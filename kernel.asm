
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
8010002d:	b8 50 30 10 80       	mov    $0x80103050,%eax
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
8010004c:	68 e0 71 10 80       	push   $0x801071e0
80100051:	68 60 c5 10 80       	push   $0x8010c560
80100056:	e8 45 43 00 00       	call   801043a0 <initlock>

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
80100092:	68 e7 71 10 80       	push   $0x801071e7
80100097:	50                   	push   %eax
80100098:	e8 f3 41 00 00       	call   80104290 <initsleeplock>
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
801000e4:	e8 b7 43 00 00       	call   801044a0 <acquire>

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
80100162:	e8 59 44 00 00       	call   801045c0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 5e 41 00 00       	call   801042d0 <acquiresleep>
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
8010017e:	e8 5d 21 00 00       	call   801022e0 <iderw>
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
80100193:	68 ee 71 10 80       	push   $0x801071ee
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
801001ae:	e8 bd 41 00 00       	call   80104370 <holdingsleep>
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
801001c4:	e9 17 21 00 00       	jmp    801022e0 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 ff 71 10 80       	push   $0x801071ff
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
801001ef:	e8 7c 41 00 00       	call   80104370 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 2c 41 00 00       	call   80104330 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 60 c5 10 80 	movl   $0x8010c560,(%esp)
8010020b:	e8 90 42 00 00       	call   801044a0 <acquire>
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
8010025c:	e9 5f 43 00 00       	jmp    801045c0 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 06 72 10 80       	push   $0x80107206
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
80100280:	e8 bb 16 00 00       	call   80101940 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 c0 b4 10 80 	movl   $0x8010b4c0,(%esp)
8010028c:	e8 0f 42 00 00       	call   801044a0 <acquire>
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
801002bd:	e8 6e 3c 00 00       	call   80103f30 <sleep>

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
801002d2:	e8 99 36 00 00       	call   80103970 <myproc>
801002d7:	8b 40 24             	mov    0x24(%eax),%eax
801002da:	85 c0                	test   %eax,%eax
801002dc:	74 d2                	je     801002b0 <consoleread+0x40>
        release(&cons.lock);
801002de:	83 ec 0c             	sub    $0xc,%esp
801002e1:	68 c0 b4 10 80       	push   $0x8010b4c0
801002e6:	e8 d5 42 00 00       	call   801045c0 <release>
        ilock(ip);
801002eb:	89 3c 24             	mov    %edi,(%esp)
801002ee:	e8 6d 15 00 00       	call   80101860 <ilock>
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
80100346:	e8 75 42 00 00       	call   801045c0 <release>
  ilock(ip);
8010034b:	89 3c 24             	mov    %edi,(%esp)
8010034e:	e8 0d 15 00 00       	call   80101860 <ilock>

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
80100389:	e8 52 25 00 00       	call   801028e0 <lapicid>
8010038e:	83 ec 08             	sub    $0x8,%esp
80100391:	50                   	push   %eax
80100392:	68 0d 72 10 80       	push   $0x8010720d
80100397:	e8 e4 02 00 00       	call   80100680 <cprintf>
  cprintf(s);
8010039c:	58                   	pop    %eax
8010039d:	ff 75 08             	pushl  0x8(%ebp)
801003a0:	e8 db 02 00 00       	call   80100680 <cprintf>
  cprintf("\n");
801003a5:	c7 04 24 67 7b 10 80 	movl   $0x80107b67,(%esp)
801003ac:	e8 cf 02 00 00       	call   80100680 <cprintf>
  getcallerpcs(&s, pcs);
801003b1:	5a                   	pop    %edx
801003b2:	8d 45 08             	lea    0x8(%ebp),%eax
801003b5:	59                   	pop    %ecx
801003b6:	53                   	push   %ebx
801003b7:	50                   	push   %eax
801003b8:	e8 03 40 00 00       	call   801043c0 <getcallerpcs>
801003bd:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003c0:	83 ec 08             	sub    $0x8,%esp
801003c3:	ff 33                	pushl  (%ebx)
801003c5:	83 c3 04             	add    $0x4,%ebx
801003c8:	68 21 72 10 80       	push   $0x80107221
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
8010041a:	e8 91 59 00 00       	call   80105db0 <uartputc>
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
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100472:	0f b6 d3             	movzbl %bl,%edx
80100475:	8d 78 01             	lea    0x1(%eax),%edi
80100478:	80 ce 07             	or     $0x7,%dh
8010047b:	66 89 94 00 00 80 0b 	mov    %dx,-0x7ff48000(%eax,%eax,1)
80100482:	80 

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
801004e5:	e8 c6 58 00 00       	call   80105db0 <uartputc>
801004ea:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f1:	e8 ba 58 00 00       	call   80105db0 <uartputc>
801004f6:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004fd:	e8 ae 58 00 00       	call   80105db0 <uartputc>
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
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
80100535:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
8010053b:	0f 8e 4e ff ff ff    	jle    8010048f <consputc+0x9f>
    panic("pos under/overflow");
80100541:	83 ec 0c             	sub    $0xc,%esp
80100544:	68 25 72 10 80       	push   $0x80107225
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
8010056a:	e8 51 41 00 00       	call   801046c0 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010056f:	b8 80 07 00 00       	mov    $0x780,%eax
80100574:	83 c4 0c             	add    $0xc,%esp
80100577:	29 d8                	sub    %ebx,%eax
80100579:	01 c0                	add    %eax,%eax
8010057b:	50                   	push   %eax
8010057c:	6a 00                	push   $0x0
8010057e:	56                   	push   %esi
8010057f:	e8 8c 40 00 00       	call   80104610 <memset>
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
801005d1:	0f b6 92 50 72 10 80 	movzbl -0x7fef8db0(%edx),%edx
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
8010062f:	e8 0c 13 00 00       	call   80101940 <iunlock>
  acquire(&cons.lock);
80100634:	c7 04 24 c0 b4 10 80 	movl   $0x8010b4c0,(%esp)
8010063b:	e8 60 3e 00 00       	call   801044a0 <acquire>
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
80100667:	e8 54 3f 00 00       	call   801045c0 <release>
  ilock(ip);
8010066c:	58                   	pop    %eax
8010066d:	ff 75 08             	pushl  0x8(%ebp)
80100670:	e8 eb 11 00 00       	call   80101860 <ilock>

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
8010072d:	e8 8e 3e 00 00       	call   801045c0 <release>
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
801007a8:	b8 38 72 10 80       	mov    $0x80107238,%eax
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
801007e8:	e8 b3 3c 00 00       	call   801044a0 <acquire>
801007ed:	83 c4 10             	add    $0x10,%esp
801007f0:	e9 a4 fe ff ff       	jmp    80100699 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
801007f5:	83 ec 0c             	sub    $0xc,%esp
801007f8:	68 3f 72 10 80       	push   $0x8010723f
801007fd:	e8 6e fb ff ff       	call   80100370 <panic>
80100802:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100810 <capturescreen>:
 * Set the capturescreen to the pid specified,
 * so only that pid can modify the screen.
 * Also clears the screen.
 */
int
capturescreen(int pid, void* handler_voidptr) {
80100810:	55                   	push   %ebp
80100811:	89 e5                	mov    %esp,%ebp
80100813:	53                   	push   %ebx
80100814:	83 ec 10             	sub    $0x10,%esp
  acquire(&cons.lock);
80100817:	68 c0 b4 10 80       	push   $0x8010b4c0
8010081c:	e8 7f 3c 00 00       	call   801044a0 <acquire>
  if (screencaptured) {
80100821:	8b 1d f8 b4 10 80    	mov    0x8010b4f8,%ebx
80100827:	83 c4 10             	add    $0x10,%esp
8010082a:	85 db                	test   %ebx,%ebx
8010082c:	75 52                	jne    80100880 <capturescreen+0x70>
    release(&cons.lock);
    return -1;
  }
  // handler = handler_voidptr;
  // *handlechar = 1;
  screencaptured = pid;
8010082e:	8b 45 08             	mov    0x8(%ebp),%eax
  release(&cons.lock);
80100831:	83 ec 0c             	sub    $0xc,%esp
80100834:	68 c0 b4 10 80       	push   $0x8010b4c0
    release(&cons.lock);
    return -1;
  }
  // handler = handler_voidptr;
  // *handlechar = 1;
  screencaptured = pid;
80100839:	a3 f8 b4 10 80       	mov    %eax,0x8010b4f8
  release(&cons.lock);
8010083e:	e8 7d 3d 00 00       	call   801045c0 <release>
  memmove(crtbackup, crt, sizeof(crt[0])*25*80);
80100843:	83 c4 0c             	add    $0xc,%esp
80100846:	68 a0 0f 00 00       	push   $0xfa0
8010084b:	68 00 80 0b 80       	push   $0x800b8000
80100850:	68 20 a5 10 80       	push   $0x8010a520
80100855:	e8 66 3e 00 00       	call   801046c0 <memmove>
  memset(crt, 0, sizeof(crt[0]) * 25 * 80);
8010085a:	83 c4 0c             	add    $0xc,%esp
8010085d:	68 a0 0f 00 00       	push   $0xfa0
80100862:	6a 00                	push   $0x0
80100864:	68 00 80 0b 80       	push   $0x800b8000
80100869:	e8 a2 3d 00 00       	call   80104610 <memset>
  // cprintf("%p\n", handler_voidptr);
  return 0;
8010086e:	83 c4 10             	add    $0x10,%esp
}
80100871:	89 d8                	mov    %ebx,%eax
80100873:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100876:	c9                   	leave  
80100877:	c3                   	ret    
80100878:	90                   	nop
80100879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 */
int
capturescreen(int pid, void* handler_voidptr) {
  acquire(&cons.lock);
  if (screencaptured) {
    release(&cons.lock);
80100880:	83 ec 0c             	sub    $0xc,%esp
    return -1;
80100883:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
 */
int
capturescreen(int pid, void* handler_voidptr) {
  acquire(&cons.lock);
  if (screencaptured) {
    release(&cons.lock);
80100888:	68 c0 b4 10 80       	push   $0x8010b4c0
8010088d:	e8 2e 3d 00 00       	call   801045c0 <release>
    return -1;
80100892:	83 c4 10             	add    $0x10,%esp
80100895:	eb da                	jmp    80100871 <capturescreen+0x61>
80100897:	89 f6                	mov    %esi,%esi
80100899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801008a0 <freescreen>:
/*
 * Sets the capturescreen to 0 so that
 * other processes can draw on the screen.
 */
int
freescreen(int pid) {
801008a0:	55                   	push   %ebp
801008a1:	89 e5                	mov    %esp,%ebp
801008a3:	83 ec 14             	sub    $0x14,%esp
  acquire(&cons.lock);
801008a6:	68 c0 b4 10 80       	push   $0x8010b4c0
801008ab:	e8 f0 3b 00 00       	call   801044a0 <acquire>
  if (screencaptured == pid) {
801008b0:	83 c4 10             	add    $0x10,%esp
801008b3:	8b 45 08             	mov    0x8(%ebp),%eax
801008b6:	39 05 f8 b4 10 80    	cmp    %eax,0x8010b4f8
801008bc:	75 3a                	jne    801008f8 <freescreen+0x58>
    screencaptured = 0;
    release(&cons.lock);
801008be:	83 ec 0c             	sub    $0xc,%esp
 */
int
freescreen(int pid) {
  acquire(&cons.lock);
  if (screencaptured == pid) {
    screencaptured = 0;
801008c1:	c7 05 f8 b4 10 80 00 	movl   $0x0,0x8010b4f8
801008c8:	00 00 00 
    release(&cons.lock);
801008cb:	68 c0 b4 10 80       	push   $0x8010b4c0
801008d0:	e8 eb 3c 00 00       	call   801045c0 <release>
    memmove(crt, crtbackup, sizeof(crt[0])*25*80);
801008d5:	83 c4 0c             	add    $0xc,%esp
801008d8:	68 a0 0f 00 00       	push   $0xfa0
801008dd:	68 20 a5 10 80       	push   $0x8010a520
801008e2:	68 00 80 0b 80       	push   $0x800b8000
801008e7:	e8 d4 3d 00 00       	call   801046c0 <memmove>
    return 0;
801008ec:	83 c4 10             	add    $0x10,%esp
801008ef:	31 c0                	xor    %eax,%eax
  }
  release(&cons.lock);
  return -1;
}
801008f1:	c9                   	leave  
801008f2:	c3                   	ret    
801008f3:	90                   	nop
801008f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    screencaptured = 0;
    release(&cons.lock);
    memmove(crt, crtbackup, sizeof(crt[0])*25*80);
    return 0;
  }
  release(&cons.lock);
801008f8:	83 ec 0c             	sub    $0xc,%esp
801008fb:	68 c0 b4 10 80       	push   $0x8010b4c0
80100900:	e8 bb 3c 00 00       	call   801045c0 <release>
  return -1;
80100905:	83 c4 10             	add    $0x10,%esp
80100908:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010090d:	c9                   	leave  
8010090e:	c3                   	ret    
8010090f:	90                   	nop

80100910 <updatescreen>:
int
updatescreen(int pid, int x, int y, char* content, int color) {
80100910:	55                   	push   %ebp
80100911:	89 e5                	mov    %esp,%ebp
80100913:	57                   	push   %edi
80100914:	56                   	push   %esi
  if (pid != screencaptured) {
80100915:	8b 7d 08             	mov    0x8(%ebp),%edi
80100918:	39 3d f8 b4 10 80    	cmp    %edi,0x8010b4f8
  }
  release(&cons.lock);
  return -1;
}
int
updatescreen(int pid, int x, int y, char* content, int color) {
8010091e:	53                   	push   %ebx
8010091f:	8b 45 10             	mov    0x10(%ebp),%eax
80100922:	8b 75 14             	mov    0x14(%ebp),%esi
  if (pid != screencaptured) {
80100925:	75 41                	jne    80100968 <updatescreen+0x58>
    return -1;
  }
  int initialpos = x + 80*y;
  char c;
  int i;
  for(i = 0; (c = content[i]) != 0; i++) {
80100927:	0f b6 16             	movzbl (%esi),%edx
int
updatescreen(int pid, int x, int y, char* content, int color) {
  if (pid != screencaptured) {
    return -1;
  }
  int initialpos = x + 80*y;
8010092a:	8d 1c 80             	lea    (%eax,%eax,4),%ebx
8010092d:	c1 e3 04             	shl    $0x4,%ebx
80100930:	03 5d 0c             	add    0xc(%ebp),%ebx
  char c;
  int i;
  for(i = 0; (c = content[i]) != 0; i++) {
80100933:	84 d2                	test   %dl,%dl
80100935:	74 38                	je     8010096f <updatescreen+0x5f>
    // crt[initialpos+i] = (color<<8) || c;
    //Don't print out newline character
    if(c != '\n')
      crt[initialpos + i] = (c&0xff) | (color<<8);
80100937:	0f b7 7d 18          	movzwl 0x18(%ebp),%edi
8010093b:	31 c0                	xor    %eax,%eax
8010093d:	c1 e7 08             	shl    $0x8,%edi
  char c;
  int i;
  for(i = 0; (c = content[i]) != 0; i++) {
    // crt[initialpos+i] = (color<<8) || c;
    //Don't print out newline character
    if(c != '\n')
80100940:	80 fa 0a             	cmp    $0xa,%dl
80100943:	74 0d                	je     80100952 <updatescreen+0x42>
      crt[initialpos + i] = (c&0xff) | (color<<8);
80100945:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
80100948:	09 fa                	or     %edi,%edx
8010094a:	66 89 94 09 00 80 0b 	mov    %dx,-0x7ff48000(%ecx,%ecx,1)
80100951:	80 
    return -1;
  }
  int initialpos = x + 80*y;
  char c;
  int i;
  for(i = 0; (c = content[i]) != 0; i++) {
80100952:	83 c0 01             	add    $0x1,%eax
80100955:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80100959:	84 d2                	test   %dl,%dl
8010095b:	75 e3                	jne    80100940 <updatescreen+0x30>
    //Don't print out newline character
    if(c != '\n')
      crt[initialpos + i] = (c&0xff) | (color<<8);
  }
  return i;
}
8010095d:	5b                   	pop    %ebx
8010095e:	5e                   	pop    %esi
8010095f:	5f                   	pop    %edi
80100960:	5d                   	pop    %ebp
80100961:	c3                   	ret    
80100962:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
}
int
updatescreen(int pid, int x, int y, char* content, int color) {
  if (pid != screencaptured) {
    return -1;
80100968:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010096d:	eb ee                	jmp    8010095d <updatescreen+0x4d>
  }
  int initialpos = x + 80*y;
  char c;
  int i;
  for(i = 0; (c = content[i]) != 0; i++) {
8010096f:	31 c0                	xor    %eax,%eax
80100971:	eb ea                	jmp    8010095d <updatescreen+0x4d>
80100973:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100980 <consoleintr>:
// C('A') == Control-A
#define C(x) (x - '@')

void
consoleintr(int (*getc)(void))
{
80100980:	55                   	push   %ebp
80100981:	89 e5                	mov    %esp,%ebp
80100983:	57                   	push   %edi
80100984:	56                   	push   %esi
80100985:	53                   	push   %ebx
80100986:	83 ec 0c             	sub    $0xc,%esp
  int c, doprocdump = 0;
  

  if (screencaptured != 0) {
80100989:	a1 f8 b4 10 80       	mov    0x8010b4f8,%eax
// C('A') == Control-A
#define C(x) (x - '@')

void
consoleintr(int (*getc)(void))
{
8010098e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c, doprocdump = 0;
  

  if (screencaptured != 0) {
80100991:	85 c0                	test   %eax,%eax
80100993:	75 21                	jne    801009b6 <consoleintr+0x36>
80100995:	eb 31                	jmp    801009c8 <consoleintr+0x48>
80100997:	89 f6                	mov    %esi,%esi
80100999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    while((c = getc()) >= 0) {
      buffer = c;
      cprintf("%d\n", c);
801009a0:	83 ec 08             	sub    $0x8,%esp
  int c, doprocdump = 0;
  

  if (screencaptured != 0) {
    while((c = getc()) >= 0) {
      buffer = c;
801009a3:	a3 4c 0f 11 80       	mov    %eax,0x80110f4c
      cprintf("%d\n", c);
801009a8:	50                   	push   %eax
801009a9:	68 d4 76 10 80       	push   $0x801076d4
801009ae:	e8 cd fc ff ff       	call   80100680 <cprintf>
801009b3:	83 c4 10             	add    $0x10,%esp
{
  int c, doprocdump = 0;
  

  if (screencaptured != 0) {
    while((c = getc()) >= 0) {
801009b6:	ff d3                	call   *%ebx
801009b8:	85 c0                	test   %eax,%eax
801009ba:	79 e4                	jns    801009a0 <consoleintr+0x20>
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
801009bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801009bf:	5b                   	pop    %ebx
801009c0:	5e                   	pop    %esi
801009c1:	5f                   	pop    %edi
801009c2:	5d                   	pop    %ebp
801009c3:	c3                   	ret    
801009c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      cprintf("%d\n", c);
    }
    return;
  }

  acquire(&cons.lock);
801009c8:	83 ec 0c             	sub    $0xc,%esp
#define C(x) (x - '@')

void
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;
801009cb:	31 f6                	xor    %esi,%esi
      cprintf("%d\n", c);
    }
    return;
  }

  acquire(&cons.lock);
801009cd:	68 c0 b4 10 80       	push   $0x8010b4c0
801009d2:	e8 c9 3a 00 00       	call   801044a0 <acquire>
  while((c = getc()) >= 0){
801009d7:	83 c4 10             	add    $0x10,%esp
801009da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801009e0:	ff d3                	call   *%ebx
801009e2:	85 c0                	test   %eax,%eax
801009e4:	89 c7                	mov    %eax,%edi
801009e6:	78 48                	js     80100a30 <consoleintr+0xb0>
    switch(c){
801009e8:	83 ff 10             	cmp    $0x10,%edi
801009eb:	0f 84 3f 01 00 00    	je     80100b30 <consoleintr+0x1b0>
801009f1:	7e 65                	jle    80100a58 <consoleintr+0xd8>
801009f3:	83 ff 15             	cmp    $0x15,%edi
801009f6:	0f 84 e4 00 00 00    	je     80100ae0 <consoleintr+0x160>
801009fc:	83 ff 7f             	cmp    $0x7f,%edi
801009ff:	75 5c                	jne    80100a5d <consoleintr+0xdd>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100a01:	a1 48 0f 11 80       	mov    0x80110f48,%eax
80100a06:	3b 05 44 0f 11 80    	cmp    0x80110f44,%eax
80100a0c:	74 d2                	je     801009e0 <consoleintr+0x60>
        input.e--;
80100a0e:	83 e8 01             	sub    $0x1,%eax
80100a11:	a3 48 0f 11 80       	mov    %eax,0x80110f48
        consputc(BACKSPACE);
80100a16:	b8 00 01 00 00       	mov    $0x100,%eax
80100a1b:	e8 d0 f9 ff ff       	call   801003f0 <consputc>
    }
    return;
  }

  acquire(&cons.lock);
  while((c = getc()) >= 0){
80100a20:	ff d3                	call   *%ebx
80100a22:	85 c0                	test   %eax,%eax
80100a24:	89 c7                	mov    %eax,%edi
80100a26:	79 c0                	jns    801009e8 <consoleintr+0x68>
80100a28:	90                   	nop
80100a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100a30:	83 ec 0c             	sub    $0xc,%esp
80100a33:	68 c0 b4 10 80       	push   $0x8010b4c0
80100a38:	e8 83 3b 00 00       	call   801045c0 <release>
  if(doprocdump) {
80100a3d:	83 c4 10             	add    $0x10,%esp
80100a40:	85 f6                	test   %esi,%esi
80100a42:	0f 84 74 ff ff ff    	je     801009bc <consoleintr+0x3c>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100a48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a4b:	5b                   	pop    %ebx
80100a4c:	5e                   	pop    %esi
80100a4d:	5f                   	pop    %edi
80100a4e:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
80100a4f:	e9 7c 37 00 00       	jmp    801041d0 <procdump>
80100a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return;
  }

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
80100a58:	83 ff 08             	cmp    $0x8,%edi
80100a5b:	74 a4                	je     80100a01 <consoleintr+0x81>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100a5d:	85 ff                	test   %edi,%edi
80100a5f:	0f 84 7b ff ff ff    	je     801009e0 <consoleintr+0x60>
80100a65:	a1 48 0f 11 80       	mov    0x80110f48,%eax
80100a6a:	89 c2                	mov    %eax,%edx
80100a6c:	2b 15 40 0f 11 80    	sub    0x80110f40,%edx
80100a72:	83 fa 7f             	cmp    $0x7f,%edx
80100a75:	0f 87 65 ff ff ff    	ja     801009e0 <consoleintr+0x60>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
80100a7b:	8d 50 01             	lea    0x1(%eax),%edx
80100a7e:	83 e0 7f             	and    $0x7f,%eax
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
80100a81:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
80100a84:	89 15 48 0f 11 80    	mov    %edx,0x80110f48
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
80100a8a:	0f 84 aa 00 00 00    	je     80100b3a <consoleintr+0x1ba>
        input.buf[input.e++ % INPUT_BUF] = c;
80100a90:	89 f9                	mov    %edi,%ecx
80100a92:	88 88 c0 0e 11 80    	mov    %cl,-0x7feef140(%eax)
        consputc(c);
80100a98:	89 f8                	mov    %edi,%eax
80100a9a:	e8 51 f9 ff ff       	call   801003f0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100a9f:	83 ff 0a             	cmp    $0xa,%edi
80100aa2:	0f 84 a3 00 00 00    	je     80100b4b <consoleintr+0x1cb>
80100aa8:	83 ff 04             	cmp    $0x4,%edi
80100aab:	0f 84 9a 00 00 00    	je     80100b4b <consoleintr+0x1cb>
80100ab1:	a1 40 0f 11 80       	mov    0x80110f40,%eax
80100ab6:	83 e8 80             	sub    $0xffffff80,%eax
80100ab9:	39 05 48 0f 11 80    	cmp    %eax,0x80110f48
80100abf:	0f 85 1b ff ff ff    	jne    801009e0 <consoleintr+0x60>
          input.w = input.e;
          wakeup(&input.r);
80100ac5:	83 ec 0c             	sub    $0xc,%esp
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
80100ac8:	a3 44 0f 11 80       	mov    %eax,0x80110f44
          wakeup(&input.r);
80100acd:	68 40 0f 11 80       	push   $0x80110f40
80100ad2:	e8 09 36 00 00       	call   801040e0 <wakeup>
80100ad7:	83 c4 10             	add    $0x10,%esp
80100ada:	e9 01 ff ff ff       	jmp    801009e0 <consoleintr+0x60>
80100adf:	90                   	nop
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100ae0:	a1 48 0f 11 80       	mov    0x80110f48,%eax
80100ae5:	39 05 44 0f 11 80    	cmp    %eax,0x80110f44
80100aeb:	75 2b                	jne    80100b18 <consoleintr+0x198>
80100aed:	e9 ee fe ff ff       	jmp    801009e0 <consoleintr+0x60>
80100af2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100af8:	a3 48 0f 11 80       	mov    %eax,0x80110f48
        consputc(BACKSPACE);
80100afd:	b8 00 01 00 00       	mov    $0x100,%eax
80100b02:	e8 e9 f8 ff ff       	call   801003f0 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100b07:	a1 48 0f 11 80       	mov    0x80110f48,%eax
80100b0c:	3b 05 44 0f 11 80    	cmp    0x80110f44,%eax
80100b12:	0f 84 c8 fe ff ff    	je     801009e0 <consoleintr+0x60>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100b18:	83 e8 01             	sub    $0x1,%eax
80100b1b:	89 c2                	mov    %eax,%edx
80100b1d:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100b20:	80 ba c0 0e 11 80 0a 	cmpb   $0xa,-0x7feef140(%edx)
80100b27:	75 cf                	jne    80100af8 <consoleintr+0x178>
80100b29:	e9 b2 fe ff ff       	jmp    801009e0 <consoleintr+0x60>
80100b2e:	66 90                	xchg   %ax,%ax
  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
80100b30:	be 01 00 00 00       	mov    $0x1,%esi
80100b35:	e9 a6 fe ff ff       	jmp    801009e0 <consoleintr+0x60>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
80100b3a:	c6 80 c0 0e 11 80 0a 	movb   $0xa,-0x7feef140(%eax)
        consputc(c);
80100b41:	b8 0a 00 00 00       	mov    $0xa,%eax
80100b46:	e8 a5 f8 ff ff       	call   801003f0 <consputc>
80100b4b:	a1 48 0f 11 80       	mov    0x80110f48,%eax
80100b50:	e9 70 ff ff ff       	jmp    80100ac5 <consoleintr+0x145>
80100b55:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100b60 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
80100b60:	55                   	push   %ebp
80100b61:	89 e5                	mov    %esp,%ebp
80100b63:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100b66:	68 48 72 10 80       	push   $0x80107248
80100b6b:	68 c0 b4 10 80       	push   $0x8010b4c0
80100b70:	e8 2b 38 00 00       	call   801043a0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100b75:	58                   	pop    %eax
80100b76:	5a                   	pop    %edx
80100b77:	6a 00                	push   $0x0
80100b79:	6a 01                	push   $0x1
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
80100b7b:	c7 05 0c 19 11 80 20 	movl   $0x80100620,0x8011190c
80100b82:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100b85:	c7 05 08 19 11 80 70 	movl   $0x80100270,0x80111908
80100b8c:	02 10 80 
  cons.locking = 1;
80100b8f:	c7 05 f4 b4 10 80 01 	movl   $0x1,0x8010b4f4
80100b96:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
80100b99:	e8 f2 18 00 00       	call   80102490 <ioapicenable>
}
80100b9e:	83 c4 10             	add    $0x10,%esp
80100ba1:	c9                   	leave  
80100ba2:	c3                   	ret    
80100ba3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100bb0 <readkey>:

int
readkey(int pid)
{
80100bb0:	55                   	push   %ebp
80100bb1:	89 e5                	mov    %esp,%ebp
  if (pid != screencaptured)
80100bb3:	8b 45 08             	mov    0x8(%ebp),%eax
80100bb6:	39 05 f8 b4 10 80    	cmp    %eax,0x8010b4f8
80100bbc:	75 12                	jne    80100bd0 <readkey+0x20>
    return -1;

  int temp = buffer;
80100bbe:	a1 4c 0f 11 80       	mov    0x80110f4c,%eax
  buffer = 0;
80100bc3:	c7 05 4c 0f 11 80 00 	movl   $0x0,0x80110f4c
80100bca:	00 00 00 
  return temp;
80100bcd:	5d                   	pop    %ebp
80100bce:	c3                   	ret    
80100bcf:	90                   	nop

int
readkey(int pid)
{
  if (pid != screencaptured)
    return -1;
80100bd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax

  int temp = buffer;
  buffer = 0;
  return temp;
80100bd5:	5d                   	pop    %ebp
80100bd6:	c3                   	ret    
80100bd7:	66 90                	xchg   %ax,%ax
80100bd9:	66 90                	xchg   %ax,%ax
80100bdb:	66 90                	xchg   %ax,%ax
80100bdd:	66 90                	xchg   %ax,%ax
80100bdf:	90                   	nop

80100be0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100be0:	55                   	push   %ebp
80100be1:	89 e5                	mov    %esp,%ebp
80100be3:	57                   	push   %edi
80100be4:	56                   	push   %esi
80100be5:	53                   	push   %ebx
80100be6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100bec:	e8 7f 2d 00 00       	call   80103970 <myproc>
80100bf1:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100bf7:	e8 44 21 00 00       	call   80102d40 <begin_op>

  if((ip = namei(path)) == 0){
80100bfc:	83 ec 0c             	sub    $0xc,%esp
80100bff:	ff 75 08             	pushl  0x8(%ebp)
80100c02:	e8 a9 14 00 00       	call   801020b0 <namei>
80100c07:	83 c4 10             	add    $0x10,%esp
80100c0a:	85 c0                	test   %eax,%eax
80100c0c:	0f 84 9c 01 00 00    	je     80100dae <exec+0x1ce>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100c12:	83 ec 0c             	sub    $0xc,%esp
80100c15:	89 c3                	mov    %eax,%ebx
80100c17:	50                   	push   %eax
80100c18:	e8 43 0c 00 00       	call   80101860 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100c1d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100c23:	6a 34                	push   $0x34
80100c25:	6a 00                	push   $0x0
80100c27:	50                   	push   %eax
80100c28:	53                   	push   %ebx
80100c29:	e8 12 0f 00 00       	call   80101b40 <readi>
80100c2e:	83 c4 20             	add    $0x20,%esp
80100c31:	83 f8 34             	cmp    $0x34,%eax
80100c34:	74 22                	je     80100c58 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100c36:	83 ec 0c             	sub    $0xc,%esp
80100c39:	53                   	push   %ebx
80100c3a:	e8 b1 0e 00 00       	call   80101af0 <iunlockput>
    end_op();
80100c3f:	e8 6c 21 00 00       	call   80102db0 <end_op>
80100c44:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100c47:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100c4c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100c4f:	5b                   	pop    %ebx
80100c50:	5e                   	pop    %esi
80100c51:	5f                   	pop    %edi
80100c52:	5d                   	pop    %ebp
80100c53:	c3                   	ret    
80100c54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100c58:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100c5f:	45 4c 46 
80100c62:	75 d2                	jne    80100c36 <exec+0x56>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100c64:	e8 d7 62 00 00       	call   80106f40 <setupkvm>
80100c69:	85 c0                	test   %eax,%eax
80100c6b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100c71:	74 c3                	je     80100c36 <exec+0x56>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c73:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100c7a:	00 
80100c7b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100c81:	c7 85 ec fe ff ff 00 	movl   $0x0,-0x114(%ebp)
80100c88:	00 00 00 
80100c8b:	0f 84 c5 00 00 00    	je     80100d56 <exec+0x176>
80100c91:	31 ff                	xor    %edi,%edi
80100c93:	eb 18                	jmp    80100cad <exec+0xcd>
80100c95:	8d 76 00             	lea    0x0(%esi),%esi
80100c98:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100c9f:	83 c7 01             	add    $0x1,%edi
80100ca2:	83 c6 20             	add    $0x20,%esi
80100ca5:	39 f8                	cmp    %edi,%eax
80100ca7:	0f 8e a9 00 00 00    	jle    80100d56 <exec+0x176>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100cad:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100cb3:	6a 20                	push   $0x20
80100cb5:	56                   	push   %esi
80100cb6:	50                   	push   %eax
80100cb7:	53                   	push   %ebx
80100cb8:	e8 83 0e 00 00       	call   80101b40 <readi>
80100cbd:	83 c4 10             	add    $0x10,%esp
80100cc0:	83 f8 20             	cmp    $0x20,%eax
80100cc3:	75 7b                	jne    80100d40 <exec+0x160>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100cc5:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100ccc:	75 ca                	jne    80100c98 <exec+0xb8>
      continue;
    if(ph.memsz < ph.filesz)
80100cce:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100cd4:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100cda:	72 64                	jb     80100d40 <exec+0x160>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100cdc:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ce2:	72 5c                	jb     80100d40 <exec+0x160>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100ce4:	83 ec 04             	sub    $0x4,%esp
80100ce7:	50                   	push   %eax
80100ce8:	ff b5 ec fe ff ff    	pushl  -0x114(%ebp)
80100cee:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100cf4:	e8 97 60 00 00       	call   80106d90 <allocuvm>
80100cf9:	83 c4 10             	add    $0x10,%esp
80100cfc:	85 c0                	test   %eax,%eax
80100cfe:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100d04:	74 3a                	je     80100d40 <exec+0x160>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100d06:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100d0c:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100d11:	75 2d                	jne    80100d40 <exec+0x160>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100d13:	83 ec 0c             	sub    $0xc,%esp
80100d16:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100d1c:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100d22:	53                   	push   %ebx
80100d23:	50                   	push   %eax
80100d24:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100d2a:	e8 a1 5f 00 00       	call   80106cd0 <loaduvm>
80100d2f:	83 c4 20             	add    $0x20,%esp
80100d32:	85 c0                	test   %eax,%eax
80100d34:	0f 89 5e ff ff ff    	jns    80100c98 <exec+0xb8>
80100d3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100d40:	83 ec 0c             	sub    $0xc,%esp
80100d43:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100d49:	e8 72 61 00 00       	call   80106ec0 <freevm>
80100d4e:	83 c4 10             	add    $0x10,%esp
80100d51:	e9 e0 fe ff ff       	jmp    80100c36 <exec+0x56>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100d56:	83 ec 0c             	sub    $0xc,%esp
80100d59:	53                   	push   %ebx
80100d5a:	e8 91 0d 00 00       	call   80101af0 <iunlockput>
  end_op();
80100d5f:	e8 4c 20 00 00       	call   80102db0 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100d64:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d6a:	83 c4 0c             	add    $0xc,%esp
  end_op();
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100d6d:	05 ff 0f 00 00       	add    $0xfff,%eax
80100d72:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d77:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100d7d:	52                   	push   %edx
80100d7e:	50                   	push   %eax
80100d7f:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100d85:	e8 06 60 00 00       	call   80106d90 <allocuvm>
80100d8a:	83 c4 10             	add    $0x10,%esp
80100d8d:	85 c0                	test   %eax,%eax
80100d8f:	89 c6                	mov    %eax,%esi
80100d91:	75 3a                	jne    80100dcd <exec+0x1ed>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100d93:	83 ec 0c             	sub    $0xc,%esp
80100d96:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100d9c:	e8 1f 61 00 00       	call   80106ec0 <freevm>
80100da1:	83 c4 10             	add    $0x10,%esp
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100da4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100da9:	e9 9e fe ff ff       	jmp    80100c4c <exec+0x6c>
  struct proc *curproc = myproc();

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
80100dae:	e8 fd 1f 00 00       	call   80102db0 <end_op>
    cprintf("exec: fail\n");
80100db3:	83 ec 0c             	sub    $0xc,%esp
80100db6:	68 61 72 10 80       	push   $0x80107261
80100dbb:	e8 c0 f8 ff ff       	call   80100680 <cprintf>
    return -1;
80100dc0:	83 c4 10             	add    $0x10,%esp
80100dc3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100dc8:	e9 7f fe ff ff       	jmp    80100c4c <exec+0x6c>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100dcd:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100dd3:	83 ec 08             	sub    $0x8,%esp
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100dd6:	31 ff                	xor    %edi,%edi
80100dd8:	89 f3                	mov    %esi,%ebx
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100dda:	50                   	push   %eax
80100ddb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100de1:	e8 fa 61 00 00       	call   80106fe0 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100de6:	8b 45 0c             	mov    0xc(%ebp),%eax
80100de9:	83 c4 10             	add    $0x10,%esp
80100dec:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100df2:	8b 00                	mov    (%eax),%eax
80100df4:	85 c0                	test   %eax,%eax
80100df6:	74 79                	je     80100e71 <exec+0x291>
80100df8:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100dfe:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100e04:	eb 13                	jmp    80100e19 <exec+0x239>
80100e06:	8d 76 00             	lea    0x0(%esi),%esi
80100e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(argc >= MAXARG)
80100e10:	83 ff 20             	cmp    $0x20,%edi
80100e13:	0f 84 7a ff ff ff    	je     80100d93 <exec+0x1b3>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100e19:	83 ec 0c             	sub    $0xc,%esp
80100e1c:	50                   	push   %eax
80100e1d:	e8 2e 3a 00 00       	call   80104850 <strlen>
80100e22:	f7 d0                	not    %eax
80100e24:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100e26:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e29:	5a                   	pop    %edx

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100e2a:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100e2d:	ff 34 b8             	pushl  (%eax,%edi,4)
80100e30:	e8 1b 3a 00 00       	call   80104850 <strlen>
80100e35:	83 c0 01             	add    $0x1,%eax
80100e38:	50                   	push   %eax
80100e39:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e3c:	ff 34 b8             	pushl  (%eax,%edi,4)
80100e3f:	53                   	push   %ebx
80100e40:	56                   	push   %esi
80100e41:	e8 fa 62 00 00       	call   80107140 <copyout>
80100e46:	83 c4 20             	add    $0x20,%esp
80100e49:	85 c0                	test   %eax,%eax
80100e4b:	0f 88 42 ff ff ff    	js     80100d93 <exec+0x1b3>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100e51:	8b 45 0c             	mov    0xc(%ebp),%eax
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100e54:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100e5b:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100e5e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100e64:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100e67:	85 c0                	test   %eax,%eax
80100e69:	75 a5                	jne    80100e10 <exec+0x230>
80100e6b:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e71:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100e78:	89 d9                	mov    %ebx,%ecx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100e7a:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100e81:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100e85:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100e8c:	ff ff ff 
  ustack[1] = argc;
80100e8f:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e95:	29 c1                	sub    %eax,%ecx

  sp -= (3+argc+1) * 4;
80100e97:	83 c0 0c             	add    $0xc,%eax
80100e9a:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e9c:	50                   	push   %eax
80100e9d:	52                   	push   %edx
80100e9e:	53                   	push   %ebx
80100e9f:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100ea5:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100eab:	e8 90 62 00 00       	call   80107140 <copyout>
80100eb0:	83 c4 10             	add    $0x10,%esp
80100eb3:	85 c0                	test   %eax,%eax
80100eb5:	0f 88 d8 fe ff ff    	js     80100d93 <exec+0x1b3>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ebb:	8b 45 08             	mov    0x8(%ebp),%eax
80100ebe:	0f b6 10             	movzbl (%eax),%edx
80100ec1:	84 d2                	test   %dl,%dl
80100ec3:	74 19                	je     80100ede <exec+0x2fe>
80100ec5:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100ec8:	83 c0 01             	add    $0x1,%eax
    if(*s == '/')
      last = s+1;
80100ecb:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ece:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
80100ed1:	0f 44 c8             	cmove  %eax,%ecx
80100ed4:	83 c0 01             	add    $0x1,%eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ed7:	84 d2                	test   %dl,%dl
80100ed9:	75 f0                	jne    80100ecb <exec+0x2eb>
80100edb:	89 4d 08             	mov    %ecx,0x8(%ebp)
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100ede:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100ee4:	50                   	push   %eax
80100ee5:	6a 10                	push   $0x10
80100ee7:	ff 75 08             	pushl  0x8(%ebp)
80100eea:	89 f8                	mov    %edi,%eax
80100eec:	83 c0 6c             	add    $0x6c,%eax
80100eef:	50                   	push   %eax
80100ef0:	e8 1b 39 00 00       	call   80104810 <safestrcpy>

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100ef5:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100efb:	89 f8                	mov    %edi,%eax
80100efd:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->pgdir = pgdir;
  curproc->sz = sz;
80100f00:	89 30                	mov    %esi,(%eax)
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100f02:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->sz = sz;
  curproc->tf->eip = elf.entry;  // main
80100f05:	89 c1                	mov    %eax,%ecx
80100f07:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100f0d:	8b 40 18             	mov    0x18(%eax),%eax
80100f10:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100f13:	8b 41 18             	mov    0x18(%ecx),%eax
80100f16:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100f19:	89 0c 24             	mov    %ecx,(%esp)
80100f1c:	e8 1f 5c 00 00       	call   80106b40 <switchuvm>
  freevm(oldpgdir);
80100f21:	89 3c 24             	mov    %edi,(%esp)
80100f24:	e8 97 5f 00 00       	call   80106ec0 <freevm>
  return 0;
80100f29:	83 c4 10             	add    $0x10,%esp
80100f2c:	31 c0                	xor    %eax,%eax
80100f2e:	e9 19 fd ff ff       	jmp    80100c4c <exec+0x6c>
80100f33:	66 90                	xchg   %ax,%ax
80100f35:	66 90                	xchg   %ax,%ax
80100f37:	66 90                	xchg   %ax,%ax
80100f39:	66 90                	xchg   %ax,%ax
80100f3b:	66 90                	xchg   %ax,%ax
80100f3d:	66 90                	xchg   %ax,%ax
80100f3f:	90                   	nop

80100f40 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100f40:	55                   	push   %ebp
80100f41:	89 e5                	mov    %esp,%ebp
80100f43:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100f46:	68 6d 72 10 80       	push   $0x8010726d
80100f4b:	68 60 0f 11 80       	push   $0x80110f60
80100f50:	e8 4b 34 00 00       	call   801043a0 <initlock>
}
80100f55:	83 c4 10             	add    $0x10,%esp
80100f58:	c9                   	leave  
80100f59:	c3                   	ret    
80100f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100f60 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f60:	55                   	push   %ebp
80100f61:	89 e5                	mov    %esp,%ebp
80100f63:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f64:	bb 94 0f 11 80       	mov    $0x80110f94,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f69:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
80100f6c:	68 60 0f 11 80       	push   $0x80110f60
80100f71:	e8 2a 35 00 00       	call   801044a0 <acquire>
80100f76:	83 c4 10             	add    $0x10,%esp
80100f79:	eb 10                	jmp    80100f8b <filealloc+0x2b>
80100f7b:	90                   	nop
80100f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f80:	83 c3 18             	add    $0x18,%ebx
80100f83:	81 fb f4 18 11 80    	cmp    $0x801118f4,%ebx
80100f89:	74 25                	je     80100fb0 <filealloc+0x50>
    if(f->ref == 0){
80100f8b:	8b 43 04             	mov    0x4(%ebx),%eax
80100f8e:	85 c0                	test   %eax,%eax
80100f90:	75 ee                	jne    80100f80 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100f92:	83 ec 0c             	sub    $0xc,%esp
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
80100f95:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100f9c:	68 60 0f 11 80       	push   $0x80110f60
80100fa1:	e8 1a 36 00 00       	call   801045c0 <release>
      return f;
80100fa6:	89 d8                	mov    %ebx,%eax
80100fa8:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ftable.lock);
  return 0;
}
80100fab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fae:	c9                   	leave  
80100faf:	c3                   	ret    
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100fb0:	83 ec 0c             	sub    $0xc,%esp
80100fb3:	68 60 0f 11 80       	push   $0x80110f60
80100fb8:	e8 03 36 00 00       	call   801045c0 <release>
  return 0;
80100fbd:	83 c4 10             	add    $0x10,%esp
80100fc0:	31 c0                	xor    %eax,%eax
}
80100fc2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fc5:	c9                   	leave  
80100fc6:	c3                   	ret    
80100fc7:	89 f6                	mov    %esi,%esi
80100fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100fd0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100fd0:	55                   	push   %ebp
80100fd1:	89 e5                	mov    %esp,%ebp
80100fd3:	53                   	push   %ebx
80100fd4:	83 ec 10             	sub    $0x10,%esp
80100fd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100fda:	68 60 0f 11 80       	push   $0x80110f60
80100fdf:	e8 bc 34 00 00       	call   801044a0 <acquire>
  if(f->ref < 1)
80100fe4:	8b 43 04             	mov    0x4(%ebx),%eax
80100fe7:	83 c4 10             	add    $0x10,%esp
80100fea:	85 c0                	test   %eax,%eax
80100fec:	7e 1a                	jle    80101008 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100fee:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100ff1:	83 ec 0c             	sub    $0xc,%esp
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  f->ref++;
80100ff4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100ff7:	68 60 0f 11 80       	push   $0x80110f60
80100ffc:	e8 bf 35 00 00       	call   801045c0 <release>
  return f;
}
80101001:	89 d8                	mov    %ebx,%eax
80101003:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101006:	c9                   	leave  
80101007:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80101008:	83 ec 0c             	sub    $0xc,%esp
8010100b:	68 74 72 10 80       	push   $0x80107274
80101010:	e8 5b f3 ff ff       	call   80100370 <panic>
80101015:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101020 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101020:	55                   	push   %ebp
80101021:	89 e5                	mov    %esp,%ebp
80101023:	57                   	push   %edi
80101024:	56                   	push   %esi
80101025:	53                   	push   %ebx
80101026:	83 ec 28             	sub    $0x28,%esp
80101029:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
8010102c:	68 60 0f 11 80       	push   $0x80110f60
80101031:	e8 6a 34 00 00       	call   801044a0 <acquire>
  if(f->ref < 1)
80101036:	8b 47 04             	mov    0x4(%edi),%eax
80101039:	83 c4 10             	add    $0x10,%esp
8010103c:	85 c0                	test   %eax,%eax
8010103e:	0f 8e 9b 00 00 00    	jle    801010df <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80101044:	83 e8 01             	sub    $0x1,%eax
80101047:	85 c0                	test   %eax,%eax
80101049:	89 47 04             	mov    %eax,0x4(%edi)
8010104c:	74 1a                	je     80101068 <fileclose+0x48>
    release(&ftable.lock);
8010104e:	c7 45 08 60 0f 11 80 	movl   $0x80110f60,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80101055:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101058:	5b                   	pop    %ebx
80101059:	5e                   	pop    %esi
8010105a:	5f                   	pop    %edi
8010105b:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
8010105c:	e9 5f 35 00 00       	jmp    801045c0 <release>
80101061:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
80101068:	0f b6 47 09          	movzbl 0x9(%edi),%eax
8010106c:	8b 1f                	mov    (%edi),%ebx
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
8010106e:	83 ec 0c             	sub    $0xc,%esp
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80101071:	8b 77 0c             	mov    0xc(%edi),%esi
  f->ref = 0;
  f->type = FD_NONE;
80101074:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
8010107a:	88 45 e7             	mov    %al,-0x19(%ebp)
8010107d:	8b 47 10             	mov    0x10(%edi),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101080:	68 60 0f 11 80       	push   $0x80110f60
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80101085:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101088:	e8 33 35 00 00       	call   801045c0 <release>

  if(ff.type == FD_PIPE)
8010108d:	83 c4 10             	add    $0x10,%esp
80101090:	83 fb 01             	cmp    $0x1,%ebx
80101093:	74 13                	je     801010a8 <fileclose+0x88>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80101095:	83 fb 02             	cmp    $0x2,%ebx
80101098:	74 26                	je     801010c0 <fileclose+0xa0>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
8010109a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010109d:	5b                   	pop    %ebx
8010109e:	5e                   	pop    %esi
8010109f:	5f                   	pop    %edi
801010a0:	5d                   	pop    %ebp
801010a1:	c3                   	ret    
801010a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
801010a8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
801010ac:	83 ec 08             	sub    $0x8,%esp
801010af:	53                   	push   %ebx
801010b0:	56                   	push   %esi
801010b1:	e8 2a 24 00 00       	call   801034e0 <pipeclose>
801010b6:	83 c4 10             	add    $0x10,%esp
801010b9:	eb df                	jmp    8010109a <fileclose+0x7a>
801010bb:	90                   	nop
801010bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if(ff.type == FD_INODE){
    begin_op();
801010c0:	e8 7b 1c 00 00       	call   80102d40 <begin_op>
    iput(ff.ip);
801010c5:	83 ec 0c             	sub    $0xc,%esp
801010c8:	ff 75 e0             	pushl  -0x20(%ebp)
801010cb:	e8 c0 08 00 00       	call   80101990 <iput>
    end_op();
801010d0:	83 c4 10             	add    $0x10,%esp
  }
}
801010d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010d6:	5b                   	pop    %ebx
801010d7:	5e                   	pop    %esi
801010d8:	5f                   	pop    %edi
801010d9:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
801010da:	e9 d1 1c 00 00       	jmp    80102db0 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
801010df:	83 ec 0c             	sub    $0xc,%esp
801010e2:	68 7c 72 10 80       	push   $0x8010727c
801010e7:	e8 84 f2 ff ff       	call   80100370 <panic>
801010ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801010f0 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
801010f0:	55                   	push   %ebp
801010f1:	89 e5                	mov    %esp,%ebp
801010f3:	53                   	push   %ebx
801010f4:	83 ec 04             	sub    $0x4,%esp
801010f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
801010fa:	83 3b 02             	cmpl   $0x2,(%ebx)
801010fd:	75 31                	jne    80101130 <filestat+0x40>
    ilock(f->ip);
801010ff:	83 ec 0c             	sub    $0xc,%esp
80101102:	ff 73 10             	pushl  0x10(%ebx)
80101105:	e8 56 07 00 00       	call   80101860 <ilock>
    stati(f->ip, st);
8010110a:	58                   	pop    %eax
8010110b:	5a                   	pop    %edx
8010110c:	ff 75 0c             	pushl  0xc(%ebp)
8010110f:	ff 73 10             	pushl  0x10(%ebx)
80101112:	e8 f9 09 00 00       	call   80101b10 <stati>
    iunlock(f->ip);
80101117:	59                   	pop    %ecx
80101118:	ff 73 10             	pushl  0x10(%ebx)
8010111b:	e8 20 08 00 00       	call   80101940 <iunlock>
    return 0;
80101120:	83 c4 10             	add    $0x10,%esp
80101123:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80101125:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101128:	c9                   	leave  
80101129:	c3                   	ret    
8010112a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80101130:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101135:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101138:	c9                   	leave  
80101139:	c3                   	ret    
8010113a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101140 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101140:	55                   	push   %ebp
80101141:	89 e5                	mov    %esp,%ebp
80101143:	57                   	push   %edi
80101144:	56                   	push   %esi
80101145:	53                   	push   %ebx
80101146:	83 ec 0c             	sub    $0xc,%esp
80101149:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010114c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010114f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101152:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101156:	74 60                	je     801011b8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101158:	8b 03                	mov    (%ebx),%eax
8010115a:	83 f8 01             	cmp    $0x1,%eax
8010115d:	74 41                	je     801011a0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010115f:	83 f8 02             	cmp    $0x2,%eax
80101162:	75 5b                	jne    801011bf <fileread+0x7f>
    ilock(f->ip);
80101164:	83 ec 0c             	sub    $0xc,%esp
80101167:	ff 73 10             	pushl  0x10(%ebx)
8010116a:	e8 f1 06 00 00       	call   80101860 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010116f:	57                   	push   %edi
80101170:	ff 73 14             	pushl  0x14(%ebx)
80101173:	56                   	push   %esi
80101174:	ff 73 10             	pushl  0x10(%ebx)
80101177:	e8 c4 09 00 00       	call   80101b40 <readi>
8010117c:	83 c4 20             	add    $0x20,%esp
8010117f:	85 c0                	test   %eax,%eax
80101181:	89 c6                	mov    %eax,%esi
80101183:	7e 03                	jle    80101188 <fileread+0x48>
      f->off += r;
80101185:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101188:	83 ec 0c             	sub    $0xc,%esp
8010118b:	ff 73 10             	pushl  0x10(%ebx)
8010118e:	e8 ad 07 00 00       	call   80101940 <iunlock>
    return r;
80101193:	83 c4 10             	add    $0x10,%esp
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101196:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80101198:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010119b:	5b                   	pop    %ebx
8010119c:	5e                   	pop    %esi
8010119d:	5f                   	pop    %edi
8010119e:	5d                   	pop    %ebp
8010119f:	c3                   	ret    
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
801011a0:	8b 43 0c             	mov    0xc(%ebx),%eax
801011a3:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
801011a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011a9:	5b                   	pop    %ebx
801011aa:	5e                   	pop    %esi
801011ab:	5f                   	pop    %edi
801011ac:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
801011ad:	e9 ce 24 00 00       	jmp    80103680 <piperead>
801011b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
801011b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801011bd:	eb d9                	jmp    80101198 <fileread+0x58>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
801011bf:	83 ec 0c             	sub    $0xc,%esp
801011c2:	68 86 72 10 80       	push   $0x80107286
801011c7:	e8 a4 f1 ff ff       	call   80100370 <panic>
801011cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801011d0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801011d0:	55                   	push   %ebp
801011d1:	89 e5                	mov    %esp,%ebp
801011d3:	57                   	push   %edi
801011d4:	56                   	push   %esi
801011d5:	53                   	push   %ebx
801011d6:	83 ec 1c             	sub    $0x1c,%esp
801011d9:	8b 75 08             	mov    0x8(%ebp),%esi
801011dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
801011df:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801011e3:	89 45 dc             	mov    %eax,-0x24(%ebp)
801011e6:	8b 45 10             	mov    0x10(%ebp),%eax
801011e9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
801011ec:	0f 84 aa 00 00 00    	je     8010129c <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
801011f2:	8b 06                	mov    (%esi),%eax
801011f4:	83 f8 01             	cmp    $0x1,%eax
801011f7:	0f 84 c2 00 00 00    	je     801012bf <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801011fd:	83 f8 02             	cmp    $0x2,%eax
80101200:	0f 85 d8 00 00 00    	jne    801012de <filewrite+0x10e>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101206:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101209:	31 ff                	xor    %edi,%edi
8010120b:	85 c0                	test   %eax,%eax
8010120d:	7f 34                	jg     80101243 <filewrite+0x73>
8010120f:	e9 9c 00 00 00       	jmp    801012b0 <filewrite+0xe0>
80101214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101218:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010121b:	83 ec 0c             	sub    $0xc,%esp
8010121e:	ff 76 10             	pushl  0x10(%esi)
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101221:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101224:	e8 17 07 00 00       	call   80101940 <iunlock>
      end_op();
80101229:	e8 82 1b 00 00       	call   80102db0 <end_op>
8010122e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101231:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101234:	39 d8                	cmp    %ebx,%eax
80101236:	0f 85 95 00 00 00    	jne    801012d1 <filewrite+0x101>
        panic("short filewrite");
      i += r;
8010123c:	01 c7                	add    %eax,%edi
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
8010123e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101241:	7e 6d                	jle    801012b0 <filewrite+0xe0>
      int n1 = n - i;
80101243:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101246:	b8 00 06 00 00       	mov    $0x600,%eax
8010124b:	29 fb                	sub    %edi,%ebx
8010124d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101253:	0f 4f d8             	cmovg  %eax,%ebx
      if(n1 > max)
        n1 = max;

      begin_op();
80101256:	e8 e5 1a 00 00       	call   80102d40 <begin_op>
      ilock(f->ip);
8010125b:	83 ec 0c             	sub    $0xc,%esp
8010125e:	ff 76 10             	pushl  0x10(%esi)
80101261:	e8 fa 05 00 00       	call   80101860 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101266:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101269:	53                   	push   %ebx
8010126a:	ff 76 14             	pushl  0x14(%esi)
8010126d:	01 f8                	add    %edi,%eax
8010126f:	50                   	push   %eax
80101270:	ff 76 10             	pushl  0x10(%esi)
80101273:	e8 c8 09 00 00       	call   80101c40 <writei>
80101278:	83 c4 20             	add    $0x20,%esp
8010127b:	85 c0                	test   %eax,%eax
8010127d:	7f 99                	jg     80101218 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
8010127f:	83 ec 0c             	sub    $0xc,%esp
80101282:	ff 76 10             	pushl  0x10(%esi)
80101285:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101288:	e8 b3 06 00 00       	call   80101940 <iunlock>
      end_op();
8010128d:	e8 1e 1b 00 00       	call   80102db0 <end_op>

      if(r < 0)
80101292:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101295:	83 c4 10             	add    $0x10,%esp
80101298:	85 c0                	test   %eax,%eax
8010129a:	74 98                	je     80101234 <filewrite+0x64>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
8010129c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
8010129f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
801012a4:	5b                   	pop    %ebx
801012a5:	5e                   	pop    %esi
801012a6:	5f                   	pop    %edi
801012a7:	5d                   	pop    %ebp
801012a8:	c3                   	ret    
801012a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801012b0:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
801012b3:	75 e7                	jne    8010129c <filewrite+0xcc>
  }
  panic("filewrite");
}
801012b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012b8:	89 f8                	mov    %edi,%eax
801012ba:	5b                   	pop    %ebx
801012bb:	5e                   	pop    %esi
801012bc:	5f                   	pop    %edi
801012bd:	5d                   	pop    %ebp
801012be:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801012bf:	8b 46 0c             	mov    0xc(%esi),%eax
801012c2:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801012c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012c8:	5b                   	pop    %ebx
801012c9:	5e                   	pop    %esi
801012ca:	5f                   	pop    %edi
801012cb:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801012cc:	e9 af 22 00 00       	jmp    80103580 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
801012d1:	83 ec 0c             	sub    $0xc,%esp
801012d4:	68 8f 72 10 80       	push   $0x8010728f
801012d9:	e8 92 f0 ff ff       	call   80100370 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
801012de:	83 ec 0c             	sub    $0xc,%esp
801012e1:	68 95 72 10 80       	push   $0x80107295
801012e6:	e8 85 f0 ff ff       	call   80100370 <panic>
801012eb:	66 90                	xchg   %ax,%ax
801012ed:	66 90                	xchg   %ax,%ax
801012ef:	90                   	nop

801012f0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801012f0:	55                   	push   %ebp
801012f1:	89 e5                	mov    %esp,%ebp
801012f3:	57                   	push   %edi
801012f4:	56                   	push   %esi
801012f5:	53                   	push   %ebx
801012f6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801012f9:	8b 0d 60 19 11 80    	mov    0x80111960,%ecx
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801012ff:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101302:	85 c9                	test   %ecx,%ecx
80101304:	0f 84 85 00 00 00    	je     8010138f <balloc+0x9f>
8010130a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101311:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101314:	83 ec 08             	sub    $0x8,%esp
80101317:	89 f0                	mov    %esi,%eax
80101319:	c1 f8 0c             	sar    $0xc,%eax
8010131c:	03 05 78 19 11 80    	add    0x80111978,%eax
80101322:	50                   	push   %eax
80101323:	ff 75 d8             	pushl  -0x28(%ebp)
80101326:	e8 a5 ed ff ff       	call   801000d0 <bread>
8010132b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010132e:	a1 60 19 11 80       	mov    0x80111960,%eax
80101333:	83 c4 10             	add    $0x10,%esp
80101336:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101339:	31 c0                	xor    %eax,%eax
8010133b:	eb 2d                	jmp    8010136a <balloc+0x7a>
8010133d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101340:	89 c1                	mov    %eax,%ecx
80101342:	ba 01 00 00 00       	mov    $0x1,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101347:	8b 5d e4             	mov    -0x1c(%ebp),%ebx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
8010134a:	83 e1 07             	and    $0x7,%ecx
8010134d:	d3 e2                	shl    %cl,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010134f:	89 c1                	mov    %eax,%ecx
80101351:	c1 f9 03             	sar    $0x3,%ecx
80101354:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
80101359:	85 d7                	test   %edx,%edi
8010135b:	74 43                	je     801013a0 <balloc+0xb0>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010135d:	83 c0 01             	add    $0x1,%eax
80101360:	83 c6 01             	add    $0x1,%esi
80101363:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101368:	74 05                	je     8010136f <balloc+0x7f>
8010136a:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010136d:	72 d1                	jb     80101340 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
8010136f:	83 ec 0c             	sub    $0xc,%esp
80101372:	ff 75 e4             	pushl  -0x1c(%ebp)
80101375:	e8 66 ee ff ff       	call   801001e0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
8010137a:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101381:	83 c4 10             	add    $0x10,%esp
80101384:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101387:	39 05 60 19 11 80    	cmp    %eax,0x80111960
8010138d:	77 82                	ja     80101311 <balloc+0x21>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
8010138f:	83 ec 0c             	sub    $0xc,%esp
80101392:	68 9f 72 10 80       	push   $0x8010729f
80101397:	e8 d4 ef ff ff       	call   80100370 <panic>
8010139c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
801013a0:	09 fa                	or     %edi,%edx
801013a2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801013a5:	83 ec 0c             	sub    $0xc,%esp
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
801013a8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801013ac:	57                   	push   %edi
801013ad:	e8 6e 1b 00 00       	call   80102f20 <log_write>
        brelse(bp);
801013b2:	89 3c 24             	mov    %edi,(%esp)
801013b5:	e8 26 ee ff ff       	call   801001e0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
801013ba:	58                   	pop    %eax
801013bb:	5a                   	pop    %edx
801013bc:	56                   	push   %esi
801013bd:	ff 75 d8             	pushl  -0x28(%ebp)
801013c0:	e8 0b ed ff ff       	call   801000d0 <bread>
801013c5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801013c7:	8d 40 5c             	lea    0x5c(%eax),%eax
801013ca:	83 c4 0c             	add    $0xc,%esp
801013cd:	68 00 02 00 00       	push   $0x200
801013d2:	6a 00                	push   $0x0
801013d4:	50                   	push   %eax
801013d5:	e8 36 32 00 00       	call   80104610 <memset>
  log_write(bp);
801013da:	89 1c 24             	mov    %ebx,(%esp)
801013dd:	e8 3e 1b 00 00       	call   80102f20 <log_write>
  brelse(bp);
801013e2:	89 1c 24             	mov    %ebx,(%esp)
801013e5:	e8 f6 ed ff ff       	call   801001e0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
801013ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013ed:	89 f0                	mov    %esi,%eax
801013ef:	5b                   	pop    %ebx
801013f0:	5e                   	pop    %esi
801013f1:	5f                   	pop    %edi
801013f2:	5d                   	pop    %ebp
801013f3:	c3                   	ret    
801013f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801013fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101400 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101400:	55                   	push   %ebp
80101401:	89 e5                	mov    %esp,%ebp
80101403:	57                   	push   %edi
80101404:	56                   	push   %esi
80101405:	53                   	push   %ebx
80101406:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101408:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010140a:	bb b4 19 11 80       	mov    $0x801119b4,%ebx
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
8010140f:	83 ec 28             	sub    $0x28,%esp
80101412:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101415:	68 80 19 11 80       	push   $0x80111980
8010141a:	e8 81 30 00 00       	call   801044a0 <acquire>
8010141f:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101422:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101425:	eb 1b                	jmp    80101442 <iget+0x42>
80101427:	89 f6                	mov    %esi,%esi
80101429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101430:	85 f6                	test   %esi,%esi
80101432:	74 44                	je     80101478 <iget+0x78>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101434:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010143a:	81 fb d4 35 11 80    	cmp    $0x801135d4,%ebx
80101440:	74 4e                	je     80101490 <iget+0x90>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101442:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101445:	85 c9                	test   %ecx,%ecx
80101447:	7e e7                	jle    80101430 <iget+0x30>
80101449:	39 3b                	cmp    %edi,(%ebx)
8010144b:	75 e3                	jne    80101430 <iget+0x30>
8010144d:	39 53 04             	cmp    %edx,0x4(%ebx)
80101450:	75 de                	jne    80101430 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
80101452:	83 ec 0c             	sub    $0xc,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
80101455:	83 c1 01             	add    $0x1,%ecx
      release(&icache.lock);
      return ip;
80101458:	89 de                	mov    %ebx,%esi
  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
8010145a:	68 80 19 11 80       	push   $0x80111980

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
8010145f:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101462:	e8 59 31 00 00       	call   801045c0 <release>
      return ip;
80101467:	83 c4 10             	add    $0x10,%esp
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
8010146a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010146d:	89 f0                	mov    %esi,%eax
8010146f:	5b                   	pop    %ebx
80101470:	5e                   	pop    %esi
80101471:	5f                   	pop    %edi
80101472:	5d                   	pop    %ebp
80101473:	c3                   	ret    
80101474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101478:	85 c9                	test   %ecx,%ecx
8010147a:	0f 44 f3             	cmove  %ebx,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010147d:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101483:	81 fb d4 35 11 80    	cmp    $0x801135d4,%ebx
80101489:	75 b7                	jne    80101442 <iget+0x42>
8010148b:	90                   	nop
8010148c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101490:	85 f6                	test   %esi,%esi
80101492:	74 2d                	je     801014c1 <iget+0xc1>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101494:	83 ec 0c             	sub    $0xc,%esp
  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
80101497:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101499:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010149c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801014a3:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801014aa:	68 80 19 11 80       	push   $0x80111980
801014af:	e8 0c 31 00 00       	call   801045c0 <release>

  return ip;
801014b4:	83 c4 10             	add    $0x10,%esp
}
801014b7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014ba:	89 f0                	mov    %esi,%eax
801014bc:	5b                   	pop    %ebx
801014bd:	5e                   	pop    %esi
801014be:	5f                   	pop    %edi
801014bf:	5d                   	pop    %ebp
801014c0:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
801014c1:	83 ec 0c             	sub    $0xc,%esp
801014c4:	68 b5 72 10 80       	push   $0x801072b5
801014c9:	e8 a2 ee ff ff       	call   80100370 <panic>
801014ce:	66 90                	xchg   %ax,%ax

801014d0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801014d0:	55                   	push   %ebp
801014d1:	89 e5                	mov    %esp,%ebp
801014d3:	57                   	push   %edi
801014d4:	56                   	push   %esi
801014d5:	53                   	push   %ebx
801014d6:	89 c6                	mov    %eax,%esi
801014d8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801014db:	83 fa 0b             	cmp    $0xb,%edx
801014de:	77 18                	ja     801014f8 <bmap+0x28>
801014e0:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
    if((addr = ip->addrs[bn]) == 0)
801014e3:	8b 43 5c             	mov    0x5c(%ebx),%eax
801014e6:	85 c0                	test   %eax,%eax
801014e8:	74 76                	je     80101560 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801014ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014ed:	5b                   	pop    %ebx
801014ee:	5e                   	pop    %esi
801014ef:	5f                   	pop    %edi
801014f0:	5d                   	pop    %ebp
801014f1:	c3                   	ret    
801014f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801014f8:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801014fb:	83 fb 7f             	cmp    $0x7f,%ebx
801014fe:	0f 87 83 00 00 00    	ja     80101587 <bmap+0xb7>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101504:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
8010150a:	85 c0                	test   %eax,%eax
8010150c:	74 6a                	je     80101578 <bmap+0xa8>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010150e:	83 ec 08             	sub    $0x8,%esp
80101511:	50                   	push   %eax
80101512:	ff 36                	pushl  (%esi)
80101514:	e8 b7 eb ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101519:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010151d:	83 c4 10             	add    $0x10,%esp

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101520:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101522:	8b 1a                	mov    (%edx),%ebx
80101524:	85 db                	test   %ebx,%ebx
80101526:	75 1d                	jne    80101545 <bmap+0x75>
      a[bn] = addr = balloc(ip->dev);
80101528:	8b 06                	mov    (%esi),%eax
8010152a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010152d:	e8 be fd ff ff       	call   801012f0 <balloc>
80101532:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101535:	83 ec 0c             	sub    $0xc,%esp
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
80101538:	89 c3                	mov    %eax,%ebx
8010153a:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010153c:	57                   	push   %edi
8010153d:	e8 de 19 00 00       	call   80102f20 <log_write>
80101542:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101545:	83 ec 0c             	sub    $0xc,%esp
80101548:	57                   	push   %edi
80101549:	e8 92 ec ff ff       	call   801001e0 <brelse>
8010154e:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101551:	8d 65 f4             	lea    -0xc(%ebp),%esp
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101554:	89 d8                	mov    %ebx,%eax
    return addr;
  }

  panic("bmap: out of range");
}
80101556:	5b                   	pop    %ebx
80101557:	5e                   	pop    %esi
80101558:	5f                   	pop    %edi
80101559:	5d                   	pop    %ebp
8010155a:	c3                   	ret    
8010155b:	90                   	nop
8010155c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80101560:	8b 06                	mov    (%esi),%eax
80101562:	e8 89 fd ff ff       	call   801012f0 <balloc>
80101567:	89 43 5c             	mov    %eax,0x5c(%ebx)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010156a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010156d:	5b                   	pop    %ebx
8010156e:	5e                   	pop    %esi
8010156f:	5f                   	pop    %edi
80101570:	5d                   	pop    %ebp
80101571:	c3                   	ret    
80101572:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101578:	8b 06                	mov    (%esi),%eax
8010157a:	e8 71 fd ff ff       	call   801012f0 <balloc>
8010157f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101585:	eb 87                	jmp    8010150e <bmap+0x3e>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
80101587:	83 ec 0c             	sub    $0xc,%esp
8010158a:	68 c5 72 10 80       	push   $0x801072c5
8010158f:	e8 dc ed ff ff       	call   80100370 <panic>
80101594:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010159a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801015a0 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
801015a0:	55                   	push   %ebp
801015a1:	89 e5                	mov    %esp,%ebp
801015a3:	56                   	push   %esi
801015a4:	53                   	push   %ebx
801015a5:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
801015a8:	83 ec 08             	sub    $0x8,%esp
801015ab:	6a 01                	push   $0x1
801015ad:	ff 75 08             	pushl  0x8(%ebp)
801015b0:	e8 1b eb ff ff       	call   801000d0 <bread>
801015b5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801015b7:	8d 40 5c             	lea    0x5c(%eax),%eax
801015ba:	83 c4 0c             	add    $0xc,%esp
801015bd:	6a 1c                	push   $0x1c
801015bf:	50                   	push   %eax
801015c0:	56                   	push   %esi
801015c1:	e8 fa 30 00 00       	call   801046c0 <memmove>
  brelse(bp);
801015c6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801015c9:	83 c4 10             	add    $0x10,%esp
}
801015cc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801015cf:	5b                   	pop    %ebx
801015d0:	5e                   	pop    %esi
801015d1:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
801015d2:	e9 09 ec ff ff       	jmp    801001e0 <brelse>
801015d7:	89 f6                	mov    %esi,%esi
801015d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801015e0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801015e0:	55                   	push   %ebp
801015e1:	89 e5                	mov    %esp,%ebp
801015e3:	56                   	push   %esi
801015e4:	53                   	push   %ebx
801015e5:	89 d3                	mov    %edx,%ebx
801015e7:	89 c6                	mov    %eax,%esi
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
801015e9:	83 ec 08             	sub    $0x8,%esp
801015ec:	68 60 19 11 80       	push   $0x80111960
801015f1:	50                   	push   %eax
801015f2:	e8 a9 ff ff ff       	call   801015a0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801015f7:	58                   	pop    %eax
801015f8:	5a                   	pop    %edx
801015f9:	89 da                	mov    %ebx,%edx
801015fb:	c1 ea 0c             	shr    $0xc,%edx
801015fe:	03 15 78 19 11 80    	add    0x80111978,%edx
80101604:	52                   	push   %edx
80101605:	56                   	push   %esi
80101606:	e8 c5 ea ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010160b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010160d:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101613:	ba 01 00 00 00       	mov    $0x1,%edx
80101618:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
8010161b:	c1 fb 03             	sar    $0x3,%ebx
8010161e:	83 c4 10             	add    $0x10,%esp
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101621:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101623:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101628:	85 d1                	test   %edx,%ecx
8010162a:	74 27                	je     80101653 <bfree+0x73>
8010162c:	89 c6                	mov    %eax,%esi
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010162e:	f7 d2                	not    %edx
80101630:	89 c8                	mov    %ecx,%eax
  log_write(bp);
80101632:	83 ec 0c             	sub    $0xc,%esp
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101635:	21 d0                	and    %edx,%eax
80101637:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010163b:	56                   	push   %esi
8010163c:	e8 df 18 00 00       	call   80102f20 <log_write>
  brelse(bp);
80101641:	89 34 24             	mov    %esi,(%esp)
80101644:	e8 97 eb ff ff       	call   801001e0 <brelse>
}
80101649:	83 c4 10             	add    $0x10,%esp
8010164c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010164f:	5b                   	pop    %ebx
80101650:	5e                   	pop    %esi
80101651:	5d                   	pop    %ebp
80101652:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
80101653:	83 ec 0c             	sub    $0xc,%esp
80101656:	68 d8 72 10 80       	push   $0x801072d8
8010165b:	e8 10 ed ff ff       	call   80100370 <panic>

80101660 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101660:	55                   	push   %ebp
80101661:	89 e5                	mov    %esp,%ebp
80101663:	53                   	push   %ebx
80101664:	bb c0 19 11 80       	mov    $0x801119c0,%ebx
80101669:	83 ec 0c             	sub    $0xc,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
8010166c:	68 eb 72 10 80       	push   $0x801072eb
80101671:	68 80 19 11 80       	push   $0x80111980
80101676:	e8 25 2d 00 00       	call   801043a0 <initlock>
8010167b:	83 c4 10             	add    $0x10,%esp
8010167e:	66 90                	xchg   %ax,%ax
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
80101680:	83 ec 08             	sub    $0x8,%esp
80101683:	68 f2 72 10 80       	push   $0x801072f2
80101688:	53                   	push   %ebx
80101689:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010168f:	e8 fc 2b 00 00       	call   80104290 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
80101694:	83 c4 10             	add    $0x10,%esp
80101697:	81 fb e0 35 11 80    	cmp    $0x801135e0,%ebx
8010169d:	75 e1                	jne    80101680 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }

  readsb(dev, &sb);
8010169f:	83 ec 08             	sub    $0x8,%esp
801016a2:	68 60 19 11 80       	push   $0x80111960
801016a7:	ff 75 08             	pushl  0x8(%ebp)
801016aa:	e8 f1 fe ff ff       	call   801015a0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801016af:	ff 35 78 19 11 80    	pushl  0x80111978
801016b5:	ff 35 74 19 11 80    	pushl  0x80111974
801016bb:	ff 35 70 19 11 80    	pushl  0x80111970
801016c1:	ff 35 6c 19 11 80    	pushl  0x8011196c
801016c7:	ff 35 68 19 11 80    	pushl  0x80111968
801016cd:	ff 35 64 19 11 80    	pushl  0x80111964
801016d3:	ff 35 60 19 11 80    	pushl  0x80111960
801016d9:	68 58 73 10 80       	push   $0x80107358
801016de:	e8 9d ef ff ff       	call   80100680 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
801016e3:	83 c4 30             	add    $0x30,%esp
801016e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801016e9:	c9                   	leave  
801016ea:	c3                   	ret    
801016eb:	90                   	nop
801016ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801016f0 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
801016f0:	55                   	push   %ebp
801016f1:	89 e5                	mov    %esp,%ebp
801016f3:	57                   	push   %edi
801016f4:	56                   	push   %esi
801016f5:	53                   	push   %ebx
801016f6:	83 ec 1c             	sub    $0x1c,%esp
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801016f9:	83 3d 68 19 11 80 01 	cmpl   $0x1,0x80111968
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101700:	8b 45 0c             	mov    0xc(%ebp),%eax
80101703:	8b 75 08             	mov    0x8(%ebp),%esi
80101706:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101709:	0f 86 91 00 00 00    	jbe    801017a0 <ialloc+0xb0>
8010170f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101714:	eb 21                	jmp    80101737 <ialloc+0x47>
80101716:	8d 76 00             	lea    0x0(%esi),%esi
80101719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101720:	83 ec 0c             	sub    $0xc,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101723:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101726:	57                   	push   %edi
80101727:	e8 b4 ea ff ff       	call   801001e0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010172c:	83 c4 10             	add    $0x10,%esp
8010172f:	39 1d 68 19 11 80    	cmp    %ebx,0x80111968
80101735:	76 69                	jbe    801017a0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101737:	89 d8                	mov    %ebx,%eax
80101739:	83 ec 08             	sub    $0x8,%esp
8010173c:	c1 e8 03             	shr    $0x3,%eax
8010173f:	03 05 74 19 11 80    	add    0x80111974,%eax
80101745:	50                   	push   %eax
80101746:	56                   	push   %esi
80101747:	e8 84 e9 ff ff       	call   801000d0 <bread>
8010174c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010174e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101750:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
80101753:	83 e0 07             	and    $0x7,%eax
80101756:	c1 e0 06             	shl    $0x6,%eax
80101759:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010175d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101761:	75 bd                	jne    80101720 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101763:	83 ec 04             	sub    $0x4,%esp
80101766:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101769:	6a 40                	push   $0x40
8010176b:	6a 00                	push   $0x0
8010176d:	51                   	push   %ecx
8010176e:	e8 9d 2e 00 00       	call   80104610 <memset>
      dip->type = type;
80101773:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101777:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010177a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010177d:	89 3c 24             	mov    %edi,(%esp)
80101780:	e8 9b 17 00 00       	call   80102f20 <log_write>
      brelse(bp);
80101785:	89 3c 24             	mov    %edi,(%esp)
80101788:	e8 53 ea ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
8010178d:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101790:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
80101793:	89 da                	mov    %ebx,%edx
80101795:	89 f0                	mov    %esi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101797:	5b                   	pop    %ebx
80101798:	5e                   	pop    %esi
80101799:	5f                   	pop    %edi
8010179a:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
8010179b:	e9 60 fc ff ff       	jmp    80101400 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
801017a0:	83 ec 0c             	sub    $0xc,%esp
801017a3:	68 f8 72 10 80       	push   $0x801072f8
801017a8:	e8 c3 eb ff ff       	call   80100370 <panic>
801017ad:	8d 76 00             	lea    0x0(%esi),%esi

801017b0 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
801017b0:	55                   	push   %ebp
801017b1:	89 e5                	mov    %esp,%ebp
801017b3:	56                   	push   %esi
801017b4:	53                   	push   %ebx
801017b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017b8:	83 ec 08             	sub    $0x8,%esp
801017bb:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017be:	83 c3 5c             	add    $0x5c,%ebx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017c1:	c1 e8 03             	shr    $0x3,%eax
801017c4:	03 05 74 19 11 80    	add    0x80111974,%eax
801017ca:	50                   	push   %eax
801017cb:	ff 73 a4             	pushl  -0x5c(%ebx)
801017ce:	e8 fd e8 ff ff       	call   801000d0 <bread>
801017d3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801017d5:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
801017d8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017dc:	83 c4 0c             	add    $0xc,%esp
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801017df:	83 e0 07             	and    $0x7,%eax
801017e2:	c1 e0 06             	shl    $0x6,%eax
801017e5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801017e9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801017ec:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017f0:	83 c0 0c             	add    $0xc,%eax
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
801017f3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801017f7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801017fb:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801017ff:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101803:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101807:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010180a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010180d:	6a 34                	push   $0x34
8010180f:	53                   	push   %ebx
80101810:	50                   	push   %eax
80101811:	e8 aa 2e 00 00       	call   801046c0 <memmove>
  log_write(bp);
80101816:	89 34 24             	mov    %esi,(%esp)
80101819:	e8 02 17 00 00       	call   80102f20 <log_write>
  brelse(bp);
8010181e:	89 75 08             	mov    %esi,0x8(%ebp)
80101821:	83 c4 10             	add    $0x10,%esp
}
80101824:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101827:	5b                   	pop    %ebx
80101828:	5e                   	pop    %esi
80101829:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
8010182a:	e9 b1 e9 ff ff       	jmp    801001e0 <brelse>
8010182f:	90                   	nop

80101830 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101830:	55                   	push   %ebp
80101831:	89 e5                	mov    %esp,%ebp
80101833:	53                   	push   %ebx
80101834:	83 ec 10             	sub    $0x10,%esp
80101837:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010183a:	68 80 19 11 80       	push   $0x80111980
8010183f:	e8 5c 2c 00 00       	call   801044a0 <acquire>
  ip->ref++;
80101844:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101848:	c7 04 24 80 19 11 80 	movl   $0x80111980,(%esp)
8010184f:	e8 6c 2d 00 00       	call   801045c0 <release>
  return ip;
}
80101854:	89 d8                	mov    %ebx,%eax
80101856:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101859:	c9                   	leave  
8010185a:	c3                   	ret    
8010185b:	90                   	nop
8010185c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101860 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101860:	55                   	push   %ebp
80101861:	89 e5                	mov    %esp,%ebp
80101863:	56                   	push   %esi
80101864:	53                   	push   %ebx
80101865:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101868:	85 db                	test   %ebx,%ebx
8010186a:	0f 84 b7 00 00 00    	je     80101927 <ilock+0xc7>
80101870:	8b 53 08             	mov    0x8(%ebx),%edx
80101873:	85 d2                	test   %edx,%edx
80101875:	0f 8e ac 00 00 00    	jle    80101927 <ilock+0xc7>
    panic("ilock");

  acquiresleep(&ip->lock);
8010187b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010187e:	83 ec 0c             	sub    $0xc,%esp
80101881:	50                   	push   %eax
80101882:	e8 49 2a 00 00       	call   801042d0 <acquiresleep>

  if(ip->valid == 0){
80101887:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010188a:	83 c4 10             	add    $0x10,%esp
8010188d:	85 c0                	test   %eax,%eax
8010188f:	74 0f                	je     801018a0 <ilock+0x40>
    brelse(bp);
    ip->valid = 1;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
80101891:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101894:	5b                   	pop    %ebx
80101895:	5e                   	pop    %esi
80101896:	5d                   	pop    %ebp
80101897:	c3                   	ret    
80101898:	90                   	nop
80101899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801018a0:	8b 43 04             	mov    0x4(%ebx),%eax
801018a3:	83 ec 08             	sub    $0x8,%esp
801018a6:	c1 e8 03             	shr    $0x3,%eax
801018a9:	03 05 74 19 11 80    	add    0x80111974,%eax
801018af:	50                   	push   %eax
801018b0:	ff 33                	pushl  (%ebx)
801018b2:	e8 19 e8 ff ff       	call   801000d0 <bread>
801018b7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801018b9:	8b 43 04             	mov    0x4(%ebx),%eax
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801018bc:	83 c4 0c             	add    $0xc,%esp

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801018bf:	83 e0 07             	and    $0x7,%eax
801018c2:	c1 e0 06             	shl    $0x6,%eax
801018c5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801018c9:	0f b7 10             	movzwl (%eax),%edx
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801018cc:	83 c0 0c             	add    $0xc,%eax
  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
801018cf:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801018d3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801018d7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801018db:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801018df:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801018e3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801018e7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801018eb:	8b 50 fc             	mov    -0x4(%eax),%edx
801018ee:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801018f1:	6a 34                	push   $0x34
801018f3:	50                   	push   %eax
801018f4:	8d 43 5c             	lea    0x5c(%ebx),%eax
801018f7:	50                   	push   %eax
801018f8:	e8 c3 2d 00 00       	call   801046c0 <memmove>
    brelse(bp);
801018fd:	89 34 24             	mov    %esi,(%esp)
80101900:	e8 db e8 ff ff       	call   801001e0 <brelse>
    ip->valid = 1;
    if(ip->type == 0)
80101905:	83 c4 10             	add    $0x10,%esp
80101908:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    brelse(bp);
    ip->valid = 1;
8010190d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101914:	0f 85 77 ff ff ff    	jne    80101891 <ilock+0x31>
      panic("ilock: no type");
8010191a:	83 ec 0c             	sub    $0xc,%esp
8010191d:	68 10 73 10 80       	push   $0x80107310
80101922:	e8 49 ea ff ff       	call   80100370 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
80101927:	83 ec 0c             	sub    $0xc,%esp
8010192a:	68 0a 73 10 80       	push   $0x8010730a
8010192f:	e8 3c ea ff ff       	call   80100370 <panic>
80101934:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010193a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101940 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101940:	55                   	push   %ebp
80101941:	89 e5                	mov    %esp,%ebp
80101943:	56                   	push   %esi
80101944:	53                   	push   %ebx
80101945:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101948:	85 db                	test   %ebx,%ebx
8010194a:	74 28                	je     80101974 <iunlock+0x34>
8010194c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010194f:	83 ec 0c             	sub    $0xc,%esp
80101952:	56                   	push   %esi
80101953:	e8 18 2a 00 00       	call   80104370 <holdingsleep>
80101958:	83 c4 10             	add    $0x10,%esp
8010195b:	85 c0                	test   %eax,%eax
8010195d:	74 15                	je     80101974 <iunlock+0x34>
8010195f:	8b 43 08             	mov    0x8(%ebx),%eax
80101962:	85 c0                	test   %eax,%eax
80101964:	7e 0e                	jle    80101974 <iunlock+0x34>
    panic("iunlock");

  releasesleep(&ip->lock);
80101966:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101969:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010196c:	5b                   	pop    %ebx
8010196d:	5e                   	pop    %esi
8010196e:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
8010196f:	e9 bc 29 00 00       	jmp    80104330 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
80101974:	83 ec 0c             	sub    $0xc,%esp
80101977:	68 1f 73 10 80       	push   $0x8010731f
8010197c:	e8 ef e9 ff ff       	call   80100370 <panic>
80101981:	eb 0d                	jmp    80101990 <iput>
80101983:	90                   	nop
80101984:	90                   	nop
80101985:	90                   	nop
80101986:	90                   	nop
80101987:	90                   	nop
80101988:	90                   	nop
80101989:	90                   	nop
8010198a:	90                   	nop
8010198b:	90                   	nop
8010198c:	90                   	nop
8010198d:	90                   	nop
8010198e:	90                   	nop
8010198f:	90                   	nop

80101990 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101990:	55                   	push   %ebp
80101991:	89 e5                	mov    %esp,%ebp
80101993:	57                   	push   %edi
80101994:	56                   	push   %esi
80101995:	53                   	push   %ebx
80101996:	83 ec 28             	sub    $0x28,%esp
80101999:	8b 75 08             	mov    0x8(%ebp),%esi
  acquiresleep(&ip->lock);
8010199c:	8d 7e 0c             	lea    0xc(%esi),%edi
8010199f:	57                   	push   %edi
801019a0:	e8 2b 29 00 00       	call   801042d0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801019a5:	8b 56 4c             	mov    0x4c(%esi),%edx
801019a8:	83 c4 10             	add    $0x10,%esp
801019ab:	85 d2                	test   %edx,%edx
801019ad:	74 07                	je     801019b6 <iput+0x26>
801019af:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
801019b4:	74 32                	je     801019e8 <iput+0x58>
      ip->type = 0;
      iupdate(ip);
      ip->valid = 0;
    }
  }
  releasesleep(&ip->lock);
801019b6:	83 ec 0c             	sub    $0xc,%esp
801019b9:	57                   	push   %edi
801019ba:	e8 71 29 00 00       	call   80104330 <releasesleep>

  acquire(&icache.lock);
801019bf:	c7 04 24 80 19 11 80 	movl   $0x80111980,(%esp)
801019c6:	e8 d5 2a 00 00       	call   801044a0 <acquire>
  ip->ref--;
801019cb:	83 6e 08 01          	subl   $0x1,0x8(%esi)
  release(&icache.lock);
801019cf:	83 c4 10             	add    $0x10,%esp
801019d2:	c7 45 08 80 19 11 80 	movl   $0x80111980,0x8(%ebp)
}
801019d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801019dc:	5b                   	pop    %ebx
801019dd:	5e                   	pop    %esi
801019de:	5f                   	pop    %edi
801019df:	5d                   	pop    %ebp
  }
  releasesleep(&ip->lock);

  acquire(&icache.lock);
  ip->ref--;
  release(&icache.lock);
801019e0:	e9 db 2b 00 00       	jmp    801045c0 <release>
801019e5:	8d 76 00             	lea    0x0(%esi),%esi
void
iput(struct inode *ip)
{
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
801019e8:	83 ec 0c             	sub    $0xc,%esp
801019eb:	68 80 19 11 80       	push   $0x80111980
801019f0:	e8 ab 2a 00 00       	call   801044a0 <acquire>
    int r = ip->ref;
801019f5:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
801019f8:	c7 04 24 80 19 11 80 	movl   $0x80111980,(%esp)
801019ff:	e8 bc 2b 00 00       	call   801045c0 <release>
    if(r == 1){
80101a04:	83 c4 10             	add    $0x10,%esp
80101a07:	83 fb 01             	cmp    $0x1,%ebx
80101a0a:	75 aa                	jne    801019b6 <iput+0x26>
80101a0c:	8d 8e 8c 00 00 00    	lea    0x8c(%esi),%ecx
80101a12:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101a15:	8d 5e 5c             	lea    0x5c(%esi),%ebx
80101a18:	89 cf                	mov    %ecx,%edi
80101a1a:	eb 0b                	jmp    80101a27 <iput+0x97>
80101a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101a20:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101a23:	39 fb                	cmp    %edi,%ebx
80101a25:	74 19                	je     80101a40 <iput+0xb0>
    if(ip->addrs[i]){
80101a27:	8b 13                	mov    (%ebx),%edx
80101a29:	85 d2                	test   %edx,%edx
80101a2b:	74 f3                	je     80101a20 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
80101a2d:	8b 06                	mov    (%esi),%eax
80101a2f:	e8 ac fb ff ff       	call   801015e0 <bfree>
      ip->addrs[i] = 0;
80101a34:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80101a3a:	eb e4                	jmp    80101a20 <iput+0x90>
80101a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101a40:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80101a46:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101a49:	85 c0                	test   %eax,%eax
80101a4b:	75 33                	jne    80101a80 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101a4d:	83 ec 0c             	sub    $0xc,%esp
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
80101a50:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
80101a57:	56                   	push   %esi
80101a58:	e8 53 fd ff ff       	call   801017b0 <iupdate>
    int r = ip->ref;
    release(&icache.lock);
    if(r == 1){
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
      ip->type = 0;
80101a5d:	31 c0                	xor    %eax,%eax
80101a5f:	66 89 46 50          	mov    %ax,0x50(%esi)
      iupdate(ip);
80101a63:	89 34 24             	mov    %esi,(%esp)
80101a66:	e8 45 fd ff ff       	call   801017b0 <iupdate>
      ip->valid = 0;
80101a6b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
80101a72:	83 c4 10             	add    $0x10,%esp
80101a75:	e9 3c ff ff ff       	jmp    801019b6 <iput+0x26>
80101a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101a80:	83 ec 08             	sub    $0x8,%esp
80101a83:	50                   	push   %eax
80101a84:	ff 36                	pushl  (%esi)
80101a86:	e8 45 e6 ff ff       	call   801000d0 <bread>
80101a8b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101a91:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101a94:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101a97:	8d 58 5c             	lea    0x5c(%eax),%ebx
80101a9a:	83 c4 10             	add    $0x10,%esp
80101a9d:	89 cf                	mov    %ecx,%edi
80101a9f:	eb 0e                	jmp    80101aaf <iput+0x11f>
80101aa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101aa8:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
80101aab:	39 fb                	cmp    %edi,%ebx
80101aad:	74 0f                	je     80101abe <iput+0x12e>
      if(a[j])
80101aaf:	8b 13                	mov    (%ebx),%edx
80101ab1:	85 d2                	test   %edx,%edx
80101ab3:	74 f3                	je     80101aa8 <iput+0x118>
        bfree(ip->dev, a[j]);
80101ab5:	8b 06                	mov    (%esi),%eax
80101ab7:	e8 24 fb ff ff       	call   801015e0 <bfree>
80101abc:	eb ea                	jmp    80101aa8 <iput+0x118>
    }
    brelse(bp);
80101abe:	83 ec 0c             	sub    $0xc,%esp
80101ac1:	ff 75 e4             	pushl  -0x1c(%ebp)
80101ac4:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101ac7:	e8 14 e7 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101acc:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
80101ad2:	8b 06                	mov    (%esi),%eax
80101ad4:	e8 07 fb ff ff       	call   801015e0 <bfree>
    ip->addrs[NDIRECT] = 0;
80101ad9:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
80101ae0:	00 00 00 
80101ae3:	83 c4 10             	add    $0x10,%esp
80101ae6:	e9 62 ff ff ff       	jmp    80101a4d <iput+0xbd>
80101aeb:	90                   	nop
80101aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101af0 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101af0:	55                   	push   %ebp
80101af1:	89 e5                	mov    %esp,%ebp
80101af3:	53                   	push   %ebx
80101af4:	83 ec 10             	sub    $0x10,%esp
80101af7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101afa:	53                   	push   %ebx
80101afb:	e8 40 fe ff ff       	call   80101940 <iunlock>
  iput(ip);
80101b00:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101b03:	83 c4 10             	add    $0x10,%esp
}
80101b06:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101b09:	c9                   	leave  
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
80101b0a:	e9 81 fe ff ff       	jmp    80101990 <iput>
80101b0f:	90                   	nop

80101b10 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101b10:	55                   	push   %ebp
80101b11:	89 e5                	mov    %esp,%ebp
80101b13:	8b 55 08             	mov    0x8(%ebp),%edx
80101b16:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101b19:	8b 0a                	mov    (%edx),%ecx
80101b1b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101b1e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101b21:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101b24:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101b28:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101b2b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101b2f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101b33:	8b 52 58             	mov    0x58(%edx),%edx
80101b36:	89 50 10             	mov    %edx,0x10(%eax)
}
80101b39:	5d                   	pop    %ebp
80101b3a:	c3                   	ret    
80101b3b:	90                   	nop
80101b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101b40 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101b40:	55                   	push   %ebp
80101b41:	89 e5                	mov    %esp,%ebp
80101b43:	57                   	push   %edi
80101b44:	56                   	push   %esi
80101b45:	53                   	push   %ebx
80101b46:	83 ec 1c             	sub    $0x1c,%esp
80101b49:	8b 45 08             	mov    0x8(%ebp),%eax
80101b4c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101b4f:	8b 75 10             	mov    0x10(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b52:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101b57:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101b5a:	8b 7d 14             	mov    0x14(%ebp),%edi
80101b5d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101b60:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b63:	0f 84 a7 00 00 00    	je     80101c10 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101b69:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b6c:	8b 40 58             	mov    0x58(%eax),%eax
80101b6f:	39 f0                	cmp    %esi,%eax
80101b71:	0f 82 c1 00 00 00    	jb     80101c38 <readi+0xf8>
80101b77:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101b7a:	89 fa                	mov    %edi,%edx
80101b7c:	01 f2                	add    %esi,%edx
80101b7e:	0f 82 b4 00 00 00    	jb     80101c38 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101b84:	89 c1                	mov    %eax,%ecx
80101b86:	29 f1                	sub    %esi,%ecx
80101b88:	39 d0                	cmp    %edx,%eax
80101b8a:	0f 43 cf             	cmovae %edi,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b8d:	31 ff                	xor    %edi,%edi
80101b8f:	85 c9                	test   %ecx,%ecx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101b91:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b94:	74 6d                	je     80101c03 <readi+0xc3>
80101b96:	8d 76 00             	lea    0x0(%esi),%esi
80101b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ba0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101ba3:	89 f2                	mov    %esi,%edx
80101ba5:	c1 ea 09             	shr    $0x9,%edx
80101ba8:	89 d8                	mov    %ebx,%eax
80101baa:	e8 21 f9 ff ff       	call   801014d0 <bmap>
80101baf:	83 ec 08             	sub    $0x8,%esp
80101bb2:	50                   	push   %eax
80101bb3:	ff 33                	pushl  (%ebx)
    m = min(n - tot, BSIZE - off%BSIZE);
80101bb5:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bba:	e8 11 e5 ff ff       	call   801000d0 <bread>
80101bbf:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101bc1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101bc4:	89 f1                	mov    %esi,%ecx
80101bc6:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101bcc:	83 c4 0c             	add    $0xc,%esp
    memmove(dst, bp->data + off%BSIZE, m);
80101bcf:	89 55 dc             	mov    %edx,-0x24(%ebp)
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101bd2:	29 cb                	sub    %ecx,%ebx
80101bd4:	29 f8                	sub    %edi,%eax
80101bd6:	39 c3                	cmp    %eax,%ebx
80101bd8:	0f 47 d8             	cmova  %eax,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101bdb:	8d 44 0a 5c          	lea    0x5c(%edx,%ecx,1),%eax
80101bdf:	53                   	push   %ebx
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101be0:	01 df                	add    %ebx,%edi
80101be2:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
80101be4:	50                   	push   %eax
80101be5:	ff 75 e0             	pushl  -0x20(%ebp)
80101be8:	e8 d3 2a 00 00       	call   801046c0 <memmove>
    brelse(bp);
80101bed:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101bf0:	89 14 24             	mov    %edx,(%esp)
80101bf3:	e8 e8 e5 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101bf8:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101bfb:	83 c4 10             	add    $0x10,%esp
80101bfe:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101c01:	77 9d                	ja     80101ba0 <readi+0x60>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101c03:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101c06:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c09:	5b                   	pop    %ebx
80101c0a:	5e                   	pop    %esi
80101c0b:	5f                   	pop    %edi
80101c0c:	5d                   	pop    %ebp
80101c0d:	c3                   	ret    
80101c0e:	66 90                	xchg   %ax,%ax
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101c10:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101c14:	66 83 f8 09          	cmp    $0x9,%ax
80101c18:	77 1e                	ja     80101c38 <readi+0xf8>
80101c1a:	8b 04 c5 00 19 11 80 	mov    -0x7feee700(,%eax,8),%eax
80101c21:	85 c0                	test   %eax,%eax
80101c23:	74 13                	je     80101c38 <readi+0xf8>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101c25:	89 7d 10             	mov    %edi,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
80101c28:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c2b:	5b                   	pop    %ebx
80101c2c:	5e                   	pop    %esi
80101c2d:	5f                   	pop    %edi
80101c2e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101c2f:	ff e0                	jmp    *%eax
80101c31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101c38:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c3d:	eb c7                	jmp    80101c06 <readi+0xc6>
80101c3f:	90                   	nop

80101c40 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101c40:	55                   	push   %ebp
80101c41:	89 e5                	mov    %esp,%ebp
80101c43:	57                   	push   %edi
80101c44:	56                   	push   %esi
80101c45:	53                   	push   %ebx
80101c46:	83 ec 1c             	sub    $0x1c,%esp
80101c49:	8b 45 08             	mov    0x8(%ebp),%eax
80101c4c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101c4f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101c52:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101c57:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101c5a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101c5d:	8b 75 10             	mov    0x10(%ebp),%esi
80101c60:	89 7d e0             	mov    %edi,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101c63:	0f 84 b7 00 00 00    	je     80101d20 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101c69:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c6c:	39 70 58             	cmp    %esi,0x58(%eax)
80101c6f:	0f 82 eb 00 00 00    	jb     80101d60 <writei+0x120>
80101c75:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101c78:	89 f8                	mov    %edi,%eax
80101c7a:	01 f0                	add    %esi,%eax
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101c7c:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101c81:	0f 87 d9 00 00 00    	ja     80101d60 <writei+0x120>
80101c87:	39 c6                	cmp    %eax,%esi
80101c89:	0f 87 d1 00 00 00    	ja     80101d60 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c8f:	85 ff                	test   %edi,%edi
80101c91:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101c98:	74 78                	je     80101d12 <writei+0xd2>
80101c9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ca0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101ca3:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101ca5:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101caa:	c1 ea 09             	shr    $0x9,%edx
80101cad:	89 f8                	mov    %edi,%eax
80101caf:	e8 1c f8 ff ff       	call   801014d0 <bmap>
80101cb4:	83 ec 08             	sub    $0x8,%esp
80101cb7:	50                   	push   %eax
80101cb8:	ff 37                	pushl  (%edi)
80101cba:	e8 11 e4 ff ff       	call   801000d0 <bread>
80101cbf:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101cc1:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101cc4:	2b 45 e4             	sub    -0x1c(%ebp),%eax
80101cc7:	89 f1                	mov    %esi,%ecx
80101cc9:	83 c4 0c             	add    $0xc,%esp
80101ccc:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101cd2:	29 cb                	sub    %ecx,%ebx
80101cd4:	39 c3                	cmp    %eax,%ebx
80101cd6:	0f 47 d8             	cmova  %eax,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101cd9:	8d 44 0f 5c          	lea    0x5c(%edi,%ecx,1),%eax
80101cdd:	53                   	push   %ebx
80101cde:	ff 75 dc             	pushl  -0x24(%ebp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ce1:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
80101ce3:	50                   	push   %eax
80101ce4:	e8 d7 29 00 00       	call   801046c0 <memmove>
    log_write(bp);
80101ce9:	89 3c 24             	mov    %edi,(%esp)
80101cec:	e8 2f 12 00 00       	call   80102f20 <log_write>
    brelse(bp);
80101cf1:	89 3c 24             	mov    %edi,(%esp)
80101cf4:	e8 e7 e4 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101cf9:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101cfc:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101cff:	83 c4 10             	add    $0x10,%esp
80101d02:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101d05:	39 55 e0             	cmp    %edx,-0x20(%ebp)
80101d08:	77 96                	ja     80101ca0 <writei+0x60>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80101d0a:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101d0d:	3b 70 58             	cmp    0x58(%eax),%esi
80101d10:	77 36                	ja     80101d48 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101d12:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101d15:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d18:	5b                   	pop    %ebx
80101d19:	5e                   	pop    %esi
80101d1a:	5f                   	pop    %edi
80101d1b:	5d                   	pop    %ebp
80101d1c:	c3                   	ret    
80101d1d:	8d 76 00             	lea    0x0(%esi),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101d20:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101d24:	66 83 f8 09          	cmp    $0x9,%ax
80101d28:	77 36                	ja     80101d60 <writei+0x120>
80101d2a:	8b 04 c5 04 19 11 80 	mov    -0x7feee6fc(,%eax,8),%eax
80101d31:	85 c0                	test   %eax,%eax
80101d33:	74 2b                	je     80101d60 <writei+0x120>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101d35:	89 7d 10             	mov    %edi,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101d38:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d3b:	5b                   	pop    %ebx
80101d3c:	5e                   	pop    %esi
80101d3d:	5f                   	pop    %edi
80101d3e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101d3f:	ff e0                	jmp    *%eax
80101d41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101d48:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101d4b:	83 ec 0c             	sub    $0xc,%esp
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101d4e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101d51:	50                   	push   %eax
80101d52:	e8 59 fa ff ff       	call   801017b0 <iupdate>
80101d57:	83 c4 10             	add    $0x10,%esp
80101d5a:	eb b6                	jmp    80101d12 <writei+0xd2>
80101d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101d60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101d65:	eb ae                	jmp    80101d15 <writei+0xd5>
80101d67:	89 f6                	mov    %esi,%esi
80101d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101d70 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101d70:	55                   	push   %ebp
80101d71:	89 e5                	mov    %esp,%ebp
80101d73:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101d76:	6a 0e                	push   $0xe
80101d78:	ff 75 0c             	pushl  0xc(%ebp)
80101d7b:	ff 75 08             	pushl  0x8(%ebp)
80101d7e:	e8 bd 29 00 00       	call   80104740 <strncmp>
}
80101d83:	c9                   	leave  
80101d84:	c3                   	ret    
80101d85:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101d90 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101d90:	55                   	push   %ebp
80101d91:	89 e5                	mov    %esp,%ebp
80101d93:	57                   	push   %edi
80101d94:	56                   	push   %esi
80101d95:	53                   	push   %ebx
80101d96:	83 ec 1c             	sub    $0x1c,%esp
80101d99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101d9c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101da1:	0f 85 80 00 00 00    	jne    80101e27 <dirlookup+0x97>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101da7:	8b 53 58             	mov    0x58(%ebx),%edx
80101daa:	31 ff                	xor    %edi,%edi
80101dac:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101daf:	85 d2                	test   %edx,%edx
80101db1:	75 0d                	jne    80101dc0 <dirlookup+0x30>
80101db3:	eb 5b                	jmp    80101e10 <dirlookup+0x80>
80101db5:	8d 76 00             	lea    0x0(%esi),%esi
80101db8:	83 c7 10             	add    $0x10,%edi
80101dbb:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101dbe:	76 50                	jbe    80101e10 <dirlookup+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101dc0:	6a 10                	push   $0x10
80101dc2:	57                   	push   %edi
80101dc3:	56                   	push   %esi
80101dc4:	53                   	push   %ebx
80101dc5:	e8 76 fd ff ff       	call   80101b40 <readi>
80101dca:	83 c4 10             	add    $0x10,%esp
80101dcd:	83 f8 10             	cmp    $0x10,%eax
80101dd0:	75 48                	jne    80101e1a <dirlookup+0x8a>
      panic("dirlookup read");
    if(de.inum == 0)
80101dd2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101dd7:	74 df                	je     80101db8 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
80101dd9:	8d 45 da             	lea    -0x26(%ebp),%eax
80101ddc:	83 ec 04             	sub    $0x4,%esp
80101ddf:	6a 0e                	push   $0xe
80101de1:	50                   	push   %eax
80101de2:	ff 75 0c             	pushl  0xc(%ebp)
80101de5:	e8 56 29 00 00       	call   80104740 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80101dea:	83 c4 10             	add    $0x10,%esp
80101ded:	85 c0                	test   %eax,%eax
80101def:	75 c7                	jne    80101db8 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101df1:	8b 45 10             	mov    0x10(%ebp),%eax
80101df4:	85 c0                	test   %eax,%eax
80101df6:	74 05                	je     80101dfd <dirlookup+0x6d>
        *poff = off;
80101df8:	8b 45 10             	mov    0x10(%ebp),%eax
80101dfb:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
      return iget(dp->dev, inum);
80101dfd:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80101e01:	8b 03                	mov    (%ebx),%eax
80101e03:	e8 f8 f5 ff ff       	call   80101400 <iget>
    }
  }

  return 0;
}
80101e08:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e0b:	5b                   	pop    %ebx
80101e0c:	5e                   	pop    %esi
80101e0d:	5f                   	pop    %edi
80101e0e:	5d                   	pop    %ebp
80101e0f:	c3                   	ret    
80101e10:	8d 65 f4             	lea    -0xc(%ebp),%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101e13:	31 c0                	xor    %eax,%eax
}
80101e15:	5b                   	pop    %ebx
80101e16:	5e                   	pop    %esi
80101e17:	5f                   	pop    %edi
80101e18:	5d                   	pop    %ebp
80101e19:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
80101e1a:	83 ec 0c             	sub    $0xc,%esp
80101e1d:	68 39 73 10 80       	push   $0x80107339
80101e22:	e8 49 e5 ff ff       	call   80100370 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101e27:	83 ec 0c             	sub    $0xc,%esp
80101e2a:	68 27 73 10 80       	push   $0x80107327
80101e2f:	e8 3c e5 ff ff       	call   80100370 <panic>
80101e34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101e3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101e40 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101e40:	55                   	push   %ebp
80101e41:	89 e5                	mov    %esp,%ebp
80101e43:	57                   	push   %edi
80101e44:	56                   	push   %esi
80101e45:	53                   	push   %ebx
80101e46:	89 cf                	mov    %ecx,%edi
80101e48:	89 c3                	mov    %eax,%ebx
80101e4a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101e4d:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101e50:	89 55 e0             	mov    %edx,-0x20(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101e53:	0f 84 53 01 00 00    	je     80101fac <namex+0x16c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101e59:	e8 12 1b 00 00       	call   80103970 <myproc>
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101e5e:	83 ec 0c             	sub    $0xc,%esp
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101e61:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101e64:	68 80 19 11 80       	push   $0x80111980
80101e69:	e8 32 26 00 00       	call   801044a0 <acquire>
  ip->ref++;
80101e6e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101e72:	c7 04 24 80 19 11 80 	movl   $0x80111980,(%esp)
80101e79:	e8 42 27 00 00       	call   801045c0 <release>
80101e7e:	83 c4 10             	add    $0x10,%esp
80101e81:	eb 08                	jmp    80101e8b <namex+0x4b>
80101e83:	90                   	nop
80101e84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101e88:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101e8b:	0f b6 03             	movzbl (%ebx),%eax
80101e8e:	3c 2f                	cmp    $0x2f,%al
80101e90:	74 f6                	je     80101e88 <namex+0x48>
    path++;
  if(*path == 0)
80101e92:	84 c0                	test   %al,%al
80101e94:	0f 84 e3 00 00 00    	je     80101f7d <namex+0x13d>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101e9a:	0f b6 03             	movzbl (%ebx),%eax
80101e9d:	89 da                	mov    %ebx,%edx
80101e9f:	84 c0                	test   %al,%al
80101ea1:	0f 84 ac 00 00 00    	je     80101f53 <namex+0x113>
80101ea7:	3c 2f                	cmp    $0x2f,%al
80101ea9:	75 09                	jne    80101eb4 <namex+0x74>
80101eab:	e9 a3 00 00 00       	jmp    80101f53 <namex+0x113>
80101eb0:	84 c0                	test   %al,%al
80101eb2:	74 0a                	je     80101ebe <namex+0x7e>
    path++;
80101eb4:	83 c2 01             	add    $0x1,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101eb7:	0f b6 02             	movzbl (%edx),%eax
80101eba:	3c 2f                	cmp    $0x2f,%al
80101ebc:	75 f2                	jne    80101eb0 <namex+0x70>
80101ebe:	89 d1                	mov    %edx,%ecx
80101ec0:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101ec2:	83 f9 0d             	cmp    $0xd,%ecx
80101ec5:	0f 8e 8d 00 00 00    	jle    80101f58 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101ecb:	83 ec 04             	sub    $0x4,%esp
80101ece:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101ed1:	6a 0e                	push   $0xe
80101ed3:	53                   	push   %ebx
80101ed4:	57                   	push   %edi
80101ed5:	e8 e6 27 00 00       	call   801046c0 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101eda:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
80101edd:	83 c4 10             	add    $0x10,%esp
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101ee0:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101ee2:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101ee5:	75 11                	jne    80101ef8 <namex+0xb8>
80101ee7:	89 f6                	mov    %esi,%esi
80101ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101ef0:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101ef3:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101ef6:	74 f8                	je     80101ef0 <namex+0xb0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101ef8:	83 ec 0c             	sub    $0xc,%esp
80101efb:	56                   	push   %esi
80101efc:	e8 5f f9 ff ff       	call   80101860 <ilock>
    if(ip->type != T_DIR){
80101f01:	83 c4 10             	add    $0x10,%esp
80101f04:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101f09:	0f 85 7f 00 00 00    	jne    80101f8e <namex+0x14e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101f0f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101f12:	85 d2                	test   %edx,%edx
80101f14:	74 09                	je     80101f1f <namex+0xdf>
80101f16:	80 3b 00             	cmpb   $0x0,(%ebx)
80101f19:	0f 84 a3 00 00 00    	je     80101fc2 <namex+0x182>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101f1f:	83 ec 04             	sub    $0x4,%esp
80101f22:	6a 00                	push   $0x0
80101f24:	57                   	push   %edi
80101f25:	56                   	push   %esi
80101f26:	e8 65 fe ff ff       	call   80101d90 <dirlookup>
80101f2b:	83 c4 10             	add    $0x10,%esp
80101f2e:	85 c0                	test   %eax,%eax
80101f30:	74 5c                	je     80101f8e <namex+0x14e>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101f32:	83 ec 0c             	sub    $0xc,%esp
80101f35:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101f38:	56                   	push   %esi
80101f39:	e8 02 fa ff ff       	call   80101940 <iunlock>
  iput(ip);
80101f3e:	89 34 24             	mov    %esi,(%esp)
80101f41:	e8 4a fa ff ff       	call   80101990 <iput>
80101f46:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101f49:	83 c4 10             	add    $0x10,%esp
80101f4c:	89 c6                	mov    %eax,%esi
80101f4e:	e9 38 ff ff ff       	jmp    80101e8b <namex+0x4b>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101f53:	31 c9                	xor    %ecx,%ecx
80101f55:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101f58:	83 ec 04             	sub    $0x4,%esp
80101f5b:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101f5e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101f61:	51                   	push   %ecx
80101f62:	53                   	push   %ebx
80101f63:	57                   	push   %edi
80101f64:	e8 57 27 00 00       	call   801046c0 <memmove>
    name[len] = 0;
80101f69:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101f6c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101f6f:	83 c4 10             	add    $0x10,%esp
80101f72:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101f76:	89 d3                	mov    %edx,%ebx
80101f78:	e9 65 ff ff ff       	jmp    80101ee2 <namex+0xa2>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101f7d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101f80:	85 c0                	test   %eax,%eax
80101f82:	75 54                	jne    80101fd8 <namex+0x198>
80101f84:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101f86:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f89:	5b                   	pop    %ebx
80101f8a:	5e                   	pop    %esi
80101f8b:	5f                   	pop    %edi
80101f8c:	5d                   	pop    %ebp
80101f8d:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101f8e:	83 ec 0c             	sub    $0xc,%esp
80101f91:	56                   	push   %esi
80101f92:	e8 a9 f9 ff ff       	call   80101940 <iunlock>
  iput(ip);
80101f97:	89 34 24             	mov    %esi,(%esp)
80101f9a:	e8 f1 f9 ff ff       	call   80101990 <iput>
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101f9f:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101fa2:	8d 65 f4             	lea    -0xc(%ebp),%esp
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101fa5:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101fa7:	5b                   	pop    %ebx
80101fa8:	5e                   	pop    %esi
80101fa9:	5f                   	pop    %edi
80101faa:	5d                   	pop    %ebp
80101fab:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101fac:	ba 01 00 00 00       	mov    $0x1,%edx
80101fb1:	b8 01 00 00 00       	mov    $0x1,%eax
80101fb6:	e8 45 f4 ff ff       	call   80101400 <iget>
80101fbb:	89 c6                	mov    %eax,%esi
80101fbd:	e9 c9 fe ff ff       	jmp    80101e8b <namex+0x4b>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101fc2:	83 ec 0c             	sub    $0xc,%esp
80101fc5:	56                   	push   %esi
80101fc6:	e8 75 f9 ff ff       	call   80101940 <iunlock>
      return ip;
80101fcb:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101fce:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
      return ip;
80101fd1:	89 f0                	mov    %esi,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101fd3:	5b                   	pop    %ebx
80101fd4:	5e                   	pop    %esi
80101fd5:	5f                   	pop    %edi
80101fd6:	5d                   	pop    %ebp
80101fd7:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101fd8:	83 ec 0c             	sub    $0xc,%esp
80101fdb:	56                   	push   %esi
80101fdc:	e8 af f9 ff ff       	call   80101990 <iput>
    return 0;
80101fe1:	83 c4 10             	add    $0x10,%esp
80101fe4:	31 c0                	xor    %eax,%eax
80101fe6:	eb 9e                	jmp    80101f86 <namex+0x146>
80101fe8:	90                   	nop
80101fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101ff0 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101ff0:	55                   	push   %ebp
80101ff1:	89 e5                	mov    %esp,%ebp
80101ff3:	57                   	push   %edi
80101ff4:	56                   	push   %esi
80101ff5:	53                   	push   %ebx
80101ff6:	83 ec 20             	sub    $0x20,%esp
80101ff9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101ffc:	6a 00                	push   $0x0
80101ffe:	ff 75 0c             	pushl  0xc(%ebp)
80102001:	53                   	push   %ebx
80102002:	e8 89 fd ff ff       	call   80101d90 <dirlookup>
80102007:	83 c4 10             	add    $0x10,%esp
8010200a:	85 c0                	test   %eax,%eax
8010200c:	75 67                	jne    80102075 <dirlink+0x85>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
8010200e:	8b 7b 58             	mov    0x58(%ebx),%edi
80102011:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102014:	85 ff                	test   %edi,%edi
80102016:	74 29                	je     80102041 <dirlink+0x51>
80102018:	31 ff                	xor    %edi,%edi
8010201a:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010201d:	eb 09                	jmp    80102028 <dirlink+0x38>
8010201f:	90                   	nop
80102020:	83 c7 10             	add    $0x10,%edi
80102023:	39 7b 58             	cmp    %edi,0x58(%ebx)
80102026:	76 19                	jbe    80102041 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102028:	6a 10                	push   $0x10
8010202a:	57                   	push   %edi
8010202b:	56                   	push   %esi
8010202c:	53                   	push   %ebx
8010202d:	e8 0e fb ff ff       	call   80101b40 <readi>
80102032:	83 c4 10             	add    $0x10,%esp
80102035:	83 f8 10             	cmp    $0x10,%eax
80102038:	75 4e                	jne    80102088 <dirlink+0x98>
      panic("dirlink read");
    if(de.inum == 0)
8010203a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010203f:	75 df                	jne    80102020 <dirlink+0x30>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80102041:	8d 45 da             	lea    -0x26(%ebp),%eax
80102044:	83 ec 04             	sub    $0x4,%esp
80102047:	6a 0e                	push   $0xe
80102049:	ff 75 0c             	pushl  0xc(%ebp)
8010204c:	50                   	push   %eax
8010204d:	e8 5e 27 00 00       	call   801047b0 <strncpy>
  de.inum = inum;
80102052:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102055:	6a 10                	push   $0x10
80102057:	57                   	push   %edi
80102058:	56                   	push   %esi
80102059:	53                   	push   %ebx
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
8010205a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010205e:	e8 dd fb ff ff       	call   80101c40 <writei>
80102063:	83 c4 20             	add    $0x20,%esp
80102066:	83 f8 10             	cmp    $0x10,%eax
80102069:	75 2a                	jne    80102095 <dirlink+0xa5>
    panic("dirlink");

  return 0;
8010206b:	31 c0                	xor    %eax,%eax
}
8010206d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102070:	5b                   	pop    %ebx
80102071:	5e                   	pop    %esi
80102072:	5f                   	pop    %edi
80102073:	5d                   	pop    %ebp
80102074:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80102075:	83 ec 0c             	sub    $0xc,%esp
80102078:	50                   	push   %eax
80102079:	e8 12 f9 ff ff       	call   80101990 <iput>
    return -1;
8010207e:	83 c4 10             	add    $0x10,%esp
80102081:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102086:	eb e5                	jmp    8010206d <dirlink+0x7d>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80102088:	83 ec 0c             	sub    $0xc,%esp
8010208b:	68 48 73 10 80       	push   $0x80107348
80102090:	e8 db e2 ff ff       	call   80100370 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80102095:	83 ec 0c             	sub    $0xc,%esp
80102098:	68 4e 79 10 80       	push   $0x8010794e
8010209d:	e8 ce e2 ff ff       	call   80100370 <panic>
801020a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801020b0 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
801020b0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
801020b1:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
801020b3:	89 e5                	mov    %esp,%ebp
801020b5:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
801020b8:	8b 45 08             	mov    0x8(%ebp),%eax
801020bb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
801020be:	e8 7d fd ff ff       	call   80101e40 <namex>
}
801020c3:	c9                   	leave  
801020c4:	c3                   	ret    
801020c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801020c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801020d0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801020d0:	55                   	push   %ebp
  return namex(path, 1, name);
801020d1:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
801020d6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
801020d8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801020db:	8b 45 08             	mov    0x8(%ebp),%eax
}
801020de:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
801020df:	e9 5c fd ff ff       	jmp    80101e40 <namex>
801020e4:	66 90                	xchg   %ax,%ax
801020e6:	66 90                	xchg   %ax,%ax
801020e8:	66 90                	xchg   %ax,%ax
801020ea:	66 90                	xchg   %ax,%ax
801020ec:	66 90                	xchg   %ax,%ax
801020ee:	66 90                	xchg   %ax,%ax

801020f0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801020f0:	55                   	push   %ebp
  if(b == 0)
801020f1:	85 c0                	test   %eax,%eax
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801020f3:	89 e5                	mov    %esp,%ebp
801020f5:	56                   	push   %esi
801020f6:	53                   	push   %ebx
  if(b == 0)
801020f7:	0f 84 ad 00 00 00    	je     801021aa <idestart+0xba>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801020fd:	8b 58 08             	mov    0x8(%eax),%ebx
80102100:	89 c1                	mov    %eax,%ecx
80102102:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80102108:	0f 87 8f 00 00 00    	ja     8010219d <idestart+0xad>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010210e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102113:	90                   	nop
80102114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102118:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102119:	83 e0 c0             	and    $0xffffffc0,%eax
8010211c:	3c 40                	cmp    $0x40,%al
8010211e:	75 f8                	jne    80102118 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102120:	31 f6                	xor    %esi,%esi
80102122:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102127:	89 f0                	mov    %esi,%eax
80102129:	ee                   	out    %al,(%dx)
8010212a:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010212f:	b8 01 00 00 00       	mov    $0x1,%eax
80102134:	ee                   	out    %al,(%dx)
80102135:	ba f3 01 00 00       	mov    $0x1f3,%edx
8010213a:	89 d8                	mov    %ebx,%eax
8010213c:	ee                   	out    %al,(%dx)
8010213d:	89 d8                	mov    %ebx,%eax
8010213f:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102144:	c1 f8 08             	sar    $0x8,%eax
80102147:	ee                   	out    %al,(%dx)
80102148:	ba f5 01 00 00       	mov    $0x1f5,%edx
8010214d:	89 f0                	mov    %esi,%eax
8010214f:	ee                   	out    %al,(%dx)
80102150:	0f b6 41 04          	movzbl 0x4(%ecx),%eax
80102154:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102159:	83 e0 01             	and    $0x1,%eax
8010215c:	c1 e0 04             	shl    $0x4,%eax
8010215f:	83 c8 e0             	or     $0xffffffe0,%eax
80102162:	ee                   	out    %al,(%dx)
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
80102163:	f6 01 04             	testb  $0x4,(%ecx)
80102166:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010216b:	75 13                	jne    80102180 <idestart+0x90>
8010216d:	b8 20 00 00 00       	mov    $0x20,%eax
80102172:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102173:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102176:	5b                   	pop    %ebx
80102177:	5e                   	pop    %esi
80102178:	5d                   	pop    %ebp
80102179:	c3                   	ret    
8010217a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102180:	b8 30 00 00 00       	mov    $0x30,%eax
80102185:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80102186:	ba f0 01 00 00       	mov    $0x1f0,%edx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
8010218b:	8d 71 5c             	lea    0x5c(%ecx),%esi
8010218e:	b9 80 00 00 00       	mov    $0x80,%ecx
80102193:	fc                   	cld    
80102194:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102196:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102199:	5b                   	pop    %ebx
8010219a:	5e                   	pop    %esi
8010219b:	5d                   	pop    %ebp
8010219c:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
8010219d:	83 ec 0c             	sub    $0xc,%esp
801021a0:	68 b4 73 10 80       	push   $0x801073b4
801021a5:	e8 c6 e1 ff ff       	call   80100370 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
801021aa:	83 ec 0c             	sub    $0xc,%esp
801021ad:	68 ab 73 10 80       	push   $0x801073ab
801021b2:	e8 b9 e1 ff ff       	call   80100370 <panic>
801021b7:	89 f6                	mov    %esi,%esi
801021b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801021c0 <ideinit>:
  return 0;
}

void
ideinit(void)
{
801021c0:	55                   	push   %ebp
801021c1:	89 e5                	mov    %esp,%ebp
801021c3:	83 ec 10             	sub    $0x10,%esp
  int i;

  initlock(&idelock, "ide");
801021c6:	68 c6 73 10 80       	push   $0x801073c6
801021cb:	68 20 b5 10 80       	push   $0x8010b520
801021d0:	e8 cb 21 00 00       	call   801043a0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801021d5:	58                   	pop    %eax
801021d6:	a1 a0 3c 11 80       	mov    0x80113ca0,%eax
801021db:	5a                   	pop    %edx
801021dc:	83 e8 01             	sub    $0x1,%eax
801021df:	50                   	push   %eax
801021e0:	6a 0e                	push   $0xe
801021e2:	e8 a9 02 00 00       	call   80102490 <ioapicenable>
801021e7:	83 c4 10             	add    $0x10,%esp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021ea:	ba f7 01 00 00       	mov    $0x1f7,%edx
801021ef:	90                   	nop
801021f0:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021f1:	83 e0 c0             	and    $0xffffffc0,%eax
801021f4:	3c 40                	cmp    $0x40,%al
801021f6:	75 f8                	jne    801021f0 <ideinit+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801021f8:	ba f6 01 00 00       	mov    $0x1f6,%edx
801021fd:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102202:	ee                   	out    %al,(%dx)
80102203:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102208:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010220d:	eb 06                	jmp    80102215 <ideinit+0x55>
8010220f:	90                   	nop
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102210:	83 e9 01             	sub    $0x1,%ecx
80102213:	74 0f                	je     80102224 <ideinit+0x64>
80102215:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102216:	84 c0                	test   %al,%al
80102218:	74 f6                	je     80102210 <ideinit+0x50>
      havedisk1 = 1;
8010221a:	c7 05 00 b5 10 80 01 	movl   $0x1,0x8010b500
80102221:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102224:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102229:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
8010222e:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
8010222f:	c9                   	leave  
80102230:	c3                   	ret    
80102231:	eb 0d                	jmp    80102240 <ideintr>
80102233:	90                   	nop
80102234:	90                   	nop
80102235:	90                   	nop
80102236:	90                   	nop
80102237:	90                   	nop
80102238:	90                   	nop
80102239:	90                   	nop
8010223a:	90                   	nop
8010223b:	90                   	nop
8010223c:	90                   	nop
8010223d:	90                   	nop
8010223e:	90                   	nop
8010223f:	90                   	nop

80102240 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
80102240:	55                   	push   %ebp
80102241:	89 e5                	mov    %esp,%ebp
80102243:	57                   	push   %edi
80102244:	56                   	push   %esi
80102245:	53                   	push   %ebx
80102246:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102249:	68 20 b5 10 80       	push   $0x8010b520
8010224e:	e8 4d 22 00 00       	call   801044a0 <acquire>

  if((b = idequeue) == 0){
80102253:	8b 1d 04 b5 10 80    	mov    0x8010b504,%ebx
80102259:	83 c4 10             	add    $0x10,%esp
8010225c:	85 db                	test   %ebx,%ebx
8010225e:	74 34                	je     80102294 <ideintr+0x54>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102260:	8b 43 58             	mov    0x58(%ebx),%eax
80102263:	a3 04 b5 10 80       	mov    %eax,0x8010b504

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102268:	8b 33                	mov    (%ebx),%esi
8010226a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102270:	74 3e                	je     801022b0 <ideintr+0x70>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102272:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102275:	83 ec 0c             	sub    $0xc,%esp
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102278:	83 ce 02             	or     $0x2,%esi
8010227b:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010227d:	53                   	push   %ebx
8010227e:	e8 5d 1e 00 00       	call   801040e0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102283:	a1 04 b5 10 80       	mov    0x8010b504,%eax
80102288:	83 c4 10             	add    $0x10,%esp
8010228b:	85 c0                	test   %eax,%eax
8010228d:	74 05                	je     80102294 <ideintr+0x54>
    idestart(idequeue);
8010228f:	e8 5c fe ff ff       	call   801020f0 <idestart>

  // First queued buffer is the active request.
  acquire(&idelock);

  if((b = idequeue) == 0){
    release(&idelock);
80102294:	83 ec 0c             	sub    $0xc,%esp
80102297:	68 20 b5 10 80       	push   $0x8010b520
8010229c:	e8 1f 23 00 00       	call   801045c0 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
801022a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022a4:	5b                   	pop    %ebx
801022a5:	5e                   	pop    %esi
801022a6:	5f                   	pop    %edi
801022a7:	5d                   	pop    %ebp
801022a8:	c3                   	ret    
801022a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801022b0:	ba f7 01 00 00       	mov    $0x1f7,%edx
801022b5:	8d 76 00             	lea    0x0(%esi),%esi
801022b8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801022b9:	89 c1                	mov    %eax,%ecx
801022bb:	83 e1 c0             	and    $0xffffffc0,%ecx
801022be:	80 f9 40             	cmp    $0x40,%cl
801022c1:	75 f5                	jne    801022b8 <ideintr+0x78>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801022c3:	a8 21                	test   $0x21,%al
801022c5:	75 ab                	jne    80102272 <ideintr+0x32>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
801022c7:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
801022ca:	b9 80 00 00 00       	mov    $0x80,%ecx
801022cf:	ba f0 01 00 00       	mov    $0x1f0,%edx
801022d4:	fc                   	cld    
801022d5:	f3 6d                	rep insl (%dx),%es:(%edi)
801022d7:	8b 33                	mov    (%ebx),%esi
801022d9:	eb 97                	jmp    80102272 <ideintr+0x32>
801022db:	90                   	nop
801022dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801022e0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801022e0:	55                   	push   %ebp
801022e1:	89 e5                	mov    %esp,%ebp
801022e3:	53                   	push   %ebx
801022e4:	83 ec 10             	sub    $0x10,%esp
801022e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801022ea:	8d 43 0c             	lea    0xc(%ebx),%eax
801022ed:	50                   	push   %eax
801022ee:	e8 7d 20 00 00       	call   80104370 <holdingsleep>
801022f3:	83 c4 10             	add    $0x10,%esp
801022f6:	85 c0                	test   %eax,%eax
801022f8:	0f 84 ad 00 00 00    	je     801023ab <iderw+0xcb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801022fe:	8b 03                	mov    (%ebx),%eax
80102300:	83 e0 06             	and    $0x6,%eax
80102303:	83 f8 02             	cmp    $0x2,%eax
80102306:	0f 84 b9 00 00 00    	je     801023c5 <iderw+0xe5>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010230c:	8b 53 04             	mov    0x4(%ebx),%edx
8010230f:	85 d2                	test   %edx,%edx
80102311:	74 0d                	je     80102320 <iderw+0x40>
80102313:	a1 00 b5 10 80       	mov    0x8010b500,%eax
80102318:	85 c0                	test   %eax,%eax
8010231a:	0f 84 98 00 00 00    	je     801023b8 <iderw+0xd8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102320:	83 ec 0c             	sub    $0xc,%esp
80102323:	68 20 b5 10 80       	push   $0x8010b520
80102328:	e8 73 21 00 00       	call   801044a0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010232d:	8b 15 04 b5 10 80    	mov    0x8010b504,%edx
80102333:	83 c4 10             	add    $0x10,%esp
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
80102336:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010233d:	85 d2                	test   %edx,%edx
8010233f:	75 09                	jne    8010234a <iderw+0x6a>
80102341:	eb 58                	jmp    8010239b <iderw+0xbb>
80102343:	90                   	nop
80102344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102348:	89 c2                	mov    %eax,%edx
8010234a:	8b 42 58             	mov    0x58(%edx),%eax
8010234d:	85 c0                	test   %eax,%eax
8010234f:	75 f7                	jne    80102348 <iderw+0x68>
80102351:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102354:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102356:	3b 1d 04 b5 10 80    	cmp    0x8010b504,%ebx
8010235c:	74 44                	je     801023a2 <iderw+0xc2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010235e:	8b 03                	mov    (%ebx),%eax
80102360:	83 e0 06             	and    $0x6,%eax
80102363:	83 f8 02             	cmp    $0x2,%eax
80102366:	74 23                	je     8010238b <iderw+0xab>
80102368:	90                   	nop
80102369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102370:	83 ec 08             	sub    $0x8,%esp
80102373:	68 20 b5 10 80       	push   $0x8010b520
80102378:	53                   	push   %ebx
80102379:	e8 b2 1b 00 00       	call   80103f30 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010237e:	8b 03                	mov    (%ebx),%eax
80102380:	83 c4 10             	add    $0x10,%esp
80102383:	83 e0 06             	and    $0x6,%eax
80102386:	83 f8 02             	cmp    $0x2,%eax
80102389:	75 e5                	jne    80102370 <iderw+0x90>
    sleep(b, &idelock);
  }


  release(&idelock);
8010238b:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
}
80102392:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102395:	c9                   	leave  
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }


  release(&idelock);
80102396:	e9 25 22 00 00       	jmp    801045c0 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010239b:	ba 04 b5 10 80       	mov    $0x8010b504,%edx
801023a0:	eb b2                	jmp    80102354 <iderw+0x74>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
801023a2:	89 d8                	mov    %ebx,%eax
801023a4:	e8 47 fd ff ff       	call   801020f0 <idestart>
801023a9:	eb b3                	jmp    8010235e <iderw+0x7e>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
801023ab:	83 ec 0c             	sub    $0xc,%esp
801023ae:	68 ca 73 10 80       	push   $0x801073ca
801023b3:	e8 b8 df ff ff       	call   80100370 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
801023b8:	83 ec 0c             	sub    $0xc,%esp
801023bb:	68 f5 73 10 80       	push   $0x801073f5
801023c0:	e8 ab df ff ff       	call   80100370 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
801023c5:	83 ec 0c             	sub    $0xc,%esp
801023c8:	68 e0 73 10 80       	push   $0x801073e0
801023cd:	e8 9e df ff ff       	call   80100370 <panic>
801023d2:	66 90                	xchg   %ax,%ax
801023d4:	66 90                	xchg   %ax,%ax
801023d6:	66 90                	xchg   %ax,%ax
801023d8:	66 90                	xchg   %ax,%ax
801023da:	66 90                	xchg   %ax,%ax
801023dc:	66 90                	xchg   %ax,%ax
801023de:	66 90                	xchg   %ax,%ax

801023e0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801023e0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801023e1:	c7 05 d4 35 11 80 00 	movl   $0xfec00000,0x801135d4
801023e8:	00 c0 fe 
  ioapic->data = data;
}

void
ioapicinit(void)
{
801023eb:	89 e5                	mov    %esp,%ebp
801023ed:	56                   	push   %esi
801023ee:	53                   	push   %ebx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
801023ef:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801023f6:	00 00 00 
  return ioapic->data;
801023f9:	8b 15 d4 35 11 80    	mov    0x801135d4,%edx
801023ff:	8b 72 10             	mov    0x10(%edx),%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80102402:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102408:	8b 0d d4 35 11 80    	mov    0x801135d4,%ecx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010240e:	0f b6 15 00 37 11 80 	movzbl 0x80113700,%edx
ioapicinit(void)
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102415:	89 f0                	mov    %esi,%eax
80102417:	c1 e8 10             	shr    $0x10,%eax
8010241a:	0f b6 f0             	movzbl %al,%esi

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
8010241d:	8b 41 10             	mov    0x10(%ecx),%eax
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102420:	c1 e8 18             	shr    $0x18,%eax
80102423:	39 d0                	cmp    %edx,%eax
80102425:	74 16                	je     8010243d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102427:	83 ec 0c             	sub    $0xc,%esp
8010242a:	68 14 74 10 80       	push   $0x80107414
8010242f:	e8 4c e2 ff ff       	call   80100680 <cprintf>
80102434:	8b 0d d4 35 11 80    	mov    0x801135d4,%ecx
8010243a:	83 c4 10             	add    $0x10,%esp
8010243d:	83 c6 21             	add    $0x21,%esi
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102440:	ba 10 00 00 00       	mov    $0x10,%edx
80102445:	b8 20 00 00 00       	mov    $0x20,%eax
8010244a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102450:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102452:	8b 0d d4 35 11 80    	mov    0x801135d4,%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102458:	89 c3                	mov    %eax,%ebx
8010245a:	81 cb 00 00 01 00    	or     $0x10000,%ebx
80102460:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102463:	89 59 10             	mov    %ebx,0x10(%ecx)
80102466:	8d 5a 01             	lea    0x1(%edx),%ebx
80102469:	83 c2 02             	add    $0x2,%edx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010246c:	39 f0                	cmp    %esi,%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010246e:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
80102470:	8b 0d d4 35 11 80    	mov    0x801135d4,%ecx
80102476:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010247d:	75 d1                	jne    80102450 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010247f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102482:	5b                   	pop    %ebx
80102483:	5e                   	pop    %esi
80102484:	5d                   	pop    %ebp
80102485:	c3                   	ret    
80102486:	8d 76 00             	lea    0x0(%esi),%esi
80102489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102490 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102490:	55                   	push   %ebp
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102491:	8b 0d d4 35 11 80    	mov    0x801135d4,%ecx
  }
}

void
ioapicenable(int irq, int cpunum)
{
80102497:	89 e5                	mov    %esp,%ebp
80102499:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010249c:	8d 50 20             	lea    0x20(%eax),%edx
8010249f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801024a3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801024a5:	8b 0d d4 35 11 80    	mov    0x801135d4,%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801024ab:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801024ae:	89 51 10             	mov    %edx,0x10(%ecx)
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801024b1:	8b 55 0c             	mov    0xc(%ebp),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801024b4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801024b6:	a1 d4 35 11 80       	mov    0x801135d4,%eax
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801024bb:	c1 e2 18             	shl    $0x18,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801024be:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
801024c1:	5d                   	pop    %ebp
801024c2:	c3                   	ret    
801024c3:	66 90                	xchg   %ax,%ax
801024c5:	66 90                	xchg   %ax,%ax
801024c7:	66 90                	xchg   %ax,%ax
801024c9:	66 90                	xchg   %ax,%ax
801024cb:	66 90                	xchg   %ax,%ax
801024cd:	66 90                	xchg   %ax,%ax
801024cf:	90                   	nop

801024d0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801024d0:	55                   	push   %ebp
801024d1:	89 e5                	mov    %esp,%ebp
801024d3:	53                   	push   %ebx
801024d4:	83 ec 04             	sub    $0x4,%esp
801024d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801024da:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801024e0:	75 70                	jne    80102552 <kfree+0x82>
801024e2:	81 fb 48 64 11 80    	cmp    $0x80116448,%ebx
801024e8:	72 68                	jb     80102552 <kfree+0x82>
801024ea:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801024f0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801024f5:	77 5b                	ja     80102552 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801024f7:	83 ec 04             	sub    $0x4,%esp
801024fa:	68 00 10 00 00       	push   $0x1000
801024ff:	6a 01                	push   $0x1
80102501:	53                   	push   %ebx
80102502:	e8 09 21 00 00       	call   80104610 <memset>

  if(kmem.use_lock)
80102507:	8b 15 14 36 11 80    	mov    0x80113614,%edx
8010250d:	83 c4 10             	add    $0x10,%esp
80102510:	85 d2                	test   %edx,%edx
80102512:	75 2c                	jne    80102540 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102514:	a1 18 36 11 80       	mov    0x80113618,%eax
80102519:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010251b:	a1 14 36 11 80       	mov    0x80113614,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
80102520:	89 1d 18 36 11 80    	mov    %ebx,0x80113618
  if(kmem.use_lock)
80102526:	85 c0                	test   %eax,%eax
80102528:	75 06                	jne    80102530 <kfree+0x60>
    release(&kmem.lock);
}
8010252a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010252d:	c9                   	leave  
8010252e:	c3                   	ret    
8010252f:	90                   	nop
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102530:	c7 45 08 e0 35 11 80 	movl   $0x801135e0,0x8(%ebp)
}
80102537:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010253a:	c9                   	leave  
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
8010253b:	e9 80 20 00 00       	jmp    801045c0 <release>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102540:	83 ec 0c             	sub    $0xc,%esp
80102543:	68 e0 35 11 80       	push   $0x801135e0
80102548:	e8 53 1f 00 00       	call   801044a0 <acquire>
8010254d:	83 c4 10             	add    $0x10,%esp
80102550:	eb c2                	jmp    80102514 <kfree+0x44>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
80102552:	83 ec 0c             	sub    $0xc,%esp
80102555:	68 46 74 10 80       	push   $0x80107446
8010255a:	e8 11 de ff ff       	call   80100370 <panic>
8010255f:	90                   	nop

80102560 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102560:	55                   	push   %ebp
80102561:	89 e5                	mov    %esp,%ebp
80102563:	56                   	push   %esi
80102564:	53                   	push   %ebx
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102565:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102568:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010256b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102571:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102577:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010257d:	39 de                	cmp    %ebx,%esi
8010257f:	72 23                	jb     801025a4 <freerange+0x44>
80102581:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102588:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010258e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102591:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102597:	50                   	push   %eax
80102598:	e8 33 ff ff ff       	call   801024d0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010259d:	83 c4 10             	add    $0x10,%esp
801025a0:	39 f3                	cmp    %esi,%ebx
801025a2:	76 e4                	jbe    80102588 <freerange+0x28>
    kfree(p);
}
801025a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025a7:	5b                   	pop    %ebx
801025a8:	5e                   	pop    %esi
801025a9:	5d                   	pop    %ebp
801025aa:	c3                   	ret    
801025ab:	90                   	nop
801025ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801025b0 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
801025b0:	55                   	push   %ebp
801025b1:	89 e5                	mov    %esp,%ebp
801025b3:	56                   	push   %esi
801025b4:	53                   	push   %ebx
801025b5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801025b8:	83 ec 08             	sub    $0x8,%esp
801025bb:	68 4c 74 10 80       	push   $0x8010744c
801025c0:	68 e0 35 11 80       	push   $0x801135e0
801025c5:	e8 d6 1d 00 00       	call   801043a0 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801025ca:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025cd:	83 c4 10             	add    $0x10,%esp
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
801025d0:	c7 05 14 36 11 80 00 	movl   $0x0,0x80113614
801025d7:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801025da:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801025e0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025e6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801025ec:	39 de                	cmp    %ebx,%esi
801025ee:	72 1c                	jb     8010260c <kinit1+0x5c>
    kfree(p);
801025f0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801025f6:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025f9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801025ff:	50                   	push   %eax
80102600:	e8 cb fe ff ff       	call   801024d0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102605:	83 c4 10             	add    $0x10,%esp
80102608:	39 de                	cmp    %ebx,%esi
8010260a:	73 e4                	jae    801025f0 <kinit1+0x40>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
8010260c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010260f:	5b                   	pop    %ebx
80102610:	5e                   	pop    %esi
80102611:	5d                   	pop    %ebp
80102612:	c3                   	ret    
80102613:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102620 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102620:	55                   	push   %ebp
80102621:	89 e5                	mov    %esp,%ebp
80102623:	56                   	push   %esi
80102624:	53                   	push   %ebx

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102625:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
80102628:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010262b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102631:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102637:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010263d:	39 de                	cmp    %ebx,%esi
8010263f:	72 23                	jb     80102664 <kinit2+0x44>
80102641:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102648:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010264e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102651:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102657:	50                   	push   %eax
80102658:	e8 73 fe ff ff       	call   801024d0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010265d:	83 c4 10             	add    $0x10,%esp
80102660:	39 de                	cmp    %ebx,%esi
80102662:	73 e4                	jae    80102648 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
80102664:	c7 05 14 36 11 80 01 	movl   $0x1,0x80113614
8010266b:	00 00 00 
}
8010266e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102671:	5b                   	pop    %ebx
80102672:	5e                   	pop    %esi
80102673:	5d                   	pop    %ebp
80102674:	c3                   	ret    
80102675:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102680 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102680:	55                   	push   %ebp
80102681:	89 e5                	mov    %esp,%ebp
80102683:	53                   	push   %ebx
80102684:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102687:	a1 14 36 11 80       	mov    0x80113614,%eax
8010268c:	85 c0                	test   %eax,%eax
8010268e:	75 30                	jne    801026c0 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102690:	8b 1d 18 36 11 80    	mov    0x80113618,%ebx
  if(r)
80102696:	85 db                	test   %ebx,%ebx
80102698:	74 1c                	je     801026b6 <kalloc+0x36>
    kmem.freelist = r->next;
8010269a:	8b 13                	mov    (%ebx),%edx
8010269c:	89 15 18 36 11 80    	mov    %edx,0x80113618
  if(kmem.use_lock)
801026a2:	85 c0                	test   %eax,%eax
801026a4:	74 10                	je     801026b6 <kalloc+0x36>
    release(&kmem.lock);
801026a6:	83 ec 0c             	sub    $0xc,%esp
801026a9:	68 e0 35 11 80       	push   $0x801135e0
801026ae:	e8 0d 1f 00 00       	call   801045c0 <release>
801026b3:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
}
801026b6:	89 d8                	mov    %ebx,%eax
801026b8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026bb:	c9                   	leave  
801026bc:	c3                   	ret    
801026bd:	8d 76 00             	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
801026c0:	83 ec 0c             	sub    $0xc,%esp
801026c3:	68 e0 35 11 80       	push   $0x801135e0
801026c8:	e8 d3 1d 00 00       	call   801044a0 <acquire>
  r = kmem.freelist;
801026cd:	8b 1d 18 36 11 80    	mov    0x80113618,%ebx
  if(r)
801026d3:	83 c4 10             	add    $0x10,%esp
801026d6:	a1 14 36 11 80       	mov    0x80113614,%eax
801026db:	85 db                	test   %ebx,%ebx
801026dd:	75 bb                	jne    8010269a <kalloc+0x1a>
801026df:	eb c1                	jmp    801026a2 <kalloc+0x22>
801026e1:	66 90                	xchg   %ax,%ax
801026e3:	66 90                	xchg   %ax,%ax
801026e5:	66 90                	xchg   %ax,%ax
801026e7:	66 90                	xchg   %ax,%ax
801026e9:	66 90                	xchg   %ax,%ax
801026eb:	66 90                	xchg   %ax,%ax
801026ed:	66 90                	xchg   %ax,%ax
801026ef:	90                   	nop

801026f0 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
801026f0:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026f1:	ba 64 00 00 00       	mov    $0x64,%edx
801026f6:	89 e5                	mov    %esp,%ebp
801026f8:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801026f9:	a8 01                	test   $0x1,%al
801026fb:	0f 84 af 00 00 00    	je     801027b0 <kbdgetc+0xc0>
80102701:	ba 60 00 00 00       	mov    $0x60,%edx
80102706:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102707:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
8010270a:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102710:	74 7e                	je     80102790 <kbdgetc+0xa0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102712:	84 c0                	test   %al,%al
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102714:	8b 0d 54 b5 10 80    	mov    0x8010b554,%ecx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
8010271a:	79 24                	jns    80102740 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
8010271c:	f6 c1 40             	test   $0x40,%cl
8010271f:	75 05                	jne    80102726 <kbdgetc+0x36>
80102721:	89 c2                	mov    %eax,%edx
80102723:	83 e2 7f             	and    $0x7f,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102726:	0f b6 82 80 75 10 80 	movzbl -0x7fef8a80(%edx),%eax
8010272d:	83 c8 40             	or     $0x40,%eax
80102730:	0f b6 c0             	movzbl %al,%eax
80102733:	f7 d0                	not    %eax
80102735:	21 c8                	and    %ecx,%eax
80102737:	a3 54 b5 10 80       	mov    %eax,0x8010b554
    return 0;
8010273c:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010273e:	5d                   	pop    %ebp
8010273f:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102740:	f6 c1 40             	test   $0x40,%cl
80102743:	74 09                	je     8010274e <kbdgetc+0x5e>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102745:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102748:	83 e1 bf             	and    $0xffffffbf,%ecx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010274b:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
8010274e:	0f b6 82 80 75 10 80 	movzbl -0x7fef8a80(%edx),%eax
80102755:	09 c1                	or     %eax,%ecx
80102757:	0f b6 82 80 74 10 80 	movzbl -0x7fef8b80(%edx),%eax
8010275e:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102760:	89 c8                	mov    %ecx,%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80102762:	89 0d 54 b5 10 80    	mov    %ecx,0x8010b554
  c = charcode[shift & (CTL | SHIFT)][data];
80102768:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010276b:	83 e1 08             	and    $0x8,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
8010276e:	8b 04 85 60 74 10 80 	mov    -0x7fef8ba0(,%eax,4),%eax
80102775:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102779:	74 c3                	je     8010273e <kbdgetc+0x4e>
    if('a' <= c && c <= 'z')
8010277b:	8d 50 9f             	lea    -0x61(%eax),%edx
8010277e:	83 fa 19             	cmp    $0x19,%edx
80102781:	77 1d                	ja     801027a0 <kbdgetc+0xb0>
      c += 'A' - 'a';
80102783:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102786:	5d                   	pop    %ebp
80102787:	c3                   	ret    
80102788:	90                   	nop
80102789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
80102790:	31 c0                	xor    %eax,%eax
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102792:	83 0d 54 b5 10 80 40 	orl    $0x40,0x8010b554
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102799:	5d                   	pop    %ebp
8010279a:	c3                   	ret    
8010279b:	90                   	nop
8010279c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
801027a0:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801027a3:	8d 50 20             	lea    0x20(%eax),%edx
  }
  return c;
}
801027a6:	5d                   	pop    %ebp
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
801027a7:	83 f9 19             	cmp    $0x19,%ecx
801027aa:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
801027ad:	c3                   	ret    
801027ae:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
801027b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801027b5:	5d                   	pop    %ebp
801027b6:	c3                   	ret    
801027b7:	89 f6                	mov    %esi,%esi
801027b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027c0 <kbdintr>:

void
kbdintr(void)
{
801027c0:	55                   	push   %ebp
801027c1:	89 e5                	mov    %esp,%ebp
801027c3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801027c6:	68 f0 26 10 80       	push   $0x801026f0
801027cb:	e8 b0 e1 ff ff       	call   80100980 <consoleintr>
}
801027d0:	83 c4 10             	add    $0x10,%esp
801027d3:	c9                   	leave  
801027d4:	c3                   	ret    
801027d5:	66 90                	xchg   %ax,%ax
801027d7:	66 90                	xchg   %ax,%ax
801027d9:	66 90                	xchg   %ax,%ax
801027db:	66 90                	xchg   %ax,%ax
801027dd:	66 90                	xchg   %ax,%ax
801027df:	90                   	nop

801027e0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801027e0:	a1 1c 36 11 80       	mov    0x8011361c,%eax
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
801027e5:	55                   	push   %ebp
801027e6:	89 e5                	mov    %esp,%ebp
  if(!lapic)
801027e8:	85 c0                	test   %eax,%eax
801027ea:	0f 84 c8 00 00 00    	je     801028b8 <lapicinit+0xd8>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027f0:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801027f7:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027fa:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027fd:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102804:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102807:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010280a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102811:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102814:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102817:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010281e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102821:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102824:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010282b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010282e:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102831:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102838:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010283b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010283e:	8b 50 30             	mov    0x30(%eax),%edx
80102841:	c1 ea 10             	shr    $0x10,%edx
80102844:	80 fa 03             	cmp    $0x3,%dl
80102847:	77 77                	ja     801028c0 <lapicinit+0xe0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102849:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102850:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102853:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102856:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010285d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102860:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102863:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010286a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010286d:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102870:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102877:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010287a:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010287d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102884:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102887:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010288a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102891:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102894:	8b 50 20             	mov    0x20(%eax),%edx
80102897:	89 f6                	mov    %esi,%esi
80102899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801028a0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801028a6:	80 e6 10             	and    $0x10,%dh
801028a9:	75 f5                	jne    801028a0 <lapicinit+0xc0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028ab:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801028b2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028b5:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801028b8:	5d                   	pop    %ebp
801028b9:	c3                   	ret    
801028ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028c0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801028c7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801028ca:	8b 50 20             	mov    0x20(%eax),%edx
801028cd:	e9 77 ff ff ff       	jmp    80102849 <lapicinit+0x69>
801028d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801028e0 <lapicid>:
}

int
lapicid(void)
{
  if (!lapic)
801028e0:	a1 1c 36 11 80       	mov    0x8011361c,%eax
  lapicw(TPR, 0);
}

int
lapicid(void)
{
801028e5:	55                   	push   %ebp
801028e6:	89 e5                	mov    %esp,%ebp
  if (!lapic)
801028e8:	85 c0                	test   %eax,%eax
801028ea:	74 0c                	je     801028f8 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
801028ec:	8b 40 20             	mov    0x20(%eax),%eax
}
801028ef:	5d                   	pop    %ebp
int
lapicid(void)
{
  if (!lapic)
    return 0;
  return lapic[ID] >> 24;
801028f0:	c1 e8 18             	shr    $0x18,%eax
}
801028f3:	c3                   	ret    
801028f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

int
lapicid(void)
{
  if (!lapic)
    return 0;
801028f8:	31 c0                	xor    %eax,%eax
  return lapic[ID] >> 24;
}
801028fa:	5d                   	pop    %ebp
801028fb:	c3                   	ret    
801028fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102900 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102900:	a1 1c 36 11 80       	mov    0x8011361c,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102905:	55                   	push   %ebp
80102906:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102908:	85 c0                	test   %eax,%eax
8010290a:	74 0d                	je     80102919 <lapiceoi+0x19>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010290c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102913:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102916:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
80102919:	5d                   	pop    %ebp
8010291a:	c3                   	ret    
8010291b:	90                   	nop
8010291c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102920 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102920:	55                   	push   %ebp
80102921:	89 e5                	mov    %esp,%ebp
}
80102923:	5d                   	pop    %ebp
80102924:	c3                   	ret    
80102925:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102930 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102930:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102931:	ba 70 00 00 00       	mov    $0x70,%edx
80102936:	b8 0f 00 00 00       	mov    $0xf,%eax
8010293b:	89 e5                	mov    %esp,%ebp
8010293d:	53                   	push   %ebx
8010293e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102941:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102944:	ee                   	out    %al,(%dx)
80102945:	ba 71 00 00 00       	mov    $0x71,%edx
8010294a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010294f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102950:	31 c0                	xor    %eax,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102952:	c1 e3 18             	shl    $0x18,%ebx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102955:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010295b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010295d:	c1 e9 0c             	shr    $0xc,%ecx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102960:	c1 e8 04             	shr    $0x4,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102963:	89 da                	mov    %ebx,%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102965:	80 cd 06             	or     $0x6,%ch
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102968:	66 a3 69 04 00 80    	mov    %ax,0x80000469

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010296e:	a1 1c 36 11 80       	mov    0x8011361c,%eax
80102973:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102979:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010297c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102983:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102986:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102989:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102990:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102993:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102996:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010299c:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010299f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029a5:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801029a8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029ae:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801029b1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029b7:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801029ba:	5b                   	pop    %ebx
801029bb:	5d                   	pop    %ebp
801029bc:	c3                   	ret    
801029bd:	8d 76 00             	lea    0x0(%esi),%esi

801029c0 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
801029c0:	55                   	push   %ebp
801029c1:	ba 70 00 00 00       	mov    $0x70,%edx
801029c6:	b8 0b 00 00 00       	mov    $0xb,%eax
801029cb:	89 e5                	mov    %esp,%ebp
801029cd:	57                   	push   %edi
801029ce:	56                   	push   %esi
801029cf:	53                   	push   %ebx
801029d0:	83 ec 4c             	sub    $0x4c,%esp
801029d3:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029d4:	ba 71 00 00 00       	mov    $0x71,%edx
801029d9:	ec                   	in     (%dx),%al
801029da:	83 e0 04             	and    $0x4,%eax
801029dd:	8d 75 d0             	lea    -0x30(%ebp),%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029e0:	31 db                	xor    %ebx,%ebx
801029e2:	88 45 b7             	mov    %al,-0x49(%ebp)
801029e5:	bf 70 00 00 00       	mov    $0x70,%edi
801029ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801029f0:	89 d8                	mov    %ebx,%eax
801029f2:	89 fa                	mov    %edi,%edx
801029f4:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029f5:	b9 71 00 00 00       	mov    $0x71,%ecx
801029fa:	89 ca                	mov    %ecx,%edx
801029fc:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
801029fd:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a00:	89 fa                	mov    %edi,%edx
80102a02:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102a05:	b8 02 00 00 00       	mov    $0x2,%eax
80102a0a:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a0b:	89 ca                	mov    %ecx,%edx
80102a0d:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
80102a0e:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a11:	89 fa                	mov    %edi,%edx
80102a13:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102a16:	b8 04 00 00 00       	mov    $0x4,%eax
80102a1b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a1c:	89 ca                	mov    %ecx,%edx
80102a1e:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
80102a1f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a22:	89 fa                	mov    %edi,%edx
80102a24:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102a27:	b8 07 00 00 00       	mov    $0x7,%eax
80102a2c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a2d:	89 ca                	mov    %ecx,%edx
80102a2f:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102a30:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a33:	89 fa                	mov    %edi,%edx
80102a35:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102a38:	b8 08 00 00 00       	mov    $0x8,%eax
80102a3d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a3e:	89 ca                	mov    %ecx,%edx
80102a40:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102a41:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a44:	89 fa                	mov    %edi,%edx
80102a46:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102a49:	b8 09 00 00 00       	mov    $0x9,%eax
80102a4e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a4f:	89 ca                	mov    %ecx,%edx
80102a51:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102a52:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a55:	89 fa                	mov    %edi,%edx
80102a57:	89 45 cc             	mov    %eax,-0x34(%ebp)
80102a5a:	b8 0a 00 00 00       	mov    $0xa,%eax
80102a5f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a60:	89 ca                	mov    %ecx,%edx
80102a62:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102a63:	84 c0                	test   %al,%al
80102a65:	78 89                	js     801029f0 <cmostime+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a67:	89 d8                	mov    %ebx,%eax
80102a69:	89 fa                	mov    %edi,%edx
80102a6b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a6c:	89 ca                	mov    %ecx,%edx
80102a6e:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
80102a6f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a72:	89 fa                	mov    %edi,%edx
80102a74:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102a77:	b8 02 00 00 00       	mov    $0x2,%eax
80102a7c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a7d:	89 ca                	mov    %ecx,%edx
80102a7f:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
80102a80:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a83:	89 fa                	mov    %edi,%edx
80102a85:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102a88:	b8 04 00 00 00       	mov    $0x4,%eax
80102a8d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a8e:	89 ca                	mov    %ecx,%edx
80102a90:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
80102a91:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a94:	89 fa                	mov    %edi,%edx
80102a96:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102a99:	b8 07 00 00 00       	mov    $0x7,%eax
80102a9e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a9f:	89 ca                	mov    %ecx,%edx
80102aa1:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102aa2:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102aa5:	89 fa                	mov    %edi,%edx
80102aa7:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102aaa:	b8 08 00 00 00       	mov    $0x8,%eax
80102aaf:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ab0:	89 ca                	mov    %ecx,%edx
80102ab2:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102ab3:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ab6:	89 fa                	mov    %edi,%edx
80102ab8:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102abb:	b8 09 00 00 00       	mov    $0x9,%eax
80102ac0:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ac1:	89 ca                	mov    %ecx,%edx
80102ac3:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102ac4:	0f b6 c0             	movzbl %al,%eax
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102ac7:	83 ec 04             	sub    $0x4,%esp
  r->second = cmos_read(SECS);
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
80102aca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102acd:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102ad0:	6a 18                	push   $0x18
80102ad2:	56                   	push   %esi
80102ad3:	50                   	push   %eax
80102ad4:	e8 87 1b 00 00       	call   80104660 <memcmp>
80102ad9:	83 c4 10             	add    $0x10,%esp
80102adc:	85 c0                	test   %eax,%eax
80102ade:	0f 85 0c ff ff ff    	jne    801029f0 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80102ae4:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
80102ae8:	75 78                	jne    80102b62 <cmostime+0x1a2>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102aea:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102aed:	89 c2                	mov    %eax,%edx
80102aef:	83 e0 0f             	and    $0xf,%eax
80102af2:	c1 ea 04             	shr    $0x4,%edx
80102af5:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102af8:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102afb:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102afe:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b01:	89 c2                	mov    %eax,%edx
80102b03:	83 e0 0f             	and    $0xf,%eax
80102b06:	c1 ea 04             	shr    $0x4,%edx
80102b09:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b0c:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b0f:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102b12:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b15:	89 c2                	mov    %eax,%edx
80102b17:	83 e0 0f             	and    $0xf,%eax
80102b1a:	c1 ea 04             	shr    $0x4,%edx
80102b1d:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b20:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b23:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102b26:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b29:	89 c2                	mov    %eax,%edx
80102b2b:	83 e0 0f             	and    $0xf,%eax
80102b2e:	c1 ea 04             	shr    $0x4,%edx
80102b31:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b34:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b37:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102b3a:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b3d:	89 c2                	mov    %eax,%edx
80102b3f:	83 e0 0f             	and    $0xf,%eax
80102b42:	c1 ea 04             	shr    $0x4,%edx
80102b45:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b48:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b4b:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102b4e:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b51:	89 c2                	mov    %eax,%edx
80102b53:	83 e0 0f             	and    $0xf,%eax
80102b56:	c1 ea 04             	shr    $0x4,%edx
80102b59:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b5c:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b5f:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102b62:	8b 75 08             	mov    0x8(%ebp),%esi
80102b65:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b68:	89 06                	mov    %eax,(%esi)
80102b6a:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b6d:	89 46 04             	mov    %eax,0x4(%esi)
80102b70:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b73:	89 46 08             	mov    %eax,0x8(%esi)
80102b76:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b79:	89 46 0c             	mov    %eax,0xc(%esi)
80102b7c:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b7f:	89 46 10             	mov    %eax,0x10(%esi)
80102b82:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b85:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102b88:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102b8f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b92:	5b                   	pop    %ebx
80102b93:	5e                   	pop    %esi
80102b94:	5f                   	pop    %edi
80102b95:	5d                   	pop    %ebp
80102b96:	c3                   	ret    
80102b97:	66 90                	xchg   %ax,%ax
80102b99:	66 90                	xchg   %ax,%ax
80102b9b:	66 90                	xchg   %ax,%ax
80102b9d:	66 90                	xchg   %ax,%ax
80102b9f:	90                   	nop

80102ba0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ba0:	8b 0d 68 36 11 80    	mov    0x80113668,%ecx
80102ba6:	85 c9                	test   %ecx,%ecx
80102ba8:	0f 8e 85 00 00 00    	jle    80102c33 <install_trans+0x93>
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102bae:	55                   	push   %ebp
80102baf:	89 e5                	mov    %esp,%ebp
80102bb1:	57                   	push   %edi
80102bb2:	56                   	push   %esi
80102bb3:	53                   	push   %ebx
80102bb4:	31 db                	xor    %ebx,%ebx
80102bb6:	83 ec 0c             	sub    $0xc,%esp
80102bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102bc0:	a1 54 36 11 80       	mov    0x80113654,%eax
80102bc5:	83 ec 08             	sub    $0x8,%esp
80102bc8:	01 d8                	add    %ebx,%eax
80102bca:	83 c0 01             	add    $0x1,%eax
80102bcd:	50                   	push   %eax
80102bce:	ff 35 64 36 11 80    	pushl  0x80113664
80102bd4:	e8 f7 d4 ff ff       	call   801000d0 <bread>
80102bd9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bdb:	58                   	pop    %eax
80102bdc:	5a                   	pop    %edx
80102bdd:	ff 34 9d 6c 36 11 80 	pushl  -0x7feec994(,%ebx,4)
80102be4:	ff 35 64 36 11 80    	pushl  0x80113664
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102bea:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bed:	e8 de d4 ff ff       	call   801000d0 <bread>
80102bf2:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102bf4:	8d 47 5c             	lea    0x5c(%edi),%eax
80102bf7:	83 c4 0c             	add    $0xc,%esp
80102bfa:	68 00 02 00 00       	push   $0x200
80102bff:	50                   	push   %eax
80102c00:	8d 46 5c             	lea    0x5c(%esi),%eax
80102c03:	50                   	push   %eax
80102c04:	e8 b7 1a 00 00       	call   801046c0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102c09:	89 34 24             	mov    %esi,(%esp)
80102c0c:	e8 8f d5 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102c11:	89 3c 24             	mov    %edi,(%esp)
80102c14:	e8 c7 d5 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102c19:	89 34 24             	mov    %esi,(%esp)
80102c1c:	e8 bf d5 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102c21:	83 c4 10             	add    $0x10,%esp
80102c24:	39 1d 68 36 11 80    	cmp    %ebx,0x80113668
80102c2a:	7f 94                	jg     80102bc0 <install_trans+0x20>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102c2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c2f:	5b                   	pop    %ebx
80102c30:	5e                   	pop    %esi
80102c31:	5f                   	pop    %edi
80102c32:	5d                   	pop    %ebp
80102c33:	f3 c3                	repz ret 
80102c35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c40 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102c40:	55                   	push   %ebp
80102c41:	89 e5                	mov    %esp,%ebp
80102c43:	53                   	push   %ebx
80102c44:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c47:	ff 35 54 36 11 80    	pushl  0x80113654
80102c4d:	ff 35 64 36 11 80    	pushl  0x80113664
80102c53:	e8 78 d4 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102c58:	8b 0d 68 36 11 80    	mov    0x80113668,%ecx
  for (i = 0; i < log.lh.n; i++) {
80102c5e:	83 c4 10             	add    $0x10,%esp
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102c61:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102c63:	85 c9                	test   %ecx,%ecx
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102c65:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102c68:	7e 1f                	jle    80102c89 <write_head+0x49>
80102c6a:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80102c71:	31 d2                	xor    %edx,%edx
80102c73:	90                   	nop
80102c74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102c78:	8b 8a 6c 36 11 80    	mov    -0x7feec994(%edx),%ecx
80102c7e:	89 4c 13 60          	mov    %ecx,0x60(%ebx,%edx,1)
80102c82:	83 c2 04             	add    $0x4,%edx
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102c85:	39 c2                	cmp    %eax,%edx
80102c87:	75 ef                	jne    80102c78 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102c89:	83 ec 0c             	sub    $0xc,%esp
80102c8c:	53                   	push   %ebx
80102c8d:	e8 0e d5 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102c92:	89 1c 24             	mov    %ebx,(%esp)
80102c95:	e8 46 d5 ff ff       	call   801001e0 <brelse>
}
80102c9a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c9d:	c9                   	leave  
80102c9e:	c3                   	ret    
80102c9f:	90                   	nop

80102ca0 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102ca0:	55                   	push   %ebp
80102ca1:	89 e5                	mov    %esp,%ebp
80102ca3:	53                   	push   %ebx
80102ca4:	83 ec 2c             	sub    $0x2c,%esp
80102ca7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102caa:	68 80 76 10 80       	push   $0x80107680
80102caf:	68 20 36 11 80       	push   $0x80113620
80102cb4:	e8 e7 16 00 00       	call   801043a0 <initlock>
  readsb(dev, &sb);
80102cb9:	58                   	pop    %eax
80102cba:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102cbd:	5a                   	pop    %edx
80102cbe:	50                   	push   %eax
80102cbf:	53                   	push   %ebx
80102cc0:	e8 db e8 ff ff       	call   801015a0 <readsb>
  log.start = sb.logstart;
  log.size = sb.nlog;
80102cc5:	8b 55 e8             	mov    -0x18(%ebp),%edx
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102cc8:	8b 45 ec             	mov    -0x14(%ebp),%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102ccb:	59                   	pop    %ecx
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102ccc:	89 1d 64 36 11 80    	mov    %ebx,0x80113664

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102cd2:	89 15 58 36 11 80    	mov    %edx,0x80113658
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102cd8:	a3 54 36 11 80       	mov    %eax,0x80113654

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102cdd:	5a                   	pop    %edx
80102cde:	50                   	push   %eax
80102cdf:	53                   	push   %ebx
80102ce0:	e8 eb d3 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102ce5:	8b 48 5c             	mov    0x5c(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102ce8:	83 c4 10             	add    $0x10,%esp
80102ceb:	85 c9                	test   %ecx,%ecx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102ced:	89 0d 68 36 11 80    	mov    %ecx,0x80113668
  for (i = 0; i < log.lh.n; i++) {
80102cf3:	7e 1c                	jle    80102d11 <initlog+0x71>
80102cf5:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102cfc:	31 d2                	xor    %edx,%edx
80102cfe:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102d00:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102d04:	83 c2 04             	add    $0x4,%edx
80102d07:	89 8a 68 36 11 80    	mov    %ecx,-0x7feec998(%edx)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102d0d:	39 da                	cmp    %ebx,%edx
80102d0f:	75 ef                	jne    80102d00 <initlog+0x60>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102d11:	83 ec 0c             	sub    $0xc,%esp
80102d14:	50                   	push   %eax
80102d15:	e8 c6 d4 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102d1a:	e8 81 fe ff ff       	call   80102ba0 <install_trans>
  log.lh.n = 0;
80102d1f:	c7 05 68 36 11 80 00 	movl   $0x0,0x80113668
80102d26:	00 00 00 
  write_head(); // clear the log
80102d29:	e8 12 ff ff ff       	call   80102c40 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102d2e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d31:	c9                   	leave  
80102d32:	c3                   	ret    
80102d33:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102d40 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102d40:	55                   	push   %ebp
80102d41:	89 e5                	mov    %esp,%ebp
80102d43:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102d46:	68 20 36 11 80       	push   $0x80113620
80102d4b:	e8 50 17 00 00       	call   801044a0 <acquire>
80102d50:	83 c4 10             	add    $0x10,%esp
80102d53:	eb 18                	jmp    80102d6d <begin_op+0x2d>
80102d55:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102d58:	83 ec 08             	sub    $0x8,%esp
80102d5b:	68 20 36 11 80       	push   $0x80113620
80102d60:	68 20 36 11 80       	push   $0x80113620
80102d65:	e8 c6 11 00 00       	call   80103f30 <sleep>
80102d6a:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102d6d:	a1 60 36 11 80       	mov    0x80113660,%eax
80102d72:	85 c0                	test   %eax,%eax
80102d74:	75 e2                	jne    80102d58 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102d76:	a1 5c 36 11 80       	mov    0x8011365c,%eax
80102d7b:	8b 15 68 36 11 80    	mov    0x80113668,%edx
80102d81:	83 c0 01             	add    $0x1,%eax
80102d84:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102d87:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102d8a:	83 fa 1e             	cmp    $0x1e,%edx
80102d8d:	7f c9                	jg     80102d58 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102d8f:	83 ec 0c             	sub    $0xc,%esp
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102d92:	a3 5c 36 11 80       	mov    %eax,0x8011365c
      release(&log.lock);
80102d97:	68 20 36 11 80       	push   $0x80113620
80102d9c:	e8 1f 18 00 00       	call   801045c0 <release>
      break;
    }
  }
}
80102da1:	83 c4 10             	add    $0x10,%esp
80102da4:	c9                   	leave  
80102da5:	c3                   	ret    
80102da6:	8d 76 00             	lea    0x0(%esi),%esi
80102da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102db0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102db0:	55                   	push   %ebp
80102db1:	89 e5                	mov    %esp,%ebp
80102db3:	57                   	push   %edi
80102db4:	56                   	push   %esi
80102db5:	53                   	push   %ebx
80102db6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102db9:	68 20 36 11 80       	push   $0x80113620
80102dbe:	e8 dd 16 00 00       	call   801044a0 <acquire>
  log.outstanding -= 1;
80102dc3:	a1 5c 36 11 80       	mov    0x8011365c,%eax
  if(log.committing)
80102dc8:	8b 1d 60 36 11 80    	mov    0x80113660,%ebx
80102dce:	83 c4 10             	add    $0x10,%esp
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102dd1:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102dd4:	85 db                	test   %ebx,%ebx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102dd6:	a3 5c 36 11 80       	mov    %eax,0x8011365c
  if(log.committing)
80102ddb:	0f 85 23 01 00 00    	jne    80102f04 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102de1:	85 c0                	test   %eax,%eax
80102de3:	0f 85 f7 00 00 00    	jne    80102ee0 <end_op+0x130>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102de9:	83 ec 0c             	sub    $0xc,%esp
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102dec:	c7 05 60 36 11 80 01 	movl   $0x1,0x80113660
80102df3:	00 00 00 
}

static void
commit()
{
  if (log.lh.n > 0) {
80102df6:	31 db                	xor    %ebx,%ebx
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102df8:	68 20 36 11 80       	push   $0x80113620
80102dfd:	e8 be 17 00 00       	call   801045c0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102e02:	8b 0d 68 36 11 80    	mov    0x80113668,%ecx
80102e08:	83 c4 10             	add    $0x10,%esp
80102e0b:	85 c9                	test   %ecx,%ecx
80102e0d:	0f 8e 8a 00 00 00    	jle    80102e9d <end_op+0xed>
80102e13:	90                   	nop
80102e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102e18:	a1 54 36 11 80       	mov    0x80113654,%eax
80102e1d:	83 ec 08             	sub    $0x8,%esp
80102e20:	01 d8                	add    %ebx,%eax
80102e22:	83 c0 01             	add    $0x1,%eax
80102e25:	50                   	push   %eax
80102e26:	ff 35 64 36 11 80    	pushl  0x80113664
80102e2c:	e8 9f d2 ff ff       	call   801000d0 <bread>
80102e31:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e33:	58                   	pop    %eax
80102e34:	5a                   	pop    %edx
80102e35:	ff 34 9d 6c 36 11 80 	pushl  -0x7feec994(,%ebx,4)
80102e3c:	ff 35 64 36 11 80    	pushl  0x80113664
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102e42:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e45:	e8 86 d2 ff ff       	call   801000d0 <bread>
80102e4a:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102e4c:	8d 40 5c             	lea    0x5c(%eax),%eax
80102e4f:	83 c4 0c             	add    $0xc,%esp
80102e52:	68 00 02 00 00       	push   $0x200
80102e57:	50                   	push   %eax
80102e58:	8d 46 5c             	lea    0x5c(%esi),%eax
80102e5b:	50                   	push   %eax
80102e5c:	e8 5f 18 00 00       	call   801046c0 <memmove>
    bwrite(to);  // write the log
80102e61:	89 34 24             	mov    %esi,(%esp)
80102e64:	e8 37 d3 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102e69:	89 3c 24             	mov    %edi,(%esp)
80102e6c:	e8 6f d3 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102e71:	89 34 24             	mov    %esi,(%esp)
80102e74:	e8 67 d3 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102e79:	83 c4 10             	add    $0x10,%esp
80102e7c:	3b 1d 68 36 11 80    	cmp    0x80113668,%ebx
80102e82:	7c 94                	jl     80102e18 <end_op+0x68>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102e84:	e8 b7 fd ff ff       	call   80102c40 <write_head>
    install_trans(); // Now install writes to home locations
80102e89:	e8 12 fd ff ff       	call   80102ba0 <install_trans>
    log.lh.n = 0;
80102e8e:	c7 05 68 36 11 80 00 	movl   $0x0,0x80113668
80102e95:	00 00 00 
    write_head();    // Erase the transaction from the log
80102e98:	e8 a3 fd ff ff       	call   80102c40 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102e9d:	83 ec 0c             	sub    $0xc,%esp
80102ea0:	68 20 36 11 80       	push   $0x80113620
80102ea5:	e8 f6 15 00 00       	call   801044a0 <acquire>
    log.committing = 0;
    wakeup(&log);
80102eaa:	c7 04 24 20 36 11 80 	movl   $0x80113620,(%esp)
  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
    log.committing = 0;
80102eb1:	c7 05 60 36 11 80 00 	movl   $0x0,0x80113660
80102eb8:	00 00 00 
    wakeup(&log);
80102ebb:	e8 20 12 00 00       	call   801040e0 <wakeup>
    release(&log.lock);
80102ec0:	c7 04 24 20 36 11 80 	movl   $0x80113620,(%esp)
80102ec7:	e8 f4 16 00 00       	call   801045c0 <release>
80102ecc:	83 c4 10             	add    $0x10,%esp
  }
}
80102ecf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ed2:	5b                   	pop    %ebx
80102ed3:	5e                   	pop    %esi
80102ed4:	5f                   	pop    %edi
80102ed5:	5d                   	pop    %ebp
80102ed6:	c3                   	ret    
80102ed7:	89 f6                	mov    %esi,%esi
80102ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
80102ee0:	83 ec 0c             	sub    $0xc,%esp
80102ee3:	68 20 36 11 80       	push   $0x80113620
80102ee8:	e8 f3 11 00 00       	call   801040e0 <wakeup>
  }
  release(&log.lock);
80102eed:	c7 04 24 20 36 11 80 	movl   $0x80113620,(%esp)
80102ef4:	e8 c7 16 00 00       	call   801045c0 <release>
80102ef9:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
80102efc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102eff:	5b                   	pop    %ebx
80102f00:	5e                   	pop    %esi
80102f01:	5f                   	pop    %edi
80102f02:	5d                   	pop    %ebp
80102f03:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102f04:	83 ec 0c             	sub    $0xc,%esp
80102f07:	68 84 76 10 80       	push   $0x80107684
80102f0c:	e8 5f d4 ff ff       	call   80100370 <panic>
80102f11:	eb 0d                	jmp    80102f20 <log_write>
80102f13:	90                   	nop
80102f14:	90                   	nop
80102f15:	90                   	nop
80102f16:	90                   	nop
80102f17:	90                   	nop
80102f18:	90                   	nop
80102f19:	90                   	nop
80102f1a:	90                   	nop
80102f1b:	90                   	nop
80102f1c:	90                   	nop
80102f1d:	90                   	nop
80102f1e:	90                   	nop
80102f1f:	90                   	nop

80102f20 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102f20:	55                   	push   %ebp
80102f21:	89 e5                	mov    %esp,%ebp
80102f23:	53                   	push   %ebx
80102f24:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f27:	8b 15 68 36 11 80    	mov    0x80113668,%edx
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102f2d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f30:	83 fa 1d             	cmp    $0x1d,%edx
80102f33:	0f 8f 97 00 00 00    	jg     80102fd0 <log_write+0xb0>
80102f39:	a1 58 36 11 80       	mov    0x80113658,%eax
80102f3e:	83 e8 01             	sub    $0x1,%eax
80102f41:	39 c2                	cmp    %eax,%edx
80102f43:	0f 8d 87 00 00 00    	jge    80102fd0 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102f49:	a1 5c 36 11 80       	mov    0x8011365c,%eax
80102f4e:	85 c0                	test   %eax,%eax
80102f50:	0f 8e 87 00 00 00    	jle    80102fdd <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102f56:	83 ec 0c             	sub    $0xc,%esp
80102f59:	68 20 36 11 80       	push   $0x80113620
80102f5e:	e8 3d 15 00 00       	call   801044a0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102f63:	8b 15 68 36 11 80    	mov    0x80113668,%edx
80102f69:	83 c4 10             	add    $0x10,%esp
80102f6c:	83 fa 00             	cmp    $0x0,%edx
80102f6f:	7e 50                	jle    80102fc1 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f71:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102f74:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f76:	3b 0d 6c 36 11 80    	cmp    0x8011366c,%ecx
80102f7c:	75 0b                	jne    80102f89 <log_write+0x69>
80102f7e:	eb 38                	jmp    80102fb8 <log_write+0x98>
80102f80:	39 0c 85 6c 36 11 80 	cmp    %ecx,-0x7feec994(,%eax,4)
80102f87:	74 2f                	je     80102fb8 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102f89:	83 c0 01             	add    $0x1,%eax
80102f8c:	39 d0                	cmp    %edx,%eax
80102f8e:	75 f0                	jne    80102f80 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102f90:	89 0c 95 6c 36 11 80 	mov    %ecx,-0x7feec994(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102f97:	83 c2 01             	add    $0x1,%edx
80102f9a:	89 15 68 36 11 80    	mov    %edx,0x80113668
  b->flags |= B_DIRTY; // prevent eviction
80102fa0:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102fa3:	c7 45 08 20 36 11 80 	movl   $0x80113620,0x8(%ebp)
}
80102faa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102fad:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102fae:	e9 0d 16 00 00       	jmp    801045c0 <release>
80102fb3:	90                   	nop
80102fb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102fb8:	89 0c 85 6c 36 11 80 	mov    %ecx,-0x7feec994(,%eax,4)
80102fbf:	eb df                	jmp    80102fa0 <log_write+0x80>
80102fc1:	8b 43 08             	mov    0x8(%ebx),%eax
80102fc4:	a3 6c 36 11 80       	mov    %eax,0x8011366c
  if (i == log.lh.n)
80102fc9:	75 d5                	jne    80102fa0 <log_write+0x80>
80102fcb:	eb ca                	jmp    80102f97 <log_write+0x77>
80102fcd:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102fd0:	83 ec 0c             	sub    $0xc,%esp
80102fd3:	68 93 76 10 80       	push   $0x80107693
80102fd8:	e8 93 d3 ff ff       	call   80100370 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102fdd:	83 ec 0c             	sub    $0xc,%esp
80102fe0:	68 a9 76 10 80       	push   $0x801076a9
80102fe5:	e8 86 d3 ff ff       	call   80100370 <panic>
80102fea:	66 90                	xchg   %ax,%ax
80102fec:	66 90                	xchg   %ax,%ax
80102fee:	66 90                	xchg   %ax,%ax

80102ff0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102ff0:	55                   	push   %ebp
80102ff1:	89 e5                	mov    %esp,%ebp
80102ff3:	53                   	push   %ebx
80102ff4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102ff7:	e8 54 09 00 00       	call   80103950 <cpuid>
80102ffc:	89 c3                	mov    %eax,%ebx
80102ffe:	e8 4d 09 00 00       	call   80103950 <cpuid>
80103003:	83 ec 04             	sub    $0x4,%esp
80103006:	53                   	push   %ebx
80103007:	50                   	push   %eax
80103008:	68 c4 76 10 80       	push   $0x801076c4
8010300d:	e8 6e d6 ff ff       	call   80100680 <cprintf>
  idtinit();       // load idt register
80103012:	e8 e9 29 00 00       	call   80105a00 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103017:	e8 b4 08 00 00       	call   801038d0 <mycpu>
8010301c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010301e:	b8 01 00 00 00       	mov    $0x1,%eax
80103023:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010302a:	e8 01 0c 00 00       	call   80103c30 <scheduler>
8010302f:	90                   	nop

80103030 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80103030:	55                   	push   %ebp
80103031:	89 e5                	mov    %esp,%ebp
80103033:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103036:	e8 e5 3a 00 00       	call   80106b20 <switchkvm>
  seginit();
8010303b:	e8 e0 39 00 00       	call   80106a20 <seginit>
  lapicinit();
80103040:	e8 9b f7 ff ff       	call   801027e0 <lapicinit>
  mpmain();
80103045:	e8 a6 ff ff ff       	call   80102ff0 <mpmain>
8010304a:	66 90                	xchg   %ax,%ax
8010304c:	66 90                	xchg   %ax,%ax
8010304e:	66 90                	xchg   %ax,%ax

80103050 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80103050:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103054:	83 e4 f0             	and    $0xfffffff0,%esp
80103057:	ff 71 fc             	pushl  -0x4(%ecx)
8010305a:	55                   	push   %ebp
8010305b:	89 e5                	mov    %esp,%ebp
8010305d:	53                   	push   %ebx
8010305e:	51                   	push   %ecx
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
8010305f:	bb 20 37 11 80       	mov    $0x80113720,%ebx
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103064:	83 ec 08             	sub    $0x8,%esp
80103067:	68 00 00 40 80       	push   $0x80400000
8010306c:	68 48 64 11 80       	push   $0x80116448
80103071:	e8 3a f5 ff ff       	call   801025b0 <kinit1>
  kvmalloc();      // kernel page table
80103076:	e8 45 3f 00 00       	call   80106fc0 <kvmalloc>
  mpinit();        // detect other processors
8010307b:	e8 70 01 00 00       	call   801031f0 <mpinit>
  lapicinit();     // interrupt controller
80103080:	e8 5b f7 ff ff       	call   801027e0 <lapicinit>
  seginit();       // segment descriptors
80103085:	e8 96 39 00 00       	call   80106a20 <seginit>
  picinit();       // disable pic
8010308a:	e8 31 03 00 00       	call   801033c0 <picinit>
  ioapicinit();    // another interrupt controller
8010308f:	e8 4c f3 ff ff       	call   801023e0 <ioapicinit>
  consoleinit();   // console hardware
80103094:	e8 c7 da ff ff       	call   80100b60 <consoleinit>
  uartinit();      // serial port
80103099:	e8 52 2c 00 00       	call   80105cf0 <uartinit>
  pinit();         // process table
8010309e:	e8 0d 08 00 00       	call   801038b0 <pinit>
  tvinit();        // trap vectors
801030a3:	e8 b8 28 00 00       	call   80105960 <tvinit>
  binit();         // buffer cache
801030a8:	e8 93 cf ff ff       	call   80100040 <binit>
  fileinit();      // file table
801030ad:	e8 8e de ff ff       	call   80100f40 <fileinit>
  ideinit();       // disk 
801030b2:	e8 09 f1 ff ff       	call   801021c0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801030b7:	83 c4 0c             	add    $0xc,%esp
801030ba:	68 8a 00 00 00       	push   $0x8a
801030bf:	68 8c a4 10 80       	push   $0x8010a48c
801030c4:	68 00 70 00 80       	push   $0x80007000
801030c9:	e8 f2 15 00 00       	call   801046c0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801030ce:	69 05 a0 3c 11 80 b0 	imul   $0xb0,0x80113ca0,%eax
801030d5:	00 00 00 
801030d8:	83 c4 10             	add    $0x10,%esp
801030db:	05 20 37 11 80       	add    $0x80113720,%eax
801030e0:	39 d8                	cmp    %ebx,%eax
801030e2:	76 6f                	jbe    80103153 <main+0x103>
801030e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
801030e8:	e8 e3 07 00 00       	call   801038d0 <mycpu>
801030ed:	39 d8                	cmp    %ebx,%eax
801030ef:	74 49                	je     8010313a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801030f1:	e8 8a f5 ff ff       	call   80102680 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
801030f6:	05 00 10 00 00       	add    $0x1000,%eax
    *(void**)(code-8) = mpenter;
801030fb:	c7 05 f8 6f 00 80 30 	movl   $0x80103030,0x80006ff8
80103102:	30 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103105:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
8010310c:	90 10 00 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
8010310f:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103114:	0f b6 03             	movzbl (%ebx),%eax
80103117:	83 ec 08             	sub    $0x8,%esp
8010311a:	68 00 70 00 00       	push   $0x7000
8010311f:	50                   	push   %eax
80103120:	e8 0b f8 ff ff       	call   80102930 <lapicstartap>
80103125:	83 c4 10             	add    $0x10,%esp
80103128:	90                   	nop
80103129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103130:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103136:	85 c0                	test   %eax,%eax
80103138:	74 f6                	je     80103130 <main+0xe0>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
8010313a:	69 05 a0 3c 11 80 b0 	imul   $0xb0,0x80113ca0,%eax
80103141:	00 00 00 
80103144:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010314a:	05 20 37 11 80       	add    $0x80113720,%eax
8010314f:	39 c3                	cmp    %eax,%ebx
80103151:	72 95                	jb     801030e8 <main+0x98>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk 
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103153:	83 ec 08             	sub    $0x8,%esp
80103156:	68 00 00 00 8e       	push   $0x8e000000
8010315b:	68 00 00 40 80       	push   $0x80400000
80103160:	e8 bb f4 ff ff       	call   80102620 <kinit2>
  userinit();      // first user process
80103165:	e8 36 08 00 00       	call   801039a0 <userinit>
  mpmain();        // finish this processor's setup
8010316a:	e8 81 fe ff ff       	call   80102ff0 <mpmain>
8010316f:	90                   	nop

80103170 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103170:	55                   	push   %ebp
80103171:	89 e5                	mov    %esp,%ebp
80103173:	57                   	push   %edi
80103174:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103175:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
8010317b:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
8010317c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
8010317f:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103182:	39 de                	cmp    %ebx,%esi
80103184:	73 48                	jae    801031ce <mpsearch1+0x5e>
80103186:	8d 76 00             	lea    0x0(%esi),%esi
80103189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103190:	83 ec 04             	sub    $0x4,%esp
80103193:	8d 7e 10             	lea    0x10(%esi),%edi
80103196:	6a 04                	push   $0x4
80103198:	68 d8 76 10 80       	push   $0x801076d8
8010319d:	56                   	push   %esi
8010319e:	e8 bd 14 00 00       	call   80104660 <memcmp>
801031a3:	83 c4 10             	add    $0x10,%esp
801031a6:	85 c0                	test   %eax,%eax
801031a8:	75 1e                	jne    801031c8 <mpsearch1+0x58>
801031aa:	8d 7e 10             	lea    0x10(%esi),%edi
801031ad:	89 f2                	mov    %esi,%edx
801031af:	31 c9                	xor    %ecx,%ecx
801031b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
801031b8:	0f b6 02             	movzbl (%edx),%eax
801031bb:	83 c2 01             	add    $0x1,%edx
801031be:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801031c0:	39 fa                	cmp    %edi,%edx
801031c2:	75 f4                	jne    801031b8 <mpsearch1+0x48>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801031c4:	84 c9                	test   %cl,%cl
801031c6:	74 10                	je     801031d8 <mpsearch1+0x68>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
801031c8:	39 fb                	cmp    %edi,%ebx
801031ca:	89 fe                	mov    %edi,%esi
801031cc:	77 c2                	ja     80103190 <mpsearch1+0x20>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
801031ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
801031d1:	31 c0                	xor    %eax,%eax
}
801031d3:	5b                   	pop    %ebx
801031d4:	5e                   	pop    %esi
801031d5:	5f                   	pop    %edi
801031d6:	5d                   	pop    %ebp
801031d7:	c3                   	ret    
801031d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031db:	89 f0                	mov    %esi,%eax
801031dd:	5b                   	pop    %ebx
801031de:	5e                   	pop    %esi
801031df:	5f                   	pop    %edi
801031e0:	5d                   	pop    %ebp
801031e1:	c3                   	ret    
801031e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801031f0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801031f0:	55                   	push   %ebp
801031f1:	89 e5                	mov    %esp,%ebp
801031f3:	57                   	push   %edi
801031f4:	56                   	push   %esi
801031f5:	53                   	push   %ebx
801031f6:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801031f9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103200:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103207:	c1 e0 08             	shl    $0x8,%eax
8010320a:	09 d0                	or     %edx,%eax
8010320c:	c1 e0 04             	shl    $0x4,%eax
8010320f:	85 c0                	test   %eax,%eax
80103211:	75 1b                	jne    8010322e <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
80103213:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010321a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103221:	c1 e0 08             	shl    $0x8,%eax
80103224:	09 d0                	or     %edx,%eax
80103226:	c1 e0 0a             	shl    $0xa,%eax
80103229:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
8010322e:	ba 00 04 00 00       	mov    $0x400,%edx
80103233:	e8 38 ff ff ff       	call   80103170 <mpsearch1>
80103238:	85 c0                	test   %eax,%eax
8010323a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010323d:	0f 84 37 01 00 00    	je     8010337a <mpinit+0x18a>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103243:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103246:	8b 58 04             	mov    0x4(%eax),%ebx
80103249:	85 db                	test   %ebx,%ebx
8010324b:	0f 84 43 01 00 00    	je     80103394 <mpinit+0x1a4>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103251:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103257:	83 ec 04             	sub    $0x4,%esp
8010325a:	6a 04                	push   $0x4
8010325c:	68 dd 76 10 80       	push   $0x801076dd
80103261:	56                   	push   %esi
80103262:	e8 f9 13 00 00       	call   80104660 <memcmp>
80103267:	83 c4 10             	add    $0x10,%esp
8010326a:	85 c0                	test   %eax,%eax
8010326c:	0f 85 22 01 00 00    	jne    80103394 <mpinit+0x1a4>
    return 0;
  if(conf->version != 1 && conf->version != 4)
80103272:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103279:	3c 01                	cmp    $0x1,%al
8010327b:	74 08                	je     80103285 <mpinit+0x95>
8010327d:	3c 04                	cmp    $0x4,%al
8010327f:	0f 85 0f 01 00 00    	jne    80103394 <mpinit+0x1a4>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80103285:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
8010328c:	85 ff                	test   %edi,%edi
8010328e:	74 21                	je     801032b1 <mpinit+0xc1>
80103290:	31 d2                	xor    %edx,%edx
80103292:	31 c0                	xor    %eax,%eax
80103294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103298:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
8010329f:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801032a0:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801032a3:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801032a5:	39 c7                	cmp    %eax,%edi
801032a7:	75 ef                	jne    80103298 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801032a9:	84 d2                	test   %dl,%dl
801032ab:	0f 85 e3 00 00 00    	jne    80103394 <mpinit+0x1a4>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801032b1:	85 f6                	test   %esi,%esi
801032b3:	0f 84 db 00 00 00    	je     80103394 <mpinit+0x1a4>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801032b9:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801032bf:	a3 1c 36 11 80       	mov    %eax,0x8011361c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032c4:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
801032cb:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
801032d1:	bb 01 00 00 00       	mov    $0x1,%ebx
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032d6:	01 d6                	add    %edx,%esi
801032d8:	90                   	nop
801032d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032e0:	39 c6                	cmp    %eax,%esi
801032e2:	76 23                	jbe    80103307 <mpinit+0x117>
801032e4:	0f b6 10             	movzbl (%eax),%edx
    switch(*p){
801032e7:	80 fa 04             	cmp    $0x4,%dl
801032ea:	0f 87 c0 00 00 00    	ja     801033b0 <mpinit+0x1c0>
801032f0:	ff 24 95 1c 77 10 80 	jmp    *-0x7fef88e4(,%edx,4)
801032f7:	89 f6                	mov    %esi,%esi
801032f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103300:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103303:	39 c6                	cmp    %eax,%esi
80103305:	77 dd                	ja     801032e4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103307:	85 db                	test   %ebx,%ebx
80103309:	0f 84 92 00 00 00    	je     801033a1 <mpinit+0x1b1>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010330f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103312:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103316:	74 15                	je     8010332d <mpinit+0x13d>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103318:	ba 22 00 00 00       	mov    $0x22,%edx
8010331d:	b8 70 00 00 00       	mov    $0x70,%eax
80103322:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103323:	ba 23 00 00 00       	mov    $0x23,%edx
80103328:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103329:	83 c8 01             	or     $0x1,%eax
8010332c:	ee                   	out    %al,(%dx)
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
8010332d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103330:	5b                   	pop    %ebx
80103331:	5e                   	pop    %esi
80103332:	5f                   	pop    %edi
80103333:	5d                   	pop    %ebp
80103334:	c3                   	ret    
80103335:	8d 76 00             	lea    0x0(%esi),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80103338:	8b 0d a0 3c 11 80    	mov    0x80113ca0,%ecx
8010333e:	83 f9 07             	cmp    $0x7,%ecx
80103341:	7f 19                	jg     8010335c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103343:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103347:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010334d:	83 c1 01             	add    $0x1,%ecx
80103350:	89 0d a0 3c 11 80    	mov    %ecx,0x80113ca0
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103356:	88 97 20 37 11 80    	mov    %dl,-0x7feec8e0(%edi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
8010335c:	83 c0 14             	add    $0x14,%eax
      continue;
8010335f:	e9 7c ff ff ff       	jmp    801032e0 <mpinit+0xf0>
80103364:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80103368:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010336c:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
8010336f:	88 15 00 37 11 80    	mov    %dl,0x80113700
      p += sizeof(struct mpioapic);
      continue;
80103375:	e9 66 ff ff ff       	jmp    801032e0 <mpinit+0xf0>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
8010337a:	ba 00 00 01 00       	mov    $0x10000,%edx
8010337f:	b8 00 00 0f 00       	mov    $0xf0000,%eax
80103384:	e8 e7 fd ff ff       	call   80103170 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103389:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
8010338b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010338e:	0f 85 af fe ff ff    	jne    80103243 <mpinit+0x53>
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
80103394:	83 ec 0c             	sub    $0xc,%esp
80103397:	68 e2 76 10 80       	push   $0x801076e2
8010339c:	e8 cf cf ff ff       	call   80100370 <panic>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
801033a1:	83 ec 0c             	sub    $0xc,%esp
801033a4:	68 fc 76 10 80       	push   $0x801076fc
801033a9:	e8 c2 cf ff ff       	call   80100370 <panic>
801033ae:	66 90                	xchg   %ax,%ax
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
801033b0:	31 db                	xor    %ebx,%ebx
801033b2:	e9 30 ff ff ff       	jmp    801032e7 <mpinit+0xf7>
801033b7:	66 90                	xchg   %ax,%ax
801033b9:	66 90                	xchg   %ax,%ax
801033bb:	66 90                	xchg   %ax,%ax
801033bd:	66 90                	xchg   %ax,%ax
801033bf:	90                   	nop

801033c0 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801033c0:	55                   	push   %ebp
801033c1:	ba 21 00 00 00       	mov    $0x21,%edx
801033c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801033cb:	89 e5                	mov    %esp,%ebp
801033cd:	ee                   	out    %al,(%dx)
801033ce:	ba a1 00 00 00       	mov    $0xa1,%edx
801033d3:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801033d4:	5d                   	pop    %ebp
801033d5:	c3                   	ret    
801033d6:	66 90                	xchg   %ax,%ax
801033d8:	66 90                	xchg   %ax,%ax
801033da:	66 90                	xchg   %ax,%ax
801033dc:	66 90                	xchg   %ax,%ax
801033de:	66 90                	xchg   %ax,%ax

801033e0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801033e0:	55                   	push   %ebp
801033e1:	89 e5                	mov    %esp,%ebp
801033e3:	57                   	push   %edi
801033e4:	56                   	push   %esi
801033e5:	53                   	push   %ebx
801033e6:	83 ec 0c             	sub    $0xc,%esp
801033e9:	8b 75 08             	mov    0x8(%ebp),%esi
801033ec:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801033ef:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801033f5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801033fb:	e8 60 db ff ff       	call   80100f60 <filealloc>
80103400:	85 c0                	test   %eax,%eax
80103402:	89 06                	mov    %eax,(%esi)
80103404:	0f 84 a8 00 00 00    	je     801034b2 <pipealloc+0xd2>
8010340a:	e8 51 db ff ff       	call   80100f60 <filealloc>
8010340f:	85 c0                	test   %eax,%eax
80103411:	89 03                	mov    %eax,(%ebx)
80103413:	0f 84 87 00 00 00    	je     801034a0 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103419:	e8 62 f2 ff ff       	call   80102680 <kalloc>
8010341e:	85 c0                	test   %eax,%eax
80103420:	89 c7                	mov    %eax,%edi
80103422:	0f 84 b0 00 00 00    	je     801034d8 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103428:	83 ec 08             	sub    $0x8,%esp
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
  p->readopen = 1;
8010342b:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103432:	00 00 00 
  p->writeopen = 1;
80103435:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010343c:	00 00 00 
  p->nwrite = 0;
8010343f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103446:	00 00 00 
  p->nread = 0;
80103449:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103450:	00 00 00 
  initlock(&p->lock, "pipe");
80103453:	68 30 77 10 80       	push   $0x80107730
80103458:	50                   	push   %eax
80103459:	e8 42 0f 00 00       	call   801043a0 <initlock>
  (*f0)->type = FD_PIPE;
8010345e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103460:	83 c4 10             	add    $0x10,%esp
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
80103463:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103469:	8b 06                	mov    (%esi),%eax
8010346b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010346f:	8b 06                	mov    (%esi),%eax
80103471:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103475:	8b 06                	mov    (%esi),%eax
80103477:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010347a:	8b 03                	mov    (%ebx),%eax
8010347c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103482:	8b 03                	mov    (%ebx),%eax
80103484:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103488:	8b 03                	mov    (%ebx),%eax
8010348a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010348e:	8b 03                	mov    (%ebx),%eax
80103490:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103493:	8d 65 f4             	lea    -0xc(%ebp),%esp
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103496:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103498:	5b                   	pop    %ebx
80103499:	5e                   	pop    %esi
8010349a:	5f                   	pop    %edi
8010349b:	5d                   	pop    %ebp
8010349c:	c3                   	ret    
8010349d:	8d 76 00             	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801034a0:	8b 06                	mov    (%esi),%eax
801034a2:	85 c0                	test   %eax,%eax
801034a4:	74 1e                	je     801034c4 <pipealloc+0xe4>
    fileclose(*f0);
801034a6:	83 ec 0c             	sub    $0xc,%esp
801034a9:	50                   	push   %eax
801034aa:	e8 71 db ff ff       	call   80101020 <fileclose>
801034af:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801034b2:	8b 03                	mov    (%ebx),%eax
801034b4:	85 c0                	test   %eax,%eax
801034b6:	74 0c                	je     801034c4 <pipealloc+0xe4>
    fileclose(*f1);
801034b8:	83 ec 0c             	sub    $0xc,%esp
801034bb:	50                   	push   %eax
801034bc:	e8 5f db ff ff       	call   80101020 <fileclose>
801034c1:	83 c4 10             	add    $0x10,%esp
  return -1;
}
801034c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
801034c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801034cc:	5b                   	pop    %ebx
801034cd:	5e                   	pop    %esi
801034ce:	5f                   	pop    %edi
801034cf:	5d                   	pop    %ebp
801034d0:	c3                   	ret    
801034d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801034d8:	8b 06                	mov    (%esi),%eax
801034da:	85 c0                	test   %eax,%eax
801034dc:	75 c8                	jne    801034a6 <pipealloc+0xc6>
801034de:	eb d2                	jmp    801034b2 <pipealloc+0xd2>

801034e0 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
801034e0:	55                   	push   %ebp
801034e1:	89 e5                	mov    %esp,%ebp
801034e3:	56                   	push   %esi
801034e4:	53                   	push   %ebx
801034e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801034e8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801034eb:	83 ec 0c             	sub    $0xc,%esp
801034ee:	53                   	push   %ebx
801034ef:	e8 ac 0f 00 00       	call   801044a0 <acquire>
  if(writable){
801034f4:	83 c4 10             	add    $0x10,%esp
801034f7:	85 f6                	test   %esi,%esi
801034f9:	74 45                	je     80103540 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
801034fb:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103501:	83 ec 0c             	sub    $0xc,%esp
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
80103504:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010350b:	00 00 00 
    wakeup(&p->nread);
8010350e:	50                   	push   %eax
8010350f:	e8 cc 0b 00 00       	call   801040e0 <wakeup>
80103514:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103517:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010351d:	85 d2                	test   %edx,%edx
8010351f:	75 0a                	jne    8010352b <pipeclose+0x4b>
80103521:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103527:	85 c0                	test   %eax,%eax
80103529:	74 35                	je     80103560 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010352b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010352e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103531:	5b                   	pop    %ebx
80103532:	5e                   	pop    %esi
80103533:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103534:	e9 87 10 00 00       	jmp    801045c0 <release>
80103539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
80103540:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103546:	83 ec 0c             	sub    $0xc,%esp
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
80103549:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103550:	00 00 00 
    wakeup(&p->nwrite);
80103553:	50                   	push   %eax
80103554:	e8 87 0b 00 00       	call   801040e0 <wakeup>
80103559:	83 c4 10             	add    $0x10,%esp
8010355c:	eb b9                	jmp    80103517 <pipeclose+0x37>
8010355e:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80103560:	83 ec 0c             	sub    $0xc,%esp
80103563:	53                   	push   %ebx
80103564:	e8 57 10 00 00       	call   801045c0 <release>
    kfree((char*)p);
80103569:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010356c:	83 c4 10             	add    $0x10,%esp
  } else
    release(&p->lock);
}
8010356f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103572:	5b                   	pop    %ebx
80103573:	5e                   	pop    %esi
80103574:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
80103575:	e9 56 ef ff ff       	jmp    801024d0 <kfree>
8010357a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103580 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103580:	55                   	push   %ebp
80103581:	89 e5                	mov    %esp,%ebp
80103583:	57                   	push   %edi
80103584:	56                   	push   %esi
80103585:	53                   	push   %ebx
80103586:	83 ec 28             	sub    $0x28,%esp
80103589:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010358c:	53                   	push   %ebx
8010358d:	e8 0e 0f 00 00       	call   801044a0 <acquire>
  for(i = 0; i < n; i++){
80103592:	8b 45 10             	mov    0x10(%ebp),%eax
80103595:	83 c4 10             	add    $0x10,%esp
80103598:	85 c0                	test   %eax,%eax
8010359a:	0f 8e b9 00 00 00    	jle    80103659 <pipewrite+0xd9>
801035a0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801035a3:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801035a9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035af:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
801035b5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801035b8:	03 4d 10             	add    0x10(%ebp),%ecx
801035bb:	89 4d e0             	mov    %ecx,-0x20(%ebp)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035be:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
801035c4:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
801035ca:	39 d0                	cmp    %edx,%eax
801035cc:	74 38                	je     80103606 <pipewrite+0x86>
801035ce:	eb 59                	jmp    80103629 <pipewrite+0xa9>
      if(p->readopen == 0 || myproc()->killed){
801035d0:	e8 9b 03 00 00       	call   80103970 <myproc>
801035d5:	8b 48 24             	mov    0x24(%eax),%ecx
801035d8:	85 c9                	test   %ecx,%ecx
801035da:	75 34                	jne    80103610 <pipewrite+0x90>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801035dc:	83 ec 0c             	sub    $0xc,%esp
801035df:	57                   	push   %edi
801035e0:	e8 fb 0a 00 00       	call   801040e0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035e5:	58                   	pop    %eax
801035e6:	5a                   	pop    %edx
801035e7:	53                   	push   %ebx
801035e8:	56                   	push   %esi
801035e9:	e8 42 09 00 00       	call   80103f30 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035ee:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801035f4:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801035fa:	83 c4 10             	add    $0x10,%esp
801035fd:	05 00 02 00 00       	add    $0x200,%eax
80103602:	39 c2                	cmp    %eax,%edx
80103604:	75 2a                	jne    80103630 <pipewrite+0xb0>
      if(p->readopen == 0 || myproc()->killed){
80103606:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010360c:	85 c0                	test   %eax,%eax
8010360e:	75 c0                	jne    801035d0 <pipewrite+0x50>
        release(&p->lock);
80103610:	83 ec 0c             	sub    $0xc,%esp
80103613:	53                   	push   %ebx
80103614:	e8 a7 0f 00 00       	call   801045c0 <release>
        return -1;
80103619:	83 c4 10             	add    $0x10,%esp
8010361c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103621:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103624:	5b                   	pop    %ebx
80103625:	5e                   	pop    %esi
80103626:	5f                   	pop    %edi
80103627:	5d                   	pop    %ebp
80103628:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103629:	89 c2                	mov    %eax,%edx
8010362b:	90                   	nop
8010362c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103630:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103633:	8d 42 01             	lea    0x1(%edx),%eax
80103636:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010363a:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103640:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103646:	0f b6 09             	movzbl (%ecx),%ecx
80103649:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
8010364d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80103650:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
80103653:	0f 85 65 ff ff ff    	jne    801035be <pipewrite+0x3e>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103659:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010365f:	83 ec 0c             	sub    $0xc,%esp
80103662:	50                   	push   %eax
80103663:	e8 78 0a 00 00       	call   801040e0 <wakeup>
  release(&p->lock);
80103668:	89 1c 24             	mov    %ebx,(%esp)
8010366b:	e8 50 0f 00 00       	call   801045c0 <release>
  return n;
80103670:	83 c4 10             	add    $0x10,%esp
80103673:	8b 45 10             	mov    0x10(%ebp),%eax
80103676:	eb a9                	jmp    80103621 <pipewrite+0xa1>
80103678:	90                   	nop
80103679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103680 <piperead>:
}

int
piperead(struct pipe *p, char *addr, int n)
{
80103680:	55                   	push   %ebp
80103681:	89 e5                	mov    %esp,%ebp
80103683:	57                   	push   %edi
80103684:	56                   	push   %esi
80103685:	53                   	push   %ebx
80103686:	83 ec 18             	sub    $0x18,%esp
80103689:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010368c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010368f:	53                   	push   %ebx
80103690:	e8 0b 0e 00 00       	call   801044a0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103695:	83 c4 10             	add    $0x10,%esp
80103698:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010369e:	39 83 38 02 00 00    	cmp    %eax,0x238(%ebx)
801036a4:	75 6a                	jne    80103710 <piperead+0x90>
801036a6:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
801036ac:	85 f6                	test   %esi,%esi
801036ae:	0f 84 cc 00 00 00    	je     80103780 <piperead+0x100>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801036b4:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
801036ba:	eb 2d                	jmp    801036e9 <piperead+0x69>
801036bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036c0:	83 ec 08             	sub    $0x8,%esp
801036c3:	53                   	push   %ebx
801036c4:	56                   	push   %esi
801036c5:	e8 66 08 00 00       	call   80103f30 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036ca:	83 c4 10             	add    $0x10,%esp
801036cd:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801036d3:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
801036d9:	75 35                	jne    80103710 <piperead+0x90>
801036db:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
801036e1:	85 d2                	test   %edx,%edx
801036e3:	0f 84 97 00 00 00    	je     80103780 <piperead+0x100>
    if(myproc()->killed){
801036e9:	e8 82 02 00 00       	call   80103970 <myproc>
801036ee:	8b 48 24             	mov    0x24(%eax),%ecx
801036f1:	85 c9                	test   %ecx,%ecx
801036f3:	74 cb                	je     801036c0 <piperead+0x40>
      release(&p->lock);
801036f5:	83 ec 0c             	sub    $0xc,%esp
801036f8:	53                   	push   %ebx
801036f9:	e8 c2 0e 00 00       	call   801045c0 <release>
      return -1;
801036fe:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103701:	8d 65 f4             	lea    -0xc(%ebp),%esp

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(myproc()->killed){
      release(&p->lock);
      return -1;
80103704:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103709:	5b                   	pop    %ebx
8010370a:	5e                   	pop    %esi
8010370b:	5f                   	pop    %edi
8010370c:	5d                   	pop    %ebp
8010370d:	c3                   	ret    
8010370e:	66 90                	xchg   %ax,%ax
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103710:	8b 45 10             	mov    0x10(%ebp),%eax
80103713:	85 c0                	test   %eax,%eax
80103715:	7e 69                	jle    80103780 <piperead+0x100>
    if(p->nread == p->nwrite)
80103717:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010371d:	31 c9                	xor    %ecx,%ecx
8010371f:	eb 15                	jmp    80103736 <piperead+0xb6>
80103721:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103728:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010372e:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
80103734:	74 5a                	je     80103790 <piperead+0x110>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103736:	8d 70 01             	lea    0x1(%eax),%esi
80103739:	25 ff 01 00 00       	and    $0x1ff,%eax
8010373e:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
80103744:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
80103749:	88 04 0f             	mov    %al,(%edi,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010374c:	83 c1 01             	add    $0x1,%ecx
8010374f:	39 4d 10             	cmp    %ecx,0x10(%ebp)
80103752:	75 d4                	jne    80103728 <piperead+0xa8>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103754:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
8010375a:	83 ec 0c             	sub    $0xc,%esp
8010375d:	50                   	push   %eax
8010375e:	e8 7d 09 00 00       	call   801040e0 <wakeup>
  release(&p->lock);
80103763:	89 1c 24             	mov    %ebx,(%esp)
80103766:	e8 55 0e 00 00       	call   801045c0 <release>
  return i;
8010376b:	8b 45 10             	mov    0x10(%ebp),%eax
8010376e:	83 c4 10             	add    $0x10,%esp
}
80103771:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103774:	5b                   	pop    %ebx
80103775:	5e                   	pop    %esi
80103776:	5f                   	pop    %edi
80103777:	5d                   	pop    %ebp
80103778:	c3                   	ret    
80103779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103780:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
80103787:	eb cb                	jmp    80103754 <piperead+0xd4>
80103789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103790:	89 4d 10             	mov    %ecx,0x10(%ebp)
80103793:	eb bf                	jmp    80103754 <piperead+0xd4>
80103795:	66 90                	xchg   %ax,%ax
80103797:	66 90                	xchg   %ax,%ax
80103799:	66 90                	xchg   %ax,%ax
8010379b:	66 90                	xchg   %ax,%ax
8010379d:	66 90                	xchg   %ax,%ax
8010379f:	90                   	nop

801037a0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801037a0:	55                   	push   %ebp
801037a1:	89 e5                	mov    %esp,%ebp
801037a3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037a4:	bb f4 3c 11 80       	mov    $0x80113cf4,%ebx
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801037a9:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
801037ac:	68 c0 3c 11 80       	push   $0x80113cc0
801037b1:	e8 ea 0c 00 00       	call   801044a0 <acquire>
801037b6:	83 c4 10             	add    $0x10,%esp
801037b9:	eb 10                	jmp    801037cb <allocproc+0x2b>
801037bb:	90                   	nop
801037bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037c0:	83 c3 7c             	add    $0x7c,%ebx
801037c3:	81 fb f4 5b 11 80    	cmp    $0x80115bf4,%ebx
801037c9:	74 75                	je     80103840 <allocproc+0xa0>
    if(p->state == UNUSED)
801037cb:	8b 43 0c             	mov    0xc(%ebx),%eax
801037ce:	85 c0                	test   %eax,%eax
801037d0:	75 ee                	jne    801037c0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801037d2:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
801037d7:	83 ec 0c             	sub    $0xc,%esp

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
801037da:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;

  release(&ptable.lock);
801037e1:	68 c0 3c 11 80       	push   $0x80113cc0
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801037e6:	8d 50 01             	lea    0x1(%eax),%edx
801037e9:	89 43 10             	mov    %eax,0x10(%ebx)
801037ec:	89 15 04 a0 10 80    	mov    %edx,0x8010a004

  release(&ptable.lock);
801037f2:	e8 c9 0d 00 00       	call   801045c0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801037f7:	e8 84 ee ff ff       	call   80102680 <kalloc>
801037fc:	83 c4 10             	add    $0x10,%esp
801037ff:	85 c0                	test   %eax,%eax
80103801:	89 43 08             	mov    %eax,0x8(%ebx)
80103804:	74 51                	je     80103857 <allocproc+0xb7>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103806:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010380c:	83 ec 04             	sub    $0x4,%esp
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
8010380f:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103814:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
80103817:	c7 40 14 50 59 10 80 	movl   $0x80105950,0x14(%eax)

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010381e:	6a 14                	push   $0x14
80103820:	6a 00                	push   $0x0
80103822:	50                   	push   %eax
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
80103823:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103826:	e8 e5 0d 00 00       	call   80104610 <memset>
  p->context->eip = (uint)forkret;
8010382b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010382e:	83 c4 10             	add    $0x10,%esp
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
80103831:	c7 40 10 60 38 10 80 	movl   $0x80103860,0x10(%eax)

  return p;
80103838:	89 d8                	mov    %ebx,%eax
}
8010383a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010383d:	c9                   	leave  
8010383e:	c3                   	ret    
8010383f:	90                   	nop

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80103840:	83 ec 0c             	sub    $0xc,%esp
80103843:	68 c0 3c 11 80       	push   $0x80113cc0
80103848:	e8 73 0d 00 00       	call   801045c0 <release>
  return 0;
8010384d:	83 c4 10             	add    $0x10,%esp
80103850:	31 c0                	xor    %eax,%eax
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
80103852:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103855:	c9                   	leave  
80103856:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
80103857:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
8010385e:	eb da                	jmp    8010383a <allocproc+0x9a>

80103860 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103860:	55                   	push   %ebp
80103861:	89 e5                	mov    %esp,%ebp
80103863:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103866:	68 c0 3c 11 80       	push   $0x80113cc0
8010386b:	e8 50 0d 00 00       	call   801045c0 <release>

  if (first) {
80103870:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103875:	83 c4 10             	add    $0x10,%esp
80103878:	85 c0                	test   %eax,%eax
8010387a:	75 04                	jne    80103880 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010387c:	c9                   	leave  
8010387d:	c3                   	ret    
8010387e:	66 90                	xchg   %ax,%ax
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
80103880:	83 ec 0c             	sub    $0xc,%esp

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80103883:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
8010388a:	00 00 00 
    iinit(ROOTDEV);
8010388d:	6a 01                	push   $0x1
8010388f:	e8 cc dd ff ff       	call   80101660 <iinit>
    initlog(ROOTDEV);
80103894:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010389b:	e8 00 f4 ff ff       	call   80102ca0 <initlog>
801038a0:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
801038a3:	c9                   	leave  
801038a4:	c3                   	ret    
801038a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801038a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801038b0 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
801038b0:	55                   	push   %ebp
801038b1:	89 e5                	mov    %esp,%ebp
801038b3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801038b6:	68 35 77 10 80       	push   $0x80107735
801038bb:	68 c0 3c 11 80       	push   $0x80113cc0
801038c0:	e8 db 0a 00 00       	call   801043a0 <initlock>
}
801038c5:	83 c4 10             	add    $0x10,%esp
801038c8:	c9                   	leave  
801038c9:	c3                   	ret    
801038ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801038d0 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
801038d0:	55                   	push   %ebp
801038d1:	89 e5                	mov    %esp,%ebp
801038d3:	56                   	push   %esi
801038d4:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801038d5:	9c                   	pushf  
801038d6:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
801038d7:	f6 c4 02             	test   $0x2,%ah
801038da:	75 5b                	jne    80103937 <mycpu+0x67>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
801038dc:	e8 ff ef ff ff       	call   801028e0 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
801038e1:	8b 35 a0 3c 11 80    	mov    0x80113ca0,%esi
801038e7:	85 f6                	test   %esi,%esi
801038e9:	7e 3f                	jle    8010392a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
801038eb:	0f b6 15 20 37 11 80 	movzbl 0x80113720,%edx
801038f2:	39 d0                	cmp    %edx,%eax
801038f4:	74 30                	je     80103926 <mycpu+0x56>
801038f6:	b9 d0 37 11 80       	mov    $0x801137d0,%ecx
801038fb:	31 d2                	xor    %edx,%edx
801038fd:	8d 76 00             	lea    0x0(%esi),%esi
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103900:	83 c2 01             	add    $0x1,%edx
80103903:	39 f2                	cmp    %esi,%edx
80103905:	74 23                	je     8010392a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
80103907:	0f b6 19             	movzbl (%ecx),%ebx
8010390a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103910:	39 d8                	cmp    %ebx,%eax
80103912:	75 ec                	jne    80103900 <mycpu+0x30>
      return &cpus[i];
80103914:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
  }
  panic("unknown apicid\n");
}
8010391a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010391d:	5b                   	pop    %ebx
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
8010391e:	05 20 37 11 80       	add    $0x80113720,%eax
  }
  panic("unknown apicid\n");
}
80103923:	5e                   	pop    %esi
80103924:	5d                   	pop    %ebp
80103925:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103926:	31 d2                	xor    %edx,%edx
80103928:	eb ea                	jmp    80103914 <mycpu+0x44>
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
8010392a:	83 ec 0c             	sub    $0xc,%esp
8010392d:	68 3c 77 10 80       	push   $0x8010773c
80103932:	e8 39 ca ff ff       	call   80100370 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
80103937:	83 ec 0c             	sub    $0xc,%esp
8010393a:	68 18 78 10 80       	push   $0x80107818
8010393f:	e8 2c ca ff ff       	call   80100370 <panic>
80103944:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010394a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103950 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
80103950:	55                   	push   %ebp
80103951:	89 e5                	mov    %esp,%ebp
80103953:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103956:	e8 75 ff ff ff       	call   801038d0 <mycpu>
8010395b:	2d 20 37 11 80       	sub    $0x80113720,%eax
}
80103960:	c9                   	leave  
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
80103961:	c1 f8 04             	sar    $0x4,%eax
80103964:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010396a:	c3                   	ret    
8010396b:	90                   	nop
8010396c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103970 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
80103970:	55                   	push   %ebp
80103971:	89 e5                	mov    %esp,%ebp
80103973:	53                   	push   %ebx
80103974:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
80103977:	e8 e4 0a 00 00       	call   80104460 <pushcli>
  c = mycpu();
8010397c:	e8 4f ff ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103981:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103987:	e8 c4 0b 00 00       	call   80104550 <popcli>
  return p;
}
8010398c:	83 c4 04             	add    $0x4,%esp
8010398f:	89 d8                	mov    %ebx,%eax
80103991:	5b                   	pop    %ebx
80103992:	5d                   	pop    %ebp
80103993:	c3                   	ret    
80103994:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010399a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801039a0 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
801039a0:	55                   	push   %ebp
801039a1:	89 e5                	mov    %esp,%ebp
801039a3:	53                   	push   %ebx
801039a4:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
801039a7:	e8 f4 fd ff ff       	call   801037a0 <allocproc>
801039ac:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
801039ae:	a3 58 b5 10 80       	mov    %eax,0x8010b558
  if((p->pgdir = setupkvm()) == 0)
801039b3:	e8 88 35 00 00       	call   80106f40 <setupkvm>
801039b8:	85 c0                	test   %eax,%eax
801039ba:	89 43 04             	mov    %eax,0x4(%ebx)
801039bd:	0f 84 bd 00 00 00    	je     80103a80 <userinit+0xe0>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801039c3:	83 ec 04             	sub    $0x4,%esp
801039c6:	68 2c 00 00 00       	push   $0x2c
801039cb:	68 60 a4 10 80       	push   $0x8010a460
801039d0:	50                   	push   %eax
801039d1:	e8 7a 32 00 00       	call   80106c50 <inituvm>
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
801039d6:	83 c4 0c             	add    $0xc,%esp
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
801039d9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801039df:	6a 4c                	push   $0x4c
801039e1:	6a 00                	push   $0x0
801039e3:	ff 73 18             	pushl  0x18(%ebx)
801039e6:	e8 25 0c 00 00       	call   80104610 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801039eb:	8b 43 18             	mov    0x18(%ebx),%eax
801039ee:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801039f3:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
801039f8:	83 c4 0c             	add    $0xc,%esp
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801039fb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801039ff:	8b 43 18             	mov    0x18(%ebx),%eax
80103a02:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103a06:	8b 43 18             	mov    0x18(%ebx),%eax
80103a09:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a0d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103a11:	8b 43 18             	mov    0x18(%ebx),%eax
80103a14:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a18:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103a1c:	8b 43 18             	mov    0x18(%ebx),%eax
80103a1f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103a26:	8b 43 18             	mov    0x18(%ebx),%eax
80103a29:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103a30:	8b 43 18             	mov    0x18(%ebx),%eax
80103a33:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a3a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103a3d:	6a 10                	push   $0x10
80103a3f:	68 65 77 10 80       	push   $0x80107765
80103a44:	50                   	push   %eax
80103a45:	e8 c6 0d 00 00       	call   80104810 <safestrcpy>
  p->cwd = namei("/");
80103a4a:	c7 04 24 6e 77 10 80 	movl   $0x8010776e,(%esp)
80103a51:	e8 5a e6 ff ff       	call   801020b0 <namei>
80103a56:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80103a59:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103a60:	e8 3b 0a 00 00       	call   801044a0 <acquire>

  p->state = RUNNABLE;
80103a65:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
80103a6c:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103a73:	e8 48 0b 00 00       	call   801045c0 <release>
}
80103a78:	83 c4 10             	add    $0x10,%esp
80103a7b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a7e:	c9                   	leave  
80103a7f:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
80103a80:	83 ec 0c             	sub    $0xc,%esp
80103a83:	68 4c 77 10 80       	push   $0x8010774c
80103a88:	e8 e3 c8 ff ff       	call   80100370 <panic>
80103a8d:	8d 76 00             	lea    0x0(%esi),%esi

80103a90 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80103a90:	55                   	push   %ebp
80103a91:	89 e5                	mov    %esp,%ebp
80103a93:	56                   	push   %esi
80103a94:	53                   	push   %ebx
80103a95:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103a98:	e8 c3 09 00 00       	call   80104460 <pushcli>
  c = mycpu();
80103a9d:	e8 2e fe ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103aa2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103aa8:	e8 a3 0a 00 00       	call   80104550 <popcli>
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
80103aad:	83 fe 00             	cmp    $0x0,%esi
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
80103ab0:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103ab2:	7e 34                	jle    80103ae8 <growproc+0x58>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103ab4:	83 ec 04             	sub    $0x4,%esp
80103ab7:	01 c6                	add    %eax,%esi
80103ab9:	56                   	push   %esi
80103aba:	50                   	push   %eax
80103abb:	ff 73 04             	pushl  0x4(%ebx)
80103abe:	e8 cd 32 00 00       	call   80106d90 <allocuvm>
80103ac3:	83 c4 10             	add    $0x10,%esp
80103ac6:	85 c0                	test   %eax,%eax
80103ac8:	74 36                	je     80103b00 <growproc+0x70>
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
80103aca:	83 ec 0c             	sub    $0xc,%esp
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
80103acd:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103acf:	53                   	push   %ebx
80103ad0:	e8 6b 30 00 00       	call   80106b40 <switchuvm>
  return 0;
80103ad5:	83 c4 10             	add    $0x10,%esp
80103ad8:	31 c0                	xor    %eax,%eax
}
80103ada:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103add:	5b                   	pop    %ebx
80103ade:	5e                   	pop    %esi
80103adf:	5d                   	pop    %ebp
80103ae0:	c3                   	ret    
80103ae1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80103ae8:	74 e0                	je     80103aca <growproc+0x3a>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103aea:	83 ec 04             	sub    $0x4,%esp
80103aed:	01 c6                	add    %eax,%esi
80103aef:	56                   	push   %esi
80103af0:	50                   	push   %eax
80103af1:	ff 73 04             	pushl  0x4(%ebx)
80103af4:	e8 97 33 00 00       	call   80106e90 <deallocuvm>
80103af9:	83 c4 10             	add    $0x10,%esp
80103afc:	85 c0                	test   %eax,%eax
80103afe:	75 ca                	jne    80103aca <growproc+0x3a>
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
80103b00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b05:	eb d3                	jmp    80103ada <growproc+0x4a>
80103b07:	89 f6                	mov    %esi,%esi
80103b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b10 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103b10:	55                   	push   %ebp
80103b11:	89 e5                	mov    %esp,%ebp
80103b13:	57                   	push   %edi
80103b14:	56                   	push   %esi
80103b15:	53                   	push   %ebx
80103b16:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103b19:	e8 42 09 00 00       	call   80104460 <pushcli>
  c = mycpu();
80103b1e:	e8 ad fd ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103b23:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b29:	e8 22 0a 00 00       	call   80104550 <popcli>
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
80103b2e:	e8 6d fc ff ff       	call   801037a0 <allocproc>
80103b33:	85 c0                	test   %eax,%eax
80103b35:	89 c7                	mov    %eax,%edi
80103b37:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103b3a:	0f 84 b5 00 00 00    	je     80103bf5 <fork+0xe5>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103b40:	83 ec 08             	sub    $0x8,%esp
80103b43:	ff 33                	pushl  (%ebx)
80103b45:	ff 73 04             	pushl  0x4(%ebx)
80103b48:	e8 c3 34 00 00       	call   80107010 <copyuvm>
80103b4d:	83 c4 10             	add    $0x10,%esp
80103b50:	85 c0                	test   %eax,%eax
80103b52:	89 47 04             	mov    %eax,0x4(%edi)
80103b55:	0f 84 a1 00 00 00    	je     80103bfc <fork+0xec>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
80103b5b:	8b 03                	mov    (%ebx),%eax
80103b5d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103b60:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103b62:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103b65:	89 c8                	mov    %ecx,%eax
80103b67:	8b 79 18             	mov    0x18(%ecx),%edi
80103b6a:	8b 73 18             	mov    0x18(%ebx),%esi
80103b6d:	b9 13 00 00 00       	mov    $0x13,%ecx
80103b72:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103b74:	31 f6                	xor    %esi,%esi
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103b76:	8b 40 18             	mov    0x18(%eax),%eax
80103b79:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
80103b80:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103b84:	85 c0                	test   %eax,%eax
80103b86:	74 13                	je     80103b9b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103b88:	83 ec 0c             	sub    $0xc,%esp
80103b8b:	50                   	push   %eax
80103b8c:	e8 3f d4 ff ff       	call   80100fd0 <filedup>
80103b91:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103b94:	83 c4 10             	add    $0x10,%esp
80103b97:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103b9b:	83 c6 01             	add    $0x1,%esi
80103b9e:	83 fe 10             	cmp    $0x10,%esi
80103ba1:	75 dd                	jne    80103b80 <fork+0x70>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103ba3:	83 ec 0c             	sub    $0xc,%esp
80103ba6:	ff 73 68             	pushl  0x68(%ebx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ba9:	83 c3 6c             	add    $0x6c,%ebx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103bac:	e8 7f dc ff ff       	call   80101830 <idup>
80103bb1:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103bb4:	83 c4 0c             	add    $0xc,%esp
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103bb7:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103bba:	8d 47 6c             	lea    0x6c(%edi),%eax
80103bbd:	6a 10                	push   $0x10
80103bbf:	53                   	push   %ebx
80103bc0:	50                   	push   %eax
80103bc1:	e8 4a 0c 00 00       	call   80104810 <safestrcpy>

  pid = np->pid;
80103bc6:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
80103bc9:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103bd0:	e8 cb 08 00 00       	call   801044a0 <acquire>

  np->state = RUNNABLE;
80103bd5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
80103bdc:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103be3:	e8 d8 09 00 00       	call   801045c0 <release>

  return pid;
80103be8:	83 c4 10             	add    $0x10,%esp
80103beb:	89 d8                	mov    %ebx,%eax
}
80103bed:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103bf0:	5b                   	pop    %ebx
80103bf1:	5e                   	pop    %esi
80103bf2:	5f                   	pop    %edi
80103bf3:	5d                   	pop    %ebp
80103bf4:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103bf5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103bfa:	eb f1                	jmp    80103bed <fork+0xdd>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
80103bfc:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103bff:	83 ec 0c             	sub    $0xc,%esp
80103c02:	ff 77 08             	pushl  0x8(%edi)
80103c05:	e8 c6 e8 ff ff       	call   801024d0 <kfree>
    np->kstack = 0;
80103c0a:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103c11:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103c18:	83 c4 10             	add    $0x10,%esp
80103c1b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103c20:	eb cb                	jmp    80103bed <fork+0xdd>
80103c22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c30 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103c30:	55                   	push   %ebp
80103c31:	89 e5                	mov    %esp,%ebp
80103c33:	57                   	push   %edi
80103c34:	56                   	push   %esi
80103c35:	53                   	push   %ebx
80103c36:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80103c39:	e8 92 fc ff ff       	call   801038d0 <mycpu>
80103c3e:	8d 78 04             	lea    0x4(%eax),%edi
80103c41:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103c43:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103c4a:	00 00 00 
80103c4d:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103c50:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103c51:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c54:	bb f4 3c 11 80       	mov    $0x80113cf4,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103c59:	68 c0 3c 11 80       	push   $0x80113cc0
80103c5e:	e8 3d 08 00 00       	call   801044a0 <acquire>
80103c63:	83 c4 10             	add    $0x10,%esp
80103c66:	eb 13                	jmp    80103c7b <scheduler+0x4b>
80103c68:	90                   	nop
80103c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c70:	83 c3 7c             	add    $0x7c,%ebx
80103c73:	81 fb f4 5b 11 80    	cmp    $0x80115bf4,%ebx
80103c79:	74 45                	je     80103cc0 <scheduler+0x90>
      if(p->state != RUNNABLE)
80103c7b:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103c7f:	75 ef                	jne    80103c70 <scheduler+0x40>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103c81:	83 ec 0c             	sub    $0xc,%esp
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
80103c84:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103c8a:	53                   	push   %ebx
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c8b:	83 c3 7c             	add    $0x7c,%ebx

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103c8e:	e8 ad 2e 00 00       	call   80106b40 <switchuvm>
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
80103c93:	58                   	pop    %eax
80103c94:	5a                   	pop    %edx
80103c95:	ff 73 a0             	pushl  -0x60(%ebx)
80103c98:	57                   	push   %edi
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103c99:	c7 43 90 04 00 00 00 	movl   $0x4,-0x70(%ebx)

      swtch(&(c->scheduler), p->context);
80103ca0:	e8 c6 0b 00 00       	call   8010486b <swtch>
      switchkvm();
80103ca5:	e8 76 2e 00 00       	call   80106b20 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103caa:	83 c4 10             	add    $0x10,%esp
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103cad:	81 fb f4 5b 11 80    	cmp    $0x80115bf4,%ebx
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103cb3:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103cba:	00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103cbd:	75 bc                	jne    80103c7b <scheduler+0x4b>
80103cbf:	90                   	nop

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
80103cc0:	83 ec 0c             	sub    $0xc,%esp
80103cc3:	68 c0 3c 11 80       	push   $0x80113cc0
80103cc8:	e8 f3 08 00 00       	call   801045c0 <release>

  }
80103ccd:	83 c4 10             	add    $0x10,%esp
80103cd0:	e9 7b ff ff ff       	jmp    80103c50 <scheduler+0x20>
80103cd5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ce0 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103ce0:	55                   	push   %ebp
80103ce1:	89 e5                	mov    %esp,%ebp
80103ce3:	56                   	push   %esi
80103ce4:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103ce5:	e8 76 07 00 00       	call   80104460 <pushcli>
  c = mycpu();
80103cea:	e8 e1 fb ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103cef:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103cf5:	e8 56 08 00 00       	call   80104550 <popcli>
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
80103cfa:	83 ec 0c             	sub    $0xc,%esp
80103cfd:	68 c0 3c 11 80       	push   $0x80113cc0
80103d02:	e8 19 07 00 00       	call   80104420 <holding>
80103d07:	83 c4 10             	add    $0x10,%esp
80103d0a:	85 c0                	test   %eax,%eax
80103d0c:	74 4f                	je     80103d5d <sched+0x7d>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
80103d0e:	e8 bd fb ff ff       	call   801038d0 <mycpu>
80103d13:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103d1a:	75 68                	jne    80103d84 <sched+0xa4>
    panic("sched locks");
  if(p->state == RUNNING)
80103d1c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103d20:	74 55                	je     80103d77 <sched+0x97>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103d22:	9c                   	pushf  
80103d23:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
80103d24:	f6 c4 02             	test   $0x2,%ah
80103d27:	75 41                	jne    80103d6a <sched+0x8a>
    panic("sched interruptible");
  intena = mycpu()->intena;
80103d29:	e8 a2 fb ff ff       	call   801038d0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103d2e:	83 c3 1c             	add    $0x1c,%ebx
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
80103d31:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103d37:	e8 94 fb ff ff       	call   801038d0 <mycpu>
80103d3c:	83 ec 08             	sub    $0x8,%esp
80103d3f:	ff 70 04             	pushl  0x4(%eax)
80103d42:	53                   	push   %ebx
80103d43:	e8 23 0b 00 00       	call   8010486b <swtch>
  mycpu()->intena = intena;
80103d48:	e8 83 fb ff ff       	call   801038d0 <mycpu>
}
80103d4d:	83 c4 10             	add    $0x10,%esp
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
80103d50:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103d56:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103d59:	5b                   	pop    %ebx
80103d5a:	5e                   	pop    %esi
80103d5b:	5d                   	pop    %ebp
80103d5c:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103d5d:	83 ec 0c             	sub    $0xc,%esp
80103d60:	68 70 77 10 80       	push   $0x80107770
80103d65:	e8 06 c6 ff ff       	call   80100370 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103d6a:	83 ec 0c             	sub    $0xc,%esp
80103d6d:	68 9c 77 10 80       	push   $0x8010779c
80103d72:	e8 f9 c5 ff ff       	call   80100370 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
80103d77:	83 ec 0c             	sub    $0xc,%esp
80103d7a:	68 8e 77 10 80       	push   $0x8010778e
80103d7f:	e8 ec c5 ff ff       	call   80100370 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80103d84:	83 ec 0c             	sub    $0xc,%esp
80103d87:	68 82 77 10 80       	push   $0x80107782
80103d8c:	e8 df c5 ff ff       	call   80100370 <panic>
80103d91:	eb 0d                	jmp    80103da0 <exit>
80103d93:	90                   	nop
80103d94:	90                   	nop
80103d95:	90                   	nop
80103d96:	90                   	nop
80103d97:	90                   	nop
80103d98:	90                   	nop
80103d99:	90                   	nop
80103d9a:	90                   	nop
80103d9b:	90                   	nop
80103d9c:	90                   	nop
80103d9d:	90                   	nop
80103d9e:	90                   	nop
80103d9f:	90                   	nop

80103da0 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103da0:	55                   	push   %ebp
80103da1:	89 e5                	mov    %esp,%ebp
80103da3:	57                   	push   %edi
80103da4:	56                   	push   %esi
80103da5:	53                   	push   %ebx
80103da6:	83 ec 0c             	sub    $0xc,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103da9:	e8 b2 06 00 00       	call   80104460 <pushcli>
  c = mycpu();
80103dae:	e8 1d fb ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103db3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103db9:	e8 92 07 00 00       	call   80104550 <popcli>
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  freescreen(curproc->pid);
80103dbe:	83 ec 0c             	sub    $0xc,%esp
80103dc1:	ff 76 10             	pushl  0x10(%esi)
80103dc4:	8d 5e 28             	lea    0x28(%esi),%ebx
80103dc7:	8d 7e 68             	lea    0x68(%esi),%edi
80103dca:	e8 d1 ca ff ff       	call   801008a0 <freescreen>

  if(curproc == initproc)
80103dcf:	83 c4 10             	add    $0x10,%esp
80103dd2:	39 35 58 b5 10 80    	cmp    %esi,0x8010b558
80103dd8:	0f 84 e9 00 00 00    	je     80103ec7 <exit+0x127>
80103dde:	66 90                	xchg   %ax,%ax
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
80103de0:	8b 03                	mov    (%ebx),%eax
80103de2:	85 c0                	test   %eax,%eax
80103de4:	74 12                	je     80103df8 <exit+0x58>
      fileclose(curproc->ofile[fd]);
80103de6:	83 ec 0c             	sub    $0xc,%esp
80103de9:	50                   	push   %eax
80103dea:	e8 31 d2 ff ff       	call   80101020 <fileclose>
      curproc->ofile[fd] = 0;
80103def:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103df5:	83 c4 10             	add    $0x10,%esp
80103df8:	83 c3 04             	add    $0x4,%ebx

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103dfb:	39 df                	cmp    %ebx,%edi
80103dfd:	75 e1                	jne    80103de0 <exit+0x40>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
80103dff:	e8 3c ef ff ff       	call   80102d40 <begin_op>
  iput(curproc->cwd);
80103e04:	83 ec 0c             	sub    $0xc,%esp
80103e07:	ff 76 68             	pushl  0x68(%esi)
80103e0a:	e8 81 db ff ff       	call   80101990 <iput>
  end_op();
80103e0f:	e8 9c ef ff ff       	call   80102db0 <end_op>
  curproc->cwd = 0;
80103e14:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)

  acquire(&ptable.lock);
80103e1b:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103e22:	e8 79 06 00 00       	call   801044a0 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80103e27:	8b 56 14             	mov    0x14(%esi),%edx
80103e2a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e2d:	b8 f4 3c 11 80       	mov    $0x80113cf4,%eax
80103e32:	eb 0e                	jmp    80103e42 <exit+0xa2>
80103e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e38:	83 c0 7c             	add    $0x7c,%eax
80103e3b:	3d f4 5b 11 80       	cmp    $0x80115bf4,%eax
80103e40:	74 1c                	je     80103e5e <exit+0xbe>
    if(p->state == SLEEPING && p->chan == chan)
80103e42:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e46:	75 f0                	jne    80103e38 <exit+0x98>
80103e48:	3b 50 20             	cmp    0x20(%eax),%edx
80103e4b:	75 eb                	jne    80103e38 <exit+0x98>
      p->state = RUNNABLE;
80103e4d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e54:	83 c0 7c             	add    $0x7c,%eax
80103e57:	3d f4 5b 11 80       	cmp    $0x80115bf4,%eax
80103e5c:	75 e4                	jne    80103e42 <exit+0xa2>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103e5e:	8b 0d 58 b5 10 80    	mov    0x8010b558,%ecx
80103e64:	ba f4 3c 11 80       	mov    $0x80113cf4,%edx
80103e69:	eb 10                	jmp    80103e7b <exit+0xdb>
80103e6b:	90                   	nop
80103e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e70:	83 c2 7c             	add    $0x7c,%edx
80103e73:	81 fa f4 5b 11 80    	cmp    $0x80115bf4,%edx
80103e79:	74 33                	je     80103eae <exit+0x10e>
    if(p->parent == curproc){
80103e7b:	39 72 14             	cmp    %esi,0x14(%edx)
80103e7e:	75 f0                	jne    80103e70 <exit+0xd0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103e80:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103e84:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103e87:	75 e7                	jne    80103e70 <exit+0xd0>
80103e89:	b8 f4 3c 11 80       	mov    $0x80113cf4,%eax
80103e8e:	eb 0a                	jmp    80103e9a <exit+0xfa>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e90:	83 c0 7c             	add    $0x7c,%eax
80103e93:	3d f4 5b 11 80       	cmp    $0x80115bf4,%eax
80103e98:	74 d6                	je     80103e70 <exit+0xd0>
    if(p->state == SLEEPING && p->chan == chan)
80103e9a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e9e:	75 f0                	jne    80103e90 <exit+0xf0>
80103ea0:	3b 48 20             	cmp    0x20(%eax),%ecx
80103ea3:	75 eb                	jne    80103e90 <exit+0xf0>
      p->state = RUNNABLE;
80103ea5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103eac:	eb e2                	jmp    80103e90 <exit+0xf0>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80103eae:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103eb5:	e8 26 fe ff ff       	call   80103ce0 <sched>
  panic("zombie exit");
80103eba:	83 ec 0c             	sub    $0xc,%esp
80103ebd:	68 bd 77 10 80       	push   $0x801077bd
80103ec2:	e8 a9 c4 ff ff       	call   80100370 <panic>
  int fd;

  freescreen(curproc->pid);

  if(curproc == initproc)
    panic("init exiting");
80103ec7:	83 ec 0c             	sub    $0xc,%esp
80103eca:	68 b0 77 10 80       	push   $0x801077b0
80103ecf:	e8 9c c4 ff ff       	call   80100370 <panic>
80103ed4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103eda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103ee0 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103ee0:	55                   	push   %ebp
80103ee1:	89 e5                	mov    %esp,%ebp
80103ee3:	53                   	push   %ebx
80103ee4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103ee7:	68 c0 3c 11 80       	push   $0x80113cc0
80103eec:	e8 af 05 00 00       	call   801044a0 <acquire>
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103ef1:	e8 6a 05 00 00       	call   80104460 <pushcli>
  c = mycpu();
80103ef6:	e8 d5 f9 ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103efb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f01:	e8 4a 06 00 00       	call   80104550 <popcli>
// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
80103f06:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103f0d:	e8 ce fd ff ff       	call   80103ce0 <sched>
  release(&ptable.lock);
80103f12:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103f19:	e8 a2 06 00 00       	call   801045c0 <release>
}
80103f1e:	83 c4 10             	add    $0x10,%esp
80103f21:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f24:	c9                   	leave  
80103f25:	c3                   	ret    
80103f26:	8d 76 00             	lea    0x0(%esi),%esi
80103f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103f30 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103f30:	55                   	push   %ebp
80103f31:	89 e5                	mov    %esp,%ebp
80103f33:	57                   	push   %edi
80103f34:	56                   	push   %esi
80103f35:	53                   	push   %ebx
80103f36:	83 ec 0c             	sub    $0xc,%esp
80103f39:	8b 7d 08             	mov    0x8(%ebp),%edi
80103f3c:	8b 75 0c             	mov    0xc(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103f3f:	e8 1c 05 00 00       	call   80104460 <pushcli>
  c = mycpu();
80103f44:	e8 87 f9 ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103f49:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f4f:	e8 fc 05 00 00       	call   80104550 <popcli>
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
80103f54:	85 db                	test   %ebx,%ebx
80103f56:	0f 84 87 00 00 00    	je     80103fe3 <sleep+0xb3>
    panic("sleep");

  if(lk == 0)
80103f5c:	85 f6                	test   %esi,%esi
80103f5e:	74 76                	je     80103fd6 <sleep+0xa6>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103f60:	81 fe c0 3c 11 80    	cmp    $0x80113cc0,%esi
80103f66:	74 50                	je     80103fb8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103f68:	83 ec 0c             	sub    $0xc,%esp
80103f6b:	68 c0 3c 11 80       	push   $0x80113cc0
80103f70:	e8 2b 05 00 00       	call   801044a0 <acquire>
    release(lk);
80103f75:	89 34 24             	mov    %esi,(%esp)
80103f78:	e8 43 06 00 00       	call   801045c0 <release>
  }
  // Go to sleep.
  p->chan = chan;
80103f7d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103f80:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80103f87:	e8 54 fd ff ff       	call   80103ce0 <sched>

  // Tidy up.
  p->chan = 0;
80103f8c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80103f93:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103f9a:	e8 21 06 00 00       	call   801045c0 <release>
    acquire(lk);
80103f9f:	89 75 08             	mov    %esi,0x8(%ebp)
80103fa2:	83 c4 10             	add    $0x10,%esp
  }
}
80103fa5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103fa8:	5b                   	pop    %ebx
80103fa9:	5e                   	pop    %esi
80103faa:	5f                   	pop    %edi
80103fab:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
80103fac:	e9 ef 04 00 00       	jmp    801044a0 <acquire>
80103fb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
80103fb8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103fbb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80103fc2:	e8 19 fd ff ff       	call   80103ce0 <sched>

  // Tidy up.
  p->chan = 0;
80103fc7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
80103fce:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103fd1:	5b                   	pop    %ebx
80103fd2:	5e                   	pop    %esi
80103fd3:	5f                   	pop    %edi
80103fd4:	5d                   	pop    %ebp
80103fd5:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80103fd6:	83 ec 0c             	sub    $0xc,%esp
80103fd9:	68 cf 77 10 80       	push   $0x801077cf
80103fde:	e8 8d c3 ff ff       	call   80100370 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
80103fe3:	83 ec 0c             	sub    $0xc,%esp
80103fe6:	68 c9 77 10 80       	push   $0x801077c9
80103feb:	e8 80 c3 ff ff       	call   80100370 <panic>

80103ff0 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80103ff0:	55                   	push   %ebp
80103ff1:	89 e5                	mov    %esp,%ebp
80103ff3:	56                   	push   %esi
80103ff4:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103ff5:	e8 66 04 00 00       	call   80104460 <pushcli>
  c = mycpu();
80103ffa:	e8 d1 f8 ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103fff:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104005:	e8 46 05 00 00       	call   80104550 <popcli>
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
8010400a:	83 ec 0c             	sub    $0xc,%esp
8010400d:	68 c0 3c 11 80       	push   $0x80113cc0
80104012:	e8 89 04 00 00       	call   801044a0 <acquire>
80104017:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
8010401a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010401c:	bb f4 3c 11 80       	mov    $0x80113cf4,%ebx
80104021:	eb 10                	jmp    80104033 <wait+0x43>
80104023:	90                   	nop
80104024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104028:	83 c3 7c             	add    $0x7c,%ebx
8010402b:	81 fb f4 5b 11 80    	cmp    $0x80115bf4,%ebx
80104031:	74 1d                	je     80104050 <wait+0x60>
      if(p->parent != curproc)
80104033:	39 73 14             	cmp    %esi,0x14(%ebx)
80104036:	75 f0                	jne    80104028 <wait+0x38>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80104038:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010403c:	74 30                	je     8010406e <wait+0x7e>
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010403e:	83 c3 7c             	add    $0x7c,%ebx
      if(p->parent != curproc)
        continue;
      havekids = 1;
80104041:	b8 01 00 00 00       	mov    $0x1,%eax
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104046:	81 fb f4 5b 11 80    	cmp    $0x80115bf4,%ebx
8010404c:	75 e5                	jne    80104033 <wait+0x43>
8010404e:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80104050:	85 c0                	test   %eax,%eax
80104052:	74 70                	je     801040c4 <wait+0xd4>
80104054:	8b 46 24             	mov    0x24(%esi),%eax
80104057:	85 c0                	test   %eax,%eax
80104059:	75 69                	jne    801040c4 <wait+0xd4>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
8010405b:	83 ec 08             	sub    $0x8,%esp
8010405e:	68 c0 3c 11 80       	push   $0x80113cc0
80104063:	56                   	push   %esi
80104064:	e8 c7 fe ff ff       	call   80103f30 <sleep>
  }
80104069:	83 c4 10             	add    $0x10,%esp
8010406c:	eb ac                	jmp    8010401a <wait+0x2a>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
8010406e:	83 ec 0c             	sub    $0xc,%esp
80104071:	ff 73 08             	pushl  0x8(%ebx)
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80104074:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104077:	e8 54 e4 ff ff       	call   801024d0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
8010407c:	5a                   	pop    %edx
8010407d:	ff 73 04             	pushl  0x4(%ebx)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80104080:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104087:	e8 34 2e 00 00       	call   80106ec0 <freevm>
        p->pid = 0;
8010408c:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104093:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010409a:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
8010409e:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801040a5:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801040ac:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
801040b3:	e8 08 05 00 00       	call   801045c0 <release>
        return pid;
801040b8:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
801040bb:	8d 65 f8             	lea    -0x8(%ebp),%esp
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
801040be:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
801040c0:	5b                   	pop    %ebx
801040c1:	5e                   	pop    %esi
801040c2:	5d                   	pop    %ebp
801040c3:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
801040c4:	83 ec 0c             	sub    $0xc,%esp
801040c7:	68 c0 3c 11 80       	push   $0x80113cc0
801040cc:	e8 ef 04 00 00       	call   801045c0 <release>
      return -1;
801040d1:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
801040d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
801040d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
801040dc:	5b                   	pop    %ebx
801040dd:	5e                   	pop    %esi
801040de:	5d                   	pop    %ebp
801040df:	c3                   	ret    

801040e0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801040e0:	55                   	push   %ebp
801040e1:	89 e5                	mov    %esp,%ebp
801040e3:	53                   	push   %ebx
801040e4:	83 ec 10             	sub    $0x10,%esp
801040e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801040ea:	68 c0 3c 11 80       	push   $0x80113cc0
801040ef:	e8 ac 03 00 00       	call   801044a0 <acquire>
801040f4:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040f7:	b8 f4 3c 11 80       	mov    $0x80113cf4,%eax
801040fc:	eb 0c                	jmp    8010410a <wakeup+0x2a>
801040fe:	66 90                	xchg   %ax,%ax
80104100:	83 c0 7c             	add    $0x7c,%eax
80104103:	3d f4 5b 11 80       	cmp    $0x80115bf4,%eax
80104108:	74 1c                	je     80104126 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010410a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010410e:	75 f0                	jne    80104100 <wakeup+0x20>
80104110:	3b 58 20             	cmp    0x20(%eax),%ebx
80104113:	75 eb                	jne    80104100 <wakeup+0x20>
      p->state = RUNNABLE;
80104115:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010411c:	83 c0 7c             	add    $0x7c,%eax
8010411f:	3d f4 5b 11 80       	cmp    $0x80115bf4,%eax
80104124:	75 e4                	jne    8010410a <wakeup+0x2a>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80104126:	c7 45 08 c0 3c 11 80 	movl   $0x80113cc0,0x8(%ebp)
}
8010412d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104130:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80104131:	e9 8a 04 00 00       	jmp    801045c0 <release>
80104136:	8d 76 00             	lea    0x0(%esi),%esi
80104139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104140 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104140:	55                   	push   %ebp
80104141:	89 e5                	mov    %esp,%ebp
80104143:	53                   	push   %ebx
80104144:	83 ec 10             	sub    $0x10,%esp
80104147:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010414a:	68 c0 3c 11 80       	push   $0x80113cc0
8010414f:	e8 4c 03 00 00       	call   801044a0 <acquire>
80104154:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104157:	b8 f4 3c 11 80       	mov    $0x80113cf4,%eax
8010415c:	eb 0c                	jmp    8010416a <kill+0x2a>
8010415e:	66 90                	xchg   %ax,%ax
80104160:	83 c0 7c             	add    $0x7c,%eax
80104163:	3d f4 5b 11 80       	cmp    $0x80115bf4,%eax
80104168:	74 3e                	je     801041a8 <kill+0x68>
    if(p->pid == pid){
8010416a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010416d:	75 f1                	jne    80104160 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010416f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
80104173:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010417a:	74 1c                	je     80104198 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
8010417c:	83 ec 0c             	sub    $0xc,%esp
8010417f:	68 c0 3c 11 80       	push   $0x80113cc0
80104184:	e8 37 04 00 00       	call   801045c0 <release>
      return 0;
80104189:	83 c4 10             	add    $0x10,%esp
8010418c:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
8010418e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104191:	c9                   	leave  
80104192:	c3                   	ret    
80104193:	90                   	nop
80104194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80104198:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010419f:	eb db                	jmp    8010417c <kill+0x3c>
801041a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
801041a8:	83 ec 0c             	sub    $0xc,%esp
801041ab:	68 c0 3c 11 80       	push   $0x80113cc0
801041b0:	e8 0b 04 00 00       	call   801045c0 <release>
  return -1;
801041b5:	83 c4 10             	add    $0x10,%esp
801041b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801041bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041c0:	c9                   	leave  
801041c1:	c3                   	ret    
801041c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801041d0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801041d0:	55                   	push   %ebp
801041d1:	89 e5                	mov    %esp,%ebp
801041d3:	57                   	push   %edi
801041d4:	56                   	push   %esi
801041d5:	53                   	push   %ebx
801041d6:	8d 75 e8             	lea    -0x18(%ebp),%esi
801041d9:	bb 60 3d 11 80       	mov    $0x80113d60,%ebx
801041de:	83 ec 3c             	sub    $0x3c,%esp
801041e1:	eb 24                	jmp    80104207 <procdump+0x37>
801041e3:	90                   	nop
801041e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801041e8:	83 ec 0c             	sub    $0xc,%esp
801041eb:	68 67 7b 10 80       	push   $0x80107b67
801041f0:	e8 8b c4 ff ff       	call   80100680 <cprintf>
801041f5:	83 c4 10             	add    $0x10,%esp
801041f8:	83 c3 7c             	add    $0x7c,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041fb:	81 fb 60 5c 11 80    	cmp    $0x80115c60,%ebx
80104201:	0f 84 81 00 00 00    	je     80104288 <procdump+0xb8>
    if(p->state == UNUSED)
80104207:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010420a:	85 c0                	test   %eax,%eax
8010420c:	74 ea                	je     801041f8 <procdump+0x28>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010420e:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
80104211:	ba e0 77 10 80       	mov    $0x801077e0,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104216:	77 11                	ja     80104229 <procdump+0x59>
80104218:	8b 14 85 40 78 10 80 	mov    -0x7fef87c0(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
8010421f:	b8 e0 77 10 80       	mov    $0x801077e0,%eax
80104224:	85 d2                	test   %edx,%edx
80104226:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104229:	53                   	push   %ebx
8010422a:	52                   	push   %edx
8010422b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010422e:	68 e4 77 10 80       	push   $0x801077e4
80104233:	e8 48 c4 ff ff       	call   80100680 <cprintf>
    if(p->state == SLEEPING){
80104238:	83 c4 10             	add    $0x10,%esp
8010423b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010423f:	75 a7                	jne    801041e8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104241:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104244:	83 ec 08             	sub    $0x8,%esp
80104247:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010424a:	50                   	push   %eax
8010424b:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010424e:	8b 40 0c             	mov    0xc(%eax),%eax
80104251:	83 c0 08             	add    $0x8,%eax
80104254:	50                   	push   %eax
80104255:	e8 66 01 00 00       	call   801043c0 <getcallerpcs>
8010425a:	83 c4 10             	add    $0x10,%esp
8010425d:	8d 76 00             	lea    0x0(%esi),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104260:	8b 17                	mov    (%edi),%edx
80104262:	85 d2                	test   %edx,%edx
80104264:	74 82                	je     801041e8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104266:	83 ec 08             	sub    $0x8,%esp
80104269:	83 c7 04             	add    $0x4,%edi
8010426c:	52                   	push   %edx
8010426d:	68 21 72 10 80       	push   $0x80107221
80104272:	e8 09 c4 ff ff       	call   80100680 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104277:	83 c4 10             	add    $0x10,%esp
8010427a:	39 f7                	cmp    %esi,%edi
8010427c:	75 e2                	jne    80104260 <procdump+0x90>
8010427e:	e9 65 ff ff ff       	jmp    801041e8 <procdump+0x18>
80104283:	90                   	nop
80104284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104288:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010428b:	5b                   	pop    %ebx
8010428c:	5e                   	pop    %esi
8010428d:	5f                   	pop    %edi
8010428e:	5d                   	pop    %ebp
8010428f:	c3                   	ret    

80104290 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104290:	55                   	push   %ebp
80104291:	89 e5                	mov    %esp,%ebp
80104293:	53                   	push   %ebx
80104294:	83 ec 0c             	sub    $0xc,%esp
80104297:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010429a:	68 58 78 10 80       	push   $0x80107858
8010429f:	8d 43 04             	lea    0x4(%ebx),%eax
801042a2:	50                   	push   %eax
801042a3:	e8 f8 00 00 00       	call   801043a0 <initlock>
  lk->name = name;
801042a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801042ab:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801042b1:	83 c4 10             	add    $0x10,%esp
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
  lk->locked = 0;
  lk->pid = 0;
801042b4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
801042bb:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
801042be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042c1:	c9                   	leave  
801042c2:	c3                   	ret    
801042c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801042c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801042d0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801042d0:	55                   	push   %ebp
801042d1:	89 e5                	mov    %esp,%ebp
801042d3:	56                   	push   %esi
801042d4:	53                   	push   %ebx
801042d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801042d8:	83 ec 0c             	sub    $0xc,%esp
801042db:	8d 73 04             	lea    0x4(%ebx),%esi
801042de:	56                   	push   %esi
801042df:	e8 bc 01 00 00       	call   801044a0 <acquire>
  while (lk->locked) {
801042e4:	8b 13                	mov    (%ebx),%edx
801042e6:	83 c4 10             	add    $0x10,%esp
801042e9:	85 d2                	test   %edx,%edx
801042eb:	74 16                	je     80104303 <acquiresleep+0x33>
801042ed:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801042f0:	83 ec 08             	sub    $0x8,%esp
801042f3:	56                   	push   %esi
801042f4:	53                   	push   %ebx
801042f5:	e8 36 fc ff ff       	call   80103f30 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
801042fa:	8b 03                	mov    (%ebx),%eax
801042fc:	83 c4 10             	add    $0x10,%esp
801042ff:	85 c0                	test   %eax,%eax
80104301:	75 ed                	jne    801042f0 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80104303:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104309:	e8 62 f6 ff ff       	call   80103970 <myproc>
8010430e:	8b 40 10             	mov    0x10(%eax),%eax
80104311:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104314:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104317:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010431a:	5b                   	pop    %ebx
8010431b:	5e                   	pop    %esi
8010431c:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
8010431d:	e9 9e 02 00 00       	jmp    801045c0 <release>
80104322:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104330 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
80104330:	55                   	push   %ebp
80104331:	89 e5                	mov    %esp,%ebp
80104333:	56                   	push   %esi
80104334:	53                   	push   %ebx
80104335:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104338:	83 ec 0c             	sub    $0xc,%esp
8010433b:	8d 73 04             	lea    0x4(%ebx),%esi
8010433e:	56                   	push   %esi
8010433f:	e8 5c 01 00 00       	call   801044a0 <acquire>
  lk->locked = 0;
80104344:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010434a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104351:	89 1c 24             	mov    %ebx,(%esp)
80104354:	e8 87 fd ff ff       	call   801040e0 <wakeup>
  release(&lk->lk);
80104359:	89 75 08             	mov    %esi,0x8(%ebp)
8010435c:	83 c4 10             	add    $0x10,%esp
}
8010435f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104362:	5b                   	pop    %ebx
80104363:	5e                   	pop    %esi
80104364:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
80104365:	e9 56 02 00 00       	jmp    801045c0 <release>
8010436a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104370 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
80104370:	55                   	push   %ebp
80104371:	89 e5                	mov    %esp,%ebp
80104373:	56                   	push   %esi
80104374:	53                   	push   %ebx
80104375:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
80104378:	83 ec 0c             	sub    $0xc,%esp
8010437b:	8d 5e 04             	lea    0x4(%esi),%ebx
8010437e:	53                   	push   %ebx
8010437f:	e8 1c 01 00 00       	call   801044a0 <acquire>
  r = lk->locked;
80104384:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
80104386:	89 1c 24             	mov    %ebx,(%esp)
80104389:	e8 32 02 00 00       	call   801045c0 <release>
  return r;
}
8010438e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104391:	89 f0                	mov    %esi,%eax
80104393:	5b                   	pop    %ebx
80104394:	5e                   	pop    %esi
80104395:	5d                   	pop    %ebp
80104396:	c3                   	ret    
80104397:	66 90                	xchg   %ax,%ax
80104399:	66 90                	xchg   %ax,%ax
8010439b:	66 90                	xchg   %ax,%ax
8010439d:	66 90                	xchg   %ax,%ax
8010439f:	90                   	nop

801043a0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801043a0:	55                   	push   %ebp
801043a1:	89 e5                	mov    %esp,%ebp
801043a3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801043a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801043a9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
801043af:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
801043b2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801043b9:	5d                   	pop    %ebp
801043ba:	c3                   	ret    
801043bb:	90                   	nop
801043bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801043c0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801043c0:	55                   	push   %ebp
801043c1:	89 e5                	mov    %esp,%ebp
801043c3:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801043c4:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801043c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801043ca:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
801043cd:	31 c0                	xor    %eax,%eax
801043cf:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801043d0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801043d6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801043dc:	77 1a                	ja     801043f8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
801043de:	8b 5a 04             	mov    0x4(%edx),%ebx
801043e1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801043e4:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
801043e7:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801043e9:	83 f8 0a             	cmp    $0xa,%eax
801043ec:	75 e2                	jne    801043d0 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801043ee:	5b                   	pop    %ebx
801043ef:	5d                   	pop    %ebp
801043f0:	c3                   	ret    
801043f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
801043f8:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801043ff:	83 c0 01             	add    $0x1,%eax
80104402:	83 f8 0a             	cmp    $0xa,%eax
80104405:	74 e7                	je     801043ee <getcallerpcs+0x2e>
    pcs[i] = 0;
80104407:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010440e:	83 c0 01             	add    $0x1,%eax
80104411:	83 f8 0a             	cmp    $0xa,%eax
80104414:	75 e2                	jne    801043f8 <getcallerpcs+0x38>
80104416:	eb d6                	jmp    801043ee <getcallerpcs+0x2e>
80104418:	90                   	nop
80104419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104420 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104420:	55                   	push   %ebp
80104421:	89 e5                	mov    %esp,%ebp
80104423:	53                   	push   %ebx
80104424:	83 ec 04             	sub    $0x4,%esp
80104427:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == mycpu();
8010442a:	8b 02                	mov    (%edx),%eax
8010442c:	85 c0                	test   %eax,%eax
8010442e:	75 10                	jne    80104440 <holding+0x20>
}
80104430:	83 c4 04             	add    $0x4,%esp
80104433:	31 c0                	xor    %eax,%eax
80104435:	5b                   	pop    %ebx
80104436:	5d                   	pop    %ebp
80104437:	c3                   	ret    
80104438:	90                   	nop
80104439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80104440:	8b 5a 08             	mov    0x8(%edx),%ebx
80104443:	e8 88 f4 ff ff       	call   801038d0 <mycpu>
80104448:	39 c3                	cmp    %eax,%ebx
8010444a:	0f 94 c0             	sete   %al
}
8010444d:	83 c4 04             	add    $0x4,%esp

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80104450:	0f b6 c0             	movzbl %al,%eax
}
80104453:	5b                   	pop    %ebx
80104454:	5d                   	pop    %ebp
80104455:	c3                   	ret    
80104456:	8d 76 00             	lea    0x0(%esi),%esi
80104459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104460 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104460:	55                   	push   %ebp
80104461:	89 e5                	mov    %esp,%ebp
80104463:	53                   	push   %ebx
80104464:	83 ec 04             	sub    $0x4,%esp
80104467:	9c                   	pushf  
80104468:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
80104469:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010446a:	e8 61 f4 ff ff       	call   801038d0 <mycpu>
8010446f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104475:	85 c0                	test   %eax,%eax
80104477:	75 11                	jne    8010448a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104479:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010447f:	e8 4c f4 ff ff       	call   801038d0 <mycpu>
80104484:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010448a:	e8 41 f4 ff ff       	call   801038d0 <mycpu>
8010448f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104496:	83 c4 04             	add    $0x4,%esp
80104499:	5b                   	pop    %ebx
8010449a:	5d                   	pop    %ebp
8010449b:	c3                   	ret    
8010449c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801044a0 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
801044a0:	55                   	push   %ebp
801044a1:	89 e5                	mov    %esp,%ebp
801044a3:	56                   	push   %esi
801044a4:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
801044a5:	e8 b6 ff ff ff       	call   80104460 <pushcli>
  if(holding(lk))
801044aa:	8b 5d 08             	mov    0x8(%ebp),%ebx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
801044ad:	8b 03                	mov    (%ebx),%eax
801044af:	85 c0                	test   %eax,%eax
801044b1:	75 7d                	jne    80104530 <acquire+0x90>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801044b3:	ba 01 00 00 00       	mov    $0x1,%edx
801044b8:	eb 09                	jmp    801044c3 <acquire+0x23>
801044ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801044c0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801044c3:	89 d0                	mov    %edx,%eax
801044c5:	f0 87 03             	lock xchg %eax,(%ebx)
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
801044c8:	85 c0                	test   %eax,%eax
801044ca:	75 f4                	jne    801044c0 <acquire+0x20>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
801044cc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
801044d1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801044d4:	e8 f7 f3 ff ff       	call   801038d0 <mycpu>
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801044d9:	89 ea                	mov    %ebp,%edx
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
801044db:	8d 4b 0c             	lea    0xc(%ebx),%ecx
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
801044de:	89 43 08             	mov    %eax,0x8(%ebx)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801044e1:	31 c0                	xor    %eax,%eax
801044e3:	90                   	nop
801044e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801044e8:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801044ee:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801044f4:	77 1a                	ja     80104510 <acquire+0x70>
      break;
    pcs[i] = ebp[1];     // saved %eip
801044f6:	8b 5a 04             	mov    0x4(%edx),%ebx
801044f9:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801044fc:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
801044ff:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104501:	83 f8 0a             	cmp    $0xa,%eax
80104504:	75 e2                	jne    801044e8 <acquire+0x48>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}
80104506:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104509:	5b                   	pop    %ebx
8010450a:	5e                   	pop    %esi
8010450b:	5d                   	pop    %ebp
8010450c:	c3                   	ret    
8010450d:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104510:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104517:	83 c0 01             	add    $0x1,%eax
8010451a:	83 f8 0a             	cmp    $0xa,%eax
8010451d:	74 e7                	je     80104506 <acquire+0x66>
    pcs[i] = 0;
8010451f:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104526:	83 c0 01             	add    $0x1,%eax
80104529:	83 f8 0a             	cmp    $0xa,%eax
8010452c:	75 e2                	jne    80104510 <acquire+0x70>
8010452e:	eb d6                	jmp    80104506 <acquire+0x66>

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80104530:	8b 73 08             	mov    0x8(%ebx),%esi
80104533:	e8 98 f3 ff ff       	call   801038d0 <mycpu>
80104538:	39 c6                	cmp    %eax,%esi
8010453a:	0f 85 73 ff ff ff    	jne    801044b3 <acquire+0x13>
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80104540:	83 ec 0c             	sub    $0xc,%esp
80104543:	68 63 78 10 80       	push   $0x80107863
80104548:	e8 23 be ff ff       	call   80100370 <panic>
8010454d:	8d 76 00             	lea    0x0(%esi),%esi

80104550 <popcli>:
  mycpu()->ncli += 1;
}

void
popcli(void)
{
80104550:	55                   	push   %ebp
80104551:	89 e5                	mov    %esp,%ebp
80104553:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104556:	9c                   	pushf  
80104557:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104558:	f6 c4 02             	test   $0x2,%ah
8010455b:	75 52                	jne    801045af <popcli+0x5f>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010455d:	e8 6e f3 ff ff       	call   801038d0 <mycpu>
80104562:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80104568:	8d 51 ff             	lea    -0x1(%ecx),%edx
8010456b:	85 d2                	test   %edx,%edx
8010456d:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80104573:	78 2d                	js     801045a2 <popcli+0x52>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104575:	e8 56 f3 ff ff       	call   801038d0 <mycpu>
8010457a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104580:	85 d2                	test   %edx,%edx
80104582:	74 0c                	je     80104590 <popcli+0x40>
    sti();
}
80104584:	c9                   	leave  
80104585:	c3                   	ret    
80104586:	8d 76 00             	lea    0x0(%esi),%esi
80104589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104590:	e8 3b f3 ff ff       	call   801038d0 <mycpu>
80104595:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010459b:	85 c0                	test   %eax,%eax
8010459d:	74 e5                	je     80104584 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
8010459f:	fb                   	sti    
    sti();
}
801045a0:	c9                   	leave  
801045a1:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
801045a2:	83 ec 0c             	sub    $0xc,%esp
801045a5:	68 82 78 10 80       	push   $0x80107882
801045aa:	e8 c1 bd ff ff       	call   80100370 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
801045af:	83 ec 0c             	sub    $0xc,%esp
801045b2:	68 6b 78 10 80       	push   $0x8010786b
801045b7:	e8 b4 bd ff ff       	call   80100370 <panic>
801045bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801045c0 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
801045c0:	55                   	push   %ebp
801045c1:	89 e5                	mov    %esp,%ebp
801045c3:	56                   	push   %esi
801045c4:	53                   	push   %ebx
801045c5:	8b 5d 08             	mov    0x8(%ebp),%ebx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
801045c8:	8b 03                	mov    (%ebx),%eax
801045ca:	85 c0                	test   %eax,%eax
801045cc:	75 12                	jne    801045e0 <release+0x20>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
801045ce:	83 ec 0c             	sub    $0xc,%esp
801045d1:	68 89 78 10 80       	push   $0x80107889
801045d6:	e8 95 bd ff ff       	call   80100370 <panic>
801045db:	90                   	nop
801045dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
801045e0:	8b 73 08             	mov    0x8(%ebx),%esi
801045e3:	e8 e8 f2 ff ff       	call   801038d0 <mycpu>
801045e8:	39 c6                	cmp    %eax,%esi
801045ea:	75 e2                	jne    801045ce <release+0xe>
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");

  lk->pcs[0] = 0;
801045ec:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801045f3:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
801045fa:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801045ff:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
80104605:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104608:	5b                   	pop    %ebx
80104609:	5e                   	pop    %esi
8010460a:	5d                   	pop    %ebp
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
8010460b:	e9 40 ff ff ff       	jmp    80104550 <popcli>

80104610 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104610:	55                   	push   %ebp
80104611:	89 e5                	mov    %esp,%ebp
80104613:	57                   	push   %edi
80104614:	53                   	push   %ebx
80104615:	8b 55 08             	mov    0x8(%ebp),%edx
80104618:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010461b:	f6 c2 03             	test   $0x3,%dl
8010461e:	75 05                	jne    80104625 <memset+0x15>
80104620:	f6 c1 03             	test   $0x3,%cl
80104623:	74 13                	je     80104638 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
80104625:	89 d7                	mov    %edx,%edi
80104627:	8b 45 0c             	mov    0xc(%ebp),%eax
8010462a:	fc                   	cld    
8010462b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010462d:	5b                   	pop    %ebx
8010462e:	89 d0                	mov    %edx,%eax
80104630:	5f                   	pop    %edi
80104631:	5d                   	pop    %ebp
80104632:	c3                   	ret    
80104633:	90                   	nop
80104634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
80104638:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
8010463c:	c1 e9 02             	shr    $0x2,%ecx
8010463f:	89 fb                	mov    %edi,%ebx
80104641:	89 f8                	mov    %edi,%eax
80104643:	c1 e3 18             	shl    $0x18,%ebx
80104646:	c1 e0 10             	shl    $0x10,%eax
80104649:	09 d8                	or     %ebx,%eax
8010464b:	09 f8                	or     %edi,%eax
8010464d:	c1 e7 08             	shl    $0x8,%edi
80104650:	09 f8                	or     %edi,%eax
80104652:	89 d7                	mov    %edx,%edi
80104654:	fc                   	cld    
80104655:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104657:	5b                   	pop    %ebx
80104658:	89 d0                	mov    %edx,%eax
8010465a:	5f                   	pop    %edi
8010465b:	5d                   	pop    %ebp
8010465c:	c3                   	ret    
8010465d:	8d 76 00             	lea    0x0(%esi),%esi

80104660 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104660:	55                   	push   %ebp
80104661:	89 e5                	mov    %esp,%ebp
80104663:	57                   	push   %edi
80104664:	56                   	push   %esi
80104665:	8b 45 10             	mov    0x10(%ebp),%eax
80104668:	53                   	push   %ebx
80104669:	8b 75 0c             	mov    0xc(%ebp),%esi
8010466c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010466f:	85 c0                	test   %eax,%eax
80104671:	74 29                	je     8010469c <memcmp+0x3c>
    if(*s1 != *s2)
80104673:	0f b6 13             	movzbl (%ebx),%edx
80104676:	0f b6 0e             	movzbl (%esi),%ecx
80104679:	38 d1                	cmp    %dl,%cl
8010467b:	75 2b                	jne    801046a8 <memcmp+0x48>
8010467d:	8d 78 ff             	lea    -0x1(%eax),%edi
80104680:	31 c0                	xor    %eax,%eax
80104682:	eb 14                	jmp    80104698 <memcmp+0x38>
80104684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104688:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
8010468d:	83 c0 01             	add    $0x1,%eax
80104690:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104694:	38 ca                	cmp    %cl,%dl
80104696:	75 10                	jne    801046a8 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104698:	39 f8                	cmp    %edi,%eax
8010469a:	75 ec                	jne    80104688 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010469c:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010469d:	31 c0                	xor    %eax,%eax
}
8010469f:	5e                   	pop    %esi
801046a0:	5f                   	pop    %edi
801046a1:	5d                   	pop    %ebp
801046a2:	c3                   	ret    
801046a3:	90                   	nop
801046a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
801046a8:	0f b6 c2             	movzbl %dl,%eax
    s1++, s2++;
  }

  return 0;
}
801046ab:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
801046ac:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
801046ae:	5e                   	pop    %esi
801046af:	5f                   	pop    %edi
801046b0:	5d                   	pop    %ebp
801046b1:	c3                   	ret    
801046b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046c0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801046c0:	55                   	push   %ebp
801046c1:	89 e5                	mov    %esp,%ebp
801046c3:	56                   	push   %esi
801046c4:	53                   	push   %ebx
801046c5:	8b 45 08             	mov    0x8(%ebp),%eax
801046c8:	8b 75 0c             	mov    0xc(%ebp),%esi
801046cb:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801046ce:	39 c6                	cmp    %eax,%esi
801046d0:	73 2e                	jae    80104700 <memmove+0x40>
801046d2:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
801046d5:	39 c8                	cmp    %ecx,%eax
801046d7:	73 27                	jae    80104700 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
801046d9:	85 db                	test   %ebx,%ebx
801046db:	8d 53 ff             	lea    -0x1(%ebx),%edx
801046de:	74 17                	je     801046f7 <memmove+0x37>
      *--d = *--s;
801046e0:	29 d9                	sub    %ebx,%ecx
801046e2:	89 cb                	mov    %ecx,%ebx
801046e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046e8:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801046ec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
801046ef:	83 ea 01             	sub    $0x1,%edx
801046f2:	83 fa ff             	cmp    $0xffffffff,%edx
801046f5:	75 f1                	jne    801046e8 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801046f7:	5b                   	pop    %ebx
801046f8:	5e                   	pop    %esi
801046f9:	5d                   	pop    %ebp
801046fa:	c3                   	ret    
801046fb:	90                   	nop
801046fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80104700:	31 d2                	xor    %edx,%edx
80104702:	85 db                	test   %ebx,%ebx
80104704:	74 f1                	je     801046f7 <memmove+0x37>
80104706:	8d 76 00             	lea    0x0(%esi),%esi
80104709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *d++ = *s++;
80104710:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104714:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104717:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
8010471a:	39 d3                	cmp    %edx,%ebx
8010471c:	75 f2                	jne    80104710 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
8010471e:	5b                   	pop    %ebx
8010471f:	5e                   	pop    %esi
80104720:	5d                   	pop    %ebp
80104721:	c3                   	ret    
80104722:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104730 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104730:	55                   	push   %ebp
80104731:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104733:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104734:	eb 8a                	jmp    801046c0 <memmove>
80104736:	8d 76 00             	lea    0x0(%esi),%esi
80104739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104740 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
80104743:	57                   	push   %edi
80104744:	56                   	push   %esi
80104745:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104748:	53                   	push   %ebx
80104749:	8b 7d 08             	mov    0x8(%ebp),%edi
8010474c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010474f:	85 c9                	test   %ecx,%ecx
80104751:	74 37                	je     8010478a <strncmp+0x4a>
80104753:	0f b6 17             	movzbl (%edi),%edx
80104756:	0f b6 1e             	movzbl (%esi),%ebx
80104759:	84 d2                	test   %dl,%dl
8010475b:	74 3f                	je     8010479c <strncmp+0x5c>
8010475d:	38 d3                	cmp    %dl,%bl
8010475f:	75 3b                	jne    8010479c <strncmp+0x5c>
80104761:	8d 47 01             	lea    0x1(%edi),%eax
80104764:	01 cf                	add    %ecx,%edi
80104766:	eb 1b                	jmp    80104783 <strncmp+0x43>
80104768:	90                   	nop
80104769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104770:	0f b6 10             	movzbl (%eax),%edx
80104773:	84 d2                	test   %dl,%dl
80104775:	74 21                	je     80104798 <strncmp+0x58>
80104777:	0f b6 19             	movzbl (%ecx),%ebx
8010477a:	83 c0 01             	add    $0x1,%eax
8010477d:	89 ce                	mov    %ecx,%esi
8010477f:	38 da                	cmp    %bl,%dl
80104781:	75 19                	jne    8010479c <strncmp+0x5c>
80104783:	39 c7                	cmp    %eax,%edi
    n--, p++, q++;
80104785:	8d 4e 01             	lea    0x1(%esi),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80104788:	75 e6                	jne    80104770 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
8010478a:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
8010478b:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
8010478d:	5e                   	pop    %esi
8010478e:	5f                   	pop    %edi
8010478f:	5d                   	pop    %ebp
80104790:	c3                   	ret    
80104791:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104798:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
8010479c:	0f b6 c2             	movzbl %dl,%eax
8010479f:	29 d8                	sub    %ebx,%eax
}
801047a1:	5b                   	pop    %ebx
801047a2:	5e                   	pop    %esi
801047a3:	5f                   	pop    %edi
801047a4:	5d                   	pop    %ebp
801047a5:	c3                   	ret    
801047a6:	8d 76 00             	lea    0x0(%esi),%esi
801047a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047b0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801047b0:	55                   	push   %ebp
801047b1:	89 e5                	mov    %esp,%ebp
801047b3:	56                   	push   %esi
801047b4:	53                   	push   %ebx
801047b5:	8b 45 08             	mov    0x8(%ebp),%eax
801047b8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801047bb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801047be:	89 c2                	mov    %eax,%edx
801047c0:	eb 19                	jmp    801047db <strncpy+0x2b>
801047c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801047c8:	83 c3 01             	add    $0x1,%ebx
801047cb:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
801047cf:	83 c2 01             	add    $0x1,%edx
801047d2:	84 c9                	test   %cl,%cl
801047d4:	88 4a ff             	mov    %cl,-0x1(%edx)
801047d7:	74 09                	je     801047e2 <strncpy+0x32>
801047d9:	89 f1                	mov    %esi,%ecx
801047db:	85 c9                	test   %ecx,%ecx
801047dd:	8d 71 ff             	lea    -0x1(%ecx),%esi
801047e0:	7f e6                	jg     801047c8 <strncpy+0x18>
    ;
  while(n-- > 0)
801047e2:	31 c9                	xor    %ecx,%ecx
801047e4:	85 f6                	test   %esi,%esi
801047e6:	7e 17                	jle    801047ff <strncpy+0x4f>
801047e8:	90                   	nop
801047e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
801047f0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
801047f4:	89 f3                	mov    %esi,%ebx
801047f6:	83 c1 01             	add    $0x1,%ecx
801047f9:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
801047fb:	85 db                	test   %ebx,%ebx
801047fd:	7f f1                	jg     801047f0 <strncpy+0x40>
    *s++ = 0;
  return os;
}
801047ff:	5b                   	pop    %ebx
80104800:	5e                   	pop    %esi
80104801:	5d                   	pop    %ebp
80104802:	c3                   	ret    
80104803:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104810 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104810:	55                   	push   %ebp
80104811:	89 e5                	mov    %esp,%ebp
80104813:	56                   	push   %esi
80104814:	53                   	push   %ebx
80104815:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104818:	8b 45 08             	mov    0x8(%ebp),%eax
8010481b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010481e:	85 c9                	test   %ecx,%ecx
80104820:	7e 26                	jle    80104848 <safestrcpy+0x38>
80104822:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104826:	89 c1                	mov    %eax,%ecx
80104828:	eb 17                	jmp    80104841 <safestrcpy+0x31>
8010482a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104830:	83 c2 01             	add    $0x1,%edx
80104833:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104837:	83 c1 01             	add    $0x1,%ecx
8010483a:	84 db                	test   %bl,%bl
8010483c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010483f:	74 04                	je     80104845 <safestrcpy+0x35>
80104841:	39 f2                	cmp    %esi,%edx
80104843:	75 eb                	jne    80104830 <safestrcpy+0x20>
    ;
  *s = 0;
80104845:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104848:	5b                   	pop    %ebx
80104849:	5e                   	pop    %esi
8010484a:	5d                   	pop    %ebp
8010484b:	c3                   	ret    
8010484c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104850 <strlen>:

int
strlen(const char *s)
{
80104850:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104851:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
80104853:	89 e5                	mov    %esp,%ebp
80104855:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80104858:	80 3a 00             	cmpb   $0x0,(%edx)
8010485b:	74 0c                	je     80104869 <strlen+0x19>
8010485d:	8d 76 00             	lea    0x0(%esi),%esi
80104860:	83 c0 01             	add    $0x1,%eax
80104863:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104867:	75 f7                	jne    80104860 <strlen+0x10>
    ;
  return n;
}
80104869:	5d                   	pop    %ebp
8010486a:	c3                   	ret    

8010486b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010486b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010486f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80104873:	55                   	push   %ebp
  pushl %ebx
80104874:	53                   	push   %ebx
  pushl %esi
80104875:	56                   	push   %esi
  pushl %edi
80104876:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104877:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104879:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
8010487b:	5f                   	pop    %edi
  popl %esi
8010487c:	5e                   	pop    %esi
  popl %ebx
8010487d:	5b                   	pop    %ebx
  popl %ebp
8010487e:	5d                   	pop    %ebp
  ret
8010487f:	c3                   	ret    

80104880 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104880:	55                   	push   %ebp
80104881:	89 e5                	mov    %esp,%ebp
80104883:	53                   	push   %ebx
80104884:	83 ec 04             	sub    $0x4,%esp
80104887:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010488a:	e8 e1 f0 ff ff       	call   80103970 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010488f:	8b 00                	mov    (%eax),%eax
80104891:	39 d8                	cmp    %ebx,%eax
80104893:	76 1b                	jbe    801048b0 <fetchint+0x30>
80104895:	8d 53 04             	lea    0x4(%ebx),%edx
80104898:	39 d0                	cmp    %edx,%eax
8010489a:	72 14                	jb     801048b0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010489c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010489f:	8b 13                	mov    (%ebx),%edx
801048a1:	89 10                	mov    %edx,(%eax)
  return 0;
801048a3:	31 c0                	xor    %eax,%eax
}
801048a5:	83 c4 04             	add    $0x4,%esp
801048a8:	5b                   	pop    %ebx
801048a9:	5d                   	pop    %ebp
801048aa:	c3                   	ret    
801048ab:	90                   	nop
801048ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
801048b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801048b5:	eb ee                	jmp    801048a5 <fetchint+0x25>
801048b7:	89 f6                	mov    %esi,%esi
801048b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048c0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801048c0:	55                   	push   %ebp
801048c1:	89 e5                	mov    %esp,%ebp
801048c3:	53                   	push   %ebx
801048c4:	83 ec 04             	sub    $0x4,%esp
801048c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801048ca:	e8 a1 f0 ff ff       	call   80103970 <myproc>

  if(addr >= curproc->sz)
801048cf:	39 18                	cmp    %ebx,(%eax)
801048d1:	76 29                	jbe    801048fc <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
801048d3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801048d6:	89 da                	mov    %ebx,%edx
801048d8:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
801048da:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
801048dc:	39 c3                	cmp    %eax,%ebx
801048de:	73 1c                	jae    801048fc <fetchstr+0x3c>
    if(*s == 0)
801048e0:	80 3b 00             	cmpb   $0x0,(%ebx)
801048e3:	75 10                	jne    801048f5 <fetchstr+0x35>
801048e5:	eb 29                	jmp    80104910 <fetchstr+0x50>
801048e7:	89 f6                	mov    %esi,%esi
801048e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801048f0:	80 3a 00             	cmpb   $0x0,(%edx)
801048f3:	74 1b                	je     80104910 <fetchstr+0x50>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
801048f5:	83 c2 01             	add    $0x1,%edx
801048f8:	39 d0                	cmp    %edx,%eax
801048fa:	77 f4                	ja     801048f0 <fetchstr+0x30>
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
801048fc:	83 c4 04             	add    $0x4,%esp
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
801048ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80104904:	5b                   	pop    %ebx
80104905:	5d                   	pop    %ebp
80104906:	c3                   	ret    
80104907:	89 f6                	mov    %esi,%esi
80104909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104910:	83 c4 04             	add    $0x4,%esp
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
80104913:	89 d0                	mov    %edx,%eax
80104915:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104917:	5b                   	pop    %ebx
80104918:	5d                   	pop    %ebp
80104919:	c3                   	ret    
8010491a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104920 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104920:	55                   	push   %ebp
80104921:	89 e5                	mov    %esp,%ebp
80104923:	56                   	push   %esi
80104924:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104925:	e8 46 f0 ff ff       	call   80103970 <myproc>
8010492a:	8b 40 18             	mov    0x18(%eax),%eax
8010492d:	8b 55 08             	mov    0x8(%ebp),%edx
80104930:	8b 40 44             	mov    0x44(%eax),%eax
80104933:	8d 1c 90             	lea    (%eax,%edx,4),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();
80104936:	e8 35 f0 ff ff       	call   80103970 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010493b:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010493d:	8d 73 04             	lea    0x4(%ebx),%esi
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104940:	39 c6                	cmp    %eax,%esi
80104942:	73 1c                	jae    80104960 <argint+0x40>
80104944:	8d 53 08             	lea    0x8(%ebx),%edx
80104947:	39 d0                	cmp    %edx,%eax
80104949:	72 15                	jb     80104960 <argint+0x40>
    return -1;
  *ip = *(int*)(addr);
8010494b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010494e:	8b 53 04             	mov    0x4(%ebx),%edx
80104951:	89 10                	mov    %edx,(%eax)
  return 0;
80104953:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
}
80104955:	5b                   	pop    %ebx
80104956:	5e                   	pop    %esi
80104957:	5d                   	pop    %ebp
80104958:	c3                   	ret    
80104959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104960:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104965:	eb ee                	jmp    80104955 <argint+0x35>
80104967:	89 f6                	mov    %esi,%esi
80104969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104970 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	56                   	push   %esi
80104974:	53                   	push   %ebx
80104975:	83 ec 10             	sub    $0x10,%esp
80104978:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010497b:	e8 f0 ef ff ff       	call   80103970 <myproc>
80104980:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104982:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104985:	83 ec 08             	sub    $0x8,%esp
80104988:	50                   	push   %eax
80104989:	ff 75 08             	pushl  0x8(%ebp)
8010498c:	e8 8f ff ff ff       	call   80104920 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104991:	c1 e8 1f             	shr    $0x1f,%eax
80104994:	83 c4 10             	add    $0x10,%esp
80104997:	84 c0                	test   %al,%al
80104999:	75 2d                	jne    801049c8 <argptr+0x58>
8010499b:	89 d8                	mov    %ebx,%eax
8010499d:	c1 e8 1f             	shr    $0x1f,%eax
801049a0:	84 c0                	test   %al,%al
801049a2:	75 24                	jne    801049c8 <argptr+0x58>
801049a4:	8b 16                	mov    (%esi),%edx
801049a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049a9:	39 c2                	cmp    %eax,%edx
801049ab:	76 1b                	jbe    801049c8 <argptr+0x58>
801049ad:	01 c3                	add    %eax,%ebx
801049af:	39 da                	cmp    %ebx,%edx
801049b1:	72 15                	jb     801049c8 <argptr+0x58>
    return -1;
  *pp = (char*)i;
801049b3:	8b 55 0c             	mov    0xc(%ebp),%edx
801049b6:	89 02                	mov    %eax,(%edx)
  return 0;
801049b8:	31 c0                	xor    %eax,%eax
}
801049ba:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049bd:	5b                   	pop    %ebx
801049be:	5e                   	pop    %esi
801049bf:	5d                   	pop    %ebp
801049c0:	c3                   	ret    
801049c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
801049c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049cd:	eb eb                	jmp    801049ba <argptr+0x4a>
801049cf:	90                   	nop

801049d0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801049d0:	55                   	push   %ebp
801049d1:	89 e5                	mov    %esp,%ebp
801049d3:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
801049d6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801049d9:	50                   	push   %eax
801049da:	ff 75 08             	pushl  0x8(%ebp)
801049dd:	e8 3e ff ff ff       	call   80104920 <argint>
801049e2:	83 c4 10             	add    $0x10,%esp
801049e5:	85 c0                	test   %eax,%eax
801049e7:	78 17                	js     80104a00 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
801049e9:	83 ec 08             	sub    $0x8,%esp
801049ec:	ff 75 0c             	pushl  0xc(%ebp)
801049ef:	ff 75 f4             	pushl  -0xc(%ebp)
801049f2:	e8 c9 fe ff ff       	call   801048c0 <fetchstr>
801049f7:	83 c4 10             	add    $0x10,%esp
}
801049fa:	c9                   	leave  
801049fb:	c3                   	ret    
801049fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80104a00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80104a05:	c9                   	leave  
80104a06:	c3                   	ret    
80104a07:	89 f6                	mov    %esi,%esi
80104a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a10 <syscall>:
[SYS_getkey]  sys_getkey,
};

void
syscall(void)
{
80104a10:	55                   	push   %ebp
80104a11:	89 e5                	mov    %esp,%ebp
80104a13:	56                   	push   %esi
80104a14:	53                   	push   %ebx
  int num;
  struct proc *curproc = myproc();
80104a15:	e8 56 ef ff ff       	call   80103970 <myproc>

  num = curproc->tf->eax;
80104a1a:	8b 70 18             	mov    0x18(%eax),%esi

void
syscall(void)
{
  int num;
  struct proc *curproc = myproc();
80104a1d:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104a1f:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104a22:	8d 50 ff             	lea    -0x1(%eax),%edx
80104a25:	83 fa 18             	cmp    $0x18,%edx
80104a28:	77 1e                	ja     80104a48 <syscall+0x38>
80104a2a:	8b 14 85 c0 78 10 80 	mov    -0x7fef8740(,%eax,4),%edx
80104a31:	85 d2                	test   %edx,%edx
80104a33:	74 13                	je     80104a48 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104a35:	ff d2                	call   *%edx
80104a37:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104a3a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a3d:	5b                   	pop    %ebx
80104a3e:	5e                   	pop    %esi
80104a3f:	5d                   	pop    %ebp
80104a40:	c3                   	ret    
80104a41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104a48:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104a49:	8d 43 6c             	lea    0x6c(%ebx),%eax

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104a4c:	50                   	push   %eax
80104a4d:	ff 73 10             	pushl  0x10(%ebx)
80104a50:	68 91 78 10 80       	push   $0x80107891
80104a55:	e8 26 bc ff ff       	call   80100680 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
80104a5a:	8b 43 18             	mov    0x18(%ebx),%eax
80104a5d:	83 c4 10             	add    $0x10,%esp
80104a60:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80104a67:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a6a:	5b                   	pop    %ebx
80104a6b:	5e                   	pop    %esi
80104a6c:	5d                   	pop    %ebp
80104a6d:	c3                   	ret    
80104a6e:	66 90                	xchg   %ax,%ax

80104a70 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104a70:	55                   	push   %ebp
80104a71:	89 e5                	mov    %esp,%ebp
80104a73:	57                   	push   %edi
80104a74:	56                   	push   %esi
80104a75:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104a76:	8d 75 da             	lea    -0x26(%ebp),%esi
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104a79:	83 ec 44             	sub    $0x44,%esp
80104a7c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104a7f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104a82:	56                   	push   %esi
80104a83:	50                   	push   %eax
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104a84:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104a87:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104a8a:	e8 41 d6 ff ff       	call   801020d0 <nameiparent>
80104a8f:	83 c4 10             	add    $0x10,%esp
80104a92:	85 c0                	test   %eax,%eax
80104a94:	0f 84 f6 00 00 00    	je     80104b90 <create+0x120>
    return 0;
  ilock(dp);
80104a9a:	83 ec 0c             	sub    $0xc,%esp
80104a9d:	89 c7                	mov    %eax,%edi
80104a9f:	50                   	push   %eax
80104aa0:	e8 bb cd ff ff       	call   80101860 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104aa5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104aa8:	83 c4 0c             	add    $0xc,%esp
80104aab:	50                   	push   %eax
80104aac:	56                   	push   %esi
80104aad:	57                   	push   %edi
80104aae:	e8 dd d2 ff ff       	call   80101d90 <dirlookup>
80104ab3:	83 c4 10             	add    $0x10,%esp
80104ab6:	85 c0                	test   %eax,%eax
80104ab8:	89 c3                	mov    %eax,%ebx
80104aba:	74 54                	je     80104b10 <create+0xa0>
    iunlockput(dp);
80104abc:	83 ec 0c             	sub    $0xc,%esp
80104abf:	57                   	push   %edi
80104ac0:	e8 2b d0 ff ff       	call   80101af0 <iunlockput>
    ilock(ip);
80104ac5:	89 1c 24             	mov    %ebx,(%esp)
80104ac8:	e8 93 cd ff ff       	call   80101860 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104acd:	83 c4 10             	add    $0x10,%esp
80104ad0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104ad5:	75 19                	jne    80104af0 <create+0x80>
80104ad7:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
80104adc:	89 d8                	mov    %ebx,%eax
80104ade:	75 10                	jne    80104af0 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104ae0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ae3:	5b                   	pop    %ebx
80104ae4:	5e                   	pop    %esi
80104ae5:	5f                   	pop    %edi
80104ae6:	5d                   	pop    %ebp
80104ae7:	c3                   	ret    
80104ae8:	90                   	nop
80104ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80104af0:	83 ec 0c             	sub    $0xc,%esp
80104af3:	53                   	push   %ebx
80104af4:	e8 f7 cf ff ff       	call   80101af0 <iunlockput>
    return 0;
80104af9:	83 c4 10             	add    $0x10,%esp
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104afc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
80104aff:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104b01:	5b                   	pop    %ebx
80104b02:	5e                   	pop    %esi
80104b03:	5f                   	pop    %edi
80104b04:	5d                   	pop    %ebp
80104b05:	c3                   	ret    
80104b06:	8d 76 00             	lea    0x0(%esi),%esi
80104b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80104b10:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104b14:	83 ec 08             	sub    $0x8,%esp
80104b17:	50                   	push   %eax
80104b18:	ff 37                	pushl  (%edi)
80104b1a:	e8 d1 cb ff ff       	call   801016f0 <ialloc>
80104b1f:	83 c4 10             	add    $0x10,%esp
80104b22:	85 c0                	test   %eax,%eax
80104b24:	89 c3                	mov    %eax,%ebx
80104b26:	0f 84 cc 00 00 00    	je     80104bf8 <create+0x188>
    panic("create: ialloc");

  ilock(ip);
80104b2c:	83 ec 0c             	sub    $0xc,%esp
80104b2f:	50                   	push   %eax
80104b30:	e8 2b cd ff ff       	call   80101860 <ilock>
  ip->major = major;
80104b35:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104b39:	66 89 43 52          	mov    %ax,0x52(%ebx)
  ip->minor = minor;
80104b3d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104b41:	66 89 43 54          	mov    %ax,0x54(%ebx)
  ip->nlink = 1;
80104b45:	b8 01 00 00 00       	mov    $0x1,%eax
80104b4a:	66 89 43 56          	mov    %ax,0x56(%ebx)
  iupdate(ip);
80104b4e:	89 1c 24             	mov    %ebx,(%esp)
80104b51:	e8 5a cc ff ff       	call   801017b0 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80104b56:	83 c4 10             	add    $0x10,%esp
80104b59:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104b5e:	74 40                	je     80104ba0 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80104b60:	83 ec 04             	sub    $0x4,%esp
80104b63:	ff 73 04             	pushl  0x4(%ebx)
80104b66:	56                   	push   %esi
80104b67:	57                   	push   %edi
80104b68:	e8 83 d4 ff ff       	call   80101ff0 <dirlink>
80104b6d:	83 c4 10             	add    $0x10,%esp
80104b70:	85 c0                	test   %eax,%eax
80104b72:	78 77                	js     80104beb <create+0x17b>
    panic("create: dirlink");

  iunlockput(dp);
80104b74:	83 ec 0c             	sub    $0xc,%esp
80104b77:	57                   	push   %edi
80104b78:	e8 73 cf ff ff       	call   80101af0 <iunlockput>

  return ip;
80104b7d:	83 c4 10             	add    $0x10,%esp
}
80104b80:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
80104b83:	89 d8                	mov    %ebx,%eax
}
80104b85:	5b                   	pop    %ebx
80104b86:	5e                   	pop    %esi
80104b87:	5f                   	pop    %edi
80104b88:	5d                   	pop    %ebp
80104b89:	c3                   	ret    
80104b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80104b90:	31 c0                	xor    %eax,%eax
80104b92:	e9 49 ff ff ff       	jmp    80104ae0 <create+0x70>
80104b97:	89 f6                	mov    %esi,%esi
80104b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80104ba0:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
    iupdate(dp);
80104ba5:	83 ec 0c             	sub    $0xc,%esp
80104ba8:	57                   	push   %edi
80104ba9:	e8 02 cc ff ff       	call   801017b0 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104bae:	83 c4 0c             	add    $0xc,%esp
80104bb1:	ff 73 04             	pushl  0x4(%ebx)
80104bb4:	68 44 79 10 80       	push   $0x80107944
80104bb9:	53                   	push   %ebx
80104bba:	e8 31 d4 ff ff       	call   80101ff0 <dirlink>
80104bbf:	83 c4 10             	add    $0x10,%esp
80104bc2:	85 c0                	test   %eax,%eax
80104bc4:	78 18                	js     80104bde <create+0x16e>
80104bc6:	83 ec 04             	sub    $0x4,%esp
80104bc9:	ff 77 04             	pushl  0x4(%edi)
80104bcc:	68 43 79 10 80       	push   $0x80107943
80104bd1:	53                   	push   %ebx
80104bd2:	e8 19 d4 ff ff       	call   80101ff0 <dirlink>
80104bd7:	83 c4 10             	add    $0x10,%esp
80104bda:	85 c0                	test   %eax,%eax
80104bdc:	79 82                	jns    80104b60 <create+0xf0>
      panic("create dots");
80104bde:	83 ec 0c             	sub    $0xc,%esp
80104be1:	68 37 79 10 80       	push   $0x80107937
80104be6:	e8 85 b7 ff ff       	call   80100370 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
80104beb:	83 ec 0c             	sub    $0xc,%esp
80104bee:	68 46 79 10 80       	push   $0x80107946
80104bf3:	e8 78 b7 ff ff       	call   80100370 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80104bf8:	83 ec 0c             	sub    $0xc,%esp
80104bfb:	68 28 79 10 80       	push   $0x80107928
80104c00:	e8 6b b7 ff ff       	call   80100370 <panic>
80104c05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c10 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104c10:	55                   	push   %ebp
80104c11:	89 e5                	mov    %esp,%ebp
80104c13:	56                   	push   %esi
80104c14:	53                   	push   %ebx
80104c15:	89 c6                	mov    %eax,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104c17:	8d 45 f4             	lea    -0xc(%ebp),%eax
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104c1a:	89 d3                	mov    %edx,%ebx
80104c1c:	83 ec 18             	sub    $0x18,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104c1f:	50                   	push   %eax
80104c20:	6a 00                	push   $0x0
80104c22:	e8 f9 fc ff ff       	call   80104920 <argint>
80104c27:	83 c4 10             	add    $0x10,%esp
80104c2a:	85 c0                	test   %eax,%eax
80104c2c:	78 32                	js     80104c60 <argfd.constprop.0+0x50>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104c2e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104c32:	77 2c                	ja     80104c60 <argfd.constprop.0+0x50>
80104c34:	e8 37 ed ff ff       	call   80103970 <myproc>
80104c39:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104c3c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104c40:	85 c0                	test   %eax,%eax
80104c42:	74 1c                	je     80104c60 <argfd.constprop.0+0x50>
    return -1;
  if(pfd)
80104c44:	85 f6                	test   %esi,%esi
80104c46:	74 02                	je     80104c4a <argfd.constprop.0+0x3a>
    *pfd = fd;
80104c48:	89 16                	mov    %edx,(%esi)
  if(pf)
80104c4a:	85 db                	test   %ebx,%ebx
80104c4c:	74 22                	je     80104c70 <argfd.constprop.0+0x60>
    *pf = f;
80104c4e:	89 03                	mov    %eax,(%ebx)
  return 0;
80104c50:	31 c0                	xor    %eax,%eax
}
80104c52:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c55:	5b                   	pop    %ebx
80104c56:	5e                   	pop    %esi
80104c57:	5d                   	pop    %ebp
80104c58:	c3                   	ret    
80104c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c60:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
80104c63:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
80104c68:	5b                   	pop    %ebx
80104c69:	5e                   	pop    %esi
80104c6a:	5d                   	pop    %ebp
80104c6b:	c3                   	ret    
80104c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
80104c70:	31 c0                	xor    %eax,%eax
80104c72:	eb de                	jmp    80104c52 <argfd.constprop.0+0x42>
80104c74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104c80 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80104c80:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104c81:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80104c83:	89 e5                	mov    %esp,%ebp
80104c85:	56                   	push   %esi
80104c86:	53                   	push   %ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104c87:	8d 55 f4             	lea    -0xc(%ebp),%edx
  return -1;
}

int
sys_dup(void)
{
80104c8a:	83 ec 10             	sub    $0x10,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104c8d:	e8 7e ff ff ff       	call   80104c10 <argfd.constprop.0>
80104c92:	85 c0                	test   %eax,%eax
80104c94:	78 1a                	js     80104cb0 <sys_dup+0x30>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104c96:	31 db                	xor    %ebx,%ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
80104c98:	8b 75 f4             	mov    -0xc(%ebp),%esi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80104c9b:	e8 d0 ec ff ff       	call   80103970 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80104ca0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104ca4:	85 d2                	test   %edx,%edx
80104ca6:	74 18                	je     80104cc0 <sys_dup+0x40>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104ca8:	83 c3 01             	add    $0x1,%ebx
80104cab:	83 fb 10             	cmp    $0x10,%ebx
80104cae:	75 f0                	jne    80104ca0 <sys_dup+0x20>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104cb0:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80104cb3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104cb8:	5b                   	pop    %ebx
80104cb9:	5e                   	pop    %esi
80104cba:	5d                   	pop    %ebp
80104cbb:	c3                   	ret    
80104cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80104cc0:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80104cc4:	83 ec 0c             	sub    $0xc,%esp
80104cc7:	ff 75 f4             	pushl  -0xc(%ebp)
80104cca:	e8 01 c3 ff ff       	call   80100fd0 <filedup>
  return fd;
80104ccf:	83 c4 10             	add    $0x10,%esp
}
80104cd2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
80104cd5:	89 d8                	mov    %ebx,%eax
}
80104cd7:	5b                   	pop    %ebx
80104cd8:	5e                   	pop    %esi
80104cd9:	5d                   	pop    %ebp
80104cda:	c3                   	ret    
80104cdb:	90                   	nop
80104cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ce0 <sys_read>:

int
sys_read(void)
{
80104ce0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104ce1:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80104ce3:	89 e5                	mov    %esp,%ebp
80104ce5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104ce8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104ceb:	e8 20 ff ff ff       	call   80104c10 <argfd.constprop.0>
80104cf0:	85 c0                	test   %eax,%eax
80104cf2:	78 4c                	js     80104d40 <sys_read+0x60>
80104cf4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104cf7:	83 ec 08             	sub    $0x8,%esp
80104cfa:	50                   	push   %eax
80104cfb:	6a 02                	push   $0x2
80104cfd:	e8 1e fc ff ff       	call   80104920 <argint>
80104d02:	83 c4 10             	add    $0x10,%esp
80104d05:	85 c0                	test   %eax,%eax
80104d07:	78 37                	js     80104d40 <sys_read+0x60>
80104d09:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d0c:	83 ec 04             	sub    $0x4,%esp
80104d0f:	ff 75 f0             	pushl  -0x10(%ebp)
80104d12:	50                   	push   %eax
80104d13:	6a 01                	push   $0x1
80104d15:	e8 56 fc ff ff       	call   80104970 <argptr>
80104d1a:	83 c4 10             	add    $0x10,%esp
80104d1d:	85 c0                	test   %eax,%eax
80104d1f:	78 1f                	js     80104d40 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80104d21:	83 ec 04             	sub    $0x4,%esp
80104d24:	ff 75 f0             	pushl  -0x10(%ebp)
80104d27:	ff 75 f4             	pushl  -0xc(%ebp)
80104d2a:	ff 75 ec             	pushl  -0x14(%ebp)
80104d2d:	e8 0e c4 ff ff       	call   80101140 <fileread>
80104d32:	83 c4 10             	add    $0x10,%esp
}
80104d35:	c9                   	leave  
80104d36:	c3                   	ret    
80104d37:	89 f6                	mov    %esi,%esi
80104d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104d40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80104d45:	c9                   	leave  
80104d46:	c3                   	ret    
80104d47:	89 f6                	mov    %esi,%esi
80104d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d50 <sys_write>:

int
sys_write(void)
{
80104d50:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d51:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80104d53:	89 e5                	mov    %esp,%ebp
80104d55:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d58:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104d5b:	e8 b0 fe ff ff       	call   80104c10 <argfd.constprop.0>
80104d60:	85 c0                	test   %eax,%eax
80104d62:	78 4c                	js     80104db0 <sys_write+0x60>
80104d64:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d67:	83 ec 08             	sub    $0x8,%esp
80104d6a:	50                   	push   %eax
80104d6b:	6a 02                	push   $0x2
80104d6d:	e8 ae fb ff ff       	call   80104920 <argint>
80104d72:	83 c4 10             	add    $0x10,%esp
80104d75:	85 c0                	test   %eax,%eax
80104d77:	78 37                	js     80104db0 <sys_write+0x60>
80104d79:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d7c:	83 ec 04             	sub    $0x4,%esp
80104d7f:	ff 75 f0             	pushl  -0x10(%ebp)
80104d82:	50                   	push   %eax
80104d83:	6a 01                	push   $0x1
80104d85:	e8 e6 fb ff ff       	call   80104970 <argptr>
80104d8a:	83 c4 10             	add    $0x10,%esp
80104d8d:	85 c0                	test   %eax,%eax
80104d8f:	78 1f                	js     80104db0 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80104d91:	83 ec 04             	sub    $0x4,%esp
80104d94:	ff 75 f0             	pushl  -0x10(%ebp)
80104d97:	ff 75 f4             	pushl  -0xc(%ebp)
80104d9a:	ff 75 ec             	pushl  -0x14(%ebp)
80104d9d:	e8 2e c4 ff ff       	call   801011d0 <filewrite>
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
  return filewrite(f, p, n);
}
80104db5:	c9                   	leave  
80104db6:	c3                   	ret    
80104db7:	89 f6                	mov    %esi,%esi
80104db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104dc0 <sys_close>:

int
sys_close(void)
{
80104dc0:	55                   	push   %ebp
80104dc1:	89 e5                	mov    %esp,%ebp
80104dc3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80104dc6:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104dc9:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104dcc:	e8 3f fe ff ff       	call   80104c10 <argfd.constprop.0>
80104dd1:	85 c0                	test   %eax,%eax
80104dd3:	78 2b                	js     80104e00 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
80104dd5:	e8 96 eb ff ff       	call   80103970 <myproc>
80104dda:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104ddd:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  myproc()->ofile[fd] = 0;
80104de0:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104de7:	00 
  fileclose(f);
80104de8:	ff 75 f4             	pushl  -0xc(%ebp)
80104deb:	e8 30 c2 ff ff       	call   80101020 <fileclose>
  return 0;
80104df0:	83 c4 10             	add    $0x10,%esp
80104df3:	31 c0                	xor    %eax,%eax
}
80104df5:	c9                   	leave  
80104df6:	c3                   	ret    
80104df7:	89 f6                	mov    %esi,%esi
80104df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80104e00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80104e05:	c9                   	leave  
80104e06:	c3                   	ret    
80104e07:	89 f6                	mov    %esi,%esi
80104e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e10 <sys_fstat>:

int
sys_fstat(void)
{
80104e10:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104e11:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80104e13:	89 e5                	mov    %esp,%ebp
80104e15:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104e18:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104e1b:	e8 f0 fd ff ff       	call   80104c10 <argfd.constprop.0>
80104e20:	85 c0                	test   %eax,%eax
80104e22:	78 2c                	js     80104e50 <sys_fstat+0x40>
80104e24:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e27:	83 ec 04             	sub    $0x4,%esp
80104e2a:	6a 14                	push   $0x14
80104e2c:	50                   	push   %eax
80104e2d:	6a 01                	push   $0x1
80104e2f:	e8 3c fb ff ff       	call   80104970 <argptr>
80104e34:	83 c4 10             	add    $0x10,%esp
80104e37:	85 c0                	test   %eax,%eax
80104e39:	78 15                	js     80104e50 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
80104e3b:	83 ec 08             	sub    $0x8,%esp
80104e3e:	ff 75 f4             	pushl  -0xc(%ebp)
80104e41:	ff 75 f0             	pushl  -0x10(%ebp)
80104e44:	e8 a7 c2 ff ff       	call   801010f0 <filestat>
80104e49:	83 c4 10             	add    $0x10,%esp
}
80104e4c:	c9                   	leave  
80104e4d:	c3                   	ret    
80104e4e:	66 90                	xchg   %ax,%ax
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80104e50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80104e55:	c9                   	leave  
80104e56:	c3                   	ret    
80104e57:	89 f6                	mov    %esi,%esi
80104e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e60 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104e60:	55                   	push   %ebp
80104e61:	89 e5                	mov    %esp,%ebp
80104e63:	57                   	push   %edi
80104e64:	56                   	push   %esi
80104e65:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104e66:	8d 45 d4             	lea    -0x2c(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104e69:	83 ec 34             	sub    $0x34,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104e6c:	50                   	push   %eax
80104e6d:	6a 00                	push   $0x0
80104e6f:	e8 5c fb ff ff       	call   801049d0 <argstr>
80104e74:	83 c4 10             	add    $0x10,%esp
80104e77:	85 c0                	test   %eax,%eax
80104e79:	0f 88 fb 00 00 00    	js     80104f7a <sys_link+0x11a>
80104e7f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104e82:	83 ec 08             	sub    $0x8,%esp
80104e85:	50                   	push   %eax
80104e86:	6a 01                	push   $0x1
80104e88:	e8 43 fb ff ff       	call   801049d0 <argstr>
80104e8d:	83 c4 10             	add    $0x10,%esp
80104e90:	85 c0                	test   %eax,%eax
80104e92:	0f 88 e2 00 00 00    	js     80104f7a <sys_link+0x11a>
    return -1;

  begin_op();
80104e98:	e8 a3 de ff ff       	call   80102d40 <begin_op>
  if((ip = namei(old)) == 0){
80104e9d:	83 ec 0c             	sub    $0xc,%esp
80104ea0:	ff 75 d4             	pushl  -0x2c(%ebp)
80104ea3:	e8 08 d2 ff ff       	call   801020b0 <namei>
80104ea8:	83 c4 10             	add    $0x10,%esp
80104eab:	85 c0                	test   %eax,%eax
80104ead:	89 c3                	mov    %eax,%ebx
80104eaf:	0f 84 f3 00 00 00    	je     80104fa8 <sys_link+0x148>
    end_op();
    return -1;
  }

  ilock(ip);
80104eb5:	83 ec 0c             	sub    $0xc,%esp
80104eb8:	50                   	push   %eax
80104eb9:	e8 a2 c9 ff ff       	call   80101860 <ilock>
  if(ip->type == T_DIR){
80104ebe:	83 c4 10             	add    $0x10,%esp
80104ec1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104ec6:	0f 84 c4 00 00 00    	je     80104f90 <sys_link+0x130>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
80104ecc:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104ed1:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80104ed4:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80104ed7:	53                   	push   %ebx
80104ed8:	e8 d3 c8 ff ff       	call   801017b0 <iupdate>
  iunlock(ip);
80104edd:	89 1c 24             	mov    %ebx,(%esp)
80104ee0:	e8 5b ca ff ff       	call   80101940 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80104ee5:	58                   	pop    %eax
80104ee6:	5a                   	pop    %edx
80104ee7:	57                   	push   %edi
80104ee8:	ff 75 d0             	pushl  -0x30(%ebp)
80104eeb:	e8 e0 d1 ff ff       	call   801020d0 <nameiparent>
80104ef0:	83 c4 10             	add    $0x10,%esp
80104ef3:	85 c0                	test   %eax,%eax
80104ef5:	89 c6                	mov    %eax,%esi
80104ef7:	74 5b                	je     80104f54 <sys_link+0xf4>
    goto bad;
  ilock(dp);
80104ef9:	83 ec 0c             	sub    $0xc,%esp
80104efc:	50                   	push   %eax
80104efd:	e8 5e c9 ff ff       	call   80101860 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104f02:	83 c4 10             	add    $0x10,%esp
80104f05:	8b 03                	mov    (%ebx),%eax
80104f07:	39 06                	cmp    %eax,(%esi)
80104f09:	75 3d                	jne    80104f48 <sys_link+0xe8>
80104f0b:	83 ec 04             	sub    $0x4,%esp
80104f0e:	ff 73 04             	pushl  0x4(%ebx)
80104f11:	57                   	push   %edi
80104f12:	56                   	push   %esi
80104f13:	e8 d8 d0 ff ff       	call   80101ff0 <dirlink>
80104f18:	83 c4 10             	add    $0x10,%esp
80104f1b:	85 c0                	test   %eax,%eax
80104f1d:	78 29                	js     80104f48 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80104f1f:	83 ec 0c             	sub    $0xc,%esp
80104f22:	56                   	push   %esi
80104f23:	e8 c8 cb ff ff       	call   80101af0 <iunlockput>
  iput(ip);
80104f28:	89 1c 24             	mov    %ebx,(%esp)
80104f2b:	e8 60 ca ff ff       	call   80101990 <iput>

  end_op();
80104f30:	e8 7b de ff ff       	call   80102db0 <end_op>

  return 0;
80104f35:	83 c4 10             	add    $0x10,%esp
80104f38:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80104f3a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f3d:	5b                   	pop    %ebx
80104f3e:	5e                   	pop    %esi
80104f3f:	5f                   	pop    %edi
80104f40:	5d                   	pop    %ebp
80104f41:	c3                   	ret    
80104f42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80104f48:	83 ec 0c             	sub    $0xc,%esp
80104f4b:	56                   	push   %esi
80104f4c:	e8 9f cb ff ff       	call   80101af0 <iunlockput>
    goto bad;
80104f51:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  ilock(ip);
80104f54:	83 ec 0c             	sub    $0xc,%esp
80104f57:	53                   	push   %ebx
80104f58:	e8 03 c9 ff ff       	call   80101860 <ilock>
  ip->nlink--;
80104f5d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104f62:	89 1c 24             	mov    %ebx,(%esp)
80104f65:	e8 46 c8 ff ff       	call   801017b0 <iupdate>
  iunlockput(ip);
80104f6a:	89 1c 24             	mov    %ebx,(%esp)
80104f6d:	e8 7e cb ff ff       	call   80101af0 <iunlockput>
  end_op();
80104f72:	e8 39 de ff ff       	call   80102db0 <end_op>
  return -1;
80104f77:	83 c4 10             	add    $0x10,%esp
}
80104f7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
80104f7d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f82:	5b                   	pop    %ebx
80104f83:	5e                   	pop    %esi
80104f84:	5f                   	pop    %edi
80104f85:	5d                   	pop    %ebp
80104f86:	c3                   	ret    
80104f87:	89 f6                	mov    %esi,%esi
80104f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
80104f90:	83 ec 0c             	sub    $0xc,%esp
80104f93:	53                   	push   %ebx
80104f94:	e8 57 cb ff ff       	call   80101af0 <iunlockput>
    end_op();
80104f99:	e8 12 de ff ff       	call   80102db0 <end_op>
    return -1;
80104f9e:	83 c4 10             	add    $0x10,%esp
80104fa1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fa6:	eb 92                	jmp    80104f3a <sys_link+0xda>
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
80104fa8:	e8 03 de ff ff       	call   80102db0 <end_op>
    return -1;
80104fad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fb2:	eb 86                	jmp    80104f3a <sys_link+0xda>
80104fb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104fba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104fc0 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104fc0:	55                   	push   %ebp
80104fc1:	89 e5                	mov    %esp,%ebp
80104fc3:	57                   	push   %edi
80104fc4:	56                   	push   %esi
80104fc5:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104fc6:	8d 45 c0             	lea    -0x40(%ebp),%eax
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104fc9:	83 ec 54             	sub    $0x54,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104fcc:	50                   	push   %eax
80104fcd:	6a 00                	push   $0x0
80104fcf:	e8 fc f9 ff ff       	call   801049d0 <argstr>
80104fd4:	83 c4 10             	add    $0x10,%esp
80104fd7:	85 c0                	test   %eax,%eax
80104fd9:	0f 88 82 01 00 00    	js     80105161 <sys_unlink+0x1a1>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
80104fdf:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
80104fe2:	e8 59 dd ff ff       	call   80102d40 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104fe7:	83 ec 08             	sub    $0x8,%esp
80104fea:	53                   	push   %ebx
80104feb:	ff 75 c0             	pushl  -0x40(%ebp)
80104fee:	e8 dd d0 ff ff       	call   801020d0 <nameiparent>
80104ff3:	83 c4 10             	add    $0x10,%esp
80104ff6:	85 c0                	test   %eax,%eax
80104ff8:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80104ffb:	0f 84 6a 01 00 00    	je     8010516b <sys_unlink+0x1ab>
    end_op();
    return -1;
  }

  ilock(dp);
80105001:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80105004:	83 ec 0c             	sub    $0xc,%esp
80105007:	56                   	push   %esi
80105008:	e8 53 c8 ff ff       	call   80101860 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010500d:	58                   	pop    %eax
8010500e:	5a                   	pop    %edx
8010500f:	68 44 79 10 80       	push   $0x80107944
80105014:	53                   	push   %ebx
80105015:	e8 56 cd ff ff       	call   80101d70 <namecmp>
8010501a:	83 c4 10             	add    $0x10,%esp
8010501d:	85 c0                	test   %eax,%eax
8010501f:	0f 84 fc 00 00 00    	je     80105121 <sys_unlink+0x161>
80105025:	83 ec 08             	sub    $0x8,%esp
80105028:	68 43 79 10 80       	push   $0x80107943
8010502d:	53                   	push   %ebx
8010502e:	e8 3d cd ff ff       	call   80101d70 <namecmp>
80105033:	83 c4 10             	add    $0x10,%esp
80105036:	85 c0                	test   %eax,%eax
80105038:	0f 84 e3 00 00 00    	je     80105121 <sys_unlink+0x161>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
8010503e:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105041:	83 ec 04             	sub    $0x4,%esp
80105044:	50                   	push   %eax
80105045:	53                   	push   %ebx
80105046:	56                   	push   %esi
80105047:	e8 44 cd ff ff       	call   80101d90 <dirlookup>
8010504c:	83 c4 10             	add    $0x10,%esp
8010504f:	85 c0                	test   %eax,%eax
80105051:	89 c3                	mov    %eax,%ebx
80105053:	0f 84 c8 00 00 00    	je     80105121 <sys_unlink+0x161>
    goto bad;
  ilock(ip);
80105059:	83 ec 0c             	sub    $0xc,%esp
8010505c:	50                   	push   %eax
8010505d:	e8 fe c7 ff ff       	call   80101860 <ilock>

  if(ip->nlink < 1)
80105062:	83 c4 10             	add    $0x10,%esp
80105065:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010506a:	0f 8e 24 01 00 00    	jle    80105194 <sys_unlink+0x1d4>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80105070:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105075:	8d 75 d8             	lea    -0x28(%ebp),%esi
80105078:	74 66                	je     801050e0 <sys_unlink+0x120>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
8010507a:	83 ec 04             	sub    $0x4,%esp
8010507d:	6a 10                	push   $0x10
8010507f:	6a 00                	push   $0x0
80105081:	56                   	push   %esi
80105082:	e8 89 f5 ff ff       	call   80104610 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105087:	6a 10                	push   $0x10
80105089:	ff 75 c4             	pushl  -0x3c(%ebp)
8010508c:	56                   	push   %esi
8010508d:	ff 75 b4             	pushl  -0x4c(%ebp)
80105090:	e8 ab cb ff ff       	call   80101c40 <writei>
80105095:	83 c4 20             	add    $0x20,%esp
80105098:	83 f8 10             	cmp    $0x10,%eax
8010509b:	0f 85 e6 00 00 00    	jne    80105187 <sys_unlink+0x1c7>
    panic("unlink: writei");
  if(ip->type == T_DIR){
801050a1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801050a6:	0f 84 9c 00 00 00    	je     80105148 <sys_unlink+0x188>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
801050ac:	83 ec 0c             	sub    $0xc,%esp
801050af:	ff 75 b4             	pushl  -0x4c(%ebp)
801050b2:	e8 39 ca ff ff       	call   80101af0 <iunlockput>

  ip->nlink--;
801050b7:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801050bc:	89 1c 24             	mov    %ebx,(%esp)
801050bf:	e8 ec c6 ff ff       	call   801017b0 <iupdate>
  iunlockput(ip);
801050c4:	89 1c 24             	mov    %ebx,(%esp)
801050c7:	e8 24 ca ff ff       	call   80101af0 <iunlockput>

  end_op();
801050cc:	e8 df dc ff ff       	call   80102db0 <end_op>

  return 0;
801050d1:	83 c4 10             	add    $0x10,%esp
801050d4:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
801050d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801050d9:	5b                   	pop    %ebx
801050da:	5e                   	pop    %esi
801050db:	5f                   	pop    %edi
801050dc:	5d                   	pop    %ebp
801050dd:	c3                   	ret    
801050de:	66 90                	xchg   %ax,%ax
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801050e0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801050e4:	76 94                	jbe    8010507a <sys_unlink+0xba>
801050e6:	bf 20 00 00 00       	mov    $0x20,%edi
801050eb:	eb 0f                	jmp    801050fc <sys_unlink+0x13c>
801050ed:	8d 76 00             	lea    0x0(%esi),%esi
801050f0:	83 c7 10             	add    $0x10,%edi
801050f3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801050f6:	0f 83 7e ff ff ff    	jae    8010507a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801050fc:	6a 10                	push   $0x10
801050fe:	57                   	push   %edi
801050ff:	56                   	push   %esi
80105100:	53                   	push   %ebx
80105101:	e8 3a ca ff ff       	call   80101b40 <readi>
80105106:	83 c4 10             	add    $0x10,%esp
80105109:	83 f8 10             	cmp    $0x10,%eax
8010510c:	75 6c                	jne    8010517a <sys_unlink+0x1ba>
      panic("isdirempty: readi");
    if(de.inum != 0)
8010510e:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105113:	74 db                	je     801050f0 <sys_unlink+0x130>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
80105115:	83 ec 0c             	sub    $0xc,%esp
80105118:	53                   	push   %ebx
80105119:	e8 d2 c9 ff ff       	call   80101af0 <iunlockput>
    goto bad;
8010511e:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  iunlockput(dp);
80105121:	83 ec 0c             	sub    $0xc,%esp
80105124:	ff 75 b4             	pushl  -0x4c(%ebp)
80105127:	e8 c4 c9 ff ff       	call   80101af0 <iunlockput>
  end_op();
8010512c:	e8 7f dc ff ff       	call   80102db0 <end_op>
  return -1;
80105131:	83 c4 10             	add    $0x10,%esp
}
80105134:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
80105137:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010513c:	5b                   	pop    %ebx
8010513d:	5e                   	pop    %esi
8010513e:	5f                   	pop    %edi
8010513f:	5d                   	pop    %ebp
80105140:	c3                   	ret    
80105141:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80105148:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
8010514b:	83 ec 0c             	sub    $0xc,%esp

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
8010514e:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80105153:	50                   	push   %eax
80105154:	e8 57 c6 ff ff       	call   801017b0 <iupdate>
80105159:	83 c4 10             	add    $0x10,%esp
8010515c:	e9 4b ff ff ff       	jmp    801050ac <sys_unlink+0xec>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
80105161:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105166:	e9 6b ff ff ff       	jmp    801050d6 <sys_unlink+0x116>

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
8010516b:	e8 40 dc ff ff       	call   80102db0 <end_op>
    return -1;
80105170:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105175:	e9 5c ff ff ff       	jmp    801050d6 <sys_unlink+0x116>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
8010517a:	83 ec 0c             	sub    $0xc,%esp
8010517d:	68 68 79 10 80       	push   $0x80107968
80105182:	e8 e9 b1 ff ff       	call   80100370 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
80105187:	83 ec 0c             	sub    $0xc,%esp
8010518a:	68 7a 79 10 80       	push   $0x8010797a
8010518f:	e8 dc b1 ff ff       	call   80100370 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
80105194:	83 ec 0c             	sub    $0xc,%esp
80105197:	68 56 79 10 80       	push   $0x80107956
8010519c:	e8 cf b1 ff ff       	call   80100370 <panic>
801051a1:	eb 0d                	jmp    801051b0 <sys_open>
801051a3:	90                   	nop
801051a4:	90                   	nop
801051a5:	90                   	nop
801051a6:	90                   	nop
801051a7:	90                   	nop
801051a8:	90                   	nop
801051a9:	90                   	nop
801051aa:	90                   	nop
801051ab:	90                   	nop
801051ac:	90                   	nop
801051ad:	90                   	nop
801051ae:	90                   	nop
801051af:	90                   	nop

801051b0 <sys_open>:
  return ip;
}

int
sys_open(void)
{
801051b0:	55                   	push   %ebp
801051b1:	89 e5                	mov    %esp,%ebp
801051b3:	57                   	push   %edi
801051b4:	56                   	push   %esi
801051b5:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801051b6:	8d 45 e0             	lea    -0x20(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
801051b9:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801051bc:	50                   	push   %eax
801051bd:	6a 00                	push   $0x0
801051bf:	e8 0c f8 ff ff       	call   801049d0 <argstr>
801051c4:	83 c4 10             	add    $0x10,%esp
801051c7:	85 c0                	test   %eax,%eax
801051c9:	0f 88 9e 00 00 00    	js     8010526d <sys_open+0xbd>
801051cf:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801051d2:	83 ec 08             	sub    $0x8,%esp
801051d5:	50                   	push   %eax
801051d6:	6a 01                	push   $0x1
801051d8:	e8 43 f7 ff ff       	call   80104920 <argint>
801051dd:	83 c4 10             	add    $0x10,%esp
801051e0:	85 c0                	test   %eax,%eax
801051e2:	0f 88 85 00 00 00    	js     8010526d <sys_open+0xbd>
    return -1;

  begin_op();
801051e8:	e8 53 db ff ff       	call   80102d40 <begin_op>

  if(omode & O_CREATE){
801051ed:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801051f1:	0f 85 89 00 00 00    	jne    80105280 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801051f7:	83 ec 0c             	sub    $0xc,%esp
801051fa:	ff 75 e0             	pushl  -0x20(%ebp)
801051fd:	e8 ae ce ff ff       	call   801020b0 <namei>
80105202:	83 c4 10             	add    $0x10,%esp
80105205:	85 c0                	test   %eax,%eax
80105207:	89 c6                	mov    %eax,%esi
80105209:	0f 84 8e 00 00 00    	je     8010529d <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
8010520f:	83 ec 0c             	sub    $0xc,%esp
80105212:	50                   	push   %eax
80105213:	e8 48 c6 ff ff       	call   80101860 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105218:	83 c4 10             	add    $0x10,%esp
8010521b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105220:	0f 84 d2 00 00 00    	je     801052f8 <sys_open+0x148>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105226:	e8 35 bd ff ff       	call   80100f60 <filealloc>
8010522b:	85 c0                	test   %eax,%eax
8010522d:	89 c7                	mov    %eax,%edi
8010522f:	74 2b                	je     8010525c <sys_open+0xac>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105231:	31 db                	xor    %ebx,%ebx
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105233:	e8 38 e7 ff ff       	call   80103970 <myproc>
80105238:	90                   	nop
80105239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80105240:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105244:	85 d2                	test   %edx,%edx
80105246:	74 68                	je     801052b0 <sys_open+0x100>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105248:	83 c3 01             	add    $0x1,%ebx
8010524b:	83 fb 10             	cmp    $0x10,%ebx
8010524e:	75 f0                	jne    80105240 <sys_open+0x90>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
80105250:	83 ec 0c             	sub    $0xc,%esp
80105253:	57                   	push   %edi
80105254:	e8 c7 bd ff ff       	call   80101020 <fileclose>
80105259:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010525c:	83 ec 0c             	sub    $0xc,%esp
8010525f:	56                   	push   %esi
80105260:	e8 8b c8 ff ff       	call   80101af0 <iunlockput>
    end_op();
80105265:	e8 46 db ff ff       	call   80102db0 <end_op>
    return -1;
8010526a:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
8010526d:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
80105270:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80105275:	5b                   	pop    %ebx
80105276:	5e                   	pop    %esi
80105277:	5f                   	pop    %edi
80105278:	5d                   	pop    %ebp
80105279:	c3                   	ret    
8010527a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105280:	83 ec 0c             	sub    $0xc,%esp
80105283:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105286:	31 c9                	xor    %ecx,%ecx
80105288:	6a 00                	push   $0x0
8010528a:	ba 02 00 00 00       	mov    $0x2,%edx
8010528f:	e8 dc f7 ff ff       	call   80104a70 <create>
    if(ip == 0){
80105294:	83 c4 10             	add    $0x10,%esp
80105297:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105299:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010529b:	75 89                	jne    80105226 <sys_open+0x76>
      end_op();
8010529d:	e8 0e db ff ff       	call   80102db0 <end_op>
      return -1;
801052a2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052a7:	eb 43                	jmp    801052ec <sys_open+0x13c>
801052a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801052b0:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
801052b3:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801052b7:	56                   	push   %esi
801052b8:	e8 83 c6 ff ff       	call   80101940 <iunlock>
  end_op();
801052bd:	e8 ee da ff ff       	call   80102db0 <end_op>

  f->type = FD_INODE;
801052c2:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801052c8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052cb:	83 c4 10             	add    $0x10,%esp
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
801052ce:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801052d1:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801052d8:	89 d0                	mov    %edx,%eax
801052da:	83 e0 01             	and    $0x1,%eax
801052dd:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052e0:	83 e2 03             	and    $0x3,%edx
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801052e3:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052e6:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
801052ea:	89 d8                	mov    %ebx,%eax
}
801052ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052ef:	5b                   	pop    %ebx
801052f0:	5e                   	pop    %esi
801052f1:	5f                   	pop    %edi
801052f2:	5d                   	pop    %ebp
801052f3:	c3                   	ret    
801052f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
801052f8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801052fb:	85 c9                	test   %ecx,%ecx
801052fd:	0f 84 23 ff ff ff    	je     80105226 <sys_open+0x76>
80105303:	e9 54 ff ff ff       	jmp    8010525c <sys_open+0xac>
80105308:	90                   	nop
80105309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105310 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80105310:	55                   	push   %ebp
80105311:	89 e5                	mov    %esp,%ebp
80105313:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105316:	e8 25 da ff ff       	call   80102d40 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010531b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010531e:	83 ec 08             	sub    $0x8,%esp
80105321:	50                   	push   %eax
80105322:	6a 00                	push   $0x0
80105324:	e8 a7 f6 ff ff       	call   801049d0 <argstr>
80105329:	83 c4 10             	add    $0x10,%esp
8010532c:	85 c0                	test   %eax,%eax
8010532e:	78 30                	js     80105360 <sys_mkdir+0x50>
80105330:	83 ec 0c             	sub    $0xc,%esp
80105333:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105336:	31 c9                	xor    %ecx,%ecx
80105338:	6a 00                	push   $0x0
8010533a:	ba 01 00 00 00       	mov    $0x1,%edx
8010533f:	e8 2c f7 ff ff       	call   80104a70 <create>
80105344:	83 c4 10             	add    $0x10,%esp
80105347:	85 c0                	test   %eax,%eax
80105349:	74 15                	je     80105360 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010534b:	83 ec 0c             	sub    $0xc,%esp
8010534e:	50                   	push   %eax
8010534f:	e8 9c c7 ff ff       	call   80101af0 <iunlockput>
  end_op();
80105354:	e8 57 da ff ff       	call   80102db0 <end_op>
  return 0;
80105359:	83 c4 10             	add    $0x10,%esp
8010535c:	31 c0                	xor    %eax,%eax
}
8010535e:	c9                   	leave  
8010535f:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
80105360:	e8 4b da ff ff       	call   80102db0 <end_op>
    return -1;
80105365:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010536a:	c9                   	leave  
8010536b:	c3                   	ret    
8010536c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105370 <sys_mknod>:

int
sys_mknod(void)
{
80105370:	55                   	push   %ebp
80105371:	89 e5                	mov    %esp,%ebp
80105373:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105376:	e8 c5 d9 ff ff       	call   80102d40 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010537b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010537e:	83 ec 08             	sub    $0x8,%esp
80105381:	50                   	push   %eax
80105382:	6a 00                	push   $0x0
80105384:	e8 47 f6 ff ff       	call   801049d0 <argstr>
80105389:	83 c4 10             	add    $0x10,%esp
8010538c:	85 c0                	test   %eax,%eax
8010538e:	78 60                	js     801053f0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105390:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105393:	83 ec 08             	sub    $0x8,%esp
80105396:	50                   	push   %eax
80105397:	6a 01                	push   $0x1
80105399:	e8 82 f5 ff ff       	call   80104920 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
8010539e:	83 c4 10             	add    $0x10,%esp
801053a1:	85 c0                	test   %eax,%eax
801053a3:	78 4b                	js     801053f0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
801053a5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053a8:	83 ec 08             	sub    $0x8,%esp
801053ab:	50                   	push   %eax
801053ac:	6a 02                	push   $0x2
801053ae:	e8 6d f5 ff ff       	call   80104920 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
801053b3:	83 c4 10             	add    $0x10,%esp
801053b6:	85 c0                	test   %eax,%eax
801053b8:	78 36                	js     801053f0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801053ba:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801053be:	83 ec 0c             	sub    $0xc,%esp
801053c1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801053c5:	ba 03 00 00 00       	mov    $0x3,%edx
801053ca:	50                   	push   %eax
801053cb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801053ce:	e8 9d f6 ff ff       	call   80104a70 <create>
801053d3:	83 c4 10             	add    $0x10,%esp
801053d6:	85 c0                	test   %eax,%eax
801053d8:	74 16                	je     801053f0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
801053da:	83 ec 0c             	sub    $0xc,%esp
801053dd:	50                   	push   %eax
801053de:	e8 0d c7 ff ff       	call   80101af0 <iunlockput>
  end_op();
801053e3:	e8 c8 d9 ff ff       	call   80102db0 <end_op>
  return 0;
801053e8:	83 c4 10             	add    $0x10,%esp
801053eb:	31 c0                	xor    %eax,%eax
}
801053ed:	c9                   	leave  
801053ee:	c3                   	ret    
801053ef:	90                   	nop
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
801053f0:	e8 bb d9 ff ff       	call   80102db0 <end_op>
    return -1;
801053f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
801053fa:	c9                   	leave  
801053fb:	c3                   	ret    
801053fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105400 <sys_chdir>:

int
sys_chdir(void)
{
80105400:	55                   	push   %ebp
80105401:	89 e5                	mov    %esp,%ebp
80105403:	56                   	push   %esi
80105404:	53                   	push   %ebx
80105405:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105408:	e8 63 e5 ff ff       	call   80103970 <myproc>
8010540d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010540f:	e8 2c d9 ff ff       	call   80102d40 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105414:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105417:	83 ec 08             	sub    $0x8,%esp
8010541a:	50                   	push   %eax
8010541b:	6a 00                	push   $0x0
8010541d:	e8 ae f5 ff ff       	call   801049d0 <argstr>
80105422:	83 c4 10             	add    $0x10,%esp
80105425:	85 c0                	test   %eax,%eax
80105427:	78 77                	js     801054a0 <sys_chdir+0xa0>
80105429:	83 ec 0c             	sub    $0xc,%esp
8010542c:	ff 75 f4             	pushl  -0xc(%ebp)
8010542f:	e8 7c cc ff ff       	call   801020b0 <namei>
80105434:	83 c4 10             	add    $0x10,%esp
80105437:	85 c0                	test   %eax,%eax
80105439:	89 c3                	mov    %eax,%ebx
8010543b:	74 63                	je     801054a0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010543d:	83 ec 0c             	sub    $0xc,%esp
80105440:	50                   	push   %eax
80105441:	e8 1a c4 ff ff       	call   80101860 <ilock>
  if(ip->type != T_DIR){
80105446:	83 c4 10             	add    $0x10,%esp
80105449:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010544e:	75 30                	jne    80105480 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105450:	83 ec 0c             	sub    $0xc,%esp
80105453:	53                   	push   %ebx
80105454:	e8 e7 c4 ff ff       	call   80101940 <iunlock>
  iput(curproc->cwd);
80105459:	58                   	pop    %eax
8010545a:	ff 76 68             	pushl  0x68(%esi)
8010545d:	e8 2e c5 ff ff       	call   80101990 <iput>
  end_op();
80105462:	e8 49 d9 ff ff       	call   80102db0 <end_op>
  curproc->cwd = ip;
80105467:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010546a:	83 c4 10             	add    $0x10,%esp
8010546d:	31 c0                	xor    %eax,%eax
}
8010546f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105472:	5b                   	pop    %ebx
80105473:	5e                   	pop    %esi
80105474:	5d                   	pop    %ebp
80105475:	c3                   	ret    
80105476:	8d 76 00             	lea    0x0(%esi),%esi
80105479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
80105480:	83 ec 0c             	sub    $0xc,%esp
80105483:	53                   	push   %ebx
80105484:	e8 67 c6 ff ff       	call   80101af0 <iunlockput>
    end_op();
80105489:	e8 22 d9 ff ff       	call   80102db0 <end_op>
    return -1;
8010548e:	83 c4 10             	add    $0x10,%esp
80105491:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105496:	eb d7                	jmp    8010546f <sys_chdir+0x6f>
80105498:	90                   	nop
80105499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct inode *ip;
  struct proc *curproc = myproc();
  
  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
801054a0:	e8 0b d9 ff ff       	call   80102db0 <end_op>
    return -1;
801054a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054aa:	eb c3                	jmp    8010546f <sys_chdir+0x6f>
801054ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054b0 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
801054b0:	55                   	push   %ebp
801054b1:	89 e5                	mov    %esp,%ebp
801054b3:	57                   	push   %edi
801054b4:	56                   	push   %esi
801054b5:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801054b6:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
801054bc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801054c2:	50                   	push   %eax
801054c3:	6a 00                	push   $0x0
801054c5:	e8 06 f5 ff ff       	call   801049d0 <argstr>
801054ca:	83 c4 10             	add    $0x10,%esp
801054cd:	85 c0                	test   %eax,%eax
801054cf:	78 7f                	js     80105550 <sys_exec+0xa0>
801054d1:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801054d7:	83 ec 08             	sub    $0x8,%esp
801054da:	50                   	push   %eax
801054db:	6a 01                	push   $0x1
801054dd:	e8 3e f4 ff ff       	call   80104920 <argint>
801054e2:	83 c4 10             	add    $0x10,%esp
801054e5:	85 c0                	test   %eax,%eax
801054e7:	78 67                	js     80105550 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801054e9:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801054ef:	83 ec 04             	sub    $0x4,%esp
801054f2:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
801054f8:	68 80 00 00 00       	push   $0x80
801054fd:	6a 00                	push   $0x0
801054ff:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105505:	50                   	push   %eax
80105506:	31 db                	xor    %ebx,%ebx
80105508:	e8 03 f1 ff ff       	call   80104610 <memset>
8010550d:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105510:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105516:	83 ec 08             	sub    $0x8,%esp
80105519:	57                   	push   %edi
8010551a:	8d 04 98             	lea    (%eax,%ebx,4),%eax
8010551d:	50                   	push   %eax
8010551e:	e8 5d f3 ff ff       	call   80104880 <fetchint>
80105523:	83 c4 10             	add    $0x10,%esp
80105526:	85 c0                	test   %eax,%eax
80105528:	78 26                	js     80105550 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
8010552a:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105530:	85 c0                	test   %eax,%eax
80105532:	74 2c                	je     80105560 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105534:	83 ec 08             	sub    $0x8,%esp
80105537:	56                   	push   %esi
80105538:	50                   	push   %eax
80105539:	e8 82 f3 ff ff       	call   801048c0 <fetchstr>
8010553e:	83 c4 10             	add    $0x10,%esp
80105541:	85 c0                	test   %eax,%eax
80105543:	78 0b                	js     80105550 <sys_exec+0xa0>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80105545:	83 c3 01             	add    $0x1,%ebx
80105548:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
8010554b:	83 fb 20             	cmp    $0x20,%ebx
8010554e:	75 c0                	jne    80105510 <sys_exec+0x60>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105550:	8d 65 f4             	lea    -0xc(%ebp),%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
80105553:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105558:	5b                   	pop    %ebx
80105559:	5e                   	pop    %esi
8010555a:	5f                   	pop    %edi
8010555b:	5d                   	pop    %ebp
8010555c:	c3                   	ret    
8010555d:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105560:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105566:	83 ec 08             	sub    $0x8,%esp
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
80105569:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105570:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105574:	50                   	push   %eax
80105575:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010557b:	e8 60 b6 ff ff       	call   80100be0 <exec>
80105580:	83 c4 10             	add    $0x10,%esp
}
80105583:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105586:	5b                   	pop    %ebx
80105587:	5e                   	pop    %esi
80105588:	5f                   	pop    %edi
80105589:	5d                   	pop    %ebp
8010558a:	c3                   	ret    
8010558b:	90                   	nop
8010558c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105590 <sys_pipe>:

int
sys_pipe(void)
{
80105590:	55                   	push   %ebp
80105591:	89 e5                	mov    %esp,%ebp
80105593:	57                   	push   %edi
80105594:	56                   	push   %esi
80105595:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105596:	8d 45 dc             	lea    -0x24(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
80105599:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010559c:	6a 08                	push   $0x8
8010559e:	50                   	push   %eax
8010559f:	6a 00                	push   $0x0
801055a1:	e8 ca f3 ff ff       	call   80104970 <argptr>
801055a6:	83 c4 10             	add    $0x10,%esp
801055a9:	85 c0                	test   %eax,%eax
801055ab:	78 4a                	js     801055f7 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801055ad:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801055b0:	83 ec 08             	sub    $0x8,%esp
801055b3:	50                   	push   %eax
801055b4:	8d 45 e0             	lea    -0x20(%ebp),%eax
801055b7:	50                   	push   %eax
801055b8:	e8 23 de ff ff       	call   801033e0 <pipealloc>
801055bd:	83 c4 10             	add    $0x10,%esp
801055c0:	85 c0                	test   %eax,%eax
801055c2:	78 33                	js     801055f7 <sys_pipe+0x67>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801055c4:	31 db                	xor    %ebx,%ebx
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801055c6:	8b 7d e0             	mov    -0x20(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801055c9:	e8 a2 e3 ff ff       	call   80103970 <myproc>
801055ce:	66 90                	xchg   %ax,%ax

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
801055d0:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801055d4:	85 f6                	test   %esi,%esi
801055d6:	74 30                	je     80105608 <sys_pipe+0x78>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801055d8:	83 c3 01             	add    $0x1,%ebx
801055db:	83 fb 10             	cmp    $0x10,%ebx
801055de:	75 f0                	jne    801055d0 <sys_pipe+0x40>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
801055e0:	83 ec 0c             	sub    $0xc,%esp
801055e3:	ff 75 e0             	pushl  -0x20(%ebp)
801055e6:	e8 35 ba ff ff       	call   80101020 <fileclose>
    fileclose(wf);
801055eb:	58                   	pop    %eax
801055ec:	ff 75 e4             	pushl  -0x1c(%ebp)
801055ef:	e8 2c ba ff ff       	call   80101020 <fileclose>
    return -1;
801055f4:	83 c4 10             	add    $0x10,%esp
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
801055f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
801055fa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
801055ff:	5b                   	pop    %ebx
80105600:	5e                   	pop    %esi
80105601:	5f                   	pop    %edi
80105602:	5d                   	pop    %ebp
80105603:	c3                   	ret    
80105604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105608:	8d 73 08             	lea    0x8(%ebx),%esi
8010560b:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010560f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105612:	e8 59 e3 ff ff       	call   80103970 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
80105617:	31 d2                	xor    %edx,%edx
80105619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105620:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105624:	85 c9                	test   %ecx,%ecx
80105626:	74 18                	je     80105640 <sys_pipe+0xb0>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105628:	83 c2 01             	add    $0x1,%edx
8010562b:	83 fa 10             	cmp    $0x10,%edx
8010562e:	75 f0                	jne    80105620 <sys_pipe+0x90>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80105630:	e8 3b e3 ff ff       	call   80103970 <myproc>
80105635:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
8010563c:	00 
8010563d:	eb a1                	jmp    801055e0 <sys_pipe+0x50>
8010563f:	90                   	nop
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105640:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105644:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105647:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105649:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010564c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
}
8010564f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
80105652:	31 c0                	xor    %eax,%eax
}
80105654:	5b                   	pop    %ebx
80105655:	5e                   	pop    %esi
80105656:	5f                   	pop    %edi
80105657:	5d                   	pop    %ebp
80105658:	c3                   	ret    
80105659:	66 90                	xchg   %ax,%ax
8010565b:	66 90                	xchg   %ax,%ax
8010565d:	66 90                	xchg   %ax,%ax
8010565f:	90                   	nop

80105660 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105660:	55                   	push   %ebp
80105661:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105663:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105664:	e9 a7 e4 ff ff       	jmp    80103b10 <fork>
80105669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105670 <sys_exit>:
}

int
sys_exit(void)
{
80105670:	55                   	push   %ebp
80105671:	89 e5                	mov    %esp,%ebp
80105673:	83 ec 08             	sub    $0x8,%esp
  exit();
80105676:	e8 25 e7 ff ff       	call   80103da0 <exit>
  return 0;  // not reached
}
8010567b:	31 c0                	xor    %eax,%eax
8010567d:	c9                   	leave  
8010567e:	c3                   	ret    
8010567f:	90                   	nop

80105680 <sys_wait>:

int
sys_wait(void)
{
80105680:	55                   	push   %ebp
80105681:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105683:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
80105684:	e9 67 e9 ff ff       	jmp    80103ff0 <wait>
80105689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105690 <sys_kill>:
}

int
sys_kill(void)
{
80105690:	55                   	push   %ebp
80105691:	89 e5                	mov    %esp,%ebp
80105693:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105696:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105699:	50                   	push   %eax
8010569a:	6a 00                	push   $0x0
8010569c:	e8 7f f2 ff ff       	call   80104920 <argint>
801056a1:	83 c4 10             	add    $0x10,%esp
801056a4:	85 c0                	test   %eax,%eax
801056a6:	78 18                	js     801056c0 <sys_kill+0x30>
    return -1;
  return kill(pid);
801056a8:	83 ec 0c             	sub    $0xc,%esp
801056ab:	ff 75 f4             	pushl  -0xc(%ebp)
801056ae:	e8 8d ea ff ff       	call   80104140 <kill>
801056b3:	83 c4 10             	add    $0x10,%esp
}
801056b6:	c9                   	leave  
801056b7:	c3                   	ret    
801056b8:	90                   	nop
801056b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
801056c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
801056c5:	c9                   	leave  
801056c6:	c3                   	ret    
801056c7:	89 f6                	mov    %esi,%esi
801056c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801056d0 <sys_getpid>:

int
sys_getpid(void)
{
801056d0:	55                   	push   %ebp
801056d1:	89 e5                	mov    %esp,%ebp
801056d3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801056d6:	e8 95 e2 ff ff       	call   80103970 <myproc>
801056db:	8b 40 10             	mov    0x10(%eax),%eax
}
801056de:	c9                   	leave  
801056df:	c3                   	ret    

801056e0 <sys_sbrk>:

int
sys_sbrk(void)
{
801056e0:	55                   	push   %ebp
801056e1:	89 e5                	mov    %esp,%ebp
801056e3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801056e4:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return myproc()->pid;
}

int
sys_sbrk(void)
{
801056e7:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801056ea:	50                   	push   %eax
801056eb:	6a 00                	push   $0x0
801056ed:	e8 2e f2 ff ff       	call   80104920 <argint>
801056f2:	83 c4 10             	add    $0x10,%esp
801056f5:	85 c0                	test   %eax,%eax
801056f7:	78 27                	js     80105720 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801056f9:	e8 72 e2 ff ff       	call   80103970 <myproc>
  if(growproc(n) < 0)
801056fe:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
80105701:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105703:	ff 75 f4             	pushl  -0xc(%ebp)
80105706:	e8 85 e3 ff ff       	call   80103a90 <growproc>
8010570b:	83 c4 10             	add    $0x10,%esp
8010570e:	85 c0                	test   %eax,%eax
80105710:	78 0e                	js     80105720 <sys_sbrk+0x40>
    return -1;
  return addr;
80105712:	89 d8                	mov    %ebx,%eax
}
80105714:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105717:	c9                   	leave  
80105718:	c3                   	ret    
80105719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80105720:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105725:	eb ed                	jmp    80105714 <sys_sbrk+0x34>
80105727:	89 f6                	mov    %esi,%esi
80105729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105730 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
80105730:	55                   	push   %ebp
80105731:	89 e5                	mov    %esp,%ebp
80105733:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105734:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return addr;
}

int
sys_sleep(void)
{
80105737:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
8010573a:	50                   	push   %eax
8010573b:	6a 00                	push   $0x0
8010573d:	e8 de f1 ff ff       	call   80104920 <argint>
80105742:	83 c4 10             	add    $0x10,%esp
80105745:	85 c0                	test   %eax,%eax
80105747:	0f 88 8a 00 00 00    	js     801057d7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010574d:	83 ec 0c             	sub    $0xc,%esp
80105750:	68 00 5c 11 80       	push   $0x80115c00
80105755:	e8 46 ed ff ff       	call   801044a0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010575a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010575d:	83 c4 10             	add    $0x10,%esp
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
80105760:	8b 1d 40 64 11 80    	mov    0x80116440,%ebx
  while(ticks - ticks0 < n){
80105766:	85 d2                	test   %edx,%edx
80105768:	75 27                	jne    80105791 <sys_sleep+0x61>
8010576a:	eb 54                	jmp    801057c0 <sys_sleep+0x90>
8010576c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105770:	83 ec 08             	sub    $0x8,%esp
80105773:	68 00 5c 11 80       	push   $0x80115c00
80105778:	68 40 64 11 80       	push   $0x80116440
8010577d:	e8 ae e7 ff ff       	call   80103f30 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105782:	a1 40 64 11 80       	mov    0x80116440,%eax
80105787:	83 c4 10             	add    $0x10,%esp
8010578a:	29 d8                	sub    %ebx,%eax
8010578c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010578f:	73 2f                	jae    801057c0 <sys_sleep+0x90>
    if(myproc()->killed){
80105791:	e8 da e1 ff ff       	call   80103970 <myproc>
80105796:	8b 40 24             	mov    0x24(%eax),%eax
80105799:	85 c0                	test   %eax,%eax
8010579b:	74 d3                	je     80105770 <sys_sleep+0x40>
      release(&tickslock);
8010579d:	83 ec 0c             	sub    $0xc,%esp
801057a0:	68 00 5c 11 80       	push   $0x80115c00
801057a5:	e8 16 ee ff ff       	call   801045c0 <release>
      return -1;
801057aa:	83 c4 10             	add    $0x10,%esp
801057ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
801057b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057b5:	c9                   	leave  
801057b6:	c3                   	ret    
801057b7:	89 f6                	mov    %esi,%esi
801057b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
801057c0:	83 ec 0c             	sub    $0xc,%esp
801057c3:	68 00 5c 11 80       	push   $0x80115c00
801057c8:	e8 f3 ed ff ff       	call   801045c0 <release>
  return 0;
801057cd:	83 c4 10             	add    $0x10,%esp
801057d0:	31 c0                	xor    %eax,%eax
}
801057d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057d5:	c9                   	leave  
801057d6:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
801057d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057dc:	eb d4                	jmp    801057b2 <sys_sleep+0x82>
801057de:	66 90                	xchg   %ax,%ax

801057e0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801057e0:	55                   	push   %ebp
801057e1:	89 e5                	mov    %esp,%ebp
801057e3:	53                   	push   %ebx
801057e4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801057e7:	68 00 5c 11 80       	push   $0x80115c00
801057ec:	e8 af ec ff ff       	call   801044a0 <acquire>
  xticks = ticks;
801057f1:	8b 1d 40 64 11 80    	mov    0x80116440,%ebx
  release(&tickslock);
801057f7:	c7 04 24 00 5c 11 80 	movl   $0x80115c00,(%esp)
801057fe:	e8 bd ed ff ff       	call   801045c0 <release>
  return xticks;
}
80105803:	89 d8                	mov    %ebx,%eax
80105805:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105808:	c9                   	leave  
80105809:	c3                   	ret    
8010580a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105810 <sys_captsc>:

int
sys_captsc(void)
{
80105810:	55                   	push   %ebp
80105811:	89 e5                	mov    %esp,%ebp
80105813:	53                   	push   %ebx
  int* handler;
  if (argptr(0, (void*)&handler, sizeof(handler)) < 0)
80105814:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return xticks;
}

int
sys_captsc(void)
{
80105817:	83 ec 18             	sub    $0x18,%esp
  int* handler;
  if (argptr(0, (void*)&handler, sizeof(handler)) < 0)
8010581a:	6a 04                	push   $0x4
8010581c:	50                   	push   %eax
8010581d:	6a 00                	push   $0x0
8010581f:	e8 4c f1 ff ff       	call   80104970 <argptr>
80105824:	83 c4 10             	add    $0x10,%esp
80105827:	85 c0                	test   %eax,%eax
80105829:	78 25                	js     80105850 <sys_captsc+0x40>
    return -1;
  return capturescreen(myproc()->pid, handler);
8010582b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010582e:	e8 3d e1 ff ff       	call   80103970 <myproc>
80105833:	83 ec 08             	sub    $0x8,%esp
80105836:	53                   	push   %ebx
80105837:	ff 70 10             	pushl  0x10(%eax)
8010583a:	e8 d1 af ff ff       	call   80100810 <capturescreen>
8010583f:	83 c4 10             	add    $0x10,%esp
}
80105842:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105845:	c9                   	leave  
80105846:	c3                   	ret    
80105847:	89 f6                	mov    %esi,%esi
80105849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
int
sys_captsc(void)
{
  int* handler;
  if (argptr(0, (void*)&handler, sizeof(handler)) < 0)
    return -1;
80105850:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105855:	eb eb                	jmp    80105842 <sys_captsc+0x32>
80105857:	89 f6                	mov    %esi,%esi
80105859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105860 <sys_freesc>:
  return capturescreen(myproc()->pid, handler);
}

int
sys_freesc(void)
{
80105860:	55                   	push   %ebp
80105861:	89 e5                	mov    %esp,%ebp
80105863:	83 ec 08             	sub    $0x8,%esp
  return freescreen(myproc()->pid);
80105866:	e8 05 e1 ff ff       	call   80103970 <myproc>
8010586b:	83 ec 0c             	sub    $0xc,%esp
8010586e:	ff 70 10             	pushl  0x10(%eax)
80105871:	e8 2a b0 ff ff       	call   801008a0 <freescreen>
}
80105876:	c9                   	leave  
80105877:	c3                   	ret    
80105878:	90                   	nop
80105879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105880 <sys_updatesc>:

int
sys_updatesc(void) {
80105880:	55                   	push   %ebp
80105881:	89 e5                	mov    %esp,%ebp
80105883:	57                   	push   %edi
80105884:	56                   	push   %esi
80105885:	53                   	push   %ebx
  int x, y, color;
  char* content;
  if(argint(0, &x) < 0)
80105886:	8d 45 d8             	lea    -0x28(%ebp),%eax
{
  return freescreen(myproc()->pid);
}

int
sys_updatesc(void) {
80105889:	83 ec 34             	sub    $0x34,%esp
  int x, y, color;
  char* content;
  if(argint(0, &x) < 0)
8010588c:	50                   	push   %eax
8010588d:	6a 00                	push   $0x0
8010588f:	e8 8c f0 ff ff       	call   80104920 <argint>
80105894:	83 c4 10             	add    $0x10,%esp
80105897:	85 c0                	test   %eax,%eax
80105899:	78 75                	js     80105910 <sys_updatesc+0x90>
    return -1;
  if(argint(1, &y) < 0)
8010589b:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010589e:	83 ec 08             	sub    $0x8,%esp
801058a1:	50                   	push   %eax
801058a2:	6a 01                	push   $0x1
801058a4:	e8 77 f0 ff ff       	call   80104920 <argint>
801058a9:	83 c4 10             	add    $0x10,%esp
801058ac:	85 c0                	test   %eax,%eax
801058ae:	78 60                	js     80105910 <sys_updatesc+0x90>
    return -1;
  if (argptr(2, (void*)&content, sizeof(content)) < 0)
801058b0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801058b3:	83 ec 04             	sub    $0x4,%esp
801058b6:	6a 04                	push   $0x4
801058b8:	50                   	push   %eax
801058b9:	6a 02                	push   $0x2
801058bb:	e8 b0 f0 ff ff       	call   80104970 <argptr>
801058c0:	83 c4 10             	add    $0x10,%esp
801058c3:	85 c0                	test   %eax,%eax
801058c5:	78 49                	js     80105910 <sys_updatesc+0x90>
    return -1;
  if(argint(3, &color) < 0)
801058c7:	8d 45 e0             	lea    -0x20(%ebp),%eax
801058ca:	83 ec 08             	sub    $0x8,%esp
801058cd:	50                   	push   %eax
801058ce:	6a 03                	push   $0x3
801058d0:	e8 4b f0 ff ff       	call   80104920 <argint>
801058d5:	83 c4 10             	add    $0x10,%esp
801058d8:	85 c0                	test   %eax,%eax
801058da:	78 34                	js     80105910 <sys_updatesc+0x90>
    return -1;
  return updatescreen(myproc()->pid, x, y, content, color);
801058dc:	8b 55 e0             	mov    -0x20(%ebp),%edx
801058df:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801058e2:	8b 75 dc             	mov    -0x24(%ebp),%esi
801058e5:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801058e8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801058eb:	e8 80 e0 ff ff       	call   80103970 <myproc>
801058f0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
801058f3:	83 ec 0c             	sub    $0xc,%esp
801058f6:	52                   	push   %edx
801058f7:	57                   	push   %edi
801058f8:	56                   	push   %esi
801058f9:	53                   	push   %ebx
801058fa:	ff 70 10             	pushl  0x10(%eax)
801058fd:	e8 0e b0 ff ff       	call   80100910 <updatescreen>
80105902:	83 c4 20             	add    $0x20,%esp
}
80105905:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105908:	5b                   	pop    %ebx
80105909:	5e                   	pop    %esi
8010590a:	5f                   	pop    %edi
8010590b:	5d                   	pop    %ebp
8010590c:	c3                   	ret    
8010590d:	8d 76 00             	lea    0x0(%esi),%esi
80105910:	8d 65 f4             	lea    -0xc(%ebp),%esp
int
sys_updatesc(void) {
  int x, y, color;
  char* content;
  if(argint(0, &x) < 0)
    return -1;
80105913:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if (argptr(2, (void*)&content, sizeof(content)) < 0)
    return -1;
  if(argint(3, &color) < 0)
    return -1;
  return updatescreen(myproc()->pid, x, y, content, color);
}
80105918:	5b                   	pop    %ebx
80105919:	5e                   	pop    %esi
8010591a:	5f                   	pop    %edi
8010591b:	5d                   	pop    %ebp
8010591c:	c3                   	ret    
8010591d:	8d 76 00             	lea    0x0(%esi),%esi

80105920 <sys_getkey>:

int 
sys_getkey(void)
{
80105920:	55                   	push   %ebp
80105921:	89 e5                	mov    %esp,%ebp
80105923:	83 ec 08             	sub    $0x8,%esp
  return readkey(myproc()->pid);
80105926:	e8 45 e0 ff ff       	call   80103970 <myproc>
8010592b:	83 ec 0c             	sub    $0xc,%esp
8010592e:	ff 70 10             	pushl  0x10(%eax)
80105931:	e8 7a b2 ff ff       	call   80100bb0 <readkey>
}
80105936:	c9                   	leave  
80105937:	c3                   	ret    

80105938 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105938:	1e                   	push   %ds
  pushl %es
80105939:	06                   	push   %es
  pushl %fs
8010593a:	0f a0                	push   %fs
  pushl %gs
8010593c:	0f a8                	push   %gs
  pushal
8010593e:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
8010593f:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105943:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105945:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105947:	54                   	push   %esp
  call trap
80105948:	e8 e3 00 00 00       	call   80105a30 <trap>
  addl $4, %esp
8010594d:	83 c4 04             	add    $0x4,%esp

80105950 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105950:	61                   	popa   
  popl %gs
80105951:	0f a9                	pop    %gs
  popl %fs
80105953:	0f a1                	pop    %fs
  popl %es
80105955:	07                   	pop    %es
  popl %ds
80105956:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105957:	83 c4 08             	add    $0x8,%esp
  iret
8010595a:	cf                   	iret   
8010595b:	66 90                	xchg   %ax,%ax
8010595d:	66 90                	xchg   %ax,%ax
8010595f:	90                   	nop

80105960 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105960:	31 c0                	xor    %eax,%eax
80105962:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105968:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
8010596f:	b9 08 00 00 00       	mov    $0x8,%ecx
80105974:	c6 04 c5 44 5c 11 80 	movb   $0x0,-0x7feea3bc(,%eax,8)
8010597b:	00 
8010597c:	66 89 0c c5 42 5c 11 	mov    %cx,-0x7feea3be(,%eax,8)
80105983:	80 
80105984:	c6 04 c5 45 5c 11 80 	movb   $0x8e,-0x7feea3bb(,%eax,8)
8010598b:	8e 
8010598c:	66 89 14 c5 40 5c 11 	mov    %dx,-0x7feea3c0(,%eax,8)
80105993:	80 
80105994:	c1 ea 10             	shr    $0x10,%edx
80105997:	66 89 14 c5 46 5c 11 	mov    %dx,-0x7feea3ba(,%eax,8)
8010599e:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
8010599f:	83 c0 01             	add    $0x1,%eax
801059a2:	3d 00 01 00 00       	cmp    $0x100,%eax
801059a7:	75 bf                	jne    80105968 <tvinit+0x8>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801059a9:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801059aa:	ba 08 00 00 00       	mov    $0x8,%edx
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801059af:	89 e5                	mov    %esp,%ebp
801059b1:	83 ec 10             	sub    $0x10,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801059b4:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
801059b9:	68 89 79 10 80       	push   $0x80107989
801059be:	68 00 5c 11 80       	push   $0x80115c00
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801059c3:	66 89 15 42 5e 11 80 	mov    %dx,0x80115e42
801059ca:	c6 05 44 5e 11 80 00 	movb   $0x0,0x80115e44
801059d1:	66 a3 40 5e 11 80    	mov    %ax,0x80115e40
801059d7:	c1 e8 10             	shr    $0x10,%eax
801059da:	c6 05 45 5e 11 80 ef 	movb   $0xef,0x80115e45
801059e1:	66 a3 46 5e 11 80    	mov    %ax,0x80115e46

  initlock(&tickslock, "time");
801059e7:	e8 b4 e9 ff ff       	call   801043a0 <initlock>
}
801059ec:	83 c4 10             	add    $0x10,%esp
801059ef:	c9                   	leave  
801059f0:	c3                   	ret    
801059f1:	eb 0d                	jmp    80105a00 <idtinit>
801059f3:	90                   	nop
801059f4:	90                   	nop
801059f5:	90                   	nop
801059f6:	90                   	nop
801059f7:	90                   	nop
801059f8:	90                   	nop
801059f9:	90                   	nop
801059fa:	90                   	nop
801059fb:	90                   	nop
801059fc:	90                   	nop
801059fd:	90                   	nop
801059fe:	90                   	nop
801059ff:	90                   	nop

80105a00 <idtinit>:

void
idtinit(void)
{
80105a00:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80105a01:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105a06:	89 e5                	mov    %esp,%ebp
80105a08:	83 ec 10             	sub    $0x10,%esp
80105a0b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105a0f:	b8 40 5c 11 80       	mov    $0x80115c40,%eax
80105a14:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105a18:	c1 e8 10             	shr    $0x10,%eax
80105a1b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80105a1f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105a22:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105a25:	c9                   	leave  
80105a26:	c3                   	ret    
80105a27:	89 f6                	mov    %esi,%esi
80105a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a30 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105a30:	55                   	push   %ebp
80105a31:	89 e5                	mov    %esp,%ebp
80105a33:	57                   	push   %edi
80105a34:	56                   	push   %esi
80105a35:	53                   	push   %ebx
80105a36:	83 ec 1c             	sub    $0x1c,%esp
80105a39:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
80105a3c:	8b 47 30             	mov    0x30(%edi),%eax
80105a3f:	83 f8 40             	cmp    $0x40,%eax
80105a42:	0f 84 88 01 00 00    	je     80105bd0 <trap+0x1a0>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105a48:	83 e8 20             	sub    $0x20,%eax
80105a4b:	83 f8 1f             	cmp    $0x1f,%eax
80105a4e:	77 10                	ja     80105a60 <trap+0x30>
80105a50:	ff 24 85 30 7a 10 80 	jmp    *-0x7fef85d0(,%eax,4)
80105a57:	89 f6                	mov    %esi,%esi
80105a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105a60:	e8 0b df ff ff       	call   80103970 <myproc>
80105a65:	85 c0                	test   %eax,%eax
80105a67:	0f 84 d7 01 00 00    	je     80105c44 <trap+0x214>
80105a6d:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105a71:	0f 84 cd 01 00 00    	je     80105c44 <trap+0x214>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105a77:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a7a:	8b 57 38             	mov    0x38(%edi),%edx
80105a7d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105a80:	89 55 dc             	mov    %edx,-0x24(%ebp)
80105a83:	e8 c8 de ff ff       	call   80103950 <cpuid>
80105a88:	8b 77 34             	mov    0x34(%edi),%esi
80105a8b:	8b 5f 30             	mov    0x30(%edi),%ebx
80105a8e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105a91:	e8 da de ff ff       	call   80103970 <myproc>
80105a96:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105a99:	e8 d2 de ff ff       	call   80103970 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a9e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105aa1:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105aa4:	51                   	push   %ecx
80105aa5:	52                   	push   %edx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105aa6:	8b 55 e0             	mov    -0x20(%ebp),%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105aa9:	ff 75 e4             	pushl  -0x1c(%ebp)
80105aac:	56                   	push   %esi
80105aad:	53                   	push   %ebx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105aae:	83 c2 6c             	add    $0x6c,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105ab1:	52                   	push   %edx
80105ab2:	ff 70 10             	pushl  0x10(%eax)
80105ab5:	68 ec 79 10 80       	push   $0x801079ec
80105aba:	e8 c1 ab ff ff       	call   80100680 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105abf:	83 c4 20             	add    $0x20,%esp
80105ac2:	e8 a9 de ff ff       	call   80103970 <myproc>
80105ac7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80105ace:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ad0:	e8 9b de ff ff       	call   80103970 <myproc>
80105ad5:	85 c0                	test   %eax,%eax
80105ad7:	74 0c                	je     80105ae5 <trap+0xb5>
80105ad9:	e8 92 de ff ff       	call   80103970 <myproc>
80105ade:	8b 50 24             	mov    0x24(%eax),%edx
80105ae1:	85 d2                	test   %edx,%edx
80105ae3:	75 4b                	jne    80105b30 <trap+0x100>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105ae5:	e8 86 de ff ff       	call   80103970 <myproc>
80105aea:	85 c0                	test   %eax,%eax
80105aec:	74 0b                	je     80105af9 <trap+0xc9>
80105aee:	e8 7d de ff ff       	call   80103970 <myproc>
80105af3:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105af7:	74 4f                	je     80105b48 <trap+0x118>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105af9:	e8 72 de ff ff       	call   80103970 <myproc>
80105afe:	85 c0                	test   %eax,%eax
80105b00:	74 1d                	je     80105b1f <trap+0xef>
80105b02:	e8 69 de ff ff       	call   80103970 <myproc>
80105b07:	8b 40 24             	mov    0x24(%eax),%eax
80105b0a:	85 c0                	test   %eax,%eax
80105b0c:	74 11                	je     80105b1f <trap+0xef>
80105b0e:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105b12:	83 e0 03             	and    $0x3,%eax
80105b15:	66 83 f8 03          	cmp    $0x3,%ax
80105b19:	0f 84 da 00 00 00    	je     80105bf9 <trap+0x1c9>
    exit();
}
80105b1f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b22:	5b                   	pop    %ebx
80105b23:	5e                   	pop    %esi
80105b24:	5f                   	pop    %edi
80105b25:	5d                   	pop    %ebp
80105b26:	c3                   	ret    
80105b27:	89 f6                	mov    %esi,%esi
80105b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b30:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105b34:	83 e0 03             	and    $0x3,%eax
80105b37:	66 83 f8 03          	cmp    $0x3,%ax
80105b3b:	75 a8                	jne    80105ae5 <trap+0xb5>
    exit();
80105b3d:	e8 5e e2 ff ff       	call   80103da0 <exit>
80105b42:	eb a1                	jmp    80105ae5 <trap+0xb5>
80105b44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105b48:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105b4c:	75 ab                	jne    80105af9 <trap+0xc9>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
80105b4e:	e8 8d e3 ff ff       	call   80103ee0 <yield>
80105b53:	eb a4                	jmp    80105af9 <trap+0xc9>
80105b55:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80105b58:	e8 f3 dd ff ff       	call   80103950 <cpuid>
80105b5d:	85 c0                	test   %eax,%eax
80105b5f:	0f 84 ab 00 00 00    	je     80105c10 <trap+0x1e0>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80105b65:	e8 96 cd ff ff       	call   80102900 <lapiceoi>
    break;
80105b6a:	e9 61 ff ff ff       	jmp    80105ad0 <trap+0xa0>
80105b6f:	90                   	nop
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80105b70:	e8 4b cc ff ff       	call   801027c0 <kbdintr>
    lapiceoi();
80105b75:	e8 86 cd ff ff       	call   80102900 <lapiceoi>
    break;
80105b7a:	e9 51 ff ff ff       	jmp    80105ad0 <trap+0xa0>
80105b7f:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80105b80:	e8 5b 02 00 00       	call   80105de0 <uartintr>
    lapiceoi();
80105b85:	e8 76 cd ff ff       	call   80102900 <lapiceoi>
    break;
80105b8a:	e9 41 ff ff ff       	jmp    80105ad0 <trap+0xa0>
80105b8f:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105b90:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105b94:	8b 77 38             	mov    0x38(%edi),%esi
80105b97:	e8 b4 dd ff ff       	call   80103950 <cpuid>
80105b9c:	56                   	push   %esi
80105b9d:	53                   	push   %ebx
80105b9e:	50                   	push   %eax
80105b9f:	68 94 79 10 80       	push   $0x80107994
80105ba4:	e8 d7 aa ff ff       	call   80100680 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
80105ba9:	e8 52 cd ff ff       	call   80102900 <lapiceoi>
    break;
80105bae:	83 c4 10             	add    $0x10,%esp
80105bb1:	e9 1a ff ff ff       	jmp    80105ad0 <trap+0xa0>
80105bb6:	8d 76 00             	lea    0x0(%esi),%esi
80105bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105bc0:	e8 7b c6 ff ff       	call   80102240 <ideintr>
80105bc5:	eb 9e                	jmp    80105b65 <trap+0x135>
80105bc7:	89 f6                	mov    %esi,%esi
80105bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
80105bd0:	e8 9b dd ff ff       	call   80103970 <myproc>
80105bd5:	8b 58 24             	mov    0x24(%eax),%ebx
80105bd8:	85 db                	test   %ebx,%ebx
80105bda:	75 2c                	jne    80105c08 <trap+0x1d8>
      exit();
    myproc()->tf = tf;
80105bdc:	e8 8f dd ff ff       	call   80103970 <myproc>
80105be1:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80105be4:	e8 27 ee ff ff       	call   80104a10 <syscall>
    if(myproc()->killed)
80105be9:	e8 82 dd ff ff       	call   80103970 <myproc>
80105bee:	8b 48 24             	mov    0x24(%eax),%ecx
80105bf1:	85 c9                	test   %ecx,%ecx
80105bf3:	0f 84 26 ff ff ff    	je     80105b1f <trap+0xef>
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80105bf9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bfc:	5b                   	pop    %ebx
80105bfd:	5e                   	pop    %esi
80105bfe:	5f                   	pop    %edi
80105bff:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
80105c00:	e9 9b e1 ff ff       	jmp    80103da0 <exit>
80105c05:	8d 76 00             	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
80105c08:	e8 93 e1 ff ff       	call   80103da0 <exit>
80105c0d:	eb cd                	jmp    80105bdc <trap+0x1ac>
80105c0f:	90                   	nop
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
80105c10:	83 ec 0c             	sub    $0xc,%esp
80105c13:	68 00 5c 11 80       	push   $0x80115c00
80105c18:	e8 83 e8 ff ff       	call   801044a0 <acquire>
      ticks++;
      wakeup(&ticks);
80105c1d:	c7 04 24 40 64 11 80 	movl   $0x80116440,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
80105c24:	83 05 40 64 11 80 01 	addl   $0x1,0x80116440
      wakeup(&ticks);
80105c2b:	e8 b0 e4 ff ff       	call   801040e0 <wakeup>
      release(&tickslock);
80105c30:	c7 04 24 00 5c 11 80 	movl   $0x80115c00,(%esp)
80105c37:	e8 84 e9 ff ff       	call   801045c0 <release>
80105c3c:	83 c4 10             	add    $0x10,%esp
80105c3f:	e9 21 ff ff ff       	jmp    80105b65 <trap+0x135>
80105c44:	0f 20 d6             	mov    %cr2,%esi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105c47:	8b 5f 38             	mov    0x38(%edi),%ebx
80105c4a:	e8 01 dd ff ff       	call   80103950 <cpuid>
80105c4f:	83 ec 0c             	sub    $0xc,%esp
80105c52:	56                   	push   %esi
80105c53:	53                   	push   %ebx
80105c54:	50                   	push   %eax
80105c55:	ff 77 30             	pushl  0x30(%edi)
80105c58:	68 b8 79 10 80       	push   $0x801079b8
80105c5d:	e8 1e aa ff ff       	call   80100680 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
80105c62:	83 c4 14             	add    $0x14,%esp
80105c65:	68 8e 79 10 80       	push   $0x8010798e
80105c6a:	e8 01 a7 ff ff       	call   80100370 <panic>
80105c6f:	90                   	nop

80105c70 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105c70:	a1 5c b5 10 80       	mov    0x8010b55c,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80105c75:	55                   	push   %ebp
80105c76:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105c78:	85 c0                	test   %eax,%eax
80105c7a:	74 1c                	je     80105c98 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105c7c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105c81:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105c82:	a8 01                	test   $0x1,%al
80105c84:	74 12                	je     80105c98 <uartgetc+0x28>
80105c86:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c8b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105c8c:	0f b6 c0             	movzbl %al,%eax
}
80105c8f:	5d                   	pop    %ebp
80105c90:	c3                   	ret    
80105c91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80105c98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
80105c9d:	5d                   	pop    %ebp
80105c9e:	c3                   	ret    
80105c9f:	90                   	nop

80105ca0 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
80105ca0:	55                   	push   %ebp
80105ca1:	89 e5                	mov    %esp,%ebp
80105ca3:	57                   	push   %edi
80105ca4:	56                   	push   %esi
80105ca5:	53                   	push   %ebx
80105ca6:	89 c7                	mov    %eax,%edi
80105ca8:	bb 80 00 00 00       	mov    $0x80,%ebx
80105cad:	be fd 03 00 00       	mov    $0x3fd,%esi
80105cb2:	83 ec 0c             	sub    $0xc,%esp
80105cb5:	eb 1b                	jmp    80105cd2 <uartputc.part.0+0x32>
80105cb7:	89 f6                	mov    %esi,%esi
80105cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80105cc0:	83 ec 0c             	sub    $0xc,%esp
80105cc3:	6a 0a                	push   $0xa
80105cc5:	e8 56 cc ff ff       	call   80102920 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105cca:	83 c4 10             	add    $0x10,%esp
80105ccd:	83 eb 01             	sub    $0x1,%ebx
80105cd0:	74 07                	je     80105cd9 <uartputc.part.0+0x39>
80105cd2:	89 f2                	mov    %esi,%edx
80105cd4:	ec                   	in     (%dx),%al
80105cd5:	a8 20                	test   $0x20,%al
80105cd7:	74 e7                	je     80105cc0 <uartputc.part.0+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105cd9:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105cde:	89 f8                	mov    %edi,%eax
80105ce0:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80105ce1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ce4:	5b                   	pop    %ebx
80105ce5:	5e                   	pop    %esi
80105ce6:	5f                   	pop    %edi
80105ce7:	5d                   	pop    %ebp
80105ce8:	c3                   	ret    
80105ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105cf0 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80105cf0:	55                   	push   %ebp
80105cf1:	31 c9                	xor    %ecx,%ecx
80105cf3:	89 c8                	mov    %ecx,%eax
80105cf5:	89 e5                	mov    %esp,%ebp
80105cf7:	57                   	push   %edi
80105cf8:	56                   	push   %esi
80105cf9:	53                   	push   %ebx
80105cfa:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105cff:	89 da                	mov    %ebx,%edx
80105d01:	83 ec 0c             	sub    $0xc,%esp
80105d04:	ee                   	out    %al,(%dx)
80105d05:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105d0a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105d0f:	89 fa                	mov    %edi,%edx
80105d11:	ee                   	out    %al,(%dx)
80105d12:	b8 0c 00 00 00       	mov    $0xc,%eax
80105d17:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d1c:	ee                   	out    %al,(%dx)
80105d1d:	be f9 03 00 00       	mov    $0x3f9,%esi
80105d22:	89 c8                	mov    %ecx,%eax
80105d24:	89 f2                	mov    %esi,%edx
80105d26:	ee                   	out    %al,(%dx)
80105d27:	b8 03 00 00 00       	mov    $0x3,%eax
80105d2c:	89 fa                	mov    %edi,%edx
80105d2e:	ee                   	out    %al,(%dx)
80105d2f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105d34:	89 c8                	mov    %ecx,%eax
80105d36:	ee                   	out    %al,(%dx)
80105d37:	b8 01 00 00 00       	mov    $0x1,%eax
80105d3c:	89 f2                	mov    %esi,%edx
80105d3e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105d3f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105d44:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80105d45:	3c ff                	cmp    $0xff,%al
80105d47:	74 5a                	je     80105da3 <uartinit+0xb3>
    return;
  uart = 1;
80105d49:	c7 05 5c b5 10 80 01 	movl   $0x1,0x8010b55c
80105d50:	00 00 00 
80105d53:	89 da                	mov    %ebx,%edx
80105d55:	ec                   	in     (%dx),%al
80105d56:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d5b:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
80105d5c:	83 ec 08             	sub    $0x8,%esp
80105d5f:	bb b0 7a 10 80       	mov    $0x80107ab0,%ebx
80105d64:	6a 00                	push   $0x0
80105d66:	6a 04                	push   $0x4
80105d68:	e8 23 c7 ff ff       	call   80102490 <ioapicenable>
80105d6d:	83 c4 10             	add    $0x10,%esp
80105d70:	b8 78 00 00 00       	mov    $0x78,%eax
80105d75:	eb 13                	jmp    80105d8a <uartinit+0x9a>
80105d77:	89 f6                	mov    %esi,%esi
80105d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105d80:	83 c3 01             	add    $0x1,%ebx
80105d83:	0f be 03             	movsbl (%ebx),%eax
80105d86:	84 c0                	test   %al,%al
80105d88:	74 19                	je     80105da3 <uartinit+0xb3>
void
uartputc(int c)
{
  int i;

  if(!uart)
80105d8a:	8b 15 5c b5 10 80    	mov    0x8010b55c,%edx
80105d90:	85 d2                	test   %edx,%edx
80105d92:	74 ec                	je     80105d80 <uartinit+0x90>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105d94:	83 c3 01             	add    $0x1,%ebx
80105d97:	e8 04 ff ff ff       	call   80105ca0 <uartputc.part.0>
80105d9c:	0f be 03             	movsbl (%ebx),%eax
80105d9f:	84 c0                	test   %al,%al
80105da1:	75 e7                	jne    80105d8a <uartinit+0x9a>
    uartputc(*p);
}
80105da3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105da6:	5b                   	pop    %ebx
80105da7:	5e                   	pop    %esi
80105da8:	5f                   	pop    %edi
80105da9:	5d                   	pop    %ebp
80105daa:	c3                   	ret    
80105dab:	90                   	nop
80105dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105db0 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80105db0:	8b 15 5c b5 10 80    	mov    0x8010b55c,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105db6:	55                   	push   %ebp
80105db7:	89 e5                	mov    %esp,%ebp
  int i;

  if(!uart)
80105db9:	85 d2                	test   %edx,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105dbb:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
80105dbe:	74 10                	je     80105dd0 <uartputc+0x20>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80105dc0:	5d                   	pop    %ebp
80105dc1:	e9 da fe ff ff       	jmp    80105ca0 <uartputc.part.0>
80105dc6:	8d 76 00             	lea    0x0(%esi),%esi
80105dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105dd0:	5d                   	pop    %ebp
80105dd1:	c3                   	ret    
80105dd2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105de0 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80105de0:	55                   	push   %ebp
80105de1:	89 e5                	mov    %esp,%ebp
80105de3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105de6:	68 70 5c 10 80       	push   $0x80105c70
80105deb:	e8 90 ab ff ff       	call   80100980 <consoleintr>
}
80105df0:	83 c4 10             	add    $0x10,%esp
80105df3:	c9                   	leave  
80105df4:	c3                   	ret    

80105df5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105df5:	6a 00                	push   $0x0
  pushl $0
80105df7:	6a 00                	push   $0x0
  jmp alltraps
80105df9:	e9 3a fb ff ff       	jmp    80105938 <alltraps>

80105dfe <vector1>:
.globl vector1
vector1:
  pushl $0
80105dfe:	6a 00                	push   $0x0
  pushl $1
80105e00:	6a 01                	push   $0x1
  jmp alltraps
80105e02:	e9 31 fb ff ff       	jmp    80105938 <alltraps>

80105e07 <vector2>:
.globl vector2
vector2:
  pushl $0
80105e07:	6a 00                	push   $0x0
  pushl $2
80105e09:	6a 02                	push   $0x2
  jmp alltraps
80105e0b:	e9 28 fb ff ff       	jmp    80105938 <alltraps>

80105e10 <vector3>:
.globl vector3
vector3:
  pushl $0
80105e10:	6a 00                	push   $0x0
  pushl $3
80105e12:	6a 03                	push   $0x3
  jmp alltraps
80105e14:	e9 1f fb ff ff       	jmp    80105938 <alltraps>

80105e19 <vector4>:
.globl vector4
vector4:
  pushl $0
80105e19:	6a 00                	push   $0x0
  pushl $4
80105e1b:	6a 04                	push   $0x4
  jmp alltraps
80105e1d:	e9 16 fb ff ff       	jmp    80105938 <alltraps>

80105e22 <vector5>:
.globl vector5
vector5:
  pushl $0
80105e22:	6a 00                	push   $0x0
  pushl $5
80105e24:	6a 05                	push   $0x5
  jmp alltraps
80105e26:	e9 0d fb ff ff       	jmp    80105938 <alltraps>

80105e2b <vector6>:
.globl vector6
vector6:
  pushl $0
80105e2b:	6a 00                	push   $0x0
  pushl $6
80105e2d:	6a 06                	push   $0x6
  jmp alltraps
80105e2f:	e9 04 fb ff ff       	jmp    80105938 <alltraps>

80105e34 <vector7>:
.globl vector7
vector7:
  pushl $0
80105e34:	6a 00                	push   $0x0
  pushl $7
80105e36:	6a 07                	push   $0x7
  jmp alltraps
80105e38:	e9 fb fa ff ff       	jmp    80105938 <alltraps>

80105e3d <vector8>:
.globl vector8
vector8:
  pushl $8
80105e3d:	6a 08                	push   $0x8
  jmp alltraps
80105e3f:	e9 f4 fa ff ff       	jmp    80105938 <alltraps>

80105e44 <vector9>:
.globl vector9
vector9:
  pushl $0
80105e44:	6a 00                	push   $0x0
  pushl $9
80105e46:	6a 09                	push   $0x9
  jmp alltraps
80105e48:	e9 eb fa ff ff       	jmp    80105938 <alltraps>

80105e4d <vector10>:
.globl vector10
vector10:
  pushl $10
80105e4d:	6a 0a                	push   $0xa
  jmp alltraps
80105e4f:	e9 e4 fa ff ff       	jmp    80105938 <alltraps>

80105e54 <vector11>:
.globl vector11
vector11:
  pushl $11
80105e54:	6a 0b                	push   $0xb
  jmp alltraps
80105e56:	e9 dd fa ff ff       	jmp    80105938 <alltraps>

80105e5b <vector12>:
.globl vector12
vector12:
  pushl $12
80105e5b:	6a 0c                	push   $0xc
  jmp alltraps
80105e5d:	e9 d6 fa ff ff       	jmp    80105938 <alltraps>

80105e62 <vector13>:
.globl vector13
vector13:
  pushl $13
80105e62:	6a 0d                	push   $0xd
  jmp alltraps
80105e64:	e9 cf fa ff ff       	jmp    80105938 <alltraps>

80105e69 <vector14>:
.globl vector14
vector14:
  pushl $14
80105e69:	6a 0e                	push   $0xe
  jmp alltraps
80105e6b:	e9 c8 fa ff ff       	jmp    80105938 <alltraps>

80105e70 <vector15>:
.globl vector15
vector15:
  pushl $0
80105e70:	6a 00                	push   $0x0
  pushl $15
80105e72:	6a 0f                	push   $0xf
  jmp alltraps
80105e74:	e9 bf fa ff ff       	jmp    80105938 <alltraps>

80105e79 <vector16>:
.globl vector16
vector16:
  pushl $0
80105e79:	6a 00                	push   $0x0
  pushl $16
80105e7b:	6a 10                	push   $0x10
  jmp alltraps
80105e7d:	e9 b6 fa ff ff       	jmp    80105938 <alltraps>

80105e82 <vector17>:
.globl vector17
vector17:
  pushl $17
80105e82:	6a 11                	push   $0x11
  jmp alltraps
80105e84:	e9 af fa ff ff       	jmp    80105938 <alltraps>

80105e89 <vector18>:
.globl vector18
vector18:
  pushl $0
80105e89:	6a 00                	push   $0x0
  pushl $18
80105e8b:	6a 12                	push   $0x12
  jmp alltraps
80105e8d:	e9 a6 fa ff ff       	jmp    80105938 <alltraps>

80105e92 <vector19>:
.globl vector19
vector19:
  pushl $0
80105e92:	6a 00                	push   $0x0
  pushl $19
80105e94:	6a 13                	push   $0x13
  jmp alltraps
80105e96:	e9 9d fa ff ff       	jmp    80105938 <alltraps>

80105e9b <vector20>:
.globl vector20
vector20:
  pushl $0
80105e9b:	6a 00                	push   $0x0
  pushl $20
80105e9d:	6a 14                	push   $0x14
  jmp alltraps
80105e9f:	e9 94 fa ff ff       	jmp    80105938 <alltraps>

80105ea4 <vector21>:
.globl vector21
vector21:
  pushl $0
80105ea4:	6a 00                	push   $0x0
  pushl $21
80105ea6:	6a 15                	push   $0x15
  jmp alltraps
80105ea8:	e9 8b fa ff ff       	jmp    80105938 <alltraps>

80105ead <vector22>:
.globl vector22
vector22:
  pushl $0
80105ead:	6a 00                	push   $0x0
  pushl $22
80105eaf:	6a 16                	push   $0x16
  jmp alltraps
80105eb1:	e9 82 fa ff ff       	jmp    80105938 <alltraps>

80105eb6 <vector23>:
.globl vector23
vector23:
  pushl $0
80105eb6:	6a 00                	push   $0x0
  pushl $23
80105eb8:	6a 17                	push   $0x17
  jmp alltraps
80105eba:	e9 79 fa ff ff       	jmp    80105938 <alltraps>

80105ebf <vector24>:
.globl vector24
vector24:
  pushl $0
80105ebf:	6a 00                	push   $0x0
  pushl $24
80105ec1:	6a 18                	push   $0x18
  jmp alltraps
80105ec3:	e9 70 fa ff ff       	jmp    80105938 <alltraps>

80105ec8 <vector25>:
.globl vector25
vector25:
  pushl $0
80105ec8:	6a 00                	push   $0x0
  pushl $25
80105eca:	6a 19                	push   $0x19
  jmp alltraps
80105ecc:	e9 67 fa ff ff       	jmp    80105938 <alltraps>

80105ed1 <vector26>:
.globl vector26
vector26:
  pushl $0
80105ed1:	6a 00                	push   $0x0
  pushl $26
80105ed3:	6a 1a                	push   $0x1a
  jmp alltraps
80105ed5:	e9 5e fa ff ff       	jmp    80105938 <alltraps>

80105eda <vector27>:
.globl vector27
vector27:
  pushl $0
80105eda:	6a 00                	push   $0x0
  pushl $27
80105edc:	6a 1b                	push   $0x1b
  jmp alltraps
80105ede:	e9 55 fa ff ff       	jmp    80105938 <alltraps>

80105ee3 <vector28>:
.globl vector28
vector28:
  pushl $0
80105ee3:	6a 00                	push   $0x0
  pushl $28
80105ee5:	6a 1c                	push   $0x1c
  jmp alltraps
80105ee7:	e9 4c fa ff ff       	jmp    80105938 <alltraps>

80105eec <vector29>:
.globl vector29
vector29:
  pushl $0
80105eec:	6a 00                	push   $0x0
  pushl $29
80105eee:	6a 1d                	push   $0x1d
  jmp alltraps
80105ef0:	e9 43 fa ff ff       	jmp    80105938 <alltraps>

80105ef5 <vector30>:
.globl vector30
vector30:
  pushl $0
80105ef5:	6a 00                	push   $0x0
  pushl $30
80105ef7:	6a 1e                	push   $0x1e
  jmp alltraps
80105ef9:	e9 3a fa ff ff       	jmp    80105938 <alltraps>

80105efe <vector31>:
.globl vector31
vector31:
  pushl $0
80105efe:	6a 00                	push   $0x0
  pushl $31
80105f00:	6a 1f                	push   $0x1f
  jmp alltraps
80105f02:	e9 31 fa ff ff       	jmp    80105938 <alltraps>

80105f07 <vector32>:
.globl vector32
vector32:
  pushl $0
80105f07:	6a 00                	push   $0x0
  pushl $32
80105f09:	6a 20                	push   $0x20
  jmp alltraps
80105f0b:	e9 28 fa ff ff       	jmp    80105938 <alltraps>

80105f10 <vector33>:
.globl vector33
vector33:
  pushl $0
80105f10:	6a 00                	push   $0x0
  pushl $33
80105f12:	6a 21                	push   $0x21
  jmp alltraps
80105f14:	e9 1f fa ff ff       	jmp    80105938 <alltraps>

80105f19 <vector34>:
.globl vector34
vector34:
  pushl $0
80105f19:	6a 00                	push   $0x0
  pushl $34
80105f1b:	6a 22                	push   $0x22
  jmp alltraps
80105f1d:	e9 16 fa ff ff       	jmp    80105938 <alltraps>

80105f22 <vector35>:
.globl vector35
vector35:
  pushl $0
80105f22:	6a 00                	push   $0x0
  pushl $35
80105f24:	6a 23                	push   $0x23
  jmp alltraps
80105f26:	e9 0d fa ff ff       	jmp    80105938 <alltraps>

80105f2b <vector36>:
.globl vector36
vector36:
  pushl $0
80105f2b:	6a 00                	push   $0x0
  pushl $36
80105f2d:	6a 24                	push   $0x24
  jmp alltraps
80105f2f:	e9 04 fa ff ff       	jmp    80105938 <alltraps>

80105f34 <vector37>:
.globl vector37
vector37:
  pushl $0
80105f34:	6a 00                	push   $0x0
  pushl $37
80105f36:	6a 25                	push   $0x25
  jmp alltraps
80105f38:	e9 fb f9 ff ff       	jmp    80105938 <alltraps>

80105f3d <vector38>:
.globl vector38
vector38:
  pushl $0
80105f3d:	6a 00                	push   $0x0
  pushl $38
80105f3f:	6a 26                	push   $0x26
  jmp alltraps
80105f41:	e9 f2 f9 ff ff       	jmp    80105938 <alltraps>

80105f46 <vector39>:
.globl vector39
vector39:
  pushl $0
80105f46:	6a 00                	push   $0x0
  pushl $39
80105f48:	6a 27                	push   $0x27
  jmp alltraps
80105f4a:	e9 e9 f9 ff ff       	jmp    80105938 <alltraps>

80105f4f <vector40>:
.globl vector40
vector40:
  pushl $0
80105f4f:	6a 00                	push   $0x0
  pushl $40
80105f51:	6a 28                	push   $0x28
  jmp alltraps
80105f53:	e9 e0 f9 ff ff       	jmp    80105938 <alltraps>

80105f58 <vector41>:
.globl vector41
vector41:
  pushl $0
80105f58:	6a 00                	push   $0x0
  pushl $41
80105f5a:	6a 29                	push   $0x29
  jmp alltraps
80105f5c:	e9 d7 f9 ff ff       	jmp    80105938 <alltraps>

80105f61 <vector42>:
.globl vector42
vector42:
  pushl $0
80105f61:	6a 00                	push   $0x0
  pushl $42
80105f63:	6a 2a                	push   $0x2a
  jmp alltraps
80105f65:	e9 ce f9 ff ff       	jmp    80105938 <alltraps>

80105f6a <vector43>:
.globl vector43
vector43:
  pushl $0
80105f6a:	6a 00                	push   $0x0
  pushl $43
80105f6c:	6a 2b                	push   $0x2b
  jmp alltraps
80105f6e:	e9 c5 f9 ff ff       	jmp    80105938 <alltraps>

80105f73 <vector44>:
.globl vector44
vector44:
  pushl $0
80105f73:	6a 00                	push   $0x0
  pushl $44
80105f75:	6a 2c                	push   $0x2c
  jmp alltraps
80105f77:	e9 bc f9 ff ff       	jmp    80105938 <alltraps>

80105f7c <vector45>:
.globl vector45
vector45:
  pushl $0
80105f7c:	6a 00                	push   $0x0
  pushl $45
80105f7e:	6a 2d                	push   $0x2d
  jmp alltraps
80105f80:	e9 b3 f9 ff ff       	jmp    80105938 <alltraps>

80105f85 <vector46>:
.globl vector46
vector46:
  pushl $0
80105f85:	6a 00                	push   $0x0
  pushl $46
80105f87:	6a 2e                	push   $0x2e
  jmp alltraps
80105f89:	e9 aa f9 ff ff       	jmp    80105938 <alltraps>

80105f8e <vector47>:
.globl vector47
vector47:
  pushl $0
80105f8e:	6a 00                	push   $0x0
  pushl $47
80105f90:	6a 2f                	push   $0x2f
  jmp alltraps
80105f92:	e9 a1 f9 ff ff       	jmp    80105938 <alltraps>

80105f97 <vector48>:
.globl vector48
vector48:
  pushl $0
80105f97:	6a 00                	push   $0x0
  pushl $48
80105f99:	6a 30                	push   $0x30
  jmp alltraps
80105f9b:	e9 98 f9 ff ff       	jmp    80105938 <alltraps>

80105fa0 <vector49>:
.globl vector49
vector49:
  pushl $0
80105fa0:	6a 00                	push   $0x0
  pushl $49
80105fa2:	6a 31                	push   $0x31
  jmp alltraps
80105fa4:	e9 8f f9 ff ff       	jmp    80105938 <alltraps>

80105fa9 <vector50>:
.globl vector50
vector50:
  pushl $0
80105fa9:	6a 00                	push   $0x0
  pushl $50
80105fab:	6a 32                	push   $0x32
  jmp alltraps
80105fad:	e9 86 f9 ff ff       	jmp    80105938 <alltraps>

80105fb2 <vector51>:
.globl vector51
vector51:
  pushl $0
80105fb2:	6a 00                	push   $0x0
  pushl $51
80105fb4:	6a 33                	push   $0x33
  jmp alltraps
80105fb6:	e9 7d f9 ff ff       	jmp    80105938 <alltraps>

80105fbb <vector52>:
.globl vector52
vector52:
  pushl $0
80105fbb:	6a 00                	push   $0x0
  pushl $52
80105fbd:	6a 34                	push   $0x34
  jmp alltraps
80105fbf:	e9 74 f9 ff ff       	jmp    80105938 <alltraps>

80105fc4 <vector53>:
.globl vector53
vector53:
  pushl $0
80105fc4:	6a 00                	push   $0x0
  pushl $53
80105fc6:	6a 35                	push   $0x35
  jmp alltraps
80105fc8:	e9 6b f9 ff ff       	jmp    80105938 <alltraps>

80105fcd <vector54>:
.globl vector54
vector54:
  pushl $0
80105fcd:	6a 00                	push   $0x0
  pushl $54
80105fcf:	6a 36                	push   $0x36
  jmp alltraps
80105fd1:	e9 62 f9 ff ff       	jmp    80105938 <alltraps>

80105fd6 <vector55>:
.globl vector55
vector55:
  pushl $0
80105fd6:	6a 00                	push   $0x0
  pushl $55
80105fd8:	6a 37                	push   $0x37
  jmp alltraps
80105fda:	e9 59 f9 ff ff       	jmp    80105938 <alltraps>

80105fdf <vector56>:
.globl vector56
vector56:
  pushl $0
80105fdf:	6a 00                	push   $0x0
  pushl $56
80105fe1:	6a 38                	push   $0x38
  jmp alltraps
80105fe3:	e9 50 f9 ff ff       	jmp    80105938 <alltraps>

80105fe8 <vector57>:
.globl vector57
vector57:
  pushl $0
80105fe8:	6a 00                	push   $0x0
  pushl $57
80105fea:	6a 39                	push   $0x39
  jmp alltraps
80105fec:	e9 47 f9 ff ff       	jmp    80105938 <alltraps>

80105ff1 <vector58>:
.globl vector58
vector58:
  pushl $0
80105ff1:	6a 00                	push   $0x0
  pushl $58
80105ff3:	6a 3a                	push   $0x3a
  jmp alltraps
80105ff5:	e9 3e f9 ff ff       	jmp    80105938 <alltraps>

80105ffa <vector59>:
.globl vector59
vector59:
  pushl $0
80105ffa:	6a 00                	push   $0x0
  pushl $59
80105ffc:	6a 3b                	push   $0x3b
  jmp alltraps
80105ffe:	e9 35 f9 ff ff       	jmp    80105938 <alltraps>

80106003 <vector60>:
.globl vector60
vector60:
  pushl $0
80106003:	6a 00                	push   $0x0
  pushl $60
80106005:	6a 3c                	push   $0x3c
  jmp alltraps
80106007:	e9 2c f9 ff ff       	jmp    80105938 <alltraps>

8010600c <vector61>:
.globl vector61
vector61:
  pushl $0
8010600c:	6a 00                	push   $0x0
  pushl $61
8010600e:	6a 3d                	push   $0x3d
  jmp alltraps
80106010:	e9 23 f9 ff ff       	jmp    80105938 <alltraps>

80106015 <vector62>:
.globl vector62
vector62:
  pushl $0
80106015:	6a 00                	push   $0x0
  pushl $62
80106017:	6a 3e                	push   $0x3e
  jmp alltraps
80106019:	e9 1a f9 ff ff       	jmp    80105938 <alltraps>

8010601e <vector63>:
.globl vector63
vector63:
  pushl $0
8010601e:	6a 00                	push   $0x0
  pushl $63
80106020:	6a 3f                	push   $0x3f
  jmp alltraps
80106022:	e9 11 f9 ff ff       	jmp    80105938 <alltraps>

80106027 <vector64>:
.globl vector64
vector64:
  pushl $0
80106027:	6a 00                	push   $0x0
  pushl $64
80106029:	6a 40                	push   $0x40
  jmp alltraps
8010602b:	e9 08 f9 ff ff       	jmp    80105938 <alltraps>

80106030 <vector65>:
.globl vector65
vector65:
  pushl $0
80106030:	6a 00                	push   $0x0
  pushl $65
80106032:	6a 41                	push   $0x41
  jmp alltraps
80106034:	e9 ff f8 ff ff       	jmp    80105938 <alltraps>

80106039 <vector66>:
.globl vector66
vector66:
  pushl $0
80106039:	6a 00                	push   $0x0
  pushl $66
8010603b:	6a 42                	push   $0x42
  jmp alltraps
8010603d:	e9 f6 f8 ff ff       	jmp    80105938 <alltraps>

80106042 <vector67>:
.globl vector67
vector67:
  pushl $0
80106042:	6a 00                	push   $0x0
  pushl $67
80106044:	6a 43                	push   $0x43
  jmp alltraps
80106046:	e9 ed f8 ff ff       	jmp    80105938 <alltraps>

8010604b <vector68>:
.globl vector68
vector68:
  pushl $0
8010604b:	6a 00                	push   $0x0
  pushl $68
8010604d:	6a 44                	push   $0x44
  jmp alltraps
8010604f:	e9 e4 f8 ff ff       	jmp    80105938 <alltraps>

80106054 <vector69>:
.globl vector69
vector69:
  pushl $0
80106054:	6a 00                	push   $0x0
  pushl $69
80106056:	6a 45                	push   $0x45
  jmp alltraps
80106058:	e9 db f8 ff ff       	jmp    80105938 <alltraps>

8010605d <vector70>:
.globl vector70
vector70:
  pushl $0
8010605d:	6a 00                	push   $0x0
  pushl $70
8010605f:	6a 46                	push   $0x46
  jmp alltraps
80106061:	e9 d2 f8 ff ff       	jmp    80105938 <alltraps>

80106066 <vector71>:
.globl vector71
vector71:
  pushl $0
80106066:	6a 00                	push   $0x0
  pushl $71
80106068:	6a 47                	push   $0x47
  jmp alltraps
8010606a:	e9 c9 f8 ff ff       	jmp    80105938 <alltraps>

8010606f <vector72>:
.globl vector72
vector72:
  pushl $0
8010606f:	6a 00                	push   $0x0
  pushl $72
80106071:	6a 48                	push   $0x48
  jmp alltraps
80106073:	e9 c0 f8 ff ff       	jmp    80105938 <alltraps>

80106078 <vector73>:
.globl vector73
vector73:
  pushl $0
80106078:	6a 00                	push   $0x0
  pushl $73
8010607a:	6a 49                	push   $0x49
  jmp alltraps
8010607c:	e9 b7 f8 ff ff       	jmp    80105938 <alltraps>

80106081 <vector74>:
.globl vector74
vector74:
  pushl $0
80106081:	6a 00                	push   $0x0
  pushl $74
80106083:	6a 4a                	push   $0x4a
  jmp alltraps
80106085:	e9 ae f8 ff ff       	jmp    80105938 <alltraps>

8010608a <vector75>:
.globl vector75
vector75:
  pushl $0
8010608a:	6a 00                	push   $0x0
  pushl $75
8010608c:	6a 4b                	push   $0x4b
  jmp alltraps
8010608e:	e9 a5 f8 ff ff       	jmp    80105938 <alltraps>

80106093 <vector76>:
.globl vector76
vector76:
  pushl $0
80106093:	6a 00                	push   $0x0
  pushl $76
80106095:	6a 4c                	push   $0x4c
  jmp alltraps
80106097:	e9 9c f8 ff ff       	jmp    80105938 <alltraps>

8010609c <vector77>:
.globl vector77
vector77:
  pushl $0
8010609c:	6a 00                	push   $0x0
  pushl $77
8010609e:	6a 4d                	push   $0x4d
  jmp alltraps
801060a0:	e9 93 f8 ff ff       	jmp    80105938 <alltraps>

801060a5 <vector78>:
.globl vector78
vector78:
  pushl $0
801060a5:	6a 00                	push   $0x0
  pushl $78
801060a7:	6a 4e                	push   $0x4e
  jmp alltraps
801060a9:	e9 8a f8 ff ff       	jmp    80105938 <alltraps>

801060ae <vector79>:
.globl vector79
vector79:
  pushl $0
801060ae:	6a 00                	push   $0x0
  pushl $79
801060b0:	6a 4f                	push   $0x4f
  jmp alltraps
801060b2:	e9 81 f8 ff ff       	jmp    80105938 <alltraps>

801060b7 <vector80>:
.globl vector80
vector80:
  pushl $0
801060b7:	6a 00                	push   $0x0
  pushl $80
801060b9:	6a 50                	push   $0x50
  jmp alltraps
801060bb:	e9 78 f8 ff ff       	jmp    80105938 <alltraps>

801060c0 <vector81>:
.globl vector81
vector81:
  pushl $0
801060c0:	6a 00                	push   $0x0
  pushl $81
801060c2:	6a 51                	push   $0x51
  jmp alltraps
801060c4:	e9 6f f8 ff ff       	jmp    80105938 <alltraps>

801060c9 <vector82>:
.globl vector82
vector82:
  pushl $0
801060c9:	6a 00                	push   $0x0
  pushl $82
801060cb:	6a 52                	push   $0x52
  jmp alltraps
801060cd:	e9 66 f8 ff ff       	jmp    80105938 <alltraps>

801060d2 <vector83>:
.globl vector83
vector83:
  pushl $0
801060d2:	6a 00                	push   $0x0
  pushl $83
801060d4:	6a 53                	push   $0x53
  jmp alltraps
801060d6:	e9 5d f8 ff ff       	jmp    80105938 <alltraps>

801060db <vector84>:
.globl vector84
vector84:
  pushl $0
801060db:	6a 00                	push   $0x0
  pushl $84
801060dd:	6a 54                	push   $0x54
  jmp alltraps
801060df:	e9 54 f8 ff ff       	jmp    80105938 <alltraps>

801060e4 <vector85>:
.globl vector85
vector85:
  pushl $0
801060e4:	6a 00                	push   $0x0
  pushl $85
801060e6:	6a 55                	push   $0x55
  jmp alltraps
801060e8:	e9 4b f8 ff ff       	jmp    80105938 <alltraps>

801060ed <vector86>:
.globl vector86
vector86:
  pushl $0
801060ed:	6a 00                	push   $0x0
  pushl $86
801060ef:	6a 56                	push   $0x56
  jmp alltraps
801060f1:	e9 42 f8 ff ff       	jmp    80105938 <alltraps>

801060f6 <vector87>:
.globl vector87
vector87:
  pushl $0
801060f6:	6a 00                	push   $0x0
  pushl $87
801060f8:	6a 57                	push   $0x57
  jmp alltraps
801060fa:	e9 39 f8 ff ff       	jmp    80105938 <alltraps>

801060ff <vector88>:
.globl vector88
vector88:
  pushl $0
801060ff:	6a 00                	push   $0x0
  pushl $88
80106101:	6a 58                	push   $0x58
  jmp alltraps
80106103:	e9 30 f8 ff ff       	jmp    80105938 <alltraps>

80106108 <vector89>:
.globl vector89
vector89:
  pushl $0
80106108:	6a 00                	push   $0x0
  pushl $89
8010610a:	6a 59                	push   $0x59
  jmp alltraps
8010610c:	e9 27 f8 ff ff       	jmp    80105938 <alltraps>

80106111 <vector90>:
.globl vector90
vector90:
  pushl $0
80106111:	6a 00                	push   $0x0
  pushl $90
80106113:	6a 5a                	push   $0x5a
  jmp alltraps
80106115:	e9 1e f8 ff ff       	jmp    80105938 <alltraps>

8010611a <vector91>:
.globl vector91
vector91:
  pushl $0
8010611a:	6a 00                	push   $0x0
  pushl $91
8010611c:	6a 5b                	push   $0x5b
  jmp alltraps
8010611e:	e9 15 f8 ff ff       	jmp    80105938 <alltraps>

80106123 <vector92>:
.globl vector92
vector92:
  pushl $0
80106123:	6a 00                	push   $0x0
  pushl $92
80106125:	6a 5c                	push   $0x5c
  jmp alltraps
80106127:	e9 0c f8 ff ff       	jmp    80105938 <alltraps>

8010612c <vector93>:
.globl vector93
vector93:
  pushl $0
8010612c:	6a 00                	push   $0x0
  pushl $93
8010612e:	6a 5d                	push   $0x5d
  jmp alltraps
80106130:	e9 03 f8 ff ff       	jmp    80105938 <alltraps>

80106135 <vector94>:
.globl vector94
vector94:
  pushl $0
80106135:	6a 00                	push   $0x0
  pushl $94
80106137:	6a 5e                	push   $0x5e
  jmp alltraps
80106139:	e9 fa f7 ff ff       	jmp    80105938 <alltraps>

8010613e <vector95>:
.globl vector95
vector95:
  pushl $0
8010613e:	6a 00                	push   $0x0
  pushl $95
80106140:	6a 5f                	push   $0x5f
  jmp alltraps
80106142:	e9 f1 f7 ff ff       	jmp    80105938 <alltraps>

80106147 <vector96>:
.globl vector96
vector96:
  pushl $0
80106147:	6a 00                	push   $0x0
  pushl $96
80106149:	6a 60                	push   $0x60
  jmp alltraps
8010614b:	e9 e8 f7 ff ff       	jmp    80105938 <alltraps>

80106150 <vector97>:
.globl vector97
vector97:
  pushl $0
80106150:	6a 00                	push   $0x0
  pushl $97
80106152:	6a 61                	push   $0x61
  jmp alltraps
80106154:	e9 df f7 ff ff       	jmp    80105938 <alltraps>

80106159 <vector98>:
.globl vector98
vector98:
  pushl $0
80106159:	6a 00                	push   $0x0
  pushl $98
8010615b:	6a 62                	push   $0x62
  jmp alltraps
8010615d:	e9 d6 f7 ff ff       	jmp    80105938 <alltraps>

80106162 <vector99>:
.globl vector99
vector99:
  pushl $0
80106162:	6a 00                	push   $0x0
  pushl $99
80106164:	6a 63                	push   $0x63
  jmp alltraps
80106166:	e9 cd f7 ff ff       	jmp    80105938 <alltraps>

8010616b <vector100>:
.globl vector100
vector100:
  pushl $0
8010616b:	6a 00                	push   $0x0
  pushl $100
8010616d:	6a 64                	push   $0x64
  jmp alltraps
8010616f:	e9 c4 f7 ff ff       	jmp    80105938 <alltraps>

80106174 <vector101>:
.globl vector101
vector101:
  pushl $0
80106174:	6a 00                	push   $0x0
  pushl $101
80106176:	6a 65                	push   $0x65
  jmp alltraps
80106178:	e9 bb f7 ff ff       	jmp    80105938 <alltraps>

8010617d <vector102>:
.globl vector102
vector102:
  pushl $0
8010617d:	6a 00                	push   $0x0
  pushl $102
8010617f:	6a 66                	push   $0x66
  jmp alltraps
80106181:	e9 b2 f7 ff ff       	jmp    80105938 <alltraps>

80106186 <vector103>:
.globl vector103
vector103:
  pushl $0
80106186:	6a 00                	push   $0x0
  pushl $103
80106188:	6a 67                	push   $0x67
  jmp alltraps
8010618a:	e9 a9 f7 ff ff       	jmp    80105938 <alltraps>

8010618f <vector104>:
.globl vector104
vector104:
  pushl $0
8010618f:	6a 00                	push   $0x0
  pushl $104
80106191:	6a 68                	push   $0x68
  jmp alltraps
80106193:	e9 a0 f7 ff ff       	jmp    80105938 <alltraps>

80106198 <vector105>:
.globl vector105
vector105:
  pushl $0
80106198:	6a 00                	push   $0x0
  pushl $105
8010619a:	6a 69                	push   $0x69
  jmp alltraps
8010619c:	e9 97 f7 ff ff       	jmp    80105938 <alltraps>

801061a1 <vector106>:
.globl vector106
vector106:
  pushl $0
801061a1:	6a 00                	push   $0x0
  pushl $106
801061a3:	6a 6a                	push   $0x6a
  jmp alltraps
801061a5:	e9 8e f7 ff ff       	jmp    80105938 <alltraps>

801061aa <vector107>:
.globl vector107
vector107:
  pushl $0
801061aa:	6a 00                	push   $0x0
  pushl $107
801061ac:	6a 6b                	push   $0x6b
  jmp alltraps
801061ae:	e9 85 f7 ff ff       	jmp    80105938 <alltraps>

801061b3 <vector108>:
.globl vector108
vector108:
  pushl $0
801061b3:	6a 00                	push   $0x0
  pushl $108
801061b5:	6a 6c                	push   $0x6c
  jmp alltraps
801061b7:	e9 7c f7 ff ff       	jmp    80105938 <alltraps>

801061bc <vector109>:
.globl vector109
vector109:
  pushl $0
801061bc:	6a 00                	push   $0x0
  pushl $109
801061be:	6a 6d                	push   $0x6d
  jmp alltraps
801061c0:	e9 73 f7 ff ff       	jmp    80105938 <alltraps>

801061c5 <vector110>:
.globl vector110
vector110:
  pushl $0
801061c5:	6a 00                	push   $0x0
  pushl $110
801061c7:	6a 6e                	push   $0x6e
  jmp alltraps
801061c9:	e9 6a f7 ff ff       	jmp    80105938 <alltraps>

801061ce <vector111>:
.globl vector111
vector111:
  pushl $0
801061ce:	6a 00                	push   $0x0
  pushl $111
801061d0:	6a 6f                	push   $0x6f
  jmp alltraps
801061d2:	e9 61 f7 ff ff       	jmp    80105938 <alltraps>

801061d7 <vector112>:
.globl vector112
vector112:
  pushl $0
801061d7:	6a 00                	push   $0x0
  pushl $112
801061d9:	6a 70                	push   $0x70
  jmp alltraps
801061db:	e9 58 f7 ff ff       	jmp    80105938 <alltraps>

801061e0 <vector113>:
.globl vector113
vector113:
  pushl $0
801061e0:	6a 00                	push   $0x0
  pushl $113
801061e2:	6a 71                	push   $0x71
  jmp alltraps
801061e4:	e9 4f f7 ff ff       	jmp    80105938 <alltraps>

801061e9 <vector114>:
.globl vector114
vector114:
  pushl $0
801061e9:	6a 00                	push   $0x0
  pushl $114
801061eb:	6a 72                	push   $0x72
  jmp alltraps
801061ed:	e9 46 f7 ff ff       	jmp    80105938 <alltraps>

801061f2 <vector115>:
.globl vector115
vector115:
  pushl $0
801061f2:	6a 00                	push   $0x0
  pushl $115
801061f4:	6a 73                	push   $0x73
  jmp alltraps
801061f6:	e9 3d f7 ff ff       	jmp    80105938 <alltraps>

801061fb <vector116>:
.globl vector116
vector116:
  pushl $0
801061fb:	6a 00                	push   $0x0
  pushl $116
801061fd:	6a 74                	push   $0x74
  jmp alltraps
801061ff:	e9 34 f7 ff ff       	jmp    80105938 <alltraps>

80106204 <vector117>:
.globl vector117
vector117:
  pushl $0
80106204:	6a 00                	push   $0x0
  pushl $117
80106206:	6a 75                	push   $0x75
  jmp alltraps
80106208:	e9 2b f7 ff ff       	jmp    80105938 <alltraps>

8010620d <vector118>:
.globl vector118
vector118:
  pushl $0
8010620d:	6a 00                	push   $0x0
  pushl $118
8010620f:	6a 76                	push   $0x76
  jmp alltraps
80106211:	e9 22 f7 ff ff       	jmp    80105938 <alltraps>

80106216 <vector119>:
.globl vector119
vector119:
  pushl $0
80106216:	6a 00                	push   $0x0
  pushl $119
80106218:	6a 77                	push   $0x77
  jmp alltraps
8010621a:	e9 19 f7 ff ff       	jmp    80105938 <alltraps>

8010621f <vector120>:
.globl vector120
vector120:
  pushl $0
8010621f:	6a 00                	push   $0x0
  pushl $120
80106221:	6a 78                	push   $0x78
  jmp alltraps
80106223:	e9 10 f7 ff ff       	jmp    80105938 <alltraps>

80106228 <vector121>:
.globl vector121
vector121:
  pushl $0
80106228:	6a 00                	push   $0x0
  pushl $121
8010622a:	6a 79                	push   $0x79
  jmp alltraps
8010622c:	e9 07 f7 ff ff       	jmp    80105938 <alltraps>

80106231 <vector122>:
.globl vector122
vector122:
  pushl $0
80106231:	6a 00                	push   $0x0
  pushl $122
80106233:	6a 7a                	push   $0x7a
  jmp alltraps
80106235:	e9 fe f6 ff ff       	jmp    80105938 <alltraps>

8010623a <vector123>:
.globl vector123
vector123:
  pushl $0
8010623a:	6a 00                	push   $0x0
  pushl $123
8010623c:	6a 7b                	push   $0x7b
  jmp alltraps
8010623e:	e9 f5 f6 ff ff       	jmp    80105938 <alltraps>

80106243 <vector124>:
.globl vector124
vector124:
  pushl $0
80106243:	6a 00                	push   $0x0
  pushl $124
80106245:	6a 7c                	push   $0x7c
  jmp alltraps
80106247:	e9 ec f6 ff ff       	jmp    80105938 <alltraps>

8010624c <vector125>:
.globl vector125
vector125:
  pushl $0
8010624c:	6a 00                	push   $0x0
  pushl $125
8010624e:	6a 7d                	push   $0x7d
  jmp alltraps
80106250:	e9 e3 f6 ff ff       	jmp    80105938 <alltraps>

80106255 <vector126>:
.globl vector126
vector126:
  pushl $0
80106255:	6a 00                	push   $0x0
  pushl $126
80106257:	6a 7e                	push   $0x7e
  jmp alltraps
80106259:	e9 da f6 ff ff       	jmp    80105938 <alltraps>

8010625e <vector127>:
.globl vector127
vector127:
  pushl $0
8010625e:	6a 00                	push   $0x0
  pushl $127
80106260:	6a 7f                	push   $0x7f
  jmp alltraps
80106262:	e9 d1 f6 ff ff       	jmp    80105938 <alltraps>

80106267 <vector128>:
.globl vector128
vector128:
  pushl $0
80106267:	6a 00                	push   $0x0
  pushl $128
80106269:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010626e:	e9 c5 f6 ff ff       	jmp    80105938 <alltraps>

80106273 <vector129>:
.globl vector129
vector129:
  pushl $0
80106273:	6a 00                	push   $0x0
  pushl $129
80106275:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010627a:	e9 b9 f6 ff ff       	jmp    80105938 <alltraps>

8010627f <vector130>:
.globl vector130
vector130:
  pushl $0
8010627f:	6a 00                	push   $0x0
  pushl $130
80106281:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106286:	e9 ad f6 ff ff       	jmp    80105938 <alltraps>

8010628b <vector131>:
.globl vector131
vector131:
  pushl $0
8010628b:	6a 00                	push   $0x0
  pushl $131
8010628d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106292:	e9 a1 f6 ff ff       	jmp    80105938 <alltraps>

80106297 <vector132>:
.globl vector132
vector132:
  pushl $0
80106297:	6a 00                	push   $0x0
  pushl $132
80106299:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010629e:	e9 95 f6 ff ff       	jmp    80105938 <alltraps>

801062a3 <vector133>:
.globl vector133
vector133:
  pushl $0
801062a3:	6a 00                	push   $0x0
  pushl $133
801062a5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801062aa:	e9 89 f6 ff ff       	jmp    80105938 <alltraps>

801062af <vector134>:
.globl vector134
vector134:
  pushl $0
801062af:	6a 00                	push   $0x0
  pushl $134
801062b1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801062b6:	e9 7d f6 ff ff       	jmp    80105938 <alltraps>

801062bb <vector135>:
.globl vector135
vector135:
  pushl $0
801062bb:	6a 00                	push   $0x0
  pushl $135
801062bd:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801062c2:	e9 71 f6 ff ff       	jmp    80105938 <alltraps>

801062c7 <vector136>:
.globl vector136
vector136:
  pushl $0
801062c7:	6a 00                	push   $0x0
  pushl $136
801062c9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801062ce:	e9 65 f6 ff ff       	jmp    80105938 <alltraps>

801062d3 <vector137>:
.globl vector137
vector137:
  pushl $0
801062d3:	6a 00                	push   $0x0
  pushl $137
801062d5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801062da:	e9 59 f6 ff ff       	jmp    80105938 <alltraps>

801062df <vector138>:
.globl vector138
vector138:
  pushl $0
801062df:	6a 00                	push   $0x0
  pushl $138
801062e1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801062e6:	e9 4d f6 ff ff       	jmp    80105938 <alltraps>

801062eb <vector139>:
.globl vector139
vector139:
  pushl $0
801062eb:	6a 00                	push   $0x0
  pushl $139
801062ed:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801062f2:	e9 41 f6 ff ff       	jmp    80105938 <alltraps>

801062f7 <vector140>:
.globl vector140
vector140:
  pushl $0
801062f7:	6a 00                	push   $0x0
  pushl $140
801062f9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801062fe:	e9 35 f6 ff ff       	jmp    80105938 <alltraps>

80106303 <vector141>:
.globl vector141
vector141:
  pushl $0
80106303:	6a 00                	push   $0x0
  pushl $141
80106305:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010630a:	e9 29 f6 ff ff       	jmp    80105938 <alltraps>

8010630f <vector142>:
.globl vector142
vector142:
  pushl $0
8010630f:	6a 00                	push   $0x0
  pushl $142
80106311:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106316:	e9 1d f6 ff ff       	jmp    80105938 <alltraps>

8010631b <vector143>:
.globl vector143
vector143:
  pushl $0
8010631b:	6a 00                	push   $0x0
  pushl $143
8010631d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106322:	e9 11 f6 ff ff       	jmp    80105938 <alltraps>

80106327 <vector144>:
.globl vector144
vector144:
  pushl $0
80106327:	6a 00                	push   $0x0
  pushl $144
80106329:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010632e:	e9 05 f6 ff ff       	jmp    80105938 <alltraps>

80106333 <vector145>:
.globl vector145
vector145:
  pushl $0
80106333:	6a 00                	push   $0x0
  pushl $145
80106335:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010633a:	e9 f9 f5 ff ff       	jmp    80105938 <alltraps>

8010633f <vector146>:
.globl vector146
vector146:
  pushl $0
8010633f:	6a 00                	push   $0x0
  pushl $146
80106341:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106346:	e9 ed f5 ff ff       	jmp    80105938 <alltraps>

8010634b <vector147>:
.globl vector147
vector147:
  pushl $0
8010634b:	6a 00                	push   $0x0
  pushl $147
8010634d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106352:	e9 e1 f5 ff ff       	jmp    80105938 <alltraps>

80106357 <vector148>:
.globl vector148
vector148:
  pushl $0
80106357:	6a 00                	push   $0x0
  pushl $148
80106359:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010635e:	e9 d5 f5 ff ff       	jmp    80105938 <alltraps>

80106363 <vector149>:
.globl vector149
vector149:
  pushl $0
80106363:	6a 00                	push   $0x0
  pushl $149
80106365:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010636a:	e9 c9 f5 ff ff       	jmp    80105938 <alltraps>

8010636f <vector150>:
.globl vector150
vector150:
  pushl $0
8010636f:	6a 00                	push   $0x0
  pushl $150
80106371:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106376:	e9 bd f5 ff ff       	jmp    80105938 <alltraps>

8010637b <vector151>:
.globl vector151
vector151:
  pushl $0
8010637b:	6a 00                	push   $0x0
  pushl $151
8010637d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106382:	e9 b1 f5 ff ff       	jmp    80105938 <alltraps>

80106387 <vector152>:
.globl vector152
vector152:
  pushl $0
80106387:	6a 00                	push   $0x0
  pushl $152
80106389:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010638e:	e9 a5 f5 ff ff       	jmp    80105938 <alltraps>

80106393 <vector153>:
.globl vector153
vector153:
  pushl $0
80106393:	6a 00                	push   $0x0
  pushl $153
80106395:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010639a:	e9 99 f5 ff ff       	jmp    80105938 <alltraps>

8010639f <vector154>:
.globl vector154
vector154:
  pushl $0
8010639f:	6a 00                	push   $0x0
  pushl $154
801063a1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801063a6:	e9 8d f5 ff ff       	jmp    80105938 <alltraps>

801063ab <vector155>:
.globl vector155
vector155:
  pushl $0
801063ab:	6a 00                	push   $0x0
  pushl $155
801063ad:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801063b2:	e9 81 f5 ff ff       	jmp    80105938 <alltraps>

801063b7 <vector156>:
.globl vector156
vector156:
  pushl $0
801063b7:	6a 00                	push   $0x0
  pushl $156
801063b9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801063be:	e9 75 f5 ff ff       	jmp    80105938 <alltraps>

801063c3 <vector157>:
.globl vector157
vector157:
  pushl $0
801063c3:	6a 00                	push   $0x0
  pushl $157
801063c5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801063ca:	e9 69 f5 ff ff       	jmp    80105938 <alltraps>

801063cf <vector158>:
.globl vector158
vector158:
  pushl $0
801063cf:	6a 00                	push   $0x0
  pushl $158
801063d1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801063d6:	e9 5d f5 ff ff       	jmp    80105938 <alltraps>

801063db <vector159>:
.globl vector159
vector159:
  pushl $0
801063db:	6a 00                	push   $0x0
  pushl $159
801063dd:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801063e2:	e9 51 f5 ff ff       	jmp    80105938 <alltraps>

801063e7 <vector160>:
.globl vector160
vector160:
  pushl $0
801063e7:	6a 00                	push   $0x0
  pushl $160
801063e9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801063ee:	e9 45 f5 ff ff       	jmp    80105938 <alltraps>

801063f3 <vector161>:
.globl vector161
vector161:
  pushl $0
801063f3:	6a 00                	push   $0x0
  pushl $161
801063f5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801063fa:	e9 39 f5 ff ff       	jmp    80105938 <alltraps>

801063ff <vector162>:
.globl vector162
vector162:
  pushl $0
801063ff:	6a 00                	push   $0x0
  pushl $162
80106401:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106406:	e9 2d f5 ff ff       	jmp    80105938 <alltraps>

8010640b <vector163>:
.globl vector163
vector163:
  pushl $0
8010640b:	6a 00                	push   $0x0
  pushl $163
8010640d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106412:	e9 21 f5 ff ff       	jmp    80105938 <alltraps>

80106417 <vector164>:
.globl vector164
vector164:
  pushl $0
80106417:	6a 00                	push   $0x0
  pushl $164
80106419:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010641e:	e9 15 f5 ff ff       	jmp    80105938 <alltraps>

80106423 <vector165>:
.globl vector165
vector165:
  pushl $0
80106423:	6a 00                	push   $0x0
  pushl $165
80106425:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010642a:	e9 09 f5 ff ff       	jmp    80105938 <alltraps>

8010642f <vector166>:
.globl vector166
vector166:
  pushl $0
8010642f:	6a 00                	push   $0x0
  pushl $166
80106431:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106436:	e9 fd f4 ff ff       	jmp    80105938 <alltraps>

8010643b <vector167>:
.globl vector167
vector167:
  pushl $0
8010643b:	6a 00                	push   $0x0
  pushl $167
8010643d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106442:	e9 f1 f4 ff ff       	jmp    80105938 <alltraps>

80106447 <vector168>:
.globl vector168
vector168:
  pushl $0
80106447:	6a 00                	push   $0x0
  pushl $168
80106449:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010644e:	e9 e5 f4 ff ff       	jmp    80105938 <alltraps>

80106453 <vector169>:
.globl vector169
vector169:
  pushl $0
80106453:	6a 00                	push   $0x0
  pushl $169
80106455:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010645a:	e9 d9 f4 ff ff       	jmp    80105938 <alltraps>

8010645f <vector170>:
.globl vector170
vector170:
  pushl $0
8010645f:	6a 00                	push   $0x0
  pushl $170
80106461:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106466:	e9 cd f4 ff ff       	jmp    80105938 <alltraps>

8010646b <vector171>:
.globl vector171
vector171:
  pushl $0
8010646b:	6a 00                	push   $0x0
  pushl $171
8010646d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106472:	e9 c1 f4 ff ff       	jmp    80105938 <alltraps>

80106477 <vector172>:
.globl vector172
vector172:
  pushl $0
80106477:	6a 00                	push   $0x0
  pushl $172
80106479:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010647e:	e9 b5 f4 ff ff       	jmp    80105938 <alltraps>

80106483 <vector173>:
.globl vector173
vector173:
  pushl $0
80106483:	6a 00                	push   $0x0
  pushl $173
80106485:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010648a:	e9 a9 f4 ff ff       	jmp    80105938 <alltraps>

8010648f <vector174>:
.globl vector174
vector174:
  pushl $0
8010648f:	6a 00                	push   $0x0
  pushl $174
80106491:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106496:	e9 9d f4 ff ff       	jmp    80105938 <alltraps>

8010649b <vector175>:
.globl vector175
vector175:
  pushl $0
8010649b:	6a 00                	push   $0x0
  pushl $175
8010649d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801064a2:	e9 91 f4 ff ff       	jmp    80105938 <alltraps>

801064a7 <vector176>:
.globl vector176
vector176:
  pushl $0
801064a7:	6a 00                	push   $0x0
  pushl $176
801064a9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801064ae:	e9 85 f4 ff ff       	jmp    80105938 <alltraps>

801064b3 <vector177>:
.globl vector177
vector177:
  pushl $0
801064b3:	6a 00                	push   $0x0
  pushl $177
801064b5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801064ba:	e9 79 f4 ff ff       	jmp    80105938 <alltraps>

801064bf <vector178>:
.globl vector178
vector178:
  pushl $0
801064bf:	6a 00                	push   $0x0
  pushl $178
801064c1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801064c6:	e9 6d f4 ff ff       	jmp    80105938 <alltraps>

801064cb <vector179>:
.globl vector179
vector179:
  pushl $0
801064cb:	6a 00                	push   $0x0
  pushl $179
801064cd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801064d2:	e9 61 f4 ff ff       	jmp    80105938 <alltraps>

801064d7 <vector180>:
.globl vector180
vector180:
  pushl $0
801064d7:	6a 00                	push   $0x0
  pushl $180
801064d9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801064de:	e9 55 f4 ff ff       	jmp    80105938 <alltraps>

801064e3 <vector181>:
.globl vector181
vector181:
  pushl $0
801064e3:	6a 00                	push   $0x0
  pushl $181
801064e5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801064ea:	e9 49 f4 ff ff       	jmp    80105938 <alltraps>

801064ef <vector182>:
.globl vector182
vector182:
  pushl $0
801064ef:	6a 00                	push   $0x0
  pushl $182
801064f1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801064f6:	e9 3d f4 ff ff       	jmp    80105938 <alltraps>

801064fb <vector183>:
.globl vector183
vector183:
  pushl $0
801064fb:	6a 00                	push   $0x0
  pushl $183
801064fd:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106502:	e9 31 f4 ff ff       	jmp    80105938 <alltraps>

80106507 <vector184>:
.globl vector184
vector184:
  pushl $0
80106507:	6a 00                	push   $0x0
  pushl $184
80106509:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010650e:	e9 25 f4 ff ff       	jmp    80105938 <alltraps>

80106513 <vector185>:
.globl vector185
vector185:
  pushl $0
80106513:	6a 00                	push   $0x0
  pushl $185
80106515:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010651a:	e9 19 f4 ff ff       	jmp    80105938 <alltraps>

8010651f <vector186>:
.globl vector186
vector186:
  pushl $0
8010651f:	6a 00                	push   $0x0
  pushl $186
80106521:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106526:	e9 0d f4 ff ff       	jmp    80105938 <alltraps>

8010652b <vector187>:
.globl vector187
vector187:
  pushl $0
8010652b:	6a 00                	push   $0x0
  pushl $187
8010652d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106532:	e9 01 f4 ff ff       	jmp    80105938 <alltraps>

80106537 <vector188>:
.globl vector188
vector188:
  pushl $0
80106537:	6a 00                	push   $0x0
  pushl $188
80106539:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010653e:	e9 f5 f3 ff ff       	jmp    80105938 <alltraps>

80106543 <vector189>:
.globl vector189
vector189:
  pushl $0
80106543:	6a 00                	push   $0x0
  pushl $189
80106545:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010654a:	e9 e9 f3 ff ff       	jmp    80105938 <alltraps>

8010654f <vector190>:
.globl vector190
vector190:
  pushl $0
8010654f:	6a 00                	push   $0x0
  pushl $190
80106551:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106556:	e9 dd f3 ff ff       	jmp    80105938 <alltraps>

8010655b <vector191>:
.globl vector191
vector191:
  pushl $0
8010655b:	6a 00                	push   $0x0
  pushl $191
8010655d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106562:	e9 d1 f3 ff ff       	jmp    80105938 <alltraps>

80106567 <vector192>:
.globl vector192
vector192:
  pushl $0
80106567:	6a 00                	push   $0x0
  pushl $192
80106569:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010656e:	e9 c5 f3 ff ff       	jmp    80105938 <alltraps>

80106573 <vector193>:
.globl vector193
vector193:
  pushl $0
80106573:	6a 00                	push   $0x0
  pushl $193
80106575:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010657a:	e9 b9 f3 ff ff       	jmp    80105938 <alltraps>

8010657f <vector194>:
.globl vector194
vector194:
  pushl $0
8010657f:	6a 00                	push   $0x0
  pushl $194
80106581:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106586:	e9 ad f3 ff ff       	jmp    80105938 <alltraps>

8010658b <vector195>:
.globl vector195
vector195:
  pushl $0
8010658b:	6a 00                	push   $0x0
  pushl $195
8010658d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106592:	e9 a1 f3 ff ff       	jmp    80105938 <alltraps>

80106597 <vector196>:
.globl vector196
vector196:
  pushl $0
80106597:	6a 00                	push   $0x0
  pushl $196
80106599:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010659e:	e9 95 f3 ff ff       	jmp    80105938 <alltraps>

801065a3 <vector197>:
.globl vector197
vector197:
  pushl $0
801065a3:	6a 00                	push   $0x0
  pushl $197
801065a5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801065aa:	e9 89 f3 ff ff       	jmp    80105938 <alltraps>

801065af <vector198>:
.globl vector198
vector198:
  pushl $0
801065af:	6a 00                	push   $0x0
  pushl $198
801065b1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801065b6:	e9 7d f3 ff ff       	jmp    80105938 <alltraps>

801065bb <vector199>:
.globl vector199
vector199:
  pushl $0
801065bb:	6a 00                	push   $0x0
  pushl $199
801065bd:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801065c2:	e9 71 f3 ff ff       	jmp    80105938 <alltraps>

801065c7 <vector200>:
.globl vector200
vector200:
  pushl $0
801065c7:	6a 00                	push   $0x0
  pushl $200
801065c9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801065ce:	e9 65 f3 ff ff       	jmp    80105938 <alltraps>

801065d3 <vector201>:
.globl vector201
vector201:
  pushl $0
801065d3:	6a 00                	push   $0x0
  pushl $201
801065d5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801065da:	e9 59 f3 ff ff       	jmp    80105938 <alltraps>

801065df <vector202>:
.globl vector202
vector202:
  pushl $0
801065df:	6a 00                	push   $0x0
  pushl $202
801065e1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801065e6:	e9 4d f3 ff ff       	jmp    80105938 <alltraps>

801065eb <vector203>:
.globl vector203
vector203:
  pushl $0
801065eb:	6a 00                	push   $0x0
  pushl $203
801065ed:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801065f2:	e9 41 f3 ff ff       	jmp    80105938 <alltraps>

801065f7 <vector204>:
.globl vector204
vector204:
  pushl $0
801065f7:	6a 00                	push   $0x0
  pushl $204
801065f9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801065fe:	e9 35 f3 ff ff       	jmp    80105938 <alltraps>

80106603 <vector205>:
.globl vector205
vector205:
  pushl $0
80106603:	6a 00                	push   $0x0
  pushl $205
80106605:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010660a:	e9 29 f3 ff ff       	jmp    80105938 <alltraps>

8010660f <vector206>:
.globl vector206
vector206:
  pushl $0
8010660f:	6a 00                	push   $0x0
  pushl $206
80106611:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106616:	e9 1d f3 ff ff       	jmp    80105938 <alltraps>

8010661b <vector207>:
.globl vector207
vector207:
  pushl $0
8010661b:	6a 00                	push   $0x0
  pushl $207
8010661d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106622:	e9 11 f3 ff ff       	jmp    80105938 <alltraps>

80106627 <vector208>:
.globl vector208
vector208:
  pushl $0
80106627:	6a 00                	push   $0x0
  pushl $208
80106629:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010662e:	e9 05 f3 ff ff       	jmp    80105938 <alltraps>

80106633 <vector209>:
.globl vector209
vector209:
  pushl $0
80106633:	6a 00                	push   $0x0
  pushl $209
80106635:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010663a:	e9 f9 f2 ff ff       	jmp    80105938 <alltraps>

8010663f <vector210>:
.globl vector210
vector210:
  pushl $0
8010663f:	6a 00                	push   $0x0
  pushl $210
80106641:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106646:	e9 ed f2 ff ff       	jmp    80105938 <alltraps>

8010664b <vector211>:
.globl vector211
vector211:
  pushl $0
8010664b:	6a 00                	push   $0x0
  pushl $211
8010664d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106652:	e9 e1 f2 ff ff       	jmp    80105938 <alltraps>

80106657 <vector212>:
.globl vector212
vector212:
  pushl $0
80106657:	6a 00                	push   $0x0
  pushl $212
80106659:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010665e:	e9 d5 f2 ff ff       	jmp    80105938 <alltraps>

80106663 <vector213>:
.globl vector213
vector213:
  pushl $0
80106663:	6a 00                	push   $0x0
  pushl $213
80106665:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010666a:	e9 c9 f2 ff ff       	jmp    80105938 <alltraps>

8010666f <vector214>:
.globl vector214
vector214:
  pushl $0
8010666f:	6a 00                	push   $0x0
  pushl $214
80106671:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106676:	e9 bd f2 ff ff       	jmp    80105938 <alltraps>

8010667b <vector215>:
.globl vector215
vector215:
  pushl $0
8010667b:	6a 00                	push   $0x0
  pushl $215
8010667d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106682:	e9 b1 f2 ff ff       	jmp    80105938 <alltraps>

80106687 <vector216>:
.globl vector216
vector216:
  pushl $0
80106687:	6a 00                	push   $0x0
  pushl $216
80106689:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010668e:	e9 a5 f2 ff ff       	jmp    80105938 <alltraps>

80106693 <vector217>:
.globl vector217
vector217:
  pushl $0
80106693:	6a 00                	push   $0x0
  pushl $217
80106695:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010669a:	e9 99 f2 ff ff       	jmp    80105938 <alltraps>

8010669f <vector218>:
.globl vector218
vector218:
  pushl $0
8010669f:	6a 00                	push   $0x0
  pushl $218
801066a1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801066a6:	e9 8d f2 ff ff       	jmp    80105938 <alltraps>

801066ab <vector219>:
.globl vector219
vector219:
  pushl $0
801066ab:	6a 00                	push   $0x0
  pushl $219
801066ad:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801066b2:	e9 81 f2 ff ff       	jmp    80105938 <alltraps>

801066b7 <vector220>:
.globl vector220
vector220:
  pushl $0
801066b7:	6a 00                	push   $0x0
  pushl $220
801066b9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801066be:	e9 75 f2 ff ff       	jmp    80105938 <alltraps>

801066c3 <vector221>:
.globl vector221
vector221:
  pushl $0
801066c3:	6a 00                	push   $0x0
  pushl $221
801066c5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801066ca:	e9 69 f2 ff ff       	jmp    80105938 <alltraps>

801066cf <vector222>:
.globl vector222
vector222:
  pushl $0
801066cf:	6a 00                	push   $0x0
  pushl $222
801066d1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801066d6:	e9 5d f2 ff ff       	jmp    80105938 <alltraps>

801066db <vector223>:
.globl vector223
vector223:
  pushl $0
801066db:	6a 00                	push   $0x0
  pushl $223
801066dd:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801066e2:	e9 51 f2 ff ff       	jmp    80105938 <alltraps>

801066e7 <vector224>:
.globl vector224
vector224:
  pushl $0
801066e7:	6a 00                	push   $0x0
  pushl $224
801066e9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801066ee:	e9 45 f2 ff ff       	jmp    80105938 <alltraps>

801066f3 <vector225>:
.globl vector225
vector225:
  pushl $0
801066f3:	6a 00                	push   $0x0
  pushl $225
801066f5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801066fa:	e9 39 f2 ff ff       	jmp    80105938 <alltraps>

801066ff <vector226>:
.globl vector226
vector226:
  pushl $0
801066ff:	6a 00                	push   $0x0
  pushl $226
80106701:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106706:	e9 2d f2 ff ff       	jmp    80105938 <alltraps>

8010670b <vector227>:
.globl vector227
vector227:
  pushl $0
8010670b:	6a 00                	push   $0x0
  pushl $227
8010670d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106712:	e9 21 f2 ff ff       	jmp    80105938 <alltraps>

80106717 <vector228>:
.globl vector228
vector228:
  pushl $0
80106717:	6a 00                	push   $0x0
  pushl $228
80106719:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010671e:	e9 15 f2 ff ff       	jmp    80105938 <alltraps>

80106723 <vector229>:
.globl vector229
vector229:
  pushl $0
80106723:	6a 00                	push   $0x0
  pushl $229
80106725:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010672a:	e9 09 f2 ff ff       	jmp    80105938 <alltraps>

8010672f <vector230>:
.globl vector230
vector230:
  pushl $0
8010672f:	6a 00                	push   $0x0
  pushl $230
80106731:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106736:	e9 fd f1 ff ff       	jmp    80105938 <alltraps>

8010673b <vector231>:
.globl vector231
vector231:
  pushl $0
8010673b:	6a 00                	push   $0x0
  pushl $231
8010673d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106742:	e9 f1 f1 ff ff       	jmp    80105938 <alltraps>

80106747 <vector232>:
.globl vector232
vector232:
  pushl $0
80106747:	6a 00                	push   $0x0
  pushl $232
80106749:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010674e:	e9 e5 f1 ff ff       	jmp    80105938 <alltraps>

80106753 <vector233>:
.globl vector233
vector233:
  pushl $0
80106753:	6a 00                	push   $0x0
  pushl $233
80106755:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010675a:	e9 d9 f1 ff ff       	jmp    80105938 <alltraps>

8010675f <vector234>:
.globl vector234
vector234:
  pushl $0
8010675f:	6a 00                	push   $0x0
  pushl $234
80106761:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106766:	e9 cd f1 ff ff       	jmp    80105938 <alltraps>

8010676b <vector235>:
.globl vector235
vector235:
  pushl $0
8010676b:	6a 00                	push   $0x0
  pushl $235
8010676d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106772:	e9 c1 f1 ff ff       	jmp    80105938 <alltraps>

80106777 <vector236>:
.globl vector236
vector236:
  pushl $0
80106777:	6a 00                	push   $0x0
  pushl $236
80106779:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010677e:	e9 b5 f1 ff ff       	jmp    80105938 <alltraps>

80106783 <vector237>:
.globl vector237
vector237:
  pushl $0
80106783:	6a 00                	push   $0x0
  pushl $237
80106785:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010678a:	e9 a9 f1 ff ff       	jmp    80105938 <alltraps>

8010678f <vector238>:
.globl vector238
vector238:
  pushl $0
8010678f:	6a 00                	push   $0x0
  pushl $238
80106791:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106796:	e9 9d f1 ff ff       	jmp    80105938 <alltraps>

8010679b <vector239>:
.globl vector239
vector239:
  pushl $0
8010679b:	6a 00                	push   $0x0
  pushl $239
8010679d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801067a2:	e9 91 f1 ff ff       	jmp    80105938 <alltraps>

801067a7 <vector240>:
.globl vector240
vector240:
  pushl $0
801067a7:	6a 00                	push   $0x0
  pushl $240
801067a9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801067ae:	e9 85 f1 ff ff       	jmp    80105938 <alltraps>

801067b3 <vector241>:
.globl vector241
vector241:
  pushl $0
801067b3:	6a 00                	push   $0x0
  pushl $241
801067b5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801067ba:	e9 79 f1 ff ff       	jmp    80105938 <alltraps>

801067bf <vector242>:
.globl vector242
vector242:
  pushl $0
801067bf:	6a 00                	push   $0x0
  pushl $242
801067c1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801067c6:	e9 6d f1 ff ff       	jmp    80105938 <alltraps>

801067cb <vector243>:
.globl vector243
vector243:
  pushl $0
801067cb:	6a 00                	push   $0x0
  pushl $243
801067cd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801067d2:	e9 61 f1 ff ff       	jmp    80105938 <alltraps>

801067d7 <vector244>:
.globl vector244
vector244:
  pushl $0
801067d7:	6a 00                	push   $0x0
  pushl $244
801067d9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801067de:	e9 55 f1 ff ff       	jmp    80105938 <alltraps>

801067e3 <vector245>:
.globl vector245
vector245:
  pushl $0
801067e3:	6a 00                	push   $0x0
  pushl $245
801067e5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801067ea:	e9 49 f1 ff ff       	jmp    80105938 <alltraps>

801067ef <vector246>:
.globl vector246
vector246:
  pushl $0
801067ef:	6a 00                	push   $0x0
  pushl $246
801067f1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801067f6:	e9 3d f1 ff ff       	jmp    80105938 <alltraps>

801067fb <vector247>:
.globl vector247
vector247:
  pushl $0
801067fb:	6a 00                	push   $0x0
  pushl $247
801067fd:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106802:	e9 31 f1 ff ff       	jmp    80105938 <alltraps>

80106807 <vector248>:
.globl vector248
vector248:
  pushl $0
80106807:	6a 00                	push   $0x0
  pushl $248
80106809:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010680e:	e9 25 f1 ff ff       	jmp    80105938 <alltraps>

80106813 <vector249>:
.globl vector249
vector249:
  pushl $0
80106813:	6a 00                	push   $0x0
  pushl $249
80106815:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010681a:	e9 19 f1 ff ff       	jmp    80105938 <alltraps>

8010681f <vector250>:
.globl vector250
vector250:
  pushl $0
8010681f:	6a 00                	push   $0x0
  pushl $250
80106821:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106826:	e9 0d f1 ff ff       	jmp    80105938 <alltraps>

8010682b <vector251>:
.globl vector251
vector251:
  pushl $0
8010682b:	6a 00                	push   $0x0
  pushl $251
8010682d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106832:	e9 01 f1 ff ff       	jmp    80105938 <alltraps>

80106837 <vector252>:
.globl vector252
vector252:
  pushl $0
80106837:	6a 00                	push   $0x0
  pushl $252
80106839:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010683e:	e9 f5 f0 ff ff       	jmp    80105938 <alltraps>

80106843 <vector253>:
.globl vector253
vector253:
  pushl $0
80106843:	6a 00                	push   $0x0
  pushl $253
80106845:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010684a:	e9 e9 f0 ff ff       	jmp    80105938 <alltraps>

8010684f <vector254>:
.globl vector254
vector254:
  pushl $0
8010684f:	6a 00                	push   $0x0
  pushl $254
80106851:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106856:	e9 dd f0 ff ff       	jmp    80105938 <alltraps>

8010685b <vector255>:
.globl vector255
vector255:
  pushl $0
8010685b:	6a 00                	push   $0x0
  pushl $255
8010685d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106862:	e9 d1 f0 ff ff       	jmp    80105938 <alltraps>
80106867:	66 90                	xchg   %ax,%ax
80106869:	66 90                	xchg   %ax,%ax
8010686b:	66 90                	xchg   %ax,%ax
8010686d:	66 90                	xchg   %ax,%ax
8010686f:	90                   	nop

80106870 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106870:	55                   	push   %ebp
80106871:	89 e5                	mov    %esp,%ebp
80106873:	57                   	push   %edi
80106874:	56                   	push   %esi
80106875:	53                   	push   %ebx
80106876:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106878:	c1 ea 16             	shr    $0x16,%edx
8010687b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
8010687e:	83 ec 0c             	sub    $0xc,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
80106881:	8b 07                	mov    (%edi),%eax
80106883:	a8 01                	test   $0x1,%al
80106885:	74 29                	je     801068b0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106887:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010688c:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106892:	8d 65 f4             	lea    -0xc(%ebp),%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106895:	c1 eb 0a             	shr    $0xa,%ebx
80106898:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
8010689e:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
801068a1:	5b                   	pop    %ebx
801068a2:	5e                   	pop    %esi
801068a3:	5f                   	pop    %edi
801068a4:	5d                   	pop    %ebp
801068a5:	c3                   	ret    
801068a6:	8d 76 00             	lea    0x0(%esi),%esi
801068a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801068b0:	85 c9                	test   %ecx,%ecx
801068b2:	74 2c                	je     801068e0 <walkpgdir+0x70>
801068b4:	e8 c7 bd ff ff       	call   80102680 <kalloc>
801068b9:	85 c0                	test   %eax,%eax
801068bb:	89 c6                	mov    %eax,%esi
801068bd:	74 21                	je     801068e0 <walkpgdir+0x70>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
801068bf:	83 ec 04             	sub    $0x4,%esp
801068c2:	68 00 10 00 00       	push   $0x1000
801068c7:	6a 00                	push   $0x0
801068c9:	50                   	push   %eax
801068ca:	e8 41 dd ff ff       	call   80104610 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801068cf:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801068d5:	83 c4 10             	add    $0x10,%esp
801068d8:	83 c8 07             	or     $0x7,%eax
801068db:	89 07                	mov    %eax,(%edi)
801068dd:	eb b3                	jmp    80106892 <walkpgdir+0x22>
801068df:	90                   	nop
  }
  return &pgtab[PTX(va)];
}
801068e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
801068e3:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
801068e5:	5b                   	pop    %ebx
801068e6:	5e                   	pop    %esi
801068e7:	5f                   	pop    %edi
801068e8:	5d                   	pop    %ebp
801068e9:	c3                   	ret    
801068ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801068f0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801068f0:	55                   	push   %ebp
801068f1:	89 e5                	mov    %esp,%ebp
801068f3:	57                   	push   %edi
801068f4:	56                   	push   %esi
801068f5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801068f6:	89 d3                	mov    %edx,%ebx
801068f8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801068fe:	83 ec 1c             	sub    $0x1c,%esp
80106901:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106904:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106908:	8b 7d 08             	mov    0x8(%ebp),%edi
8010690b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106910:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106913:	8b 45 0c             	mov    0xc(%ebp),%eax
80106916:	29 df                	sub    %ebx,%edi
80106918:	83 c8 01             	or     $0x1,%eax
8010691b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010691e:	eb 15                	jmp    80106935 <mappages+0x45>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80106920:	f6 00 01             	testb  $0x1,(%eax)
80106923:	75 45                	jne    8010696a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80106925:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106928:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
8010692b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010692d:	74 31                	je     80106960 <mappages+0x70>
      break;
    a += PGSIZE;
8010692f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106935:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106938:	b9 01 00 00 00       	mov    $0x1,%ecx
8010693d:	89 da                	mov    %ebx,%edx
8010693f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106942:	e8 29 ff ff ff       	call   80106870 <walkpgdir>
80106947:	85 c0                	test   %eax,%eax
80106949:	75 d5                	jne    80106920 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
8010694b:	8d 65 f4             	lea    -0xc(%ebp),%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
8010694e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80106953:	5b                   	pop    %ebx
80106954:	5e                   	pop    %esi
80106955:	5f                   	pop    %edi
80106956:	5d                   	pop    %ebp
80106957:	c3                   	ret    
80106958:	90                   	nop
80106959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106960:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80106963:	31 c0                	xor    %eax,%eax
}
80106965:	5b                   	pop    %ebx
80106966:	5e                   	pop    %esi
80106967:	5f                   	pop    %edi
80106968:	5d                   	pop    %ebp
80106969:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
8010696a:	83 ec 0c             	sub    $0xc,%esp
8010696d:	68 b8 7a 10 80       	push   $0x80107ab8
80106972:	e8 f9 99 ff ff       	call   80100370 <panic>
80106977:	89 f6                	mov    %esi,%esi
80106979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106980 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106980:	55                   	push   %ebp
80106981:	89 e5                	mov    %esp,%ebp
80106983:	57                   	push   %edi
80106984:	56                   	push   %esi
80106985:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106986:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010698c:	89 c7                	mov    %eax,%edi
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
8010698e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106994:	83 ec 1c             	sub    $0x1c,%esp
80106997:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
8010699a:	39 d3                	cmp    %edx,%ebx
8010699c:	73 66                	jae    80106a04 <deallocuvm.part.0+0x84>
8010699e:	89 d6                	mov    %edx,%esi
801069a0:	eb 3d                	jmp    801069df <deallocuvm.part.0+0x5f>
801069a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
801069a8:	8b 10                	mov    (%eax),%edx
801069aa:	f6 c2 01             	test   $0x1,%dl
801069ad:	74 26                	je     801069d5 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801069af:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801069b5:	74 58                	je     80106a0f <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
801069b7:	83 ec 0c             	sub    $0xc,%esp
801069ba:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801069c0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801069c3:	52                   	push   %edx
801069c4:	e8 07 bb ff ff       	call   801024d0 <kfree>
      *pte = 0;
801069c9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801069cc:	83 c4 10             	add    $0x10,%esp
801069cf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801069d5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801069db:	39 f3                	cmp    %esi,%ebx
801069dd:	73 25                	jae    80106a04 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
801069df:	31 c9                	xor    %ecx,%ecx
801069e1:	89 da                	mov    %ebx,%edx
801069e3:	89 f8                	mov    %edi,%eax
801069e5:	e8 86 fe ff ff       	call   80106870 <walkpgdir>
    if(!pte)
801069ea:	85 c0                	test   %eax,%eax
801069ec:	75 ba                	jne    801069a8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801069ee:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
801069f4:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801069fa:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106a00:	39 f3                	cmp    %esi,%ebx
80106a02:	72 db                	jb     801069df <deallocuvm.part.0+0x5f>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106a04:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106a07:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a0a:	5b                   	pop    %ebx
80106a0b:	5e                   	pop    %esi
80106a0c:	5f                   	pop    %edi
80106a0d:	5d                   	pop    %ebp
80106a0e:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80106a0f:	83 ec 0c             	sub    $0xc,%esp
80106a12:	68 46 74 10 80       	push   $0x80107446
80106a17:	e8 54 99 ff ff       	call   80100370 <panic>
80106a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106a20 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80106a20:	55                   	push   %ebp
80106a21:	89 e5                	mov    %esp,%ebp
80106a23:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80106a26:	e8 25 cf ff ff       	call   80103950 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106a2b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106a31:	31 c9                	xor    %ecx,%ecx
80106a33:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106a38:	66 89 90 98 37 11 80 	mov    %dx,-0x7feec868(%eax)
80106a3f:	66 89 88 9a 37 11 80 	mov    %cx,-0x7feec866(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106a46:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106a4b:	31 c9                	xor    %ecx,%ecx
80106a4d:	66 89 90 a0 37 11 80 	mov    %dx,-0x7feec860(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106a54:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106a59:	66 89 88 a2 37 11 80 	mov    %cx,-0x7feec85e(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106a60:	31 c9                	xor    %ecx,%ecx
80106a62:	66 89 90 a8 37 11 80 	mov    %dx,-0x7feec858(%eax)
80106a69:	66 89 88 aa 37 11 80 	mov    %cx,-0x7feec856(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106a70:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106a75:	31 c9                	xor    %ecx,%ecx
80106a77:	66 89 90 b0 37 11 80 	mov    %dx,-0x7feec850(%eax)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106a7e:	c6 80 9c 37 11 80 00 	movb   $0x0,-0x7feec864(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106a85:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106a8a:	c6 80 9d 37 11 80 9a 	movb   $0x9a,-0x7feec863(%eax)
80106a91:	c6 80 9e 37 11 80 cf 	movb   $0xcf,-0x7feec862(%eax)
80106a98:	c6 80 9f 37 11 80 00 	movb   $0x0,-0x7feec861(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106a9f:	c6 80 a4 37 11 80 00 	movb   $0x0,-0x7feec85c(%eax)
80106aa6:	c6 80 a5 37 11 80 92 	movb   $0x92,-0x7feec85b(%eax)
80106aad:	c6 80 a6 37 11 80 cf 	movb   $0xcf,-0x7feec85a(%eax)
80106ab4:	c6 80 a7 37 11 80 00 	movb   $0x0,-0x7feec859(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106abb:	c6 80 ac 37 11 80 00 	movb   $0x0,-0x7feec854(%eax)
80106ac2:	c6 80 ad 37 11 80 fa 	movb   $0xfa,-0x7feec853(%eax)
80106ac9:	c6 80 ae 37 11 80 cf 	movb   $0xcf,-0x7feec852(%eax)
80106ad0:	c6 80 af 37 11 80 00 	movb   $0x0,-0x7feec851(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106ad7:	66 89 88 b2 37 11 80 	mov    %cx,-0x7feec84e(%eax)
80106ade:	c6 80 b4 37 11 80 00 	movb   $0x0,-0x7feec84c(%eax)
80106ae5:	c6 80 b5 37 11 80 f2 	movb   $0xf2,-0x7feec84b(%eax)
80106aec:	c6 80 b6 37 11 80 cf 	movb   $0xcf,-0x7feec84a(%eax)
80106af3:	c6 80 b7 37 11 80 00 	movb   $0x0,-0x7feec849(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80106afa:	05 90 37 11 80       	add    $0x80113790,%eax
80106aff:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
80106b03:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106b07:	c1 e8 10             	shr    $0x10,%eax
80106b0a:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80106b0e:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106b11:	0f 01 10             	lgdtl  (%eax)
}
80106b14:	c9                   	leave  
80106b15:	c3                   	ret    
80106b16:	8d 76 00             	lea    0x0(%esi),%esi
80106b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b20 <switchkvm>:
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106b20:	a1 44 64 11 80       	mov    0x80116444,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106b25:	55                   	push   %ebp
80106b26:	89 e5                	mov    %esp,%ebp
80106b28:	05 00 00 00 80       	add    $0x80000000,%eax
80106b2d:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
80106b30:	5d                   	pop    %ebp
80106b31:	c3                   	ret    
80106b32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b40 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80106b40:	55                   	push   %ebp
80106b41:	89 e5                	mov    %esp,%ebp
80106b43:	57                   	push   %edi
80106b44:	56                   	push   %esi
80106b45:	53                   	push   %ebx
80106b46:	83 ec 1c             	sub    $0x1c,%esp
80106b49:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106b4c:	85 f6                	test   %esi,%esi
80106b4e:	0f 84 cd 00 00 00    	je     80106c21 <switchuvm+0xe1>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80106b54:	8b 46 08             	mov    0x8(%esi),%eax
80106b57:	85 c0                	test   %eax,%eax
80106b59:	0f 84 dc 00 00 00    	je     80106c3b <switchuvm+0xfb>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80106b5f:	8b 7e 04             	mov    0x4(%esi),%edi
80106b62:	85 ff                	test   %edi,%edi
80106b64:	0f 84 c4 00 00 00    	je     80106c2e <switchuvm+0xee>
    panic("switchuvm: no pgdir");

  pushcli();
80106b6a:	e8 f1 d8 ff ff       	call   80104460 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106b6f:	e8 5c cd ff ff       	call   801038d0 <mycpu>
80106b74:	89 c3                	mov    %eax,%ebx
80106b76:	e8 55 cd ff ff       	call   801038d0 <mycpu>
80106b7b:	89 c7                	mov    %eax,%edi
80106b7d:	e8 4e cd ff ff       	call   801038d0 <mycpu>
80106b82:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106b85:	83 c7 08             	add    $0x8,%edi
80106b88:	e8 43 cd ff ff       	call   801038d0 <mycpu>
80106b8d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106b90:	83 c0 08             	add    $0x8,%eax
80106b93:	ba 67 00 00 00       	mov    $0x67,%edx
80106b98:	c1 e8 18             	shr    $0x18,%eax
80106b9b:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80106ba2:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106ba9:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
80106bb0:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80106bb7:	83 c1 08             	add    $0x8,%ecx
80106bba:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106bc0:	c1 e9 10             	shr    $0x10,%ecx
80106bc3:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106bc9:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    panic("switchuvm: no pgdir");

  pushcli();
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
80106bce:	e8 fd cc ff ff       	call   801038d0 <mycpu>
80106bd3:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106bda:	e8 f1 cc ff ff       	call   801038d0 <mycpu>
80106bdf:	b9 10 00 00 00       	mov    $0x10,%ecx
80106be4:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106be8:	e8 e3 cc ff ff       	call   801038d0 <mycpu>
80106bed:	8b 56 08             	mov    0x8(%esi),%edx
80106bf0:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80106bf6:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106bf9:	e8 d2 cc ff ff       	call   801038d0 <mycpu>
80106bfe:	66 89 58 6e          	mov    %bx,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
80106c02:	b8 28 00 00 00       	mov    $0x28,%eax
80106c07:	0f 00 d8             	ltr    %ax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106c0a:	8b 46 04             	mov    0x4(%esi),%eax
80106c0d:	05 00 00 00 80       	add    $0x80000000,%eax
80106c12:	0f 22 d8             	mov    %eax,%cr3
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
80106c15:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c18:	5b                   	pop    %ebx
80106c19:	5e                   	pop    %esi
80106c1a:	5f                   	pop    %edi
80106c1b:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
80106c1c:	e9 2f d9 ff ff       	jmp    80104550 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
80106c21:	83 ec 0c             	sub    $0xc,%esp
80106c24:	68 be 7a 10 80       	push   $0x80107abe
80106c29:	e8 42 97 ff ff       	call   80100370 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
80106c2e:	83 ec 0c             	sub    $0xc,%esp
80106c31:	68 e9 7a 10 80       	push   $0x80107ae9
80106c36:	e8 35 97 ff ff       	call   80100370 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
80106c3b:	83 ec 0c             	sub    $0xc,%esp
80106c3e:	68 d4 7a 10 80       	push   $0x80107ad4
80106c43:	e8 28 97 ff ff       	call   80100370 <panic>
80106c48:	90                   	nop
80106c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106c50 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106c50:	55                   	push   %ebp
80106c51:	89 e5                	mov    %esp,%ebp
80106c53:	57                   	push   %edi
80106c54:	56                   	push   %esi
80106c55:	53                   	push   %ebx
80106c56:	83 ec 1c             	sub    $0x1c,%esp
80106c59:	8b 75 10             	mov    0x10(%ebp),%esi
80106c5c:	8b 45 08             	mov    0x8(%ebp),%eax
80106c5f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80106c62:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106c68:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80106c6b:	77 49                	ja     80106cb6 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
80106c6d:	e8 0e ba ff ff       	call   80102680 <kalloc>
  memset(mem, 0, PGSIZE);
80106c72:	83 ec 04             	sub    $0x4,%esp
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80106c75:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106c77:	68 00 10 00 00       	push   $0x1000
80106c7c:	6a 00                	push   $0x0
80106c7e:	50                   	push   %eax
80106c7f:	e8 8c d9 ff ff       	call   80104610 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106c84:	58                   	pop    %eax
80106c85:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106c8b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106c90:	5a                   	pop    %edx
80106c91:	6a 06                	push   $0x6
80106c93:	50                   	push   %eax
80106c94:	31 d2                	xor    %edx,%edx
80106c96:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106c99:	e8 52 fc ff ff       	call   801068f0 <mappages>
  memmove(mem, init, sz);
80106c9e:	89 75 10             	mov    %esi,0x10(%ebp)
80106ca1:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106ca4:	83 c4 10             	add    $0x10,%esp
80106ca7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106caa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106cad:	5b                   	pop    %ebx
80106cae:	5e                   	pop    %esi
80106caf:	5f                   	pop    %edi
80106cb0:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80106cb1:	e9 0a da ff ff       	jmp    801046c0 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80106cb6:	83 ec 0c             	sub    $0xc,%esp
80106cb9:	68 fd 7a 10 80       	push   $0x80107afd
80106cbe:	e8 ad 96 ff ff       	call   80100370 <panic>
80106cc3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106cd0 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80106cd0:	55                   	push   %ebp
80106cd1:	89 e5                	mov    %esp,%ebp
80106cd3:	57                   	push   %edi
80106cd4:	56                   	push   %esi
80106cd5:	53                   	push   %ebx
80106cd6:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80106cd9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106ce0:	0f 85 91 00 00 00    	jne    80106d77 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80106ce6:	8b 75 18             	mov    0x18(%ebp),%esi
80106ce9:	31 db                	xor    %ebx,%ebx
80106ceb:	85 f6                	test   %esi,%esi
80106ced:	75 1a                	jne    80106d09 <loaduvm+0x39>
80106cef:	eb 6f                	jmp    80106d60 <loaduvm+0x90>
80106cf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106cf8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106cfe:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106d04:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106d07:	76 57                	jbe    80106d60 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106d09:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d0c:	8b 45 08             	mov    0x8(%ebp),%eax
80106d0f:	31 c9                	xor    %ecx,%ecx
80106d11:	01 da                	add    %ebx,%edx
80106d13:	e8 58 fb ff ff       	call   80106870 <walkpgdir>
80106d18:	85 c0                	test   %eax,%eax
80106d1a:	74 4e                	je     80106d6a <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106d1c:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106d1e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
80106d21:	bf 00 10 00 00       	mov    $0x1000,%edi
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106d26:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106d2b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106d31:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106d34:	01 d9                	add    %ebx,%ecx
80106d36:	05 00 00 00 80       	add    $0x80000000,%eax
80106d3b:	57                   	push   %edi
80106d3c:	51                   	push   %ecx
80106d3d:	50                   	push   %eax
80106d3e:	ff 75 10             	pushl  0x10(%ebp)
80106d41:	e8 fa ad ff ff       	call   80101b40 <readi>
80106d46:	83 c4 10             	add    $0x10,%esp
80106d49:	39 c7                	cmp    %eax,%edi
80106d4b:	74 ab                	je     80106cf8 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80106d4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80106d50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80106d55:	5b                   	pop    %ebx
80106d56:	5e                   	pop    %esi
80106d57:	5f                   	pop    %edi
80106d58:	5d                   	pop    %ebp
80106d59:	c3                   	ret    
80106d5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d60:	8d 65 f4             	lea    -0xc(%ebp),%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80106d63:	31 c0                	xor    %eax,%eax
}
80106d65:	5b                   	pop    %ebx
80106d66:	5e                   	pop    %esi
80106d67:	5f                   	pop    %edi
80106d68:	5d                   	pop    %ebp
80106d69:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80106d6a:	83 ec 0c             	sub    $0xc,%esp
80106d6d:	68 17 7b 10 80       	push   $0x80107b17
80106d72:	e8 f9 95 ff ff       	call   80100370 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80106d77:	83 ec 0c             	sub    $0xc,%esp
80106d7a:	68 b8 7b 10 80       	push   $0x80107bb8
80106d7f:	e8 ec 95 ff ff       	call   80100370 <panic>
80106d84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106d90 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106d90:	55                   	push   %ebp
80106d91:	89 e5                	mov    %esp,%ebp
80106d93:	57                   	push   %edi
80106d94:	56                   	push   %esi
80106d95:	53                   	push   %ebx
80106d96:	83 ec 0c             	sub    $0xc,%esp
80106d99:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80106d9c:	85 ff                	test   %edi,%edi
80106d9e:	0f 88 ca 00 00 00    	js     80106e6e <allocuvm+0xde>
    return 0;
  if(newsz < oldsz)
80106da4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80106da7:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
80106daa:	0f 82 82 00 00 00    	jb     80106e32 <allocuvm+0xa2>
    return oldsz;

  a = PGROUNDUP(oldsz);
80106db0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106db6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106dbc:	39 df                	cmp    %ebx,%edi
80106dbe:	77 43                	ja     80106e03 <allocuvm+0x73>
80106dc0:	e9 bb 00 00 00       	jmp    80106e80 <allocuvm+0xf0>
80106dc5:	8d 76 00             	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80106dc8:	83 ec 04             	sub    $0x4,%esp
80106dcb:	68 00 10 00 00       	push   $0x1000
80106dd0:	6a 00                	push   $0x0
80106dd2:	50                   	push   %eax
80106dd3:	e8 38 d8 ff ff       	call   80104610 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106dd8:	58                   	pop    %eax
80106dd9:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106ddf:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106de4:	5a                   	pop    %edx
80106de5:	6a 06                	push   $0x6
80106de7:	50                   	push   %eax
80106de8:	89 da                	mov    %ebx,%edx
80106dea:	8b 45 08             	mov    0x8(%ebp),%eax
80106ded:	e8 fe fa ff ff       	call   801068f0 <mappages>
80106df2:	83 c4 10             	add    $0x10,%esp
80106df5:	85 c0                	test   %eax,%eax
80106df7:	78 47                	js     80106e40 <allocuvm+0xb0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106df9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106dff:	39 df                	cmp    %ebx,%edi
80106e01:	76 7d                	jbe    80106e80 <allocuvm+0xf0>
    mem = kalloc();
80106e03:	e8 78 b8 ff ff       	call   80102680 <kalloc>
    if(mem == 0){
80106e08:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
80106e0a:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106e0c:	75 ba                	jne    80106dc8 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
80106e0e:	83 ec 0c             	sub    $0xc,%esp
80106e11:	68 35 7b 10 80       	push   $0x80107b35
80106e16:	e8 65 98 ff ff       	call   80100680 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106e1b:	83 c4 10             	add    $0x10,%esp
80106e1e:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106e21:	76 4b                	jbe    80106e6e <allocuvm+0xde>
80106e23:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106e26:	8b 45 08             	mov    0x8(%ebp),%eax
80106e29:	89 fa                	mov    %edi,%edx
80106e2b:	e8 50 fb ff ff       	call   80106980 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80106e30:	31 c0                	xor    %eax,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106e32:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e35:	5b                   	pop    %ebx
80106e36:	5e                   	pop    %esi
80106e37:	5f                   	pop    %edi
80106e38:	5d                   	pop    %ebp
80106e39:	c3                   	ret    
80106e3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80106e40:	83 ec 0c             	sub    $0xc,%esp
80106e43:	68 4d 7b 10 80       	push   $0x80107b4d
80106e48:	e8 33 98 ff ff       	call   80100680 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106e4d:	83 c4 10             	add    $0x10,%esp
80106e50:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106e53:	76 0d                	jbe    80106e62 <allocuvm+0xd2>
80106e55:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106e58:	8b 45 08             	mov    0x8(%ebp),%eax
80106e5b:	89 fa                	mov    %edi,%edx
80106e5d:	e8 1e fb ff ff       	call   80106980 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80106e62:	83 ec 0c             	sub    $0xc,%esp
80106e65:	56                   	push   %esi
80106e66:	e8 65 b6 ff ff       	call   801024d0 <kfree>
      return 0;
80106e6b:	83 c4 10             	add    $0x10,%esp
    }
  }
  return newsz;
}
80106e6e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80106e71:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
80106e73:	5b                   	pop    %ebx
80106e74:	5e                   	pop    %esi
80106e75:	5f                   	pop    %edi
80106e76:	5d                   	pop    %ebp
80106e77:	c3                   	ret    
80106e78:	90                   	nop
80106e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e80:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106e83:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106e85:	5b                   	pop    %ebx
80106e86:	5e                   	pop    %esi
80106e87:	5f                   	pop    %edi
80106e88:	5d                   	pop    %ebp
80106e89:	c3                   	ret    
80106e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106e90 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106e90:	55                   	push   %ebp
80106e91:	89 e5                	mov    %esp,%ebp
80106e93:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e96:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106e99:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106e9c:	39 d1                	cmp    %edx,%ecx
80106e9e:	73 10                	jae    80106eb0 <deallocuvm+0x20>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106ea0:	5d                   	pop    %ebp
80106ea1:	e9 da fa ff ff       	jmp    80106980 <deallocuvm.part.0>
80106ea6:	8d 76 00             	lea    0x0(%esi),%esi
80106ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106eb0:	89 d0                	mov    %edx,%eax
80106eb2:	5d                   	pop    %ebp
80106eb3:	c3                   	ret    
80106eb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106eba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106ec0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106ec0:	55                   	push   %ebp
80106ec1:	89 e5                	mov    %esp,%ebp
80106ec3:	57                   	push   %edi
80106ec4:	56                   	push   %esi
80106ec5:	53                   	push   %ebx
80106ec6:	83 ec 0c             	sub    $0xc,%esp
80106ec9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106ecc:	85 f6                	test   %esi,%esi
80106ece:	74 59                	je     80106f29 <freevm+0x69>
80106ed0:	31 c9                	xor    %ecx,%ecx
80106ed2:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106ed7:	89 f0                	mov    %esi,%eax
80106ed9:	e8 a2 fa ff ff       	call   80106980 <deallocuvm.part.0>
80106ede:	89 f3                	mov    %esi,%ebx
80106ee0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106ee6:	eb 0f                	jmp    80106ef7 <freevm+0x37>
80106ee8:	90                   	nop
80106ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ef0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106ef3:	39 fb                	cmp    %edi,%ebx
80106ef5:	74 23                	je     80106f1a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106ef7:	8b 03                	mov    (%ebx),%eax
80106ef9:	a8 01                	test   $0x1,%al
80106efb:	74 f3                	je     80106ef0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
80106efd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106f02:	83 ec 0c             	sub    $0xc,%esp
80106f05:	83 c3 04             	add    $0x4,%ebx
80106f08:	05 00 00 00 80       	add    $0x80000000,%eax
80106f0d:	50                   	push   %eax
80106f0e:	e8 bd b5 ff ff       	call   801024d0 <kfree>
80106f13:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106f16:	39 fb                	cmp    %edi,%ebx
80106f18:	75 dd                	jne    80106ef7 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106f1a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106f1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f20:	5b                   	pop    %ebx
80106f21:	5e                   	pop    %esi
80106f22:	5f                   	pop    %edi
80106f23:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106f24:	e9 a7 b5 ff ff       	jmp    801024d0 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80106f29:	83 ec 0c             	sub    $0xc,%esp
80106f2c:	68 69 7b 10 80       	push   $0x80107b69
80106f31:	e8 3a 94 ff ff       	call   80100370 <panic>
80106f36:	8d 76 00             	lea    0x0(%esi),%esi
80106f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f40 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80106f40:	55                   	push   %ebp
80106f41:	89 e5                	mov    %esp,%ebp
80106f43:	56                   	push   %esi
80106f44:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80106f45:	e8 36 b7 ff ff       	call   80102680 <kalloc>
80106f4a:	85 c0                	test   %eax,%eax
80106f4c:	74 6a                	je     80106fb8 <setupkvm+0x78>
    return 0;
  memset(pgdir, 0, PGSIZE);
80106f4e:	83 ec 04             	sub    $0x4,%esp
80106f51:	89 c6                	mov    %eax,%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106f53:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
80106f58:	68 00 10 00 00       	push   $0x1000
80106f5d:	6a 00                	push   $0x0
80106f5f:	50                   	push   %eax
80106f60:	e8 ab d6 ff ff       	call   80104610 <memset>
80106f65:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106f68:	8b 43 04             	mov    0x4(%ebx),%eax
80106f6b:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106f6e:	83 ec 08             	sub    $0x8,%esp
80106f71:	8b 13                	mov    (%ebx),%edx
80106f73:	ff 73 0c             	pushl  0xc(%ebx)
80106f76:	50                   	push   %eax
80106f77:	29 c1                	sub    %eax,%ecx
80106f79:	89 f0                	mov    %esi,%eax
80106f7b:	e8 70 f9 ff ff       	call   801068f0 <mappages>
80106f80:	83 c4 10             	add    $0x10,%esp
80106f83:	85 c0                	test   %eax,%eax
80106f85:	78 19                	js     80106fa0 <setupkvm+0x60>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106f87:	83 c3 10             	add    $0x10,%ebx
80106f8a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106f90:	75 d6                	jne    80106f68 <setupkvm+0x28>
80106f92:	89 f0                	mov    %esi,%eax
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
80106f94:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106f97:	5b                   	pop    %ebx
80106f98:	5e                   	pop    %esi
80106f99:	5d                   	pop    %ebp
80106f9a:	c3                   	ret    
80106f9b:	90                   	nop
80106f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
80106fa0:	83 ec 0c             	sub    $0xc,%esp
80106fa3:	56                   	push   %esi
80106fa4:	e8 17 ff ff ff       	call   80106ec0 <freevm>
      return 0;
80106fa9:	83 c4 10             	add    $0x10,%esp
    }
  return pgdir;
}
80106fac:	8d 65 f8             	lea    -0x8(%ebp),%esp
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
80106faf:	31 c0                	xor    %eax,%eax
    }
  return pgdir;
}
80106fb1:	5b                   	pop    %ebx
80106fb2:	5e                   	pop    %esi
80106fb3:	5d                   	pop    %ebp
80106fb4:	c3                   	ret    
80106fb5:	8d 76 00             	lea    0x0(%esi),%esi
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80106fb8:	31 c0                	xor    %eax,%eax
80106fba:	eb d8                	jmp    80106f94 <setupkvm+0x54>
80106fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106fc0 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80106fc0:	55                   	push   %ebp
80106fc1:	89 e5                	mov    %esp,%ebp
80106fc3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106fc6:	e8 75 ff ff ff       	call   80106f40 <setupkvm>
80106fcb:	a3 44 64 11 80       	mov    %eax,0x80116444
80106fd0:	05 00 00 00 80       	add    $0x80000000,%eax
80106fd5:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
80106fd8:	c9                   	leave  
80106fd9:	c3                   	ret    
80106fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106fe0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106fe0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106fe1:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106fe3:	89 e5                	mov    %esp,%ebp
80106fe5:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106fe8:	8b 55 0c             	mov    0xc(%ebp),%edx
80106feb:	8b 45 08             	mov    0x8(%ebp),%eax
80106fee:	e8 7d f8 ff ff       	call   80106870 <walkpgdir>
  if(pte == 0)
80106ff3:	85 c0                	test   %eax,%eax
80106ff5:	74 05                	je     80106ffc <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106ff7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106ffa:	c9                   	leave  
80106ffb:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80106ffc:	83 ec 0c             	sub    $0xc,%esp
80106fff:	68 7a 7b 10 80       	push   $0x80107b7a
80107004:	e8 67 93 ff ff       	call   80100370 <panic>
80107009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107010 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107010:	55                   	push   %ebp
80107011:	89 e5                	mov    %esp,%ebp
80107013:	57                   	push   %edi
80107014:	56                   	push   %esi
80107015:	53                   	push   %ebx
80107016:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107019:	e8 22 ff ff ff       	call   80106f40 <setupkvm>
8010701e:	85 c0                	test   %eax,%eax
80107020:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107023:	0f 84 b2 00 00 00    	je     801070db <copyuvm+0xcb>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107029:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010702c:	85 c9                	test   %ecx,%ecx
8010702e:	0f 84 9c 00 00 00    	je     801070d0 <copyuvm+0xc0>
80107034:	31 f6                	xor    %esi,%esi
80107036:	eb 4a                	jmp    80107082 <copyuvm+0x72>
80107038:	90                   	nop
80107039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107040:	83 ec 04             	sub    $0x4,%esp
80107043:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107049:	68 00 10 00 00       	push   $0x1000
8010704e:	57                   	push   %edi
8010704f:	50                   	push   %eax
80107050:	e8 6b d6 ff ff       	call   801046c0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80107055:	58                   	pop    %eax
80107056:	5a                   	pop    %edx
80107057:	8d 93 00 00 00 80    	lea    -0x80000000(%ebx),%edx
8010705d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107060:	ff 75 e4             	pushl  -0x1c(%ebp)
80107063:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107068:	52                   	push   %edx
80107069:	89 f2                	mov    %esi,%edx
8010706b:	e8 80 f8 ff ff       	call   801068f0 <mappages>
80107070:	83 c4 10             	add    $0x10,%esp
80107073:	85 c0                	test   %eax,%eax
80107075:	78 3e                	js     801070b5 <copyuvm+0xa5>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107077:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010707d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107080:	76 4e                	jbe    801070d0 <copyuvm+0xc0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107082:	8b 45 08             	mov    0x8(%ebp),%eax
80107085:	31 c9                	xor    %ecx,%ecx
80107087:	89 f2                	mov    %esi,%edx
80107089:	e8 e2 f7 ff ff       	call   80106870 <walkpgdir>
8010708e:	85 c0                	test   %eax,%eax
80107090:	74 5a                	je     801070ec <copyuvm+0xdc>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80107092:	8b 18                	mov    (%eax),%ebx
80107094:	f6 c3 01             	test   $0x1,%bl
80107097:	74 46                	je     801070df <copyuvm+0xcf>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107099:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
8010709b:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
801070a1:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
801070a4:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
801070aa:	e8 d1 b5 ff ff       	call   80102680 <kalloc>
801070af:	85 c0                	test   %eax,%eax
801070b1:	89 c3                	mov    %eax,%ebx
801070b3:	75 8b                	jne    80107040 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
801070b5:	83 ec 0c             	sub    $0xc,%esp
801070b8:	ff 75 e0             	pushl  -0x20(%ebp)
801070bb:	e8 00 fe ff ff       	call   80106ec0 <freevm>
  return 0;
801070c0:	83 c4 10             	add    $0x10,%esp
801070c3:	31 c0                	xor    %eax,%eax
}
801070c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070c8:	5b                   	pop    %ebx
801070c9:	5e                   	pop    %esi
801070ca:	5f                   	pop    %edi
801070cb:	5d                   	pop    %ebp
801070cc:	c3                   	ret    
801070cd:	8d 76 00             	lea    0x0(%esi),%esi
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801070d0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
801070d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070d6:	5b                   	pop    %ebx
801070d7:	5e                   	pop    %esi
801070d8:	5f                   	pop    %edi
801070d9:	5d                   	pop    %ebp
801070da:	c3                   	ret    
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
801070db:	31 c0                	xor    %eax,%eax
801070dd:	eb e6                	jmp    801070c5 <copyuvm+0xb5>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
801070df:	83 ec 0c             	sub    $0xc,%esp
801070e2:	68 9e 7b 10 80       	push   $0x80107b9e
801070e7:	e8 84 92 ff ff       	call   80100370 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
801070ec:	83 ec 0c             	sub    $0xc,%esp
801070ef:	68 84 7b 10 80       	push   $0x80107b84
801070f4:	e8 77 92 ff ff       	call   80100370 <panic>
801070f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107100 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107100:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107101:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107103:	89 e5                	mov    %esp,%ebp
80107105:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107108:	8b 55 0c             	mov    0xc(%ebp),%edx
8010710b:	8b 45 08             	mov    0x8(%ebp),%eax
8010710e:	e8 5d f7 ff ff       	call   80106870 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107113:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80107115:	89 c2                	mov    %eax,%edx
80107117:	83 e2 05             	and    $0x5,%edx
8010711a:	83 fa 05             	cmp    $0x5,%edx
8010711d:	75 11                	jne    80107130 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
8010711f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
80107124:	c9                   	leave  
  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80107125:	05 00 00 00 80       	add    $0x80000000,%eax
}
8010712a:	c3                   	ret    
8010712b:	90                   	nop
8010712c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
80107130:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
80107132:	c9                   	leave  
80107133:	c3                   	ret    
80107134:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010713a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107140 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107140:	55                   	push   %ebp
80107141:	89 e5                	mov    %esp,%ebp
80107143:	57                   	push   %edi
80107144:	56                   	push   %esi
80107145:	53                   	push   %ebx
80107146:	83 ec 1c             	sub    $0x1c,%esp
80107149:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010714c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010714f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107152:	85 db                	test   %ebx,%ebx
80107154:	75 40                	jne    80107196 <copyout+0x56>
80107156:	eb 70                	jmp    801071c8 <copyout+0x88>
80107158:	90                   	nop
80107159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107160:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107163:	89 f1                	mov    %esi,%ecx
80107165:	29 d1                	sub    %edx,%ecx
80107167:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010716d:	39 d9                	cmp    %ebx,%ecx
8010716f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107172:	29 f2                	sub    %esi,%edx
80107174:	83 ec 04             	sub    $0x4,%esp
80107177:	01 d0                	add    %edx,%eax
80107179:	51                   	push   %ecx
8010717a:	57                   	push   %edi
8010717b:	50                   	push   %eax
8010717c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010717f:	e8 3c d5 ff ff       	call   801046c0 <memmove>
    len -= n;
    buf += n;
80107184:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107187:	83 c4 10             	add    $0x10,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
8010718a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
80107190:	01 cf                	add    %ecx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107192:	29 cb                	sub    %ecx,%ebx
80107194:	74 32                	je     801071c8 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107196:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107198:	83 ec 08             	sub    $0x8,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
8010719b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010719e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801071a4:	56                   	push   %esi
801071a5:	ff 75 08             	pushl  0x8(%ebp)
801071a8:	e8 53 ff ff ff       	call   80107100 <uva2ka>
    if(pa0 == 0)
801071ad:	83 c4 10             	add    $0x10,%esp
801071b0:	85 c0                	test   %eax,%eax
801071b2:	75 ac                	jne    80107160 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
801071b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
801071b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
801071bc:	5b                   	pop    %ebx
801071bd:	5e                   	pop    %esi
801071be:	5f                   	pop    %edi
801071bf:	5d                   	pop    %ebp
801071c0:	c3                   	ret    
801071c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
801071cb:	31 c0                	xor    %eax,%eax
}
801071cd:	5b                   	pop    %ebx
801071ce:	5e                   	pop    %esi
801071cf:	5f                   	pop    %edi
801071d0:	5d                   	pop    %ebp
801071d1:	c3                   	ret    
