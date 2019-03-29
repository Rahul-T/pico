
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
8010002d:	b8 20 30 10 80       	mov    $0x80103020,%eax
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
8010004c:	68 80 71 10 80       	push   $0x80107180
80100051:	68 60 c5 10 80       	push   $0x8010c560
80100056:	e8 05 43 00 00       	call   80104360 <initlock>

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
80100092:	68 87 71 10 80       	push   $0x80107187
80100097:	50                   	push   %eax
80100098:	e8 b3 41 00 00       	call   80104250 <initsleeplock>
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
801000e4:	e8 77 43 00 00       	call   80104460 <acquire>

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
80100162:	e8 19 44 00 00       	call   80104580 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 1e 41 00 00       	call   80104290 <acquiresleep>
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
8010017e:	e8 2d 21 00 00       	call   801022b0 <iderw>
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
80100193:	68 8e 71 10 80       	push   $0x8010718e
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
801001ae:	e8 7d 41 00 00       	call   80104330 <holdingsleep>
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
801001c4:	e9 e7 20 00 00       	jmp    801022b0 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 9f 71 10 80       	push   $0x8010719f
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
801001ef:	e8 3c 41 00 00       	call   80104330 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 ec 40 00 00       	call   801042f0 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 60 c5 10 80 	movl   $0x8010c560,(%esp)
8010020b:	e8 50 42 00 00       	call   80104460 <acquire>
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
8010025c:	e9 1f 43 00 00       	jmp    80104580 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 a6 71 10 80       	push   $0x801071a6
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
80100280:	e8 8b 16 00 00       	call   80101910 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 c0 b4 10 80 	movl   $0x8010b4c0,(%esp)
8010028c:	e8 cf 41 00 00       	call   80104460 <acquire>
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
801002bd:	e8 2e 3c 00 00       	call   80103ef0 <sleep>

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
801002d2:	e8 69 36 00 00       	call   80103940 <myproc>
801002d7:	8b 40 24             	mov    0x24(%eax),%eax
801002da:	85 c0                	test   %eax,%eax
801002dc:	74 d2                	je     801002b0 <consoleread+0x40>
        release(&cons.lock);
801002de:	83 ec 0c             	sub    $0xc,%esp
801002e1:	68 c0 b4 10 80       	push   $0x8010b4c0
801002e6:	e8 95 42 00 00       	call   80104580 <release>
        ilock(ip);
801002eb:	89 3c 24             	mov    %edi,(%esp)
801002ee:	e8 3d 15 00 00       	call   80101830 <ilock>
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
80100346:	e8 35 42 00 00       	call   80104580 <release>
  ilock(ip);
8010034b:	89 3c 24             	mov    %edi,(%esp)
8010034e:	e8 dd 14 00 00       	call   80101830 <ilock>

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
80100389:	e8 22 25 00 00       	call   801028b0 <lapicid>
8010038e:	83 ec 08             	sub    $0x8,%esp
80100391:	50                   	push   %eax
80100392:	68 ad 71 10 80       	push   $0x801071ad
80100397:	e8 14 03 00 00       	call   801006b0 <cprintf>
  cprintf(s);
8010039c:	58                   	pop    %eax
8010039d:	ff 75 08             	pushl  0x8(%ebp)
801003a0:	e8 0b 03 00 00       	call   801006b0 <cprintf>
  cprintf("\n");
801003a5:	c7 04 24 03 7b 10 80 	movl   $0x80107b03,(%esp)
801003ac:	e8 ff 02 00 00       	call   801006b0 <cprintf>
  getcallerpcs(&s, pcs);
801003b1:	5a                   	pop    %edx
801003b2:	8d 45 08             	lea    0x8(%ebp),%eax
801003b5:	59                   	pop    %ecx
801003b6:	53                   	push   %ebx
801003b7:	50                   	push   %eax
801003b8:	e8 c3 3f 00 00       	call   80104380 <getcallerpcs>
801003bd:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003c0:	83 ec 08             	sub    $0x8,%esp
801003c3:	ff 33                	pushl  (%ebx)
801003c5:	83 c3 04             	add    $0x4,%ebx
801003c8:	68 c1 71 10 80       	push   $0x801071c1
801003cd:	e8 de 02 00 00       	call   801006b0 <cprintf>
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

801003f0 <cgaputc>:
  return i;
}

static void
cgaputc(int c)
{
801003f0:	55                   	push   %ebp
801003f1:	89 e5                	mov    %esp,%ebp
801003f3:	57                   	push   %edi
801003f4:	56                   	push   %esi
801003f5:	53                   	push   %ebx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801003f6:	bf d4 03 00 00       	mov    $0x3d4,%edi
801003fb:	89 c6                	mov    %eax,%esi
801003fd:	89 fa                	mov    %edi,%edx
801003ff:	b8 0e 00 00 00       	mov    $0xe,%eax
80100404:	83 ec 1c             	sub    $0x1c,%esp
80100407:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100408:	bb d5 03 00 00       	mov    $0x3d5,%ebx
8010040d:	89 da                	mov    %ebx,%edx
8010040f:	ec                   	in     (%dx),%al
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
80100410:	0f b6 c8             	movzbl %al,%ecx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100413:	89 fa                	mov    %edi,%edx
80100415:	b8 0f 00 00 00       	mov    $0xf,%eax
8010041a:	c1 e1 08             	shl    $0x8,%ecx
8010041d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010041e:	89 da                	mov    %ebx,%edx
80100420:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
80100421:	0f b6 c0             	movzbl %al,%eax
80100424:	09 c8                	or     %ecx,%eax

  if(c == '\n')
80100426:	83 fe 0a             	cmp    $0xa,%esi
80100429:	0f 84 c9 00 00 00    	je     801004f8 <cgaputc+0x108>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
8010042f:	81 fe 00 01 00 00    	cmp    $0x100,%esi
80100435:	0f 84 dd 00 00 00    	je     80100518 <cgaputc+0x128>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010043b:	89 f1                	mov    %esi,%ecx
8010043d:	8d 58 01             	lea    0x1(%eax),%ebx
80100440:	0f b6 f1             	movzbl %cl,%esi
80100443:	66 81 ce 00 07       	or     $0x700,%si
80100448:	66 89 b4 00 00 80 0b 	mov    %si,-0x7ff48000(%eax,%eax,1)
8010044f:	80 

  if(pos < 0 || pos > 25*80)
80100450:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
80100456:	0f 8f d7 00 00 00    	jg     80100533 <cgaputc+0x143>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
8010045c:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
80100462:	7f 4c                	jg     801004b0 <cgaputc+0xc0>
80100464:	89 d8                	mov    %ebx,%eax
80100466:	8d 8c 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%ecx
8010046d:	89 df                	mov    %ebx,%edi
8010046f:	c1 e8 08             	shr    $0x8,%eax
80100472:	89 45 d8             	mov    %eax,-0x28(%ebp)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100475:	be d4 03 00 00       	mov    $0x3d4,%esi
8010047a:	b8 0e 00 00 00       	mov    $0xe,%eax
8010047f:	89 f2                	mov    %esi,%edx
80100481:	ee                   	out    %al,(%dx)
80100482:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100487:	0f b6 45 d8          	movzbl -0x28(%ebp),%eax
8010048b:	89 da                	mov    %ebx,%edx
8010048d:	ee                   	out    %al,(%dx)
8010048e:	b8 0f 00 00 00       	mov    $0xf,%eax
80100493:	89 f2                	mov    %esi,%edx
80100495:	ee                   	out    %al,(%dx)
80100496:	89 f8                	mov    %edi,%eax
80100498:	89 da                	mov    %ebx,%edx
8010049a:	ee                   	out    %al,(%dx)

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
8010049b:	b8 20 07 00 00       	mov    $0x720,%eax
801004a0:	66 89 01             	mov    %ax,(%ecx)
}
801004a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004a6:	5b                   	pop    %ebx
801004a7:	5e                   	pop    %esi
801004a8:	5f                   	pop    %edi
801004a9:	5d                   	pop    %ebp
801004aa:	c3                   	ret    
801004ab:	90                   	nop
801004ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004b0:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
801004b3:	8d 7b b0             	lea    -0x50(%ebx),%edi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004b6:	68 60 0e 00 00       	push   $0xe60
801004bb:	68 a0 80 0b 80       	push   $0x800b80a0
801004c0:	68 00 80 0b 80       	push   $0x800b8000
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004c5:	8d 9c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ebx

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004cc:	e8 af 41 00 00       	call   80104680 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004d1:	b8 80 07 00 00       	mov    $0x780,%eax
801004d6:	83 c4 0c             	add    $0xc,%esp
801004d9:	29 f8                	sub    %edi,%eax
801004db:	01 c0                	add    %eax,%eax
801004dd:	50                   	push   %eax
801004de:	6a 00                	push   $0x0
801004e0:	53                   	push   %ebx
801004e1:	e8 ea 40 00 00       	call   801045d0 <memset>
801004e6:	83 c4 10             	add    $0x10,%esp
801004e9:	89 d9                	mov    %ebx,%ecx
801004eb:	c6 45 d8 07          	movb   $0x7,-0x28(%ebp)
801004ef:	eb 84                	jmp    80100475 <cgaputc+0x85>
801004f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
801004f8:	ba 67 66 66 66       	mov    $0x66666667,%edx
801004fd:	f7 ea                	imul   %edx
801004ff:	89 d0                	mov    %edx,%eax
80100501:	c1 e8 05             	shr    $0x5,%eax
80100504:	8d 04 80             	lea    (%eax,%eax,4),%eax
80100507:	c1 e0 04             	shl    $0x4,%eax
8010050a:	8d 58 50             	lea    0x50(%eax),%ebx
8010050d:	e9 3e ff ff ff       	jmp    80100450 <cgaputc+0x60>
80100512:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
80100518:	85 c0                	test   %eax,%eax
8010051a:	8d 58 ff             	lea    -0x1(%eax),%ebx
8010051d:	0f 85 2d ff ff ff    	jne    80100450 <cgaputc+0x60>
80100523:	b9 00 80 0b 80       	mov    $0x800b8000,%ecx
80100528:	c6 45 d8 00          	movb   $0x0,-0x28(%ebp)
8010052c:	31 ff                	xor    %edi,%edi
8010052e:	e9 42 ff ff ff       	jmp    80100475 <cgaputc+0x85>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");
80100533:	83 ec 0c             	sub    $0xc,%esp
80100536:	68 c5 71 10 80       	push   $0x801071c5
8010053b:	e8 30 fe ff ff       	call   80100370 <panic>

80100540 <consputc>:
}

void
consputc(int c)
{
  if(panicked){
80100540:	8b 15 fc b4 10 80    	mov    0x8010b4fc,%edx
80100546:	85 d2                	test   %edx,%edx
80100548:	74 06                	je     80100550 <consputc+0x10>
}

static inline void
cli(void)
{
  asm volatile("cli");
8010054a:	fa                   	cli    
8010054b:	eb fe                	jmp    8010054b <consputc+0xb>
8010054d:	8d 76 00             	lea    0x0(%esi),%esi
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
80100550:	55                   	push   %ebp
80100551:	89 e5                	mov    %esp,%ebp
80100553:	53                   	push   %ebx
80100554:	89 c3                	mov    %eax,%ebx
80100556:	83 ec 04             	sub    $0x4,%esp
  if(panicked){
    cli();
    for(;;)
      ;
  }
  if (screencaptured && c != '\n') {
80100559:	a1 f8 b4 10 80       	mov    0x8010b4f8,%eax
8010055e:	85 c0                	test   %eax,%eax
80100560:	74 16                	je     80100578 <consputc+0x38>
80100562:	83 fb 0a             	cmp    $0xa,%ebx
80100565:	74 19                	je     80100580 <consputc+0x40>
    cgaputc(c);
80100567:	89 d8                	mov    %ebx,%eax
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
80100569:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010056c:	c9                   	leave  
    cli();
    for(;;)
      ;
  }
  if (screencaptured && c != '\n') {
    cgaputc(c);
8010056d:	e9 7e fe ff ff       	jmp    801003f0 <cgaputc>
80100572:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    // (handler)(c);
    return;
  }

  if(c == BACKSPACE){
80100578:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010057e:	74 17                	je     80100597 <consputc+0x57>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
80100580:	83 ec 0c             	sub    $0xc,%esp
80100583:	53                   	push   %ebx
80100584:	e8 c7 57 00 00       	call   80105d50 <uartputc>
80100589:	83 c4 10             	add    $0x10,%esp
    cli();
    for(;;)
      ;
  }
  if (screencaptured && c != '\n') {
    cgaputc(c);
8010058c:	89 d8                	mov    %ebx,%eax
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
8010058e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100591:	c9                   	leave  
    cli();
    for(;;)
      ;
  }
  if (screencaptured && c != '\n') {
    cgaputc(c);
80100592:	e9 59 fe ff ff       	jmp    801003f0 <cgaputc>
    // (handler)(c);
    return;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100597:	83 ec 0c             	sub    $0xc,%esp
8010059a:	6a 08                	push   $0x8
8010059c:	e8 af 57 00 00       	call   80105d50 <uartputc>
801005a1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801005a8:	e8 a3 57 00 00       	call   80105d50 <uartputc>
801005ad:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801005b4:	e8 97 57 00 00       	call   80105d50 <uartputc>
801005b9:	83 c4 10             	add    $0x10,%esp
    cli();
    for(;;)
      ;
  }
  if (screencaptured && c != '\n') {
    cgaputc(c);
801005bc:	89 d8                	mov    %ebx,%eax
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
801005be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801005c1:	c9                   	leave  
    cli();
    for(;;)
      ;
  }
  if (screencaptured && c != '\n') {
    cgaputc(c);
801005c2:	e9 29 fe ff ff       	jmp    801003f0 <cgaputc>
801005c7:	89 f6                	mov    %esi,%esi
801005c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801005d0 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
801005d0:	55                   	push   %ebp
801005d1:	89 e5                	mov    %esp,%ebp
801005d3:	57                   	push   %edi
801005d4:	56                   	push   %esi
801005d5:	53                   	push   %ebx
801005d6:	89 d6                	mov    %edx,%esi
801005d8:	83 ec 2c             	sub    $0x2c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
801005db:	85 c9                	test   %ecx,%ecx
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
801005dd:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
801005e0:	74 0c                	je     801005ee <printint+0x1e>
801005e2:	89 c7                	mov    %eax,%edi
801005e4:	c1 ef 1f             	shr    $0x1f,%edi
801005e7:	85 c0                	test   %eax,%eax
801005e9:	89 7d d4             	mov    %edi,-0x2c(%ebp)
801005ec:	78 51                	js     8010063f <printint+0x6f>
    x = -xx;
  else
    x = xx;

  i = 0;
801005ee:	31 ff                	xor    %edi,%edi
801005f0:	8d 5d d7             	lea    -0x29(%ebp),%ebx
801005f3:	eb 05                	jmp    801005fa <printint+0x2a>
801005f5:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
801005f8:	89 cf                	mov    %ecx,%edi
801005fa:	31 d2                	xor    %edx,%edx
801005fc:	8d 4f 01             	lea    0x1(%edi),%ecx
801005ff:	f7 f6                	div    %esi
80100601:	0f b6 92 f0 71 10 80 	movzbl -0x7fef8e10(%edx),%edx
  }while((x /= base) != 0);
80100608:	85 c0                	test   %eax,%eax
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
8010060a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
8010060d:	75 e9                	jne    801005f8 <printint+0x28>

  if(sign)
8010060f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100612:	85 c0                	test   %eax,%eax
80100614:	74 08                	je     8010061e <printint+0x4e>
    buf[i++] = '-';
80100616:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
8010061b:	8d 4f 02             	lea    0x2(%edi),%ecx
8010061e:	8d 74 0d d7          	lea    -0x29(%ebp,%ecx,1),%esi
80100622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  while(--i >= 0)
    consputc(buf[i]);
80100628:	0f be 06             	movsbl (%esi),%eax
8010062b:	83 ee 01             	sub    $0x1,%esi
8010062e:	e8 0d ff ff ff       	call   80100540 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
80100633:	39 de                	cmp    %ebx,%esi
80100635:	75 f1                	jne    80100628 <printint+0x58>
    consputc(buf[i]);
}
80100637:	83 c4 2c             	add    $0x2c,%esp
8010063a:	5b                   	pop    %ebx
8010063b:	5e                   	pop    %esi
8010063c:	5f                   	pop    %edi
8010063d:	5d                   	pop    %ebp
8010063e:	c3                   	ret    
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
8010063f:	f7 d8                	neg    %eax
80100641:	eb ab                	jmp    801005ee <printint+0x1e>
80100643:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100650 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100650:	55                   	push   %ebp
80100651:	89 e5                	mov    %esp,%ebp
80100653:	57                   	push   %edi
80100654:	56                   	push   %esi
80100655:	53                   	push   %ebx
80100656:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100659:	ff 75 08             	pushl  0x8(%ebp)
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
8010065c:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010065f:	e8 ac 12 00 00       	call   80101910 <iunlock>
  acquire(&cons.lock);
80100664:	c7 04 24 c0 b4 10 80 	movl   $0x8010b4c0,(%esp)
8010066b:	e8 f0 3d 00 00       	call   80104460 <acquire>
80100670:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100673:	83 c4 10             	add    $0x10,%esp
80100676:	85 f6                	test   %esi,%esi
80100678:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010067b:	7e 12                	jle    8010068f <consolewrite+0x3f>
8010067d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100680:	0f b6 07             	movzbl (%edi),%eax
80100683:	83 c7 01             	add    $0x1,%edi
80100686:	e8 b5 fe ff ff       	call   80100540 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
8010068b:	39 df                	cmp    %ebx,%edi
8010068d:	75 f1                	jne    80100680 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
8010068f:	83 ec 0c             	sub    $0xc,%esp
80100692:	68 c0 b4 10 80       	push   $0x8010b4c0
80100697:	e8 e4 3e 00 00       	call   80104580 <release>
  ilock(ip);
8010069c:	58                   	pop    %eax
8010069d:	ff 75 08             	pushl  0x8(%ebp)
801006a0:	e8 8b 11 00 00       	call   80101830 <ilock>

  return n;
}
801006a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801006a8:	89 f0                	mov    %esi,%eax
801006aa:	5b                   	pop    %ebx
801006ab:	5e                   	pop    %esi
801006ac:	5f                   	pop    %edi
801006ad:	5d                   	pop    %ebp
801006ae:	c3                   	ret    
801006af:	90                   	nop

801006b0 <cprintf>:
// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{

  if (screencaptured)
801006b0:	8b 15 f8 b4 10 80    	mov    0x8010b4f8,%edx
801006b6:	85 d2                	test   %edx,%edx
801006b8:	0f 85 aa 00 00 00    	jne    80100768 <cprintf+0xb8>
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
801006be:	55                   	push   %ebp
801006bf:	89 e5                	mov    %esp,%ebp
801006c1:	57                   	push   %edi
801006c2:	56                   	push   %esi
801006c3:	53                   	push   %ebx
801006c4:	83 ec 1c             	sub    $0x1c,%esp
    return;
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
801006c7:	a1 f4 b4 10 80       	mov    0x8010b4f4,%eax
  if(locking)
801006cc:	85 c0                	test   %eax,%eax
    return;
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
801006ce:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
801006d1:	0f 85 49 01 00 00    	jne    80100820 <cprintf+0x170>
    acquire(&cons.lock);

  if (fmt == 0)
801006d7:	8b 45 08             	mov    0x8(%ebp),%eax
801006da:	85 c0                	test   %eax,%eax
801006dc:	89 c1                	mov    %eax,%ecx
801006de:	0f 84 51 01 00 00    	je     80100835 <cprintf+0x185>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e4:	0f b6 00             	movzbl (%eax),%eax
801006e7:	31 db                	xor    %ebx,%ebx
801006e9:	8d 75 0c             	lea    0xc(%ebp),%esi
801006ec:	89 cf                	mov    %ecx,%edi
801006ee:	85 c0                	test   %eax,%eax
801006f0:	75 4f                	jne    80100741 <cprintf+0x91>
801006f2:	eb 62                	jmp    80100756 <cprintf+0xa6>
801006f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
801006f8:	83 c3 01             	add    $0x1,%ebx
801006fb:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
    if(c == 0)
801006ff:	85 d2                	test   %edx,%edx
80100701:	74 53                	je     80100756 <cprintf+0xa6>
      break;
    switch(c){
80100703:	83 fa 70             	cmp    $0x70,%edx
80100706:	74 72                	je     8010077a <cprintf+0xca>
80100708:	7f 66                	jg     80100770 <cprintf+0xc0>
8010070a:	83 fa 25             	cmp    $0x25,%edx
8010070d:	0f 84 a5 00 00 00    	je     801007b8 <cprintf+0x108>
80100713:	83 fa 64             	cmp    $0x64,%edx
80100716:	0f 85 7c 00 00 00    	jne    80100798 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
8010071c:	8d 46 04             	lea    0x4(%esi),%eax
8010071f:	b9 01 00 00 00       	mov    $0x1,%ecx
80100724:	ba 0a 00 00 00       	mov    $0xa,%edx
80100729:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010072c:	8b 06                	mov    (%esi),%eax
8010072e:	e8 9d fe ff ff       	call   801005d0 <printint>
80100733:	8b 75 e4             	mov    -0x1c(%ebp),%esi

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100736:	83 c3 01             	add    $0x1,%ebx
80100739:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
8010073d:	85 c0                	test   %eax,%eax
8010073f:	74 15                	je     80100756 <cprintf+0xa6>
    if(c != '%'){
80100741:	83 f8 25             	cmp    $0x25,%eax
80100744:	74 b2                	je     801006f8 <cprintf+0x48>
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
80100746:	e8 f5 fd ff ff       	call   80100540 <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010074b:	83 c3 01             	add    $0x1,%ebx
8010074e:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
80100752:	85 c0                	test   %eax,%eax
80100754:	75 eb                	jne    80100741 <cprintf+0x91>
      consputc(c);
      break;
    }
  }

  if(locking)
80100756:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100759:	85 c0                	test   %eax,%eax
8010075b:	0f 85 9f 00 00 00    	jne    80100800 <cprintf+0x150>
    release(&cons.lock);
}
80100761:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100764:	5b                   	pop    %ebx
80100765:	5e                   	pop    %esi
80100766:	5f                   	pop    %edi
80100767:	5d                   	pop    %ebp
80100768:	f3 c3                	repz ret 
8010076a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
80100770:	83 fa 73             	cmp    $0x73,%edx
80100773:	74 53                	je     801007c8 <cprintf+0x118>
80100775:	83 fa 78             	cmp    $0x78,%edx
80100778:	75 1e                	jne    80100798 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
8010077a:	8d 46 04             	lea    0x4(%esi),%eax
8010077d:	31 c9                	xor    %ecx,%ecx
8010077f:	ba 10 00 00 00       	mov    $0x10,%edx
80100784:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100787:	8b 06                	mov    (%esi),%eax
80100789:	e8 42 fe ff ff       	call   801005d0 <printint>
8010078e:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      break;
80100791:	eb a3                	jmp    80100736 <cprintf+0x86>
80100793:	90                   	nop
80100794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100798:	b8 25 00 00 00       	mov    $0x25,%eax
8010079d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801007a0:	e8 9b fd ff ff       	call   80100540 <consputc>
      consputc(c);
801007a5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801007a8:	89 d0                	mov    %edx,%eax
801007aa:	e8 91 fd ff ff       	call   80100540 <consputc>
      break;
801007af:	eb 85                	jmp    80100736 <cprintf+0x86>
801007b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
801007b8:	b8 25 00 00 00       	mov    $0x25,%eax
801007bd:	e8 7e fd ff ff       	call   80100540 <consputc>
801007c2:	eb 87                	jmp    8010074b <cprintf+0x9b>
801007c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
801007c8:	8d 46 04             	lea    0x4(%esi),%eax
801007cb:	8b 36                	mov    (%esi),%esi
801007cd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        s = "(null)";
801007d0:	b8 d8 71 10 80       	mov    $0x801071d8,%eax
801007d5:	85 f6                	test   %esi,%esi
801007d7:	0f 44 f0             	cmove  %eax,%esi
      for(; *s; s++)
801007da:	0f be 06             	movsbl (%esi),%eax
801007dd:	84 c0                	test   %al,%al
801007df:	74 16                	je     801007f7 <cprintf+0x147>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007e8:	83 c6 01             	add    $0x1,%esi
        consputc(*s);
801007eb:	e8 50 fd ff ff       	call   80100540 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801007f0:	0f be 06             	movsbl (%esi),%eax
801007f3:	84 c0                	test   %al,%al
801007f5:	75 f1                	jne    801007e8 <cprintf+0x138>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
801007f7:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801007fa:	e9 37 ff ff ff       	jmp    80100736 <cprintf+0x86>
801007ff:	90                   	nop
      break;
    }
  }

  if(locking)
    release(&cons.lock);
80100800:	83 ec 0c             	sub    $0xc,%esp
80100803:	68 c0 b4 10 80       	push   $0x8010b4c0
80100808:	e8 73 3d 00 00       	call   80104580 <release>
8010080d:	83 c4 10             	add    $0x10,%esp
}
80100810:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100813:	5b                   	pop    %ebx
80100814:	5e                   	pop    %esi
80100815:	5f                   	pop    %edi
80100816:	5d                   	pop    %ebp
80100817:	e9 4c ff ff ff       	jmp    80100768 <cprintf+0xb8>
8010081c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
80100820:	83 ec 0c             	sub    $0xc,%esp
80100823:	68 c0 b4 10 80       	push   $0x8010b4c0
80100828:	e8 33 3c 00 00       	call   80104460 <acquire>
8010082d:	83 c4 10             	add    $0x10,%esp
80100830:	e9 a2 fe ff ff       	jmp    801006d7 <cprintf+0x27>

  if (fmt == 0)
    panic("null fmt");
80100835:	83 ec 0c             	sub    $0xc,%esp
80100838:	68 df 71 10 80       	push   $0x801071df
8010083d:	e8 2e fb ff ff       	call   80100370 <panic>
80100842:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100850 <capturescreen>:
 * Set the capturescreen to the pid specified,
 * so only that pid can modify the screen.
 * Also clears the screen.
 */
int
capturescreen(int pid, void* func) {
80100850:	55                   	push   %ebp
80100851:	89 e5                	mov    %esp,%ebp
80100853:	53                   	push   %ebx
80100854:	83 ec 10             	sub    $0x10,%esp
  acquire(&cons.lock);
80100857:	68 c0 b4 10 80       	push   $0x8010b4c0
8010085c:	e8 ff 3b 00 00       	call   80104460 <acquire>
  if (screencaptured) {
80100861:	8b 1d f8 b4 10 80    	mov    0x8010b4f8,%ebx
80100867:	83 c4 10             	add    $0x10,%esp
8010086a:	85 db                	test   %ebx,%ebx
8010086c:	75 52                	jne    801008c0 <capturescreen+0x70>
    release(&cons.lock);
    return -1;
  }
  screencaptured = pid;
8010086e:	8b 45 08             	mov    0x8(%ebp),%eax
  handler = func;
  release(&cons.lock);
80100871:	83 ec 0c             	sub    $0xc,%esp
80100874:	68 c0 b4 10 80       	push   $0x8010b4c0
  acquire(&cons.lock);
  if (screencaptured) {
    release(&cons.lock);
    return -1;
  }
  screencaptured = pid;
80100879:	a3 f8 b4 10 80       	mov    %eax,0x8010b4f8
  handler = func;
  release(&cons.lock);
8010087e:	e8 fd 3c 00 00       	call   80104580 <release>
  memmove(crtbackup, crt, sizeof(crt[0])*25*80);
80100883:	83 c4 0c             	add    $0xc,%esp
80100886:	68 a0 0f 00 00       	push   $0xfa0
8010088b:	68 00 80 0b 80       	push   $0x800b8000
80100890:	68 20 a5 10 80       	push   $0x8010a520
80100895:	e8 e6 3d 00 00       	call   80104680 <memmove>
  memset(crt, 0, sizeof(crt[0]) * 25 * 80);
8010089a:	83 c4 0c             	add    $0xc,%esp
8010089d:	68 a0 0f 00 00       	push   $0xfa0
801008a2:	6a 00                	push   $0x0
801008a4:	68 00 80 0b 80       	push   $0x800b8000
801008a9:	e8 22 3d 00 00       	call   801045d0 <memset>
  return 0;
801008ae:	83 c4 10             	add    $0x10,%esp
}
801008b1:	89 d8                	mov    %ebx,%eax
801008b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801008b6:	c9                   	leave  
801008b7:	c3                   	ret    
801008b8:	90                   	nop
801008b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 */
int
capturescreen(int pid, void* func) {
  acquire(&cons.lock);
  if (screencaptured) {
    release(&cons.lock);
801008c0:	83 ec 0c             	sub    $0xc,%esp
    return -1;
801008c3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
 */
int
capturescreen(int pid, void* func) {
  acquire(&cons.lock);
  if (screencaptured) {
    release(&cons.lock);
801008c8:	68 c0 b4 10 80       	push   $0x8010b4c0
801008cd:	e8 ae 3c 00 00       	call   80104580 <release>
    return -1;
801008d2:	83 c4 10             	add    $0x10,%esp
801008d5:	eb da                	jmp    801008b1 <capturescreen+0x61>
801008d7:	89 f6                	mov    %esi,%esi
801008d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801008e0 <freescreen>:
/*
 * Sets the capturescreen to 0 so that
 * other processes can draw on the screen.
 */
int
freescreen(int pid) {
801008e0:	55                   	push   %ebp
801008e1:	89 e5                	mov    %esp,%ebp
801008e3:	83 ec 14             	sub    $0x14,%esp
  acquire(&cons.lock);
801008e6:	68 c0 b4 10 80       	push   $0x8010b4c0
801008eb:	e8 70 3b 00 00       	call   80104460 <acquire>
  if (screencaptured == pid) {
801008f0:	83 c4 10             	add    $0x10,%esp
801008f3:	8b 45 08             	mov    0x8(%ebp),%eax
801008f6:	39 05 f8 b4 10 80    	cmp    %eax,0x8010b4f8
801008fc:	75 3a                	jne    80100938 <freescreen+0x58>
    screencaptured = 0;
    release(&cons.lock);
801008fe:	83 ec 0c             	sub    $0xc,%esp
 */
int
freescreen(int pid) {
  acquire(&cons.lock);
  if (screencaptured == pid) {
    screencaptured = 0;
80100901:	c7 05 f8 b4 10 80 00 	movl   $0x0,0x8010b4f8
80100908:	00 00 00 
    release(&cons.lock);
8010090b:	68 c0 b4 10 80       	push   $0x8010b4c0
80100910:	e8 6b 3c 00 00       	call   80104580 <release>
    memmove(crt, crtbackup, sizeof(crt[0])*25*80);
80100915:	83 c4 0c             	add    $0xc,%esp
80100918:	68 a0 0f 00 00       	push   $0xfa0
8010091d:	68 20 a5 10 80       	push   $0x8010a520
80100922:	68 00 80 0b 80       	push   $0x800b8000
80100927:	e8 54 3d 00 00       	call   80104680 <memmove>
    return 0;
8010092c:	83 c4 10             	add    $0x10,%esp
8010092f:	31 c0                	xor    %eax,%eax
  }
  release(&cons.lock);
  return -1;
}
80100931:	c9                   	leave  
80100932:	c3                   	ret    
80100933:	90                   	nop
80100934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    screencaptured = 0;
    release(&cons.lock);
    memmove(crt, crtbackup, sizeof(crt[0])*25*80);
    return 0;
  }
  release(&cons.lock);
80100938:	83 ec 0c             	sub    $0xc,%esp
8010093b:	68 c0 b4 10 80       	push   $0x8010b4c0
80100940:	e8 3b 3c 00 00       	call   80104580 <release>
  return -1;
80100945:	83 c4 10             	add    $0x10,%esp
80100948:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010094d:	c9                   	leave  
8010094e:	c3                   	ret    
8010094f:	90                   	nop

80100950 <updatescreen>:
int
updatescreen(int pid, int x, int y, char* content, int color) {
80100950:	55                   	push   %ebp
80100951:	89 e5                	mov    %esp,%ebp
80100953:	57                   	push   %edi
80100954:	56                   	push   %esi
  if (pid != screencaptured) {
80100955:	8b 75 08             	mov    0x8(%ebp),%esi
80100958:	39 35 f8 b4 10 80    	cmp    %esi,0x8010b4f8
  }
  release(&cons.lock);
  return -1;
}
int
updatescreen(int pid, int x, int y, char* content, int color) {
8010095e:	53                   	push   %ebx
8010095f:	8b 45 10             	mov    0x10(%ebp),%eax
80100962:	8b 7d 14             	mov    0x14(%ebp),%edi
  if (pid != screencaptured) {
80100965:	75 39                	jne    801009a0 <updatescreen+0x50>
    return -1;
  }
  int initialpos = x + 80*y;
  char c;
  int i;
  for(i = 0; (c = content[i]) != 0; i++) {
80100967:	0f b6 17             	movzbl (%edi),%edx
int
updatescreen(int pid, int x, int y, char* content, int color) {
  if (pid != screencaptured) {
    return -1;
  }
  int initialpos = x + 80*y;
8010096a:	8d 1c 80             	lea    (%eax,%eax,4),%ebx
8010096d:	c1 e3 04             	shl    $0x4,%ebx
80100970:	03 5d 0c             	add    0xc(%ebp),%ebx
  char c;
  int i;
  for(i = 0; (c = content[i]) != 0; i++) {
80100973:	84 d2                	test   %dl,%dl
80100975:	74 30                	je     801009a7 <updatescreen+0x57>
80100977:	0f b7 75 18          	movzwl 0x18(%ebp),%esi
8010097b:	31 c0                	xor    %eax,%eax
8010097d:	c1 e6 08             	shl    $0x8,%esi
    // crt[initialpos+i] = (color<<8) || c;
    crt[initialpos + i] = (c&0xff) | (color<<8);
80100980:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
80100983:	09 f2                	or     %esi,%edx
    return -1;
  }
  int initialpos = x + 80*y;
  char c;
  int i;
  for(i = 0; (c = content[i]) != 0; i++) {
80100985:	83 c0 01             	add    $0x1,%eax
    // crt[initialpos+i] = (color<<8) || c;
    crt[initialpos + i] = (c&0xff) | (color<<8);
80100988:	66 89 94 09 00 80 0b 	mov    %dx,-0x7ff48000(%ecx,%ecx,1)
8010098f:	80 
    return -1;
  }
  int initialpos = x + 80*y;
  char c;
  int i;
  for(i = 0; (c = content[i]) != 0; i++) {
80100990:	0f b6 14 07          	movzbl (%edi,%eax,1),%edx
80100994:	84 d2                	test   %dl,%dl
80100996:	75 e8                	jne    80100980 <updatescreen+0x30>
    // crt[initialpos+i] = (color<<8) || c;
    crt[initialpos + i] = (c&0xff) | (color<<8);
  }
  return i;
}
80100998:	5b                   	pop    %ebx
80100999:	5e                   	pop    %esi
8010099a:	5f                   	pop    %edi
8010099b:	5d                   	pop    %ebp
8010099c:	c3                   	ret    
8010099d:	8d 76 00             	lea    0x0(%esi),%esi
  return -1;
}
int
updatescreen(int pid, int x, int y, char* content, int color) {
  if (pid != screencaptured) {
    return -1;
801009a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801009a5:	eb f1                	jmp    80100998 <updatescreen+0x48>
  }
  int initialpos = x + 80*y;
  char c;
  int i;
  for(i = 0; (c = content[i]) != 0; i++) {
801009a7:	31 c0                	xor    %eax,%eax
801009a9:	eb ed                	jmp    80100998 <updatescreen+0x48>
801009ab:	90                   	nop
801009ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009b0 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801009b0:	55                   	push   %ebp
801009b1:	89 e5                	mov    %esp,%ebp
801009b3:	57                   	push   %edi
801009b4:	56                   	push   %esi
801009b5:	53                   	push   %ebx
  int c, doprocdump = 0;
801009b6:	31 f6                	xor    %esi,%esi

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801009b8:	83 ec 18             	sub    $0x18,%esp
801009bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c, doprocdump = 0;

  acquire(&cons.lock);
801009be:	68 c0 b4 10 80       	push   $0x8010b4c0
801009c3:	e8 98 3a 00 00       	call   80104460 <acquire>
  while((c = getc()) >= 0){
801009c8:	83 c4 10             	add    $0x10,%esp
801009cb:	90                   	nop
801009cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801009d0:	ff d3                	call   *%ebx
801009d2:	85 c0                	test   %eax,%eax
801009d4:	89 c7                	mov    %eax,%edi
801009d6:	78 48                	js     80100a20 <consoleintr+0x70>
    switch(c){
801009d8:	83 ff 10             	cmp    $0x10,%edi
801009db:	0f 84 3f 01 00 00    	je     80100b20 <consoleintr+0x170>
801009e1:	7e 5d                	jle    80100a40 <consoleintr+0x90>
801009e3:	83 ff 15             	cmp    $0x15,%edi
801009e6:	0f 84 dc 00 00 00    	je     80100ac8 <consoleintr+0x118>
801009ec:	83 ff 7f             	cmp    $0x7f,%edi
801009ef:	75 54                	jne    80100a45 <consoleintr+0x95>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
801009f1:	a1 48 0f 11 80       	mov    0x80110f48,%eax
801009f6:	3b 05 44 0f 11 80    	cmp    0x80110f44,%eax
801009fc:	74 d2                	je     801009d0 <consoleintr+0x20>
        input.e--;
801009fe:	83 e8 01             	sub    $0x1,%eax
80100a01:	a3 48 0f 11 80       	mov    %eax,0x80110f48
        consputc(BACKSPACE);
80100a06:	b8 00 01 00 00       	mov    $0x100,%eax
80100a0b:	e8 30 fb ff ff       	call   80100540 <consputc>
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
80100a10:	ff d3                	call   *%ebx
80100a12:	85 c0                	test   %eax,%eax
80100a14:	89 c7                	mov    %eax,%edi
80100a16:	79 c0                	jns    801009d8 <consoleintr+0x28>
80100a18:	90                   	nop
80100a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100a20:	83 ec 0c             	sub    $0xc,%esp
80100a23:	68 c0 b4 10 80       	push   $0x8010b4c0
80100a28:	e8 53 3b 00 00       	call   80104580 <release>
  if(doprocdump) {
80100a2d:	83 c4 10             	add    $0x10,%esp
80100a30:	85 f6                	test   %esi,%esi
80100a32:	0f 85 f8 00 00 00    	jne    80100b30 <consoleintr+0x180>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100a38:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a3b:	5b                   	pop    %ebx
80100a3c:	5e                   	pop    %esi
80100a3d:	5f                   	pop    %edi
80100a3e:	5d                   	pop    %ebp
80100a3f:	c3                   	ret    
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
80100a40:	83 ff 08             	cmp    $0x8,%edi
80100a43:	74 ac                	je     801009f1 <consoleintr+0x41>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100a45:	85 ff                	test   %edi,%edi
80100a47:	74 87                	je     801009d0 <consoleintr+0x20>
80100a49:	a1 48 0f 11 80       	mov    0x80110f48,%eax
80100a4e:	89 c2                	mov    %eax,%edx
80100a50:	2b 15 40 0f 11 80    	sub    0x80110f40,%edx
80100a56:	83 fa 7f             	cmp    $0x7f,%edx
80100a59:	0f 87 71 ff ff ff    	ja     801009d0 <consoleintr+0x20>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
80100a5f:	8d 50 01             	lea    0x1(%eax),%edx
80100a62:	83 e0 7f             	and    $0x7f,%eax
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
80100a65:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
80100a68:	89 15 48 0f 11 80    	mov    %edx,0x80110f48
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
80100a6e:	0f 84 c8 00 00 00    	je     80100b3c <consoleintr+0x18c>
        input.buf[input.e++ % INPUT_BUF] = c;
80100a74:	89 f9                	mov    %edi,%ecx
80100a76:	88 88 c0 0e 11 80    	mov    %cl,-0x7feef140(%eax)
        consputc(c);
80100a7c:	89 f8                	mov    %edi,%eax
80100a7e:	e8 bd fa ff ff       	call   80100540 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100a83:	83 ff 0a             	cmp    $0xa,%edi
80100a86:	0f 84 c1 00 00 00    	je     80100b4d <consoleintr+0x19d>
80100a8c:	83 ff 04             	cmp    $0x4,%edi
80100a8f:	0f 84 b8 00 00 00    	je     80100b4d <consoleintr+0x19d>
80100a95:	a1 40 0f 11 80       	mov    0x80110f40,%eax
80100a9a:	83 e8 80             	sub    $0xffffff80,%eax
80100a9d:	39 05 48 0f 11 80    	cmp    %eax,0x80110f48
80100aa3:	0f 85 27 ff ff ff    	jne    801009d0 <consoleintr+0x20>
          input.w = input.e;
          wakeup(&input.r);
80100aa9:	83 ec 0c             	sub    $0xc,%esp
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
80100aac:	a3 44 0f 11 80       	mov    %eax,0x80110f44
          wakeup(&input.r);
80100ab1:	68 40 0f 11 80       	push   $0x80110f40
80100ab6:	e8 e5 35 00 00       	call   801040a0 <wakeup>
80100abb:	83 c4 10             	add    $0x10,%esp
80100abe:	e9 0d ff ff ff       	jmp    801009d0 <consoleintr+0x20>
80100ac3:	90                   	nop
80100ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100ac8:	a1 48 0f 11 80       	mov    0x80110f48,%eax
80100acd:	39 05 44 0f 11 80    	cmp    %eax,0x80110f44
80100ad3:	75 2b                	jne    80100b00 <consoleintr+0x150>
80100ad5:	e9 f6 fe ff ff       	jmp    801009d0 <consoleintr+0x20>
80100ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100ae0:	a3 48 0f 11 80       	mov    %eax,0x80110f48
        consputc(BACKSPACE);
80100ae5:	b8 00 01 00 00       	mov    $0x100,%eax
80100aea:	e8 51 fa ff ff       	call   80100540 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100aef:	a1 48 0f 11 80       	mov    0x80110f48,%eax
80100af4:	3b 05 44 0f 11 80    	cmp    0x80110f44,%eax
80100afa:	0f 84 d0 fe ff ff    	je     801009d0 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100b00:	83 e8 01             	sub    $0x1,%eax
80100b03:	89 c2                	mov    %eax,%edx
80100b05:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100b08:	80 ba c0 0e 11 80 0a 	cmpb   $0xa,-0x7feef140(%edx)
80100b0f:	75 cf                	jne    80100ae0 <consoleintr+0x130>
80100b11:	e9 ba fe ff ff       	jmp    801009d0 <consoleintr+0x20>
80100b16:	8d 76 00             	lea    0x0(%esi),%esi
80100b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
80100b20:	be 01 00 00 00       	mov    $0x1,%esi
80100b25:	e9 a6 fe ff ff       	jmp    801009d0 <consoleintr+0x20>
80100b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100b30:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100b33:	5b                   	pop    %ebx
80100b34:	5e                   	pop    %esi
80100b35:	5f                   	pop    %edi
80100b36:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
80100b37:	e9 54 36 00 00       	jmp    80104190 <procdump>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
80100b3c:	c6 80 c0 0e 11 80 0a 	movb   $0xa,-0x7feef140(%eax)
        consputc(c);
80100b43:	b8 0a 00 00 00       	mov    $0xa,%eax
80100b48:	e8 f3 f9 ff ff       	call   80100540 <consputc>
80100b4d:	a1 48 0f 11 80       	mov    0x80110f48,%eax
80100b52:	e9 52 ff ff ff       	jmp    80100aa9 <consoleintr+0xf9>
80100b57:	89 f6                	mov    %esi,%esi
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
80100b66:	68 e8 71 10 80       	push   $0x801071e8
80100b6b:	68 c0 b4 10 80       	push   $0x8010b4c0
80100b70:	e8 eb 37 00 00       	call   80104360 <initlock>

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
80100b7b:	c7 05 0c 19 11 80 50 	movl   $0x80100650,0x8011190c
80100b82:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100b85:	c7 05 08 19 11 80 70 	movl   $0x80100270,0x80111908
80100b8c:	02 10 80 
  cons.locking = 1;
80100b8f:	c7 05 f4 b4 10 80 01 	movl   $0x1,0x8010b4f4
80100b96:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
80100b99:	e8 c2 18 00 00       	call   80102460 <ioapicenable>
80100b9e:	83 c4 10             	add    $0x10,%esp
80100ba1:	c9                   	leave  
80100ba2:	c3                   	ret    
80100ba3:	66 90                	xchg   %ax,%ax
80100ba5:	66 90                	xchg   %ax,%ax
80100ba7:	66 90                	xchg   %ax,%ax
80100ba9:	66 90                	xchg   %ax,%ax
80100bab:	66 90                	xchg   %ax,%ax
80100bad:	66 90                	xchg   %ax,%ax
80100baf:	90                   	nop

80100bb0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100bb0:	55                   	push   %ebp
80100bb1:	89 e5                	mov    %esp,%ebp
80100bb3:	57                   	push   %edi
80100bb4:	56                   	push   %esi
80100bb5:	53                   	push   %ebx
80100bb6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100bbc:	e8 7f 2d 00 00       	call   80103940 <myproc>
80100bc1:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100bc7:	e8 44 21 00 00       	call   80102d10 <begin_op>

  if((ip = namei(path)) == 0){
80100bcc:	83 ec 0c             	sub    $0xc,%esp
80100bcf:	ff 75 08             	pushl  0x8(%ebp)
80100bd2:	e8 a9 14 00 00       	call   80102080 <namei>
80100bd7:	83 c4 10             	add    $0x10,%esp
80100bda:	85 c0                	test   %eax,%eax
80100bdc:	0f 84 9c 01 00 00    	je     80100d7e <exec+0x1ce>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100be2:	83 ec 0c             	sub    $0xc,%esp
80100be5:	89 c3                	mov    %eax,%ebx
80100be7:	50                   	push   %eax
80100be8:	e8 43 0c 00 00       	call   80101830 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100bed:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100bf3:	6a 34                	push   $0x34
80100bf5:	6a 00                	push   $0x0
80100bf7:	50                   	push   %eax
80100bf8:	53                   	push   %ebx
80100bf9:	e8 12 0f 00 00       	call   80101b10 <readi>
80100bfe:	83 c4 20             	add    $0x20,%esp
80100c01:	83 f8 34             	cmp    $0x34,%eax
80100c04:	74 22                	je     80100c28 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100c06:	83 ec 0c             	sub    $0xc,%esp
80100c09:	53                   	push   %ebx
80100c0a:	e8 b1 0e 00 00       	call   80101ac0 <iunlockput>
    end_op();
80100c0f:	e8 6c 21 00 00       	call   80102d80 <end_op>
80100c14:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100c17:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100c1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100c1f:	5b                   	pop    %ebx
80100c20:	5e                   	pop    %esi
80100c21:	5f                   	pop    %edi
80100c22:	5d                   	pop    %ebp
80100c23:	c3                   	ret    
80100c24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100c28:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100c2f:	45 4c 46 
80100c32:	75 d2                	jne    80100c06 <exec+0x56>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100c34:	e8 a7 62 00 00       	call   80106ee0 <setupkvm>
80100c39:	85 c0                	test   %eax,%eax
80100c3b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100c41:	74 c3                	je     80100c06 <exec+0x56>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c43:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100c4a:	00 
80100c4b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100c51:	c7 85 ec fe ff ff 00 	movl   $0x0,-0x114(%ebp)
80100c58:	00 00 00 
80100c5b:	0f 84 c5 00 00 00    	je     80100d26 <exec+0x176>
80100c61:	31 ff                	xor    %edi,%edi
80100c63:	eb 18                	jmp    80100c7d <exec+0xcd>
80100c65:	8d 76 00             	lea    0x0(%esi),%esi
80100c68:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100c6f:	83 c7 01             	add    $0x1,%edi
80100c72:	83 c6 20             	add    $0x20,%esi
80100c75:	39 f8                	cmp    %edi,%eax
80100c77:	0f 8e a9 00 00 00    	jle    80100d26 <exec+0x176>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100c7d:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100c83:	6a 20                	push   $0x20
80100c85:	56                   	push   %esi
80100c86:	50                   	push   %eax
80100c87:	53                   	push   %ebx
80100c88:	e8 83 0e 00 00       	call   80101b10 <readi>
80100c8d:	83 c4 10             	add    $0x10,%esp
80100c90:	83 f8 20             	cmp    $0x20,%eax
80100c93:	75 7b                	jne    80100d10 <exec+0x160>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100c95:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100c9c:	75 ca                	jne    80100c68 <exec+0xb8>
      continue;
    if(ph.memsz < ph.filesz)
80100c9e:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ca4:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100caa:	72 64                	jb     80100d10 <exec+0x160>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100cac:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100cb2:	72 5c                	jb     80100d10 <exec+0x160>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100cb4:	83 ec 04             	sub    $0x4,%esp
80100cb7:	50                   	push   %eax
80100cb8:	ff b5 ec fe ff ff    	pushl  -0x114(%ebp)
80100cbe:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100cc4:	e8 67 60 00 00       	call   80106d30 <allocuvm>
80100cc9:	83 c4 10             	add    $0x10,%esp
80100ccc:	85 c0                	test   %eax,%eax
80100cce:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100cd4:	74 3a                	je     80100d10 <exec+0x160>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100cd6:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100cdc:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100ce1:	75 2d                	jne    80100d10 <exec+0x160>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100ce3:	83 ec 0c             	sub    $0xc,%esp
80100ce6:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100cec:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100cf2:	53                   	push   %ebx
80100cf3:	50                   	push   %eax
80100cf4:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100cfa:	e8 71 5f 00 00       	call   80106c70 <loaduvm>
80100cff:	83 c4 20             	add    $0x20,%esp
80100d02:	85 c0                	test   %eax,%eax
80100d04:	0f 89 5e ff ff ff    	jns    80100c68 <exec+0xb8>
80100d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100d10:	83 ec 0c             	sub    $0xc,%esp
80100d13:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100d19:	e8 42 61 00 00       	call   80106e60 <freevm>
80100d1e:	83 c4 10             	add    $0x10,%esp
80100d21:	e9 e0 fe ff ff       	jmp    80100c06 <exec+0x56>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100d26:	83 ec 0c             	sub    $0xc,%esp
80100d29:	53                   	push   %ebx
80100d2a:	e8 91 0d 00 00       	call   80101ac0 <iunlockput>
  end_op();
80100d2f:	e8 4c 20 00 00       	call   80102d80 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100d34:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d3a:	83 c4 0c             	add    $0xc,%esp
  end_op();
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100d3d:	05 ff 0f 00 00       	add    $0xfff,%eax
80100d42:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d47:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100d4d:	52                   	push   %edx
80100d4e:	50                   	push   %eax
80100d4f:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100d55:	e8 d6 5f 00 00       	call   80106d30 <allocuvm>
80100d5a:	83 c4 10             	add    $0x10,%esp
80100d5d:	85 c0                	test   %eax,%eax
80100d5f:	89 c6                	mov    %eax,%esi
80100d61:	75 3a                	jne    80100d9d <exec+0x1ed>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100d63:	83 ec 0c             	sub    $0xc,%esp
80100d66:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100d6c:	e8 ef 60 00 00       	call   80106e60 <freevm>
80100d71:	83 c4 10             	add    $0x10,%esp
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100d74:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100d79:	e9 9e fe ff ff       	jmp    80100c1c <exec+0x6c>
  struct proc *curproc = myproc();

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
80100d7e:	e8 fd 1f 00 00       	call   80102d80 <end_op>
    cprintf("exec: fail\n");
80100d83:	83 ec 0c             	sub    $0xc,%esp
80100d86:	68 01 72 10 80       	push   $0x80107201
80100d8b:	e8 20 f9 ff ff       	call   801006b0 <cprintf>
    return -1;
80100d90:	83 c4 10             	add    $0x10,%esp
80100d93:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100d98:	e9 7f fe ff ff       	jmp    80100c1c <exec+0x6c>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d9d:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100da3:	83 ec 08             	sub    $0x8,%esp
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100da6:	31 ff                	xor    %edi,%edi
80100da8:	89 f3                	mov    %esi,%ebx
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100daa:	50                   	push   %eax
80100dab:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100db1:	e8 ca 61 00 00       	call   80106f80 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100db6:	8b 45 0c             	mov    0xc(%ebp),%eax
80100db9:	83 c4 10             	add    $0x10,%esp
80100dbc:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100dc2:	8b 00                	mov    (%eax),%eax
80100dc4:	85 c0                	test   %eax,%eax
80100dc6:	74 79                	je     80100e41 <exec+0x291>
80100dc8:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100dce:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100dd4:	eb 13                	jmp    80100de9 <exec+0x239>
80100dd6:	8d 76 00             	lea    0x0(%esi),%esi
80100dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(argc >= MAXARG)
80100de0:	83 ff 20             	cmp    $0x20,%edi
80100de3:	0f 84 7a ff ff ff    	je     80100d63 <exec+0x1b3>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100de9:	83 ec 0c             	sub    $0xc,%esp
80100dec:	50                   	push   %eax
80100ded:	e8 1e 3a 00 00       	call   80104810 <strlen>
80100df2:	f7 d0                	not    %eax
80100df4:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100df6:	8b 45 0c             	mov    0xc(%ebp),%eax
80100df9:	5a                   	pop    %edx

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100dfa:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100dfd:	ff 34 b8             	pushl  (%eax,%edi,4)
80100e00:	e8 0b 3a 00 00       	call   80104810 <strlen>
80100e05:	83 c0 01             	add    $0x1,%eax
80100e08:	50                   	push   %eax
80100e09:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e0c:	ff 34 b8             	pushl  (%eax,%edi,4)
80100e0f:	53                   	push   %ebx
80100e10:	56                   	push   %esi
80100e11:	e8 ca 62 00 00       	call   801070e0 <copyout>
80100e16:	83 c4 20             	add    $0x20,%esp
80100e19:	85 c0                	test   %eax,%eax
80100e1b:	0f 88 42 ff ff ff    	js     80100d63 <exec+0x1b3>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100e21:	8b 45 0c             	mov    0xc(%ebp),%eax
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100e24:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100e2b:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100e2e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100e34:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100e37:	85 c0                	test   %eax,%eax
80100e39:	75 a5                	jne    80100de0 <exec+0x230>
80100e3b:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e41:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100e48:	89 d9                	mov    %ebx,%ecx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100e4a:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100e51:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100e55:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100e5c:	ff ff ff 
  ustack[1] = argc;
80100e5f:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e65:	29 c1                	sub    %eax,%ecx

  sp -= (3+argc+1) * 4;
80100e67:	83 c0 0c             	add    $0xc,%eax
80100e6a:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e6c:	50                   	push   %eax
80100e6d:	52                   	push   %edx
80100e6e:	53                   	push   %ebx
80100e6f:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e75:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e7b:	e8 60 62 00 00       	call   801070e0 <copyout>
80100e80:	83 c4 10             	add    $0x10,%esp
80100e83:	85 c0                	test   %eax,%eax
80100e85:	0f 88 d8 fe ff ff    	js     80100d63 <exec+0x1b3>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e8b:	8b 45 08             	mov    0x8(%ebp),%eax
80100e8e:	0f b6 10             	movzbl (%eax),%edx
80100e91:	84 d2                	test   %dl,%dl
80100e93:	74 19                	je     80100eae <exec+0x2fe>
80100e95:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100e98:	83 c0 01             	add    $0x1,%eax
    if(*s == '/')
      last = s+1;
80100e9b:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e9e:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
80100ea1:	0f 44 c8             	cmove  %eax,%ecx
80100ea4:	83 c0 01             	add    $0x1,%eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ea7:	84 d2                	test   %dl,%dl
80100ea9:	75 f0                	jne    80100e9b <exec+0x2eb>
80100eab:	89 4d 08             	mov    %ecx,0x8(%ebp)
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100eae:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100eb4:	50                   	push   %eax
80100eb5:	6a 10                	push   $0x10
80100eb7:	ff 75 08             	pushl  0x8(%ebp)
80100eba:	89 f8                	mov    %edi,%eax
80100ebc:	83 c0 6c             	add    $0x6c,%eax
80100ebf:	50                   	push   %eax
80100ec0:	e8 0b 39 00 00       	call   801047d0 <safestrcpy>

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100ec5:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100ecb:	89 f8                	mov    %edi,%eax
80100ecd:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->pgdir = pgdir;
  curproc->sz = sz;
80100ed0:	89 30                	mov    %esi,(%eax)
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100ed2:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->sz = sz;
  curproc->tf->eip = elf.entry;  // main
80100ed5:	89 c1                	mov    %eax,%ecx
80100ed7:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100edd:	8b 40 18             	mov    0x18(%eax),%eax
80100ee0:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100ee3:	8b 41 18             	mov    0x18(%ecx),%eax
80100ee6:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100ee9:	89 0c 24             	mov    %ecx,(%esp)
80100eec:	e8 ef 5b 00 00       	call   80106ae0 <switchuvm>
  freevm(oldpgdir);
80100ef1:	89 3c 24             	mov    %edi,(%esp)
80100ef4:	e8 67 5f 00 00       	call   80106e60 <freevm>
  return 0;
80100ef9:	83 c4 10             	add    $0x10,%esp
80100efc:	31 c0                	xor    %eax,%eax
80100efe:	e9 19 fd ff ff       	jmp    80100c1c <exec+0x6c>
80100f03:	66 90                	xchg   %ax,%ax
80100f05:	66 90                	xchg   %ax,%ax
80100f07:	66 90                	xchg   %ax,%ax
80100f09:	66 90                	xchg   %ax,%ax
80100f0b:	66 90                	xchg   %ax,%ax
80100f0d:	66 90                	xchg   %ax,%ax
80100f0f:	90                   	nop

80100f10 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100f10:	55                   	push   %ebp
80100f11:	89 e5                	mov    %esp,%ebp
80100f13:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100f16:	68 0d 72 10 80       	push   $0x8010720d
80100f1b:	68 60 0f 11 80       	push   $0x80110f60
80100f20:	e8 3b 34 00 00       	call   80104360 <initlock>
}
80100f25:	83 c4 10             	add    $0x10,%esp
80100f28:	c9                   	leave  
80100f29:	c3                   	ret    
80100f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100f30 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f30:	55                   	push   %ebp
80100f31:	89 e5                	mov    %esp,%ebp
80100f33:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f34:	bb 94 0f 11 80       	mov    $0x80110f94,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f39:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
80100f3c:	68 60 0f 11 80       	push   $0x80110f60
80100f41:	e8 1a 35 00 00       	call   80104460 <acquire>
80100f46:	83 c4 10             	add    $0x10,%esp
80100f49:	eb 10                	jmp    80100f5b <filealloc+0x2b>
80100f4b:	90                   	nop
80100f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f50:	83 c3 18             	add    $0x18,%ebx
80100f53:	81 fb f4 18 11 80    	cmp    $0x801118f4,%ebx
80100f59:	74 25                	je     80100f80 <filealloc+0x50>
    if(f->ref == 0){
80100f5b:	8b 43 04             	mov    0x4(%ebx),%eax
80100f5e:	85 c0                	test   %eax,%eax
80100f60:	75 ee                	jne    80100f50 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100f62:	83 ec 0c             	sub    $0xc,%esp
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
80100f65:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100f6c:	68 60 0f 11 80       	push   $0x80110f60
80100f71:	e8 0a 36 00 00       	call   80104580 <release>
      return f;
80100f76:	89 d8                	mov    %ebx,%eax
80100f78:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ftable.lock);
  return 0;
}
80100f7b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f7e:	c9                   	leave  
80100f7f:	c3                   	ret    
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100f80:	83 ec 0c             	sub    $0xc,%esp
80100f83:	68 60 0f 11 80       	push   $0x80110f60
80100f88:	e8 f3 35 00 00       	call   80104580 <release>
  return 0;
80100f8d:	83 c4 10             	add    $0x10,%esp
80100f90:	31 c0                	xor    %eax,%eax
}
80100f92:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f95:	c9                   	leave  
80100f96:	c3                   	ret    
80100f97:	89 f6                	mov    %esi,%esi
80100f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100fa0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100fa0:	55                   	push   %ebp
80100fa1:	89 e5                	mov    %esp,%ebp
80100fa3:	53                   	push   %ebx
80100fa4:	83 ec 10             	sub    $0x10,%esp
80100fa7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100faa:	68 60 0f 11 80       	push   $0x80110f60
80100faf:	e8 ac 34 00 00       	call   80104460 <acquire>
  if(f->ref < 1)
80100fb4:	8b 43 04             	mov    0x4(%ebx),%eax
80100fb7:	83 c4 10             	add    $0x10,%esp
80100fba:	85 c0                	test   %eax,%eax
80100fbc:	7e 1a                	jle    80100fd8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100fbe:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100fc1:	83 ec 0c             	sub    $0xc,%esp
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  f->ref++;
80100fc4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100fc7:	68 60 0f 11 80       	push   $0x80110f60
80100fcc:	e8 af 35 00 00       	call   80104580 <release>
  return f;
}
80100fd1:	89 d8                	mov    %ebx,%eax
80100fd3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fd6:	c9                   	leave  
80100fd7:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80100fd8:	83 ec 0c             	sub    $0xc,%esp
80100fdb:	68 14 72 10 80       	push   $0x80107214
80100fe0:	e8 8b f3 ff ff       	call   80100370 <panic>
80100fe5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100ff0 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100ff0:	55                   	push   %ebp
80100ff1:	89 e5                	mov    %esp,%ebp
80100ff3:	57                   	push   %edi
80100ff4:	56                   	push   %esi
80100ff5:	53                   	push   %ebx
80100ff6:	83 ec 28             	sub    $0x28,%esp
80100ff9:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100ffc:	68 60 0f 11 80       	push   $0x80110f60
80101001:	e8 5a 34 00 00       	call   80104460 <acquire>
  if(f->ref < 1)
80101006:	8b 47 04             	mov    0x4(%edi),%eax
80101009:	83 c4 10             	add    $0x10,%esp
8010100c:	85 c0                	test   %eax,%eax
8010100e:	0f 8e 9b 00 00 00    	jle    801010af <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80101014:	83 e8 01             	sub    $0x1,%eax
80101017:	85 c0                	test   %eax,%eax
80101019:	89 47 04             	mov    %eax,0x4(%edi)
8010101c:	74 1a                	je     80101038 <fileclose+0x48>
    release(&ftable.lock);
8010101e:	c7 45 08 60 0f 11 80 	movl   $0x80110f60,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80101025:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101028:	5b                   	pop    %ebx
80101029:	5e                   	pop    %esi
8010102a:	5f                   	pop    %edi
8010102b:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
8010102c:	e9 4f 35 00 00       	jmp    80104580 <release>
80101031:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
80101038:	0f b6 47 09          	movzbl 0x9(%edi),%eax
8010103c:	8b 1f                	mov    (%edi),%ebx
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
8010103e:	83 ec 0c             	sub    $0xc,%esp
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80101041:	8b 77 0c             	mov    0xc(%edi),%esi
  f->ref = 0;
  f->type = FD_NONE;
80101044:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
8010104a:	88 45 e7             	mov    %al,-0x19(%ebp)
8010104d:	8b 47 10             	mov    0x10(%edi),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101050:	68 60 0f 11 80       	push   $0x80110f60
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80101055:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101058:	e8 23 35 00 00       	call   80104580 <release>

  if(ff.type == FD_PIPE)
8010105d:	83 c4 10             	add    $0x10,%esp
80101060:	83 fb 01             	cmp    $0x1,%ebx
80101063:	74 13                	je     80101078 <fileclose+0x88>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80101065:	83 fb 02             	cmp    $0x2,%ebx
80101068:	74 26                	je     80101090 <fileclose+0xa0>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
8010106a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010106d:	5b                   	pop    %ebx
8010106e:	5e                   	pop    %esi
8010106f:	5f                   	pop    %edi
80101070:	5d                   	pop    %ebp
80101071:	c3                   	ret    
80101072:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80101078:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
8010107c:	83 ec 08             	sub    $0x8,%esp
8010107f:	53                   	push   %ebx
80101080:	56                   	push   %esi
80101081:	e8 2a 24 00 00       	call   801034b0 <pipeclose>
80101086:	83 c4 10             	add    $0x10,%esp
80101089:	eb df                	jmp    8010106a <fileclose+0x7a>
8010108b:	90                   	nop
8010108c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80101090:	e8 7b 1c 00 00       	call   80102d10 <begin_op>
    iput(ff.ip);
80101095:	83 ec 0c             	sub    $0xc,%esp
80101098:	ff 75 e0             	pushl  -0x20(%ebp)
8010109b:	e8 c0 08 00 00       	call   80101960 <iput>
    end_op();
801010a0:	83 c4 10             	add    $0x10,%esp
  }
}
801010a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010a6:	5b                   	pop    %ebx
801010a7:	5e                   	pop    %esi
801010a8:	5f                   	pop    %edi
801010a9:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
801010aa:	e9 d1 1c 00 00       	jmp    80102d80 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
801010af:	83 ec 0c             	sub    $0xc,%esp
801010b2:	68 1c 72 10 80       	push   $0x8010721c
801010b7:	e8 b4 f2 ff ff       	call   80100370 <panic>
801010bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801010c0 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
801010c0:	55                   	push   %ebp
801010c1:	89 e5                	mov    %esp,%ebp
801010c3:	53                   	push   %ebx
801010c4:	83 ec 04             	sub    $0x4,%esp
801010c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
801010ca:	83 3b 02             	cmpl   $0x2,(%ebx)
801010cd:	75 31                	jne    80101100 <filestat+0x40>
    ilock(f->ip);
801010cf:	83 ec 0c             	sub    $0xc,%esp
801010d2:	ff 73 10             	pushl  0x10(%ebx)
801010d5:	e8 56 07 00 00       	call   80101830 <ilock>
    stati(f->ip, st);
801010da:	58                   	pop    %eax
801010db:	5a                   	pop    %edx
801010dc:	ff 75 0c             	pushl  0xc(%ebp)
801010df:	ff 73 10             	pushl  0x10(%ebx)
801010e2:	e8 f9 09 00 00       	call   80101ae0 <stati>
    iunlock(f->ip);
801010e7:	59                   	pop    %ecx
801010e8:	ff 73 10             	pushl  0x10(%ebx)
801010eb:	e8 20 08 00 00       	call   80101910 <iunlock>
    return 0;
801010f0:	83 c4 10             	add    $0x10,%esp
801010f3:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
801010f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801010f8:	c9                   	leave  
801010f9:	c3                   	ret    
801010fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80101100:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101105:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101108:	c9                   	leave  
80101109:	c3                   	ret    
8010110a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101110 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101110:	55                   	push   %ebp
80101111:	89 e5                	mov    %esp,%ebp
80101113:	57                   	push   %edi
80101114:	56                   	push   %esi
80101115:	53                   	push   %ebx
80101116:	83 ec 0c             	sub    $0xc,%esp
80101119:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010111c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010111f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101122:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101126:	74 60                	je     80101188 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101128:	8b 03                	mov    (%ebx),%eax
8010112a:	83 f8 01             	cmp    $0x1,%eax
8010112d:	74 41                	je     80101170 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010112f:	83 f8 02             	cmp    $0x2,%eax
80101132:	75 5b                	jne    8010118f <fileread+0x7f>
    ilock(f->ip);
80101134:	83 ec 0c             	sub    $0xc,%esp
80101137:	ff 73 10             	pushl  0x10(%ebx)
8010113a:	e8 f1 06 00 00       	call   80101830 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010113f:	57                   	push   %edi
80101140:	ff 73 14             	pushl  0x14(%ebx)
80101143:	56                   	push   %esi
80101144:	ff 73 10             	pushl  0x10(%ebx)
80101147:	e8 c4 09 00 00       	call   80101b10 <readi>
8010114c:	83 c4 20             	add    $0x20,%esp
8010114f:	85 c0                	test   %eax,%eax
80101151:	89 c6                	mov    %eax,%esi
80101153:	7e 03                	jle    80101158 <fileread+0x48>
      f->off += r;
80101155:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101158:	83 ec 0c             	sub    $0xc,%esp
8010115b:	ff 73 10             	pushl  0x10(%ebx)
8010115e:	e8 ad 07 00 00       	call   80101910 <iunlock>
    return r;
80101163:	83 c4 10             	add    $0x10,%esp
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101166:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80101168:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010116b:	5b                   	pop    %ebx
8010116c:	5e                   	pop    %esi
8010116d:	5f                   	pop    %edi
8010116e:	5d                   	pop    %ebp
8010116f:	c3                   	ret    
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80101170:	8b 43 0c             	mov    0xc(%ebx),%eax
80101173:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80101176:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101179:	5b                   	pop    %ebx
8010117a:	5e                   	pop    %esi
8010117b:	5f                   	pop    %edi
8010117c:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
8010117d:	e9 ce 24 00 00       	jmp    80103650 <piperead>
80101182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
80101188:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010118d:	eb d9                	jmp    80101168 <fileread+0x58>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
8010118f:	83 ec 0c             	sub    $0xc,%esp
80101192:	68 26 72 10 80       	push   $0x80107226
80101197:	e8 d4 f1 ff ff       	call   80100370 <panic>
8010119c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801011a0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801011a0:	55                   	push   %ebp
801011a1:	89 e5                	mov    %esp,%ebp
801011a3:	57                   	push   %edi
801011a4:	56                   	push   %esi
801011a5:	53                   	push   %ebx
801011a6:	83 ec 1c             	sub    $0x1c,%esp
801011a9:	8b 75 08             	mov    0x8(%ebp),%esi
801011ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
801011af:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801011b3:	89 45 dc             	mov    %eax,-0x24(%ebp)
801011b6:	8b 45 10             	mov    0x10(%ebp),%eax
801011b9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
801011bc:	0f 84 aa 00 00 00    	je     8010126c <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
801011c2:	8b 06                	mov    (%esi),%eax
801011c4:	83 f8 01             	cmp    $0x1,%eax
801011c7:	0f 84 c2 00 00 00    	je     8010128f <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801011cd:	83 f8 02             	cmp    $0x2,%eax
801011d0:	0f 85 d8 00 00 00    	jne    801012ae <filewrite+0x10e>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801011d6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801011d9:	31 ff                	xor    %edi,%edi
801011db:	85 c0                	test   %eax,%eax
801011dd:	7f 34                	jg     80101213 <filewrite+0x73>
801011df:	e9 9c 00 00 00       	jmp    80101280 <filewrite+0xe0>
801011e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801011e8:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
801011eb:	83 ec 0c             	sub    $0xc,%esp
801011ee:	ff 76 10             	pushl  0x10(%esi)
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801011f1:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801011f4:	e8 17 07 00 00       	call   80101910 <iunlock>
      end_op();
801011f9:	e8 82 1b 00 00       	call   80102d80 <end_op>
801011fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101201:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101204:	39 d8                	cmp    %ebx,%eax
80101206:	0f 85 95 00 00 00    	jne    801012a1 <filewrite+0x101>
        panic("short filewrite");
      i += r;
8010120c:	01 c7                	add    %eax,%edi
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
8010120e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101211:	7e 6d                	jle    80101280 <filewrite+0xe0>
      int n1 = n - i;
80101213:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101216:	b8 00 06 00 00       	mov    $0x600,%eax
8010121b:	29 fb                	sub    %edi,%ebx
8010121d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101223:	0f 4f d8             	cmovg  %eax,%ebx
      if(n1 > max)
        n1 = max;

      begin_op();
80101226:	e8 e5 1a 00 00       	call   80102d10 <begin_op>
      ilock(f->ip);
8010122b:	83 ec 0c             	sub    $0xc,%esp
8010122e:	ff 76 10             	pushl  0x10(%esi)
80101231:	e8 fa 05 00 00       	call   80101830 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101236:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101239:	53                   	push   %ebx
8010123a:	ff 76 14             	pushl  0x14(%esi)
8010123d:	01 f8                	add    %edi,%eax
8010123f:	50                   	push   %eax
80101240:	ff 76 10             	pushl  0x10(%esi)
80101243:	e8 c8 09 00 00       	call   80101c10 <writei>
80101248:	83 c4 20             	add    $0x20,%esp
8010124b:	85 c0                	test   %eax,%eax
8010124d:	7f 99                	jg     801011e8 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
8010124f:	83 ec 0c             	sub    $0xc,%esp
80101252:	ff 76 10             	pushl  0x10(%esi)
80101255:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101258:	e8 b3 06 00 00       	call   80101910 <iunlock>
      end_op();
8010125d:	e8 1e 1b 00 00       	call   80102d80 <end_op>

      if(r < 0)
80101262:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101265:	83 c4 10             	add    $0x10,%esp
80101268:	85 c0                	test   %eax,%eax
8010126a:	74 98                	je     80101204 <filewrite+0x64>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
8010126c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
8010126f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80101274:	5b                   	pop    %ebx
80101275:	5e                   	pop    %esi
80101276:	5f                   	pop    %edi
80101277:	5d                   	pop    %ebp
80101278:	c3                   	ret    
80101279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
80101280:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80101283:	75 e7                	jne    8010126c <filewrite+0xcc>
  }
  panic("filewrite");
}
80101285:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101288:	89 f8                	mov    %edi,%eax
8010128a:	5b                   	pop    %ebx
8010128b:	5e                   	pop    %esi
8010128c:	5f                   	pop    %edi
8010128d:	5d                   	pop    %ebp
8010128e:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
8010128f:	8b 46 0c             	mov    0xc(%esi),%eax
80101292:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80101295:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101298:	5b                   	pop    %ebx
80101299:	5e                   	pop    %esi
8010129a:	5f                   	pop    %edi
8010129b:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
8010129c:	e9 af 22 00 00       	jmp    80103550 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
801012a1:	83 ec 0c             	sub    $0xc,%esp
801012a4:	68 2f 72 10 80       	push   $0x8010722f
801012a9:	e8 c2 f0 ff ff       	call   80100370 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
801012ae:	83 ec 0c             	sub    $0xc,%esp
801012b1:	68 35 72 10 80       	push   $0x80107235
801012b6:	e8 b5 f0 ff ff       	call   80100370 <panic>
801012bb:	66 90                	xchg   %ax,%ax
801012bd:	66 90                	xchg   %ax,%ax
801012bf:	90                   	nop

801012c0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801012c0:	55                   	push   %ebp
801012c1:	89 e5                	mov    %esp,%ebp
801012c3:	57                   	push   %edi
801012c4:	56                   	push   %esi
801012c5:	53                   	push   %ebx
801012c6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801012c9:	8b 0d 60 19 11 80    	mov    0x80111960,%ecx
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801012cf:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801012d2:	85 c9                	test   %ecx,%ecx
801012d4:	0f 84 85 00 00 00    	je     8010135f <balloc+0x9f>
801012da:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801012e1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801012e4:	83 ec 08             	sub    $0x8,%esp
801012e7:	89 f0                	mov    %esi,%eax
801012e9:	c1 f8 0c             	sar    $0xc,%eax
801012ec:	03 05 78 19 11 80    	add    0x80111978,%eax
801012f2:	50                   	push   %eax
801012f3:	ff 75 d8             	pushl  -0x28(%ebp)
801012f6:	e8 d5 ed ff ff       	call   801000d0 <bread>
801012fb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801012fe:	a1 60 19 11 80       	mov    0x80111960,%eax
80101303:	83 c4 10             	add    $0x10,%esp
80101306:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101309:	31 c0                	xor    %eax,%eax
8010130b:	eb 2d                	jmp    8010133a <balloc+0x7a>
8010130d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101310:	89 c1                	mov    %eax,%ecx
80101312:	ba 01 00 00 00       	mov    $0x1,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101317:	8b 5d e4             	mov    -0x1c(%ebp),%ebx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
8010131a:	83 e1 07             	and    $0x7,%ecx
8010131d:	d3 e2                	shl    %cl,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010131f:	89 c1                	mov    %eax,%ecx
80101321:	c1 f9 03             	sar    $0x3,%ecx
80101324:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
80101329:	85 d7                	test   %edx,%edi
8010132b:	74 43                	je     80101370 <balloc+0xb0>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010132d:	83 c0 01             	add    $0x1,%eax
80101330:	83 c6 01             	add    $0x1,%esi
80101333:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101338:	74 05                	je     8010133f <balloc+0x7f>
8010133a:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010133d:	72 d1                	jb     80101310 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
8010133f:	83 ec 0c             	sub    $0xc,%esp
80101342:	ff 75 e4             	pushl  -0x1c(%ebp)
80101345:	e8 96 ee ff ff       	call   801001e0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
8010134a:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101351:	83 c4 10             	add    $0x10,%esp
80101354:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101357:	39 05 60 19 11 80    	cmp    %eax,0x80111960
8010135d:	77 82                	ja     801012e1 <balloc+0x21>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
8010135f:	83 ec 0c             	sub    $0xc,%esp
80101362:	68 3f 72 10 80       	push   $0x8010723f
80101367:	e8 04 f0 ff ff       	call   80100370 <panic>
8010136c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101370:	09 fa                	or     %edi,%edx
80101372:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101375:	83 ec 0c             	sub    $0xc,%esp
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101378:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010137c:	57                   	push   %edi
8010137d:	e8 6e 1b 00 00       	call   80102ef0 <log_write>
        brelse(bp);
80101382:	89 3c 24             	mov    %edi,(%esp)
80101385:	e8 56 ee ff ff       	call   801001e0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
8010138a:	58                   	pop    %eax
8010138b:	5a                   	pop    %edx
8010138c:	56                   	push   %esi
8010138d:	ff 75 d8             	pushl  -0x28(%ebp)
80101390:	e8 3b ed ff ff       	call   801000d0 <bread>
80101395:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101397:	8d 40 5c             	lea    0x5c(%eax),%eax
8010139a:	83 c4 0c             	add    $0xc,%esp
8010139d:	68 00 02 00 00       	push   $0x200
801013a2:	6a 00                	push   $0x0
801013a4:	50                   	push   %eax
801013a5:	e8 26 32 00 00       	call   801045d0 <memset>
  log_write(bp);
801013aa:	89 1c 24             	mov    %ebx,(%esp)
801013ad:	e8 3e 1b 00 00       	call   80102ef0 <log_write>
  brelse(bp);
801013b2:	89 1c 24             	mov    %ebx,(%esp)
801013b5:	e8 26 ee ff ff       	call   801001e0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
801013ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013bd:	89 f0                	mov    %esi,%eax
801013bf:	5b                   	pop    %ebx
801013c0:	5e                   	pop    %esi
801013c1:	5f                   	pop    %edi
801013c2:	5d                   	pop    %ebp
801013c3:	c3                   	ret    
801013c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801013ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801013d0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801013d0:	55                   	push   %ebp
801013d1:	89 e5                	mov    %esp,%ebp
801013d3:	57                   	push   %edi
801013d4:	56                   	push   %esi
801013d5:	53                   	push   %ebx
801013d6:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801013d8:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013da:	bb b4 19 11 80       	mov    $0x801119b4,%ebx
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801013df:	83 ec 28             	sub    $0x28,%esp
801013e2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
801013e5:	68 80 19 11 80       	push   $0x80111980
801013ea:	e8 71 30 00 00       	call   80104460 <acquire>
801013ef:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013f2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801013f5:	eb 1b                	jmp    80101412 <iget+0x42>
801013f7:	89 f6                	mov    %esi,%esi
801013f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101400:	85 f6                	test   %esi,%esi
80101402:	74 44                	je     80101448 <iget+0x78>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101404:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010140a:	81 fb d4 35 11 80    	cmp    $0x801135d4,%ebx
80101410:	74 4e                	je     80101460 <iget+0x90>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101412:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101415:	85 c9                	test   %ecx,%ecx
80101417:	7e e7                	jle    80101400 <iget+0x30>
80101419:	39 3b                	cmp    %edi,(%ebx)
8010141b:	75 e3                	jne    80101400 <iget+0x30>
8010141d:	39 53 04             	cmp    %edx,0x4(%ebx)
80101420:	75 de                	jne    80101400 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
80101422:	83 ec 0c             	sub    $0xc,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
80101425:	83 c1 01             	add    $0x1,%ecx
      release(&icache.lock);
      return ip;
80101428:	89 de                	mov    %ebx,%esi
  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
8010142a:	68 80 19 11 80       	push   $0x80111980

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
8010142f:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101432:	e8 49 31 00 00       	call   80104580 <release>
      return ip;
80101437:	83 c4 10             	add    $0x10,%esp
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
8010143a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010143d:	89 f0                	mov    %esi,%eax
8010143f:	5b                   	pop    %ebx
80101440:	5e                   	pop    %esi
80101441:	5f                   	pop    %edi
80101442:	5d                   	pop    %ebp
80101443:	c3                   	ret    
80101444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101448:	85 c9                	test   %ecx,%ecx
8010144a:	0f 44 f3             	cmove  %ebx,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010144d:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101453:	81 fb d4 35 11 80    	cmp    $0x801135d4,%ebx
80101459:	75 b7                	jne    80101412 <iget+0x42>
8010145b:	90                   	nop
8010145c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101460:	85 f6                	test   %esi,%esi
80101462:	74 2d                	je     80101491 <iget+0xc1>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101464:	83 ec 0c             	sub    $0xc,%esp
  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
80101467:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101469:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010146c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101473:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010147a:	68 80 19 11 80       	push   $0x80111980
8010147f:	e8 fc 30 00 00       	call   80104580 <release>

  return ip;
80101484:	83 c4 10             	add    $0x10,%esp
}
80101487:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010148a:	89 f0                	mov    %esi,%eax
8010148c:	5b                   	pop    %ebx
8010148d:	5e                   	pop    %esi
8010148e:	5f                   	pop    %edi
8010148f:	5d                   	pop    %ebp
80101490:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
80101491:	83 ec 0c             	sub    $0xc,%esp
80101494:	68 55 72 10 80       	push   $0x80107255
80101499:	e8 d2 ee ff ff       	call   80100370 <panic>
8010149e:	66 90                	xchg   %ax,%ax

801014a0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801014a0:	55                   	push   %ebp
801014a1:	89 e5                	mov    %esp,%ebp
801014a3:	57                   	push   %edi
801014a4:	56                   	push   %esi
801014a5:	53                   	push   %ebx
801014a6:	89 c6                	mov    %eax,%esi
801014a8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801014ab:	83 fa 0b             	cmp    $0xb,%edx
801014ae:	77 18                	ja     801014c8 <bmap+0x28>
801014b0:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
    if((addr = ip->addrs[bn]) == 0)
801014b3:	8b 43 5c             	mov    0x5c(%ebx),%eax
801014b6:	85 c0                	test   %eax,%eax
801014b8:	74 76                	je     80101530 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801014ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014bd:	5b                   	pop    %ebx
801014be:	5e                   	pop    %esi
801014bf:	5f                   	pop    %edi
801014c0:	5d                   	pop    %ebp
801014c1:	c3                   	ret    
801014c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801014c8:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801014cb:	83 fb 7f             	cmp    $0x7f,%ebx
801014ce:	0f 87 83 00 00 00    	ja     80101557 <bmap+0xb7>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801014d4:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801014da:	85 c0                	test   %eax,%eax
801014dc:	74 6a                	je     80101548 <bmap+0xa8>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801014de:	83 ec 08             	sub    $0x8,%esp
801014e1:	50                   	push   %eax
801014e2:	ff 36                	pushl  (%esi)
801014e4:	e8 e7 eb ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801014e9:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
801014ed:	83 c4 10             	add    $0x10,%esp

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801014f0:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801014f2:	8b 1a                	mov    (%edx),%ebx
801014f4:	85 db                	test   %ebx,%ebx
801014f6:	75 1d                	jne    80101515 <bmap+0x75>
      a[bn] = addr = balloc(ip->dev);
801014f8:	8b 06                	mov    (%esi),%eax
801014fa:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801014fd:	e8 be fd ff ff       	call   801012c0 <balloc>
80101502:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101505:	83 ec 0c             	sub    $0xc,%esp
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
80101508:	89 c3                	mov    %eax,%ebx
8010150a:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010150c:	57                   	push   %edi
8010150d:	e8 de 19 00 00       	call   80102ef0 <log_write>
80101512:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101515:	83 ec 0c             	sub    $0xc,%esp
80101518:	57                   	push   %edi
80101519:	e8 c2 ec ff ff       	call   801001e0 <brelse>
8010151e:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101521:	8d 65 f4             	lea    -0xc(%ebp),%esp
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101524:	89 d8                	mov    %ebx,%eax
    return addr;
  }

  panic("bmap: out of range");
}
80101526:	5b                   	pop    %ebx
80101527:	5e                   	pop    %esi
80101528:	5f                   	pop    %edi
80101529:	5d                   	pop    %ebp
8010152a:	c3                   	ret    
8010152b:	90                   	nop
8010152c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80101530:	8b 06                	mov    (%esi),%eax
80101532:	e8 89 fd ff ff       	call   801012c0 <balloc>
80101537:	89 43 5c             	mov    %eax,0x5c(%ebx)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010153a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010153d:	5b                   	pop    %ebx
8010153e:	5e                   	pop    %esi
8010153f:	5f                   	pop    %edi
80101540:	5d                   	pop    %ebp
80101541:	c3                   	ret    
80101542:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101548:	8b 06                	mov    (%esi),%eax
8010154a:	e8 71 fd ff ff       	call   801012c0 <balloc>
8010154f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101555:	eb 87                	jmp    801014de <bmap+0x3e>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
80101557:	83 ec 0c             	sub    $0xc,%esp
8010155a:	68 65 72 10 80       	push   $0x80107265
8010155f:	e8 0c ee ff ff       	call   80100370 <panic>
80101564:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010156a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101570 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101570:	55                   	push   %ebp
80101571:	89 e5                	mov    %esp,%ebp
80101573:	56                   	push   %esi
80101574:	53                   	push   %ebx
80101575:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
80101578:	83 ec 08             	sub    $0x8,%esp
8010157b:	6a 01                	push   $0x1
8010157d:	ff 75 08             	pushl  0x8(%ebp)
80101580:	e8 4b eb ff ff       	call   801000d0 <bread>
80101585:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101587:	8d 40 5c             	lea    0x5c(%eax),%eax
8010158a:	83 c4 0c             	add    $0xc,%esp
8010158d:	6a 1c                	push   $0x1c
8010158f:	50                   	push   %eax
80101590:	56                   	push   %esi
80101591:	e8 ea 30 00 00       	call   80104680 <memmove>
  brelse(bp);
80101596:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101599:	83 c4 10             	add    $0x10,%esp
}
8010159c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010159f:	5b                   	pop    %ebx
801015a0:	5e                   	pop    %esi
801015a1:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
801015a2:	e9 39 ec ff ff       	jmp    801001e0 <brelse>
801015a7:	89 f6                	mov    %esi,%esi
801015a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801015b0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801015b0:	55                   	push   %ebp
801015b1:	89 e5                	mov    %esp,%ebp
801015b3:	56                   	push   %esi
801015b4:	53                   	push   %ebx
801015b5:	89 d3                	mov    %edx,%ebx
801015b7:	89 c6                	mov    %eax,%esi
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
801015b9:	83 ec 08             	sub    $0x8,%esp
801015bc:	68 60 19 11 80       	push   $0x80111960
801015c1:	50                   	push   %eax
801015c2:	e8 a9 ff ff ff       	call   80101570 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801015c7:	58                   	pop    %eax
801015c8:	5a                   	pop    %edx
801015c9:	89 da                	mov    %ebx,%edx
801015cb:	c1 ea 0c             	shr    $0xc,%edx
801015ce:	03 15 78 19 11 80    	add    0x80111978,%edx
801015d4:	52                   	push   %edx
801015d5:	56                   	push   %esi
801015d6:	e8 f5 ea ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
801015db:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801015dd:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
801015e3:	ba 01 00 00 00       	mov    $0x1,%edx
801015e8:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
801015eb:	c1 fb 03             	sar    $0x3,%ebx
801015ee:	83 c4 10             	add    $0x10,%esp
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
801015f1:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
801015f3:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
801015f8:	85 d1                	test   %edx,%ecx
801015fa:	74 27                	je     80101623 <bfree+0x73>
801015fc:	89 c6                	mov    %eax,%esi
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
801015fe:	f7 d2                	not    %edx
80101600:	89 c8                	mov    %ecx,%eax
  log_write(bp);
80101602:	83 ec 0c             	sub    $0xc,%esp
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101605:	21 d0                	and    %edx,%eax
80101607:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010160b:	56                   	push   %esi
8010160c:	e8 df 18 00 00       	call   80102ef0 <log_write>
  brelse(bp);
80101611:	89 34 24             	mov    %esi,(%esp)
80101614:	e8 c7 eb ff ff       	call   801001e0 <brelse>
}
80101619:	83 c4 10             	add    $0x10,%esp
8010161c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010161f:	5b                   	pop    %ebx
80101620:	5e                   	pop    %esi
80101621:	5d                   	pop    %ebp
80101622:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
80101623:	83 ec 0c             	sub    $0xc,%esp
80101626:	68 78 72 10 80       	push   $0x80107278
8010162b:	e8 40 ed ff ff       	call   80100370 <panic>

80101630 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101630:	55                   	push   %ebp
80101631:	89 e5                	mov    %esp,%ebp
80101633:	53                   	push   %ebx
80101634:	bb c0 19 11 80       	mov    $0x801119c0,%ebx
80101639:	83 ec 0c             	sub    $0xc,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
8010163c:	68 8b 72 10 80       	push   $0x8010728b
80101641:	68 80 19 11 80       	push   $0x80111980
80101646:	e8 15 2d 00 00       	call   80104360 <initlock>
8010164b:	83 c4 10             	add    $0x10,%esp
8010164e:	66 90                	xchg   %ax,%ax
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
80101650:	83 ec 08             	sub    $0x8,%esp
80101653:	68 92 72 10 80       	push   $0x80107292
80101658:	53                   	push   %ebx
80101659:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010165f:	e8 ec 2b 00 00       	call   80104250 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
80101664:	83 c4 10             	add    $0x10,%esp
80101667:	81 fb e0 35 11 80    	cmp    $0x801135e0,%ebx
8010166d:	75 e1                	jne    80101650 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }

  readsb(dev, &sb);
8010166f:	83 ec 08             	sub    $0x8,%esp
80101672:	68 60 19 11 80       	push   $0x80111960
80101677:	ff 75 08             	pushl  0x8(%ebp)
8010167a:	e8 f1 fe ff ff       	call   80101570 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010167f:	ff 35 78 19 11 80    	pushl  0x80111978
80101685:	ff 35 74 19 11 80    	pushl  0x80111974
8010168b:	ff 35 70 19 11 80    	pushl  0x80111970
80101691:	ff 35 6c 19 11 80    	pushl  0x8011196c
80101697:	ff 35 68 19 11 80    	pushl  0x80111968
8010169d:	ff 35 64 19 11 80    	pushl  0x80111964
801016a3:	ff 35 60 19 11 80    	pushl  0x80111960
801016a9:	68 f8 72 10 80       	push   $0x801072f8
801016ae:	e8 fd ef ff ff       	call   801006b0 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
801016b3:	83 c4 30             	add    $0x30,%esp
801016b6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801016b9:	c9                   	leave  
801016ba:	c3                   	ret    
801016bb:	90                   	nop
801016bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801016c0 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
801016c0:	55                   	push   %ebp
801016c1:	89 e5                	mov    %esp,%ebp
801016c3:	57                   	push   %edi
801016c4:	56                   	push   %esi
801016c5:	53                   	push   %ebx
801016c6:	83 ec 1c             	sub    $0x1c,%esp
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801016c9:	83 3d 68 19 11 80 01 	cmpl   $0x1,0x80111968
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
801016d0:	8b 45 0c             	mov    0xc(%ebp),%eax
801016d3:	8b 75 08             	mov    0x8(%ebp),%esi
801016d6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801016d9:	0f 86 91 00 00 00    	jbe    80101770 <ialloc+0xb0>
801016df:	bb 01 00 00 00       	mov    $0x1,%ebx
801016e4:	eb 21                	jmp    80101707 <ialloc+0x47>
801016e6:	8d 76 00             	lea    0x0(%esi),%esi
801016e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
801016f0:	83 ec 0c             	sub    $0xc,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801016f3:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
801016f6:	57                   	push   %edi
801016f7:	e8 e4 ea ff ff       	call   801001e0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801016fc:	83 c4 10             	add    $0x10,%esp
801016ff:	39 1d 68 19 11 80    	cmp    %ebx,0x80111968
80101705:	76 69                	jbe    80101770 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101707:	89 d8                	mov    %ebx,%eax
80101709:	83 ec 08             	sub    $0x8,%esp
8010170c:	c1 e8 03             	shr    $0x3,%eax
8010170f:	03 05 74 19 11 80    	add    0x80111974,%eax
80101715:	50                   	push   %eax
80101716:	56                   	push   %esi
80101717:	e8 b4 e9 ff ff       	call   801000d0 <bread>
8010171c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010171e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101720:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
80101723:	83 e0 07             	and    $0x7,%eax
80101726:	c1 e0 06             	shl    $0x6,%eax
80101729:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010172d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101731:	75 bd                	jne    801016f0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101733:	83 ec 04             	sub    $0x4,%esp
80101736:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101739:	6a 40                	push   $0x40
8010173b:	6a 00                	push   $0x0
8010173d:	51                   	push   %ecx
8010173e:	e8 8d 2e 00 00       	call   801045d0 <memset>
      dip->type = type;
80101743:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101747:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010174a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010174d:	89 3c 24             	mov    %edi,(%esp)
80101750:	e8 9b 17 00 00       	call   80102ef0 <log_write>
      brelse(bp);
80101755:	89 3c 24             	mov    %edi,(%esp)
80101758:	e8 83 ea ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
8010175d:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101760:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
80101763:	89 da                	mov    %ebx,%edx
80101765:	89 f0                	mov    %esi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101767:	5b                   	pop    %ebx
80101768:	5e                   	pop    %esi
80101769:	5f                   	pop    %edi
8010176a:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
8010176b:	e9 60 fc ff ff       	jmp    801013d0 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
80101770:	83 ec 0c             	sub    $0xc,%esp
80101773:	68 98 72 10 80       	push   $0x80107298
80101778:	e8 f3 eb ff ff       	call   80100370 <panic>
8010177d:	8d 76 00             	lea    0x0(%esi),%esi

80101780 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
80101780:	55                   	push   %ebp
80101781:	89 e5                	mov    %esp,%ebp
80101783:	56                   	push   %esi
80101784:	53                   	push   %ebx
80101785:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101788:	83 ec 08             	sub    $0x8,%esp
8010178b:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010178e:	83 c3 5c             	add    $0x5c,%ebx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101791:	c1 e8 03             	shr    $0x3,%eax
80101794:	03 05 74 19 11 80    	add    0x80111974,%eax
8010179a:	50                   	push   %eax
8010179b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010179e:	e8 2d e9 ff ff       	call   801000d0 <bread>
801017a3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801017a5:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
801017a8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017ac:	83 c4 0c             	add    $0xc,%esp
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801017af:	83 e0 07             	and    $0x7,%eax
801017b2:	c1 e0 06             	shl    $0x6,%eax
801017b5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801017b9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801017bc:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017c0:	83 c0 0c             	add    $0xc,%eax
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
801017c3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801017c7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801017cb:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801017cf:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
801017d3:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
801017d7:	8b 53 fc             	mov    -0x4(%ebx),%edx
801017da:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017dd:	6a 34                	push   $0x34
801017df:	53                   	push   %ebx
801017e0:	50                   	push   %eax
801017e1:	e8 9a 2e 00 00       	call   80104680 <memmove>
  log_write(bp);
801017e6:	89 34 24             	mov    %esi,(%esp)
801017e9:	e8 02 17 00 00       	call   80102ef0 <log_write>
  brelse(bp);
801017ee:	89 75 08             	mov    %esi,0x8(%ebp)
801017f1:	83 c4 10             	add    $0x10,%esp
}
801017f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017f7:	5b                   	pop    %ebx
801017f8:	5e                   	pop    %esi
801017f9:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
801017fa:	e9 e1 e9 ff ff       	jmp    801001e0 <brelse>
801017ff:	90                   	nop

80101800 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101800:	55                   	push   %ebp
80101801:	89 e5                	mov    %esp,%ebp
80101803:	53                   	push   %ebx
80101804:	83 ec 10             	sub    $0x10,%esp
80101807:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010180a:	68 80 19 11 80       	push   $0x80111980
8010180f:	e8 4c 2c 00 00       	call   80104460 <acquire>
  ip->ref++;
80101814:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101818:	c7 04 24 80 19 11 80 	movl   $0x80111980,(%esp)
8010181f:	e8 5c 2d 00 00       	call   80104580 <release>
  return ip;
}
80101824:	89 d8                	mov    %ebx,%eax
80101826:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101829:	c9                   	leave  
8010182a:	c3                   	ret    
8010182b:	90                   	nop
8010182c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101830 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101830:	55                   	push   %ebp
80101831:	89 e5                	mov    %esp,%ebp
80101833:	56                   	push   %esi
80101834:	53                   	push   %ebx
80101835:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101838:	85 db                	test   %ebx,%ebx
8010183a:	0f 84 b7 00 00 00    	je     801018f7 <ilock+0xc7>
80101840:	8b 53 08             	mov    0x8(%ebx),%edx
80101843:	85 d2                	test   %edx,%edx
80101845:	0f 8e ac 00 00 00    	jle    801018f7 <ilock+0xc7>
    panic("ilock");

  acquiresleep(&ip->lock);
8010184b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010184e:	83 ec 0c             	sub    $0xc,%esp
80101851:	50                   	push   %eax
80101852:	e8 39 2a 00 00       	call   80104290 <acquiresleep>

  if(ip->valid == 0){
80101857:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010185a:	83 c4 10             	add    $0x10,%esp
8010185d:	85 c0                	test   %eax,%eax
8010185f:	74 0f                	je     80101870 <ilock+0x40>
    brelse(bp);
    ip->valid = 1;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
80101861:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101864:	5b                   	pop    %ebx
80101865:	5e                   	pop    %esi
80101866:	5d                   	pop    %ebp
80101867:	c3                   	ret    
80101868:	90                   	nop
80101869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101870:	8b 43 04             	mov    0x4(%ebx),%eax
80101873:	83 ec 08             	sub    $0x8,%esp
80101876:	c1 e8 03             	shr    $0x3,%eax
80101879:	03 05 74 19 11 80    	add    0x80111974,%eax
8010187f:	50                   	push   %eax
80101880:	ff 33                	pushl  (%ebx)
80101882:	e8 49 e8 ff ff       	call   801000d0 <bread>
80101887:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101889:	8b 43 04             	mov    0x4(%ebx),%eax
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010188c:	83 c4 0c             	add    $0xc,%esp

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010188f:	83 e0 07             	and    $0x7,%eax
80101892:	c1 e0 06             	shl    $0x6,%eax
80101895:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101899:	0f b7 10             	movzwl (%eax),%edx
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010189c:	83 c0 0c             	add    $0xc,%eax
  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
8010189f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801018a3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801018a7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801018ab:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801018af:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801018b3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801018b7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801018bb:	8b 50 fc             	mov    -0x4(%eax),%edx
801018be:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801018c1:	6a 34                	push   $0x34
801018c3:	50                   	push   %eax
801018c4:	8d 43 5c             	lea    0x5c(%ebx),%eax
801018c7:	50                   	push   %eax
801018c8:	e8 b3 2d 00 00       	call   80104680 <memmove>
    brelse(bp);
801018cd:	89 34 24             	mov    %esi,(%esp)
801018d0:	e8 0b e9 ff ff       	call   801001e0 <brelse>
    ip->valid = 1;
    if(ip->type == 0)
801018d5:	83 c4 10             	add    $0x10,%esp
801018d8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    brelse(bp);
    ip->valid = 1;
801018dd:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801018e4:	0f 85 77 ff ff ff    	jne    80101861 <ilock+0x31>
      panic("ilock: no type");
801018ea:	83 ec 0c             	sub    $0xc,%esp
801018ed:	68 b0 72 10 80       	push   $0x801072b0
801018f2:	e8 79 ea ff ff       	call   80100370 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
801018f7:	83 ec 0c             	sub    $0xc,%esp
801018fa:	68 aa 72 10 80       	push   $0x801072aa
801018ff:	e8 6c ea ff ff       	call   80100370 <panic>
80101904:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010190a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101910 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101910:	55                   	push   %ebp
80101911:	89 e5                	mov    %esp,%ebp
80101913:	56                   	push   %esi
80101914:	53                   	push   %ebx
80101915:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101918:	85 db                	test   %ebx,%ebx
8010191a:	74 28                	je     80101944 <iunlock+0x34>
8010191c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010191f:	83 ec 0c             	sub    $0xc,%esp
80101922:	56                   	push   %esi
80101923:	e8 08 2a 00 00       	call   80104330 <holdingsleep>
80101928:	83 c4 10             	add    $0x10,%esp
8010192b:	85 c0                	test   %eax,%eax
8010192d:	74 15                	je     80101944 <iunlock+0x34>
8010192f:	8b 43 08             	mov    0x8(%ebx),%eax
80101932:	85 c0                	test   %eax,%eax
80101934:	7e 0e                	jle    80101944 <iunlock+0x34>
    panic("iunlock");

  releasesleep(&ip->lock);
80101936:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101939:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010193c:	5b                   	pop    %ebx
8010193d:	5e                   	pop    %esi
8010193e:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
8010193f:	e9 ac 29 00 00       	jmp    801042f0 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
80101944:	83 ec 0c             	sub    $0xc,%esp
80101947:	68 bf 72 10 80       	push   $0x801072bf
8010194c:	e8 1f ea ff ff       	call   80100370 <panic>
80101951:	eb 0d                	jmp    80101960 <iput>
80101953:	90                   	nop
80101954:	90                   	nop
80101955:	90                   	nop
80101956:	90                   	nop
80101957:	90                   	nop
80101958:	90                   	nop
80101959:	90                   	nop
8010195a:	90                   	nop
8010195b:	90                   	nop
8010195c:	90                   	nop
8010195d:	90                   	nop
8010195e:	90                   	nop
8010195f:	90                   	nop

80101960 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101960:	55                   	push   %ebp
80101961:	89 e5                	mov    %esp,%ebp
80101963:	57                   	push   %edi
80101964:	56                   	push   %esi
80101965:	53                   	push   %ebx
80101966:	83 ec 28             	sub    $0x28,%esp
80101969:	8b 75 08             	mov    0x8(%ebp),%esi
  acquiresleep(&ip->lock);
8010196c:	8d 7e 0c             	lea    0xc(%esi),%edi
8010196f:	57                   	push   %edi
80101970:	e8 1b 29 00 00       	call   80104290 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101975:	8b 56 4c             	mov    0x4c(%esi),%edx
80101978:	83 c4 10             	add    $0x10,%esp
8010197b:	85 d2                	test   %edx,%edx
8010197d:	74 07                	je     80101986 <iput+0x26>
8010197f:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
80101984:	74 32                	je     801019b8 <iput+0x58>
      ip->type = 0;
      iupdate(ip);
      ip->valid = 0;
    }
  }
  releasesleep(&ip->lock);
80101986:	83 ec 0c             	sub    $0xc,%esp
80101989:	57                   	push   %edi
8010198a:	e8 61 29 00 00       	call   801042f0 <releasesleep>

  acquire(&icache.lock);
8010198f:	c7 04 24 80 19 11 80 	movl   $0x80111980,(%esp)
80101996:	e8 c5 2a 00 00       	call   80104460 <acquire>
  ip->ref--;
8010199b:	83 6e 08 01          	subl   $0x1,0x8(%esi)
  release(&icache.lock);
8010199f:	83 c4 10             	add    $0x10,%esp
801019a2:	c7 45 08 80 19 11 80 	movl   $0x80111980,0x8(%ebp)
}
801019a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801019ac:	5b                   	pop    %ebx
801019ad:	5e                   	pop    %esi
801019ae:	5f                   	pop    %edi
801019af:	5d                   	pop    %ebp
  }
  releasesleep(&ip->lock);

  acquire(&icache.lock);
  ip->ref--;
  release(&icache.lock);
801019b0:	e9 cb 2b 00 00       	jmp    80104580 <release>
801019b5:	8d 76 00             	lea    0x0(%esi),%esi
void
iput(struct inode *ip)
{
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
801019b8:	83 ec 0c             	sub    $0xc,%esp
801019bb:	68 80 19 11 80       	push   $0x80111980
801019c0:	e8 9b 2a 00 00       	call   80104460 <acquire>
    int r = ip->ref;
801019c5:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
801019c8:	c7 04 24 80 19 11 80 	movl   $0x80111980,(%esp)
801019cf:	e8 ac 2b 00 00       	call   80104580 <release>
    if(r == 1){
801019d4:	83 c4 10             	add    $0x10,%esp
801019d7:	83 fb 01             	cmp    $0x1,%ebx
801019da:	75 aa                	jne    80101986 <iput+0x26>
801019dc:	8d 8e 8c 00 00 00    	lea    0x8c(%esi),%ecx
801019e2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801019e5:	8d 5e 5c             	lea    0x5c(%esi),%ebx
801019e8:	89 cf                	mov    %ecx,%edi
801019ea:	eb 0b                	jmp    801019f7 <iput+0x97>
801019ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801019f0:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801019f3:	39 fb                	cmp    %edi,%ebx
801019f5:	74 19                	je     80101a10 <iput+0xb0>
    if(ip->addrs[i]){
801019f7:	8b 13                	mov    (%ebx),%edx
801019f9:	85 d2                	test   %edx,%edx
801019fb:	74 f3                	je     801019f0 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
801019fd:	8b 06                	mov    (%esi),%eax
801019ff:	e8 ac fb ff ff       	call   801015b0 <bfree>
      ip->addrs[i] = 0;
80101a04:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80101a0a:	eb e4                	jmp    801019f0 <iput+0x90>
80101a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101a10:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80101a16:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101a19:	85 c0                	test   %eax,%eax
80101a1b:	75 33                	jne    80101a50 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101a1d:	83 ec 0c             	sub    $0xc,%esp
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
80101a20:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
80101a27:	56                   	push   %esi
80101a28:	e8 53 fd ff ff       	call   80101780 <iupdate>
    int r = ip->ref;
    release(&icache.lock);
    if(r == 1){
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
      ip->type = 0;
80101a2d:	31 c0                	xor    %eax,%eax
80101a2f:	66 89 46 50          	mov    %ax,0x50(%esi)
      iupdate(ip);
80101a33:	89 34 24             	mov    %esi,(%esp)
80101a36:	e8 45 fd ff ff       	call   80101780 <iupdate>
      ip->valid = 0;
80101a3b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
80101a42:	83 c4 10             	add    $0x10,%esp
80101a45:	e9 3c ff ff ff       	jmp    80101986 <iput+0x26>
80101a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101a50:	83 ec 08             	sub    $0x8,%esp
80101a53:	50                   	push   %eax
80101a54:	ff 36                	pushl  (%esi)
80101a56:	e8 75 e6 ff ff       	call   801000d0 <bread>
80101a5b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101a61:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101a64:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101a67:	8d 58 5c             	lea    0x5c(%eax),%ebx
80101a6a:	83 c4 10             	add    $0x10,%esp
80101a6d:	89 cf                	mov    %ecx,%edi
80101a6f:	eb 0e                	jmp    80101a7f <iput+0x11f>
80101a71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a78:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
80101a7b:	39 fb                	cmp    %edi,%ebx
80101a7d:	74 0f                	je     80101a8e <iput+0x12e>
      if(a[j])
80101a7f:	8b 13                	mov    (%ebx),%edx
80101a81:	85 d2                	test   %edx,%edx
80101a83:	74 f3                	je     80101a78 <iput+0x118>
        bfree(ip->dev, a[j]);
80101a85:	8b 06                	mov    (%esi),%eax
80101a87:	e8 24 fb ff ff       	call   801015b0 <bfree>
80101a8c:	eb ea                	jmp    80101a78 <iput+0x118>
    }
    brelse(bp);
80101a8e:	83 ec 0c             	sub    $0xc,%esp
80101a91:	ff 75 e4             	pushl  -0x1c(%ebp)
80101a94:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a97:	e8 44 e7 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101a9c:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
80101aa2:	8b 06                	mov    (%esi),%eax
80101aa4:	e8 07 fb ff ff       	call   801015b0 <bfree>
    ip->addrs[NDIRECT] = 0;
80101aa9:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
80101ab0:	00 00 00 
80101ab3:	83 c4 10             	add    $0x10,%esp
80101ab6:	e9 62 ff ff ff       	jmp    80101a1d <iput+0xbd>
80101abb:	90                   	nop
80101abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ac0 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101ac0:	55                   	push   %ebp
80101ac1:	89 e5                	mov    %esp,%ebp
80101ac3:	53                   	push   %ebx
80101ac4:	83 ec 10             	sub    $0x10,%esp
80101ac7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101aca:	53                   	push   %ebx
80101acb:	e8 40 fe ff ff       	call   80101910 <iunlock>
  iput(ip);
80101ad0:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101ad3:	83 c4 10             	add    $0x10,%esp
}
80101ad6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101ad9:	c9                   	leave  
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
80101ada:	e9 81 fe ff ff       	jmp    80101960 <iput>
80101adf:	90                   	nop

80101ae0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101ae0:	55                   	push   %ebp
80101ae1:	89 e5                	mov    %esp,%ebp
80101ae3:	8b 55 08             	mov    0x8(%ebp),%edx
80101ae6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101ae9:	8b 0a                	mov    (%edx),%ecx
80101aeb:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101aee:	8b 4a 04             	mov    0x4(%edx),%ecx
80101af1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101af4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101af8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101afb:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101aff:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101b03:	8b 52 58             	mov    0x58(%edx),%edx
80101b06:	89 50 10             	mov    %edx,0x10(%eax)
}
80101b09:	5d                   	pop    %ebp
80101b0a:	c3                   	ret    
80101b0b:	90                   	nop
80101b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101b10 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101b10:	55                   	push   %ebp
80101b11:	89 e5                	mov    %esp,%ebp
80101b13:	57                   	push   %edi
80101b14:	56                   	push   %esi
80101b15:	53                   	push   %ebx
80101b16:	83 ec 1c             	sub    $0x1c,%esp
80101b19:	8b 45 08             	mov    0x8(%ebp),%eax
80101b1c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101b1f:	8b 75 10             	mov    0x10(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b22:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101b27:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101b2a:	8b 7d 14             	mov    0x14(%ebp),%edi
80101b2d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101b30:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b33:	0f 84 a7 00 00 00    	je     80101be0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101b39:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b3c:	8b 40 58             	mov    0x58(%eax),%eax
80101b3f:	39 f0                	cmp    %esi,%eax
80101b41:	0f 82 c1 00 00 00    	jb     80101c08 <readi+0xf8>
80101b47:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101b4a:	89 fa                	mov    %edi,%edx
80101b4c:	01 f2                	add    %esi,%edx
80101b4e:	0f 82 b4 00 00 00    	jb     80101c08 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101b54:	89 c1                	mov    %eax,%ecx
80101b56:	29 f1                	sub    %esi,%ecx
80101b58:	39 d0                	cmp    %edx,%eax
80101b5a:	0f 43 cf             	cmovae %edi,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b5d:	31 ff                	xor    %edi,%edi
80101b5f:	85 c9                	test   %ecx,%ecx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101b61:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b64:	74 6d                	je     80101bd3 <readi+0xc3>
80101b66:	8d 76 00             	lea    0x0(%esi),%esi
80101b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b70:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101b73:	89 f2                	mov    %esi,%edx
80101b75:	c1 ea 09             	shr    $0x9,%edx
80101b78:	89 d8                	mov    %ebx,%eax
80101b7a:	e8 21 f9 ff ff       	call   801014a0 <bmap>
80101b7f:	83 ec 08             	sub    $0x8,%esp
80101b82:	50                   	push   %eax
80101b83:	ff 33                	pushl  (%ebx)
    m = min(n - tot, BSIZE - off%BSIZE);
80101b85:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b8a:	e8 41 e5 ff ff       	call   801000d0 <bread>
80101b8f:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101b91:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b94:	89 f1                	mov    %esi,%ecx
80101b96:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101b9c:	83 c4 0c             	add    $0xc,%esp
    memmove(dst, bp->data + off%BSIZE, m);
80101b9f:	89 55 dc             	mov    %edx,-0x24(%ebp)
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101ba2:	29 cb                	sub    %ecx,%ebx
80101ba4:	29 f8                	sub    %edi,%eax
80101ba6:	39 c3                	cmp    %eax,%ebx
80101ba8:	0f 47 d8             	cmova  %eax,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101bab:	8d 44 0a 5c          	lea    0x5c(%edx,%ecx,1),%eax
80101baf:	53                   	push   %ebx
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101bb0:	01 df                	add    %ebx,%edi
80101bb2:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
80101bb4:	50                   	push   %eax
80101bb5:	ff 75 e0             	pushl  -0x20(%ebp)
80101bb8:	e8 c3 2a 00 00       	call   80104680 <memmove>
    brelse(bp);
80101bbd:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101bc0:	89 14 24             	mov    %edx,(%esp)
80101bc3:	e8 18 e6 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101bc8:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101bcb:	83 c4 10             	add    $0x10,%esp
80101bce:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101bd1:	77 9d                	ja     80101b70 <readi+0x60>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101bd3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101bd6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bd9:	5b                   	pop    %ebx
80101bda:	5e                   	pop    %esi
80101bdb:	5f                   	pop    %edi
80101bdc:	5d                   	pop    %ebp
80101bdd:	c3                   	ret    
80101bde:	66 90                	xchg   %ax,%ax
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101be0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101be4:	66 83 f8 09          	cmp    $0x9,%ax
80101be8:	77 1e                	ja     80101c08 <readi+0xf8>
80101bea:	8b 04 c5 00 19 11 80 	mov    -0x7feee700(,%eax,8),%eax
80101bf1:	85 c0                	test   %eax,%eax
80101bf3:	74 13                	je     80101c08 <readi+0xf8>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101bf5:	89 7d 10             	mov    %edi,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
80101bf8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bfb:	5b                   	pop    %ebx
80101bfc:	5e                   	pop    %esi
80101bfd:	5f                   	pop    %edi
80101bfe:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101bff:	ff e0                	jmp    *%eax
80101c01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101c08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c0d:	eb c7                	jmp    80101bd6 <readi+0xc6>
80101c0f:	90                   	nop

80101c10 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101c10:	55                   	push   %ebp
80101c11:	89 e5                	mov    %esp,%ebp
80101c13:	57                   	push   %edi
80101c14:	56                   	push   %esi
80101c15:	53                   	push   %ebx
80101c16:	83 ec 1c             	sub    $0x1c,%esp
80101c19:	8b 45 08             	mov    0x8(%ebp),%eax
80101c1c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101c1f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101c22:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101c27:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101c2a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101c2d:	8b 75 10             	mov    0x10(%ebp),%esi
80101c30:	89 7d e0             	mov    %edi,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101c33:	0f 84 b7 00 00 00    	je     80101cf0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101c39:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c3c:	39 70 58             	cmp    %esi,0x58(%eax)
80101c3f:	0f 82 eb 00 00 00    	jb     80101d30 <writei+0x120>
80101c45:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101c48:	89 f8                	mov    %edi,%eax
80101c4a:	01 f0                	add    %esi,%eax
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101c4c:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101c51:	0f 87 d9 00 00 00    	ja     80101d30 <writei+0x120>
80101c57:	39 c6                	cmp    %eax,%esi
80101c59:	0f 87 d1 00 00 00    	ja     80101d30 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c5f:	85 ff                	test   %edi,%edi
80101c61:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101c68:	74 78                	je     80101ce2 <writei+0xd2>
80101c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c70:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101c73:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101c75:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c7a:	c1 ea 09             	shr    $0x9,%edx
80101c7d:	89 f8                	mov    %edi,%eax
80101c7f:	e8 1c f8 ff ff       	call   801014a0 <bmap>
80101c84:	83 ec 08             	sub    $0x8,%esp
80101c87:	50                   	push   %eax
80101c88:	ff 37                	pushl  (%edi)
80101c8a:	e8 41 e4 ff ff       	call   801000d0 <bread>
80101c8f:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101c91:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101c94:	2b 45 e4             	sub    -0x1c(%ebp),%eax
80101c97:	89 f1                	mov    %esi,%ecx
80101c99:	83 c4 0c             	add    $0xc,%esp
80101c9c:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101ca2:	29 cb                	sub    %ecx,%ebx
80101ca4:	39 c3                	cmp    %eax,%ebx
80101ca6:	0f 47 d8             	cmova  %eax,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101ca9:	8d 44 0f 5c          	lea    0x5c(%edi,%ecx,1),%eax
80101cad:	53                   	push   %ebx
80101cae:	ff 75 dc             	pushl  -0x24(%ebp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101cb1:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
80101cb3:	50                   	push   %eax
80101cb4:	e8 c7 29 00 00       	call   80104680 <memmove>
    log_write(bp);
80101cb9:	89 3c 24             	mov    %edi,(%esp)
80101cbc:	e8 2f 12 00 00       	call   80102ef0 <log_write>
    brelse(bp);
80101cc1:	89 3c 24             	mov    %edi,(%esp)
80101cc4:	e8 17 e5 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101cc9:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101ccc:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101ccf:	83 c4 10             	add    $0x10,%esp
80101cd2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101cd5:	39 55 e0             	cmp    %edx,-0x20(%ebp)
80101cd8:	77 96                	ja     80101c70 <writei+0x60>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80101cda:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101cdd:	3b 70 58             	cmp    0x58(%eax),%esi
80101ce0:	77 36                	ja     80101d18 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101ce2:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101ce5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ce8:	5b                   	pop    %ebx
80101ce9:	5e                   	pop    %esi
80101cea:	5f                   	pop    %edi
80101ceb:	5d                   	pop    %ebp
80101cec:	c3                   	ret    
80101ced:	8d 76 00             	lea    0x0(%esi),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101cf0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101cf4:	66 83 f8 09          	cmp    $0x9,%ax
80101cf8:	77 36                	ja     80101d30 <writei+0x120>
80101cfa:	8b 04 c5 04 19 11 80 	mov    -0x7feee6fc(,%eax,8),%eax
80101d01:	85 c0                	test   %eax,%eax
80101d03:	74 2b                	je     80101d30 <writei+0x120>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101d05:	89 7d 10             	mov    %edi,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101d08:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d0b:	5b                   	pop    %ebx
80101d0c:	5e                   	pop    %esi
80101d0d:	5f                   	pop    %edi
80101d0e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101d0f:	ff e0                	jmp    *%eax
80101d11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101d18:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101d1b:	83 ec 0c             	sub    $0xc,%esp
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101d1e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101d21:	50                   	push   %eax
80101d22:	e8 59 fa ff ff       	call   80101780 <iupdate>
80101d27:	83 c4 10             	add    $0x10,%esp
80101d2a:	eb b6                	jmp    80101ce2 <writei+0xd2>
80101d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101d30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101d35:	eb ae                	jmp    80101ce5 <writei+0xd5>
80101d37:	89 f6                	mov    %esi,%esi
80101d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101d40 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101d40:	55                   	push   %ebp
80101d41:	89 e5                	mov    %esp,%ebp
80101d43:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101d46:	6a 0e                	push   $0xe
80101d48:	ff 75 0c             	pushl  0xc(%ebp)
80101d4b:	ff 75 08             	pushl  0x8(%ebp)
80101d4e:	e8 ad 29 00 00       	call   80104700 <strncmp>
}
80101d53:	c9                   	leave  
80101d54:	c3                   	ret    
80101d55:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101d60 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101d60:	55                   	push   %ebp
80101d61:	89 e5                	mov    %esp,%ebp
80101d63:	57                   	push   %edi
80101d64:	56                   	push   %esi
80101d65:	53                   	push   %ebx
80101d66:	83 ec 1c             	sub    $0x1c,%esp
80101d69:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101d6c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101d71:	0f 85 80 00 00 00    	jne    80101df7 <dirlookup+0x97>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101d77:	8b 53 58             	mov    0x58(%ebx),%edx
80101d7a:	31 ff                	xor    %edi,%edi
80101d7c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101d7f:	85 d2                	test   %edx,%edx
80101d81:	75 0d                	jne    80101d90 <dirlookup+0x30>
80101d83:	eb 5b                	jmp    80101de0 <dirlookup+0x80>
80101d85:	8d 76 00             	lea    0x0(%esi),%esi
80101d88:	83 c7 10             	add    $0x10,%edi
80101d8b:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101d8e:	76 50                	jbe    80101de0 <dirlookup+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101d90:	6a 10                	push   $0x10
80101d92:	57                   	push   %edi
80101d93:	56                   	push   %esi
80101d94:	53                   	push   %ebx
80101d95:	e8 76 fd ff ff       	call   80101b10 <readi>
80101d9a:	83 c4 10             	add    $0x10,%esp
80101d9d:	83 f8 10             	cmp    $0x10,%eax
80101da0:	75 48                	jne    80101dea <dirlookup+0x8a>
      panic("dirlookup read");
    if(de.inum == 0)
80101da2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101da7:	74 df                	je     80101d88 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
80101da9:	8d 45 da             	lea    -0x26(%ebp),%eax
80101dac:	83 ec 04             	sub    $0x4,%esp
80101daf:	6a 0e                	push   $0xe
80101db1:	50                   	push   %eax
80101db2:	ff 75 0c             	pushl  0xc(%ebp)
80101db5:	e8 46 29 00 00       	call   80104700 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80101dba:	83 c4 10             	add    $0x10,%esp
80101dbd:	85 c0                	test   %eax,%eax
80101dbf:	75 c7                	jne    80101d88 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101dc1:	8b 45 10             	mov    0x10(%ebp),%eax
80101dc4:	85 c0                	test   %eax,%eax
80101dc6:	74 05                	je     80101dcd <dirlookup+0x6d>
        *poff = off;
80101dc8:	8b 45 10             	mov    0x10(%ebp),%eax
80101dcb:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
      return iget(dp->dev, inum);
80101dcd:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80101dd1:	8b 03                	mov    (%ebx),%eax
80101dd3:	e8 f8 f5 ff ff       	call   801013d0 <iget>
    }
  }

  return 0;
}
80101dd8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ddb:	5b                   	pop    %ebx
80101ddc:	5e                   	pop    %esi
80101ddd:	5f                   	pop    %edi
80101dde:	5d                   	pop    %ebp
80101ddf:	c3                   	ret    
80101de0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101de3:	31 c0                	xor    %eax,%eax
}
80101de5:	5b                   	pop    %ebx
80101de6:	5e                   	pop    %esi
80101de7:	5f                   	pop    %edi
80101de8:	5d                   	pop    %ebp
80101de9:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
80101dea:	83 ec 0c             	sub    $0xc,%esp
80101ded:	68 d9 72 10 80       	push   $0x801072d9
80101df2:	e8 79 e5 ff ff       	call   80100370 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101df7:	83 ec 0c             	sub    $0xc,%esp
80101dfa:	68 c7 72 10 80       	push   $0x801072c7
80101dff:	e8 6c e5 ff ff       	call   80100370 <panic>
80101e04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101e0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101e10 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101e10:	55                   	push   %ebp
80101e11:	89 e5                	mov    %esp,%ebp
80101e13:	57                   	push   %edi
80101e14:	56                   	push   %esi
80101e15:	53                   	push   %ebx
80101e16:	89 cf                	mov    %ecx,%edi
80101e18:	89 c3                	mov    %eax,%ebx
80101e1a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101e1d:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101e20:	89 55 e0             	mov    %edx,-0x20(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101e23:	0f 84 53 01 00 00    	je     80101f7c <namex+0x16c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101e29:	e8 12 1b 00 00       	call   80103940 <myproc>
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101e2e:	83 ec 0c             	sub    $0xc,%esp
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101e31:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101e34:	68 80 19 11 80       	push   $0x80111980
80101e39:	e8 22 26 00 00       	call   80104460 <acquire>
  ip->ref++;
80101e3e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101e42:	c7 04 24 80 19 11 80 	movl   $0x80111980,(%esp)
80101e49:	e8 32 27 00 00       	call   80104580 <release>
80101e4e:	83 c4 10             	add    $0x10,%esp
80101e51:	eb 08                	jmp    80101e5b <namex+0x4b>
80101e53:	90                   	nop
80101e54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101e58:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101e5b:	0f b6 03             	movzbl (%ebx),%eax
80101e5e:	3c 2f                	cmp    $0x2f,%al
80101e60:	74 f6                	je     80101e58 <namex+0x48>
    path++;
  if(*path == 0)
80101e62:	84 c0                	test   %al,%al
80101e64:	0f 84 e3 00 00 00    	je     80101f4d <namex+0x13d>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101e6a:	0f b6 03             	movzbl (%ebx),%eax
80101e6d:	89 da                	mov    %ebx,%edx
80101e6f:	84 c0                	test   %al,%al
80101e71:	0f 84 ac 00 00 00    	je     80101f23 <namex+0x113>
80101e77:	3c 2f                	cmp    $0x2f,%al
80101e79:	75 09                	jne    80101e84 <namex+0x74>
80101e7b:	e9 a3 00 00 00       	jmp    80101f23 <namex+0x113>
80101e80:	84 c0                	test   %al,%al
80101e82:	74 0a                	je     80101e8e <namex+0x7e>
    path++;
80101e84:	83 c2 01             	add    $0x1,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101e87:	0f b6 02             	movzbl (%edx),%eax
80101e8a:	3c 2f                	cmp    $0x2f,%al
80101e8c:	75 f2                	jne    80101e80 <namex+0x70>
80101e8e:	89 d1                	mov    %edx,%ecx
80101e90:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101e92:	83 f9 0d             	cmp    $0xd,%ecx
80101e95:	0f 8e 8d 00 00 00    	jle    80101f28 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101e9b:	83 ec 04             	sub    $0x4,%esp
80101e9e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101ea1:	6a 0e                	push   $0xe
80101ea3:	53                   	push   %ebx
80101ea4:	57                   	push   %edi
80101ea5:	e8 d6 27 00 00       	call   80104680 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101eaa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
80101ead:	83 c4 10             	add    $0x10,%esp
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101eb0:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101eb2:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101eb5:	75 11                	jne    80101ec8 <namex+0xb8>
80101eb7:	89 f6                	mov    %esi,%esi
80101eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101ec0:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101ec3:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101ec6:	74 f8                	je     80101ec0 <namex+0xb0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101ec8:	83 ec 0c             	sub    $0xc,%esp
80101ecb:	56                   	push   %esi
80101ecc:	e8 5f f9 ff ff       	call   80101830 <ilock>
    if(ip->type != T_DIR){
80101ed1:	83 c4 10             	add    $0x10,%esp
80101ed4:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101ed9:	0f 85 7f 00 00 00    	jne    80101f5e <namex+0x14e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101edf:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101ee2:	85 d2                	test   %edx,%edx
80101ee4:	74 09                	je     80101eef <namex+0xdf>
80101ee6:	80 3b 00             	cmpb   $0x0,(%ebx)
80101ee9:	0f 84 a3 00 00 00    	je     80101f92 <namex+0x182>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101eef:	83 ec 04             	sub    $0x4,%esp
80101ef2:	6a 00                	push   $0x0
80101ef4:	57                   	push   %edi
80101ef5:	56                   	push   %esi
80101ef6:	e8 65 fe ff ff       	call   80101d60 <dirlookup>
80101efb:	83 c4 10             	add    $0x10,%esp
80101efe:	85 c0                	test   %eax,%eax
80101f00:	74 5c                	je     80101f5e <namex+0x14e>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101f02:	83 ec 0c             	sub    $0xc,%esp
80101f05:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101f08:	56                   	push   %esi
80101f09:	e8 02 fa ff ff       	call   80101910 <iunlock>
  iput(ip);
80101f0e:	89 34 24             	mov    %esi,(%esp)
80101f11:	e8 4a fa ff ff       	call   80101960 <iput>
80101f16:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101f19:	83 c4 10             	add    $0x10,%esp
80101f1c:	89 c6                	mov    %eax,%esi
80101f1e:	e9 38 ff ff ff       	jmp    80101e5b <namex+0x4b>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101f23:	31 c9                	xor    %ecx,%ecx
80101f25:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101f28:	83 ec 04             	sub    $0x4,%esp
80101f2b:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101f2e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101f31:	51                   	push   %ecx
80101f32:	53                   	push   %ebx
80101f33:	57                   	push   %edi
80101f34:	e8 47 27 00 00       	call   80104680 <memmove>
    name[len] = 0;
80101f39:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101f3c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101f3f:	83 c4 10             	add    $0x10,%esp
80101f42:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101f46:	89 d3                	mov    %edx,%ebx
80101f48:	e9 65 ff ff ff       	jmp    80101eb2 <namex+0xa2>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101f4d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101f50:	85 c0                	test   %eax,%eax
80101f52:	75 54                	jne    80101fa8 <namex+0x198>
80101f54:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101f56:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f59:	5b                   	pop    %ebx
80101f5a:	5e                   	pop    %esi
80101f5b:	5f                   	pop    %edi
80101f5c:	5d                   	pop    %ebp
80101f5d:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101f5e:	83 ec 0c             	sub    $0xc,%esp
80101f61:	56                   	push   %esi
80101f62:	e8 a9 f9 ff ff       	call   80101910 <iunlock>
  iput(ip);
80101f67:	89 34 24             	mov    %esi,(%esp)
80101f6a:	e8 f1 f9 ff ff       	call   80101960 <iput>
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101f6f:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101f72:	8d 65 f4             	lea    -0xc(%ebp),%esp
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101f75:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101f77:	5b                   	pop    %ebx
80101f78:	5e                   	pop    %esi
80101f79:	5f                   	pop    %edi
80101f7a:	5d                   	pop    %ebp
80101f7b:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101f7c:	ba 01 00 00 00       	mov    $0x1,%edx
80101f81:	b8 01 00 00 00       	mov    $0x1,%eax
80101f86:	e8 45 f4 ff ff       	call   801013d0 <iget>
80101f8b:	89 c6                	mov    %eax,%esi
80101f8d:	e9 c9 fe ff ff       	jmp    80101e5b <namex+0x4b>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101f92:	83 ec 0c             	sub    $0xc,%esp
80101f95:	56                   	push   %esi
80101f96:	e8 75 f9 ff ff       	call   80101910 <iunlock>
      return ip;
80101f9b:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101f9e:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
      return ip;
80101fa1:	89 f0                	mov    %esi,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101fa3:	5b                   	pop    %ebx
80101fa4:	5e                   	pop    %esi
80101fa5:	5f                   	pop    %edi
80101fa6:	5d                   	pop    %ebp
80101fa7:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101fa8:	83 ec 0c             	sub    $0xc,%esp
80101fab:	56                   	push   %esi
80101fac:	e8 af f9 ff ff       	call   80101960 <iput>
    return 0;
80101fb1:	83 c4 10             	add    $0x10,%esp
80101fb4:	31 c0                	xor    %eax,%eax
80101fb6:	eb 9e                	jmp    80101f56 <namex+0x146>
80101fb8:	90                   	nop
80101fb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101fc0 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101fc0:	55                   	push   %ebp
80101fc1:	89 e5                	mov    %esp,%ebp
80101fc3:	57                   	push   %edi
80101fc4:	56                   	push   %esi
80101fc5:	53                   	push   %ebx
80101fc6:	83 ec 20             	sub    $0x20,%esp
80101fc9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101fcc:	6a 00                	push   $0x0
80101fce:	ff 75 0c             	pushl  0xc(%ebp)
80101fd1:	53                   	push   %ebx
80101fd2:	e8 89 fd ff ff       	call   80101d60 <dirlookup>
80101fd7:	83 c4 10             	add    $0x10,%esp
80101fda:	85 c0                	test   %eax,%eax
80101fdc:	75 67                	jne    80102045 <dirlink+0x85>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101fde:	8b 7b 58             	mov    0x58(%ebx),%edi
80101fe1:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101fe4:	85 ff                	test   %edi,%edi
80101fe6:	74 29                	je     80102011 <dirlink+0x51>
80101fe8:	31 ff                	xor    %edi,%edi
80101fea:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101fed:	eb 09                	jmp    80101ff8 <dirlink+0x38>
80101fef:	90                   	nop
80101ff0:	83 c7 10             	add    $0x10,%edi
80101ff3:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101ff6:	76 19                	jbe    80102011 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ff8:	6a 10                	push   $0x10
80101ffa:	57                   	push   %edi
80101ffb:	56                   	push   %esi
80101ffc:	53                   	push   %ebx
80101ffd:	e8 0e fb ff ff       	call   80101b10 <readi>
80102002:	83 c4 10             	add    $0x10,%esp
80102005:	83 f8 10             	cmp    $0x10,%eax
80102008:	75 4e                	jne    80102058 <dirlink+0x98>
      panic("dirlink read");
    if(de.inum == 0)
8010200a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010200f:	75 df                	jne    80101ff0 <dirlink+0x30>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80102011:	8d 45 da             	lea    -0x26(%ebp),%eax
80102014:	83 ec 04             	sub    $0x4,%esp
80102017:	6a 0e                	push   $0xe
80102019:	ff 75 0c             	pushl  0xc(%ebp)
8010201c:	50                   	push   %eax
8010201d:	e8 4e 27 00 00       	call   80104770 <strncpy>
  de.inum = inum;
80102022:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102025:	6a 10                	push   $0x10
80102027:	57                   	push   %edi
80102028:	56                   	push   %esi
80102029:	53                   	push   %ebx
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
8010202a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010202e:	e8 dd fb ff ff       	call   80101c10 <writei>
80102033:	83 c4 20             	add    $0x20,%esp
80102036:	83 f8 10             	cmp    $0x10,%eax
80102039:	75 2a                	jne    80102065 <dirlink+0xa5>
    panic("dirlink");

  return 0;
8010203b:	31 c0                	xor    %eax,%eax
}
8010203d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102040:	5b                   	pop    %ebx
80102041:	5e                   	pop    %esi
80102042:	5f                   	pop    %edi
80102043:	5d                   	pop    %ebp
80102044:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80102045:	83 ec 0c             	sub    $0xc,%esp
80102048:	50                   	push   %eax
80102049:	e8 12 f9 ff ff       	call   80101960 <iput>
    return -1;
8010204e:	83 c4 10             	add    $0x10,%esp
80102051:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102056:	eb e5                	jmp    8010203d <dirlink+0x7d>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80102058:	83 ec 0c             	sub    $0xc,%esp
8010205b:	68 e8 72 10 80       	push   $0x801072e8
80102060:	e8 0b e3 ff ff       	call   80100370 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80102065:	83 ec 0c             	sub    $0xc,%esp
80102068:	68 ea 78 10 80       	push   $0x801078ea
8010206d:	e8 fe e2 ff ff       	call   80100370 <panic>
80102072:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102080 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80102080:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102081:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80102083:	89 e5                	mov    %esp,%ebp
80102085:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102088:	8b 45 08             	mov    0x8(%ebp),%eax
8010208b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010208e:	e8 7d fd ff ff       	call   80101e10 <namex>
}
80102093:	c9                   	leave  
80102094:	c3                   	ret    
80102095:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801020a0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801020a0:	55                   	push   %ebp
  return namex(path, 1, name);
801020a1:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
801020a6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
801020a8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801020ab:	8b 45 08             	mov    0x8(%ebp),%eax
}
801020ae:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
801020af:	e9 5c fd ff ff       	jmp    80101e10 <namex>
801020b4:	66 90                	xchg   %ax,%ax
801020b6:	66 90                	xchg   %ax,%ax
801020b8:	66 90                	xchg   %ax,%ax
801020ba:	66 90                	xchg   %ax,%ax
801020bc:	66 90                	xchg   %ax,%ax
801020be:	66 90                	xchg   %ax,%ax

801020c0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801020c0:	55                   	push   %ebp
  if(b == 0)
801020c1:	85 c0                	test   %eax,%eax
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801020c3:	89 e5                	mov    %esp,%ebp
801020c5:	56                   	push   %esi
801020c6:	53                   	push   %ebx
  if(b == 0)
801020c7:	0f 84 ad 00 00 00    	je     8010217a <idestart+0xba>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801020cd:	8b 58 08             	mov    0x8(%eax),%ebx
801020d0:	89 c1                	mov    %eax,%ecx
801020d2:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
801020d8:	0f 87 8f 00 00 00    	ja     8010216d <idestart+0xad>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020de:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020e3:	90                   	nop
801020e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801020e8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020e9:	83 e0 c0             	and    $0xffffffc0,%eax
801020ec:	3c 40                	cmp    $0x40,%al
801020ee:	75 f8                	jne    801020e8 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801020f0:	31 f6                	xor    %esi,%esi
801020f2:	ba f6 03 00 00       	mov    $0x3f6,%edx
801020f7:	89 f0                	mov    %esi,%eax
801020f9:	ee                   	out    %al,(%dx)
801020fa:	ba f2 01 00 00       	mov    $0x1f2,%edx
801020ff:	b8 01 00 00 00       	mov    $0x1,%eax
80102104:	ee                   	out    %al,(%dx)
80102105:	ba f3 01 00 00       	mov    $0x1f3,%edx
8010210a:	89 d8                	mov    %ebx,%eax
8010210c:	ee                   	out    %al,(%dx)
8010210d:	89 d8                	mov    %ebx,%eax
8010210f:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102114:	c1 f8 08             	sar    $0x8,%eax
80102117:	ee                   	out    %al,(%dx)
80102118:	ba f5 01 00 00       	mov    $0x1f5,%edx
8010211d:	89 f0                	mov    %esi,%eax
8010211f:	ee                   	out    %al,(%dx)
80102120:	0f b6 41 04          	movzbl 0x4(%ecx),%eax
80102124:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102129:	83 e0 01             	and    $0x1,%eax
8010212c:	c1 e0 04             	shl    $0x4,%eax
8010212f:	83 c8 e0             	or     $0xffffffe0,%eax
80102132:	ee                   	out    %al,(%dx)
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
80102133:	f6 01 04             	testb  $0x4,(%ecx)
80102136:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010213b:	75 13                	jne    80102150 <idestart+0x90>
8010213d:	b8 20 00 00 00       	mov    $0x20,%eax
80102142:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102143:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102146:	5b                   	pop    %ebx
80102147:	5e                   	pop    %esi
80102148:	5d                   	pop    %ebp
80102149:	c3                   	ret    
8010214a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102150:	b8 30 00 00 00       	mov    $0x30,%eax
80102155:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80102156:	ba f0 01 00 00       	mov    $0x1f0,%edx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
8010215b:	8d 71 5c             	lea    0x5c(%ecx),%esi
8010215e:	b9 80 00 00 00       	mov    $0x80,%ecx
80102163:	fc                   	cld    
80102164:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102166:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102169:	5b                   	pop    %ebx
8010216a:	5e                   	pop    %esi
8010216b:	5d                   	pop    %ebp
8010216c:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
8010216d:	83 ec 0c             	sub    $0xc,%esp
80102170:	68 54 73 10 80       	push   $0x80107354
80102175:	e8 f6 e1 ff ff       	call   80100370 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
8010217a:	83 ec 0c             	sub    $0xc,%esp
8010217d:	68 4b 73 10 80       	push   $0x8010734b
80102182:	e8 e9 e1 ff ff       	call   80100370 <panic>
80102187:	89 f6                	mov    %esi,%esi
80102189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102190 <ideinit>:
  return 0;
}

void
ideinit(void)
{
80102190:	55                   	push   %ebp
80102191:	89 e5                	mov    %esp,%ebp
80102193:	83 ec 10             	sub    $0x10,%esp
  int i;

  initlock(&idelock, "ide");
80102196:	68 66 73 10 80       	push   $0x80107366
8010219b:	68 20 b5 10 80       	push   $0x8010b520
801021a0:	e8 bb 21 00 00       	call   80104360 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801021a5:	58                   	pop    %eax
801021a6:	a1 a0 3c 11 80       	mov    0x80113ca0,%eax
801021ab:	5a                   	pop    %edx
801021ac:	83 e8 01             	sub    $0x1,%eax
801021af:	50                   	push   %eax
801021b0:	6a 0e                	push   $0xe
801021b2:	e8 a9 02 00 00       	call   80102460 <ioapicenable>
801021b7:	83 c4 10             	add    $0x10,%esp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021ba:	ba f7 01 00 00       	mov    $0x1f7,%edx
801021bf:	90                   	nop
801021c0:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021c1:	83 e0 c0             	and    $0xffffffc0,%eax
801021c4:	3c 40                	cmp    $0x40,%al
801021c6:	75 f8                	jne    801021c0 <ideinit+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801021c8:	ba f6 01 00 00       	mov    $0x1f6,%edx
801021cd:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801021d2:	ee                   	out    %al,(%dx)
801021d3:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021d8:	ba f7 01 00 00       	mov    $0x1f7,%edx
801021dd:	eb 06                	jmp    801021e5 <ideinit+0x55>
801021df:	90                   	nop
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
801021e0:	83 e9 01             	sub    $0x1,%ecx
801021e3:	74 0f                	je     801021f4 <ideinit+0x64>
801021e5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801021e6:	84 c0                	test   %al,%al
801021e8:	74 f6                	je     801021e0 <ideinit+0x50>
      havedisk1 = 1;
801021ea:	c7 05 00 b5 10 80 01 	movl   $0x1,0x8010b500
801021f1:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801021f4:	ba f6 01 00 00       	mov    $0x1f6,%edx
801021f9:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801021fe:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
801021ff:	c9                   	leave  
80102200:	c3                   	ret    
80102201:	eb 0d                	jmp    80102210 <ideintr>
80102203:	90                   	nop
80102204:	90                   	nop
80102205:	90                   	nop
80102206:	90                   	nop
80102207:	90                   	nop
80102208:	90                   	nop
80102209:	90                   	nop
8010220a:	90                   	nop
8010220b:	90                   	nop
8010220c:	90                   	nop
8010220d:	90                   	nop
8010220e:	90                   	nop
8010220f:	90                   	nop

80102210 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
80102210:	55                   	push   %ebp
80102211:	89 e5                	mov    %esp,%ebp
80102213:	57                   	push   %edi
80102214:	56                   	push   %esi
80102215:	53                   	push   %ebx
80102216:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102219:	68 20 b5 10 80       	push   $0x8010b520
8010221e:	e8 3d 22 00 00       	call   80104460 <acquire>

  if((b = idequeue) == 0){
80102223:	8b 1d 04 b5 10 80    	mov    0x8010b504,%ebx
80102229:	83 c4 10             	add    $0x10,%esp
8010222c:	85 db                	test   %ebx,%ebx
8010222e:	74 34                	je     80102264 <ideintr+0x54>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102230:	8b 43 58             	mov    0x58(%ebx),%eax
80102233:	a3 04 b5 10 80       	mov    %eax,0x8010b504

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102238:	8b 33                	mov    (%ebx),%esi
8010223a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102240:	74 3e                	je     80102280 <ideintr+0x70>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102242:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102245:	83 ec 0c             	sub    $0xc,%esp
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102248:	83 ce 02             	or     $0x2,%esi
8010224b:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010224d:	53                   	push   %ebx
8010224e:	e8 4d 1e 00 00       	call   801040a0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102253:	a1 04 b5 10 80       	mov    0x8010b504,%eax
80102258:	83 c4 10             	add    $0x10,%esp
8010225b:	85 c0                	test   %eax,%eax
8010225d:	74 05                	je     80102264 <ideintr+0x54>
    idestart(idequeue);
8010225f:	e8 5c fe ff ff       	call   801020c0 <idestart>

  // First queued buffer is the active request.
  acquire(&idelock);

  if((b = idequeue) == 0){
    release(&idelock);
80102264:	83 ec 0c             	sub    $0xc,%esp
80102267:	68 20 b5 10 80       	push   $0x8010b520
8010226c:	e8 0f 23 00 00       	call   80104580 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
80102271:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102274:	5b                   	pop    %ebx
80102275:	5e                   	pop    %esi
80102276:	5f                   	pop    %edi
80102277:	5d                   	pop    %ebp
80102278:	c3                   	ret    
80102279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102280:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102285:	8d 76 00             	lea    0x0(%esi),%esi
80102288:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102289:	89 c1                	mov    %eax,%ecx
8010228b:	83 e1 c0             	and    $0xffffffc0,%ecx
8010228e:	80 f9 40             	cmp    $0x40,%cl
80102291:	75 f5                	jne    80102288 <ideintr+0x78>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102293:	a8 21                	test   $0x21,%al
80102295:	75 ab                	jne    80102242 <ideintr+0x32>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
80102297:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
8010229a:	b9 80 00 00 00       	mov    $0x80,%ecx
8010229f:	ba f0 01 00 00       	mov    $0x1f0,%edx
801022a4:	fc                   	cld    
801022a5:	f3 6d                	rep insl (%dx),%es:(%edi)
801022a7:	8b 33                	mov    (%ebx),%esi
801022a9:	eb 97                	jmp    80102242 <ideintr+0x32>
801022ab:	90                   	nop
801022ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801022b0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801022b0:	55                   	push   %ebp
801022b1:	89 e5                	mov    %esp,%ebp
801022b3:	53                   	push   %ebx
801022b4:	83 ec 10             	sub    $0x10,%esp
801022b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801022ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801022bd:	50                   	push   %eax
801022be:	e8 6d 20 00 00       	call   80104330 <holdingsleep>
801022c3:	83 c4 10             	add    $0x10,%esp
801022c6:	85 c0                	test   %eax,%eax
801022c8:	0f 84 ad 00 00 00    	je     8010237b <iderw+0xcb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801022ce:	8b 03                	mov    (%ebx),%eax
801022d0:	83 e0 06             	and    $0x6,%eax
801022d3:	83 f8 02             	cmp    $0x2,%eax
801022d6:	0f 84 b9 00 00 00    	je     80102395 <iderw+0xe5>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801022dc:	8b 53 04             	mov    0x4(%ebx),%edx
801022df:	85 d2                	test   %edx,%edx
801022e1:	74 0d                	je     801022f0 <iderw+0x40>
801022e3:	a1 00 b5 10 80       	mov    0x8010b500,%eax
801022e8:	85 c0                	test   %eax,%eax
801022ea:	0f 84 98 00 00 00    	je     80102388 <iderw+0xd8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801022f0:	83 ec 0c             	sub    $0xc,%esp
801022f3:	68 20 b5 10 80       	push   $0x8010b520
801022f8:	e8 63 21 00 00       	call   80104460 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022fd:	8b 15 04 b5 10 80    	mov    0x8010b504,%edx
80102303:	83 c4 10             	add    $0x10,%esp
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
80102306:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010230d:	85 d2                	test   %edx,%edx
8010230f:	75 09                	jne    8010231a <iderw+0x6a>
80102311:	eb 58                	jmp    8010236b <iderw+0xbb>
80102313:	90                   	nop
80102314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102318:	89 c2                	mov    %eax,%edx
8010231a:	8b 42 58             	mov    0x58(%edx),%eax
8010231d:	85 c0                	test   %eax,%eax
8010231f:	75 f7                	jne    80102318 <iderw+0x68>
80102321:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102324:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102326:	3b 1d 04 b5 10 80    	cmp    0x8010b504,%ebx
8010232c:	74 44                	je     80102372 <iderw+0xc2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010232e:	8b 03                	mov    (%ebx),%eax
80102330:	83 e0 06             	and    $0x6,%eax
80102333:	83 f8 02             	cmp    $0x2,%eax
80102336:	74 23                	je     8010235b <iderw+0xab>
80102338:	90                   	nop
80102339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102340:	83 ec 08             	sub    $0x8,%esp
80102343:	68 20 b5 10 80       	push   $0x8010b520
80102348:	53                   	push   %ebx
80102349:	e8 a2 1b 00 00       	call   80103ef0 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010234e:	8b 03                	mov    (%ebx),%eax
80102350:	83 c4 10             	add    $0x10,%esp
80102353:	83 e0 06             	and    $0x6,%eax
80102356:	83 f8 02             	cmp    $0x2,%eax
80102359:	75 e5                	jne    80102340 <iderw+0x90>
    sleep(b, &idelock);
  }


  release(&idelock);
8010235b:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
}
80102362:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102365:	c9                   	leave  
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }


  release(&idelock);
80102366:	e9 15 22 00 00       	jmp    80104580 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010236b:	ba 04 b5 10 80       	mov    $0x8010b504,%edx
80102370:	eb b2                	jmp    80102324 <iderw+0x74>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
80102372:	89 d8                	mov    %ebx,%eax
80102374:	e8 47 fd ff ff       	call   801020c0 <idestart>
80102379:	eb b3                	jmp    8010232e <iderw+0x7e>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
8010237b:	83 ec 0c             	sub    $0xc,%esp
8010237e:	68 6a 73 10 80       	push   $0x8010736a
80102383:	e8 e8 df ff ff       	call   80100370 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
80102388:	83 ec 0c             	sub    $0xc,%esp
8010238b:	68 95 73 10 80       	push   $0x80107395
80102390:	e8 db df ff ff       	call   80100370 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
80102395:	83 ec 0c             	sub    $0xc,%esp
80102398:	68 80 73 10 80       	push   $0x80107380
8010239d:	e8 ce df ff ff       	call   80100370 <panic>
801023a2:	66 90                	xchg   %ax,%ax
801023a4:	66 90                	xchg   %ax,%ax
801023a6:	66 90                	xchg   %ax,%ax
801023a8:	66 90                	xchg   %ax,%ax
801023aa:	66 90                	xchg   %ax,%ax
801023ac:	66 90                	xchg   %ax,%ax
801023ae:	66 90                	xchg   %ax,%ax

801023b0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801023b0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801023b1:	c7 05 d4 35 11 80 00 	movl   $0xfec00000,0x801135d4
801023b8:	00 c0 fe 
  ioapic->data = data;
}

void
ioapicinit(void)
{
801023bb:	89 e5                	mov    %esp,%ebp
801023bd:	56                   	push   %esi
801023be:	53                   	push   %ebx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
801023bf:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801023c6:	00 00 00 
  return ioapic->data;
801023c9:	8b 15 d4 35 11 80    	mov    0x801135d4,%edx
801023cf:	8b 72 10             	mov    0x10(%edx),%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
801023d2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801023d8:	8b 0d d4 35 11 80    	mov    0x801135d4,%ecx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801023de:	0f b6 15 00 37 11 80 	movzbl 0x80113700,%edx
ioapicinit(void)
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801023e5:	89 f0                	mov    %esi,%eax
801023e7:	c1 e8 10             	shr    $0x10,%eax
801023ea:	0f b6 f0             	movzbl %al,%esi

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
801023ed:	8b 41 10             	mov    0x10(%ecx),%eax
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801023f0:	c1 e8 18             	shr    $0x18,%eax
801023f3:	39 d0                	cmp    %edx,%eax
801023f5:	74 16                	je     8010240d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801023f7:	83 ec 0c             	sub    $0xc,%esp
801023fa:	68 b4 73 10 80       	push   $0x801073b4
801023ff:	e8 ac e2 ff ff       	call   801006b0 <cprintf>
80102404:	8b 0d d4 35 11 80    	mov    0x801135d4,%ecx
8010240a:	83 c4 10             	add    $0x10,%esp
8010240d:	83 c6 21             	add    $0x21,%esi
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102410:	ba 10 00 00 00       	mov    $0x10,%edx
80102415:	b8 20 00 00 00       	mov    $0x20,%eax
8010241a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102420:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102422:	8b 0d d4 35 11 80    	mov    0x801135d4,%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102428:	89 c3                	mov    %eax,%ebx
8010242a:	81 cb 00 00 01 00    	or     $0x10000,%ebx
80102430:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102433:	89 59 10             	mov    %ebx,0x10(%ecx)
80102436:	8d 5a 01             	lea    0x1(%edx),%ebx
80102439:	83 c2 02             	add    $0x2,%edx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010243c:	39 f0                	cmp    %esi,%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010243e:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
80102440:	8b 0d d4 35 11 80    	mov    0x801135d4,%ecx
80102446:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010244d:	75 d1                	jne    80102420 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010244f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102452:	5b                   	pop    %ebx
80102453:	5e                   	pop    %esi
80102454:	5d                   	pop    %ebp
80102455:	c3                   	ret    
80102456:	8d 76 00             	lea    0x0(%esi),%esi
80102459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102460 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102460:	55                   	push   %ebp
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102461:	8b 0d d4 35 11 80    	mov    0x801135d4,%ecx
  }
}

void
ioapicenable(int irq, int cpunum)
{
80102467:	89 e5                	mov    %esp,%ebp
80102469:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010246c:	8d 50 20             	lea    0x20(%eax),%edx
8010246f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102473:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102475:	8b 0d d4 35 11 80    	mov    0x801135d4,%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010247b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010247e:	89 51 10             	mov    %edx,0x10(%ecx)
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102481:	8b 55 0c             	mov    0xc(%ebp),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102484:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102486:	a1 d4 35 11 80       	mov    0x801135d4,%eax
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010248b:	c1 e2 18             	shl    $0x18,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
8010248e:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
80102491:	5d                   	pop    %ebp
80102492:	c3                   	ret    
80102493:	66 90                	xchg   %ax,%ax
80102495:	66 90                	xchg   %ax,%ax
80102497:	66 90                	xchg   %ax,%ax
80102499:	66 90                	xchg   %ax,%ax
8010249b:	66 90                	xchg   %ax,%ax
8010249d:	66 90                	xchg   %ax,%ax
8010249f:	90                   	nop

801024a0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801024a0:	55                   	push   %ebp
801024a1:	89 e5                	mov    %esp,%ebp
801024a3:	53                   	push   %ebx
801024a4:	83 ec 04             	sub    $0x4,%esp
801024a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801024aa:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801024b0:	75 70                	jne    80102522 <kfree+0x82>
801024b2:	81 fb 48 64 11 80    	cmp    $0x80116448,%ebx
801024b8:	72 68                	jb     80102522 <kfree+0x82>
801024ba:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801024c0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801024c5:	77 5b                	ja     80102522 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801024c7:	83 ec 04             	sub    $0x4,%esp
801024ca:	68 00 10 00 00       	push   $0x1000
801024cf:	6a 01                	push   $0x1
801024d1:	53                   	push   %ebx
801024d2:	e8 f9 20 00 00       	call   801045d0 <memset>

  if(kmem.use_lock)
801024d7:	8b 15 14 36 11 80    	mov    0x80113614,%edx
801024dd:	83 c4 10             	add    $0x10,%esp
801024e0:	85 d2                	test   %edx,%edx
801024e2:	75 2c                	jne    80102510 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801024e4:	a1 18 36 11 80       	mov    0x80113618,%eax
801024e9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801024eb:	a1 14 36 11 80       	mov    0x80113614,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
801024f0:	89 1d 18 36 11 80    	mov    %ebx,0x80113618
  if(kmem.use_lock)
801024f6:	85 c0                	test   %eax,%eax
801024f8:	75 06                	jne    80102500 <kfree+0x60>
    release(&kmem.lock);
}
801024fa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024fd:	c9                   	leave  
801024fe:	c3                   	ret    
801024ff:	90                   	nop
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102500:	c7 45 08 e0 35 11 80 	movl   $0x801135e0,0x8(%ebp)
}
80102507:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010250a:	c9                   	leave  
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
8010250b:	e9 70 20 00 00       	jmp    80104580 <release>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102510:	83 ec 0c             	sub    $0xc,%esp
80102513:	68 e0 35 11 80       	push   $0x801135e0
80102518:	e8 43 1f 00 00       	call   80104460 <acquire>
8010251d:	83 c4 10             	add    $0x10,%esp
80102520:	eb c2                	jmp    801024e4 <kfree+0x44>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
80102522:	83 ec 0c             	sub    $0xc,%esp
80102525:	68 e6 73 10 80       	push   $0x801073e6
8010252a:	e8 41 de ff ff       	call   80100370 <panic>
8010252f:	90                   	nop

80102530 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102530:	55                   	push   %ebp
80102531:	89 e5                	mov    %esp,%ebp
80102533:	56                   	push   %esi
80102534:	53                   	push   %ebx
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102535:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102538:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010253b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102541:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102547:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010254d:	39 de                	cmp    %ebx,%esi
8010254f:	72 23                	jb     80102574 <freerange+0x44>
80102551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102558:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010255e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102561:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102567:	50                   	push   %eax
80102568:	e8 33 ff ff ff       	call   801024a0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010256d:	83 c4 10             	add    $0x10,%esp
80102570:	39 f3                	cmp    %esi,%ebx
80102572:	76 e4                	jbe    80102558 <freerange+0x28>
    kfree(p);
}
80102574:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102577:	5b                   	pop    %ebx
80102578:	5e                   	pop    %esi
80102579:	5d                   	pop    %ebp
8010257a:	c3                   	ret    
8010257b:	90                   	nop
8010257c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102580 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102580:	55                   	push   %ebp
80102581:	89 e5                	mov    %esp,%ebp
80102583:	56                   	push   %esi
80102584:	53                   	push   %ebx
80102585:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102588:	83 ec 08             	sub    $0x8,%esp
8010258b:	68 ec 73 10 80       	push   $0x801073ec
80102590:	68 e0 35 11 80       	push   $0x801135e0
80102595:	e8 c6 1d 00 00       	call   80104360 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010259a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010259d:	83 c4 10             	add    $0x10,%esp
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
801025a0:	c7 05 14 36 11 80 00 	movl   $0x0,0x80113614
801025a7:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801025aa:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801025b0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025b6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801025bc:	39 de                	cmp    %ebx,%esi
801025be:	72 1c                	jb     801025dc <kinit1+0x5c>
    kfree(p);
801025c0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801025c6:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025c9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801025cf:	50                   	push   %eax
801025d0:	e8 cb fe ff ff       	call   801024a0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025d5:	83 c4 10             	add    $0x10,%esp
801025d8:	39 de                	cmp    %ebx,%esi
801025da:	73 e4                	jae    801025c0 <kinit1+0x40>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
801025dc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025df:	5b                   	pop    %ebx
801025e0:	5e                   	pop    %esi
801025e1:	5d                   	pop    %ebp
801025e2:	c3                   	ret    
801025e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801025e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801025f0 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
801025f0:	55                   	push   %ebp
801025f1:	89 e5                	mov    %esp,%ebp
801025f3:	56                   	push   %esi
801025f4:	53                   	push   %ebx

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801025f5:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
801025f8:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801025fb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102601:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102607:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010260d:	39 de                	cmp    %ebx,%esi
8010260f:	72 23                	jb     80102634 <kinit2+0x44>
80102611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102618:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010261e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102621:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102627:	50                   	push   %eax
80102628:	e8 73 fe ff ff       	call   801024a0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010262d:	83 c4 10             	add    $0x10,%esp
80102630:	39 de                	cmp    %ebx,%esi
80102632:	73 e4                	jae    80102618 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
80102634:	c7 05 14 36 11 80 01 	movl   $0x1,0x80113614
8010263b:	00 00 00 
}
8010263e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102641:	5b                   	pop    %ebx
80102642:	5e                   	pop    %esi
80102643:	5d                   	pop    %ebp
80102644:	c3                   	ret    
80102645:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102650 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102650:	55                   	push   %ebp
80102651:	89 e5                	mov    %esp,%ebp
80102653:	53                   	push   %ebx
80102654:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102657:	a1 14 36 11 80       	mov    0x80113614,%eax
8010265c:	85 c0                	test   %eax,%eax
8010265e:	75 30                	jne    80102690 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102660:	8b 1d 18 36 11 80    	mov    0x80113618,%ebx
  if(r)
80102666:	85 db                	test   %ebx,%ebx
80102668:	74 1c                	je     80102686 <kalloc+0x36>
    kmem.freelist = r->next;
8010266a:	8b 13                	mov    (%ebx),%edx
8010266c:	89 15 18 36 11 80    	mov    %edx,0x80113618
  if(kmem.use_lock)
80102672:	85 c0                	test   %eax,%eax
80102674:	74 10                	je     80102686 <kalloc+0x36>
    release(&kmem.lock);
80102676:	83 ec 0c             	sub    $0xc,%esp
80102679:	68 e0 35 11 80       	push   $0x801135e0
8010267e:	e8 fd 1e 00 00       	call   80104580 <release>
80102683:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
}
80102686:	89 d8                	mov    %ebx,%eax
80102688:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010268b:	c9                   	leave  
8010268c:	c3                   	ret    
8010268d:	8d 76 00             	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102690:	83 ec 0c             	sub    $0xc,%esp
80102693:	68 e0 35 11 80       	push   $0x801135e0
80102698:	e8 c3 1d 00 00       	call   80104460 <acquire>
  r = kmem.freelist;
8010269d:	8b 1d 18 36 11 80    	mov    0x80113618,%ebx
  if(r)
801026a3:	83 c4 10             	add    $0x10,%esp
801026a6:	a1 14 36 11 80       	mov    0x80113614,%eax
801026ab:	85 db                	test   %ebx,%ebx
801026ad:	75 bb                	jne    8010266a <kalloc+0x1a>
801026af:	eb c1                	jmp    80102672 <kalloc+0x22>
801026b1:	66 90                	xchg   %ax,%ax
801026b3:	66 90                	xchg   %ax,%ax
801026b5:	66 90                	xchg   %ax,%ax
801026b7:	66 90                	xchg   %ax,%ax
801026b9:	66 90                	xchg   %ax,%ax
801026bb:	66 90                	xchg   %ax,%ax
801026bd:	66 90                	xchg   %ax,%ax
801026bf:	90                   	nop

801026c0 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
801026c0:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026c1:	ba 64 00 00 00       	mov    $0x64,%edx
801026c6:	89 e5                	mov    %esp,%ebp
801026c8:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801026c9:	a8 01                	test   $0x1,%al
801026cb:	0f 84 af 00 00 00    	je     80102780 <kbdgetc+0xc0>
801026d1:	ba 60 00 00 00       	mov    $0x60,%edx
801026d6:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
801026d7:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
801026da:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
801026e0:	74 7e                	je     80102760 <kbdgetc+0xa0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801026e2:	84 c0                	test   %al,%al
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801026e4:	8b 0d 54 b5 10 80    	mov    0x8010b554,%ecx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801026ea:	79 24                	jns    80102710 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801026ec:	f6 c1 40             	test   $0x40,%cl
801026ef:	75 05                	jne    801026f6 <kbdgetc+0x36>
801026f1:	89 c2                	mov    %eax,%edx
801026f3:	83 e2 7f             	and    $0x7f,%edx
    shift &= ~(shiftcode[data] | E0ESC);
801026f6:	0f b6 82 20 75 10 80 	movzbl -0x7fef8ae0(%edx),%eax
801026fd:	83 c8 40             	or     $0x40,%eax
80102700:	0f b6 c0             	movzbl %al,%eax
80102703:	f7 d0                	not    %eax
80102705:	21 c8                	and    %ecx,%eax
80102707:	a3 54 b5 10 80       	mov    %eax,0x8010b554
    return 0;
8010270c:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010270e:	5d                   	pop    %ebp
8010270f:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102710:	f6 c1 40             	test   $0x40,%cl
80102713:	74 09                	je     8010271e <kbdgetc+0x5e>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102715:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102718:	83 e1 bf             	and    $0xffffffbf,%ecx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010271b:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
8010271e:	0f b6 82 20 75 10 80 	movzbl -0x7fef8ae0(%edx),%eax
80102725:	09 c1                	or     %eax,%ecx
80102727:	0f b6 82 20 74 10 80 	movzbl -0x7fef8be0(%edx),%eax
8010272e:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102730:	89 c8                	mov    %ecx,%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80102732:	89 0d 54 b5 10 80    	mov    %ecx,0x8010b554
  c = charcode[shift & (CTL | SHIFT)][data];
80102738:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010273b:	83 e1 08             	and    $0x8,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
8010273e:	8b 04 85 00 74 10 80 	mov    -0x7fef8c00(,%eax,4),%eax
80102745:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102749:	74 c3                	je     8010270e <kbdgetc+0x4e>
    if('a' <= c && c <= 'z')
8010274b:	8d 50 9f             	lea    -0x61(%eax),%edx
8010274e:	83 fa 19             	cmp    $0x19,%edx
80102751:	77 1d                	ja     80102770 <kbdgetc+0xb0>
      c += 'A' - 'a';
80102753:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102756:	5d                   	pop    %ebp
80102757:	c3                   	ret    
80102758:	90                   	nop
80102759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
80102760:	31 c0                	xor    %eax,%eax
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102762:	83 0d 54 b5 10 80 40 	orl    $0x40,0x8010b554
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102769:	5d                   	pop    %ebp
8010276a:	c3                   	ret    
8010276b:	90                   	nop
8010276c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
80102770:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102773:	8d 50 20             	lea    0x20(%eax),%edx
  }
  return c;
}
80102776:	5d                   	pop    %ebp
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
80102777:	83 f9 19             	cmp    $0x19,%ecx
8010277a:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
8010277d:	c3                   	ret    
8010277e:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
80102780:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102785:	5d                   	pop    %ebp
80102786:	c3                   	ret    
80102787:	89 f6                	mov    %esi,%esi
80102789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102790 <kbdintr>:

void
kbdintr(void)
{
80102790:	55                   	push   %ebp
80102791:	89 e5                	mov    %esp,%ebp
80102793:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102796:	68 c0 26 10 80       	push   $0x801026c0
8010279b:	e8 10 e2 ff ff       	call   801009b0 <consoleintr>
}
801027a0:	83 c4 10             	add    $0x10,%esp
801027a3:	c9                   	leave  
801027a4:	c3                   	ret    
801027a5:	66 90                	xchg   %ax,%ax
801027a7:	66 90                	xchg   %ax,%ax
801027a9:	66 90                	xchg   %ax,%ax
801027ab:	66 90                	xchg   %ax,%ax
801027ad:	66 90                	xchg   %ax,%ax
801027af:	90                   	nop

801027b0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801027b0:	a1 1c 36 11 80       	mov    0x8011361c,%eax
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
801027b5:	55                   	push   %ebp
801027b6:	89 e5                	mov    %esp,%ebp
  if(!lapic)
801027b8:	85 c0                	test   %eax,%eax
801027ba:	0f 84 c8 00 00 00    	je     80102888 <lapicinit+0xd8>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027c0:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801027c7:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027ca:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027cd:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801027d4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027d7:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027da:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801027e1:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801027e4:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027e7:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801027ee:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801027f1:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027f4:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801027fb:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801027fe:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102801:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102808:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010280b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010280e:	8b 50 30             	mov    0x30(%eax),%edx
80102811:	c1 ea 10             	shr    $0x10,%edx
80102814:	80 fa 03             	cmp    $0x3,%dl
80102817:	77 77                	ja     80102890 <lapicinit+0xe0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102819:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102820:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102823:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102826:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010282d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102830:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102833:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010283a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010283d:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102840:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102847:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010284a:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010284d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102854:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102857:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010285a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102861:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102864:	8b 50 20             	mov    0x20(%eax),%edx
80102867:	89 f6                	mov    %esi,%esi
80102869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102870:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102876:	80 e6 10             	and    $0x10,%dh
80102879:	75 f5                	jne    80102870 <lapicinit+0xc0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010287b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102882:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102885:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102888:	5d                   	pop    %ebp
80102889:	c3                   	ret    
8010288a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102890:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102897:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010289a:	8b 50 20             	mov    0x20(%eax),%edx
8010289d:	e9 77 ff ff ff       	jmp    80102819 <lapicinit+0x69>
801028a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801028b0 <lapicid>:
}

int
lapicid(void)
{
  if (!lapic)
801028b0:	a1 1c 36 11 80       	mov    0x8011361c,%eax
  lapicw(TPR, 0);
}

int
lapicid(void)
{
801028b5:	55                   	push   %ebp
801028b6:	89 e5                	mov    %esp,%ebp
  if (!lapic)
801028b8:	85 c0                	test   %eax,%eax
801028ba:	74 0c                	je     801028c8 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
801028bc:	8b 40 20             	mov    0x20(%eax),%eax
}
801028bf:	5d                   	pop    %ebp
int
lapicid(void)
{
  if (!lapic)
    return 0;
  return lapic[ID] >> 24;
801028c0:	c1 e8 18             	shr    $0x18,%eax
}
801028c3:	c3                   	ret    
801028c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

int
lapicid(void)
{
  if (!lapic)
    return 0;
801028c8:	31 c0                	xor    %eax,%eax
  return lapic[ID] >> 24;
}
801028ca:	5d                   	pop    %ebp
801028cb:	c3                   	ret    
801028cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801028d0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801028d0:	a1 1c 36 11 80       	mov    0x8011361c,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
801028d5:	55                   	push   %ebp
801028d6:	89 e5                	mov    %esp,%ebp
  if(lapic)
801028d8:	85 c0                	test   %eax,%eax
801028da:	74 0d                	je     801028e9 <lapiceoi+0x19>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028dc:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801028e3:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028e6:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
801028e9:	5d                   	pop    %ebp
801028ea:	c3                   	ret    
801028eb:	90                   	nop
801028ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801028f0 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
801028f0:	55                   	push   %ebp
801028f1:	89 e5                	mov    %esp,%ebp
}
801028f3:	5d                   	pop    %ebp
801028f4:	c3                   	ret    
801028f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801028f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102900 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102900:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102901:	ba 70 00 00 00       	mov    $0x70,%edx
80102906:	b8 0f 00 00 00       	mov    $0xf,%eax
8010290b:	89 e5                	mov    %esp,%ebp
8010290d:	53                   	push   %ebx
8010290e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102911:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102914:	ee                   	out    %al,(%dx)
80102915:	ba 71 00 00 00       	mov    $0x71,%edx
8010291a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010291f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102920:	31 c0                	xor    %eax,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102922:	c1 e3 18             	shl    $0x18,%ebx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102925:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010292b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010292d:	c1 e9 0c             	shr    $0xc,%ecx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102930:	c1 e8 04             	shr    $0x4,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102933:	89 da                	mov    %ebx,%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102935:	80 cd 06             	or     $0x6,%ch
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102938:	66 a3 69 04 00 80    	mov    %ax,0x80000469

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010293e:	a1 1c 36 11 80       	mov    0x8011361c,%eax
80102943:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102949:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010294c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102953:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102956:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102959:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102960:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102963:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102966:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010296c:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010296f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102975:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102978:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010297e:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102981:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102987:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
8010298a:	5b                   	pop    %ebx
8010298b:	5d                   	pop    %ebp
8010298c:	c3                   	ret    
8010298d:	8d 76 00             	lea    0x0(%esi),%esi

80102990 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
80102990:	55                   	push   %ebp
80102991:	ba 70 00 00 00       	mov    $0x70,%edx
80102996:	b8 0b 00 00 00       	mov    $0xb,%eax
8010299b:	89 e5                	mov    %esp,%ebp
8010299d:	57                   	push   %edi
8010299e:	56                   	push   %esi
8010299f:	53                   	push   %ebx
801029a0:	83 ec 4c             	sub    $0x4c,%esp
801029a3:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029a4:	ba 71 00 00 00       	mov    $0x71,%edx
801029a9:	ec                   	in     (%dx),%al
801029aa:	83 e0 04             	and    $0x4,%eax
801029ad:	8d 75 d0             	lea    -0x30(%ebp),%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029b0:	31 db                	xor    %ebx,%ebx
801029b2:	88 45 b7             	mov    %al,-0x49(%ebp)
801029b5:	bf 70 00 00 00       	mov    $0x70,%edi
801029ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801029c0:	89 d8                	mov    %ebx,%eax
801029c2:	89 fa                	mov    %edi,%edx
801029c4:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029c5:	b9 71 00 00 00       	mov    $0x71,%ecx
801029ca:	89 ca                	mov    %ecx,%edx
801029cc:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
801029cd:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029d0:	89 fa                	mov    %edi,%edx
801029d2:	89 45 b8             	mov    %eax,-0x48(%ebp)
801029d5:	b8 02 00 00 00       	mov    $0x2,%eax
801029da:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029db:	89 ca                	mov    %ecx,%edx
801029dd:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
801029de:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029e1:	89 fa                	mov    %edi,%edx
801029e3:	89 45 bc             	mov    %eax,-0x44(%ebp)
801029e6:	b8 04 00 00 00       	mov    $0x4,%eax
801029eb:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ec:	89 ca                	mov    %ecx,%edx
801029ee:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
801029ef:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029f2:	89 fa                	mov    %edi,%edx
801029f4:	89 45 c0             	mov    %eax,-0x40(%ebp)
801029f7:	b8 07 00 00 00       	mov    $0x7,%eax
801029fc:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029fd:	89 ca                	mov    %ecx,%edx
801029ff:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102a00:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a03:	89 fa                	mov    %edi,%edx
80102a05:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102a08:	b8 08 00 00 00       	mov    $0x8,%eax
80102a0d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a0e:	89 ca                	mov    %ecx,%edx
80102a10:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102a11:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a14:	89 fa                	mov    %edi,%edx
80102a16:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102a19:	b8 09 00 00 00       	mov    $0x9,%eax
80102a1e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a1f:	89 ca                	mov    %ecx,%edx
80102a21:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102a22:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a25:	89 fa                	mov    %edi,%edx
80102a27:	89 45 cc             	mov    %eax,-0x34(%ebp)
80102a2a:	b8 0a 00 00 00       	mov    $0xa,%eax
80102a2f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a30:	89 ca                	mov    %ecx,%edx
80102a32:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102a33:	84 c0                	test   %al,%al
80102a35:	78 89                	js     801029c0 <cmostime+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a37:	89 d8                	mov    %ebx,%eax
80102a39:	89 fa                	mov    %edi,%edx
80102a3b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a3c:	89 ca                	mov    %ecx,%edx
80102a3e:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
80102a3f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a42:	89 fa                	mov    %edi,%edx
80102a44:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102a47:	b8 02 00 00 00       	mov    $0x2,%eax
80102a4c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a4d:	89 ca                	mov    %ecx,%edx
80102a4f:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
80102a50:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a53:	89 fa                	mov    %edi,%edx
80102a55:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102a58:	b8 04 00 00 00       	mov    $0x4,%eax
80102a5d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a5e:	89 ca                	mov    %ecx,%edx
80102a60:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
80102a61:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a64:	89 fa                	mov    %edi,%edx
80102a66:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102a69:	b8 07 00 00 00       	mov    $0x7,%eax
80102a6e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a6f:	89 ca                	mov    %ecx,%edx
80102a71:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102a72:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a75:	89 fa                	mov    %edi,%edx
80102a77:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102a7a:	b8 08 00 00 00       	mov    $0x8,%eax
80102a7f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a80:	89 ca                	mov    %ecx,%edx
80102a82:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102a83:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a86:	89 fa                	mov    %edi,%edx
80102a88:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102a8b:	b8 09 00 00 00       	mov    $0x9,%eax
80102a90:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a91:	89 ca                	mov    %ecx,%edx
80102a93:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102a94:	0f b6 c0             	movzbl %al,%eax
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102a97:	83 ec 04             	sub    $0x4,%esp
  r->second = cmos_read(SECS);
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
80102a9a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102a9d:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102aa0:	6a 18                	push   $0x18
80102aa2:	56                   	push   %esi
80102aa3:	50                   	push   %eax
80102aa4:	e8 77 1b 00 00       	call   80104620 <memcmp>
80102aa9:	83 c4 10             	add    $0x10,%esp
80102aac:	85 c0                	test   %eax,%eax
80102aae:	0f 85 0c ff ff ff    	jne    801029c0 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80102ab4:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
80102ab8:	75 78                	jne    80102b32 <cmostime+0x1a2>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102aba:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102abd:	89 c2                	mov    %eax,%edx
80102abf:	83 e0 0f             	and    $0xf,%eax
80102ac2:	c1 ea 04             	shr    $0x4,%edx
80102ac5:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ac8:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102acb:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102ace:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102ad1:	89 c2                	mov    %eax,%edx
80102ad3:	83 e0 0f             	and    $0xf,%eax
80102ad6:	c1 ea 04             	shr    $0x4,%edx
80102ad9:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102adc:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102adf:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102ae2:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102ae5:	89 c2                	mov    %eax,%edx
80102ae7:	83 e0 0f             	and    $0xf,%eax
80102aea:	c1 ea 04             	shr    $0x4,%edx
80102aed:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102af0:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102af3:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102af6:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102af9:	89 c2                	mov    %eax,%edx
80102afb:	83 e0 0f             	and    $0xf,%eax
80102afe:	c1 ea 04             	shr    $0x4,%edx
80102b01:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b04:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b07:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102b0a:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b0d:	89 c2                	mov    %eax,%edx
80102b0f:	83 e0 0f             	and    $0xf,%eax
80102b12:	c1 ea 04             	shr    $0x4,%edx
80102b15:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b18:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b1b:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102b1e:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b21:	89 c2                	mov    %eax,%edx
80102b23:	83 e0 0f             	and    $0xf,%eax
80102b26:	c1 ea 04             	shr    $0x4,%edx
80102b29:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b2c:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b2f:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102b32:	8b 75 08             	mov    0x8(%ebp),%esi
80102b35:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b38:	89 06                	mov    %eax,(%esi)
80102b3a:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b3d:	89 46 04             	mov    %eax,0x4(%esi)
80102b40:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b43:	89 46 08             	mov    %eax,0x8(%esi)
80102b46:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b49:	89 46 0c             	mov    %eax,0xc(%esi)
80102b4c:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b4f:	89 46 10             	mov    %eax,0x10(%esi)
80102b52:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b55:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102b58:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102b5f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b62:	5b                   	pop    %ebx
80102b63:	5e                   	pop    %esi
80102b64:	5f                   	pop    %edi
80102b65:	5d                   	pop    %ebp
80102b66:	c3                   	ret    
80102b67:	66 90                	xchg   %ax,%ax
80102b69:	66 90                	xchg   %ax,%ax
80102b6b:	66 90                	xchg   %ax,%ax
80102b6d:	66 90                	xchg   %ax,%ax
80102b6f:	90                   	nop

80102b70 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102b70:	8b 0d 68 36 11 80    	mov    0x80113668,%ecx
80102b76:	85 c9                	test   %ecx,%ecx
80102b78:	0f 8e 85 00 00 00    	jle    80102c03 <install_trans+0x93>
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102b7e:	55                   	push   %ebp
80102b7f:	89 e5                	mov    %esp,%ebp
80102b81:	57                   	push   %edi
80102b82:	56                   	push   %esi
80102b83:	53                   	push   %ebx
80102b84:	31 db                	xor    %ebx,%ebx
80102b86:	83 ec 0c             	sub    $0xc,%esp
80102b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102b90:	a1 54 36 11 80       	mov    0x80113654,%eax
80102b95:	83 ec 08             	sub    $0x8,%esp
80102b98:	01 d8                	add    %ebx,%eax
80102b9a:	83 c0 01             	add    $0x1,%eax
80102b9d:	50                   	push   %eax
80102b9e:	ff 35 64 36 11 80    	pushl  0x80113664
80102ba4:	e8 27 d5 ff ff       	call   801000d0 <bread>
80102ba9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bab:	58                   	pop    %eax
80102bac:	5a                   	pop    %edx
80102bad:	ff 34 9d 6c 36 11 80 	pushl  -0x7feec994(,%ebx,4)
80102bb4:	ff 35 64 36 11 80    	pushl  0x80113664
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102bba:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bbd:	e8 0e d5 ff ff       	call   801000d0 <bread>
80102bc2:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102bc4:	8d 47 5c             	lea    0x5c(%edi),%eax
80102bc7:	83 c4 0c             	add    $0xc,%esp
80102bca:	68 00 02 00 00       	push   $0x200
80102bcf:	50                   	push   %eax
80102bd0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102bd3:	50                   	push   %eax
80102bd4:	e8 a7 1a 00 00       	call   80104680 <memmove>
    bwrite(dbuf);  // write dst to disk
80102bd9:	89 34 24             	mov    %esi,(%esp)
80102bdc:	e8 bf d5 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102be1:	89 3c 24             	mov    %edi,(%esp)
80102be4:	e8 f7 d5 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102be9:	89 34 24             	mov    %esi,(%esp)
80102bec:	e8 ef d5 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102bf1:	83 c4 10             	add    $0x10,%esp
80102bf4:	39 1d 68 36 11 80    	cmp    %ebx,0x80113668
80102bfa:	7f 94                	jg     80102b90 <install_trans+0x20>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102bfc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102bff:	5b                   	pop    %ebx
80102c00:	5e                   	pop    %esi
80102c01:	5f                   	pop    %edi
80102c02:	5d                   	pop    %ebp
80102c03:	f3 c3                	repz ret 
80102c05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c10 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102c10:	55                   	push   %ebp
80102c11:	89 e5                	mov    %esp,%ebp
80102c13:	53                   	push   %ebx
80102c14:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c17:	ff 35 54 36 11 80    	pushl  0x80113654
80102c1d:	ff 35 64 36 11 80    	pushl  0x80113664
80102c23:	e8 a8 d4 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102c28:	8b 0d 68 36 11 80    	mov    0x80113668,%ecx
  for (i = 0; i < log.lh.n; i++) {
80102c2e:	83 c4 10             	add    $0x10,%esp
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102c31:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102c33:	85 c9                	test   %ecx,%ecx
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102c35:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102c38:	7e 1f                	jle    80102c59 <write_head+0x49>
80102c3a:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80102c41:	31 d2                	xor    %edx,%edx
80102c43:	90                   	nop
80102c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102c48:	8b 8a 6c 36 11 80    	mov    -0x7feec994(%edx),%ecx
80102c4e:	89 4c 13 60          	mov    %ecx,0x60(%ebx,%edx,1)
80102c52:	83 c2 04             	add    $0x4,%edx
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102c55:	39 c2                	cmp    %eax,%edx
80102c57:	75 ef                	jne    80102c48 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102c59:	83 ec 0c             	sub    $0xc,%esp
80102c5c:	53                   	push   %ebx
80102c5d:	e8 3e d5 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102c62:	89 1c 24             	mov    %ebx,(%esp)
80102c65:	e8 76 d5 ff ff       	call   801001e0 <brelse>
}
80102c6a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c6d:	c9                   	leave  
80102c6e:	c3                   	ret    
80102c6f:	90                   	nop

80102c70 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102c70:	55                   	push   %ebp
80102c71:	89 e5                	mov    %esp,%ebp
80102c73:	53                   	push   %ebx
80102c74:	83 ec 2c             	sub    $0x2c,%esp
80102c77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102c7a:	68 20 76 10 80       	push   $0x80107620
80102c7f:	68 20 36 11 80       	push   $0x80113620
80102c84:	e8 d7 16 00 00       	call   80104360 <initlock>
  readsb(dev, &sb);
80102c89:	58                   	pop    %eax
80102c8a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102c8d:	5a                   	pop    %edx
80102c8e:	50                   	push   %eax
80102c8f:	53                   	push   %ebx
80102c90:	e8 db e8 ff ff       	call   80101570 <readsb>
  log.start = sb.logstart;
  log.size = sb.nlog;
80102c95:	8b 55 e8             	mov    -0x18(%ebp),%edx
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102c98:	8b 45 ec             	mov    -0x14(%ebp),%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102c9b:	59                   	pop    %ecx
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102c9c:	89 1d 64 36 11 80    	mov    %ebx,0x80113664

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102ca2:	89 15 58 36 11 80    	mov    %edx,0x80113658
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102ca8:	a3 54 36 11 80       	mov    %eax,0x80113654

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102cad:	5a                   	pop    %edx
80102cae:	50                   	push   %eax
80102caf:	53                   	push   %ebx
80102cb0:	e8 1b d4 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102cb5:	8b 48 5c             	mov    0x5c(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102cb8:	83 c4 10             	add    $0x10,%esp
80102cbb:	85 c9                	test   %ecx,%ecx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102cbd:	89 0d 68 36 11 80    	mov    %ecx,0x80113668
  for (i = 0; i < log.lh.n; i++) {
80102cc3:	7e 1c                	jle    80102ce1 <initlog+0x71>
80102cc5:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102ccc:	31 d2                	xor    %edx,%edx
80102cce:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102cd0:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102cd4:	83 c2 04             	add    $0x4,%edx
80102cd7:	89 8a 68 36 11 80    	mov    %ecx,-0x7feec998(%edx)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102cdd:	39 da                	cmp    %ebx,%edx
80102cdf:	75 ef                	jne    80102cd0 <initlog+0x60>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102ce1:	83 ec 0c             	sub    $0xc,%esp
80102ce4:	50                   	push   %eax
80102ce5:	e8 f6 d4 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102cea:	e8 81 fe ff ff       	call   80102b70 <install_trans>
  log.lh.n = 0;
80102cef:	c7 05 68 36 11 80 00 	movl   $0x0,0x80113668
80102cf6:	00 00 00 
  write_head(); // clear the log
80102cf9:	e8 12 ff ff ff       	call   80102c10 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102cfe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d01:	c9                   	leave  
80102d02:	c3                   	ret    
80102d03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102d10 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102d10:	55                   	push   %ebp
80102d11:	89 e5                	mov    %esp,%ebp
80102d13:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102d16:	68 20 36 11 80       	push   $0x80113620
80102d1b:	e8 40 17 00 00       	call   80104460 <acquire>
80102d20:	83 c4 10             	add    $0x10,%esp
80102d23:	eb 18                	jmp    80102d3d <begin_op+0x2d>
80102d25:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102d28:	83 ec 08             	sub    $0x8,%esp
80102d2b:	68 20 36 11 80       	push   $0x80113620
80102d30:	68 20 36 11 80       	push   $0x80113620
80102d35:	e8 b6 11 00 00       	call   80103ef0 <sleep>
80102d3a:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102d3d:	a1 60 36 11 80       	mov    0x80113660,%eax
80102d42:	85 c0                	test   %eax,%eax
80102d44:	75 e2                	jne    80102d28 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102d46:	a1 5c 36 11 80       	mov    0x8011365c,%eax
80102d4b:	8b 15 68 36 11 80    	mov    0x80113668,%edx
80102d51:	83 c0 01             	add    $0x1,%eax
80102d54:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102d57:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102d5a:	83 fa 1e             	cmp    $0x1e,%edx
80102d5d:	7f c9                	jg     80102d28 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102d5f:	83 ec 0c             	sub    $0xc,%esp
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102d62:	a3 5c 36 11 80       	mov    %eax,0x8011365c
      release(&log.lock);
80102d67:	68 20 36 11 80       	push   $0x80113620
80102d6c:	e8 0f 18 00 00       	call   80104580 <release>
      break;
    }
  }
}
80102d71:	83 c4 10             	add    $0x10,%esp
80102d74:	c9                   	leave  
80102d75:	c3                   	ret    
80102d76:	8d 76 00             	lea    0x0(%esi),%esi
80102d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102d80 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102d80:	55                   	push   %ebp
80102d81:	89 e5                	mov    %esp,%ebp
80102d83:	57                   	push   %edi
80102d84:	56                   	push   %esi
80102d85:	53                   	push   %ebx
80102d86:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102d89:	68 20 36 11 80       	push   $0x80113620
80102d8e:	e8 cd 16 00 00       	call   80104460 <acquire>
  log.outstanding -= 1;
80102d93:	a1 5c 36 11 80       	mov    0x8011365c,%eax
  if(log.committing)
80102d98:	8b 1d 60 36 11 80    	mov    0x80113660,%ebx
80102d9e:	83 c4 10             	add    $0x10,%esp
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102da1:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102da4:	85 db                	test   %ebx,%ebx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102da6:	a3 5c 36 11 80       	mov    %eax,0x8011365c
  if(log.committing)
80102dab:	0f 85 23 01 00 00    	jne    80102ed4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102db1:	85 c0                	test   %eax,%eax
80102db3:	0f 85 f7 00 00 00    	jne    80102eb0 <end_op+0x130>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102db9:	83 ec 0c             	sub    $0xc,%esp
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102dbc:	c7 05 60 36 11 80 01 	movl   $0x1,0x80113660
80102dc3:	00 00 00 
}

static void
commit()
{
  if (log.lh.n > 0) {
80102dc6:	31 db                	xor    %ebx,%ebx
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102dc8:	68 20 36 11 80       	push   $0x80113620
80102dcd:	e8 ae 17 00 00       	call   80104580 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102dd2:	8b 0d 68 36 11 80    	mov    0x80113668,%ecx
80102dd8:	83 c4 10             	add    $0x10,%esp
80102ddb:	85 c9                	test   %ecx,%ecx
80102ddd:	0f 8e 8a 00 00 00    	jle    80102e6d <end_op+0xed>
80102de3:	90                   	nop
80102de4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102de8:	a1 54 36 11 80       	mov    0x80113654,%eax
80102ded:	83 ec 08             	sub    $0x8,%esp
80102df0:	01 d8                	add    %ebx,%eax
80102df2:	83 c0 01             	add    $0x1,%eax
80102df5:	50                   	push   %eax
80102df6:	ff 35 64 36 11 80    	pushl  0x80113664
80102dfc:	e8 cf d2 ff ff       	call   801000d0 <bread>
80102e01:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e03:	58                   	pop    %eax
80102e04:	5a                   	pop    %edx
80102e05:	ff 34 9d 6c 36 11 80 	pushl  -0x7feec994(,%ebx,4)
80102e0c:	ff 35 64 36 11 80    	pushl  0x80113664
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102e12:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e15:	e8 b6 d2 ff ff       	call   801000d0 <bread>
80102e1a:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102e1c:	8d 40 5c             	lea    0x5c(%eax),%eax
80102e1f:	83 c4 0c             	add    $0xc,%esp
80102e22:	68 00 02 00 00       	push   $0x200
80102e27:	50                   	push   %eax
80102e28:	8d 46 5c             	lea    0x5c(%esi),%eax
80102e2b:	50                   	push   %eax
80102e2c:	e8 4f 18 00 00       	call   80104680 <memmove>
    bwrite(to);  // write the log
80102e31:	89 34 24             	mov    %esi,(%esp)
80102e34:	e8 67 d3 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102e39:	89 3c 24             	mov    %edi,(%esp)
80102e3c:	e8 9f d3 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102e41:	89 34 24             	mov    %esi,(%esp)
80102e44:	e8 97 d3 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102e49:	83 c4 10             	add    $0x10,%esp
80102e4c:	3b 1d 68 36 11 80    	cmp    0x80113668,%ebx
80102e52:	7c 94                	jl     80102de8 <end_op+0x68>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102e54:	e8 b7 fd ff ff       	call   80102c10 <write_head>
    install_trans(); // Now install writes to home locations
80102e59:	e8 12 fd ff ff       	call   80102b70 <install_trans>
    log.lh.n = 0;
80102e5e:	c7 05 68 36 11 80 00 	movl   $0x0,0x80113668
80102e65:	00 00 00 
    write_head();    // Erase the transaction from the log
80102e68:	e8 a3 fd ff ff       	call   80102c10 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102e6d:	83 ec 0c             	sub    $0xc,%esp
80102e70:	68 20 36 11 80       	push   $0x80113620
80102e75:	e8 e6 15 00 00       	call   80104460 <acquire>
    log.committing = 0;
    wakeup(&log);
80102e7a:	c7 04 24 20 36 11 80 	movl   $0x80113620,(%esp)
  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
    log.committing = 0;
80102e81:	c7 05 60 36 11 80 00 	movl   $0x0,0x80113660
80102e88:	00 00 00 
    wakeup(&log);
80102e8b:	e8 10 12 00 00       	call   801040a0 <wakeup>
    release(&log.lock);
80102e90:	c7 04 24 20 36 11 80 	movl   $0x80113620,(%esp)
80102e97:	e8 e4 16 00 00       	call   80104580 <release>
80102e9c:	83 c4 10             	add    $0x10,%esp
  }
}
80102e9f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ea2:	5b                   	pop    %ebx
80102ea3:	5e                   	pop    %esi
80102ea4:	5f                   	pop    %edi
80102ea5:	5d                   	pop    %ebp
80102ea6:	c3                   	ret    
80102ea7:	89 f6                	mov    %esi,%esi
80102ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
80102eb0:	83 ec 0c             	sub    $0xc,%esp
80102eb3:	68 20 36 11 80       	push   $0x80113620
80102eb8:	e8 e3 11 00 00       	call   801040a0 <wakeup>
  }
  release(&log.lock);
80102ebd:	c7 04 24 20 36 11 80 	movl   $0x80113620,(%esp)
80102ec4:	e8 b7 16 00 00       	call   80104580 <release>
80102ec9:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
80102ecc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ecf:	5b                   	pop    %ebx
80102ed0:	5e                   	pop    %esi
80102ed1:	5f                   	pop    %edi
80102ed2:	5d                   	pop    %ebp
80102ed3:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102ed4:	83 ec 0c             	sub    $0xc,%esp
80102ed7:	68 24 76 10 80       	push   $0x80107624
80102edc:	e8 8f d4 ff ff       	call   80100370 <panic>
80102ee1:	eb 0d                	jmp    80102ef0 <log_write>
80102ee3:	90                   	nop
80102ee4:	90                   	nop
80102ee5:	90                   	nop
80102ee6:	90                   	nop
80102ee7:	90                   	nop
80102ee8:	90                   	nop
80102ee9:	90                   	nop
80102eea:	90                   	nop
80102eeb:	90                   	nop
80102eec:	90                   	nop
80102eed:	90                   	nop
80102eee:	90                   	nop
80102eef:	90                   	nop

80102ef0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102ef0:	55                   	push   %ebp
80102ef1:	89 e5                	mov    %esp,%ebp
80102ef3:	53                   	push   %ebx
80102ef4:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102ef7:	8b 15 68 36 11 80    	mov    0x80113668,%edx
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102efd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f00:	83 fa 1d             	cmp    $0x1d,%edx
80102f03:	0f 8f 97 00 00 00    	jg     80102fa0 <log_write+0xb0>
80102f09:	a1 58 36 11 80       	mov    0x80113658,%eax
80102f0e:	83 e8 01             	sub    $0x1,%eax
80102f11:	39 c2                	cmp    %eax,%edx
80102f13:	0f 8d 87 00 00 00    	jge    80102fa0 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102f19:	a1 5c 36 11 80       	mov    0x8011365c,%eax
80102f1e:	85 c0                	test   %eax,%eax
80102f20:	0f 8e 87 00 00 00    	jle    80102fad <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102f26:	83 ec 0c             	sub    $0xc,%esp
80102f29:	68 20 36 11 80       	push   $0x80113620
80102f2e:	e8 2d 15 00 00       	call   80104460 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102f33:	8b 15 68 36 11 80    	mov    0x80113668,%edx
80102f39:	83 c4 10             	add    $0x10,%esp
80102f3c:	83 fa 00             	cmp    $0x0,%edx
80102f3f:	7e 50                	jle    80102f91 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f41:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102f44:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f46:	3b 0d 6c 36 11 80    	cmp    0x8011366c,%ecx
80102f4c:	75 0b                	jne    80102f59 <log_write+0x69>
80102f4e:	eb 38                	jmp    80102f88 <log_write+0x98>
80102f50:	39 0c 85 6c 36 11 80 	cmp    %ecx,-0x7feec994(,%eax,4)
80102f57:	74 2f                	je     80102f88 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102f59:	83 c0 01             	add    $0x1,%eax
80102f5c:	39 d0                	cmp    %edx,%eax
80102f5e:	75 f0                	jne    80102f50 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102f60:	89 0c 95 6c 36 11 80 	mov    %ecx,-0x7feec994(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102f67:	83 c2 01             	add    $0x1,%edx
80102f6a:	89 15 68 36 11 80    	mov    %edx,0x80113668
  b->flags |= B_DIRTY; // prevent eviction
80102f70:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102f73:	c7 45 08 20 36 11 80 	movl   $0x80113620,0x8(%ebp)
}
80102f7a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f7d:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102f7e:	e9 fd 15 00 00       	jmp    80104580 <release>
80102f83:	90                   	nop
80102f84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102f88:	89 0c 85 6c 36 11 80 	mov    %ecx,-0x7feec994(,%eax,4)
80102f8f:	eb df                	jmp    80102f70 <log_write+0x80>
80102f91:	8b 43 08             	mov    0x8(%ebx),%eax
80102f94:	a3 6c 36 11 80       	mov    %eax,0x8011366c
  if (i == log.lh.n)
80102f99:	75 d5                	jne    80102f70 <log_write+0x80>
80102f9b:	eb ca                	jmp    80102f67 <log_write+0x77>
80102f9d:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102fa0:	83 ec 0c             	sub    $0xc,%esp
80102fa3:	68 33 76 10 80       	push   $0x80107633
80102fa8:	e8 c3 d3 ff ff       	call   80100370 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102fad:	83 ec 0c             	sub    $0xc,%esp
80102fb0:	68 49 76 10 80       	push   $0x80107649
80102fb5:	e8 b6 d3 ff ff       	call   80100370 <panic>
80102fba:	66 90                	xchg   %ax,%ax
80102fbc:	66 90                	xchg   %ax,%ax
80102fbe:	66 90                	xchg   %ax,%ax

80102fc0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102fc0:	55                   	push   %ebp
80102fc1:	89 e5                	mov    %esp,%ebp
80102fc3:	53                   	push   %ebx
80102fc4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102fc7:	e8 54 09 00 00       	call   80103920 <cpuid>
80102fcc:	89 c3                	mov    %eax,%ebx
80102fce:	e8 4d 09 00 00       	call   80103920 <cpuid>
80102fd3:	83 ec 04             	sub    $0x4,%esp
80102fd6:	53                   	push   %ebx
80102fd7:	50                   	push   %eax
80102fd8:	68 64 76 10 80       	push   $0x80107664
80102fdd:	e8 ce d6 ff ff       	call   801006b0 <cprintf>
  idtinit();       // load idt register
80102fe2:	e8 b9 29 00 00       	call   801059a0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102fe7:	e8 b4 08 00 00       	call   801038a0 <mycpu>
80102fec:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102fee:	b8 01 00 00 00       	mov    $0x1,%eax
80102ff3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102ffa:	e8 01 0c 00 00       	call   80103c00 <scheduler>
80102fff:	90                   	nop

80103000 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80103000:	55                   	push   %ebp
80103001:	89 e5                	mov    %esp,%ebp
80103003:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103006:	e8 b5 3a 00 00       	call   80106ac0 <switchkvm>
  seginit();
8010300b:	e8 b0 39 00 00       	call   801069c0 <seginit>
  lapicinit();
80103010:	e8 9b f7 ff ff       	call   801027b0 <lapicinit>
  mpmain();
80103015:	e8 a6 ff ff ff       	call   80102fc0 <mpmain>
8010301a:	66 90                	xchg   %ax,%ax
8010301c:	66 90                	xchg   %ax,%ax
8010301e:	66 90                	xchg   %ax,%ax

80103020 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80103020:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103024:	83 e4 f0             	and    $0xfffffff0,%esp
80103027:	ff 71 fc             	pushl  -0x4(%ecx)
8010302a:	55                   	push   %ebp
8010302b:	89 e5                	mov    %esp,%ebp
8010302d:	53                   	push   %ebx
8010302e:	51                   	push   %ecx
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
8010302f:	bb 20 37 11 80       	mov    $0x80113720,%ebx
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103034:	83 ec 08             	sub    $0x8,%esp
80103037:	68 00 00 40 80       	push   $0x80400000
8010303c:	68 48 64 11 80       	push   $0x80116448
80103041:	e8 3a f5 ff ff       	call   80102580 <kinit1>
  kvmalloc();      // kernel page table
80103046:	e8 15 3f 00 00       	call   80106f60 <kvmalloc>
  mpinit();        // detect other processors
8010304b:	e8 70 01 00 00       	call   801031c0 <mpinit>
  lapicinit();     // interrupt controller
80103050:	e8 5b f7 ff ff       	call   801027b0 <lapicinit>
  seginit();       // segment descriptors
80103055:	e8 66 39 00 00       	call   801069c0 <seginit>
  picinit();       // disable pic
8010305a:	e8 31 03 00 00       	call   80103390 <picinit>
  ioapicinit();    // another interrupt controller
8010305f:	e8 4c f3 ff ff       	call   801023b0 <ioapicinit>
  consoleinit();   // console hardware
80103064:	e8 f7 da ff ff       	call   80100b60 <consoleinit>
  uartinit();      // serial port
80103069:	e8 22 2c 00 00       	call   80105c90 <uartinit>
  pinit();         // process table
8010306e:	e8 0d 08 00 00       	call   80103880 <pinit>
  tvinit();        // trap vectors
80103073:	e8 88 28 00 00       	call   80105900 <tvinit>
  binit();         // buffer cache
80103078:	e8 c3 cf ff ff       	call   80100040 <binit>
  fileinit();      // file table
8010307d:	e8 8e de ff ff       	call   80100f10 <fileinit>
  ideinit();       // disk 
80103082:	e8 09 f1 ff ff       	call   80102190 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103087:	83 c4 0c             	add    $0xc,%esp
8010308a:	68 8a 00 00 00       	push   $0x8a
8010308f:	68 8c a4 10 80       	push   $0x8010a48c
80103094:	68 00 70 00 80       	push   $0x80007000
80103099:	e8 e2 15 00 00       	call   80104680 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
8010309e:	69 05 a0 3c 11 80 b0 	imul   $0xb0,0x80113ca0,%eax
801030a5:	00 00 00 
801030a8:	83 c4 10             	add    $0x10,%esp
801030ab:	05 20 37 11 80       	add    $0x80113720,%eax
801030b0:	39 d8                	cmp    %ebx,%eax
801030b2:	76 6f                	jbe    80103123 <main+0x103>
801030b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
801030b8:	e8 e3 07 00 00       	call   801038a0 <mycpu>
801030bd:	39 d8                	cmp    %ebx,%eax
801030bf:	74 49                	je     8010310a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801030c1:	e8 8a f5 ff ff       	call   80102650 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
801030c6:	05 00 10 00 00       	add    $0x1000,%eax
    *(void**)(code-8) = mpenter;
801030cb:	c7 05 f8 6f 00 80 00 	movl   $0x80103000,0x80006ff8
801030d2:	30 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801030d5:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
801030dc:	90 10 00 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
801030df:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
801030e4:	0f b6 03             	movzbl (%ebx),%eax
801030e7:	83 ec 08             	sub    $0x8,%esp
801030ea:	68 00 70 00 00       	push   $0x7000
801030ef:	50                   	push   %eax
801030f0:	e8 0b f8 ff ff       	call   80102900 <lapicstartap>
801030f5:	83 c4 10             	add    $0x10,%esp
801030f8:	90                   	nop
801030f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103100:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103106:	85 c0                	test   %eax,%eax
80103108:	74 f6                	je     80103100 <main+0xe0>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
8010310a:	69 05 a0 3c 11 80 b0 	imul   $0xb0,0x80113ca0,%eax
80103111:	00 00 00 
80103114:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010311a:	05 20 37 11 80       	add    $0x80113720,%eax
8010311f:	39 c3                	cmp    %eax,%ebx
80103121:	72 95                	jb     801030b8 <main+0x98>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk 
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103123:	83 ec 08             	sub    $0x8,%esp
80103126:	68 00 00 00 8e       	push   $0x8e000000
8010312b:	68 00 00 40 80       	push   $0x80400000
80103130:	e8 bb f4 ff ff       	call   801025f0 <kinit2>
  userinit();      // first user process
80103135:	e8 36 08 00 00       	call   80103970 <userinit>
  mpmain();        // finish this processor's setup
8010313a:	e8 81 fe ff ff       	call   80102fc0 <mpmain>
8010313f:	90                   	nop

80103140 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103140:	55                   	push   %ebp
80103141:	89 e5                	mov    %esp,%ebp
80103143:	57                   	push   %edi
80103144:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103145:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
8010314b:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
8010314c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
8010314f:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103152:	39 de                	cmp    %ebx,%esi
80103154:	73 48                	jae    8010319e <mpsearch1+0x5e>
80103156:	8d 76 00             	lea    0x0(%esi),%esi
80103159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103160:	83 ec 04             	sub    $0x4,%esp
80103163:	8d 7e 10             	lea    0x10(%esi),%edi
80103166:	6a 04                	push   $0x4
80103168:	68 78 76 10 80       	push   $0x80107678
8010316d:	56                   	push   %esi
8010316e:	e8 ad 14 00 00       	call   80104620 <memcmp>
80103173:	83 c4 10             	add    $0x10,%esp
80103176:	85 c0                	test   %eax,%eax
80103178:	75 1e                	jne    80103198 <mpsearch1+0x58>
8010317a:	8d 7e 10             	lea    0x10(%esi),%edi
8010317d:	89 f2                	mov    %esi,%edx
8010317f:	31 c9                	xor    %ecx,%ecx
80103181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
80103188:	0f b6 02             	movzbl (%edx),%eax
8010318b:	83 c2 01             	add    $0x1,%edx
8010318e:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103190:	39 fa                	cmp    %edi,%edx
80103192:	75 f4                	jne    80103188 <mpsearch1+0x48>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103194:	84 c9                	test   %cl,%cl
80103196:	74 10                	je     801031a8 <mpsearch1+0x68>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103198:	39 fb                	cmp    %edi,%ebx
8010319a:	89 fe                	mov    %edi,%esi
8010319c:	77 c2                	ja     80103160 <mpsearch1+0x20>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
8010319e:	8d 65 f4             	lea    -0xc(%ebp),%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
801031a1:	31 c0                	xor    %eax,%eax
}
801031a3:	5b                   	pop    %ebx
801031a4:	5e                   	pop    %esi
801031a5:	5f                   	pop    %edi
801031a6:	5d                   	pop    %ebp
801031a7:	c3                   	ret    
801031a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031ab:	89 f0                	mov    %esi,%eax
801031ad:	5b                   	pop    %ebx
801031ae:	5e                   	pop    %esi
801031af:	5f                   	pop    %edi
801031b0:	5d                   	pop    %ebp
801031b1:	c3                   	ret    
801031b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801031c0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801031c0:	55                   	push   %ebp
801031c1:	89 e5                	mov    %esp,%ebp
801031c3:	57                   	push   %edi
801031c4:	56                   	push   %esi
801031c5:	53                   	push   %ebx
801031c6:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801031c9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801031d0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801031d7:	c1 e0 08             	shl    $0x8,%eax
801031da:	09 d0                	or     %edx,%eax
801031dc:	c1 e0 04             	shl    $0x4,%eax
801031df:	85 c0                	test   %eax,%eax
801031e1:	75 1b                	jne    801031fe <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
801031e3:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801031ea:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801031f1:	c1 e0 08             	shl    $0x8,%eax
801031f4:	09 d0                	or     %edx,%eax
801031f6:	c1 e0 0a             	shl    $0xa,%eax
801031f9:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
801031fe:	ba 00 04 00 00       	mov    $0x400,%edx
80103203:	e8 38 ff ff ff       	call   80103140 <mpsearch1>
80103208:	85 c0                	test   %eax,%eax
8010320a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010320d:	0f 84 37 01 00 00    	je     8010334a <mpinit+0x18a>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103213:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103216:	8b 58 04             	mov    0x4(%eax),%ebx
80103219:	85 db                	test   %ebx,%ebx
8010321b:	0f 84 43 01 00 00    	je     80103364 <mpinit+0x1a4>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103221:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103227:	83 ec 04             	sub    $0x4,%esp
8010322a:	6a 04                	push   $0x4
8010322c:	68 7d 76 10 80       	push   $0x8010767d
80103231:	56                   	push   %esi
80103232:	e8 e9 13 00 00       	call   80104620 <memcmp>
80103237:	83 c4 10             	add    $0x10,%esp
8010323a:	85 c0                	test   %eax,%eax
8010323c:	0f 85 22 01 00 00    	jne    80103364 <mpinit+0x1a4>
    return 0;
  if(conf->version != 1 && conf->version != 4)
80103242:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103249:	3c 01                	cmp    $0x1,%al
8010324b:	74 08                	je     80103255 <mpinit+0x95>
8010324d:	3c 04                	cmp    $0x4,%al
8010324f:	0f 85 0f 01 00 00    	jne    80103364 <mpinit+0x1a4>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80103255:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
8010325c:	85 ff                	test   %edi,%edi
8010325e:	74 21                	je     80103281 <mpinit+0xc1>
80103260:	31 d2                	xor    %edx,%edx
80103262:	31 c0                	xor    %eax,%eax
80103264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103268:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
8010326f:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103270:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103273:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103275:	39 c7                	cmp    %eax,%edi
80103277:	75 ef                	jne    80103268 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80103279:	84 d2                	test   %dl,%dl
8010327b:	0f 85 e3 00 00 00    	jne    80103364 <mpinit+0x1a4>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103281:	85 f6                	test   %esi,%esi
80103283:	0f 84 db 00 00 00    	je     80103364 <mpinit+0x1a4>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103289:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
8010328f:	a3 1c 36 11 80       	mov    %eax,0x8011361c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103294:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
8010329b:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
801032a1:	bb 01 00 00 00       	mov    $0x1,%ebx
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032a6:	01 d6                	add    %edx,%esi
801032a8:	90                   	nop
801032a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032b0:	39 c6                	cmp    %eax,%esi
801032b2:	76 23                	jbe    801032d7 <mpinit+0x117>
801032b4:	0f b6 10             	movzbl (%eax),%edx
    switch(*p){
801032b7:	80 fa 04             	cmp    $0x4,%dl
801032ba:	0f 87 c0 00 00 00    	ja     80103380 <mpinit+0x1c0>
801032c0:	ff 24 95 bc 76 10 80 	jmp    *-0x7fef8944(,%edx,4)
801032c7:	89 f6                	mov    %esi,%esi
801032c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801032d0:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032d3:	39 c6                	cmp    %eax,%esi
801032d5:	77 dd                	ja     801032b4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801032d7:	85 db                	test   %ebx,%ebx
801032d9:	0f 84 92 00 00 00    	je     80103371 <mpinit+0x1b1>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801032df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801032e2:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
801032e6:	74 15                	je     801032fd <mpinit+0x13d>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032e8:	ba 22 00 00 00       	mov    $0x22,%edx
801032ed:	b8 70 00 00 00       	mov    $0x70,%eax
801032f2:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801032f3:	ba 23 00 00 00       	mov    $0x23,%edx
801032f8:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032f9:	83 c8 01             	or     $0x1,%eax
801032fc:	ee                   	out    %al,(%dx)
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
801032fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103300:	5b                   	pop    %ebx
80103301:	5e                   	pop    %esi
80103302:	5f                   	pop    %edi
80103303:	5d                   	pop    %ebp
80103304:	c3                   	ret    
80103305:	8d 76 00             	lea    0x0(%esi),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80103308:	8b 0d a0 3c 11 80    	mov    0x80113ca0,%ecx
8010330e:	83 f9 07             	cmp    $0x7,%ecx
80103311:	7f 19                	jg     8010332c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103313:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103317:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010331d:	83 c1 01             	add    $0x1,%ecx
80103320:	89 0d a0 3c 11 80    	mov    %ecx,0x80113ca0
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103326:	88 97 20 37 11 80    	mov    %dl,-0x7feec8e0(%edi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
8010332c:	83 c0 14             	add    $0x14,%eax
      continue;
8010332f:	e9 7c ff ff ff       	jmp    801032b0 <mpinit+0xf0>
80103334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80103338:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010333c:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
8010333f:	88 15 00 37 11 80    	mov    %dl,0x80113700
      p += sizeof(struct mpioapic);
      continue;
80103345:	e9 66 ff ff ff       	jmp    801032b0 <mpinit+0xf0>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
8010334a:	ba 00 00 01 00       	mov    $0x10000,%edx
8010334f:	b8 00 00 0f 00       	mov    $0xf0000,%eax
80103354:	e8 e7 fd ff ff       	call   80103140 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103359:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
8010335b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010335e:	0f 85 af fe ff ff    	jne    80103213 <mpinit+0x53>
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
80103364:	83 ec 0c             	sub    $0xc,%esp
80103367:	68 82 76 10 80       	push   $0x80107682
8010336c:	e8 ff cf ff ff       	call   80100370 <panic>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
80103371:	83 ec 0c             	sub    $0xc,%esp
80103374:	68 9c 76 10 80       	push   $0x8010769c
80103379:	e8 f2 cf ff ff       	call   80100370 <panic>
8010337e:	66 90                	xchg   %ax,%ax
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
80103380:	31 db                	xor    %ebx,%ebx
80103382:	e9 30 ff ff ff       	jmp    801032b7 <mpinit+0xf7>
80103387:	66 90                	xchg   %ax,%ax
80103389:	66 90                	xchg   %ax,%ax
8010338b:	66 90                	xchg   %ax,%ax
8010338d:	66 90                	xchg   %ax,%ax
8010338f:	90                   	nop

80103390 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103390:	55                   	push   %ebp
80103391:	ba 21 00 00 00       	mov    $0x21,%edx
80103396:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010339b:	89 e5                	mov    %esp,%ebp
8010339d:	ee                   	out    %al,(%dx)
8010339e:	ba a1 00 00 00       	mov    $0xa1,%edx
801033a3:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801033a4:	5d                   	pop    %ebp
801033a5:	c3                   	ret    
801033a6:	66 90                	xchg   %ax,%ax
801033a8:	66 90                	xchg   %ax,%ax
801033aa:	66 90                	xchg   %ax,%ax
801033ac:	66 90                	xchg   %ax,%ax
801033ae:	66 90                	xchg   %ax,%ax

801033b0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801033b0:	55                   	push   %ebp
801033b1:	89 e5                	mov    %esp,%ebp
801033b3:	57                   	push   %edi
801033b4:	56                   	push   %esi
801033b5:	53                   	push   %ebx
801033b6:	83 ec 0c             	sub    $0xc,%esp
801033b9:	8b 75 08             	mov    0x8(%ebp),%esi
801033bc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801033bf:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801033c5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801033cb:	e8 60 db ff ff       	call   80100f30 <filealloc>
801033d0:	85 c0                	test   %eax,%eax
801033d2:	89 06                	mov    %eax,(%esi)
801033d4:	0f 84 a8 00 00 00    	je     80103482 <pipealloc+0xd2>
801033da:	e8 51 db ff ff       	call   80100f30 <filealloc>
801033df:	85 c0                	test   %eax,%eax
801033e1:	89 03                	mov    %eax,(%ebx)
801033e3:	0f 84 87 00 00 00    	je     80103470 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801033e9:	e8 62 f2 ff ff       	call   80102650 <kalloc>
801033ee:	85 c0                	test   %eax,%eax
801033f0:	89 c7                	mov    %eax,%edi
801033f2:	0f 84 b0 00 00 00    	je     801034a8 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
801033f8:	83 ec 08             	sub    $0x8,%esp
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
  p->readopen = 1;
801033fb:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103402:	00 00 00 
  p->writeopen = 1;
80103405:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010340c:	00 00 00 
  p->nwrite = 0;
8010340f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103416:	00 00 00 
  p->nread = 0;
80103419:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103420:	00 00 00 
  initlock(&p->lock, "pipe");
80103423:	68 d0 76 10 80       	push   $0x801076d0
80103428:	50                   	push   %eax
80103429:	e8 32 0f 00 00       	call   80104360 <initlock>
  (*f0)->type = FD_PIPE;
8010342e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103430:	83 c4 10             	add    $0x10,%esp
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
80103433:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103439:	8b 06                	mov    (%esi),%eax
8010343b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010343f:	8b 06                	mov    (%esi),%eax
80103441:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103445:	8b 06                	mov    (%esi),%eax
80103447:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010344a:	8b 03                	mov    (%ebx),%eax
8010344c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103452:	8b 03                	mov    (%ebx),%eax
80103454:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103458:	8b 03                	mov    (%ebx),%eax
8010345a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010345e:	8b 03                	mov    (%ebx),%eax
80103460:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103463:	8d 65 f4             	lea    -0xc(%ebp),%esp
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103466:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103468:	5b                   	pop    %ebx
80103469:	5e                   	pop    %esi
8010346a:	5f                   	pop    %edi
8010346b:	5d                   	pop    %ebp
8010346c:	c3                   	ret    
8010346d:	8d 76 00             	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80103470:	8b 06                	mov    (%esi),%eax
80103472:	85 c0                	test   %eax,%eax
80103474:	74 1e                	je     80103494 <pipealloc+0xe4>
    fileclose(*f0);
80103476:	83 ec 0c             	sub    $0xc,%esp
80103479:	50                   	push   %eax
8010347a:	e8 71 db ff ff       	call   80100ff0 <fileclose>
8010347f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103482:	8b 03                	mov    (%ebx),%eax
80103484:	85 c0                	test   %eax,%eax
80103486:	74 0c                	je     80103494 <pipealloc+0xe4>
    fileclose(*f1);
80103488:	83 ec 0c             	sub    $0xc,%esp
8010348b:	50                   	push   %eax
8010348c:	e8 5f db ff ff       	call   80100ff0 <fileclose>
80103491:	83 c4 10             	add    $0x10,%esp
  return -1;
}
80103494:	8d 65 f4             	lea    -0xc(%ebp),%esp
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
80103497:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010349c:	5b                   	pop    %ebx
8010349d:	5e                   	pop    %esi
8010349e:	5f                   	pop    %edi
8010349f:	5d                   	pop    %ebp
801034a0:	c3                   	ret    
801034a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801034a8:	8b 06                	mov    (%esi),%eax
801034aa:	85 c0                	test   %eax,%eax
801034ac:	75 c8                	jne    80103476 <pipealloc+0xc6>
801034ae:	eb d2                	jmp    80103482 <pipealloc+0xd2>

801034b0 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
801034b0:	55                   	push   %ebp
801034b1:	89 e5                	mov    %esp,%ebp
801034b3:	56                   	push   %esi
801034b4:	53                   	push   %ebx
801034b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801034b8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801034bb:	83 ec 0c             	sub    $0xc,%esp
801034be:	53                   	push   %ebx
801034bf:	e8 9c 0f 00 00       	call   80104460 <acquire>
  if(writable){
801034c4:	83 c4 10             	add    $0x10,%esp
801034c7:	85 f6                	test   %esi,%esi
801034c9:	74 45                	je     80103510 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
801034cb:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801034d1:	83 ec 0c             	sub    $0xc,%esp
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
801034d4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801034db:	00 00 00 
    wakeup(&p->nread);
801034de:	50                   	push   %eax
801034df:	e8 bc 0b 00 00       	call   801040a0 <wakeup>
801034e4:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801034e7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801034ed:	85 d2                	test   %edx,%edx
801034ef:	75 0a                	jne    801034fb <pipeclose+0x4b>
801034f1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801034f7:	85 c0                	test   %eax,%eax
801034f9:	74 35                	je     80103530 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801034fb:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801034fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103501:	5b                   	pop    %ebx
80103502:	5e                   	pop    %esi
80103503:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103504:	e9 77 10 00 00       	jmp    80104580 <release>
80103509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
80103510:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103516:	83 ec 0c             	sub    $0xc,%esp
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
80103519:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103520:	00 00 00 
    wakeup(&p->nwrite);
80103523:	50                   	push   %eax
80103524:	e8 77 0b 00 00       	call   801040a0 <wakeup>
80103529:	83 c4 10             	add    $0x10,%esp
8010352c:	eb b9                	jmp    801034e7 <pipeclose+0x37>
8010352e:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80103530:	83 ec 0c             	sub    $0xc,%esp
80103533:	53                   	push   %ebx
80103534:	e8 47 10 00 00       	call   80104580 <release>
    kfree((char*)p);
80103539:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010353c:	83 c4 10             	add    $0x10,%esp
  } else
    release(&p->lock);
}
8010353f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103542:	5b                   	pop    %ebx
80103543:	5e                   	pop    %esi
80103544:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
80103545:	e9 56 ef ff ff       	jmp    801024a0 <kfree>
8010354a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103550 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103550:	55                   	push   %ebp
80103551:	89 e5                	mov    %esp,%ebp
80103553:	57                   	push   %edi
80103554:	56                   	push   %esi
80103555:	53                   	push   %ebx
80103556:	83 ec 28             	sub    $0x28,%esp
80103559:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010355c:	53                   	push   %ebx
8010355d:	e8 fe 0e 00 00       	call   80104460 <acquire>
  for(i = 0; i < n; i++){
80103562:	8b 45 10             	mov    0x10(%ebp),%eax
80103565:	83 c4 10             	add    $0x10,%esp
80103568:	85 c0                	test   %eax,%eax
8010356a:	0f 8e b9 00 00 00    	jle    80103629 <pipewrite+0xd9>
80103570:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103573:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103579:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010357f:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103585:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103588:	03 4d 10             	add    0x10(%ebp),%ecx
8010358b:	89 4d e0             	mov    %ecx,-0x20(%ebp)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010358e:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80103594:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
8010359a:	39 d0                	cmp    %edx,%eax
8010359c:	74 38                	je     801035d6 <pipewrite+0x86>
8010359e:	eb 59                	jmp    801035f9 <pipewrite+0xa9>
      if(p->readopen == 0 || myproc()->killed){
801035a0:	e8 9b 03 00 00       	call   80103940 <myproc>
801035a5:	8b 48 24             	mov    0x24(%eax),%ecx
801035a8:	85 c9                	test   %ecx,%ecx
801035aa:	75 34                	jne    801035e0 <pipewrite+0x90>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801035ac:	83 ec 0c             	sub    $0xc,%esp
801035af:	57                   	push   %edi
801035b0:	e8 eb 0a 00 00       	call   801040a0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035b5:	58                   	pop    %eax
801035b6:	5a                   	pop    %edx
801035b7:	53                   	push   %ebx
801035b8:	56                   	push   %esi
801035b9:	e8 32 09 00 00       	call   80103ef0 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035be:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801035c4:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801035ca:	83 c4 10             	add    $0x10,%esp
801035cd:	05 00 02 00 00       	add    $0x200,%eax
801035d2:	39 c2                	cmp    %eax,%edx
801035d4:	75 2a                	jne    80103600 <pipewrite+0xb0>
      if(p->readopen == 0 || myproc()->killed){
801035d6:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801035dc:	85 c0                	test   %eax,%eax
801035de:	75 c0                	jne    801035a0 <pipewrite+0x50>
        release(&p->lock);
801035e0:	83 ec 0c             	sub    $0xc,%esp
801035e3:	53                   	push   %ebx
801035e4:	e8 97 0f 00 00       	call   80104580 <release>
        return -1;
801035e9:	83 c4 10             	add    $0x10,%esp
801035ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801035f1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035f4:	5b                   	pop    %ebx
801035f5:	5e                   	pop    %esi
801035f6:	5f                   	pop    %edi
801035f7:	5d                   	pop    %ebp
801035f8:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035f9:	89 c2                	mov    %eax,%edx
801035fb:	90                   	nop
801035fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103600:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103603:	8d 42 01             	lea    0x1(%edx),%eax
80103606:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010360a:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103610:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103616:	0f b6 09             	movzbl (%ecx),%ecx
80103619:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
8010361d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80103620:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
80103623:	0f 85 65 ff ff ff    	jne    8010358e <pipewrite+0x3e>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103629:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010362f:	83 ec 0c             	sub    $0xc,%esp
80103632:	50                   	push   %eax
80103633:	e8 68 0a 00 00       	call   801040a0 <wakeup>
  release(&p->lock);
80103638:	89 1c 24             	mov    %ebx,(%esp)
8010363b:	e8 40 0f 00 00       	call   80104580 <release>
  return n;
80103640:	83 c4 10             	add    $0x10,%esp
80103643:	8b 45 10             	mov    0x10(%ebp),%eax
80103646:	eb a9                	jmp    801035f1 <pipewrite+0xa1>
80103648:	90                   	nop
80103649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103650 <piperead>:
}

int
piperead(struct pipe *p, char *addr, int n)
{
80103650:	55                   	push   %ebp
80103651:	89 e5                	mov    %esp,%ebp
80103653:	57                   	push   %edi
80103654:	56                   	push   %esi
80103655:	53                   	push   %ebx
80103656:	83 ec 18             	sub    $0x18,%esp
80103659:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010365c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010365f:	53                   	push   %ebx
80103660:	e8 fb 0d 00 00       	call   80104460 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103665:	83 c4 10             	add    $0x10,%esp
80103668:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010366e:	39 83 38 02 00 00    	cmp    %eax,0x238(%ebx)
80103674:	75 6a                	jne    801036e0 <piperead+0x90>
80103676:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
8010367c:	85 f6                	test   %esi,%esi
8010367e:	0f 84 cc 00 00 00    	je     80103750 <piperead+0x100>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103684:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
8010368a:	eb 2d                	jmp    801036b9 <piperead+0x69>
8010368c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103690:	83 ec 08             	sub    $0x8,%esp
80103693:	53                   	push   %ebx
80103694:	56                   	push   %esi
80103695:	e8 56 08 00 00       	call   80103ef0 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010369a:	83 c4 10             	add    $0x10,%esp
8010369d:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801036a3:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
801036a9:	75 35                	jne    801036e0 <piperead+0x90>
801036ab:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
801036b1:	85 d2                	test   %edx,%edx
801036b3:	0f 84 97 00 00 00    	je     80103750 <piperead+0x100>
    if(myproc()->killed){
801036b9:	e8 82 02 00 00       	call   80103940 <myproc>
801036be:	8b 48 24             	mov    0x24(%eax),%ecx
801036c1:	85 c9                	test   %ecx,%ecx
801036c3:	74 cb                	je     80103690 <piperead+0x40>
      release(&p->lock);
801036c5:	83 ec 0c             	sub    $0xc,%esp
801036c8:	53                   	push   %ebx
801036c9:	e8 b2 0e 00 00       	call   80104580 <release>
      return -1;
801036ce:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801036d1:	8d 65 f4             	lea    -0xc(%ebp),%esp

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(myproc()->killed){
      release(&p->lock);
      return -1;
801036d4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801036d9:	5b                   	pop    %ebx
801036da:	5e                   	pop    %esi
801036db:	5f                   	pop    %edi
801036dc:	5d                   	pop    %ebp
801036dd:	c3                   	ret    
801036de:	66 90                	xchg   %ax,%ax
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801036e0:	8b 45 10             	mov    0x10(%ebp),%eax
801036e3:	85 c0                	test   %eax,%eax
801036e5:	7e 69                	jle    80103750 <piperead+0x100>
    if(p->nread == p->nwrite)
801036e7:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801036ed:	31 c9                	xor    %ecx,%ecx
801036ef:	eb 15                	jmp    80103706 <piperead+0xb6>
801036f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036f8:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801036fe:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
80103704:	74 5a                	je     80103760 <piperead+0x110>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103706:	8d 70 01             	lea    0x1(%eax),%esi
80103709:	25 ff 01 00 00       	and    $0x1ff,%eax
8010370e:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
80103714:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
80103719:	88 04 0f             	mov    %al,(%edi,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010371c:	83 c1 01             	add    $0x1,%ecx
8010371f:	39 4d 10             	cmp    %ecx,0x10(%ebp)
80103722:	75 d4                	jne    801036f8 <piperead+0xa8>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103724:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
8010372a:	83 ec 0c             	sub    $0xc,%esp
8010372d:	50                   	push   %eax
8010372e:	e8 6d 09 00 00       	call   801040a0 <wakeup>
  release(&p->lock);
80103733:	89 1c 24             	mov    %ebx,(%esp)
80103736:	e8 45 0e 00 00       	call   80104580 <release>
  return i;
8010373b:	8b 45 10             	mov    0x10(%ebp),%eax
8010373e:	83 c4 10             	add    $0x10,%esp
}
80103741:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103744:	5b                   	pop    %ebx
80103745:	5e                   	pop    %esi
80103746:	5f                   	pop    %edi
80103747:	5d                   	pop    %ebp
80103748:	c3                   	ret    
80103749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103750:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
80103757:	eb cb                	jmp    80103724 <piperead+0xd4>
80103759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103760:	89 4d 10             	mov    %ecx,0x10(%ebp)
80103763:	eb bf                	jmp    80103724 <piperead+0xd4>
80103765:	66 90                	xchg   %ax,%ax
80103767:	66 90                	xchg   %ax,%ax
80103769:	66 90                	xchg   %ax,%ax
8010376b:	66 90                	xchg   %ax,%ax
8010376d:	66 90                	xchg   %ax,%ax
8010376f:	90                   	nop

80103770 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103770:	55                   	push   %ebp
80103771:	89 e5                	mov    %esp,%ebp
80103773:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103774:	bb f4 3c 11 80       	mov    $0x80113cf4,%ebx
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103779:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
8010377c:	68 c0 3c 11 80       	push   $0x80113cc0
80103781:	e8 da 0c 00 00       	call   80104460 <acquire>
80103786:	83 c4 10             	add    $0x10,%esp
80103789:	eb 10                	jmp    8010379b <allocproc+0x2b>
8010378b:	90                   	nop
8010378c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103790:	83 c3 7c             	add    $0x7c,%ebx
80103793:	81 fb f4 5b 11 80    	cmp    $0x80115bf4,%ebx
80103799:	74 75                	je     80103810 <allocproc+0xa0>
    if(p->state == UNUSED)
8010379b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010379e:	85 c0                	test   %eax,%eax
801037a0:	75 ee                	jne    80103790 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801037a2:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
801037a7:	83 ec 0c             	sub    $0xc,%esp

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
801037aa:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;

  release(&ptable.lock);
801037b1:	68 c0 3c 11 80       	push   $0x80113cc0
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801037b6:	8d 50 01             	lea    0x1(%eax),%edx
801037b9:	89 43 10             	mov    %eax,0x10(%ebx)
801037bc:	89 15 04 a0 10 80    	mov    %edx,0x8010a004

  release(&ptable.lock);
801037c2:	e8 b9 0d 00 00       	call   80104580 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801037c7:	e8 84 ee ff ff       	call   80102650 <kalloc>
801037cc:	83 c4 10             	add    $0x10,%esp
801037cf:	85 c0                	test   %eax,%eax
801037d1:	89 43 08             	mov    %eax,0x8(%ebx)
801037d4:	74 51                	je     80103827 <allocproc+0xb7>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801037d6:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801037dc:	83 ec 04             	sub    $0x4,%esp
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
801037df:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801037e4:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
801037e7:	c7 40 14 f5 58 10 80 	movl   $0x801058f5,0x14(%eax)

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801037ee:	6a 14                	push   $0x14
801037f0:	6a 00                	push   $0x0
801037f2:	50                   	push   %eax
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
801037f3:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801037f6:	e8 d5 0d 00 00       	call   801045d0 <memset>
  p->context->eip = (uint)forkret;
801037fb:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
801037fe:	83 c4 10             	add    $0x10,%esp
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
80103801:	c7 40 10 30 38 10 80 	movl   $0x80103830,0x10(%eax)

  return p;
80103808:	89 d8                	mov    %ebx,%eax
}
8010380a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010380d:	c9                   	leave  
8010380e:	c3                   	ret    
8010380f:	90                   	nop

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80103810:	83 ec 0c             	sub    $0xc,%esp
80103813:	68 c0 3c 11 80       	push   $0x80113cc0
80103818:	e8 63 0d 00 00       	call   80104580 <release>
  return 0;
8010381d:	83 c4 10             	add    $0x10,%esp
80103820:	31 c0                	xor    %eax,%eax
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
80103822:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103825:	c9                   	leave  
80103826:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
80103827:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
8010382e:	eb da                	jmp    8010380a <allocproc+0x9a>

80103830 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103830:	55                   	push   %ebp
80103831:	89 e5                	mov    %esp,%ebp
80103833:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103836:	68 c0 3c 11 80       	push   $0x80113cc0
8010383b:	e8 40 0d 00 00       	call   80104580 <release>

  if (first) {
80103840:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103845:	83 c4 10             	add    $0x10,%esp
80103848:	85 c0                	test   %eax,%eax
8010384a:	75 04                	jne    80103850 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010384c:	c9                   	leave  
8010384d:	c3                   	ret    
8010384e:	66 90                	xchg   %ax,%ax
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
80103850:	83 ec 0c             	sub    $0xc,%esp

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80103853:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
8010385a:	00 00 00 
    iinit(ROOTDEV);
8010385d:	6a 01                	push   $0x1
8010385f:	e8 cc dd ff ff       	call   80101630 <iinit>
    initlog(ROOTDEV);
80103864:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010386b:	e8 00 f4 ff ff       	call   80102c70 <initlog>
80103870:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103873:	c9                   	leave  
80103874:	c3                   	ret    
80103875:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103880 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80103880:	55                   	push   %ebp
80103881:	89 e5                	mov    %esp,%ebp
80103883:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103886:	68 d5 76 10 80       	push   $0x801076d5
8010388b:	68 c0 3c 11 80       	push   $0x80113cc0
80103890:	e8 cb 0a 00 00       	call   80104360 <initlock>
}
80103895:	83 c4 10             	add    $0x10,%esp
80103898:	c9                   	leave  
80103899:	c3                   	ret    
8010389a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801038a0 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
801038a0:	55                   	push   %ebp
801038a1:	89 e5                	mov    %esp,%ebp
801038a3:	56                   	push   %esi
801038a4:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801038a5:	9c                   	pushf  
801038a6:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
801038a7:	f6 c4 02             	test   $0x2,%ah
801038aa:	75 5b                	jne    80103907 <mycpu+0x67>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
801038ac:	e8 ff ef ff ff       	call   801028b0 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
801038b1:	8b 35 a0 3c 11 80    	mov    0x80113ca0,%esi
801038b7:	85 f6                	test   %esi,%esi
801038b9:	7e 3f                	jle    801038fa <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
801038bb:	0f b6 15 20 37 11 80 	movzbl 0x80113720,%edx
801038c2:	39 d0                	cmp    %edx,%eax
801038c4:	74 30                	je     801038f6 <mycpu+0x56>
801038c6:	b9 d0 37 11 80       	mov    $0x801137d0,%ecx
801038cb:	31 d2                	xor    %edx,%edx
801038cd:	8d 76 00             	lea    0x0(%esi),%esi
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
801038d0:	83 c2 01             	add    $0x1,%edx
801038d3:	39 f2                	cmp    %esi,%edx
801038d5:	74 23                	je     801038fa <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
801038d7:	0f b6 19             	movzbl (%ecx),%ebx
801038da:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
801038e0:	39 d8                	cmp    %ebx,%eax
801038e2:	75 ec                	jne    801038d0 <mycpu+0x30>
      return &cpus[i];
801038e4:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
  }
  panic("unknown apicid\n");
}
801038ea:	8d 65 f8             	lea    -0x8(%ebp),%esp
801038ed:	5b                   	pop    %ebx
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
801038ee:	05 20 37 11 80       	add    $0x80113720,%eax
  }
  panic("unknown apicid\n");
}
801038f3:	5e                   	pop    %esi
801038f4:	5d                   	pop    %ebp
801038f5:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
801038f6:	31 d2                	xor    %edx,%edx
801038f8:	eb ea                	jmp    801038e4 <mycpu+0x44>
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
801038fa:	83 ec 0c             	sub    $0xc,%esp
801038fd:	68 dc 76 10 80       	push   $0x801076dc
80103902:	e8 69 ca ff ff       	call   80100370 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
80103907:	83 ec 0c             	sub    $0xc,%esp
8010390a:	68 b8 77 10 80       	push   $0x801077b8
8010390f:	e8 5c ca ff ff       	call   80100370 <panic>
80103914:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010391a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103920 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
80103920:	55                   	push   %ebp
80103921:	89 e5                	mov    %esp,%ebp
80103923:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103926:	e8 75 ff ff ff       	call   801038a0 <mycpu>
8010392b:	2d 20 37 11 80       	sub    $0x80113720,%eax
}
80103930:	c9                   	leave  
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
80103931:	c1 f8 04             	sar    $0x4,%eax
80103934:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010393a:	c3                   	ret    
8010393b:	90                   	nop
8010393c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103940 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
80103940:	55                   	push   %ebp
80103941:	89 e5                	mov    %esp,%ebp
80103943:	53                   	push   %ebx
80103944:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
80103947:	e8 d4 0a 00 00       	call   80104420 <pushcli>
  c = mycpu();
8010394c:	e8 4f ff ff ff       	call   801038a0 <mycpu>
  p = c->proc;
80103951:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103957:	e8 b4 0b 00 00       	call   80104510 <popcli>
  return p;
}
8010395c:	83 c4 04             	add    $0x4,%esp
8010395f:	89 d8                	mov    %ebx,%eax
80103961:	5b                   	pop    %ebx
80103962:	5d                   	pop    %ebp
80103963:	c3                   	ret    
80103964:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010396a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103970 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80103970:	55                   	push   %ebp
80103971:	89 e5                	mov    %esp,%ebp
80103973:	53                   	push   %ebx
80103974:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
80103977:	e8 f4 fd ff ff       	call   80103770 <allocproc>
8010397c:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
8010397e:	a3 58 b5 10 80       	mov    %eax,0x8010b558
  if((p->pgdir = setupkvm()) == 0)
80103983:	e8 58 35 00 00       	call   80106ee0 <setupkvm>
80103988:	85 c0                	test   %eax,%eax
8010398a:	89 43 04             	mov    %eax,0x4(%ebx)
8010398d:	0f 84 bd 00 00 00    	je     80103a50 <userinit+0xe0>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103993:	83 ec 04             	sub    $0x4,%esp
80103996:	68 2c 00 00 00       	push   $0x2c
8010399b:	68 60 a4 10 80       	push   $0x8010a460
801039a0:	50                   	push   %eax
801039a1:	e8 4a 32 00 00       	call   80106bf0 <inituvm>
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
801039a6:	83 c4 0c             	add    $0xc,%esp
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
801039a9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801039af:	6a 4c                	push   $0x4c
801039b1:	6a 00                	push   $0x0
801039b3:	ff 73 18             	pushl  0x18(%ebx)
801039b6:	e8 15 0c 00 00       	call   801045d0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801039bb:	8b 43 18             	mov    0x18(%ebx),%eax
801039be:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801039c3:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
801039c8:	83 c4 0c             	add    $0xc,%esp
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801039cb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801039cf:	8b 43 18             	mov    0x18(%ebx),%eax
801039d2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801039d6:	8b 43 18             	mov    0x18(%ebx),%eax
801039d9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801039dd:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801039e1:	8b 43 18             	mov    0x18(%ebx),%eax
801039e4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801039e8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801039ec:	8b 43 18             	mov    0x18(%ebx),%eax
801039ef:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801039f6:	8b 43 18             	mov    0x18(%ebx),%eax
801039f9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103a00:	8b 43 18             	mov    0x18(%ebx),%eax
80103a03:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a0a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103a0d:	6a 10                	push   $0x10
80103a0f:	68 05 77 10 80       	push   $0x80107705
80103a14:	50                   	push   %eax
80103a15:	e8 b6 0d 00 00       	call   801047d0 <safestrcpy>
  p->cwd = namei("/");
80103a1a:	c7 04 24 0e 77 10 80 	movl   $0x8010770e,(%esp)
80103a21:	e8 5a e6 ff ff       	call   80102080 <namei>
80103a26:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80103a29:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103a30:	e8 2b 0a 00 00       	call   80104460 <acquire>

  p->state = RUNNABLE;
80103a35:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
80103a3c:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103a43:	e8 38 0b 00 00       	call   80104580 <release>
}
80103a48:	83 c4 10             	add    $0x10,%esp
80103a4b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a4e:	c9                   	leave  
80103a4f:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
80103a50:	83 ec 0c             	sub    $0xc,%esp
80103a53:	68 ec 76 10 80       	push   $0x801076ec
80103a58:	e8 13 c9 ff ff       	call   80100370 <panic>
80103a5d:	8d 76 00             	lea    0x0(%esi),%esi

80103a60 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80103a60:	55                   	push   %ebp
80103a61:	89 e5                	mov    %esp,%ebp
80103a63:	56                   	push   %esi
80103a64:	53                   	push   %ebx
80103a65:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103a68:	e8 b3 09 00 00       	call   80104420 <pushcli>
  c = mycpu();
80103a6d:	e8 2e fe ff ff       	call   801038a0 <mycpu>
  p = c->proc;
80103a72:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a78:	e8 93 0a 00 00       	call   80104510 <popcli>
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
80103a7d:	83 fe 00             	cmp    $0x0,%esi
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
80103a80:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103a82:	7e 34                	jle    80103ab8 <growproc+0x58>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a84:	83 ec 04             	sub    $0x4,%esp
80103a87:	01 c6                	add    %eax,%esi
80103a89:	56                   	push   %esi
80103a8a:	50                   	push   %eax
80103a8b:	ff 73 04             	pushl  0x4(%ebx)
80103a8e:	e8 9d 32 00 00       	call   80106d30 <allocuvm>
80103a93:	83 c4 10             	add    $0x10,%esp
80103a96:	85 c0                	test   %eax,%eax
80103a98:	74 36                	je     80103ad0 <growproc+0x70>
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
80103a9a:	83 ec 0c             	sub    $0xc,%esp
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
80103a9d:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103a9f:	53                   	push   %ebx
80103aa0:	e8 3b 30 00 00       	call   80106ae0 <switchuvm>
  return 0;
80103aa5:	83 c4 10             	add    $0x10,%esp
80103aa8:	31 c0                	xor    %eax,%eax
}
80103aaa:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103aad:	5b                   	pop    %ebx
80103aae:	5e                   	pop    %esi
80103aaf:	5d                   	pop    %ebp
80103ab0:	c3                   	ret    
80103ab1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80103ab8:	74 e0                	je     80103a9a <growproc+0x3a>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103aba:	83 ec 04             	sub    $0x4,%esp
80103abd:	01 c6                	add    %eax,%esi
80103abf:	56                   	push   %esi
80103ac0:	50                   	push   %eax
80103ac1:	ff 73 04             	pushl  0x4(%ebx)
80103ac4:	e8 67 33 00 00       	call   80106e30 <deallocuvm>
80103ac9:	83 c4 10             	add    $0x10,%esp
80103acc:	85 c0                	test   %eax,%eax
80103ace:	75 ca                	jne    80103a9a <growproc+0x3a>
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
80103ad0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103ad5:	eb d3                	jmp    80103aaa <growproc+0x4a>
80103ad7:	89 f6                	mov    %esi,%esi
80103ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ae0 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103ae0:	55                   	push   %ebp
80103ae1:	89 e5                	mov    %esp,%ebp
80103ae3:	57                   	push   %edi
80103ae4:	56                   	push   %esi
80103ae5:	53                   	push   %ebx
80103ae6:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103ae9:	e8 32 09 00 00       	call   80104420 <pushcli>
  c = mycpu();
80103aee:	e8 ad fd ff ff       	call   801038a0 <mycpu>
  p = c->proc;
80103af3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103af9:	e8 12 0a 00 00       	call   80104510 <popcli>
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
80103afe:	e8 6d fc ff ff       	call   80103770 <allocproc>
80103b03:	85 c0                	test   %eax,%eax
80103b05:	89 c7                	mov    %eax,%edi
80103b07:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103b0a:	0f 84 b5 00 00 00    	je     80103bc5 <fork+0xe5>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103b10:	83 ec 08             	sub    $0x8,%esp
80103b13:	ff 33                	pushl  (%ebx)
80103b15:	ff 73 04             	pushl  0x4(%ebx)
80103b18:	e8 93 34 00 00       	call   80106fb0 <copyuvm>
80103b1d:	83 c4 10             	add    $0x10,%esp
80103b20:	85 c0                	test   %eax,%eax
80103b22:	89 47 04             	mov    %eax,0x4(%edi)
80103b25:	0f 84 a1 00 00 00    	je     80103bcc <fork+0xec>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
80103b2b:	8b 03                	mov    (%ebx),%eax
80103b2d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103b30:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103b32:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103b35:	89 c8                	mov    %ecx,%eax
80103b37:	8b 79 18             	mov    0x18(%ecx),%edi
80103b3a:	8b 73 18             	mov    0x18(%ebx),%esi
80103b3d:	b9 13 00 00 00       	mov    $0x13,%ecx
80103b42:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103b44:	31 f6                	xor    %esi,%esi
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103b46:	8b 40 18             	mov    0x18(%eax),%eax
80103b49:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
80103b50:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103b54:	85 c0                	test   %eax,%eax
80103b56:	74 13                	je     80103b6b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103b58:	83 ec 0c             	sub    $0xc,%esp
80103b5b:	50                   	push   %eax
80103b5c:	e8 3f d4 ff ff       	call   80100fa0 <filedup>
80103b61:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103b64:	83 c4 10             	add    $0x10,%esp
80103b67:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103b6b:	83 c6 01             	add    $0x1,%esi
80103b6e:	83 fe 10             	cmp    $0x10,%esi
80103b71:	75 dd                	jne    80103b50 <fork+0x70>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103b73:	83 ec 0c             	sub    $0xc,%esp
80103b76:	ff 73 68             	pushl  0x68(%ebx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b79:	83 c3 6c             	add    $0x6c,%ebx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103b7c:	e8 7f dc ff ff       	call   80101800 <idup>
80103b81:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b84:	83 c4 0c             	add    $0xc,%esp
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103b87:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b8a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103b8d:	6a 10                	push   $0x10
80103b8f:	53                   	push   %ebx
80103b90:	50                   	push   %eax
80103b91:	e8 3a 0c 00 00       	call   801047d0 <safestrcpy>

  pid = np->pid;
80103b96:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
80103b99:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103ba0:	e8 bb 08 00 00       	call   80104460 <acquire>

  np->state = RUNNABLE;
80103ba5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
80103bac:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103bb3:	e8 c8 09 00 00       	call   80104580 <release>

  return pid;
80103bb8:	83 c4 10             	add    $0x10,%esp
80103bbb:	89 d8                	mov    %ebx,%eax
}
80103bbd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103bc0:	5b                   	pop    %ebx
80103bc1:	5e                   	pop    %esi
80103bc2:	5f                   	pop    %edi
80103bc3:	5d                   	pop    %ebp
80103bc4:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103bc5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103bca:	eb f1                	jmp    80103bbd <fork+0xdd>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
80103bcc:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103bcf:	83 ec 0c             	sub    $0xc,%esp
80103bd2:	ff 77 08             	pushl  0x8(%edi)
80103bd5:	e8 c6 e8 ff ff       	call   801024a0 <kfree>
    np->kstack = 0;
80103bda:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103be1:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103be8:	83 c4 10             	add    $0x10,%esp
80103beb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103bf0:	eb cb                	jmp    80103bbd <fork+0xdd>
80103bf2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c00 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103c00:	55                   	push   %ebp
80103c01:	89 e5                	mov    %esp,%ebp
80103c03:	57                   	push   %edi
80103c04:	56                   	push   %esi
80103c05:	53                   	push   %ebx
80103c06:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80103c09:	e8 92 fc ff ff       	call   801038a0 <mycpu>
80103c0e:	8d 78 04             	lea    0x4(%eax),%edi
80103c11:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103c13:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103c1a:	00 00 00 
80103c1d:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103c20:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103c21:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c24:	bb f4 3c 11 80       	mov    $0x80113cf4,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103c29:	68 c0 3c 11 80       	push   $0x80113cc0
80103c2e:	e8 2d 08 00 00       	call   80104460 <acquire>
80103c33:	83 c4 10             	add    $0x10,%esp
80103c36:	eb 13                	jmp    80103c4b <scheduler+0x4b>
80103c38:	90                   	nop
80103c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c40:	83 c3 7c             	add    $0x7c,%ebx
80103c43:	81 fb f4 5b 11 80    	cmp    $0x80115bf4,%ebx
80103c49:	74 45                	je     80103c90 <scheduler+0x90>
      if(p->state != RUNNABLE)
80103c4b:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103c4f:	75 ef                	jne    80103c40 <scheduler+0x40>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103c51:	83 ec 0c             	sub    $0xc,%esp
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
80103c54:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103c5a:	53                   	push   %ebx
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c5b:	83 c3 7c             	add    $0x7c,%ebx

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103c5e:	e8 7d 2e 00 00       	call   80106ae0 <switchuvm>
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
80103c63:	58                   	pop    %eax
80103c64:	5a                   	pop    %edx
80103c65:	ff 73 a0             	pushl  -0x60(%ebx)
80103c68:	57                   	push   %edi
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103c69:	c7 43 90 04 00 00 00 	movl   $0x4,-0x70(%ebx)

      swtch(&(c->scheduler), p->context);
80103c70:	e8 b6 0b 00 00       	call   8010482b <swtch>
      switchkvm();
80103c75:	e8 46 2e 00 00       	call   80106ac0 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103c7a:	83 c4 10             	add    $0x10,%esp
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c7d:	81 fb f4 5b 11 80    	cmp    $0x80115bf4,%ebx
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103c83:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103c8a:	00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c8d:	75 bc                	jne    80103c4b <scheduler+0x4b>
80103c8f:	90                   	nop

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
80103c90:	83 ec 0c             	sub    $0xc,%esp
80103c93:	68 c0 3c 11 80       	push   $0x80113cc0
80103c98:	e8 e3 08 00 00       	call   80104580 <release>

  }
80103c9d:	83 c4 10             	add    $0x10,%esp
80103ca0:	e9 7b ff ff ff       	jmp    80103c20 <scheduler+0x20>
80103ca5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103cb0 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103cb0:	55                   	push   %ebp
80103cb1:	89 e5                	mov    %esp,%ebp
80103cb3:	56                   	push   %esi
80103cb4:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103cb5:	e8 66 07 00 00       	call   80104420 <pushcli>
  c = mycpu();
80103cba:	e8 e1 fb ff ff       	call   801038a0 <mycpu>
  p = c->proc;
80103cbf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103cc5:	e8 46 08 00 00       	call   80104510 <popcli>
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
80103cca:	83 ec 0c             	sub    $0xc,%esp
80103ccd:	68 c0 3c 11 80       	push   $0x80113cc0
80103cd2:	e8 09 07 00 00       	call   801043e0 <holding>
80103cd7:	83 c4 10             	add    $0x10,%esp
80103cda:	85 c0                	test   %eax,%eax
80103cdc:	74 4f                	je     80103d2d <sched+0x7d>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
80103cde:	e8 bd fb ff ff       	call   801038a0 <mycpu>
80103ce3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103cea:	75 68                	jne    80103d54 <sched+0xa4>
    panic("sched locks");
  if(p->state == RUNNING)
80103cec:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103cf0:	74 55                	je     80103d47 <sched+0x97>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103cf2:	9c                   	pushf  
80103cf3:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
80103cf4:	f6 c4 02             	test   $0x2,%ah
80103cf7:	75 41                	jne    80103d3a <sched+0x8a>
    panic("sched interruptible");
  intena = mycpu()->intena;
80103cf9:	e8 a2 fb ff ff       	call   801038a0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103cfe:	83 c3 1c             	add    $0x1c,%ebx
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
80103d01:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103d07:	e8 94 fb ff ff       	call   801038a0 <mycpu>
80103d0c:	83 ec 08             	sub    $0x8,%esp
80103d0f:	ff 70 04             	pushl  0x4(%eax)
80103d12:	53                   	push   %ebx
80103d13:	e8 13 0b 00 00       	call   8010482b <swtch>
  mycpu()->intena = intena;
80103d18:	e8 83 fb ff ff       	call   801038a0 <mycpu>
}
80103d1d:	83 c4 10             	add    $0x10,%esp
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
80103d20:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103d26:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103d29:	5b                   	pop    %ebx
80103d2a:	5e                   	pop    %esi
80103d2b:	5d                   	pop    %ebp
80103d2c:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103d2d:	83 ec 0c             	sub    $0xc,%esp
80103d30:	68 10 77 10 80       	push   $0x80107710
80103d35:	e8 36 c6 ff ff       	call   80100370 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103d3a:	83 ec 0c             	sub    $0xc,%esp
80103d3d:	68 3c 77 10 80       	push   $0x8010773c
80103d42:	e8 29 c6 ff ff       	call   80100370 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
80103d47:	83 ec 0c             	sub    $0xc,%esp
80103d4a:	68 2e 77 10 80       	push   $0x8010772e
80103d4f:	e8 1c c6 ff ff       	call   80100370 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80103d54:	83 ec 0c             	sub    $0xc,%esp
80103d57:	68 22 77 10 80       	push   $0x80107722
80103d5c:	e8 0f c6 ff ff       	call   80100370 <panic>
80103d61:	eb 0d                	jmp    80103d70 <exit>
80103d63:	90                   	nop
80103d64:	90                   	nop
80103d65:	90                   	nop
80103d66:	90                   	nop
80103d67:	90                   	nop
80103d68:	90                   	nop
80103d69:	90                   	nop
80103d6a:	90                   	nop
80103d6b:	90                   	nop
80103d6c:	90                   	nop
80103d6d:	90                   	nop
80103d6e:	90                   	nop
80103d6f:	90                   	nop

80103d70 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103d70:	55                   	push   %ebp
80103d71:	89 e5                	mov    %esp,%ebp
80103d73:	57                   	push   %edi
80103d74:	56                   	push   %esi
80103d75:	53                   	push   %ebx
80103d76:	83 ec 0c             	sub    $0xc,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103d79:	e8 a2 06 00 00       	call   80104420 <pushcli>
  c = mycpu();
80103d7e:	e8 1d fb ff ff       	call   801038a0 <mycpu>
  p = c->proc;
80103d83:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103d89:	e8 82 07 00 00       	call   80104510 <popcli>
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103d8e:	39 35 58 b5 10 80    	cmp    %esi,0x8010b558
80103d94:	8d 5e 28             	lea    0x28(%esi),%ebx
80103d97:	8d 7e 68             	lea    0x68(%esi),%edi
80103d9a:	0f 84 e7 00 00 00    	je     80103e87 <exit+0x117>
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
80103da0:	8b 03                	mov    (%ebx),%eax
80103da2:	85 c0                	test   %eax,%eax
80103da4:	74 12                	je     80103db8 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103da6:	83 ec 0c             	sub    $0xc,%esp
80103da9:	50                   	push   %eax
80103daa:	e8 41 d2 ff ff       	call   80100ff0 <fileclose>
      curproc->ofile[fd] = 0;
80103daf:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103db5:	83 c4 10             	add    $0x10,%esp
80103db8:	83 c3 04             	add    $0x4,%ebx

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103dbb:	39 df                	cmp    %ebx,%edi
80103dbd:	75 e1                	jne    80103da0 <exit+0x30>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
80103dbf:	e8 4c ef ff ff       	call   80102d10 <begin_op>
  iput(curproc->cwd);
80103dc4:	83 ec 0c             	sub    $0xc,%esp
80103dc7:	ff 76 68             	pushl  0x68(%esi)
80103dca:	e8 91 db ff ff       	call   80101960 <iput>
  end_op();
80103dcf:	e8 ac ef ff ff       	call   80102d80 <end_op>
  curproc->cwd = 0;
80103dd4:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)

  acquire(&ptable.lock);
80103ddb:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103de2:	e8 79 06 00 00       	call   80104460 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80103de7:	8b 56 14             	mov    0x14(%esi),%edx
80103dea:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ded:	b8 f4 3c 11 80       	mov    $0x80113cf4,%eax
80103df2:	eb 0e                	jmp    80103e02 <exit+0x92>
80103df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103df8:	83 c0 7c             	add    $0x7c,%eax
80103dfb:	3d f4 5b 11 80       	cmp    $0x80115bf4,%eax
80103e00:	74 1c                	je     80103e1e <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80103e02:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e06:	75 f0                	jne    80103df8 <exit+0x88>
80103e08:	3b 50 20             	cmp    0x20(%eax),%edx
80103e0b:	75 eb                	jne    80103df8 <exit+0x88>
      p->state = RUNNABLE;
80103e0d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e14:	83 c0 7c             	add    $0x7c,%eax
80103e17:	3d f4 5b 11 80       	cmp    $0x80115bf4,%eax
80103e1c:	75 e4                	jne    80103e02 <exit+0x92>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103e1e:	8b 0d 58 b5 10 80    	mov    0x8010b558,%ecx
80103e24:	ba f4 3c 11 80       	mov    $0x80113cf4,%edx
80103e29:	eb 10                	jmp    80103e3b <exit+0xcb>
80103e2b:	90                   	nop
80103e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e30:	83 c2 7c             	add    $0x7c,%edx
80103e33:	81 fa f4 5b 11 80    	cmp    $0x80115bf4,%edx
80103e39:	74 33                	je     80103e6e <exit+0xfe>
    if(p->parent == curproc){
80103e3b:	39 72 14             	cmp    %esi,0x14(%edx)
80103e3e:	75 f0                	jne    80103e30 <exit+0xc0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103e40:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103e44:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103e47:	75 e7                	jne    80103e30 <exit+0xc0>
80103e49:	b8 f4 3c 11 80       	mov    $0x80113cf4,%eax
80103e4e:	eb 0a                	jmp    80103e5a <exit+0xea>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e50:	83 c0 7c             	add    $0x7c,%eax
80103e53:	3d f4 5b 11 80       	cmp    $0x80115bf4,%eax
80103e58:	74 d6                	je     80103e30 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103e5a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e5e:	75 f0                	jne    80103e50 <exit+0xe0>
80103e60:	3b 48 20             	cmp    0x20(%eax),%ecx
80103e63:	75 eb                	jne    80103e50 <exit+0xe0>
      p->state = RUNNABLE;
80103e65:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103e6c:	eb e2                	jmp    80103e50 <exit+0xe0>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80103e6e:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103e75:	e8 36 fe ff ff       	call   80103cb0 <sched>
  panic("zombie exit");
80103e7a:	83 ec 0c             	sub    $0xc,%esp
80103e7d:	68 5d 77 10 80       	push   $0x8010775d
80103e82:	e8 e9 c4 ff ff       	call   80100370 <panic>
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");
80103e87:	83 ec 0c             	sub    $0xc,%esp
80103e8a:	68 50 77 10 80       	push   $0x80107750
80103e8f:	e8 dc c4 ff ff       	call   80100370 <panic>
80103e94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103e9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103ea0 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103ea0:	55                   	push   %ebp
80103ea1:	89 e5                	mov    %esp,%ebp
80103ea3:	53                   	push   %ebx
80103ea4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103ea7:	68 c0 3c 11 80       	push   $0x80113cc0
80103eac:	e8 af 05 00 00       	call   80104460 <acquire>
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103eb1:	e8 6a 05 00 00       	call   80104420 <pushcli>
  c = mycpu();
80103eb6:	e8 e5 f9 ff ff       	call   801038a0 <mycpu>
  p = c->proc;
80103ebb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ec1:	e8 4a 06 00 00       	call   80104510 <popcli>
// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
80103ec6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103ecd:	e8 de fd ff ff       	call   80103cb0 <sched>
  release(&ptable.lock);
80103ed2:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103ed9:	e8 a2 06 00 00       	call   80104580 <release>
}
80103ede:	83 c4 10             	add    $0x10,%esp
80103ee1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ee4:	c9                   	leave  
80103ee5:	c3                   	ret    
80103ee6:	8d 76 00             	lea    0x0(%esi),%esi
80103ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ef0 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103ef0:	55                   	push   %ebp
80103ef1:	89 e5                	mov    %esp,%ebp
80103ef3:	57                   	push   %edi
80103ef4:	56                   	push   %esi
80103ef5:	53                   	push   %ebx
80103ef6:	83 ec 0c             	sub    $0xc,%esp
80103ef9:	8b 7d 08             	mov    0x8(%ebp),%edi
80103efc:	8b 75 0c             	mov    0xc(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103eff:	e8 1c 05 00 00       	call   80104420 <pushcli>
  c = mycpu();
80103f04:	e8 97 f9 ff ff       	call   801038a0 <mycpu>
  p = c->proc;
80103f09:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f0f:	e8 fc 05 00 00       	call   80104510 <popcli>
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
80103f14:	85 db                	test   %ebx,%ebx
80103f16:	0f 84 87 00 00 00    	je     80103fa3 <sleep+0xb3>
    panic("sleep");

  if(lk == 0)
80103f1c:	85 f6                	test   %esi,%esi
80103f1e:	74 76                	je     80103f96 <sleep+0xa6>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103f20:	81 fe c0 3c 11 80    	cmp    $0x80113cc0,%esi
80103f26:	74 50                	je     80103f78 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103f28:	83 ec 0c             	sub    $0xc,%esp
80103f2b:	68 c0 3c 11 80       	push   $0x80113cc0
80103f30:	e8 2b 05 00 00       	call   80104460 <acquire>
    release(lk);
80103f35:	89 34 24             	mov    %esi,(%esp)
80103f38:	e8 43 06 00 00       	call   80104580 <release>
  }
  // Go to sleep.
  p->chan = chan;
80103f3d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103f40:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80103f47:	e8 64 fd ff ff       	call   80103cb0 <sched>

  // Tidy up.
  p->chan = 0;
80103f4c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80103f53:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103f5a:	e8 21 06 00 00       	call   80104580 <release>
    acquire(lk);
80103f5f:	89 75 08             	mov    %esi,0x8(%ebp)
80103f62:	83 c4 10             	add    $0x10,%esp
  }
}
80103f65:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f68:	5b                   	pop    %ebx
80103f69:	5e                   	pop    %esi
80103f6a:	5f                   	pop    %edi
80103f6b:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
80103f6c:	e9 ef 04 00 00       	jmp    80104460 <acquire>
80103f71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
80103f78:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103f7b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80103f82:	e8 29 fd ff ff       	call   80103cb0 <sched>

  // Tidy up.
  p->chan = 0;
80103f87:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
80103f8e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f91:	5b                   	pop    %ebx
80103f92:	5e                   	pop    %esi
80103f93:	5f                   	pop    %edi
80103f94:	5d                   	pop    %ebp
80103f95:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80103f96:	83 ec 0c             	sub    $0xc,%esp
80103f99:	68 6f 77 10 80       	push   $0x8010776f
80103f9e:	e8 cd c3 ff ff       	call   80100370 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
80103fa3:	83 ec 0c             	sub    $0xc,%esp
80103fa6:	68 69 77 10 80       	push   $0x80107769
80103fab:	e8 c0 c3 ff ff       	call   80100370 <panic>

80103fb0 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80103fb0:	55                   	push   %ebp
80103fb1:	89 e5                	mov    %esp,%ebp
80103fb3:	56                   	push   %esi
80103fb4:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103fb5:	e8 66 04 00 00       	call   80104420 <pushcli>
  c = mycpu();
80103fba:	e8 e1 f8 ff ff       	call   801038a0 <mycpu>
  p = c->proc;
80103fbf:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103fc5:	e8 46 05 00 00       	call   80104510 <popcli>
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
80103fca:	83 ec 0c             	sub    $0xc,%esp
80103fcd:	68 c0 3c 11 80       	push   $0x80113cc0
80103fd2:	e8 89 04 00 00       	call   80104460 <acquire>
80103fd7:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80103fda:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fdc:	bb f4 3c 11 80       	mov    $0x80113cf4,%ebx
80103fe1:	eb 10                	jmp    80103ff3 <wait+0x43>
80103fe3:	90                   	nop
80103fe4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103fe8:	83 c3 7c             	add    $0x7c,%ebx
80103feb:	81 fb f4 5b 11 80    	cmp    $0x80115bf4,%ebx
80103ff1:	74 1d                	je     80104010 <wait+0x60>
      if(p->parent != curproc)
80103ff3:	39 73 14             	cmp    %esi,0x14(%ebx)
80103ff6:	75 f0                	jne    80103fe8 <wait+0x38>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80103ff8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103ffc:	74 30                	je     8010402e <wait+0x7e>
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ffe:	83 c3 7c             	add    $0x7c,%ebx
      if(p->parent != curproc)
        continue;
      havekids = 1;
80104001:	b8 01 00 00 00       	mov    $0x1,%eax
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104006:	81 fb f4 5b 11 80    	cmp    $0x80115bf4,%ebx
8010400c:	75 e5                	jne    80103ff3 <wait+0x43>
8010400e:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80104010:	85 c0                	test   %eax,%eax
80104012:	74 70                	je     80104084 <wait+0xd4>
80104014:	8b 46 24             	mov    0x24(%esi),%eax
80104017:	85 c0                	test   %eax,%eax
80104019:	75 69                	jne    80104084 <wait+0xd4>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
8010401b:	83 ec 08             	sub    $0x8,%esp
8010401e:	68 c0 3c 11 80       	push   $0x80113cc0
80104023:	56                   	push   %esi
80104024:	e8 c7 fe ff ff       	call   80103ef0 <sleep>
  }
80104029:	83 c4 10             	add    $0x10,%esp
8010402c:	eb ac                	jmp    80103fda <wait+0x2a>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
8010402e:	83 ec 0c             	sub    $0xc,%esp
80104031:	ff 73 08             	pushl  0x8(%ebx)
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80104034:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104037:	e8 64 e4 ff ff       	call   801024a0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
8010403c:	5a                   	pop    %edx
8010403d:	ff 73 04             	pushl  0x4(%ebx)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80104040:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104047:	e8 14 2e 00 00       	call   80106e60 <freevm>
        p->pid = 0;
8010404c:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104053:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010405a:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
8010405e:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104065:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010406c:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80104073:	e8 08 05 00 00       	call   80104580 <release>
        return pid;
80104078:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
8010407b:	8d 65 f8             	lea    -0x8(%ebp),%esp
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
8010407e:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104080:	5b                   	pop    %ebx
80104081:	5e                   	pop    %esi
80104082:	5d                   	pop    %ebp
80104083:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
80104084:	83 ec 0c             	sub    $0xc,%esp
80104087:	68 c0 3c 11 80       	push   $0x80113cc0
8010408c:	e8 ef 04 00 00       	call   80104580 <release>
      return -1;
80104091:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104094:	8d 65 f8             	lea    -0x8(%ebp),%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
80104097:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
8010409c:	5b                   	pop    %ebx
8010409d:	5e                   	pop    %esi
8010409e:	5d                   	pop    %ebp
8010409f:	c3                   	ret    

801040a0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801040a0:	55                   	push   %ebp
801040a1:	89 e5                	mov    %esp,%ebp
801040a3:	53                   	push   %ebx
801040a4:	83 ec 10             	sub    $0x10,%esp
801040a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801040aa:	68 c0 3c 11 80       	push   $0x80113cc0
801040af:	e8 ac 03 00 00       	call   80104460 <acquire>
801040b4:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040b7:	b8 f4 3c 11 80       	mov    $0x80113cf4,%eax
801040bc:	eb 0c                	jmp    801040ca <wakeup+0x2a>
801040be:	66 90                	xchg   %ax,%ax
801040c0:	83 c0 7c             	add    $0x7c,%eax
801040c3:	3d f4 5b 11 80       	cmp    $0x80115bf4,%eax
801040c8:	74 1c                	je     801040e6 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
801040ca:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801040ce:	75 f0                	jne    801040c0 <wakeup+0x20>
801040d0:	3b 58 20             	cmp    0x20(%eax),%ebx
801040d3:	75 eb                	jne    801040c0 <wakeup+0x20>
      p->state = RUNNABLE;
801040d5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040dc:	83 c0 7c             	add    $0x7c,%eax
801040df:	3d f4 5b 11 80       	cmp    $0x80115bf4,%eax
801040e4:	75 e4                	jne    801040ca <wakeup+0x2a>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
801040e6:	c7 45 08 c0 3c 11 80 	movl   $0x80113cc0,0x8(%ebp)
}
801040ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040f0:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
801040f1:	e9 8a 04 00 00       	jmp    80104580 <release>
801040f6:	8d 76 00             	lea    0x0(%esi),%esi
801040f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104100 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104100:	55                   	push   %ebp
80104101:	89 e5                	mov    %esp,%ebp
80104103:	53                   	push   %ebx
80104104:	83 ec 10             	sub    $0x10,%esp
80104107:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010410a:	68 c0 3c 11 80       	push   $0x80113cc0
8010410f:	e8 4c 03 00 00       	call   80104460 <acquire>
80104114:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104117:	b8 f4 3c 11 80       	mov    $0x80113cf4,%eax
8010411c:	eb 0c                	jmp    8010412a <kill+0x2a>
8010411e:	66 90                	xchg   %ax,%ax
80104120:	83 c0 7c             	add    $0x7c,%eax
80104123:	3d f4 5b 11 80       	cmp    $0x80115bf4,%eax
80104128:	74 3e                	je     80104168 <kill+0x68>
    if(p->pid == pid){
8010412a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010412d:	75 f1                	jne    80104120 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010412f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
80104133:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010413a:	74 1c                	je     80104158 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
8010413c:	83 ec 0c             	sub    $0xc,%esp
8010413f:	68 c0 3c 11 80       	push   $0x80113cc0
80104144:	e8 37 04 00 00       	call   80104580 <release>
      return 0;
80104149:	83 c4 10             	add    $0x10,%esp
8010414c:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
8010414e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104151:	c9                   	leave  
80104152:	c3                   	ret    
80104153:	90                   	nop
80104154:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80104158:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010415f:	eb db                	jmp    8010413c <kill+0x3c>
80104161:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104168:	83 ec 0c             	sub    $0xc,%esp
8010416b:	68 c0 3c 11 80       	push   $0x80113cc0
80104170:	e8 0b 04 00 00       	call   80104580 <release>
  return -1;
80104175:	83 c4 10             	add    $0x10,%esp
80104178:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010417d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104180:	c9                   	leave  
80104181:	c3                   	ret    
80104182:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104190 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104190:	55                   	push   %ebp
80104191:	89 e5                	mov    %esp,%ebp
80104193:	57                   	push   %edi
80104194:	56                   	push   %esi
80104195:	53                   	push   %ebx
80104196:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104199:	bb 60 3d 11 80       	mov    $0x80113d60,%ebx
8010419e:	83 ec 3c             	sub    $0x3c,%esp
801041a1:	eb 24                	jmp    801041c7 <procdump+0x37>
801041a3:	90                   	nop
801041a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801041a8:	83 ec 0c             	sub    $0xc,%esp
801041ab:	68 03 7b 10 80       	push   $0x80107b03
801041b0:	e8 fb c4 ff ff       	call   801006b0 <cprintf>
801041b5:	83 c4 10             	add    $0x10,%esp
801041b8:	83 c3 7c             	add    $0x7c,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041bb:	81 fb 60 5c 11 80    	cmp    $0x80115c60,%ebx
801041c1:	0f 84 81 00 00 00    	je     80104248 <procdump+0xb8>
    if(p->state == UNUSED)
801041c7:	8b 43 a0             	mov    -0x60(%ebx),%eax
801041ca:	85 c0                	test   %eax,%eax
801041cc:	74 ea                	je     801041b8 <procdump+0x28>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801041ce:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
801041d1:	ba 80 77 10 80       	mov    $0x80107780,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801041d6:	77 11                	ja     801041e9 <procdump+0x59>
801041d8:	8b 14 85 e0 77 10 80 	mov    -0x7fef8820(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
801041df:	b8 80 77 10 80       	mov    $0x80107780,%eax
801041e4:	85 d2                	test   %edx,%edx
801041e6:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801041e9:	53                   	push   %ebx
801041ea:	52                   	push   %edx
801041eb:	ff 73 a4             	pushl  -0x5c(%ebx)
801041ee:	68 84 77 10 80       	push   $0x80107784
801041f3:	e8 b8 c4 ff ff       	call   801006b0 <cprintf>
    if(p->state == SLEEPING){
801041f8:	83 c4 10             	add    $0x10,%esp
801041fb:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801041ff:	75 a7                	jne    801041a8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104201:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104204:	83 ec 08             	sub    $0x8,%esp
80104207:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010420a:	50                   	push   %eax
8010420b:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010420e:	8b 40 0c             	mov    0xc(%eax),%eax
80104211:	83 c0 08             	add    $0x8,%eax
80104214:	50                   	push   %eax
80104215:	e8 66 01 00 00       	call   80104380 <getcallerpcs>
8010421a:	83 c4 10             	add    $0x10,%esp
8010421d:	8d 76 00             	lea    0x0(%esi),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104220:	8b 17                	mov    (%edi),%edx
80104222:	85 d2                	test   %edx,%edx
80104224:	74 82                	je     801041a8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104226:	83 ec 08             	sub    $0x8,%esp
80104229:	83 c7 04             	add    $0x4,%edi
8010422c:	52                   	push   %edx
8010422d:	68 c1 71 10 80       	push   $0x801071c1
80104232:	e8 79 c4 ff ff       	call   801006b0 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104237:	83 c4 10             	add    $0x10,%esp
8010423a:	39 f7                	cmp    %esi,%edi
8010423c:	75 e2                	jne    80104220 <procdump+0x90>
8010423e:	e9 65 ff ff ff       	jmp    801041a8 <procdump+0x18>
80104243:	90                   	nop
80104244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104248:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010424b:	5b                   	pop    %ebx
8010424c:	5e                   	pop    %esi
8010424d:	5f                   	pop    %edi
8010424e:	5d                   	pop    %ebp
8010424f:	c3                   	ret    

80104250 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104250:	55                   	push   %ebp
80104251:	89 e5                	mov    %esp,%ebp
80104253:	53                   	push   %ebx
80104254:	83 ec 0c             	sub    $0xc,%esp
80104257:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010425a:	68 f8 77 10 80       	push   $0x801077f8
8010425f:	8d 43 04             	lea    0x4(%ebx),%eax
80104262:	50                   	push   %eax
80104263:	e8 f8 00 00 00       	call   80104360 <initlock>
  lk->name = name;
80104268:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010426b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104271:	83 c4 10             	add    $0x10,%esp
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
  lk->locked = 0;
  lk->pid = 0;
80104274:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
8010427b:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
8010427e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104281:	c9                   	leave  
80104282:	c3                   	ret    
80104283:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104290 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104290:	55                   	push   %ebp
80104291:	89 e5                	mov    %esp,%ebp
80104293:	56                   	push   %esi
80104294:	53                   	push   %ebx
80104295:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104298:	83 ec 0c             	sub    $0xc,%esp
8010429b:	8d 73 04             	lea    0x4(%ebx),%esi
8010429e:	56                   	push   %esi
8010429f:	e8 bc 01 00 00       	call   80104460 <acquire>
  while (lk->locked) {
801042a4:	8b 13                	mov    (%ebx),%edx
801042a6:	83 c4 10             	add    $0x10,%esp
801042a9:	85 d2                	test   %edx,%edx
801042ab:	74 16                	je     801042c3 <acquiresleep+0x33>
801042ad:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801042b0:	83 ec 08             	sub    $0x8,%esp
801042b3:	56                   	push   %esi
801042b4:	53                   	push   %ebx
801042b5:	e8 36 fc ff ff       	call   80103ef0 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
801042ba:	8b 03                	mov    (%ebx),%eax
801042bc:	83 c4 10             	add    $0x10,%esp
801042bf:	85 c0                	test   %eax,%eax
801042c1:	75 ed                	jne    801042b0 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
801042c3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801042c9:	e8 72 f6 ff ff       	call   80103940 <myproc>
801042ce:	8b 40 10             	mov    0x10(%eax),%eax
801042d1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801042d4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801042d7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042da:	5b                   	pop    %ebx
801042db:	5e                   	pop    %esi
801042dc:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
801042dd:	e9 9e 02 00 00       	jmp    80104580 <release>
801042e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801042f0 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
801042f0:	55                   	push   %ebp
801042f1:	89 e5                	mov    %esp,%ebp
801042f3:	56                   	push   %esi
801042f4:	53                   	push   %ebx
801042f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801042f8:	83 ec 0c             	sub    $0xc,%esp
801042fb:	8d 73 04             	lea    0x4(%ebx),%esi
801042fe:	56                   	push   %esi
801042ff:	e8 5c 01 00 00       	call   80104460 <acquire>
  lk->locked = 0;
80104304:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010430a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104311:	89 1c 24             	mov    %ebx,(%esp)
80104314:	e8 87 fd ff ff       	call   801040a0 <wakeup>
  release(&lk->lk);
80104319:	89 75 08             	mov    %esi,0x8(%ebp)
8010431c:	83 c4 10             	add    $0x10,%esp
}
8010431f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104322:	5b                   	pop    %ebx
80104323:	5e                   	pop    %esi
80104324:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
80104325:	e9 56 02 00 00       	jmp    80104580 <release>
8010432a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104330 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
80104330:	55                   	push   %ebp
80104331:	89 e5                	mov    %esp,%ebp
80104333:	56                   	push   %esi
80104334:	53                   	push   %ebx
80104335:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
80104338:	83 ec 0c             	sub    $0xc,%esp
8010433b:	8d 5e 04             	lea    0x4(%esi),%ebx
8010433e:	53                   	push   %ebx
8010433f:	e8 1c 01 00 00       	call   80104460 <acquire>
  r = lk->locked;
80104344:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
80104346:	89 1c 24             	mov    %ebx,(%esp)
80104349:	e8 32 02 00 00       	call   80104580 <release>
  return r;
}
8010434e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104351:	89 f0                	mov    %esi,%eax
80104353:	5b                   	pop    %ebx
80104354:	5e                   	pop    %esi
80104355:	5d                   	pop    %ebp
80104356:	c3                   	ret    
80104357:	66 90                	xchg   %ax,%ax
80104359:	66 90                	xchg   %ax,%ax
8010435b:	66 90                	xchg   %ax,%ax
8010435d:	66 90                	xchg   %ax,%ax
8010435f:	90                   	nop

80104360 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104360:	55                   	push   %ebp
80104361:	89 e5                	mov    %esp,%ebp
80104363:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104366:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104369:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
8010436f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
80104372:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104379:	5d                   	pop    %ebp
8010437a:	c3                   	ret    
8010437b:	90                   	nop
8010437c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104380 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104380:	55                   	push   %ebp
80104381:	89 e5                	mov    %esp,%ebp
80104383:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104384:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104387:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010438a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
8010438d:	31 c0                	xor    %eax,%eax
8010438f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104390:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104396:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010439c:	77 1a                	ja     801043b8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010439e:	8b 5a 04             	mov    0x4(%edx),%ebx
801043a1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801043a4:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
801043a7:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801043a9:	83 f8 0a             	cmp    $0xa,%eax
801043ac:	75 e2                	jne    80104390 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801043ae:	5b                   	pop    %ebx
801043af:	5d                   	pop    %ebp
801043b0:	c3                   	ret    
801043b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
801043b8:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801043bf:	83 c0 01             	add    $0x1,%eax
801043c2:	83 f8 0a             	cmp    $0xa,%eax
801043c5:	74 e7                	je     801043ae <getcallerpcs+0x2e>
    pcs[i] = 0;
801043c7:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801043ce:	83 c0 01             	add    $0x1,%eax
801043d1:	83 f8 0a             	cmp    $0xa,%eax
801043d4:	75 e2                	jne    801043b8 <getcallerpcs+0x38>
801043d6:	eb d6                	jmp    801043ae <getcallerpcs+0x2e>
801043d8:	90                   	nop
801043d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801043e0 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
801043e0:	55                   	push   %ebp
801043e1:	89 e5                	mov    %esp,%ebp
801043e3:	53                   	push   %ebx
801043e4:	83 ec 04             	sub    $0x4,%esp
801043e7:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == mycpu();
801043ea:	8b 02                	mov    (%edx),%eax
801043ec:	85 c0                	test   %eax,%eax
801043ee:	75 10                	jne    80104400 <holding+0x20>
}
801043f0:	83 c4 04             	add    $0x4,%esp
801043f3:	31 c0                	xor    %eax,%eax
801043f5:	5b                   	pop    %ebx
801043f6:	5d                   	pop    %ebp
801043f7:	c3                   	ret    
801043f8:	90                   	nop
801043f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80104400:	8b 5a 08             	mov    0x8(%edx),%ebx
80104403:	e8 98 f4 ff ff       	call   801038a0 <mycpu>
80104408:	39 c3                	cmp    %eax,%ebx
8010440a:	0f 94 c0             	sete   %al
}
8010440d:	83 c4 04             	add    $0x4,%esp

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80104410:	0f b6 c0             	movzbl %al,%eax
}
80104413:	5b                   	pop    %ebx
80104414:	5d                   	pop    %ebp
80104415:	c3                   	ret    
80104416:	8d 76 00             	lea    0x0(%esi),%esi
80104419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104420 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104420:	55                   	push   %ebp
80104421:	89 e5                	mov    %esp,%ebp
80104423:	53                   	push   %ebx
80104424:	83 ec 04             	sub    $0x4,%esp
80104427:	9c                   	pushf  
80104428:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
80104429:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010442a:	e8 71 f4 ff ff       	call   801038a0 <mycpu>
8010442f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104435:	85 c0                	test   %eax,%eax
80104437:	75 11                	jne    8010444a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104439:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010443f:	e8 5c f4 ff ff       	call   801038a0 <mycpu>
80104444:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010444a:	e8 51 f4 ff ff       	call   801038a0 <mycpu>
8010444f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104456:	83 c4 04             	add    $0x4,%esp
80104459:	5b                   	pop    %ebx
8010445a:	5d                   	pop    %ebp
8010445b:	c3                   	ret    
8010445c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104460 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104460:	55                   	push   %ebp
80104461:	89 e5                	mov    %esp,%ebp
80104463:	56                   	push   %esi
80104464:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104465:	e8 b6 ff ff ff       	call   80104420 <pushcli>
  if(holding(lk))
8010446a:	8b 5d 08             	mov    0x8(%ebp),%ebx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
8010446d:	8b 03                	mov    (%ebx),%eax
8010446f:	85 c0                	test   %eax,%eax
80104471:	75 7d                	jne    801044f0 <acquire+0x90>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104473:	ba 01 00 00 00       	mov    $0x1,%edx
80104478:	eb 09                	jmp    80104483 <acquire+0x23>
8010447a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104480:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104483:	89 d0                	mov    %edx,%eax
80104485:	f0 87 03             	lock xchg %eax,(%ebx)
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
80104488:	85 c0                	test   %eax,%eax
8010448a:	75 f4                	jne    80104480 <acquire+0x20>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
8010448c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
80104491:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104494:	e8 07 f4 ff ff       	call   801038a0 <mycpu>
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104499:	89 ea                	mov    %ebp,%edx
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
8010449b:	8d 4b 0c             	lea    0xc(%ebx),%ecx
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
8010449e:	89 43 08             	mov    %eax,0x8(%ebx)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801044a1:	31 c0                	xor    %eax,%eax
801044a3:	90                   	nop
801044a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801044a8:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801044ae:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801044b4:	77 1a                	ja     801044d0 <acquire+0x70>
      break;
    pcs[i] = ebp[1];     // saved %eip
801044b6:	8b 5a 04             	mov    0x4(%edx),%ebx
801044b9:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801044bc:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
801044bf:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801044c1:	83 f8 0a             	cmp    $0xa,%eax
801044c4:	75 e2                	jne    801044a8 <acquire+0x48>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}
801044c6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801044c9:	5b                   	pop    %ebx
801044ca:	5e                   	pop    %esi
801044cb:	5d                   	pop    %ebp
801044cc:	c3                   	ret    
801044cd:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
801044d0:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801044d7:	83 c0 01             	add    $0x1,%eax
801044da:	83 f8 0a             	cmp    $0xa,%eax
801044dd:	74 e7                	je     801044c6 <acquire+0x66>
    pcs[i] = 0;
801044df:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801044e6:	83 c0 01             	add    $0x1,%eax
801044e9:	83 f8 0a             	cmp    $0xa,%eax
801044ec:	75 e2                	jne    801044d0 <acquire+0x70>
801044ee:	eb d6                	jmp    801044c6 <acquire+0x66>

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
801044f0:	8b 73 08             	mov    0x8(%ebx),%esi
801044f3:	e8 a8 f3 ff ff       	call   801038a0 <mycpu>
801044f8:	39 c6                	cmp    %eax,%esi
801044fa:	0f 85 73 ff ff ff    	jne    80104473 <acquire+0x13>
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80104500:	83 ec 0c             	sub    $0xc,%esp
80104503:	68 03 78 10 80       	push   $0x80107803
80104508:	e8 63 be ff ff       	call   80100370 <panic>
8010450d:	8d 76 00             	lea    0x0(%esi),%esi

80104510 <popcli>:
  mycpu()->ncli += 1;
}

void
popcli(void)
{
80104510:	55                   	push   %ebp
80104511:	89 e5                	mov    %esp,%ebp
80104513:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104516:	9c                   	pushf  
80104517:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104518:	f6 c4 02             	test   $0x2,%ah
8010451b:	75 52                	jne    8010456f <popcli+0x5f>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010451d:	e8 7e f3 ff ff       	call   801038a0 <mycpu>
80104522:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80104528:	8d 51 ff             	lea    -0x1(%ecx),%edx
8010452b:	85 d2                	test   %edx,%edx
8010452d:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80104533:	78 2d                	js     80104562 <popcli+0x52>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104535:	e8 66 f3 ff ff       	call   801038a0 <mycpu>
8010453a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104540:	85 d2                	test   %edx,%edx
80104542:	74 0c                	je     80104550 <popcli+0x40>
    sti();
}
80104544:	c9                   	leave  
80104545:	c3                   	ret    
80104546:	8d 76 00             	lea    0x0(%esi),%esi
80104549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104550:	e8 4b f3 ff ff       	call   801038a0 <mycpu>
80104555:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010455b:	85 c0                	test   %eax,%eax
8010455d:	74 e5                	je     80104544 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
8010455f:	fb                   	sti    
    sti();
}
80104560:	c9                   	leave  
80104561:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
80104562:	83 ec 0c             	sub    $0xc,%esp
80104565:	68 22 78 10 80       	push   $0x80107822
8010456a:	e8 01 be ff ff       	call   80100370 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
8010456f:	83 ec 0c             	sub    $0xc,%esp
80104572:	68 0b 78 10 80       	push   $0x8010780b
80104577:	e8 f4 bd ff ff       	call   80100370 <panic>
8010457c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104580 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
80104580:	55                   	push   %ebp
80104581:	89 e5                	mov    %esp,%ebp
80104583:	56                   	push   %esi
80104584:	53                   	push   %ebx
80104585:	8b 5d 08             	mov    0x8(%ebp),%ebx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80104588:	8b 03                	mov    (%ebx),%eax
8010458a:	85 c0                	test   %eax,%eax
8010458c:	75 12                	jne    801045a0 <release+0x20>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
8010458e:	83 ec 0c             	sub    $0xc,%esp
80104591:	68 29 78 10 80       	push   $0x80107829
80104596:	e8 d5 bd ff ff       	call   80100370 <panic>
8010459b:	90                   	nop
8010459c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
801045a0:	8b 73 08             	mov    0x8(%ebx),%esi
801045a3:	e8 f8 f2 ff ff       	call   801038a0 <mycpu>
801045a8:	39 c6                	cmp    %eax,%esi
801045aa:	75 e2                	jne    8010458e <release+0xe>
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");

  lk->pcs[0] = 0;
801045ac:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801045b3:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
801045ba:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801045bf:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
801045c5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045c8:	5b                   	pop    %ebx
801045c9:	5e                   	pop    %esi
801045ca:	5d                   	pop    %ebp
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
801045cb:	e9 40 ff ff ff       	jmp    80104510 <popcli>

801045d0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801045d0:	55                   	push   %ebp
801045d1:	89 e5                	mov    %esp,%ebp
801045d3:	57                   	push   %edi
801045d4:	53                   	push   %ebx
801045d5:	8b 55 08             	mov    0x8(%ebp),%edx
801045d8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801045db:	f6 c2 03             	test   $0x3,%dl
801045de:	75 05                	jne    801045e5 <memset+0x15>
801045e0:	f6 c1 03             	test   $0x3,%cl
801045e3:	74 13                	je     801045f8 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
801045e5:	89 d7                	mov    %edx,%edi
801045e7:	8b 45 0c             	mov    0xc(%ebp),%eax
801045ea:	fc                   	cld    
801045eb:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801045ed:	5b                   	pop    %ebx
801045ee:	89 d0                	mov    %edx,%eax
801045f0:	5f                   	pop    %edi
801045f1:	5d                   	pop    %ebp
801045f2:	c3                   	ret    
801045f3:	90                   	nop
801045f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
801045f8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
801045fc:	c1 e9 02             	shr    $0x2,%ecx
801045ff:	89 fb                	mov    %edi,%ebx
80104601:	89 f8                	mov    %edi,%eax
80104603:	c1 e3 18             	shl    $0x18,%ebx
80104606:	c1 e0 10             	shl    $0x10,%eax
80104609:	09 d8                	or     %ebx,%eax
8010460b:	09 f8                	or     %edi,%eax
8010460d:	c1 e7 08             	shl    $0x8,%edi
80104610:	09 f8                	or     %edi,%eax
80104612:	89 d7                	mov    %edx,%edi
80104614:	fc                   	cld    
80104615:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104617:	5b                   	pop    %ebx
80104618:	89 d0                	mov    %edx,%eax
8010461a:	5f                   	pop    %edi
8010461b:	5d                   	pop    %ebp
8010461c:	c3                   	ret    
8010461d:	8d 76 00             	lea    0x0(%esi),%esi

80104620 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104620:	55                   	push   %ebp
80104621:	89 e5                	mov    %esp,%ebp
80104623:	57                   	push   %edi
80104624:	56                   	push   %esi
80104625:	8b 45 10             	mov    0x10(%ebp),%eax
80104628:	53                   	push   %ebx
80104629:	8b 75 0c             	mov    0xc(%ebp),%esi
8010462c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010462f:	85 c0                	test   %eax,%eax
80104631:	74 29                	je     8010465c <memcmp+0x3c>
    if(*s1 != *s2)
80104633:	0f b6 13             	movzbl (%ebx),%edx
80104636:	0f b6 0e             	movzbl (%esi),%ecx
80104639:	38 d1                	cmp    %dl,%cl
8010463b:	75 2b                	jne    80104668 <memcmp+0x48>
8010463d:	8d 78 ff             	lea    -0x1(%eax),%edi
80104640:	31 c0                	xor    %eax,%eax
80104642:	eb 14                	jmp    80104658 <memcmp+0x38>
80104644:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104648:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
8010464d:	83 c0 01             	add    $0x1,%eax
80104650:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104654:	38 ca                	cmp    %cl,%dl
80104656:	75 10                	jne    80104668 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104658:	39 f8                	cmp    %edi,%eax
8010465a:	75 ec                	jne    80104648 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010465c:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010465d:	31 c0                	xor    %eax,%eax
}
8010465f:	5e                   	pop    %esi
80104660:	5f                   	pop    %edi
80104661:	5d                   	pop    %ebp
80104662:	c3                   	ret    
80104663:	90                   	nop
80104664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80104668:	0f b6 c2             	movzbl %dl,%eax
    s1++, s2++;
  }

  return 0;
}
8010466b:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
8010466c:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
8010466e:	5e                   	pop    %esi
8010466f:	5f                   	pop    %edi
80104670:	5d                   	pop    %ebp
80104671:	c3                   	ret    
80104672:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104680 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104680:	55                   	push   %ebp
80104681:	89 e5                	mov    %esp,%ebp
80104683:	56                   	push   %esi
80104684:	53                   	push   %ebx
80104685:	8b 45 08             	mov    0x8(%ebp),%eax
80104688:	8b 75 0c             	mov    0xc(%ebp),%esi
8010468b:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010468e:	39 c6                	cmp    %eax,%esi
80104690:	73 2e                	jae    801046c0 <memmove+0x40>
80104692:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
80104695:	39 c8                	cmp    %ecx,%eax
80104697:	73 27                	jae    801046c0 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
80104699:	85 db                	test   %ebx,%ebx
8010469b:	8d 53 ff             	lea    -0x1(%ebx),%edx
8010469e:	74 17                	je     801046b7 <memmove+0x37>
      *--d = *--s;
801046a0:	29 d9                	sub    %ebx,%ecx
801046a2:	89 cb                	mov    %ecx,%ebx
801046a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046a8:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801046ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
801046af:	83 ea 01             	sub    $0x1,%edx
801046b2:	83 fa ff             	cmp    $0xffffffff,%edx
801046b5:	75 f1                	jne    801046a8 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801046b7:	5b                   	pop    %ebx
801046b8:	5e                   	pop    %esi
801046b9:	5d                   	pop    %ebp
801046ba:	c3                   	ret    
801046bb:	90                   	nop
801046bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801046c0:	31 d2                	xor    %edx,%edx
801046c2:	85 db                	test   %ebx,%ebx
801046c4:	74 f1                	je     801046b7 <memmove+0x37>
801046c6:	8d 76 00             	lea    0x0(%esi),%esi
801046c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *d++ = *s++;
801046d0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
801046d4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801046d7:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801046da:	39 d3                	cmp    %edx,%ebx
801046dc:	75 f2                	jne    801046d0 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
801046de:	5b                   	pop    %ebx
801046df:	5e                   	pop    %esi
801046e0:	5d                   	pop    %ebp
801046e1:	c3                   	ret    
801046e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046f0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801046f0:	55                   	push   %ebp
801046f1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
801046f3:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
801046f4:	eb 8a                	jmp    80104680 <memmove>
801046f6:	8d 76 00             	lea    0x0(%esi),%esi
801046f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104700 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104700:	55                   	push   %ebp
80104701:	89 e5                	mov    %esp,%ebp
80104703:	57                   	push   %edi
80104704:	56                   	push   %esi
80104705:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104708:	53                   	push   %ebx
80104709:	8b 7d 08             	mov    0x8(%ebp),%edi
8010470c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010470f:	85 c9                	test   %ecx,%ecx
80104711:	74 37                	je     8010474a <strncmp+0x4a>
80104713:	0f b6 17             	movzbl (%edi),%edx
80104716:	0f b6 1e             	movzbl (%esi),%ebx
80104719:	84 d2                	test   %dl,%dl
8010471b:	74 3f                	je     8010475c <strncmp+0x5c>
8010471d:	38 d3                	cmp    %dl,%bl
8010471f:	75 3b                	jne    8010475c <strncmp+0x5c>
80104721:	8d 47 01             	lea    0x1(%edi),%eax
80104724:	01 cf                	add    %ecx,%edi
80104726:	eb 1b                	jmp    80104743 <strncmp+0x43>
80104728:	90                   	nop
80104729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104730:	0f b6 10             	movzbl (%eax),%edx
80104733:	84 d2                	test   %dl,%dl
80104735:	74 21                	je     80104758 <strncmp+0x58>
80104737:	0f b6 19             	movzbl (%ecx),%ebx
8010473a:	83 c0 01             	add    $0x1,%eax
8010473d:	89 ce                	mov    %ecx,%esi
8010473f:	38 da                	cmp    %bl,%dl
80104741:	75 19                	jne    8010475c <strncmp+0x5c>
80104743:	39 c7                	cmp    %eax,%edi
    n--, p++, q++;
80104745:	8d 4e 01             	lea    0x1(%esi),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80104748:	75 e6                	jne    80104730 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
8010474a:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
8010474b:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
8010474d:	5e                   	pop    %esi
8010474e:	5f                   	pop    %edi
8010474f:	5d                   	pop    %ebp
80104750:	c3                   	ret    
80104751:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104758:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
8010475c:	0f b6 c2             	movzbl %dl,%eax
8010475f:	29 d8                	sub    %ebx,%eax
}
80104761:	5b                   	pop    %ebx
80104762:	5e                   	pop    %esi
80104763:	5f                   	pop    %edi
80104764:	5d                   	pop    %ebp
80104765:	c3                   	ret    
80104766:	8d 76 00             	lea    0x0(%esi),%esi
80104769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104770 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104770:	55                   	push   %ebp
80104771:	89 e5                	mov    %esp,%ebp
80104773:	56                   	push   %esi
80104774:	53                   	push   %ebx
80104775:	8b 45 08             	mov    0x8(%ebp),%eax
80104778:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010477b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010477e:	89 c2                	mov    %eax,%edx
80104780:	eb 19                	jmp    8010479b <strncpy+0x2b>
80104782:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104788:	83 c3 01             	add    $0x1,%ebx
8010478b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010478f:	83 c2 01             	add    $0x1,%edx
80104792:	84 c9                	test   %cl,%cl
80104794:	88 4a ff             	mov    %cl,-0x1(%edx)
80104797:	74 09                	je     801047a2 <strncpy+0x32>
80104799:	89 f1                	mov    %esi,%ecx
8010479b:	85 c9                	test   %ecx,%ecx
8010479d:	8d 71 ff             	lea    -0x1(%ecx),%esi
801047a0:	7f e6                	jg     80104788 <strncpy+0x18>
    ;
  while(n-- > 0)
801047a2:	31 c9                	xor    %ecx,%ecx
801047a4:	85 f6                	test   %esi,%esi
801047a6:	7e 17                	jle    801047bf <strncpy+0x4f>
801047a8:	90                   	nop
801047a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
801047b0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
801047b4:	89 f3                	mov    %esi,%ebx
801047b6:	83 c1 01             	add    $0x1,%ecx
801047b9:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
801047bb:	85 db                	test   %ebx,%ebx
801047bd:	7f f1                	jg     801047b0 <strncpy+0x40>
    *s++ = 0;
  return os;
}
801047bf:	5b                   	pop    %ebx
801047c0:	5e                   	pop    %esi
801047c1:	5d                   	pop    %ebp
801047c2:	c3                   	ret    
801047c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801047c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047d0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801047d0:	55                   	push   %ebp
801047d1:	89 e5                	mov    %esp,%ebp
801047d3:	56                   	push   %esi
801047d4:	53                   	push   %ebx
801047d5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801047d8:	8b 45 08             	mov    0x8(%ebp),%eax
801047db:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
801047de:	85 c9                	test   %ecx,%ecx
801047e0:	7e 26                	jle    80104808 <safestrcpy+0x38>
801047e2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
801047e6:	89 c1                	mov    %eax,%ecx
801047e8:	eb 17                	jmp    80104801 <safestrcpy+0x31>
801047ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801047f0:	83 c2 01             	add    $0x1,%edx
801047f3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
801047f7:	83 c1 01             	add    $0x1,%ecx
801047fa:	84 db                	test   %bl,%bl
801047fc:	88 59 ff             	mov    %bl,-0x1(%ecx)
801047ff:	74 04                	je     80104805 <safestrcpy+0x35>
80104801:	39 f2                	cmp    %esi,%edx
80104803:	75 eb                	jne    801047f0 <safestrcpy+0x20>
    ;
  *s = 0;
80104805:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104808:	5b                   	pop    %ebx
80104809:	5e                   	pop    %esi
8010480a:	5d                   	pop    %ebp
8010480b:	c3                   	ret    
8010480c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104810 <strlen>:

int
strlen(const char *s)
{
80104810:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104811:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
80104813:	89 e5                	mov    %esp,%ebp
80104815:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80104818:	80 3a 00             	cmpb   $0x0,(%edx)
8010481b:	74 0c                	je     80104829 <strlen+0x19>
8010481d:	8d 76 00             	lea    0x0(%esi),%esi
80104820:	83 c0 01             	add    $0x1,%eax
80104823:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104827:	75 f7                	jne    80104820 <strlen+0x10>
    ;
  return n;
}
80104829:	5d                   	pop    %ebp
8010482a:	c3                   	ret    

8010482b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010482b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010482f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80104833:	55                   	push   %ebp
  pushl %ebx
80104834:	53                   	push   %ebx
  pushl %esi
80104835:	56                   	push   %esi
  pushl %edi
80104836:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104837:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104839:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
8010483b:	5f                   	pop    %edi
  popl %esi
8010483c:	5e                   	pop    %esi
  popl %ebx
8010483d:	5b                   	pop    %ebx
  popl %ebp
8010483e:	5d                   	pop    %ebp
  ret
8010483f:	c3                   	ret    

80104840 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104840:	55                   	push   %ebp
80104841:	89 e5                	mov    %esp,%ebp
80104843:	53                   	push   %ebx
80104844:	83 ec 04             	sub    $0x4,%esp
80104847:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010484a:	e8 f1 f0 ff ff       	call   80103940 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010484f:	8b 00                	mov    (%eax),%eax
80104851:	39 d8                	cmp    %ebx,%eax
80104853:	76 1b                	jbe    80104870 <fetchint+0x30>
80104855:	8d 53 04             	lea    0x4(%ebx),%edx
80104858:	39 d0                	cmp    %edx,%eax
8010485a:	72 14                	jb     80104870 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010485c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010485f:	8b 13                	mov    (%ebx),%edx
80104861:	89 10                	mov    %edx,(%eax)
  return 0;
80104863:	31 c0                	xor    %eax,%eax
}
80104865:	83 c4 04             	add    $0x4,%esp
80104868:	5b                   	pop    %ebx
80104869:	5d                   	pop    %ebp
8010486a:	c3                   	ret    
8010486b:	90                   	nop
8010486c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104870:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104875:	eb ee                	jmp    80104865 <fetchint+0x25>
80104877:	89 f6                	mov    %esi,%esi
80104879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104880 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104880:	55                   	push   %ebp
80104881:	89 e5                	mov    %esp,%ebp
80104883:	53                   	push   %ebx
80104884:	83 ec 04             	sub    $0x4,%esp
80104887:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010488a:	e8 b1 f0 ff ff       	call   80103940 <myproc>

  if(addr >= curproc->sz)
8010488f:	39 18                	cmp    %ebx,(%eax)
80104891:	76 29                	jbe    801048bc <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104893:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104896:	89 da                	mov    %ebx,%edx
80104898:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010489a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010489c:	39 c3                	cmp    %eax,%ebx
8010489e:	73 1c                	jae    801048bc <fetchstr+0x3c>
    if(*s == 0)
801048a0:	80 3b 00             	cmpb   $0x0,(%ebx)
801048a3:	75 10                	jne    801048b5 <fetchstr+0x35>
801048a5:	eb 29                	jmp    801048d0 <fetchstr+0x50>
801048a7:	89 f6                	mov    %esi,%esi
801048a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801048b0:	80 3a 00             	cmpb   $0x0,(%edx)
801048b3:	74 1b                	je     801048d0 <fetchstr+0x50>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
801048b5:	83 c2 01             	add    $0x1,%edx
801048b8:	39 d0                	cmp    %edx,%eax
801048ba:	77 f4                	ja     801048b0 <fetchstr+0x30>
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
801048bc:	83 c4 04             	add    $0x4,%esp
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
801048bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
801048c4:	5b                   	pop    %ebx
801048c5:	5d                   	pop    %ebp
801048c6:	c3                   	ret    
801048c7:	89 f6                	mov    %esi,%esi
801048c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801048d0:	83 c4 04             	add    $0x4,%esp
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
801048d3:	89 d0                	mov    %edx,%eax
801048d5:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
801048d7:	5b                   	pop    %ebx
801048d8:	5d                   	pop    %ebp
801048d9:	c3                   	ret    
801048da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801048e0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801048e0:	55                   	push   %ebp
801048e1:	89 e5                	mov    %esp,%ebp
801048e3:	56                   	push   %esi
801048e4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801048e5:	e8 56 f0 ff ff       	call   80103940 <myproc>
801048ea:	8b 40 18             	mov    0x18(%eax),%eax
801048ed:	8b 55 08             	mov    0x8(%ebp),%edx
801048f0:	8b 40 44             	mov    0x44(%eax),%eax
801048f3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();
801048f6:	e8 45 f0 ff ff       	call   80103940 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801048fb:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801048fd:	8d 73 04             	lea    0x4(%ebx),%esi
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104900:	39 c6                	cmp    %eax,%esi
80104902:	73 1c                	jae    80104920 <argint+0x40>
80104904:	8d 53 08             	lea    0x8(%ebx),%edx
80104907:	39 d0                	cmp    %edx,%eax
80104909:	72 15                	jb     80104920 <argint+0x40>
    return -1;
  *ip = *(int*)(addr);
8010490b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010490e:	8b 53 04             	mov    0x4(%ebx),%edx
80104911:	89 10                	mov    %edx,(%eax)
  return 0;
80104913:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
}
80104915:	5b                   	pop    %ebx
80104916:	5e                   	pop    %esi
80104917:	5d                   	pop    %ebp
80104918:	c3                   	ret    
80104919:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104920:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104925:	eb ee                	jmp    80104915 <argint+0x35>
80104927:	89 f6                	mov    %esi,%esi
80104929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104930 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104930:	55                   	push   %ebp
80104931:	89 e5                	mov    %esp,%ebp
80104933:	56                   	push   %esi
80104934:	53                   	push   %ebx
80104935:	83 ec 10             	sub    $0x10,%esp
80104938:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010493b:	e8 00 f0 ff ff       	call   80103940 <myproc>
80104940:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104942:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104945:	83 ec 08             	sub    $0x8,%esp
80104948:	50                   	push   %eax
80104949:	ff 75 08             	pushl  0x8(%ebp)
8010494c:	e8 8f ff ff ff       	call   801048e0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104951:	c1 e8 1f             	shr    $0x1f,%eax
80104954:	83 c4 10             	add    $0x10,%esp
80104957:	84 c0                	test   %al,%al
80104959:	75 2d                	jne    80104988 <argptr+0x58>
8010495b:	89 d8                	mov    %ebx,%eax
8010495d:	c1 e8 1f             	shr    $0x1f,%eax
80104960:	84 c0                	test   %al,%al
80104962:	75 24                	jne    80104988 <argptr+0x58>
80104964:	8b 16                	mov    (%esi),%edx
80104966:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104969:	39 c2                	cmp    %eax,%edx
8010496b:	76 1b                	jbe    80104988 <argptr+0x58>
8010496d:	01 c3                	add    %eax,%ebx
8010496f:	39 da                	cmp    %ebx,%edx
80104971:	72 15                	jb     80104988 <argptr+0x58>
    return -1;
  *pp = (char*)i;
80104973:	8b 55 0c             	mov    0xc(%ebp),%edx
80104976:	89 02                	mov    %eax,(%edx)
  return 0;
80104978:	31 c0                	xor    %eax,%eax
}
8010497a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010497d:	5b                   	pop    %ebx
8010497e:	5e                   	pop    %esi
8010497f:	5d                   	pop    %ebp
80104980:	c3                   	ret    
80104981:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
80104988:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010498d:	eb eb                	jmp    8010497a <argptr+0x4a>
8010498f:	90                   	nop

80104990 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104990:	55                   	push   %ebp
80104991:	89 e5                	mov    %esp,%ebp
80104993:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104996:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104999:	50                   	push   %eax
8010499a:	ff 75 08             	pushl  0x8(%ebp)
8010499d:	e8 3e ff ff ff       	call   801048e0 <argint>
801049a2:	83 c4 10             	add    $0x10,%esp
801049a5:	85 c0                	test   %eax,%eax
801049a7:	78 17                	js     801049c0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
801049a9:	83 ec 08             	sub    $0x8,%esp
801049ac:	ff 75 0c             	pushl  0xc(%ebp)
801049af:	ff 75 f4             	pushl  -0xc(%ebp)
801049b2:	e8 c9 fe ff ff       	call   80104880 <fetchstr>
801049b7:	83 c4 10             	add    $0x10,%esp
}
801049ba:	c9                   	leave  
801049bb:	c3                   	ret    
801049bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
801049c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
801049c5:	c9                   	leave  
801049c6:	c3                   	ret    
801049c7:	89 f6                	mov    %esi,%esi
801049c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049d0 <syscall>:
[SYS_updatesc] sys_updatesc,
};

void
syscall(void)
{
801049d0:	55                   	push   %ebp
801049d1:	89 e5                	mov    %esp,%ebp
801049d3:	56                   	push   %esi
801049d4:	53                   	push   %ebx
  int num;
  struct proc *curproc = myproc();
801049d5:	e8 66 ef ff ff       	call   80103940 <myproc>

  num = curproc->tf->eax;
801049da:	8b 70 18             	mov    0x18(%eax),%esi

void
syscall(void)
{
  int num;
  struct proc *curproc = myproc();
801049dd:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
801049df:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801049e2:	8d 50 ff             	lea    -0x1(%eax),%edx
801049e5:	83 fa 17             	cmp    $0x17,%edx
801049e8:	77 1e                	ja     80104a08 <syscall+0x38>
801049ea:	8b 14 85 60 78 10 80 	mov    -0x7fef87a0(,%eax,4),%edx
801049f1:	85 d2                	test   %edx,%edx
801049f3:	74 13                	je     80104a08 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
801049f5:	ff d2                	call   *%edx
801049f7:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801049fa:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049fd:	5b                   	pop    %ebx
801049fe:	5e                   	pop    %esi
801049ff:	5d                   	pop    %ebp
80104a00:	c3                   	ret    
80104a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104a08:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104a09:	8d 43 6c             	lea    0x6c(%ebx),%eax

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104a0c:	50                   	push   %eax
80104a0d:	ff 73 10             	pushl  0x10(%ebx)
80104a10:	68 31 78 10 80       	push   $0x80107831
80104a15:	e8 96 bc ff ff       	call   801006b0 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
80104a1a:	8b 43 18             	mov    0x18(%ebx),%eax
80104a1d:	83 c4 10             	add    $0x10,%esp
80104a20:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80104a27:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a2a:	5b                   	pop    %ebx
80104a2b:	5e                   	pop    %esi
80104a2c:	5d                   	pop    %ebp
80104a2d:	c3                   	ret    
80104a2e:	66 90                	xchg   %ax,%ax

80104a30 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104a30:	55                   	push   %ebp
80104a31:	89 e5                	mov    %esp,%ebp
80104a33:	57                   	push   %edi
80104a34:	56                   	push   %esi
80104a35:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104a36:	8d 75 da             	lea    -0x26(%ebp),%esi
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104a39:	83 ec 44             	sub    $0x44,%esp
80104a3c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104a3f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104a42:	56                   	push   %esi
80104a43:	50                   	push   %eax
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104a44:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104a47:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104a4a:	e8 51 d6 ff ff       	call   801020a0 <nameiparent>
80104a4f:	83 c4 10             	add    $0x10,%esp
80104a52:	85 c0                	test   %eax,%eax
80104a54:	0f 84 f6 00 00 00    	je     80104b50 <create+0x120>
    return 0;
  ilock(dp);
80104a5a:	83 ec 0c             	sub    $0xc,%esp
80104a5d:	89 c7                	mov    %eax,%edi
80104a5f:	50                   	push   %eax
80104a60:	e8 cb cd ff ff       	call   80101830 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104a65:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104a68:	83 c4 0c             	add    $0xc,%esp
80104a6b:	50                   	push   %eax
80104a6c:	56                   	push   %esi
80104a6d:	57                   	push   %edi
80104a6e:	e8 ed d2 ff ff       	call   80101d60 <dirlookup>
80104a73:	83 c4 10             	add    $0x10,%esp
80104a76:	85 c0                	test   %eax,%eax
80104a78:	89 c3                	mov    %eax,%ebx
80104a7a:	74 54                	je     80104ad0 <create+0xa0>
    iunlockput(dp);
80104a7c:	83 ec 0c             	sub    $0xc,%esp
80104a7f:	57                   	push   %edi
80104a80:	e8 3b d0 ff ff       	call   80101ac0 <iunlockput>
    ilock(ip);
80104a85:	89 1c 24             	mov    %ebx,(%esp)
80104a88:	e8 a3 cd ff ff       	call   80101830 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104a8d:	83 c4 10             	add    $0x10,%esp
80104a90:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104a95:	75 19                	jne    80104ab0 <create+0x80>
80104a97:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
80104a9c:	89 d8                	mov    %ebx,%eax
80104a9e:	75 10                	jne    80104ab0 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104aa0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104aa3:	5b                   	pop    %ebx
80104aa4:	5e                   	pop    %esi
80104aa5:	5f                   	pop    %edi
80104aa6:	5d                   	pop    %ebp
80104aa7:	c3                   	ret    
80104aa8:	90                   	nop
80104aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80104ab0:	83 ec 0c             	sub    $0xc,%esp
80104ab3:	53                   	push   %ebx
80104ab4:	e8 07 d0 ff ff       	call   80101ac0 <iunlockput>
    return 0;
80104ab9:	83 c4 10             	add    $0x10,%esp
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104abc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
80104abf:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104ac1:	5b                   	pop    %ebx
80104ac2:	5e                   	pop    %esi
80104ac3:	5f                   	pop    %edi
80104ac4:	5d                   	pop    %ebp
80104ac5:	c3                   	ret    
80104ac6:	8d 76 00             	lea    0x0(%esi),%esi
80104ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80104ad0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104ad4:	83 ec 08             	sub    $0x8,%esp
80104ad7:	50                   	push   %eax
80104ad8:	ff 37                	pushl  (%edi)
80104ada:	e8 e1 cb ff ff       	call   801016c0 <ialloc>
80104adf:	83 c4 10             	add    $0x10,%esp
80104ae2:	85 c0                	test   %eax,%eax
80104ae4:	89 c3                	mov    %eax,%ebx
80104ae6:	0f 84 cc 00 00 00    	je     80104bb8 <create+0x188>
    panic("create: ialloc");

  ilock(ip);
80104aec:	83 ec 0c             	sub    $0xc,%esp
80104aef:	50                   	push   %eax
80104af0:	e8 3b cd ff ff       	call   80101830 <ilock>
  ip->major = major;
80104af5:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104af9:	66 89 43 52          	mov    %ax,0x52(%ebx)
  ip->minor = minor;
80104afd:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104b01:	66 89 43 54          	mov    %ax,0x54(%ebx)
  ip->nlink = 1;
80104b05:	b8 01 00 00 00       	mov    $0x1,%eax
80104b0a:	66 89 43 56          	mov    %ax,0x56(%ebx)
  iupdate(ip);
80104b0e:	89 1c 24             	mov    %ebx,(%esp)
80104b11:	e8 6a cc ff ff       	call   80101780 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80104b16:	83 c4 10             	add    $0x10,%esp
80104b19:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104b1e:	74 40                	je     80104b60 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80104b20:	83 ec 04             	sub    $0x4,%esp
80104b23:	ff 73 04             	pushl  0x4(%ebx)
80104b26:	56                   	push   %esi
80104b27:	57                   	push   %edi
80104b28:	e8 93 d4 ff ff       	call   80101fc0 <dirlink>
80104b2d:	83 c4 10             	add    $0x10,%esp
80104b30:	85 c0                	test   %eax,%eax
80104b32:	78 77                	js     80104bab <create+0x17b>
    panic("create: dirlink");

  iunlockput(dp);
80104b34:	83 ec 0c             	sub    $0xc,%esp
80104b37:	57                   	push   %edi
80104b38:	e8 83 cf ff ff       	call   80101ac0 <iunlockput>

  return ip;
80104b3d:	83 c4 10             	add    $0x10,%esp
}
80104b40:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
80104b43:	89 d8                	mov    %ebx,%eax
}
80104b45:	5b                   	pop    %ebx
80104b46:	5e                   	pop    %esi
80104b47:	5f                   	pop    %edi
80104b48:	5d                   	pop    %ebp
80104b49:	c3                   	ret    
80104b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80104b50:	31 c0                	xor    %eax,%eax
80104b52:	e9 49 ff ff ff       	jmp    80104aa0 <create+0x70>
80104b57:	89 f6                	mov    %esi,%esi
80104b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80104b60:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
    iupdate(dp);
80104b65:	83 ec 0c             	sub    $0xc,%esp
80104b68:	57                   	push   %edi
80104b69:	e8 12 cc ff ff       	call   80101780 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104b6e:	83 c4 0c             	add    $0xc,%esp
80104b71:	ff 73 04             	pushl  0x4(%ebx)
80104b74:	68 e0 78 10 80       	push   $0x801078e0
80104b79:	53                   	push   %ebx
80104b7a:	e8 41 d4 ff ff       	call   80101fc0 <dirlink>
80104b7f:	83 c4 10             	add    $0x10,%esp
80104b82:	85 c0                	test   %eax,%eax
80104b84:	78 18                	js     80104b9e <create+0x16e>
80104b86:	83 ec 04             	sub    $0x4,%esp
80104b89:	ff 77 04             	pushl  0x4(%edi)
80104b8c:	68 df 78 10 80       	push   $0x801078df
80104b91:	53                   	push   %ebx
80104b92:	e8 29 d4 ff ff       	call   80101fc0 <dirlink>
80104b97:	83 c4 10             	add    $0x10,%esp
80104b9a:	85 c0                	test   %eax,%eax
80104b9c:	79 82                	jns    80104b20 <create+0xf0>
      panic("create dots");
80104b9e:	83 ec 0c             	sub    $0xc,%esp
80104ba1:	68 d3 78 10 80       	push   $0x801078d3
80104ba6:	e8 c5 b7 ff ff       	call   80100370 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
80104bab:	83 ec 0c             	sub    $0xc,%esp
80104bae:	68 e2 78 10 80       	push   $0x801078e2
80104bb3:	e8 b8 b7 ff ff       	call   80100370 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80104bb8:	83 ec 0c             	sub    $0xc,%esp
80104bbb:	68 c4 78 10 80       	push   $0x801078c4
80104bc0:	e8 ab b7 ff ff       	call   80100370 <panic>
80104bc5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104bd0 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104bd0:	55                   	push   %ebp
80104bd1:	89 e5                	mov    %esp,%ebp
80104bd3:	56                   	push   %esi
80104bd4:	53                   	push   %ebx
80104bd5:	89 c6                	mov    %eax,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104bd7:	8d 45 f4             	lea    -0xc(%ebp),%eax
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104bda:	89 d3                	mov    %edx,%ebx
80104bdc:	83 ec 18             	sub    $0x18,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104bdf:	50                   	push   %eax
80104be0:	6a 00                	push   $0x0
80104be2:	e8 f9 fc ff ff       	call   801048e0 <argint>
80104be7:	83 c4 10             	add    $0x10,%esp
80104bea:	85 c0                	test   %eax,%eax
80104bec:	78 32                	js     80104c20 <argfd.constprop.0+0x50>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104bee:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104bf2:	77 2c                	ja     80104c20 <argfd.constprop.0+0x50>
80104bf4:	e8 47 ed ff ff       	call   80103940 <myproc>
80104bf9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104bfc:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104c00:	85 c0                	test   %eax,%eax
80104c02:	74 1c                	je     80104c20 <argfd.constprop.0+0x50>
    return -1;
  if(pfd)
80104c04:	85 f6                	test   %esi,%esi
80104c06:	74 02                	je     80104c0a <argfd.constprop.0+0x3a>
    *pfd = fd;
80104c08:	89 16                	mov    %edx,(%esi)
  if(pf)
80104c0a:	85 db                	test   %ebx,%ebx
80104c0c:	74 22                	je     80104c30 <argfd.constprop.0+0x60>
    *pf = f;
80104c0e:	89 03                	mov    %eax,(%ebx)
  return 0;
80104c10:	31 c0                	xor    %eax,%eax
}
80104c12:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c15:	5b                   	pop    %ebx
80104c16:	5e                   	pop    %esi
80104c17:	5d                   	pop    %ebp
80104c18:	c3                   	ret    
80104c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c20:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
80104c23:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
80104c28:	5b                   	pop    %ebx
80104c29:	5e                   	pop    %esi
80104c2a:	5d                   	pop    %ebp
80104c2b:	c3                   	ret    
80104c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
80104c30:	31 c0                	xor    %eax,%eax
80104c32:	eb de                	jmp    80104c12 <argfd.constprop.0+0x42>
80104c34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104c40 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80104c40:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104c41:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80104c43:	89 e5                	mov    %esp,%ebp
80104c45:	56                   	push   %esi
80104c46:	53                   	push   %ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104c47:	8d 55 f4             	lea    -0xc(%ebp),%edx
  return -1;
}

int
sys_dup(void)
{
80104c4a:	83 ec 10             	sub    $0x10,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104c4d:	e8 7e ff ff ff       	call   80104bd0 <argfd.constprop.0>
80104c52:	85 c0                	test   %eax,%eax
80104c54:	78 1a                	js     80104c70 <sys_dup+0x30>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104c56:	31 db                	xor    %ebx,%ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
80104c58:	8b 75 f4             	mov    -0xc(%ebp),%esi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80104c5b:	e8 e0 ec ff ff       	call   80103940 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80104c60:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104c64:	85 d2                	test   %edx,%edx
80104c66:	74 18                	je     80104c80 <sys_dup+0x40>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104c68:	83 c3 01             	add    $0x1,%ebx
80104c6b:	83 fb 10             	cmp    $0x10,%ebx
80104c6e:	75 f0                	jne    80104c60 <sys_dup+0x20>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104c70:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80104c73:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104c78:	5b                   	pop    %ebx
80104c79:	5e                   	pop    %esi
80104c7a:	5d                   	pop    %ebp
80104c7b:	c3                   	ret    
80104c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80104c80:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80104c84:	83 ec 0c             	sub    $0xc,%esp
80104c87:	ff 75 f4             	pushl  -0xc(%ebp)
80104c8a:	e8 11 c3 ff ff       	call   80100fa0 <filedup>
  return fd;
80104c8f:	83 c4 10             	add    $0x10,%esp
}
80104c92:	8d 65 f8             	lea    -0x8(%ebp),%esp
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
80104c95:	89 d8                	mov    %ebx,%eax
}
80104c97:	5b                   	pop    %ebx
80104c98:	5e                   	pop    %esi
80104c99:	5d                   	pop    %ebp
80104c9a:	c3                   	ret    
80104c9b:	90                   	nop
80104c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ca0 <sys_read>:

int
sys_read(void)
{
80104ca0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104ca1:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80104ca3:	89 e5                	mov    %esp,%ebp
80104ca5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104ca8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104cab:	e8 20 ff ff ff       	call   80104bd0 <argfd.constprop.0>
80104cb0:	85 c0                	test   %eax,%eax
80104cb2:	78 4c                	js     80104d00 <sys_read+0x60>
80104cb4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104cb7:	83 ec 08             	sub    $0x8,%esp
80104cba:	50                   	push   %eax
80104cbb:	6a 02                	push   $0x2
80104cbd:	e8 1e fc ff ff       	call   801048e0 <argint>
80104cc2:	83 c4 10             	add    $0x10,%esp
80104cc5:	85 c0                	test   %eax,%eax
80104cc7:	78 37                	js     80104d00 <sys_read+0x60>
80104cc9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ccc:	83 ec 04             	sub    $0x4,%esp
80104ccf:	ff 75 f0             	pushl  -0x10(%ebp)
80104cd2:	50                   	push   %eax
80104cd3:	6a 01                	push   $0x1
80104cd5:	e8 56 fc ff ff       	call   80104930 <argptr>
80104cda:	83 c4 10             	add    $0x10,%esp
80104cdd:	85 c0                	test   %eax,%eax
80104cdf:	78 1f                	js     80104d00 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80104ce1:	83 ec 04             	sub    $0x4,%esp
80104ce4:	ff 75 f0             	pushl  -0x10(%ebp)
80104ce7:	ff 75 f4             	pushl  -0xc(%ebp)
80104cea:	ff 75 ec             	pushl  -0x14(%ebp)
80104ced:	e8 1e c4 ff ff       	call   80101110 <fileread>
80104cf2:	83 c4 10             	add    $0x10,%esp
}
80104cf5:	c9                   	leave  
80104cf6:	c3                   	ret    
80104cf7:	89 f6                	mov    %esi,%esi
80104cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104d00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80104d05:	c9                   	leave  
80104d06:	c3                   	ret    
80104d07:	89 f6                	mov    %esi,%esi
80104d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d10 <sys_write>:

int
sys_write(void)
{
80104d10:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d11:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80104d13:	89 e5                	mov    %esp,%ebp
80104d15:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d18:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104d1b:	e8 b0 fe ff ff       	call   80104bd0 <argfd.constprop.0>
80104d20:	85 c0                	test   %eax,%eax
80104d22:	78 4c                	js     80104d70 <sys_write+0x60>
80104d24:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d27:	83 ec 08             	sub    $0x8,%esp
80104d2a:	50                   	push   %eax
80104d2b:	6a 02                	push   $0x2
80104d2d:	e8 ae fb ff ff       	call   801048e0 <argint>
80104d32:	83 c4 10             	add    $0x10,%esp
80104d35:	85 c0                	test   %eax,%eax
80104d37:	78 37                	js     80104d70 <sys_write+0x60>
80104d39:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d3c:	83 ec 04             	sub    $0x4,%esp
80104d3f:	ff 75 f0             	pushl  -0x10(%ebp)
80104d42:	50                   	push   %eax
80104d43:	6a 01                	push   $0x1
80104d45:	e8 e6 fb ff ff       	call   80104930 <argptr>
80104d4a:	83 c4 10             	add    $0x10,%esp
80104d4d:	85 c0                	test   %eax,%eax
80104d4f:	78 1f                	js     80104d70 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80104d51:	83 ec 04             	sub    $0x4,%esp
80104d54:	ff 75 f0             	pushl  -0x10(%ebp)
80104d57:	ff 75 f4             	pushl  -0xc(%ebp)
80104d5a:	ff 75 ec             	pushl  -0x14(%ebp)
80104d5d:	e8 3e c4 ff ff       	call   801011a0 <filewrite>
80104d62:	83 c4 10             	add    $0x10,%esp
}
80104d65:	c9                   	leave  
80104d66:	c3                   	ret    
80104d67:	89 f6                	mov    %esi,%esi
80104d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104d70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
80104d75:	c9                   	leave  
80104d76:	c3                   	ret    
80104d77:	89 f6                	mov    %esi,%esi
80104d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d80 <sys_close>:

int
sys_close(void)
{
80104d80:	55                   	push   %ebp
80104d81:	89 e5                	mov    %esp,%ebp
80104d83:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80104d86:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104d89:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d8c:	e8 3f fe ff ff       	call   80104bd0 <argfd.constprop.0>
80104d91:	85 c0                	test   %eax,%eax
80104d93:	78 2b                	js     80104dc0 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
80104d95:	e8 a6 eb ff ff       	call   80103940 <myproc>
80104d9a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104d9d:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  myproc()->ofile[fd] = 0;
80104da0:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104da7:	00 
  fileclose(f);
80104da8:	ff 75 f4             	pushl  -0xc(%ebp)
80104dab:	e8 40 c2 ff ff       	call   80100ff0 <fileclose>
  return 0;
80104db0:	83 c4 10             	add    $0x10,%esp
80104db3:	31 c0                	xor    %eax,%eax
}
80104db5:	c9                   	leave  
80104db6:	c3                   	ret    
80104db7:	89 f6                	mov    %esi,%esi
80104db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80104dc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80104dc5:	c9                   	leave  
80104dc6:	c3                   	ret    
80104dc7:	89 f6                	mov    %esi,%esi
80104dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104dd0 <sys_fstat>:

int
sys_fstat(void)
{
80104dd0:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104dd1:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80104dd3:	89 e5                	mov    %esp,%ebp
80104dd5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104dd8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104ddb:	e8 f0 fd ff ff       	call   80104bd0 <argfd.constprop.0>
80104de0:	85 c0                	test   %eax,%eax
80104de2:	78 2c                	js     80104e10 <sys_fstat+0x40>
80104de4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104de7:	83 ec 04             	sub    $0x4,%esp
80104dea:	6a 14                	push   $0x14
80104dec:	50                   	push   %eax
80104ded:	6a 01                	push   $0x1
80104def:	e8 3c fb ff ff       	call   80104930 <argptr>
80104df4:	83 c4 10             	add    $0x10,%esp
80104df7:	85 c0                	test   %eax,%eax
80104df9:	78 15                	js     80104e10 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
80104dfb:	83 ec 08             	sub    $0x8,%esp
80104dfe:	ff 75 f4             	pushl  -0xc(%ebp)
80104e01:	ff 75 f0             	pushl  -0x10(%ebp)
80104e04:	e8 b7 c2 ff ff       	call   801010c0 <filestat>
80104e09:	83 c4 10             	add    $0x10,%esp
}
80104e0c:	c9                   	leave  
80104e0d:	c3                   	ret    
80104e0e:	66 90                	xchg   %ax,%ax
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80104e10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80104e15:	c9                   	leave  
80104e16:	c3                   	ret    
80104e17:	89 f6                	mov    %esi,%esi
80104e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e20 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104e20:	55                   	push   %ebp
80104e21:	89 e5                	mov    %esp,%ebp
80104e23:	57                   	push   %edi
80104e24:	56                   	push   %esi
80104e25:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104e26:	8d 45 d4             	lea    -0x2c(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104e29:	83 ec 34             	sub    $0x34,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104e2c:	50                   	push   %eax
80104e2d:	6a 00                	push   $0x0
80104e2f:	e8 5c fb ff ff       	call   80104990 <argstr>
80104e34:	83 c4 10             	add    $0x10,%esp
80104e37:	85 c0                	test   %eax,%eax
80104e39:	0f 88 fb 00 00 00    	js     80104f3a <sys_link+0x11a>
80104e3f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104e42:	83 ec 08             	sub    $0x8,%esp
80104e45:	50                   	push   %eax
80104e46:	6a 01                	push   $0x1
80104e48:	e8 43 fb ff ff       	call   80104990 <argstr>
80104e4d:	83 c4 10             	add    $0x10,%esp
80104e50:	85 c0                	test   %eax,%eax
80104e52:	0f 88 e2 00 00 00    	js     80104f3a <sys_link+0x11a>
    return -1;

  begin_op();
80104e58:	e8 b3 de ff ff       	call   80102d10 <begin_op>
  if((ip = namei(old)) == 0){
80104e5d:	83 ec 0c             	sub    $0xc,%esp
80104e60:	ff 75 d4             	pushl  -0x2c(%ebp)
80104e63:	e8 18 d2 ff ff       	call   80102080 <namei>
80104e68:	83 c4 10             	add    $0x10,%esp
80104e6b:	85 c0                	test   %eax,%eax
80104e6d:	89 c3                	mov    %eax,%ebx
80104e6f:	0f 84 f3 00 00 00    	je     80104f68 <sys_link+0x148>
    end_op();
    return -1;
  }

  ilock(ip);
80104e75:	83 ec 0c             	sub    $0xc,%esp
80104e78:	50                   	push   %eax
80104e79:	e8 b2 c9 ff ff       	call   80101830 <ilock>
  if(ip->type == T_DIR){
80104e7e:	83 c4 10             	add    $0x10,%esp
80104e81:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104e86:	0f 84 c4 00 00 00    	je     80104f50 <sys_link+0x130>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
80104e8c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104e91:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80104e94:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80104e97:	53                   	push   %ebx
80104e98:	e8 e3 c8 ff ff       	call   80101780 <iupdate>
  iunlock(ip);
80104e9d:	89 1c 24             	mov    %ebx,(%esp)
80104ea0:	e8 6b ca ff ff       	call   80101910 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80104ea5:	58                   	pop    %eax
80104ea6:	5a                   	pop    %edx
80104ea7:	57                   	push   %edi
80104ea8:	ff 75 d0             	pushl  -0x30(%ebp)
80104eab:	e8 f0 d1 ff ff       	call   801020a0 <nameiparent>
80104eb0:	83 c4 10             	add    $0x10,%esp
80104eb3:	85 c0                	test   %eax,%eax
80104eb5:	89 c6                	mov    %eax,%esi
80104eb7:	74 5b                	je     80104f14 <sys_link+0xf4>
    goto bad;
  ilock(dp);
80104eb9:	83 ec 0c             	sub    $0xc,%esp
80104ebc:	50                   	push   %eax
80104ebd:	e8 6e c9 ff ff       	call   80101830 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104ec2:	83 c4 10             	add    $0x10,%esp
80104ec5:	8b 03                	mov    (%ebx),%eax
80104ec7:	39 06                	cmp    %eax,(%esi)
80104ec9:	75 3d                	jne    80104f08 <sys_link+0xe8>
80104ecb:	83 ec 04             	sub    $0x4,%esp
80104ece:	ff 73 04             	pushl  0x4(%ebx)
80104ed1:	57                   	push   %edi
80104ed2:	56                   	push   %esi
80104ed3:	e8 e8 d0 ff ff       	call   80101fc0 <dirlink>
80104ed8:	83 c4 10             	add    $0x10,%esp
80104edb:	85 c0                	test   %eax,%eax
80104edd:	78 29                	js     80104f08 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80104edf:	83 ec 0c             	sub    $0xc,%esp
80104ee2:	56                   	push   %esi
80104ee3:	e8 d8 cb ff ff       	call   80101ac0 <iunlockput>
  iput(ip);
80104ee8:	89 1c 24             	mov    %ebx,(%esp)
80104eeb:	e8 70 ca ff ff       	call   80101960 <iput>

  end_op();
80104ef0:	e8 8b de ff ff       	call   80102d80 <end_op>

  return 0;
80104ef5:	83 c4 10             	add    $0x10,%esp
80104ef8:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80104efa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104efd:	5b                   	pop    %ebx
80104efe:	5e                   	pop    %esi
80104eff:	5f                   	pop    %edi
80104f00:	5d                   	pop    %ebp
80104f01:	c3                   	ret    
80104f02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80104f08:	83 ec 0c             	sub    $0xc,%esp
80104f0b:	56                   	push   %esi
80104f0c:	e8 af cb ff ff       	call   80101ac0 <iunlockput>
    goto bad;
80104f11:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  ilock(ip);
80104f14:	83 ec 0c             	sub    $0xc,%esp
80104f17:	53                   	push   %ebx
80104f18:	e8 13 c9 ff ff       	call   80101830 <ilock>
  ip->nlink--;
80104f1d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104f22:	89 1c 24             	mov    %ebx,(%esp)
80104f25:	e8 56 c8 ff ff       	call   80101780 <iupdate>
  iunlockput(ip);
80104f2a:	89 1c 24             	mov    %ebx,(%esp)
80104f2d:	e8 8e cb ff ff       	call   80101ac0 <iunlockput>
  end_op();
80104f32:	e8 49 de ff ff       	call   80102d80 <end_op>
  return -1;
80104f37:	83 c4 10             	add    $0x10,%esp
}
80104f3a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
80104f3d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f42:	5b                   	pop    %ebx
80104f43:	5e                   	pop    %esi
80104f44:	5f                   	pop    %edi
80104f45:	5d                   	pop    %ebp
80104f46:	c3                   	ret    
80104f47:	89 f6                	mov    %esi,%esi
80104f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
80104f50:	83 ec 0c             	sub    $0xc,%esp
80104f53:	53                   	push   %ebx
80104f54:	e8 67 cb ff ff       	call   80101ac0 <iunlockput>
    end_op();
80104f59:	e8 22 de ff ff       	call   80102d80 <end_op>
    return -1;
80104f5e:	83 c4 10             	add    $0x10,%esp
80104f61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f66:	eb 92                	jmp    80104efa <sys_link+0xda>
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
80104f68:	e8 13 de ff ff       	call   80102d80 <end_op>
    return -1;
80104f6d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f72:	eb 86                	jmp    80104efa <sys_link+0xda>
80104f74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104f80 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104f80:	55                   	push   %ebp
80104f81:	89 e5                	mov    %esp,%ebp
80104f83:	57                   	push   %edi
80104f84:	56                   	push   %esi
80104f85:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104f86:	8d 45 c0             	lea    -0x40(%ebp),%eax
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104f89:	83 ec 54             	sub    $0x54,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104f8c:	50                   	push   %eax
80104f8d:	6a 00                	push   $0x0
80104f8f:	e8 fc f9 ff ff       	call   80104990 <argstr>
80104f94:	83 c4 10             	add    $0x10,%esp
80104f97:	85 c0                	test   %eax,%eax
80104f99:	0f 88 82 01 00 00    	js     80105121 <sys_unlink+0x1a1>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
80104f9f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
80104fa2:	e8 69 dd ff ff       	call   80102d10 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104fa7:	83 ec 08             	sub    $0x8,%esp
80104faa:	53                   	push   %ebx
80104fab:	ff 75 c0             	pushl  -0x40(%ebp)
80104fae:	e8 ed d0 ff ff       	call   801020a0 <nameiparent>
80104fb3:	83 c4 10             	add    $0x10,%esp
80104fb6:	85 c0                	test   %eax,%eax
80104fb8:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80104fbb:	0f 84 6a 01 00 00    	je     8010512b <sys_unlink+0x1ab>
    end_op();
    return -1;
  }

  ilock(dp);
80104fc1:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80104fc4:	83 ec 0c             	sub    $0xc,%esp
80104fc7:	56                   	push   %esi
80104fc8:	e8 63 c8 ff ff       	call   80101830 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104fcd:	58                   	pop    %eax
80104fce:	5a                   	pop    %edx
80104fcf:	68 e0 78 10 80       	push   $0x801078e0
80104fd4:	53                   	push   %ebx
80104fd5:	e8 66 cd ff ff       	call   80101d40 <namecmp>
80104fda:	83 c4 10             	add    $0x10,%esp
80104fdd:	85 c0                	test   %eax,%eax
80104fdf:	0f 84 fc 00 00 00    	je     801050e1 <sys_unlink+0x161>
80104fe5:	83 ec 08             	sub    $0x8,%esp
80104fe8:	68 df 78 10 80       	push   $0x801078df
80104fed:	53                   	push   %ebx
80104fee:	e8 4d cd ff ff       	call   80101d40 <namecmp>
80104ff3:	83 c4 10             	add    $0x10,%esp
80104ff6:	85 c0                	test   %eax,%eax
80104ff8:	0f 84 e3 00 00 00    	je     801050e1 <sys_unlink+0x161>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80104ffe:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105001:	83 ec 04             	sub    $0x4,%esp
80105004:	50                   	push   %eax
80105005:	53                   	push   %ebx
80105006:	56                   	push   %esi
80105007:	e8 54 cd ff ff       	call   80101d60 <dirlookup>
8010500c:	83 c4 10             	add    $0x10,%esp
8010500f:	85 c0                	test   %eax,%eax
80105011:	89 c3                	mov    %eax,%ebx
80105013:	0f 84 c8 00 00 00    	je     801050e1 <sys_unlink+0x161>
    goto bad;
  ilock(ip);
80105019:	83 ec 0c             	sub    $0xc,%esp
8010501c:	50                   	push   %eax
8010501d:	e8 0e c8 ff ff       	call   80101830 <ilock>

  if(ip->nlink < 1)
80105022:	83 c4 10             	add    $0x10,%esp
80105025:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010502a:	0f 8e 24 01 00 00    	jle    80105154 <sys_unlink+0x1d4>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80105030:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105035:	8d 75 d8             	lea    -0x28(%ebp),%esi
80105038:	74 66                	je     801050a0 <sys_unlink+0x120>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
8010503a:	83 ec 04             	sub    $0x4,%esp
8010503d:	6a 10                	push   $0x10
8010503f:	6a 00                	push   $0x0
80105041:	56                   	push   %esi
80105042:	e8 89 f5 ff ff       	call   801045d0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105047:	6a 10                	push   $0x10
80105049:	ff 75 c4             	pushl  -0x3c(%ebp)
8010504c:	56                   	push   %esi
8010504d:	ff 75 b4             	pushl  -0x4c(%ebp)
80105050:	e8 bb cb ff ff       	call   80101c10 <writei>
80105055:	83 c4 20             	add    $0x20,%esp
80105058:	83 f8 10             	cmp    $0x10,%eax
8010505b:	0f 85 e6 00 00 00    	jne    80105147 <sys_unlink+0x1c7>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80105061:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105066:	0f 84 9c 00 00 00    	je     80105108 <sys_unlink+0x188>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
8010506c:	83 ec 0c             	sub    $0xc,%esp
8010506f:	ff 75 b4             	pushl  -0x4c(%ebp)
80105072:	e8 49 ca ff ff       	call   80101ac0 <iunlockput>

  ip->nlink--;
80105077:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010507c:	89 1c 24             	mov    %ebx,(%esp)
8010507f:	e8 fc c6 ff ff       	call   80101780 <iupdate>
  iunlockput(ip);
80105084:	89 1c 24             	mov    %ebx,(%esp)
80105087:	e8 34 ca ff ff       	call   80101ac0 <iunlockput>

  end_op();
8010508c:	e8 ef dc ff ff       	call   80102d80 <end_op>

  return 0;
80105091:	83 c4 10             	add    $0x10,%esp
80105094:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80105096:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105099:	5b                   	pop    %ebx
8010509a:	5e                   	pop    %esi
8010509b:	5f                   	pop    %edi
8010509c:	5d                   	pop    %ebp
8010509d:	c3                   	ret    
8010509e:	66 90                	xchg   %ax,%ax
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801050a0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801050a4:	76 94                	jbe    8010503a <sys_unlink+0xba>
801050a6:	bf 20 00 00 00       	mov    $0x20,%edi
801050ab:	eb 0f                	jmp    801050bc <sys_unlink+0x13c>
801050ad:	8d 76 00             	lea    0x0(%esi),%esi
801050b0:	83 c7 10             	add    $0x10,%edi
801050b3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801050b6:	0f 83 7e ff ff ff    	jae    8010503a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801050bc:	6a 10                	push   $0x10
801050be:	57                   	push   %edi
801050bf:	56                   	push   %esi
801050c0:	53                   	push   %ebx
801050c1:	e8 4a ca ff ff       	call   80101b10 <readi>
801050c6:	83 c4 10             	add    $0x10,%esp
801050c9:	83 f8 10             	cmp    $0x10,%eax
801050cc:	75 6c                	jne    8010513a <sys_unlink+0x1ba>
      panic("isdirempty: readi");
    if(de.inum != 0)
801050ce:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801050d3:	74 db                	je     801050b0 <sys_unlink+0x130>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
801050d5:	83 ec 0c             	sub    $0xc,%esp
801050d8:	53                   	push   %ebx
801050d9:	e8 e2 c9 ff ff       	call   80101ac0 <iunlockput>
    goto bad;
801050de:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  iunlockput(dp);
801050e1:	83 ec 0c             	sub    $0xc,%esp
801050e4:	ff 75 b4             	pushl  -0x4c(%ebp)
801050e7:	e8 d4 c9 ff ff       	call   80101ac0 <iunlockput>
  end_op();
801050ec:	e8 8f dc ff ff       	call   80102d80 <end_op>
  return -1;
801050f1:	83 c4 10             	add    $0x10,%esp
}
801050f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
801050f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801050fc:	5b                   	pop    %ebx
801050fd:	5e                   	pop    %esi
801050fe:	5f                   	pop    %edi
801050ff:	5d                   	pop    %ebp
80105100:	c3                   	ret    
80105101:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80105108:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
8010510b:	83 ec 0c             	sub    $0xc,%esp

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
8010510e:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80105113:	50                   	push   %eax
80105114:	e8 67 c6 ff ff       	call   80101780 <iupdate>
80105119:	83 c4 10             	add    $0x10,%esp
8010511c:	e9 4b ff ff ff       	jmp    8010506c <sys_unlink+0xec>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
80105121:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105126:	e9 6b ff ff ff       	jmp    80105096 <sys_unlink+0x116>

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
8010512b:	e8 50 dc ff ff       	call   80102d80 <end_op>
    return -1;
80105130:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105135:	e9 5c ff ff ff       	jmp    80105096 <sys_unlink+0x116>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
8010513a:	83 ec 0c             	sub    $0xc,%esp
8010513d:	68 04 79 10 80       	push   $0x80107904
80105142:	e8 29 b2 ff ff       	call   80100370 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
80105147:	83 ec 0c             	sub    $0xc,%esp
8010514a:	68 16 79 10 80       	push   $0x80107916
8010514f:	e8 1c b2 ff ff       	call   80100370 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
80105154:	83 ec 0c             	sub    $0xc,%esp
80105157:	68 f2 78 10 80       	push   $0x801078f2
8010515c:	e8 0f b2 ff ff       	call   80100370 <panic>
80105161:	eb 0d                	jmp    80105170 <sys_open>
80105163:	90                   	nop
80105164:	90                   	nop
80105165:	90                   	nop
80105166:	90                   	nop
80105167:	90                   	nop
80105168:	90                   	nop
80105169:	90                   	nop
8010516a:	90                   	nop
8010516b:	90                   	nop
8010516c:	90                   	nop
8010516d:	90                   	nop
8010516e:	90                   	nop
8010516f:	90                   	nop

80105170 <sys_open>:
  return ip;
}

int
sys_open(void)
{
80105170:	55                   	push   %ebp
80105171:	89 e5                	mov    %esp,%ebp
80105173:	57                   	push   %edi
80105174:	56                   	push   %esi
80105175:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105176:	8d 45 e0             	lea    -0x20(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
80105179:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010517c:	50                   	push   %eax
8010517d:	6a 00                	push   $0x0
8010517f:	e8 0c f8 ff ff       	call   80104990 <argstr>
80105184:	83 c4 10             	add    $0x10,%esp
80105187:	85 c0                	test   %eax,%eax
80105189:	0f 88 9e 00 00 00    	js     8010522d <sys_open+0xbd>
8010518f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105192:	83 ec 08             	sub    $0x8,%esp
80105195:	50                   	push   %eax
80105196:	6a 01                	push   $0x1
80105198:	e8 43 f7 ff ff       	call   801048e0 <argint>
8010519d:	83 c4 10             	add    $0x10,%esp
801051a0:	85 c0                	test   %eax,%eax
801051a2:	0f 88 85 00 00 00    	js     8010522d <sys_open+0xbd>
    return -1;

  begin_op();
801051a8:	e8 63 db ff ff       	call   80102d10 <begin_op>

  if(omode & O_CREATE){
801051ad:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801051b1:	0f 85 89 00 00 00    	jne    80105240 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801051b7:	83 ec 0c             	sub    $0xc,%esp
801051ba:	ff 75 e0             	pushl  -0x20(%ebp)
801051bd:	e8 be ce ff ff       	call   80102080 <namei>
801051c2:	83 c4 10             	add    $0x10,%esp
801051c5:	85 c0                	test   %eax,%eax
801051c7:	89 c6                	mov    %eax,%esi
801051c9:	0f 84 8e 00 00 00    	je     8010525d <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
801051cf:	83 ec 0c             	sub    $0xc,%esp
801051d2:	50                   	push   %eax
801051d3:	e8 58 c6 ff ff       	call   80101830 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801051d8:	83 c4 10             	add    $0x10,%esp
801051db:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801051e0:	0f 84 d2 00 00 00    	je     801052b8 <sys_open+0x148>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801051e6:	e8 45 bd ff ff       	call   80100f30 <filealloc>
801051eb:	85 c0                	test   %eax,%eax
801051ed:	89 c7                	mov    %eax,%edi
801051ef:	74 2b                	je     8010521c <sys_open+0xac>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801051f1:	31 db                	xor    %ebx,%ebx
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801051f3:	e8 48 e7 ff ff       	call   80103940 <myproc>
801051f8:	90                   	nop
801051f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80105200:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105204:	85 d2                	test   %edx,%edx
80105206:	74 68                	je     80105270 <sys_open+0x100>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105208:	83 c3 01             	add    $0x1,%ebx
8010520b:	83 fb 10             	cmp    $0x10,%ebx
8010520e:	75 f0                	jne    80105200 <sys_open+0x90>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
80105210:	83 ec 0c             	sub    $0xc,%esp
80105213:	57                   	push   %edi
80105214:	e8 d7 bd ff ff       	call   80100ff0 <fileclose>
80105219:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010521c:	83 ec 0c             	sub    $0xc,%esp
8010521f:	56                   	push   %esi
80105220:	e8 9b c8 ff ff       	call   80101ac0 <iunlockput>
    end_op();
80105225:	e8 56 db ff ff       	call   80102d80 <end_op>
    return -1;
8010522a:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
8010522d:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
80105230:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80105235:	5b                   	pop    %ebx
80105236:	5e                   	pop    %esi
80105237:	5f                   	pop    %edi
80105238:	5d                   	pop    %ebp
80105239:	c3                   	ret    
8010523a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105240:	83 ec 0c             	sub    $0xc,%esp
80105243:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105246:	31 c9                	xor    %ecx,%ecx
80105248:	6a 00                	push   $0x0
8010524a:	ba 02 00 00 00       	mov    $0x2,%edx
8010524f:	e8 dc f7 ff ff       	call   80104a30 <create>
    if(ip == 0){
80105254:	83 c4 10             	add    $0x10,%esp
80105257:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105259:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010525b:	75 89                	jne    801051e6 <sys_open+0x76>
      end_op();
8010525d:	e8 1e db ff ff       	call   80102d80 <end_op>
      return -1;
80105262:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105267:	eb 43                	jmp    801052ac <sys_open+0x13c>
80105269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105270:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105273:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105277:	56                   	push   %esi
80105278:	e8 93 c6 ff ff       	call   80101910 <iunlock>
  end_op();
8010527d:	e8 fe da ff ff       	call   80102d80 <end_op>

  f->type = FD_INODE;
80105282:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105288:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010528b:	83 c4 10             	add    $0x10,%esp
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
8010528e:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105291:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105298:	89 d0                	mov    %edx,%eax
8010529a:	83 e0 01             	and    $0x1,%eax
8010529d:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052a0:	83 e2 03             	and    $0x3,%edx
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801052a3:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052a6:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
801052aa:	89 d8                	mov    %ebx,%eax
}
801052ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052af:	5b                   	pop    %ebx
801052b0:	5e                   	pop    %esi
801052b1:	5f                   	pop    %edi
801052b2:	5d                   	pop    %ebp
801052b3:	c3                   	ret    
801052b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
801052b8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801052bb:	85 c9                	test   %ecx,%ecx
801052bd:	0f 84 23 ff ff ff    	je     801051e6 <sys_open+0x76>
801052c3:	e9 54 ff ff ff       	jmp    8010521c <sys_open+0xac>
801052c8:	90                   	nop
801052c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801052d0 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
801052d0:	55                   	push   %ebp
801052d1:	89 e5                	mov    %esp,%ebp
801052d3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801052d6:	e8 35 da ff ff       	call   80102d10 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801052db:	8d 45 f4             	lea    -0xc(%ebp),%eax
801052de:	83 ec 08             	sub    $0x8,%esp
801052e1:	50                   	push   %eax
801052e2:	6a 00                	push   $0x0
801052e4:	e8 a7 f6 ff ff       	call   80104990 <argstr>
801052e9:	83 c4 10             	add    $0x10,%esp
801052ec:	85 c0                	test   %eax,%eax
801052ee:	78 30                	js     80105320 <sys_mkdir+0x50>
801052f0:	83 ec 0c             	sub    $0xc,%esp
801052f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801052f6:	31 c9                	xor    %ecx,%ecx
801052f8:	6a 00                	push   $0x0
801052fa:	ba 01 00 00 00       	mov    $0x1,%edx
801052ff:	e8 2c f7 ff ff       	call   80104a30 <create>
80105304:	83 c4 10             	add    $0x10,%esp
80105307:	85 c0                	test   %eax,%eax
80105309:	74 15                	je     80105320 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010530b:	83 ec 0c             	sub    $0xc,%esp
8010530e:	50                   	push   %eax
8010530f:	e8 ac c7 ff ff       	call   80101ac0 <iunlockput>
  end_op();
80105314:	e8 67 da ff ff       	call   80102d80 <end_op>
  return 0;
80105319:	83 c4 10             	add    $0x10,%esp
8010531c:	31 c0                	xor    %eax,%eax
}
8010531e:	c9                   	leave  
8010531f:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
80105320:	e8 5b da ff ff       	call   80102d80 <end_op>
    return -1;
80105325:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010532a:	c9                   	leave  
8010532b:	c3                   	ret    
8010532c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105330 <sys_mknod>:

int
sys_mknod(void)
{
80105330:	55                   	push   %ebp
80105331:	89 e5                	mov    %esp,%ebp
80105333:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105336:	e8 d5 d9 ff ff       	call   80102d10 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010533b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010533e:	83 ec 08             	sub    $0x8,%esp
80105341:	50                   	push   %eax
80105342:	6a 00                	push   $0x0
80105344:	e8 47 f6 ff ff       	call   80104990 <argstr>
80105349:	83 c4 10             	add    $0x10,%esp
8010534c:	85 c0                	test   %eax,%eax
8010534e:	78 60                	js     801053b0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105350:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105353:	83 ec 08             	sub    $0x8,%esp
80105356:	50                   	push   %eax
80105357:	6a 01                	push   $0x1
80105359:	e8 82 f5 ff ff       	call   801048e0 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
8010535e:	83 c4 10             	add    $0x10,%esp
80105361:	85 c0                	test   %eax,%eax
80105363:	78 4b                	js     801053b0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105365:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105368:	83 ec 08             	sub    $0x8,%esp
8010536b:	50                   	push   %eax
8010536c:	6a 02                	push   $0x2
8010536e:	e8 6d f5 ff ff       	call   801048e0 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80105373:	83 c4 10             	add    $0x10,%esp
80105376:	85 c0                	test   %eax,%eax
80105378:	78 36                	js     801053b0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
8010537a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010537e:	83 ec 0c             	sub    $0xc,%esp
80105381:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105385:	ba 03 00 00 00       	mov    $0x3,%edx
8010538a:	50                   	push   %eax
8010538b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010538e:	e8 9d f6 ff ff       	call   80104a30 <create>
80105393:	83 c4 10             	add    $0x10,%esp
80105396:	85 c0                	test   %eax,%eax
80105398:	74 16                	je     801053b0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
8010539a:	83 ec 0c             	sub    $0xc,%esp
8010539d:	50                   	push   %eax
8010539e:	e8 1d c7 ff ff       	call   80101ac0 <iunlockput>
  end_op();
801053a3:	e8 d8 d9 ff ff       	call   80102d80 <end_op>
  return 0;
801053a8:	83 c4 10             	add    $0x10,%esp
801053ab:	31 c0                	xor    %eax,%eax
}
801053ad:	c9                   	leave  
801053ae:	c3                   	ret    
801053af:	90                   	nop
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
801053b0:	e8 cb d9 ff ff       	call   80102d80 <end_op>
    return -1;
801053b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
801053ba:	c9                   	leave  
801053bb:	c3                   	ret    
801053bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801053c0 <sys_chdir>:

int
sys_chdir(void)
{
801053c0:	55                   	push   %ebp
801053c1:	89 e5                	mov    %esp,%ebp
801053c3:	56                   	push   %esi
801053c4:	53                   	push   %ebx
801053c5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801053c8:	e8 73 e5 ff ff       	call   80103940 <myproc>
801053cd:	89 c6                	mov    %eax,%esi
  
  begin_op();
801053cf:	e8 3c d9 ff ff       	call   80102d10 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801053d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053d7:	83 ec 08             	sub    $0x8,%esp
801053da:	50                   	push   %eax
801053db:	6a 00                	push   $0x0
801053dd:	e8 ae f5 ff ff       	call   80104990 <argstr>
801053e2:	83 c4 10             	add    $0x10,%esp
801053e5:	85 c0                	test   %eax,%eax
801053e7:	78 77                	js     80105460 <sys_chdir+0xa0>
801053e9:	83 ec 0c             	sub    $0xc,%esp
801053ec:	ff 75 f4             	pushl  -0xc(%ebp)
801053ef:	e8 8c cc ff ff       	call   80102080 <namei>
801053f4:	83 c4 10             	add    $0x10,%esp
801053f7:	85 c0                	test   %eax,%eax
801053f9:	89 c3                	mov    %eax,%ebx
801053fb:	74 63                	je     80105460 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801053fd:	83 ec 0c             	sub    $0xc,%esp
80105400:	50                   	push   %eax
80105401:	e8 2a c4 ff ff       	call   80101830 <ilock>
  if(ip->type != T_DIR){
80105406:	83 c4 10             	add    $0x10,%esp
80105409:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010540e:	75 30                	jne    80105440 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105410:	83 ec 0c             	sub    $0xc,%esp
80105413:	53                   	push   %ebx
80105414:	e8 f7 c4 ff ff       	call   80101910 <iunlock>
  iput(curproc->cwd);
80105419:	58                   	pop    %eax
8010541a:	ff 76 68             	pushl  0x68(%esi)
8010541d:	e8 3e c5 ff ff       	call   80101960 <iput>
  end_op();
80105422:	e8 59 d9 ff ff       	call   80102d80 <end_op>
  curproc->cwd = ip;
80105427:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010542a:	83 c4 10             	add    $0x10,%esp
8010542d:	31 c0                	xor    %eax,%eax
}
8010542f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105432:	5b                   	pop    %ebx
80105433:	5e                   	pop    %esi
80105434:	5d                   	pop    %ebp
80105435:	c3                   	ret    
80105436:	8d 76 00             	lea    0x0(%esi),%esi
80105439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
80105440:	83 ec 0c             	sub    $0xc,%esp
80105443:	53                   	push   %ebx
80105444:	e8 77 c6 ff ff       	call   80101ac0 <iunlockput>
    end_op();
80105449:	e8 32 d9 ff ff       	call   80102d80 <end_op>
    return -1;
8010544e:	83 c4 10             	add    $0x10,%esp
80105451:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105456:	eb d7                	jmp    8010542f <sys_chdir+0x6f>
80105458:	90                   	nop
80105459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct inode *ip;
  struct proc *curproc = myproc();
  
  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
80105460:	e8 1b d9 ff ff       	call   80102d80 <end_op>
    return -1;
80105465:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010546a:	eb c3                	jmp    8010542f <sys_chdir+0x6f>
8010546c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105470 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
80105470:	55                   	push   %ebp
80105471:	89 e5                	mov    %esp,%ebp
80105473:	57                   	push   %edi
80105474:	56                   	push   %esi
80105475:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105476:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
8010547c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105482:	50                   	push   %eax
80105483:	6a 00                	push   $0x0
80105485:	e8 06 f5 ff ff       	call   80104990 <argstr>
8010548a:	83 c4 10             	add    $0x10,%esp
8010548d:	85 c0                	test   %eax,%eax
8010548f:	78 7f                	js     80105510 <sys_exec+0xa0>
80105491:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105497:	83 ec 08             	sub    $0x8,%esp
8010549a:	50                   	push   %eax
8010549b:	6a 01                	push   $0x1
8010549d:	e8 3e f4 ff ff       	call   801048e0 <argint>
801054a2:	83 c4 10             	add    $0x10,%esp
801054a5:	85 c0                	test   %eax,%eax
801054a7:	78 67                	js     80105510 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801054a9:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801054af:	83 ec 04             	sub    $0x4,%esp
801054b2:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
801054b8:	68 80 00 00 00       	push   $0x80
801054bd:	6a 00                	push   $0x0
801054bf:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801054c5:	50                   	push   %eax
801054c6:	31 db                	xor    %ebx,%ebx
801054c8:	e8 03 f1 ff ff       	call   801045d0 <memset>
801054cd:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801054d0:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801054d6:	83 ec 08             	sub    $0x8,%esp
801054d9:	57                   	push   %edi
801054da:	8d 04 98             	lea    (%eax,%ebx,4),%eax
801054dd:	50                   	push   %eax
801054de:	e8 5d f3 ff ff       	call   80104840 <fetchint>
801054e3:	83 c4 10             	add    $0x10,%esp
801054e6:	85 c0                	test   %eax,%eax
801054e8:	78 26                	js     80105510 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
801054ea:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801054f0:	85 c0                	test   %eax,%eax
801054f2:	74 2c                	je     80105520 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801054f4:	83 ec 08             	sub    $0x8,%esp
801054f7:	56                   	push   %esi
801054f8:	50                   	push   %eax
801054f9:	e8 82 f3 ff ff       	call   80104880 <fetchstr>
801054fe:	83 c4 10             	add    $0x10,%esp
80105501:	85 c0                	test   %eax,%eax
80105503:	78 0b                	js     80105510 <sys_exec+0xa0>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80105505:	83 c3 01             	add    $0x1,%ebx
80105508:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
8010550b:	83 fb 20             	cmp    $0x20,%ebx
8010550e:	75 c0                	jne    801054d0 <sys_exec+0x60>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105510:	8d 65 f4             	lea    -0xc(%ebp),%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
80105513:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105518:	5b                   	pop    %ebx
80105519:	5e                   	pop    %esi
8010551a:	5f                   	pop    %edi
8010551b:	5d                   	pop    %ebp
8010551c:	c3                   	ret    
8010551d:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105520:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105526:	83 ec 08             	sub    $0x8,%esp
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
80105529:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105530:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105534:	50                   	push   %eax
80105535:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010553b:	e8 70 b6 ff ff       	call   80100bb0 <exec>
80105540:	83 c4 10             	add    $0x10,%esp
}
80105543:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105546:	5b                   	pop    %ebx
80105547:	5e                   	pop    %esi
80105548:	5f                   	pop    %edi
80105549:	5d                   	pop    %ebp
8010554a:	c3                   	ret    
8010554b:	90                   	nop
8010554c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105550 <sys_pipe>:

int
sys_pipe(void)
{
80105550:	55                   	push   %ebp
80105551:	89 e5                	mov    %esp,%ebp
80105553:	57                   	push   %edi
80105554:	56                   	push   %esi
80105555:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105556:	8d 45 dc             	lea    -0x24(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
80105559:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010555c:	6a 08                	push   $0x8
8010555e:	50                   	push   %eax
8010555f:	6a 00                	push   $0x0
80105561:	e8 ca f3 ff ff       	call   80104930 <argptr>
80105566:	83 c4 10             	add    $0x10,%esp
80105569:	85 c0                	test   %eax,%eax
8010556b:	78 4a                	js     801055b7 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010556d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105570:	83 ec 08             	sub    $0x8,%esp
80105573:	50                   	push   %eax
80105574:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105577:	50                   	push   %eax
80105578:	e8 33 de ff ff       	call   801033b0 <pipealloc>
8010557d:	83 c4 10             	add    $0x10,%esp
80105580:	85 c0                	test   %eax,%eax
80105582:	78 33                	js     801055b7 <sys_pipe+0x67>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105584:	31 db                	xor    %ebx,%ebx
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105586:	8b 7d e0             	mov    -0x20(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105589:	e8 b2 e3 ff ff       	call   80103940 <myproc>
8010558e:	66 90                	xchg   %ax,%ax

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80105590:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105594:	85 f6                	test   %esi,%esi
80105596:	74 30                	je     801055c8 <sys_pipe+0x78>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105598:	83 c3 01             	add    $0x1,%ebx
8010559b:	83 fb 10             	cmp    $0x10,%ebx
8010559e:	75 f0                	jne    80105590 <sys_pipe+0x40>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
801055a0:	83 ec 0c             	sub    $0xc,%esp
801055a3:	ff 75 e0             	pushl  -0x20(%ebp)
801055a6:	e8 45 ba ff ff       	call   80100ff0 <fileclose>
    fileclose(wf);
801055ab:	58                   	pop    %eax
801055ac:	ff 75 e4             	pushl  -0x1c(%ebp)
801055af:	e8 3c ba ff ff       	call   80100ff0 <fileclose>
    return -1;
801055b4:	83 c4 10             	add    $0x10,%esp
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
801055b7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
801055ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
801055bf:	5b                   	pop    %ebx
801055c0:	5e                   	pop    %esi
801055c1:	5f                   	pop    %edi
801055c2:	5d                   	pop    %ebp
801055c3:	c3                   	ret    
801055c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
801055c8:	8d 73 08             	lea    0x8(%ebx),%esi
801055cb:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801055cf:	8b 7d e4             	mov    -0x1c(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801055d2:	e8 69 e3 ff ff       	call   80103940 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
801055d7:	31 d2                	xor    %edx,%edx
801055d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801055e0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801055e4:	85 c9                	test   %ecx,%ecx
801055e6:	74 18                	je     80105600 <sys_pipe+0xb0>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801055e8:	83 c2 01             	add    $0x1,%edx
801055eb:	83 fa 10             	cmp    $0x10,%edx
801055ee:	75 f0                	jne    801055e0 <sys_pipe+0x90>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
801055f0:	e8 4b e3 ff ff       	call   80103940 <myproc>
801055f5:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801055fc:	00 
801055fd:	eb a1                	jmp    801055a0 <sys_pipe+0x50>
801055ff:	90                   	nop
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105600:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105604:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105607:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105609:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010560c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
}
8010560f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
80105612:	31 c0                	xor    %eax,%eax
}
80105614:	5b                   	pop    %ebx
80105615:	5e                   	pop    %esi
80105616:	5f                   	pop    %edi
80105617:	5d                   	pop    %ebp
80105618:	c3                   	ret    
80105619:	66 90                	xchg   %ax,%ax
8010561b:	66 90                	xchg   %ax,%ax
8010561d:	66 90                	xchg   %ax,%ax
8010561f:	90                   	nop

80105620 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105620:	55                   	push   %ebp
80105621:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105623:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105624:	e9 b7 e4 ff ff       	jmp    80103ae0 <fork>
80105629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105630 <sys_exit>:
}

int
sys_exit(void)
{
80105630:	55                   	push   %ebp
80105631:	89 e5                	mov    %esp,%ebp
80105633:	83 ec 08             	sub    $0x8,%esp
  exit();
80105636:	e8 35 e7 ff ff       	call   80103d70 <exit>
  return 0;  // not reached
}
8010563b:	31 c0                	xor    %eax,%eax
8010563d:	c9                   	leave  
8010563e:	c3                   	ret    
8010563f:	90                   	nop

80105640 <sys_wait>:

int
sys_wait(void)
{
80105640:	55                   	push   %ebp
80105641:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105643:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
80105644:	e9 67 e9 ff ff       	jmp    80103fb0 <wait>
80105649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105650 <sys_kill>:
}

int
sys_kill(void)
{
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
80105653:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105656:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105659:	50                   	push   %eax
8010565a:	6a 00                	push   $0x0
8010565c:	e8 7f f2 ff ff       	call   801048e0 <argint>
80105661:	83 c4 10             	add    $0x10,%esp
80105664:	85 c0                	test   %eax,%eax
80105666:	78 18                	js     80105680 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105668:	83 ec 0c             	sub    $0xc,%esp
8010566b:	ff 75 f4             	pushl  -0xc(%ebp)
8010566e:	e8 8d ea ff ff       	call   80104100 <kill>
80105673:	83 c4 10             	add    $0x10,%esp
}
80105676:	c9                   	leave  
80105677:	c3                   	ret    
80105678:	90                   	nop
80105679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
80105680:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
80105685:	c9                   	leave  
80105686:	c3                   	ret    
80105687:	89 f6                	mov    %esi,%esi
80105689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105690 <sys_getpid>:

int
sys_getpid(void)
{
80105690:	55                   	push   %ebp
80105691:	89 e5                	mov    %esp,%ebp
80105693:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105696:	e8 a5 e2 ff ff       	call   80103940 <myproc>
8010569b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010569e:	c9                   	leave  
8010569f:	c3                   	ret    

801056a0 <sys_sbrk>:

int
sys_sbrk(void)
{
801056a0:	55                   	push   %ebp
801056a1:	89 e5                	mov    %esp,%ebp
801056a3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801056a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return myproc()->pid;
}

int
sys_sbrk(void)
{
801056a7:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801056aa:	50                   	push   %eax
801056ab:	6a 00                	push   $0x0
801056ad:	e8 2e f2 ff ff       	call   801048e0 <argint>
801056b2:	83 c4 10             	add    $0x10,%esp
801056b5:	85 c0                	test   %eax,%eax
801056b7:	78 27                	js     801056e0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801056b9:	e8 82 e2 ff ff       	call   80103940 <myproc>
  if(growproc(n) < 0)
801056be:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
801056c1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801056c3:	ff 75 f4             	pushl  -0xc(%ebp)
801056c6:	e8 95 e3 ff ff       	call   80103a60 <growproc>
801056cb:	83 c4 10             	add    $0x10,%esp
801056ce:	85 c0                	test   %eax,%eax
801056d0:	78 0e                	js     801056e0 <sys_sbrk+0x40>
    return -1;
  return addr;
801056d2:	89 d8                	mov    %ebx,%eax
}
801056d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801056d7:	c9                   	leave  
801056d8:	c3                   	ret    
801056d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
801056e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056e5:	eb ed                	jmp    801056d4 <sys_sbrk+0x34>
801056e7:	89 f6                	mov    %esi,%esi
801056e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801056f0 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
801056f0:	55                   	push   %ebp
801056f1:	89 e5                	mov    %esp,%ebp
801056f3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801056f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return addr;
}

int
sys_sleep(void)
{
801056f7:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801056fa:	50                   	push   %eax
801056fb:	6a 00                	push   $0x0
801056fd:	e8 de f1 ff ff       	call   801048e0 <argint>
80105702:	83 c4 10             	add    $0x10,%esp
80105705:	85 c0                	test   %eax,%eax
80105707:	0f 88 8a 00 00 00    	js     80105797 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010570d:	83 ec 0c             	sub    $0xc,%esp
80105710:	68 00 5c 11 80       	push   $0x80115c00
80105715:	e8 46 ed ff ff       	call   80104460 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010571a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010571d:	83 c4 10             	add    $0x10,%esp
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
80105720:	8b 1d 40 64 11 80    	mov    0x80116440,%ebx
  while(ticks - ticks0 < n){
80105726:	85 d2                	test   %edx,%edx
80105728:	75 27                	jne    80105751 <sys_sleep+0x61>
8010572a:	eb 54                	jmp    80105780 <sys_sleep+0x90>
8010572c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105730:	83 ec 08             	sub    $0x8,%esp
80105733:	68 00 5c 11 80       	push   $0x80115c00
80105738:	68 40 64 11 80       	push   $0x80116440
8010573d:	e8 ae e7 ff ff       	call   80103ef0 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105742:	a1 40 64 11 80       	mov    0x80116440,%eax
80105747:	83 c4 10             	add    $0x10,%esp
8010574a:	29 d8                	sub    %ebx,%eax
8010574c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010574f:	73 2f                	jae    80105780 <sys_sleep+0x90>
    if(myproc()->killed){
80105751:	e8 ea e1 ff ff       	call   80103940 <myproc>
80105756:	8b 40 24             	mov    0x24(%eax),%eax
80105759:	85 c0                	test   %eax,%eax
8010575b:	74 d3                	je     80105730 <sys_sleep+0x40>
      release(&tickslock);
8010575d:	83 ec 0c             	sub    $0xc,%esp
80105760:	68 00 5c 11 80       	push   $0x80115c00
80105765:	e8 16 ee ff ff       	call   80104580 <release>
      return -1;
8010576a:	83 c4 10             	add    $0x10,%esp
8010576d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
80105772:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105775:	c9                   	leave  
80105776:	c3                   	ret    
80105777:	89 f6                	mov    %esi,%esi
80105779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80105780:	83 ec 0c             	sub    $0xc,%esp
80105783:	68 00 5c 11 80       	push   $0x80115c00
80105788:	e8 f3 ed ff ff       	call   80104580 <release>
  return 0;
8010578d:	83 c4 10             	add    $0x10,%esp
80105790:	31 c0                	xor    %eax,%eax
}
80105792:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105795:	c9                   	leave  
80105796:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
80105797:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010579c:	eb d4                	jmp    80105772 <sys_sleep+0x82>
8010579e:	66 90                	xchg   %ax,%ax

801057a0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801057a0:	55                   	push   %ebp
801057a1:	89 e5                	mov    %esp,%ebp
801057a3:	53                   	push   %ebx
801057a4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801057a7:	68 00 5c 11 80       	push   $0x80115c00
801057ac:	e8 af ec ff ff       	call   80104460 <acquire>
  xticks = ticks;
801057b1:	8b 1d 40 64 11 80    	mov    0x80116440,%ebx
  release(&tickslock);
801057b7:	c7 04 24 00 5c 11 80 	movl   $0x80115c00,(%esp)
801057be:	e8 bd ed ff ff       	call   80104580 <release>
  return xticks;
}
801057c3:	89 d8                	mov    %ebx,%eax
801057c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057c8:	c9                   	leave  
801057c9:	c3                   	ret    
801057ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801057d0 <sys_captsc>:

int
sys_captsc(void)
{
801057d0:	55                   	push   %ebp
801057d1:	89 e5                	mov    %esp,%ebp
801057d3:	53                   	push   %ebx
  void* func;
  if (argptr(0, (void*)&func, sizeof(func)) < 0)
801057d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return xticks;
}

int
sys_captsc(void)
{
801057d7:	83 ec 18             	sub    $0x18,%esp
  void* func;
  if (argptr(0, (void*)&func, sizeof(func)) < 0)
801057da:	6a 04                	push   $0x4
801057dc:	50                   	push   %eax
801057dd:	6a 00                	push   $0x0
801057df:	e8 4c f1 ff ff       	call   80104930 <argptr>
801057e4:	83 c4 10             	add    $0x10,%esp
801057e7:	85 c0                	test   %eax,%eax
801057e9:	78 25                	js     80105810 <sys_captsc+0x40>
    return -1;
  return capturescreen(myproc()->pid, func);
801057eb:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801057ee:	e8 4d e1 ff ff       	call   80103940 <myproc>
801057f3:	83 ec 08             	sub    $0x8,%esp
801057f6:	53                   	push   %ebx
801057f7:	ff 70 10             	pushl  0x10(%eax)
801057fa:	e8 51 b0 ff ff       	call   80100850 <capturescreen>
801057ff:	83 c4 10             	add    $0x10,%esp
}
80105802:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105805:	c9                   	leave  
80105806:	c3                   	ret    
80105807:	89 f6                	mov    %esi,%esi
80105809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
int
sys_captsc(void)
{
  void* func;
  if (argptr(0, (void*)&func, sizeof(func)) < 0)
    return -1;
80105810:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105815:	eb eb                	jmp    80105802 <sys_captsc+0x32>
80105817:	89 f6                	mov    %esi,%esi
80105819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105820 <sys_freesc>:
  return capturescreen(myproc()->pid, func);
}

int
sys_freesc(void)
{
80105820:	55                   	push   %ebp
80105821:	89 e5                	mov    %esp,%ebp
80105823:	83 ec 08             	sub    $0x8,%esp
  return freescreen(myproc()->pid);
80105826:	e8 15 e1 ff ff       	call   80103940 <myproc>
8010582b:	83 ec 0c             	sub    $0xc,%esp
8010582e:	ff 70 10             	pushl  0x10(%eax)
80105831:	e8 aa b0 ff ff       	call   801008e0 <freescreen>
}
80105836:	c9                   	leave  
80105837:	c3                   	ret    
80105838:	90                   	nop
80105839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105840 <sys_updatesc>:

int
sys_updatesc(void) {
80105840:	55                   	push   %ebp
80105841:	89 e5                	mov    %esp,%ebp
80105843:	57                   	push   %edi
80105844:	56                   	push   %esi
80105845:	53                   	push   %ebx
  int x, y, color;
  char* content;
  if(argint(0, &x) < 0)
80105846:	8d 45 d8             	lea    -0x28(%ebp),%eax
{
  return freescreen(myproc()->pid);
}

int
sys_updatesc(void) {
80105849:	83 ec 34             	sub    $0x34,%esp
  int x, y, color;
  char* content;
  if(argint(0, &x) < 0)
8010584c:	50                   	push   %eax
8010584d:	6a 00                	push   $0x0
8010584f:	e8 8c f0 ff ff       	call   801048e0 <argint>
80105854:	83 c4 10             	add    $0x10,%esp
80105857:	85 c0                	test   %eax,%eax
80105859:	78 75                	js     801058d0 <sys_updatesc+0x90>
    return -1;
  if(argint(1, &y) < 0)
8010585b:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010585e:	83 ec 08             	sub    $0x8,%esp
80105861:	50                   	push   %eax
80105862:	6a 01                	push   $0x1
80105864:	e8 77 f0 ff ff       	call   801048e0 <argint>
80105869:	83 c4 10             	add    $0x10,%esp
8010586c:	85 c0                	test   %eax,%eax
8010586e:	78 60                	js     801058d0 <sys_updatesc+0x90>
    return -1;
  if (argptr(2, (void*)&content, sizeof(content)) < 0)
80105870:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105873:	83 ec 04             	sub    $0x4,%esp
80105876:	6a 04                	push   $0x4
80105878:	50                   	push   %eax
80105879:	6a 02                	push   $0x2
8010587b:	e8 b0 f0 ff ff       	call   80104930 <argptr>
80105880:	83 c4 10             	add    $0x10,%esp
80105883:	85 c0                	test   %eax,%eax
80105885:	78 49                	js     801058d0 <sys_updatesc+0x90>
    return -1;
  if(argint(3, &color) < 0)
80105887:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010588a:	83 ec 08             	sub    $0x8,%esp
8010588d:	50                   	push   %eax
8010588e:	6a 03                	push   $0x3
80105890:	e8 4b f0 ff ff       	call   801048e0 <argint>
80105895:	83 c4 10             	add    $0x10,%esp
80105898:	85 c0                	test   %eax,%eax
8010589a:	78 34                	js     801058d0 <sys_updatesc+0x90>
    return -1;
  return updatescreen(myproc()->pid, x, y, content, color);
8010589c:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010589f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801058a2:	8b 75 dc             	mov    -0x24(%ebp),%esi
801058a5:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801058a8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801058ab:	e8 90 e0 ff ff       	call   80103940 <myproc>
801058b0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
801058b3:	83 ec 0c             	sub    $0xc,%esp
801058b6:	52                   	push   %edx
801058b7:	57                   	push   %edi
801058b8:	56                   	push   %esi
801058b9:	53                   	push   %ebx
801058ba:	ff 70 10             	pushl  0x10(%eax)
801058bd:	e8 8e b0 ff ff       	call   80100950 <updatescreen>
801058c2:	83 c4 20             	add    $0x20,%esp
}
801058c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801058c8:	5b                   	pop    %ebx
801058c9:	5e                   	pop    %esi
801058ca:	5f                   	pop    %edi
801058cb:	5d                   	pop    %ebp
801058cc:	c3                   	ret    
801058cd:	8d 76 00             	lea    0x0(%esi),%esi
801058d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
int
sys_updatesc(void) {
  int x, y, color;
  char* content;
  if(argint(0, &x) < 0)
    return -1;
801058d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if (argptr(2, (void*)&content, sizeof(content)) < 0)
    return -1;
  if(argint(3, &color) < 0)
    return -1;
  return updatescreen(myproc()->pid, x, y, content, color);
}
801058d8:	5b                   	pop    %ebx
801058d9:	5e                   	pop    %esi
801058da:	5f                   	pop    %edi
801058db:	5d                   	pop    %ebp
801058dc:	c3                   	ret    

801058dd <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801058dd:	1e                   	push   %ds
  pushl %es
801058de:	06                   	push   %es
  pushl %fs
801058df:	0f a0                	push   %fs
  pushl %gs
801058e1:	0f a8                	push   %gs
  pushal
801058e3:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
801058e4:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801058e8:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801058ea:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
801058ec:	54                   	push   %esp
  call trap
801058ed:	e8 de 00 00 00       	call   801059d0 <trap>
  addl $4, %esp
801058f2:	83 c4 04             	add    $0x4,%esp

801058f5 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801058f5:	61                   	popa   
  popl %gs
801058f6:	0f a9                	pop    %gs
  popl %fs
801058f8:	0f a1                	pop    %fs
  popl %es
801058fa:	07                   	pop    %es
  popl %ds
801058fb:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801058fc:	83 c4 08             	add    $0x8,%esp
  iret
801058ff:	cf                   	iret   

80105900 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105900:	31 c0                	xor    %eax,%eax
80105902:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105908:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
8010590f:	b9 08 00 00 00       	mov    $0x8,%ecx
80105914:	c6 04 c5 44 5c 11 80 	movb   $0x0,-0x7feea3bc(,%eax,8)
8010591b:	00 
8010591c:	66 89 0c c5 42 5c 11 	mov    %cx,-0x7feea3be(,%eax,8)
80105923:	80 
80105924:	c6 04 c5 45 5c 11 80 	movb   $0x8e,-0x7feea3bb(,%eax,8)
8010592b:	8e 
8010592c:	66 89 14 c5 40 5c 11 	mov    %dx,-0x7feea3c0(,%eax,8)
80105933:	80 
80105934:	c1 ea 10             	shr    $0x10,%edx
80105937:	66 89 14 c5 46 5c 11 	mov    %dx,-0x7feea3ba(,%eax,8)
8010593e:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
8010593f:	83 c0 01             	add    $0x1,%eax
80105942:	3d 00 01 00 00       	cmp    $0x100,%eax
80105947:	75 bf                	jne    80105908 <tvinit+0x8>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105949:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010594a:	ba 08 00 00 00       	mov    $0x8,%edx
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
8010594f:	89 e5                	mov    %esp,%ebp
80105951:	83 ec 10             	sub    $0x10,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105954:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105959:	68 25 79 10 80       	push   $0x80107925
8010595e:	68 00 5c 11 80       	push   $0x80115c00
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105963:	66 89 15 42 5e 11 80 	mov    %dx,0x80115e42
8010596a:	c6 05 44 5e 11 80 00 	movb   $0x0,0x80115e44
80105971:	66 a3 40 5e 11 80    	mov    %ax,0x80115e40
80105977:	c1 e8 10             	shr    $0x10,%eax
8010597a:	c6 05 45 5e 11 80 ef 	movb   $0xef,0x80115e45
80105981:	66 a3 46 5e 11 80    	mov    %ax,0x80115e46

  initlock(&tickslock, "time");
80105987:	e8 d4 e9 ff ff       	call   80104360 <initlock>
}
8010598c:	83 c4 10             	add    $0x10,%esp
8010598f:	c9                   	leave  
80105990:	c3                   	ret    
80105991:	eb 0d                	jmp    801059a0 <idtinit>
80105993:	90                   	nop
80105994:	90                   	nop
80105995:	90                   	nop
80105996:	90                   	nop
80105997:	90                   	nop
80105998:	90                   	nop
80105999:	90                   	nop
8010599a:	90                   	nop
8010599b:	90                   	nop
8010599c:	90                   	nop
8010599d:	90                   	nop
8010599e:	90                   	nop
8010599f:	90                   	nop

801059a0 <idtinit>:

void
idtinit(void)
{
801059a0:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
801059a1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801059a6:	89 e5                	mov    %esp,%ebp
801059a8:	83 ec 10             	sub    $0x10,%esp
801059ab:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801059af:	b8 40 5c 11 80       	mov    $0x80115c40,%eax
801059b4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801059b8:	c1 e8 10             	shr    $0x10,%eax
801059bb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
801059bf:	8d 45 fa             	lea    -0x6(%ebp),%eax
801059c2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801059c5:	c9                   	leave  
801059c6:	c3                   	ret    
801059c7:	89 f6                	mov    %esi,%esi
801059c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801059d0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801059d0:	55                   	push   %ebp
801059d1:	89 e5                	mov    %esp,%ebp
801059d3:	57                   	push   %edi
801059d4:	56                   	push   %esi
801059d5:	53                   	push   %ebx
801059d6:	83 ec 1c             	sub    $0x1c,%esp
801059d9:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
801059dc:	8b 47 30             	mov    0x30(%edi),%eax
801059df:	83 f8 40             	cmp    $0x40,%eax
801059e2:	0f 84 88 01 00 00    	je     80105b70 <trap+0x1a0>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801059e8:	83 e8 20             	sub    $0x20,%eax
801059eb:	83 f8 1f             	cmp    $0x1f,%eax
801059ee:	77 10                	ja     80105a00 <trap+0x30>
801059f0:	ff 24 85 cc 79 10 80 	jmp    *-0x7fef8634(,%eax,4)
801059f7:	89 f6                	mov    %esi,%esi
801059f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105a00:	e8 3b df ff ff       	call   80103940 <myproc>
80105a05:	85 c0                	test   %eax,%eax
80105a07:	0f 84 d7 01 00 00    	je     80105be4 <trap+0x214>
80105a0d:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105a11:	0f 84 cd 01 00 00    	je     80105be4 <trap+0x214>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105a17:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a1a:	8b 57 38             	mov    0x38(%edi),%edx
80105a1d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105a20:	89 55 dc             	mov    %edx,-0x24(%ebp)
80105a23:	e8 f8 de ff ff       	call   80103920 <cpuid>
80105a28:	8b 77 34             	mov    0x34(%edi),%esi
80105a2b:	8b 5f 30             	mov    0x30(%edi),%ebx
80105a2e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105a31:	e8 0a df ff ff       	call   80103940 <myproc>
80105a36:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105a39:	e8 02 df ff ff       	call   80103940 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a3e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105a41:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105a44:	51                   	push   %ecx
80105a45:	52                   	push   %edx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105a46:	8b 55 e0             	mov    -0x20(%ebp),%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a49:	ff 75 e4             	pushl  -0x1c(%ebp)
80105a4c:	56                   	push   %esi
80105a4d:	53                   	push   %ebx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105a4e:	83 c2 6c             	add    $0x6c,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a51:	52                   	push   %edx
80105a52:	ff 70 10             	pushl  0x10(%eax)
80105a55:	68 88 79 10 80       	push   $0x80107988
80105a5a:	e8 51 ac ff ff       	call   801006b0 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105a5f:	83 c4 20             	add    $0x20,%esp
80105a62:	e8 d9 de ff ff       	call   80103940 <myproc>
80105a67:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80105a6e:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a70:	e8 cb de ff ff       	call   80103940 <myproc>
80105a75:	85 c0                	test   %eax,%eax
80105a77:	74 0c                	je     80105a85 <trap+0xb5>
80105a79:	e8 c2 de ff ff       	call   80103940 <myproc>
80105a7e:	8b 50 24             	mov    0x24(%eax),%edx
80105a81:	85 d2                	test   %edx,%edx
80105a83:	75 4b                	jne    80105ad0 <trap+0x100>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105a85:	e8 b6 de ff ff       	call   80103940 <myproc>
80105a8a:	85 c0                	test   %eax,%eax
80105a8c:	74 0b                	je     80105a99 <trap+0xc9>
80105a8e:	e8 ad de ff ff       	call   80103940 <myproc>
80105a93:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105a97:	74 4f                	je     80105ae8 <trap+0x118>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a99:	e8 a2 de ff ff       	call   80103940 <myproc>
80105a9e:	85 c0                	test   %eax,%eax
80105aa0:	74 1d                	je     80105abf <trap+0xef>
80105aa2:	e8 99 de ff ff       	call   80103940 <myproc>
80105aa7:	8b 40 24             	mov    0x24(%eax),%eax
80105aaa:	85 c0                	test   %eax,%eax
80105aac:	74 11                	je     80105abf <trap+0xef>
80105aae:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105ab2:	83 e0 03             	and    $0x3,%eax
80105ab5:	66 83 f8 03          	cmp    $0x3,%ax
80105ab9:	0f 84 da 00 00 00    	je     80105b99 <trap+0x1c9>
    exit();
}
80105abf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ac2:	5b                   	pop    %ebx
80105ac3:	5e                   	pop    %esi
80105ac4:	5f                   	pop    %edi
80105ac5:	5d                   	pop    %ebp
80105ac6:	c3                   	ret    
80105ac7:	89 f6                	mov    %esi,%esi
80105ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ad0:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105ad4:	83 e0 03             	and    $0x3,%eax
80105ad7:	66 83 f8 03          	cmp    $0x3,%ax
80105adb:	75 a8                	jne    80105a85 <trap+0xb5>
    exit();
80105add:	e8 8e e2 ff ff       	call   80103d70 <exit>
80105ae2:	eb a1                	jmp    80105a85 <trap+0xb5>
80105ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105ae8:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105aec:	75 ab                	jne    80105a99 <trap+0xc9>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
80105aee:	e8 ad e3 ff ff       	call   80103ea0 <yield>
80105af3:	eb a4                	jmp    80105a99 <trap+0xc9>
80105af5:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80105af8:	e8 23 de ff ff       	call   80103920 <cpuid>
80105afd:	85 c0                	test   %eax,%eax
80105aff:	0f 84 ab 00 00 00    	je     80105bb0 <trap+0x1e0>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80105b05:	e8 c6 cd ff ff       	call   801028d0 <lapiceoi>
    break;
80105b0a:	e9 61 ff ff ff       	jmp    80105a70 <trap+0xa0>
80105b0f:	90                   	nop
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80105b10:	e8 7b cc ff ff       	call   80102790 <kbdintr>
    lapiceoi();
80105b15:	e8 b6 cd ff ff       	call   801028d0 <lapiceoi>
    break;
80105b1a:	e9 51 ff ff ff       	jmp    80105a70 <trap+0xa0>
80105b1f:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80105b20:	e8 5b 02 00 00       	call   80105d80 <uartintr>
    lapiceoi();
80105b25:	e8 a6 cd ff ff       	call   801028d0 <lapiceoi>
    break;
80105b2a:	e9 41 ff ff ff       	jmp    80105a70 <trap+0xa0>
80105b2f:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105b30:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105b34:	8b 77 38             	mov    0x38(%edi),%esi
80105b37:	e8 e4 dd ff ff       	call   80103920 <cpuid>
80105b3c:	56                   	push   %esi
80105b3d:	53                   	push   %ebx
80105b3e:	50                   	push   %eax
80105b3f:	68 30 79 10 80       	push   $0x80107930
80105b44:	e8 67 ab ff ff       	call   801006b0 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
80105b49:	e8 82 cd ff ff       	call   801028d0 <lapiceoi>
    break;
80105b4e:	83 c4 10             	add    $0x10,%esp
80105b51:	e9 1a ff ff ff       	jmp    80105a70 <trap+0xa0>
80105b56:	8d 76 00             	lea    0x0(%esi),%esi
80105b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105b60:	e8 ab c6 ff ff       	call   80102210 <ideintr>
80105b65:	eb 9e                	jmp    80105b05 <trap+0x135>
80105b67:	89 f6                	mov    %esi,%esi
80105b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
80105b70:	e8 cb dd ff ff       	call   80103940 <myproc>
80105b75:	8b 58 24             	mov    0x24(%eax),%ebx
80105b78:	85 db                	test   %ebx,%ebx
80105b7a:	75 2c                	jne    80105ba8 <trap+0x1d8>
      exit();
    myproc()->tf = tf;
80105b7c:	e8 bf dd ff ff       	call   80103940 <myproc>
80105b81:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80105b84:	e8 47 ee ff ff       	call   801049d0 <syscall>
    if(myproc()->killed)
80105b89:	e8 b2 dd ff ff       	call   80103940 <myproc>
80105b8e:	8b 48 24             	mov    0x24(%eax),%ecx
80105b91:	85 c9                	test   %ecx,%ecx
80105b93:	0f 84 26 ff ff ff    	je     80105abf <trap+0xef>
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80105b99:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b9c:	5b                   	pop    %ebx
80105b9d:	5e                   	pop    %esi
80105b9e:	5f                   	pop    %edi
80105b9f:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
80105ba0:	e9 cb e1 ff ff       	jmp    80103d70 <exit>
80105ba5:	8d 76 00             	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
80105ba8:	e8 c3 e1 ff ff       	call   80103d70 <exit>
80105bad:	eb cd                	jmp    80105b7c <trap+0x1ac>
80105baf:	90                   	nop
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
80105bb0:	83 ec 0c             	sub    $0xc,%esp
80105bb3:	68 00 5c 11 80       	push   $0x80115c00
80105bb8:	e8 a3 e8 ff ff       	call   80104460 <acquire>
      ticks++;
      wakeup(&ticks);
80105bbd:	c7 04 24 40 64 11 80 	movl   $0x80116440,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
80105bc4:	83 05 40 64 11 80 01 	addl   $0x1,0x80116440
      wakeup(&ticks);
80105bcb:	e8 d0 e4 ff ff       	call   801040a0 <wakeup>
      release(&tickslock);
80105bd0:	c7 04 24 00 5c 11 80 	movl   $0x80115c00,(%esp)
80105bd7:	e8 a4 e9 ff ff       	call   80104580 <release>
80105bdc:	83 c4 10             	add    $0x10,%esp
80105bdf:	e9 21 ff ff ff       	jmp    80105b05 <trap+0x135>
80105be4:	0f 20 d6             	mov    %cr2,%esi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105be7:	8b 5f 38             	mov    0x38(%edi),%ebx
80105bea:	e8 31 dd ff ff       	call   80103920 <cpuid>
80105bef:	83 ec 0c             	sub    $0xc,%esp
80105bf2:	56                   	push   %esi
80105bf3:	53                   	push   %ebx
80105bf4:	50                   	push   %eax
80105bf5:	ff 77 30             	pushl  0x30(%edi)
80105bf8:	68 54 79 10 80       	push   $0x80107954
80105bfd:	e8 ae aa ff ff       	call   801006b0 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
80105c02:	83 c4 14             	add    $0x14,%esp
80105c05:	68 2a 79 10 80       	push   $0x8010792a
80105c0a:	e8 61 a7 ff ff       	call   80100370 <panic>
80105c0f:	90                   	nop

80105c10 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105c10:	a1 5c b5 10 80       	mov    0x8010b55c,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80105c15:	55                   	push   %ebp
80105c16:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105c18:	85 c0                	test   %eax,%eax
80105c1a:	74 1c                	je     80105c38 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105c1c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105c21:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105c22:	a8 01                	test   $0x1,%al
80105c24:	74 12                	je     80105c38 <uartgetc+0x28>
80105c26:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c2b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105c2c:	0f b6 c0             	movzbl %al,%eax
}
80105c2f:	5d                   	pop    %ebp
80105c30:	c3                   	ret    
80105c31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80105c38:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
80105c3d:	5d                   	pop    %ebp
80105c3e:	c3                   	ret    
80105c3f:	90                   	nop

80105c40 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
80105c40:	55                   	push   %ebp
80105c41:	89 e5                	mov    %esp,%ebp
80105c43:	57                   	push   %edi
80105c44:	56                   	push   %esi
80105c45:	53                   	push   %ebx
80105c46:	89 c7                	mov    %eax,%edi
80105c48:	bb 80 00 00 00       	mov    $0x80,%ebx
80105c4d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105c52:	83 ec 0c             	sub    $0xc,%esp
80105c55:	eb 1b                	jmp    80105c72 <uartputc.part.0+0x32>
80105c57:	89 f6                	mov    %esi,%esi
80105c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80105c60:	83 ec 0c             	sub    $0xc,%esp
80105c63:	6a 0a                	push   $0xa
80105c65:	e8 86 cc ff ff       	call   801028f0 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105c6a:	83 c4 10             	add    $0x10,%esp
80105c6d:	83 eb 01             	sub    $0x1,%ebx
80105c70:	74 07                	je     80105c79 <uartputc.part.0+0x39>
80105c72:	89 f2                	mov    %esi,%edx
80105c74:	ec                   	in     (%dx),%al
80105c75:	a8 20                	test   $0x20,%al
80105c77:	74 e7                	je     80105c60 <uartputc.part.0+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105c79:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c7e:	89 f8                	mov    %edi,%eax
80105c80:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80105c81:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c84:	5b                   	pop    %ebx
80105c85:	5e                   	pop    %esi
80105c86:	5f                   	pop    %edi
80105c87:	5d                   	pop    %ebp
80105c88:	c3                   	ret    
80105c89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105c90 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80105c90:	55                   	push   %ebp
80105c91:	31 c9                	xor    %ecx,%ecx
80105c93:	89 c8                	mov    %ecx,%eax
80105c95:	89 e5                	mov    %esp,%ebp
80105c97:	57                   	push   %edi
80105c98:	56                   	push   %esi
80105c99:	53                   	push   %ebx
80105c9a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105c9f:	89 da                	mov    %ebx,%edx
80105ca1:	83 ec 0c             	sub    $0xc,%esp
80105ca4:	ee                   	out    %al,(%dx)
80105ca5:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105caa:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105caf:	89 fa                	mov    %edi,%edx
80105cb1:	ee                   	out    %al,(%dx)
80105cb2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105cb7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105cbc:	ee                   	out    %al,(%dx)
80105cbd:	be f9 03 00 00       	mov    $0x3f9,%esi
80105cc2:	89 c8                	mov    %ecx,%eax
80105cc4:	89 f2                	mov    %esi,%edx
80105cc6:	ee                   	out    %al,(%dx)
80105cc7:	b8 03 00 00 00       	mov    $0x3,%eax
80105ccc:	89 fa                	mov    %edi,%edx
80105cce:	ee                   	out    %al,(%dx)
80105ccf:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105cd4:	89 c8                	mov    %ecx,%eax
80105cd6:	ee                   	out    %al,(%dx)
80105cd7:	b8 01 00 00 00       	mov    $0x1,%eax
80105cdc:	89 f2                	mov    %esi,%edx
80105cde:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105cdf:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105ce4:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80105ce5:	3c ff                	cmp    $0xff,%al
80105ce7:	74 5a                	je     80105d43 <uartinit+0xb3>
    return;
  uart = 1;
80105ce9:	c7 05 5c b5 10 80 01 	movl   $0x1,0x8010b55c
80105cf0:	00 00 00 
80105cf3:	89 da                	mov    %ebx,%edx
80105cf5:	ec                   	in     (%dx),%al
80105cf6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105cfb:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
80105cfc:	83 ec 08             	sub    $0x8,%esp
80105cff:	bb 4c 7a 10 80       	mov    $0x80107a4c,%ebx
80105d04:	6a 00                	push   $0x0
80105d06:	6a 04                	push   $0x4
80105d08:	e8 53 c7 ff ff       	call   80102460 <ioapicenable>
80105d0d:	83 c4 10             	add    $0x10,%esp
80105d10:	b8 78 00 00 00       	mov    $0x78,%eax
80105d15:	eb 13                	jmp    80105d2a <uartinit+0x9a>
80105d17:	89 f6                	mov    %esi,%esi
80105d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105d20:	83 c3 01             	add    $0x1,%ebx
80105d23:	0f be 03             	movsbl (%ebx),%eax
80105d26:	84 c0                	test   %al,%al
80105d28:	74 19                	je     80105d43 <uartinit+0xb3>
void
uartputc(int c)
{
  int i;

  if(!uart)
80105d2a:	8b 15 5c b5 10 80    	mov    0x8010b55c,%edx
80105d30:	85 d2                	test   %edx,%edx
80105d32:	74 ec                	je     80105d20 <uartinit+0x90>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105d34:	83 c3 01             	add    $0x1,%ebx
80105d37:	e8 04 ff ff ff       	call   80105c40 <uartputc.part.0>
80105d3c:	0f be 03             	movsbl (%ebx),%eax
80105d3f:	84 c0                	test   %al,%al
80105d41:	75 e7                	jne    80105d2a <uartinit+0x9a>
    uartputc(*p);
}
80105d43:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d46:	5b                   	pop    %ebx
80105d47:	5e                   	pop    %esi
80105d48:	5f                   	pop    %edi
80105d49:	5d                   	pop    %ebp
80105d4a:	c3                   	ret    
80105d4b:	90                   	nop
80105d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d50 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80105d50:	8b 15 5c b5 10 80    	mov    0x8010b55c,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105d56:	55                   	push   %ebp
80105d57:	89 e5                	mov    %esp,%ebp
  int i;

  if(!uart)
80105d59:	85 d2                	test   %edx,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105d5b:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
80105d5e:	74 10                	je     80105d70 <uartputc+0x20>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80105d60:	5d                   	pop    %ebp
80105d61:	e9 da fe ff ff       	jmp    80105c40 <uartputc.part.0>
80105d66:	8d 76 00             	lea    0x0(%esi),%esi
80105d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105d70:	5d                   	pop    %ebp
80105d71:	c3                   	ret    
80105d72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105d80 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80105d80:	55                   	push   %ebp
80105d81:	89 e5                	mov    %esp,%ebp
80105d83:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105d86:	68 10 5c 10 80       	push   $0x80105c10
80105d8b:	e8 20 ac ff ff       	call   801009b0 <consoleintr>
}
80105d90:	83 c4 10             	add    $0x10,%esp
80105d93:	c9                   	leave  
80105d94:	c3                   	ret    

80105d95 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105d95:	6a 00                	push   $0x0
  pushl $0
80105d97:	6a 00                	push   $0x0
  jmp alltraps
80105d99:	e9 3f fb ff ff       	jmp    801058dd <alltraps>

80105d9e <vector1>:
.globl vector1
vector1:
  pushl $0
80105d9e:	6a 00                	push   $0x0
  pushl $1
80105da0:	6a 01                	push   $0x1
  jmp alltraps
80105da2:	e9 36 fb ff ff       	jmp    801058dd <alltraps>

80105da7 <vector2>:
.globl vector2
vector2:
  pushl $0
80105da7:	6a 00                	push   $0x0
  pushl $2
80105da9:	6a 02                	push   $0x2
  jmp alltraps
80105dab:	e9 2d fb ff ff       	jmp    801058dd <alltraps>

80105db0 <vector3>:
.globl vector3
vector3:
  pushl $0
80105db0:	6a 00                	push   $0x0
  pushl $3
80105db2:	6a 03                	push   $0x3
  jmp alltraps
80105db4:	e9 24 fb ff ff       	jmp    801058dd <alltraps>

80105db9 <vector4>:
.globl vector4
vector4:
  pushl $0
80105db9:	6a 00                	push   $0x0
  pushl $4
80105dbb:	6a 04                	push   $0x4
  jmp alltraps
80105dbd:	e9 1b fb ff ff       	jmp    801058dd <alltraps>

80105dc2 <vector5>:
.globl vector5
vector5:
  pushl $0
80105dc2:	6a 00                	push   $0x0
  pushl $5
80105dc4:	6a 05                	push   $0x5
  jmp alltraps
80105dc6:	e9 12 fb ff ff       	jmp    801058dd <alltraps>

80105dcb <vector6>:
.globl vector6
vector6:
  pushl $0
80105dcb:	6a 00                	push   $0x0
  pushl $6
80105dcd:	6a 06                	push   $0x6
  jmp alltraps
80105dcf:	e9 09 fb ff ff       	jmp    801058dd <alltraps>

80105dd4 <vector7>:
.globl vector7
vector7:
  pushl $0
80105dd4:	6a 00                	push   $0x0
  pushl $7
80105dd6:	6a 07                	push   $0x7
  jmp alltraps
80105dd8:	e9 00 fb ff ff       	jmp    801058dd <alltraps>

80105ddd <vector8>:
.globl vector8
vector8:
  pushl $8
80105ddd:	6a 08                	push   $0x8
  jmp alltraps
80105ddf:	e9 f9 fa ff ff       	jmp    801058dd <alltraps>

80105de4 <vector9>:
.globl vector9
vector9:
  pushl $0
80105de4:	6a 00                	push   $0x0
  pushl $9
80105de6:	6a 09                	push   $0x9
  jmp alltraps
80105de8:	e9 f0 fa ff ff       	jmp    801058dd <alltraps>

80105ded <vector10>:
.globl vector10
vector10:
  pushl $10
80105ded:	6a 0a                	push   $0xa
  jmp alltraps
80105def:	e9 e9 fa ff ff       	jmp    801058dd <alltraps>

80105df4 <vector11>:
.globl vector11
vector11:
  pushl $11
80105df4:	6a 0b                	push   $0xb
  jmp alltraps
80105df6:	e9 e2 fa ff ff       	jmp    801058dd <alltraps>

80105dfb <vector12>:
.globl vector12
vector12:
  pushl $12
80105dfb:	6a 0c                	push   $0xc
  jmp alltraps
80105dfd:	e9 db fa ff ff       	jmp    801058dd <alltraps>

80105e02 <vector13>:
.globl vector13
vector13:
  pushl $13
80105e02:	6a 0d                	push   $0xd
  jmp alltraps
80105e04:	e9 d4 fa ff ff       	jmp    801058dd <alltraps>

80105e09 <vector14>:
.globl vector14
vector14:
  pushl $14
80105e09:	6a 0e                	push   $0xe
  jmp alltraps
80105e0b:	e9 cd fa ff ff       	jmp    801058dd <alltraps>

80105e10 <vector15>:
.globl vector15
vector15:
  pushl $0
80105e10:	6a 00                	push   $0x0
  pushl $15
80105e12:	6a 0f                	push   $0xf
  jmp alltraps
80105e14:	e9 c4 fa ff ff       	jmp    801058dd <alltraps>

80105e19 <vector16>:
.globl vector16
vector16:
  pushl $0
80105e19:	6a 00                	push   $0x0
  pushl $16
80105e1b:	6a 10                	push   $0x10
  jmp alltraps
80105e1d:	e9 bb fa ff ff       	jmp    801058dd <alltraps>

80105e22 <vector17>:
.globl vector17
vector17:
  pushl $17
80105e22:	6a 11                	push   $0x11
  jmp alltraps
80105e24:	e9 b4 fa ff ff       	jmp    801058dd <alltraps>

80105e29 <vector18>:
.globl vector18
vector18:
  pushl $0
80105e29:	6a 00                	push   $0x0
  pushl $18
80105e2b:	6a 12                	push   $0x12
  jmp alltraps
80105e2d:	e9 ab fa ff ff       	jmp    801058dd <alltraps>

80105e32 <vector19>:
.globl vector19
vector19:
  pushl $0
80105e32:	6a 00                	push   $0x0
  pushl $19
80105e34:	6a 13                	push   $0x13
  jmp alltraps
80105e36:	e9 a2 fa ff ff       	jmp    801058dd <alltraps>

80105e3b <vector20>:
.globl vector20
vector20:
  pushl $0
80105e3b:	6a 00                	push   $0x0
  pushl $20
80105e3d:	6a 14                	push   $0x14
  jmp alltraps
80105e3f:	e9 99 fa ff ff       	jmp    801058dd <alltraps>

80105e44 <vector21>:
.globl vector21
vector21:
  pushl $0
80105e44:	6a 00                	push   $0x0
  pushl $21
80105e46:	6a 15                	push   $0x15
  jmp alltraps
80105e48:	e9 90 fa ff ff       	jmp    801058dd <alltraps>

80105e4d <vector22>:
.globl vector22
vector22:
  pushl $0
80105e4d:	6a 00                	push   $0x0
  pushl $22
80105e4f:	6a 16                	push   $0x16
  jmp alltraps
80105e51:	e9 87 fa ff ff       	jmp    801058dd <alltraps>

80105e56 <vector23>:
.globl vector23
vector23:
  pushl $0
80105e56:	6a 00                	push   $0x0
  pushl $23
80105e58:	6a 17                	push   $0x17
  jmp alltraps
80105e5a:	e9 7e fa ff ff       	jmp    801058dd <alltraps>

80105e5f <vector24>:
.globl vector24
vector24:
  pushl $0
80105e5f:	6a 00                	push   $0x0
  pushl $24
80105e61:	6a 18                	push   $0x18
  jmp alltraps
80105e63:	e9 75 fa ff ff       	jmp    801058dd <alltraps>

80105e68 <vector25>:
.globl vector25
vector25:
  pushl $0
80105e68:	6a 00                	push   $0x0
  pushl $25
80105e6a:	6a 19                	push   $0x19
  jmp alltraps
80105e6c:	e9 6c fa ff ff       	jmp    801058dd <alltraps>

80105e71 <vector26>:
.globl vector26
vector26:
  pushl $0
80105e71:	6a 00                	push   $0x0
  pushl $26
80105e73:	6a 1a                	push   $0x1a
  jmp alltraps
80105e75:	e9 63 fa ff ff       	jmp    801058dd <alltraps>

80105e7a <vector27>:
.globl vector27
vector27:
  pushl $0
80105e7a:	6a 00                	push   $0x0
  pushl $27
80105e7c:	6a 1b                	push   $0x1b
  jmp alltraps
80105e7e:	e9 5a fa ff ff       	jmp    801058dd <alltraps>

80105e83 <vector28>:
.globl vector28
vector28:
  pushl $0
80105e83:	6a 00                	push   $0x0
  pushl $28
80105e85:	6a 1c                	push   $0x1c
  jmp alltraps
80105e87:	e9 51 fa ff ff       	jmp    801058dd <alltraps>

80105e8c <vector29>:
.globl vector29
vector29:
  pushl $0
80105e8c:	6a 00                	push   $0x0
  pushl $29
80105e8e:	6a 1d                	push   $0x1d
  jmp alltraps
80105e90:	e9 48 fa ff ff       	jmp    801058dd <alltraps>

80105e95 <vector30>:
.globl vector30
vector30:
  pushl $0
80105e95:	6a 00                	push   $0x0
  pushl $30
80105e97:	6a 1e                	push   $0x1e
  jmp alltraps
80105e99:	e9 3f fa ff ff       	jmp    801058dd <alltraps>

80105e9e <vector31>:
.globl vector31
vector31:
  pushl $0
80105e9e:	6a 00                	push   $0x0
  pushl $31
80105ea0:	6a 1f                	push   $0x1f
  jmp alltraps
80105ea2:	e9 36 fa ff ff       	jmp    801058dd <alltraps>

80105ea7 <vector32>:
.globl vector32
vector32:
  pushl $0
80105ea7:	6a 00                	push   $0x0
  pushl $32
80105ea9:	6a 20                	push   $0x20
  jmp alltraps
80105eab:	e9 2d fa ff ff       	jmp    801058dd <alltraps>

80105eb0 <vector33>:
.globl vector33
vector33:
  pushl $0
80105eb0:	6a 00                	push   $0x0
  pushl $33
80105eb2:	6a 21                	push   $0x21
  jmp alltraps
80105eb4:	e9 24 fa ff ff       	jmp    801058dd <alltraps>

80105eb9 <vector34>:
.globl vector34
vector34:
  pushl $0
80105eb9:	6a 00                	push   $0x0
  pushl $34
80105ebb:	6a 22                	push   $0x22
  jmp alltraps
80105ebd:	e9 1b fa ff ff       	jmp    801058dd <alltraps>

80105ec2 <vector35>:
.globl vector35
vector35:
  pushl $0
80105ec2:	6a 00                	push   $0x0
  pushl $35
80105ec4:	6a 23                	push   $0x23
  jmp alltraps
80105ec6:	e9 12 fa ff ff       	jmp    801058dd <alltraps>

80105ecb <vector36>:
.globl vector36
vector36:
  pushl $0
80105ecb:	6a 00                	push   $0x0
  pushl $36
80105ecd:	6a 24                	push   $0x24
  jmp alltraps
80105ecf:	e9 09 fa ff ff       	jmp    801058dd <alltraps>

80105ed4 <vector37>:
.globl vector37
vector37:
  pushl $0
80105ed4:	6a 00                	push   $0x0
  pushl $37
80105ed6:	6a 25                	push   $0x25
  jmp alltraps
80105ed8:	e9 00 fa ff ff       	jmp    801058dd <alltraps>

80105edd <vector38>:
.globl vector38
vector38:
  pushl $0
80105edd:	6a 00                	push   $0x0
  pushl $38
80105edf:	6a 26                	push   $0x26
  jmp alltraps
80105ee1:	e9 f7 f9 ff ff       	jmp    801058dd <alltraps>

80105ee6 <vector39>:
.globl vector39
vector39:
  pushl $0
80105ee6:	6a 00                	push   $0x0
  pushl $39
80105ee8:	6a 27                	push   $0x27
  jmp alltraps
80105eea:	e9 ee f9 ff ff       	jmp    801058dd <alltraps>

80105eef <vector40>:
.globl vector40
vector40:
  pushl $0
80105eef:	6a 00                	push   $0x0
  pushl $40
80105ef1:	6a 28                	push   $0x28
  jmp alltraps
80105ef3:	e9 e5 f9 ff ff       	jmp    801058dd <alltraps>

80105ef8 <vector41>:
.globl vector41
vector41:
  pushl $0
80105ef8:	6a 00                	push   $0x0
  pushl $41
80105efa:	6a 29                	push   $0x29
  jmp alltraps
80105efc:	e9 dc f9 ff ff       	jmp    801058dd <alltraps>

80105f01 <vector42>:
.globl vector42
vector42:
  pushl $0
80105f01:	6a 00                	push   $0x0
  pushl $42
80105f03:	6a 2a                	push   $0x2a
  jmp alltraps
80105f05:	e9 d3 f9 ff ff       	jmp    801058dd <alltraps>

80105f0a <vector43>:
.globl vector43
vector43:
  pushl $0
80105f0a:	6a 00                	push   $0x0
  pushl $43
80105f0c:	6a 2b                	push   $0x2b
  jmp alltraps
80105f0e:	e9 ca f9 ff ff       	jmp    801058dd <alltraps>

80105f13 <vector44>:
.globl vector44
vector44:
  pushl $0
80105f13:	6a 00                	push   $0x0
  pushl $44
80105f15:	6a 2c                	push   $0x2c
  jmp alltraps
80105f17:	e9 c1 f9 ff ff       	jmp    801058dd <alltraps>

80105f1c <vector45>:
.globl vector45
vector45:
  pushl $0
80105f1c:	6a 00                	push   $0x0
  pushl $45
80105f1e:	6a 2d                	push   $0x2d
  jmp alltraps
80105f20:	e9 b8 f9 ff ff       	jmp    801058dd <alltraps>

80105f25 <vector46>:
.globl vector46
vector46:
  pushl $0
80105f25:	6a 00                	push   $0x0
  pushl $46
80105f27:	6a 2e                	push   $0x2e
  jmp alltraps
80105f29:	e9 af f9 ff ff       	jmp    801058dd <alltraps>

80105f2e <vector47>:
.globl vector47
vector47:
  pushl $0
80105f2e:	6a 00                	push   $0x0
  pushl $47
80105f30:	6a 2f                	push   $0x2f
  jmp alltraps
80105f32:	e9 a6 f9 ff ff       	jmp    801058dd <alltraps>

80105f37 <vector48>:
.globl vector48
vector48:
  pushl $0
80105f37:	6a 00                	push   $0x0
  pushl $48
80105f39:	6a 30                	push   $0x30
  jmp alltraps
80105f3b:	e9 9d f9 ff ff       	jmp    801058dd <alltraps>

80105f40 <vector49>:
.globl vector49
vector49:
  pushl $0
80105f40:	6a 00                	push   $0x0
  pushl $49
80105f42:	6a 31                	push   $0x31
  jmp alltraps
80105f44:	e9 94 f9 ff ff       	jmp    801058dd <alltraps>

80105f49 <vector50>:
.globl vector50
vector50:
  pushl $0
80105f49:	6a 00                	push   $0x0
  pushl $50
80105f4b:	6a 32                	push   $0x32
  jmp alltraps
80105f4d:	e9 8b f9 ff ff       	jmp    801058dd <alltraps>

80105f52 <vector51>:
.globl vector51
vector51:
  pushl $0
80105f52:	6a 00                	push   $0x0
  pushl $51
80105f54:	6a 33                	push   $0x33
  jmp alltraps
80105f56:	e9 82 f9 ff ff       	jmp    801058dd <alltraps>

80105f5b <vector52>:
.globl vector52
vector52:
  pushl $0
80105f5b:	6a 00                	push   $0x0
  pushl $52
80105f5d:	6a 34                	push   $0x34
  jmp alltraps
80105f5f:	e9 79 f9 ff ff       	jmp    801058dd <alltraps>

80105f64 <vector53>:
.globl vector53
vector53:
  pushl $0
80105f64:	6a 00                	push   $0x0
  pushl $53
80105f66:	6a 35                	push   $0x35
  jmp alltraps
80105f68:	e9 70 f9 ff ff       	jmp    801058dd <alltraps>

80105f6d <vector54>:
.globl vector54
vector54:
  pushl $0
80105f6d:	6a 00                	push   $0x0
  pushl $54
80105f6f:	6a 36                	push   $0x36
  jmp alltraps
80105f71:	e9 67 f9 ff ff       	jmp    801058dd <alltraps>

80105f76 <vector55>:
.globl vector55
vector55:
  pushl $0
80105f76:	6a 00                	push   $0x0
  pushl $55
80105f78:	6a 37                	push   $0x37
  jmp alltraps
80105f7a:	e9 5e f9 ff ff       	jmp    801058dd <alltraps>

80105f7f <vector56>:
.globl vector56
vector56:
  pushl $0
80105f7f:	6a 00                	push   $0x0
  pushl $56
80105f81:	6a 38                	push   $0x38
  jmp alltraps
80105f83:	e9 55 f9 ff ff       	jmp    801058dd <alltraps>

80105f88 <vector57>:
.globl vector57
vector57:
  pushl $0
80105f88:	6a 00                	push   $0x0
  pushl $57
80105f8a:	6a 39                	push   $0x39
  jmp alltraps
80105f8c:	e9 4c f9 ff ff       	jmp    801058dd <alltraps>

80105f91 <vector58>:
.globl vector58
vector58:
  pushl $0
80105f91:	6a 00                	push   $0x0
  pushl $58
80105f93:	6a 3a                	push   $0x3a
  jmp alltraps
80105f95:	e9 43 f9 ff ff       	jmp    801058dd <alltraps>

80105f9a <vector59>:
.globl vector59
vector59:
  pushl $0
80105f9a:	6a 00                	push   $0x0
  pushl $59
80105f9c:	6a 3b                	push   $0x3b
  jmp alltraps
80105f9e:	e9 3a f9 ff ff       	jmp    801058dd <alltraps>

80105fa3 <vector60>:
.globl vector60
vector60:
  pushl $0
80105fa3:	6a 00                	push   $0x0
  pushl $60
80105fa5:	6a 3c                	push   $0x3c
  jmp alltraps
80105fa7:	e9 31 f9 ff ff       	jmp    801058dd <alltraps>

80105fac <vector61>:
.globl vector61
vector61:
  pushl $0
80105fac:	6a 00                	push   $0x0
  pushl $61
80105fae:	6a 3d                	push   $0x3d
  jmp alltraps
80105fb0:	e9 28 f9 ff ff       	jmp    801058dd <alltraps>

80105fb5 <vector62>:
.globl vector62
vector62:
  pushl $0
80105fb5:	6a 00                	push   $0x0
  pushl $62
80105fb7:	6a 3e                	push   $0x3e
  jmp alltraps
80105fb9:	e9 1f f9 ff ff       	jmp    801058dd <alltraps>

80105fbe <vector63>:
.globl vector63
vector63:
  pushl $0
80105fbe:	6a 00                	push   $0x0
  pushl $63
80105fc0:	6a 3f                	push   $0x3f
  jmp alltraps
80105fc2:	e9 16 f9 ff ff       	jmp    801058dd <alltraps>

80105fc7 <vector64>:
.globl vector64
vector64:
  pushl $0
80105fc7:	6a 00                	push   $0x0
  pushl $64
80105fc9:	6a 40                	push   $0x40
  jmp alltraps
80105fcb:	e9 0d f9 ff ff       	jmp    801058dd <alltraps>

80105fd0 <vector65>:
.globl vector65
vector65:
  pushl $0
80105fd0:	6a 00                	push   $0x0
  pushl $65
80105fd2:	6a 41                	push   $0x41
  jmp alltraps
80105fd4:	e9 04 f9 ff ff       	jmp    801058dd <alltraps>

80105fd9 <vector66>:
.globl vector66
vector66:
  pushl $0
80105fd9:	6a 00                	push   $0x0
  pushl $66
80105fdb:	6a 42                	push   $0x42
  jmp alltraps
80105fdd:	e9 fb f8 ff ff       	jmp    801058dd <alltraps>

80105fe2 <vector67>:
.globl vector67
vector67:
  pushl $0
80105fe2:	6a 00                	push   $0x0
  pushl $67
80105fe4:	6a 43                	push   $0x43
  jmp alltraps
80105fe6:	e9 f2 f8 ff ff       	jmp    801058dd <alltraps>

80105feb <vector68>:
.globl vector68
vector68:
  pushl $0
80105feb:	6a 00                	push   $0x0
  pushl $68
80105fed:	6a 44                	push   $0x44
  jmp alltraps
80105fef:	e9 e9 f8 ff ff       	jmp    801058dd <alltraps>

80105ff4 <vector69>:
.globl vector69
vector69:
  pushl $0
80105ff4:	6a 00                	push   $0x0
  pushl $69
80105ff6:	6a 45                	push   $0x45
  jmp alltraps
80105ff8:	e9 e0 f8 ff ff       	jmp    801058dd <alltraps>

80105ffd <vector70>:
.globl vector70
vector70:
  pushl $0
80105ffd:	6a 00                	push   $0x0
  pushl $70
80105fff:	6a 46                	push   $0x46
  jmp alltraps
80106001:	e9 d7 f8 ff ff       	jmp    801058dd <alltraps>

80106006 <vector71>:
.globl vector71
vector71:
  pushl $0
80106006:	6a 00                	push   $0x0
  pushl $71
80106008:	6a 47                	push   $0x47
  jmp alltraps
8010600a:	e9 ce f8 ff ff       	jmp    801058dd <alltraps>

8010600f <vector72>:
.globl vector72
vector72:
  pushl $0
8010600f:	6a 00                	push   $0x0
  pushl $72
80106011:	6a 48                	push   $0x48
  jmp alltraps
80106013:	e9 c5 f8 ff ff       	jmp    801058dd <alltraps>

80106018 <vector73>:
.globl vector73
vector73:
  pushl $0
80106018:	6a 00                	push   $0x0
  pushl $73
8010601a:	6a 49                	push   $0x49
  jmp alltraps
8010601c:	e9 bc f8 ff ff       	jmp    801058dd <alltraps>

80106021 <vector74>:
.globl vector74
vector74:
  pushl $0
80106021:	6a 00                	push   $0x0
  pushl $74
80106023:	6a 4a                	push   $0x4a
  jmp alltraps
80106025:	e9 b3 f8 ff ff       	jmp    801058dd <alltraps>

8010602a <vector75>:
.globl vector75
vector75:
  pushl $0
8010602a:	6a 00                	push   $0x0
  pushl $75
8010602c:	6a 4b                	push   $0x4b
  jmp alltraps
8010602e:	e9 aa f8 ff ff       	jmp    801058dd <alltraps>

80106033 <vector76>:
.globl vector76
vector76:
  pushl $0
80106033:	6a 00                	push   $0x0
  pushl $76
80106035:	6a 4c                	push   $0x4c
  jmp alltraps
80106037:	e9 a1 f8 ff ff       	jmp    801058dd <alltraps>

8010603c <vector77>:
.globl vector77
vector77:
  pushl $0
8010603c:	6a 00                	push   $0x0
  pushl $77
8010603e:	6a 4d                	push   $0x4d
  jmp alltraps
80106040:	e9 98 f8 ff ff       	jmp    801058dd <alltraps>

80106045 <vector78>:
.globl vector78
vector78:
  pushl $0
80106045:	6a 00                	push   $0x0
  pushl $78
80106047:	6a 4e                	push   $0x4e
  jmp alltraps
80106049:	e9 8f f8 ff ff       	jmp    801058dd <alltraps>

8010604e <vector79>:
.globl vector79
vector79:
  pushl $0
8010604e:	6a 00                	push   $0x0
  pushl $79
80106050:	6a 4f                	push   $0x4f
  jmp alltraps
80106052:	e9 86 f8 ff ff       	jmp    801058dd <alltraps>

80106057 <vector80>:
.globl vector80
vector80:
  pushl $0
80106057:	6a 00                	push   $0x0
  pushl $80
80106059:	6a 50                	push   $0x50
  jmp alltraps
8010605b:	e9 7d f8 ff ff       	jmp    801058dd <alltraps>

80106060 <vector81>:
.globl vector81
vector81:
  pushl $0
80106060:	6a 00                	push   $0x0
  pushl $81
80106062:	6a 51                	push   $0x51
  jmp alltraps
80106064:	e9 74 f8 ff ff       	jmp    801058dd <alltraps>

80106069 <vector82>:
.globl vector82
vector82:
  pushl $0
80106069:	6a 00                	push   $0x0
  pushl $82
8010606b:	6a 52                	push   $0x52
  jmp alltraps
8010606d:	e9 6b f8 ff ff       	jmp    801058dd <alltraps>

80106072 <vector83>:
.globl vector83
vector83:
  pushl $0
80106072:	6a 00                	push   $0x0
  pushl $83
80106074:	6a 53                	push   $0x53
  jmp alltraps
80106076:	e9 62 f8 ff ff       	jmp    801058dd <alltraps>

8010607b <vector84>:
.globl vector84
vector84:
  pushl $0
8010607b:	6a 00                	push   $0x0
  pushl $84
8010607d:	6a 54                	push   $0x54
  jmp alltraps
8010607f:	e9 59 f8 ff ff       	jmp    801058dd <alltraps>

80106084 <vector85>:
.globl vector85
vector85:
  pushl $0
80106084:	6a 00                	push   $0x0
  pushl $85
80106086:	6a 55                	push   $0x55
  jmp alltraps
80106088:	e9 50 f8 ff ff       	jmp    801058dd <alltraps>

8010608d <vector86>:
.globl vector86
vector86:
  pushl $0
8010608d:	6a 00                	push   $0x0
  pushl $86
8010608f:	6a 56                	push   $0x56
  jmp alltraps
80106091:	e9 47 f8 ff ff       	jmp    801058dd <alltraps>

80106096 <vector87>:
.globl vector87
vector87:
  pushl $0
80106096:	6a 00                	push   $0x0
  pushl $87
80106098:	6a 57                	push   $0x57
  jmp alltraps
8010609a:	e9 3e f8 ff ff       	jmp    801058dd <alltraps>

8010609f <vector88>:
.globl vector88
vector88:
  pushl $0
8010609f:	6a 00                	push   $0x0
  pushl $88
801060a1:	6a 58                	push   $0x58
  jmp alltraps
801060a3:	e9 35 f8 ff ff       	jmp    801058dd <alltraps>

801060a8 <vector89>:
.globl vector89
vector89:
  pushl $0
801060a8:	6a 00                	push   $0x0
  pushl $89
801060aa:	6a 59                	push   $0x59
  jmp alltraps
801060ac:	e9 2c f8 ff ff       	jmp    801058dd <alltraps>

801060b1 <vector90>:
.globl vector90
vector90:
  pushl $0
801060b1:	6a 00                	push   $0x0
  pushl $90
801060b3:	6a 5a                	push   $0x5a
  jmp alltraps
801060b5:	e9 23 f8 ff ff       	jmp    801058dd <alltraps>

801060ba <vector91>:
.globl vector91
vector91:
  pushl $0
801060ba:	6a 00                	push   $0x0
  pushl $91
801060bc:	6a 5b                	push   $0x5b
  jmp alltraps
801060be:	e9 1a f8 ff ff       	jmp    801058dd <alltraps>

801060c3 <vector92>:
.globl vector92
vector92:
  pushl $0
801060c3:	6a 00                	push   $0x0
  pushl $92
801060c5:	6a 5c                	push   $0x5c
  jmp alltraps
801060c7:	e9 11 f8 ff ff       	jmp    801058dd <alltraps>

801060cc <vector93>:
.globl vector93
vector93:
  pushl $0
801060cc:	6a 00                	push   $0x0
  pushl $93
801060ce:	6a 5d                	push   $0x5d
  jmp alltraps
801060d0:	e9 08 f8 ff ff       	jmp    801058dd <alltraps>

801060d5 <vector94>:
.globl vector94
vector94:
  pushl $0
801060d5:	6a 00                	push   $0x0
  pushl $94
801060d7:	6a 5e                	push   $0x5e
  jmp alltraps
801060d9:	e9 ff f7 ff ff       	jmp    801058dd <alltraps>

801060de <vector95>:
.globl vector95
vector95:
  pushl $0
801060de:	6a 00                	push   $0x0
  pushl $95
801060e0:	6a 5f                	push   $0x5f
  jmp alltraps
801060e2:	e9 f6 f7 ff ff       	jmp    801058dd <alltraps>

801060e7 <vector96>:
.globl vector96
vector96:
  pushl $0
801060e7:	6a 00                	push   $0x0
  pushl $96
801060e9:	6a 60                	push   $0x60
  jmp alltraps
801060eb:	e9 ed f7 ff ff       	jmp    801058dd <alltraps>

801060f0 <vector97>:
.globl vector97
vector97:
  pushl $0
801060f0:	6a 00                	push   $0x0
  pushl $97
801060f2:	6a 61                	push   $0x61
  jmp alltraps
801060f4:	e9 e4 f7 ff ff       	jmp    801058dd <alltraps>

801060f9 <vector98>:
.globl vector98
vector98:
  pushl $0
801060f9:	6a 00                	push   $0x0
  pushl $98
801060fb:	6a 62                	push   $0x62
  jmp alltraps
801060fd:	e9 db f7 ff ff       	jmp    801058dd <alltraps>

80106102 <vector99>:
.globl vector99
vector99:
  pushl $0
80106102:	6a 00                	push   $0x0
  pushl $99
80106104:	6a 63                	push   $0x63
  jmp alltraps
80106106:	e9 d2 f7 ff ff       	jmp    801058dd <alltraps>

8010610b <vector100>:
.globl vector100
vector100:
  pushl $0
8010610b:	6a 00                	push   $0x0
  pushl $100
8010610d:	6a 64                	push   $0x64
  jmp alltraps
8010610f:	e9 c9 f7 ff ff       	jmp    801058dd <alltraps>

80106114 <vector101>:
.globl vector101
vector101:
  pushl $0
80106114:	6a 00                	push   $0x0
  pushl $101
80106116:	6a 65                	push   $0x65
  jmp alltraps
80106118:	e9 c0 f7 ff ff       	jmp    801058dd <alltraps>

8010611d <vector102>:
.globl vector102
vector102:
  pushl $0
8010611d:	6a 00                	push   $0x0
  pushl $102
8010611f:	6a 66                	push   $0x66
  jmp alltraps
80106121:	e9 b7 f7 ff ff       	jmp    801058dd <alltraps>

80106126 <vector103>:
.globl vector103
vector103:
  pushl $0
80106126:	6a 00                	push   $0x0
  pushl $103
80106128:	6a 67                	push   $0x67
  jmp alltraps
8010612a:	e9 ae f7 ff ff       	jmp    801058dd <alltraps>

8010612f <vector104>:
.globl vector104
vector104:
  pushl $0
8010612f:	6a 00                	push   $0x0
  pushl $104
80106131:	6a 68                	push   $0x68
  jmp alltraps
80106133:	e9 a5 f7 ff ff       	jmp    801058dd <alltraps>

80106138 <vector105>:
.globl vector105
vector105:
  pushl $0
80106138:	6a 00                	push   $0x0
  pushl $105
8010613a:	6a 69                	push   $0x69
  jmp alltraps
8010613c:	e9 9c f7 ff ff       	jmp    801058dd <alltraps>

80106141 <vector106>:
.globl vector106
vector106:
  pushl $0
80106141:	6a 00                	push   $0x0
  pushl $106
80106143:	6a 6a                	push   $0x6a
  jmp alltraps
80106145:	e9 93 f7 ff ff       	jmp    801058dd <alltraps>

8010614a <vector107>:
.globl vector107
vector107:
  pushl $0
8010614a:	6a 00                	push   $0x0
  pushl $107
8010614c:	6a 6b                	push   $0x6b
  jmp alltraps
8010614e:	e9 8a f7 ff ff       	jmp    801058dd <alltraps>

80106153 <vector108>:
.globl vector108
vector108:
  pushl $0
80106153:	6a 00                	push   $0x0
  pushl $108
80106155:	6a 6c                	push   $0x6c
  jmp alltraps
80106157:	e9 81 f7 ff ff       	jmp    801058dd <alltraps>

8010615c <vector109>:
.globl vector109
vector109:
  pushl $0
8010615c:	6a 00                	push   $0x0
  pushl $109
8010615e:	6a 6d                	push   $0x6d
  jmp alltraps
80106160:	e9 78 f7 ff ff       	jmp    801058dd <alltraps>

80106165 <vector110>:
.globl vector110
vector110:
  pushl $0
80106165:	6a 00                	push   $0x0
  pushl $110
80106167:	6a 6e                	push   $0x6e
  jmp alltraps
80106169:	e9 6f f7 ff ff       	jmp    801058dd <alltraps>

8010616e <vector111>:
.globl vector111
vector111:
  pushl $0
8010616e:	6a 00                	push   $0x0
  pushl $111
80106170:	6a 6f                	push   $0x6f
  jmp alltraps
80106172:	e9 66 f7 ff ff       	jmp    801058dd <alltraps>

80106177 <vector112>:
.globl vector112
vector112:
  pushl $0
80106177:	6a 00                	push   $0x0
  pushl $112
80106179:	6a 70                	push   $0x70
  jmp alltraps
8010617b:	e9 5d f7 ff ff       	jmp    801058dd <alltraps>

80106180 <vector113>:
.globl vector113
vector113:
  pushl $0
80106180:	6a 00                	push   $0x0
  pushl $113
80106182:	6a 71                	push   $0x71
  jmp alltraps
80106184:	e9 54 f7 ff ff       	jmp    801058dd <alltraps>

80106189 <vector114>:
.globl vector114
vector114:
  pushl $0
80106189:	6a 00                	push   $0x0
  pushl $114
8010618b:	6a 72                	push   $0x72
  jmp alltraps
8010618d:	e9 4b f7 ff ff       	jmp    801058dd <alltraps>

80106192 <vector115>:
.globl vector115
vector115:
  pushl $0
80106192:	6a 00                	push   $0x0
  pushl $115
80106194:	6a 73                	push   $0x73
  jmp alltraps
80106196:	e9 42 f7 ff ff       	jmp    801058dd <alltraps>

8010619b <vector116>:
.globl vector116
vector116:
  pushl $0
8010619b:	6a 00                	push   $0x0
  pushl $116
8010619d:	6a 74                	push   $0x74
  jmp alltraps
8010619f:	e9 39 f7 ff ff       	jmp    801058dd <alltraps>

801061a4 <vector117>:
.globl vector117
vector117:
  pushl $0
801061a4:	6a 00                	push   $0x0
  pushl $117
801061a6:	6a 75                	push   $0x75
  jmp alltraps
801061a8:	e9 30 f7 ff ff       	jmp    801058dd <alltraps>

801061ad <vector118>:
.globl vector118
vector118:
  pushl $0
801061ad:	6a 00                	push   $0x0
  pushl $118
801061af:	6a 76                	push   $0x76
  jmp alltraps
801061b1:	e9 27 f7 ff ff       	jmp    801058dd <alltraps>

801061b6 <vector119>:
.globl vector119
vector119:
  pushl $0
801061b6:	6a 00                	push   $0x0
  pushl $119
801061b8:	6a 77                	push   $0x77
  jmp alltraps
801061ba:	e9 1e f7 ff ff       	jmp    801058dd <alltraps>

801061bf <vector120>:
.globl vector120
vector120:
  pushl $0
801061bf:	6a 00                	push   $0x0
  pushl $120
801061c1:	6a 78                	push   $0x78
  jmp alltraps
801061c3:	e9 15 f7 ff ff       	jmp    801058dd <alltraps>

801061c8 <vector121>:
.globl vector121
vector121:
  pushl $0
801061c8:	6a 00                	push   $0x0
  pushl $121
801061ca:	6a 79                	push   $0x79
  jmp alltraps
801061cc:	e9 0c f7 ff ff       	jmp    801058dd <alltraps>

801061d1 <vector122>:
.globl vector122
vector122:
  pushl $0
801061d1:	6a 00                	push   $0x0
  pushl $122
801061d3:	6a 7a                	push   $0x7a
  jmp alltraps
801061d5:	e9 03 f7 ff ff       	jmp    801058dd <alltraps>

801061da <vector123>:
.globl vector123
vector123:
  pushl $0
801061da:	6a 00                	push   $0x0
  pushl $123
801061dc:	6a 7b                	push   $0x7b
  jmp alltraps
801061de:	e9 fa f6 ff ff       	jmp    801058dd <alltraps>

801061e3 <vector124>:
.globl vector124
vector124:
  pushl $0
801061e3:	6a 00                	push   $0x0
  pushl $124
801061e5:	6a 7c                	push   $0x7c
  jmp alltraps
801061e7:	e9 f1 f6 ff ff       	jmp    801058dd <alltraps>

801061ec <vector125>:
.globl vector125
vector125:
  pushl $0
801061ec:	6a 00                	push   $0x0
  pushl $125
801061ee:	6a 7d                	push   $0x7d
  jmp alltraps
801061f0:	e9 e8 f6 ff ff       	jmp    801058dd <alltraps>

801061f5 <vector126>:
.globl vector126
vector126:
  pushl $0
801061f5:	6a 00                	push   $0x0
  pushl $126
801061f7:	6a 7e                	push   $0x7e
  jmp alltraps
801061f9:	e9 df f6 ff ff       	jmp    801058dd <alltraps>

801061fe <vector127>:
.globl vector127
vector127:
  pushl $0
801061fe:	6a 00                	push   $0x0
  pushl $127
80106200:	6a 7f                	push   $0x7f
  jmp alltraps
80106202:	e9 d6 f6 ff ff       	jmp    801058dd <alltraps>

80106207 <vector128>:
.globl vector128
vector128:
  pushl $0
80106207:	6a 00                	push   $0x0
  pushl $128
80106209:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010620e:	e9 ca f6 ff ff       	jmp    801058dd <alltraps>

80106213 <vector129>:
.globl vector129
vector129:
  pushl $0
80106213:	6a 00                	push   $0x0
  pushl $129
80106215:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010621a:	e9 be f6 ff ff       	jmp    801058dd <alltraps>

8010621f <vector130>:
.globl vector130
vector130:
  pushl $0
8010621f:	6a 00                	push   $0x0
  pushl $130
80106221:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106226:	e9 b2 f6 ff ff       	jmp    801058dd <alltraps>

8010622b <vector131>:
.globl vector131
vector131:
  pushl $0
8010622b:	6a 00                	push   $0x0
  pushl $131
8010622d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106232:	e9 a6 f6 ff ff       	jmp    801058dd <alltraps>

80106237 <vector132>:
.globl vector132
vector132:
  pushl $0
80106237:	6a 00                	push   $0x0
  pushl $132
80106239:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010623e:	e9 9a f6 ff ff       	jmp    801058dd <alltraps>

80106243 <vector133>:
.globl vector133
vector133:
  pushl $0
80106243:	6a 00                	push   $0x0
  pushl $133
80106245:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010624a:	e9 8e f6 ff ff       	jmp    801058dd <alltraps>

8010624f <vector134>:
.globl vector134
vector134:
  pushl $0
8010624f:	6a 00                	push   $0x0
  pushl $134
80106251:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106256:	e9 82 f6 ff ff       	jmp    801058dd <alltraps>

8010625b <vector135>:
.globl vector135
vector135:
  pushl $0
8010625b:	6a 00                	push   $0x0
  pushl $135
8010625d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106262:	e9 76 f6 ff ff       	jmp    801058dd <alltraps>

80106267 <vector136>:
.globl vector136
vector136:
  pushl $0
80106267:	6a 00                	push   $0x0
  pushl $136
80106269:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010626e:	e9 6a f6 ff ff       	jmp    801058dd <alltraps>

80106273 <vector137>:
.globl vector137
vector137:
  pushl $0
80106273:	6a 00                	push   $0x0
  pushl $137
80106275:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010627a:	e9 5e f6 ff ff       	jmp    801058dd <alltraps>

8010627f <vector138>:
.globl vector138
vector138:
  pushl $0
8010627f:	6a 00                	push   $0x0
  pushl $138
80106281:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106286:	e9 52 f6 ff ff       	jmp    801058dd <alltraps>

8010628b <vector139>:
.globl vector139
vector139:
  pushl $0
8010628b:	6a 00                	push   $0x0
  pushl $139
8010628d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106292:	e9 46 f6 ff ff       	jmp    801058dd <alltraps>

80106297 <vector140>:
.globl vector140
vector140:
  pushl $0
80106297:	6a 00                	push   $0x0
  pushl $140
80106299:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010629e:	e9 3a f6 ff ff       	jmp    801058dd <alltraps>

801062a3 <vector141>:
.globl vector141
vector141:
  pushl $0
801062a3:	6a 00                	push   $0x0
  pushl $141
801062a5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801062aa:	e9 2e f6 ff ff       	jmp    801058dd <alltraps>

801062af <vector142>:
.globl vector142
vector142:
  pushl $0
801062af:	6a 00                	push   $0x0
  pushl $142
801062b1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801062b6:	e9 22 f6 ff ff       	jmp    801058dd <alltraps>

801062bb <vector143>:
.globl vector143
vector143:
  pushl $0
801062bb:	6a 00                	push   $0x0
  pushl $143
801062bd:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801062c2:	e9 16 f6 ff ff       	jmp    801058dd <alltraps>

801062c7 <vector144>:
.globl vector144
vector144:
  pushl $0
801062c7:	6a 00                	push   $0x0
  pushl $144
801062c9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801062ce:	e9 0a f6 ff ff       	jmp    801058dd <alltraps>

801062d3 <vector145>:
.globl vector145
vector145:
  pushl $0
801062d3:	6a 00                	push   $0x0
  pushl $145
801062d5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801062da:	e9 fe f5 ff ff       	jmp    801058dd <alltraps>

801062df <vector146>:
.globl vector146
vector146:
  pushl $0
801062df:	6a 00                	push   $0x0
  pushl $146
801062e1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801062e6:	e9 f2 f5 ff ff       	jmp    801058dd <alltraps>

801062eb <vector147>:
.globl vector147
vector147:
  pushl $0
801062eb:	6a 00                	push   $0x0
  pushl $147
801062ed:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801062f2:	e9 e6 f5 ff ff       	jmp    801058dd <alltraps>

801062f7 <vector148>:
.globl vector148
vector148:
  pushl $0
801062f7:	6a 00                	push   $0x0
  pushl $148
801062f9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801062fe:	e9 da f5 ff ff       	jmp    801058dd <alltraps>

80106303 <vector149>:
.globl vector149
vector149:
  pushl $0
80106303:	6a 00                	push   $0x0
  pushl $149
80106305:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010630a:	e9 ce f5 ff ff       	jmp    801058dd <alltraps>

8010630f <vector150>:
.globl vector150
vector150:
  pushl $0
8010630f:	6a 00                	push   $0x0
  pushl $150
80106311:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106316:	e9 c2 f5 ff ff       	jmp    801058dd <alltraps>

8010631b <vector151>:
.globl vector151
vector151:
  pushl $0
8010631b:	6a 00                	push   $0x0
  pushl $151
8010631d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106322:	e9 b6 f5 ff ff       	jmp    801058dd <alltraps>

80106327 <vector152>:
.globl vector152
vector152:
  pushl $0
80106327:	6a 00                	push   $0x0
  pushl $152
80106329:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010632e:	e9 aa f5 ff ff       	jmp    801058dd <alltraps>

80106333 <vector153>:
.globl vector153
vector153:
  pushl $0
80106333:	6a 00                	push   $0x0
  pushl $153
80106335:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010633a:	e9 9e f5 ff ff       	jmp    801058dd <alltraps>

8010633f <vector154>:
.globl vector154
vector154:
  pushl $0
8010633f:	6a 00                	push   $0x0
  pushl $154
80106341:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106346:	e9 92 f5 ff ff       	jmp    801058dd <alltraps>

8010634b <vector155>:
.globl vector155
vector155:
  pushl $0
8010634b:	6a 00                	push   $0x0
  pushl $155
8010634d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106352:	e9 86 f5 ff ff       	jmp    801058dd <alltraps>

80106357 <vector156>:
.globl vector156
vector156:
  pushl $0
80106357:	6a 00                	push   $0x0
  pushl $156
80106359:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010635e:	e9 7a f5 ff ff       	jmp    801058dd <alltraps>

80106363 <vector157>:
.globl vector157
vector157:
  pushl $0
80106363:	6a 00                	push   $0x0
  pushl $157
80106365:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010636a:	e9 6e f5 ff ff       	jmp    801058dd <alltraps>

8010636f <vector158>:
.globl vector158
vector158:
  pushl $0
8010636f:	6a 00                	push   $0x0
  pushl $158
80106371:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106376:	e9 62 f5 ff ff       	jmp    801058dd <alltraps>

8010637b <vector159>:
.globl vector159
vector159:
  pushl $0
8010637b:	6a 00                	push   $0x0
  pushl $159
8010637d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106382:	e9 56 f5 ff ff       	jmp    801058dd <alltraps>

80106387 <vector160>:
.globl vector160
vector160:
  pushl $0
80106387:	6a 00                	push   $0x0
  pushl $160
80106389:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010638e:	e9 4a f5 ff ff       	jmp    801058dd <alltraps>

80106393 <vector161>:
.globl vector161
vector161:
  pushl $0
80106393:	6a 00                	push   $0x0
  pushl $161
80106395:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010639a:	e9 3e f5 ff ff       	jmp    801058dd <alltraps>

8010639f <vector162>:
.globl vector162
vector162:
  pushl $0
8010639f:	6a 00                	push   $0x0
  pushl $162
801063a1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801063a6:	e9 32 f5 ff ff       	jmp    801058dd <alltraps>

801063ab <vector163>:
.globl vector163
vector163:
  pushl $0
801063ab:	6a 00                	push   $0x0
  pushl $163
801063ad:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801063b2:	e9 26 f5 ff ff       	jmp    801058dd <alltraps>

801063b7 <vector164>:
.globl vector164
vector164:
  pushl $0
801063b7:	6a 00                	push   $0x0
  pushl $164
801063b9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801063be:	e9 1a f5 ff ff       	jmp    801058dd <alltraps>

801063c3 <vector165>:
.globl vector165
vector165:
  pushl $0
801063c3:	6a 00                	push   $0x0
  pushl $165
801063c5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801063ca:	e9 0e f5 ff ff       	jmp    801058dd <alltraps>

801063cf <vector166>:
.globl vector166
vector166:
  pushl $0
801063cf:	6a 00                	push   $0x0
  pushl $166
801063d1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801063d6:	e9 02 f5 ff ff       	jmp    801058dd <alltraps>

801063db <vector167>:
.globl vector167
vector167:
  pushl $0
801063db:	6a 00                	push   $0x0
  pushl $167
801063dd:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801063e2:	e9 f6 f4 ff ff       	jmp    801058dd <alltraps>

801063e7 <vector168>:
.globl vector168
vector168:
  pushl $0
801063e7:	6a 00                	push   $0x0
  pushl $168
801063e9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801063ee:	e9 ea f4 ff ff       	jmp    801058dd <alltraps>

801063f3 <vector169>:
.globl vector169
vector169:
  pushl $0
801063f3:	6a 00                	push   $0x0
  pushl $169
801063f5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801063fa:	e9 de f4 ff ff       	jmp    801058dd <alltraps>

801063ff <vector170>:
.globl vector170
vector170:
  pushl $0
801063ff:	6a 00                	push   $0x0
  pushl $170
80106401:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106406:	e9 d2 f4 ff ff       	jmp    801058dd <alltraps>

8010640b <vector171>:
.globl vector171
vector171:
  pushl $0
8010640b:	6a 00                	push   $0x0
  pushl $171
8010640d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106412:	e9 c6 f4 ff ff       	jmp    801058dd <alltraps>

80106417 <vector172>:
.globl vector172
vector172:
  pushl $0
80106417:	6a 00                	push   $0x0
  pushl $172
80106419:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010641e:	e9 ba f4 ff ff       	jmp    801058dd <alltraps>

80106423 <vector173>:
.globl vector173
vector173:
  pushl $0
80106423:	6a 00                	push   $0x0
  pushl $173
80106425:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010642a:	e9 ae f4 ff ff       	jmp    801058dd <alltraps>

8010642f <vector174>:
.globl vector174
vector174:
  pushl $0
8010642f:	6a 00                	push   $0x0
  pushl $174
80106431:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106436:	e9 a2 f4 ff ff       	jmp    801058dd <alltraps>

8010643b <vector175>:
.globl vector175
vector175:
  pushl $0
8010643b:	6a 00                	push   $0x0
  pushl $175
8010643d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106442:	e9 96 f4 ff ff       	jmp    801058dd <alltraps>

80106447 <vector176>:
.globl vector176
vector176:
  pushl $0
80106447:	6a 00                	push   $0x0
  pushl $176
80106449:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010644e:	e9 8a f4 ff ff       	jmp    801058dd <alltraps>

80106453 <vector177>:
.globl vector177
vector177:
  pushl $0
80106453:	6a 00                	push   $0x0
  pushl $177
80106455:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010645a:	e9 7e f4 ff ff       	jmp    801058dd <alltraps>

8010645f <vector178>:
.globl vector178
vector178:
  pushl $0
8010645f:	6a 00                	push   $0x0
  pushl $178
80106461:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106466:	e9 72 f4 ff ff       	jmp    801058dd <alltraps>

8010646b <vector179>:
.globl vector179
vector179:
  pushl $0
8010646b:	6a 00                	push   $0x0
  pushl $179
8010646d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106472:	e9 66 f4 ff ff       	jmp    801058dd <alltraps>

80106477 <vector180>:
.globl vector180
vector180:
  pushl $0
80106477:	6a 00                	push   $0x0
  pushl $180
80106479:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010647e:	e9 5a f4 ff ff       	jmp    801058dd <alltraps>

80106483 <vector181>:
.globl vector181
vector181:
  pushl $0
80106483:	6a 00                	push   $0x0
  pushl $181
80106485:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010648a:	e9 4e f4 ff ff       	jmp    801058dd <alltraps>

8010648f <vector182>:
.globl vector182
vector182:
  pushl $0
8010648f:	6a 00                	push   $0x0
  pushl $182
80106491:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106496:	e9 42 f4 ff ff       	jmp    801058dd <alltraps>

8010649b <vector183>:
.globl vector183
vector183:
  pushl $0
8010649b:	6a 00                	push   $0x0
  pushl $183
8010649d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801064a2:	e9 36 f4 ff ff       	jmp    801058dd <alltraps>

801064a7 <vector184>:
.globl vector184
vector184:
  pushl $0
801064a7:	6a 00                	push   $0x0
  pushl $184
801064a9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801064ae:	e9 2a f4 ff ff       	jmp    801058dd <alltraps>

801064b3 <vector185>:
.globl vector185
vector185:
  pushl $0
801064b3:	6a 00                	push   $0x0
  pushl $185
801064b5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801064ba:	e9 1e f4 ff ff       	jmp    801058dd <alltraps>

801064bf <vector186>:
.globl vector186
vector186:
  pushl $0
801064bf:	6a 00                	push   $0x0
  pushl $186
801064c1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801064c6:	e9 12 f4 ff ff       	jmp    801058dd <alltraps>

801064cb <vector187>:
.globl vector187
vector187:
  pushl $0
801064cb:	6a 00                	push   $0x0
  pushl $187
801064cd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801064d2:	e9 06 f4 ff ff       	jmp    801058dd <alltraps>

801064d7 <vector188>:
.globl vector188
vector188:
  pushl $0
801064d7:	6a 00                	push   $0x0
  pushl $188
801064d9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801064de:	e9 fa f3 ff ff       	jmp    801058dd <alltraps>

801064e3 <vector189>:
.globl vector189
vector189:
  pushl $0
801064e3:	6a 00                	push   $0x0
  pushl $189
801064e5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801064ea:	e9 ee f3 ff ff       	jmp    801058dd <alltraps>

801064ef <vector190>:
.globl vector190
vector190:
  pushl $0
801064ef:	6a 00                	push   $0x0
  pushl $190
801064f1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801064f6:	e9 e2 f3 ff ff       	jmp    801058dd <alltraps>

801064fb <vector191>:
.globl vector191
vector191:
  pushl $0
801064fb:	6a 00                	push   $0x0
  pushl $191
801064fd:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106502:	e9 d6 f3 ff ff       	jmp    801058dd <alltraps>

80106507 <vector192>:
.globl vector192
vector192:
  pushl $0
80106507:	6a 00                	push   $0x0
  pushl $192
80106509:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010650e:	e9 ca f3 ff ff       	jmp    801058dd <alltraps>

80106513 <vector193>:
.globl vector193
vector193:
  pushl $0
80106513:	6a 00                	push   $0x0
  pushl $193
80106515:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010651a:	e9 be f3 ff ff       	jmp    801058dd <alltraps>

8010651f <vector194>:
.globl vector194
vector194:
  pushl $0
8010651f:	6a 00                	push   $0x0
  pushl $194
80106521:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106526:	e9 b2 f3 ff ff       	jmp    801058dd <alltraps>

8010652b <vector195>:
.globl vector195
vector195:
  pushl $0
8010652b:	6a 00                	push   $0x0
  pushl $195
8010652d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106532:	e9 a6 f3 ff ff       	jmp    801058dd <alltraps>

80106537 <vector196>:
.globl vector196
vector196:
  pushl $0
80106537:	6a 00                	push   $0x0
  pushl $196
80106539:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010653e:	e9 9a f3 ff ff       	jmp    801058dd <alltraps>

80106543 <vector197>:
.globl vector197
vector197:
  pushl $0
80106543:	6a 00                	push   $0x0
  pushl $197
80106545:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010654a:	e9 8e f3 ff ff       	jmp    801058dd <alltraps>

8010654f <vector198>:
.globl vector198
vector198:
  pushl $0
8010654f:	6a 00                	push   $0x0
  pushl $198
80106551:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106556:	e9 82 f3 ff ff       	jmp    801058dd <alltraps>

8010655b <vector199>:
.globl vector199
vector199:
  pushl $0
8010655b:	6a 00                	push   $0x0
  pushl $199
8010655d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106562:	e9 76 f3 ff ff       	jmp    801058dd <alltraps>

80106567 <vector200>:
.globl vector200
vector200:
  pushl $0
80106567:	6a 00                	push   $0x0
  pushl $200
80106569:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010656e:	e9 6a f3 ff ff       	jmp    801058dd <alltraps>

80106573 <vector201>:
.globl vector201
vector201:
  pushl $0
80106573:	6a 00                	push   $0x0
  pushl $201
80106575:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010657a:	e9 5e f3 ff ff       	jmp    801058dd <alltraps>

8010657f <vector202>:
.globl vector202
vector202:
  pushl $0
8010657f:	6a 00                	push   $0x0
  pushl $202
80106581:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106586:	e9 52 f3 ff ff       	jmp    801058dd <alltraps>

8010658b <vector203>:
.globl vector203
vector203:
  pushl $0
8010658b:	6a 00                	push   $0x0
  pushl $203
8010658d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106592:	e9 46 f3 ff ff       	jmp    801058dd <alltraps>

80106597 <vector204>:
.globl vector204
vector204:
  pushl $0
80106597:	6a 00                	push   $0x0
  pushl $204
80106599:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010659e:	e9 3a f3 ff ff       	jmp    801058dd <alltraps>

801065a3 <vector205>:
.globl vector205
vector205:
  pushl $0
801065a3:	6a 00                	push   $0x0
  pushl $205
801065a5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801065aa:	e9 2e f3 ff ff       	jmp    801058dd <alltraps>

801065af <vector206>:
.globl vector206
vector206:
  pushl $0
801065af:	6a 00                	push   $0x0
  pushl $206
801065b1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801065b6:	e9 22 f3 ff ff       	jmp    801058dd <alltraps>

801065bb <vector207>:
.globl vector207
vector207:
  pushl $0
801065bb:	6a 00                	push   $0x0
  pushl $207
801065bd:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801065c2:	e9 16 f3 ff ff       	jmp    801058dd <alltraps>

801065c7 <vector208>:
.globl vector208
vector208:
  pushl $0
801065c7:	6a 00                	push   $0x0
  pushl $208
801065c9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801065ce:	e9 0a f3 ff ff       	jmp    801058dd <alltraps>

801065d3 <vector209>:
.globl vector209
vector209:
  pushl $0
801065d3:	6a 00                	push   $0x0
  pushl $209
801065d5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801065da:	e9 fe f2 ff ff       	jmp    801058dd <alltraps>

801065df <vector210>:
.globl vector210
vector210:
  pushl $0
801065df:	6a 00                	push   $0x0
  pushl $210
801065e1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801065e6:	e9 f2 f2 ff ff       	jmp    801058dd <alltraps>

801065eb <vector211>:
.globl vector211
vector211:
  pushl $0
801065eb:	6a 00                	push   $0x0
  pushl $211
801065ed:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801065f2:	e9 e6 f2 ff ff       	jmp    801058dd <alltraps>

801065f7 <vector212>:
.globl vector212
vector212:
  pushl $0
801065f7:	6a 00                	push   $0x0
  pushl $212
801065f9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801065fe:	e9 da f2 ff ff       	jmp    801058dd <alltraps>

80106603 <vector213>:
.globl vector213
vector213:
  pushl $0
80106603:	6a 00                	push   $0x0
  pushl $213
80106605:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010660a:	e9 ce f2 ff ff       	jmp    801058dd <alltraps>

8010660f <vector214>:
.globl vector214
vector214:
  pushl $0
8010660f:	6a 00                	push   $0x0
  pushl $214
80106611:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106616:	e9 c2 f2 ff ff       	jmp    801058dd <alltraps>

8010661b <vector215>:
.globl vector215
vector215:
  pushl $0
8010661b:	6a 00                	push   $0x0
  pushl $215
8010661d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106622:	e9 b6 f2 ff ff       	jmp    801058dd <alltraps>

80106627 <vector216>:
.globl vector216
vector216:
  pushl $0
80106627:	6a 00                	push   $0x0
  pushl $216
80106629:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010662e:	e9 aa f2 ff ff       	jmp    801058dd <alltraps>

80106633 <vector217>:
.globl vector217
vector217:
  pushl $0
80106633:	6a 00                	push   $0x0
  pushl $217
80106635:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010663a:	e9 9e f2 ff ff       	jmp    801058dd <alltraps>

8010663f <vector218>:
.globl vector218
vector218:
  pushl $0
8010663f:	6a 00                	push   $0x0
  pushl $218
80106641:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106646:	e9 92 f2 ff ff       	jmp    801058dd <alltraps>

8010664b <vector219>:
.globl vector219
vector219:
  pushl $0
8010664b:	6a 00                	push   $0x0
  pushl $219
8010664d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106652:	e9 86 f2 ff ff       	jmp    801058dd <alltraps>

80106657 <vector220>:
.globl vector220
vector220:
  pushl $0
80106657:	6a 00                	push   $0x0
  pushl $220
80106659:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010665e:	e9 7a f2 ff ff       	jmp    801058dd <alltraps>

80106663 <vector221>:
.globl vector221
vector221:
  pushl $0
80106663:	6a 00                	push   $0x0
  pushl $221
80106665:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010666a:	e9 6e f2 ff ff       	jmp    801058dd <alltraps>

8010666f <vector222>:
.globl vector222
vector222:
  pushl $0
8010666f:	6a 00                	push   $0x0
  pushl $222
80106671:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106676:	e9 62 f2 ff ff       	jmp    801058dd <alltraps>

8010667b <vector223>:
.globl vector223
vector223:
  pushl $0
8010667b:	6a 00                	push   $0x0
  pushl $223
8010667d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106682:	e9 56 f2 ff ff       	jmp    801058dd <alltraps>

80106687 <vector224>:
.globl vector224
vector224:
  pushl $0
80106687:	6a 00                	push   $0x0
  pushl $224
80106689:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010668e:	e9 4a f2 ff ff       	jmp    801058dd <alltraps>

80106693 <vector225>:
.globl vector225
vector225:
  pushl $0
80106693:	6a 00                	push   $0x0
  pushl $225
80106695:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010669a:	e9 3e f2 ff ff       	jmp    801058dd <alltraps>

8010669f <vector226>:
.globl vector226
vector226:
  pushl $0
8010669f:	6a 00                	push   $0x0
  pushl $226
801066a1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801066a6:	e9 32 f2 ff ff       	jmp    801058dd <alltraps>

801066ab <vector227>:
.globl vector227
vector227:
  pushl $0
801066ab:	6a 00                	push   $0x0
  pushl $227
801066ad:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801066b2:	e9 26 f2 ff ff       	jmp    801058dd <alltraps>

801066b7 <vector228>:
.globl vector228
vector228:
  pushl $0
801066b7:	6a 00                	push   $0x0
  pushl $228
801066b9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801066be:	e9 1a f2 ff ff       	jmp    801058dd <alltraps>

801066c3 <vector229>:
.globl vector229
vector229:
  pushl $0
801066c3:	6a 00                	push   $0x0
  pushl $229
801066c5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801066ca:	e9 0e f2 ff ff       	jmp    801058dd <alltraps>

801066cf <vector230>:
.globl vector230
vector230:
  pushl $0
801066cf:	6a 00                	push   $0x0
  pushl $230
801066d1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801066d6:	e9 02 f2 ff ff       	jmp    801058dd <alltraps>

801066db <vector231>:
.globl vector231
vector231:
  pushl $0
801066db:	6a 00                	push   $0x0
  pushl $231
801066dd:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801066e2:	e9 f6 f1 ff ff       	jmp    801058dd <alltraps>

801066e7 <vector232>:
.globl vector232
vector232:
  pushl $0
801066e7:	6a 00                	push   $0x0
  pushl $232
801066e9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801066ee:	e9 ea f1 ff ff       	jmp    801058dd <alltraps>

801066f3 <vector233>:
.globl vector233
vector233:
  pushl $0
801066f3:	6a 00                	push   $0x0
  pushl $233
801066f5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801066fa:	e9 de f1 ff ff       	jmp    801058dd <alltraps>

801066ff <vector234>:
.globl vector234
vector234:
  pushl $0
801066ff:	6a 00                	push   $0x0
  pushl $234
80106701:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106706:	e9 d2 f1 ff ff       	jmp    801058dd <alltraps>

8010670b <vector235>:
.globl vector235
vector235:
  pushl $0
8010670b:	6a 00                	push   $0x0
  pushl $235
8010670d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106712:	e9 c6 f1 ff ff       	jmp    801058dd <alltraps>

80106717 <vector236>:
.globl vector236
vector236:
  pushl $0
80106717:	6a 00                	push   $0x0
  pushl $236
80106719:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010671e:	e9 ba f1 ff ff       	jmp    801058dd <alltraps>

80106723 <vector237>:
.globl vector237
vector237:
  pushl $0
80106723:	6a 00                	push   $0x0
  pushl $237
80106725:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010672a:	e9 ae f1 ff ff       	jmp    801058dd <alltraps>

8010672f <vector238>:
.globl vector238
vector238:
  pushl $0
8010672f:	6a 00                	push   $0x0
  pushl $238
80106731:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106736:	e9 a2 f1 ff ff       	jmp    801058dd <alltraps>

8010673b <vector239>:
.globl vector239
vector239:
  pushl $0
8010673b:	6a 00                	push   $0x0
  pushl $239
8010673d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106742:	e9 96 f1 ff ff       	jmp    801058dd <alltraps>

80106747 <vector240>:
.globl vector240
vector240:
  pushl $0
80106747:	6a 00                	push   $0x0
  pushl $240
80106749:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010674e:	e9 8a f1 ff ff       	jmp    801058dd <alltraps>

80106753 <vector241>:
.globl vector241
vector241:
  pushl $0
80106753:	6a 00                	push   $0x0
  pushl $241
80106755:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010675a:	e9 7e f1 ff ff       	jmp    801058dd <alltraps>

8010675f <vector242>:
.globl vector242
vector242:
  pushl $0
8010675f:	6a 00                	push   $0x0
  pushl $242
80106761:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106766:	e9 72 f1 ff ff       	jmp    801058dd <alltraps>

8010676b <vector243>:
.globl vector243
vector243:
  pushl $0
8010676b:	6a 00                	push   $0x0
  pushl $243
8010676d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106772:	e9 66 f1 ff ff       	jmp    801058dd <alltraps>

80106777 <vector244>:
.globl vector244
vector244:
  pushl $0
80106777:	6a 00                	push   $0x0
  pushl $244
80106779:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010677e:	e9 5a f1 ff ff       	jmp    801058dd <alltraps>

80106783 <vector245>:
.globl vector245
vector245:
  pushl $0
80106783:	6a 00                	push   $0x0
  pushl $245
80106785:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010678a:	e9 4e f1 ff ff       	jmp    801058dd <alltraps>

8010678f <vector246>:
.globl vector246
vector246:
  pushl $0
8010678f:	6a 00                	push   $0x0
  pushl $246
80106791:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106796:	e9 42 f1 ff ff       	jmp    801058dd <alltraps>

8010679b <vector247>:
.globl vector247
vector247:
  pushl $0
8010679b:	6a 00                	push   $0x0
  pushl $247
8010679d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801067a2:	e9 36 f1 ff ff       	jmp    801058dd <alltraps>

801067a7 <vector248>:
.globl vector248
vector248:
  pushl $0
801067a7:	6a 00                	push   $0x0
  pushl $248
801067a9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801067ae:	e9 2a f1 ff ff       	jmp    801058dd <alltraps>

801067b3 <vector249>:
.globl vector249
vector249:
  pushl $0
801067b3:	6a 00                	push   $0x0
  pushl $249
801067b5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801067ba:	e9 1e f1 ff ff       	jmp    801058dd <alltraps>

801067bf <vector250>:
.globl vector250
vector250:
  pushl $0
801067bf:	6a 00                	push   $0x0
  pushl $250
801067c1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801067c6:	e9 12 f1 ff ff       	jmp    801058dd <alltraps>

801067cb <vector251>:
.globl vector251
vector251:
  pushl $0
801067cb:	6a 00                	push   $0x0
  pushl $251
801067cd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
801067d2:	e9 06 f1 ff ff       	jmp    801058dd <alltraps>

801067d7 <vector252>:
.globl vector252
vector252:
  pushl $0
801067d7:	6a 00                	push   $0x0
  pushl $252
801067d9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
801067de:	e9 fa f0 ff ff       	jmp    801058dd <alltraps>

801067e3 <vector253>:
.globl vector253
vector253:
  pushl $0
801067e3:	6a 00                	push   $0x0
  pushl $253
801067e5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801067ea:	e9 ee f0 ff ff       	jmp    801058dd <alltraps>

801067ef <vector254>:
.globl vector254
vector254:
  pushl $0
801067ef:	6a 00                	push   $0x0
  pushl $254
801067f1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
801067f6:	e9 e2 f0 ff ff       	jmp    801058dd <alltraps>

801067fb <vector255>:
.globl vector255
vector255:
  pushl $0
801067fb:	6a 00                	push   $0x0
  pushl $255
801067fd:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106802:	e9 d6 f0 ff ff       	jmp    801058dd <alltraps>
80106807:	66 90                	xchg   %ax,%ax
80106809:	66 90                	xchg   %ax,%ax
8010680b:	66 90                	xchg   %ax,%ax
8010680d:	66 90                	xchg   %ax,%ax
8010680f:	90                   	nop

80106810 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106810:	55                   	push   %ebp
80106811:	89 e5                	mov    %esp,%ebp
80106813:	57                   	push   %edi
80106814:	56                   	push   %esi
80106815:	53                   	push   %ebx
80106816:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106818:	c1 ea 16             	shr    $0x16,%edx
8010681b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
8010681e:	83 ec 0c             	sub    $0xc,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
80106821:	8b 07                	mov    (%edi),%eax
80106823:	a8 01                	test   $0x1,%al
80106825:	74 29                	je     80106850 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106827:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010682c:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106832:	8d 65 f4             	lea    -0xc(%ebp),%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106835:	c1 eb 0a             	shr    $0xa,%ebx
80106838:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
8010683e:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
80106841:	5b                   	pop    %ebx
80106842:	5e                   	pop    %esi
80106843:	5f                   	pop    %edi
80106844:	5d                   	pop    %ebp
80106845:	c3                   	ret    
80106846:	8d 76 00             	lea    0x0(%esi),%esi
80106849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106850:	85 c9                	test   %ecx,%ecx
80106852:	74 2c                	je     80106880 <walkpgdir+0x70>
80106854:	e8 f7 bd ff ff       	call   80102650 <kalloc>
80106859:	85 c0                	test   %eax,%eax
8010685b:	89 c6                	mov    %eax,%esi
8010685d:	74 21                	je     80106880 <walkpgdir+0x70>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
8010685f:	83 ec 04             	sub    $0x4,%esp
80106862:	68 00 10 00 00       	push   $0x1000
80106867:	6a 00                	push   $0x0
80106869:	50                   	push   %eax
8010686a:	e8 61 dd ff ff       	call   801045d0 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010686f:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106875:	83 c4 10             	add    $0x10,%esp
80106878:	83 c8 07             	or     $0x7,%eax
8010687b:	89 07                	mov    %eax,(%edi)
8010687d:	eb b3                	jmp    80106832 <walkpgdir+0x22>
8010687f:	90                   	nop
  }
  return &pgtab[PTX(va)];
}
80106880:	8d 65 f4             	lea    -0xc(%ebp),%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
80106883:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106885:	5b                   	pop    %ebx
80106886:	5e                   	pop    %esi
80106887:	5f                   	pop    %edi
80106888:	5d                   	pop    %ebp
80106889:	c3                   	ret    
8010688a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106890 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106890:	55                   	push   %ebp
80106891:	89 e5                	mov    %esp,%ebp
80106893:	57                   	push   %edi
80106894:	56                   	push   %esi
80106895:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106896:	89 d3                	mov    %edx,%ebx
80106898:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
8010689e:	83 ec 1c             	sub    $0x1c,%esp
801068a1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801068a4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801068a8:	8b 7d 08             	mov    0x8(%ebp),%edi
801068ab:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801068b0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801068b3:	8b 45 0c             	mov    0xc(%ebp),%eax
801068b6:	29 df                	sub    %ebx,%edi
801068b8:	83 c8 01             	or     $0x1,%eax
801068bb:	89 45 dc             	mov    %eax,-0x24(%ebp)
801068be:	eb 15                	jmp    801068d5 <mappages+0x45>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
801068c0:	f6 00 01             	testb  $0x1,(%eax)
801068c3:	75 45                	jne    8010690a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
801068c5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
801068c8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801068cb:	89 30                	mov    %esi,(%eax)
    if(a == last)
801068cd:	74 31                	je     80106900 <mappages+0x70>
      break;
    a += PGSIZE;
801068cf:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801068d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801068d8:	b9 01 00 00 00       	mov    $0x1,%ecx
801068dd:	89 da                	mov    %ebx,%edx
801068df:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
801068e2:	e8 29 ff ff ff       	call   80106810 <walkpgdir>
801068e7:	85 c0                	test   %eax,%eax
801068e9:	75 d5                	jne    801068c0 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
801068eb:	8d 65 f4             	lea    -0xc(%ebp),%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
801068ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
801068f3:	5b                   	pop    %ebx
801068f4:	5e                   	pop    %esi
801068f5:	5f                   	pop    %edi
801068f6:	5d                   	pop    %ebp
801068f7:	c3                   	ret    
801068f8:	90                   	nop
801068f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106900:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80106903:	31 c0                	xor    %eax,%eax
}
80106905:	5b                   	pop    %ebx
80106906:	5e                   	pop    %esi
80106907:	5f                   	pop    %edi
80106908:	5d                   	pop    %ebp
80106909:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
8010690a:	83 ec 0c             	sub    $0xc,%esp
8010690d:	68 54 7a 10 80       	push   $0x80107a54
80106912:	e8 59 9a ff ff       	call   80100370 <panic>
80106917:	89 f6                	mov    %esi,%esi
80106919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106920 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106920:	55                   	push   %ebp
80106921:	89 e5                	mov    %esp,%ebp
80106923:	57                   	push   %edi
80106924:	56                   	push   %esi
80106925:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106926:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010692c:	89 c7                	mov    %eax,%edi
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
8010692e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106934:	83 ec 1c             	sub    $0x1c,%esp
80106937:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
8010693a:	39 d3                	cmp    %edx,%ebx
8010693c:	73 66                	jae    801069a4 <deallocuvm.part.0+0x84>
8010693e:	89 d6                	mov    %edx,%esi
80106940:	eb 3d                	jmp    8010697f <deallocuvm.part.0+0x5f>
80106942:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106948:	8b 10                	mov    (%eax),%edx
8010694a:	f6 c2 01             	test   $0x1,%dl
8010694d:	74 26                	je     80106975 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010694f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106955:	74 58                	je     801069af <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106957:	83 ec 0c             	sub    $0xc,%esp
8010695a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106960:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106963:	52                   	push   %edx
80106964:	e8 37 bb ff ff       	call   801024a0 <kfree>
      *pte = 0;
80106969:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010696c:	83 c4 10             	add    $0x10,%esp
8010696f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106975:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010697b:	39 f3                	cmp    %esi,%ebx
8010697d:	73 25                	jae    801069a4 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010697f:	31 c9                	xor    %ecx,%ecx
80106981:	89 da                	mov    %ebx,%edx
80106983:	89 f8                	mov    %edi,%eax
80106985:	e8 86 fe ff ff       	call   80106810 <walkpgdir>
    if(!pte)
8010698a:	85 c0                	test   %eax,%eax
8010698c:	75 ba                	jne    80106948 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010698e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106994:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
8010699a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801069a0:	39 f3                	cmp    %esi,%ebx
801069a2:	72 db                	jb     8010697f <deallocuvm.part.0+0x5f>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
801069a4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801069a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801069aa:	5b                   	pop    %ebx
801069ab:	5e                   	pop    %esi
801069ac:	5f                   	pop    %edi
801069ad:	5d                   	pop    %ebp
801069ae:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
801069af:	83 ec 0c             	sub    $0xc,%esp
801069b2:	68 e6 73 10 80       	push   $0x801073e6
801069b7:	e8 b4 99 ff ff       	call   80100370 <panic>
801069bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801069c0 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
801069c0:	55                   	push   %ebp
801069c1:	89 e5                	mov    %esp,%ebp
801069c3:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
801069c6:	e8 55 cf ff ff       	call   80103920 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801069cb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
801069d1:	31 c9                	xor    %ecx,%ecx
801069d3:	ba ff ff ff ff       	mov    $0xffffffff,%edx
801069d8:	66 89 90 98 37 11 80 	mov    %dx,-0x7feec868(%eax)
801069df:	66 89 88 9a 37 11 80 	mov    %cx,-0x7feec866(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801069e6:	ba ff ff ff ff       	mov    $0xffffffff,%edx
801069eb:	31 c9                	xor    %ecx,%ecx
801069ed:	66 89 90 a0 37 11 80 	mov    %dx,-0x7feec860(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801069f4:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801069f9:	66 89 88 a2 37 11 80 	mov    %cx,-0x7feec85e(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106a00:	31 c9                	xor    %ecx,%ecx
80106a02:	66 89 90 a8 37 11 80 	mov    %dx,-0x7feec858(%eax)
80106a09:	66 89 88 aa 37 11 80 	mov    %cx,-0x7feec856(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106a10:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106a15:	31 c9                	xor    %ecx,%ecx
80106a17:	66 89 90 b0 37 11 80 	mov    %dx,-0x7feec850(%eax)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106a1e:	c6 80 9c 37 11 80 00 	movb   $0x0,-0x7feec864(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106a25:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106a2a:	c6 80 9d 37 11 80 9a 	movb   $0x9a,-0x7feec863(%eax)
80106a31:	c6 80 9e 37 11 80 cf 	movb   $0xcf,-0x7feec862(%eax)
80106a38:	c6 80 9f 37 11 80 00 	movb   $0x0,-0x7feec861(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106a3f:	c6 80 a4 37 11 80 00 	movb   $0x0,-0x7feec85c(%eax)
80106a46:	c6 80 a5 37 11 80 92 	movb   $0x92,-0x7feec85b(%eax)
80106a4d:	c6 80 a6 37 11 80 cf 	movb   $0xcf,-0x7feec85a(%eax)
80106a54:	c6 80 a7 37 11 80 00 	movb   $0x0,-0x7feec859(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106a5b:	c6 80 ac 37 11 80 00 	movb   $0x0,-0x7feec854(%eax)
80106a62:	c6 80 ad 37 11 80 fa 	movb   $0xfa,-0x7feec853(%eax)
80106a69:	c6 80 ae 37 11 80 cf 	movb   $0xcf,-0x7feec852(%eax)
80106a70:	c6 80 af 37 11 80 00 	movb   $0x0,-0x7feec851(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106a77:	66 89 88 b2 37 11 80 	mov    %cx,-0x7feec84e(%eax)
80106a7e:	c6 80 b4 37 11 80 00 	movb   $0x0,-0x7feec84c(%eax)
80106a85:	c6 80 b5 37 11 80 f2 	movb   $0xf2,-0x7feec84b(%eax)
80106a8c:	c6 80 b6 37 11 80 cf 	movb   $0xcf,-0x7feec84a(%eax)
80106a93:	c6 80 b7 37 11 80 00 	movb   $0x0,-0x7feec849(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80106a9a:	05 90 37 11 80       	add    $0x80113790,%eax
80106a9f:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
80106aa3:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106aa7:	c1 e8 10             	shr    $0x10,%eax
80106aaa:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80106aae:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106ab1:	0f 01 10             	lgdtl  (%eax)
}
80106ab4:	c9                   	leave  
80106ab5:	c3                   	ret    
80106ab6:	8d 76 00             	lea    0x0(%esi),%esi
80106ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ac0 <switchkvm>:
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106ac0:	a1 44 64 11 80       	mov    0x80116444,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106ac5:	55                   	push   %ebp
80106ac6:	89 e5                	mov    %esp,%ebp
80106ac8:	05 00 00 00 80       	add    $0x80000000,%eax
80106acd:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
80106ad0:	5d                   	pop    %ebp
80106ad1:	c3                   	ret    
80106ad2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ae0 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80106ae0:	55                   	push   %ebp
80106ae1:	89 e5                	mov    %esp,%ebp
80106ae3:	57                   	push   %edi
80106ae4:	56                   	push   %esi
80106ae5:	53                   	push   %ebx
80106ae6:	83 ec 1c             	sub    $0x1c,%esp
80106ae9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106aec:	85 f6                	test   %esi,%esi
80106aee:	0f 84 cd 00 00 00    	je     80106bc1 <switchuvm+0xe1>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80106af4:	8b 46 08             	mov    0x8(%esi),%eax
80106af7:	85 c0                	test   %eax,%eax
80106af9:	0f 84 dc 00 00 00    	je     80106bdb <switchuvm+0xfb>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80106aff:	8b 7e 04             	mov    0x4(%esi),%edi
80106b02:	85 ff                	test   %edi,%edi
80106b04:	0f 84 c4 00 00 00    	je     80106bce <switchuvm+0xee>
    panic("switchuvm: no pgdir");

  pushcli();
80106b0a:	e8 11 d9 ff ff       	call   80104420 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106b0f:	e8 8c cd ff ff       	call   801038a0 <mycpu>
80106b14:	89 c3                	mov    %eax,%ebx
80106b16:	e8 85 cd ff ff       	call   801038a0 <mycpu>
80106b1b:	89 c7                	mov    %eax,%edi
80106b1d:	e8 7e cd ff ff       	call   801038a0 <mycpu>
80106b22:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106b25:	83 c7 08             	add    $0x8,%edi
80106b28:	e8 73 cd ff ff       	call   801038a0 <mycpu>
80106b2d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106b30:	83 c0 08             	add    $0x8,%eax
80106b33:	ba 67 00 00 00       	mov    $0x67,%edx
80106b38:	c1 e8 18             	shr    $0x18,%eax
80106b3b:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80106b42:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106b49:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
80106b50:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80106b57:	83 c1 08             	add    $0x8,%ecx
80106b5a:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106b60:	c1 e9 10             	shr    $0x10,%ecx
80106b63:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106b69:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    panic("switchuvm: no pgdir");

  pushcli();
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
80106b6e:	e8 2d cd ff ff       	call   801038a0 <mycpu>
80106b73:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106b7a:	e8 21 cd ff ff       	call   801038a0 <mycpu>
80106b7f:	b9 10 00 00 00       	mov    $0x10,%ecx
80106b84:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106b88:	e8 13 cd ff ff       	call   801038a0 <mycpu>
80106b8d:	8b 56 08             	mov    0x8(%esi),%edx
80106b90:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80106b96:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106b99:	e8 02 cd ff ff       	call   801038a0 <mycpu>
80106b9e:	66 89 58 6e          	mov    %bx,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
80106ba2:	b8 28 00 00 00       	mov    $0x28,%eax
80106ba7:	0f 00 d8             	ltr    %ax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106baa:	8b 46 04             	mov    0x4(%esi),%eax
80106bad:	05 00 00 00 80       	add    $0x80000000,%eax
80106bb2:	0f 22 d8             	mov    %eax,%cr3
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
80106bb5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106bb8:	5b                   	pop    %ebx
80106bb9:	5e                   	pop    %esi
80106bba:	5f                   	pop    %edi
80106bbb:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
80106bbc:	e9 4f d9 ff ff       	jmp    80104510 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
80106bc1:	83 ec 0c             	sub    $0xc,%esp
80106bc4:	68 5a 7a 10 80       	push   $0x80107a5a
80106bc9:	e8 a2 97 ff ff       	call   80100370 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
80106bce:	83 ec 0c             	sub    $0xc,%esp
80106bd1:	68 85 7a 10 80       	push   $0x80107a85
80106bd6:	e8 95 97 ff ff       	call   80100370 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
80106bdb:	83 ec 0c             	sub    $0xc,%esp
80106bde:	68 70 7a 10 80       	push   $0x80107a70
80106be3:	e8 88 97 ff ff       	call   80100370 <panic>
80106be8:	90                   	nop
80106be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106bf0 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106bf0:	55                   	push   %ebp
80106bf1:	89 e5                	mov    %esp,%ebp
80106bf3:	57                   	push   %edi
80106bf4:	56                   	push   %esi
80106bf5:	53                   	push   %ebx
80106bf6:	83 ec 1c             	sub    $0x1c,%esp
80106bf9:	8b 75 10             	mov    0x10(%ebp),%esi
80106bfc:	8b 45 08             	mov    0x8(%ebp),%eax
80106bff:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80106c02:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106c08:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80106c0b:	77 49                	ja     80106c56 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
80106c0d:	e8 3e ba ff ff       	call   80102650 <kalloc>
  memset(mem, 0, PGSIZE);
80106c12:	83 ec 04             	sub    $0x4,%esp
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80106c15:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106c17:	68 00 10 00 00       	push   $0x1000
80106c1c:	6a 00                	push   $0x0
80106c1e:	50                   	push   %eax
80106c1f:	e8 ac d9 ff ff       	call   801045d0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106c24:	58                   	pop    %eax
80106c25:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106c2b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106c30:	5a                   	pop    %edx
80106c31:	6a 06                	push   $0x6
80106c33:	50                   	push   %eax
80106c34:	31 d2                	xor    %edx,%edx
80106c36:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106c39:	e8 52 fc ff ff       	call   80106890 <mappages>
  memmove(mem, init, sz);
80106c3e:	89 75 10             	mov    %esi,0x10(%ebp)
80106c41:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106c44:	83 c4 10             	add    $0x10,%esp
80106c47:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106c4a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c4d:	5b                   	pop    %ebx
80106c4e:	5e                   	pop    %esi
80106c4f:	5f                   	pop    %edi
80106c50:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80106c51:	e9 2a da ff ff       	jmp    80104680 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80106c56:	83 ec 0c             	sub    $0xc,%esp
80106c59:	68 99 7a 10 80       	push   $0x80107a99
80106c5e:	e8 0d 97 ff ff       	call   80100370 <panic>
80106c63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c70 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80106c70:	55                   	push   %ebp
80106c71:	89 e5                	mov    %esp,%ebp
80106c73:	57                   	push   %edi
80106c74:	56                   	push   %esi
80106c75:	53                   	push   %ebx
80106c76:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80106c79:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106c80:	0f 85 91 00 00 00    	jne    80106d17 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80106c86:	8b 75 18             	mov    0x18(%ebp),%esi
80106c89:	31 db                	xor    %ebx,%ebx
80106c8b:	85 f6                	test   %esi,%esi
80106c8d:	75 1a                	jne    80106ca9 <loaduvm+0x39>
80106c8f:	eb 6f                	jmp    80106d00 <loaduvm+0x90>
80106c91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c98:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106c9e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106ca4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106ca7:	76 57                	jbe    80106d00 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106ca9:	8b 55 0c             	mov    0xc(%ebp),%edx
80106cac:	8b 45 08             	mov    0x8(%ebp),%eax
80106caf:	31 c9                	xor    %ecx,%ecx
80106cb1:	01 da                	add    %ebx,%edx
80106cb3:	e8 58 fb ff ff       	call   80106810 <walkpgdir>
80106cb8:	85 c0                	test   %eax,%eax
80106cba:	74 4e                	je     80106d0a <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106cbc:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106cbe:	8b 4d 14             	mov    0x14(%ebp),%ecx
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
80106cc1:	bf 00 10 00 00       	mov    $0x1000,%edi
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106cc6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106ccb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106cd1:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106cd4:	01 d9                	add    %ebx,%ecx
80106cd6:	05 00 00 00 80       	add    $0x80000000,%eax
80106cdb:	57                   	push   %edi
80106cdc:	51                   	push   %ecx
80106cdd:	50                   	push   %eax
80106cde:	ff 75 10             	pushl  0x10(%ebp)
80106ce1:	e8 2a ae ff ff       	call   80101b10 <readi>
80106ce6:	83 c4 10             	add    $0x10,%esp
80106ce9:	39 c7                	cmp    %eax,%edi
80106ceb:	74 ab                	je     80106c98 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80106ced:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80106cf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80106cf5:	5b                   	pop    %ebx
80106cf6:	5e                   	pop    %esi
80106cf7:	5f                   	pop    %edi
80106cf8:	5d                   	pop    %ebp
80106cf9:	c3                   	ret    
80106cfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d00:	8d 65 f4             	lea    -0xc(%ebp),%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80106d03:	31 c0                	xor    %eax,%eax
}
80106d05:	5b                   	pop    %ebx
80106d06:	5e                   	pop    %esi
80106d07:	5f                   	pop    %edi
80106d08:	5d                   	pop    %ebp
80106d09:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80106d0a:	83 ec 0c             	sub    $0xc,%esp
80106d0d:	68 b3 7a 10 80       	push   $0x80107ab3
80106d12:	e8 59 96 ff ff       	call   80100370 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80106d17:	83 ec 0c             	sub    $0xc,%esp
80106d1a:	68 54 7b 10 80       	push   $0x80107b54
80106d1f:	e8 4c 96 ff ff       	call   80100370 <panic>
80106d24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106d30 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106d30:	55                   	push   %ebp
80106d31:	89 e5                	mov    %esp,%ebp
80106d33:	57                   	push   %edi
80106d34:	56                   	push   %esi
80106d35:	53                   	push   %ebx
80106d36:	83 ec 0c             	sub    $0xc,%esp
80106d39:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80106d3c:	85 ff                	test   %edi,%edi
80106d3e:	0f 88 ca 00 00 00    	js     80106e0e <allocuvm+0xde>
    return 0;
  if(newsz < oldsz)
80106d44:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80106d47:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
80106d4a:	0f 82 82 00 00 00    	jb     80106dd2 <allocuvm+0xa2>
    return oldsz;

  a = PGROUNDUP(oldsz);
80106d50:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106d56:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106d5c:	39 df                	cmp    %ebx,%edi
80106d5e:	77 43                	ja     80106da3 <allocuvm+0x73>
80106d60:	e9 bb 00 00 00       	jmp    80106e20 <allocuvm+0xf0>
80106d65:	8d 76 00             	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80106d68:	83 ec 04             	sub    $0x4,%esp
80106d6b:	68 00 10 00 00       	push   $0x1000
80106d70:	6a 00                	push   $0x0
80106d72:	50                   	push   %eax
80106d73:	e8 58 d8 ff ff       	call   801045d0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106d78:	58                   	pop    %eax
80106d79:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106d7f:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106d84:	5a                   	pop    %edx
80106d85:	6a 06                	push   $0x6
80106d87:	50                   	push   %eax
80106d88:	89 da                	mov    %ebx,%edx
80106d8a:	8b 45 08             	mov    0x8(%ebp),%eax
80106d8d:	e8 fe fa ff ff       	call   80106890 <mappages>
80106d92:	83 c4 10             	add    $0x10,%esp
80106d95:	85 c0                	test   %eax,%eax
80106d97:	78 47                	js     80106de0 <allocuvm+0xb0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106d99:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d9f:	39 df                	cmp    %ebx,%edi
80106da1:	76 7d                	jbe    80106e20 <allocuvm+0xf0>
    mem = kalloc();
80106da3:	e8 a8 b8 ff ff       	call   80102650 <kalloc>
    if(mem == 0){
80106da8:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
80106daa:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106dac:	75 ba                	jne    80106d68 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
80106dae:	83 ec 0c             	sub    $0xc,%esp
80106db1:	68 d1 7a 10 80       	push   $0x80107ad1
80106db6:	e8 f5 98 ff ff       	call   801006b0 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106dbb:	83 c4 10             	add    $0x10,%esp
80106dbe:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106dc1:	76 4b                	jbe    80106e0e <allocuvm+0xde>
80106dc3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106dc6:	8b 45 08             	mov    0x8(%ebp),%eax
80106dc9:	89 fa                	mov    %edi,%edx
80106dcb:	e8 50 fb ff ff       	call   80106920 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80106dd0:	31 c0                	xor    %eax,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106dd2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106dd5:	5b                   	pop    %ebx
80106dd6:	5e                   	pop    %esi
80106dd7:	5f                   	pop    %edi
80106dd8:	5d                   	pop    %ebp
80106dd9:	c3                   	ret    
80106dda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80106de0:	83 ec 0c             	sub    $0xc,%esp
80106de3:	68 e9 7a 10 80       	push   $0x80107ae9
80106de8:	e8 c3 98 ff ff       	call   801006b0 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106ded:	83 c4 10             	add    $0x10,%esp
80106df0:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106df3:	76 0d                	jbe    80106e02 <allocuvm+0xd2>
80106df5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106df8:	8b 45 08             	mov    0x8(%ebp),%eax
80106dfb:	89 fa                	mov    %edi,%edx
80106dfd:	e8 1e fb ff ff       	call   80106920 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80106e02:	83 ec 0c             	sub    $0xc,%esp
80106e05:	56                   	push   %esi
80106e06:	e8 95 b6 ff ff       	call   801024a0 <kfree>
      return 0;
80106e0b:	83 c4 10             	add    $0x10,%esp
    }
  }
  return newsz;
}
80106e0e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80106e11:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
80106e13:	5b                   	pop    %ebx
80106e14:	5e                   	pop    %esi
80106e15:	5f                   	pop    %edi
80106e16:	5d                   	pop    %ebp
80106e17:	c3                   	ret    
80106e18:	90                   	nop
80106e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e20:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106e23:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106e25:	5b                   	pop    %ebx
80106e26:	5e                   	pop    %esi
80106e27:	5f                   	pop    %edi
80106e28:	5d                   	pop    %ebp
80106e29:	c3                   	ret    
80106e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106e30 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106e30:	55                   	push   %ebp
80106e31:	89 e5                	mov    %esp,%ebp
80106e33:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e36:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106e39:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106e3c:	39 d1                	cmp    %edx,%ecx
80106e3e:	73 10                	jae    80106e50 <deallocuvm+0x20>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106e40:	5d                   	pop    %ebp
80106e41:	e9 da fa ff ff       	jmp    80106920 <deallocuvm.part.0>
80106e46:	8d 76 00             	lea    0x0(%esi),%esi
80106e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106e50:	89 d0                	mov    %edx,%eax
80106e52:	5d                   	pop    %ebp
80106e53:	c3                   	ret    
80106e54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106e60 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106e60:	55                   	push   %ebp
80106e61:	89 e5                	mov    %esp,%ebp
80106e63:	57                   	push   %edi
80106e64:	56                   	push   %esi
80106e65:	53                   	push   %ebx
80106e66:	83 ec 0c             	sub    $0xc,%esp
80106e69:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106e6c:	85 f6                	test   %esi,%esi
80106e6e:	74 59                	je     80106ec9 <freevm+0x69>
80106e70:	31 c9                	xor    %ecx,%ecx
80106e72:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106e77:	89 f0                	mov    %esi,%eax
80106e79:	e8 a2 fa ff ff       	call   80106920 <deallocuvm.part.0>
80106e7e:	89 f3                	mov    %esi,%ebx
80106e80:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106e86:	eb 0f                	jmp    80106e97 <freevm+0x37>
80106e88:	90                   	nop
80106e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e90:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106e93:	39 fb                	cmp    %edi,%ebx
80106e95:	74 23                	je     80106eba <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106e97:	8b 03                	mov    (%ebx),%eax
80106e99:	a8 01                	test   $0x1,%al
80106e9b:	74 f3                	je     80106e90 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
80106e9d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106ea2:	83 ec 0c             	sub    $0xc,%esp
80106ea5:	83 c3 04             	add    $0x4,%ebx
80106ea8:	05 00 00 00 80       	add    $0x80000000,%eax
80106ead:	50                   	push   %eax
80106eae:	e8 ed b5 ff ff       	call   801024a0 <kfree>
80106eb3:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106eb6:	39 fb                	cmp    %edi,%ebx
80106eb8:	75 dd                	jne    80106e97 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106eba:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106ebd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ec0:	5b                   	pop    %ebx
80106ec1:	5e                   	pop    %esi
80106ec2:	5f                   	pop    %edi
80106ec3:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106ec4:	e9 d7 b5 ff ff       	jmp    801024a0 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80106ec9:	83 ec 0c             	sub    $0xc,%esp
80106ecc:	68 05 7b 10 80       	push   $0x80107b05
80106ed1:	e8 9a 94 ff ff       	call   80100370 <panic>
80106ed6:	8d 76 00             	lea    0x0(%esi),%esi
80106ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ee0 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80106ee0:	55                   	push   %ebp
80106ee1:	89 e5                	mov    %esp,%ebp
80106ee3:	56                   	push   %esi
80106ee4:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80106ee5:	e8 66 b7 ff ff       	call   80102650 <kalloc>
80106eea:	85 c0                	test   %eax,%eax
80106eec:	74 6a                	je     80106f58 <setupkvm+0x78>
    return 0;
  memset(pgdir, 0, PGSIZE);
80106eee:	83 ec 04             	sub    $0x4,%esp
80106ef1:	89 c6                	mov    %eax,%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106ef3:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
80106ef8:	68 00 10 00 00       	push   $0x1000
80106efd:	6a 00                	push   $0x0
80106eff:	50                   	push   %eax
80106f00:	e8 cb d6 ff ff       	call   801045d0 <memset>
80106f05:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106f08:	8b 43 04             	mov    0x4(%ebx),%eax
80106f0b:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106f0e:	83 ec 08             	sub    $0x8,%esp
80106f11:	8b 13                	mov    (%ebx),%edx
80106f13:	ff 73 0c             	pushl  0xc(%ebx)
80106f16:	50                   	push   %eax
80106f17:	29 c1                	sub    %eax,%ecx
80106f19:	89 f0                	mov    %esi,%eax
80106f1b:	e8 70 f9 ff ff       	call   80106890 <mappages>
80106f20:	83 c4 10             	add    $0x10,%esp
80106f23:	85 c0                	test   %eax,%eax
80106f25:	78 19                	js     80106f40 <setupkvm+0x60>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106f27:	83 c3 10             	add    $0x10,%ebx
80106f2a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106f30:	75 d6                	jne    80106f08 <setupkvm+0x28>
80106f32:	89 f0                	mov    %esi,%eax
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
80106f34:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106f37:	5b                   	pop    %ebx
80106f38:	5e                   	pop    %esi
80106f39:	5d                   	pop    %ebp
80106f3a:	c3                   	ret    
80106f3b:	90                   	nop
80106f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
80106f40:	83 ec 0c             	sub    $0xc,%esp
80106f43:	56                   	push   %esi
80106f44:	e8 17 ff ff ff       	call   80106e60 <freevm>
      return 0;
80106f49:	83 c4 10             	add    $0x10,%esp
    }
  return pgdir;
}
80106f4c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
80106f4f:	31 c0                	xor    %eax,%eax
    }
  return pgdir;
}
80106f51:	5b                   	pop    %ebx
80106f52:	5e                   	pop    %esi
80106f53:	5d                   	pop    %ebp
80106f54:	c3                   	ret    
80106f55:	8d 76 00             	lea    0x0(%esi),%esi
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80106f58:	31 c0                	xor    %eax,%eax
80106f5a:	eb d8                	jmp    80106f34 <setupkvm+0x54>
80106f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106f60 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80106f60:	55                   	push   %ebp
80106f61:	89 e5                	mov    %esp,%ebp
80106f63:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106f66:	e8 75 ff ff ff       	call   80106ee0 <setupkvm>
80106f6b:	a3 44 64 11 80       	mov    %eax,0x80116444
80106f70:	05 00 00 00 80       	add    $0x80000000,%eax
80106f75:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
80106f78:	c9                   	leave  
80106f79:	c3                   	ret    
80106f7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106f80 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106f80:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106f81:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106f83:	89 e5                	mov    %esp,%ebp
80106f85:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106f88:	8b 55 0c             	mov    0xc(%ebp),%edx
80106f8b:	8b 45 08             	mov    0x8(%ebp),%eax
80106f8e:	e8 7d f8 ff ff       	call   80106810 <walkpgdir>
  if(pte == 0)
80106f93:	85 c0                	test   %eax,%eax
80106f95:	74 05                	je     80106f9c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106f97:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106f9a:	c9                   	leave  
80106f9b:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80106f9c:	83 ec 0c             	sub    $0xc,%esp
80106f9f:	68 16 7b 10 80       	push   $0x80107b16
80106fa4:	e8 c7 93 ff ff       	call   80100370 <panic>
80106fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106fb0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106fb0:	55                   	push   %ebp
80106fb1:	89 e5                	mov    %esp,%ebp
80106fb3:	57                   	push   %edi
80106fb4:	56                   	push   %esi
80106fb5:	53                   	push   %ebx
80106fb6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106fb9:	e8 22 ff ff ff       	call   80106ee0 <setupkvm>
80106fbe:	85 c0                	test   %eax,%eax
80106fc0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106fc3:	0f 84 b2 00 00 00    	je     8010707b <copyuvm+0xcb>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106fc9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106fcc:	85 c9                	test   %ecx,%ecx
80106fce:	0f 84 9c 00 00 00    	je     80107070 <copyuvm+0xc0>
80106fd4:	31 f6                	xor    %esi,%esi
80106fd6:	eb 4a                	jmp    80107022 <copyuvm+0x72>
80106fd8:	90                   	nop
80106fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106fe0:	83 ec 04             	sub    $0x4,%esp
80106fe3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80106fe9:	68 00 10 00 00       	push   $0x1000
80106fee:	57                   	push   %edi
80106fef:	50                   	push   %eax
80106ff0:	e8 8b d6 ff ff       	call   80104680 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80106ff5:	58                   	pop    %eax
80106ff6:	5a                   	pop    %edx
80106ff7:	8d 93 00 00 00 80    	lea    -0x80000000(%ebx),%edx
80106ffd:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107000:	ff 75 e4             	pushl  -0x1c(%ebp)
80107003:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107008:	52                   	push   %edx
80107009:	89 f2                	mov    %esi,%edx
8010700b:	e8 80 f8 ff ff       	call   80106890 <mappages>
80107010:	83 c4 10             	add    $0x10,%esp
80107013:	85 c0                	test   %eax,%eax
80107015:	78 3e                	js     80107055 <copyuvm+0xa5>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107017:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010701d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107020:	76 4e                	jbe    80107070 <copyuvm+0xc0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107022:	8b 45 08             	mov    0x8(%ebp),%eax
80107025:	31 c9                	xor    %ecx,%ecx
80107027:	89 f2                	mov    %esi,%edx
80107029:	e8 e2 f7 ff ff       	call   80106810 <walkpgdir>
8010702e:	85 c0                	test   %eax,%eax
80107030:	74 5a                	je     8010708c <copyuvm+0xdc>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80107032:	8b 18                	mov    (%eax),%ebx
80107034:	f6 c3 01             	test   $0x1,%bl
80107037:	74 46                	je     8010707f <copyuvm+0xcf>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107039:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
8010703b:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
80107041:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107044:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
8010704a:	e8 01 b6 ff ff       	call   80102650 <kalloc>
8010704f:	85 c0                	test   %eax,%eax
80107051:	89 c3                	mov    %eax,%ebx
80107053:	75 8b                	jne    80106fe0 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
80107055:	83 ec 0c             	sub    $0xc,%esp
80107058:	ff 75 e0             	pushl  -0x20(%ebp)
8010705b:	e8 00 fe ff ff       	call   80106e60 <freevm>
  return 0;
80107060:	83 c4 10             	add    $0x10,%esp
80107063:	31 c0                	xor    %eax,%eax
}
80107065:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107068:	5b                   	pop    %ebx
80107069:	5e                   	pop    %esi
8010706a:	5f                   	pop    %edi
8010706b:	5d                   	pop    %ebp
8010706c:	c3                   	ret    
8010706d:	8d 76 00             	lea    0x0(%esi),%esi
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107070:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
80107073:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107076:	5b                   	pop    %ebx
80107077:	5e                   	pop    %esi
80107078:	5f                   	pop    %edi
80107079:	5d                   	pop    %ebp
8010707a:	c3                   	ret    
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
8010707b:	31 c0                	xor    %eax,%eax
8010707d:	eb e6                	jmp    80107065 <copyuvm+0xb5>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
8010707f:	83 ec 0c             	sub    $0xc,%esp
80107082:	68 3a 7b 10 80       	push   $0x80107b3a
80107087:	e8 e4 92 ff ff       	call   80100370 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010708c:	83 ec 0c             	sub    $0xc,%esp
8010708f:	68 20 7b 10 80       	push   $0x80107b20
80107094:	e8 d7 92 ff ff       	call   80100370 <panic>
80107099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801070a0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801070a0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801070a1:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801070a3:	89 e5                	mov    %esp,%ebp
801070a5:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801070a8:	8b 55 0c             	mov    0xc(%ebp),%edx
801070ab:	8b 45 08             	mov    0x8(%ebp),%eax
801070ae:	e8 5d f7 ff ff       	call   80106810 <walkpgdir>
  if((*pte & PTE_P) == 0)
801070b3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
801070b5:	89 c2                	mov    %eax,%edx
801070b7:	83 e2 05             	and    $0x5,%edx
801070ba:	83 fa 05             	cmp    $0x5,%edx
801070bd:	75 11                	jne    801070d0 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
801070bf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
801070c4:	c9                   	leave  
  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
801070c5:	05 00 00 00 80       	add    $0x80000000,%eax
}
801070ca:	c3                   	ret    
801070cb:	90                   	nop
801070cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
801070d0:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
801070d2:	c9                   	leave  
801070d3:	c3                   	ret    
801070d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801070da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801070e0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801070e0:	55                   	push   %ebp
801070e1:	89 e5                	mov    %esp,%ebp
801070e3:	57                   	push   %edi
801070e4:	56                   	push   %esi
801070e5:	53                   	push   %ebx
801070e6:	83 ec 1c             	sub    $0x1c,%esp
801070e9:	8b 5d 14             	mov    0x14(%ebp),%ebx
801070ec:	8b 55 0c             	mov    0xc(%ebp),%edx
801070ef:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801070f2:	85 db                	test   %ebx,%ebx
801070f4:	75 40                	jne    80107136 <copyout+0x56>
801070f6:	eb 70                	jmp    80107168 <copyout+0x88>
801070f8:	90                   	nop
801070f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107100:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107103:	89 f1                	mov    %esi,%ecx
80107105:	29 d1                	sub    %edx,%ecx
80107107:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010710d:	39 d9                	cmp    %ebx,%ecx
8010710f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107112:	29 f2                	sub    %esi,%edx
80107114:	83 ec 04             	sub    $0x4,%esp
80107117:	01 d0                	add    %edx,%eax
80107119:	51                   	push   %ecx
8010711a:	57                   	push   %edi
8010711b:	50                   	push   %eax
8010711c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010711f:	e8 5c d5 ff ff       	call   80104680 <memmove>
    len -= n;
    buf += n;
80107124:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107127:	83 c4 10             	add    $0x10,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
8010712a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
80107130:	01 cf                	add    %ecx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107132:	29 cb                	sub    %ecx,%ebx
80107134:	74 32                	je     80107168 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107136:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107138:	83 ec 08             	sub    $0x8,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
8010713b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010713e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107144:	56                   	push   %esi
80107145:	ff 75 08             	pushl  0x8(%ebp)
80107148:	e8 53 ff ff ff       	call   801070a0 <uva2ka>
    if(pa0 == 0)
8010714d:	83 c4 10             	add    $0x10,%esp
80107150:	85 c0                	test   %eax,%eax
80107152:	75 ac                	jne    80107100 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80107154:	8d 65 f4             	lea    -0xc(%ebp),%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
80107157:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
8010715c:	5b                   	pop    %ebx
8010715d:	5e                   	pop    %esi
8010715e:	5f                   	pop    %edi
8010715f:	5d                   	pop    %ebp
80107160:	c3                   	ret    
80107161:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107168:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
8010716b:	31 c0                	xor    %eax,%eax
}
8010716d:	5b                   	pop    %ebx
8010716e:	5e                   	pop    %esi
8010716f:	5f                   	pop    %edi
80107170:	5d                   	pop    %ebp
80107171:	c3                   	ret    
