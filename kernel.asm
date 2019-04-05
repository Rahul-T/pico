
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 60 c5 10 80       	mov    $0x8010c560,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 c0 30 10 80       	mov    $0x801030c0,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 94 c5 10 80       	mov    $0x8010c594,%ebx
  struct buf head;
} bcache;

void
binit(void)
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010004c:	68 60 72 10 80       	push   $0x80107260
80100051:	68 60 c5 10 80       	push   $0x8010c560
80100056:	e8 b5 43 00 00       	call   80104410 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 ac 0c 11 80 5c 	movl   $0x80110c5c,0x80110cac
80100062:	0c 11 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 b0 0c 11 80 5c 	movl   $0x80110c5c,0x80110cb0
8010006c:	0c 11 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba 5c 0c 11 80       	mov    $0x80110c5c,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 5c 0c 11 80 	movl   $0x80110c5c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 67 72 10 80       	push   $0x80107267
80100097:	50                   	push   %eax
80100098:	e8 63 42 00 00       	call   80104300 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 b0 0c 11 80       	mov    0x80110cb0,%eax

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
801000b0:	89 1d b0 0c 11 80    	mov    %ebx,0x80110cb0

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d 5c 0c 11 80       	cmp    $0x80110c5c,%eax
801000bb:	75 c3                	jne    80100080 <binit+0x40>
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000df:	68 60 c5 10 80       	push   $0x8010c560
801000e4:	e8 27 44 00 00       	call   80104510 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d b0 0c 11 80    	mov    0x80110cb0,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 5c 0c 11 80    	cmp    $0x80110c5c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 5c 0c 11 80    	cmp    $0x80110c5c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d ac 0c 11 80    	mov    0x80110cac,%ebx
80100126:	81 fb 5c 0c 11 80    	cmp    $0x80110c5c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 5c 0c 11 80    	cmp    $0x80110c5c,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 60 c5 10 80       	push   $0x8010c560
80100162:	e8 c9 44 00 00       	call   80104630 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ce 41 00 00       	call   80104340 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 cd 21 00 00       	call   80102350 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 6e 72 10 80       	push   $0x8010726e
80100198:	e8 d3 01 00 00       	call   80100370 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 2d 42 00 00       	call   801043e0 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
801001c4:	e9 87 21 00 00       	jmp    80102350 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 7f 72 10 80       	push   $0x8010727f
801001d1:	e8 9a 01 00 00       	call   80100370 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 ec 41 00 00       	call   801043e0 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 9c 41 00 00       	call   801043a0 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 60 c5 10 80 	movl   $0x8010c560,(%esp)
8010020b:	e8 00 43 00 00       	call   80104510 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 b0 0c 11 80       	mov    0x80110cb0,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 5c 0c 11 80 	movl   $0x80110c5c,0x50(%ebx)
  b->refcnt--;
  if (b->refcnt == 0) {
    // no one is waiting for it.
    b->next->prev = b->prev;
    b->prev->next = b->next;
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
80100241:	a1 b0 0c 11 80       	mov    0x80110cb0,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d b0 0c 11 80    	mov    %ebx,0x80110cb0
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 60 c5 10 80 	movl   $0x8010c560,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
  
  release(&bcache.lock);
8010025c:	e9 cf 43 00 00       	jmp    80104630 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 86 72 10 80       	push   $0x80107286
80100269:	e8 02 01 00 00       	call   80100370 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 2b 17 00 00       	call   801019b0 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 c0 b4 10 80 	movl   $0x8010b4c0,(%esp)
8010028c:	e8 7f 42 00 00       	call   80104510 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e 9a 00 00 00    	jle    8010033b <consoleread+0xcb>
    while(input.r == input.w){
801002a1:	a1 40 0f 11 80       	mov    0x80110f40,%eax
801002a6:	3b 05 44 0f 11 80    	cmp    0x80110f44,%eax
801002ac:	74 24                	je     801002d2 <consoleread+0x62>
801002ae:	eb 58                	jmp    80100308 <consoleread+0x98>
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b0:	83 ec 08             	sub    $0x8,%esp
801002b3:	68 c0 b4 10 80       	push   $0x8010b4c0
801002b8:	68 40 0f 11 80       	push   $0x80110f40
801002bd:	e8 de 3c 00 00       	call   80103fa0 <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
801002c2:	a1 40 0f 11 80       	mov    0x80110f40,%eax
801002c7:	83 c4 10             	add    $0x10,%esp
801002ca:	3b 05 44 0f 11 80    	cmp    0x80110f44,%eax
801002d0:	75 36                	jne    80100308 <consoleread+0x98>
      if(myproc()->killed){
801002d2:	e8 09 37 00 00       	call   801039e0 <myproc>
801002d7:	8b 40 24             	mov    0x24(%eax),%eax
801002da:	85 c0                	test   %eax,%eax
801002dc:	74 d2                	je     801002b0 <consoleread+0x40>
        release(&cons.lock);
801002de:	83 ec 0c             	sub    $0xc,%esp
801002e1:	68 c0 b4 10 80       	push   $0x8010b4c0
801002e6:	e8 45 43 00 00       	call   80104630 <release>
        ilock(ip);
801002eb:	89 3c 24             	mov    %edi,(%esp)
801002ee:	e8 dd 15 00 00       	call   801018d0 <ilock>
        return -1;
801002f3:	83 c4 10             	add    $0x10,%esp
801002f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002fe:	5b                   	pop    %ebx
801002ff:	5e                   	pop    %esi
80100300:	5f                   	pop    %edi
80100301:	5d                   	pop    %ebp
80100302:	c3                   	ret    
80100303:	90                   	nop
80100304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100308:	8d 50 01             	lea    0x1(%eax),%edx
8010030b:	89 15 40 0f 11 80    	mov    %edx,0x80110f40
80100311:	89 c2                	mov    %eax,%edx
80100313:	83 e2 7f             	and    $0x7f,%edx
80100316:	0f be 92 c0 0e 11 80 	movsbl -0x7feef140(%edx),%edx
    if(c == C('D')){  // EOF
8010031d:	83 fa 04             	cmp    $0x4,%edx
80100320:	74 39                	je     8010035b <consoleread+0xeb>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
80100322:	83 c6 01             	add    $0x1,%esi
    --n;
80100325:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
80100328:	83 fa 0a             	cmp    $0xa,%edx
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
8010032b:	88 56 ff             	mov    %dl,-0x1(%esi)
    --n;
    if(c == '\n')
8010032e:	74 35                	je     80100365 <consoleread+0xf5>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100330:	85 db                	test   %ebx,%ebx
80100332:	0f 85 69 ff ff ff    	jne    801002a1 <consoleread+0x31>
80100338:	8b 45 10             	mov    0x10(%ebp),%eax
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
8010033b:	83 ec 0c             	sub    $0xc,%esp
8010033e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100341:	68 c0 b4 10 80       	push   $0x8010b4c0
80100346:	e8 e5 42 00 00       	call   80104630 <release>
  ilock(ip);
8010034b:	89 3c 24             	mov    %edi,(%esp)
8010034e:	e8 7d 15 00 00       	call   801018d0 <ilock>

  return target - n;
80100353:	83 c4 10             	add    $0x10,%esp
80100356:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100359:	eb a0                	jmp    801002fb <consoleread+0x8b>
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
8010035b:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010035e:	76 05                	jbe    80100365 <consoleread+0xf5>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100360:	a3 40 0f 11 80       	mov    %eax,0x80110f40
80100365:	8b 45 10             	mov    0x10(%ebp),%eax
80100368:	29 d8                	sub    %ebx,%eax
8010036a:	eb cf                	jmp    8010033b <consoleread+0xcb>
8010036c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100370 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
80100370:	55                   	push   %ebp
80100371:	89 e5                	mov    %esp,%ebp
80100373:	56                   	push   %esi
80100374:	53                   	push   %ebx
80100375:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100378:	fa                   	cli    
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
80100379:	c7 05 f4 b4 10 80 00 	movl   $0x0,0x8010b4f4
80100380:	00 00 00 
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
80100383:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100386:	8d 75 f8             	lea    -0x8(%ebp),%esi
  uint pcs[10];

  cli();
  cons.locking = 0;
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
80100389:	e8 c2 25 00 00       	call   80102950 <lapicid>
8010038e:	83 ec 08             	sub    $0x8,%esp
80100391:	50                   	push   %eax
80100392:	68 8d 72 10 80       	push   $0x8010728d
80100397:	e8 e4 02 00 00       	call   80100680 <cprintf>
  cprintf(s);
8010039c:	58                   	pop    %eax
8010039d:	ff 75 08             	pushl  0x8(%ebp)
801003a0:	e8 db 02 00 00       	call   80100680 <cprintf>
  cprintf("\n");
801003a5:	c7 04 24 e7 7b 10 80 	movl   $0x80107be7,(%esp)
801003ac:	e8 cf 02 00 00       	call   80100680 <cprintf>
  getcallerpcs(&s, pcs);
801003b1:	5a                   	pop    %edx
801003b2:	8d 45 08             	lea    0x8(%ebp),%eax
801003b5:	59                   	pop    %ecx
801003b6:	53                   	push   %ebx
801003b7:	50                   	push   %eax
801003b8:	e8 73 40 00 00       	call   80104430 <getcallerpcs>
801003bd:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003c0:	83 ec 08             	sub    $0x8,%esp
801003c3:	ff 33                	pushl  (%ebx)
801003c5:	83 c3 04             	add    $0x4,%ebx
801003c8:	68 a1 72 10 80       	push   $0x801072a1
801003cd:	e8 ae 02 00 00       	call   80100680 <cprintf>
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801003d2:	83 c4 10             	add    $0x10,%esp
801003d5:	39 f3                	cmp    %esi,%ebx
801003d7:	75 e7                	jne    801003c0 <panic+0x50>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801003d9:	c7 05 fc b4 10 80 01 	movl   $0x1,0x8010b4fc
801003e0:	00 00 00 
801003e3:	eb fe                	jmp    801003e3 <panic+0x73>
801003e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801003e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801003f0 <consputc>:
}

void
consputc(int c)
{
  if(panicked){
801003f0:	8b 0d fc b4 10 80    	mov    0x8010b4fc,%ecx
801003f6:	85 c9                	test   %ecx,%ecx
801003f8:	74 06                	je     80100400 <consputc+0x10>
801003fa:	fa                   	cli    
801003fb:	eb fe                	jmp    801003fb <consputc+0xb>
801003fd:	8d 76 00             	lea    0x0(%esi),%esi
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c3                	mov    %eax,%ebx
80100408:	83 ec 0c             	sub    $0xc,%esp
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 ca 00 00 00    	je     801004e0 <consputc+0xf0>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 01 5a 00 00       	call   80105e20 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
static void
cgaputc(int c)
{
  int pos;

  if (screencaptured){
80100422:	8b 15 f8 b4 10 80    	mov    0x8010b4f8,%edx
80100428:	85 d2                	test   %edx,%edx
8010042a:	0f 85 a8 00 00 00    	jne    801004d8 <consputc+0xe8>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100430:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100435:	b8 0e 00 00 00       	mov    $0xe,%eax
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010043d:	be d5 03 00 00       	mov    $0x3d5,%esi
80100442:	89 f2                	mov    %esi,%edx
80100444:	ec                   	in     (%dx),%al
    return;
  }

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
80100445:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100448:	89 fa                	mov    %edi,%edx
8010044a:	c1 e0 08             	shl    $0x8,%eax
8010044d:	89 c1                	mov    %eax,%ecx
8010044f:	b8 0f 00 00 00       	mov    $0xf,%eax
80100454:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100455:	89 f2                	mov    %esi,%edx
80100457:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
80100458:	0f b6 c0             	movzbl %al,%eax
8010045b:	09 c8                	or     %ecx,%eax

  if(c == '\n')
8010045d:	83 fb 0a             	cmp    $0xa,%ebx
80100460:	0f 84 ba 00 00 00    	je     80100520 <consputc+0x130>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
80100466:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010046c:	0f 84 98 00 00 00    	je     8010050a <consputc+0x11a>
    if(pos > 0) --pos;
  } else{
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100472:	0f b6 d3             	movzbl %bl,%edx
80100475:	8d 78 01             	lea    0x1(%eax),%edi
80100478:	80 ce 07             	or     $0x7,%dh
8010047b:	66 89 94 00 00 80 0b 	mov    %dx,-0x7ff48000(%eax,%eax,1)
80100482:	80 
  }

  if(pos < 0 || pos > 25*80)
80100483:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
80100489:	0f 8f b2 00 00 00    	jg     80100541 <consputc+0x151>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
8010048f:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
80100495:	0f 8f b3 00 00 00    	jg     8010054e <consputc+0x15e>
8010049b:	89 f8                	mov    %edi,%eax
8010049d:	8d 8c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ecx
801004a4:	89 fb                	mov    %edi,%ebx
801004a6:	c1 e8 08             	shr    $0x8,%eax
801004a9:	89 c6                	mov    %eax,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004ab:	bf d4 03 00 00       	mov    $0x3d4,%edi
801004b0:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b5:	89 fa                	mov    %edi,%edx
801004b7:	ee                   	out    %al,(%dx)
801004b8:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004bd:	89 f0                	mov    %esi,%eax
801004bf:	ee                   	out    %al,(%dx)
801004c0:	b8 0f 00 00 00       	mov    $0xf,%eax
801004c5:	89 fa                	mov    %edi,%edx
801004c7:	ee                   	out    %al,(%dx)
801004c8:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004cd:	89 d8                	mov    %ebx,%eax
801004cf:	ee                   	out    %al,(%dx)
  }
  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
801004d0:	b8 20 07 00 00       	mov    $0x720,%eax
801004d5:	66 89 01             	mov    %ax,(%ecx)
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
801004d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004db:	5b                   	pop    %ebx
801004dc:	5e                   	pop    %esi
801004dd:	5f                   	pop    %edi
801004de:	5d                   	pop    %ebp
801004df:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e0:	83 ec 0c             	sub    $0xc,%esp
801004e3:	6a 08                	push   $0x8
801004e5:	e8 36 59 00 00       	call   80105e20 <uartputc>
801004ea:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f1:	e8 2a 59 00 00       	call   80105e20 <uartputc>
801004f6:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004fd:	e8 1e 59 00 00       	call   80105e20 <uartputc>
80100502:	83 c4 10             	add    $0x10,%esp
80100505:	e9 18 ff ff ff       	jmp    80100422 <consputc+0x32>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
8010050a:	85 c0                	test   %eax,%eax
8010050c:	8d 78 ff             	lea    -0x1(%eax),%edi
8010050f:	0f 85 6e ff ff ff    	jne    80100483 <consputc+0x93>
80100515:	b9 00 80 0b 80       	mov    $0x800b8000,%ecx
8010051a:	31 db                	xor    %ebx,%ebx
8010051c:	31 f6                	xor    %esi,%esi
8010051e:	eb 8b                	jmp    801004ab <consputc+0xbb>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
80100520:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100525:	f7 ea                	imul   %edx
80100527:	89 d0                	mov    %edx,%eax
80100529:	c1 e8 05             	shr    $0x5,%eax
8010052c:	8d 04 80             	lea    (%eax,%eax,4),%eax
8010052f:	c1 e0 04             	shl    $0x4,%eax
80100532:	8d 78 50             	lea    0x50(%eax),%edi
    if(pos > 0) --pos;
  } else{
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  }

  if(pos < 0 || pos > 25*80)
80100535:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
8010053b:	0f 8e 4e ff ff ff    	jle    8010048f <consputc+0x9f>
    panic("pos under/overflow");
80100541:	83 ec 0c             	sub    $0xc,%esp
80100544:	68 a5 72 10 80       	push   $0x801072a5
80100549:	e8 22 fe ff ff       	call   80100370 <panic>

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010054e:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100551:	8d 5f b0             	lea    -0x50(%edi),%ebx

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100554:	68 60 0e 00 00       	push   $0xe60
80100559:	68 a0 80 0b 80       	push   $0x800b80a0
8010055e:	68 00 80 0b 80       	push   $0x800b8000
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100563:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010056a:	e8 c1 41 00 00       	call   80104730 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010056f:	b8 80 07 00 00       	mov    $0x780,%eax
80100574:	83 c4 0c             	add    $0xc,%esp
80100577:	29 d8                	sub    %ebx,%eax
80100579:	01 c0                	add    %eax,%eax
8010057b:	50                   	push   %eax
8010057c:	6a 00                	push   $0x0
8010057e:	56                   	push   %esi
8010057f:	e8 fc 40 00 00       	call   80104680 <memset>
80100584:	89 f1                	mov    %esi,%ecx
80100586:	83 c4 10             	add    $0x10,%esp
80100589:	be 07 00 00 00       	mov    $0x7,%esi
8010058e:	e9 18 ff ff ff       	jmp    801004ab <consputc+0xbb>
80100593:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801005a0 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
801005a0:	55                   	push   %ebp
801005a1:	89 e5                	mov    %esp,%ebp
801005a3:	57                   	push   %edi
801005a4:	56                   	push   %esi
801005a5:	53                   	push   %ebx
801005a6:	89 d6                	mov    %edx,%esi
801005a8:	83 ec 2c             	sub    $0x2c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
801005ab:	85 c9                	test   %ecx,%ecx
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
801005ad:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
801005b0:	74 0c                	je     801005be <printint+0x1e>
801005b2:	89 c7                	mov    %eax,%edi
801005b4:	c1 ef 1f             	shr    $0x1f,%edi
801005b7:	85 c0                	test   %eax,%eax
801005b9:	89 7d d4             	mov    %edi,-0x2c(%ebp)
801005bc:	78 51                	js     8010060f <printint+0x6f>
    x = -xx;
  else
    x = xx;

  i = 0;
801005be:	31 ff                	xor    %edi,%edi
801005c0:	8d 5d d7             	lea    -0x29(%ebp),%ebx
801005c3:	eb 05                	jmp    801005ca <printint+0x2a>
801005c5:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
801005c8:	89 cf                	mov    %ecx,%edi
801005ca:	31 d2                	xor    %edx,%edx
801005cc:	8d 4f 01             	lea    0x1(%edi),%ecx
801005cf:	f7 f6                	div    %esi
801005d1:	0f b6 92 d0 72 10 80 	movzbl -0x7fef8d30(%edx),%edx
  }while((x /= base) != 0);
801005d8:	85 c0                	test   %eax,%eax
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
801005da:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
801005dd:	75 e9                	jne    801005c8 <printint+0x28>

  if(sign)
801005df:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005e2:	85 c0                	test   %eax,%eax
801005e4:	74 08                	je     801005ee <printint+0x4e>
    buf[i++] = '-';
801005e6:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
801005eb:	8d 4f 02             	lea    0x2(%edi),%ecx
801005ee:	8d 74 0d d7          	lea    -0x29(%ebp,%ecx,1),%esi
801005f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  while(--i >= 0)
    consputc(buf[i]);
801005f8:	0f be 06             	movsbl (%esi),%eax
801005fb:	83 ee 01             	sub    $0x1,%esi
801005fe:	e8 ed fd ff ff       	call   801003f0 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
80100603:	39 de                	cmp    %ebx,%esi
80100605:	75 f1                	jne    801005f8 <printint+0x58>
    consputc(buf[i]);
}
80100607:	83 c4 2c             	add    $0x2c,%esp
8010060a:	5b                   	pop    %ebx
8010060b:	5e                   	pop    %esi
8010060c:	5f                   	pop    %edi
8010060d:	5d                   	pop    %ebp
8010060e:	c3                   	ret    
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
8010060f:	f7 d8                	neg    %eax
80100611:	eb ab                	jmp    801005be <printint+0x1e>
80100613:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100620 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100620:	55                   	push   %ebp
80100621:	89 e5                	mov    %esp,%ebp
80100623:	57                   	push   %edi
80100624:	56                   	push   %esi
80100625:	53                   	push   %ebx
80100626:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100629:	ff 75 08             	pushl  0x8(%ebp)
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
8010062c:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010062f:	e8 7c 13 00 00       	call   801019b0 <iunlock>
  acquire(&cons.lock);
80100634:	c7 04 24 c0 b4 10 80 	movl   $0x8010b4c0,(%esp)
8010063b:	e8 d0 3e 00 00       	call   80104510 <acquire>
80100640:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100643:	83 c4 10             	add    $0x10,%esp
80100646:	85 f6                	test   %esi,%esi
80100648:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010064b:	7e 12                	jle    8010065f <consolewrite+0x3f>
8010064d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100650:	0f b6 07             	movzbl (%edi),%eax
80100653:	83 c7 01             	add    $0x1,%edi
80100656:	e8 95 fd ff ff       	call   801003f0 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
8010065b:	39 df                	cmp    %ebx,%edi
8010065d:	75 f1                	jne    80100650 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
8010065f:	83 ec 0c             	sub    $0xc,%esp
80100662:	68 c0 b4 10 80       	push   $0x8010b4c0
80100667:	e8 c4 3f 00 00       	call   80104630 <release>
  ilock(ip);
8010066c:	58                   	pop    %eax
8010066d:	ff 75 08             	pushl  0x8(%ebp)
80100670:	e8 5b 12 00 00       	call   801018d0 <ilock>

  return n;
}
80100675:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100678:	89 f0                	mov    %esi,%eax
8010067a:	5b                   	pop    %ebx
8010067b:	5e                   	pop    %esi
8010067c:	5f                   	pop    %edi
8010067d:	5d                   	pop    %ebp
8010067e:	c3                   	ret    
8010067f:	90                   	nop

80100680 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100680:	55                   	push   %ebp
80100681:	89 e5                	mov    %esp,%ebp
80100683:	57                   	push   %edi
80100684:	56                   	push   %esi
80100685:	53                   	push   %ebx
80100686:	83 ec 1c             	sub    $0x1c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100689:	a1 f4 b4 10 80       	mov    0x8010b4f4,%eax
  if(locking)
8010068e:	85 c0                	test   %eax,%eax
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100690:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100693:	0f 85 47 01 00 00    	jne    801007e0 <cprintf+0x160>
    acquire(&cons.lock);

  if (fmt == 0)
80100699:	8b 45 08             	mov    0x8(%ebp),%eax
8010069c:	85 c0                	test   %eax,%eax
8010069e:	89 c1                	mov    %eax,%ecx
801006a0:	0f 84 4f 01 00 00    	je     801007f5 <cprintf+0x175>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006a6:	0f b6 00             	movzbl (%eax),%eax
801006a9:	31 db                	xor    %ebx,%ebx
801006ab:	8d 75 0c             	lea    0xc(%ebp),%esi
801006ae:	89 cf                	mov    %ecx,%edi
801006b0:	85 c0                	test   %eax,%eax
801006b2:	75 55                	jne    80100709 <cprintf+0x89>
801006b4:	eb 68                	jmp    8010071e <cprintf+0x9e>
801006b6:	8d 76 00             	lea    0x0(%esi),%esi
801006b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
801006c0:	83 c3 01             	add    $0x1,%ebx
801006c3:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
    if(c == 0)
801006c7:	85 d2                	test   %edx,%edx
801006c9:	74 53                	je     8010071e <cprintf+0x9e>
      break;
    switch(c){
801006cb:	83 fa 70             	cmp    $0x70,%edx
801006ce:	74 7a                	je     8010074a <cprintf+0xca>
801006d0:	7f 6e                	jg     80100740 <cprintf+0xc0>
801006d2:	83 fa 25             	cmp    $0x25,%edx
801006d5:	0f 84 ad 00 00 00    	je     80100788 <cprintf+0x108>
801006db:	83 fa 64             	cmp    $0x64,%edx
801006de:	0f 85 84 00 00 00    	jne    80100768 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
801006e4:	8d 46 04             	lea    0x4(%esi),%eax
801006e7:	b9 01 00 00 00       	mov    $0x1,%ecx
801006ec:	ba 0a 00 00 00       	mov    $0xa,%edx
801006f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006f4:	8b 06                	mov    (%esi),%eax
801006f6:	e8 a5 fe ff ff       	call   801005a0 <printint>
801006fb:	8b 75 e4             	mov    -0x1c(%ebp),%esi

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fe:	83 c3 01             	add    $0x1,%ebx
80100701:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
80100705:	85 c0                	test   %eax,%eax
80100707:	74 15                	je     8010071e <cprintf+0x9e>
    if(c != '%'){
80100709:	83 f8 25             	cmp    $0x25,%eax
8010070c:	74 b2                	je     801006c0 <cprintf+0x40>
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
8010070e:	e8 dd fc ff ff       	call   801003f0 <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100713:	83 c3 01             	add    $0x1,%ebx
80100716:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
8010071a:	85 c0                	test   %eax,%eax
8010071c:	75 eb                	jne    80100709 <cprintf+0x89>
      consputc(c);
      break;
    }
  }

  if(locking)
8010071e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100721:	85 c0                	test   %eax,%eax
80100723:	74 10                	je     80100735 <cprintf+0xb5>
    release(&cons.lock);
80100725:	83 ec 0c             	sub    $0xc,%esp
80100728:	68 c0 b4 10 80       	push   $0x8010b4c0
8010072d:	e8 fe 3e 00 00       	call   80104630 <release>
80100732:	83 c4 10             	add    $0x10,%esp
}
80100735:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100738:	5b                   	pop    %ebx
80100739:	5e                   	pop    %esi
8010073a:	5f                   	pop    %edi
8010073b:	5d                   	pop    %ebp
8010073c:	c3                   	ret    
8010073d:	8d 76 00             	lea    0x0(%esi),%esi
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
80100740:	83 fa 73             	cmp    $0x73,%edx
80100743:	74 5b                	je     801007a0 <cprintf+0x120>
80100745:	83 fa 78             	cmp    $0x78,%edx
80100748:	75 1e                	jne    80100768 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
8010074a:	8d 46 04             	lea    0x4(%esi),%eax
8010074d:	31 c9                	xor    %ecx,%ecx
8010074f:	ba 10 00 00 00       	mov    $0x10,%edx
80100754:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100757:	8b 06                	mov    (%esi),%eax
80100759:	e8 42 fe ff ff       	call   801005a0 <printint>
8010075e:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      break;
80100761:	eb 9b                	jmp    801006fe <cprintf+0x7e>
80100763:	90                   	nop
80100764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100768:	b8 25 00 00 00       	mov    $0x25,%eax
8010076d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100770:	e8 7b fc ff ff       	call   801003f0 <consputc>
      consputc(c);
80100775:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100778:	89 d0                	mov    %edx,%eax
8010077a:	e8 71 fc ff ff       	call   801003f0 <consputc>
      break;
8010077f:	e9 7a ff ff ff       	jmp    801006fe <cprintf+0x7e>
80100784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
80100788:	b8 25 00 00 00       	mov    $0x25,%eax
8010078d:	e8 5e fc ff ff       	call   801003f0 <consputc>
80100792:	e9 7c ff ff ff       	jmp    80100713 <cprintf+0x93>
80100797:	89 f6                	mov    %esi,%esi
80100799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
801007a0:	8d 46 04             	lea    0x4(%esi),%eax
801007a3:	8b 36                	mov    (%esi),%esi
801007a5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        s = "(null)";
801007a8:	b8 b8 72 10 80       	mov    $0x801072b8,%eax
801007ad:	85 f6                	test   %esi,%esi
801007af:	0f 44 f0             	cmove  %eax,%esi
      for(; *s; s++)
801007b2:	0f be 06             	movsbl (%esi),%eax
801007b5:	84 c0                	test   %al,%al
801007b7:	74 16                	je     801007cf <cprintf+0x14f>
801007b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007c0:	83 c6 01             	add    $0x1,%esi
        consputc(*s);
801007c3:	e8 28 fc ff ff       	call   801003f0 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801007c8:	0f be 06             	movsbl (%esi),%eax
801007cb:	84 c0                	test   %al,%al
801007cd:	75 f1                	jne    801007c0 <cprintf+0x140>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
801007cf:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801007d2:	e9 27 ff ff ff       	jmp    801006fe <cprintf+0x7e>
801007d7:	89 f6                	mov    %esi,%esi
801007d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
801007e0:	83 ec 0c             	sub    $0xc,%esp
801007e3:	68 c0 b4 10 80       	push   $0x8010b4c0
801007e8:	e8 23 3d 00 00       	call   80104510 <acquire>
801007ed:	83 c4 10             	add    $0x10,%esp
801007f0:	e9 a4 fe ff ff       	jmp    80100699 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
801007f5:	83 ec 0c             	sub    $0xc,%esp
801007f8:	68 bf 72 10 80       	push   $0x801072bf
801007fd:	e8 6e fb ff ff       	call   80100370 <panic>
80100802:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100810 <vga_move_forward_cursor>:
 * Set the capturescreen to the pid specified,
 * so only that pid can modify the screen.
 * Also clears the screen.
 */

void vga_move_forward_cursor(){
80100810:	55                   	push   %ebp
80100811:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100816:	b8 0e 00 00 00       	mov    $0xe,%eax
8010081b:	89 e5                	mov    %esp,%ebp
8010081d:	53                   	push   %ebx
8010081e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010081f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100824:	89 ca                	mov    %ecx,%edx
80100826:	ec                   	in     (%dx),%al
  int pos;
  
  // get cursor position
  outb(CRTPORT, 14);                  
  pos = inb(CRTPORT+1) << 8;
80100827:	0f b6 d8             	movzbl %al,%ebx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010082a:	ba d4 03 00 00       	mov    $0x3d4,%edx
8010082f:	b8 0f 00 00 00       	mov    $0xf,%eax
80100834:	c1 e3 08             	shl    $0x8,%ebx
80100837:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100838:	89 ca                	mov    %ecx,%edx
8010083a:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);    
8010083b:	0f b6 c8             	movzbl %al,%ecx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010083e:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100843:	b8 0f 00 00 00       	mov    $0xf,%eax
80100848:	09 d9                	or     %ebx,%ecx

  // move back
  pos++;
8010084a:	83 c1 01             	add    $0x1,%ecx
8010084d:	ee                   	out    %al,(%dx)
8010084e:	ba d5 03 00 00       	mov    $0x3d5,%edx
80100853:	89 c8                	mov    %ecx,%eax
80100855:	ee                   	out    %al,(%dx)
80100856:	ba d4 03 00 00       	mov    $0x3d4,%edx
8010085b:	b8 0e 00 00 00       	mov    $0xe,%eax
80100860:	ee                   	out    %al,(%dx)
80100861:	89 c8                	mov    %ecx,%eax
80100863:	ba d5 03 00 00       	mov    $0x3d5,%edx
80100868:	c1 f8 08             	sar    $0x8,%eax
8010086b:	ee                   	out    %al,(%dx)
  outb(CRTPORT, 15);
  outb(CRTPORT+1, (unsigned char)(pos&0xFF));
  outb(CRTPORT, 14);
  outb(CRTPORT+1, (unsigned char )((pos>>8)&0xFF));
  //crt[pos] = ' ' | 0x0700;
}
8010086c:	5b                   	pop    %ebx
8010086d:	5d                   	pop    %ebp
8010086e:	c3                   	ret    
8010086f:	90                   	nop

80100870 <capturescreen>:

int
capturescreen(int pid, void* handler_voidptr) {
80100870:	55                   	push   %ebp
80100871:	89 e5                	mov    %esp,%ebp
80100873:	53                   	push   %ebx
80100874:	83 ec 10             	sub    $0x10,%esp
  acquire(&cons.lock);
80100877:	68 c0 b4 10 80       	push   $0x8010b4c0
8010087c:	e8 8f 3c 00 00       	call   80104510 <acquire>
  if (screencaptured) {
80100881:	8b 1d f8 b4 10 80    	mov    0x8010b4f8,%ebx
80100887:	83 c4 10             	add    $0x10,%esp
8010088a:	85 db                	test   %ebx,%ebx
8010088c:	75 52                	jne    801008e0 <capturescreen+0x70>
    release(&cons.lock);
    return -1;
  }
  // handler = handler_voidptr;
  // *handlechar = 1;
  screencaptured = pid;
8010088e:	8b 45 08             	mov    0x8(%ebp),%eax
  release(&cons.lock);
80100891:	83 ec 0c             	sub    $0xc,%esp
80100894:	68 c0 b4 10 80       	push   $0x8010b4c0
    release(&cons.lock);
    return -1;
  }
  // handler = handler_voidptr;
  // *handlechar = 1;
  screencaptured = pid;
80100899:	a3 f8 b4 10 80       	mov    %eax,0x8010b4f8
  release(&cons.lock);
8010089e:	e8 8d 3d 00 00       	call   80104630 <release>
  memmove(crtbackup, crt, sizeof(crt[0])*25*80);
801008a3:	83 c4 0c             	add    $0xc,%esp
801008a6:	68 a0 0f 00 00       	push   $0xfa0
801008ab:	68 00 80 0b 80       	push   $0x800b8000
801008b0:	68 20 a5 10 80       	push   $0x8010a520
801008b5:	e8 76 3e 00 00       	call   80104730 <memmove>
  memset(crt, 0, sizeof(crt[0]) * 25 * 80);
801008ba:	83 c4 0c             	add    $0xc,%esp
801008bd:	68 a0 0f 00 00       	push   $0xfa0
801008c2:	6a 00                	push   $0x0
801008c4:	68 00 80 0b 80       	push   $0x800b8000
801008c9:	e8 b2 3d 00 00       	call   80104680 <memset>
  // cprintf("%p\n", handler_voidptr);
  return 0;
801008ce:	83 c4 10             	add    $0x10,%esp
}
801008d1:	89 d8                	mov    %ebx,%eax
801008d3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801008d6:	c9                   	leave  
801008d7:	c3                   	ret    
801008d8:	90                   	nop
801008d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

int
capturescreen(int pid, void* handler_voidptr) {
  acquire(&cons.lock);
  if (screencaptured) {
    release(&cons.lock);
801008e0:	83 ec 0c             	sub    $0xc,%esp
    return -1;
801008e3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx

int
capturescreen(int pid, void* handler_voidptr) {
  acquire(&cons.lock);
  if (screencaptured) {
    release(&cons.lock);
801008e8:	68 c0 b4 10 80       	push   $0x8010b4c0
801008ed:	e8 3e 3d 00 00       	call   80104630 <release>
    return -1;
801008f2:	83 c4 10             	add    $0x10,%esp
801008f5:	eb da                	jmp    801008d1 <capturescreen+0x61>
801008f7:	89 f6                	mov    %esi,%esi
801008f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100900 <freescreen>:
/*
 * Sets the capturescreen to 0 so that
 * other processes can draw on the screen.
 */
int
freescreen(int pid) {
80100900:	55                   	push   %ebp
80100901:	89 e5                	mov    %esp,%ebp
80100903:	83 ec 14             	sub    $0x14,%esp
  acquire(&cons.lock);
80100906:	68 c0 b4 10 80       	push   $0x8010b4c0
8010090b:	e8 00 3c 00 00       	call   80104510 <acquire>
  if (screencaptured == pid) {
80100910:	83 c4 10             	add    $0x10,%esp
80100913:	8b 45 08             	mov    0x8(%ebp),%eax
80100916:	39 05 f8 b4 10 80    	cmp    %eax,0x8010b4f8
8010091c:	75 3a                	jne    80100958 <freescreen+0x58>
    screencaptured = 0;
    release(&cons.lock);
8010091e:	83 ec 0c             	sub    $0xc,%esp
 */
int
freescreen(int pid) {
  acquire(&cons.lock);
  if (screencaptured == pid) {
    screencaptured = 0;
80100921:	c7 05 f8 b4 10 80 00 	movl   $0x0,0x8010b4f8
80100928:	00 00 00 
    release(&cons.lock);
8010092b:	68 c0 b4 10 80       	push   $0x8010b4c0
80100930:	e8 fb 3c 00 00       	call   80104630 <release>
    memmove(crt, crtbackup, sizeof(crt[0])*25*80);
80100935:	83 c4 0c             	add    $0xc,%esp
80100938:	68 a0 0f 00 00       	push   $0xfa0
8010093d:	68 20 a5 10 80       	push   $0x8010a520
80100942:	68 00 80 0b 80       	push   $0x800b8000
80100947:	e8 e4 3d 00 00       	call   80104730 <memmove>
    return 0;
8010094c:	83 c4 10             	add    $0x10,%esp
8010094f:	31 c0                	xor    %eax,%eax
  }
  release(&cons.lock);
  return -1;
}
80100951:	c9                   	leave  
80100952:	c3                   	ret    
80100953:	90                   	nop
80100954:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    screencaptured = 0;
    release(&cons.lock);
    memmove(crt, crtbackup, sizeof(crt[0])*25*80);
    return 0;
  }
  release(&cons.lock);
80100958:	83 ec 0c             	sub    $0xc,%esp
8010095b:	68 c0 b4 10 80       	push   $0x8010b4c0
80100960:	e8 cb 3c 00 00       	call   80104630 <release>
  return -1;
80100965:	83 c4 10             	add    $0x10,%esp
80100968:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010096d:	c9                   	leave  
8010096e:	c3                   	ret    
8010096f:	90                   	nop

80100970 <updatescreen>:
int
updatescreen(int pid, int x, int y, char* content, int color) {
80100970:	55                   	push   %ebp
80100971:	89 e5                	mov    %esp,%ebp
80100973:	57                   	push   %edi
80100974:	56                   	push   %esi
80100975:	53                   	push   %ebx
80100976:	83 ec 04             	sub    $0x4,%esp
  if (pid != screencaptured) {
80100979:	8b 7d 08             	mov    0x8(%ebp),%edi
8010097c:	39 3d f8 b4 10 80    	cmp    %edi,0x8010b4f8
  }
  release(&cons.lock);
  return -1;
}
int
updatescreen(int pid, int x, int y, char* content, int color) {
80100982:	8b 45 10             	mov    0x10(%ebp),%eax
80100985:	8b 75 14             	mov    0x14(%ebp),%esi
  if (pid != screencaptured) {
80100988:	75 56                	jne    801009e0 <updatescreen+0x70>
    return -1;
  }
  int initialpos = x + 80*y;
  char c;
  int i;
  for(i = 0; (c = content[i]) != 0; i++) {
8010098a:	0f b6 0e             	movzbl (%esi),%ecx
int
updatescreen(int pid, int x, int y, char* content, int color) {
  if (pid != screencaptured) {
    return -1;
  }
  int initialpos = x + 80*y;
8010098d:	8d 1c 80             	lea    (%eax,%eax,4),%ebx
80100990:	c1 e3 04             	shl    $0x4,%ebx
80100993:	03 5d 0c             	add    0xc(%ebp),%ebx
  char c;
  int i;
  for(i = 0; (c = content[i]) != 0; i++) {
80100996:	84 c9                	test   %cl,%cl
80100998:	74 4d                	je     801009e7 <updatescreen+0x77>
8010099a:	0f b7 45 18          	movzwl 0x18(%ebp),%eax
8010099e:	bf 20 00 00 00       	mov    $0x20,%edi
801009a3:	c1 e0 08             	shl    $0x8,%eax
801009a6:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
801009aa:	31 c0                	xor    %eax,%eax
801009ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801009b0:	80 f9 0a             	cmp    $0xa,%cl
801009b3:	0f b6 d1             	movzbl %cl,%edx
    //Don't print out newline character, print out a space instead
    if(c == '\n'){
      c = ' ';
    }
    
    crt[initialpos + i] = (c&0xff) | (color<<8);
801009b6:	8d 0c 03             	lea    (%ebx,%eax,1),%ecx
801009b9:	0f 44 d7             	cmove  %edi,%edx
801009bc:	66 0b 55 f2          	or     -0xe(%ebp),%dx
    return -1;
  }
  int initialpos = x + 80*y;
  char c;
  int i;
  for(i = 0; (c = content[i]) != 0; i++) {
801009c0:	83 c0 01             	add    $0x1,%eax
    //Don't print out newline character, print out a space instead
    if(c == '\n'){
      c = ' ';
    }
    
    crt[initialpos + i] = (c&0xff) | (color<<8);
801009c3:	66 89 94 09 00 80 0b 	mov    %dx,-0x7ff48000(%ecx,%ecx,1)
801009ca:	80 
    return -1;
  }
  int initialpos = x + 80*y;
  char c;
  int i;
  for(i = 0; (c = content[i]) != 0; i++) {
801009cb:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
801009cf:	84 c9                	test   %cl,%cl
801009d1:	75 dd                	jne    801009b0 <updatescreen+0x40>
    }
    
    crt[initialpos + i] = (c&0xff) | (color<<8);
  }
  return i;
}
801009d3:	83 c4 04             	add    $0x4,%esp
801009d6:	5b                   	pop    %ebx
801009d7:	5e                   	pop    %esi
801009d8:	5f                   	pop    %edi
801009d9:	5d                   	pop    %ebp
801009da:	c3                   	ret    
801009db:	90                   	nop
801009dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return -1;
}
int
updatescreen(int pid, int x, int y, char* content, int color) {
  if (pid != screencaptured) {
    return -1;
801009e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801009e5:	eb ec                	jmp    801009d3 <updatescreen+0x63>
  }
  int initialpos = x + 80*y;
  char c;
  int i;
  for(i = 0; (c = content[i]) != 0; i++) {
801009e7:	31 c0                	xor    %eax,%eax
801009e9:	eb e8                	jmp    801009d3 <updatescreen+0x63>
801009eb:	90                   	nop
801009ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009f0 <consoleintr>:
// C('A') == Control-A
#define C(x) (x - '@')

void
consoleintr(int (*getc)(void))
{
801009f0:	55                   	push   %ebp
801009f1:	89 e5                	mov    %esp,%ebp
801009f3:	57                   	push   %edi
801009f4:	56                   	push   %esi
801009f5:	53                   	push   %ebx
801009f6:	83 ec 0c             	sub    $0xc,%esp
  int c, doprocdump = 0;
  

  if (screencaptured != 0) {
801009f9:	a1 f8 b4 10 80       	mov    0x8010b4f8,%eax
// C('A') == Control-A
#define C(x) (x - '@')

void
consoleintr(int (*getc)(void))
{
801009fe:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c, doprocdump = 0;
  

  if (screencaptured != 0) {
80100a01:	85 c0                	test   %eax,%eax
80100a03:	75 21                	jne    80100a26 <consoleintr+0x36>
80100a05:	eb 31                	jmp    80100a38 <consoleintr+0x48>
80100a07:	89 f6                	mov    %esi,%esi
80100a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    while((c = getc()) >= 0) {
      buffer = c;
      cprintf("%d\n", c);
80100a10:	83 ec 08             	sub    $0x8,%esp
  int c, doprocdump = 0;
  

  if (screencaptured != 0) {
    while((c = getc()) >= 0) {
      buffer = c;
80100a13:	a3 4c 0f 11 80       	mov    %eax,0x80110f4c
      cprintf("%d\n", c);
80100a18:	50                   	push   %eax
80100a19:	68 54 77 10 80       	push   $0x80107754
80100a1e:	e8 5d fc ff ff       	call   80100680 <cprintf>
80100a23:	83 c4 10             	add    $0x10,%esp
{
  int c, doprocdump = 0;
  

  if (screencaptured != 0) {
    while((c = getc()) >= 0) {
80100a26:	ff d3                	call   *%ebx
80100a28:	85 c0                	test   %eax,%eax
80100a2a:	79 e4                	jns    80100a10 <consoleintr+0x20>
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100a2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a2f:	5b                   	pop    %ebx
80100a30:	5e                   	pop    %esi
80100a31:	5f                   	pop    %edi
80100a32:	5d                   	pop    %ebp
80100a33:	c3                   	ret    
80100a34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      cprintf("%d\n", c);
    }
    return;
  }

  acquire(&cons.lock);
80100a38:	83 ec 0c             	sub    $0xc,%esp
#define C(x) (x - '@')

void
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;
80100a3b:	31 f6                	xor    %esi,%esi
      cprintf("%d\n", c);
    }
    return;
  }

  acquire(&cons.lock);
80100a3d:	68 c0 b4 10 80       	push   $0x8010b4c0
80100a42:	e8 c9 3a 00 00       	call   80104510 <acquire>
  while((c = getc()) >= 0){
80100a47:	83 c4 10             	add    $0x10,%esp
80100a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100a50:	ff d3                	call   *%ebx
80100a52:	85 c0                	test   %eax,%eax
80100a54:	89 c7                	mov    %eax,%edi
80100a56:	78 48                	js     80100aa0 <consoleintr+0xb0>
    switch(c){
80100a58:	83 ff 10             	cmp    $0x10,%edi
80100a5b:	0f 84 3f 01 00 00    	je     80100ba0 <consoleintr+0x1b0>
80100a61:	7e 65                	jle    80100ac8 <consoleintr+0xd8>
80100a63:	83 ff 15             	cmp    $0x15,%edi
80100a66:	0f 84 e4 00 00 00    	je     80100b50 <consoleintr+0x160>
80100a6c:	83 ff 7f             	cmp    $0x7f,%edi
80100a6f:	75 5c                	jne    80100acd <consoleintr+0xdd>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100a71:	a1 48 0f 11 80       	mov    0x80110f48,%eax
80100a76:	3b 05 44 0f 11 80    	cmp    0x80110f44,%eax
80100a7c:	74 d2                	je     80100a50 <consoleintr+0x60>
        input.e--;
80100a7e:	83 e8 01             	sub    $0x1,%eax
80100a81:	a3 48 0f 11 80       	mov    %eax,0x80110f48
        consputc(BACKSPACE);
80100a86:	b8 00 01 00 00       	mov    $0x100,%eax
80100a8b:	e8 60 f9 ff ff       	call   801003f0 <consputc>
    }
    return;
  }

  acquire(&cons.lock);
  while((c = getc()) >= 0){
80100a90:	ff d3                	call   *%ebx
80100a92:	85 c0                	test   %eax,%eax
80100a94:	89 c7                	mov    %eax,%edi
80100a96:	79 c0                	jns    80100a58 <consoleintr+0x68>
80100a98:	90                   	nop
80100a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100aa0:	83 ec 0c             	sub    $0xc,%esp
80100aa3:	68 c0 b4 10 80       	push   $0x8010b4c0
80100aa8:	e8 83 3b 00 00       	call   80104630 <release>
  if(doprocdump) {
80100aad:	83 c4 10             	add    $0x10,%esp
80100ab0:	85 f6                	test   %esi,%esi
80100ab2:	0f 84 74 ff ff ff    	je     80100a2c <consoleintr+0x3c>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100ab8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100abb:	5b                   	pop    %ebx
80100abc:	5e                   	pop    %esi
80100abd:	5f                   	pop    %edi
80100abe:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
80100abf:	e9 7c 37 00 00       	jmp    80104240 <procdump>
80100ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return;
  }

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
80100ac8:	83 ff 08             	cmp    $0x8,%edi
80100acb:	74 a4                	je     80100a71 <consoleintr+0x81>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100acd:	85 ff                	test   %edi,%edi
80100acf:	0f 84 7b ff ff ff    	je     80100a50 <consoleintr+0x60>
80100ad5:	a1 48 0f 11 80       	mov    0x80110f48,%eax
80100ada:	89 c2                	mov    %eax,%edx
80100adc:	2b 15 40 0f 11 80    	sub    0x80110f40,%edx
80100ae2:	83 fa 7f             	cmp    $0x7f,%edx
80100ae5:	0f 87 65 ff ff ff    	ja     80100a50 <consoleintr+0x60>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
80100aeb:	8d 50 01             	lea    0x1(%eax),%edx
80100aee:	83 e0 7f             	and    $0x7f,%eax
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
80100af1:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
80100af4:	89 15 48 0f 11 80    	mov    %edx,0x80110f48
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
80100afa:	0f 84 aa 00 00 00    	je     80100baa <consoleintr+0x1ba>
        input.buf[input.e++ % INPUT_BUF] = c;
80100b00:	89 f9                	mov    %edi,%ecx
80100b02:	88 88 c0 0e 11 80    	mov    %cl,-0x7feef140(%eax)
        consputc(c);
80100b08:	89 f8                	mov    %edi,%eax
80100b0a:	e8 e1 f8 ff ff       	call   801003f0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100b0f:	83 ff 0a             	cmp    $0xa,%edi
80100b12:	0f 84 a3 00 00 00    	je     80100bbb <consoleintr+0x1cb>
80100b18:	83 ff 04             	cmp    $0x4,%edi
80100b1b:	0f 84 9a 00 00 00    	je     80100bbb <consoleintr+0x1cb>
80100b21:	a1 40 0f 11 80       	mov    0x80110f40,%eax
80100b26:	83 e8 80             	sub    $0xffffff80,%eax
80100b29:	39 05 48 0f 11 80    	cmp    %eax,0x80110f48
80100b2f:	0f 85 1b ff ff ff    	jne    80100a50 <consoleintr+0x60>
          input.w = input.e;
          wakeup(&input.r);
80100b35:	83 ec 0c             	sub    $0xc,%esp
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
80100b38:	a3 44 0f 11 80       	mov    %eax,0x80110f44
          wakeup(&input.r);
80100b3d:	68 40 0f 11 80       	push   $0x80110f40
80100b42:	e8 09 36 00 00       	call   80104150 <wakeup>
80100b47:	83 c4 10             	add    $0x10,%esp
80100b4a:	e9 01 ff ff ff       	jmp    80100a50 <consoleintr+0x60>
80100b4f:	90                   	nop
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100b50:	a1 48 0f 11 80       	mov    0x80110f48,%eax
80100b55:	39 05 44 0f 11 80    	cmp    %eax,0x80110f44
80100b5b:	75 2b                	jne    80100b88 <consoleintr+0x198>
80100b5d:	e9 ee fe ff ff       	jmp    80100a50 <consoleintr+0x60>
80100b62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100b68:	a3 48 0f 11 80       	mov    %eax,0x80110f48
        consputc(BACKSPACE);
80100b6d:	b8 00 01 00 00       	mov    $0x100,%eax
80100b72:	e8 79 f8 ff ff       	call   801003f0 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100b77:	a1 48 0f 11 80       	mov    0x80110f48,%eax
80100b7c:	3b 05 44 0f 11 80    	cmp    0x80110f44,%eax
80100b82:	0f 84 c8 fe ff ff    	je     80100a50 <consoleintr+0x60>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100b88:	83 e8 01             	sub    $0x1,%eax
80100b8b:	89 c2                	mov    %eax,%edx
80100b8d:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100b90:	80 ba c0 0e 11 80 0a 	cmpb   $0xa,-0x7feef140(%edx)
80100b97:	75 cf                	jne    80100b68 <consoleintr+0x178>
80100b99:	e9 b2 fe ff ff       	jmp    80100a50 <consoleintr+0x60>
80100b9e:	66 90                	xchg   %ax,%ax
  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
80100ba0:	be 01 00 00 00       	mov    $0x1,%esi
80100ba5:	e9 a6 fe ff ff       	jmp    80100a50 <consoleintr+0x60>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
80100baa:	c6 80 c0 0e 11 80 0a 	movb   $0xa,-0x7feef140(%eax)
        consputc(c);
80100bb1:	b8 0a 00 00 00       	mov    $0xa,%eax
80100bb6:	e8 35 f8 ff ff       	call   801003f0 <consputc>
80100bbb:	a1 48 0f 11 80       	mov    0x80110f48,%eax
80100bc0:	e9 70 ff ff ff       	jmp    80100b35 <consoleintr+0x145>
80100bc5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100bd0 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
80100bd0:	55                   	push   %ebp
80100bd1:	89 e5                	mov    %esp,%ebp
80100bd3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100bd6:	68 c8 72 10 80       	push   $0x801072c8
80100bdb:	68 c0 b4 10 80       	push   $0x8010b4c0
80100be0:	e8 2b 38 00 00       	call   80104410 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100be5:	58                   	pop    %eax
80100be6:	5a                   	pop    %edx
80100be7:	6a 00                	push   $0x0
80100be9:	6a 01                	push   $0x1
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
80100beb:	c7 05 0c 19 11 80 20 	movl   $0x80100620,0x8011190c
80100bf2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100bf5:	c7 05 08 19 11 80 70 	movl   $0x80100270,0x80111908
80100bfc:	02 10 80 
  cons.locking = 1;
80100bff:	c7 05 f4 b4 10 80 01 	movl   $0x1,0x8010b4f4
80100c06:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
80100c09:	e8 f2 18 00 00       	call   80102500 <ioapicenable>
}
80100c0e:	83 c4 10             	add    $0x10,%esp
80100c11:	c9                   	leave  
80100c12:	c3                   	ret    
80100c13:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100c20 <readkey>:

int
readkey(int pid)
{
80100c20:	55                   	push   %ebp
80100c21:	89 e5                	mov    %esp,%ebp
  if (pid != screencaptured)
80100c23:	8b 45 08             	mov    0x8(%ebp),%eax
80100c26:	39 05 f8 b4 10 80    	cmp    %eax,0x8010b4f8
80100c2c:	75 12                	jne    80100c40 <readkey+0x20>
    return -1;

  int temp = buffer;
80100c2e:	a1 4c 0f 11 80       	mov    0x80110f4c,%eax
  buffer = 0;
80100c33:	c7 05 4c 0f 11 80 00 	movl   $0x0,0x80110f4c
80100c3a:	00 00 00 
  return temp;
80100c3d:	5d                   	pop    %ebp
80100c3e:	c3                   	ret    
80100c3f:	90                   	nop

int
readkey(int pid)
{
  if (pid != screencaptured)
    return -1;
80100c40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax

  int temp = buffer;
  buffer = 0;
  return temp;
80100c45:	5d                   	pop    %ebp
80100c46:	c3                   	ret    
80100c47:	66 90                	xchg   %ax,%ax
80100c49:	66 90                	xchg   %ax,%ax
80100c4b:	66 90                	xchg   %ax,%ax
80100c4d:	66 90                	xchg   %ax,%ax
80100c4f:	90                   	nop

80100c50 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100c50:	55                   	push   %ebp
80100c51:	89 e5                	mov    %esp,%ebp
80100c53:	57                   	push   %edi
80100c54:	56                   	push   %esi
80100c55:	53                   	push   %ebx
80100c56:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100c5c:	e8 7f 2d 00 00       	call   801039e0 <myproc>
80100c61:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100c67:	e8 44 21 00 00       	call   80102db0 <begin_op>

  if((ip = namei(path)) == 0){
80100c6c:	83 ec 0c             	sub    $0xc,%esp
80100c6f:	ff 75 08             	pushl  0x8(%ebp)
80100c72:	e8 a9 14 00 00       	call   80102120 <namei>
80100c77:	83 c4 10             	add    $0x10,%esp
80100c7a:	85 c0                	test   %eax,%eax
80100c7c:	0f 84 9c 01 00 00    	je     80100e1e <exec+0x1ce>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100c82:	83 ec 0c             	sub    $0xc,%esp
80100c85:	89 c3                	mov    %eax,%ebx
80100c87:	50                   	push   %eax
80100c88:	e8 43 0c 00 00       	call   801018d0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100c8d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100c93:	6a 34                	push   $0x34
80100c95:	6a 00                	push   $0x0
80100c97:	50                   	push   %eax
80100c98:	53                   	push   %ebx
80100c99:	e8 12 0f 00 00       	call   80101bb0 <readi>
80100c9e:	83 c4 20             	add    $0x20,%esp
80100ca1:	83 f8 34             	cmp    $0x34,%eax
80100ca4:	74 22                	je     80100cc8 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100ca6:	83 ec 0c             	sub    $0xc,%esp
80100ca9:	53                   	push   %ebx
80100caa:	e8 b1 0e 00 00       	call   80101b60 <iunlockput>
    end_op();
80100caf:	e8 6c 21 00 00       	call   80102e20 <end_op>
80100cb4:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100cb7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100cbc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100cbf:	5b                   	pop    %ebx
80100cc0:	5e                   	pop    %esi
80100cc1:	5f                   	pop    %edi
80100cc2:	5d                   	pop    %ebp
80100cc3:	c3                   	ret    
80100cc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100cc8:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100ccf:	45 4c 46 
80100cd2:	75 d2                	jne    80100ca6 <exec+0x56>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100cd4:	e8 d7 62 00 00       	call   80106fb0 <setupkvm>
80100cd9:	85 c0                	test   %eax,%eax
80100cdb:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100ce1:	74 c3                	je     80100ca6 <exec+0x56>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100ce3:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100cea:	00 
80100ceb:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100cf1:	c7 85 ec fe ff ff 00 	movl   $0x0,-0x114(%ebp)
80100cf8:	00 00 00 
80100cfb:	0f 84 c5 00 00 00    	je     80100dc6 <exec+0x176>
80100d01:	31 ff                	xor    %edi,%edi
80100d03:	eb 18                	jmp    80100d1d <exec+0xcd>
80100d05:	8d 76 00             	lea    0x0(%esi),%esi
80100d08:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100d0f:	83 c7 01             	add    $0x1,%edi
80100d12:	83 c6 20             	add    $0x20,%esi
80100d15:	39 f8                	cmp    %edi,%eax
80100d17:	0f 8e a9 00 00 00    	jle    80100dc6 <exec+0x176>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100d1d:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100d23:	6a 20                	push   $0x20
80100d25:	56                   	push   %esi
80100d26:	50                   	push   %eax
80100d27:	53                   	push   %ebx
80100d28:	e8 83 0e 00 00       	call   80101bb0 <readi>
80100d2d:	83 c4 10             	add    $0x10,%esp
80100d30:	83 f8 20             	cmp    $0x20,%eax
80100d33:	75 7b                	jne    80100db0 <exec+0x160>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100d35:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100d3c:	75 ca                	jne    80100d08 <exec+0xb8>
      continue;
    if(ph.memsz < ph.filesz)
80100d3e:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100d44:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100d4a:	72 64                	jb     80100db0 <exec+0x160>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100d4c:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100d52:	72 5c                	jb     80100db0 <exec+0x160>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100d54:	83 ec 04             	sub    $0x4,%esp
80100d57:	50                   	push   %eax
80100d58:	ff b5 ec fe ff ff    	pushl  -0x114(%ebp)
80100d5e:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100d64:	e8 97 60 00 00       	call   80106e00 <allocuvm>
80100d69:	83 c4 10             	add    $0x10,%esp
80100d6c:	85 c0                	test   %eax,%eax
80100d6e:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100d74:	74 3a                	je     80100db0 <exec+0x160>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100d76:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100d7c:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100d81:	75 2d                	jne    80100db0 <exec+0x160>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100d83:	83 ec 0c             	sub    $0xc,%esp
80100d86:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100d8c:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100d92:	53                   	push   %ebx
80100d93:	50                   	push   %eax
80100d94:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100d9a:	e8 a1 5f 00 00       	call   80106d40 <loaduvm>
80100d9f:	83 c4 20             	add    $0x20,%esp
80100da2:	85 c0                	test   %eax,%eax
80100da4:	0f 89 5e ff ff ff    	jns    80100d08 <exec+0xb8>
80100daa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100db0:	83 ec 0c             	sub    $0xc,%esp
80100db3:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100db9:	e8 72 61 00 00       	call   80106f30 <freevm>
80100dbe:	83 c4 10             	add    $0x10,%esp
80100dc1:	e9 e0 fe ff ff       	jmp    80100ca6 <exec+0x56>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100dc6:	83 ec 0c             	sub    $0xc,%esp
80100dc9:	53                   	push   %ebx
80100dca:	e8 91 0d 00 00       	call   80101b60 <iunlockput>
  end_op();
80100dcf:	e8 4c 20 00 00       	call   80102e20 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100dd4:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100dda:	83 c4 0c             	add    $0xc,%esp
  end_op();
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100ddd:	05 ff 0f 00 00       	add    $0xfff,%eax
80100de2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100de7:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100ded:	52                   	push   %edx
80100dee:	50                   	push   %eax
80100def:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100df5:	e8 06 60 00 00       	call   80106e00 <allocuvm>
80100dfa:	83 c4 10             	add    $0x10,%esp
80100dfd:	85 c0                	test   %eax,%eax
80100dff:	89 c6                	mov    %eax,%esi
80100e01:	75 3a                	jne    80100e3d <exec+0x1ed>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100e03:	83 ec 0c             	sub    $0xc,%esp
80100e06:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100e0c:	e8 1f 61 00 00       	call   80106f30 <freevm>
80100e11:	83 c4 10             	add    $0x10,%esp
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100e14:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100e19:	e9 9e fe ff ff       	jmp    80100cbc <exec+0x6c>
  struct proc *curproc = myproc();

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
80100e1e:	e8 fd 1f 00 00       	call   80102e20 <end_op>
    cprintf("exec: fail\n");
80100e23:	83 ec 0c             	sub    $0xc,%esp
80100e26:	68 e1 72 10 80       	push   $0x801072e1
80100e2b:	e8 50 f8 ff ff       	call   80100680 <cprintf>
    return -1;
80100e30:	83 c4 10             	add    $0x10,%esp
80100e33:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100e38:	e9 7f fe ff ff       	jmp    80100cbc <exec+0x6c>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100e3d:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100e43:	83 ec 08             	sub    $0x8,%esp
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100e46:	31 ff                	xor    %edi,%edi
80100e48:	89 f3                	mov    %esi,%ebx
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100e4a:	50                   	push   %eax
80100e4b:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100e51:	e8 fa 61 00 00       	call   80107050 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100e56:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e59:	83 c4 10             	add    $0x10,%esp
80100e5c:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100e62:	8b 00                	mov    (%eax),%eax
80100e64:	85 c0                	test   %eax,%eax
80100e66:	74 79                	je     80100ee1 <exec+0x291>
80100e68:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100e6e:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100e74:	eb 13                	jmp    80100e89 <exec+0x239>
80100e76:	8d 76 00             	lea    0x0(%esi),%esi
80100e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(argc >= MAXARG)
80100e80:	83 ff 20             	cmp    $0x20,%edi
80100e83:	0f 84 7a ff ff ff    	je     80100e03 <exec+0x1b3>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100e89:	83 ec 0c             	sub    $0xc,%esp
80100e8c:	50                   	push   %eax
80100e8d:	e8 2e 3a 00 00       	call   801048c0 <strlen>
80100e92:	f7 d0                	not    %eax
80100e94:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100e96:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e99:	5a                   	pop    %edx

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100e9a:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100e9d:	ff 34 b8             	pushl  (%eax,%edi,4)
80100ea0:	e8 1b 3a 00 00       	call   801048c0 <strlen>
80100ea5:	83 c0 01             	add    $0x1,%eax
80100ea8:	50                   	push   %eax
80100ea9:	8b 45 0c             	mov    0xc(%ebp),%eax
80100eac:	ff 34 b8             	pushl  (%eax,%edi,4)
80100eaf:	53                   	push   %ebx
80100eb0:	56                   	push   %esi
80100eb1:	e8 fa 62 00 00       	call   801071b0 <copyout>
80100eb6:	83 c4 20             	add    $0x20,%esp
80100eb9:	85 c0                	test   %eax,%eax
80100ebb:	0f 88 42 ff ff ff    	js     80100e03 <exec+0x1b3>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100ec1:	8b 45 0c             	mov    0xc(%ebp),%eax
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100ec4:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100ecb:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100ece:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100ed4:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100ed7:	85 c0                	test   %eax,%eax
80100ed9:	75 a5                	jne    80100e80 <exec+0x230>
80100edb:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100ee1:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100ee8:	89 d9                	mov    %ebx,%ecx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100eea:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100ef1:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100ef5:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100efc:	ff ff ff 
  ustack[1] = argc;
80100eff:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100f05:	29 c1                	sub    %eax,%ecx

  sp -= (3+argc+1) * 4;
80100f07:	83 c0 0c             	add    $0xc,%eax
80100f0a:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100f0c:	50                   	push   %eax
80100f0d:	52                   	push   %edx
80100f0e:	53                   	push   %ebx
80100f0f:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100f15:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100f1b:	e8 90 62 00 00       	call   801071b0 <copyout>
80100f20:	83 c4 10             	add    $0x10,%esp
80100f23:	85 c0                	test   %eax,%eax
80100f25:	0f 88 d8 fe ff ff    	js     80100e03 <exec+0x1b3>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100f2b:	8b 45 08             	mov    0x8(%ebp),%eax
80100f2e:	0f b6 10             	movzbl (%eax),%edx
80100f31:	84 d2                	test   %dl,%dl
80100f33:	74 19                	je     80100f4e <exec+0x2fe>
80100f35:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100f38:	83 c0 01             	add    $0x1,%eax
    if(*s == '/')
      last = s+1;
80100f3b:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100f3e:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
80100f41:	0f 44 c8             	cmove  %eax,%ecx
80100f44:	83 c0 01             	add    $0x1,%eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100f47:	84 d2                	test   %dl,%dl
80100f49:	75 f0                	jne    80100f3b <exec+0x2eb>
80100f4b:	89 4d 08             	mov    %ecx,0x8(%ebp)
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100f4e:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100f54:	50                   	push   %eax
80100f55:	6a 10                	push   $0x10
80100f57:	ff 75 08             	pushl  0x8(%ebp)
80100f5a:	89 f8                	mov    %edi,%eax
80100f5c:	83 c0 6c             	add    $0x6c,%eax
80100f5f:	50                   	push   %eax
80100f60:	e8 1b 39 00 00       	call   80104880 <safestrcpy>

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100f65:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100f6b:	89 f8                	mov    %edi,%eax
80100f6d:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->pgdir = pgdir;
  curproc->sz = sz;
80100f70:	89 30                	mov    %esi,(%eax)
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100f72:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->sz = sz;
  curproc->tf->eip = elf.entry;  // main
80100f75:	89 c1                	mov    %eax,%ecx
80100f77:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100f7d:	8b 40 18             	mov    0x18(%eax),%eax
80100f80:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100f83:	8b 41 18             	mov    0x18(%ecx),%eax
80100f86:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100f89:	89 0c 24             	mov    %ecx,(%esp)
80100f8c:	e8 1f 5c 00 00       	call   80106bb0 <switchuvm>
  freevm(oldpgdir);
80100f91:	89 3c 24             	mov    %edi,(%esp)
80100f94:	e8 97 5f 00 00       	call   80106f30 <freevm>
  return 0;
80100f99:	83 c4 10             	add    $0x10,%esp
80100f9c:	31 c0                	xor    %eax,%eax
80100f9e:	e9 19 fd ff ff       	jmp    80100cbc <exec+0x6c>
80100fa3:	66 90                	xchg   %ax,%ax
80100fa5:	66 90                	xchg   %ax,%ax
80100fa7:	66 90                	xchg   %ax,%ax
80100fa9:	66 90                	xchg   %ax,%ax
80100fab:	66 90                	xchg   %ax,%ax
80100fad:	66 90                	xchg   %ax,%ax
80100faf:	90                   	nop

80100fb0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100fb0:	55                   	push   %ebp
80100fb1:	89 e5                	mov    %esp,%ebp
80100fb3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100fb6:	68 ed 72 10 80       	push   $0x801072ed
80100fbb:	68 60 0f 11 80       	push   $0x80110f60
80100fc0:	e8 4b 34 00 00       	call   80104410 <initlock>
}
80100fc5:	83 c4 10             	add    $0x10,%esp
80100fc8:	c9                   	leave  
80100fc9:	c3                   	ret    
80100fca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100fd0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100fd0:	55                   	push   %ebp
80100fd1:	89 e5                	mov    %esp,%ebp
80100fd3:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100fd4:	bb 94 0f 11 80       	mov    $0x80110f94,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100fd9:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
80100fdc:	68 60 0f 11 80       	push   $0x80110f60
80100fe1:	e8 2a 35 00 00       	call   80104510 <acquire>
80100fe6:	83 c4 10             	add    $0x10,%esp
80100fe9:	eb 10                	jmp    80100ffb <filealloc+0x2b>
80100feb:	90                   	nop
80100fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100ff0:	83 c3 18             	add    $0x18,%ebx
80100ff3:	81 fb f4 18 11 80    	cmp    $0x801118f4,%ebx
80100ff9:	74 25                	je     80101020 <filealloc+0x50>
    if(f->ref == 0){
80100ffb:	8b 43 04             	mov    0x4(%ebx),%eax
80100ffe:	85 c0                	test   %eax,%eax
80101000:	75 ee                	jne    80100ff0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80101002:	83 ec 0c             	sub    $0xc,%esp
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
80101005:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
8010100c:	68 60 0f 11 80       	push   $0x80110f60
80101011:	e8 1a 36 00 00       	call   80104630 <release>
      return f;
80101016:	89 d8                	mov    %ebx,%eax
80101018:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ftable.lock);
  return 0;
}
8010101b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010101e:	c9                   	leave  
8010101f:	c3                   	ret    
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80101020:	83 ec 0c             	sub    $0xc,%esp
80101023:	68 60 0f 11 80       	push   $0x80110f60
80101028:	e8 03 36 00 00       	call   80104630 <release>
  return 0;
8010102d:	83 c4 10             	add    $0x10,%esp
80101030:	31 c0                	xor    %eax,%eax
}
80101032:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101035:	c9                   	leave  
80101036:	c3                   	ret    
80101037:	89 f6                	mov    %esi,%esi
80101039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101040 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101040:	55                   	push   %ebp
80101041:	89 e5                	mov    %esp,%ebp
80101043:	53                   	push   %ebx
80101044:	83 ec 10             	sub    $0x10,%esp
80101047:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
8010104a:	68 60 0f 11 80       	push   $0x80110f60
8010104f:	e8 bc 34 00 00       	call   80104510 <acquire>
  if(f->ref < 1)
80101054:	8b 43 04             	mov    0x4(%ebx),%eax
80101057:	83 c4 10             	add    $0x10,%esp
8010105a:	85 c0                	test   %eax,%eax
8010105c:	7e 1a                	jle    80101078 <filedup+0x38>
    panic("filedup");
  f->ref++;
8010105e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101061:	83 ec 0c             	sub    $0xc,%esp
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  f->ref++;
80101064:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80101067:	68 60 0f 11 80       	push   $0x80110f60
8010106c:	e8 bf 35 00 00       	call   80104630 <release>
  return f;
}
80101071:	89 d8                	mov    %ebx,%eax
80101073:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101076:	c9                   	leave  
80101077:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80101078:	83 ec 0c             	sub    $0xc,%esp
8010107b:	68 f4 72 10 80       	push   $0x801072f4
80101080:	e8 eb f2 ff ff       	call   80100370 <panic>
80101085:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101090 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101090:	55                   	push   %ebp
80101091:	89 e5                	mov    %esp,%ebp
80101093:	57                   	push   %edi
80101094:	56                   	push   %esi
80101095:	53                   	push   %ebx
80101096:	83 ec 28             	sub    $0x28,%esp
80101099:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
8010109c:	68 60 0f 11 80       	push   $0x80110f60
801010a1:	e8 6a 34 00 00       	call   80104510 <acquire>
  if(f->ref < 1)
801010a6:	8b 47 04             	mov    0x4(%edi),%eax
801010a9:	83 c4 10             	add    $0x10,%esp
801010ac:	85 c0                	test   %eax,%eax
801010ae:	0f 8e 9b 00 00 00    	jle    8010114f <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
801010b4:	83 e8 01             	sub    $0x1,%eax
801010b7:	85 c0                	test   %eax,%eax
801010b9:	89 47 04             	mov    %eax,0x4(%edi)
801010bc:	74 1a                	je     801010d8 <fileclose+0x48>
    release(&ftable.lock);
801010be:	c7 45 08 60 0f 11 80 	movl   $0x80110f60,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
801010c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010c8:	5b                   	pop    %ebx
801010c9:	5e                   	pop    %esi
801010ca:	5f                   	pop    %edi
801010cb:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
801010cc:	e9 5f 35 00 00       	jmp    80104630 <release>
801010d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
801010d8:	0f b6 47 09          	movzbl 0x9(%edi),%eax
801010dc:	8b 1f                	mov    (%edi),%ebx
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
801010de:	83 ec 0c             	sub    $0xc,%esp
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
801010e1:	8b 77 0c             	mov    0xc(%edi),%esi
  f->ref = 0;
  f->type = FD_NONE;
801010e4:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
801010ea:	88 45 e7             	mov    %al,-0x19(%ebp)
801010ed:	8b 47 10             	mov    0x10(%edi),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
801010f0:	68 60 0f 11 80       	push   $0x80110f60
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
801010f5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
801010f8:	e8 33 35 00 00       	call   80104630 <release>

  if(ff.type == FD_PIPE)
801010fd:	83 c4 10             	add    $0x10,%esp
80101100:	83 fb 01             	cmp    $0x1,%ebx
80101103:	74 13                	je     80101118 <fileclose+0x88>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80101105:	83 fb 02             	cmp    $0x2,%ebx
80101108:	74 26                	je     80101130 <fileclose+0xa0>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
8010110a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010110d:	5b                   	pop    %ebx
8010110e:	5e                   	pop    %esi
8010110f:	5f                   	pop    %edi
80101110:	5d                   	pop    %ebp
80101111:	c3                   	ret    
80101112:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80101118:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
8010111c:	83 ec 08             	sub    $0x8,%esp
8010111f:	53                   	push   %ebx
80101120:	56                   	push   %esi
80101121:	e8 2a 24 00 00       	call   80103550 <pipeclose>
80101126:	83 c4 10             	add    $0x10,%esp
80101129:	eb df                	jmp    8010110a <fileclose+0x7a>
8010112b:	90                   	nop
8010112c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80101130:	e8 7b 1c 00 00       	call   80102db0 <begin_op>
    iput(ff.ip);
80101135:	83 ec 0c             	sub    $0xc,%esp
80101138:	ff 75 e0             	pushl  -0x20(%ebp)
8010113b:	e8 c0 08 00 00       	call   80101a00 <iput>
    end_op();
80101140:	83 c4 10             	add    $0x10,%esp
  }
}
80101143:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101146:	5b                   	pop    %ebx
80101147:	5e                   	pop    %esi
80101148:	5f                   	pop    %edi
80101149:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
8010114a:	e9 d1 1c 00 00       	jmp    80102e20 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
8010114f:	83 ec 0c             	sub    $0xc,%esp
80101152:	68 fc 72 10 80       	push   $0x801072fc
80101157:	e8 14 f2 ff ff       	call   80100370 <panic>
8010115c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101160 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101160:	55                   	push   %ebp
80101161:	89 e5                	mov    %esp,%ebp
80101163:	53                   	push   %ebx
80101164:	83 ec 04             	sub    $0x4,%esp
80101167:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010116a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010116d:	75 31                	jne    801011a0 <filestat+0x40>
    ilock(f->ip);
8010116f:	83 ec 0c             	sub    $0xc,%esp
80101172:	ff 73 10             	pushl  0x10(%ebx)
80101175:	e8 56 07 00 00       	call   801018d0 <ilock>
    stati(f->ip, st);
8010117a:	58                   	pop    %eax
8010117b:	5a                   	pop    %edx
8010117c:	ff 75 0c             	pushl  0xc(%ebp)
8010117f:	ff 73 10             	pushl  0x10(%ebx)
80101182:	e8 f9 09 00 00       	call   80101b80 <stati>
    iunlock(f->ip);
80101187:	59                   	pop    %ecx
80101188:	ff 73 10             	pushl  0x10(%ebx)
8010118b:	e8 20 08 00 00       	call   801019b0 <iunlock>
    return 0;
80101190:	83 c4 10             	add    $0x10,%esp
80101193:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80101195:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101198:	c9                   	leave  
80101199:	c3                   	ret    
8010119a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
801011a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801011a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801011a8:	c9                   	leave  
801011a9:	c3                   	ret    
801011aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801011b0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
801011b0:	55                   	push   %ebp
801011b1:	89 e5                	mov    %esp,%ebp
801011b3:	57                   	push   %edi
801011b4:	56                   	push   %esi
801011b5:	53                   	push   %ebx
801011b6:	83 ec 0c             	sub    $0xc,%esp
801011b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801011bc:	8b 75 0c             	mov    0xc(%ebp),%esi
801011bf:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
801011c2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801011c6:	74 60                	je     80101228 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
801011c8:	8b 03                	mov    (%ebx),%eax
801011ca:	83 f8 01             	cmp    $0x1,%eax
801011cd:	74 41                	je     80101210 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
801011cf:	83 f8 02             	cmp    $0x2,%eax
801011d2:	75 5b                	jne    8010122f <fileread+0x7f>
    ilock(f->ip);
801011d4:	83 ec 0c             	sub    $0xc,%esp
801011d7:	ff 73 10             	pushl  0x10(%ebx)
801011da:	e8 f1 06 00 00       	call   801018d0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801011df:	57                   	push   %edi
801011e0:	ff 73 14             	pushl  0x14(%ebx)
801011e3:	56                   	push   %esi
801011e4:	ff 73 10             	pushl  0x10(%ebx)
801011e7:	e8 c4 09 00 00       	call   80101bb0 <readi>
801011ec:	83 c4 20             	add    $0x20,%esp
801011ef:	85 c0                	test   %eax,%eax
801011f1:	89 c6                	mov    %eax,%esi
801011f3:	7e 03                	jle    801011f8 <fileread+0x48>
      f->off += r;
801011f5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
801011f8:	83 ec 0c             	sub    $0xc,%esp
801011fb:	ff 73 10             	pushl  0x10(%ebx)
801011fe:	e8 ad 07 00 00       	call   801019b0 <iunlock>
    return r;
80101203:	83 c4 10             	add    $0x10,%esp
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101206:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80101208:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010120b:	5b                   	pop    %ebx
8010120c:	5e                   	pop    %esi
8010120d:	5f                   	pop    %edi
8010120e:	5d                   	pop    %ebp
8010120f:	c3                   	ret    
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80101210:	8b 43 0c             	mov    0xc(%ebx),%eax
80101213:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80101216:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101219:	5b                   	pop    %ebx
8010121a:	5e                   	pop    %esi
8010121b:	5f                   	pop    %edi
8010121c:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
8010121d:	e9 ce 24 00 00       	jmp    801036f0 <piperead>
80101222:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
80101228:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010122d:	eb d9                	jmp    80101208 <fileread+0x58>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
8010122f:	83 ec 0c             	sub    $0xc,%esp
80101232:	68 06 73 10 80       	push   $0x80107306
80101237:	e8 34 f1 ff ff       	call   80100370 <panic>
8010123c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101240 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101240:	55                   	push   %ebp
80101241:	89 e5                	mov    %esp,%ebp
80101243:	57                   	push   %edi
80101244:	56                   	push   %esi
80101245:	53                   	push   %ebx
80101246:	83 ec 1c             	sub    $0x1c,%esp
80101249:	8b 75 08             	mov    0x8(%ebp),%esi
8010124c:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
8010124f:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101253:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101256:	8b 45 10             	mov    0x10(%ebp),%eax
80101259:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
8010125c:	0f 84 aa 00 00 00    	je     8010130c <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101262:	8b 06                	mov    (%esi),%eax
80101264:	83 f8 01             	cmp    $0x1,%eax
80101267:	0f 84 c2 00 00 00    	je     8010132f <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010126d:	83 f8 02             	cmp    $0x2,%eax
80101270:	0f 85 d8 00 00 00    	jne    8010134e <filewrite+0x10e>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101276:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101279:	31 ff                	xor    %edi,%edi
8010127b:	85 c0                	test   %eax,%eax
8010127d:	7f 34                	jg     801012b3 <filewrite+0x73>
8010127f:	e9 9c 00 00 00       	jmp    80101320 <filewrite+0xe0>
80101284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101288:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010128b:	83 ec 0c             	sub    $0xc,%esp
8010128e:	ff 76 10             	pushl  0x10(%esi)
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101291:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101294:	e8 17 07 00 00       	call   801019b0 <iunlock>
      end_op();
80101299:	e8 82 1b 00 00       	call   80102e20 <end_op>
8010129e:	8b 45 e0             	mov    -0x20(%ebp),%eax
801012a1:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
801012a4:	39 d8                	cmp    %ebx,%eax
801012a6:	0f 85 95 00 00 00    	jne    80101341 <filewrite+0x101>
        panic("short filewrite");
      i += r;
801012ac:	01 c7                	add    %eax,%edi
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801012ae:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801012b1:	7e 6d                	jle    80101320 <filewrite+0xe0>
      int n1 = n - i;
801012b3:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801012b6:	b8 00 06 00 00       	mov    $0x600,%eax
801012bb:	29 fb                	sub    %edi,%ebx
801012bd:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
801012c3:	0f 4f d8             	cmovg  %eax,%ebx
      if(n1 > max)
        n1 = max;

      begin_op();
801012c6:	e8 e5 1a 00 00       	call   80102db0 <begin_op>
      ilock(f->ip);
801012cb:	83 ec 0c             	sub    $0xc,%esp
801012ce:	ff 76 10             	pushl  0x10(%esi)
801012d1:	e8 fa 05 00 00       	call   801018d0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801012d6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801012d9:	53                   	push   %ebx
801012da:	ff 76 14             	pushl  0x14(%esi)
801012dd:	01 f8                	add    %edi,%eax
801012df:	50                   	push   %eax
801012e0:	ff 76 10             	pushl  0x10(%esi)
801012e3:	e8 c8 09 00 00       	call   80101cb0 <writei>
801012e8:	83 c4 20             	add    $0x20,%esp
801012eb:	85 c0                	test   %eax,%eax
801012ed:	7f 99                	jg     80101288 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
801012ef:	83 ec 0c             	sub    $0xc,%esp
801012f2:	ff 76 10             	pushl  0x10(%esi)
801012f5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801012f8:	e8 b3 06 00 00       	call   801019b0 <iunlock>
      end_op();
801012fd:	e8 1e 1b 00 00       	call   80102e20 <end_op>

      if(r < 0)
80101302:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101305:	83 c4 10             	add    $0x10,%esp
80101308:	85 c0                	test   %eax,%eax
8010130a:	74 98                	je     801012a4 <filewrite+0x64>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
8010130c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
8010130f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80101314:	5b                   	pop    %ebx
80101315:	5e                   	pop    %esi
80101316:	5f                   	pop    %edi
80101317:	5d                   	pop    %ebp
80101318:	c3                   	ret    
80101319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
80101320:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80101323:	75 e7                	jne    8010130c <filewrite+0xcc>
  }
  panic("filewrite");
}
80101325:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101328:	89 f8                	mov    %edi,%eax
8010132a:	5b                   	pop    %ebx
8010132b:	5e                   	pop    %esi
8010132c:	5f                   	pop    %edi
8010132d:	5d                   	pop    %ebp
8010132e:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
8010132f:	8b 46 0c             	mov    0xc(%esi),%eax
80101332:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80101335:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101338:	5b                   	pop    %ebx
80101339:	5e                   	pop    %esi
8010133a:	5f                   	pop    %edi
8010133b:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
8010133c:	e9 af 22 00 00       	jmp    801035f0 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
80101341:	83 ec 0c             	sub    $0xc,%esp
80101344:	68 0f 73 10 80       	push   $0x8010730f
80101349:	e8 22 f0 ff ff       	call   80100370 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
8010134e:	83 ec 0c             	sub    $0xc,%esp
80101351:	68 15 73 10 80       	push   $0x80107315
80101356:	e8 15 f0 ff ff       	call   80100370 <panic>
8010135b:	66 90                	xchg   %ax,%ax
8010135d:	66 90                	xchg   %ax,%ax
8010135f:	90                   	nop

80101360 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101360:	55                   	push   %ebp
80101361:	89 e5                	mov    %esp,%ebp
80101363:	57                   	push   %edi
80101364:	56                   	push   %esi
80101365:	53                   	push   %ebx
80101366:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101369:	8b 0d 60 19 11 80    	mov    0x80111960,%ecx
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
8010136f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101372:	85 c9                	test   %ecx,%ecx
80101374:	0f 84 85 00 00 00    	je     801013ff <balloc+0x9f>
8010137a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101381:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101384:	83 ec 08             	sub    $0x8,%esp
80101387:	89 f0                	mov    %esi,%eax
80101389:	c1 f8 0c             	sar    $0xc,%eax
8010138c:	03 05 78 19 11 80    	add    0x80111978,%eax
80101392:	50                   	push   %eax
80101393:	ff 75 d8             	pushl  -0x28(%ebp)
80101396:	e8 35 ed ff ff       	call   801000d0 <bread>
8010139b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010139e:	a1 60 19 11 80       	mov    0x80111960,%eax
801013a3:	83 c4 10             	add    $0x10,%esp
801013a6:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801013a9:	31 c0                	xor    %eax,%eax
801013ab:	eb 2d                	jmp    801013da <balloc+0x7a>
801013ad:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801013b0:	89 c1                	mov    %eax,%ecx
801013b2:	ba 01 00 00 00       	mov    $0x1,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801013b7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
801013ba:	83 e1 07             	and    $0x7,%ecx
801013bd:	d3 e2                	shl    %cl,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801013bf:	89 c1                	mov    %eax,%ecx
801013c1:	c1 f9 03             	sar    $0x3,%ecx
801013c4:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
801013c9:	85 d7                	test   %edx,%edi
801013cb:	74 43                	je     80101410 <balloc+0xb0>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801013cd:	83 c0 01             	add    $0x1,%eax
801013d0:	83 c6 01             	add    $0x1,%esi
801013d3:	3d 00 10 00 00       	cmp    $0x1000,%eax
801013d8:	74 05                	je     801013df <balloc+0x7f>
801013da:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801013dd:	72 d1                	jb     801013b0 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801013df:	83 ec 0c             	sub    $0xc,%esp
801013e2:	ff 75 e4             	pushl  -0x1c(%ebp)
801013e5:	e8 f6 ed ff ff       	call   801001e0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801013ea:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801013f1:	83 c4 10             	add    $0x10,%esp
801013f4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801013f7:	39 05 60 19 11 80    	cmp    %eax,0x80111960
801013fd:	77 82                	ja     80101381 <balloc+0x21>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
801013ff:	83 ec 0c             	sub    $0xc,%esp
80101402:	68 1f 73 10 80       	push   $0x8010731f
80101407:	e8 64 ef ff ff       	call   80100370 <panic>
8010140c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101410:	09 fa                	or     %edi,%edx
80101412:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101415:	83 ec 0c             	sub    $0xc,%esp
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101418:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010141c:	57                   	push   %edi
8010141d:	e8 6e 1b 00 00       	call   80102f90 <log_write>
        brelse(bp);
80101422:	89 3c 24             	mov    %edi,(%esp)
80101425:	e8 b6 ed ff ff       	call   801001e0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
8010142a:	58                   	pop    %eax
8010142b:	5a                   	pop    %edx
8010142c:	56                   	push   %esi
8010142d:	ff 75 d8             	pushl  -0x28(%ebp)
80101430:	e8 9b ec ff ff       	call   801000d0 <bread>
80101435:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101437:	8d 40 5c             	lea    0x5c(%eax),%eax
8010143a:	83 c4 0c             	add    $0xc,%esp
8010143d:	68 00 02 00 00       	push   $0x200
80101442:	6a 00                	push   $0x0
80101444:	50                   	push   %eax
80101445:	e8 36 32 00 00       	call   80104680 <memset>
  log_write(bp);
8010144a:	89 1c 24             	mov    %ebx,(%esp)
8010144d:	e8 3e 1b 00 00       	call   80102f90 <log_write>
  brelse(bp);
80101452:	89 1c 24             	mov    %ebx,(%esp)
80101455:	e8 86 ed ff ff       	call   801001e0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
8010145a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010145d:	89 f0                	mov    %esi,%eax
8010145f:	5b                   	pop    %ebx
80101460:	5e                   	pop    %esi
80101461:	5f                   	pop    %edi
80101462:	5d                   	pop    %ebp
80101463:	c3                   	ret    
80101464:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010146a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101470 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101470:	55                   	push   %ebp
80101471:	89 e5                	mov    %esp,%ebp
80101473:	57                   	push   %edi
80101474:	56                   	push   %esi
80101475:	53                   	push   %ebx
80101476:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101478:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010147a:	bb b4 19 11 80       	mov    $0x801119b4,%ebx
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
8010147f:	83 ec 28             	sub    $0x28,%esp
80101482:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101485:	68 80 19 11 80       	push   $0x80111980
8010148a:	e8 81 30 00 00       	call   80104510 <acquire>
8010148f:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101492:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101495:	eb 1b                	jmp    801014b2 <iget+0x42>
80101497:	89 f6                	mov    %esi,%esi
80101499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801014a0:	85 f6                	test   %esi,%esi
801014a2:	74 44                	je     801014e8 <iget+0x78>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801014a4:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014aa:	81 fb d4 35 11 80    	cmp    $0x801135d4,%ebx
801014b0:	74 4e                	je     80101500 <iget+0x90>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801014b2:	8b 4b 08             	mov    0x8(%ebx),%ecx
801014b5:	85 c9                	test   %ecx,%ecx
801014b7:	7e e7                	jle    801014a0 <iget+0x30>
801014b9:	39 3b                	cmp    %edi,(%ebx)
801014bb:	75 e3                	jne    801014a0 <iget+0x30>
801014bd:	39 53 04             	cmp    %edx,0x4(%ebx)
801014c0:	75 de                	jne    801014a0 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
801014c2:	83 ec 0c             	sub    $0xc,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
801014c5:	83 c1 01             	add    $0x1,%ecx
      release(&icache.lock);
      return ip;
801014c8:	89 de                	mov    %ebx,%esi
  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
801014ca:	68 80 19 11 80       	push   $0x80111980

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
801014cf:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801014d2:	e8 59 31 00 00       	call   80104630 <release>
      return ip;
801014d7:	83 c4 10             	add    $0x10,%esp
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
801014da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014dd:	89 f0                	mov    %esi,%eax
801014df:	5b                   	pop    %ebx
801014e0:	5e                   	pop    %esi
801014e1:	5f                   	pop    %edi
801014e2:	5d                   	pop    %ebp
801014e3:	c3                   	ret    
801014e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801014e8:	85 c9                	test   %ecx,%ecx
801014ea:	0f 44 f3             	cmove  %ebx,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801014ed:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014f3:	81 fb d4 35 11 80    	cmp    $0x801135d4,%ebx
801014f9:	75 b7                	jne    801014b2 <iget+0x42>
801014fb:	90                   	nop
801014fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101500:	85 f6                	test   %esi,%esi
80101502:	74 2d                	je     80101531 <iget+0xc1>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101504:	83 ec 0c             	sub    $0xc,%esp
  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
80101507:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101509:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010150c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101513:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010151a:	68 80 19 11 80       	push   $0x80111980
8010151f:	e8 0c 31 00 00       	call   80104630 <release>

  return ip;
80101524:	83 c4 10             	add    $0x10,%esp
}
80101527:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010152a:	89 f0                	mov    %esi,%eax
8010152c:	5b                   	pop    %ebx
8010152d:	5e                   	pop    %esi
8010152e:	5f                   	pop    %edi
8010152f:	5d                   	pop    %ebp
80101530:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
80101531:	83 ec 0c             	sub    $0xc,%esp
80101534:	68 35 73 10 80       	push   $0x80107335
80101539:	e8 32 ee ff ff       	call   80100370 <panic>
8010153e:	66 90                	xchg   %ax,%ax

80101540 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101540:	55                   	push   %ebp
80101541:	89 e5                	mov    %esp,%ebp
80101543:	57                   	push   %edi
80101544:	56                   	push   %esi
80101545:	53                   	push   %ebx
80101546:	89 c6                	mov    %eax,%esi
80101548:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010154b:	83 fa 0b             	cmp    $0xb,%edx
8010154e:	77 18                	ja     80101568 <bmap+0x28>
80101550:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
    if((addr = ip->addrs[bn]) == 0)
80101553:	8b 43 5c             	mov    0x5c(%ebx),%eax
80101556:	85 c0                	test   %eax,%eax
80101558:	74 76                	je     801015d0 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010155a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010155d:	5b                   	pop    %ebx
8010155e:	5e                   	pop    %esi
8010155f:	5f                   	pop    %edi
80101560:	5d                   	pop    %ebp
80101561:	c3                   	ret    
80101562:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101568:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
8010156b:	83 fb 7f             	cmp    $0x7f,%ebx
8010156e:	0f 87 83 00 00 00    	ja     801015f7 <bmap+0xb7>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101574:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
8010157a:	85 c0                	test   %eax,%eax
8010157c:	74 6a                	je     801015e8 <bmap+0xa8>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010157e:	83 ec 08             	sub    $0x8,%esp
80101581:	50                   	push   %eax
80101582:	ff 36                	pushl  (%esi)
80101584:	e8 47 eb ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101589:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010158d:	83 c4 10             	add    $0x10,%esp

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101590:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101592:	8b 1a                	mov    (%edx),%ebx
80101594:	85 db                	test   %ebx,%ebx
80101596:	75 1d                	jne    801015b5 <bmap+0x75>
      a[bn] = addr = balloc(ip->dev);
80101598:	8b 06                	mov    (%esi),%eax
8010159a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010159d:	e8 be fd ff ff       	call   80101360 <balloc>
801015a2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
801015a5:	83 ec 0c             	sub    $0xc,%esp
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
801015a8:	89 c3                	mov    %eax,%ebx
801015aa:	89 02                	mov    %eax,(%edx)
      log_write(bp);
801015ac:	57                   	push   %edi
801015ad:	e8 de 19 00 00       	call   80102f90 <log_write>
801015b2:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
801015b5:	83 ec 0c             	sub    $0xc,%esp
801015b8:	57                   	push   %edi
801015b9:	e8 22 ec ff ff       	call   801001e0 <brelse>
801015be:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
801015c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801015c4:	89 d8                	mov    %ebx,%eax
    return addr;
  }

  panic("bmap: out of range");
}
801015c6:	5b                   	pop    %ebx
801015c7:	5e                   	pop    %esi
801015c8:	5f                   	pop    %edi
801015c9:	5d                   	pop    %ebp
801015ca:	c3                   	ret    
801015cb:	90                   	nop
801015cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
801015d0:	8b 06                	mov    (%esi),%eax
801015d2:	e8 89 fd ff ff       	call   80101360 <balloc>
801015d7:	89 43 5c             	mov    %eax,0x5c(%ebx)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801015da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801015dd:	5b                   	pop    %ebx
801015de:	5e                   	pop    %esi
801015df:	5f                   	pop    %edi
801015e0:	5d                   	pop    %ebp
801015e1:	c3                   	ret    
801015e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801015e8:	8b 06                	mov    (%esi),%eax
801015ea:	e8 71 fd ff ff       	call   80101360 <balloc>
801015ef:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801015f5:	eb 87                	jmp    8010157e <bmap+0x3e>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
801015f7:	83 ec 0c             	sub    $0xc,%esp
801015fa:	68 45 73 10 80       	push   $0x80107345
801015ff:	e8 6c ed ff ff       	call   80100370 <panic>
80101604:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010160a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101610 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101610:	55                   	push   %ebp
80101611:	89 e5                	mov    %esp,%ebp
80101613:	56                   	push   %esi
80101614:	53                   	push   %ebx
80101615:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
80101618:	83 ec 08             	sub    $0x8,%esp
8010161b:	6a 01                	push   $0x1
8010161d:	ff 75 08             	pushl  0x8(%ebp)
80101620:	e8 ab ea ff ff       	call   801000d0 <bread>
80101625:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101627:	8d 40 5c             	lea    0x5c(%eax),%eax
8010162a:	83 c4 0c             	add    $0xc,%esp
8010162d:	6a 1c                	push   $0x1c
8010162f:	50                   	push   %eax
80101630:	56                   	push   %esi
80101631:	e8 fa 30 00 00       	call   80104730 <memmove>
  brelse(bp);
80101636:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101639:	83 c4 10             	add    $0x10,%esp
}
8010163c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010163f:	5b                   	pop    %ebx
80101640:	5e                   	pop    %esi
80101641:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
80101642:	e9 99 eb ff ff       	jmp    801001e0 <brelse>
80101647:	89 f6                	mov    %esi,%esi
80101649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101650 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101650:	55                   	push   %ebp
80101651:	89 e5                	mov    %esp,%ebp
80101653:	56                   	push   %esi
80101654:	53                   	push   %ebx
80101655:	89 d3                	mov    %edx,%ebx
80101657:	89 c6                	mov    %eax,%esi
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
80101659:	83 ec 08             	sub    $0x8,%esp
8010165c:	68 60 19 11 80       	push   $0x80111960
80101661:	50                   	push   %eax
80101662:	e8 a9 ff ff ff       	call   80101610 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101667:	58                   	pop    %eax
80101668:	5a                   	pop    %edx
80101669:	89 da                	mov    %ebx,%edx
8010166b:	c1 ea 0c             	shr    $0xc,%edx
8010166e:	03 15 78 19 11 80    	add    0x80111978,%edx
80101674:	52                   	push   %edx
80101675:	56                   	push   %esi
80101676:	e8 55 ea ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010167b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010167d:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101683:	ba 01 00 00 00       	mov    $0x1,%edx
80101688:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
8010168b:	c1 fb 03             	sar    $0x3,%ebx
8010168e:	83 c4 10             	add    $0x10,%esp
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101691:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101693:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101698:	85 d1                	test   %edx,%ecx
8010169a:	74 27                	je     801016c3 <bfree+0x73>
8010169c:	89 c6                	mov    %eax,%esi
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010169e:	f7 d2                	not    %edx
801016a0:	89 c8                	mov    %ecx,%eax
  log_write(bp);
801016a2:	83 ec 0c             	sub    $0xc,%esp
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
801016a5:	21 d0                	and    %edx,%eax
801016a7:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
801016ab:	56                   	push   %esi
801016ac:	e8 df 18 00 00       	call   80102f90 <log_write>
  brelse(bp);
801016b1:	89 34 24             	mov    %esi,(%esp)
801016b4:	e8 27 eb ff ff       	call   801001e0 <brelse>
}
801016b9:	83 c4 10             	add    $0x10,%esp
801016bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016bf:	5b                   	pop    %ebx
801016c0:	5e                   	pop    %esi
801016c1:	5d                   	pop    %ebp
801016c2:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
801016c3:	83 ec 0c             	sub    $0xc,%esp
801016c6:	68 58 73 10 80       	push   $0x80107358
801016cb:	e8 a0 ec ff ff       	call   80100370 <panic>

801016d0 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
801016d0:	55                   	push   %ebp
801016d1:	89 e5                	mov    %esp,%ebp
801016d3:	53                   	push   %ebx
801016d4:	bb c0 19 11 80       	mov    $0x801119c0,%ebx
801016d9:	83 ec 0c             	sub    $0xc,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
801016dc:	68 6b 73 10 80       	push   $0x8010736b
801016e1:	68 80 19 11 80       	push   $0x80111980
801016e6:	e8 25 2d 00 00       	call   80104410 <initlock>
801016eb:	83 c4 10             	add    $0x10,%esp
801016ee:	66 90                	xchg   %ax,%ax
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
801016f0:	83 ec 08             	sub    $0x8,%esp
801016f3:	68 72 73 10 80       	push   $0x80107372
801016f8:	53                   	push   %ebx
801016f9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801016ff:	e8 fc 2b 00 00       	call   80104300 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
80101704:	83 c4 10             	add    $0x10,%esp
80101707:	81 fb e0 35 11 80    	cmp    $0x801135e0,%ebx
8010170d:	75 e1                	jne    801016f0 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }

  readsb(dev, &sb);
8010170f:	83 ec 08             	sub    $0x8,%esp
80101712:	68 60 19 11 80       	push   $0x80111960
80101717:	ff 75 08             	pushl  0x8(%ebp)
8010171a:	e8 f1 fe ff ff       	call   80101610 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010171f:	ff 35 78 19 11 80    	pushl  0x80111978
80101725:	ff 35 74 19 11 80    	pushl  0x80111974
8010172b:	ff 35 70 19 11 80    	pushl  0x80111970
80101731:	ff 35 6c 19 11 80    	pushl  0x8011196c
80101737:	ff 35 68 19 11 80    	pushl  0x80111968
8010173d:	ff 35 64 19 11 80    	pushl  0x80111964
80101743:	ff 35 60 19 11 80    	pushl  0x80111960
80101749:	68 d8 73 10 80       	push   $0x801073d8
8010174e:	e8 2d ef ff ff       	call   80100680 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
80101753:	83 c4 30             	add    $0x30,%esp
80101756:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101759:	c9                   	leave  
8010175a:	c3                   	ret    
8010175b:	90                   	nop
8010175c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101760 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101760:	55                   	push   %ebp
80101761:	89 e5                	mov    %esp,%ebp
80101763:	57                   	push   %edi
80101764:	56                   	push   %esi
80101765:	53                   	push   %ebx
80101766:	83 ec 1c             	sub    $0x1c,%esp
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101769:	83 3d 68 19 11 80 01 	cmpl   $0x1,0x80111968
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101770:	8b 45 0c             	mov    0xc(%ebp),%eax
80101773:	8b 75 08             	mov    0x8(%ebp),%esi
80101776:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101779:	0f 86 91 00 00 00    	jbe    80101810 <ialloc+0xb0>
8010177f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101784:	eb 21                	jmp    801017a7 <ialloc+0x47>
80101786:	8d 76 00             	lea    0x0(%esi),%esi
80101789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101790:	83 ec 0c             	sub    $0xc,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101793:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101796:	57                   	push   %edi
80101797:	e8 44 ea ff ff       	call   801001e0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010179c:	83 c4 10             	add    $0x10,%esp
8010179f:	39 1d 68 19 11 80    	cmp    %ebx,0x80111968
801017a5:	76 69                	jbe    80101810 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
801017a7:	89 d8                	mov    %ebx,%eax
801017a9:	83 ec 08             	sub    $0x8,%esp
801017ac:	c1 e8 03             	shr    $0x3,%eax
801017af:	03 05 74 19 11 80    	add    0x80111974,%eax
801017b5:	50                   	push   %eax
801017b6:	56                   	push   %esi
801017b7:	e8 14 e9 ff ff       	call   801000d0 <bread>
801017bc:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
801017be:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
801017c0:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
801017c3:	83 e0 07             	and    $0x7,%eax
801017c6:	c1 e0 06             	shl    $0x6,%eax
801017c9:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801017cd:	66 83 39 00          	cmpw   $0x0,(%ecx)
801017d1:	75 bd                	jne    80101790 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801017d3:	83 ec 04             	sub    $0x4,%esp
801017d6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801017d9:	6a 40                	push   $0x40
801017db:	6a 00                	push   $0x0
801017dd:	51                   	push   %ecx
801017de:	e8 9d 2e 00 00       	call   80104680 <memset>
      dip->type = type;
801017e3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801017e7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801017ea:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801017ed:	89 3c 24             	mov    %edi,(%esp)
801017f0:	e8 9b 17 00 00       	call   80102f90 <log_write>
      brelse(bp);
801017f5:	89 3c 24             	mov    %edi,(%esp)
801017f8:	e8 e3 e9 ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801017fd:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101800:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
80101803:	89 da                	mov    %ebx,%edx
80101805:	89 f0                	mov    %esi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101807:	5b                   	pop    %ebx
80101808:	5e                   	pop    %esi
80101809:	5f                   	pop    %edi
8010180a:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
8010180b:	e9 60 fc ff ff       	jmp    80101470 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
80101810:	83 ec 0c             	sub    $0xc,%esp
80101813:	68 78 73 10 80       	push   $0x80107378
80101818:	e8 53 eb ff ff       	call   80100370 <panic>
8010181d:	8d 76 00             	lea    0x0(%esi),%esi

80101820 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
80101820:	55                   	push   %ebp
80101821:	89 e5                	mov    %esp,%ebp
80101823:	56                   	push   %esi
80101824:	53                   	push   %ebx
80101825:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101828:	83 ec 08             	sub    $0x8,%esp
8010182b:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010182e:	83 c3 5c             	add    $0x5c,%ebx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101831:	c1 e8 03             	shr    $0x3,%eax
80101834:	03 05 74 19 11 80    	add    0x80111974,%eax
8010183a:	50                   	push   %eax
8010183b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010183e:	e8 8d e8 ff ff       	call   801000d0 <bread>
80101843:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101845:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
80101848:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010184c:	83 c4 0c             	add    $0xc,%esp
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010184f:	83 e0 07             	and    $0x7,%eax
80101852:	c1 e0 06             	shl    $0x6,%eax
80101855:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101859:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010185c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101860:	83 c0 0c             	add    $0xc,%eax
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
80101863:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101867:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010186b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010186f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101873:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101877:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010187a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010187d:	6a 34                	push   $0x34
8010187f:	53                   	push   %ebx
80101880:	50                   	push   %eax
80101881:	e8 aa 2e 00 00       	call   80104730 <memmove>
  log_write(bp);
80101886:	89 34 24             	mov    %esi,(%esp)
80101889:	e8 02 17 00 00       	call   80102f90 <log_write>
  brelse(bp);
8010188e:	89 75 08             	mov    %esi,0x8(%ebp)
80101891:	83 c4 10             	add    $0x10,%esp
}
80101894:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101897:	5b                   	pop    %ebx
80101898:	5e                   	pop    %esi
80101899:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
8010189a:	e9 41 e9 ff ff       	jmp    801001e0 <brelse>
8010189f:	90                   	nop

801018a0 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
801018a0:	55                   	push   %ebp
801018a1:	89 e5                	mov    %esp,%ebp
801018a3:	53                   	push   %ebx
801018a4:	83 ec 10             	sub    $0x10,%esp
801018a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801018aa:	68 80 19 11 80       	push   $0x80111980
801018af:	e8 5c 2c 00 00       	call   80104510 <acquire>
  ip->ref++;
801018b4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801018b8:	c7 04 24 80 19 11 80 	movl   $0x80111980,(%esp)
801018bf:	e8 6c 2d 00 00       	call   80104630 <release>
  return ip;
}
801018c4:	89 d8                	mov    %ebx,%eax
801018c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801018c9:	c9                   	leave  
801018ca:	c3                   	ret    
801018cb:	90                   	nop
801018cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801018d0 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
801018d0:	55                   	push   %ebp
801018d1:	89 e5                	mov    %esp,%ebp
801018d3:	56                   	push   %esi
801018d4:	53                   	push   %ebx
801018d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
801018d8:	85 db                	test   %ebx,%ebx
801018da:	0f 84 b7 00 00 00    	je     80101997 <ilock+0xc7>
801018e0:	8b 53 08             	mov    0x8(%ebx),%edx
801018e3:	85 d2                	test   %edx,%edx
801018e5:	0f 8e ac 00 00 00    	jle    80101997 <ilock+0xc7>
    panic("ilock");

  acquiresleep(&ip->lock);
801018eb:	8d 43 0c             	lea    0xc(%ebx),%eax
801018ee:	83 ec 0c             	sub    $0xc,%esp
801018f1:	50                   	push   %eax
801018f2:	e8 49 2a 00 00       	call   80104340 <acquiresleep>

  if(ip->valid == 0){
801018f7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801018fa:	83 c4 10             	add    $0x10,%esp
801018fd:	85 c0                	test   %eax,%eax
801018ff:	74 0f                	je     80101910 <ilock+0x40>
    brelse(bp);
    ip->valid = 1;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
80101901:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101904:	5b                   	pop    %ebx
80101905:	5e                   	pop    %esi
80101906:	5d                   	pop    %ebp
80101907:	c3                   	ret    
80101908:	90                   	nop
80101909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101910:	8b 43 04             	mov    0x4(%ebx),%eax
80101913:	83 ec 08             	sub    $0x8,%esp
80101916:	c1 e8 03             	shr    $0x3,%eax
80101919:	03 05 74 19 11 80    	add    0x80111974,%eax
8010191f:	50                   	push   %eax
80101920:	ff 33                	pushl  (%ebx)
80101922:	e8 a9 e7 ff ff       	call   801000d0 <bread>
80101927:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101929:	8b 43 04             	mov    0x4(%ebx),%eax
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010192c:	83 c4 0c             	add    $0xc,%esp

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010192f:	83 e0 07             	and    $0x7,%eax
80101932:	c1 e0 06             	shl    $0x6,%eax
80101935:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101939:	0f b7 10             	movzwl (%eax),%edx
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010193c:	83 c0 0c             	add    $0xc,%eax
  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
8010193f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101943:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101947:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010194b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010194f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101953:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101957:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010195b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010195e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101961:	6a 34                	push   $0x34
80101963:	50                   	push   %eax
80101964:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101967:	50                   	push   %eax
80101968:	e8 c3 2d 00 00       	call   80104730 <memmove>
    brelse(bp);
8010196d:	89 34 24             	mov    %esi,(%esp)
80101970:	e8 6b e8 ff ff       	call   801001e0 <brelse>
    ip->valid = 1;
    if(ip->type == 0)
80101975:	83 c4 10             	add    $0x10,%esp
80101978:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    brelse(bp);
    ip->valid = 1;
8010197d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101984:	0f 85 77 ff ff ff    	jne    80101901 <ilock+0x31>
      panic("ilock: no type");
8010198a:	83 ec 0c             	sub    $0xc,%esp
8010198d:	68 90 73 10 80       	push   $0x80107390
80101992:	e8 d9 e9 ff ff       	call   80100370 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
80101997:	83 ec 0c             	sub    $0xc,%esp
8010199a:	68 8a 73 10 80       	push   $0x8010738a
8010199f:	e8 cc e9 ff ff       	call   80100370 <panic>
801019a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801019aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801019b0 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
801019b0:	55                   	push   %ebp
801019b1:	89 e5                	mov    %esp,%ebp
801019b3:	56                   	push   %esi
801019b4:	53                   	push   %ebx
801019b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801019b8:	85 db                	test   %ebx,%ebx
801019ba:	74 28                	je     801019e4 <iunlock+0x34>
801019bc:	8d 73 0c             	lea    0xc(%ebx),%esi
801019bf:	83 ec 0c             	sub    $0xc,%esp
801019c2:	56                   	push   %esi
801019c3:	e8 18 2a 00 00       	call   801043e0 <holdingsleep>
801019c8:	83 c4 10             	add    $0x10,%esp
801019cb:	85 c0                	test   %eax,%eax
801019cd:	74 15                	je     801019e4 <iunlock+0x34>
801019cf:	8b 43 08             	mov    0x8(%ebx),%eax
801019d2:	85 c0                	test   %eax,%eax
801019d4:	7e 0e                	jle    801019e4 <iunlock+0x34>
    panic("iunlock");

  releasesleep(&ip->lock);
801019d6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801019d9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801019dc:	5b                   	pop    %ebx
801019dd:	5e                   	pop    %esi
801019de:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
801019df:	e9 bc 29 00 00       	jmp    801043a0 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
801019e4:	83 ec 0c             	sub    $0xc,%esp
801019e7:	68 9f 73 10 80       	push   $0x8010739f
801019ec:	e8 7f e9 ff ff       	call   80100370 <panic>
801019f1:	eb 0d                	jmp    80101a00 <iput>
801019f3:	90                   	nop
801019f4:	90                   	nop
801019f5:	90                   	nop
801019f6:	90                   	nop
801019f7:	90                   	nop
801019f8:	90                   	nop
801019f9:	90                   	nop
801019fa:	90                   	nop
801019fb:	90                   	nop
801019fc:	90                   	nop
801019fd:	90                   	nop
801019fe:	90                   	nop
801019ff:	90                   	nop

80101a00 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101a00:	55                   	push   %ebp
80101a01:	89 e5                	mov    %esp,%ebp
80101a03:	57                   	push   %edi
80101a04:	56                   	push   %esi
80101a05:	53                   	push   %ebx
80101a06:	83 ec 28             	sub    $0x28,%esp
80101a09:	8b 75 08             	mov    0x8(%ebp),%esi
  acquiresleep(&ip->lock);
80101a0c:	8d 7e 0c             	lea    0xc(%esi),%edi
80101a0f:	57                   	push   %edi
80101a10:	e8 2b 29 00 00       	call   80104340 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101a15:	8b 56 4c             	mov    0x4c(%esi),%edx
80101a18:	83 c4 10             	add    $0x10,%esp
80101a1b:	85 d2                	test   %edx,%edx
80101a1d:	74 07                	je     80101a26 <iput+0x26>
80101a1f:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
80101a24:	74 32                	je     80101a58 <iput+0x58>
      ip->type = 0;
      iupdate(ip);
      ip->valid = 0;
    }
  }
  releasesleep(&ip->lock);
80101a26:	83 ec 0c             	sub    $0xc,%esp
80101a29:	57                   	push   %edi
80101a2a:	e8 71 29 00 00       	call   801043a0 <releasesleep>

  acquire(&icache.lock);
80101a2f:	c7 04 24 80 19 11 80 	movl   $0x80111980,(%esp)
80101a36:	e8 d5 2a 00 00       	call   80104510 <acquire>
  ip->ref--;
80101a3b:	83 6e 08 01          	subl   $0x1,0x8(%esi)
  release(&icache.lock);
80101a3f:	83 c4 10             	add    $0x10,%esp
80101a42:	c7 45 08 80 19 11 80 	movl   $0x80111980,0x8(%ebp)
}
80101a49:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a4c:	5b                   	pop    %ebx
80101a4d:	5e                   	pop    %esi
80101a4e:	5f                   	pop    %edi
80101a4f:	5d                   	pop    %ebp
  }
  releasesleep(&ip->lock);

  acquire(&icache.lock);
  ip->ref--;
  release(&icache.lock);
80101a50:	e9 db 2b 00 00       	jmp    80104630 <release>
80101a55:	8d 76 00             	lea    0x0(%esi),%esi
void
iput(struct inode *ip)
{
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
80101a58:	83 ec 0c             	sub    $0xc,%esp
80101a5b:	68 80 19 11 80       	push   $0x80111980
80101a60:	e8 ab 2a 00 00       	call   80104510 <acquire>
    int r = ip->ref;
80101a65:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
80101a68:	c7 04 24 80 19 11 80 	movl   $0x80111980,(%esp)
80101a6f:	e8 bc 2b 00 00       	call   80104630 <release>
    if(r == 1){
80101a74:	83 c4 10             	add    $0x10,%esp
80101a77:	83 fb 01             	cmp    $0x1,%ebx
80101a7a:	75 aa                	jne    80101a26 <iput+0x26>
80101a7c:	8d 8e 8c 00 00 00    	lea    0x8c(%esi),%ecx
80101a82:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101a85:	8d 5e 5c             	lea    0x5c(%esi),%ebx
80101a88:	89 cf                	mov    %ecx,%edi
80101a8a:	eb 0b                	jmp    80101a97 <iput+0x97>
80101a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101a90:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101a93:	39 fb                	cmp    %edi,%ebx
80101a95:	74 19                	je     80101ab0 <iput+0xb0>
    if(ip->addrs[i]){
80101a97:	8b 13                	mov    (%ebx),%edx
80101a99:	85 d2                	test   %edx,%edx
80101a9b:	74 f3                	je     80101a90 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
80101a9d:	8b 06                	mov    (%esi),%eax
80101a9f:	e8 ac fb ff ff       	call   80101650 <bfree>
      ip->addrs[i] = 0;
80101aa4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80101aaa:	eb e4                	jmp    80101a90 <iput+0x90>
80101aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101ab0:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80101ab6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101ab9:	85 c0                	test   %eax,%eax
80101abb:	75 33                	jne    80101af0 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101abd:	83 ec 0c             	sub    $0xc,%esp
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
80101ac0:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
80101ac7:	56                   	push   %esi
80101ac8:	e8 53 fd ff ff       	call   80101820 <iupdate>
    int r = ip->ref;
    release(&icache.lock);
    if(r == 1){
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
      ip->type = 0;
80101acd:	31 c0                	xor    %eax,%eax
80101acf:	66 89 46 50          	mov    %ax,0x50(%esi)
      iupdate(ip);
80101ad3:	89 34 24             	mov    %esi,(%esp)
80101ad6:	e8 45 fd ff ff       	call   80101820 <iupdate>
      ip->valid = 0;
80101adb:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
80101ae2:	83 c4 10             	add    $0x10,%esp
80101ae5:	e9 3c ff ff ff       	jmp    80101a26 <iput+0x26>
80101aea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101af0:	83 ec 08             	sub    $0x8,%esp
80101af3:	50                   	push   %eax
80101af4:	ff 36                	pushl  (%esi)
80101af6:	e8 d5 e5 ff ff       	call   801000d0 <bread>
80101afb:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101b01:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101b04:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101b07:	8d 58 5c             	lea    0x5c(%eax),%ebx
80101b0a:	83 c4 10             	add    $0x10,%esp
80101b0d:	89 cf                	mov    %ecx,%edi
80101b0f:	eb 0e                	jmp    80101b1f <iput+0x11f>
80101b11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b18:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
80101b1b:	39 fb                	cmp    %edi,%ebx
80101b1d:	74 0f                	je     80101b2e <iput+0x12e>
      if(a[j])
80101b1f:	8b 13                	mov    (%ebx),%edx
80101b21:	85 d2                	test   %edx,%edx
80101b23:	74 f3                	je     80101b18 <iput+0x118>
        bfree(ip->dev, a[j]);
80101b25:	8b 06                	mov    (%esi),%eax
80101b27:	e8 24 fb ff ff       	call   80101650 <bfree>
80101b2c:	eb ea                	jmp    80101b18 <iput+0x118>
    }
    brelse(bp);
80101b2e:	83 ec 0c             	sub    $0xc,%esp
80101b31:	ff 75 e4             	pushl  -0x1c(%ebp)
80101b34:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101b37:	e8 a4 e6 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101b3c:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
80101b42:	8b 06                	mov    (%esi),%eax
80101b44:	e8 07 fb ff ff       	call   80101650 <bfree>
    ip->addrs[NDIRECT] = 0;
80101b49:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
80101b50:	00 00 00 
80101b53:	83 c4 10             	add    $0x10,%esp
80101b56:	e9 62 ff ff ff       	jmp    80101abd <iput+0xbd>
80101b5b:	90                   	nop
80101b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101b60 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101b60:	55                   	push   %ebp
80101b61:	89 e5                	mov    %esp,%ebp
80101b63:	53                   	push   %ebx
80101b64:	83 ec 10             	sub    $0x10,%esp
80101b67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101b6a:	53                   	push   %ebx
80101b6b:	e8 40 fe ff ff       	call   801019b0 <iunlock>
  iput(ip);
80101b70:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101b73:	83 c4 10             	add    $0x10,%esp
}
80101b76:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101b79:	c9                   	leave  
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
80101b7a:	e9 81 fe ff ff       	jmp    80101a00 <iput>
80101b7f:	90                   	nop

80101b80 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101b80:	55                   	push   %ebp
80101b81:	89 e5                	mov    %esp,%ebp
80101b83:	8b 55 08             	mov    0x8(%ebp),%edx
80101b86:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101b89:	8b 0a                	mov    (%edx),%ecx
80101b8b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101b8e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101b91:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101b94:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101b98:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101b9b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101b9f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101ba3:	8b 52 58             	mov    0x58(%edx),%edx
80101ba6:	89 50 10             	mov    %edx,0x10(%eax)
}
80101ba9:	5d                   	pop    %ebp
80101baa:	c3                   	ret    
80101bab:	90                   	nop
80101bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101bb0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101bb0:	55                   	push   %ebp
80101bb1:	89 e5                	mov    %esp,%ebp
80101bb3:	57                   	push   %edi
80101bb4:	56                   	push   %esi
80101bb5:	53                   	push   %ebx
80101bb6:	83 ec 1c             	sub    $0x1c,%esp
80101bb9:	8b 45 08             	mov    0x8(%ebp),%eax
80101bbc:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101bbf:	8b 75 10             	mov    0x10(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101bc2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101bc7:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101bca:	8b 7d 14             	mov    0x14(%ebp),%edi
80101bcd:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101bd0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101bd3:	0f 84 a7 00 00 00    	je     80101c80 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101bd9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bdc:	8b 40 58             	mov    0x58(%eax),%eax
80101bdf:	39 f0                	cmp    %esi,%eax
80101be1:	0f 82 c1 00 00 00    	jb     80101ca8 <readi+0xf8>
80101be7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101bea:	89 fa                	mov    %edi,%edx
80101bec:	01 f2                	add    %esi,%edx
80101bee:	0f 82 b4 00 00 00    	jb     80101ca8 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101bf4:	89 c1                	mov    %eax,%ecx
80101bf6:	29 f1                	sub    %esi,%ecx
80101bf8:	39 d0                	cmp    %edx,%eax
80101bfa:	0f 43 cf             	cmovae %edi,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101bfd:	31 ff                	xor    %edi,%edi
80101bff:	85 c9                	test   %ecx,%ecx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101c01:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c04:	74 6d                	je     80101c73 <readi+0xc3>
80101c06:	8d 76 00             	lea    0x0(%esi),%esi
80101c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c10:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101c13:	89 f2                	mov    %esi,%edx
80101c15:	c1 ea 09             	shr    $0x9,%edx
80101c18:	89 d8                	mov    %ebx,%eax
80101c1a:	e8 21 f9 ff ff       	call   80101540 <bmap>
80101c1f:	83 ec 08             	sub    $0x8,%esp
80101c22:	50                   	push   %eax
80101c23:	ff 33                	pushl  (%ebx)
    m = min(n - tot, BSIZE - off%BSIZE);
80101c25:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c2a:	e8 a1 e4 ff ff       	call   801000d0 <bread>
80101c2f:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101c31:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101c34:	89 f1                	mov    %esi,%ecx
80101c36:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101c3c:	83 c4 0c             	add    $0xc,%esp
    memmove(dst, bp->data + off%BSIZE, m);
80101c3f:	89 55 dc             	mov    %edx,-0x24(%ebp)
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101c42:	29 cb                	sub    %ecx,%ebx
80101c44:	29 f8                	sub    %edi,%eax
80101c46:	39 c3                	cmp    %eax,%ebx
80101c48:	0f 47 d8             	cmova  %eax,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101c4b:	8d 44 0a 5c          	lea    0x5c(%edx,%ecx,1),%eax
80101c4f:	53                   	push   %ebx
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c50:	01 df                	add    %ebx,%edi
80101c52:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
80101c54:	50                   	push   %eax
80101c55:	ff 75 e0             	pushl  -0x20(%ebp)
80101c58:	e8 d3 2a 00 00       	call   80104730 <memmove>
    brelse(bp);
80101c5d:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101c60:	89 14 24             	mov    %edx,(%esp)
80101c63:	e8 78 e5 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c68:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101c6b:	83 c4 10             	add    $0x10,%esp
80101c6e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101c71:	77 9d                	ja     80101c10 <readi+0x60>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101c73:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101c76:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c79:	5b                   	pop    %ebx
80101c7a:	5e                   	pop    %esi
80101c7b:	5f                   	pop    %edi
80101c7c:	5d                   	pop    %ebp
80101c7d:	c3                   	ret    
80101c7e:	66 90                	xchg   %ax,%ax
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101c80:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101c84:	66 83 f8 09          	cmp    $0x9,%ax
80101c88:	77 1e                	ja     80101ca8 <readi+0xf8>
80101c8a:	8b 04 c5 00 19 11 80 	mov    -0x7feee700(,%eax,8),%eax
80101c91:	85 c0                	test   %eax,%eax
80101c93:	74 13                	je     80101ca8 <readi+0xf8>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101c95:	89 7d 10             	mov    %edi,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
80101c98:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c9b:	5b                   	pop    %ebx
80101c9c:	5e                   	pop    %esi
80101c9d:	5f                   	pop    %edi
80101c9e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101c9f:	ff e0                	jmp    *%eax
80101ca1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101ca8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101cad:	eb c7                	jmp    80101c76 <readi+0xc6>
80101caf:	90                   	nop

80101cb0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101cb0:	55                   	push   %ebp
80101cb1:	89 e5                	mov    %esp,%ebp
80101cb3:	57                   	push   %edi
80101cb4:	56                   	push   %esi
80101cb5:	53                   	push   %ebx
80101cb6:	83 ec 1c             	sub    $0x1c,%esp
80101cb9:	8b 45 08             	mov    0x8(%ebp),%eax
80101cbc:	8b 75 0c             	mov    0xc(%ebp),%esi
80101cbf:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101cc2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101cc7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101cca:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101ccd:	8b 75 10             	mov    0x10(%ebp),%esi
80101cd0:	89 7d e0             	mov    %edi,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101cd3:	0f 84 b7 00 00 00    	je     80101d90 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101cd9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101cdc:	39 70 58             	cmp    %esi,0x58(%eax)
80101cdf:	0f 82 eb 00 00 00    	jb     80101dd0 <writei+0x120>
80101ce5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101ce8:	89 f8                	mov    %edi,%eax
80101cea:	01 f0                	add    %esi,%eax
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101cec:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101cf1:	0f 87 d9 00 00 00    	ja     80101dd0 <writei+0x120>
80101cf7:	39 c6                	cmp    %eax,%esi
80101cf9:	0f 87 d1 00 00 00    	ja     80101dd0 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101cff:	85 ff                	test   %edi,%edi
80101d01:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101d08:	74 78                	je     80101d82 <writei+0xd2>
80101d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101d10:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101d13:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101d15:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101d1a:	c1 ea 09             	shr    $0x9,%edx
80101d1d:	89 f8                	mov    %edi,%eax
80101d1f:	e8 1c f8 ff ff       	call   80101540 <bmap>
80101d24:	83 ec 08             	sub    $0x8,%esp
80101d27:	50                   	push   %eax
80101d28:	ff 37                	pushl  (%edi)
80101d2a:	e8 a1 e3 ff ff       	call   801000d0 <bread>
80101d2f:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101d31:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101d34:	2b 45 e4             	sub    -0x1c(%ebp),%eax
80101d37:	89 f1                	mov    %esi,%ecx
80101d39:	83 c4 0c             	add    $0xc,%esp
80101d3c:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101d42:	29 cb                	sub    %ecx,%ebx
80101d44:	39 c3                	cmp    %eax,%ebx
80101d46:	0f 47 d8             	cmova  %eax,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101d49:	8d 44 0f 5c          	lea    0x5c(%edi,%ecx,1),%eax
80101d4d:	53                   	push   %ebx
80101d4e:	ff 75 dc             	pushl  -0x24(%ebp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101d51:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
80101d53:	50                   	push   %eax
80101d54:	e8 d7 29 00 00       	call   80104730 <memmove>
    log_write(bp);
80101d59:	89 3c 24             	mov    %edi,(%esp)
80101d5c:	e8 2f 12 00 00       	call   80102f90 <log_write>
    brelse(bp);
80101d61:	89 3c 24             	mov    %edi,(%esp)
80101d64:	e8 77 e4 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101d69:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101d6c:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101d6f:	83 c4 10             	add    $0x10,%esp
80101d72:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101d75:	39 55 e0             	cmp    %edx,-0x20(%ebp)
80101d78:	77 96                	ja     80101d10 <writei+0x60>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80101d7a:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101d7d:	3b 70 58             	cmp    0x58(%eax),%esi
80101d80:	77 36                	ja     80101db8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101d82:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101d85:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d88:	5b                   	pop    %ebx
80101d89:	5e                   	pop    %esi
80101d8a:	5f                   	pop    %edi
80101d8b:	5d                   	pop    %ebp
80101d8c:	c3                   	ret    
80101d8d:	8d 76 00             	lea    0x0(%esi),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101d90:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101d94:	66 83 f8 09          	cmp    $0x9,%ax
80101d98:	77 36                	ja     80101dd0 <writei+0x120>
80101d9a:	8b 04 c5 04 19 11 80 	mov    -0x7feee6fc(,%eax,8),%eax
80101da1:	85 c0                	test   %eax,%eax
80101da3:	74 2b                	je     80101dd0 <writei+0x120>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101da5:	89 7d 10             	mov    %edi,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101da8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dab:	5b                   	pop    %ebx
80101dac:	5e                   	pop    %esi
80101dad:	5f                   	pop    %edi
80101dae:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101daf:	ff e0                	jmp    *%eax
80101db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101db8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101dbb:	83 ec 0c             	sub    $0xc,%esp
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101dbe:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101dc1:	50                   	push   %eax
80101dc2:	e8 59 fa ff ff       	call   80101820 <iupdate>
80101dc7:	83 c4 10             	add    $0x10,%esp
80101dca:	eb b6                	jmp    80101d82 <writei+0xd2>
80101dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101dd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101dd5:	eb ae                	jmp    80101d85 <writei+0xd5>
80101dd7:	89 f6                	mov    %esi,%esi
80101dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101de0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101de0:	55                   	push   %ebp
80101de1:	89 e5                	mov    %esp,%ebp
80101de3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101de6:	6a 0e                	push   $0xe
80101de8:	ff 75 0c             	pushl  0xc(%ebp)
80101deb:	ff 75 08             	pushl  0x8(%ebp)
80101dee:	e8 bd 29 00 00       	call   801047b0 <strncmp>
}
80101df3:	c9                   	leave  
80101df4:	c3                   	ret    
80101df5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101e00 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101e00:	55                   	push   %ebp
80101e01:	89 e5                	mov    %esp,%ebp
80101e03:	57                   	push   %edi
80101e04:	56                   	push   %esi
80101e05:	53                   	push   %ebx
80101e06:	83 ec 1c             	sub    $0x1c,%esp
80101e09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101e0c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101e11:	0f 85 80 00 00 00    	jne    80101e97 <dirlookup+0x97>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101e17:	8b 53 58             	mov    0x58(%ebx),%edx
80101e1a:	31 ff                	xor    %edi,%edi
80101e1c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e1f:	85 d2                	test   %edx,%edx
80101e21:	75 0d                	jne    80101e30 <dirlookup+0x30>
80101e23:	eb 5b                	jmp    80101e80 <dirlookup+0x80>
80101e25:	8d 76 00             	lea    0x0(%esi),%esi
80101e28:	83 c7 10             	add    $0x10,%edi
80101e2b:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101e2e:	76 50                	jbe    80101e80 <dirlookup+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e30:	6a 10                	push   $0x10
80101e32:	57                   	push   %edi
80101e33:	56                   	push   %esi
80101e34:	53                   	push   %ebx
80101e35:	e8 76 fd ff ff       	call   80101bb0 <readi>
80101e3a:	83 c4 10             	add    $0x10,%esp
80101e3d:	83 f8 10             	cmp    $0x10,%eax
80101e40:	75 48                	jne    80101e8a <dirlookup+0x8a>
      panic("dirlookup read");
    if(de.inum == 0)
80101e42:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e47:	74 df                	je     80101e28 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
80101e49:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e4c:	83 ec 04             	sub    $0x4,%esp
80101e4f:	6a 0e                	push   $0xe
80101e51:	50                   	push   %eax
80101e52:	ff 75 0c             	pushl  0xc(%ebp)
80101e55:	e8 56 29 00 00       	call   801047b0 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80101e5a:	83 c4 10             	add    $0x10,%esp
80101e5d:	85 c0                	test   %eax,%eax
80101e5f:	75 c7                	jne    80101e28 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101e61:	8b 45 10             	mov    0x10(%ebp),%eax
80101e64:	85 c0                	test   %eax,%eax
80101e66:	74 05                	je     80101e6d <dirlookup+0x6d>
        *poff = off;
80101e68:	8b 45 10             	mov    0x10(%ebp),%eax
80101e6b:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
      return iget(dp->dev, inum);
80101e6d:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80101e71:	8b 03                	mov    (%ebx),%eax
80101e73:	e8 f8 f5 ff ff       	call   80101470 <iget>
    }
  }

  return 0;
}
80101e78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e7b:	5b                   	pop    %ebx
80101e7c:	5e                   	pop    %esi
80101e7d:	5f                   	pop    %edi
80101e7e:	5d                   	pop    %ebp
80101e7f:	c3                   	ret    
80101e80:	8d 65 f4             	lea    -0xc(%ebp),%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101e83:	31 c0                	xor    %eax,%eax
}
80101e85:	5b                   	pop    %ebx
80101e86:	5e                   	pop    %esi
80101e87:	5f                   	pop    %edi
80101e88:	5d                   	pop    %ebp
80101e89:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
80101e8a:	83 ec 0c             	sub    $0xc,%esp
80101e8d:	68 b9 73 10 80       	push   $0x801073b9
80101e92:	e8 d9 e4 ff ff       	call   80100370 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101e97:	83 ec 0c             	sub    $0xc,%esp
80101e9a:	68 a7 73 10 80       	push   $0x801073a7
80101e9f:	e8 cc e4 ff ff       	call   80100370 <panic>
80101ea4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101eaa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101eb0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101eb0:	55                   	push   %ebp
80101eb1:	89 e5                	mov    %esp,%ebp
80101eb3:	57                   	push   %edi
80101eb4:	56                   	push   %esi
80101eb5:	53                   	push   %ebx
80101eb6:	89 cf                	mov    %ecx,%edi
80101eb8:	89 c3                	mov    %eax,%ebx
80101eba:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101ebd:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101ec0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101ec3:	0f 84 53 01 00 00    	je     8010201c <namex+0x16c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101ec9:	e8 12 1b 00 00       	call   801039e0 <myproc>
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101ece:	83 ec 0c             	sub    $0xc,%esp
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101ed1:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101ed4:	68 80 19 11 80       	push   $0x80111980
80101ed9:	e8 32 26 00 00       	call   80104510 <acquire>
  ip->ref++;
80101ede:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101ee2:	c7 04 24 80 19 11 80 	movl   $0x80111980,(%esp)
80101ee9:	e8 42 27 00 00       	call   80104630 <release>
80101eee:	83 c4 10             	add    $0x10,%esp
80101ef1:	eb 08                	jmp    80101efb <namex+0x4b>
80101ef3:	90                   	nop
80101ef4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101ef8:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101efb:	0f b6 03             	movzbl (%ebx),%eax
80101efe:	3c 2f                	cmp    $0x2f,%al
80101f00:	74 f6                	je     80101ef8 <namex+0x48>
    path++;
  if(*path == 0)
80101f02:	84 c0                	test   %al,%al
80101f04:	0f 84 e3 00 00 00    	je     80101fed <namex+0x13d>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101f0a:	0f b6 03             	movzbl (%ebx),%eax
80101f0d:	89 da                	mov    %ebx,%edx
80101f0f:	84 c0                	test   %al,%al
80101f11:	0f 84 ac 00 00 00    	je     80101fc3 <namex+0x113>
80101f17:	3c 2f                	cmp    $0x2f,%al
80101f19:	75 09                	jne    80101f24 <namex+0x74>
80101f1b:	e9 a3 00 00 00       	jmp    80101fc3 <namex+0x113>
80101f20:	84 c0                	test   %al,%al
80101f22:	74 0a                	je     80101f2e <namex+0x7e>
    path++;
80101f24:	83 c2 01             	add    $0x1,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101f27:	0f b6 02             	movzbl (%edx),%eax
80101f2a:	3c 2f                	cmp    $0x2f,%al
80101f2c:	75 f2                	jne    80101f20 <namex+0x70>
80101f2e:	89 d1                	mov    %edx,%ecx
80101f30:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101f32:	83 f9 0d             	cmp    $0xd,%ecx
80101f35:	0f 8e 8d 00 00 00    	jle    80101fc8 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101f3b:	83 ec 04             	sub    $0x4,%esp
80101f3e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101f41:	6a 0e                	push   $0xe
80101f43:	53                   	push   %ebx
80101f44:	57                   	push   %edi
80101f45:	e8 e6 27 00 00       	call   80104730 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101f4a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
80101f4d:	83 c4 10             	add    $0x10,%esp
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101f50:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101f52:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101f55:	75 11                	jne    80101f68 <namex+0xb8>
80101f57:	89 f6                	mov    %esi,%esi
80101f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101f60:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101f63:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101f66:	74 f8                	je     80101f60 <namex+0xb0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101f68:	83 ec 0c             	sub    $0xc,%esp
80101f6b:	56                   	push   %esi
80101f6c:	e8 5f f9 ff ff       	call   801018d0 <ilock>
    if(ip->type != T_DIR){
80101f71:	83 c4 10             	add    $0x10,%esp
80101f74:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101f79:	0f 85 7f 00 00 00    	jne    80101ffe <namex+0x14e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101f7f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101f82:	85 d2                	test   %edx,%edx
80101f84:	74 09                	je     80101f8f <namex+0xdf>
80101f86:	80 3b 00             	cmpb   $0x0,(%ebx)
80101f89:	0f 84 a3 00 00 00    	je     80102032 <namex+0x182>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101f8f:	83 ec 04             	sub    $0x4,%esp
80101f92:	6a 00                	push   $0x0
80101f94:	57                   	push   %edi
80101f95:	56                   	push   %esi
80101f96:	e8 65 fe ff ff       	call   80101e00 <dirlookup>
80101f9b:	83 c4 10             	add    $0x10,%esp
80101f9e:	85 c0                	test   %eax,%eax
80101fa0:	74 5c                	je     80101ffe <namex+0x14e>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101fa2:	83 ec 0c             	sub    $0xc,%esp
80101fa5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101fa8:	56                   	push   %esi
80101fa9:	e8 02 fa ff ff       	call   801019b0 <iunlock>
  iput(ip);
80101fae:	89 34 24             	mov    %esi,(%esp)
80101fb1:	e8 4a fa ff ff       	call   80101a00 <iput>
80101fb6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101fb9:	83 c4 10             	add    $0x10,%esp
80101fbc:	89 c6                	mov    %eax,%esi
80101fbe:	e9 38 ff ff ff       	jmp    80101efb <namex+0x4b>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101fc3:	31 c9                	xor    %ecx,%ecx
80101fc5:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101fc8:	83 ec 04             	sub    $0x4,%esp
80101fcb:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101fce:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101fd1:	51                   	push   %ecx
80101fd2:	53                   	push   %ebx
80101fd3:	57                   	push   %edi
80101fd4:	e8 57 27 00 00       	call   80104730 <memmove>
    name[len] = 0;
80101fd9:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101fdc:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101fdf:	83 c4 10             	add    $0x10,%esp
80101fe2:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101fe6:	89 d3                	mov    %edx,%ebx
80101fe8:	e9 65 ff ff ff       	jmp    80101f52 <namex+0xa2>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101fed:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101ff0:	85 c0                	test   %eax,%eax
80101ff2:	75 54                	jne    80102048 <namex+0x198>
80101ff4:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101ff6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ff9:	5b                   	pop    %ebx
80101ffa:	5e                   	pop    %esi
80101ffb:	5f                   	pop    %edi
80101ffc:	5d                   	pop    %ebp
80101ffd:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101ffe:	83 ec 0c             	sub    $0xc,%esp
80102001:	56                   	push   %esi
80102002:	e8 a9 f9 ff ff       	call   801019b0 <iunlock>
  iput(ip);
80102007:	89 34 24             	mov    %esi,(%esp)
8010200a:	e8 f1 f9 ff ff       	call   80101a00 <iput>
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
8010200f:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80102012:	8d 65 f4             	lea    -0xc(%ebp),%esp
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80102015:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80102017:	5b                   	pop    %ebx
80102018:	5e                   	pop    %esi
80102019:	5f                   	pop    %edi
8010201a:	5d                   	pop    %ebp
8010201b:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
8010201c:	ba 01 00 00 00       	mov    $0x1,%edx
80102021:	b8 01 00 00 00       	mov    $0x1,%eax
80102026:	e8 45 f4 ff ff       	call   80101470 <iget>
8010202b:	89 c6                	mov    %eax,%esi
8010202d:	e9 c9 fe ff ff       	jmp    80101efb <namex+0x4b>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80102032:	83 ec 0c             	sub    $0xc,%esp
80102035:	56                   	push   %esi
80102036:	e8 75 f9 ff ff       	call   801019b0 <iunlock>
      return ip;
8010203b:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
8010203e:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
      return ip;
80102041:	89 f0                	mov    %esi,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80102043:	5b                   	pop    %ebx
80102044:	5e                   	pop    %esi
80102045:	5f                   	pop    %edi
80102046:	5d                   	pop    %ebp
80102047:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80102048:	83 ec 0c             	sub    $0xc,%esp
8010204b:	56                   	push   %esi
8010204c:	e8 af f9 ff ff       	call   80101a00 <iput>
    return 0;
80102051:	83 c4 10             	add    $0x10,%esp
80102054:	31 c0                	xor    %eax,%eax
80102056:	eb 9e                	jmp    80101ff6 <namex+0x146>
80102058:	90                   	nop
80102059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102060 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80102060:	55                   	push   %ebp
80102061:	89 e5                	mov    %esp,%ebp
80102063:	57                   	push   %edi
80102064:	56                   	push   %esi
80102065:	53                   	push   %ebx
80102066:	83 ec 20             	sub    $0x20,%esp
80102069:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
8010206c:	6a 00                	push   $0x0
8010206e:	ff 75 0c             	pushl  0xc(%ebp)
80102071:	53                   	push   %ebx
80102072:	e8 89 fd ff ff       	call   80101e00 <dirlookup>
80102077:	83 c4 10             	add    $0x10,%esp
8010207a:	85 c0                	test   %eax,%eax
8010207c:	75 67                	jne    801020e5 <dirlink+0x85>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
8010207e:	8b 7b 58             	mov    0x58(%ebx),%edi
80102081:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102084:	85 ff                	test   %edi,%edi
80102086:	74 29                	je     801020b1 <dirlink+0x51>
80102088:	31 ff                	xor    %edi,%edi
8010208a:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010208d:	eb 09                	jmp    80102098 <dirlink+0x38>
8010208f:	90                   	nop
80102090:	83 c7 10             	add    $0x10,%edi
80102093:	39 7b 58             	cmp    %edi,0x58(%ebx)
80102096:	76 19                	jbe    801020b1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102098:	6a 10                	push   $0x10
8010209a:	57                   	push   %edi
8010209b:	56                   	push   %esi
8010209c:	53                   	push   %ebx
8010209d:	e8 0e fb ff ff       	call   80101bb0 <readi>
801020a2:	83 c4 10             	add    $0x10,%esp
801020a5:	83 f8 10             	cmp    $0x10,%eax
801020a8:	75 4e                	jne    801020f8 <dirlink+0x98>
      panic("dirlink read");
    if(de.inum == 0)
801020aa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801020af:	75 df                	jne    80102090 <dirlink+0x30>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
801020b1:	8d 45 da             	lea    -0x26(%ebp),%eax
801020b4:	83 ec 04             	sub    $0x4,%esp
801020b7:	6a 0e                	push   $0xe
801020b9:	ff 75 0c             	pushl  0xc(%ebp)
801020bc:	50                   	push   %eax
801020bd:	e8 5e 27 00 00       	call   80104820 <strncpy>
  de.inum = inum;
801020c2:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801020c5:	6a 10                	push   $0x10
801020c7:	57                   	push   %edi
801020c8:	56                   	push   %esi
801020c9:	53                   	push   %ebx
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
801020ca:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801020ce:	e8 dd fb ff ff       	call   80101cb0 <writei>
801020d3:	83 c4 20             	add    $0x20,%esp
801020d6:	83 f8 10             	cmp    $0x10,%eax
801020d9:	75 2a                	jne    80102105 <dirlink+0xa5>
    panic("dirlink");

  return 0;
801020db:	31 c0                	xor    %eax,%eax
}
801020dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020e0:	5b                   	pop    %ebx
801020e1:	5e                   	pop    %esi
801020e2:	5f                   	pop    %edi
801020e3:	5d                   	pop    %ebp
801020e4:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
801020e5:	83 ec 0c             	sub    $0xc,%esp
801020e8:	50                   	push   %eax
801020e9:	e8 12 f9 ff ff       	call   80101a00 <iput>
    return -1;
801020ee:	83 c4 10             	add    $0x10,%esp
801020f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801020f6:	eb e5                	jmp    801020dd <dirlink+0x7d>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
801020f8:	83 ec 0c             	sub    $0xc,%esp
801020fb:	68 c8 73 10 80       	push   $0x801073c8
80102100:	e8 6b e2 ff ff       	call   80100370 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80102105:	83 ec 0c             	sub    $0xc,%esp
80102108:	68 ce 79 10 80       	push   $0x801079ce
8010210d:	e8 5e e2 ff ff       	call   80100370 <panic>
80102112:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102120 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80102120:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102121:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80102123:	89 e5                	mov    %esp,%ebp
80102125:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102128:	8b 45 08             	mov    0x8(%ebp),%eax
8010212b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010212e:	e8 7d fd ff ff       	call   80101eb0 <namex>
}
80102133:	c9                   	leave  
80102134:	c3                   	ret    
80102135:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102140 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102140:	55                   	push   %ebp
  return namex(path, 1, name);
80102141:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80102146:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102148:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010214b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010214e:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
8010214f:	e9 5c fd ff ff       	jmp    80101eb0 <namex>
80102154:	66 90                	xchg   %ax,%ax
80102156:	66 90                	xchg   %ax,%ax
80102158:	66 90                	xchg   %ax,%ax
8010215a:	66 90                	xchg   %ax,%ax
8010215c:	66 90                	xchg   %ax,%ax
8010215e:	66 90                	xchg   %ax,%ax

80102160 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102160:	55                   	push   %ebp
  if(b == 0)
80102161:	85 c0                	test   %eax,%eax
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102163:	89 e5                	mov    %esp,%ebp
80102165:	56                   	push   %esi
80102166:	53                   	push   %ebx
  if(b == 0)
80102167:	0f 84 ad 00 00 00    	je     8010221a <idestart+0xba>
    panic("idestart");
  if(b->blockno >= FSSIZE)
8010216d:	8b 58 08             	mov    0x8(%eax),%ebx
80102170:	89 c1                	mov    %eax,%ecx
80102172:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80102178:	0f 87 8f 00 00 00    	ja     8010220d <idestart+0xad>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010217e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102183:	90                   	nop
80102184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102188:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102189:	83 e0 c0             	and    $0xffffffc0,%eax
8010218c:	3c 40                	cmp    $0x40,%al
8010218e:	75 f8                	jne    80102188 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102190:	31 f6                	xor    %esi,%esi
80102192:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102197:	89 f0                	mov    %esi,%eax
80102199:	ee                   	out    %al,(%dx)
8010219a:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010219f:	b8 01 00 00 00       	mov    $0x1,%eax
801021a4:	ee                   	out    %al,(%dx)
801021a5:	ba f3 01 00 00       	mov    $0x1f3,%edx
801021aa:	89 d8                	mov    %ebx,%eax
801021ac:	ee                   	out    %al,(%dx)
801021ad:	89 d8                	mov    %ebx,%eax
801021af:	ba f4 01 00 00       	mov    $0x1f4,%edx
801021b4:	c1 f8 08             	sar    $0x8,%eax
801021b7:	ee                   	out    %al,(%dx)
801021b8:	ba f5 01 00 00       	mov    $0x1f5,%edx
801021bd:	89 f0                	mov    %esi,%eax
801021bf:	ee                   	out    %al,(%dx)
801021c0:	0f b6 41 04          	movzbl 0x4(%ecx),%eax
801021c4:	ba f6 01 00 00       	mov    $0x1f6,%edx
801021c9:	83 e0 01             	and    $0x1,%eax
801021cc:	c1 e0 04             	shl    $0x4,%eax
801021cf:	83 c8 e0             	or     $0xffffffe0,%eax
801021d2:	ee                   	out    %al,(%dx)
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
801021d3:	f6 01 04             	testb  $0x4,(%ecx)
801021d6:	ba f7 01 00 00       	mov    $0x1f7,%edx
801021db:	75 13                	jne    801021f0 <idestart+0x90>
801021dd:	b8 20 00 00 00       	mov    $0x20,%eax
801021e2:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
801021e3:	8d 65 f8             	lea    -0x8(%ebp),%esp
801021e6:	5b                   	pop    %ebx
801021e7:	5e                   	pop    %esi
801021e8:	5d                   	pop    %ebp
801021e9:	c3                   	ret    
801021ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801021f0:	b8 30 00 00 00       	mov    $0x30,%eax
801021f5:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
801021f6:	ba f0 01 00 00       	mov    $0x1f0,%edx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
801021fb:	8d 71 5c             	lea    0x5c(%ecx),%esi
801021fe:	b9 80 00 00 00       	mov    $0x80,%ecx
80102203:	fc                   	cld    
80102204:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102206:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102209:	5b                   	pop    %ebx
8010220a:	5e                   	pop    %esi
8010220b:	5d                   	pop    %ebp
8010220c:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
8010220d:	83 ec 0c             	sub    $0xc,%esp
80102210:	68 34 74 10 80       	push   $0x80107434
80102215:	e8 56 e1 ff ff       	call   80100370 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
8010221a:	83 ec 0c             	sub    $0xc,%esp
8010221d:	68 2b 74 10 80       	push   $0x8010742b
80102222:	e8 49 e1 ff ff       	call   80100370 <panic>
80102227:	89 f6                	mov    %esi,%esi
80102229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102230 <ideinit>:
  return 0;
}

void
ideinit(void)
{
80102230:	55                   	push   %ebp
80102231:	89 e5                	mov    %esp,%ebp
80102233:	83 ec 10             	sub    $0x10,%esp
  int i;

  initlock(&idelock, "ide");
80102236:	68 46 74 10 80       	push   $0x80107446
8010223b:	68 20 b5 10 80       	push   $0x8010b520
80102240:	e8 cb 21 00 00       	call   80104410 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102245:	58                   	pop    %eax
80102246:	a1 a0 3c 11 80       	mov    0x80113ca0,%eax
8010224b:	5a                   	pop    %edx
8010224c:	83 e8 01             	sub    $0x1,%eax
8010224f:	50                   	push   %eax
80102250:	6a 0e                	push   $0xe
80102252:	e8 a9 02 00 00       	call   80102500 <ioapicenable>
80102257:	83 c4 10             	add    $0x10,%esp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010225a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010225f:	90                   	nop
80102260:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102261:	83 e0 c0             	and    $0xffffffc0,%eax
80102264:	3c 40                	cmp    $0x40,%al
80102266:	75 f8                	jne    80102260 <ideinit+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102268:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010226d:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102272:	ee                   	out    %al,(%dx)
80102273:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102278:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010227d:	eb 06                	jmp    80102285 <ideinit+0x55>
8010227f:	90                   	nop
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102280:	83 e9 01             	sub    $0x1,%ecx
80102283:	74 0f                	je     80102294 <ideinit+0x64>
80102285:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102286:	84 c0                	test   %al,%al
80102288:	74 f6                	je     80102280 <ideinit+0x50>
      havedisk1 = 1;
8010228a:	c7 05 00 b5 10 80 01 	movl   $0x1,0x8010b500
80102291:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102294:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102299:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
8010229e:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
8010229f:	c9                   	leave  
801022a0:	c3                   	ret    
801022a1:	eb 0d                	jmp    801022b0 <ideintr>
801022a3:	90                   	nop
801022a4:	90                   	nop
801022a5:	90                   	nop
801022a6:	90                   	nop
801022a7:	90                   	nop
801022a8:	90                   	nop
801022a9:	90                   	nop
801022aa:	90                   	nop
801022ab:	90                   	nop
801022ac:	90                   	nop
801022ad:	90                   	nop
801022ae:	90                   	nop
801022af:	90                   	nop

801022b0 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
801022b0:	55                   	push   %ebp
801022b1:	89 e5                	mov    %esp,%ebp
801022b3:	57                   	push   %edi
801022b4:	56                   	push   %esi
801022b5:	53                   	push   %ebx
801022b6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801022b9:	68 20 b5 10 80       	push   $0x8010b520
801022be:	e8 4d 22 00 00       	call   80104510 <acquire>

  if((b = idequeue) == 0){
801022c3:	8b 1d 04 b5 10 80    	mov    0x8010b504,%ebx
801022c9:	83 c4 10             	add    $0x10,%esp
801022cc:	85 db                	test   %ebx,%ebx
801022ce:	74 34                	je     80102304 <ideintr+0x54>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801022d0:	8b 43 58             	mov    0x58(%ebx),%eax
801022d3:	a3 04 b5 10 80       	mov    %eax,0x8010b504

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801022d8:	8b 33                	mov    (%ebx),%esi
801022da:	f7 c6 04 00 00 00    	test   $0x4,%esi
801022e0:	74 3e                	je     80102320 <ideintr+0x70>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801022e2:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801022e5:	83 ec 0c             	sub    $0xc,%esp
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801022e8:	83 ce 02             	or     $0x2,%esi
801022eb:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801022ed:	53                   	push   %ebx
801022ee:	e8 5d 1e 00 00       	call   80104150 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801022f3:	a1 04 b5 10 80       	mov    0x8010b504,%eax
801022f8:	83 c4 10             	add    $0x10,%esp
801022fb:	85 c0                	test   %eax,%eax
801022fd:	74 05                	je     80102304 <ideintr+0x54>
    idestart(idequeue);
801022ff:	e8 5c fe ff ff       	call   80102160 <idestart>

  // First queued buffer is the active request.
  acquire(&idelock);

  if((b = idequeue) == 0){
    release(&idelock);
80102304:	83 ec 0c             	sub    $0xc,%esp
80102307:	68 20 b5 10 80       	push   $0x8010b520
8010230c:	e8 1f 23 00 00       	call   80104630 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
80102311:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102314:	5b                   	pop    %ebx
80102315:	5e                   	pop    %esi
80102316:	5f                   	pop    %edi
80102317:	5d                   	pop    %ebp
80102318:	c3                   	ret    
80102319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102320:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102325:	8d 76 00             	lea    0x0(%esi),%esi
80102328:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102329:	89 c1                	mov    %eax,%ecx
8010232b:	83 e1 c0             	and    $0xffffffc0,%ecx
8010232e:	80 f9 40             	cmp    $0x40,%cl
80102331:	75 f5                	jne    80102328 <ideintr+0x78>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102333:	a8 21                	test   $0x21,%al
80102335:	75 ab                	jne    801022e2 <ideintr+0x32>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
80102337:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
8010233a:	b9 80 00 00 00       	mov    $0x80,%ecx
8010233f:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102344:	fc                   	cld    
80102345:	f3 6d                	rep insl (%dx),%es:(%edi)
80102347:	8b 33                	mov    (%ebx),%esi
80102349:	eb 97                	jmp    801022e2 <ideintr+0x32>
8010234b:	90                   	nop
8010234c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102350 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102350:	55                   	push   %ebp
80102351:	89 e5                	mov    %esp,%ebp
80102353:	53                   	push   %ebx
80102354:	83 ec 10             	sub    $0x10,%esp
80102357:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010235a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010235d:	50                   	push   %eax
8010235e:	e8 7d 20 00 00       	call   801043e0 <holdingsleep>
80102363:	83 c4 10             	add    $0x10,%esp
80102366:	85 c0                	test   %eax,%eax
80102368:	0f 84 ad 00 00 00    	je     8010241b <iderw+0xcb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010236e:	8b 03                	mov    (%ebx),%eax
80102370:	83 e0 06             	and    $0x6,%eax
80102373:	83 f8 02             	cmp    $0x2,%eax
80102376:	0f 84 b9 00 00 00    	je     80102435 <iderw+0xe5>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010237c:	8b 53 04             	mov    0x4(%ebx),%edx
8010237f:	85 d2                	test   %edx,%edx
80102381:	74 0d                	je     80102390 <iderw+0x40>
80102383:	a1 00 b5 10 80       	mov    0x8010b500,%eax
80102388:	85 c0                	test   %eax,%eax
8010238a:	0f 84 98 00 00 00    	je     80102428 <iderw+0xd8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102390:	83 ec 0c             	sub    $0xc,%esp
80102393:	68 20 b5 10 80       	push   $0x8010b520
80102398:	e8 73 21 00 00       	call   80104510 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010239d:	8b 15 04 b5 10 80    	mov    0x8010b504,%edx
801023a3:	83 c4 10             	add    $0x10,%esp
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
801023a6:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801023ad:	85 d2                	test   %edx,%edx
801023af:	75 09                	jne    801023ba <iderw+0x6a>
801023b1:	eb 58                	jmp    8010240b <iderw+0xbb>
801023b3:	90                   	nop
801023b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801023b8:	89 c2                	mov    %eax,%edx
801023ba:	8b 42 58             	mov    0x58(%edx),%eax
801023bd:	85 c0                	test   %eax,%eax
801023bf:	75 f7                	jne    801023b8 <iderw+0x68>
801023c1:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801023c4:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801023c6:	3b 1d 04 b5 10 80    	cmp    0x8010b504,%ebx
801023cc:	74 44                	je     80102412 <iderw+0xc2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801023ce:	8b 03                	mov    (%ebx),%eax
801023d0:	83 e0 06             	and    $0x6,%eax
801023d3:	83 f8 02             	cmp    $0x2,%eax
801023d6:	74 23                	je     801023fb <iderw+0xab>
801023d8:	90                   	nop
801023d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
801023e0:	83 ec 08             	sub    $0x8,%esp
801023e3:	68 20 b5 10 80       	push   $0x8010b520
801023e8:	53                   	push   %ebx
801023e9:	e8 b2 1b 00 00       	call   80103fa0 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801023ee:	8b 03                	mov    (%ebx),%eax
801023f0:	83 c4 10             	add    $0x10,%esp
801023f3:	83 e0 06             	and    $0x6,%eax
801023f6:	83 f8 02             	cmp    $0x2,%eax
801023f9:	75 e5                	jne    801023e0 <iderw+0x90>
    sleep(b, &idelock);
  }


  release(&idelock);
801023fb:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
}
80102402:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102405:	c9                   	leave  
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }


  release(&idelock);
80102406:	e9 25 22 00 00       	jmp    80104630 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010240b:	ba 04 b5 10 80       	mov    $0x8010b504,%edx
80102410:	eb b2                	jmp    801023c4 <iderw+0x74>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
80102412:	89 d8                	mov    %ebx,%eax
80102414:	e8 47 fd ff ff       	call   80102160 <idestart>
80102419:	eb b3                	jmp    801023ce <iderw+0x7e>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
8010241b:	83 ec 0c             	sub    $0xc,%esp
8010241e:	68 4a 74 10 80       	push   $0x8010744a
80102423:	e8 48 df ff ff       	call   80100370 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
80102428:	83 ec 0c             	sub    $0xc,%esp
8010242b:	68 75 74 10 80       	push   $0x80107475
80102430:	e8 3b df ff ff       	call   80100370 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
80102435:	83 ec 0c             	sub    $0xc,%esp
80102438:	68 60 74 10 80       	push   $0x80107460
8010243d:	e8 2e df ff ff       	call   80100370 <panic>
80102442:	66 90                	xchg   %ax,%ax
80102444:	66 90                	xchg   %ax,%ax
80102446:	66 90                	xchg   %ax,%ax
80102448:	66 90                	xchg   %ax,%ax
8010244a:	66 90                	xchg   %ax,%ax
8010244c:	66 90                	xchg   %ax,%ax
8010244e:	66 90                	xchg   %ax,%ax

80102450 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102450:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102451:	c7 05 d4 35 11 80 00 	movl   $0xfec00000,0x801135d4
80102458:	00 c0 fe 
  ioapic->data = data;
}

void
ioapicinit(void)
{
8010245b:	89 e5                	mov    %esp,%ebp
8010245d:	56                   	push   %esi
8010245e:	53                   	push   %ebx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
8010245f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102466:	00 00 00 
  return ioapic->data;
80102469:	8b 15 d4 35 11 80    	mov    0x801135d4,%edx
8010246f:	8b 72 10             	mov    0x10(%edx),%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80102472:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102478:	8b 0d d4 35 11 80    	mov    0x801135d4,%ecx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010247e:	0f b6 15 00 37 11 80 	movzbl 0x80113700,%edx
ioapicinit(void)
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102485:	89 f0                	mov    %esi,%eax
80102487:	c1 e8 10             	shr    $0x10,%eax
8010248a:	0f b6 f0             	movzbl %al,%esi

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
8010248d:	8b 41 10             	mov    0x10(%ecx),%eax
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102490:	c1 e8 18             	shr    $0x18,%eax
80102493:	39 d0                	cmp    %edx,%eax
80102495:	74 16                	je     801024ad <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102497:	83 ec 0c             	sub    $0xc,%esp
8010249a:	68 94 74 10 80       	push   $0x80107494
8010249f:	e8 dc e1 ff ff       	call   80100680 <cprintf>
801024a4:	8b 0d d4 35 11 80    	mov    0x801135d4,%ecx
801024aa:	83 c4 10             	add    $0x10,%esp
801024ad:	83 c6 21             	add    $0x21,%esi
  ioapic->data = data;
}

void
ioapicinit(void)
{
801024b0:	ba 10 00 00 00       	mov    $0x10,%edx
801024b5:	b8 20 00 00 00       	mov    $0x20,%eax
801024ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801024c0:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
801024c2:	8b 0d d4 35 11 80    	mov    0x801135d4,%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801024c8:	89 c3                	mov    %eax,%ebx
801024ca:	81 cb 00 00 01 00    	or     $0x10000,%ebx
801024d0:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801024d3:	89 59 10             	mov    %ebx,0x10(%ecx)
801024d6:	8d 5a 01             	lea    0x1(%edx),%ebx
801024d9:	83 c2 02             	add    $0x2,%edx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801024dc:	39 f0                	cmp    %esi,%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801024de:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
801024e0:	8b 0d d4 35 11 80    	mov    0x801135d4,%ecx
801024e6:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801024ed:	75 d1                	jne    801024c0 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801024ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024f2:	5b                   	pop    %ebx
801024f3:	5e                   	pop    %esi
801024f4:	5d                   	pop    %ebp
801024f5:	c3                   	ret    
801024f6:	8d 76 00             	lea    0x0(%esi),%esi
801024f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102500 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102500:	55                   	push   %ebp
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102501:	8b 0d d4 35 11 80    	mov    0x801135d4,%ecx
  }
}

void
ioapicenable(int irq, int cpunum)
{
80102507:	89 e5                	mov    %esp,%ebp
80102509:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010250c:	8d 50 20             	lea    0x20(%eax),%edx
8010250f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102513:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102515:	8b 0d d4 35 11 80    	mov    0x801135d4,%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010251b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010251e:	89 51 10             	mov    %edx,0x10(%ecx)
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102521:	8b 55 0c             	mov    0xc(%ebp),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102524:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102526:	a1 d4 35 11 80       	mov    0x801135d4,%eax
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010252b:	c1 e2 18             	shl    $0x18,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
8010252e:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
80102531:	5d                   	pop    %ebp
80102532:	c3                   	ret    
80102533:	66 90                	xchg   %ax,%ax
80102535:	66 90                	xchg   %ax,%ax
80102537:	66 90                	xchg   %ax,%ax
80102539:	66 90                	xchg   %ax,%ax
8010253b:	66 90                	xchg   %ax,%ax
8010253d:	66 90                	xchg   %ax,%ax
8010253f:	90                   	nop

80102540 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102540:	55                   	push   %ebp
80102541:	89 e5                	mov    %esp,%ebp
80102543:	53                   	push   %ebx
80102544:	83 ec 04             	sub    $0x4,%esp
80102547:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010254a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102550:	75 70                	jne    801025c2 <kfree+0x82>
80102552:	81 fb 48 64 11 80    	cmp    $0x80116448,%ebx
80102558:	72 68                	jb     801025c2 <kfree+0x82>
8010255a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102560:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102565:	77 5b                	ja     801025c2 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102567:	83 ec 04             	sub    $0x4,%esp
8010256a:	68 00 10 00 00       	push   $0x1000
8010256f:	6a 01                	push   $0x1
80102571:	53                   	push   %ebx
80102572:	e8 09 21 00 00       	call   80104680 <memset>

  if(kmem.use_lock)
80102577:	8b 15 14 36 11 80    	mov    0x80113614,%edx
8010257d:	83 c4 10             	add    $0x10,%esp
80102580:	85 d2                	test   %edx,%edx
80102582:	75 2c                	jne    801025b0 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102584:	a1 18 36 11 80       	mov    0x80113618,%eax
80102589:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010258b:	a1 14 36 11 80       	mov    0x80113614,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
80102590:	89 1d 18 36 11 80    	mov    %ebx,0x80113618
  if(kmem.use_lock)
80102596:	85 c0                	test   %eax,%eax
80102598:	75 06                	jne    801025a0 <kfree+0x60>
    release(&kmem.lock);
}
8010259a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010259d:	c9                   	leave  
8010259e:	c3                   	ret    
8010259f:	90                   	nop
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
801025a0:	c7 45 08 e0 35 11 80 	movl   $0x801135e0,0x8(%ebp)
}
801025a7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801025aa:	c9                   	leave  
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
801025ab:	e9 80 20 00 00       	jmp    80104630 <release>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
801025b0:	83 ec 0c             	sub    $0xc,%esp
801025b3:	68 e0 35 11 80       	push   $0x801135e0
801025b8:	e8 53 1f 00 00       	call   80104510 <acquire>
801025bd:	83 c4 10             	add    $0x10,%esp
801025c0:	eb c2                	jmp    80102584 <kfree+0x44>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
801025c2:	83 ec 0c             	sub    $0xc,%esp
801025c5:	68 c6 74 10 80       	push   $0x801074c6
801025ca:	e8 a1 dd ff ff       	call   80100370 <panic>
801025cf:	90                   	nop

801025d0 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
801025d0:	55                   	push   %ebp
801025d1:	89 e5                	mov    %esp,%ebp
801025d3:	56                   	push   %esi
801025d4:	53                   	push   %ebx
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801025d5:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
801025d8:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801025db:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801025e1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025e7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801025ed:	39 de                	cmp    %ebx,%esi
801025ef:	72 23                	jb     80102614 <freerange+0x44>
801025f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801025f8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801025fe:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102601:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102607:	50                   	push   %eax
80102608:	e8 33 ff ff ff       	call   80102540 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010260d:	83 c4 10             	add    $0x10,%esp
80102610:	39 f3                	cmp    %esi,%ebx
80102612:	76 e4                	jbe    801025f8 <freerange+0x28>
    kfree(p);
}
80102614:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102617:	5b                   	pop    %ebx
80102618:	5e                   	pop    %esi
80102619:	5d                   	pop    %ebp
8010261a:	c3                   	ret    
8010261b:	90                   	nop
8010261c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102620 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102620:	55                   	push   %ebp
80102621:	89 e5                	mov    %esp,%ebp
80102623:	56                   	push   %esi
80102624:	53                   	push   %ebx
80102625:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102628:	83 ec 08             	sub    $0x8,%esp
8010262b:	68 cc 74 10 80       	push   $0x801074cc
80102630:	68 e0 35 11 80       	push   $0x801135e0
80102635:	e8 d6 1d 00 00       	call   80104410 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010263a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010263d:	83 c4 10             	add    $0x10,%esp
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
80102640:	c7 05 14 36 11 80 00 	movl   $0x0,0x80113614
80102647:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010264a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102650:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102656:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010265c:	39 de                	cmp    %ebx,%esi
8010265e:	72 1c                	jb     8010267c <kinit1+0x5c>
    kfree(p);
80102660:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102666:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102669:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010266f:	50                   	push   %eax
80102670:	e8 cb fe ff ff       	call   80102540 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102675:	83 c4 10             	add    $0x10,%esp
80102678:	39 de                	cmp    %ebx,%esi
8010267a:	73 e4                	jae    80102660 <kinit1+0x40>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
8010267c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010267f:	5b                   	pop    %ebx
80102680:	5e                   	pop    %esi
80102681:	5d                   	pop    %ebp
80102682:	c3                   	ret    
80102683:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102690 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102690:	55                   	push   %ebp
80102691:	89 e5                	mov    %esp,%ebp
80102693:	56                   	push   %esi
80102694:	53                   	push   %ebx

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102695:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
80102698:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010269b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801026a1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026a7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801026ad:	39 de                	cmp    %ebx,%esi
801026af:	72 23                	jb     801026d4 <kinit2+0x44>
801026b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801026b8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801026be:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026c1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801026c7:	50                   	push   %eax
801026c8:	e8 73 fe ff ff       	call   80102540 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026cd:	83 c4 10             	add    $0x10,%esp
801026d0:	39 de                	cmp    %ebx,%esi
801026d2:	73 e4                	jae    801026b8 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
801026d4:	c7 05 14 36 11 80 01 	movl   $0x1,0x80113614
801026db:	00 00 00 
}
801026de:	8d 65 f8             	lea    -0x8(%ebp),%esp
801026e1:	5b                   	pop    %ebx
801026e2:	5e                   	pop    %esi
801026e3:	5d                   	pop    %ebp
801026e4:	c3                   	ret    
801026e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801026e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801026f0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
801026f0:	55                   	push   %ebp
801026f1:	89 e5                	mov    %esp,%ebp
801026f3:	53                   	push   %ebx
801026f4:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
801026f7:	a1 14 36 11 80       	mov    0x80113614,%eax
801026fc:	85 c0                	test   %eax,%eax
801026fe:	75 30                	jne    80102730 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102700:	8b 1d 18 36 11 80    	mov    0x80113618,%ebx
  if(r)
80102706:	85 db                	test   %ebx,%ebx
80102708:	74 1c                	je     80102726 <kalloc+0x36>
    kmem.freelist = r->next;
8010270a:	8b 13                	mov    (%ebx),%edx
8010270c:	89 15 18 36 11 80    	mov    %edx,0x80113618
  if(kmem.use_lock)
80102712:	85 c0                	test   %eax,%eax
80102714:	74 10                	je     80102726 <kalloc+0x36>
    release(&kmem.lock);
80102716:	83 ec 0c             	sub    $0xc,%esp
80102719:	68 e0 35 11 80       	push   $0x801135e0
8010271e:	e8 0d 1f 00 00       	call   80104630 <release>
80102723:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
}
80102726:	89 d8                	mov    %ebx,%eax
80102728:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010272b:	c9                   	leave  
8010272c:	c3                   	ret    
8010272d:	8d 76 00             	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102730:	83 ec 0c             	sub    $0xc,%esp
80102733:	68 e0 35 11 80       	push   $0x801135e0
80102738:	e8 d3 1d 00 00       	call   80104510 <acquire>
  r = kmem.freelist;
8010273d:	8b 1d 18 36 11 80    	mov    0x80113618,%ebx
  if(r)
80102743:	83 c4 10             	add    $0x10,%esp
80102746:	a1 14 36 11 80       	mov    0x80113614,%eax
8010274b:	85 db                	test   %ebx,%ebx
8010274d:	75 bb                	jne    8010270a <kalloc+0x1a>
8010274f:	eb c1                	jmp    80102712 <kalloc+0x22>
80102751:	66 90                	xchg   %ax,%ax
80102753:	66 90                	xchg   %ax,%ax
80102755:	66 90                	xchg   %ax,%ax
80102757:	66 90                	xchg   %ax,%ax
80102759:	66 90                	xchg   %ax,%ax
8010275b:	66 90                	xchg   %ax,%ax
8010275d:	66 90                	xchg   %ax,%ax
8010275f:	90                   	nop

80102760 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102760:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102761:	ba 64 00 00 00       	mov    $0x64,%edx
80102766:	89 e5                	mov    %esp,%ebp
80102768:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102769:	a8 01                	test   $0x1,%al
8010276b:	0f 84 af 00 00 00    	je     80102820 <kbdgetc+0xc0>
80102771:	ba 60 00 00 00       	mov    $0x60,%edx
80102776:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102777:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
8010277a:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102780:	74 7e                	je     80102800 <kbdgetc+0xa0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102782:	84 c0                	test   %al,%al
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102784:	8b 0d 54 b5 10 80    	mov    0x8010b554,%ecx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
8010278a:	79 24                	jns    801027b0 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
8010278c:	f6 c1 40             	test   $0x40,%cl
8010278f:	75 05                	jne    80102796 <kbdgetc+0x36>
80102791:	89 c2                	mov    %eax,%edx
80102793:	83 e2 7f             	and    $0x7f,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102796:	0f b6 82 00 76 10 80 	movzbl -0x7fef8a00(%edx),%eax
8010279d:	83 c8 40             	or     $0x40,%eax
801027a0:	0f b6 c0             	movzbl %al,%eax
801027a3:	f7 d0                	not    %eax
801027a5:	21 c8                	and    %ecx,%eax
801027a7:	a3 54 b5 10 80       	mov    %eax,0x8010b554
    return 0;
801027ac:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801027ae:	5d                   	pop    %ebp
801027af:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801027b0:	f6 c1 40             	test   $0x40,%cl
801027b3:	74 09                	je     801027be <kbdgetc+0x5e>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801027b5:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
801027b8:	83 e1 bf             	and    $0xffffffbf,%ecx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801027bb:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
801027be:	0f b6 82 00 76 10 80 	movzbl -0x7fef8a00(%edx),%eax
801027c5:	09 c1                	or     %eax,%ecx
801027c7:	0f b6 82 00 75 10 80 	movzbl -0x7fef8b00(%edx),%eax
801027ce:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801027d0:	89 c8                	mov    %ecx,%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
801027d2:	89 0d 54 b5 10 80    	mov    %ecx,0x8010b554
  c = charcode[shift & (CTL | SHIFT)][data];
801027d8:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801027db:	83 e1 08             	and    $0x8,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
801027de:	8b 04 85 e0 74 10 80 	mov    -0x7fef8b20(,%eax,4),%eax
801027e5:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
801027e9:	74 c3                	je     801027ae <kbdgetc+0x4e>
    if('a' <= c && c <= 'z')
801027eb:	8d 50 9f             	lea    -0x61(%eax),%edx
801027ee:	83 fa 19             	cmp    $0x19,%edx
801027f1:	77 1d                	ja     80102810 <kbdgetc+0xb0>
      c += 'A' - 'a';
801027f3:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801027f6:	5d                   	pop    %ebp
801027f7:	c3                   	ret    
801027f8:	90                   	nop
801027f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
80102800:	31 c0                	xor    %eax,%eax
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102802:	83 0d 54 b5 10 80 40 	orl    $0x40,0x8010b554
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102809:	5d                   	pop    %ebp
8010280a:	c3                   	ret    
8010280b:	90                   	nop
8010280c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
80102810:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102813:	8d 50 20             	lea    0x20(%eax),%edx
  }
  return c;
}
80102816:	5d                   	pop    %ebp
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
80102817:	83 f9 19             	cmp    $0x19,%ecx
8010281a:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
8010281d:	c3                   	ret    
8010281e:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
80102820:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102825:	5d                   	pop    %ebp
80102826:	c3                   	ret    
80102827:	89 f6                	mov    %esi,%esi
80102829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102830 <kbdintr>:

void
kbdintr(void)
{
80102830:	55                   	push   %ebp
80102831:	89 e5                	mov    %esp,%ebp
80102833:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102836:	68 60 27 10 80       	push   $0x80102760
8010283b:	e8 b0 e1 ff ff       	call   801009f0 <consoleintr>
}
80102840:	83 c4 10             	add    $0x10,%esp
80102843:	c9                   	leave  
80102844:	c3                   	ret    
80102845:	66 90                	xchg   %ax,%ax
80102847:	66 90                	xchg   %ax,%ax
80102849:	66 90                	xchg   %ax,%ax
8010284b:	66 90                	xchg   %ax,%ax
8010284d:	66 90                	xchg   %ax,%ax
8010284f:	90                   	nop

80102850 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102850:	a1 1c 36 11 80       	mov    0x8011361c,%eax
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
80102855:	55                   	push   %ebp
80102856:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102858:	85 c0                	test   %eax,%eax
8010285a:	0f 84 c8 00 00 00    	je     80102928 <lapicinit+0xd8>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102860:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102867:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010286a:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010286d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102874:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102877:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010287a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102881:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102884:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102887:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010288e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102891:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102894:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010289b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010289e:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028a1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801028a8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801028ab:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801028ae:	8b 50 30             	mov    0x30(%eax),%edx
801028b1:	c1 ea 10             	shr    $0x10,%edx
801028b4:	80 fa 03             	cmp    $0x3,%dl
801028b7:	77 77                	ja     80102930 <lapicinit+0xe0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028b9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801028c0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028c3:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028c6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801028cd:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028d0:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028d3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801028da:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028dd:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028e0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801028e7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028ea:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028ed:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801028f4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028f7:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028fa:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102901:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102904:	8b 50 20             	mov    0x20(%eax),%edx
80102907:	89 f6                	mov    %esi,%esi
80102909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102910:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102916:	80 e6 10             	and    $0x10,%dh
80102919:	75 f5                	jne    80102910 <lapicinit+0xc0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010291b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102922:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102925:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102928:	5d                   	pop    %ebp
80102929:	c3                   	ret    
8010292a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102930:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102937:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010293a:	8b 50 20             	mov    0x20(%eax),%edx
8010293d:	e9 77 ff ff ff       	jmp    801028b9 <lapicinit+0x69>
80102942:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102950 <lapicid>:
}

int
lapicid(void)
{
  if (!lapic)
80102950:	a1 1c 36 11 80       	mov    0x8011361c,%eax
  lapicw(TPR, 0);
}

int
lapicid(void)
{
80102955:	55                   	push   %ebp
80102956:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102958:	85 c0                	test   %eax,%eax
8010295a:	74 0c                	je     80102968 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
8010295c:	8b 40 20             	mov    0x20(%eax),%eax
}
8010295f:	5d                   	pop    %ebp
int
lapicid(void)
{
  if (!lapic)
    return 0;
  return lapic[ID] >> 24;
80102960:	c1 e8 18             	shr    $0x18,%eax
}
80102963:	c3                   	ret    
80102964:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

int
lapicid(void)
{
  if (!lapic)
    return 0;
80102968:	31 c0                	xor    %eax,%eax
  return lapic[ID] >> 24;
}
8010296a:	5d                   	pop    %ebp
8010296b:	c3                   	ret    
8010296c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102970 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102970:	a1 1c 36 11 80       	mov    0x8011361c,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102975:	55                   	push   %ebp
80102976:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102978:	85 c0                	test   %eax,%eax
8010297a:	74 0d                	je     80102989 <lapiceoi+0x19>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010297c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102983:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102986:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
80102989:	5d                   	pop    %ebp
8010298a:	c3                   	ret    
8010298b:	90                   	nop
8010298c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102990 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102990:	55                   	push   %ebp
80102991:	89 e5                	mov    %esp,%ebp
}
80102993:	5d                   	pop    %ebp
80102994:	c3                   	ret    
80102995:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801029a0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801029a0:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029a1:	ba 70 00 00 00       	mov    $0x70,%edx
801029a6:	b8 0f 00 00 00       	mov    $0xf,%eax
801029ab:	89 e5                	mov    %esp,%ebp
801029ad:	53                   	push   %ebx
801029ae:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801029b1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801029b4:	ee                   	out    %al,(%dx)
801029b5:	ba 71 00 00 00       	mov    $0x71,%edx
801029ba:	b8 0a 00 00 00       	mov    $0xa,%eax
801029bf:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801029c0:	31 c0                	xor    %eax,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801029c2:	c1 e3 18             	shl    $0x18,%ebx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801029c5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801029cb:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801029cd:	c1 e9 0c             	shr    $0xc,%ecx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
801029d0:	c1 e8 04             	shr    $0x4,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801029d3:	89 da                	mov    %ebx,%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801029d5:	80 cd 06             	or     $0x6,%ch
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
801029d8:	66 a3 69 04 00 80    	mov    %ax,0x80000469

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801029de:	a1 1c 36 11 80       	mov    0x8011361c,%eax
801029e3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029e9:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801029ec:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801029f3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029f6:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801029f9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102a00:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a03:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102a06:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a0c:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102a0f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a15:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102a18:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a1e:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102a21:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a27:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
80102a2a:	5b                   	pop    %ebx
80102a2b:	5d                   	pop    %ebp
80102a2c:	c3                   	ret    
80102a2d:	8d 76 00             	lea    0x0(%esi),%esi

80102a30 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
80102a30:	55                   	push   %ebp
80102a31:	ba 70 00 00 00       	mov    $0x70,%edx
80102a36:	b8 0b 00 00 00       	mov    $0xb,%eax
80102a3b:	89 e5                	mov    %esp,%ebp
80102a3d:	57                   	push   %edi
80102a3e:	56                   	push   %esi
80102a3f:	53                   	push   %ebx
80102a40:	83 ec 4c             	sub    $0x4c,%esp
80102a43:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a44:	ba 71 00 00 00       	mov    $0x71,%edx
80102a49:	ec                   	in     (%dx),%al
80102a4a:	83 e0 04             	and    $0x4,%eax
80102a4d:	8d 75 d0             	lea    -0x30(%ebp),%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a50:	31 db                	xor    %ebx,%ebx
80102a52:	88 45 b7             	mov    %al,-0x49(%ebp)
80102a55:	bf 70 00 00 00       	mov    $0x70,%edi
80102a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102a60:	89 d8                	mov    %ebx,%eax
80102a62:	89 fa                	mov    %edi,%edx
80102a64:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a65:	b9 71 00 00 00       	mov    $0x71,%ecx
80102a6a:	89 ca                	mov    %ecx,%edx
80102a6c:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
80102a6d:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a70:	89 fa                	mov    %edi,%edx
80102a72:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102a75:	b8 02 00 00 00       	mov    $0x2,%eax
80102a7a:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a7b:	89 ca                	mov    %ecx,%edx
80102a7d:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
80102a7e:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a81:	89 fa                	mov    %edi,%edx
80102a83:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102a86:	b8 04 00 00 00       	mov    $0x4,%eax
80102a8b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a8c:	89 ca                	mov    %ecx,%edx
80102a8e:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
80102a8f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a92:	89 fa                	mov    %edi,%edx
80102a94:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102a97:	b8 07 00 00 00       	mov    $0x7,%eax
80102a9c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a9d:	89 ca                	mov    %ecx,%edx
80102a9f:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102aa0:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102aa3:	89 fa                	mov    %edi,%edx
80102aa5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102aa8:	b8 08 00 00 00       	mov    $0x8,%eax
80102aad:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102aae:	89 ca                	mov    %ecx,%edx
80102ab0:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102ab1:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ab4:	89 fa                	mov    %edi,%edx
80102ab6:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102ab9:	b8 09 00 00 00       	mov    $0x9,%eax
80102abe:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102abf:	89 ca                	mov    %ecx,%edx
80102ac1:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102ac2:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ac5:	89 fa                	mov    %edi,%edx
80102ac7:	89 45 cc             	mov    %eax,-0x34(%ebp)
80102aca:	b8 0a 00 00 00       	mov    $0xa,%eax
80102acf:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ad0:	89 ca                	mov    %ecx,%edx
80102ad2:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102ad3:	84 c0                	test   %al,%al
80102ad5:	78 89                	js     80102a60 <cmostime+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ad7:	89 d8                	mov    %ebx,%eax
80102ad9:	89 fa                	mov    %edi,%edx
80102adb:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102adc:	89 ca                	mov    %ecx,%edx
80102ade:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
80102adf:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ae2:	89 fa                	mov    %edi,%edx
80102ae4:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102ae7:	b8 02 00 00 00       	mov    $0x2,%eax
80102aec:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102aed:	89 ca                	mov    %ecx,%edx
80102aef:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
80102af0:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102af3:	89 fa                	mov    %edi,%edx
80102af5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102af8:	b8 04 00 00 00       	mov    $0x4,%eax
80102afd:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102afe:	89 ca                	mov    %ecx,%edx
80102b00:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
80102b01:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b04:	89 fa                	mov    %edi,%edx
80102b06:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102b09:	b8 07 00 00 00       	mov    $0x7,%eax
80102b0e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b0f:	89 ca                	mov    %ecx,%edx
80102b11:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102b12:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b15:	89 fa                	mov    %edi,%edx
80102b17:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102b1a:	b8 08 00 00 00       	mov    $0x8,%eax
80102b1f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b20:	89 ca                	mov    %ecx,%edx
80102b22:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102b23:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b26:	89 fa                	mov    %edi,%edx
80102b28:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102b2b:	b8 09 00 00 00       	mov    $0x9,%eax
80102b30:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b31:	89 ca                	mov    %ecx,%edx
80102b33:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102b34:	0f b6 c0             	movzbl %al,%eax
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102b37:	83 ec 04             	sub    $0x4,%esp
  r->second = cmos_read(SECS);
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
80102b3a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102b3d:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102b40:	6a 18                	push   $0x18
80102b42:	56                   	push   %esi
80102b43:	50                   	push   %eax
80102b44:	e8 87 1b 00 00       	call   801046d0 <memcmp>
80102b49:	83 c4 10             	add    $0x10,%esp
80102b4c:	85 c0                	test   %eax,%eax
80102b4e:	0f 85 0c ff ff ff    	jne    80102a60 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80102b54:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
80102b58:	75 78                	jne    80102bd2 <cmostime+0x1a2>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102b5a:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b5d:	89 c2                	mov    %eax,%edx
80102b5f:	83 e0 0f             	and    $0xf,%eax
80102b62:	c1 ea 04             	shr    $0x4,%edx
80102b65:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b68:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b6b:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102b6e:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b71:	89 c2                	mov    %eax,%edx
80102b73:	83 e0 0f             	and    $0xf,%eax
80102b76:	c1 ea 04             	shr    $0x4,%edx
80102b79:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b7c:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b7f:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102b82:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b85:	89 c2                	mov    %eax,%edx
80102b87:	83 e0 0f             	and    $0xf,%eax
80102b8a:	c1 ea 04             	shr    $0x4,%edx
80102b8d:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b90:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b93:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102b96:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b99:	89 c2                	mov    %eax,%edx
80102b9b:	83 e0 0f             	and    $0xf,%eax
80102b9e:	c1 ea 04             	shr    $0x4,%edx
80102ba1:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ba4:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ba7:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102baa:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102bad:	89 c2                	mov    %eax,%edx
80102baf:	83 e0 0f             	and    $0xf,%eax
80102bb2:	c1 ea 04             	shr    $0x4,%edx
80102bb5:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102bb8:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102bbb:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102bbe:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102bc1:	89 c2                	mov    %eax,%edx
80102bc3:	83 e0 0f             	and    $0xf,%eax
80102bc6:	c1 ea 04             	shr    $0x4,%edx
80102bc9:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102bcc:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102bcf:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102bd2:	8b 75 08             	mov    0x8(%ebp),%esi
80102bd5:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102bd8:	89 06                	mov    %eax,(%esi)
80102bda:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102bdd:	89 46 04             	mov    %eax,0x4(%esi)
80102be0:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102be3:	89 46 08             	mov    %eax,0x8(%esi)
80102be6:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102be9:	89 46 0c             	mov    %eax,0xc(%esi)
80102bec:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102bef:	89 46 10             	mov    %eax,0x10(%esi)
80102bf2:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102bf5:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102bf8:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102bff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c02:	5b                   	pop    %ebx
80102c03:	5e                   	pop    %esi
80102c04:	5f                   	pop    %edi
80102c05:	5d                   	pop    %ebp
80102c06:	c3                   	ret    
80102c07:	66 90                	xchg   %ax,%ax
80102c09:	66 90                	xchg   %ax,%ax
80102c0b:	66 90                	xchg   %ax,%ax
80102c0d:	66 90                	xchg   %ax,%ax
80102c0f:	90                   	nop

80102c10 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102c10:	8b 0d 68 36 11 80    	mov    0x80113668,%ecx
80102c16:	85 c9                	test   %ecx,%ecx
80102c18:	0f 8e 85 00 00 00    	jle    80102ca3 <install_trans+0x93>
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102c1e:	55                   	push   %ebp
80102c1f:	89 e5                	mov    %esp,%ebp
80102c21:	57                   	push   %edi
80102c22:	56                   	push   %esi
80102c23:	53                   	push   %ebx
80102c24:	31 db                	xor    %ebx,%ebx
80102c26:	83 ec 0c             	sub    $0xc,%esp
80102c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102c30:	a1 54 36 11 80       	mov    0x80113654,%eax
80102c35:	83 ec 08             	sub    $0x8,%esp
80102c38:	01 d8                	add    %ebx,%eax
80102c3a:	83 c0 01             	add    $0x1,%eax
80102c3d:	50                   	push   %eax
80102c3e:	ff 35 64 36 11 80    	pushl  0x80113664
80102c44:	e8 87 d4 ff ff       	call   801000d0 <bread>
80102c49:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102c4b:	58                   	pop    %eax
80102c4c:	5a                   	pop    %edx
80102c4d:	ff 34 9d 6c 36 11 80 	pushl  -0x7feec994(,%ebx,4)
80102c54:	ff 35 64 36 11 80    	pushl  0x80113664
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102c5a:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102c5d:	e8 6e d4 ff ff       	call   801000d0 <bread>
80102c62:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102c64:	8d 47 5c             	lea    0x5c(%edi),%eax
80102c67:	83 c4 0c             	add    $0xc,%esp
80102c6a:	68 00 02 00 00       	push   $0x200
80102c6f:	50                   	push   %eax
80102c70:	8d 46 5c             	lea    0x5c(%esi),%eax
80102c73:	50                   	push   %eax
80102c74:	e8 b7 1a 00 00       	call   80104730 <memmove>
    bwrite(dbuf);  // write dst to disk
80102c79:	89 34 24             	mov    %esi,(%esp)
80102c7c:	e8 1f d5 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102c81:	89 3c 24             	mov    %edi,(%esp)
80102c84:	e8 57 d5 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102c89:	89 34 24             	mov    %esi,(%esp)
80102c8c:	e8 4f d5 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102c91:	83 c4 10             	add    $0x10,%esp
80102c94:	39 1d 68 36 11 80    	cmp    %ebx,0x80113668
80102c9a:	7f 94                	jg     80102c30 <install_trans+0x20>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102c9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c9f:	5b                   	pop    %ebx
80102ca0:	5e                   	pop    %esi
80102ca1:	5f                   	pop    %edi
80102ca2:	5d                   	pop    %ebp
80102ca3:	f3 c3                	repz ret 
80102ca5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102cb0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102cb0:	55                   	push   %ebp
80102cb1:	89 e5                	mov    %esp,%ebp
80102cb3:	53                   	push   %ebx
80102cb4:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102cb7:	ff 35 54 36 11 80    	pushl  0x80113654
80102cbd:	ff 35 64 36 11 80    	pushl  0x80113664
80102cc3:	e8 08 d4 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102cc8:	8b 0d 68 36 11 80    	mov    0x80113668,%ecx
  for (i = 0; i < log.lh.n; i++) {
80102cce:	83 c4 10             	add    $0x10,%esp
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102cd1:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102cd3:	85 c9                	test   %ecx,%ecx
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102cd5:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102cd8:	7e 1f                	jle    80102cf9 <write_head+0x49>
80102cda:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80102ce1:	31 d2                	xor    %edx,%edx
80102ce3:	90                   	nop
80102ce4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102ce8:	8b 8a 6c 36 11 80    	mov    -0x7feec994(%edx),%ecx
80102cee:	89 4c 13 60          	mov    %ecx,0x60(%ebx,%edx,1)
80102cf2:	83 c2 04             	add    $0x4,%edx
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102cf5:	39 c2                	cmp    %eax,%edx
80102cf7:	75 ef                	jne    80102ce8 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102cf9:	83 ec 0c             	sub    $0xc,%esp
80102cfc:	53                   	push   %ebx
80102cfd:	e8 9e d4 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102d02:	89 1c 24             	mov    %ebx,(%esp)
80102d05:	e8 d6 d4 ff ff       	call   801001e0 <brelse>
}
80102d0a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d0d:	c9                   	leave  
80102d0e:	c3                   	ret    
80102d0f:	90                   	nop

80102d10 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102d10:	55                   	push   %ebp
80102d11:	89 e5                	mov    %esp,%ebp
80102d13:	53                   	push   %ebx
80102d14:	83 ec 2c             	sub    $0x2c,%esp
80102d17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102d1a:	68 00 77 10 80       	push   $0x80107700
80102d1f:	68 20 36 11 80       	push   $0x80113620
80102d24:	e8 e7 16 00 00       	call   80104410 <initlock>
  readsb(dev, &sb);
80102d29:	58                   	pop    %eax
80102d2a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102d2d:	5a                   	pop    %edx
80102d2e:	50                   	push   %eax
80102d2f:	53                   	push   %ebx
80102d30:	e8 db e8 ff ff       	call   80101610 <readsb>
  log.start = sb.logstart;
  log.size = sb.nlog;
80102d35:	8b 55 e8             	mov    -0x18(%ebp),%edx
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102d38:	8b 45 ec             	mov    -0x14(%ebp),%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102d3b:	59                   	pop    %ecx
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102d3c:	89 1d 64 36 11 80    	mov    %ebx,0x80113664

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102d42:	89 15 58 36 11 80    	mov    %edx,0x80113658
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102d48:	a3 54 36 11 80       	mov    %eax,0x80113654

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102d4d:	5a                   	pop    %edx
80102d4e:	50                   	push   %eax
80102d4f:	53                   	push   %ebx
80102d50:	e8 7b d3 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102d55:	8b 48 5c             	mov    0x5c(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102d58:	83 c4 10             	add    $0x10,%esp
80102d5b:	85 c9                	test   %ecx,%ecx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102d5d:	89 0d 68 36 11 80    	mov    %ecx,0x80113668
  for (i = 0; i < log.lh.n; i++) {
80102d63:	7e 1c                	jle    80102d81 <initlog+0x71>
80102d65:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102d6c:	31 d2                	xor    %edx,%edx
80102d6e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102d70:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102d74:	83 c2 04             	add    $0x4,%edx
80102d77:	89 8a 68 36 11 80    	mov    %ecx,-0x7feec998(%edx)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102d7d:	39 da                	cmp    %ebx,%edx
80102d7f:	75 ef                	jne    80102d70 <initlog+0x60>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102d81:	83 ec 0c             	sub    $0xc,%esp
80102d84:	50                   	push   %eax
80102d85:	e8 56 d4 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102d8a:	e8 81 fe ff ff       	call   80102c10 <install_trans>
  log.lh.n = 0;
80102d8f:	c7 05 68 36 11 80 00 	movl   $0x0,0x80113668
80102d96:	00 00 00 
  write_head(); // clear the log
80102d99:	e8 12 ff ff ff       	call   80102cb0 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102d9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102da1:	c9                   	leave  
80102da2:	c3                   	ret    
80102da3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102db0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102db0:	55                   	push   %ebp
80102db1:	89 e5                	mov    %esp,%ebp
80102db3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102db6:	68 20 36 11 80       	push   $0x80113620
80102dbb:	e8 50 17 00 00       	call   80104510 <acquire>
80102dc0:	83 c4 10             	add    $0x10,%esp
80102dc3:	eb 18                	jmp    80102ddd <begin_op+0x2d>
80102dc5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102dc8:	83 ec 08             	sub    $0x8,%esp
80102dcb:	68 20 36 11 80       	push   $0x80113620
80102dd0:	68 20 36 11 80       	push   $0x80113620
80102dd5:	e8 c6 11 00 00       	call   80103fa0 <sleep>
80102dda:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102ddd:	a1 60 36 11 80       	mov    0x80113660,%eax
80102de2:	85 c0                	test   %eax,%eax
80102de4:	75 e2                	jne    80102dc8 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102de6:	a1 5c 36 11 80       	mov    0x8011365c,%eax
80102deb:	8b 15 68 36 11 80    	mov    0x80113668,%edx
80102df1:	83 c0 01             	add    $0x1,%eax
80102df4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102df7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102dfa:	83 fa 1e             	cmp    $0x1e,%edx
80102dfd:	7f c9                	jg     80102dc8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102dff:	83 ec 0c             	sub    $0xc,%esp
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102e02:	a3 5c 36 11 80       	mov    %eax,0x8011365c
      release(&log.lock);
80102e07:	68 20 36 11 80       	push   $0x80113620
80102e0c:	e8 1f 18 00 00       	call   80104630 <release>
      break;
    }
  }
}
80102e11:	83 c4 10             	add    $0x10,%esp
80102e14:	c9                   	leave  
80102e15:	c3                   	ret    
80102e16:	8d 76 00             	lea    0x0(%esi),%esi
80102e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102e20 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102e20:	55                   	push   %ebp
80102e21:	89 e5                	mov    %esp,%ebp
80102e23:	57                   	push   %edi
80102e24:	56                   	push   %esi
80102e25:	53                   	push   %ebx
80102e26:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102e29:	68 20 36 11 80       	push   $0x80113620
80102e2e:	e8 dd 16 00 00       	call   80104510 <acquire>
  log.outstanding -= 1;
80102e33:	a1 5c 36 11 80       	mov    0x8011365c,%eax
  if(log.committing)
80102e38:	8b 1d 60 36 11 80    	mov    0x80113660,%ebx
80102e3e:	83 c4 10             	add    $0x10,%esp
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102e41:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102e44:	85 db                	test   %ebx,%ebx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102e46:	a3 5c 36 11 80       	mov    %eax,0x8011365c
  if(log.committing)
80102e4b:	0f 85 23 01 00 00    	jne    80102f74 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102e51:	85 c0                	test   %eax,%eax
80102e53:	0f 85 f7 00 00 00    	jne    80102f50 <end_op+0x130>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102e59:	83 ec 0c             	sub    $0xc,%esp
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102e5c:	c7 05 60 36 11 80 01 	movl   $0x1,0x80113660
80102e63:	00 00 00 
}

static void
commit()
{
  if (log.lh.n > 0) {
80102e66:	31 db                	xor    %ebx,%ebx
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102e68:	68 20 36 11 80       	push   $0x80113620
80102e6d:	e8 be 17 00 00       	call   80104630 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102e72:	8b 0d 68 36 11 80    	mov    0x80113668,%ecx
80102e78:	83 c4 10             	add    $0x10,%esp
80102e7b:	85 c9                	test   %ecx,%ecx
80102e7d:	0f 8e 8a 00 00 00    	jle    80102f0d <end_op+0xed>
80102e83:	90                   	nop
80102e84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102e88:	a1 54 36 11 80       	mov    0x80113654,%eax
80102e8d:	83 ec 08             	sub    $0x8,%esp
80102e90:	01 d8                	add    %ebx,%eax
80102e92:	83 c0 01             	add    $0x1,%eax
80102e95:	50                   	push   %eax
80102e96:	ff 35 64 36 11 80    	pushl  0x80113664
80102e9c:	e8 2f d2 ff ff       	call   801000d0 <bread>
80102ea1:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102ea3:	58                   	pop    %eax
80102ea4:	5a                   	pop    %edx
80102ea5:	ff 34 9d 6c 36 11 80 	pushl  -0x7feec994(,%ebx,4)
80102eac:	ff 35 64 36 11 80    	pushl  0x80113664
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102eb2:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102eb5:	e8 16 d2 ff ff       	call   801000d0 <bread>
80102eba:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102ebc:	8d 40 5c             	lea    0x5c(%eax),%eax
80102ebf:	83 c4 0c             	add    $0xc,%esp
80102ec2:	68 00 02 00 00       	push   $0x200
80102ec7:	50                   	push   %eax
80102ec8:	8d 46 5c             	lea    0x5c(%esi),%eax
80102ecb:	50                   	push   %eax
80102ecc:	e8 5f 18 00 00       	call   80104730 <memmove>
    bwrite(to);  // write the log
80102ed1:	89 34 24             	mov    %esi,(%esp)
80102ed4:	e8 c7 d2 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102ed9:	89 3c 24             	mov    %edi,(%esp)
80102edc:	e8 ff d2 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102ee1:	89 34 24             	mov    %esi,(%esp)
80102ee4:	e8 f7 d2 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ee9:	83 c4 10             	add    $0x10,%esp
80102eec:	3b 1d 68 36 11 80    	cmp    0x80113668,%ebx
80102ef2:	7c 94                	jl     80102e88 <end_op+0x68>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102ef4:	e8 b7 fd ff ff       	call   80102cb0 <write_head>
    install_trans(); // Now install writes to home locations
80102ef9:	e8 12 fd ff ff       	call   80102c10 <install_trans>
    log.lh.n = 0;
80102efe:	c7 05 68 36 11 80 00 	movl   $0x0,0x80113668
80102f05:	00 00 00 
    write_head();    // Erase the transaction from the log
80102f08:	e8 a3 fd ff ff       	call   80102cb0 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102f0d:	83 ec 0c             	sub    $0xc,%esp
80102f10:	68 20 36 11 80       	push   $0x80113620
80102f15:	e8 f6 15 00 00       	call   80104510 <acquire>
    log.committing = 0;
    wakeup(&log);
80102f1a:	c7 04 24 20 36 11 80 	movl   $0x80113620,(%esp)
  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
    log.committing = 0;
80102f21:	c7 05 60 36 11 80 00 	movl   $0x0,0x80113660
80102f28:	00 00 00 
    wakeup(&log);
80102f2b:	e8 20 12 00 00       	call   80104150 <wakeup>
    release(&log.lock);
80102f30:	c7 04 24 20 36 11 80 	movl   $0x80113620,(%esp)
80102f37:	e8 f4 16 00 00       	call   80104630 <release>
80102f3c:	83 c4 10             	add    $0x10,%esp
  }
}
80102f3f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f42:	5b                   	pop    %ebx
80102f43:	5e                   	pop    %esi
80102f44:	5f                   	pop    %edi
80102f45:	5d                   	pop    %ebp
80102f46:	c3                   	ret    
80102f47:	89 f6                	mov    %esi,%esi
80102f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
80102f50:	83 ec 0c             	sub    $0xc,%esp
80102f53:	68 20 36 11 80       	push   $0x80113620
80102f58:	e8 f3 11 00 00       	call   80104150 <wakeup>
  }
  release(&log.lock);
80102f5d:	c7 04 24 20 36 11 80 	movl   $0x80113620,(%esp)
80102f64:	e8 c7 16 00 00       	call   80104630 <release>
80102f69:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
80102f6c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f6f:	5b                   	pop    %ebx
80102f70:	5e                   	pop    %esi
80102f71:	5f                   	pop    %edi
80102f72:	5d                   	pop    %ebp
80102f73:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102f74:	83 ec 0c             	sub    $0xc,%esp
80102f77:	68 04 77 10 80       	push   $0x80107704
80102f7c:	e8 ef d3 ff ff       	call   80100370 <panic>
80102f81:	eb 0d                	jmp    80102f90 <log_write>
80102f83:	90                   	nop
80102f84:	90                   	nop
80102f85:	90                   	nop
80102f86:	90                   	nop
80102f87:	90                   	nop
80102f88:	90                   	nop
80102f89:	90                   	nop
80102f8a:	90                   	nop
80102f8b:	90                   	nop
80102f8c:	90                   	nop
80102f8d:	90                   	nop
80102f8e:	90                   	nop
80102f8f:	90                   	nop

80102f90 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102f90:	55                   	push   %ebp
80102f91:	89 e5                	mov    %esp,%ebp
80102f93:	53                   	push   %ebx
80102f94:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f97:	8b 15 68 36 11 80    	mov    0x80113668,%edx
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102f9d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102fa0:	83 fa 1d             	cmp    $0x1d,%edx
80102fa3:	0f 8f 97 00 00 00    	jg     80103040 <log_write+0xb0>
80102fa9:	a1 58 36 11 80       	mov    0x80113658,%eax
80102fae:	83 e8 01             	sub    $0x1,%eax
80102fb1:	39 c2                	cmp    %eax,%edx
80102fb3:	0f 8d 87 00 00 00    	jge    80103040 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102fb9:	a1 5c 36 11 80       	mov    0x8011365c,%eax
80102fbe:	85 c0                	test   %eax,%eax
80102fc0:	0f 8e 87 00 00 00    	jle    8010304d <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102fc6:	83 ec 0c             	sub    $0xc,%esp
80102fc9:	68 20 36 11 80       	push   $0x80113620
80102fce:	e8 3d 15 00 00       	call   80104510 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102fd3:	8b 15 68 36 11 80    	mov    0x80113668,%edx
80102fd9:	83 c4 10             	add    $0x10,%esp
80102fdc:	83 fa 00             	cmp    $0x0,%edx
80102fdf:	7e 50                	jle    80103031 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102fe1:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102fe4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102fe6:	3b 0d 6c 36 11 80    	cmp    0x8011366c,%ecx
80102fec:	75 0b                	jne    80102ff9 <log_write+0x69>
80102fee:	eb 38                	jmp    80103028 <log_write+0x98>
80102ff0:	39 0c 85 6c 36 11 80 	cmp    %ecx,-0x7feec994(,%eax,4)
80102ff7:	74 2f                	je     80103028 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102ff9:	83 c0 01             	add    $0x1,%eax
80102ffc:	39 d0                	cmp    %edx,%eax
80102ffe:	75 f0                	jne    80102ff0 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80103000:	89 0c 95 6c 36 11 80 	mov    %ecx,-0x7feec994(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80103007:	83 c2 01             	add    $0x1,%edx
8010300a:	89 15 68 36 11 80    	mov    %edx,0x80113668
  b->flags |= B_DIRTY; // prevent eviction
80103010:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80103013:	c7 45 08 20 36 11 80 	movl   $0x80113620,0x8(%ebp)
}
8010301a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010301d:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
8010301e:	e9 0d 16 00 00       	jmp    80104630 <release>
80103023:	90                   	nop
80103024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80103028:	89 0c 85 6c 36 11 80 	mov    %ecx,-0x7feec994(,%eax,4)
8010302f:	eb df                	jmp    80103010 <log_write+0x80>
80103031:	8b 43 08             	mov    0x8(%ebx),%eax
80103034:	a3 6c 36 11 80       	mov    %eax,0x8011366c
  if (i == log.lh.n)
80103039:	75 d5                	jne    80103010 <log_write+0x80>
8010303b:	eb ca                	jmp    80103007 <log_write+0x77>
8010303d:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80103040:	83 ec 0c             	sub    $0xc,%esp
80103043:	68 13 77 10 80       	push   $0x80107713
80103048:	e8 23 d3 ff ff       	call   80100370 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
8010304d:	83 ec 0c             	sub    $0xc,%esp
80103050:	68 29 77 10 80       	push   $0x80107729
80103055:	e8 16 d3 ff ff       	call   80100370 <panic>
8010305a:	66 90                	xchg   %ax,%ax
8010305c:	66 90                	xchg   %ax,%ax
8010305e:	66 90                	xchg   %ax,%ax

80103060 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103060:	55                   	push   %ebp
80103061:	89 e5                	mov    %esp,%ebp
80103063:	53                   	push   %ebx
80103064:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103067:	e8 54 09 00 00       	call   801039c0 <cpuid>
8010306c:	89 c3                	mov    %eax,%ebx
8010306e:	e8 4d 09 00 00       	call   801039c0 <cpuid>
80103073:	83 ec 04             	sub    $0x4,%esp
80103076:	53                   	push   %ebx
80103077:	50                   	push   %eax
80103078:	68 44 77 10 80       	push   $0x80107744
8010307d:	e8 fe d5 ff ff       	call   80100680 <cprintf>
  idtinit();       // load idt register
80103082:	e8 e9 29 00 00       	call   80105a70 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103087:	e8 b4 08 00 00       	call   80103940 <mycpu>
8010308c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010308e:	b8 01 00 00 00       	mov    $0x1,%eax
80103093:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010309a:	e8 01 0c 00 00       	call   80103ca0 <scheduler>
8010309f:	90                   	nop

801030a0 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
801030a0:	55                   	push   %ebp
801030a1:	89 e5                	mov    %esp,%ebp
801030a3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
801030a6:	e8 e5 3a 00 00       	call   80106b90 <switchkvm>
  seginit();
801030ab:	e8 e0 39 00 00       	call   80106a90 <seginit>
  lapicinit();
801030b0:	e8 9b f7 ff ff       	call   80102850 <lapicinit>
  mpmain();
801030b5:	e8 a6 ff ff ff       	call   80103060 <mpmain>
801030ba:	66 90                	xchg   %ax,%ax
801030bc:	66 90                	xchg   %ax,%ax
801030be:	66 90                	xchg   %ax,%ax

801030c0 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
801030c0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
801030c4:	83 e4 f0             	and    $0xfffffff0,%esp
801030c7:	ff 71 fc             	pushl  -0x4(%ecx)
801030ca:	55                   	push   %ebp
801030cb:	89 e5                	mov    %esp,%ebp
801030cd:	53                   	push   %ebx
801030ce:	51                   	push   %ecx
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
801030cf:	bb 20 37 11 80       	mov    $0x80113720,%ebx
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801030d4:	83 ec 08             	sub    $0x8,%esp
801030d7:	68 00 00 40 80       	push   $0x80400000
801030dc:	68 48 64 11 80       	push   $0x80116448
801030e1:	e8 3a f5 ff ff       	call   80102620 <kinit1>
  kvmalloc();      // kernel page table
801030e6:	e8 45 3f 00 00       	call   80107030 <kvmalloc>
  mpinit();        // detect other processors
801030eb:	e8 70 01 00 00       	call   80103260 <mpinit>
  lapicinit();     // interrupt controller
801030f0:	e8 5b f7 ff ff       	call   80102850 <lapicinit>
  seginit();       // segment descriptors
801030f5:	e8 96 39 00 00       	call   80106a90 <seginit>
  picinit();       // disable pic
801030fa:	e8 31 03 00 00       	call   80103430 <picinit>
  ioapicinit();    // another interrupt controller
801030ff:	e8 4c f3 ff ff       	call   80102450 <ioapicinit>
  consoleinit();   // console hardware
80103104:	e8 c7 da ff ff       	call   80100bd0 <consoleinit>
  uartinit();      // serial port
80103109:	e8 52 2c 00 00       	call   80105d60 <uartinit>
  pinit();         // process table
8010310e:	e8 0d 08 00 00       	call   80103920 <pinit>
  tvinit();        // trap vectors
80103113:	e8 b8 28 00 00       	call   801059d0 <tvinit>
  binit();         // buffer cache
80103118:	e8 23 cf ff ff       	call   80100040 <binit>
  fileinit();      // file table
8010311d:	e8 8e de ff ff       	call   80100fb0 <fileinit>
  ideinit();       // disk 
80103122:	e8 09 f1 ff ff       	call   80102230 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103127:	83 c4 0c             	add    $0xc,%esp
8010312a:	68 8a 00 00 00       	push   $0x8a
8010312f:	68 8c a4 10 80       	push   $0x8010a48c
80103134:	68 00 70 00 80       	push   $0x80007000
80103139:	e8 f2 15 00 00       	call   80104730 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
8010313e:	69 05 a0 3c 11 80 b0 	imul   $0xb0,0x80113ca0,%eax
80103145:	00 00 00 
80103148:	83 c4 10             	add    $0x10,%esp
8010314b:	05 20 37 11 80       	add    $0x80113720,%eax
80103150:	39 d8                	cmp    %ebx,%eax
80103152:	76 6f                	jbe    801031c3 <main+0x103>
80103154:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
80103158:	e8 e3 07 00 00       	call   80103940 <mycpu>
8010315d:	39 d8                	cmp    %ebx,%eax
8010315f:	74 49                	je     801031aa <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103161:	e8 8a f5 ff ff       	call   801026f0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80103166:	05 00 10 00 00       	add    $0x1000,%eax
    *(void**)(code-8) = mpenter;
8010316b:	c7 05 f8 6f 00 80 a0 	movl   $0x801030a0,0x80006ff8
80103172:	30 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103175:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
8010317c:	90 10 00 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
8010317f:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103184:	0f b6 03             	movzbl (%ebx),%eax
80103187:	83 ec 08             	sub    $0x8,%esp
8010318a:	68 00 70 00 00       	push   $0x7000
8010318f:	50                   	push   %eax
80103190:	e8 0b f8 ff ff       	call   801029a0 <lapicstartap>
80103195:	83 c4 10             	add    $0x10,%esp
80103198:	90                   	nop
80103199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801031a0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
801031a6:	85 c0                	test   %eax,%eax
801031a8:	74 f6                	je     801031a0 <main+0xe0>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
801031aa:	69 05 a0 3c 11 80 b0 	imul   $0xb0,0x80113ca0,%eax
801031b1:	00 00 00 
801031b4:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801031ba:	05 20 37 11 80       	add    $0x80113720,%eax
801031bf:	39 c3                	cmp    %eax,%ebx
801031c1:	72 95                	jb     80103158 <main+0x98>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk 
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801031c3:	83 ec 08             	sub    $0x8,%esp
801031c6:	68 00 00 00 8e       	push   $0x8e000000
801031cb:	68 00 00 40 80       	push   $0x80400000
801031d0:	e8 bb f4 ff ff       	call   80102690 <kinit2>
  userinit();      // first user process
801031d5:	e8 36 08 00 00       	call   80103a10 <userinit>
  mpmain();        // finish this processor's setup
801031da:	e8 81 fe ff ff       	call   80103060 <mpmain>
801031df:	90                   	nop

801031e0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801031e0:	55                   	push   %ebp
801031e1:	89 e5                	mov    %esp,%ebp
801031e3:	57                   	push   %edi
801031e4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801031e5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801031eb:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
801031ec:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801031ef:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
801031f2:	39 de                	cmp    %ebx,%esi
801031f4:	73 48                	jae    8010323e <mpsearch1+0x5e>
801031f6:	8d 76 00             	lea    0x0(%esi),%esi
801031f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103200:	83 ec 04             	sub    $0x4,%esp
80103203:	8d 7e 10             	lea    0x10(%esi),%edi
80103206:	6a 04                	push   $0x4
80103208:	68 58 77 10 80       	push   $0x80107758
8010320d:	56                   	push   %esi
8010320e:	e8 bd 14 00 00       	call   801046d0 <memcmp>
80103213:	83 c4 10             	add    $0x10,%esp
80103216:	85 c0                	test   %eax,%eax
80103218:	75 1e                	jne    80103238 <mpsearch1+0x58>
8010321a:	8d 7e 10             	lea    0x10(%esi),%edi
8010321d:	89 f2                	mov    %esi,%edx
8010321f:	31 c9                	xor    %ecx,%ecx
80103221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
80103228:	0f b6 02             	movzbl (%edx),%eax
8010322b:	83 c2 01             	add    $0x1,%edx
8010322e:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103230:	39 fa                	cmp    %edi,%edx
80103232:	75 f4                	jne    80103228 <mpsearch1+0x48>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103234:	84 c9                	test   %cl,%cl
80103236:	74 10                	je     80103248 <mpsearch1+0x68>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103238:	39 fb                	cmp    %edi,%ebx
8010323a:	89 fe                	mov    %edi,%esi
8010323c:	77 c2                	ja     80103200 <mpsearch1+0x20>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
8010323e:	8d 65 f4             	lea    -0xc(%ebp),%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103241:	31 c0                	xor    %eax,%eax
}
80103243:	5b                   	pop    %ebx
80103244:	5e                   	pop    %esi
80103245:	5f                   	pop    %edi
80103246:	5d                   	pop    %ebp
80103247:	c3                   	ret    
80103248:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010324b:	89 f0                	mov    %esi,%eax
8010324d:	5b                   	pop    %ebx
8010324e:	5e                   	pop    %esi
8010324f:	5f                   	pop    %edi
80103250:	5d                   	pop    %ebp
80103251:	c3                   	ret    
80103252:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103260 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103260:	55                   	push   %ebp
80103261:	89 e5                	mov    %esp,%ebp
80103263:	57                   	push   %edi
80103264:	56                   	push   %esi
80103265:	53                   	push   %ebx
80103266:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103269:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103270:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103277:	c1 e0 08             	shl    $0x8,%eax
8010327a:	09 d0                	or     %edx,%eax
8010327c:	c1 e0 04             	shl    $0x4,%eax
8010327f:	85 c0                	test   %eax,%eax
80103281:	75 1b                	jne    8010329e <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
80103283:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010328a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103291:	c1 e0 08             	shl    $0x8,%eax
80103294:	09 d0                	or     %edx,%eax
80103296:	c1 e0 0a             	shl    $0xa,%eax
80103299:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
8010329e:	ba 00 04 00 00       	mov    $0x400,%edx
801032a3:	e8 38 ff ff ff       	call   801031e0 <mpsearch1>
801032a8:	85 c0                	test   %eax,%eax
801032aa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801032ad:	0f 84 37 01 00 00    	je     801033ea <mpinit+0x18a>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801032b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801032b6:	8b 58 04             	mov    0x4(%eax),%ebx
801032b9:	85 db                	test   %ebx,%ebx
801032bb:	0f 84 43 01 00 00    	je     80103404 <mpinit+0x1a4>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801032c1:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
801032c7:	83 ec 04             	sub    $0x4,%esp
801032ca:	6a 04                	push   $0x4
801032cc:	68 5d 77 10 80       	push   $0x8010775d
801032d1:	56                   	push   %esi
801032d2:	e8 f9 13 00 00       	call   801046d0 <memcmp>
801032d7:	83 c4 10             	add    $0x10,%esp
801032da:	85 c0                	test   %eax,%eax
801032dc:	0f 85 22 01 00 00    	jne    80103404 <mpinit+0x1a4>
    return 0;
  if(conf->version != 1 && conf->version != 4)
801032e2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801032e9:	3c 01                	cmp    $0x1,%al
801032eb:	74 08                	je     801032f5 <mpinit+0x95>
801032ed:	3c 04                	cmp    $0x4,%al
801032ef:	0f 85 0f 01 00 00    	jne    80103404 <mpinit+0x1a4>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801032f5:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801032fc:	85 ff                	test   %edi,%edi
801032fe:	74 21                	je     80103321 <mpinit+0xc1>
80103300:	31 d2                	xor    %edx,%edx
80103302:	31 c0                	xor    %eax,%eax
80103304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103308:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
8010330f:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103310:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103313:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103315:	39 c7                	cmp    %eax,%edi
80103317:	75 ef                	jne    80103308 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80103319:	84 d2                	test   %dl,%dl
8010331b:	0f 85 e3 00 00 00    	jne    80103404 <mpinit+0x1a4>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103321:	85 f6                	test   %esi,%esi
80103323:	0f 84 db 00 00 00    	je     80103404 <mpinit+0x1a4>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103329:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
8010332f:	a3 1c 36 11 80       	mov    %eax,0x8011361c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103334:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
8010333b:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
80103341:	bb 01 00 00 00       	mov    $0x1,%ebx
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103346:	01 d6                	add    %edx,%esi
80103348:	90                   	nop
80103349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103350:	39 c6                	cmp    %eax,%esi
80103352:	76 23                	jbe    80103377 <mpinit+0x117>
80103354:	0f b6 10             	movzbl (%eax),%edx
    switch(*p){
80103357:	80 fa 04             	cmp    $0x4,%dl
8010335a:	0f 87 c0 00 00 00    	ja     80103420 <mpinit+0x1c0>
80103360:	ff 24 95 9c 77 10 80 	jmp    *-0x7fef8864(,%edx,4)
80103367:	89 f6                	mov    %esi,%esi
80103369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103370:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103373:	39 c6                	cmp    %eax,%esi
80103375:	77 dd                	ja     80103354 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103377:	85 db                	test   %ebx,%ebx
80103379:	0f 84 92 00 00 00    	je     80103411 <mpinit+0x1b1>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010337f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103382:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103386:	74 15                	je     8010339d <mpinit+0x13d>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103388:	ba 22 00 00 00       	mov    $0x22,%edx
8010338d:	b8 70 00 00 00       	mov    $0x70,%eax
80103392:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103393:	ba 23 00 00 00       	mov    $0x23,%edx
80103398:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103399:	83 c8 01             	or     $0x1,%eax
8010339c:	ee                   	out    %al,(%dx)
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
8010339d:	8d 65 f4             	lea    -0xc(%ebp),%esp
801033a0:	5b                   	pop    %ebx
801033a1:	5e                   	pop    %esi
801033a2:	5f                   	pop    %edi
801033a3:	5d                   	pop    %ebp
801033a4:	c3                   	ret    
801033a5:	8d 76 00             	lea    0x0(%esi),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
801033a8:	8b 0d a0 3c 11 80    	mov    0x80113ca0,%ecx
801033ae:	83 f9 07             	cmp    $0x7,%ecx
801033b1:	7f 19                	jg     801033cc <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801033b3:	0f b6 50 01          	movzbl 0x1(%eax),%edx
801033b7:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
801033bd:	83 c1 01             	add    $0x1,%ecx
801033c0:	89 0d a0 3c 11 80    	mov    %ecx,0x80113ca0
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801033c6:	88 97 20 37 11 80    	mov    %dl,-0x7feec8e0(%edi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
801033cc:	83 c0 14             	add    $0x14,%eax
      continue;
801033cf:	e9 7c ff ff ff       	jmp    80103350 <mpinit+0xf0>
801033d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
801033d8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801033dc:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
801033df:	88 15 00 37 11 80    	mov    %dl,0x80113700
      p += sizeof(struct mpioapic);
      continue;
801033e5:	e9 66 ff ff ff       	jmp    80103350 <mpinit+0xf0>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801033ea:	ba 00 00 01 00       	mov    $0x10000,%edx
801033ef:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801033f4:	e8 e7 fd ff ff       	call   801031e0 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801033f9:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801033fb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801033fe:	0f 85 af fe ff ff    	jne    801032b3 <mpinit+0x53>
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
80103404:	83 ec 0c             	sub    $0xc,%esp
80103407:	68 62 77 10 80       	push   $0x80107762
8010340c:	e8 5f cf ff ff       	call   80100370 <panic>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
80103411:	83 ec 0c             	sub    $0xc,%esp
80103414:	68 7c 77 10 80       	push   $0x8010777c
80103419:	e8 52 cf ff ff       	call   80100370 <panic>
8010341e:	66 90                	xchg   %ax,%ax
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
80103420:	31 db                	xor    %ebx,%ebx
80103422:	e9 30 ff ff ff       	jmp    80103357 <mpinit+0xf7>
80103427:	66 90                	xchg   %ax,%ax
80103429:	66 90                	xchg   %ax,%ax
8010342b:	66 90                	xchg   %ax,%ax
8010342d:	66 90                	xchg   %ax,%ax
8010342f:	90                   	nop

80103430 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103430:	55                   	push   %ebp
80103431:	ba 21 00 00 00       	mov    $0x21,%edx
80103436:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010343b:	89 e5                	mov    %esp,%ebp
8010343d:	ee                   	out    %al,(%dx)
8010343e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103443:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103444:	5d                   	pop    %ebp
80103445:	c3                   	ret    
80103446:	66 90                	xchg   %ax,%ax
80103448:	66 90                	xchg   %ax,%ax
8010344a:	66 90                	xchg   %ax,%ax
8010344c:	66 90                	xchg   %ax,%ax
8010344e:	66 90                	xchg   %ax,%ax

80103450 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103450:	55                   	push   %ebp
80103451:	89 e5                	mov    %esp,%ebp
80103453:	57                   	push   %edi
80103454:	56                   	push   %esi
80103455:	53                   	push   %ebx
80103456:	83 ec 0c             	sub    $0xc,%esp
80103459:	8b 75 08             	mov    0x8(%ebp),%esi
8010345c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010345f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103465:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010346b:	e8 60 db ff ff       	call   80100fd0 <filealloc>
80103470:	85 c0                	test   %eax,%eax
80103472:	89 06                	mov    %eax,(%esi)
80103474:	0f 84 a8 00 00 00    	je     80103522 <pipealloc+0xd2>
8010347a:	e8 51 db ff ff       	call   80100fd0 <filealloc>
8010347f:	85 c0                	test   %eax,%eax
80103481:	89 03                	mov    %eax,(%ebx)
80103483:	0f 84 87 00 00 00    	je     80103510 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103489:	e8 62 f2 ff ff       	call   801026f0 <kalloc>
8010348e:	85 c0                	test   %eax,%eax
80103490:	89 c7                	mov    %eax,%edi
80103492:	0f 84 b0 00 00 00    	je     80103548 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103498:	83 ec 08             	sub    $0x8,%esp
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
  p->readopen = 1;
8010349b:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801034a2:	00 00 00 
  p->writeopen = 1;
801034a5:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801034ac:	00 00 00 
  p->nwrite = 0;
801034af:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801034b6:	00 00 00 
  p->nread = 0;
801034b9:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801034c0:	00 00 00 
  initlock(&p->lock, "pipe");
801034c3:	68 b0 77 10 80       	push   $0x801077b0
801034c8:	50                   	push   %eax
801034c9:	e8 42 0f 00 00       	call   80104410 <initlock>
  (*f0)->type = FD_PIPE;
801034ce:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801034d0:	83 c4 10             	add    $0x10,%esp
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
801034d3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801034d9:	8b 06                	mov    (%esi),%eax
801034db:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801034df:	8b 06                	mov    (%esi),%eax
801034e1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801034e5:	8b 06                	mov    (%esi),%eax
801034e7:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801034ea:	8b 03                	mov    (%ebx),%eax
801034ec:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801034f2:	8b 03                	mov    (%ebx),%eax
801034f4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801034f8:	8b 03                	mov    (%ebx),%eax
801034fa:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801034fe:	8b 03                	mov    (%ebx),%eax
80103500:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103503:	8d 65 f4             	lea    -0xc(%ebp),%esp
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103506:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103508:	5b                   	pop    %ebx
80103509:	5e                   	pop    %esi
8010350a:	5f                   	pop    %edi
8010350b:	5d                   	pop    %ebp
8010350c:	c3                   	ret    
8010350d:	8d 76 00             	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80103510:	8b 06                	mov    (%esi),%eax
80103512:	85 c0                	test   %eax,%eax
80103514:	74 1e                	je     80103534 <pipealloc+0xe4>
    fileclose(*f0);
80103516:	83 ec 0c             	sub    $0xc,%esp
80103519:	50                   	push   %eax
8010351a:	e8 71 db ff ff       	call   80101090 <fileclose>
8010351f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103522:	8b 03                	mov    (%ebx),%eax
80103524:	85 c0                	test   %eax,%eax
80103526:	74 0c                	je     80103534 <pipealloc+0xe4>
    fileclose(*f1);
80103528:	83 ec 0c             	sub    $0xc,%esp
8010352b:	50                   	push   %eax
8010352c:	e8 5f db ff ff       	call   80101090 <fileclose>
80103531:	83 c4 10             	add    $0x10,%esp
  return -1;
}
80103534:	8d 65 f4             	lea    -0xc(%ebp),%esp
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
80103537:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010353c:	5b                   	pop    %ebx
8010353d:	5e                   	pop    %esi
8010353e:	5f                   	pop    %edi
8010353f:	5d                   	pop    %ebp
80103540:	c3                   	ret    
80103541:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80103548:	8b 06                	mov    (%esi),%eax
8010354a:	85 c0                	test   %eax,%eax
8010354c:	75 c8                	jne    80103516 <pipealloc+0xc6>
8010354e:	eb d2                	jmp    80103522 <pipealloc+0xd2>

80103550 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
80103550:	55                   	push   %ebp
80103551:	89 e5                	mov    %esp,%ebp
80103553:	56                   	push   %esi
80103554:	53                   	push   %ebx
80103555:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103558:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010355b:	83 ec 0c             	sub    $0xc,%esp
8010355e:	53                   	push   %ebx
8010355f:	e8 ac 0f 00 00       	call   80104510 <acquire>
  if(writable){
80103564:	83 c4 10             	add    $0x10,%esp
80103567:	85 f6                	test   %esi,%esi
80103569:	74 45                	je     801035b0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010356b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103571:	83 ec 0c             	sub    $0xc,%esp
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
80103574:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010357b:	00 00 00 
    wakeup(&p->nread);
8010357e:	50                   	push   %eax
8010357f:	e8 cc 0b 00 00       	call   80104150 <wakeup>
80103584:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103587:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010358d:	85 d2                	test   %edx,%edx
8010358f:	75 0a                	jne    8010359b <pipeclose+0x4b>
80103591:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103597:	85 c0                	test   %eax,%eax
80103599:	74 35                	je     801035d0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010359b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010359e:	8d 65 f8             	lea    -0x8(%ebp),%esp
801035a1:	5b                   	pop    %ebx
801035a2:	5e                   	pop    %esi
801035a3:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801035a4:	e9 87 10 00 00       	jmp    80104630 <release>
801035a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
801035b0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801035b6:	83 ec 0c             	sub    $0xc,%esp
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
801035b9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801035c0:	00 00 00 
    wakeup(&p->nwrite);
801035c3:	50                   	push   %eax
801035c4:	e8 87 0b 00 00       	call   80104150 <wakeup>
801035c9:	83 c4 10             	add    $0x10,%esp
801035cc:	eb b9                	jmp    80103587 <pipeclose+0x37>
801035ce:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
801035d0:	83 ec 0c             	sub    $0xc,%esp
801035d3:	53                   	push   %ebx
801035d4:	e8 57 10 00 00       	call   80104630 <release>
    kfree((char*)p);
801035d9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801035dc:	83 c4 10             	add    $0x10,%esp
  } else
    release(&p->lock);
}
801035df:	8d 65 f8             	lea    -0x8(%ebp),%esp
801035e2:	5b                   	pop    %ebx
801035e3:	5e                   	pop    %esi
801035e4:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
801035e5:	e9 56 ef ff ff       	jmp    80102540 <kfree>
801035ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801035f0 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801035f0:	55                   	push   %ebp
801035f1:	89 e5                	mov    %esp,%ebp
801035f3:	57                   	push   %edi
801035f4:	56                   	push   %esi
801035f5:	53                   	push   %ebx
801035f6:	83 ec 28             	sub    $0x28,%esp
801035f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801035fc:	53                   	push   %ebx
801035fd:	e8 0e 0f 00 00       	call   80104510 <acquire>
  for(i = 0; i < n; i++){
80103602:	8b 45 10             	mov    0x10(%ebp),%eax
80103605:	83 c4 10             	add    $0x10,%esp
80103608:	85 c0                	test   %eax,%eax
8010360a:	0f 8e b9 00 00 00    	jle    801036c9 <pipewrite+0xd9>
80103610:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103613:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103619:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010361f:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103625:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103628:	03 4d 10             	add    0x10(%ebp),%ecx
8010362b:	89 4d e0             	mov    %ecx,-0x20(%ebp)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010362e:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80103634:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
8010363a:	39 d0                	cmp    %edx,%eax
8010363c:	74 38                	je     80103676 <pipewrite+0x86>
8010363e:	eb 59                	jmp    80103699 <pipewrite+0xa9>
      if(p->readopen == 0 || myproc()->killed){
80103640:	e8 9b 03 00 00       	call   801039e0 <myproc>
80103645:	8b 48 24             	mov    0x24(%eax),%ecx
80103648:	85 c9                	test   %ecx,%ecx
8010364a:	75 34                	jne    80103680 <pipewrite+0x90>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
8010364c:	83 ec 0c             	sub    $0xc,%esp
8010364f:	57                   	push   %edi
80103650:	e8 fb 0a 00 00       	call   80104150 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103655:	58                   	pop    %eax
80103656:	5a                   	pop    %edx
80103657:	53                   	push   %ebx
80103658:	56                   	push   %esi
80103659:	e8 42 09 00 00       	call   80103fa0 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010365e:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103664:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010366a:	83 c4 10             	add    $0x10,%esp
8010366d:	05 00 02 00 00       	add    $0x200,%eax
80103672:	39 c2                	cmp    %eax,%edx
80103674:	75 2a                	jne    801036a0 <pipewrite+0xb0>
      if(p->readopen == 0 || myproc()->killed){
80103676:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010367c:	85 c0                	test   %eax,%eax
8010367e:	75 c0                	jne    80103640 <pipewrite+0x50>
        release(&p->lock);
80103680:	83 ec 0c             	sub    $0xc,%esp
80103683:	53                   	push   %ebx
80103684:	e8 a7 0f 00 00       	call   80104630 <release>
        return -1;
80103689:	83 c4 10             	add    $0x10,%esp
8010368c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103691:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103694:	5b                   	pop    %ebx
80103695:	5e                   	pop    %esi
80103696:	5f                   	pop    %edi
80103697:	5d                   	pop    %ebp
80103698:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103699:	89 c2                	mov    %eax,%edx
8010369b:	90                   	nop
8010369c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801036a0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801036a3:	8d 42 01             	lea    0x1(%edx),%eax
801036a6:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
801036aa:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801036b0:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801036b6:	0f b6 09             	movzbl (%ecx),%ecx
801036b9:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
801036bd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
801036c0:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
801036c3:	0f 85 65 ff ff ff    	jne    8010362e <pipewrite+0x3e>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801036c9:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801036cf:	83 ec 0c             	sub    $0xc,%esp
801036d2:	50                   	push   %eax
801036d3:	e8 78 0a 00 00       	call   80104150 <wakeup>
  release(&p->lock);
801036d8:	89 1c 24             	mov    %ebx,(%esp)
801036db:	e8 50 0f 00 00       	call   80104630 <release>
  return n;
801036e0:	83 c4 10             	add    $0x10,%esp
801036e3:	8b 45 10             	mov    0x10(%ebp),%eax
801036e6:	eb a9                	jmp    80103691 <pipewrite+0xa1>
801036e8:	90                   	nop
801036e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801036f0 <piperead>:
}

int
piperead(struct pipe *p, char *addr, int n)
{
801036f0:	55                   	push   %ebp
801036f1:	89 e5                	mov    %esp,%ebp
801036f3:	57                   	push   %edi
801036f4:	56                   	push   %esi
801036f5:	53                   	push   %ebx
801036f6:	83 ec 18             	sub    $0x18,%esp
801036f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801036fc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801036ff:	53                   	push   %ebx
80103700:	e8 0b 0e 00 00       	call   80104510 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103705:	83 c4 10             	add    $0x10,%esp
80103708:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010370e:	39 83 38 02 00 00    	cmp    %eax,0x238(%ebx)
80103714:	75 6a                	jne    80103780 <piperead+0x90>
80103716:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
8010371c:	85 f6                	test   %esi,%esi
8010371e:	0f 84 cc 00 00 00    	je     801037f0 <piperead+0x100>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103724:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
8010372a:	eb 2d                	jmp    80103759 <piperead+0x69>
8010372c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103730:	83 ec 08             	sub    $0x8,%esp
80103733:	53                   	push   %ebx
80103734:	56                   	push   %esi
80103735:	e8 66 08 00 00       	call   80103fa0 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010373a:	83 c4 10             	add    $0x10,%esp
8010373d:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103743:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
80103749:	75 35                	jne    80103780 <piperead+0x90>
8010374b:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
80103751:	85 d2                	test   %edx,%edx
80103753:	0f 84 97 00 00 00    	je     801037f0 <piperead+0x100>
    if(myproc()->killed){
80103759:	e8 82 02 00 00       	call   801039e0 <myproc>
8010375e:	8b 48 24             	mov    0x24(%eax),%ecx
80103761:	85 c9                	test   %ecx,%ecx
80103763:	74 cb                	je     80103730 <piperead+0x40>
      release(&p->lock);
80103765:	83 ec 0c             	sub    $0xc,%esp
80103768:	53                   	push   %ebx
80103769:	e8 c2 0e 00 00       	call   80104630 <release>
      return -1;
8010376e:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103771:	8d 65 f4             	lea    -0xc(%ebp),%esp

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(myproc()->killed){
      release(&p->lock);
      return -1;
80103774:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103779:	5b                   	pop    %ebx
8010377a:	5e                   	pop    %esi
8010377b:	5f                   	pop    %edi
8010377c:	5d                   	pop    %ebp
8010377d:	c3                   	ret    
8010377e:	66 90                	xchg   %ax,%ax
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103780:	8b 45 10             	mov    0x10(%ebp),%eax
80103783:	85 c0                	test   %eax,%eax
80103785:	7e 69                	jle    801037f0 <piperead+0x100>
    if(p->nread == p->nwrite)
80103787:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010378d:	31 c9                	xor    %ecx,%ecx
8010378f:	eb 15                	jmp    801037a6 <piperead+0xb6>
80103791:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103798:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010379e:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
801037a4:	74 5a                	je     80103800 <piperead+0x110>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801037a6:	8d 70 01             	lea    0x1(%eax),%esi
801037a9:	25 ff 01 00 00       	and    $0x1ff,%eax
801037ae:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
801037b4:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
801037b9:	88 04 0f             	mov    %al,(%edi,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801037bc:	83 c1 01             	add    $0x1,%ecx
801037bf:	39 4d 10             	cmp    %ecx,0x10(%ebp)
801037c2:	75 d4                	jne    80103798 <piperead+0xa8>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801037c4:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801037ca:	83 ec 0c             	sub    $0xc,%esp
801037cd:	50                   	push   %eax
801037ce:	e8 7d 09 00 00       	call   80104150 <wakeup>
  release(&p->lock);
801037d3:	89 1c 24             	mov    %ebx,(%esp)
801037d6:	e8 55 0e 00 00       	call   80104630 <release>
  return i;
801037db:	8b 45 10             	mov    0x10(%ebp),%eax
801037de:	83 c4 10             	add    $0x10,%esp
}
801037e1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801037e4:	5b                   	pop    %ebx
801037e5:	5e                   	pop    %esi
801037e6:	5f                   	pop    %edi
801037e7:	5d                   	pop    %ebp
801037e8:	c3                   	ret    
801037e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801037f0:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
801037f7:	eb cb                	jmp    801037c4 <piperead+0xd4>
801037f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103800:	89 4d 10             	mov    %ecx,0x10(%ebp)
80103803:	eb bf                	jmp    801037c4 <piperead+0xd4>
80103805:	66 90                	xchg   %ax,%ax
80103807:	66 90                	xchg   %ax,%ax
80103809:	66 90                	xchg   %ax,%ax
8010380b:	66 90                	xchg   %ax,%ax
8010380d:	66 90                	xchg   %ax,%ax
8010380f:	90                   	nop

80103810 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103810:	55                   	push   %ebp
80103811:	89 e5                	mov    %esp,%ebp
80103813:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103814:	bb f4 3c 11 80       	mov    $0x80113cf4,%ebx
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103819:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
8010381c:	68 c0 3c 11 80       	push   $0x80113cc0
80103821:	e8 ea 0c 00 00       	call   80104510 <acquire>
80103826:	83 c4 10             	add    $0x10,%esp
80103829:	eb 10                	jmp    8010383b <allocproc+0x2b>
8010382b:	90                   	nop
8010382c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103830:	83 c3 7c             	add    $0x7c,%ebx
80103833:	81 fb f4 5b 11 80    	cmp    $0x80115bf4,%ebx
80103839:	74 75                	je     801038b0 <allocproc+0xa0>
    if(p->state == UNUSED)
8010383b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010383e:	85 c0                	test   %eax,%eax
80103840:	75 ee                	jne    80103830 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103842:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
80103847:	83 ec 0c             	sub    $0xc,%esp

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
8010384a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;

  release(&ptable.lock);
80103851:	68 c0 3c 11 80       	push   $0x80113cc0
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103856:	8d 50 01             	lea    0x1(%eax),%edx
80103859:	89 43 10             	mov    %eax,0x10(%ebx)
8010385c:	89 15 04 a0 10 80    	mov    %edx,0x8010a004

  release(&ptable.lock);
80103862:	e8 c9 0d 00 00       	call   80104630 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103867:	e8 84 ee ff ff       	call   801026f0 <kalloc>
8010386c:	83 c4 10             	add    $0x10,%esp
8010386f:	85 c0                	test   %eax,%eax
80103871:	89 43 08             	mov    %eax,0x8(%ebx)
80103874:	74 51                	je     801038c7 <allocproc+0xb7>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103876:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010387c:	83 ec 04             	sub    $0x4,%esp
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
8010387f:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103884:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
80103887:	c7 40 14 c0 59 10 80 	movl   $0x801059c0,0x14(%eax)

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010388e:	6a 14                	push   $0x14
80103890:	6a 00                	push   $0x0
80103892:	50                   	push   %eax
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
80103893:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103896:	e8 e5 0d 00 00       	call   80104680 <memset>
  p->context->eip = (uint)forkret;
8010389b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010389e:	83 c4 10             	add    $0x10,%esp
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
801038a1:	c7 40 10 d0 38 10 80 	movl   $0x801038d0,0x10(%eax)

  return p;
801038a8:	89 d8                	mov    %ebx,%eax
}
801038aa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801038ad:	c9                   	leave  
801038ae:	c3                   	ret    
801038af:	90                   	nop

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
801038b0:	83 ec 0c             	sub    $0xc,%esp
801038b3:	68 c0 3c 11 80       	push   $0x80113cc0
801038b8:	e8 73 0d 00 00       	call   80104630 <release>
  return 0;
801038bd:	83 c4 10             	add    $0x10,%esp
801038c0:	31 c0                	xor    %eax,%eax
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
801038c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801038c5:	c9                   	leave  
801038c6:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
801038c7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801038ce:	eb da                	jmp    801038aa <allocproc+0x9a>

801038d0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801038d0:	55                   	push   %ebp
801038d1:	89 e5                	mov    %esp,%ebp
801038d3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801038d6:	68 c0 3c 11 80       	push   $0x80113cc0
801038db:	e8 50 0d 00 00       	call   80104630 <release>

  if (first) {
801038e0:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801038e5:	83 c4 10             	add    $0x10,%esp
801038e8:	85 c0                	test   %eax,%eax
801038ea:	75 04                	jne    801038f0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801038ec:	c9                   	leave  
801038ed:	c3                   	ret    
801038ee:	66 90                	xchg   %ax,%ax
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
801038f0:	83 ec 0c             	sub    $0xc,%esp

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
801038f3:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
801038fa:	00 00 00 
    iinit(ROOTDEV);
801038fd:	6a 01                	push   $0x1
801038ff:	e8 cc dd ff ff       	call   801016d0 <iinit>
    initlog(ROOTDEV);
80103904:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010390b:	e8 00 f4 ff ff       	call   80102d10 <initlog>
80103910:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103913:	c9                   	leave  
80103914:	c3                   	ret    
80103915:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103920 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80103920:	55                   	push   %ebp
80103921:	89 e5                	mov    %esp,%ebp
80103923:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103926:	68 b5 77 10 80       	push   $0x801077b5
8010392b:	68 c0 3c 11 80       	push   $0x80113cc0
80103930:	e8 db 0a 00 00       	call   80104410 <initlock>
}
80103935:	83 c4 10             	add    $0x10,%esp
80103938:	c9                   	leave  
80103939:	c3                   	ret    
8010393a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103940 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
80103940:	55                   	push   %ebp
80103941:	89 e5                	mov    %esp,%ebp
80103943:	56                   	push   %esi
80103944:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103945:	9c                   	pushf  
80103946:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
80103947:	f6 c4 02             	test   $0x2,%ah
8010394a:	75 5b                	jne    801039a7 <mycpu+0x67>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
8010394c:	e8 ff ef ff ff       	call   80102950 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103951:	8b 35 a0 3c 11 80    	mov    0x80113ca0,%esi
80103957:	85 f6                	test   %esi,%esi
80103959:	7e 3f                	jle    8010399a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
8010395b:	0f b6 15 20 37 11 80 	movzbl 0x80113720,%edx
80103962:	39 d0                	cmp    %edx,%eax
80103964:	74 30                	je     80103996 <mycpu+0x56>
80103966:	b9 d0 37 11 80       	mov    $0x801137d0,%ecx
8010396b:	31 d2                	xor    %edx,%edx
8010396d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103970:	83 c2 01             	add    $0x1,%edx
80103973:	39 f2                	cmp    %esi,%edx
80103975:	74 23                	je     8010399a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
80103977:	0f b6 19             	movzbl (%ecx),%ebx
8010397a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103980:	39 d8                	cmp    %ebx,%eax
80103982:	75 ec                	jne    80103970 <mycpu+0x30>
      return &cpus[i];
80103984:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
  }
  panic("unknown apicid\n");
}
8010398a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010398d:	5b                   	pop    %ebx
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
8010398e:	05 20 37 11 80       	add    $0x80113720,%eax
  }
  panic("unknown apicid\n");
}
80103993:	5e                   	pop    %esi
80103994:	5d                   	pop    %ebp
80103995:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103996:	31 d2                	xor    %edx,%edx
80103998:	eb ea                	jmp    80103984 <mycpu+0x44>
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
8010399a:	83 ec 0c             	sub    $0xc,%esp
8010399d:	68 bc 77 10 80       	push   $0x801077bc
801039a2:	e8 c9 c9 ff ff       	call   80100370 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
801039a7:	83 ec 0c             	sub    $0xc,%esp
801039aa:	68 98 78 10 80       	push   $0x80107898
801039af:	e8 bc c9 ff ff       	call   80100370 <panic>
801039b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801039ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801039c0 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
801039c0:	55                   	push   %ebp
801039c1:	89 e5                	mov    %esp,%ebp
801039c3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801039c6:	e8 75 ff ff ff       	call   80103940 <mycpu>
801039cb:	2d 20 37 11 80       	sub    $0x80113720,%eax
}
801039d0:	c9                   	leave  
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
801039d1:	c1 f8 04             	sar    $0x4,%eax
801039d4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801039da:	c3                   	ret    
801039db:	90                   	nop
801039dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801039e0 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
801039e0:	55                   	push   %ebp
801039e1:	89 e5                	mov    %esp,%ebp
801039e3:	53                   	push   %ebx
801039e4:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
801039e7:	e8 e4 0a 00 00       	call   801044d0 <pushcli>
  c = mycpu();
801039ec:	e8 4f ff ff ff       	call   80103940 <mycpu>
  p = c->proc;
801039f1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039f7:	e8 c4 0b 00 00       	call   801045c0 <popcli>
  return p;
}
801039fc:	83 c4 04             	add    $0x4,%esp
801039ff:	89 d8                	mov    %ebx,%eax
80103a01:	5b                   	pop    %ebx
80103a02:	5d                   	pop    %ebp
80103a03:	c3                   	ret    
80103a04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103a0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103a10 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80103a10:	55                   	push   %ebp
80103a11:	89 e5                	mov    %esp,%ebp
80103a13:	53                   	push   %ebx
80103a14:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
80103a17:	e8 f4 fd ff ff       	call   80103810 <allocproc>
80103a1c:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
80103a1e:	a3 58 b5 10 80       	mov    %eax,0x8010b558
  if((p->pgdir = setupkvm()) == 0)
80103a23:	e8 88 35 00 00       	call   80106fb0 <setupkvm>
80103a28:	85 c0                	test   %eax,%eax
80103a2a:	89 43 04             	mov    %eax,0x4(%ebx)
80103a2d:	0f 84 bd 00 00 00    	je     80103af0 <userinit+0xe0>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103a33:	83 ec 04             	sub    $0x4,%esp
80103a36:	68 2c 00 00 00       	push   $0x2c
80103a3b:	68 60 a4 10 80       	push   $0x8010a460
80103a40:	50                   	push   %eax
80103a41:	e8 7a 32 00 00       	call   80106cc0 <inituvm>
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
80103a46:	83 c4 0c             	add    $0xc,%esp
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
80103a49:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103a4f:	6a 4c                	push   $0x4c
80103a51:	6a 00                	push   $0x0
80103a53:	ff 73 18             	pushl  0x18(%ebx)
80103a56:	e8 25 0c 00 00       	call   80104680 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a5b:	8b 43 18             	mov    0x18(%ebx),%eax
80103a5e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a63:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a68:	83 c4 0c             	add    $0xc,%esp
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a6b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a6f:	8b 43 18             	mov    0x18(%ebx),%eax
80103a72:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103a76:	8b 43 18             	mov    0x18(%ebx),%eax
80103a79:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a7d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103a81:	8b 43 18             	mov    0x18(%ebx),%eax
80103a84:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a88:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103a8c:	8b 43 18             	mov    0x18(%ebx),%eax
80103a8f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103a96:	8b 43 18             	mov    0x18(%ebx),%eax
80103a99:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103aa0:	8b 43 18             	mov    0x18(%ebx),%eax
80103aa3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103aaa:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103aad:	6a 10                	push   $0x10
80103aaf:	68 e5 77 10 80       	push   $0x801077e5
80103ab4:	50                   	push   %eax
80103ab5:	e8 c6 0d 00 00       	call   80104880 <safestrcpy>
  p->cwd = namei("/");
80103aba:	c7 04 24 ee 77 10 80 	movl   $0x801077ee,(%esp)
80103ac1:	e8 5a e6 ff ff       	call   80102120 <namei>
80103ac6:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80103ac9:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103ad0:	e8 3b 0a 00 00       	call   80104510 <acquire>

  p->state = RUNNABLE;
80103ad5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
80103adc:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103ae3:	e8 48 0b 00 00       	call   80104630 <release>
}
80103ae8:	83 c4 10             	add    $0x10,%esp
80103aeb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103aee:	c9                   	leave  
80103aef:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
80103af0:	83 ec 0c             	sub    $0xc,%esp
80103af3:	68 cc 77 10 80       	push   $0x801077cc
80103af8:	e8 73 c8 ff ff       	call   80100370 <panic>
80103afd:	8d 76 00             	lea    0x0(%esi),%esi

80103b00 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80103b00:	55                   	push   %ebp
80103b01:	89 e5                	mov    %esp,%ebp
80103b03:	56                   	push   %esi
80103b04:	53                   	push   %ebx
80103b05:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103b08:	e8 c3 09 00 00       	call   801044d0 <pushcli>
  c = mycpu();
80103b0d:	e8 2e fe ff ff       	call   80103940 <mycpu>
  p = c->proc;
80103b12:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b18:	e8 a3 0a 00 00       	call   801045c0 <popcli>
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
80103b1d:	83 fe 00             	cmp    $0x0,%esi
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
80103b20:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103b22:	7e 34                	jle    80103b58 <growproc+0x58>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103b24:	83 ec 04             	sub    $0x4,%esp
80103b27:	01 c6                	add    %eax,%esi
80103b29:	56                   	push   %esi
80103b2a:	50                   	push   %eax
80103b2b:	ff 73 04             	pushl  0x4(%ebx)
80103b2e:	e8 cd 32 00 00       	call   80106e00 <allocuvm>
80103b33:	83 c4 10             	add    $0x10,%esp
80103b36:	85 c0                	test   %eax,%eax
80103b38:	74 36                	je     80103b70 <growproc+0x70>
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
80103b3a:	83 ec 0c             	sub    $0xc,%esp
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
80103b3d:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103b3f:	53                   	push   %ebx
80103b40:	e8 6b 30 00 00       	call   80106bb0 <switchuvm>
  return 0;
80103b45:	83 c4 10             	add    $0x10,%esp
80103b48:	31 c0                	xor    %eax,%eax
}
80103b4a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103b4d:	5b                   	pop    %ebx
80103b4e:	5e                   	pop    %esi
80103b4f:	5d                   	pop    %ebp
80103b50:	c3                   	ret    
80103b51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80103b58:	74 e0                	je     80103b3a <growproc+0x3a>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103b5a:	83 ec 04             	sub    $0x4,%esp
80103b5d:	01 c6                	add    %eax,%esi
80103b5f:	56                   	push   %esi
80103b60:	50                   	push   %eax
80103b61:	ff 73 04             	pushl  0x4(%ebx)
80103b64:	e8 97 33 00 00       	call   80106f00 <deallocuvm>
80103b69:	83 c4 10             	add    $0x10,%esp
80103b6c:	85 c0                	test   %eax,%eax
80103b6e:	75 ca                	jne    80103b3a <growproc+0x3a>
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
80103b70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b75:	eb d3                	jmp    80103b4a <growproc+0x4a>
80103b77:	89 f6                	mov    %esi,%esi
80103b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b80 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103b80:	55                   	push   %ebp
80103b81:	89 e5                	mov    %esp,%ebp
80103b83:	57                   	push   %edi
80103b84:	56                   	push   %esi
80103b85:	53                   	push   %ebx
80103b86:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103b89:	e8 42 09 00 00       	call   801044d0 <pushcli>
  c = mycpu();
80103b8e:	e8 ad fd ff ff       	call   80103940 <mycpu>
  p = c->proc;
80103b93:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b99:	e8 22 0a 00 00       	call   801045c0 <popcli>
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
80103b9e:	e8 6d fc ff ff       	call   80103810 <allocproc>
80103ba3:	85 c0                	test   %eax,%eax
80103ba5:	89 c7                	mov    %eax,%edi
80103ba7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103baa:	0f 84 b5 00 00 00    	je     80103c65 <fork+0xe5>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103bb0:	83 ec 08             	sub    $0x8,%esp
80103bb3:	ff 33                	pushl  (%ebx)
80103bb5:	ff 73 04             	pushl  0x4(%ebx)
80103bb8:	e8 c3 34 00 00       	call   80107080 <copyuvm>
80103bbd:	83 c4 10             	add    $0x10,%esp
80103bc0:	85 c0                	test   %eax,%eax
80103bc2:	89 47 04             	mov    %eax,0x4(%edi)
80103bc5:	0f 84 a1 00 00 00    	je     80103c6c <fork+0xec>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
80103bcb:	8b 03                	mov    (%ebx),%eax
80103bcd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103bd0:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103bd2:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103bd5:	89 c8                	mov    %ecx,%eax
80103bd7:	8b 79 18             	mov    0x18(%ecx),%edi
80103bda:	8b 73 18             	mov    0x18(%ebx),%esi
80103bdd:	b9 13 00 00 00       	mov    $0x13,%ecx
80103be2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103be4:	31 f6                	xor    %esi,%esi
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103be6:	8b 40 18             	mov    0x18(%eax),%eax
80103be9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
80103bf0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103bf4:	85 c0                	test   %eax,%eax
80103bf6:	74 13                	je     80103c0b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103bf8:	83 ec 0c             	sub    $0xc,%esp
80103bfb:	50                   	push   %eax
80103bfc:	e8 3f d4 ff ff       	call   80101040 <filedup>
80103c01:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103c04:	83 c4 10             	add    $0x10,%esp
80103c07:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103c0b:	83 c6 01             	add    $0x1,%esi
80103c0e:	83 fe 10             	cmp    $0x10,%esi
80103c11:	75 dd                	jne    80103bf0 <fork+0x70>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103c13:	83 ec 0c             	sub    $0xc,%esp
80103c16:	ff 73 68             	pushl  0x68(%ebx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c19:	83 c3 6c             	add    $0x6c,%ebx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103c1c:	e8 7f dc ff ff       	call   801018a0 <idup>
80103c21:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c24:	83 c4 0c             	add    $0xc,%esp
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103c27:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c2a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103c2d:	6a 10                	push   $0x10
80103c2f:	53                   	push   %ebx
80103c30:	50                   	push   %eax
80103c31:	e8 4a 0c 00 00       	call   80104880 <safestrcpy>

  pid = np->pid;
80103c36:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
80103c39:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103c40:	e8 cb 08 00 00       	call   80104510 <acquire>

  np->state = RUNNABLE;
80103c45:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
80103c4c:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103c53:	e8 d8 09 00 00       	call   80104630 <release>

  return pid;
80103c58:	83 c4 10             	add    $0x10,%esp
80103c5b:	89 d8                	mov    %ebx,%eax
}
80103c5d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c60:	5b                   	pop    %ebx
80103c61:	5e                   	pop    %esi
80103c62:	5f                   	pop    %edi
80103c63:	5d                   	pop    %ebp
80103c64:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103c65:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103c6a:	eb f1                	jmp    80103c5d <fork+0xdd>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
80103c6c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103c6f:	83 ec 0c             	sub    $0xc,%esp
80103c72:	ff 77 08             	pushl  0x8(%edi)
80103c75:	e8 c6 e8 ff ff       	call   80102540 <kfree>
    np->kstack = 0;
80103c7a:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103c81:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103c88:	83 c4 10             	add    $0x10,%esp
80103c8b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103c90:	eb cb                	jmp    80103c5d <fork+0xdd>
80103c92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ca0 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103ca0:	55                   	push   %ebp
80103ca1:	89 e5                	mov    %esp,%ebp
80103ca3:	57                   	push   %edi
80103ca4:	56                   	push   %esi
80103ca5:	53                   	push   %ebx
80103ca6:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80103ca9:	e8 92 fc ff ff       	call   80103940 <mycpu>
80103cae:	8d 78 04             	lea    0x4(%eax),%edi
80103cb1:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103cb3:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103cba:	00 00 00 
80103cbd:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103cc0:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103cc1:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103cc4:	bb f4 3c 11 80       	mov    $0x80113cf4,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103cc9:	68 c0 3c 11 80       	push   $0x80113cc0
80103cce:	e8 3d 08 00 00       	call   80104510 <acquire>
80103cd3:	83 c4 10             	add    $0x10,%esp
80103cd6:	eb 13                	jmp    80103ceb <scheduler+0x4b>
80103cd8:	90                   	nop
80103cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ce0:	83 c3 7c             	add    $0x7c,%ebx
80103ce3:	81 fb f4 5b 11 80    	cmp    $0x80115bf4,%ebx
80103ce9:	74 45                	je     80103d30 <scheduler+0x90>
      if(p->state != RUNNABLE)
80103ceb:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103cef:	75 ef                	jne    80103ce0 <scheduler+0x40>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103cf1:	83 ec 0c             	sub    $0xc,%esp
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
80103cf4:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103cfa:	53                   	push   %ebx
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103cfb:	83 c3 7c             	add    $0x7c,%ebx

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103cfe:	e8 ad 2e 00 00       	call   80106bb0 <switchuvm>
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
80103d03:	58                   	pop    %eax
80103d04:	5a                   	pop    %edx
80103d05:	ff 73 a0             	pushl  -0x60(%ebx)
80103d08:	57                   	push   %edi
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103d09:	c7 43 90 04 00 00 00 	movl   $0x4,-0x70(%ebx)

      swtch(&(c->scheduler), p->context);
80103d10:	e8 c6 0b 00 00       	call   801048db <swtch>
      switchkvm();
80103d15:	e8 76 2e 00 00       	call   80106b90 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103d1a:	83 c4 10             	add    $0x10,%esp
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d1d:	81 fb f4 5b 11 80    	cmp    $0x80115bf4,%ebx
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103d23:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103d2a:	00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d2d:	75 bc                	jne    80103ceb <scheduler+0x4b>
80103d2f:	90                   	nop

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
80103d30:	83 ec 0c             	sub    $0xc,%esp
80103d33:	68 c0 3c 11 80       	push   $0x80113cc0
80103d38:	e8 f3 08 00 00       	call   80104630 <release>

  }
80103d3d:	83 c4 10             	add    $0x10,%esp
80103d40:	e9 7b ff ff ff       	jmp    80103cc0 <scheduler+0x20>
80103d45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103d50 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103d50:	55                   	push   %ebp
80103d51:	89 e5                	mov    %esp,%ebp
80103d53:	56                   	push   %esi
80103d54:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103d55:	e8 76 07 00 00       	call   801044d0 <pushcli>
  c = mycpu();
80103d5a:	e8 e1 fb ff ff       	call   80103940 <mycpu>
  p = c->proc;
80103d5f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d65:	e8 56 08 00 00       	call   801045c0 <popcli>
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
80103d6a:	83 ec 0c             	sub    $0xc,%esp
80103d6d:	68 c0 3c 11 80       	push   $0x80113cc0
80103d72:	e8 19 07 00 00       	call   80104490 <holding>
80103d77:	83 c4 10             	add    $0x10,%esp
80103d7a:	85 c0                	test   %eax,%eax
80103d7c:	74 4f                	je     80103dcd <sched+0x7d>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
80103d7e:	e8 bd fb ff ff       	call   80103940 <mycpu>
80103d83:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103d8a:	75 68                	jne    80103df4 <sched+0xa4>
    panic("sched locks");
  if(p->state == RUNNING)
80103d8c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103d90:	74 55                	je     80103de7 <sched+0x97>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103d92:	9c                   	pushf  
80103d93:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
80103d94:	f6 c4 02             	test   $0x2,%ah
80103d97:	75 41                	jne    80103dda <sched+0x8a>
    panic("sched interruptible");
  intena = mycpu()->intena;
80103d99:	e8 a2 fb ff ff       	call   80103940 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103d9e:	83 c3 1c             	add    $0x1c,%ebx
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
80103da1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103da7:	e8 94 fb ff ff       	call   80103940 <mycpu>
80103dac:	83 ec 08             	sub    $0x8,%esp
80103daf:	ff 70 04             	pushl  0x4(%eax)
80103db2:	53                   	push   %ebx
80103db3:	e8 23 0b 00 00       	call   801048db <swtch>
  mycpu()->intena = intena;
80103db8:	e8 83 fb ff ff       	call   80103940 <mycpu>
}
80103dbd:	83 c4 10             	add    $0x10,%esp
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
80103dc0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103dc6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103dc9:	5b                   	pop    %ebx
80103dca:	5e                   	pop    %esi
80103dcb:	5d                   	pop    %ebp
80103dcc:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103dcd:	83 ec 0c             	sub    $0xc,%esp
80103dd0:	68 f0 77 10 80       	push   $0x801077f0
80103dd5:	e8 96 c5 ff ff       	call   80100370 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103dda:	83 ec 0c             	sub    $0xc,%esp
80103ddd:	68 1c 78 10 80       	push   $0x8010781c
80103de2:	e8 89 c5 ff ff       	call   80100370 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
80103de7:	83 ec 0c             	sub    $0xc,%esp
80103dea:	68 0e 78 10 80       	push   $0x8010780e
80103def:	e8 7c c5 ff ff       	call   80100370 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80103df4:	83 ec 0c             	sub    $0xc,%esp
80103df7:	68 02 78 10 80       	push   $0x80107802
80103dfc:	e8 6f c5 ff ff       	call   80100370 <panic>
80103e01:	eb 0d                	jmp    80103e10 <exit>
80103e03:	90                   	nop
80103e04:	90                   	nop
80103e05:	90                   	nop
80103e06:	90                   	nop
80103e07:	90                   	nop
80103e08:	90                   	nop
80103e09:	90                   	nop
80103e0a:	90                   	nop
80103e0b:	90                   	nop
80103e0c:	90                   	nop
80103e0d:	90                   	nop
80103e0e:	90                   	nop
80103e0f:	90                   	nop

80103e10 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103e10:	55                   	push   %ebp
80103e11:	89 e5                	mov    %esp,%ebp
80103e13:	57                   	push   %edi
80103e14:	56                   	push   %esi
80103e15:	53                   	push   %ebx
80103e16:	83 ec 0c             	sub    $0xc,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103e19:	e8 b2 06 00 00       	call   801044d0 <pushcli>
  c = mycpu();
80103e1e:	e8 1d fb ff ff       	call   80103940 <mycpu>
  p = c->proc;
80103e23:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103e29:	e8 92 07 00 00       	call   801045c0 <popcli>
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  freescreen(curproc->pid);
80103e2e:	83 ec 0c             	sub    $0xc,%esp
80103e31:	ff 76 10             	pushl  0x10(%esi)
80103e34:	8d 5e 28             	lea    0x28(%esi),%ebx
80103e37:	8d 7e 68             	lea    0x68(%esi),%edi
80103e3a:	e8 c1 ca ff ff       	call   80100900 <freescreen>

  if(curproc == initproc)
80103e3f:	83 c4 10             	add    $0x10,%esp
80103e42:	39 35 58 b5 10 80    	cmp    %esi,0x8010b558
80103e48:	0f 84 e9 00 00 00    	je     80103f37 <exit+0x127>
80103e4e:	66 90                	xchg   %ax,%ax
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
80103e50:	8b 03                	mov    (%ebx),%eax
80103e52:	85 c0                	test   %eax,%eax
80103e54:	74 12                	je     80103e68 <exit+0x58>
      fileclose(curproc->ofile[fd]);
80103e56:	83 ec 0c             	sub    $0xc,%esp
80103e59:	50                   	push   %eax
80103e5a:	e8 31 d2 ff ff       	call   80101090 <fileclose>
      curproc->ofile[fd] = 0;
80103e5f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103e65:	83 c4 10             	add    $0x10,%esp
80103e68:	83 c3 04             	add    $0x4,%ebx

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103e6b:	39 df                	cmp    %ebx,%edi
80103e6d:	75 e1                	jne    80103e50 <exit+0x40>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
80103e6f:	e8 3c ef ff ff       	call   80102db0 <begin_op>
  iput(curproc->cwd);
80103e74:	83 ec 0c             	sub    $0xc,%esp
80103e77:	ff 76 68             	pushl  0x68(%esi)
80103e7a:	e8 81 db ff ff       	call   80101a00 <iput>
  end_op();
80103e7f:	e8 9c ef ff ff       	call   80102e20 <end_op>
  curproc->cwd = 0;
80103e84:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)

  acquire(&ptable.lock);
80103e8b:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103e92:	e8 79 06 00 00       	call   80104510 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80103e97:	8b 56 14             	mov    0x14(%esi),%edx
80103e9a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e9d:	b8 f4 3c 11 80       	mov    $0x80113cf4,%eax
80103ea2:	eb 0e                	jmp    80103eb2 <exit+0xa2>
80103ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ea8:	83 c0 7c             	add    $0x7c,%eax
80103eab:	3d f4 5b 11 80       	cmp    $0x80115bf4,%eax
80103eb0:	74 1c                	je     80103ece <exit+0xbe>
    if(p->state == SLEEPING && p->chan == chan)
80103eb2:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103eb6:	75 f0                	jne    80103ea8 <exit+0x98>
80103eb8:	3b 50 20             	cmp    0x20(%eax),%edx
80103ebb:	75 eb                	jne    80103ea8 <exit+0x98>
      p->state = RUNNABLE;
80103ebd:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ec4:	83 c0 7c             	add    $0x7c,%eax
80103ec7:	3d f4 5b 11 80       	cmp    $0x80115bf4,%eax
80103ecc:	75 e4                	jne    80103eb2 <exit+0xa2>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103ece:	8b 0d 58 b5 10 80    	mov    0x8010b558,%ecx
80103ed4:	ba f4 3c 11 80       	mov    $0x80113cf4,%edx
80103ed9:	eb 10                	jmp    80103eeb <exit+0xdb>
80103edb:	90                   	nop
80103edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ee0:	83 c2 7c             	add    $0x7c,%edx
80103ee3:	81 fa f4 5b 11 80    	cmp    $0x80115bf4,%edx
80103ee9:	74 33                	je     80103f1e <exit+0x10e>
    if(p->parent == curproc){
80103eeb:	39 72 14             	cmp    %esi,0x14(%edx)
80103eee:	75 f0                	jne    80103ee0 <exit+0xd0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103ef0:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103ef4:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103ef7:	75 e7                	jne    80103ee0 <exit+0xd0>
80103ef9:	b8 f4 3c 11 80       	mov    $0x80113cf4,%eax
80103efe:	eb 0a                	jmp    80103f0a <exit+0xfa>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f00:	83 c0 7c             	add    $0x7c,%eax
80103f03:	3d f4 5b 11 80       	cmp    $0x80115bf4,%eax
80103f08:	74 d6                	je     80103ee0 <exit+0xd0>
    if(p->state == SLEEPING && p->chan == chan)
80103f0a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f0e:	75 f0                	jne    80103f00 <exit+0xf0>
80103f10:	3b 48 20             	cmp    0x20(%eax),%ecx
80103f13:	75 eb                	jne    80103f00 <exit+0xf0>
      p->state = RUNNABLE;
80103f15:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103f1c:	eb e2                	jmp    80103f00 <exit+0xf0>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80103f1e:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103f25:	e8 26 fe ff ff       	call   80103d50 <sched>
  panic("zombie exit");
80103f2a:	83 ec 0c             	sub    $0xc,%esp
80103f2d:	68 3d 78 10 80       	push   $0x8010783d
80103f32:	e8 39 c4 ff ff       	call   80100370 <panic>
  int fd;

  freescreen(curproc->pid);

  if(curproc == initproc)
    panic("init exiting");
80103f37:	83 ec 0c             	sub    $0xc,%esp
80103f3a:	68 30 78 10 80       	push   $0x80107830
80103f3f:	e8 2c c4 ff ff       	call   80100370 <panic>
80103f44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103f4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103f50 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103f50:	55                   	push   %ebp
80103f51:	89 e5                	mov    %esp,%ebp
80103f53:	53                   	push   %ebx
80103f54:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103f57:	68 c0 3c 11 80       	push   $0x80113cc0
80103f5c:	e8 af 05 00 00       	call   80104510 <acquire>
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103f61:	e8 6a 05 00 00       	call   801044d0 <pushcli>
  c = mycpu();
80103f66:	e8 d5 f9 ff ff       	call   80103940 <mycpu>
  p = c->proc;
80103f6b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f71:	e8 4a 06 00 00       	call   801045c0 <popcli>
// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
80103f76:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103f7d:	e8 ce fd ff ff       	call   80103d50 <sched>
  release(&ptable.lock);
80103f82:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103f89:	e8 a2 06 00 00       	call   80104630 <release>
}
80103f8e:	83 c4 10             	add    $0x10,%esp
80103f91:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f94:	c9                   	leave  
80103f95:	c3                   	ret    
80103f96:	8d 76 00             	lea    0x0(%esi),%esi
80103f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103fa0 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103fa0:	55                   	push   %ebp
80103fa1:	89 e5                	mov    %esp,%ebp
80103fa3:	57                   	push   %edi
80103fa4:	56                   	push   %esi
80103fa5:	53                   	push   %ebx
80103fa6:	83 ec 0c             	sub    $0xc,%esp
80103fa9:	8b 7d 08             	mov    0x8(%ebp),%edi
80103fac:	8b 75 0c             	mov    0xc(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103faf:	e8 1c 05 00 00       	call   801044d0 <pushcli>
  c = mycpu();
80103fb4:	e8 87 f9 ff ff       	call   80103940 <mycpu>
  p = c->proc;
80103fb9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103fbf:	e8 fc 05 00 00       	call   801045c0 <popcli>
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
80103fc4:	85 db                	test   %ebx,%ebx
80103fc6:	0f 84 87 00 00 00    	je     80104053 <sleep+0xb3>
    panic("sleep");

  if(lk == 0)
80103fcc:	85 f6                	test   %esi,%esi
80103fce:	74 76                	je     80104046 <sleep+0xa6>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103fd0:	81 fe c0 3c 11 80    	cmp    $0x80113cc0,%esi
80103fd6:	74 50                	je     80104028 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103fd8:	83 ec 0c             	sub    $0xc,%esp
80103fdb:	68 c0 3c 11 80       	push   $0x80113cc0
80103fe0:	e8 2b 05 00 00       	call   80104510 <acquire>
    release(lk);
80103fe5:	89 34 24             	mov    %esi,(%esp)
80103fe8:	e8 43 06 00 00       	call   80104630 <release>
  }
  // Go to sleep.
  p->chan = chan;
80103fed:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103ff0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80103ff7:	e8 54 fd ff ff       	call   80103d50 <sched>

  // Tidy up.
  p->chan = 0;
80103ffc:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80104003:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
8010400a:	e8 21 06 00 00       	call   80104630 <release>
    acquire(lk);
8010400f:	89 75 08             	mov    %esi,0x8(%ebp)
80104012:	83 c4 10             	add    $0x10,%esp
  }
}
80104015:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104018:	5b                   	pop    %ebx
80104019:	5e                   	pop    %esi
8010401a:	5f                   	pop    %edi
8010401b:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
8010401c:	e9 ef 04 00 00       	jmp    80104510 <acquire>
80104021:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
80104028:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010402b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80104032:	e8 19 fd ff ff       	call   80103d50 <sched>

  // Tidy up.
  p->chan = 0;
80104037:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
8010403e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104041:	5b                   	pop    %ebx
80104042:	5e                   	pop    %esi
80104043:	5f                   	pop    %edi
80104044:	5d                   	pop    %ebp
80104045:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80104046:	83 ec 0c             	sub    $0xc,%esp
80104049:	68 4f 78 10 80       	push   $0x8010784f
8010404e:	e8 1d c3 ff ff       	call   80100370 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
80104053:	83 ec 0c             	sub    $0xc,%esp
80104056:	68 49 78 10 80       	push   $0x80107849
8010405b:	e8 10 c3 ff ff       	call   80100370 <panic>

80104060 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80104060:	55                   	push   %ebp
80104061:	89 e5                	mov    %esp,%ebp
80104063:	56                   	push   %esi
80104064:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80104065:	e8 66 04 00 00       	call   801044d0 <pushcli>
  c = mycpu();
8010406a:	e8 d1 f8 ff ff       	call   80103940 <mycpu>
  p = c->proc;
8010406f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104075:	e8 46 05 00 00       	call   801045c0 <popcli>
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
8010407a:	83 ec 0c             	sub    $0xc,%esp
8010407d:	68 c0 3c 11 80       	push   $0x80113cc0
80104082:	e8 89 04 00 00       	call   80104510 <acquire>
80104087:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
8010408a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010408c:	bb f4 3c 11 80       	mov    $0x80113cf4,%ebx
80104091:	eb 10                	jmp    801040a3 <wait+0x43>
80104093:	90                   	nop
80104094:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104098:	83 c3 7c             	add    $0x7c,%ebx
8010409b:	81 fb f4 5b 11 80    	cmp    $0x80115bf4,%ebx
801040a1:	74 1d                	je     801040c0 <wait+0x60>
      if(p->parent != curproc)
801040a3:	39 73 14             	cmp    %esi,0x14(%ebx)
801040a6:	75 f0                	jne    80104098 <wait+0x38>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
801040a8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801040ac:	74 30                	je     801040de <wait+0x7e>
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040ae:	83 c3 7c             	add    $0x7c,%ebx
      if(p->parent != curproc)
        continue;
      havekids = 1;
801040b1:	b8 01 00 00 00       	mov    $0x1,%eax
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040b6:	81 fb f4 5b 11 80    	cmp    $0x80115bf4,%ebx
801040bc:	75 e5                	jne    801040a3 <wait+0x43>
801040be:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
801040c0:	85 c0                	test   %eax,%eax
801040c2:	74 70                	je     80104134 <wait+0xd4>
801040c4:	8b 46 24             	mov    0x24(%esi),%eax
801040c7:	85 c0                	test   %eax,%eax
801040c9:	75 69                	jne    80104134 <wait+0xd4>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
801040cb:	83 ec 08             	sub    $0x8,%esp
801040ce:	68 c0 3c 11 80       	push   $0x80113cc0
801040d3:	56                   	push   %esi
801040d4:	e8 c7 fe ff ff       	call   80103fa0 <sleep>
  }
801040d9:	83 c4 10             	add    $0x10,%esp
801040dc:	eb ac                	jmp    8010408a <wait+0x2a>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
801040de:	83 ec 0c             	sub    $0xc,%esp
801040e1:	ff 73 08             	pushl  0x8(%ebx)
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
801040e4:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801040e7:	e8 54 e4 ff ff       	call   80102540 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
801040ec:	5a                   	pop    %edx
801040ed:	ff 73 04             	pushl  0x4(%ebx)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
801040f0:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801040f7:	e8 34 2e 00 00       	call   80106f30 <freevm>
        p->pid = 0;
801040fc:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104103:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010410a:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
8010410e:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104115:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010411c:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80104123:	e8 08 05 00 00       	call   80104630 <release>
        return pid;
80104128:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
8010412b:	8d 65 f8             	lea    -0x8(%ebp),%esp
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
8010412e:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104130:	5b                   	pop    %ebx
80104131:	5e                   	pop    %esi
80104132:	5d                   	pop    %ebp
80104133:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
80104134:	83 ec 0c             	sub    $0xc,%esp
80104137:	68 c0 3c 11 80       	push   $0x80113cc0
8010413c:	e8 ef 04 00 00       	call   80104630 <release>
      return -1;
80104141:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104144:	8d 65 f8             	lea    -0x8(%ebp),%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
80104147:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
8010414c:	5b                   	pop    %ebx
8010414d:	5e                   	pop    %esi
8010414e:	5d                   	pop    %ebp
8010414f:	c3                   	ret    

80104150 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104150:	55                   	push   %ebp
80104151:	89 e5                	mov    %esp,%ebp
80104153:	53                   	push   %ebx
80104154:	83 ec 10             	sub    $0x10,%esp
80104157:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010415a:	68 c0 3c 11 80       	push   $0x80113cc0
8010415f:	e8 ac 03 00 00       	call   80104510 <acquire>
80104164:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104167:	b8 f4 3c 11 80       	mov    $0x80113cf4,%eax
8010416c:	eb 0c                	jmp    8010417a <wakeup+0x2a>
8010416e:	66 90                	xchg   %ax,%ax
80104170:	83 c0 7c             	add    $0x7c,%eax
80104173:	3d f4 5b 11 80       	cmp    $0x80115bf4,%eax
80104178:	74 1c                	je     80104196 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010417a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010417e:	75 f0                	jne    80104170 <wakeup+0x20>
80104180:	3b 58 20             	cmp    0x20(%eax),%ebx
80104183:	75 eb                	jne    80104170 <wakeup+0x20>
      p->state = RUNNABLE;
80104185:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010418c:	83 c0 7c             	add    $0x7c,%eax
8010418f:	3d f4 5b 11 80       	cmp    $0x80115bf4,%eax
80104194:	75 e4                	jne    8010417a <wakeup+0x2a>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80104196:	c7 45 08 c0 3c 11 80 	movl   $0x80113cc0,0x8(%ebp)
}
8010419d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041a0:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
801041a1:	e9 8a 04 00 00       	jmp    80104630 <release>
801041a6:	8d 76 00             	lea    0x0(%esi),%esi
801041a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801041b0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801041b0:	55                   	push   %ebp
801041b1:	89 e5                	mov    %esp,%ebp
801041b3:	53                   	push   %ebx
801041b4:	83 ec 10             	sub    $0x10,%esp
801041b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801041ba:	68 c0 3c 11 80       	push   $0x80113cc0
801041bf:	e8 4c 03 00 00       	call   80104510 <acquire>
801041c4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041c7:	b8 f4 3c 11 80       	mov    $0x80113cf4,%eax
801041cc:	eb 0c                	jmp    801041da <kill+0x2a>
801041ce:	66 90                	xchg   %ax,%ax
801041d0:	83 c0 7c             	add    $0x7c,%eax
801041d3:	3d f4 5b 11 80       	cmp    $0x80115bf4,%eax
801041d8:	74 3e                	je     80104218 <kill+0x68>
    if(p->pid == pid){
801041da:	39 58 10             	cmp    %ebx,0x10(%eax)
801041dd:	75 f1                	jne    801041d0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801041df:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
801041e3:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801041ea:	74 1c                	je     80104208 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
801041ec:	83 ec 0c             	sub    $0xc,%esp
801041ef:	68 c0 3c 11 80       	push   $0x80113cc0
801041f4:	e8 37 04 00 00       	call   80104630 <release>
      return 0;
801041f9:	83 c4 10             	add    $0x10,%esp
801041fc:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
801041fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104201:	c9                   	leave  
80104202:	c3                   	ret    
80104203:	90                   	nop
80104204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80104208:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010420f:	eb db                	jmp    801041ec <kill+0x3c>
80104211:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104218:	83 ec 0c             	sub    $0xc,%esp
8010421b:	68 c0 3c 11 80       	push   $0x80113cc0
80104220:	e8 0b 04 00 00       	call   80104630 <release>
  return -1;
80104225:	83 c4 10             	add    $0x10,%esp
80104228:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010422d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104230:	c9                   	leave  
80104231:	c3                   	ret    
80104232:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104240 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104240:	55                   	push   %ebp
80104241:	89 e5                	mov    %esp,%ebp
80104243:	57                   	push   %edi
80104244:	56                   	push   %esi
80104245:	53                   	push   %ebx
80104246:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104249:	bb 60 3d 11 80       	mov    $0x80113d60,%ebx
8010424e:	83 ec 3c             	sub    $0x3c,%esp
80104251:	eb 24                	jmp    80104277 <procdump+0x37>
80104253:	90                   	nop
80104254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104258:	83 ec 0c             	sub    $0xc,%esp
8010425b:	68 e7 7b 10 80       	push   $0x80107be7
80104260:	e8 1b c4 ff ff       	call   80100680 <cprintf>
80104265:	83 c4 10             	add    $0x10,%esp
80104268:	83 c3 7c             	add    $0x7c,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010426b:	81 fb 60 5c 11 80    	cmp    $0x80115c60,%ebx
80104271:	0f 84 81 00 00 00    	je     801042f8 <procdump+0xb8>
    if(p->state == UNUSED)
80104277:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010427a:	85 c0                	test   %eax,%eax
8010427c:	74 ea                	je     80104268 <procdump+0x28>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010427e:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
80104281:	ba 60 78 10 80       	mov    $0x80107860,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104286:	77 11                	ja     80104299 <procdump+0x59>
80104288:	8b 14 85 c0 78 10 80 	mov    -0x7fef8740(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
8010428f:	b8 60 78 10 80       	mov    $0x80107860,%eax
80104294:	85 d2                	test   %edx,%edx
80104296:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104299:	53                   	push   %ebx
8010429a:	52                   	push   %edx
8010429b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010429e:	68 64 78 10 80       	push   $0x80107864
801042a3:	e8 d8 c3 ff ff       	call   80100680 <cprintf>
    if(p->state == SLEEPING){
801042a8:	83 c4 10             	add    $0x10,%esp
801042ab:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801042af:	75 a7                	jne    80104258 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801042b1:	8d 45 c0             	lea    -0x40(%ebp),%eax
801042b4:	83 ec 08             	sub    $0x8,%esp
801042b7:	8d 7d c0             	lea    -0x40(%ebp),%edi
801042ba:	50                   	push   %eax
801042bb:	8b 43 b0             	mov    -0x50(%ebx),%eax
801042be:	8b 40 0c             	mov    0xc(%eax),%eax
801042c1:	83 c0 08             	add    $0x8,%eax
801042c4:	50                   	push   %eax
801042c5:	e8 66 01 00 00       	call   80104430 <getcallerpcs>
801042ca:	83 c4 10             	add    $0x10,%esp
801042cd:	8d 76 00             	lea    0x0(%esi),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
801042d0:	8b 17                	mov    (%edi),%edx
801042d2:	85 d2                	test   %edx,%edx
801042d4:	74 82                	je     80104258 <procdump+0x18>
        cprintf(" %p", pc[i]);
801042d6:	83 ec 08             	sub    $0x8,%esp
801042d9:	83 c7 04             	add    $0x4,%edi
801042dc:	52                   	push   %edx
801042dd:	68 a1 72 10 80       	push   $0x801072a1
801042e2:	e8 99 c3 ff ff       	call   80100680 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
801042e7:	83 c4 10             	add    $0x10,%esp
801042ea:	39 f7                	cmp    %esi,%edi
801042ec:	75 e2                	jne    801042d0 <procdump+0x90>
801042ee:	e9 65 ff ff ff       	jmp    80104258 <procdump+0x18>
801042f3:	90                   	nop
801042f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
801042f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801042fb:	5b                   	pop    %ebx
801042fc:	5e                   	pop    %esi
801042fd:	5f                   	pop    %edi
801042fe:	5d                   	pop    %ebp
801042ff:	c3                   	ret    

80104300 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104300:	55                   	push   %ebp
80104301:	89 e5                	mov    %esp,%ebp
80104303:	53                   	push   %ebx
80104304:	83 ec 0c             	sub    $0xc,%esp
80104307:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010430a:	68 d8 78 10 80       	push   $0x801078d8
8010430f:	8d 43 04             	lea    0x4(%ebx),%eax
80104312:	50                   	push   %eax
80104313:	e8 f8 00 00 00       	call   80104410 <initlock>
  lk->name = name;
80104318:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010431b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104321:	83 c4 10             	add    $0x10,%esp
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
  lk->locked = 0;
  lk->pid = 0;
80104324:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
8010432b:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
8010432e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104331:	c9                   	leave  
80104332:	c3                   	ret    
80104333:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104340 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104340:	55                   	push   %ebp
80104341:	89 e5                	mov    %esp,%ebp
80104343:	56                   	push   %esi
80104344:	53                   	push   %ebx
80104345:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104348:	83 ec 0c             	sub    $0xc,%esp
8010434b:	8d 73 04             	lea    0x4(%ebx),%esi
8010434e:	56                   	push   %esi
8010434f:	e8 bc 01 00 00       	call   80104510 <acquire>
  while (lk->locked) {
80104354:	8b 13                	mov    (%ebx),%edx
80104356:	83 c4 10             	add    $0x10,%esp
80104359:	85 d2                	test   %edx,%edx
8010435b:	74 16                	je     80104373 <acquiresleep+0x33>
8010435d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104360:	83 ec 08             	sub    $0x8,%esp
80104363:	56                   	push   %esi
80104364:	53                   	push   %ebx
80104365:	e8 36 fc ff ff       	call   80103fa0 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
8010436a:	8b 03                	mov    (%ebx),%eax
8010436c:	83 c4 10             	add    $0x10,%esp
8010436f:	85 c0                	test   %eax,%eax
80104371:	75 ed                	jne    80104360 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80104373:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104379:	e8 62 f6 ff ff       	call   801039e0 <myproc>
8010437e:	8b 40 10             	mov    0x10(%eax),%eax
80104381:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104384:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104387:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010438a:	5b                   	pop    %ebx
8010438b:	5e                   	pop    %esi
8010438c:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
8010438d:	e9 9e 02 00 00       	jmp    80104630 <release>
80104392:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801043a0 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
801043a0:	55                   	push   %ebp
801043a1:	89 e5                	mov    %esp,%ebp
801043a3:	56                   	push   %esi
801043a4:	53                   	push   %ebx
801043a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801043a8:	83 ec 0c             	sub    $0xc,%esp
801043ab:	8d 73 04             	lea    0x4(%ebx),%esi
801043ae:	56                   	push   %esi
801043af:	e8 5c 01 00 00       	call   80104510 <acquire>
  lk->locked = 0;
801043b4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801043ba:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801043c1:	89 1c 24             	mov    %ebx,(%esp)
801043c4:	e8 87 fd ff ff       	call   80104150 <wakeup>
  release(&lk->lk);
801043c9:	89 75 08             	mov    %esi,0x8(%ebp)
801043cc:	83 c4 10             	add    $0x10,%esp
}
801043cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801043d2:	5b                   	pop    %ebx
801043d3:	5e                   	pop    %esi
801043d4:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
801043d5:	e9 56 02 00 00       	jmp    80104630 <release>
801043da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801043e0 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
801043e0:	55                   	push   %ebp
801043e1:	89 e5                	mov    %esp,%ebp
801043e3:	56                   	push   %esi
801043e4:	53                   	push   %ebx
801043e5:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
801043e8:	83 ec 0c             	sub    $0xc,%esp
801043eb:	8d 5e 04             	lea    0x4(%esi),%ebx
801043ee:	53                   	push   %ebx
801043ef:	e8 1c 01 00 00       	call   80104510 <acquire>
  r = lk->locked;
801043f4:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
801043f6:	89 1c 24             	mov    %ebx,(%esp)
801043f9:	e8 32 02 00 00       	call   80104630 <release>
  return r;
}
801043fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104401:	89 f0                	mov    %esi,%eax
80104403:	5b                   	pop    %ebx
80104404:	5e                   	pop    %esi
80104405:	5d                   	pop    %ebp
80104406:	c3                   	ret    
80104407:	66 90                	xchg   %ax,%ax
80104409:	66 90                	xchg   %ax,%ax
8010440b:	66 90                	xchg   %ax,%ax
8010440d:	66 90                	xchg   %ax,%ax
8010440f:	90                   	nop

80104410 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104410:	55                   	push   %ebp
80104411:	89 e5                	mov    %esp,%ebp
80104413:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104416:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104419:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
8010441f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
80104422:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104429:	5d                   	pop    %ebp
8010442a:	c3                   	ret    
8010442b:	90                   	nop
8010442c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104430 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104430:	55                   	push   %ebp
80104431:	89 e5                	mov    %esp,%ebp
80104433:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104434:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104437:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010443a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
8010443d:	31 c0                	xor    %eax,%eax
8010443f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104440:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104446:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010444c:	77 1a                	ja     80104468 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010444e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104451:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104454:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104457:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104459:	83 f8 0a             	cmp    $0xa,%eax
8010445c:	75 e2                	jne    80104440 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010445e:	5b                   	pop    %ebx
8010445f:	5d                   	pop    %ebp
80104460:	c3                   	ret    
80104461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104468:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010446f:	83 c0 01             	add    $0x1,%eax
80104472:	83 f8 0a             	cmp    $0xa,%eax
80104475:	74 e7                	je     8010445e <getcallerpcs+0x2e>
    pcs[i] = 0;
80104477:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010447e:	83 c0 01             	add    $0x1,%eax
80104481:	83 f8 0a             	cmp    $0xa,%eax
80104484:	75 e2                	jne    80104468 <getcallerpcs+0x38>
80104486:	eb d6                	jmp    8010445e <getcallerpcs+0x2e>
80104488:	90                   	nop
80104489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104490 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	53                   	push   %ebx
80104494:	83 ec 04             	sub    $0x4,%esp
80104497:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == mycpu();
8010449a:	8b 02                	mov    (%edx),%eax
8010449c:	85 c0                	test   %eax,%eax
8010449e:	75 10                	jne    801044b0 <holding+0x20>
}
801044a0:	83 c4 04             	add    $0x4,%esp
801044a3:	31 c0                	xor    %eax,%eax
801044a5:	5b                   	pop    %ebx
801044a6:	5d                   	pop    %ebp
801044a7:	c3                   	ret    
801044a8:	90                   	nop
801044a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
801044b0:	8b 5a 08             	mov    0x8(%edx),%ebx
801044b3:	e8 88 f4 ff ff       	call   80103940 <mycpu>
801044b8:	39 c3                	cmp    %eax,%ebx
801044ba:	0f 94 c0             	sete   %al
}
801044bd:	83 c4 04             	add    $0x4,%esp

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
801044c0:	0f b6 c0             	movzbl %al,%eax
}
801044c3:	5b                   	pop    %ebx
801044c4:	5d                   	pop    %ebp
801044c5:	c3                   	ret    
801044c6:	8d 76 00             	lea    0x0(%esi),%esi
801044c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801044d0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	53                   	push   %ebx
801044d4:	83 ec 04             	sub    $0x4,%esp
801044d7:	9c                   	pushf  
801044d8:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
801044d9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801044da:	e8 61 f4 ff ff       	call   80103940 <mycpu>
801044df:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801044e5:	85 c0                	test   %eax,%eax
801044e7:	75 11                	jne    801044fa <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801044e9:	81 e3 00 02 00 00    	and    $0x200,%ebx
801044ef:	e8 4c f4 ff ff       	call   80103940 <mycpu>
801044f4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801044fa:	e8 41 f4 ff ff       	call   80103940 <mycpu>
801044ff:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104506:	83 c4 04             	add    $0x4,%esp
80104509:	5b                   	pop    %ebx
8010450a:	5d                   	pop    %ebp
8010450b:	c3                   	ret    
8010450c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104510 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104510:	55                   	push   %ebp
80104511:	89 e5                	mov    %esp,%ebp
80104513:	56                   	push   %esi
80104514:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104515:	e8 b6 ff ff ff       	call   801044d0 <pushcli>
  if(holding(lk))
8010451a:	8b 5d 08             	mov    0x8(%ebp),%ebx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
8010451d:	8b 03                	mov    (%ebx),%eax
8010451f:	85 c0                	test   %eax,%eax
80104521:	75 7d                	jne    801045a0 <acquire+0x90>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104523:	ba 01 00 00 00       	mov    $0x1,%edx
80104528:	eb 09                	jmp    80104533 <acquire+0x23>
8010452a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104530:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104533:	89 d0                	mov    %edx,%eax
80104535:	f0 87 03             	lock xchg %eax,(%ebx)
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
80104538:	85 c0                	test   %eax,%eax
8010453a:	75 f4                	jne    80104530 <acquire+0x20>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
8010453c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
80104541:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104544:	e8 f7 f3 ff ff       	call   80103940 <mycpu>
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104549:	89 ea                	mov    %ebp,%edx
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
8010454b:	8d 4b 0c             	lea    0xc(%ebx),%ecx
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
8010454e:	89 43 08             	mov    %eax,0x8(%ebx)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104551:	31 c0                	xor    %eax,%eax
80104553:	90                   	nop
80104554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104558:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
8010455e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104564:	77 1a                	ja     80104580 <acquire+0x70>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104566:	8b 5a 04             	mov    0x4(%edx),%ebx
80104569:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
8010456c:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
8010456f:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104571:	83 f8 0a             	cmp    $0xa,%eax
80104574:	75 e2                	jne    80104558 <acquire+0x48>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}
80104576:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104579:	5b                   	pop    %ebx
8010457a:	5e                   	pop    %esi
8010457b:	5d                   	pop    %ebp
8010457c:	c3                   	ret    
8010457d:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104580:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104587:	83 c0 01             	add    $0x1,%eax
8010458a:	83 f8 0a             	cmp    $0xa,%eax
8010458d:	74 e7                	je     80104576 <acquire+0x66>
    pcs[i] = 0;
8010458f:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104596:	83 c0 01             	add    $0x1,%eax
80104599:	83 f8 0a             	cmp    $0xa,%eax
8010459c:	75 e2                	jne    80104580 <acquire+0x70>
8010459e:	eb d6                	jmp    80104576 <acquire+0x66>

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
801045a0:	8b 73 08             	mov    0x8(%ebx),%esi
801045a3:	e8 98 f3 ff ff       	call   80103940 <mycpu>
801045a8:	39 c6                	cmp    %eax,%esi
801045aa:	0f 85 73 ff ff ff    	jne    80104523 <acquire+0x13>
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
801045b0:	83 ec 0c             	sub    $0xc,%esp
801045b3:	68 e3 78 10 80       	push   $0x801078e3
801045b8:	e8 b3 bd ff ff       	call   80100370 <panic>
801045bd:	8d 76 00             	lea    0x0(%esi),%esi

801045c0 <popcli>:
  mycpu()->ncli += 1;
}

void
popcli(void)
{
801045c0:	55                   	push   %ebp
801045c1:	89 e5                	mov    %esp,%ebp
801045c3:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801045c6:	9c                   	pushf  
801045c7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801045c8:	f6 c4 02             	test   $0x2,%ah
801045cb:	75 52                	jne    8010461f <popcli+0x5f>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801045cd:	e8 6e f3 ff ff       	call   80103940 <mycpu>
801045d2:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
801045d8:	8d 51 ff             	lea    -0x1(%ecx),%edx
801045db:	85 d2                	test   %edx,%edx
801045dd:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
801045e3:	78 2d                	js     80104612 <popcli+0x52>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801045e5:	e8 56 f3 ff ff       	call   80103940 <mycpu>
801045ea:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801045f0:	85 d2                	test   %edx,%edx
801045f2:	74 0c                	je     80104600 <popcli+0x40>
    sti();
}
801045f4:	c9                   	leave  
801045f5:	c3                   	ret    
801045f6:	8d 76 00             	lea    0x0(%esi),%esi
801045f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104600:	e8 3b f3 ff ff       	call   80103940 <mycpu>
80104605:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010460b:	85 c0                	test   %eax,%eax
8010460d:	74 e5                	je     801045f4 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
8010460f:	fb                   	sti    
    sti();
}
80104610:	c9                   	leave  
80104611:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
80104612:	83 ec 0c             	sub    $0xc,%esp
80104615:	68 02 79 10 80       	push   $0x80107902
8010461a:	e8 51 bd ff ff       	call   80100370 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
8010461f:	83 ec 0c             	sub    $0xc,%esp
80104622:	68 eb 78 10 80       	push   $0x801078eb
80104627:	e8 44 bd ff ff       	call   80100370 <panic>
8010462c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104630 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
80104630:	55                   	push   %ebp
80104631:	89 e5                	mov    %esp,%ebp
80104633:	56                   	push   %esi
80104634:	53                   	push   %ebx
80104635:	8b 5d 08             	mov    0x8(%ebp),%ebx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80104638:	8b 03                	mov    (%ebx),%eax
8010463a:	85 c0                	test   %eax,%eax
8010463c:	75 12                	jne    80104650 <release+0x20>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
8010463e:	83 ec 0c             	sub    $0xc,%esp
80104641:	68 09 79 10 80       	push   $0x80107909
80104646:	e8 25 bd ff ff       	call   80100370 <panic>
8010464b:	90                   	nop
8010464c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80104650:	8b 73 08             	mov    0x8(%ebx),%esi
80104653:	e8 e8 f2 ff ff       	call   80103940 <mycpu>
80104658:	39 c6                	cmp    %eax,%esi
8010465a:	75 e2                	jne    8010463e <release+0xe>
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");

  lk->pcs[0] = 0;
8010465c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104663:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
8010466a:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010466f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
80104675:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104678:	5b                   	pop    %ebx
80104679:	5e                   	pop    %esi
8010467a:	5d                   	pop    %ebp
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
8010467b:	e9 40 ff ff ff       	jmp    801045c0 <popcli>

80104680 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104680:	55                   	push   %ebp
80104681:	89 e5                	mov    %esp,%ebp
80104683:	57                   	push   %edi
80104684:	53                   	push   %ebx
80104685:	8b 55 08             	mov    0x8(%ebp),%edx
80104688:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010468b:	f6 c2 03             	test   $0x3,%dl
8010468e:	75 05                	jne    80104695 <memset+0x15>
80104690:	f6 c1 03             	test   $0x3,%cl
80104693:	74 13                	je     801046a8 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
80104695:	89 d7                	mov    %edx,%edi
80104697:	8b 45 0c             	mov    0xc(%ebp),%eax
8010469a:	fc                   	cld    
8010469b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010469d:	5b                   	pop    %ebx
8010469e:	89 d0                	mov    %edx,%eax
801046a0:	5f                   	pop    %edi
801046a1:	5d                   	pop    %ebp
801046a2:	c3                   	ret    
801046a3:	90                   	nop
801046a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
801046a8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
801046ac:	c1 e9 02             	shr    $0x2,%ecx
801046af:	89 fb                	mov    %edi,%ebx
801046b1:	89 f8                	mov    %edi,%eax
801046b3:	c1 e3 18             	shl    $0x18,%ebx
801046b6:	c1 e0 10             	shl    $0x10,%eax
801046b9:	09 d8                	or     %ebx,%eax
801046bb:	09 f8                	or     %edi,%eax
801046bd:	c1 e7 08             	shl    $0x8,%edi
801046c0:	09 f8                	or     %edi,%eax
801046c2:	89 d7                	mov    %edx,%edi
801046c4:	fc                   	cld    
801046c5:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801046c7:	5b                   	pop    %ebx
801046c8:	89 d0                	mov    %edx,%eax
801046ca:	5f                   	pop    %edi
801046cb:	5d                   	pop    %ebp
801046cc:	c3                   	ret    
801046cd:	8d 76 00             	lea    0x0(%esi),%esi

801046d0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801046d0:	55                   	push   %ebp
801046d1:	89 e5                	mov    %esp,%ebp
801046d3:	57                   	push   %edi
801046d4:	56                   	push   %esi
801046d5:	8b 45 10             	mov    0x10(%ebp),%eax
801046d8:	53                   	push   %ebx
801046d9:	8b 75 0c             	mov    0xc(%ebp),%esi
801046dc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801046df:	85 c0                	test   %eax,%eax
801046e1:	74 29                	je     8010470c <memcmp+0x3c>
    if(*s1 != *s2)
801046e3:	0f b6 13             	movzbl (%ebx),%edx
801046e6:	0f b6 0e             	movzbl (%esi),%ecx
801046e9:	38 d1                	cmp    %dl,%cl
801046eb:	75 2b                	jne    80104718 <memcmp+0x48>
801046ed:	8d 78 ff             	lea    -0x1(%eax),%edi
801046f0:	31 c0                	xor    %eax,%eax
801046f2:	eb 14                	jmp    80104708 <memcmp+0x38>
801046f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046f8:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
801046fd:	83 c0 01             	add    $0x1,%eax
80104700:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104704:	38 ca                	cmp    %cl,%dl
80104706:	75 10                	jne    80104718 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104708:	39 f8                	cmp    %edi,%eax
8010470a:	75 ec                	jne    801046f8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010470c:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010470d:	31 c0                	xor    %eax,%eax
}
8010470f:	5e                   	pop    %esi
80104710:	5f                   	pop    %edi
80104711:	5d                   	pop    %ebp
80104712:	c3                   	ret    
80104713:	90                   	nop
80104714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80104718:	0f b6 c2             	movzbl %dl,%eax
    s1++, s2++;
  }

  return 0;
}
8010471b:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
8010471c:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
8010471e:	5e                   	pop    %esi
8010471f:	5f                   	pop    %edi
80104720:	5d                   	pop    %ebp
80104721:	c3                   	ret    
80104722:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104730 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104730:	55                   	push   %ebp
80104731:	89 e5                	mov    %esp,%ebp
80104733:	56                   	push   %esi
80104734:	53                   	push   %ebx
80104735:	8b 45 08             	mov    0x8(%ebp),%eax
80104738:	8b 75 0c             	mov    0xc(%ebp),%esi
8010473b:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010473e:	39 c6                	cmp    %eax,%esi
80104740:	73 2e                	jae    80104770 <memmove+0x40>
80104742:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
80104745:	39 c8                	cmp    %ecx,%eax
80104747:	73 27                	jae    80104770 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
80104749:	85 db                	test   %ebx,%ebx
8010474b:	8d 53 ff             	lea    -0x1(%ebx),%edx
8010474e:	74 17                	je     80104767 <memmove+0x37>
      *--d = *--s;
80104750:	29 d9                	sub    %ebx,%ecx
80104752:	89 cb                	mov    %ecx,%ebx
80104754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104758:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
8010475c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
8010475f:	83 ea 01             	sub    $0x1,%edx
80104762:	83 fa ff             	cmp    $0xffffffff,%edx
80104765:	75 f1                	jne    80104758 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104767:	5b                   	pop    %ebx
80104768:	5e                   	pop    %esi
80104769:	5d                   	pop    %ebp
8010476a:	c3                   	ret    
8010476b:	90                   	nop
8010476c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80104770:	31 d2                	xor    %edx,%edx
80104772:	85 db                	test   %ebx,%ebx
80104774:	74 f1                	je     80104767 <memmove+0x37>
80104776:	8d 76 00             	lea    0x0(%esi),%esi
80104779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *d++ = *s++;
80104780:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104784:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104787:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
8010478a:	39 d3                	cmp    %edx,%ebx
8010478c:	75 f2                	jne    80104780 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
8010478e:	5b                   	pop    %ebx
8010478f:	5e                   	pop    %esi
80104790:	5d                   	pop    %ebp
80104791:	c3                   	ret    
80104792:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047a0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
801047a3:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
801047a4:	eb 8a                	jmp    80104730 <memmove>
801047a6:	8d 76 00             	lea    0x0(%esi),%esi
801047a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047b0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
801047b0:	55                   	push   %ebp
801047b1:	89 e5                	mov    %esp,%ebp
801047b3:	57                   	push   %edi
801047b4:	56                   	push   %esi
801047b5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801047b8:	53                   	push   %ebx
801047b9:	8b 7d 08             	mov    0x8(%ebp),%edi
801047bc:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
801047bf:	85 c9                	test   %ecx,%ecx
801047c1:	74 37                	je     801047fa <strncmp+0x4a>
801047c3:	0f b6 17             	movzbl (%edi),%edx
801047c6:	0f b6 1e             	movzbl (%esi),%ebx
801047c9:	84 d2                	test   %dl,%dl
801047cb:	74 3f                	je     8010480c <strncmp+0x5c>
801047cd:	38 d3                	cmp    %dl,%bl
801047cf:	75 3b                	jne    8010480c <strncmp+0x5c>
801047d1:	8d 47 01             	lea    0x1(%edi),%eax
801047d4:	01 cf                	add    %ecx,%edi
801047d6:	eb 1b                	jmp    801047f3 <strncmp+0x43>
801047d8:	90                   	nop
801047d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047e0:	0f b6 10             	movzbl (%eax),%edx
801047e3:	84 d2                	test   %dl,%dl
801047e5:	74 21                	je     80104808 <strncmp+0x58>
801047e7:	0f b6 19             	movzbl (%ecx),%ebx
801047ea:	83 c0 01             	add    $0x1,%eax
801047ed:	89 ce                	mov    %ecx,%esi
801047ef:	38 da                	cmp    %bl,%dl
801047f1:	75 19                	jne    8010480c <strncmp+0x5c>
801047f3:	39 c7                	cmp    %eax,%edi
    n--, p++, q++;
801047f5:	8d 4e 01             	lea    0x1(%esi),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
801047f8:	75 e6                	jne    801047e0 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
801047fa:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
801047fb:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
801047fd:	5e                   	pop    %esi
801047fe:	5f                   	pop    %edi
801047ff:	5d                   	pop    %ebp
80104800:	c3                   	ret    
80104801:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104808:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
8010480c:	0f b6 c2             	movzbl %dl,%eax
8010480f:	29 d8                	sub    %ebx,%eax
}
80104811:	5b                   	pop    %ebx
80104812:	5e                   	pop    %esi
80104813:	5f                   	pop    %edi
80104814:	5d                   	pop    %ebp
80104815:	c3                   	ret    
80104816:	8d 76 00             	lea    0x0(%esi),%esi
80104819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104820 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104820:	55                   	push   %ebp
80104821:	89 e5                	mov    %esp,%ebp
80104823:	56                   	push   %esi
80104824:	53                   	push   %ebx
80104825:	8b 45 08             	mov    0x8(%ebp),%eax
80104828:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010482b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010482e:	89 c2                	mov    %eax,%edx
80104830:	eb 19                	jmp    8010484b <strncpy+0x2b>
80104832:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104838:	83 c3 01             	add    $0x1,%ebx
8010483b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010483f:	83 c2 01             	add    $0x1,%edx
80104842:	84 c9                	test   %cl,%cl
80104844:	88 4a ff             	mov    %cl,-0x1(%edx)
80104847:	74 09                	je     80104852 <strncpy+0x32>
80104849:	89 f1                	mov    %esi,%ecx
8010484b:	85 c9                	test   %ecx,%ecx
8010484d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104850:	7f e6                	jg     80104838 <strncpy+0x18>
    ;
  while(n-- > 0)
80104852:	31 c9                	xor    %ecx,%ecx
80104854:	85 f6                	test   %esi,%esi
80104856:	7e 17                	jle    8010486f <strncpy+0x4f>
80104858:	90                   	nop
80104859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104860:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104864:	89 f3                	mov    %esi,%ebx
80104866:	83 c1 01             	add    $0x1,%ecx
80104869:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
8010486b:	85 db                	test   %ebx,%ebx
8010486d:	7f f1                	jg     80104860 <strncpy+0x40>
    *s++ = 0;
  return os;
}
8010486f:	5b                   	pop    %ebx
80104870:	5e                   	pop    %esi
80104871:	5d                   	pop    %ebp
80104872:	c3                   	ret    
80104873:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104880 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104880:	55                   	push   %ebp
80104881:	89 e5                	mov    %esp,%ebp
80104883:	56                   	push   %esi
80104884:	53                   	push   %ebx
80104885:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104888:	8b 45 08             	mov    0x8(%ebp),%eax
8010488b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010488e:	85 c9                	test   %ecx,%ecx
80104890:	7e 26                	jle    801048b8 <safestrcpy+0x38>
80104892:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104896:	89 c1                	mov    %eax,%ecx
80104898:	eb 17                	jmp    801048b1 <safestrcpy+0x31>
8010489a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801048a0:	83 c2 01             	add    $0x1,%edx
801048a3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
801048a7:	83 c1 01             	add    $0x1,%ecx
801048aa:	84 db                	test   %bl,%bl
801048ac:	88 59 ff             	mov    %bl,-0x1(%ecx)
801048af:	74 04                	je     801048b5 <safestrcpy+0x35>
801048b1:	39 f2                	cmp    %esi,%edx
801048b3:	75 eb                	jne    801048a0 <safestrcpy+0x20>
    ;
  *s = 0;
801048b5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
801048b8:	5b                   	pop    %ebx
801048b9:	5e                   	pop    %esi
801048ba:	5d                   	pop    %ebp
801048bb:	c3                   	ret    
801048bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801048c0 <strlen>:

int
strlen(const char *s)
{
801048c0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
801048c1:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
801048c3:	89 e5                	mov    %esp,%ebp
801048c5:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
801048c8:	80 3a 00             	cmpb   $0x0,(%edx)
801048cb:	74 0c                	je     801048d9 <strlen+0x19>
801048cd:	8d 76 00             	lea    0x0(%esi),%esi
801048d0:	83 c0 01             	add    $0x1,%eax
801048d3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801048d7:	75 f7                	jne    801048d0 <strlen+0x10>
    ;
  return n;
}
801048d9:	5d                   	pop    %ebp
801048da:	c3                   	ret    

801048db <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
801048db:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801048df:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
801048e3:	55                   	push   %ebp
  pushl %ebx
801048e4:	53                   	push   %ebx
  pushl %esi
801048e5:	56                   	push   %esi
  pushl %edi
801048e6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801048e7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801048e9:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
801048eb:	5f                   	pop    %edi
  popl %esi
801048ec:	5e                   	pop    %esi
  popl %ebx
801048ed:	5b                   	pop    %ebx
  popl %ebp
801048ee:	5d                   	pop    %ebp
  ret
801048ef:	c3                   	ret    

801048f0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801048f0:	55                   	push   %ebp
801048f1:	89 e5                	mov    %esp,%ebp
801048f3:	53                   	push   %ebx
801048f4:	83 ec 04             	sub    $0x4,%esp
801048f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801048fa:	e8 e1 f0 ff ff       	call   801039e0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801048ff:	8b 00                	mov    (%eax),%eax
80104901:	39 d8                	cmp    %ebx,%eax
80104903:	76 1b                	jbe    80104920 <fetchint+0x30>
80104905:	8d 53 04             	lea    0x4(%ebx),%edx
80104908:	39 d0                	cmp    %edx,%eax
8010490a:	72 14                	jb     80104920 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010490c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010490f:	8b 13                	mov    (%ebx),%edx
80104911:	89 10                	mov    %edx,(%eax)
  return 0;
80104913:	31 c0                	xor    %eax,%eax
}
80104915:	83 c4 04             	add    $0x4,%esp
80104918:	5b                   	pop    %ebx
80104919:	5d                   	pop    %ebp
8010491a:	c3                   	ret    
8010491b:	90                   	nop
8010491c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104920:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104925:	eb ee                	jmp    80104915 <fetchint+0x25>
80104927:	89 f6                	mov    %esi,%esi
80104929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104930 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104930:	55                   	push   %ebp
80104931:	89 e5                	mov    %esp,%ebp
80104933:	53                   	push   %ebx
80104934:	83 ec 04             	sub    $0x4,%esp
80104937:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010493a:	e8 a1 f0 ff ff       	call   801039e0 <myproc>

  if(addr >= curproc->sz)
8010493f:	39 18                	cmp    %ebx,(%eax)
80104941:	76 29                	jbe    8010496c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104943:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104946:	89 da                	mov    %ebx,%edx
80104948:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010494a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010494c:	39 c3                	cmp    %eax,%ebx
8010494e:	73 1c                	jae    8010496c <fetchstr+0x3c>
    if(*s == 0)
80104950:	80 3b 00             	cmpb   $0x0,(%ebx)
80104953:	75 10                	jne    80104965 <fetchstr+0x35>
80104955:	eb 29                	jmp    80104980 <fetchstr+0x50>
80104957:	89 f6                	mov    %esi,%esi
80104959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104960:	80 3a 00             	cmpb   $0x0,(%edx)
80104963:	74 1b                	je     80104980 <fetchstr+0x50>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
80104965:	83 c2 01             	add    $0x1,%edx
80104968:	39 d0                	cmp    %edx,%eax
8010496a:	77 f4                	ja     80104960 <fetchstr+0x30>
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
8010496c:	83 c4 04             	add    $0x4,%esp
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
8010496f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80104974:	5b                   	pop    %ebx
80104975:	5d                   	pop    %ebp
80104976:	c3                   	ret    
80104977:	89 f6                	mov    %esi,%esi
80104979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104980:	83 c4 04             	add    $0x4,%esp
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
80104983:	89 d0                	mov    %edx,%eax
80104985:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104987:	5b                   	pop    %ebx
80104988:	5d                   	pop    %ebp
80104989:	c3                   	ret    
8010498a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104990 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104990:	55                   	push   %ebp
80104991:	89 e5                	mov    %esp,%ebp
80104993:	56                   	push   %esi
80104994:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104995:	e8 46 f0 ff ff       	call   801039e0 <myproc>
8010499a:	8b 40 18             	mov    0x18(%eax),%eax
8010499d:	8b 55 08             	mov    0x8(%ebp),%edx
801049a0:	8b 40 44             	mov    0x44(%eax),%eax
801049a3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();
801049a6:	e8 35 f0 ff ff       	call   801039e0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801049ab:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801049ad:	8d 73 04             	lea    0x4(%ebx),%esi
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801049b0:	39 c6                	cmp    %eax,%esi
801049b2:	73 1c                	jae    801049d0 <argint+0x40>
801049b4:	8d 53 08             	lea    0x8(%ebx),%edx
801049b7:	39 d0                	cmp    %edx,%eax
801049b9:	72 15                	jb     801049d0 <argint+0x40>
    return -1;
  *ip = *(int*)(addr);
801049bb:	8b 45 0c             	mov    0xc(%ebp),%eax
801049be:	8b 53 04             	mov    0x4(%ebx),%edx
801049c1:	89 10                	mov    %edx,(%eax)
  return 0;
801049c3:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
}
801049c5:	5b                   	pop    %ebx
801049c6:	5e                   	pop    %esi
801049c7:	5d                   	pop    %ebp
801049c8:	c3                   	ret    
801049c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
801049d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049d5:	eb ee                	jmp    801049c5 <argint+0x35>
801049d7:	89 f6                	mov    %esi,%esi
801049d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049e0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801049e0:	55                   	push   %ebp
801049e1:	89 e5                	mov    %esp,%ebp
801049e3:	56                   	push   %esi
801049e4:	53                   	push   %ebx
801049e5:	83 ec 10             	sub    $0x10,%esp
801049e8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801049eb:	e8 f0 ef ff ff       	call   801039e0 <myproc>
801049f0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
801049f2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801049f5:	83 ec 08             	sub    $0x8,%esp
801049f8:	50                   	push   %eax
801049f9:	ff 75 08             	pushl  0x8(%ebp)
801049fc:	e8 8f ff ff ff       	call   80104990 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104a01:	c1 e8 1f             	shr    $0x1f,%eax
80104a04:	83 c4 10             	add    $0x10,%esp
80104a07:	84 c0                	test   %al,%al
80104a09:	75 2d                	jne    80104a38 <argptr+0x58>
80104a0b:	89 d8                	mov    %ebx,%eax
80104a0d:	c1 e8 1f             	shr    $0x1f,%eax
80104a10:	84 c0                	test   %al,%al
80104a12:	75 24                	jne    80104a38 <argptr+0x58>
80104a14:	8b 16                	mov    (%esi),%edx
80104a16:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a19:	39 c2                	cmp    %eax,%edx
80104a1b:	76 1b                	jbe    80104a38 <argptr+0x58>
80104a1d:	01 c3                	add    %eax,%ebx
80104a1f:	39 da                	cmp    %ebx,%edx
80104a21:	72 15                	jb     80104a38 <argptr+0x58>
    return -1;
  *pp = (char*)i;
80104a23:	8b 55 0c             	mov    0xc(%ebp),%edx
80104a26:	89 02                	mov    %eax,(%edx)
  return 0;
80104a28:	31 c0                	xor    %eax,%eax
}
80104a2a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a2d:	5b                   	pop    %ebx
80104a2e:	5e                   	pop    %esi
80104a2f:	5d                   	pop    %ebp
80104a30:	c3                   	ret    
80104a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
80104a38:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a3d:	eb eb                	jmp    80104a2a <argptr+0x4a>
80104a3f:	90                   	nop

80104a40 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104a40:	55                   	push   %ebp
80104a41:	89 e5                	mov    %esp,%ebp
80104a43:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104a46:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a49:	50                   	push   %eax
80104a4a:	ff 75 08             	pushl  0x8(%ebp)
80104a4d:	e8 3e ff ff ff       	call   80104990 <argint>
80104a52:	83 c4 10             	add    $0x10,%esp
80104a55:	85 c0                	test   %eax,%eax
80104a57:	78 17                	js     80104a70 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104a59:	83 ec 08             	sub    $0x8,%esp
80104a5c:	ff 75 0c             	pushl  0xc(%ebp)
80104a5f:	ff 75 f4             	pushl  -0xc(%ebp)
80104a62:	e8 c9 fe ff ff       	call   80104930 <fetchstr>
80104a67:	83 c4 10             	add    $0x10,%esp
}
80104a6a:	c9                   	leave  
80104a6b:	c3                   	ret    
80104a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80104a70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80104a75:	c9                   	leave  
80104a76:	c3                   	ret    
80104a77:	89 f6                	mov    %esi,%esi
80104a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a80 <syscall>:
[SYS_getkey]  sys_getkey,
};

void
syscall(void)
{
80104a80:	55                   	push   %ebp
80104a81:	89 e5                	mov    %esp,%ebp
80104a83:	56                   	push   %esi
80104a84:	53                   	push   %ebx
  int num;
  struct proc *curproc = myproc();
80104a85:	e8 56 ef ff ff       	call   801039e0 <myproc>

  num = curproc->tf->eax;
80104a8a:	8b 70 18             	mov    0x18(%eax),%esi

void
syscall(void)
{
  int num;
  struct proc *curproc = myproc();
80104a8d:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104a8f:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104a92:	8d 50 ff             	lea    -0x1(%eax),%edx
80104a95:	83 fa 18             	cmp    $0x18,%edx
80104a98:	77 1e                	ja     80104ab8 <syscall+0x38>
80104a9a:	8b 14 85 40 79 10 80 	mov    -0x7fef86c0(,%eax,4),%edx
80104aa1:	85 d2                	test   %edx,%edx
80104aa3:	74 13                	je     80104ab8 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104aa5:	ff d2                	call   *%edx
80104aa7:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104aaa:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104aad:	5b                   	pop    %ebx
80104aae:	5e                   	pop    %esi
80104aaf:	5d                   	pop    %ebp
80104ab0:	c3                   	ret    
80104ab1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104ab8:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104ab9:	8d 43 6c             	lea    0x6c(%ebx),%eax

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104abc:	50                   	push   %eax
80104abd:	ff 73 10             	pushl  0x10(%ebx)
80104ac0:	68 11 79 10 80       	push   $0x80107911
80104ac5:	e8 b6 bb ff ff       	call   80100680 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
80104aca:	8b 43 18             	mov    0x18(%ebx),%eax
80104acd:	83 c4 10             	add    $0x10,%esp
80104ad0:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80104ad7:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ada:	5b                   	pop    %ebx
80104adb:	5e                   	pop    %esi
80104adc:	5d                   	pop    %ebp
80104add:	c3                   	ret    
80104ade:	66 90                	xchg   %ax,%ax

80104ae0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104ae0:	55                   	push   %ebp
80104ae1:	89 e5                	mov    %esp,%ebp
80104ae3:	57                   	push   %edi
80104ae4:	56                   	push   %esi
80104ae5:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104ae6:	8d 75 da             	lea    -0x26(%ebp),%esi
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104ae9:	83 ec 44             	sub    $0x44,%esp
80104aec:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104aef:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104af2:	56                   	push   %esi
80104af3:	50                   	push   %eax
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104af4:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104af7:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104afa:	e8 41 d6 ff ff       	call   80102140 <nameiparent>
80104aff:	83 c4 10             	add    $0x10,%esp
80104b02:	85 c0                	test   %eax,%eax
80104b04:	0f 84 f6 00 00 00    	je     80104c00 <create+0x120>
    return 0;
  ilock(dp);
80104b0a:	83 ec 0c             	sub    $0xc,%esp
80104b0d:	89 c7                	mov    %eax,%edi
80104b0f:	50                   	push   %eax
80104b10:	e8 bb cd ff ff       	call   801018d0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104b15:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104b18:	83 c4 0c             	add    $0xc,%esp
80104b1b:	50                   	push   %eax
80104b1c:	56                   	push   %esi
80104b1d:	57                   	push   %edi
80104b1e:	e8 dd d2 ff ff       	call   80101e00 <dirlookup>
80104b23:	83 c4 10             	add    $0x10,%esp
80104b26:	85 c0                	test   %eax,%eax
80104b28:	89 c3                	mov    %eax,%ebx
80104b2a:	74 54                	je     80104b80 <create+0xa0>
    iunlockput(dp);
80104b2c:	83 ec 0c             	sub    $0xc,%esp
80104b2f:	57                   	push   %edi
80104b30:	e8 2b d0 ff ff       	call   80101b60 <iunlockput>
    ilock(ip);
80104b35:	89 1c 24             	mov    %ebx,(%esp)
80104b38:	e8 93 cd ff ff       	call   801018d0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104b3d:	83 c4 10             	add    $0x10,%esp
80104b40:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104b45:	75 19                	jne    80104b60 <create+0x80>
80104b47:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
80104b4c:	89 d8                	mov    %ebx,%eax
80104b4e:	75 10                	jne    80104b60 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104b50:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b53:	5b                   	pop    %ebx
80104b54:	5e                   	pop    %esi
80104b55:	5f                   	pop    %edi
80104b56:	5d                   	pop    %ebp
80104b57:	c3                   	ret    
80104b58:	90                   	nop
80104b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80104b60:	83 ec 0c             	sub    $0xc,%esp
80104b63:	53                   	push   %ebx
80104b64:	e8 f7 cf ff ff       	call   80101b60 <iunlockput>
    return 0;
80104b69:	83 c4 10             	add    $0x10,%esp
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104b6c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
80104b6f:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104b71:	5b                   	pop    %ebx
80104b72:	5e                   	pop    %esi
80104b73:	5f                   	pop    %edi
80104b74:	5d                   	pop    %ebp
80104b75:	c3                   	ret    
80104b76:	8d 76 00             	lea    0x0(%esi),%esi
80104b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80104b80:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104b84:	83 ec 08             	sub    $0x8,%esp
80104b87:	50                   	push   %eax
80104b88:	ff 37                	pushl  (%edi)
80104b8a:	e8 d1 cb ff ff       	call   80101760 <ialloc>
80104b8f:	83 c4 10             	add    $0x10,%esp
80104b92:	85 c0                	test   %eax,%eax
80104b94:	89 c3                	mov    %eax,%ebx
80104b96:	0f 84 cc 00 00 00    	je     80104c68 <create+0x188>
    panic("create: ialloc");

  ilock(ip);
80104b9c:	83 ec 0c             	sub    $0xc,%esp
80104b9f:	50                   	push   %eax
80104ba0:	e8 2b cd ff ff       	call   801018d0 <ilock>
  ip->major = major;
80104ba5:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104ba9:	66 89 43 52          	mov    %ax,0x52(%ebx)
  ip->minor = minor;
80104bad:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104bb1:	66 89 43 54          	mov    %ax,0x54(%ebx)
  ip->nlink = 1;
80104bb5:	b8 01 00 00 00       	mov    $0x1,%eax
80104bba:	66 89 43 56          	mov    %ax,0x56(%ebx)
  iupdate(ip);
80104bbe:	89 1c 24             	mov    %ebx,(%esp)
80104bc1:	e8 5a cc ff ff       	call   80101820 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80104bc6:	83 c4 10             	add    $0x10,%esp
80104bc9:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104bce:	74 40                	je     80104c10 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80104bd0:	83 ec 04             	sub    $0x4,%esp
80104bd3:	ff 73 04             	pushl  0x4(%ebx)
80104bd6:	56                   	push   %esi
80104bd7:	57                   	push   %edi
80104bd8:	e8 83 d4 ff ff       	call   80102060 <dirlink>
80104bdd:	83 c4 10             	add    $0x10,%esp
80104be0:	85 c0                	test   %eax,%eax
80104be2:	78 77                	js     80104c5b <create+0x17b>
    panic("create: dirlink");

  iunlockput(dp);
80104be4:	83 ec 0c             	sub    $0xc,%esp
80104be7:	57                   	push   %edi
80104be8:	e8 73 cf ff ff       	call   80101b60 <iunlockput>

  return ip;
80104bed:	83 c4 10             	add    $0x10,%esp
}
80104bf0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
80104bf3:	89 d8                	mov    %ebx,%eax
}
80104bf5:	5b                   	pop    %ebx
80104bf6:	5e                   	pop    %esi
80104bf7:	5f                   	pop    %edi
80104bf8:	5d                   	pop    %ebp
80104bf9:	c3                   	ret    
80104bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80104c00:	31 c0                	xor    %eax,%eax
80104c02:	e9 49 ff ff ff       	jmp    80104b50 <create+0x70>
80104c07:	89 f6                	mov    %esi,%esi
80104c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80104c10:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
    iupdate(dp);
80104c15:	83 ec 0c             	sub    $0xc,%esp
80104c18:	57                   	push   %edi
80104c19:	e8 02 cc ff ff       	call   80101820 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104c1e:	83 c4 0c             	add    $0xc,%esp
80104c21:	ff 73 04             	pushl  0x4(%ebx)
80104c24:	68 c4 79 10 80       	push   $0x801079c4
80104c29:	53                   	push   %ebx
80104c2a:	e8 31 d4 ff ff       	call   80102060 <dirlink>
80104c2f:	83 c4 10             	add    $0x10,%esp
80104c32:	85 c0                	test   %eax,%eax
80104c34:	78 18                	js     80104c4e <create+0x16e>
80104c36:	83 ec 04             	sub    $0x4,%esp
80104c39:	ff 77 04             	pushl  0x4(%edi)
80104c3c:	68 c3 79 10 80       	push   $0x801079c3
80104c41:	53                   	push   %ebx
80104c42:	e8 19 d4 ff ff       	call   80102060 <dirlink>
80104c47:	83 c4 10             	add    $0x10,%esp
80104c4a:	85 c0                	test   %eax,%eax
80104c4c:	79 82                	jns    80104bd0 <create+0xf0>
      panic("create dots");
80104c4e:	83 ec 0c             	sub    $0xc,%esp
80104c51:	68 b7 79 10 80       	push   $0x801079b7
80104c56:	e8 15 b7 ff ff       	call   80100370 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
80104c5b:	83 ec 0c             	sub    $0xc,%esp
80104c5e:	68 c6 79 10 80       	push   $0x801079c6
80104c63:	e8 08 b7 ff ff       	call   80100370 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80104c68:	83 ec 0c             	sub    $0xc,%esp
80104c6b:	68 a8 79 10 80       	push   $0x801079a8
80104c70:	e8 fb b6 ff ff       	call   80100370 <panic>
80104c75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c80 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104c80:	55                   	push   %ebp
80104c81:	89 e5                	mov    %esp,%ebp
80104c83:	56                   	push   %esi
80104c84:	53                   	push   %ebx
80104c85:	89 c6                	mov    %eax,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104c87:	8d 45 f4             	lea    -0xc(%ebp),%eax
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104c8a:	89 d3                	mov    %edx,%ebx
80104c8c:	83 ec 18             	sub    $0x18,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104c8f:	50                   	push   %eax
80104c90:	6a 00                	push   $0x0
80104c92:	e8 f9 fc ff ff       	call   80104990 <argint>
80104c97:	83 c4 10             	add    $0x10,%esp
80104c9a:	85 c0                	test   %eax,%eax
80104c9c:	78 32                	js     80104cd0 <argfd.constprop.0+0x50>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104c9e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104ca2:	77 2c                	ja     80104cd0 <argfd.constprop.0+0x50>
80104ca4:	e8 37 ed ff ff       	call   801039e0 <myproc>
80104ca9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104cac:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104cb0:	85 c0                	test   %eax,%eax
80104cb2:	74 1c                	je     80104cd0 <argfd.constprop.0+0x50>
    return -1;
  if(pfd)
80104cb4:	85 f6                	test   %esi,%esi
80104cb6:	74 02                	je     80104cba <argfd.constprop.0+0x3a>
    *pfd = fd;
80104cb8:	89 16                	mov    %edx,(%esi)
  if(pf)
80104cba:	85 db                	test   %ebx,%ebx
80104cbc:	74 22                	je     80104ce0 <argfd.constprop.0+0x60>
    *pf = f;
80104cbe:	89 03                	mov    %eax,(%ebx)
  return 0;
80104cc0:	31 c0                	xor    %eax,%eax
}
80104cc2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104cc5:	5b                   	pop    %ebx
80104cc6:	5e                   	pop    %esi
80104cc7:	5d                   	pop    %ebp
80104cc8:	c3                   	ret    
80104cc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cd0:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
80104cd3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
80104cd8:	5b                   	pop    %ebx
80104cd9:	5e                   	pop    %esi
80104cda:	5d                   	pop    %ebp
80104cdb:	c3                   	ret    
80104cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
80104ce0:	31 c0                	xor    %eax,%eax
80104ce2:	eb de                	jmp    80104cc2 <argfd.constprop.0+0x42>
80104ce4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104cea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104cf0 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80104cf0:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104cf1:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80104cf3:	89 e5                	mov    %esp,%ebp
80104cf5:	56                   	push   %esi
80104cf6:	53                   	push   %ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104cf7:	8d 55 f4             	lea    -0xc(%ebp),%edx
  return -1;
}

int
sys_dup(void)
{
80104cfa:	83 ec 10             	sub    $0x10,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104cfd:	e8 7e ff ff ff       	call   80104c80 <argfd.constprop.0>
80104d02:	85 c0                	test   %eax,%eax
80104d04:	78 1a                	js     80104d20 <sys_dup+0x30>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104d06:	31 db                	xor    %ebx,%ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
80104d08:	8b 75 f4             	mov    -0xc(%ebp),%esi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80104d0b:	e8 d0 ec ff ff       	call   801039e0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80104d10:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104d14:	85 d2                	test   %edx,%edx
80104d16:	74 18                	je     80104d30 <sys_dup+0x40>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104d18:	83 c3 01             	add    $0x1,%ebx
80104d1b:	83 fb 10             	cmp    $0x10,%ebx
80104d1e:	75 f0                	jne    80104d10 <sys_dup+0x20>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104d20:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80104d23:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104d28:	5b                   	pop    %ebx
80104d29:	5e                   	pop    %esi
80104d2a:	5d                   	pop    %ebp
80104d2b:	c3                   	ret    
80104d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80104d30:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80104d34:	83 ec 0c             	sub    $0xc,%esp
80104d37:	ff 75 f4             	pushl  -0xc(%ebp)
80104d3a:	e8 01 c3 ff ff       	call   80101040 <filedup>
  return fd;
80104d3f:	83 c4 10             	add    $0x10,%esp
}
80104d42:	8d 65 f8             	lea    -0x8(%ebp),%esp
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
80104d45:	89 d8                	mov    %ebx,%eax
}
80104d47:	5b                   	pop    %ebx
80104d48:	5e                   	pop    %esi
80104d49:	5d                   	pop    %ebp
80104d4a:	c3                   	ret    
80104d4b:	90                   	nop
80104d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104d50 <sys_read>:

int
sys_read(void)
{
80104d50:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d51:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80104d53:	89 e5                	mov    %esp,%ebp
80104d55:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d58:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104d5b:	e8 20 ff ff ff       	call   80104c80 <argfd.constprop.0>
80104d60:	85 c0                	test   %eax,%eax
80104d62:	78 4c                	js     80104db0 <sys_read+0x60>
80104d64:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d67:	83 ec 08             	sub    $0x8,%esp
80104d6a:	50                   	push   %eax
80104d6b:	6a 02                	push   $0x2
80104d6d:	e8 1e fc ff ff       	call   80104990 <argint>
80104d72:	83 c4 10             	add    $0x10,%esp
80104d75:	85 c0                	test   %eax,%eax
80104d77:	78 37                	js     80104db0 <sys_read+0x60>
80104d79:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d7c:	83 ec 04             	sub    $0x4,%esp
80104d7f:	ff 75 f0             	pushl  -0x10(%ebp)
80104d82:	50                   	push   %eax
80104d83:	6a 01                	push   $0x1
80104d85:	e8 56 fc ff ff       	call   801049e0 <argptr>
80104d8a:	83 c4 10             	add    $0x10,%esp
80104d8d:	85 c0                	test   %eax,%eax
80104d8f:	78 1f                	js     80104db0 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80104d91:	83 ec 04             	sub    $0x4,%esp
80104d94:	ff 75 f0             	pushl  -0x10(%ebp)
80104d97:	ff 75 f4             	pushl  -0xc(%ebp)
80104d9a:	ff 75 ec             	pushl  -0x14(%ebp)
80104d9d:	e8 0e c4 ff ff       	call   801011b0 <fileread>
80104da2:	83 c4 10             	add    $0x10,%esp
}
80104da5:	c9                   	leave  
80104da6:	c3                   	ret    
80104da7:	89 f6                	mov    %esi,%esi
80104da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104db0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80104db5:	c9                   	leave  
80104db6:	c3                   	ret    
80104db7:	89 f6                	mov    %esi,%esi
80104db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104dc0 <sys_write>:

int
sys_write(void)
{
80104dc0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104dc1:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80104dc3:	89 e5                	mov    %esp,%ebp
80104dc5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104dc8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104dcb:	e8 b0 fe ff ff       	call   80104c80 <argfd.constprop.0>
80104dd0:	85 c0                	test   %eax,%eax
80104dd2:	78 4c                	js     80104e20 <sys_write+0x60>
80104dd4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104dd7:	83 ec 08             	sub    $0x8,%esp
80104dda:	50                   	push   %eax
80104ddb:	6a 02                	push   $0x2
80104ddd:	e8 ae fb ff ff       	call   80104990 <argint>
80104de2:	83 c4 10             	add    $0x10,%esp
80104de5:	85 c0                	test   %eax,%eax
80104de7:	78 37                	js     80104e20 <sys_write+0x60>
80104de9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104dec:	83 ec 04             	sub    $0x4,%esp
80104def:	ff 75 f0             	pushl  -0x10(%ebp)
80104df2:	50                   	push   %eax
80104df3:	6a 01                	push   $0x1
80104df5:	e8 e6 fb ff ff       	call   801049e0 <argptr>
80104dfa:	83 c4 10             	add    $0x10,%esp
80104dfd:	85 c0                	test   %eax,%eax
80104dff:	78 1f                	js     80104e20 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80104e01:	83 ec 04             	sub    $0x4,%esp
80104e04:	ff 75 f0             	pushl  -0x10(%ebp)
80104e07:	ff 75 f4             	pushl  -0xc(%ebp)
80104e0a:	ff 75 ec             	pushl  -0x14(%ebp)
80104e0d:	e8 2e c4 ff ff       	call   80101240 <filewrite>
80104e12:	83 c4 10             	add    $0x10,%esp
}
80104e15:	c9                   	leave  
80104e16:	c3                   	ret    
80104e17:	89 f6                	mov    %esi,%esi
80104e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104e20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
80104e25:	c9                   	leave  
80104e26:	c3                   	ret    
80104e27:	89 f6                	mov    %esi,%esi
80104e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e30 <sys_close>:

int
sys_close(void)
{
80104e30:	55                   	push   %ebp
80104e31:	89 e5                	mov    %esp,%ebp
80104e33:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80104e36:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104e39:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e3c:	e8 3f fe ff ff       	call   80104c80 <argfd.constprop.0>
80104e41:	85 c0                	test   %eax,%eax
80104e43:	78 2b                	js     80104e70 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
80104e45:	e8 96 eb ff ff       	call   801039e0 <myproc>
80104e4a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104e4d:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  myproc()->ofile[fd] = 0;
80104e50:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104e57:	00 
  fileclose(f);
80104e58:	ff 75 f4             	pushl  -0xc(%ebp)
80104e5b:	e8 30 c2 ff ff       	call   80101090 <fileclose>
  return 0;
80104e60:	83 c4 10             	add    $0x10,%esp
80104e63:	31 c0                	xor    %eax,%eax
}
80104e65:	c9                   	leave  
80104e66:	c3                   	ret    
80104e67:	89 f6                	mov    %esi,%esi
80104e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80104e70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80104e75:	c9                   	leave  
80104e76:	c3                   	ret    
80104e77:	89 f6                	mov    %esi,%esi
80104e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e80 <sys_fstat>:

int
sys_fstat(void)
{
80104e80:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104e81:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80104e83:	89 e5                	mov    %esp,%ebp
80104e85:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104e88:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104e8b:	e8 f0 fd ff ff       	call   80104c80 <argfd.constprop.0>
80104e90:	85 c0                	test   %eax,%eax
80104e92:	78 2c                	js     80104ec0 <sys_fstat+0x40>
80104e94:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e97:	83 ec 04             	sub    $0x4,%esp
80104e9a:	6a 14                	push   $0x14
80104e9c:	50                   	push   %eax
80104e9d:	6a 01                	push   $0x1
80104e9f:	e8 3c fb ff ff       	call   801049e0 <argptr>
80104ea4:	83 c4 10             	add    $0x10,%esp
80104ea7:	85 c0                	test   %eax,%eax
80104ea9:	78 15                	js     80104ec0 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
80104eab:	83 ec 08             	sub    $0x8,%esp
80104eae:	ff 75 f4             	pushl  -0xc(%ebp)
80104eb1:	ff 75 f0             	pushl  -0x10(%ebp)
80104eb4:	e8 a7 c2 ff ff       	call   80101160 <filestat>
80104eb9:	83 c4 10             	add    $0x10,%esp
}
80104ebc:	c9                   	leave  
80104ebd:	c3                   	ret    
80104ebe:	66 90                	xchg   %ax,%ax
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80104ec0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80104ec5:	c9                   	leave  
80104ec6:	c3                   	ret    
80104ec7:	89 f6                	mov    %esi,%esi
80104ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ed0 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104ed0:	55                   	push   %ebp
80104ed1:	89 e5                	mov    %esp,%ebp
80104ed3:	57                   	push   %edi
80104ed4:	56                   	push   %esi
80104ed5:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104ed6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104ed9:	83 ec 34             	sub    $0x34,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104edc:	50                   	push   %eax
80104edd:	6a 00                	push   $0x0
80104edf:	e8 5c fb ff ff       	call   80104a40 <argstr>
80104ee4:	83 c4 10             	add    $0x10,%esp
80104ee7:	85 c0                	test   %eax,%eax
80104ee9:	0f 88 fb 00 00 00    	js     80104fea <sys_link+0x11a>
80104eef:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104ef2:	83 ec 08             	sub    $0x8,%esp
80104ef5:	50                   	push   %eax
80104ef6:	6a 01                	push   $0x1
80104ef8:	e8 43 fb ff ff       	call   80104a40 <argstr>
80104efd:	83 c4 10             	add    $0x10,%esp
80104f00:	85 c0                	test   %eax,%eax
80104f02:	0f 88 e2 00 00 00    	js     80104fea <sys_link+0x11a>
    return -1;

  begin_op();
80104f08:	e8 a3 de ff ff       	call   80102db0 <begin_op>
  if((ip = namei(old)) == 0){
80104f0d:	83 ec 0c             	sub    $0xc,%esp
80104f10:	ff 75 d4             	pushl  -0x2c(%ebp)
80104f13:	e8 08 d2 ff ff       	call   80102120 <namei>
80104f18:	83 c4 10             	add    $0x10,%esp
80104f1b:	85 c0                	test   %eax,%eax
80104f1d:	89 c3                	mov    %eax,%ebx
80104f1f:	0f 84 f3 00 00 00    	je     80105018 <sys_link+0x148>
    end_op();
    return -1;
  }

  ilock(ip);
80104f25:	83 ec 0c             	sub    $0xc,%esp
80104f28:	50                   	push   %eax
80104f29:	e8 a2 c9 ff ff       	call   801018d0 <ilock>
  if(ip->type == T_DIR){
80104f2e:	83 c4 10             	add    $0x10,%esp
80104f31:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104f36:	0f 84 c4 00 00 00    	je     80105000 <sys_link+0x130>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
80104f3c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104f41:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80104f44:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80104f47:	53                   	push   %ebx
80104f48:	e8 d3 c8 ff ff       	call   80101820 <iupdate>
  iunlock(ip);
80104f4d:	89 1c 24             	mov    %ebx,(%esp)
80104f50:	e8 5b ca ff ff       	call   801019b0 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80104f55:	58                   	pop    %eax
80104f56:	5a                   	pop    %edx
80104f57:	57                   	push   %edi
80104f58:	ff 75 d0             	pushl  -0x30(%ebp)
80104f5b:	e8 e0 d1 ff ff       	call   80102140 <nameiparent>
80104f60:	83 c4 10             	add    $0x10,%esp
80104f63:	85 c0                	test   %eax,%eax
80104f65:	89 c6                	mov    %eax,%esi
80104f67:	74 5b                	je     80104fc4 <sys_link+0xf4>
    goto bad;
  ilock(dp);
80104f69:	83 ec 0c             	sub    $0xc,%esp
80104f6c:	50                   	push   %eax
80104f6d:	e8 5e c9 ff ff       	call   801018d0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104f72:	83 c4 10             	add    $0x10,%esp
80104f75:	8b 03                	mov    (%ebx),%eax
80104f77:	39 06                	cmp    %eax,(%esi)
80104f79:	75 3d                	jne    80104fb8 <sys_link+0xe8>
80104f7b:	83 ec 04             	sub    $0x4,%esp
80104f7e:	ff 73 04             	pushl  0x4(%ebx)
80104f81:	57                   	push   %edi
80104f82:	56                   	push   %esi
80104f83:	e8 d8 d0 ff ff       	call   80102060 <dirlink>
80104f88:	83 c4 10             	add    $0x10,%esp
80104f8b:	85 c0                	test   %eax,%eax
80104f8d:	78 29                	js     80104fb8 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80104f8f:	83 ec 0c             	sub    $0xc,%esp
80104f92:	56                   	push   %esi
80104f93:	e8 c8 cb ff ff       	call   80101b60 <iunlockput>
  iput(ip);
80104f98:	89 1c 24             	mov    %ebx,(%esp)
80104f9b:	e8 60 ca ff ff       	call   80101a00 <iput>

  end_op();
80104fa0:	e8 7b de ff ff       	call   80102e20 <end_op>

  return 0;
80104fa5:	83 c4 10             	add    $0x10,%esp
80104fa8:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80104faa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104fad:	5b                   	pop    %ebx
80104fae:	5e                   	pop    %esi
80104faf:	5f                   	pop    %edi
80104fb0:	5d                   	pop    %ebp
80104fb1:	c3                   	ret    
80104fb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80104fb8:	83 ec 0c             	sub    $0xc,%esp
80104fbb:	56                   	push   %esi
80104fbc:	e8 9f cb ff ff       	call   80101b60 <iunlockput>
    goto bad;
80104fc1:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  ilock(ip);
80104fc4:	83 ec 0c             	sub    $0xc,%esp
80104fc7:	53                   	push   %ebx
80104fc8:	e8 03 c9 ff ff       	call   801018d0 <ilock>
  ip->nlink--;
80104fcd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104fd2:	89 1c 24             	mov    %ebx,(%esp)
80104fd5:	e8 46 c8 ff ff       	call   80101820 <iupdate>
  iunlockput(ip);
80104fda:	89 1c 24             	mov    %ebx,(%esp)
80104fdd:	e8 7e cb ff ff       	call   80101b60 <iunlockput>
  end_op();
80104fe2:	e8 39 de ff ff       	call   80102e20 <end_op>
  return -1;
80104fe7:	83 c4 10             	add    $0x10,%esp
}
80104fea:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
80104fed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ff2:	5b                   	pop    %ebx
80104ff3:	5e                   	pop    %esi
80104ff4:	5f                   	pop    %edi
80104ff5:	5d                   	pop    %ebp
80104ff6:	c3                   	ret    
80104ff7:	89 f6                	mov    %esi,%esi
80104ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
80105000:	83 ec 0c             	sub    $0xc,%esp
80105003:	53                   	push   %ebx
80105004:	e8 57 cb ff ff       	call   80101b60 <iunlockput>
    end_op();
80105009:	e8 12 de ff ff       	call   80102e20 <end_op>
    return -1;
8010500e:	83 c4 10             	add    $0x10,%esp
80105011:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105016:	eb 92                	jmp    80104faa <sys_link+0xda>
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
80105018:	e8 03 de ff ff       	call   80102e20 <end_op>
    return -1;
8010501d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105022:	eb 86                	jmp    80104faa <sys_link+0xda>
80105024:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010502a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105030 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80105030:	55                   	push   %ebp
80105031:	89 e5                	mov    %esp,%ebp
80105033:	57                   	push   %edi
80105034:	56                   	push   %esi
80105035:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105036:	8d 45 c0             	lea    -0x40(%ebp),%eax
}

//PAGEBREAK!
int
sys_unlink(void)
{
80105039:	83 ec 54             	sub    $0x54,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
8010503c:	50                   	push   %eax
8010503d:	6a 00                	push   $0x0
8010503f:	e8 fc f9 ff ff       	call   80104a40 <argstr>
80105044:	83 c4 10             	add    $0x10,%esp
80105047:	85 c0                	test   %eax,%eax
80105049:	0f 88 82 01 00 00    	js     801051d1 <sys_unlink+0x1a1>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
8010504f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
80105052:	e8 59 dd ff ff       	call   80102db0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105057:	83 ec 08             	sub    $0x8,%esp
8010505a:	53                   	push   %ebx
8010505b:	ff 75 c0             	pushl  -0x40(%ebp)
8010505e:	e8 dd d0 ff ff       	call   80102140 <nameiparent>
80105063:	83 c4 10             	add    $0x10,%esp
80105066:	85 c0                	test   %eax,%eax
80105068:	89 45 b4             	mov    %eax,-0x4c(%ebp)
8010506b:	0f 84 6a 01 00 00    	je     801051db <sys_unlink+0x1ab>
    end_op();
    return -1;
  }

  ilock(dp);
80105071:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80105074:	83 ec 0c             	sub    $0xc,%esp
80105077:	56                   	push   %esi
80105078:	e8 53 c8 ff ff       	call   801018d0 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010507d:	58                   	pop    %eax
8010507e:	5a                   	pop    %edx
8010507f:	68 c4 79 10 80       	push   $0x801079c4
80105084:	53                   	push   %ebx
80105085:	e8 56 cd ff ff       	call   80101de0 <namecmp>
8010508a:	83 c4 10             	add    $0x10,%esp
8010508d:	85 c0                	test   %eax,%eax
8010508f:	0f 84 fc 00 00 00    	je     80105191 <sys_unlink+0x161>
80105095:	83 ec 08             	sub    $0x8,%esp
80105098:	68 c3 79 10 80       	push   $0x801079c3
8010509d:	53                   	push   %ebx
8010509e:	e8 3d cd ff ff       	call   80101de0 <namecmp>
801050a3:	83 c4 10             	add    $0x10,%esp
801050a6:	85 c0                	test   %eax,%eax
801050a8:	0f 84 e3 00 00 00    	je     80105191 <sys_unlink+0x161>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
801050ae:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801050b1:	83 ec 04             	sub    $0x4,%esp
801050b4:	50                   	push   %eax
801050b5:	53                   	push   %ebx
801050b6:	56                   	push   %esi
801050b7:	e8 44 cd ff ff       	call   80101e00 <dirlookup>
801050bc:	83 c4 10             	add    $0x10,%esp
801050bf:	85 c0                	test   %eax,%eax
801050c1:	89 c3                	mov    %eax,%ebx
801050c3:	0f 84 c8 00 00 00    	je     80105191 <sys_unlink+0x161>
    goto bad;
  ilock(ip);
801050c9:	83 ec 0c             	sub    $0xc,%esp
801050cc:	50                   	push   %eax
801050cd:	e8 fe c7 ff ff       	call   801018d0 <ilock>

  if(ip->nlink < 1)
801050d2:	83 c4 10             	add    $0x10,%esp
801050d5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801050da:	0f 8e 24 01 00 00    	jle    80105204 <sys_unlink+0x1d4>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
801050e0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801050e5:	8d 75 d8             	lea    -0x28(%ebp),%esi
801050e8:	74 66                	je     80105150 <sys_unlink+0x120>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
801050ea:	83 ec 04             	sub    $0x4,%esp
801050ed:	6a 10                	push   $0x10
801050ef:	6a 00                	push   $0x0
801050f1:	56                   	push   %esi
801050f2:	e8 89 f5 ff ff       	call   80104680 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801050f7:	6a 10                	push   $0x10
801050f9:	ff 75 c4             	pushl  -0x3c(%ebp)
801050fc:	56                   	push   %esi
801050fd:	ff 75 b4             	pushl  -0x4c(%ebp)
80105100:	e8 ab cb ff ff       	call   80101cb0 <writei>
80105105:	83 c4 20             	add    $0x20,%esp
80105108:	83 f8 10             	cmp    $0x10,%eax
8010510b:	0f 85 e6 00 00 00    	jne    801051f7 <sys_unlink+0x1c7>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80105111:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105116:	0f 84 9c 00 00 00    	je     801051b8 <sys_unlink+0x188>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
8010511c:	83 ec 0c             	sub    $0xc,%esp
8010511f:	ff 75 b4             	pushl  -0x4c(%ebp)
80105122:	e8 39 ca ff ff       	call   80101b60 <iunlockput>

  ip->nlink--;
80105127:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010512c:	89 1c 24             	mov    %ebx,(%esp)
8010512f:	e8 ec c6 ff ff       	call   80101820 <iupdate>
  iunlockput(ip);
80105134:	89 1c 24             	mov    %ebx,(%esp)
80105137:	e8 24 ca ff ff       	call   80101b60 <iunlockput>

  end_op();
8010513c:	e8 df dc ff ff       	call   80102e20 <end_op>

  return 0;
80105141:	83 c4 10             	add    $0x10,%esp
80105144:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80105146:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105149:	5b                   	pop    %ebx
8010514a:	5e                   	pop    %esi
8010514b:	5f                   	pop    %edi
8010514c:	5d                   	pop    %ebp
8010514d:	c3                   	ret    
8010514e:	66 90                	xchg   %ax,%ax
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105150:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105154:	76 94                	jbe    801050ea <sys_unlink+0xba>
80105156:	bf 20 00 00 00       	mov    $0x20,%edi
8010515b:	eb 0f                	jmp    8010516c <sys_unlink+0x13c>
8010515d:	8d 76 00             	lea    0x0(%esi),%esi
80105160:	83 c7 10             	add    $0x10,%edi
80105163:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105166:	0f 83 7e ff ff ff    	jae    801050ea <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010516c:	6a 10                	push   $0x10
8010516e:	57                   	push   %edi
8010516f:	56                   	push   %esi
80105170:	53                   	push   %ebx
80105171:	e8 3a ca ff ff       	call   80101bb0 <readi>
80105176:	83 c4 10             	add    $0x10,%esp
80105179:	83 f8 10             	cmp    $0x10,%eax
8010517c:	75 6c                	jne    801051ea <sys_unlink+0x1ba>
      panic("isdirempty: readi");
    if(de.inum != 0)
8010517e:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105183:	74 db                	je     80105160 <sys_unlink+0x130>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
80105185:	83 ec 0c             	sub    $0xc,%esp
80105188:	53                   	push   %ebx
80105189:	e8 d2 c9 ff ff       	call   80101b60 <iunlockput>
    goto bad;
8010518e:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  iunlockput(dp);
80105191:	83 ec 0c             	sub    $0xc,%esp
80105194:	ff 75 b4             	pushl  -0x4c(%ebp)
80105197:	e8 c4 c9 ff ff       	call   80101b60 <iunlockput>
  end_op();
8010519c:	e8 7f dc ff ff       	call   80102e20 <end_op>
  return -1;
801051a1:	83 c4 10             	add    $0x10,%esp
}
801051a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
801051a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801051ac:	5b                   	pop    %ebx
801051ad:	5e                   	pop    %esi
801051ae:	5f                   	pop    %edi
801051af:	5d                   	pop    %ebp
801051b0:	c3                   	ret    
801051b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
801051b8:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
801051bb:	83 ec 0c             	sub    $0xc,%esp

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
801051be:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
801051c3:	50                   	push   %eax
801051c4:	e8 57 c6 ff ff       	call   80101820 <iupdate>
801051c9:	83 c4 10             	add    $0x10,%esp
801051cc:	e9 4b ff ff ff       	jmp    8010511c <sys_unlink+0xec>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
801051d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051d6:	e9 6b ff ff ff       	jmp    80105146 <sys_unlink+0x116>

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
801051db:	e8 40 dc ff ff       	call   80102e20 <end_op>
    return -1;
801051e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051e5:	e9 5c ff ff ff       	jmp    80105146 <sys_unlink+0x116>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
801051ea:	83 ec 0c             	sub    $0xc,%esp
801051ed:	68 e8 79 10 80       	push   $0x801079e8
801051f2:	e8 79 b1 ff ff       	call   80100370 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
801051f7:	83 ec 0c             	sub    $0xc,%esp
801051fa:	68 fa 79 10 80       	push   $0x801079fa
801051ff:	e8 6c b1 ff ff       	call   80100370 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
80105204:	83 ec 0c             	sub    $0xc,%esp
80105207:	68 d6 79 10 80       	push   $0x801079d6
8010520c:	e8 5f b1 ff ff       	call   80100370 <panic>
80105211:	eb 0d                	jmp    80105220 <sys_open>
80105213:	90                   	nop
80105214:	90                   	nop
80105215:	90                   	nop
80105216:	90                   	nop
80105217:	90                   	nop
80105218:	90                   	nop
80105219:	90                   	nop
8010521a:	90                   	nop
8010521b:	90                   	nop
8010521c:	90                   	nop
8010521d:	90                   	nop
8010521e:	90                   	nop
8010521f:	90                   	nop

80105220 <sys_open>:
  return ip;
}

int
sys_open(void)
{
80105220:	55                   	push   %ebp
80105221:	89 e5                	mov    %esp,%ebp
80105223:	57                   	push   %edi
80105224:	56                   	push   %esi
80105225:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105226:	8d 45 e0             	lea    -0x20(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
80105229:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010522c:	50                   	push   %eax
8010522d:	6a 00                	push   $0x0
8010522f:	e8 0c f8 ff ff       	call   80104a40 <argstr>
80105234:	83 c4 10             	add    $0x10,%esp
80105237:	85 c0                	test   %eax,%eax
80105239:	0f 88 9e 00 00 00    	js     801052dd <sys_open+0xbd>
8010523f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105242:	83 ec 08             	sub    $0x8,%esp
80105245:	50                   	push   %eax
80105246:	6a 01                	push   $0x1
80105248:	e8 43 f7 ff ff       	call   80104990 <argint>
8010524d:	83 c4 10             	add    $0x10,%esp
80105250:	85 c0                	test   %eax,%eax
80105252:	0f 88 85 00 00 00    	js     801052dd <sys_open+0xbd>
    return -1;

  begin_op();
80105258:	e8 53 db ff ff       	call   80102db0 <begin_op>

  if(omode & O_CREATE){
8010525d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105261:	0f 85 89 00 00 00    	jne    801052f0 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105267:	83 ec 0c             	sub    $0xc,%esp
8010526a:	ff 75 e0             	pushl  -0x20(%ebp)
8010526d:	e8 ae ce ff ff       	call   80102120 <namei>
80105272:	83 c4 10             	add    $0x10,%esp
80105275:	85 c0                	test   %eax,%eax
80105277:	89 c6                	mov    %eax,%esi
80105279:	0f 84 8e 00 00 00    	je     8010530d <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
8010527f:	83 ec 0c             	sub    $0xc,%esp
80105282:	50                   	push   %eax
80105283:	e8 48 c6 ff ff       	call   801018d0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105288:	83 c4 10             	add    $0x10,%esp
8010528b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105290:	0f 84 d2 00 00 00    	je     80105368 <sys_open+0x148>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105296:	e8 35 bd ff ff       	call   80100fd0 <filealloc>
8010529b:	85 c0                	test   %eax,%eax
8010529d:	89 c7                	mov    %eax,%edi
8010529f:	74 2b                	je     801052cc <sys_open+0xac>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801052a1:	31 db                	xor    %ebx,%ebx
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801052a3:	e8 38 e7 ff ff       	call   801039e0 <myproc>
801052a8:	90                   	nop
801052a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
801052b0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801052b4:	85 d2                	test   %edx,%edx
801052b6:	74 68                	je     80105320 <sys_open+0x100>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801052b8:	83 c3 01             	add    $0x1,%ebx
801052bb:	83 fb 10             	cmp    $0x10,%ebx
801052be:	75 f0                	jne    801052b0 <sys_open+0x90>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
801052c0:	83 ec 0c             	sub    $0xc,%esp
801052c3:	57                   	push   %edi
801052c4:	e8 c7 bd ff ff       	call   80101090 <fileclose>
801052c9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801052cc:	83 ec 0c             	sub    $0xc,%esp
801052cf:	56                   	push   %esi
801052d0:	e8 8b c8 ff ff       	call   80101b60 <iunlockput>
    end_op();
801052d5:	e8 46 db ff ff       	call   80102e20 <end_op>
    return -1;
801052da:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
801052dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
801052e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
801052e5:	5b                   	pop    %ebx
801052e6:	5e                   	pop    %esi
801052e7:	5f                   	pop    %edi
801052e8:	5d                   	pop    %ebp
801052e9:	c3                   	ret    
801052ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
801052f0:	83 ec 0c             	sub    $0xc,%esp
801052f3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801052f6:	31 c9                	xor    %ecx,%ecx
801052f8:	6a 00                	push   $0x0
801052fa:	ba 02 00 00 00       	mov    $0x2,%edx
801052ff:	e8 dc f7 ff ff       	call   80104ae0 <create>
    if(ip == 0){
80105304:	83 c4 10             	add    $0x10,%esp
80105307:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105309:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010530b:	75 89                	jne    80105296 <sys_open+0x76>
      end_op();
8010530d:	e8 0e db ff ff       	call   80102e20 <end_op>
      return -1;
80105312:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105317:	eb 43                	jmp    8010535c <sys_open+0x13c>
80105319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105320:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105323:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105327:	56                   	push   %esi
80105328:	e8 83 c6 ff ff       	call   801019b0 <iunlock>
  end_op();
8010532d:	e8 ee da ff ff       	call   80102e20 <end_op>

  f->type = FD_INODE;
80105332:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105338:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010533b:	83 c4 10             	add    $0x10,%esp
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
8010533e:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105341:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105348:	89 d0                	mov    %edx,%eax
8010534a:	83 e0 01             	and    $0x1,%eax
8010534d:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105350:	83 e2 03             	and    $0x3,%edx
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105353:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105356:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
8010535a:	89 d8                	mov    %ebx,%eax
}
8010535c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010535f:	5b                   	pop    %ebx
80105360:	5e                   	pop    %esi
80105361:	5f                   	pop    %edi
80105362:	5d                   	pop    %ebp
80105363:	c3                   	ret    
80105364:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
80105368:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010536b:	85 c9                	test   %ecx,%ecx
8010536d:	0f 84 23 ff ff ff    	je     80105296 <sys_open+0x76>
80105373:	e9 54 ff ff ff       	jmp    801052cc <sys_open+0xac>
80105378:	90                   	nop
80105379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105380 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105386:	e8 25 da ff ff       	call   80102db0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010538b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010538e:	83 ec 08             	sub    $0x8,%esp
80105391:	50                   	push   %eax
80105392:	6a 00                	push   $0x0
80105394:	e8 a7 f6 ff ff       	call   80104a40 <argstr>
80105399:	83 c4 10             	add    $0x10,%esp
8010539c:	85 c0                	test   %eax,%eax
8010539e:	78 30                	js     801053d0 <sys_mkdir+0x50>
801053a0:	83 ec 0c             	sub    $0xc,%esp
801053a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053a6:	31 c9                	xor    %ecx,%ecx
801053a8:	6a 00                	push   $0x0
801053aa:	ba 01 00 00 00       	mov    $0x1,%edx
801053af:	e8 2c f7 ff ff       	call   80104ae0 <create>
801053b4:	83 c4 10             	add    $0x10,%esp
801053b7:	85 c0                	test   %eax,%eax
801053b9:	74 15                	je     801053d0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801053bb:	83 ec 0c             	sub    $0xc,%esp
801053be:	50                   	push   %eax
801053bf:	e8 9c c7 ff ff       	call   80101b60 <iunlockput>
  end_op();
801053c4:	e8 57 da ff ff       	call   80102e20 <end_op>
  return 0;
801053c9:	83 c4 10             	add    $0x10,%esp
801053cc:	31 c0                	xor    %eax,%eax
}
801053ce:	c9                   	leave  
801053cf:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
801053d0:	e8 4b da ff ff       	call   80102e20 <end_op>
    return -1;
801053d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
801053da:	c9                   	leave  
801053db:	c3                   	ret    
801053dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801053e0 <sys_mknod>:

int
sys_mknod(void)
{
801053e0:	55                   	push   %ebp
801053e1:	89 e5                	mov    %esp,%ebp
801053e3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801053e6:	e8 c5 d9 ff ff       	call   80102db0 <begin_op>
  if((argstr(0, &path)) < 0 ||
801053eb:	8d 45 ec             	lea    -0x14(%ebp),%eax
801053ee:	83 ec 08             	sub    $0x8,%esp
801053f1:	50                   	push   %eax
801053f2:	6a 00                	push   $0x0
801053f4:	e8 47 f6 ff ff       	call   80104a40 <argstr>
801053f9:	83 c4 10             	add    $0x10,%esp
801053fc:	85 c0                	test   %eax,%eax
801053fe:	78 60                	js     80105460 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105400:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105403:	83 ec 08             	sub    $0x8,%esp
80105406:	50                   	push   %eax
80105407:	6a 01                	push   $0x1
80105409:	e8 82 f5 ff ff       	call   80104990 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
8010540e:	83 c4 10             	add    $0x10,%esp
80105411:	85 c0                	test   %eax,%eax
80105413:	78 4b                	js     80105460 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105415:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105418:	83 ec 08             	sub    $0x8,%esp
8010541b:	50                   	push   %eax
8010541c:	6a 02                	push   $0x2
8010541e:	e8 6d f5 ff ff       	call   80104990 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80105423:	83 c4 10             	add    $0x10,%esp
80105426:	85 c0                	test   %eax,%eax
80105428:	78 36                	js     80105460 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
8010542a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010542e:	83 ec 0c             	sub    $0xc,%esp
80105431:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105435:	ba 03 00 00 00       	mov    $0x3,%edx
8010543a:	50                   	push   %eax
8010543b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010543e:	e8 9d f6 ff ff       	call   80104ae0 <create>
80105443:	83 c4 10             	add    $0x10,%esp
80105446:	85 c0                	test   %eax,%eax
80105448:	74 16                	je     80105460 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
8010544a:	83 ec 0c             	sub    $0xc,%esp
8010544d:	50                   	push   %eax
8010544e:	e8 0d c7 ff ff       	call   80101b60 <iunlockput>
  end_op();
80105453:	e8 c8 d9 ff ff       	call   80102e20 <end_op>
  return 0;
80105458:	83 c4 10             	add    $0x10,%esp
8010545b:	31 c0                	xor    %eax,%eax
}
8010545d:	c9                   	leave  
8010545e:	c3                   	ret    
8010545f:	90                   	nop
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80105460:	e8 bb d9 ff ff       	call   80102e20 <end_op>
    return -1;
80105465:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010546a:	c9                   	leave  
8010546b:	c3                   	ret    
8010546c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105470 <sys_chdir>:

int
sys_chdir(void)
{
80105470:	55                   	push   %ebp
80105471:	89 e5                	mov    %esp,%ebp
80105473:	56                   	push   %esi
80105474:	53                   	push   %ebx
80105475:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105478:	e8 63 e5 ff ff       	call   801039e0 <myproc>
8010547d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010547f:	e8 2c d9 ff ff       	call   80102db0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105484:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105487:	83 ec 08             	sub    $0x8,%esp
8010548a:	50                   	push   %eax
8010548b:	6a 00                	push   $0x0
8010548d:	e8 ae f5 ff ff       	call   80104a40 <argstr>
80105492:	83 c4 10             	add    $0x10,%esp
80105495:	85 c0                	test   %eax,%eax
80105497:	78 77                	js     80105510 <sys_chdir+0xa0>
80105499:	83 ec 0c             	sub    $0xc,%esp
8010549c:	ff 75 f4             	pushl  -0xc(%ebp)
8010549f:	e8 7c cc ff ff       	call   80102120 <namei>
801054a4:	83 c4 10             	add    $0x10,%esp
801054a7:	85 c0                	test   %eax,%eax
801054a9:	89 c3                	mov    %eax,%ebx
801054ab:	74 63                	je     80105510 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801054ad:	83 ec 0c             	sub    $0xc,%esp
801054b0:	50                   	push   %eax
801054b1:	e8 1a c4 ff ff       	call   801018d0 <ilock>
  if(ip->type != T_DIR){
801054b6:	83 c4 10             	add    $0x10,%esp
801054b9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801054be:	75 30                	jne    801054f0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801054c0:	83 ec 0c             	sub    $0xc,%esp
801054c3:	53                   	push   %ebx
801054c4:	e8 e7 c4 ff ff       	call   801019b0 <iunlock>
  iput(curproc->cwd);
801054c9:	58                   	pop    %eax
801054ca:	ff 76 68             	pushl  0x68(%esi)
801054cd:	e8 2e c5 ff ff       	call   80101a00 <iput>
  end_op();
801054d2:	e8 49 d9 ff ff       	call   80102e20 <end_op>
  curproc->cwd = ip;
801054d7:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
801054da:	83 c4 10             	add    $0x10,%esp
801054dd:	31 c0                	xor    %eax,%eax
}
801054df:	8d 65 f8             	lea    -0x8(%ebp),%esp
801054e2:	5b                   	pop    %ebx
801054e3:	5e                   	pop    %esi
801054e4:	5d                   	pop    %ebp
801054e5:	c3                   	ret    
801054e6:	8d 76 00             	lea    0x0(%esi),%esi
801054e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
801054f0:	83 ec 0c             	sub    $0xc,%esp
801054f3:	53                   	push   %ebx
801054f4:	e8 67 c6 ff ff       	call   80101b60 <iunlockput>
    end_op();
801054f9:	e8 22 d9 ff ff       	call   80102e20 <end_op>
    return -1;
801054fe:	83 c4 10             	add    $0x10,%esp
80105501:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105506:	eb d7                	jmp    801054df <sys_chdir+0x6f>
80105508:	90                   	nop
80105509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct inode *ip;
  struct proc *curproc = myproc();
  
  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
80105510:	e8 0b d9 ff ff       	call   80102e20 <end_op>
    return -1;
80105515:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010551a:	eb c3                	jmp    801054df <sys_chdir+0x6f>
8010551c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105520 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
80105520:	55                   	push   %ebp
80105521:	89 e5                	mov    %esp,%ebp
80105523:	57                   	push   %edi
80105524:	56                   	push   %esi
80105525:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105526:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
8010552c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105532:	50                   	push   %eax
80105533:	6a 00                	push   $0x0
80105535:	e8 06 f5 ff ff       	call   80104a40 <argstr>
8010553a:	83 c4 10             	add    $0x10,%esp
8010553d:	85 c0                	test   %eax,%eax
8010553f:	78 7f                	js     801055c0 <sys_exec+0xa0>
80105541:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105547:	83 ec 08             	sub    $0x8,%esp
8010554a:	50                   	push   %eax
8010554b:	6a 01                	push   $0x1
8010554d:	e8 3e f4 ff ff       	call   80104990 <argint>
80105552:	83 c4 10             	add    $0x10,%esp
80105555:	85 c0                	test   %eax,%eax
80105557:	78 67                	js     801055c0 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105559:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010555f:	83 ec 04             	sub    $0x4,%esp
80105562:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80105568:	68 80 00 00 00       	push   $0x80
8010556d:	6a 00                	push   $0x0
8010556f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105575:	50                   	push   %eax
80105576:	31 db                	xor    %ebx,%ebx
80105578:	e8 03 f1 ff ff       	call   80104680 <memset>
8010557d:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105580:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105586:	83 ec 08             	sub    $0x8,%esp
80105589:	57                   	push   %edi
8010558a:	8d 04 98             	lea    (%eax,%ebx,4),%eax
8010558d:	50                   	push   %eax
8010558e:	e8 5d f3 ff ff       	call   801048f0 <fetchint>
80105593:	83 c4 10             	add    $0x10,%esp
80105596:	85 c0                	test   %eax,%eax
80105598:	78 26                	js     801055c0 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
8010559a:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801055a0:	85 c0                	test   %eax,%eax
801055a2:	74 2c                	je     801055d0 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801055a4:	83 ec 08             	sub    $0x8,%esp
801055a7:	56                   	push   %esi
801055a8:	50                   	push   %eax
801055a9:	e8 82 f3 ff ff       	call   80104930 <fetchstr>
801055ae:	83 c4 10             	add    $0x10,%esp
801055b1:	85 c0                	test   %eax,%eax
801055b3:	78 0b                	js     801055c0 <sys_exec+0xa0>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
801055b5:	83 c3 01             	add    $0x1,%ebx
801055b8:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
801055bb:	83 fb 20             	cmp    $0x20,%ebx
801055be:	75 c0                	jne    80105580 <sys_exec+0x60>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
801055c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
801055c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
801055c8:	5b                   	pop    %ebx
801055c9:	5e                   	pop    %esi
801055ca:	5f                   	pop    %edi
801055cb:	5d                   	pop    %ebp
801055cc:	c3                   	ret    
801055cd:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801055d0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801055d6:	83 ec 08             	sub    $0x8,%esp
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
801055d9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801055e0:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801055e4:	50                   	push   %eax
801055e5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801055eb:	e8 60 b6 ff ff       	call   80100c50 <exec>
801055f0:	83 c4 10             	add    $0x10,%esp
}
801055f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055f6:	5b                   	pop    %ebx
801055f7:	5e                   	pop    %esi
801055f8:	5f                   	pop    %edi
801055f9:	5d                   	pop    %ebp
801055fa:	c3                   	ret    
801055fb:	90                   	nop
801055fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105600 <sys_pipe>:

int
sys_pipe(void)
{
80105600:	55                   	push   %ebp
80105601:	89 e5                	mov    %esp,%ebp
80105603:	57                   	push   %edi
80105604:	56                   	push   %esi
80105605:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105606:	8d 45 dc             	lea    -0x24(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
80105609:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010560c:	6a 08                	push   $0x8
8010560e:	50                   	push   %eax
8010560f:	6a 00                	push   $0x0
80105611:	e8 ca f3 ff ff       	call   801049e0 <argptr>
80105616:	83 c4 10             	add    $0x10,%esp
80105619:	85 c0                	test   %eax,%eax
8010561b:	78 4a                	js     80105667 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010561d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105620:	83 ec 08             	sub    $0x8,%esp
80105623:	50                   	push   %eax
80105624:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105627:	50                   	push   %eax
80105628:	e8 23 de ff ff       	call   80103450 <pipealloc>
8010562d:	83 c4 10             	add    $0x10,%esp
80105630:	85 c0                	test   %eax,%eax
80105632:	78 33                	js     80105667 <sys_pipe+0x67>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105634:	31 db                	xor    %ebx,%ebx
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105636:	8b 7d e0             	mov    -0x20(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105639:	e8 a2 e3 ff ff       	call   801039e0 <myproc>
8010563e:	66 90                	xchg   %ax,%ax

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80105640:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105644:	85 f6                	test   %esi,%esi
80105646:	74 30                	je     80105678 <sys_pipe+0x78>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105648:	83 c3 01             	add    $0x1,%ebx
8010564b:	83 fb 10             	cmp    $0x10,%ebx
8010564e:	75 f0                	jne    80105640 <sys_pipe+0x40>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105650:	83 ec 0c             	sub    $0xc,%esp
80105653:	ff 75 e0             	pushl  -0x20(%ebp)
80105656:	e8 35 ba ff ff       	call   80101090 <fileclose>
    fileclose(wf);
8010565b:	58                   	pop    %eax
8010565c:	ff 75 e4             	pushl  -0x1c(%ebp)
8010565f:	e8 2c ba ff ff       	call   80101090 <fileclose>
    return -1;
80105664:	83 c4 10             	add    $0x10,%esp
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
80105667:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
8010566a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
8010566f:	5b                   	pop    %ebx
80105670:	5e                   	pop    %esi
80105671:	5f                   	pop    %edi
80105672:	5d                   	pop    %ebp
80105673:	c3                   	ret    
80105674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105678:	8d 73 08             	lea    0x8(%ebx),%esi
8010567b:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010567f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105682:	e8 59 e3 ff ff       	call   801039e0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
80105687:	31 d2                	xor    %edx,%edx
80105689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105690:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105694:	85 c9                	test   %ecx,%ecx
80105696:	74 18                	je     801056b0 <sys_pipe+0xb0>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105698:	83 c2 01             	add    $0x1,%edx
8010569b:	83 fa 10             	cmp    $0x10,%edx
8010569e:	75 f0                	jne    80105690 <sys_pipe+0x90>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
801056a0:	e8 3b e3 ff ff       	call   801039e0 <myproc>
801056a5:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801056ac:	00 
801056ad:	eb a1                	jmp    80105650 <sys_pipe+0x50>
801056af:	90                   	nop
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
801056b0:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
801056b4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801056b7:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801056b9:	8b 45 dc             	mov    -0x24(%ebp),%eax
801056bc:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
}
801056bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
801056c2:	31 c0                	xor    %eax,%eax
}
801056c4:	5b                   	pop    %ebx
801056c5:	5e                   	pop    %esi
801056c6:	5f                   	pop    %edi
801056c7:	5d                   	pop    %ebp
801056c8:	c3                   	ret    
801056c9:	66 90                	xchg   %ax,%ax
801056cb:	66 90                	xchg   %ax,%ax
801056cd:	66 90                	xchg   %ax,%ax
801056cf:	90                   	nop

801056d0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801056d0:	55                   	push   %ebp
801056d1:	89 e5                	mov    %esp,%ebp
  return fork();
}
801056d3:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
801056d4:	e9 a7 e4 ff ff       	jmp    80103b80 <fork>
801056d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801056e0 <sys_exit>:
}

int
sys_exit(void)
{
801056e0:	55                   	push   %ebp
801056e1:	89 e5                	mov    %esp,%ebp
801056e3:	83 ec 08             	sub    $0x8,%esp
  exit();
801056e6:	e8 25 e7 ff ff       	call   80103e10 <exit>
  return 0;  // not reached
}
801056eb:	31 c0                	xor    %eax,%eax
801056ed:	c9                   	leave  
801056ee:	c3                   	ret    
801056ef:	90                   	nop

801056f0 <sys_wait>:

int
sys_wait(void)
{
801056f0:	55                   	push   %ebp
801056f1:	89 e5                	mov    %esp,%ebp
  return wait();
}
801056f3:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
801056f4:	e9 67 e9 ff ff       	jmp    80104060 <wait>
801056f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105700 <sys_kill>:
}

int
sys_kill(void)
{
80105700:	55                   	push   %ebp
80105701:	89 e5                	mov    %esp,%ebp
80105703:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105706:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105709:	50                   	push   %eax
8010570a:	6a 00                	push   $0x0
8010570c:	e8 7f f2 ff ff       	call   80104990 <argint>
80105711:	83 c4 10             	add    $0x10,%esp
80105714:	85 c0                	test   %eax,%eax
80105716:	78 18                	js     80105730 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105718:	83 ec 0c             	sub    $0xc,%esp
8010571b:	ff 75 f4             	pushl  -0xc(%ebp)
8010571e:	e8 8d ea ff ff       	call   801041b0 <kill>
80105723:	83 c4 10             	add    $0x10,%esp
}
80105726:	c9                   	leave  
80105727:	c3                   	ret    
80105728:	90                   	nop
80105729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
80105730:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
80105735:	c9                   	leave  
80105736:	c3                   	ret    
80105737:	89 f6                	mov    %esi,%esi
80105739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105740 <sys_getpid>:

int
sys_getpid(void)
{
80105740:	55                   	push   %ebp
80105741:	89 e5                	mov    %esp,%ebp
80105743:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105746:	e8 95 e2 ff ff       	call   801039e0 <myproc>
8010574b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010574e:	c9                   	leave  
8010574f:	c3                   	ret    

80105750 <sys_sbrk>:

int
sys_sbrk(void)
{
80105750:	55                   	push   %ebp
80105751:	89 e5                	mov    %esp,%ebp
80105753:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105754:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return myproc()->pid;
}

int
sys_sbrk(void)
{
80105757:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
8010575a:	50                   	push   %eax
8010575b:	6a 00                	push   $0x0
8010575d:	e8 2e f2 ff ff       	call   80104990 <argint>
80105762:	83 c4 10             	add    $0x10,%esp
80105765:	85 c0                	test   %eax,%eax
80105767:	78 27                	js     80105790 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105769:	e8 72 e2 ff ff       	call   801039e0 <myproc>
  if(growproc(n) < 0)
8010576e:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
80105771:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105773:	ff 75 f4             	pushl  -0xc(%ebp)
80105776:	e8 85 e3 ff ff       	call   80103b00 <growproc>
8010577b:	83 c4 10             	add    $0x10,%esp
8010577e:	85 c0                	test   %eax,%eax
80105780:	78 0e                	js     80105790 <sys_sbrk+0x40>
    return -1;
  return addr;
80105782:	89 d8                	mov    %ebx,%eax
}
80105784:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105787:	c9                   	leave  
80105788:	c3                   	ret    
80105789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80105790:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105795:	eb ed                	jmp    80105784 <sys_sbrk+0x34>
80105797:	89 f6                	mov    %esi,%esi
80105799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057a0 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
801057a0:	55                   	push   %ebp
801057a1:	89 e5                	mov    %esp,%ebp
801057a3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801057a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return addr;
}

int
sys_sleep(void)
{
801057a7:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801057aa:	50                   	push   %eax
801057ab:	6a 00                	push   $0x0
801057ad:	e8 de f1 ff ff       	call   80104990 <argint>
801057b2:	83 c4 10             	add    $0x10,%esp
801057b5:	85 c0                	test   %eax,%eax
801057b7:	0f 88 8a 00 00 00    	js     80105847 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801057bd:	83 ec 0c             	sub    $0xc,%esp
801057c0:	68 00 5c 11 80       	push   $0x80115c00
801057c5:	e8 46 ed ff ff       	call   80104510 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801057ca:	8b 55 f4             	mov    -0xc(%ebp),%edx
801057cd:	83 c4 10             	add    $0x10,%esp
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
801057d0:	8b 1d 40 64 11 80    	mov    0x80116440,%ebx
  while(ticks - ticks0 < n){
801057d6:	85 d2                	test   %edx,%edx
801057d8:	75 27                	jne    80105801 <sys_sleep+0x61>
801057da:	eb 54                	jmp    80105830 <sys_sleep+0x90>
801057dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801057e0:	83 ec 08             	sub    $0x8,%esp
801057e3:	68 00 5c 11 80       	push   $0x80115c00
801057e8:	68 40 64 11 80       	push   $0x80116440
801057ed:	e8 ae e7 ff ff       	call   80103fa0 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801057f2:	a1 40 64 11 80       	mov    0x80116440,%eax
801057f7:	83 c4 10             	add    $0x10,%esp
801057fa:	29 d8                	sub    %ebx,%eax
801057fc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801057ff:	73 2f                	jae    80105830 <sys_sleep+0x90>
    if(myproc()->killed){
80105801:	e8 da e1 ff ff       	call   801039e0 <myproc>
80105806:	8b 40 24             	mov    0x24(%eax),%eax
80105809:	85 c0                	test   %eax,%eax
8010580b:	74 d3                	je     801057e0 <sys_sleep+0x40>
      release(&tickslock);
8010580d:	83 ec 0c             	sub    $0xc,%esp
80105810:	68 00 5c 11 80       	push   $0x80115c00
80105815:	e8 16 ee ff ff       	call   80104630 <release>
      return -1;
8010581a:	83 c4 10             	add    $0x10,%esp
8010581d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
80105822:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105825:	c9                   	leave  
80105826:	c3                   	ret    
80105827:	89 f6                	mov    %esi,%esi
80105829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80105830:	83 ec 0c             	sub    $0xc,%esp
80105833:	68 00 5c 11 80       	push   $0x80115c00
80105838:	e8 f3 ed ff ff       	call   80104630 <release>
  return 0;
8010583d:	83 c4 10             	add    $0x10,%esp
80105840:	31 c0                	xor    %eax,%eax
}
80105842:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105845:	c9                   	leave  
80105846:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
80105847:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010584c:	eb d4                	jmp    80105822 <sys_sleep+0x82>
8010584e:	66 90                	xchg   %ax,%ax

80105850 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105850:	55                   	push   %ebp
80105851:	89 e5                	mov    %esp,%ebp
80105853:	53                   	push   %ebx
80105854:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105857:	68 00 5c 11 80       	push   $0x80115c00
8010585c:	e8 af ec ff ff       	call   80104510 <acquire>
  xticks = ticks;
80105861:	8b 1d 40 64 11 80    	mov    0x80116440,%ebx
  release(&tickslock);
80105867:	c7 04 24 00 5c 11 80 	movl   $0x80115c00,(%esp)
8010586e:	e8 bd ed ff ff       	call   80104630 <release>
  return xticks;
}
80105873:	89 d8                	mov    %ebx,%eax
80105875:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105878:	c9                   	leave  
80105879:	c3                   	ret    
8010587a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105880 <sys_captsc>:

int
sys_captsc(void)
{
80105880:	55                   	push   %ebp
80105881:	89 e5                	mov    %esp,%ebp
80105883:	53                   	push   %ebx
  int* handler;
  if (argptr(0, (void*)&handler, sizeof(handler)) < 0)
80105884:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return xticks;
}

int
sys_captsc(void)
{
80105887:	83 ec 18             	sub    $0x18,%esp
  int* handler;
  if (argptr(0, (void*)&handler, sizeof(handler)) < 0)
8010588a:	6a 04                	push   $0x4
8010588c:	50                   	push   %eax
8010588d:	6a 00                	push   $0x0
8010588f:	e8 4c f1 ff ff       	call   801049e0 <argptr>
80105894:	83 c4 10             	add    $0x10,%esp
80105897:	85 c0                	test   %eax,%eax
80105899:	78 25                	js     801058c0 <sys_captsc+0x40>
    return -1;
  return capturescreen(myproc()->pid, handler);
8010589b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010589e:	e8 3d e1 ff ff       	call   801039e0 <myproc>
801058a3:	83 ec 08             	sub    $0x8,%esp
801058a6:	53                   	push   %ebx
801058a7:	ff 70 10             	pushl  0x10(%eax)
801058aa:	e8 c1 af ff ff       	call   80100870 <capturescreen>
801058af:	83 c4 10             	add    $0x10,%esp
}
801058b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801058b5:	c9                   	leave  
801058b6:	c3                   	ret    
801058b7:	89 f6                	mov    %esi,%esi
801058b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
int
sys_captsc(void)
{
  int* handler;
  if (argptr(0, (void*)&handler, sizeof(handler)) < 0)
    return -1;
801058c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058c5:	eb eb                	jmp    801058b2 <sys_captsc+0x32>
801058c7:	89 f6                	mov    %esi,%esi
801058c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058d0 <sys_freesc>:
  return capturescreen(myproc()->pid, handler);
}

int
sys_freesc(void)
{
801058d0:	55                   	push   %ebp
801058d1:	89 e5                	mov    %esp,%ebp
801058d3:	83 ec 08             	sub    $0x8,%esp
  return freescreen(myproc()->pid);
801058d6:	e8 05 e1 ff ff       	call   801039e0 <myproc>
801058db:	83 ec 0c             	sub    $0xc,%esp
801058de:	ff 70 10             	pushl  0x10(%eax)
801058e1:	e8 1a b0 ff ff       	call   80100900 <freescreen>
}
801058e6:	c9                   	leave  
801058e7:	c3                   	ret    
801058e8:	90                   	nop
801058e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801058f0 <sys_updatesc>:

int
sys_updatesc(void) {
801058f0:	55                   	push   %ebp
801058f1:	89 e5                	mov    %esp,%ebp
801058f3:	57                   	push   %edi
801058f4:	56                   	push   %esi
801058f5:	53                   	push   %ebx
  int x, y, color;
  char* content;
  if(argint(0, &x) < 0)
801058f6:	8d 45 d8             	lea    -0x28(%ebp),%eax
{
  return freescreen(myproc()->pid);
}

int
sys_updatesc(void) {
801058f9:	83 ec 34             	sub    $0x34,%esp
  int x, y, color;
  char* content;
  if(argint(0, &x) < 0)
801058fc:	50                   	push   %eax
801058fd:	6a 00                	push   $0x0
801058ff:	e8 8c f0 ff ff       	call   80104990 <argint>
80105904:	83 c4 10             	add    $0x10,%esp
80105907:	85 c0                	test   %eax,%eax
80105909:	78 75                	js     80105980 <sys_updatesc+0x90>
    return -1;
  if(argint(1, &y) < 0)
8010590b:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010590e:	83 ec 08             	sub    $0x8,%esp
80105911:	50                   	push   %eax
80105912:	6a 01                	push   $0x1
80105914:	e8 77 f0 ff ff       	call   80104990 <argint>
80105919:	83 c4 10             	add    $0x10,%esp
8010591c:	85 c0                	test   %eax,%eax
8010591e:	78 60                	js     80105980 <sys_updatesc+0x90>
    return -1;
  if (argptr(2, (void*)&content, sizeof(content)) < 0)
80105920:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105923:	83 ec 04             	sub    $0x4,%esp
80105926:	6a 04                	push   $0x4
80105928:	50                   	push   %eax
80105929:	6a 02                	push   $0x2
8010592b:	e8 b0 f0 ff ff       	call   801049e0 <argptr>
80105930:	83 c4 10             	add    $0x10,%esp
80105933:	85 c0                	test   %eax,%eax
80105935:	78 49                	js     80105980 <sys_updatesc+0x90>
    return -1;
  if(argint(3, &color) < 0)
80105937:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010593a:	83 ec 08             	sub    $0x8,%esp
8010593d:	50                   	push   %eax
8010593e:	6a 03                	push   $0x3
80105940:	e8 4b f0 ff ff       	call   80104990 <argint>
80105945:	83 c4 10             	add    $0x10,%esp
80105948:	85 c0                	test   %eax,%eax
8010594a:	78 34                	js     80105980 <sys_updatesc+0x90>
    return -1;
  return updatescreen(myproc()->pid, x, y, content, color);
8010594c:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010594f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80105952:	8b 75 dc             	mov    -0x24(%ebp),%esi
80105955:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80105958:	89 55 d4             	mov    %edx,-0x2c(%ebp)
8010595b:	e8 80 e0 ff ff       	call   801039e0 <myproc>
80105960:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80105963:	83 ec 0c             	sub    $0xc,%esp
80105966:	52                   	push   %edx
80105967:	57                   	push   %edi
80105968:	56                   	push   %esi
80105969:	53                   	push   %ebx
8010596a:	ff 70 10             	pushl  0x10(%eax)
8010596d:	e8 fe af ff ff       	call   80100970 <updatescreen>
80105972:	83 c4 20             	add    $0x20,%esp
}
80105975:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105978:	5b                   	pop    %ebx
80105979:	5e                   	pop    %esi
8010597a:	5f                   	pop    %edi
8010597b:	5d                   	pop    %ebp
8010597c:	c3                   	ret    
8010597d:	8d 76 00             	lea    0x0(%esi),%esi
80105980:	8d 65 f4             	lea    -0xc(%ebp),%esp
int
sys_updatesc(void) {
  int x, y, color;
  char* content;
  if(argint(0, &x) < 0)
    return -1;
80105983:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if (argptr(2, (void*)&content, sizeof(content)) < 0)
    return -1;
  if(argint(3, &color) < 0)
    return -1;
  return updatescreen(myproc()->pid, x, y, content, color);
}
80105988:	5b                   	pop    %ebx
80105989:	5e                   	pop    %esi
8010598a:	5f                   	pop    %edi
8010598b:	5d                   	pop    %ebp
8010598c:	c3                   	ret    
8010598d:	8d 76 00             	lea    0x0(%esi),%esi

80105990 <sys_getkey>:

int 
sys_getkey(void)
{
80105990:	55                   	push   %ebp
80105991:	89 e5                	mov    %esp,%ebp
80105993:	83 ec 08             	sub    $0x8,%esp
  return readkey(myproc()->pid);
80105996:	e8 45 e0 ff ff       	call   801039e0 <myproc>
8010599b:	83 ec 0c             	sub    $0xc,%esp
8010599e:	ff 70 10             	pushl  0x10(%eax)
801059a1:	e8 7a b2 ff ff       	call   80100c20 <readkey>
}
801059a6:	c9                   	leave  
801059a7:	c3                   	ret    

801059a8 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801059a8:	1e                   	push   %ds
  pushl %es
801059a9:	06                   	push   %es
  pushl %fs
801059aa:	0f a0                	push   %fs
  pushl %gs
801059ac:	0f a8                	push   %gs
  pushal
801059ae:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
801059af:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801059b3:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801059b5:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
801059b7:	54                   	push   %esp
  call trap
801059b8:	e8 e3 00 00 00       	call   80105aa0 <trap>
  addl $4, %esp
801059bd:	83 c4 04             	add    $0x4,%esp

801059c0 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801059c0:	61                   	popa   
  popl %gs
801059c1:	0f a9                	pop    %gs
  popl %fs
801059c3:	0f a1                	pop    %fs
  popl %es
801059c5:	07                   	pop    %es
  popl %ds
801059c6:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801059c7:	83 c4 08             	add    $0x8,%esp
  iret
801059ca:	cf                   	iret   
801059cb:	66 90                	xchg   %ax,%ax
801059cd:	66 90                	xchg   %ax,%ax
801059cf:	90                   	nop

801059d0 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
801059d0:	31 c0                	xor    %eax,%eax
801059d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801059d8:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
801059df:	b9 08 00 00 00       	mov    $0x8,%ecx
801059e4:	c6 04 c5 44 5c 11 80 	movb   $0x0,-0x7feea3bc(,%eax,8)
801059eb:	00 
801059ec:	66 89 0c c5 42 5c 11 	mov    %cx,-0x7feea3be(,%eax,8)
801059f3:	80 
801059f4:	c6 04 c5 45 5c 11 80 	movb   $0x8e,-0x7feea3bb(,%eax,8)
801059fb:	8e 
801059fc:	66 89 14 c5 40 5c 11 	mov    %dx,-0x7feea3c0(,%eax,8)
80105a03:	80 
80105a04:	c1 ea 10             	shr    $0x10,%edx
80105a07:	66 89 14 c5 46 5c 11 	mov    %dx,-0x7feea3ba(,%eax,8)
80105a0e:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105a0f:	83 c0 01             	add    $0x1,%eax
80105a12:	3d 00 01 00 00       	cmp    $0x100,%eax
80105a17:	75 bf                	jne    801059d8 <tvinit+0x8>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105a19:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105a1a:	ba 08 00 00 00       	mov    $0x8,%edx
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105a1f:	89 e5                	mov    %esp,%ebp
80105a21:	83 ec 10             	sub    $0x10,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105a24:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105a29:	68 09 7a 10 80       	push   $0x80107a09
80105a2e:	68 00 5c 11 80       	push   $0x80115c00
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105a33:	66 89 15 42 5e 11 80 	mov    %dx,0x80115e42
80105a3a:	c6 05 44 5e 11 80 00 	movb   $0x0,0x80115e44
80105a41:	66 a3 40 5e 11 80    	mov    %ax,0x80115e40
80105a47:	c1 e8 10             	shr    $0x10,%eax
80105a4a:	c6 05 45 5e 11 80 ef 	movb   $0xef,0x80115e45
80105a51:	66 a3 46 5e 11 80    	mov    %ax,0x80115e46

  initlock(&tickslock, "time");
80105a57:	e8 b4 e9 ff ff       	call   80104410 <initlock>
}
80105a5c:	83 c4 10             	add    $0x10,%esp
80105a5f:	c9                   	leave  
80105a60:	c3                   	ret    
80105a61:	eb 0d                	jmp    80105a70 <idtinit>
80105a63:	90                   	nop
80105a64:	90                   	nop
80105a65:	90                   	nop
80105a66:	90                   	nop
80105a67:	90                   	nop
80105a68:	90                   	nop
80105a69:	90                   	nop
80105a6a:	90                   	nop
80105a6b:	90                   	nop
80105a6c:	90                   	nop
80105a6d:	90                   	nop
80105a6e:	90                   	nop
80105a6f:	90                   	nop

80105a70 <idtinit>:

void
idtinit(void)
{
80105a70:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80105a71:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105a76:	89 e5                	mov    %esp,%ebp
80105a78:	83 ec 10             	sub    $0x10,%esp
80105a7b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105a7f:	b8 40 5c 11 80       	mov    $0x80115c40,%eax
80105a84:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105a88:	c1 e8 10             	shr    $0x10,%eax
80105a8b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80105a8f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105a92:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105a95:	c9                   	leave  
80105a96:	c3                   	ret    
80105a97:	89 f6                	mov    %esi,%esi
80105a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105aa0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105aa0:	55                   	push   %ebp
80105aa1:	89 e5                	mov    %esp,%ebp
80105aa3:	57                   	push   %edi
80105aa4:	56                   	push   %esi
80105aa5:	53                   	push   %ebx
80105aa6:	83 ec 1c             	sub    $0x1c,%esp
80105aa9:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
80105aac:	8b 47 30             	mov    0x30(%edi),%eax
80105aaf:	83 f8 40             	cmp    $0x40,%eax
80105ab2:	0f 84 88 01 00 00    	je     80105c40 <trap+0x1a0>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105ab8:	83 e8 20             	sub    $0x20,%eax
80105abb:	83 f8 1f             	cmp    $0x1f,%eax
80105abe:	77 10                	ja     80105ad0 <trap+0x30>
80105ac0:	ff 24 85 b0 7a 10 80 	jmp    *-0x7fef8550(,%eax,4)
80105ac7:	89 f6                	mov    %esi,%esi
80105ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105ad0:	e8 0b df ff ff       	call   801039e0 <myproc>
80105ad5:	85 c0                	test   %eax,%eax
80105ad7:	0f 84 d7 01 00 00    	je     80105cb4 <trap+0x214>
80105add:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105ae1:	0f 84 cd 01 00 00    	je     80105cb4 <trap+0x214>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105ae7:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105aea:	8b 57 38             	mov    0x38(%edi),%edx
80105aed:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105af0:	89 55 dc             	mov    %edx,-0x24(%ebp)
80105af3:	e8 c8 de ff ff       	call   801039c0 <cpuid>
80105af8:	8b 77 34             	mov    0x34(%edi),%esi
80105afb:	8b 5f 30             	mov    0x30(%edi),%ebx
80105afe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105b01:	e8 da de ff ff       	call   801039e0 <myproc>
80105b06:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105b09:	e8 d2 de ff ff       	call   801039e0 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b0e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105b11:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105b14:	51                   	push   %ecx
80105b15:	52                   	push   %edx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105b16:	8b 55 e0             	mov    -0x20(%ebp),%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b19:	ff 75 e4             	pushl  -0x1c(%ebp)
80105b1c:	56                   	push   %esi
80105b1d:	53                   	push   %ebx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105b1e:	83 c2 6c             	add    $0x6c,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b21:	52                   	push   %edx
80105b22:	ff 70 10             	pushl  0x10(%eax)
80105b25:	68 6c 7a 10 80       	push   $0x80107a6c
80105b2a:	e8 51 ab ff ff       	call   80100680 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105b2f:	83 c4 20             	add    $0x20,%esp
80105b32:	e8 a9 de ff ff       	call   801039e0 <myproc>
80105b37:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80105b3e:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b40:	e8 9b de ff ff       	call   801039e0 <myproc>
80105b45:	85 c0                	test   %eax,%eax
80105b47:	74 0c                	je     80105b55 <trap+0xb5>
80105b49:	e8 92 de ff ff       	call   801039e0 <myproc>
80105b4e:	8b 50 24             	mov    0x24(%eax),%edx
80105b51:	85 d2                	test   %edx,%edx
80105b53:	75 4b                	jne    80105ba0 <trap+0x100>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105b55:	e8 86 de ff ff       	call   801039e0 <myproc>
80105b5a:	85 c0                	test   %eax,%eax
80105b5c:	74 0b                	je     80105b69 <trap+0xc9>
80105b5e:	e8 7d de ff ff       	call   801039e0 <myproc>
80105b63:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105b67:	74 4f                	je     80105bb8 <trap+0x118>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b69:	e8 72 de ff ff       	call   801039e0 <myproc>
80105b6e:	85 c0                	test   %eax,%eax
80105b70:	74 1d                	je     80105b8f <trap+0xef>
80105b72:	e8 69 de ff ff       	call   801039e0 <myproc>
80105b77:	8b 40 24             	mov    0x24(%eax),%eax
80105b7a:	85 c0                	test   %eax,%eax
80105b7c:	74 11                	je     80105b8f <trap+0xef>
80105b7e:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105b82:	83 e0 03             	and    $0x3,%eax
80105b85:	66 83 f8 03          	cmp    $0x3,%ax
80105b89:	0f 84 da 00 00 00    	je     80105c69 <trap+0x1c9>
    exit();
}
80105b8f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b92:	5b                   	pop    %ebx
80105b93:	5e                   	pop    %esi
80105b94:	5f                   	pop    %edi
80105b95:	5d                   	pop    %ebp
80105b96:	c3                   	ret    
80105b97:	89 f6                	mov    %esi,%esi
80105b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ba0:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105ba4:	83 e0 03             	and    $0x3,%eax
80105ba7:	66 83 f8 03          	cmp    $0x3,%ax
80105bab:	75 a8                	jne    80105b55 <trap+0xb5>
    exit();
80105bad:	e8 5e e2 ff ff       	call   80103e10 <exit>
80105bb2:	eb a1                	jmp    80105b55 <trap+0xb5>
80105bb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105bb8:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105bbc:	75 ab                	jne    80105b69 <trap+0xc9>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
80105bbe:	e8 8d e3 ff ff       	call   80103f50 <yield>
80105bc3:	eb a4                	jmp    80105b69 <trap+0xc9>
80105bc5:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80105bc8:	e8 f3 dd ff ff       	call   801039c0 <cpuid>
80105bcd:	85 c0                	test   %eax,%eax
80105bcf:	0f 84 ab 00 00 00    	je     80105c80 <trap+0x1e0>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80105bd5:	e8 96 cd ff ff       	call   80102970 <lapiceoi>
    break;
80105bda:	e9 61 ff ff ff       	jmp    80105b40 <trap+0xa0>
80105bdf:	90                   	nop
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80105be0:	e8 4b cc ff ff       	call   80102830 <kbdintr>
    lapiceoi();
80105be5:	e8 86 cd ff ff       	call   80102970 <lapiceoi>
    break;
80105bea:	e9 51 ff ff ff       	jmp    80105b40 <trap+0xa0>
80105bef:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80105bf0:	e8 5b 02 00 00       	call   80105e50 <uartintr>
    lapiceoi();
80105bf5:	e8 76 cd ff ff       	call   80102970 <lapiceoi>
    break;
80105bfa:	e9 41 ff ff ff       	jmp    80105b40 <trap+0xa0>
80105bff:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105c00:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105c04:	8b 77 38             	mov    0x38(%edi),%esi
80105c07:	e8 b4 dd ff ff       	call   801039c0 <cpuid>
80105c0c:	56                   	push   %esi
80105c0d:	53                   	push   %ebx
80105c0e:	50                   	push   %eax
80105c0f:	68 14 7a 10 80       	push   $0x80107a14
80105c14:	e8 67 aa ff ff       	call   80100680 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
80105c19:	e8 52 cd ff ff       	call   80102970 <lapiceoi>
    break;
80105c1e:	83 c4 10             	add    $0x10,%esp
80105c21:	e9 1a ff ff ff       	jmp    80105b40 <trap+0xa0>
80105c26:	8d 76 00             	lea    0x0(%esi),%esi
80105c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105c30:	e8 7b c6 ff ff       	call   801022b0 <ideintr>
80105c35:	eb 9e                	jmp    80105bd5 <trap+0x135>
80105c37:	89 f6                	mov    %esi,%esi
80105c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
80105c40:	e8 9b dd ff ff       	call   801039e0 <myproc>
80105c45:	8b 58 24             	mov    0x24(%eax),%ebx
80105c48:	85 db                	test   %ebx,%ebx
80105c4a:	75 2c                	jne    80105c78 <trap+0x1d8>
      exit();
    myproc()->tf = tf;
80105c4c:	e8 8f dd ff ff       	call   801039e0 <myproc>
80105c51:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80105c54:	e8 27 ee ff ff       	call   80104a80 <syscall>
    if(myproc()->killed)
80105c59:	e8 82 dd ff ff       	call   801039e0 <myproc>
80105c5e:	8b 48 24             	mov    0x24(%eax),%ecx
80105c61:	85 c9                	test   %ecx,%ecx
80105c63:	0f 84 26 ff ff ff    	je     80105b8f <trap+0xef>
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80105c69:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c6c:	5b                   	pop    %ebx
80105c6d:	5e                   	pop    %esi
80105c6e:	5f                   	pop    %edi
80105c6f:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
80105c70:	e9 9b e1 ff ff       	jmp    80103e10 <exit>
80105c75:	8d 76 00             	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
80105c78:	e8 93 e1 ff ff       	call   80103e10 <exit>
80105c7d:	eb cd                	jmp    80105c4c <trap+0x1ac>
80105c7f:	90                   	nop
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
80105c80:	83 ec 0c             	sub    $0xc,%esp
80105c83:	68 00 5c 11 80       	push   $0x80115c00
80105c88:	e8 83 e8 ff ff       	call   80104510 <acquire>
      ticks++;
      wakeup(&ticks);
80105c8d:	c7 04 24 40 64 11 80 	movl   $0x80116440,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
80105c94:	83 05 40 64 11 80 01 	addl   $0x1,0x80116440
      wakeup(&ticks);
80105c9b:	e8 b0 e4 ff ff       	call   80104150 <wakeup>
      release(&tickslock);
80105ca0:	c7 04 24 00 5c 11 80 	movl   $0x80115c00,(%esp)
80105ca7:	e8 84 e9 ff ff       	call   80104630 <release>
80105cac:	83 c4 10             	add    $0x10,%esp
80105caf:	e9 21 ff ff ff       	jmp    80105bd5 <trap+0x135>
80105cb4:	0f 20 d6             	mov    %cr2,%esi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105cb7:	8b 5f 38             	mov    0x38(%edi),%ebx
80105cba:	e8 01 dd ff ff       	call   801039c0 <cpuid>
80105cbf:	83 ec 0c             	sub    $0xc,%esp
80105cc2:	56                   	push   %esi
80105cc3:	53                   	push   %ebx
80105cc4:	50                   	push   %eax
80105cc5:	ff 77 30             	pushl  0x30(%edi)
80105cc8:	68 38 7a 10 80       	push   $0x80107a38
80105ccd:	e8 ae a9 ff ff       	call   80100680 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
80105cd2:	83 c4 14             	add    $0x14,%esp
80105cd5:	68 0e 7a 10 80       	push   $0x80107a0e
80105cda:	e8 91 a6 ff ff       	call   80100370 <panic>
80105cdf:	90                   	nop

80105ce0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105ce0:	a1 5c b5 10 80       	mov    0x8010b55c,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80105ce5:	55                   	push   %ebp
80105ce6:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105ce8:	85 c0                	test   %eax,%eax
80105cea:	74 1c                	je     80105d08 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105cec:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105cf1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105cf2:	a8 01                	test   $0x1,%al
80105cf4:	74 12                	je     80105d08 <uartgetc+0x28>
80105cf6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105cfb:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105cfc:	0f b6 c0             	movzbl %al,%eax
}
80105cff:	5d                   	pop    %ebp
80105d00:	c3                   	ret    
80105d01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80105d08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
80105d0d:	5d                   	pop    %ebp
80105d0e:	c3                   	ret    
80105d0f:	90                   	nop

80105d10 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
80105d10:	55                   	push   %ebp
80105d11:	89 e5                	mov    %esp,%ebp
80105d13:	57                   	push   %edi
80105d14:	56                   	push   %esi
80105d15:	53                   	push   %ebx
80105d16:	89 c7                	mov    %eax,%edi
80105d18:	bb 80 00 00 00       	mov    $0x80,%ebx
80105d1d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105d22:	83 ec 0c             	sub    $0xc,%esp
80105d25:	eb 1b                	jmp    80105d42 <uartputc.part.0+0x32>
80105d27:	89 f6                	mov    %esi,%esi
80105d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80105d30:	83 ec 0c             	sub    $0xc,%esp
80105d33:	6a 0a                	push   $0xa
80105d35:	e8 56 cc ff ff       	call   80102990 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105d3a:	83 c4 10             	add    $0x10,%esp
80105d3d:	83 eb 01             	sub    $0x1,%ebx
80105d40:	74 07                	je     80105d49 <uartputc.part.0+0x39>
80105d42:	89 f2                	mov    %esi,%edx
80105d44:	ec                   	in     (%dx),%al
80105d45:	a8 20                	test   $0x20,%al
80105d47:	74 e7                	je     80105d30 <uartputc.part.0+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105d49:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d4e:	89 f8                	mov    %edi,%eax
80105d50:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80105d51:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d54:	5b                   	pop    %ebx
80105d55:	5e                   	pop    %esi
80105d56:	5f                   	pop    %edi
80105d57:	5d                   	pop    %ebp
80105d58:	c3                   	ret    
80105d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d60 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80105d60:	55                   	push   %ebp
80105d61:	31 c9                	xor    %ecx,%ecx
80105d63:	89 c8                	mov    %ecx,%eax
80105d65:	89 e5                	mov    %esp,%ebp
80105d67:	57                   	push   %edi
80105d68:	56                   	push   %esi
80105d69:	53                   	push   %ebx
80105d6a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105d6f:	89 da                	mov    %ebx,%edx
80105d71:	83 ec 0c             	sub    $0xc,%esp
80105d74:	ee                   	out    %al,(%dx)
80105d75:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105d7a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105d7f:	89 fa                	mov    %edi,%edx
80105d81:	ee                   	out    %al,(%dx)
80105d82:	b8 0c 00 00 00       	mov    $0xc,%eax
80105d87:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d8c:	ee                   	out    %al,(%dx)
80105d8d:	be f9 03 00 00       	mov    $0x3f9,%esi
80105d92:	89 c8                	mov    %ecx,%eax
80105d94:	89 f2                	mov    %esi,%edx
80105d96:	ee                   	out    %al,(%dx)
80105d97:	b8 03 00 00 00       	mov    $0x3,%eax
80105d9c:	89 fa                	mov    %edi,%edx
80105d9e:	ee                   	out    %al,(%dx)
80105d9f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105da4:	89 c8                	mov    %ecx,%eax
80105da6:	ee                   	out    %al,(%dx)
80105da7:	b8 01 00 00 00       	mov    $0x1,%eax
80105dac:	89 f2                	mov    %esi,%edx
80105dae:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105daf:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105db4:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80105db5:	3c ff                	cmp    $0xff,%al
80105db7:	74 5a                	je     80105e13 <uartinit+0xb3>
    return;
  uart = 1;
80105db9:	c7 05 5c b5 10 80 01 	movl   $0x1,0x8010b55c
80105dc0:	00 00 00 
80105dc3:	89 da                	mov    %ebx,%edx
80105dc5:	ec                   	in     (%dx),%al
80105dc6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105dcb:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
80105dcc:	83 ec 08             	sub    $0x8,%esp
80105dcf:	bb 30 7b 10 80       	mov    $0x80107b30,%ebx
80105dd4:	6a 00                	push   $0x0
80105dd6:	6a 04                	push   $0x4
80105dd8:	e8 23 c7 ff ff       	call   80102500 <ioapicenable>
80105ddd:	83 c4 10             	add    $0x10,%esp
80105de0:	b8 78 00 00 00       	mov    $0x78,%eax
80105de5:	eb 13                	jmp    80105dfa <uartinit+0x9a>
80105de7:	89 f6                	mov    %esi,%esi
80105de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105df0:	83 c3 01             	add    $0x1,%ebx
80105df3:	0f be 03             	movsbl (%ebx),%eax
80105df6:	84 c0                	test   %al,%al
80105df8:	74 19                	je     80105e13 <uartinit+0xb3>
void
uartputc(int c)
{
  int i;

  if(!uart)
80105dfa:	8b 15 5c b5 10 80    	mov    0x8010b55c,%edx
80105e00:	85 d2                	test   %edx,%edx
80105e02:	74 ec                	je     80105df0 <uartinit+0x90>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105e04:	83 c3 01             	add    $0x1,%ebx
80105e07:	e8 04 ff ff ff       	call   80105d10 <uartputc.part.0>
80105e0c:	0f be 03             	movsbl (%ebx),%eax
80105e0f:	84 c0                	test   %al,%al
80105e11:	75 e7                	jne    80105dfa <uartinit+0x9a>
    uartputc(*p);
}
80105e13:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e16:	5b                   	pop    %ebx
80105e17:	5e                   	pop    %esi
80105e18:	5f                   	pop    %edi
80105e19:	5d                   	pop    %ebp
80105e1a:	c3                   	ret    
80105e1b:	90                   	nop
80105e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105e20 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80105e20:	8b 15 5c b5 10 80    	mov    0x8010b55c,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105e26:	55                   	push   %ebp
80105e27:	89 e5                	mov    %esp,%ebp
  int i;

  if(!uart)
80105e29:	85 d2                	test   %edx,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105e2b:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
80105e2e:	74 10                	je     80105e40 <uartputc+0x20>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80105e30:	5d                   	pop    %ebp
80105e31:	e9 da fe ff ff       	jmp    80105d10 <uartputc.part.0>
80105e36:	8d 76 00             	lea    0x0(%esi),%esi
80105e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105e40:	5d                   	pop    %ebp
80105e41:	c3                   	ret    
80105e42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e50 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80105e50:	55                   	push   %ebp
80105e51:	89 e5                	mov    %esp,%ebp
80105e53:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105e56:	68 e0 5c 10 80       	push   $0x80105ce0
80105e5b:	e8 90 ab ff ff       	call   801009f0 <consoleintr>
}
80105e60:	83 c4 10             	add    $0x10,%esp
80105e63:	c9                   	leave  
80105e64:	c3                   	ret    

80105e65 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105e65:	6a 00                	push   $0x0
  pushl $0
80105e67:	6a 00                	push   $0x0
  jmp alltraps
80105e69:	e9 3a fb ff ff       	jmp    801059a8 <alltraps>

80105e6e <vector1>:
.globl vector1
vector1:
  pushl $0
80105e6e:	6a 00                	push   $0x0
  pushl $1
80105e70:	6a 01                	push   $0x1
  jmp alltraps
80105e72:	e9 31 fb ff ff       	jmp    801059a8 <alltraps>

80105e77 <vector2>:
.globl vector2
vector2:
  pushl $0
80105e77:	6a 00                	push   $0x0
  pushl $2
80105e79:	6a 02                	push   $0x2
  jmp alltraps
80105e7b:	e9 28 fb ff ff       	jmp    801059a8 <alltraps>

80105e80 <vector3>:
.globl vector3
vector3:
  pushl $0
80105e80:	6a 00                	push   $0x0
  pushl $3
80105e82:	6a 03                	push   $0x3
  jmp alltraps
80105e84:	e9 1f fb ff ff       	jmp    801059a8 <alltraps>

80105e89 <vector4>:
.globl vector4
vector4:
  pushl $0
80105e89:	6a 00                	push   $0x0
  pushl $4
80105e8b:	6a 04                	push   $0x4
  jmp alltraps
80105e8d:	e9 16 fb ff ff       	jmp    801059a8 <alltraps>

80105e92 <vector5>:
.globl vector5
vector5:
  pushl $0
80105e92:	6a 00                	push   $0x0
  pushl $5
80105e94:	6a 05                	push   $0x5
  jmp alltraps
80105e96:	e9 0d fb ff ff       	jmp    801059a8 <alltraps>

80105e9b <vector6>:
.globl vector6
vector6:
  pushl $0
80105e9b:	6a 00                	push   $0x0
  pushl $6
80105e9d:	6a 06                	push   $0x6
  jmp alltraps
80105e9f:	e9 04 fb ff ff       	jmp    801059a8 <alltraps>

80105ea4 <vector7>:
.globl vector7
vector7:
  pushl $0
80105ea4:	6a 00                	push   $0x0
  pushl $7
80105ea6:	6a 07                	push   $0x7
  jmp alltraps
80105ea8:	e9 fb fa ff ff       	jmp    801059a8 <alltraps>

80105ead <vector8>:
.globl vector8
vector8:
  pushl $8
80105ead:	6a 08                	push   $0x8
  jmp alltraps
80105eaf:	e9 f4 fa ff ff       	jmp    801059a8 <alltraps>

80105eb4 <vector9>:
.globl vector9
vector9:
  pushl $0
80105eb4:	6a 00                	push   $0x0
  pushl $9
80105eb6:	6a 09                	push   $0x9
  jmp alltraps
80105eb8:	e9 eb fa ff ff       	jmp    801059a8 <alltraps>

80105ebd <vector10>:
.globl vector10
vector10:
  pushl $10
80105ebd:	6a 0a                	push   $0xa
  jmp alltraps
80105ebf:	e9 e4 fa ff ff       	jmp    801059a8 <alltraps>

80105ec4 <vector11>:
.globl vector11
vector11:
  pushl $11
80105ec4:	6a 0b                	push   $0xb
  jmp alltraps
80105ec6:	e9 dd fa ff ff       	jmp    801059a8 <alltraps>

80105ecb <vector12>:
.globl vector12
vector12:
  pushl $12
80105ecb:	6a 0c                	push   $0xc
  jmp alltraps
80105ecd:	e9 d6 fa ff ff       	jmp    801059a8 <alltraps>

80105ed2 <vector13>:
.globl vector13
vector13:
  pushl $13
80105ed2:	6a 0d                	push   $0xd
  jmp alltraps
80105ed4:	e9 cf fa ff ff       	jmp    801059a8 <alltraps>

80105ed9 <vector14>:
.globl vector14
vector14:
  pushl $14
80105ed9:	6a 0e                	push   $0xe
  jmp alltraps
80105edb:	e9 c8 fa ff ff       	jmp    801059a8 <alltraps>

80105ee0 <vector15>:
.globl vector15
vector15:
  pushl $0
80105ee0:	6a 00                	push   $0x0
  pushl $15
80105ee2:	6a 0f                	push   $0xf
  jmp alltraps
80105ee4:	e9 bf fa ff ff       	jmp    801059a8 <alltraps>

80105ee9 <vector16>:
.globl vector16
vector16:
  pushl $0
80105ee9:	6a 00                	push   $0x0
  pushl $16
80105eeb:	6a 10                	push   $0x10
  jmp alltraps
80105eed:	e9 b6 fa ff ff       	jmp    801059a8 <alltraps>

80105ef2 <vector17>:
.globl vector17
vector17:
  pushl $17
80105ef2:	6a 11                	push   $0x11
  jmp alltraps
80105ef4:	e9 af fa ff ff       	jmp    801059a8 <alltraps>

80105ef9 <vector18>:
.globl vector18
vector18:
  pushl $0
80105ef9:	6a 00                	push   $0x0
  pushl $18
80105efb:	6a 12                	push   $0x12
  jmp alltraps
80105efd:	e9 a6 fa ff ff       	jmp    801059a8 <alltraps>

80105f02 <vector19>:
.globl vector19
vector19:
  pushl $0
80105f02:	6a 00                	push   $0x0
  pushl $19
80105f04:	6a 13                	push   $0x13
  jmp alltraps
80105f06:	e9 9d fa ff ff       	jmp    801059a8 <alltraps>

80105f0b <vector20>:
.globl vector20
vector20:
  pushl $0
80105f0b:	6a 00                	push   $0x0
  pushl $20
80105f0d:	6a 14                	push   $0x14
  jmp alltraps
80105f0f:	e9 94 fa ff ff       	jmp    801059a8 <alltraps>

80105f14 <vector21>:
.globl vector21
vector21:
  pushl $0
80105f14:	6a 00                	push   $0x0
  pushl $21
80105f16:	6a 15                	push   $0x15
  jmp alltraps
80105f18:	e9 8b fa ff ff       	jmp    801059a8 <alltraps>

80105f1d <vector22>:
.globl vector22
vector22:
  pushl $0
80105f1d:	6a 00                	push   $0x0
  pushl $22
80105f1f:	6a 16                	push   $0x16
  jmp alltraps
80105f21:	e9 82 fa ff ff       	jmp    801059a8 <alltraps>

80105f26 <vector23>:
.globl vector23
vector23:
  pushl $0
80105f26:	6a 00                	push   $0x0
  pushl $23
80105f28:	6a 17                	push   $0x17
  jmp alltraps
80105f2a:	e9 79 fa ff ff       	jmp    801059a8 <alltraps>

80105f2f <vector24>:
.globl vector24
vector24:
  pushl $0
80105f2f:	6a 00                	push   $0x0
  pushl $24
80105f31:	6a 18                	push   $0x18
  jmp alltraps
80105f33:	e9 70 fa ff ff       	jmp    801059a8 <alltraps>

80105f38 <vector25>:
.globl vector25
vector25:
  pushl $0
80105f38:	6a 00                	push   $0x0
  pushl $25
80105f3a:	6a 19                	push   $0x19
  jmp alltraps
80105f3c:	e9 67 fa ff ff       	jmp    801059a8 <alltraps>

80105f41 <vector26>:
.globl vector26
vector26:
  pushl $0
80105f41:	6a 00                	push   $0x0
  pushl $26
80105f43:	6a 1a                	push   $0x1a
  jmp alltraps
80105f45:	e9 5e fa ff ff       	jmp    801059a8 <alltraps>

80105f4a <vector27>:
.globl vector27
vector27:
  pushl $0
80105f4a:	6a 00                	push   $0x0
  pushl $27
80105f4c:	6a 1b                	push   $0x1b
  jmp alltraps
80105f4e:	e9 55 fa ff ff       	jmp    801059a8 <alltraps>

80105f53 <vector28>:
.globl vector28
vector28:
  pushl $0
80105f53:	6a 00                	push   $0x0
  pushl $28
80105f55:	6a 1c                	push   $0x1c
  jmp alltraps
80105f57:	e9 4c fa ff ff       	jmp    801059a8 <alltraps>

80105f5c <vector29>:
.globl vector29
vector29:
  pushl $0
80105f5c:	6a 00                	push   $0x0
  pushl $29
80105f5e:	6a 1d                	push   $0x1d
  jmp alltraps
80105f60:	e9 43 fa ff ff       	jmp    801059a8 <alltraps>

80105f65 <vector30>:
.globl vector30
vector30:
  pushl $0
80105f65:	6a 00                	push   $0x0
  pushl $30
80105f67:	6a 1e                	push   $0x1e
  jmp alltraps
80105f69:	e9 3a fa ff ff       	jmp    801059a8 <alltraps>

80105f6e <vector31>:
.globl vector31
vector31:
  pushl $0
80105f6e:	6a 00                	push   $0x0
  pushl $31
80105f70:	6a 1f                	push   $0x1f
  jmp alltraps
80105f72:	e9 31 fa ff ff       	jmp    801059a8 <alltraps>

80105f77 <vector32>:
.globl vector32
vector32:
  pushl $0
80105f77:	6a 00                	push   $0x0
  pushl $32
80105f79:	6a 20                	push   $0x20
  jmp alltraps
80105f7b:	e9 28 fa ff ff       	jmp    801059a8 <alltraps>

80105f80 <vector33>:
.globl vector33
vector33:
  pushl $0
80105f80:	6a 00                	push   $0x0
  pushl $33
80105f82:	6a 21                	push   $0x21
  jmp alltraps
80105f84:	e9 1f fa ff ff       	jmp    801059a8 <alltraps>

80105f89 <vector34>:
.globl vector34
vector34:
  pushl $0
80105f89:	6a 00                	push   $0x0
  pushl $34
80105f8b:	6a 22                	push   $0x22
  jmp alltraps
80105f8d:	e9 16 fa ff ff       	jmp    801059a8 <alltraps>

80105f92 <vector35>:
.globl vector35
vector35:
  pushl $0
80105f92:	6a 00                	push   $0x0
  pushl $35
80105f94:	6a 23                	push   $0x23
  jmp alltraps
80105f96:	e9 0d fa ff ff       	jmp    801059a8 <alltraps>

80105f9b <vector36>:
.globl vector36
vector36:
  pushl $0
80105f9b:	6a 00                	push   $0x0
  pushl $36
80105f9d:	6a 24                	push   $0x24
  jmp alltraps
80105f9f:	e9 04 fa ff ff       	jmp    801059a8 <alltraps>

80105fa4 <vector37>:
.globl vector37
vector37:
  pushl $0
80105fa4:	6a 00                	push   $0x0
  pushl $37
80105fa6:	6a 25                	push   $0x25
  jmp alltraps
80105fa8:	e9 fb f9 ff ff       	jmp    801059a8 <alltraps>

80105fad <vector38>:
.globl vector38
vector38:
  pushl $0
80105fad:	6a 00                	push   $0x0
  pushl $38
80105faf:	6a 26                	push   $0x26
  jmp alltraps
80105fb1:	e9 f2 f9 ff ff       	jmp    801059a8 <alltraps>

80105fb6 <vector39>:
.globl vector39
vector39:
  pushl $0
80105fb6:	6a 00                	push   $0x0
  pushl $39
80105fb8:	6a 27                	push   $0x27
  jmp alltraps
80105fba:	e9 e9 f9 ff ff       	jmp    801059a8 <alltraps>

80105fbf <vector40>:
.globl vector40
vector40:
  pushl $0
80105fbf:	6a 00                	push   $0x0
  pushl $40
80105fc1:	6a 28                	push   $0x28
  jmp alltraps
80105fc3:	e9 e0 f9 ff ff       	jmp    801059a8 <alltraps>

80105fc8 <vector41>:
.globl vector41
vector41:
  pushl $0
80105fc8:	6a 00                	push   $0x0
  pushl $41
80105fca:	6a 29                	push   $0x29
  jmp alltraps
80105fcc:	e9 d7 f9 ff ff       	jmp    801059a8 <alltraps>

80105fd1 <vector42>:
.globl vector42
vector42:
  pushl $0
80105fd1:	6a 00                	push   $0x0
  pushl $42
80105fd3:	6a 2a                	push   $0x2a
  jmp alltraps
80105fd5:	e9 ce f9 ff ff       	jmp    801059a8 <alltraps>

80105fda <vector43>:
.globl vector43
vector43:
  pushl $0
80105fda:	6a 00                	push   $0x0
  pushl $43
80105fdc:	6a 2b                	push   $0x2b
  jmp alltraps
80105fde:	e9 c5 f9 ff ff       	jmp    801059a8 <alltraps>

80105fe3 <vector44>:
.globl vector44
vector44:
  pushl $0
80105fe3:	6a 00                	push   $0x0
  pushl $44
80105fe5:	6a 2c                	push   $0x2c
  jmp alltraps
80105fe7:	e9 bc f9 ff ff       	jmp    801059a8 <alltraps>

80105fec <vector45>:
.globl vector45
vector45:
  pushl $0
80105fec:	6a 00                	push   $0x0
  pushl $45
80105fee:	6a 2d                	push   $0x2d
  jmp alltraps
80105ff0:	e9 b3 f9 ff ff       	jmp    801059a8 <alltraps>

80105ff5 <vector46>:
.globl vector46
vector46:
  pushl $0
80105ff5:	6a 00                	push   $0x0
  pushl $46
80105ff7:	6a 2e                	push   $0x2e
  jmp alltraps
80105ff9:	e9 aa f9 ff ff       	jmp    801059a8 <alltraps>

80105ffe <vector47>:
.globl vector47
vector47:
  pushl $0
80105ffe:	6a 00                	push   $0x0
  pushl $47
80106000:	6a 2f                	push   $0x2f
  jmp alltraps
80106002:	e9 a1 f9 ff ff       	jmp    801059a8 <alltraps>

80106007 <vector48>:
.globl vector48
vector48:
  pushl $0
80106007:	6a 00                	push   $0x0
  pushl $48
80106009:	6a 30                	push   $0x30
  jmp alltraps
8010600b:	e9 98 f9 ff ff       	jmp    801059a8 <alltraps>

80106010 <vector49>:
.globl vector49
vector49:
  pushl $0
80106010:	6a 00                	push   $0x0
  pushl $49
80106012:	6a 31                	push   $0x31
  jmp alltraps
80106014:	e9 8f f9 ff ff       	jmp    801059a8 <alltraps>

80106019 <vector50>:
.globl vector50
vector50:
  pushl $0
80106019:	6a 00                	push   $0x0
  pushl $50
8010601b:	6a 32                	push   $0x32
  jmp alltraps
8010601d:	e9 86 f9 ff ff       	jmp    801059a8 <alltraps>

80106022 <vector51>:
.globl vector51
vector51:
  pushl $0
80106022:	6a 00                	push   $0x0
  pushl $51
80106024:	6a 33                	push   $0x33
  jmp alltraps
80106026:	e9 7d f9 ff ff       	jmp    801059a8 <alltraps>

8010602b <vector52>:
.globl vector52
vector52:
  pushl $0
8010602b:	6a 00                	push   $0x0
  pushl $52
8010602d:	6a 34                	push   $0x34
  jmp alltraps
8010602f:	e9 74 f9 ff ff       	jmp    801059a8 <alltraps>

80106034 <vector53>:
.globl vector53
vector53:
  pushl $0
80106034:	6a 00                	push   $0x0
  pushl $53
80106036:	6a 35                	push   $0x35
  jmp alltraps
80106038:	e9 6b f9 ff ff       	jmp    801059a8 <alltraps>

8010603d <vector54>:
.globl vector54
vector54:
  pushl $0
8010603d:	6a 00                	push   $0x0
  pushl $54
8010603f:	6a 36                	push   $0x36
  jmp alltraps
80106041:	e9 62 f9 ff ff       	jmp    801059a8 <alltraps>

80106046 <vector55>:
.globl vector55
vector55:
  pushl $0
80106046:	6a 00                	push   $0x0
  pushl $55
80106048:	6a 37                	push   $0x37
  jmp alltraps
8010604a:	e9 59 f9 ff ff       	jmp    801059a8 <alltraps>

8010604f <vector56>:
.globl vector56
vector56:
  pushl $0
8010604f:	6a 00                	push   $0x0
  pushl $56
80106051:	6a 38                	push   $0x38
  jmp alltraps
80106053:	e9 50 f9 ff ff       	jmp    801059a8 <alltraps>

80106058 <vector57>:
.globl vector57
vector57:
  pushl $0
80106058:	6a 00                	push   $0x0
  pushl $57
8010605a:	6a 39                	push   $0x39
  jmp alltraps
8010605c:	e9 47 f9 ff ff       	jmp    801059a8 <alltraps>

80106061 <vector58>:
.globl vector58
vector58:
  pushl $0
80106061:	6a 00                	push   $0x0
  pushl $58
80106063:	6a 3a                	push   $0x3a
  jmp alltraps
80106065:	e9 3e f9 ff ff       	jmp    801059a8 <alltraps>

8010606a <vector59>:
.globl vector59
vector59:
  pushl $0
8010606a:	6a 00                	push   $0x0
  pushl $59
8010606c:	6a 3b                	push   $0x3b
  jmp alltraps
8010606e:	e9 35 f9 ff ff       	jmp    801059a8 <alltraps>

80106073 <vector60>:
.globl vector60
vector60:
  pushl $0
80106073:	6a 00                	push   $0x0
  pushl $60
80106075:	6a 3c                	push   $0x3c
  jmp alltraps
80106077:	e9 2c f9 ff ff       	jmp    801059a8 <alltraps>

8010607c <vector61>:
.globl vector61
vector61:
  pushl $0
8010607c:	6a 00                	push   $0x0
  pushl $61
8010607e:	6a 3d                	push   $0x3d
  jmp alltraps
80106080:	e9 23 f9 ff ff       	jmp    801059a8 <alltraps>

80106085 <vector62>:
.globl vector62
vector62:
  pushl $0
80106085:	6a 00                	push   $0x0
  pushl $62
80106087:	6a 3e                	push   $0x3e
  jmp alltraps
80106089:	e9 1a f9 ff ff       	jmp    801059a8 <alltraps>

8010608e <vector63>:
.globl vector63
vector63:
  pushl $0
8010608e:	6a 00                	push   $0x0
  pushl $63
80106090:	6a 3f                	push   $0x3f
  jmp alltraps
80106092:	e9 11 f9 ff ff       	jmp    801059a8 <alltraps>

80106097 <vector64>:
.globl vector64
vector64:
  pushl $0
80106097:	6a 00                	push   $0x0
  pushl $64
80106099:	6a 40                	push   $0x40
  jmp alltraps
8010609b:	e9 08 f9 ff ff       	jmp    801059a8 <alltraps>

801060a0 <vector65>:
.globl vector65
vector65:
  pushl $0
801060a0:	6a 00                	push   $0x0
  pushl $65
801060a2:	6a 41                	push   $0x41
  jmp alltraps
801060a4:	e9 ff f8 ff ff       	jmp    801059a8 <alltraps>

801060a9 <vector66>:
.globl vector66
vector66:
  pushl $0
801060a9:	6a 00                	push   $0x0
  pushl $66
801060ab:	6a 42                	push   $0x42
  jmp alltraps
801060ad:	e9 f6 f8 ff ff       	jmp    801059a8 <alltraps>

801060b2 <vector67>:
.globl vector67
vector67:
  pushl $0
801060b2:	6a 00                	push   $0x0
  pushl $67
801060b4:	6a 43                	push   $0x43
  jmp alltraps
801060b6:	e9 ed f8 ff ff       	jmp    801059a8 <alltraps>

801060bb <vector68>:
.globl vector68
vector68:
  pushl $0
801060bb:	6a 00                	push   $0x0
  pushl $68
801060bd:	6a 44                	push   $0x44
  jmp alltraps
801060bf:	e9 e4 f8 ff ff       	jmp    801059a8 <alltraps>

801060c4 <vector69>:
.globl vector69
vector69:
  pushl $0
801060c4:	6a 00                	push   $0x0
  pushl $69
801060c6:	6a 45                	push   $0x45
  jmp alltraps
801060c8:	e9 db f8 ff ff       	jmp    801059a8 <alltraps>

801060cd <vector70>:
.globl vector70
vector70:
  pushl $0
801060cd:	6a 00                	push   $0x0
  pushl $70
801060cf:	6a 46                	push   $0x46
  jmp alltraps
801060d1:	e9 d2 f8 ff ff       	jmp    801059a8 <alltraps>

801060d6 <vector71>:
.globl vector71
vector71:
  pushl $0
801060d6:	6a 00                	push   $0x0
  pushl $71
801060d8:	6a 47                	push   $0x47
  jmp alltraps
801060da:	e9 c9 f8 ff ff       	jmp    801059a8 <alltraps>

801060df <vector72>:
.globl vector72
vector72:
  pushl $0
801060df:	6a 00                	push   $0x0
  pushl $72
801060e1:	6a 48                	push   $0x48
  jmp alltraps
801060e3:	e9 c0 f8 ff ff       	jmp    801059a8 <alltraps>

801060e8 <vector73>:
.globl vector73
vector73:
  pushl $0
801060e8:	6a 00                	push   $0x0
  pushl $73
801060ea:	6a 49                	push   $0x49
  jmp alltraps
801060ec:	e9 b7 f8 ff ff       	jmp    801059a8 <alltraps>

801060f1 <vector74>:
.globl vector74
vector74:
  pushl $0
801060f1:	6a 00                	push   $0x0
  pushl $74
801060f3:	6a 4a                	push   $0x4a
  jmp alltraps
801060f5:	e9 ae f8 ff ff       	jmp    801059a8 <alltraps>

801060fa <vector75>:
.globl vector75
vector75:
  pushl $0
801060fa:	6a 00                	push   $0x0
  pushl $75
801060fc:	6a 4b                	push   $0x4b
  jmp alltraps
801060fe:	e9 a5 f8 ff ff       	jmp    801059a8 <alltraps>

80106103 <vector76>:
.globl vector76
vector76:
  pushl $0
80106103:	6a 00                	push   $0x0
  pushl $76
80106105:	6a 4c                	push   $0x4c
  jmp alltraps
80106107:	e9 9c f8 ff ff       	jmp    801059a8 <alltraps>

8010610c <vector77>:
.globl vector77
vector77:
  pushl $0
8010610c:	6a 00                	push   $0x0
  pushl $77
8010610e:	6a 4d                	push   $0x4d
  jmp alltraps
80106110:	e9 93 f8 ff ff       	jmp    801059a8 <alltraps>

80106115 <vector78>:
.globl vector78
vector78:
  pushl $0
80106115:	6a 00                	push   $0x0
  pushl $78
80106117:	6a 4e                	push   $0x4e
  jmp alltraps
80106119:	e9 8a f8 ff ff       	jmp    801059a8 <alltraps>

8010611e <vector79>:
.globl vector79
vector79:
  pushl $0
8010611e:	6a 00                	push   $0x0
  pushl $79
80106120:	6a 4f                	push   $0x4f
  jmp alltraps
80106122:	e9 81 f8 ff ff       	jmp    801059a8 <alltraps>

80106127 <vector80>:
.globl vector80
vector80:
  pushl $0
80106127:	6a 00                	push   $0x0
  pushl $80
80106129:	6a 50                	push   $0x50
  jmp alltraps
8010612b:	e9 78 f8 ff ff       	jmp    801059a8 <alltraps>

80106130 <vector81>:
.globl vector81
vector81:
  pushl $0
80106130:	6a 00                	push   $0x0
  pushl $81
80106132:	6a 51                	push   $0x51
  jmp alltraps
80106134:	e9 6f f8 ff ff       	jmp    801059a8 <alltraps>

80106139 <vector82>:
.globl vector82
vector82:
  pushl $0
80106139:	6a 00                	push   $0x0
  pushl $82
8010613b:	6a 52                	push   $0x52
  jmp alltraps
8010613d:	e9 66 f8 ff ff       	jmp    801059a8 <alltraps>

80106142 <vector83>:
.globl vector83
vector83:
  pushl $0
80106142:	6a 00                	push   $0x0
  pushl $83
80106144:	6a 53                	push   $0x53
  jmp alltraps
80106146:	e9 5d f8 ff ff       	jmp    801059a8 <alltraps>

8010614b <vector84>:
.globl vector84
vector84:
  pushl $0
8010614b:	6a 00                	push   $0x0
  pushl $84
8010614d:	6a 54                	push   $0x54
  jmp alltraps
8010614f:	e9 54 f8 ff ff       	jmp    801059a8 <alltraps>

80106154 <vector85>:
.globl vector85
vector85:
  pushl $0
80106154:	6a 00                	push   $0x0
  pushl $85
80106156:	6a 55                	push   $0x55
  jmp alltraps
80106158:	e9 4b f8 ff ff       	jmp    801059a8 <alltraps>

8010615d <vector86>:
.globl vector86
vector86:
  pushl $0
8010615d:	6a 00                	push   $0x0
  pushl $86
8010615f:	6a 56                	push   $0x56
  jmp alltraps
80106161:	e9 42 f8 ff ff       	jmp    801059a8 <alltraps>

80106166 <vector87>:
.globl vector87
vector87:
  pushl $0
80106166:	6a 00                	push   $0x0
  pushl $87
80106168:	6a 57                	push   $0x57
  jmp alltraps
8010616a:	e9 39 f8 ff ff       	jmp    801059a8 <alltraps>

8010616f <vector88>:
.globl vector88
vector88:
  pushl $0
8010616f:	6a 00                	push   $0x0
  pushl $88
80106171:	6a 58                	push   $0x58
  jmp alltraps
80106173:	e9 30 f8 ff ff       	jmp    801059a8 <alltraps>

80106178 <vector89>:
.globl vector89
vector89:
  pushl $0
80106178:	6a 00                	push   $0x0
  pushl $89
8010617a:	6a 59                	push   $0x59
  jmp alltraps
8010617c:	e9 27 f8 ff ff       	jmp    801059a8 <alltraps>

80106181 <vector90>:
.globl vector90
vector90:
  pushl $0
80106181:	6a 00                	push   $0x0
  pushl $90
80106183:	6a 5a                	push   $0x5a
  jmp alltraps
80106185:	e9 1e f8 ff ff       	jmp    801059a8 <alltraps>

8010618a <vector91>:
.globl vector91
vector91:
  pushl $0
8010618a:	6a 00                	push   $0x0
  pushl $91
8010618c:	6a 5b                	push   $0x5b
  jmp alltraps
8010618e:	e9 15 f8 ff ff       	jmp    801059a8 <alltraps>

80106193 <vector92>:
.globl vector92
vector92:
  pushl $0
80106193:	6a 00                	push   $0x0
  pushl $92
80106195:	6a 5c                	push   $0x5c
  jmp alltraps
80106197:	e9 0c f8 ff ff       	jmp    801059a8 <alltraps>

8010619c <vector93>:
.globl vector93
vector93:
  pushl $0
8010619c:	6a 00                	push   $0x0
  pushl $93
8010619e:	6a 5d                	push   $0x5d
  jmp alltraps
801061a0:	e9 03 f8 ff ff       	jmp    801059a8 <alltraps>

801061a5 <vector94>:
.globl vector94
vector94:
  pushl $0
801061a5:	6a 00                	push   $0x0
  pushl $94
801061a7:	6a 5e                	push   $0x5e
  jmp alltraps
801061a9:	e9 fa f7 ff ff       	jmp    801059a8 <alltraps>

801061ae <vector95>:
.globl vector95
vector95:
  pushl $0
801061ae:	6a 00                	push   $0x0
  pushl $95
801061b0:	6a 5f                	push   $0x5f
  jmp alltraps
801061b2:	e9 f1 f7 ff ff       	jmp    801059a8 <alltraps>

801061b7 <vector96>:
.globl vector96
vector96:
  pushl $0
801061b7:	6a 00                	push   $0x0
  pushl $96
801061b9:	6a 60                	push   $0x60
  jmp alltraps
801061bb:	e9 e8 f7 ff ff       	jmp    801059a8 <alltraps>

801061c0 <vector97>:
.globl vector97
vector97:
  pushl $0
801061c0:	6a 00                	push   $0x0
  pushl $97
801061c2:	6a 61                	push   $0x61
  jmp alltraps
801061c4:	e9 df f7 ff ff       	jmp    801059a8 <alltraps>

801061c9 <vector98>:
.globl vector98
vector98:
  pushl $0
801061c9:	6a 00                	push   $0x0
  pushl $98
801061cb:	6a 62                	push   $0x62
  jmp alltraps
801061cd:	e9 d6 f7 ff ff       	jmp    801059a8 <alltraps>

801061d2 <vector99>:
.globl vector99
vector99:
  pushl $0
801061d2:	6a 00                	push   $0x0
  pushl $99
801061d4:	6a 63                	push   $0x63
  jmp alltraps
801061d6:	e9 cd f7 ff ff       	jmp    801059a8 <alltraps>

801061db <vector100>:
.globl vector100
vector100:
  pushl $0
801061db:	6a 00                	push   $0x0
  pushl $100
801061dd:	6a 64                	push   $0x64
  jmp alltraps
801061df:	e9 c4 f7 ff ff       	jmp    801059a8 <alltraps>

801061e4 <vector101>:
.globl vector101
vector101:
  pushl $0
801061e4:	6a 00                	push   $0x0
  pushl $101
801061e6:	6a 65                	push   $0x65
  jmp alltraps
801061e8:	e9 bb f7 ff ff       	jmp    801059a8 <alltraps>

801061ed <vector102>:
.globl vector102
vector102:
  pushl $0
801061ed:	6a 00                	push   $0x0
  pushl $102
801061ef:	6a 66                	push   $0x66
  jmp alltraps
801061f1:	e9 b2 f7 ff ff       	jmp    801059a8 <alltraps>

801061f6 <vector103>:
.globl vector103
vector103:
  pushl $0
801061f6:	6a 00                	push   $0x0
  pushl $103
801061f8:	6a 67                	push   $0x67
  jmp alltraps
801061fa:	e9 a9 f7 ff ff       	jmp    801059a8 <alltraps>

801061ff <vector104>:
.globl vector104
vector104:
  pushl $0
801061ff:	6a 00                	push   $0x0
  pushl $104
80106201:	6a 68                	push   $0x68
  jmp alltraps
80106203:	e9 a0 f7 ff ff       	jmp    801059a8 <alltraps>

80106208 <vector105>:
.globl vector105
vector105:
  pushl $0
80106208:	6a 00                	push   $0x0
  pushl $105
8010620a:	6a 69                	push   $0x69
  jmp alltraps
8010620c:	e9 97 f7 ff ff       	jmp    801059a8 <alltraps>

80106211 <vector106>:
.globl vector106
vector106:
  pushl $0
80106211:	6a 00                	push   $0x0
  pushl $106
80106213:	6a 6a                	push   $0x6a
  jmp alltraps
80106215:	e9 8e f7 ff ff       	jmp    801059a8 <alltraps>

8010621a <vector107>:
.globl vector107
vector107:
  pushl $0
8010621a:	6a 00                	push   $0x0
  pushl $107
8010621c:	6a 6b                	push   $0x6b
  jmp alltraps
8010621e:	e9 85 f7 ff ff       	jmp    801059a8 <alltraps>

80106223 <vector108>:
.globl vector108
vector108:
  pushl $0
80106223:	6a 00                	push   $0x0
  pushl $108
80106225:	6a 6c                	push   $0x6c
  jmp alltraps
80106227:	e9 7c f7 ff ff       	jmp    801059a8 <alltraps>

8010622c <vector109>:
.globl vector109
vector109:
  pushl $0
8010622c:	6a 00                	push   $0x0
  pushl $109
8010622e:	6a 6d                	push   $0x6d
  jmp alltraps
80106230:	e9 73 f7 ff ff       	jmp    801059a8 <alltraps>

80106235 <vector110>:
.globl vector110
vector110:
  pushl $0
80106235:	6a 00                	push   $0x0
  pushl $110
80106237:	6a 6e                	push   $0x6e
  jmp alltraps
80106239:	e9 6a f7 ff ff       	jmp    801059a8 <alltraps>

8010623e <vector111>:
.globl vector111
vector111:
  pushl $0
8010623e:	6a 00                	push   $0x0
  pushl $111
80106240:	6a 6f                	push   $0x6f
  jmp alltraps
80106242:	e9 61 f7 ff ff       	jmp    801059a8 <alltraps>

80106247 <vector112>:
.globl vector112
vector112:
  pushl $0
80106247:	6a 00                	push   $0x0
  pushl $112
80106249:	6a 70                	push   $0x70
  jmp alltraps
8010624b:	e9 58 f7 ff ff       	jmp    801059a8 <alltraps>

80106250 <vector113>:
.globl vector113
vector113:
  pushl $0
80106250:	6a 00                	push   $0x0
  pushl $113
80106252:	6a 71                	push   $0x71
  jmp alltraps
80106254:	e9 4f f7 ff ff       	jmp    801059a8 <alltraps>

80106259 <vector114>:
.globl vector114
vector114:
  pushl $0
80106259:	6a 00                	push   $0x0
  pushl $114
8010625b:	6a 72                	push   $0x72
  jmp alltraps
8010625d:	e9 46 f7 ff ff       	jmp    801059a8 <alltraps>

80106262 <vector115>:
.globl vector115
vector115:
  pushl $0
80106262:	6a 00                	push   $0x0
  pushl $115
80106264:	6a 73                	push   $0x73
  jmp alltraps
80106266:	e9 3d f7 ff ff       	jmp    801059a8 <alltraps>

8010626b <vector116>:
.globl vector116
vector116:
  pushl $0
8010626b:	6a 00                	push   $0x0
  pushl $116
8010626d:	6a 74                	push   $0x74
  jmp alltraps
8010626f:	e9 34 f7 ff ff       	jmp    801059a8 <alltraps>

80106274 <vector117>:
.globl vector117
vector117:
  pushl $0
80106274:	6a 00                	push   $0x0
  pushl $117
80106276:	6a 75                	push   $0x75
  jmp alltraps
80106278:	e9 2b f7 ff ff       	jmp    801059a8 <alltraps>

8010627d <vector118>:
.globl vector118
vector118:
  pushl $0
8010627d:	6a 00                	push   $0x0
  pushl $118
8010627f:	6a 76                	push   $0x76
  jmp alltraps
80106281:	e9 22 f7 ff ff       	jmp    801059a8 <alltraps>

80106286 <vector119>:
.globl vector119
vector119:
  pushl $0
80106286:	6a 00                	push   $0x0
  pushl $119
80106288:	6a 77                	push   $0x77
  jmp alltraps
8010628a:	e9 19 f7 ff ff       	jmp    801059a8 <alltraps>

8010628f <vector120>:
.globl vector120
vector120:
  pushl $0
8010628f:	6a 00                	push   $0x0
  pushl $120
80106291:	6a 78                	push   $0x78
  jmp alltraps
80106293:	e9 10 f7 ff ff       	jmp    801059a8 <alltraps>

80106298 <vector121>:
.globl vector121
vector121:
  pushl $0
80106298:	6a 00                	push   $0x0
  pushl $121
8010629a:	6a 79                	push   $0x79
  jmp alltraps
8010629c:	e9 07 f7 ff ff       	jmp    801059a8 <alltraps>

801062a1 <vector122>:
.globl vector122
vector122:
  pushl $0
801062a1:	6a 00                	push   $0x0
  pushl $122
801062a3:	6a 7a                	push   $0x7a
  jmp alltraps
801062a5:	e9 fe f6 ff ff       	jmp    801059a8 <alltraps>

801062aa <vector123>:
.globl vector123
vector123:
  pushl $0
801062aa:	6a 00                	push   $0x0
  pushl $123
801062ac:	6a 7b                	push   $0x7b
  jmp alltraps
801062ae:	e9 f5 f6 ff ff       	jmp    801059a8 <alltraps>

801062b3 <vector124>:
.globl vector124
vector124:
  pushl $0
801062b3:	6a 00                	push   $0x0
  pushl $124
801062b5:	6a 7c                	push   $0x7c
  jmp alltraps
801062b7:	e9 ec f6 ff ff       	jmp    801059a8 <alltraps>

801062bc <vector125>:
.globl vector125
vector125:
  pushl $0
801062bc:	6a 00                	push   $0x0
  pushl $125
801062be:	6a 7d                	push   $0x7d
  jmp alltraps
801062c0:	e9 e3 f6 ff ff       	jmp    801059a8 <alltraps>

801062c5 <vector126>:
.globl vector126
vector126:
  pushl $0
801062c5:	6a 00                	push   $0x0
  pushl $126
801062c7:	6a 7e                	push   $0x7e
  jmp alltraps
801062c9:	e9 da f6 ff ff       	jmp    801059a8 <alltraps>

801062ce <vector127>:
.globl vector127
vector127:
  pushl $0
801062ce:	6a 00                	push   $0x0
  pushl $127
801062d0:	6a 7f                	push   $0x7f
  jmp alltraps
801062d2:	e9 d1 f6 ff ff       	jmp    801059a8 <alltraps>

801062d7 <vector128>:
.globl vector128
vector128:
  pushl $0
801062d7:	6a 00                	push   $0x0
  pushl $128
801062d9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801062de:	e9 c5 f6 ff ff       	jmp    801059a8 <alltraps>

801062e3 <vector129>:
.globl vector129
vector129:
  pushl $0
801062e3:	6a 00                	push   $0x0
  pushl $129
801062e5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801062ea:	e9 b9 f6 ff ff       	jmp    801059a8 <alltraps>

801062ef <vector130>:
.globl vector130
vector130:
  pushl $0
801062ef:	6a 00                	push   $0x0
  pushl $130
801062f1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801062f6:	e9 ad f6 ff ff       	jmp    801059a8 <alltraps>

801062fb <vector131>:
.globl vector131
vector131:
  pushl $0
801062fb:	6a 00                	push   $0x0
  pushl $131
801062fd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106302:	e9 a1 f6 ff ff       	jmp    801059a8 <alltraps>

80106307 <vector132>:
.globl vector132
vector132:
  pushl $0
80106307:	6a 00                	push   $0x0
  pushl $132
80106309:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010630e:	e9 95 f6 ff ff       	jmp    801059a8 <alltraps>

80106313 <vector133>:
.globl vector133
vector133:
  pushl $0
80106313:	6a 00                	push   $0x0
  pushl $133
80106315:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010631a:	e9 89 f6 ff ff       	jmp    801059a8 <alltraps>

8010631f <vector134>:
.globl vector134
vector134:
  pushl $0
8010631f:	6a 00                	push   $0x0
  pushl $134
80106321:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106326:	e9 7d f6 ff ff       	jmp    801059a8 <alltraps>

8010632b <vector135>:
.globl vector135
vector135:
  pushl $0
8010632b:	6a 00                	push   $0x0
  pushl $135
8010632d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106332:	e9 71 f6 ff ff       	jmp    801059a8 <alltraps>

80106337 <vector136>:
.globl vector136
vector136:
  pushl $0
80106337:	6a 00                	push   $0x0
  pushl $136
80106339:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010633e:	e9 65 f6 ff ff       	jmp    801059a8 <alltraps>

80106343 <vector137>:
.globl vector137
vector137:
  pushl $0
80106343:	6a 00                	push   $0x0
  pushl $137
80106345:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010634a:	e9 59 f6 ff ff       	jmp    801059a8 <alltraps>

8010634f <vector138>:
.globl vector138
vector138:
  pushl $0
8010634f:	6a 00                	push   $0x0
  pushl $138
80106351:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106356:	e9 4d f6 ff ff       	jmp    801059a8 <alltraps>

8010635b <vector139>:
.globl vector139
vector139:
  pushl $0
8010635b:	6a 00                	push   $0x0
  pushl $139
8010635d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106362:	e9 41 f6 ff ff       	jmp    801059a8 <alltraps>

80106367 <vector140>:
.globl vector140
vector140:
  pushl $0
80106367:	6a 00                	push   $0x0
  pushl $140
80106369:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010636e:	e9 35 f6 ff ff       	jmp    801059a8 <alltraps>

80106373 <vector141>:
.globl vector141
vector141:
  pushl $0
80106373:	6a 00                	push   $0x0
  pushl $141
80106375:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010637a:	e9 29 f6 ff ff       	jmp    801059a8 <alltraps>

8010637f <vector142>:
.globl vector142
vector142:
  pushl $0
8010637f:	6a 00                	push   $0x0
  pushl $142
80106381:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106386:	e9 1d f6 ff ff       	jmp    801059a8 <alltraps>

8010638b <vector143>:
.globl vector143
vector143:
  pushl $0
8010638b:	6a 00                	push   $0x0
  pushl $143
8010638d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106392:	e9 11 f6 ff ff       	jmp    801059a8 <alltraps>

80106397 <vector144>:
.globl vector144
vector144:
  pushl $0
80106397:	6a 00                	push   $0x0
  pushl $144
80106399:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010639e:	e9 05 f6 ff ff       	jmp    801059a8 <alltraps>

801063a3 <vector145>:
.globl vector145
vector145:
  pushl $0
801063a3:	6a 00                	push   $0x0
  pushl $145
801063a5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801063aa:	e9 f9 f5 ff ff       	jmp    801059a8 <alltraps>

801063af <vector146>:
.globl vector146
vector146:
  pushl $0
801063af:	6a 00                	push   $0x0
  pushl $146
801063b1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801063b6:	e9 ed f5 ff ff       	jmp    801059a8 <alltraps>

801063bb <vector147>:
.globl vector147
vector147:
  pushl $0
801063bb:	6a 00                	push   $0x0
  pushl $147
801063bd:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801063c2:	e9 e1 f5 ff ff       	jmp    801059a8 <alltraps>

801063c7 <vector148>:
.globl vector148
vector148:
  pushl $0
801063c7:	6a 00                	push   $0x0
  pushl $148
801063c9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801063ce:	e9 d5 f5 ff ff       	jmp    801059a8 <alltraps>

801063d3 <vector149>:
.globl vector149
vector149:
  pushl $0
801063d3:	6a 00                	push   $0x0
  pushl $149
801063d5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801063da:	e9 c9 f5 ff ff       	jmp    801059a8 <alltraps>

801063df <vector150>:
.globl vector150
vector150:
  pushl $0
801063df:	6a 00                	push   $0x0
  pushl $150
801063e1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801063e6:	e9 bd f5 ff ff       	jmp    801059a8 <alltraps>

801063eb <vector151>:
.globl vector151
vector151:
  pushl $0
801063eb:	6a 00                	push   $0x0
  pushl $151
801063ed:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801063f2:	e9 b1 f5 ff ff       	jmp    801059a8 <alltraps>

801063f7 <vector152>:
.globl vector152
vector152:
  pushl $0
801063f7:	6a 00                	push   $0x0
  pushl $152
801063f9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801063fe:	e9 a5 f5 ff ff       	jmp    801059a8 <alltraps>

80106403 <vector153>:
.globl vector153
vector153:
  pushl $0
80106403:	6a 00                	push   $0x0
  pushl $153
80106405:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010640a:	e9 99 f5 ff ff       	jmp    801059a8 <alltraps>

8010640f <vector154>:
.globl vector154
vector154:
  pushl $0
8010640f:	6a 00                	push   $0x0
  pushl $154
80106411:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106416:	e9 8d f5 ff ff       	jmp    801059a8 <alltraps>

8010641b <vector155>:
.globl vector155
vector155:
  pushl $0
8010641b:	6a 00                	push   $0x0
  pushl $155
8010641d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106422:	e9 81 f5 ff ff       	jmp    801059a8 <alltraps>

80106427 <vector156>:
.globl vector156
vector156:
  pushl $0
80106427:	6a 00                	push   $0x0
  pushl $156
80106429:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010642e:	e9 75 f5 ff ff       	jmp    801059a8 <alltraps>

80106433 <vector157>:
.globl vector157
vector157:
  pushl $0
80106433:	6a 00                	push   $0x0
  pushl $157
80106435:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010643a:	e9 69 f5 ff ff       	jmp    801059a8 <alltraps>

8010643f <vector158>:
.globl vector158
vector158:
  pushl $0
8010643f:	6a 00                	push   $0x0
  pushl $158
80106441:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106446:	e9 5d f5 ff ff       	jmp    801059a8 <alltraps>

8010644b <vector159>:
.globl vector159
vector159:
  pushl $0
8010644b:	6a 00                	push   $0x0
  pushl $159
8010644d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106452:	e9 51 f5 ff ff       	jmp    801059a8 <alltraps>

80106457 <vector160>:
.globl vector160
vector160:
  pushl $0
80106457:	6a 00                	push   $0x0
  pushl $160
80106459:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010645e:	e9 45 f5 ff ff       	jmp    801059a8 <alltraps>

80106463 <vector161>:
.globl vector161
vector161:
  pushl $0
80106463:	6a 00                	push   $0x0
  pushl $161
80106465:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010646a:	e9 39 f5 ff ff       	jmp    801059a8 <alltraps>

8010646f <vector162>:
.globl vector162
vector162:
  pushl $0
8010646f:	6a 00                	push   $0x0
  pushl $162
80106471:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106476:	e9 2d f5 ff ff       	jmp    801059a8 <alltraps>

8010647b <vector163>:
.globl vector163
vector163:
  pushl $0
8010647b:	6a 00                	push   $0x0
  pushl $163
8010647d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106482:	e9 21 f5 ff ff       	jmp    801059a8 <alltraps>

80106487 <vector164>:
.globl vector164
vector164:
  pushl $0
80106487:	6a 00                	push   $0x0
  pushl $164
80106489:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010648e:	e9 15 f5 ff ff       	jmp    801059a8 <alltraps>

80106493 <vector165>:
.globl vector165
vector165:
  pushl $0
80106493:	6a 00                	push   $0x0
  pushl $165
80106495:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010649a:	e9 09 f5 ff ff       	jmp    801059a8 <alltraps>

8010649f <vector166>:
.globl vector166
vector166:
  pushl $0
8010649f:	6a 00                	push   $0x0
  pushl $166
801064a1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801064a6:	e9 fd f4 ff ff       	jmp    801059a8 <alltraps>

801064ab <vector167>:
.globl vector167
vector167:
  pushl $0
801064ab:	6a 00                	push   $0x0
  pushl $167
801064ad:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801064b2:	e9 f1 f4 ff ff       	jmp    801059a8 <alltraps>

801064b7 <vector168>:
.globl vector168
vector168:
  pushl $0
801064b7:	6a 00                	push   $0x0
  pushl $168
801064b9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801064be:	e9 e5 f4 ff ff       	jmp    801059a8 <alltraps>

801064c3 <vector169>:
.globl vector169
vector169:
  pushl $0
801064c3:	6a 00                	push   $0x0
  pushl $169
801064c5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801064ca:	e9 d9 f4 ff ff       	jmp    801059a8 <alltraps>

801064cf <vector170>:
.globl vector170
vector170:
  pushl $0
801064cf:	6a 00                	push   $0x0
  pushl $170
801064d1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801064d6:	e9 cd f4 ff ff       	jmp    801059a8 <alltraps>

801064db <vector171>:
.globl vector171
vector171:
  pushl $0
801064db:	6a 00                	push   $0x0
  pushl $171
801064dd:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801064e2:	e9 c1 f4 ff ff       	jmp    801059a8 <alltraps>

801064e7 <vector172>:
.globl vector172
vector172:
  pushl $0
801064e7:	6a 00                	push   $0x0
  pushl $172
801064e9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801064ee:	e9 b5 f4 ff ff       	jmp    801059a8 <alltraps>

801064f3 <vector173>:
.globl vector173
vector173:
  pushl $0
801064f3:	6a 00                	push   $0x0
  pushl $173
801064f5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801064fa:	e9 a9 f4 ff ff       	jmp    801059a8 <alltraps>

801064ff <vector174>:
.globl vector174
vector174:
  pushl $0
801064ff:	6a 00                	push   $0x0
  pushl $174
80106501:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106506:	e9 9d f4 ff ff       	jmp    801059a8 <alltraps>

8010650b <vector175>:
.globl vector175
vector175:
  pushl $0
8010650b:	6a 00                	push   $0x0
  pushl $175
8010650d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106512:	e9 91 f4 ff ff       	jmp    801059a8 <alltraps>

80106517 <vector176>:
.globl vector176
vector176:
  pushl $0
80106517:	6a 00                	push   $0x0
  pushl $176
80106519:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010651e:	e9 85 f4 ff ff       	jmp    801059a8 <alltraps>

80106523 <vector177>:
.globl vector177
vector177:
  pushl $0
80106523:	6a 00                	push   $0x0
  pushl $177
80106525:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010652a:	e9 79 f4 ff ff       	jmp    801059a8 <alltraps>

8010652f <vector178>:
.globl vector178
vector178:
  pushl $0
8010652f:	6a 00                	push   $0x0
  pushl $178
80106531:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106536:	e9 6d f4 ff ff       	jmp    801059a8 <alltraps>

8010653b <vector179>:
.globl vector179
vector179:
  pushl $0
8010653b:	6a 00                	push   $0x0
  pushl $179
8010653d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106542:	e9 61 f4 ff ff       	jmp    801059a8 <alltraps>

80106547 <vector180>:
.globl vector180
vector180:
  pushl $0
80106547:	6a 00                	push   $0x0
  pushl $180
80106549:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010654e:	e9 55 f4 ff ff       	jmp    801059a8 <alltraps>

80106553 <vector181>:
.globl vector181
vector181:
  pushl $0
80106553:	6a 00                	push   $0x0
  pushl $181
80106555:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010655a:	e9 49 f4 ff ff       	jmp    801059a8 <alltraps>

8010655f <vector182>:
.globl vector182
vector182:
  pushl $0
8010655f:	6a 00                	push   $0x0
  pushl $182
80106561:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106566:	e9 3d f4 ff ff       	jmp    801059a8 <alltraps>

8010656b <vector183>:
.globl vector183
vector183:
  pushl $0
8010656b:	6a 00                	push   $0x0
  pushl $183
8010656d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106572:	e9 31 f4 ff ff       	jmp    801059a8 <alltraps>

80106577 <vector184>:
.globl vector184
vector184:
  pushl $0
80106577:	6a 00                	push   $0x0
  pushl $184
80106579:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010657e:	e9 25 f4 ff ff       	jmp    801059a8 <alltraps>

80106583 <vector185>:
.globl vector185
vector185:
  pushl $0
80106583:	6a 00                	push   $0x0
  pushl $185
80106585:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010658a:	e9 19 f4 ff ff       	jmp    801059a8 <alltraps>

8010658f <vector186>:
.globl vector186
vector186:
  pushl $0
8010658f:	6a 00                	push   $0x0
  pushl $186
80106591:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106596:	e9 0d f4 ff ff       	jmp    801059a8 <alltraps>

8010659b <vector187>:
.globl vector187
vector187:
  pushl $0
8010659b:	6a 00                	push   $0x0
  pushl $187
8010659d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801065a2:	e9 01 f4 ff ff       	jmp    801059a8 <alltraps>

801065a7 <vector188>:
.globl vector188
vector188:
  pushl $0
801065a7:	6a 00                	push   $0x0
  pushl $188
801065a9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801065ae:	e9 f5 f3 ff ff       	jmp    801059a8 <alltraps>

801065b3 <vector189>:
.globl vector189
vector189:
  pushl $0
801065b3:	6a 00                	push   $0x0
  pushl $189
801065b5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801065ba:	e9 e9 f3 ff ff       	jmp    801059a8 <alltraps>

801065bf <vector190>:
.globl vector190
vector190:
  pushl $0
801065bf:	6a 00                	push   $0x0
  pushl $190
801065c1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801065c6:	e9 dd f3 ff ff       	jmp    801059a8 <alltraps>

801065cb <vector191>:
.globl vector191
vector191:
  pushl $0
801065cb:	6a 00                	push   $0x0
  pushl $191
801065cd:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801065d2:	e9 d1 f3 ff ff       	jmp    801059a8 <alltraps>

801065d7 <vector192>:
.globl vector192
vector192:
  pushl $0
801065d7:	6a 00                	push   $0x0
  pushl $192
801065d9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801065de:	e9 c5 f3 ff ff       	jmp    801059a8 <alltraps>

801065e3 <vector193>:
.globl vector193
vector193:
  pushl $0
801065e3:	6a 00                	push   $0x0
  pushl $193
801065e5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801065ea:	e9 b9 f3 ff ff       	jmp    801059a8 <alltraps>

801065ef <vector194>:
.globl vector194
vector194:
  pushl $0
801065ef:	6a 00                	push   $0x0
  pushl $194
801065f1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801065f6:	e9 ad f3 ff ff       	jmp    801059a8 <alltraps>

801065fb <vector195>:
.globl vector195
vector195:
  pushl $0
801065fb:	6a 00                	push   $0x0
  pushl $195
801065fd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106602:	e9 a1 f3 ff ff       	jmp    801059a8 <alltraps>

80106607 <vector196>:
.globl vector196
vector196:
  pushl $0
80106607:	6a 00                	push   $0x0
  pushl $196
80106609:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010660e:	e9 95 f3 ff ff       	jmp    801059a8 <alltraps>

80106613 <vector197>:
.globl vector197
vector197:
  pushl $0
80106613:	6a 00                	push   $0x0
  pushl $197
80106615:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010661a:	e9 89 f3 ff ff       	jmp    801059a8 <alltraps>

8010661f <vector198>:
.globl vector198
vector198:
  pushl $0
8010661f:	6a 00                	push   $0x0
  pushl $198
80106621:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106626:	e9 7d f3 ff ff       	jmp    801059a8 <alltraps>

8010662b <vector199>:
.globl vector199
vector199:
  pushl $0
8010662b:	6a 00                	push   $0x0
  pushl $199
8010662d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106632:	e9 71 f3 ff ff       	jmp    801059a8 <alltraps>

80106637 <vector200>:
.globl vector200
vector200:
  pushl $0
80106637:	6a 00                	push   $0x0
  pushl $200
80106639:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010663e:	e9 65 f3 ff ff       	jmp    801059a8 <alltraps>

80106643 <vector201>:
.globl vector201
vector201:
  pushl $0
80106643:	6a 00                	push   $0x0
  pushl $201
80106645:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010664a:	e9 59 f3 ff ff       	jmp    801059a8 <alltraps>

8010664f <vector202>:
.globl vector202
vector202:
  pushl $0
8010664f:	6a 00                	push   $0x0
  pushl $202
80106651:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106656:	e9 4d f3 ff ff       	jmp    801059a8 <alltraps>

8010665b <vector203>:
.globl vector203
vector203:
  pushl $0
8010665b:	6a 00                	push   $0x0
  pushl $203
8010665d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106662:	e9 41 f3 ff ff       	jmp    801059a8 <alltraps>

80106667 <vector204>:
.globl vector204
vector204:
  pushl $0
80106667:	6a 00                	push   $0x0
  pushl $204
80106669:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010666e:	e9 35 f3 ff ff       	jmp    801059a8 <alltraps>

80106673 <vector205>:
.globl vector205
vector205:
  pushl $0
80106673:	6a 00                	push   $0x0
  pushl $205
80106675:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010667a:	e9 29 f3 ff ff       	jmp    801059a8 <alltraps>

8010667f <vector206>:
.globl vector206
vector206:
  pushl $0
8010667f:	6a 00                	push   $0x0
  pushl $206
80106681:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106686:	e9 1d f3 ff ff       	jmp    801059a8 <alltraps>

8010668b <vector207>:
.globl vector207
vector207:
  pushl $0
8010668b:	6a 00                	push   $0x0
  pushl $207
8010668d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106692:	e9 11 f3 ff ff       	jmp    801059a8 <alltraps>

80106697 <vector208>:
.globl vector208
vector208:
  pushl $0
80106697:	6a 00                	push   $0x0
  pushl $208
80106699:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010669e:	e9 05 f3 ff ff       	jmp    801059a8 <alltraps>

801066a3 <vector209>:
.globl vector209
vector209:
  pushl $0
801066a3:	6a 00                	push   $0x0
  pushl $209
801066a5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801066aa:	e9 f9 f2 ff ff       	jmp    801059a8 <alltraps>

801066af <vector210>:
.globl vector210
vector210:
  pushl $0
801066af:	6a 00                	push   $0x0
  pushl $210
801066b1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801066b6:	e9 ed f2 ff ff       	jmp    801059a8 <alltraps>

801066bb <vector211>:
.globl vector211
vector211:
  pushl $0
801066bb:	6a 00                	push   $0x0
  pushl $211
801066bd:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801066c2:	e9 e1 f2 ff ff       	jmp    801059a8 <alltraps>

801066c7 <vector212>:
.globl vector212
vector212:
  pushl $0
801066c7:	6a 00                	push   $0x0
  pushl $212
801066c9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801066ce:	e9 d5 f2 ff ff       	jmp    801059a8 <alltraps>

801066d3 <vector213>:
.globl vector213
vector213:
  pushl $0
801066d3:	6a 00                	push   $0x0
  pushl $213
801066d5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801066da:	e9 c9 f2 ff ff       	jmp    801059a8 <alltraps>

801066df <vector214>:
.globl vector214
vector214:
  pushl $0
801066df:	6a 00                	push   $0x0
  pushl $214
801066e1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801066e6:	e9 bd f2 ff ff       	jmp    801059a8 <alltraps>

801066eb <vector215>:
.globl vector215
vector215:
  pushl $0
801066eb:	6a 00                	push   $0x0
  pushl $215
801066ed:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801066f2:	e9 b1 f2 ff ff       	jmp    801059a8 <alltraps>

801066f7 <vector216>:
.globl vector216
vector216:
  pushl $0
801066f7:	6a 00                	push   $0x0
  pushl $216
801066f9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801066fe:	e9 a5 f2 ff ff       	jmp    801059a8 <alltraps>

80106703 <vector217>:
.globl vector217
vector217:
  pushl $0
80106703:	6a 00                	push   $0x0
  pushl $217
80106705:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010670a:	e9 99 f2 ff ff       	jmp    801059a8 <alltraps>

8010670f <vector218>:
.globl vector218
vector218:
  pushl $0
8010670f:	6a 00                	push   $0x0
  pushl $218
80106711:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106716:	e9 8d f2 ff ff       	jmp    801059a8 <alltraps>

8010671b <vector219>:
.globl vector219
vector219:
  pushl $0
8010671b:	6a 00                	push   $0x0
  pushl $219
8010671d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106722:	e9 81 f2 ff ff       	jmp    801059a8 <alltraps>

80106727 <vector220>:
.globl vector220
vector220:
  pushl $0
80106727:	6a 00                	push   $0x0
  pushl $220
80106729:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010672e:	e9 75 f2 ff ff       	jmp    801059a8 <alltraps>

80106733 <vector221>:
.globl vector221
vector221:
  pushl $0
80106733:	6a 00                	push   $0x0
  pushl $221
80106735:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010673a:	e9 69 f2 ff ff       	jmp    801059a8 <alltraps>

8010673f <vector222>:
.globl vector222
vector222:
  pushl $0
8010673f:	6a 00                	push   $0x0
  pushl $222
80106741:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106746:	e9 5d f2 ff ff       	jmp    801059a8 <alltraps>

8010674b <vector223>:
.globl vector223
vector223:
  pushl $0
8010674b:	6a 00                	push   $0x0
  pushl $223
8010674d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106752:	e9 51 f2 ff ff       	jmp    801059a8 <alltraps>

80106757 <vector224>:
.globl vector224
vector224:
  pushl $0
80106757:	6a 00                	push   $0x0
  pushl $224
80106759:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010675e:	e9 45 f2 ff ff       	jmp    801059a8 <alltraps>

80106763 <vector225>:
.globl vector225
vector225:
  pushl $0
80106763:	6a 00                	push   $0x0
  pushl $225
80106765:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010676a:	e9 39 f2 ff ff       	jmp    801059a8 <alltraps>

8010676f <vector226>:
.globl vector226
vector226:
  pushl $0
8010676f:	6a 00                	push   $0x0
  pushl $226
80106771:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106776:	e9 2d f2 ff ff       	jmp    801059a8 <alltraps>

8010677b <vector227>:
.globl vector227
vector227:
  pushl $0
8010677b:	6a 00                	push   $0x0
  pushl $227
8010677d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106782:	e9 21 f2 ff ff       	jmp    801059a8 <alltraps>

80106787 <vector228>:
.globl vector228
vector228:
  pushl $0
80106787:	6a 00                	push   $0x0
  pushl $228
80106789:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010678e:	e9 15 f2 ff ff       	jmp    801059a8 <alltraps>

80106793 <vector229>:
.globl vector229
vector229:
  pushl $0
80106793:	6a 00                	push   $0x0
  pushl $229
80106795:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010679a:	e9 09 f2 ff ff       	jmp    801059a8 <alltraps>

8010679f <vector230>:
.globl vector230
vector230:
  pushl $0
8010679f:	6a 00                	push   $0x0
  pushl $230
801067a1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801067a6:	e9 fd f1 ff ff       	jmp    801059a8 <alltraps>

801067ab <vector231>:
.globl vector231
vector231:
  pushl $0
801067ab:	6a 00                	push   $0x0
  pushl $231
801067ad:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801067b2:	e9 f1 f1 ff ff       	jmp    801059a8 <alltraps>

801067b7 <vector232>:
.globl vector232
vector232:
  pushl $0
801067b7:	6a 00                	push   $0x0
  pushl $232
801067b9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801067be:	e9 e5 f1 ff ff       	jmp    801059a8 <alltraps>

801067c3 <vector233>:
.globl vector233
vector233:
  pushl $0
801067c3:	6a 00                	push   $0x0
  pushl $233
801067c5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801067ca:	e9 d9 f1 ff ff       	jmp    801059a8 <alltraps>

801067cf <vector234>:
.globl vector234
vector234:
  pushl $0
801067cf:	6a 00                	push   $0x0
  pushl $234
801067d1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801067d6:	e9 cd f1 ff ff       	jmp    801059a8 <alltraps>

801067db <vector235>:
.globl vector235
vector235:
  pushl $0
801067db:	6a 00                	push   $0x0
  pushl $235
801067dd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801067e2:	e9 c1 f1 ff ff       	jmp    801059a8 <alltraps>

801067e7 <vector236>:
.globl vector236
vector236:
  pushl $0
801067e7:	6a 00                	push   $0x0
  pushl $236
801067e9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801067ee:	e9 b5 f1 ff ff       	jmp    801059a8 <alltraps>

801067f3 <vector237>:
.globl vector237
vector237:
  pushl $0
801067f3:	6a 00                	push   $0x0
  pushl $237
801067f5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801067fa:	e9 a9 f1 ff ff       	jmp    801059a8 <alltraps>

801067ff <vector238>:
.globl vector238
vector238:
  pushl $0
801067ff:	6a 00                	push   $0x0
  pushl $238
80106801:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106806:	e9 9d f1 ff ff       	jmp    801059a8 <alltraps>

8010680b <vector239>:
.globl vector239
vector239:
  pushl $0
8010680b:	6a 00                	push   $0x0
  pushl $239
8010680d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106812:	e9 91 f1 ff ff       	jmp    801059a8 <alltraps>

80106817 <vector240>:
.globl vector240
vector240:
  pushl $0
80106817:	6a 00                	push   $0x0
  pushl $240
80106819:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010681e:	e9 85 f1 ff ff       	jmp    801059a8 <alltraps>

80106823 <vector241>:
.globl vector241
vector241:
  pushl $0
80106823:	6a 00                	push   $0x0
  pushl $241
80106825:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010682a:	e9 79 f1 ff ff       	jmp    801059a8 <alltraps>

8010682f <vector242>:
.globl vector242
vector242:
  pushl $0
8010682f:	6a 00                	push   $0x0
  pushl $242
80106831:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106836:	e9 6d f1 ff ff       	jmp    801059a8 <alltraps>

8010683b <vector243>:
.globl vector243
vector243:
  pushl $0
8010683b:	6a 00                	push   $0x0
  pushl $243
8010683d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106842:	e9 61 f1 ff ff       	jmp    801059a8 <alltraps>

80106847 <vector244>:
.globl vector244
vector244:
  pushl $0
80106847:	6a 00                	push   $0x0
  pushl $244
80106849:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010684e:	e9 55 f1 ff ff       	jmp    801059a8 <alltraps>

80106853 <vector245>:
.globl vector245
vector245:
  pushl $0
80106853:	6a 00                	push   $0x0
  pushl $245
80106855:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010685a:	e9 49 f1 ff ff       	jmp    801059a8 <alltraps>

8010685f <vector246>:
.globl vector246
vector246:
  pushl $0
8010685f:	6a 00                	push   $0x0
  pushl $246
80106861:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106866:	e9 3d f1 ff ff       	jmp    801059a8 <alltraps>

8010686b <vector247>:
.globl vector247
vector247:
  pushl $0
8010686b:	6a 00                	push   $0x0
  pushl $247
8010686d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106872:	e9 31 f1 ff ff       	jmp    801059a8 <alltraps>

80106877 <vector248>:
.globl vector248
vector248:
  pushl $0
80106877:	6a 00                	push   $0x0
  pushl $248
80106879:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010687e:	e9 25 f1 ff ff       	jmp    801059a8 <alltraps>

80106883 <vector249>:
.globl vector249
vector249:
  pushl $0
80106883:	6a 00                	push   $0x0
  pushl $249
80106885:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010688a:	e9 19 f1 ff ff       	jmp    801059a8 <alltraps>

8010688f <vector250>:
.globl vector250
vector250:
  pushl $0
8010688f:	6a 00                	push   $0x0
  pushl $250
80106891:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106896:	e9 0d f1 ff ff       	jmp    801059a8 <alltraps>

8010689b <vector251>:
.globl vector251
vector251:
  pushl $0
8010689b:	6a 00                	push   $0x0
  pushl $251
8010689d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
801068a2:	e9 01 f1 ff ff       	jmp    801059a8 <alltraps>

801068a7 <vector252>:
.globl vector252
vector252:
  pushl $0
801068a7:	6a 00                	push   $0x0
  pushl $252
801068a9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
801068ae:	e9 f5 f0 ff ff       	jmp    801059a8 <alltraps>

801068b3 <vector253>:
.globl vector253
vector253:
  pushl $0
801068b3:	6a 00                	push   $0x0
  pushl $253
801068b5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801068ba:	e9 e9 f0 ff ff       	jmp    801059a8 <alltraps>

801068bf <vector254>:
.globl vector254
vector254:
  pushl $0
801068bf:	6a 00                	push   $0x0
  pushl $254
801068c1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
801068c6:	e9 dd f0 ff ff       	jmp    801059a8 <alltraps>

801068cb <vector255>:
.globl vector255
vector255:
  pushl $0
801068cb:	6a 00                	push   $0x0
  pushl $255
801068cd:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
801068d2:	e9 d1 f0 ff ff       	jmp    801059a8 <alltraps>
801068d7:	66 90                	xchg   %ax,%ax
801068d9:	66 90                	xchg   %ax,%ax
801068db:	66 90                	xchg   %ax,%ax
801068dd:	66 90                	xchg   %ax,%ax
801068df:	90                   	nop

801068e0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801068e0:	55                   	push   %ebp
801068e1:	89 e5                	mov    %esp,%ebp
801068e3:	57                   	push   %edi
801068e4:	56                   	push   %esi
801068e5:	53                   	push   %ebx
801068e6:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801068e8:	c1 ea 16             	shr    $0x16,%edx
801068eb:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801068ee:	83 ec 0c             	sub    $0xc,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
801068f1:	8b 07                	mov    (%edi),%eax
801068f3:	a8 01                	test   $0x1,%al
801068f5:	74 29                	je     80106920 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801068f7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801068fc:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106902:	8d 65 f4             	lea    -0xc(%ebp),%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106905:	c1 eb 0a             	shr    $0xa,%ebx
80106908:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
8010690e:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
80106911:	5b                   	pop    %ebx
80106912:	5e                   	pop    %esi
80106913:	5f                   	pop    %edi
80106914:	5d                   	pop    %ebp
80106915:	c3                   	ret    
80106916:	8d 76 00             	lea    0x0(%esi),%esi
80106919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106920:	85 c9                	test   %ecx,%ecx
80106922:	74 2c                	je     80106950 <walkpgdir+0x70>
80106924:	e8 c7 bd ff ff       	call   801026f0 <kalloc>
80106929:	85 c0                	test   %eax,%eax
8010692b:	89 c6                	mov    %eax,%esi
8010692d:	74 21                	je     80106950 <walkpgdir+0x70>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
8010692f:	83 ec 04             	sub    $0x4,%esp
80106932:	68 00 10 00 00       	push   $0x1000
80106937:	6a 00                	push   $0x0
80106939:	50                   	push   %eax
8010693a:	e8 41 dd ff ff       	call   80104680 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010693f:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106945:	83 c4 10             	add    $0x10,%esp
80106948:	83 c8 07             	or     $0x7,%eax
8010694b:	89 07                	mov    %eax,(%edi)
8010694d:	eb b3                	jmp    80106902 <walkpgdir+0x22>
8010694f:	90                   	nop
  }
  return &pgtab[PTX(va)];
}
80106950:	8d 65 f4             	lea    -0xc(%ebp),%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
80106953:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106955:	5b                   	pop    %ebx
80106956:	5e                   	pop    %esi
80106957:	5f                   	pop    %edi
80106958:	5d                   	pop    %ebp
80106959:	c3                   	ret    
8010695a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106960 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106960:	55                   	push   %ebp
80106961:	89 e5                	mov    %esp,%ebp
80106963:	57                   	push   %edi
80106964:	56                   	push   %esi
80106965:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106966:	89 d3                	mov    %edx,%ebx
80106968:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
8010696e:	83 ec 1c             	sub    $0x1c,%esp
80106971:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106974:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106978:	8b 7d 08             	mov    0x8(%ebp),%edi
8010697b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106980:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106983:	8b 45 0c             	mov    0xc(%ebp),%eax
80106986:	29 df                	sub    %ebx,%edi
80106988:	83 c8 01             	or     $0x1,%eax
8010698b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010698e:	eb 15                	jmp    801069a5 <mappages+0x45>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80106990:	f6 00 01             	testb  $0x1,(%eax)
80106993:	75 45                	jne    801069da <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80106995:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106998:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
8010699b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010699d:	74 31                	je     801069d0 <mappages+0x70>
      break;
    a += PGSIZE;
8010699f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801069a5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801069a8:	b9 01 00 00 00       	mov    $0x1,%ecx
801069ad:	89 da                	mov    %ebx,%edx
801069af:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
801069b2:	e8 29 ff ff ff       	call   801068e0 <walkpgdir>
801069b7:	85 c0                	test   %eax,%eax
801069b9:	75 d5                	jne    80106990 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
801069bb:	8d 65 f4             	lea    -0xc(%ebp),%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
801069be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
801069c3:	5b                   	pop    %ebx
801069c4:	5e                   	pop    %esi
801069c5:	5f                   	pop    %edi
801069c6:	5d                   	pop    %ebp
801069c7:	c3                   	ret    
801069c8:	90                   	nop
801069c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
801069d3:	31 c0                	xor    %eax,%eax
}
801069d5:	5b                   	pop    %ebx
801069d6:	5e                   	pop    %esi
801069d7:	5f                   	pop    %edi
801069d8:	5d                   	pop    %ebp
801069d9:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
801069da:	83 ec 0c             	sub    $0xc,%esp
801069dd:	68 38 7b 10 80       	push   $0x80107b38
801069e2:	e8 89 99 ff ff       	call   80100370 <panic>
801069e7:	89 f6                	mov    %esi,%esi
801069e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801069f0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801069f0:	55                   	push   %ebp
801069f1:	89 e5                	mov    %esp,%ebp
801069f3:	57                   	push   %edi
801069f4:	56                   	push   %esi
801069f5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801069f6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801069fc:	89 c7                	mov    %eax,%edi
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801069fe:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106a04:	83 ec 1c             	sub    $0x1c,%esp
80106a07:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106a0a:	39 d3                	cmp    %edx,%ebx
80106a0c:	73 66                	jae    80106a74 <deallocuvm.part.0+0x84>
80106a0e:	89 d6                	mov    %edx,%esi
80106a10:	eb 3d                	jmp    80106a4f <deallocuvm.part.0+0x5f>
80106a12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106a18:	8b 10                	mov    (%eax),%edx
80106a1a:	f6 c2 01             	test   $0x1,%dl
80106a1d:	74 26                	je     80106a45 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106a1f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106a25:	74 58                	je     80106a7f <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106a27:	83 ec 0c             	sub    $0xc,%esp
80106a2a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106a30:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106a33:	52                   	push   %edx
80106a34:	e8 07 bb ff ff       	call   80102540 <kfree>
      *pte = 0;
80106a39:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106a3c:	83 c4 10             	add    $0x10,%esp
80106a3f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106a45:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106a4b:	39 f3                	cmp    %esi,%ebx
80106a4d:	73 25                	jae    80106a74 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106a4f:	31 c9                	xor    %ecx,%ecx
80106a51:	89 da                	mov    %ebx,%edx
80106a53:	89 f8                	mov    %edi,%eax
80106a55:	e8 86 fe ff ff       	call   801068e0 <walkpgdir>
    if(!pte)
80106a5a:	85 c0                	test   %eax,%eax
80106a5c:	75 ba                	jne    80106a18 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106a5e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106a64:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106a6a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106a70:	39 f3                	cmp    %esi,%ebx
80106a72:	72 db                	jb     80106a4f <deallocuvm.part.0+0x5f>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106a74:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106a77:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a7a:	5b                   	pop    %ebx
80106a7b:	5e                   	pop    %esi
80106a7c:	5f                   	pop    %edi
80106a7d:	5d                   	pop    %ebp
80106a7e:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80106a7f:	83 ec 0c             	sub    $0xc,%esp
80106a82:	68 c6 74 10 80       	push   $0x801074c6
80106a87:	e8 e4 98 ff ff       	call   80100370 <panic>
80106a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106a90 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80106a90:	55                   	push   %ebp
80106a91:	89 e5                	mov    %esp,%ebp
80106a93:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80106a96:	e8 25 cf ff ff       	call   801039c0 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106a9b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106aa1:	31 c9                	xor    %ecx,%ecx
80106aa3:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106aa8:	66 89 90 98 37 11 80 	mov    %dx,-0x7feec868(%eax)
80106aaf:	66 89 88 9a 37 11 80 	mov    %cx,-0x7feec866(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106ab6:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106abb:	31 c9                	xor    %ecx,%ecx
80106abd:	66 89 90 a0 37 11 80 	mov    %dx,-0x7feec860(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106ac4:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106ac9:	66 89 88 a2 37 11 80 	mov    %cx,-0x7feec85e(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106ad0:	31 c9                	xor    %ecx,%ecx
80106ad2:	66 89 90 a8 37 11 80 	mov    %dx,-0x7feec858(%eax)
80106ad9:	66 89 88 aa 37 11 80 	mov    %cx,-0x7feec856(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106ae0:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106ae5:	31 c9                	xor    %ecx,%ecx
80106ae7:	66 89 90 b0 37 11 80 	mov    %dx,-0x7feec850(%eax)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106aee:	c6 80 9c 37 11 80 00 	movb   $0x0,-0x7feec864(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106af5:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106afa:	c6 80 9d 37 11 80 9a 	movb   $0x9a,-0x7feec863(%eax)
80106b01:	c6 80 9e 37 11 80 cf 	movb   $0xcf,-0x7feec862(%eax)
80106b08:	c6 80 9f 37 11 80 00 	movb   $0x0,-0x7feec861(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106b0f:	c6 80 a4 37 11 80 00 	movb   $0x0,-0x7feec85c(%eax)
80106b16:	c6 80 a5 37 11 80 92 	movb   $0x92,-0x7feec85b(%eax)
80106b1d:	c6 80 a6 37 11 80 cf 	movb   $0xcf,-0x7feec85a(%eax)
80106b24:	c6 80 a7 37 11 80 00 	movb   $0x0,-0x7feec859(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106b2b:	c6 80 ac 37 11 80 00 	movb   $0x0,-0x7feec854(%eax)
80106b32:	c6 80 ad 37 11 80 fa 	movb   $0xfa,-0x7feec853(%eax)
80106b39:	c6 80 ae 37 11 80 cf 	movb   $0xcf,-0x7feec852(%eax)
80106b40:	c6 80 af 37 11 80 00 	movb   $0x0,-0x7feec851(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106b47:	66 89 88 b2 37 11 80 	mov    %cx,-0x7feec84e(%eax)
80106b4e:	c6 80 b4 37 11 80 00 	movb   $0x0,-0x7feec84c(%eax)
80106b55:	c6 80 b5 37 11 80 f2 	movb   $0xf2,-0x7feec84b(%eax)
80106b5c:	c6 80 b6 37 11 80 cf 	movb   $0xcf,-0x7feec84a(%eax)
80106b63:	c6 80 b7 37 11 80 00 	movb   $0x0,-0x7feec849(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80106b6a:	05 90 37 11 80       	add    $0x80113790,%eax
80106b6f:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
80106b73:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106b77:	c1 e8 10             	shr    $0x10,%eax
80106b7a:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80106b7e:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106b81:	0f 01 10             	lgdtl  (%eax)
}
80106b84:	c9                   	leave  
80106b85:	c3                   	ret    
80106b86:	8d 76 00             	lea    0x0(%esi),%esi
80106b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b90 <switchkvm>:
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106b90:	a1 44 64 11 80       	mov    0x80116444,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106b95:	55                   	push   %ebp
80106b96:	89 e5                	mov    %esp,%ebp
80106b98:	05 00 00 00 80       	add    $0x80000000,%eax
80106b9d:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
80106ba0:	5d                   	pop    %ebp
80106ba1:	c3                   	ret    
80106ba2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106bb0 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80106bb0:	55                   	push   %ebp
80106bb1:	89 e5                	mov    %esp,%ebp
80106bb3:	57                   	push   %edi
80106bb4:	56                   	push   %esi
80106bb5:	53                   	push   %ebx
80106bb6:	83 ec 1c             	sub    $0x1c,%esp
80106bb9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106bbc:	85 f6                	test   %esi,%esi
80106bbe:	0f 84 cd 00 00 00    	je     80106c91 <switchuvm+0xe1>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80106bc4:	8b 46 08             	mov    0x8(%esi),%eax
80106bc7:	85 c0                	test   %eax,%eax
80106bc9:	0f 84 dc 00 00 00    	je     80106cab <switchuvm+0xfb>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80106bcf:	8b 7e 04             	mov    0x4(%esi),%edi
80106bd2:	85 ff                	test   %edi,%edi
80106bd4:	0f 84 c4 00 00 00    	je     80106c9e <switchuvm+0xee>
    panic("switchuvm: no pgdir");

  pushcli();
80106bda:	e8 f1 d8 ff ff       	call   801044d0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106bdf:	e8 5c cd ff ff       	call   80103940 <mycpu>
80106be4:	89 c3                	mov    %eax,%ebx
80106be6:	e8 55 cd ff ff       	call   80103940 <mycpu>
80106beb:	89 c7                	mov    %eax,%edi
80106bed:	e8 4e cd ff ff       	call   80103940 <mycpu>
80106bf2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106bf5:	83 c7 08             	add    $0x8,%edi
80106bf8:	e8 43 cd ff ff       	call   80103940 <mycpu>
80106bfd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106c00:	83 c0 08             	add    $0x8,%eax
80106c03:	ba 67 00 00 00       	mov    $0x67,%edx
80106c08:	c1 e8 18             	shr    $0x18,%eax
80106c0b:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80106c12:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106c19:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
80106c20:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80106c27:	83 c1 08             	add    $0x8,%ecx
80106c2a:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106c30:	c1 e9 10             	shr    $0x10,%ecx
80106c33:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106c39:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    panic("switchuvm: no pgdir");

  pushcli();
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
80106c3e:	e8 fd cc ff ff       	call   80103940 <mycpu>
80106c43:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106c4a:	e8 f1 cc ff ff       	call   80103940 <mycpu>
80106c4f:	b9 10 00 00 00       	mov    $0x10,%ecx
80106c54:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106c58:	e8 e3 cc ff ff       	call   80103940 <mycpu>
80106c5d:	8b 56 08             	mov    0x8(%esi),%edx
80106c60:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80106c66:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106c69:	e8 d2 cc ff ff       	call   80103940 <mycpu>
80106c6e:	66 89 58 6e          	mov    %bx,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
80106c72:	b8 28 00 00 00       	mov    $0x28,%eax
80106c77:	0f 00 d8             	ltr    %ax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106c7a:	8b 46 04             	mov    0x4(%esi),%eax
80106c7d:	05 00 00 00 80       	add    $0x80000000,%eax
80106c82:	0f 22 d8             	mov    %eax,%cr3
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
80106c85:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c88:	5b                   	pop    %ebx
80106c89:	5e                   	pop    %esi
80106c8a:	5f                   	pop    %edi
80106c8b:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
80106c8c:	e9 2f d9 ff ff       	jmp    801045c0 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
80106c91:	83 ec 0c             	sub    $0xc,%esp
80106c94:	68 3e 7b 10 80       	push   $0x80107b3e
80106c99:	e8 d2 96 ff ff       	call   80100370 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
80106c9e:	83 ec 0c             	sub    $0xc,%esp
80106ca1:	68 69 7b 10 80       	push   $0x80107b69
80106ca6:	e8 c5 96 ff ff       	call   80100370 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
80106cab:	83 ec 0c             	sub    $0xc,%esp
80106cae:	68 54 7b 10 80       	push   $0x80107b54
80106cb3:	e8 b8 96 ff ff       	call   80100370 <panic>
80106cb8:	90                   	nop
80106cb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106cc0 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106cc0:	55                   	push   %ebp
80106cc1:	89 e5                	mov    %esp,%ebp
80106cc3:	57                   	push   %edi
80106cc4:	56                   	push   %esi
80106cc5:	53                   	push   %ebx
80106cc6:	83 ec 1c             	sub    $0x1c,%esp
80106cc9:	8b 75 10             	mov    0x10(%ebp),%esi
80106ccc:	8b 45 08             	mov    0x8(%ebp),%eax
80106ccf:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80106cd2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106cd8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80106cdb:	77 49                	ja     80106d26 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
80106cdd:	e8 0e ba ff ff       	call   801026f0 <kalloc>
  memset(mem, 0, PGSIZE);
80106ce2:	83 ec 04             	sub    $0x4,%esp
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80106ce5:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106ce7:	68 00 10 00 00       	push   $0x1000
80106cec:	6a 00                	push   $0x0
80106cee:	50                   	push   %eax
80106cef:	e8 8c d9 ff ff       	call   80104680 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106cf4:	58                   	pop    %eax
80106cf5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106cfb:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106d00:	5a                   	pop    %edx
80106d01:	6a 06                	push   $0x6
80106d03:	50                   	push   %eax
80106d04:	31 d2                	xor    %edx,%edx
80106d06:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106d09:	e8 52 fc ff ff       	call   80106960 <mappages>
  memmove(mem, init, sz);
80106d0e:	89 75 10             	mov    %esi,0x10(%ebp)
80106d11:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106d14:	83 c4 10             	add    $0x10,%esp
80106d17:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106d1a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d1d:	5b                   	pop    %ebx
80106d1e:	5e                   	pop    %esi
80106d1f:	5f                   	pop    %edi
80106d20:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80106d21:	e9 0a da ff ff       	jmp    80104730 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80106d26:	83 ec 0c             	sub    $0xc,%esp
80106d29:	68 7d 7b 10 80       	push   $0x80107b7d
80106d2e:	e8 3d 96 ff ff       	call   80100370 <panic>
80106d33:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d40 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80106d40:	55                   	push   %ebp
80106d41:	89 e5                	mov    %esp,%ebp
80106d43:	57                   	push   %edi
80106d44:	56                   	push   %esi
80106d45:	53                   	push   %ebx
80106d46:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80106d49:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106d50:	0f 85 91 00 00 00    	jne    80106de7 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80106d56:	8b 75 18             	mov    0x18(%ebp),%esi
80106d59:	31 db                	xor    %ebx,%ebx
80106d5b:	85 f6                	test   %esi,%esi
80106d5d:	75 1a                	jne    80106d79 <loaduvm+0x39>
80106d5f:	eb 6f                	jmp    80106dd0 <loaduvm+0x90>
80106d61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d68:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d6e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106d74:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106d77:	76 57                	jbe    80106dd0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106d79:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d7c:	8b 45 08             	mov    0x8(%ebp),%eax
80106d7f:	31 c9                	xor    %ecx,%ecx
80106d81:	01 da                	add    %ebx,%edx
80106d83:	e8 58 fb ff ff       	call   801068e0 <walkpgdir>
80106d88:	85 c0                	test   %eax,%eax
80106d8a:	74 4e                	je     80106dda <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106d8c:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106d8e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
80106d91:	bf 00 10 00 00       	mov    $0x1000,%edi
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106d96:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106d9b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106da1:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106da4:	01 d9                	add    %ebx,%ecx
80106da6:	05 00 00 00 80       	add    $0x80000000,%eax
80106dab:	57                   	push   %edi
80106dac:	51                   	push   %ecx
80106dad:	50                   	push   %eax
80106dae:	ff 75 10             	pushl  0x10(%ebp)
80106db1:	e8 fa ad ff ff       	call   80101bb0 <readi>
80106db6:	83 c4 10             	add    $0x10,%esp
80106db9:	39 c7                	cmp    %eax,%edi
80106dbb:	74 ab                	je     80106d68 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80106dbd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80106dc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80106dc5:	5b                   	pop    %ebx
80106dc6:	5e                   	pop    %esi
80106dc7:	5f                   	pop    %edi
80106dc8:	5d                   	pop    %ebp
80106dc9:	c3                   	ret    
80106dca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106dd0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80106dd3:	31 c0                	xor    %eax,%eax
}
80106dd5:	5b                   	pop    %ebx
80106dd6:	5e                   	pop    %esi
80106dd7:	5f                   	pop    %edi
80106dd8:	5d                   	pop    %ebp
80106dd9:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80106dda:	83 ec 0c             	sub    $0xc,%esp
80106ddd:	68 97 7b 10 80       	push   $0x80107b97
80106de2:	e8 89 95 ff ff       	call   80100370 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80106de7:	83 ec 0c             	sub    $0xc,%esp
80106dea:	68 38 7c 10 80       	push   $0x80107c38
80106def:	e8 7c 95 ff ff       	call   80100370 <panic>
80106df4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106dfa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106e00 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106e00:	55                   	push   %ebp
80106e01:	89 e5                	mov    %esp,%ebp
80106e03:	57                   	push   %edi
80106e04:	56                   	push   %esi
80106e05:	53                   	push   %ebx
80106e06:	83 ec 0c             	sub    $0xc,%esp
80106e09:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80106e0c:	85 ff                	test   %edi,%edi
80106e0e:	0f 88 ca 00 00 00    	js     80106ede <allocuvm+0xde>
    return 0;
  if(newsz < oldsz)
80106e14:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80106e17:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
80106e1a:	0f 82 82 00 00 00    	jb     80106ea2 <allocuvm+0xa2>
    return oldsz;

  a = PGROUNDUP(oldsz);
80106e20:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106e26:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106e2c:	39 df                	cmp    %ebx,%edi
80106e2e:	77 43                	ja     80106e73 <allocuvm+0x73>
80106e30:	e9 bb 00 00 00       	jmp    80106ef0 <allocuvm+0xf0>
80106e35:	8d 76 00             	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80106e38:	83 ec 04             	sub    $0x4,%esp
80106e3b:	68 00 10 00 00       	push   $0x1000
80106e40:	6a 00                	push   $0x0
80106e42:	50                   	push   %eax
80106e43:	e8 38 d8 ff ff       	call   80104680 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106e48:	58                   	pop    %eax
80106e49:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106e4f:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106e54:	5a                   	pop    %edx
80106e55:	6a 06                	push   $0x6
80106e57:	50                   	push   %eax
80106e58:	89 da                	mov    %ebx,%edx
80106e5a:	8b 45 08             	mov    0x8(%ebp),%eax
80106e5d:	e8 fe fa ff ff       	call   80106960 <mappages>
80106e62:	83 c4 10             	add    $0x10,%esp
80106e65:	85 c0                	test   %eax,%eax
80106e67:	78 47                	js     80106eb0 <allocuvm+0xb0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106e69:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106e6f:	39 df                	cmp    %ebx,%edi
80106e71:	76 7d                	jbe    80106ef0 <allocuvm+0xf0>
    mem = kalloc();
80106e73:	e8 78 b8 ff ff       	call   801026f0 <kalloc>
    if(mem == 0){
80106e78:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
80106e7a:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106e7c:	75 ba                	jne    80106e38 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
80106e7e:	83 ec 0c             	sub    $0xc,%esp
80106e81:	68 b5 7b 10 80       	push   $0x80107bb5
80106e86:	e8 f5 97 ff ff       	call   80100680 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106e8b:	83 c4 10             	add    $0x10,%esp
80106e8e:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106e91:	76 4b                	jbe    80106ede <allocuvm+0xde>
80106e93:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106e96:	8b 45 08             	mov    0x8(%ebp),%eax
80106e99:	89 fa                	mov    %edi,%edx
80106e9b:	e8 50 fb ff ff       	call   801069f0 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80106ea0:	31 c0                	xor    %eax,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106ea2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ea5:	5b                   	pop    %ebx
80106ea6:	5e                   	pop    %esi
80106ea7:	5f                   	pop    %edi
80106ea8:	5d                   	pop    %ebp
80106ea9:	c3                   	ret    
80106eaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80106eb0:	83 ec 0c             	sub    $0xc,%esp
80106eb3:	68 cd 7b 10 80       	push   $0x80107bcd
80106eb8:	e8 c3 97 ff ff       	call   80100680 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106ebd:	83 c4 10             	add    $0x10,%esp
80106ec0:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106ec3:	76 0d                	jbe    80106ed2 <allocuvm+0xd2>
80106ec5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106ec8:	8b 45 08             	mov    0x8(%ebp),%eax
80106ecb:	89 fa                	mov    %edi,%edx
80106ecd:	e8 1e fb ff ff       	call   801069f0 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80106ed2:	83 ec 0c             	sub    $0xc,%esp
80106ed5:	56                   	push   %esi
80106ed6:	e8 65 b6 ff ff       	call   80102540 <kfree>
      return 0;
80106edb:	83 c4 10             	add    $0x10,%esp
    }
  }
  return newsz;
}
80106ede:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80106ee1:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
80106ee3:	5b                   	pop    %ebx
80106ee4:	5e                   	pop    %esi
80106ee5:	5f                   	pop    %edi
80106ee6:	5d                   	pop    %ebp
80106ee7:	c3                   	ret    
80106ee8:	90                   	nop
80106ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ef0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106ef3:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106ef5:	5b                   	pop    %ebx
80106ef6:	5e                   	pop    %esi
80106ef7:	5f                   	pop    %edi
80106ef8:	5d                   	pop    %ebp
80106ef9:	c3                   	ret    
80106efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106f00 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106f00:	55                   	push   %ebp
80106f01:	89 e5                	mov    %esp,%ebp
80106f03:	8b 55 0c             	mov    0xc(%ebp),%edx
80106f06:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106f09:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106f0c:	39 d1                	cmp    %edx,%ecx
80106f0e:	73 10                	jae    80106f20 <deallocuvm+0x20>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106f10:	5d                   	pop    %ebp
80106f11:	e9 da fa ff ff       	jmp    801069f0 <deallocuvm.part.0>
80106f16:	8d 76 00             	lea    0x0(%esi),%esi
80106f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106f20:	89 d0                	mov    %edx,%eax
80106f22:	5d                   	pop    %ebp
80106f23:	c3                   	ret    
80106f24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106f2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106f30 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106f30:	55                   	push   %ebp
80106f31:	89 e5                	mov    %esp,%ebp
80106f33:	57                   	push   %edi
80106f34:	56                   	push   %esi
80106f35:	53                   	push   %ebx
80106f36:	83 ec 0c             	sub    $0xc,%esp
80106f39:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106f3c:	85 f6                	test   %esi,%esi
80106f3e:	74 59                	je     80106f99 <freevm+0x69>
80106f40:	31 c9                	xor    %ecx,%ecx
80106f42:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106f47:	89 f0                	mov    %esi,%eax
80106f49:	e8 a2 fa ff ff       	call   801069f0 <deallocuvm.part.0>
80106f4e:	89 f3                	mov    %esi,%ebx
80106f50:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106f56:	eb 0f                	jmp    80106f67 <freevm+0x37>
80106f58:	90                   	nop
80106f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f60:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106f63:	39 fb                	cmp    %edi,%ebx
80106f65:	74 23                	je     80106f8a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106f67:	8b 03                	mov    (%ebx),%eax
80106f69:	a8 01                	test   $0x1,%al
80106f6b:	74 f3                	je     80106f60 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
80106f6d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106f72:	83 ec 0c             	sub    $0xc,%esp
80106f75:	83 c3 04             	add    $0x4,%ebx
80106f78:	05 00 00 00 80       	add    $0x80000000,%eax
80106f7d:	50                   	push   %eax
80106f7e:	e8 bd b5 ff ff       	call   80102540 <kfree>
80106f83:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106f86:	39 fb                	cmp    %edi,%ebx
80106f88:	75 dd                	jne    80106f67 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106f8a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106f8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f90:	5b                   	pop    %ebx
80106f91:	5e                   	pop    %esi
80106f92:	5f                   	pop    %edi
80106f93:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106f94:	e9 a7 b5 ff ff       	jmp    80102540 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80106f99:	83 ec 0c             	sub    $0xc,%esp
80106f9c:	68 e9 7b 10 80       	push   $0x80107be9
80106fa1:	e8 ca 93 ff ff       	call   80100370 <panic>
80106fa6:	8d 76 00             	lea    0x0(%esi),%esi
80106fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106fb0 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80106fb0:	55                   	push   %ebp
80106fb1:	89 e5                	mov    %esp,%ebp
80106fb3:	56                   	push   %esi
80106fb4:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80106fb5:	e8 36 b7 ff ff       	call   801026f0 <kalloc>
80106fba:	85 c0                	test   %eax,%eax
80106fbc:	74 6a                	je     80107028 <setupkvm+0x78>
    return 0;
  memset(pgdir, 0, PGSIZE);
80106fbe:	83 ec 04             	sub    $0x4,%esp
80106fc1:	89 c6                	mov    %eax,%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106fc3:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
80106fc8:	68 00 10 00 00       	push   $0x1000
80106fcd:	6a 00                	push   $0x0
80106fcf:	50                   	push   %eax
80106fd0:	e8 ab d6 ff ff       	call   80104680 <memset>
80106fd5:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106fd8:	8b 43 04             	mov    0x4(%ebx),%eax
80106fdb:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106fde:	83 ec 08             	sub    $0x8,%esp
80106fe1:	8b 13                	mov    (%ebx),%edx
80106fe3:	ff 73 0c             	pushl  0xc(%ebx)
80106fe6:	50                   	push   %eax
80106fe7:	29 c1                	sub    %eax,%ecx
80106fe9:	89 f0                	mov    %esi,%eax
80106feb:	e8 70 f9 ff ff       	call   80106960 <mappages>
80106ff0:	83 c4 10             	add    $0x10,%esp
80106ff3:	85 c0                	test   %eax,%eax
80106ff5:	78 19                	js     80107010 <setupkvm+0x60>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106ff7:	83 c3 10             	add    $0x10,%ebx
80106ffa:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80107000:	75 d6                	jne    80106fd8 <setupkvm+0x28>
80107002:	89 f0                	mov    %esi,%eax
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
80107004:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107007:	5b                   	pop    %ebx
80107008:	5e                   	pop    %esi
80107009:	5d                   	pop    %ebp
8010700a:	c3                   	ret    
8010700b:	90                   	nop
8010700c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
80107010:	83 ec 0c             	sub    $0xc,%esp
80107013:	56                   	push   %esi
80107014:	e8 17 ff ff ff       	call   80106f30 <freevm>
      return 0;
80107019:	83 c4 10             	add    $0x10,%esp
    }
  return pgdir;
}
8010701c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
8010701f:	31 c0                	xor    %eax,%eax
    }
  return pgdir;
}
80107021:	5b                   	pop    %ebx
80107022:	5e                   	pop    %esi
80107023:	5d                   	pop    %ebp
80107024:	c3                   	ret    
80107025:	8d 76 00             	lea    0x0(%esi),%esi
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80107028:	31 c0                	xor    %eax,%eax
8010702a:	eb d8                	jmp    80107004 <setupkvm+0x54>
8010702c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107030 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107030:	55                   	push   %ebp
80107031:	89 e5                	mov    %esp,%ebp
80107033:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107036:	e8 75 ff ff ff       	call   80106fb0 <setupkvm>
8010703b:	a3 44 64 11 80       	mov    %eax,0x80116444
80107040:	05 00 00 00 80       	add    $0x80000000,%eax
80107045:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
80107048:	c9                   	leave  
80107049:	c3                   	ret    
8010704a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107050 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107050:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107051:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107053:	89 e5                	mov    %esp,%ebp
80107055:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107058:	8b 55 0c             	mov    0xc(%ebp),%edx
8010705b:	8b 45 08             	mov    0x8(%ebp),%eax
8010705e:	e8 7d f8 ff ff       	call   801068e0 <walkpgdir>
  if(pte == 0)
80107063:	85 c0                	test   %eax,%eax
80107065:	74 05                	je     8010706c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107067:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010706a:	c9                   	leave  
8010706b:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
8010706c:	83 ec 0c             	sub    $0xc,%esp
8010706f:	68 fa 7b 10 80       	push   $0x80107bfa
80107074:	e8 f7 92 ff ff       	call   80100370 <panic>
80107079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107080 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107080:	55                   	push   %ebp
80107081:	89 e5                	mov    %esp,%ebp
80107083:	57                   	push   %edi
80107084:	56                   	push   %esi
80107085:	53                   	push   %ebx
80107086:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107089:	e8 22 ff ff ff       	call   80106fb0 <setupkvm>
8010708e:	85 c0                	test   %eax,%eax
80107090:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107093:	0f 84 b2 00 00 00    	je     8010714b <copyuvm+0xcb>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107099:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010709c:	85 c9                	test   %ecx,%ecx
8010709e:	0f 84 9c 00 00 00    	je     80107140 <copyuvm+0xc0>
801070a4:	31 f6                	xor    %esi,%esi
801070a6:	eb 4a                	jmp    801070f2 <copyuvm+0x72>
801070a8:	90                   	nop
801070a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801070b0:	83 ec 04             	sub    $0x4,%esp
801070b3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
801070b9:	68 00 10 00 00       	push   $0x1000
801070be:	57                   	push   %edi
801070bf:	50                   	push   %eax
801070c0:	e8 6b d6 ff ff       	call   80104730 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
801070c5:	58                   	pop    %eax
801070c6:	5a                   	pop    %edx
801070c7:	8d 93 00 00 00 80    	lea    -0x80000000(%ebx),%edx
801070cd:	8b 45 e0             	mov    -0x20(%ebp),%eax
801070d0:	ff 75 e4             	pushl  -0x1c(%ebp)
801070d3:	b9 00 10 00 00       	mov    $0x1000,%ecx
801070d8:	52                   	push   %edx
801070d9:	89 f2                	mov    %esi,%edx
801070db:	e8 80 f8 ff ff       	call   80106960 <mappages>
801070e0:	83 c4 10             	add    $0x10,%esp
801070e3:	85 c0                	test   %eax,%eax
801070e5:	78 3e                	js     80107125 <copyuvm+0xa5>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801070e7:	81 c6 00 10 00 00    	add    $0x1000,%esi
801070ed:	39 75 0c             	cmp    %esi,0xc(%ebp)
801070f0:	76 4e                	jbe    80107140 <copyuvm+0xc0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801070f2:	8b 45 08             	mov    0x8(%ebp),%eax
801070f5:	31 c9                	xor    %ecx,%ecx
801070f7:	89 f2                	mov    %esi,%edx
801070f9:	e8 e2 f7 ff ff       	call   801068e0 <walkpgdir>
801070fe:	85 c0                	test   %eax,%eax
80107100:	74 5a                	je     8010715c <copyuvm+0xdc>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80107102:	8b 18                	mov    (%eax),%ebx
80107104:	f6 c3 01             	test   $0x1,%bl
80107107:	74 46                	je     8010714f <copyuvm+0xcf>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107109:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
8010710b:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
80107111:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107114:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
8010711a:	e8 d1 b5 ff ff       	call   801026f0 <kalloc>
8010711f:	85 c0                	test   %eax,%eax
80107121:	89 c3                	mov    %eax,%ebx
80107123:	75 8b                	jne    801070b0 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
80107125:	83 ec 0c             	sub    $0xc,%esp
80107128:	ff 75 e0             	pushl  -0x20(%ebp)
8010712b:	e8 00 fe ff ff       	call   80106f30 <freevm>
  return 0;
80107130:	83 c4 10             	add    $0x10,%esp
80107133:	31 c0                	xor    %eax,%eax
}
80107135:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107138:	5b                   	pop    %ebx
80107139:	5e                   	pop    %esi
8010713a:	5f                   	pop    %edi
8010713b:	5d                   	pop    %ebp
8010713c:	c3                   	ret    
8010713d:	8d 76 00             	lea    0x0(%esi),%esi
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107140:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
80107143:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107146:	5b                   	pop    %ebx
80107147:	5e                   	pop    %esi
80107148:	5f                   	pop    %edi
80107149:	5d                   	pop    %ebp
8010714a:	c3                   	ret    
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
8010714b:	31 c0                	xor    %eax,%eax
8010714d:	eb e6                	jmp    80107135 <copyuvm+0xb5>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
8010714f:	83 ec 0c             	sub    $0xc,%esp
80107152:	68 1e 7c 10 80       	push   $0x80107c1e
80107157:	e8 14 92 ff ff       	call   80100370 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010715c:	83 ec 0c             	sub    $0xc,%esp
8010715f:	68 04 7c 10 80       	push   $0x80107c04
80107164:	e8 07 92 ff ff       	call   80100370 <panic>
80107169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107170 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107170:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107171:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107173:	89 e5                	mov    %esp,%ebp
80107175:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107178:	8b 55 0c             	mov    0xc(%ebp),%edx
8010717b:	8b 45 08             	mov    0x8(%ebp),%eax
8010717e:	e8 5d f7 ff ff       	call   801068e0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107183:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80107185:	89 c2                	mov    %eax,%edx
80107187:	83 e2 05             	and    $0x5,%edx
8010718a:	83 fa 05             	cmp    $0x5,%edx
8010718d:	75 11                	jne    801071a0 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
8010718f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
80107194:	c9                   	leave  
  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80107195:	05 00 00 00 80       	add    $0x80000000,%eax
}
8010719a:	c3                   	ret    
8010719b:	90                   	nop
8010719c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
801071a0:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
801071a2:	c9                   	leave  
801071a3:	c3                   	ret    
801071a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801071aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801071b0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801071b0:	55                   	push   %ebp
801071b1:	89 e5                	mov    %esp,%ebp
801071b3:	57                   	push   %edi
801071b4:	56                   	push   %esi
801071b5:	53                   	push   %ebx
801071b6:	83 ec 1c             	sub    $0x1c,%esp
801071b9:	8b 5d 14             	mov    0x14(%ebp),%ebx
801071bc:	8b 55 0c             	mov    0xc(%ebp),%edx
801071bf:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801071c2:	85 db                	test   %ebx,%ebx
801071c4:	75 40                	jne    80107206 <copyout+0x56>
801071c6:	eb 70                	jmp    80107238 <copyout+0x88>
801071c8:	90                   	nop
801071c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801071d0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801071d3:	89 f1                	mov    %esi,%ecx
801071d5:	29 d1                	sub    %edx,%ecx
801071d7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
801071dd:	39 d9                	cmp    %ebx,%ecx
801071df:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801071e2:	29 f2                	sub    %esi,%edx
801071e4:	83 ec 04             	sub    $0x4,%esp
801071e7:	01 d0                	add    %edx,%eax
801071e9:	51                   	push   %ecx
801071ea:	57                   	push   %edi
801071eb:	50                   	push   %eax
801071ec:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801071ef:	e8 3c d5 ff ff       	call   80104730 <memmove>
    len -= n;
    buf += n;
801071f4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801071f7:	83 c4 10             	add    $0x10,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
801071fa:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
80107200:	01 cf                	add    %ecx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107202:	29 cb                	sub    %ecx,%ebx
80107204:	74 32                	je     80107238 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107206:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107208:	83 ec 08             	sub    $0x8,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
8010720b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010720e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107214:	56                   	push   %esi
80107215:	ff 75 08             	pushl  0x8(%ebp)
80107218:	e8 53 ff ff ff       	call   80107170 <uva2ka>
    if(pa0 == 0)
8010721d:	83 c4 10             	add    $0x10,%esp
80107220:	85 c0                	test   %eax,%eax
80107222:	75 ac                	jne    801071d0 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80107224:	8d 65 f4             	lea    -0xc(%ebp),%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
80107227:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
8010722c:	5b                   	pop    %ebx
8010722d:	5e                   	pop    %esi
8010722e:	5f                   	pop    %edi
8010722f:	5d                   	pop    %ebp
80107230:	c3                   	ret    
80107231:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107238:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
8010723b:	31 c0                	xor    %eax,%eax
}
8010723d:	5b                   	pop    %ebx
8010723e:	5e                   	pop    %esi
8010723f:	5f                   	pop    %edi
80107240:	5d                   	pop    %ebp
80107241:	c3                   	ret    
