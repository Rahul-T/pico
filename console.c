// Console input and output.
// Input is from the keyboard or serial port.
// Output is written to the screen and serial port.

#include "types.h"
#include "defs.h"
#include "param.h"
#include "traps.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "fs.h"
#include "file.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"
#include "console.h"

#define BLACK 0x00
#define DARK_BLUE 0x01
#define GREEN 0x02
#define TEAL 0x03
#define RED 0x04
#define PURPLE 0x05
#define ORANGE 0x06
#define GREY 0x07
#define DARK_GREY 0x08
#define BLUE 0x09
#define LIGHT_GREEN 0x0A
#define LIGHT_BLUE 0x0B
#define LIGHT_ORANGE 0x0C
#define PINK 0x0D
#define YELLOW 0x0E
#define WHITE 0x0F
#define CURSOR_COLOR 0x70
#define UI_COLOR 0xc0
#define TOTAL_CHARS WIDTH * HEIGHT
#define NUM_BLUE_KEYWORDS 14
#define NUM_RED_KEYWORDS 18


struct charandcolor {
  char character;
  int color;
};


char *bluekeywords[NUM_BLUE_KEYWORDS];
char *redkeywords[NUM_RED_KEYWORDS];

static void consputc(int);

static int panicked = 0;
static int screencaptured = 0;
// typedef void (*handler_t)(int);
// static handler_t handler;
//int* handlechar = 0;
int buffer;

static struct {
  struct spinlock lock;
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
    consputc(buf[i]);
}
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
      consputc(c);
      break;
    }
  }

  if(locking)
    release(&cons.lock);
}

void
panic(char *s)
{
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
  for(;;)
    ;
}

//PAGEBREAK: 50
#define BACKSPACE 0x100
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory
static ushort crtbackup[2000]; // array of size 25 * 80

/*
 * Set the capturescreen to the pid specified,
 * so only that pid can modify the screen.
 * Also clears the screen.
 */

int
capturescreen(int pid, void* handler_voidptr) {
  acquire(&cons.lock);
  if (screencaptured) {
    release(&cons.lock);
    return -1;
  }
  // handler = handler_voidptr;
  // *handlechar = 1;
  screencaptured = pid;
  release(&cons.lock);
  memmove(crtbackup, crt, sizeof(crt[0])*25*80);
  memset(crt, 0, sizeof(crt[0]) * 25 * 80);
  // cprintf("%p\n", handler_voidptr);
  return 0;
}

/*
 * Sets the capturescreen to 0 so that
 * other processes can draw on the screen.
 */
int
freescreen(int pid) {
  acquire(&cons.lock);
  if (screencaptured == pid) {
    screencaptured = 0;
    release(&cons.lock);
    memmove(crt, crtbackup, sizeof(crt[0])*25*80);
    return 0;
  }
  release(&cons.lock);
  return -1;
}


int
checkkeyword(char keywordstring[], int keywordlen, struct charandcolor* content, int i){
  for(int j=0; j<keywordlen; j++){
    int k = i-1;
    if(k+j >= 0){
      if(content[k+j].character != keywordstring[j] && !(keywordstring[j] == ' ' 
          && (content[k+j].character == '.' || content[k+j].character == '(' 
          || content[k+j].character == '{' || content[k+j].character == ';'))){
        return 0;
      }
    }
  }
  //cprintf("hey");
  return 1;
}

int checkallbluekeywords(struct charandcolor* content, int i){
  for(int k=0; k<NUM_BLUE_KEYWORDS; k++){
    int len = 0;
    for(int j=0; bluekeywords[k][j] != 0; j++){
      len++;
    }
    if(checkkeyword(bluekeywords[k], len, content, i) == 1){
      return len-2;
    }
  }
  return 0;
}

int checkallredkeywords(struct charandcolor* content, int i){
  for(int k=0; k<NUM_RED_KEYWORDS; k++){
    int len = 0;
    for(int j=0; redkeywords[k][j] != 0; j++){
      len++;
    }
    if(checkkeyword(redkeywords[k], len, content, i) == 1){
      return len-2;
    }
  }
  return 0;
}


int
updatescreen(int pid, int x, int y, struct charandcolor* content, int color) {
  if (pid != screencaptured) {
    return -1;
  }
  bluekeywords[0] = " auto ";
  bluekeywords[1] = " char ";
  bluekeywords[2] = " double ";
  bluekeywords[3] = " enum ";
  bluekeywords[4] = " float ";
  bluekeywords[5] = " int ";
  bluekeywords[6] = " long ";
  bluekeywords[7] = " short ";
  bluekeywords[8] = " signed ";
  bluekeywords[9] = " struct ";
  bluekeywords[10] = " typedef ";
  bluekeywords[11] = " union ";
  bluekeywords[12] = " unsigned ";
  bluekeywords[13] = " void ";

  redkeywords[0] = " break ";
  redkeywords[1] = " case ";
  redkeywords[2] = " const ";
  redkeywords[3] = " continue ";
  redkeywords[4] = " default ";
  redkeywords[5] = " do ";
  redkeywords[6] = " else ";
  redkeywords[7] = " extern ";
  redkeywords[8] = " for ";
  redkeywords[9] = " goto ";
  redkeywords[10] = " if ";
  redkeywords[11] = " register ";
  redkeywords[12] = " return ";
  redkeywords[13] = " sizeof ";
  redkeywords[14] = " static ";
  redkeywords[15] = " switch ";
  redkeywords[16] = " volatile ";
  redkeywords[17] = " while ";


  int initialpos = x + 80*y;
  char c;
  int i;
  int newcolor = color;
  int startstring = 0;
  int inword = 0;
  int startcomment = 0;

  for(i = 0; (c = content[i].character) != 0; i++) {

    if(color != CURSOR_COLOR && color != UI_COLOR){
      //Strings are orange
      if(c == '\"' && startstring == 0 && startcomment == 0){
        //Indicate start of string
        newcolor = LIGHT_ORANGE;
        startstring = 1;
      } else if(c == '\"' && startstring == 1 && startcomment == 0){
        //Indicate end of string
        newcolor = LIGHT_ORANGE;
        startstring = 0;
      } else if(c == '/' && content[i+1].character == '/'){
        //Comments are dark grey
        startcomment = 1;
        newcolor = GREY;
      } else if((c == '0' || c == '1' || c == '2' || c == '3' || c == '4' 
                || c == '5' || c == '6' || c == '7' || c == '8' || c == '9')
                && startstring == 0 && startcomment == 0){
        //Numbers are purple
        newcolor = PINK;
       } else if(startstring == 0 && inword == 0 && startcomment == 0){
          //Type keywords are blue
          inword = checkallbluekeywords(content, i);
          if(inword > 0){
            newcolor = LIGHT_BLUE;
          } else {
              //Other reserved words are red
              inword = checkallredkeywords(content, i);
              if(inword > 0){
                newcolor = LIGHT_GREEN;
              } else{
                newcolor = color;
              }
            }
       }

      content[i].color = newcolor;
      }

    if(inword > 0){
      inword--;
    }
    if((i+1) % 80 == 0 && startcomment == 1){
      startcomment = 0;
    }

    crt[initialpos + i] = (c&0xff) | (newcolor<<8);

  }
  return i;
}

const uchar ansimap[256] = 
{
  ['A'] KEY_UP,     ['B'] KEY_DN,
  ['C'] KEY_RT,     ['D'] KEY_LF,
};

static void
cgaputc(int c)
{
  int pos;

  if (screencaptured){
    return;
  }

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
  } else{
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  }

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  }
  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
  if(panicked){
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}

#define INPUT_BUF 128
struct {
  char buf[INPUT_BUF];
  uint r;  // Read index
  uint w;  // Write index
  uint e;  // Edit index
} input;


void
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;
  
  if (screencaptured != 0) {
    static uint ansi;
    while ((c = getc()) >= 0) {
      if (c == 0x1B) {
        ansi = 0x1B;
        continue;
      } else if (c == 0x5B && ansi == 0x1B) {
        ansi = 0x5B;
        continue;
      } else if (ansi == 0x5B) {
        ansi = 0;
        buffer = ansimap[c];
        return;
      } else {
        ansi = 0;
      }

      buffer = c;
      //cprintf("%d\n", c);
    }
    return;
  }

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
          wakeup(&input.r);
        }
      }
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
  uint target;
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
    consputc(buf[i] & 0xff);
  release(&cons.lock);
  ilock(ip);

  return n;
}

void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
}

int
readkey(int pid)
{
  if (pid != screencaptured)
    return -1;

  int temp = buffer;
  buffer = 0;
  return temp;
}