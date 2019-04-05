
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
8010002d:	b8 60 30 10 80       	mov    $0x80103060,%eax
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
8010004c:	68 00 72 10 80       	push   $0x80107200
80100051:	68 60 c5 10 80       	push   $0x8010c560
80100056:	e8 55 43 00 00       	call   801043b0 <initlock>

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
80100092:	68 07 72 10 80       	push   $0x80107207
80100097:	50                   	push   %eax
80100098:	e8 03 42 00 00       	call   801042a0 <initsleeplock>
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
801000e4:	e8 c7 43 00 00       	call   801044b0 <acquire>

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
80100162:	e8 69 44 00 00       	call   801045d0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 6e 41 00 00       	call   801042e0 <acquiresleep>
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
8010017e:	e8 6d 21 00 00       	call   801022f0 <iderw>
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
80100193:	68 0e 72 10 80       	push   $0x8010720e
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
801001ae:	e8 cd 41 00 00       	call   80104380 <holdingsleep>
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
801001c4:	e9 27 21 00 00       	jmp    801022f0 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 1f 72 10 80       	push   $0x8010721f
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
801001ef:	e8 8c 41 00 00       	call   80104380 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 3c 41 00 00       	call   80104340 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 60 c5 10 80 	movl   $0x8010c560,(%esp)
8010020b:	e8 a0 42 00 00       	call   801044b0 <acquire>
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
8010025c:	e9 6f 43 00 00       	jmp    801045d0 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 26 72 10 80       	push   $0x80107226
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
80100280:	e8 cb 16 00 00       	call   80101950 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 c0 b4 10 80 	movl   $0x8010b4c0,(%esp)
8010028c:	e8 1f 42 00 00       	call   801044b0 <acquire>
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
801002bd:	e8 7e 3c 00 00       	call   80103f40 <sleep>

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
801002d2:	e8 a9 36 00 00       	call   80103980 <myproc>
801002d7:	8b 40 24             	mov    0x24(%eax),%eax
801002da:	85 c0                	test   %eax,%eax
801002dc:	74 d2                	je     801002b0 <consoleread+0x40>
        release(&cons.lock);
801002de:	83 ec 0c             	sub    $0xc,%esp
801002e1:	68 c0 b4 10 80       	push   $0x8010b4c0
801002e6:	e8 e5 42 00 00       	call   801045d0 <release>
        ilock(ip);
801002eb:	89 3c 24             	mov    %edi,(%esp)
801002ee:	e8 7d 15 00 00       	call   80101870 <ilock>
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
80100346:	e8 85 42 00 00       	call   801045d0 <release>
  ilock(ip);
8010034b:	89 3c 24             	mov    %edi,(%esp)
8010034e:	e8 1d 15 00 00       	call   80101870 <ilock>

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
80100389:	e8 62 25 00 00       	call   801028f0 <lapicid>
8010038e:	83 ec 08             	sub    $0x8,%esp
80100391:	50                   	push   %eax
80100392:	68 2d 72 10 80       	push   $0x8010722d
80100397:	e8 e4 02 00 00       	call   80100680 <cprintf>
  cprintf(s);
8010039c:	58                   	pop    %eax
8010039d:	ff 75 08             	pushl  0x8(%ebp)
801003a0:	e8 db 02 00 00       	call   80100680 <cprintf>
  cprintf("\n");
801003a5:	c7 04 24 87 7b 10 80 	movl   $0x80107b87,(%esp)
801003ac:	e8 cf 02 00 00       	call   80100680 <cprintf>
  getcallerpcs(&s, pcs);
801003b1:	5a                   	pop    %edx
801003b2:	8d 45 08             	lea    0x8(%ebp),%eax
801003b5:	59                   	pop    %ecx
801003b6:	53                   	push   %ebx
801003b7:	50                   	push   %eax
801003b8:	e8 13 40 00 00       	call   801043d0 <getcallerpcs>
801003bd:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003c0:	83 ec 08             	sub    $0x8,%esp
801003c3:	ff 33                	pushl  (%ebx)
801003c5:	83 c3 04             	add    $0x4,%ebx
801003c8:	68 41 72 10 80       	push   $0x80107241
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
8010041a:	e8 a1 59 00 00       	call   80105dc0 <uartputc>
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
801004e5:	e8 d6 58 00 00       	call   80105dc0 <uartputc>
801004ea:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f1:	e8 ca 58 00 00       	call   80105dc0 <uartputc>
801004f6:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004fd:	e8 be 58 00 00       	call   80105dc0 <uartputc>
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
80100544:	68 45 72 10 80       	push   $0x80107245
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
8010056a:	e8 61 41 00 00       	call   801046d0 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010056f:	b8 80 07 00 00       	mov    $0x780,%eax
80100574:	83 c4 0c             	add    $0xc,%esp
80100577:	29 d8                	sub    %ebx,%eax
80100579:	01 c0                	add    %eax,%eax
8010057b:	50                   	push   %eax
8010057c:	6a 00                	push   $0x0
8010057e:	56                   	push   %esi
8010057f:	e8 9c 40 00 00       	call   80104620 <memset>
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
801005d1:	0f b6 92 70 72 10 80 	movzbl -0x7fef8d90(%edx),%edx
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
8010062f:	e8 1c 13 00 00       	call   80101950 <iunlock>
  acquire(&cons.lock);
80100634:	c7 04 24 c0 b4 10 80 	movl   $0x8010b4c0,(%esp)
8010063b:	e8 70 3e 00 00       	call   801044b0 <acquire>
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
80100667:	e8 64 3f 00 00       	call   801045d0 <release>
  ilock(ip);
8010066c:	58                   	pop    %eax
8010066d:	ff 75 08             	pushl  0x8(%ebp)
80100670:	e8 fb 11 00 00       	call   80101870 <ilock>

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
8010072d:	e8 9e 3e 00 00       	call   801045d0 <release>
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
801007a8:	b8 58 72 10 80       	mov    $0x80107258,%eax
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
801007e8:	e8 c3 3c 00 00       	call   801044b0 <acquire>
801007ed:	83 c4 10             	add    $0x10,%esp
801007f0:	e9 a4 fe ff ff       	jmp    80100699 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
801007f5:	83 ec 0c             	sub    $0xc,%esp
801007f8:	68 5f 72 10 80       	push   $0x8010725f
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
8010081c:	e8 8f 3c 00 00       	call   801044b0 <acquire>
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
8010083e:	e8 8d 3d 00 00       	call   801045d0 <release>
  memmove(crtbackup, crt, sizeof(crt[0])*25*80);
80100843:	83 c4 0c             	add    $0xc,%esp
80100846:	68 a0 0f 00 00       	push   $0xfa0
8010084b:	68 00 80 0b 80       	push   $0x800b8000
80100850:	68 20 a5 10 80       	push   $0x8010a520
80100855:	e8 76 3e 00 00       	call   801046d0 <memmove>
  memset(crt, 0, sizeof(crt[0]) * 25 * 80);
8010085a:	83 c4 0c             	add    $0xc,%esp
8010085d:	68 a0 0f 00 00       	push   $0xfa0
80100862:	6a 00                	push   $0x0
80100864:	68 00 80 0b 80       	push   $0x800b8000
80100869:	e8 b2 3d 00 00       	call   80104620 <memset>
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
8010088d:	e8 3e 3d 00 00       	call   801045d0 <release>
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
801008ab:	e8 00 3c 00 00       	call   801044b0 <acquire>
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
801008d0:	e8 fb 3c 00 00       	call   801045d0 <release>
    memmove(crt, crtbackup, sizeof(crt[0])*25*80);
801008d5:	83 c4 0c             	add    $0xc,%esp
801008d8:	68 a0 0f 00 00       	push   $0xfa0
801008dd:	68 20 a5 10 80       	push   $0x8010a520
801008e2:	68 00 80 0b 80       	push   $0x800b8000
801008e7:	e8 e4 3d 00 00       	call   801046d0 <memmove>
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
80100900:	e8 cb 3c 00 00       	call   801045d0 <release>
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
80100915:	53                   	push   %ebx
80100916:	83 ec 04             	sub    $0x4,%esp
  if (pid != screencaptured) {
80100919:	8b 7d 08             	mov    0x8(%ebp),%edi
8010091c:	39 3d f8 b4 10 80    	cmp    %edi,0x8010b4f8
  }
  release(&cons.lock);
  return -1;
}
int
updatescreen(int pid, int x, int y, char* content, int color) {
80100922:	8b 45 10             	mov    0x10(%ebp),%eax
80100925:	8b 75 14             	mov    0x14(%ebp),%esi
  if (pid != screencaptured) {
80100928:	75 56                	jne    80100980 <updatescreen+0x70>
    return -1;
  }
  int initialpos = x + 80*y;
  char c;
  int i;
  for(i = 0; (c = content[i]) != 0; i++) {
8010092a:	0f b6 0e             	movzbl (%esi),%ecx
int
updatescreen(int pid, int x, int y, char* content, int color) {
  if (pid != screencaptured) {
    return -1;
  }
  int initialpos = x + 80*y;
8010092d:	8d 1c 80             	lea    (%eax,%eax,4),%ebx
80100930:	c1 e3 04             	shl    $0x4,%ebx
80100933:	03 5d 0c             	add    0xc(%ebp),%ebx
  char c;
  int i;
  for(i = 0; (c = content[i]) != 0; i++) {
80100936:	84 c9                	test   %cl,%cl
80100938:	74 4d                	je     80100987 <updatescreen+0x77>
8010093a:	0f b7 45 18          	movzwl 0x18(%ebp),%eax
8010093e:	bf 20 00 00 00       	mov    $0x20,%edi
80100943:	c1 e0 08             	shl    $0x8,%eax
80100946:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
8010094a:	31 c0                	xor    %eax,%eax
8010094c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100950:	80 f9 0a             	cmp    $0xa,%cl
80100953:	0f b6 d1             	movzbl %cl,%edx
    //Don't print out newline character, print out a space instead
    if(c == '\n'){
      c = ' ';
    }

    crt[initialpos + i] = (c&0xff) | (color<<8);
80100956:	8d 0c 03             	lea    (%ebx,%eax,1),%ecx
80100959:	0f 44 d7             	cmove  %edi,%edx
8010095c:	66 0b 55 f2          	or     -0xe(%ebp),%dx
    return -1;
  }
  int initialpos = x + 80*y;
  char c;
  int i;
  for(i = 0; (c = content[i]) != 0; i++) {
80100960:	83 c0 01             	add    $0x1,%eax
    //Don't print out newline character, print out a space instead
    if(c == '\n'){
      c = ' ';
    }

    crt[initialpos + i] = (c&0xff) | (color<<8);
80100963:	66 89 94 09 00 80 0b 	mov    %dx,-0x7ff48000(%ecx,%ecx,1)
8010096a:	80 
    return -1;
  }
  int initialpos = x + 80*y;
  char c;
  int i;
  for(i = 0; (c = content[i]) != 0; i++) {
8010096b:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
8010096f:	84 c9                	test   %cl,%cl
80100971:	75 dd                	jne    80100950 <updatescreen+0x40>
    }

    crt[initialpos + i] = (c&0xff) | (color<<8);
  }
  return i;
}
80100973:	83 c4 04             	add    $0x4,%esp
80100976:	5b                   	pop    %ebx
80100977:	5e                   	pop    %esi
80100978:	5f                   	pop    %edi
80100979:	5d                   	pop    %ebp
8010097a:	c3                   	ret    
8010097b:	90                   	nop
8010097c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return -1;
}
int
updatescreen(int pid, int x, int y, char* content, int color) {
  if (pid != screencaptured) {
    return -1;
80100980:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100985:	eb ec                	jmp    80100973 <updatescreen+0x63>
  }
  int initialpos = x + 80*y;
  char c;
  int i;
  for(i = 0; (c = content[i]) != 0; i++) {
80100987:	31 c0                	xor    %eax,%eax
80100989:	eb e8                	jmp    80100973 <updatescreen+0x63>
8010098b:	90                   	nop
8010098c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100990 <consoleintr>:
// C('A') == Control-A
#define C(x) (x - '@')

void
consoleintr(int (*getc)(void))
{
80100990:	55                   	push   %ebp
80100991:	89 e5                	mov    %esp,%ebp
80100993:	57                   	push   %edi
80100994:	56                   	push   %esi
80100995:	53                   	push   %ebx
80100996:	83 ec 0c             	sub    $0xc,%esp
  int c, doprocdump = 0;
  

  if (screencaptured != 0) {
80100999:	a1 f8 b4 10 80       	mov    0x8010b4f8,%eax
// C('A') == Control-A
#define C(x) (x - '@')

void
consoleintr(int (*getc)(void))
{
8010099e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c, doprocdump = 0;
  

  if (screencaptured != 0) {
801009a1:	85 c0                	test   %eax,%eax
801009a3:	75 21                	jne    801009c6 <consoleintr+0x36>
801009a5:	eb 31                	jmp    801009d8 <consoleintr+0x48>
801009a7:	89 f6                	mov    %esi,%esi
801009a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    while((c = getc()) >= 0) {
      buffer = c;
      cprintf("%d\n", c);
801009b0:	83 ec 08             	sub    $0x8,%esp
  int c, doprocdump = 0;
  

  if (screencaptured != 0) {
    while((c = getc()) >= 0) {
      buffer = c;
801009b3:	a3 4c 0f 11 80       	mov    %eax,0x80110f4c
      cprintf("%d\n", c);
801009b8:	50                   	push   %eax
801009b9:	68 f4 76 10 80       	push   $0x801076f4
801009be:	e8 bd fc ff ff       	call   80100680 <cprintf>
801009c3:	83 c4 10             	add    $0x10,%esp
{
  int c, doprocdump = 0;
  

  if (screencaptured != 0) {
    while((c = getc()) >= 0) {
801009c6:	ff d3                	call   *%ebx
801009c8:	85 c0                	test   %eax,%eax
801009ca:	79 e4                	jns    801009b0 <consoleintr+0x20>
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
801009cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801009cf:	5b                   	pop    %ebx
801009d0:	5e                   	pop    %esi
801009d1:	5f                   	pop    %edi
801009d2:	5d                   	pop    %ebp
801009d3:	c3                   	ret    
801009d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      cprintf("%d\n", c);
    }
    return;
  }

  acquire(&cons.lock);
801009d8:	83 ec 0c             	sub    $0xc,%esp
#define C(x) (x - '@')

void
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;
801009db:	31 f6                	xor    %esi,%esi
      cprintf("%d\n", c);
    }
    return;
  }

  acquire(&cons.lock);
801009dd:	68 c0 b4 10 80       	push   $0x8010b4c0
801009e2:	e8 c9 3a 00 00       	call   801044b0 <acquire>
  while((c = getc()) >= 0){
801009e7:	83 c4 10             	add    $0x10,%esp
801009ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801009f0:	ff d3                	call   *%ebx
801009f2:	85 c0                	test   %eax,%eax
801009f4:	89 c7                	mov    %eax,%edi
801009f6:	78 48                	js     80100a40 <consoleintr+0xb0>
    switch(c){
801009f8:	83 ff 10             	cmp    $0x10,%edi
801009fb:	0f 84 3f 01 00 00    	je     80100b40 <consoleintr+0x1b0>
80100a01:	7e 65                	jle    80100a68 <consoleintr+0xd8>
80100a03:	83 ff 15             	cmp    $0x15,%edi
80100a06:	0f 84 e4 00 00 00    	je     80100af0 <consoleintr+0x160>
80100a0c:	83 ff 7f             	cmp    $0x7f,%edi
80100a0f:	75 5c                	jne    80100a6d <consoleintr+0xdd>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100a11:	a1 48 0f 11 80       	mov    0x80110f48,%eax
80100a16:	3b 05 44 0f 11 80    	cmp    0x80110f44,%eax
80100a1c:	74 d2                	je     801009f0 <consoleintr+0x60>
        input.e--;
80100a1e:	83 e8 01             	sub    $0x1,%eax
80100a21:	a3 48 0f 11 80       	mov    %eax,0x80110f48
        consputc(BACKSPACE);
80100a26:	b8 00 01 00 00       	mov    $0x100,%eax
80100a2b:	e8 c0 f9 ff ff       	call   801003f0 <consputc>
    }
    return;
  }

  acquire(&cons.lock);
  while((c = getc()) >= 0){
80100a30:	ff d3                	call   *%ebx
80100a32:	85 c0                	test   %eax,%eax
80100a34:	89 c7                	mov    %eax,%edi
80100a36:	79 c0                	jns    801009f8 <consoleintr+0x68>
80100a38:	90                   	nop
80100a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100a40:	83 ec 0c             	sub    $0xc,%esp
80100a43:	68 c0 b4 10 80       	push   $0x8010b4c0
80100a48:	e8 83 3b 00 00       	call   801045d0 <release>
  if(doprocdump) {
80100a4d:	83 c4 10             	add    $0x10,%esp
80100a50:	85 f6                	test   %esi,%esi
80100a52:	0f 84 74 ff ff ff    	je     801009cc <consoleintr+0x3c>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100a58:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a5b:	5b                   	pop    %ebx
80100a5c:	5e                   	pop    %esi
80100a5d:	5f                   	pop    %edi
80100a5e:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
80100a5f:	e9 7c 37 00 00       	jmp    801041e0 <procdump>
80100a64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return;
  }

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
80100a68:	83 ff 08             	cmp    $0x8,%edi
80100a6b:	74 a4                	je     80100a11 <consoleintr+0x81>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100a6d:	85 ff                	test   %edi,%edi
80100a6f:	0f 84 7b ff ff ff    	je     801009f0 <consoleintr+0x60>
80100a75:	a1 48 0f 11 80       	mov    0x80110f48,%eax
80100a7a:	89 c2                	mov    %eax,%edx
80100a7c:	2b 15 40 0f 11 80    	sub    0x80110f40,%edx
80100a82:	83 fa 7f             	cmp    $0x7f,%edx
80100a85:	0f 87 65 ff ff ff    	ja     801009f0 <consoleintr+0x60>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
80100a8b:	8d 50 01             	lea    0x1(%eax),%edx
80100a8e:	83 e0 7f             	and    $0x7f,%eax
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
80100a91:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
80100a94:	89 15 48 0f 11 80    	mov    %edx,0x80110f48
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
80100a9a:	0f 84 aa 00 00 00    	je     80100b4a <consoleintr+0x1ba>
        input.buf[input.e++ % INPUT_BUF] = c;
80100aa0:	89 f9                	mov    %edi,%ecx
80100aa2:	88 88 c0 0e 11 80    	mov    %cl,-0x7feef140(%eax)
        consputc(c);
80100aa8:	89 f8                	mov    %edi,%eax
80100aaa:	e8 41 f9 ff ff       	call   801003f0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100aaf:	83 ff 0a             	cmp    $0xa,%edi
80100ab2:	0f 84 a3 00 00 00    	je     80100b5b <consoleintr+0x1cb>
80100ab8:	83 ff 04             	cmp    $0x4,%edi
80100abb:	0f 84 9a 00 00 00    	je     80100b5b <consoleintr+0x1cb>
80100ac1:	a1 40 0f 11 80       	mov    0x80110f40,%eax
80100ac6:	83 e8 80             	sub    $0xffffff80,%eax
80100ac9:	39 05 48 0f 11 80    	cmp    %eax,0x80110f48
80100acf:	0f 85 1b ff ff ff    	jne    801009f0 <consoleintr+0x60>
          input.w = input.e;
          wakeup(&input.r);
80100ad5:	83 ec 0c             	sub    $0xc,%esp
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
80100ad8:	a3 44 0f 11 80       	mov    %eax,0x80110f44
          wakeup(&input.r);
80100add:	68 40 0f 11 80       	push   $0x80110f40
80100ae2:	e8 09 36 00 00       	call   801040f0 <wakeup>
80100ae7:	83 c4 10             	add    $0x10,%esp
80100aea:	e9 01 ff ff ff       	jmp    801009f0 <consoleintr+0x60>
80100aef:	90                   	nop
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100af0:	a1 48 0f 11 80       	mov    0x80110f48,%eax
80100af5:	39 05 44 0f 11 80    	cmp    %eax,0x80110f44
80100afb:	75 2b                	jne    80100b28 <consoleintr+0x198>
80100afd:	e9 ee fe ff ff       	jmp    801009f0 <consoleintr+0x60>
80100b02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100b08:	a3 48 0f 11 80       	mov    %eax,0x80110f48
        consputc(BACKSPACE);
80100b0d:	b8 00 01 00 00       	mov    $0x100,%eax
80100b12:	e8 d9 f8 ff ff       	call   801003f0 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100b17:	a1 48 0f 11 80       	mov    0x80110f48,%eax
80100b1c:	3b 05 44 0f 11 80    	cmp    0x80110f44,%eax
80100b22:	0f 84 c8 fe ff ff    	je     801009f0 <consoleintr+0x60>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100b28:	83 e8 01             	sub    $0x1,%eax
80100b2b:	89 c2                	mov    %eax,%edx
80100b2d:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100b30:	80 ba c0 0e 11 80 0a 	cmpb   $0xa,-0x7feef140(%edx)
80100b37:	75 cf                	jne    80100b08 <consoleintr+0x178>
80100b39:	e9 b2 fe ff ff       	jmp    801009f0 <consoleintr+0x60>
80100b3e:	66 90                	xchg   %ax,%ax
  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
80100b40:	be 01 00 00 00       	mov    $0x1,%esi
80100b45:	e9 a6 fe ff ff       	jmp    801009f0 <consoleintr+0x60>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
80100b4a:	c6 80 c0 0e 11 80 0a 	movb   $0xa,-0x7feef140(%eax)
        consputc(c);
80100b51:	b8 0a 00 00 00       	mov    $0xa,%eax
80100b56:	e8 95 f8 ff ff       	call   801003f0 <consputc>
80100b5b:	a1 48 0f 11 80       	mov    0x80110f48,%eax
80100b60:	e9 70 ff ff ff       	jmp    80100ad5 <consoleintr+0x145>
80100b65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100b70 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
80100b70:	55                   	push   %ebp
80100b71:	89 e5                	mov    %esp,%ebp
80100b73:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100b76:	68 68 72 10 80       	push   $0x80107268
80100b7b:	68 c0 b4 10 80       	push   $0x8010b4c0
80100b80:	e8 2b 38 00 00       	call   801043b0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100b85:	58                   	pop    %eax
80100b86:	5a                   	pop    %edx
80100b87:	6a 00                	push   $0x0
80100b89:	6a 01                	push   $0x1
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
80100b8b:	c7 05 0c 19 11 80 20 	movl   $0x80100620,0x8011190c
80100b92:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100b95:	c7 05 08 19 11 80 70 	movl   $0x80100270,0x80111908
80100b9c:	02 10 80 
  cons.locking = 1;
80100b9f:	c7 05 f4 b4 10 80 01 	movl   $0x1,0x8010b4f4
80100ba6:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
80100ba9:	e8 f2 18 00 00       	call   801024a0 <ioapicenable>
}
80100bae:	83 c4 10             	add    $0x10,%esp
80100bb1:	c9                   	leave  
80100bb2:	c3                   	ret    
80100bb3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100bc0 <readkey>:

int
readkey(int pid)
{
80100bc0:	55                   	push   %ebp
80100bc1:	89 e5                	mov    %esp,%ebp
  if (pid != screencaptured)
80100bc3:	8b 45 08             	mov    0x8(%ebp),%eax
80100bc6:	39 05 f8 b4 10 80    	cmp    %eax,0x8010b4f8
80100bcc:	75 12                	jne    80100be0 <readkey+0x20>
    return -1;

  int temp = buffer;
80100bce:	a1 4c 0f 11 80       	mov    0x80110f4c,%eax
  buffer = 0;
80100bd3:	c7 05 4c 0f 11 80 00 	movl   $0x0,0x80110f4c
80100bda:	00 00 00 
  return temp;
80100bdd:	5d                   	pop    %ebp
80100bde:	c3                   	ret    
80100bdf:	90                   	nop

int
readkey(int pid)
{
  if (pid != screencaptured)
    return -1;
80100be0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax

  int temp = buffer;
  buffer = 0;
  return temp;
80100be5:	5d                   	pop    %ebp
80100be6:	c3                   	ret    
80100be7:	66 90                	xchg   %ax,%ax
80100be9:	66 90                	xchg   %ax,%ax
80100beb:	66 90                	xchg   %ax,%ax
80100bed:	66 90                	xchg   %ax,%ax
80100bef:	90                   	nop

80100bf0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100bf0:	55                   	push   %ebp
80100bf1:	89 e5                	mov    %esp,%ebp
80100bf3:	57                   	push   %edi
80100bf4:	56                   	push   %esi
80100bf5:	53                   	push   %ebx
80100bf6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100bfc:	e8 7f 2d 00 00       	call   80103980 <myproc>
80100c01:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100c07:	e8 44 21 00 00       	call   80102d50 <begin_op>

  if((ip = namei(path)) == 0){
80100c0c:	83 ec 0c             	sub    $0xc,%esp
80100c0f:	ff 75 08             	pushl  0x8(%ebp)
80100c12:	e8 a9 14 00 00       	call   801020c0 <namei>
80100c17:	83 c4 10             	add    $0x10,%esp
80100c1a:	85 c0                	test   %eax,%eax
80100c1c:	0f 84 9c 01 00 00    	je     80100dbe <exec+0x1ce>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100c22:	83 ec 0c             	sub    $0xc,%esp
80100c25:	89 c3                	mov    %eax,%ebx
80100c27:	50                   	push   %eax
80100c28:	e8 43 0c 00 00       	call   80101870 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100c2d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100c33:	6a 34                	push   $0x34
80100c35:	6a 00                	push   $0x0
80100c37:	50                   	push   %eax
80100c38:	53                   	push   %ebx
80100c39:	e8 12 0f 00 00       	call   80101b50 <readi>
80100c3e:	83 c4 20             	add    $0x20,%esp
80100c41:	83 f8 34             	cmp    $0x34,%eax
80100c44:	74 22                	je     80100c68 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100c46:	83 ec 0c             	sub    $0xc,%esp
80100c49:	53                   	push   %ebx
80100c4a:	e8 b1 0e 00 00       	call   80101b00 <iunlockput>
    end_op();
80100c4f:	e8 6c 21 00 00       	call   80102dc0 <end_op>
80100c54:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100c57:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100c5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100c5f:	5b                   	pop    %ebx
80100c60:	5e                   	pop    %esi
80100c61:	5f                   	pop    %edi
80100c62:	5d                   	pop    %ebp
80100c63:	c3                   	ret    
80100c64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100c68:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100c6f:	45 4c 46 
80100c72:	75 d2                	jne    80100c46 <exec+0x56>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100c74:	e8 d7 62 00 00       	call   80106f50 <setupkvm>
80100c79:	85 c0                	test   %eax,%eax
80100c7b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100c81:	74 c3                	je     80100c46 <exec+0x56>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c83:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100c8a:	00 
80100c8b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100c91:	c7 85 ec fe ff ff 00 	movl   $0x0,-0x114(%ebp)
80100c98:	00 00 00 
80100c9b:	0f 84 c5 00 00 00    	je     80100d66 <exec+0x176>
80100ca1:	31 ff                	xor    %edi,%edi
80100ca3:	eb 18                	jmp    80100cbd <exec+0xcd>
80100ca5:	8d 76 00             	lea    0x0(%esi),%esi
80100ca8:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100caf:	83 c7 01             	add    $0x1,%edi
80100cb2:	83 c6 20             	add    $0x20,%esi
80100cb5:	39 f8                	cmp    %edi,%eax
80100cb7:	0f 8e a9 00 00 00    	jle    80100d66 <exec+0x176>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100cbd:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100cc3:	6a 20                	push   $0x20
80100cc5:	56                   	push   %esi
80100cc6:	50                   	push   %eax
80100cc7:	53                   	push   %ebx
80100cc8:	e8 83 0e 00 00       	call   80101b50 <readi>
80100ccd:	83 c4 10             	add    $0x10,%esp
80100cd0:	83 f8 20             	cmp    $0x20,%eax
80100cd3:	75 7b                	jne    80100d50 <exec+0x160>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100cd5:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100cdc:	75 ca                	jne    80100ca8 <exec+0xb8>
      continue;
    if(ph.memsz < ph.filesz)
80100cde:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ce4:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100cea:	72 64                	jb     80100d50 <exec+0x160>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100cec:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100cf2:	72 5c                	jb     80100d50 <exec+0x160>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100cf4:	83 ec 04             	sub    $0x4,%esp
80100cf7:	50                   	push   %eax
80100cf8:	ff b5 ec fe ff ff    	pushl  -0x114(%ebp)
80100cfe:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100d04:	e8 97 60 00 00       	call   80106da0 <allocuvm>
80100d09:	83 c4 10             	add    $0x10,%esp
80100d0c:	85 c0                	test   %eax,%eax
80100d0e:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100d14:	74 3a                	je     80100d50 <exec+0x160>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100d16:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100d1c:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100d21:	75 2d                	jne    80100d50 <exec+0x160>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100d23:	83 ec 0c             	sub    $0xc,%esp
80100d26:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100d2c:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100d32:	53                   	push   %ebx
80100d33:	50                   	push   %eax
80100d34:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100d3a:	e8 a1 5f 00 00       	call   80106ce0 <loaduvm>
80100d3f:	83 c4 20             	add    $0x20,%esp
80100d42:	85 c0                	test   %eax,%eax
80100d44:	0f 89 5e ff ff ff    	jns    80100ca8 <exec+0xb8>
80100d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100d50:	83 ec 0c             	sub    $0xc,%esp
80100d53:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100d59:	e8 72 61 00 00       	call   80106ed0 <freevm>
80100d5e:	83 c4 10             	add    $0x10,%esp
80100d61:	e9 e0 fe ff ff       	jmp    80100c46 <exec+0x56>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100d66:	83 ec 0c             	sub    $0xc,%esp
80100d69:	53                   	push   %ebx
80100d6a:	e8 91 0d 00 00       	call   80101b00 <iunlockput>
  end_op();
80100d6f:	e8 4c 20 00 00       	call   80102dc0 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100d74:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d7a:	83 c4 0c             	add    $0xc,%esp
  end_op();
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100d7d:	05 ff 0f 00 00       	add    $0xfff,%eax
80100d82:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d87:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100d8d:	52                   	push   %edx
80100d8e:	50                   	push   %eax
80100d8f:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100d95:	e8 06 60 00 00       	call   80106da0 <allocuvm>
80100d9a:	83 c4 10             	add    $0x10,%esp
80100d9d:	85 c0                	test   %eax,%eax
80100d9f:	89 c6                	mov    %eax,%esi
80100da1:	75 3a                	jne    80100ddd <exec+0x1ed>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100da3:	83 ec 0c             	sub    $0xc,%esp
80100da6:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100dac:	e8 1f 61 00 00       	call   80106ed0 <freevm>
80100db1:	83 c4 10             	add    $0x10,%esp
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100db4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100db9:	e9 9e fe ff ff       	jmp    80100c5c <exec+0x6c>
  struct proc *curproc = myproc();

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
80100dbe:	e8 fd 1f 00 00       	call   80102dc0 <end_op>
    cprintf("exec: fail\n");
80100dc3:	83 ec 0c             	sub    $0xc,%esp
80100dc6:	68 81 72 10 80       	push   $0x80107281
80100dcb:	e8 b0 f8 ff ff       	call   80100680 <cprintf>
    return -1;
80100dd0:	83 c4 10             	add    $0x10,%esp
80100dd3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100dd8:	e9 7f fe ff ff       	jmp    80100c5c <exec+0x6c>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100ddd:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100de3:	83 ec 08             	sub    $0x8,%esp
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100de6:	31 ff                	xor    %edi,%edi
80100de8:	89 f3                	mov    %esi,%ebx
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100dea:	50                   	push   %eax
80100deb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100df1:	e8 fa 61 00 00       	call   80106ff0 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100df6:	8b 45 0c             	mov    0xc(%ebp),%eax
80100df9:	83 c4 10             	add    $0x10,%esp
80100dfc:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100e02:	8b 00                	mov    (%eax),%eax
80100e04:	85 c0                	test   %eax,%eax
80100e06:	74 79                	je     80100e81 <exec+0x291>
80100e08:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100e0e:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100e14:	eb 13                	jmp    80100e29 <exec+0x239>
80100e16:	8d 76 00             	lea    0x0(%esi),%esi
80100e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(argc >= MAXARG)
80100e20:	83 ff 20             	cmp    $0x20,%edi
80100e23:	0f 84 7a ff ff ff    	je     80100da3 <exec+0x1b3>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100e29:	83 ec 0c             	sub    $0xc,%esp
80100e2c:	50                   	push   %eax
80100e2d:	e8 2e 3a 00 00       	call   80104860 <strlen>
80100e32:	f7 d0                	not    %eax
80100e34:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100e36:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e39:	5a                   	pop    %edx

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100e3a:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100e3d:	ff 34 b8             	pushl  (%eax,%edi,4)
80100e40:	e8 1b 3a 00 00       	call   80104860 <strlen>
80100e45:	83 c0 01             	add    $0x1,%eax
80100e48:	50                   	push   %eax
80100e49:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e4c:	ff 34 b8             	pushl  (%eax,%edi,4)
80100e4f:	53                   	push   %ebx
80100e50:	56                   	push   %esi
80100e51:	e8 fa 62 00 00       	call   80107150 <copyout>
80100e56:	83 c4 20             	add    $0x20,%esp
80100e59:	85 c0                	test   %eax,%eax
80100e5b:	0f 88 42 ff ff ff    	js     80100da3 <exec+0x1b3>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100e61:	8b 45 0c             	mov    0xc(%ebp),%eax
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100e64:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100e6b:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100e6e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100e74:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100e77:	85 c0                	test   %eax,%eax
80100e79:	75 a5                	jne    80100e20 <exec+0x230>
80100e7b:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e81:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100e88:	89 d9                	mov    %ebx,%ecx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100e8a:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100e91:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100e95:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100e9c:	ff ff ff 
  ustack[1] = argc;
80100e9f:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100ea5:	29 c1                	sub    %eax,%ecx

  sp -= (3+argc+1) * 4;
80100ea7:	83 c0 0c             	add    $0xc,%eax
80100eaa:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100eac:	50                   	push   %eax
80100ead:	52                   	push   %edx
80100eae:	53                   	push   %ebx
80100eaf:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100eb5:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100ebb:	e8 90 62 00 00       	call   80107150 <copyout>
80100ec0:	83 c4 10             	add    $0x10,%esp
80100ec3:	85 c0                	test   %eax,%eax
80100ec5:	0f 88 d8 fe ff ff    	js     80100da3 <exec+0x1b3>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ecb:	8b 45 08             	mov    0x8(%ebp),%eax
80100ece:	0f b6 10             	movzbl (%eax),%edx
80100ed1:	84 d2                	test   %dl,%dl
80100ed3:	74 19                	je     80100eee <exec+0x2fe>
80100ed5:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100ed8:	83 c0 01             	add    $0x1,%eax
    if(*s == '/')
      last = s+1;
80100edb:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ede:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
80100ee1:	0f 44 c8             	cmove  %eax,%ecx
80100ee4:	83 c0 01             	add    $0x1,%eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ee7:	84 d2                	test   %dl,%dl
80100ee9:	75 f0                	jne    80100edb <exec+0x2eb>
80100eeb:	89 4d 08             	mov    %ecx,0x8(%ebp)
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100eee:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100ef4:	50                   	push   %eax
80100ef5:	6a 10                	push   $0x10
80100ef7:	ff 75 08             	pushl  0x8(%ebp)
80100efa:	89 f8                	mov    %edi,%eax
80100efc:	83 c0 6c             	add    $0x6c,%eax
80100eff:	50                   	push   %eax
80100f00:	e8 1b 39 00 00       	call   80104820 <safestrcpy>

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100f05:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100f0b:	89 f8                	mov    %edi,%eax
80100f0d:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->pgdir = pgdir;
  curproc->sz = sz;
80100f10:	89 30                	mov    %esi,(%eax)
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100f12:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->sz = sz;
  curproc->tf->eip = elf.entry;  // main
80100f15:	89 c1                	mov    %eax,%ecx
80100f17:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100f1d:	8b 40 18             	mov    0x18(%eax),%eax
80100f20:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100f23:	8b 41 18             	mov    0x18(%ecx),%eax
80100f26:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100f29:	89 0c 24             	mov    %ecx,(%esp)
80100f2c:	e8 1f 5c 00 00       	call   80106b50 <switchuvm>
  freevm(oldpgdir);
80100f31:	89 3c 24             	mov    %edi,(%esp)
80100f34:	e8 97 5f 00 00       	call   80106ed0 <freevm>
  return 0;
80100f39:	83 c4 10             	add    $0x10,%esp
80100f3c:	31 c0                	xor    %eax,%eax
80100f3e:	e9 19 fd ff ff       	jmp    80100c5c <exec+0x6c>
80100f43:	66 90                	xchg   %ax,%ax
80100f45:	66 90                	xchg   %ax,%ax
80100f47:	66 90                	xchg   %ax,%ax
80100f49:	66 90                	xchg   %ax,%ax
80100f4b:	66 90                	xchg   %ax,%ax
80100f4d:	66 90                	xchg   %ax,%ax
80100f4f:	90                   	nop

80100f50 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100f50:	55                   	push   %ebp
80100f51:	89 e5                	mov    %esp,%ebp
80100f53:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100f56:	68 8d 72 10 80       	push   $0x8010728d
80100f5b:	68 60 0f 11 80       	push   $0x80110f60
80100f60:	e8 4b 34 00 00       	call   801043b0 <initlock>
}
80100f65:	83 c4 10             	add    $0x10,%esp
80100f68:	c9                   	leave  
80100f69:	c3                   	ret    
80100f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100f70 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f70:	55                   	push   %ebp
80100f71:	89 e5                	mov    %esp,%ebp
80100f73:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f74:	bb 94 0f 11 80       	mov    $0x80110f94,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f79:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
80100f7c:	68 60 0f 11 80       	push   $0x80110f60
80100f81:	e8 2a 35 00 00       	call   801044b0 <acquire>
80100f86:	83 c4 10             	add    $0x10,%esp
80100f89:	eb 10                	jmp    80100f9b <filealloc+0x2b>
80100f8b:	90                   	nop
80100f8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f90:	83 c3 18             	add    $0x18,%ebx
80100f93:	81 fb f4 18 11 80    	cmp    $0x801118f4,%ebx
80100f99:	74 25                	je     80100fc0 <filealloc+0x50>
    if(f->ref == 0){
80100f9b:	8b 43 04             	mov    0x4(%ebx),%eax
80100f9e:	85 c0                	test   %eax,%eax
80100fa0:	75 ee                	jne    80100f90 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100fa2:	83 ec 0c             	sub    $0xc,%esp
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
80100fa5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100fac:	68 60 0f 11 80       	push   $0x80110f60
80100fb1:	e8 1a 36 00 00       	call   801045d0 <release>
      return f;
80100fb6:	89 d8                	mov    %ebx,%eax
80100fb8:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ftable.lock);
  return 0;
}
80100fbb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fbe:	c9                   	leave  
80100fbf:	c3                   	ret    
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100fc0:	83 ec 0c             	sub    $0xc,%esp
80100fc3:	68 60 0f 11 80       	push   $0x80110f60
80100fc8:	e8 03 36 00 00       	call   801045d0 <release>
  return 0;
80100fcd:	83 c4 10             	add    $0x10,%esp
80100fd0:	31 c0                	xor    %eax,%eax
}
80100fd2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fd5:	c9                   	leave  
80100fd6:	c3                   	ret    
80100fd7:	89 f6                	mov    %esi,%esi
80100fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100fe0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100fe0:	55                   	push   %ebp
80100fe1:	89 e5                	mov    %esp,%ebp
80100fe3:	53                   	push   %ebx
80100fe4:	83 ec 10             	sub    $0x10,%esp
80100fe7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100fea:	68 60 0f 11 80       	push   $0x80110f60
80100fef:	e8 bc 34 00 00       	call   801044b0 <acquire>
  if(f->ref < 1)
80100ff4:	8b 43 04             	mov    0x4(%ebx),%eax
80100ff7:	83 c4 10             	add    $0x10,%esp
80100ffa:	85 c0                	test   %eax,%eax
80100ffc:	7e 1a                	jle    80101018 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100ffe:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101001:	83 ec 0c             	sub    $0xc,%esp
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  f->ref++;
80101004:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80101007:	68 60 0f 11 80       	push   $0x80110f60
8010100c:	e8 bf 35 00 00       	call   801045d0 <release>
  return f;
}
80101011:	89 d8                	mov    %ebx,%eax
80101013:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101016:	c9                   	leave  
80101017:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80101018:	83 ec 0c             	sub    $0xc,%esp
8010101b:	68 94 72 10 80       	push   $0x80107294
80101020:	e8 4b f3 ff ff       	call   80100370 <panic>
80101025:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101030 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101030:	55                   	push   %ebp
80101031:	89 e5                	mov    %esp,%ebp
80101033:	57                   	push   %edi
80101034:	56                   	push   %esi
80101035:	53                   	push   %ebx
80101036:	83 ec 28             	sub    $0x28,%esp
80101039:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
8010103c:	68 60 0f 11 80       	push   $0x80110f60
80101041:	e8 6a 34 00 00       	call   801044b0 <acquire>
  if(f->ref < 1)
80101046:	8b 47 04             	mov    0x4(%edi),%eax
80101049:	83 c4 10             	add    $0x10,%esp
8010104c:	85 c0                	test   %eax,%eax
8010104e:	0f 8e 9b 00 00 00    	jle    801010ef <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80101054:	83 e8 01             	sub    $0x1,%eax
80101057:	85 c0                	test   %eax,%eax
80101059:	89 47 04             	mov    %eax,0x4(%edi)
8010105c:	74 1a                	je     80101078 <fileclose+0x48>
    release(&ftable.lock);
8010105e:	c7 45 08 60 0f 11 80 	movl   $0x80110f60,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80101065:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101068:	5b                   	pop    %ebx
80101069:	5e                   	pop    %esi
8010106a:	5f                   	pop    %edi
8010106b:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
8010106c:	e9 5f 35 00 00       	jmp    801045d0 <release>
80101071:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
80101078:	0f b6 47 09          	movzbl 0x9(%edi),%eax
8010107c:	8b 1f                	mov    (%edi),%ebx
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
8010107e:	83 ec 0c             	sub    $0xc,%esp
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80101081:	8b 77 0c             	mov    0xc(%edi),%esi
  f->ref = 0;
  f->type = FD_NONE;
80101084:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
8010108a:	88 45 e7             	mov    %al,-0x19(%ebp)
8010108d:	8b 47 10             	mov    0x10(%edi),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101090:	68 60 0f 11 80       	push   $0x80110f60
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80101095:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101098:	e8 33 35 00 00       	call   801045d0 <release>

  if(ff.type == FD_PIPE)
8010109d:	83 c4 10             	add    $0x10,%esp
801010a0:	83 fb 01             	cmp    $0x1,%ebx
801010a3:	74 13                	je     801010b8 <fileclose+0x88>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
801010a5:	83 fb 02             	cmp    $0x2,%ebx
801010a8:	74 26                	je     801010d0 <fileclose+0xa0>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
801010aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010ad:	5b                   	pop    %ebx
801010ae:	5e                   	pop    %esi
801010af:	5f                   	pop    %edi
801010b0:	5d                   	pop    %ebp
801010b1:	c3                   	ret    
801010b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
801010b8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
801010bc:	83 ec 08             	sub    $0x8,%esp
801010bf:	53                   	push   %ebx
801010c0:	56                   	push   %esi
801010c1:	e8 2a 24 00 00       	call   801034f0 <pipeclose>
801010c6:	83 c4 10             	add    $0x10,%esp
801010c9:	eb df                	jmp    801010aa <fileclose+0x7a>
801010cb:	90                   	nop
801010cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if(ff.type == FD_INODE){
    begin_op();
801010d0:	e8 7b 1c 00 00       	call   80102d50 <begin_op>
    iput(ff.ip);
801010d5:	83 ec 0c             	sub    $0xc,%esp
801010d8:	ff 75 e0             	pushl  -0x20(%ebp)
801010db:	e8 c0 08 00 00       	call   801019a0 <iput>
    end_op();
801010e0:	83 c4 10             	add    $0x10,%esp
  }
}
801010e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010e6:	5b                   	pop    %ebx
801010e7:	5e                   	pop    %esi
801010e8:	5f                   	pop    %edi
801010e9:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
801010ea:	e9 d1 1c 00 00       	jmp    80102dc0 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
801010ef:	83 ec 0c             	sub    $0xc,%esp
801010f2:	68 9c 72 10 80       	push   $0x8010729c
801010f7:	e8 74 f2 ff ff       	call   80100370 <panic>
801010fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101100 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101100:	55                   	push   %ebp
80101101:	89 e5                	mov    %esp,%ebp
80101103:	53                   	push   %ebx
80101104:	83 ec 04             	sub    $0x4,%esp
80101107:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010110a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010110d:	75 31                	jne    80101140 <filestat+0x40>
    ilock(f->ip);
8010110f:	83 ec 0c             	sub    $0xc,%esp
80101112:	ff 73 10             	pushl  0x10(%ebx)
80101115:	e8 56 07 00 00       	call   80101870 <ilock>
    stati(f->ip, st);
8010111a:	58                   	pop    %eax
8010111b:	5a                   	pop    %edx
8010111c:	ff 75 0c             	pushl  0xc(%ebp)
8010111f:	ff 73 10             	pushl  0x10(%ebx)
80101122:	e8 f9 09 00 00       	call   80101b20 <stati>
    iunlock(f->ip);
80101127:	59                   	pop    %ecx
80101128:	ff 73 10             	pushl  0x10(%ebx)
8010112b:	e8 20 08 00 00       	call   80101950 <iunlock>
    return 0;
80101130:	83 c4 10             	add    $0x10,%esp
80101133:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80101135:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101138:	c9                   	leave  
80101139:	c3                   	ret    
8010113a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80101140:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101145:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101148:	c9                   	leave  
80101149:	c3                   	ret    
8010114a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101150 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101150:	55                   	push   %ebp
80101151:	89 e5                	mov    %esp,%ebp
80101153:	57                   	push   %edi
80101154:	56                   	push   %esi
80101155:	53                   	push   %ebx
80101156:	83 ec 0c             	sub    $0xc,%esp
80101159:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010115c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010115f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101162:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101166:	74 60                	je     801011c8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101168:	8b 03                	mov    (%ebx),%eax
8010116a:	83 f8 01             	cmp    $0x1,%eax
8010116d:	74 41                	je     801011b0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010116f:	83 f8 02             	cmp    $0x2,%eax
80101172:	75 5b                	jne    801011cf <fileread+0x7f>
    ilock(f->ip);
80101174:	83 ec 0c             	sub    $0xc,%esp
80101177:	ff 73 10             	pushl  0x10(%ebx)
8010117a:	e8 f1 06 00 00       	call   80101870 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010117f:	57                   	push   %edi
80101180:	ff 73 14             	pushl  0x14(%ebx)
80101183:	56                   	push   %esi
80101184:	ff 73 10             	pushl  0x10(%ebx)
80101187:	e8 c4 09 00 00       	call   80101b50 <readi>
8010118c:	83 c4 20             	add    $0x20,%esp
8010118f:	85 c0                	test   %eax,%eax
80101191:	89 c6                	mov    %eax,%esi
80101193:	7e 03                	jle    80101198 <fileread+0x48>
      f->off += r;
80101195:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101198:	83 ec 0c             	sub    $0xc,%esp
8010119b:	ff 73 10             	pushl  0x10(%ebx)
8010119e:	e8 ad 07 00 00       	call   80101950 <iunlock>
    return r;
801011a3:	83 c4 10             	add    $0x10,%esp
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801011a6:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
801011a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011ab:	5b                   	pop    %ebx
801011ac:	5e                   	pop    %esi
801011ad:	5f                   	pop    %edi
801011ae:	5d                   	pop    %ebp
801011af:	c3                   	ret    
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
801011b0:	8b 43 0c             	mov    0xc(%ebx),%eax
801011b3:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
801011b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011b9:	5b                   	pop    %ebx
801011ba:	5e                   	pop    %esi
801011bb:	5f                   	pop    %edi
801011bc:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
801011bd:	e9 ce 24 00 00       	jmp    80103690 <piperead>
801011c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
801011c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801011cd:	eb d9                	jmp    801011a8 <fileread+0x58>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
801011cf:	83 ec 0c             	sub    $0xc,%esp
801011d2:	68 a6 72 10 80       	push   $0x801072a6
801011d7:	e8 94 f1 ff ff       	call   80100370 <panic>
801011dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801011e0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801011e0:	55                   	push   %ebp
801011e1:	89 e5                	mov    %esp,%ebp
801011e3:	57                   	push   %edi
801011e4:	56                   	push   %esi
801011e5:	53                   	push   %ebx
801011e6:	83 ec 1c             	sub    $0x1c,%esp
801011e9:	8b 75 08             	mov    0x8(%ebp),%esi
801011ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
801011ef:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801011f3:	89 45 dc             	mov    %eax,-0x24(%ebp)
801011f6:	8b 45 10             	mov    0x10(%ebp),%eax
801011f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
801011fc:	0f 84 aa 00 00 00    	je     801012ac <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101202:	8b 06                	mov    (%esi),%eax
80101204:	83 f8 01             	cmp    $0x1,%eax
80101207:	0f 84 c2 00 00 00    	je     801012cf <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010120d:	83 f8 02             	cmp    $0x2,%eax
80101210:	0f 85 d8 00 00 00    	jne    801012ee <filewrite+0x10e>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101216:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101219:	31 ff                	xor    %edi,%edi
8010121b:	85 c0                	test   %eax,%eax
8010121d:	7f 34                	jg     80101253 <filewrite+0x73>
8010121f:	e9 9c 00 00 00       	jmp    801012c0 <filewrite+0xe0>
80101224:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101228:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010122b:	83 ec 0c             	sub    $0xc,%esp
8010122e:	ff 76 10             	pushl  0x10(%esi)
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101231:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101234:	e8 17 07 00 00       	call   80101950 <iunlock>
      end_op();
80101239:	e8 82 1b 00 00       	call   80102dc0 <end_op>
8010123e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101241:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101244:	39 d8                	cmp    %ebx,%eax
80101246:	0f 85 95 00 00 00    	jne    801012e1 <filewrite+0x101>
        panic("short filewrite");
      i += r;
8010124c:	01 c7                	add    %eax,%edi
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
8010124e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101251:	7e 6d                	jle    801012c0 <filewrite+0xe0>
      int n1 = n - i;
80101253:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101256:	b8 00 06 00 00       	mov    $0x600,%eax
8010125b:	29 fb                	sub    %edi,%ebx
8010125d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101263:	0f 4f d8             	cmovg  %eax,%ebx
      if(n1 > max)
        n1 = max;

      begin_op();
80101266:	e8 e5 1a 00 00       	call   80102d50 <begin_op>
      ilock(f->ip);
8010126b:	83 ec 0c             	sub    $0xc,%esp
8010126e:	ff 76 10             	pushl  0x10(%esi)
80101271:	e8 fa 05 00 00       	call   80101870 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101276:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101279:	53                   	push   %ebx
8010127a:	ff 76 14             	pushl  0x14(%esi)
8010127d:	01 f8                	add    %edi,%eax
8010127f:	50                   	push   %eax
80101280:	ff 76 10             	pushl  0x10(%esi)
80101283:	e8 c8 09 00 00       	call   80101c50 <writei>
80101288:	83 c4 20             	add    $0x20,%esp
8010128b:	85 c0                	test   %eax,%eax
8010128d:	7f 99                	jg     80101228 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
8010128f:	83 ec 0c             	sub    $0xc,%esp
80101292:	ff 76 10             	pushl  0x10(%esi)
80101295:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101298:	e8 b3 06 00 00       	call   80101950 <iunlock>
      end_op();
8010129d:	e8 1e 1b 00 00       	call   80102dc0 <end_op>

      if(r < 0)
801012a2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801012a5:	83 c4 10             	add    $0x10,%esp
801012a8:	85 c0                	test   %eax,%eax
801012aa:	74 98                	je     80101244 <filewrite+0x64>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801012ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801012af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
801012b4:	5b                   	pop    %ebx
801012b5:	5e                   	pop    %esi
801012b6:	5f                   	pop    %edi
801012b7:	5d                   	pop    %ebp
801012b8:	c3                   	ret    
801012b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801012c0:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
801012c3:	75 e7                	jne    801012ac <filewrite+0xcc>
  }
  panic("filewrite");
}
801012c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012c8:	89 f8                	mov    %edi,%eax
801012ca:	5b                   	pop    %ebx
801012cb:	5e                   	pop    %esi
801012cc:	5f                   	pop    %edi
801012cd:	5d                   	pop    %ebp
801012ce:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801012cf:	8b 46 0c             	mov    0xc(%esi),%eax
801012d2:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801012d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012d8:	5b                   	pop    %ebx
801012d9:	5e                   	pop    %esi
801012da:	5f                   	pop    %edi
801012db:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801012dc:	e9 af 22 00 00       	jmp    80103590 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
801012e1:	83 ec 0c             	sub    $0xc,%esp
801012e4:	68 af 72 10 80       	push   $0x801072af
801012e9:	e8 82 f0 ff ff       	call   80100370 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
801012ee:	83 ec 0c             	sub    $0xc,%esp
801012f1:	68 b5 72 10 80       	push   $0x801072b5
801012f6:	e8 75 f0 ff ff       	call   80100370 <panic>
801012fb:	66 90                	xchg   %ax,%ax
801012fd:	66 90                	xchg   %ax,%ax
801012ff:	90                   	nop

80101300 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101300:	55                   	push   %ebp
80101301:	89 e5                	mov    %esp,%ebp
80101303:	57                   	push   %edi
80101304:	56                   	push   %esi
80101305:	53                   	push   %ebx
80101306:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101309:	8b 0d 60 19 11 80    	mov    0x80111960,%ecx
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
8010130f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101312:	85 c9                	test   %ecx,%ecx
80101314:	0f 84 85 00 00 00    	je     8010139f <balloc+0x9f>
8010131a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101321:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101324:	83 ec 08             	sub    $0x8,%esp
80101327:	89 f0                	mov    %esi,%eax
80101329:	c1 f8 0c             	sar    $0xc,%eax
8010132c:	03 05 78 19 11 80    	add    0x80111978,%eax
80101332:	50                   	push   %eax
80101333:	ff 75 d8             	pushl  -0x28(%ebp)
80101336:	e8 95 ed ff ff       	call   801000d0 <bread>
8010133b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010133e:	a1 60 19 11 80       	mov    0x80111960,%eax
80101343:	83 c4 10             	add    $0x10,%esp
80101346:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101349:	31 c0                	xor    %eax,%eax
8010134b:	eb 2d                	jmp    8010137a <balloc+0x7a>
8010134d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101350:	89 c1                	mov    %eax,%ecx
80101352:	ba 01 00 00 00       	mov    $0x1,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101357:	8b 5d e4             	mov    -0x1c(%ebp),%ebx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
8010135a:	83 e1 07             	and    $0x7,%ecx
8010135d:	d3 e2                	shl    %cl,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010135f:	89 c1                	mov    %eax,%ecx
80101361:	c1 f9 03             	sar    $0x3,%ecx
80101364:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
80101369:	85 d7                	test   %edx,%edi
8010136b:	74 43                	je     801013b0 <balloc+0xb0>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010136d:	83 c0 01             	add    $0x1,%eax
80101370:	83 c6 01             	add    $0x1,%esi
80101373:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101378:	74 05                	je     8010137f <balloc+0x7f>
8010137a:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010137d:	72 d1                	jb     80101350 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
8010137f:	83 ec 0c             	sub    $0xc,%esp
80101382:	ff 75 e4             	pushl  -0x1c(%ebp)
80101385:	e8 56 ee ff ff       	call   801001e0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
8010138a:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101391:	83 c4 10             	add    $0x10,%esp
80101394:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101397:	39 05 60 19 11 80    	cmp    %eax,0x80111960
8010139d:	77 82                	ja     80101321 <balloc+0x21>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
8010139f:	83 ec 0c             	sub    $0xc,%esp
801013a2:	68 bf 72 10 80       	push   $0x801072bf
801013a7:	e8 c4 ef ff ff       	call   80100370 <panic>
801013ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
801013b0:	09 fa                	or     %edi,%edx
801013b2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801013b5:	83 ec 0c             	sub    $0xc,%esp
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
801013b8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801013bc:	57                   	push   %edi
801013bd:	e8 6e 1b 00 00       	call   80102f30 <log_write>
        brelse(bp);
801013c2:	89 3c 24             	mov    %edi,(%esp)
801013c5:	e8 16 ee ff ff       	call   801001e0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
801013ca:	58                   	pop    %eax
801013cb:	5a                   	pop    %edx
801013cc:	56                   	push   %esi
801013cd:	ff 75 d8             	pushl  -0x28(%ebp)
801013d0:	e8 fb ec ff ff       	call   801000d0 <bread>
801013d5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801013d7:	8d 40 5c             	lea    0x5c(%eax),%eax
801013da:	83 c4 0c             	add    $0xc,%esp
801013dd:	68 00 02 00 00       	push   $0x200
801013e2:	6a 00                	push   $0x0
801013e4:	50                   	push   %eax
801013e5:	e8 36 32 00 00       	call   80104620 <memset>
  log_write(bp);
801013ea:	89 1c 24             	mov    %ebx,(%esp)
801013ed:	e8 3e 1b 00 00       	call   80102f30 <log_write>
  brelse(bp);
801013f2:	89 1c 24             	mov    %ebx,(%esp)
801013f5:	e8 e6 ed ff ff       	call   801001e0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
801013fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013fd:	89 f0                	mov    %esi,%eax
801013ff:	5b                   	pop    %ebx
80101400:	5e                   	pop    %esi
80101401:	5f                   	pop    %edi
80101402:	5d                   	pop    %ebp
80101403:	c3                   	ret    
80101404:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010140a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101410 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101410:	55                   	push   %ebp
80101411:	89 e5                	mov    %esp,%ebp
80101413:	57                   	push   %edi
80101414:	56                   	push   %esi
80101415:	53                   	push   %ebx
80101416:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101418:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010141a:	bb b4 19 11 80       	mov    $0x801119b4,%ebx
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
8010141f:	83 ec 28             	sub    $0x28,%esp
80101422:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101425:	68 80 19 11 80       	push   $0x80111980
8010142a:	e8 81 30 00 00       	call   801044b0 <acquire>
8010142f:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101432:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101435:	eb 1b                	jmp    80101452 <iget+0x42>
80101437:	89 f6                	mov    %esi,%esi
80101439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101440:	85 f6                	test   %esi,%esi
80101442:	74 44                	je     80101488 <iget+0x78>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101444:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010144a:	81 fb d4 35 11 80    	cmp    $0x801135d4,%ebx
80101450:	74 4e                	je     801014a0 <iget+0x90>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101452:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101455:	85 c9                	test   %ecx,%ecx
80101457:	7e e7                	jle    80101440 <iget+0x30>
80101459:	39 3b                	cmp    %edi,(%ebx)
8010145b:	75 e3                	jne    80101440 <iget+0x30>
8010145d:	39 53 04             	cmp    %edx,0x4(%ebx)
80101460:	75 de                	jne    80101440 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
80101462:	83 ec 0c             	sub    $0xc,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
80101465:	83 c1 01             	add    $0x1,%ecx
      release(&icache.lock);
      return ip;
80101468:	89 de                	mov    %ebx,%esi
  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
8010146a:	68 80 19 11 80       	push   $0x80111980

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
8010146f:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101472:	e8 59 31 00 00       	call   801045d0 <release>
      return ip;
80101477:	83 c4 10             	add    $0x10,%esp
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
8010147a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010147d:	89 f0                	mov    %esi,%eax
8010147f:	5b                   	pop    %ebx
80101480:	5e                   	pop    %esi
80101481:	5f                   	pop    %edi
80101482:	5d                   	pop    %ebp
80101483:	c3                   	ret    
80101484:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101488:	85 c9                	test   %ecx,%ecx
8010148a:	0f 44 f3             	cmove  %ebx,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010148d:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101493:	81 fb d4 35 11 80    	cmp    $0x801135d4,%ebx
80101499:	75 b7                	jne    80101452 <iget+0x42>
8010149b:	90                   	nop
8010149c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801014a0:	85 f6                	test   %esi,%esi
801014a2:	74 2d                	je     801014d1 <iget+0xc1>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801014a4:	83 ec 0c             	sub    $0xc,%esp
  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
801014a7:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801014a9:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801014ac:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801014b3:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801014ba:	68 80 19 11 80       	push   $0x80111980
801014bf:	e8 0c 31 00 00       	call   801045d0 <release>

  return ip;
801014c4:	83 c4 10             	add    $0x10,%esp
}
801014c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014ca:	89 f0                	mov    %esi,%eax
801014cc:	5b                   	pop    %ebx
801014cd:	5e                   	pop    %esi
801014ce:	5f                   	pop    %edi
801014cf:	5d                   	pop    %ebp
801014d0:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
801014d1:	83 ec 0c             	sub    $0xc,%esp
801014d4:	68 d5 72 10 80       	push   $0x801072d5
801014d9:	e8 92 ee ff ff       	call   80100370 <panic>
801014de:	66 90                	xchg   %ax,%ax

801014e0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801014e0:	55                   	push   %ebp
801014e1:	89 e5                	mov    %esp,%ebp
801014e3:	57                   	push   %edi
801014e4:	56                   	push   %esi
801014e5:	53                   	push   %ebx
801014e6:	89 c6                	mov    %eax,%esi
801014e8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801014eb:	83 fa 0b             	cmp    $0xb,%edx
801014ee:	77 18                	ja     80101508 <bmap+0x28>
801014f0:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
    if((addr = ip->addrs[bn]) == 0)
801014f3:	8b 43 5c             	mov    0x5c(%ebx),%eax
801014f6:	85 c0                	test   %eax,%eax
801014f8:	74 76                	je     80101570 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801014fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014fd:	5b                   	pop    %ebx
801014fe:	5e                   	pop    %esi
801014ff:	5f                   	pop    %edi
80101500:	5d                   	pop    %ebp
80101501:	c3                   	ret    
80101502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101508:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
8010150b:	83 fb 7f             	cmp    $0x7f,%ebx
8010150e:	0f 87 83 00 00 00    	ja     80101597 <bmap+0xb7>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101514:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
8010151a:	85 c0                	test   %eax,%eax
8010151c:	74 6a                	je     80101588 <bmap+0xa8>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010151e:	83 ec 08             	sub    $0x8,%esp
80101521:	50                   	push   %eax
80101522:	ff 36                	pushl  (%esi)
80101524:	e8 a7 eb ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101529:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010152d:	83 c4 10             	add    $0x10,%esp

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101530:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101532:	8b 1a                	mov    (%edx),%ebx
80101534:	85 db                	test   %ebx,%ebx
80101536:	75 1d                	jne    80101555 <bmap+0x75>
      a[bn] = addr = balloc(ip->dev);
80101538:	8b 06                	mov    (%esi),%eax
8010153a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010153d:	e8 be fd ff ff       	call   80101300 <balloc>
80101542:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101545:	83 ec 0c             	sub    $0xc,%esp
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
80101548:	89 c3                	mov    %eax,%ebx
8010154a:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010154c:	57                   	push   %edi
8010154d:	e8 de 19 00 00       	call   80102f30 <log_write>
80101552:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101555:	83 ec 0c             	sub    $0xc,%esp
80101558:	57                   	push   %edi
80101559:	e8 82 ec ff ff       	call   801001e0 <brelse>
8010155e:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101561:	8d 65 f4             	lea    -0xc(%ebp),%esp
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101564:	89 d8                	mov    %ebx,%eax
    return addr;
  }

  panic("bmap: out of range");
}
80101566:	5b                   	pop    %ebx
80101567:	5e                   	pop    %esi
80101568:	5f                   	pop    %edi
80101569:	5d                   	pop    %ebp
8010156a:	c3                   	ret    
8010156b:	90                   	nop
8010156c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80101570:	8b 06                	mov    (%esi),%eax
80101572:	e8 89 fd ff ff       	call   80101300 <balloc>
80101577:	89 43 5c             	mov    %eax,0x5c(%ebx)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010157a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010157d:	5b                   	pop    %ebx
8010157e:	5e                   	pop    %esi
8010157f:	5f                   	pop    %edi
80101580:	5d                   	pop    %ebp
80101581:	c3                   	ret    
80101582:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101588:	8b 06                	mov    (%esi),%eax
8010158a:	e8 71 fd ff ff       	call   80101300 <balloc>
8010158f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101595:	eb 87                	jmp    8010151e <bmap+0x3e>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
80101597:	83 ec 0c             	sub    $0xc,%esp
8010159a:	68 e5 72 10 80       	push   $0x801072e5
8010159f:	e8 cc ed ff ff       	call   80100370 <panic>
801015a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801015aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801015b0 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
801015b0:	55                   	push   %ebp
801015b1:	89 e5                	mov    %esp,%ebp
801015b3:	56                   	push   %esi
801015b4:	53                   	push   %ebx
801015b5:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
801015b8:	83 ec 08             	sub    $0x8,%esp
801015bb:	6a 01                	push   $0x1
801015bd:	ff 75 08             	pushl  0x8(%ebp)
801015c0:	e8 0b eb ff ff       	call   801000d0 <bread>
801015c5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801015c7:	8d 40 5c             	lea    0x5c(%eax),%eax
801015ca:	83 c4 0c             	add    $0xc,%esp
801015cd:	6a 1c                	push   $0x1c
801015cf:	50                   	push   %eax
801015d0:	56                   	push   %esi
801015d1:	e8 fa 30 00 00       	call   801046d0 <memmove>
  brelse(bp);
801015d6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801015d9:	83 c4 10             	add    $0x10,%esp
}
801015dc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801015df:	5b                   	pop    %ebx
801015e0:	5e                   	pop    %esi
801015e1:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
801015e2:	e9 f9 eb ff ff       	jmp    801001e0 <brelse>
801015e7:	89 f6                	mov    %esi,%esi
801015e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801015f0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801015f0:	55                   	push   %ebp
801015f1:	89 e5                	mov    %esp,%ebp
801015f3:	56                   	push   %esi
801015f4:	53                   	push   %ebx
801015f5:	89 d3                	mov    %edx,%ebx
801015f7:	89 c6                	mov    %eax,%esi
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
801015f9:	83 ec 08             	sub    $0x8,%esp
801015fc:	68 60 19 11 80       	push   $0x80111960
80101601:	50                   	push   %eax
80101602:	e8 a9 ff ff ff       	call   801015b0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101607:	58                   	pop    %eax
80101608:	5a                   	pop    %edx
80101609:	89 da                	mov    %ebx,%edx
8010160b:	c1 ea 0c             	shr    $0xc,%edx
8010160e:	03 15 78 19 11 80    	add    0x80111978,%edx
80101614:	52                   	push   %edx
80101615:	56                   	push   %esi
80101616:	e8 b5 ea ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010161b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010161d:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101623:	ba 01 00 00 00       	mov    $0x1,%edx
80101628:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
8010162b:	c1 fb 03             	sar    $0x3,%ebx
8010162e:	83 c4 10             	add    $0x10,%esp
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101631:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101633:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101638:	85 d1                	test   %edx,%ecx
8010163a:	74 27                	je     80101663 <bfree+0x73>
8010163c:	89 c6                	mov    %eax,%esi
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010163e:	f7 d2                	not    %edx
80101640:	89 c8                	mov    %ecx,%eax
  log_write(bp);
80101642:	83 ec 0c             	sub    $0xc,%esp
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101645:	21 d0                	and    %edx,%eax
80101647:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010164b:	56                   	push   %esi
8010164c:	e8 df 18 00 00       	call   80102f30 <log_write>
  brelse(bp);
80101651:	89 34 24             	mov    %esi,(%esp)
80101654:	e8 87 eb ff ff       	call   801001e0 <brelse>
}
80101659:	83 c4 10             	add    $0x10,%esp
8010165c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010165f:	5b                   	pop    %ebx
80101660:	5e                   	pop    %esi
80101661:	5d                   	pop    %ebp
80101662:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
80101663:	83 ec 0c             	sub    $0xc,%esp
80101666:	68 f8 72 10 80       	push   $0x801072f8
8010166b:	e8 00 ed ff ff       	call   80100370 <panic>

80101670 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101670:	55                   	push   %ebp
80101671:	89 e5                	mov    %esp,%ebp
80101673:	53                   	push   %ebx
80101674:	bb c0 19 11 80       	mov    $0x801119c0,%ebx
80101679:	83 ec 0c             	sub    $0xc,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
8010167c:	68 0b 73 10 80       	push   $0x8010730b
80101681:	68 80 19 11 80       	push   $0x80111980
80101686:	e8 25 2d 00 00       	call   801043b0 <initlock>
8010168b:	83 c4 10             	add    $0x10,%esp
8010168e:	66 90                	xchg   %ax,%ax
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
80101690:	83 ec 08             	sub    $0x8,%esp
80101693:	68 12 73 10 80       	push   $0x80107312
80101698:	53                   	push   %ebx
80101699:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010169f:	e8 fc 2b 00 00       	call   801042a0 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
801016a4:	83 c4 10             	add    $0x10,%esp
801016a7:	81 fb e0 35 11 80    	cmp    $0x801135e0,%ebx
801016ad:	75 e1                	jne    80101690 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }

  readsb(dev, &sb);
801016af:	83 ec 08             	sub    $0x8,%esp
801016b2:	68 60 19 11 80       	push   $0x80111960
801016b7:	ff 75 08             	pushl  0x8(%ebp)
801016ba:	e8 f1 fe ff ff       	call   801015b0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801016bf:	ff 35 78 19 11 80    	pushl  0x80111978
801016c5:	ff 35 74 19 11 80    	pushl  0x80111974
801016cb:	ff 35 70 19 11 80    	pushl  0x80111970
801016d1:	ff 35 6c 19 11 80    	pushl  0x8011196c
801016d7:	ff 35 68 19 11 80    	pushl  0x80111968
801016dd:	ff 35 64 19 11 80    	pushl  0x80111964
801016e3:	ff 35 60 19 11 80    	pushl  0x80111960
801016e9:	68 78 73 10 80       	push   $0x80107378
801016ee:	e8 8d ef ff ff       	call   80100680 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
801016f3:	83 c4 30             	add    $0x30,%esp
801016f6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801016f9:	c9                   	leave  
801016fa:	c3                   	ret    
801016fb:	90                   	nop
801016fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101700 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101700:	55                   	push   %ebp
80101701:	89 e5                	mov    %esp,%ebp
80101703:	57                   	push   %edi
80101704:	56                   	push   %esi
80101705:	53                   	push   %ebx
80101706:	83 ec 1c             	sub    $0x1c,%esp
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101709:	83 3d 68 19 11 80 01 	cmpl   $0x1,0x80111968
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101710:	8b 45 0c             	mov    0xc(%ebp),%eax
80101713:	8b 75 08             	mov    0x8(%ebp),%esi
80101716:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101719:	0f 86 91 00 00 00    	jbe    801017b0 <ialloc+0xb0>
8010171f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101724:	eb 21                	jmp    80101747 <ialloc+0x47>
80101726:	8d 76 00             	lea    0x0(%esi),%esi
80101729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101730:	83 ec 0c             	sub    $0xc,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101733:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101736:	57                   	push   %edi
80101737:	e8 a4 ea ff ff       	call   801001e0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010173c:	83 c4 10             	add    $0x10,%esp
8010173f:	39 1d 68 19 11 80    	cmp    %ebx,0x80111968
80101745:	76 69                	jbe    801017b0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101747:	89 d8                	mov    %ebx,%eax
80101749:	83 ec 08             	sub    $0x8,%esp
8010174c:	c1 e8 03             	shr    $0x3,%eax
8010174f:	03 05 74 19 11 80    	add    0x80111974,%eax
80101755:	50                   	push   %eax
80101756:	56                   	push   %esi
80101757:	e8 74 e9 ff ff       	call   801000d0 <bread>
8010175c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010175e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101760:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
80101763:	83 e0 07             	and    $0x7,%eax
80101766:	c1 e0 06             	shl    $0x6,%eax
80101769:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010176d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101771:	75 bd                	jne    80101730 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101773:	83 ec 04             	sub    $0x4,%esp
80101776:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101779:	6a 40                	push   $0x40
8010177b:	6a 00                	push   $0x0
8010177d:	51                   	push   %ecx
8010177e:	e8 9d 2e 00 00       	call   80104620 <memset>
      dip->type = type;
80101783:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101787:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010178a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010178d:	89 3c 24             	mov    %edi,(%esp)
80101790:	e8 9b 17 00 00       	call   80102f30 <log_write>
      brelse(bp);
80101795:	89 3c 24             	mov    %edi,(%esp)
80101798:	e8 43 ea ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
8010179d:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801017a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801017a3:	89 da                	mov    %ebx,%edx
801017a5:	89 f0                	mov    %esi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801017a7:	5b                   	pop    %ebx
801017a8:	5e                   	pop    %esi
801017a9:	5f                   	pop    %edi
801017aa:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801017ab:	e9 60 fc ff ff       	jmp    80101410 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
801017b0:	83 ec 0c             	sub    $0xc,%esp
801017b3:	68 18 73 10 80       	push   $0x80107318
801017b8:	e8 b3 eb ff ff       	call   80100370 <panic>
801017bd:	8d 76 00             	lea    0x0(%esi),%esi

801017c0 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
801017c0:	55                   	push   %ebp
801017c1:	89 e5                	mov    %esp,%ebp
801017c3:	56                   	push   %esi
801017c4:	53                   	push   %ebx
801017c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017c8:	83 ec 08             	sub    $0x8,%esp
801017cb:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017ce:	83 c3 5c             	add    $0x5c,%ebx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017d1:	c1 e8 03             	shr    $0x3,%eax
801017d4:	03 05 74 19 11 80    	add    0x80111974,%eax
801017da:	50                   	push   %eax
801017db:	ff 73 a4             	pushl  -0x5c(%ebx)
801017de:	e8 ed e8 ff ff       	call   801000d0 <bread>
801017e3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801017e5:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
801017e8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017ec:	83 c4 0c             	add    $0xc,%esp
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801017ef:	83 e0 07             	and    $0x7,%eax
801017f2:	c1 e0 06             	shl    $0x6,%eax
801017f5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801017f9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801017fc:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101800:	83 c0 0c             	add    $0xc,%eax
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
80101803:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101807:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010180b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010180f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101813:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101817:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010181a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010181d:	6a 34                	push   $0x34
8010181f:	53                   	push   %ebx
80101820:	50                   	push   %eax
80101821:	e8 aa 2e 00 00       	call   801046d0 <memmove>
  log_write(bp);
80101826:	89 34 24             	mov    %esi,(%esp)
80101829:	e8 02 17 00 00       	call   80102f30 <log_write>
  brelse(bp);
8010182e:	89 75 08             	mov    %esi,0x8(%ebp)
80101831:	83 c4 10             	add    $0x10,%esp
}
80101834:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101837:	5b                   	pop    %ebx
80101838:	5e                   	pop    %esi
80101839:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
8010183a:	e9 a1 e9 ff ff       	jmp    801001e0 <brelse>
8010183f:	90                   	nop

80101840 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101840:	55                   	push   %ebp
80101841:	89 e5                	mov    %esp,%ebp
80101843:	53                   	push   %ebx
80101844:	83 ec 10             	sub    $0x10,%esp
80101847:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010184a:	68 80 19 11 80       	push   $0x80111980
8010184f:	e8 5c 2c 00 00       	call   801044b0 <acquire>
  ip->ref++;
80101854:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101858:	c7 04 24 80 19 11 80 	movl   $0x80111980,(%esp)
8010185f:	e8 6c 2d 00 00       	call   801045d0 <release>
  return ip;
}
80101864:	89 d8                	mov    %ebx,%eax
80101866:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101869:	c9                   	leave  
8010186a:	c3                   	ret    
8010186b:	90                   	nop
8010186c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101870 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101870:	55                   	push   %ebp
80101871:	89 e5                	mov    %esp,%ebp
80101873:	56                   	push   %esi
80101874:	53                   	push   %ebx
80101875:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101878:	85 db                	test   %ebx,%ebx
8010187a:	0f 84 b7 00 00 00    	je     80101937 <ilock+0xc7>
80101880:	8b 53 08             	mov    0x8(%ebx),%edx
80101883:	85 d2                	test   %edx,%edx
80101885:	0f 8e ac 00 00 00    	jle    80101937 <ilock+0xc7>
    panic("ilock");

  acquiresleep(&ip->lock);
8010188b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010188e:	83 ec 0c             	sub    $0xc,%esp
80101891:	50                   	push   %eax
80101892:	e8 49 2a 00 00       	call   801042e0 <acquiresleep>

  if(ip->valid == 0){
80101897:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010189a:	83 c4 10             	add    $0x10,%esp
8010189d:	85 c0                	test   %eax,%eax
8010189f:	74 0f                	je     801018b0 <ilock+0x40>
    brelse(bp);
    ip->valid = 1;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
801018a1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801018a4:	5b                   	pop    %ebx
801018a5:	5e                   	pop    %esi
801018a6:	5d                   	pop    %ebp
801018a7:	c3                   	ret    
801018a8:	90                   	nop
801018a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801018b0:	8b 43 04             	mov    0x4(%ebx),%eax
801018b3:	83 ec 08             	sub    $0x8,%esp
801018b6:	c1 e8 03             	shr    $0x3,%eax
801018b9:	03 05 74 19 11 80    	add    0x80111974,%eax
801018bf:	50                   	push   %eax
801018c0:	ff 33                	pushl  (%ebx)
801018c2:	e8 09 e8 ff ff       	call   801000d0 <bread>
801018c7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801018c9:	8b 43 04             	mov    0x4(%ebx),%eax
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801018cc:	83 c4 0c             	add    $0xc,%esp

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801018cf:	83 e0 07             	and    $0x7,%eax
801018d2:	c1 e0 06             	shl    $0x6,%eax
801018d5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801018d9:	0f b7 10             	movzwl (%eax),%edx
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801018dc:	83 c0 0c             	add    $0xc,%eax
  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
801018df:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801018e3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801018e7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801018eb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801018ef:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801018f3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801018f7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801018fb:	8b 50 fc             	mov    -0x4(%eax),%edx
801018fe:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101901:	6a 34                	push   $0x34
80101903:	50                   	push   %eax
80101904:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101907:	50                   	push   %eax
80101908:	e8 c3 2d 00 00       	call   801046d0 <memmove>
    brelse(bp);
8010190d:	89 34 24             	mov    %esi,(%esp)
80101910:	e8 cb e8 ff ff       	call   801001e0 <brelse>
    ip->valid = 1;
    if(ip->type == 0)
80101915:	83 c4 10             	add    $0x10,%esp
80101918:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    brelse(bp);
    ip->valid = 1;
8010191d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101924:	0f 85 77 ff ff ff    	jne    801018a1 <ilock+0x31>
      panic("ilock: no type");
8010192a:	83 ec 0c             	sub    $0xc,%esp
8010192d:	68 30 73 10 80       	push   $0x80107330
80101932:	e8 39 ea ff ff       	call   80100370 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
80101937:	83 ec 0c             	sub    $0xc,%esp
8010193a:	68 2a 73 10 80       	push   $0x8010732a
8010193f:	e8 2c ea ff ff       	call   80100370 <panic>
80101944:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010194a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101950 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101950:	55                   	push   %ebp
80101951:	89 e5                	mov    %esp,%ebp
80101953:	56                   	push   %esi
80101954:	53                   	push   %ebx
80101955:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101958:	85 db                	test   %ebx,%ebx
8010195a:	74 28                	je     80101984 <iunlock+0x34>
8010195c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010195f:	83 ec 0c             	sub    $0xc,%esp
80101962:	56                   	push   %esi
80101963:	e8 18 2a 00 00       	call   80104380 <holdingsleep>
80101968:	83 c4 10             	add    $0x10,%esp
8010196b:	85 c0                	test   %eax,%eax
8010196d:	74 15                	je     80101984 <iunlock+0x34>
8010196f:	8b 43 08             	mov    0x8(%ebx),%eax
80101972:	85 c0                	test   %eax,%eax
80101974:	7e 0e                	jle    80101984 <iunlock+0x34>
    panic("iunlock");

  releasesleep(&ip->lock);
80101976:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101979:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010197c:	5b                   	pop    %ebx
8010197d:	5e                   	pop    %esi
8010197e:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
8010197f:	e9 bc 29 00 00       	jmp    80104340 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
80101984:	83 ec 0c             	sub    $0xc,%esp
80101987:	68 3f 73 10 80       	push   $0x8010733f
8010198c:	e8 df e9 ff ff       	call   80100370 <panic>
80101991:	eb 0d                	jmp    801019a0 <iput>
80101993:	90                   	nop
80101994:	90                   	nop
80101995:	90                   	nop
80101996:	90                   	nop
80101997:	90                   	nop
80101998:	90                   	nop
80101999:	90                   	nop
8010199a:	90                   	nop
8010199b:	90                   	nop
8010199c:	90                   	nop
8010199d:	90                   	nop
8010199e:	90                   	nop
8010199f:	90                   	nop

801019a0 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
801019a0:	55                   	push   %ebp
801019a1:	89 e5                	mov    %esp,%ebp
801019a3:	57                   	push   %edi
801019a4:	56                   	push   %esi
801019a5:	53                   	push   %ebx
801019a6:	83 ec 28             	sub    $0x28,%esp
801019a9:	8b 75 08             	mov    0x8(%ebp),%esi
  acquiresleep(&ip->lock);
801019ac:	8d 7e 0c             	lea    0xc(%esi),%edi
801019af:	57                   	push   %edi
801019b0:	e8 2b 29 00 00       	call   801042e0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801019b5:	8b 56 4c             	mov    0x4c(%esi),%edx
801019b8:	83 c4 10             	add    $0x10,%esp
801019bb:	85 d2                	test   %edx,%edx
801019bd:	74 07                	je     801019c6 <iput+0x26>
801019bf:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
801019c4:	74 32                	je     801019f8 <iput+0x58>
      ip->type = 0;
      iupdate(ip);
      ip->valid = 0;
    }
  }
  releasesleep(&ip->lock);
801019c6:	83 ec 0c             	sub    $0xc,%esp
801019c9:	57                   	push   %edi
801019ca:	e8 71 29 00 00       	call   80104340 <releasesleep>

  acquire(&icache.lock);
801019cf:	c7 04 24 80 19 11 80 	movl   $0x80111980,(%esp)
801019d6:	e8 d5 2a 00 00       	call   801044b0 <acquire>
  ip->ref--;
801019db:	83 6e 08 01          	subl   $0x1,0x8(%esi)
  release(&icache.lock);
801019df:	83 c4 10             	add    $0x10,%esp
801019e2:	c7 45 08 80 19 11 80 	movl   $0x80111980,0x8(%ebp)
}
801019e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801019ec:	5b                   	pop    %ebx
801019ed:	5e                   	pop    %esi
801019ee:	5f                   	pop    %edi
801019ef:	5d                   	pop    %ebp
  }
  releasesleep(&ip->lock);

  acquire(&icache.lock);
  ip->ref--;
  release(&icache.lock);
801019f0:	e9 db 2b 00 00       	jmp    801045d0 <release>
801019f5:	8d 76 00             	lea    0x0(%esi),%esi
void
iput(struct inode *ip)
{
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
801019f8:	83 ec 0c             	sub    $0xc,%esp
801019fb:	68 80 19 11 80       	push   $0x80111980
80101a00:	e8 ab 2a 00 00       	call   801044b0 <acquire>
    int r = ip->ref;
80101a05:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
80101a08:	c7 04 24 80 19 11 80 	movl   $0x80111980,(%esp)
80101a0f:	e8 bc 2b 00 00       	call   801045d0 <release>
    if(r == 1){
80101a14:	83 c4 10             	add    $0x10,%esp
80101a17:	83 fb 01             	cmp    $0x1,%ebx
80101a1a:	75 aa                	jne    801019c6 <iput+0x26>
80101a1c:	8d 8e 8c 00 00 00    	lea    0x8c(%esi),%ecx
80101a22:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101a25:	8d 5e 5c             	lea    0x5c(%esi),%ebx
80101a28:	89 cf                	mov    %ecx,%edi
80101a2a:	eb 0b                	jmp    80101a37 <iput+0x97>
80101a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101a30:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101a33:	39 fb                	cmp    %edi,%ebx
80101a35:	74 19                	je     80101a50 <iput+0xb0>
    if(ip->addrs[i]){
80101a37:	8b 13                	mov    (%ebx),%edx
80101a39:	85 d2                	test   %edx,%edx
80101a3b:	74 f3                	je     80101a30 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
80101a3d:	8b 06                	mov    (%esi),%eax
80101a3f:	e8 ac fb ff ff       	call   801015f0 <bfree>
      ip->addrs[i] = 0;
80101a44:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80101a4a:	eb e4                	jmp    80101a30 <iput+0x90>
80101a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101a50:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80101a56:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101a59:	85 c0                	test   %eax,%eax
80101a5b:	75 33                	jne    80101a90 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101a5d:	83 ec 0c             	sub    $0xc,%esp
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
80101a60:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
80101a67:	56                   	push   %esi
80101a68:	e8 53 fd ff ff       	call   801017c0 <iupdate>
    int r = ip->ref;
    release(&icache.lock);
    if(r == 1){
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
      ip->type = 0;
80101a6d:	31 c0                	xor    %eax,%eax
80101a6f:	66 89 46 50          	mov    %ax,0x50(%esi)
      iupdate(ip);
80101a73:	89 34 24             	mov    %esi,(%esp)
80101a76:	e8 45 fd ff ff       	call   801017c0 <iupdate>
      ip->valid = 0;
80101a7b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
80101a82:	83 c4 10             	add    $0x10,%esp
80101a85:	e9 3c ff ff ff       	jmp    801019c6 <iput+0x26>
80101a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101a90:	83 ec 08             	sub    $0x8,%esp
80101a93:	50                   	push   %eax
80101a94:	ff 36                	pushl  (%esi)
80101a96:	e8 35 e6 ff ff       	call   801000d0 <bread>
80101a9b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101aa1:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101aa4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101aa7:	8d 58 5c             	lea    0x5c(%eax),%ebx
80101aaa:	83 c4 10             	add    $0x10,%esp
80101aad:	89 cf                	mov    %ecx,%edi
80101aaf:	eb 0e                	jmp    80101abf <iput+0x11f>
80101ab1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ab8:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
80101abb:	39 fb                	cmp    %edi,%ebx
80101abd:	74 0f                	je     80101ace <iput+0x12e>
      if(a[j])
80101abf:	8b 13                	mov    (%ebx),%edx
80101ac1:	85 d2                	test   %edx,%edx
80101ac3:	74 f3                	je     80101ab8 <iput+0x118>
        bfree(ip->dev, a[j]);
80101ac5:	8b 06                	mov    (%esi),%eax
80101ac7:	e8 24 fb ff ff       	call   801015f0 <bfree>
80101acc:	eb ea                	jmp    80101ab8 <iput+0x118>
    }
    brelse(bp);
80101ace:	83 ec 0c             	sub    $0xc,%esp
80101ad1:	ff 75 e4             	pushl  -0x1c(%ebp)
80101ad4:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101ad7:	e8 04 e7 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101adc:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
80101ae2:	8b 06                	mov    (%esi),%eax
80101ae4:	e8 07 fb ff ff       	call   801015f0 <bfree>
    ip->addrs[NDIRECT] = 0;
80101ae9:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
80101af0:	00 00 00 
80101af3:	83 c4 10             	add    $0x10,%esp
80101af6:	e9 62 ff ff ff       	jmp    80101a5d <iput+0xbd>
80101afb:	90                   	nop
80101afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101b00 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101b00:	55                   	push   %ebp
80101b01:	89 e5                	mov    %esp,%ebp
80101b03:	53                   	push   %ebx
80101b04:	83 ec 10             	sub    $0x10,%esp
80101b07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101b0a:	53                   	push   %ebx
80101b0b:	e8 40 fe ff ff       	call   80101950 <iunlock>
  iput(ip);
80101b10:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101b13:	83 c4 10             	add    $0x10,%esp
}
80101b16:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101b19:	c9                   	leave  
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
80101b1a:	e9 81 fe ff ff       	jmp    801019a0 <iput>
80101b1f:	90                   	nop

80101b20 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101b20:	55                   	push   %ebp
80101b21:	89 e5                	mov    %esp,%ebp
80101b23:	8b 55 08             	mov    0x8(%ebp),%edx
80101b26:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101b29:	8b 0a                	mov    (%edx),%ecx
80101b2b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101b2e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101b31:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101b34:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101b38:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101b3b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101b3f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101b43:	8b 52 58             	mov    0x58(%edx),%edx
80101b46:	89 50 10             	mov    %edx,0x10(%eax)
}
80101b49:	5d                   	pop    %ebp
80101b4a:	c3                   	ret    
80101b4b:	90                   	nop
80101b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101b50 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101b50:	55                   	push   %ebp
80101b51:	89 e5                	mov    %esp,%ebp
80101b53:	57                   	push   %edi
80101b54:	56                   	push   %esi
80101b55:	53                   	push   %ebx
80101b56:	83 ec 1c             	sub    $0x1c,%esp
80101b59:	8b 45 08             	mov    0x8(%ebp),%eax
80101b5c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101b5f:	8b 75 10             	mov    0x10(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b62:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101b67:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101b6a:	8b 7d 14             	mov    0x14(%ebp),%edi
80101b6d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101b70:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b73:	0f 84 a7 00 00 00    	je     80101c20 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101b79:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b7c:	8b 40 58             	mov    0x58(%eax),%eax
80101b7f:	39 f0                	cmp    %esi,%eax
80101b81:	0f 82 c1 00 00 00    	jb     80101c48 <readi+0xf8>
80101b87:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101b8a:	89 fa                	mov    %edi,%edx
80101b8c:	01 f2                	add    %esi,%edx
80101b8e:	0f 82 b4 00 00 00    	jb     80101c48 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101b94:	89 c1                	mov    %eax,%ecx
80101b96:	29 f1                	sub    %esi,%ecx
80101b98:	39 d0                	cmp    %edx,%eax
80101b9a:	0f 43 cf             	cmovae %edi,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b9d:	31 ff                	xor    %edi,%edi
80101b9f:	85 c9                	test   %ecx,%ecx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101ba1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ba4:	74 6d                	je     80101c13 <readi+0xc3>
80101ba6:	8d 76 00             	lea    0x0(%esi),%esi
80101ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bb0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101bb3:	89 f2                	mov    %esi,%edx
80101bb5:	c1 ea 09             	shr    $0x9,%edx
80101bb8:	89 d8                	mov    %ebx,%eax
80101bba:	e8 21 f9 ff ff       	call   801014e0 <bmap>
80101bbf:	83 ec 08             	sub    $0x8,%esp
80101bc2:	50                   	push   %eax
80101bc3:	ff 33                	pushl  (%ebx)
    m = min(n - tot, BSIZE - off%BSIZE);
80101bc5:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bca:	e8 01 e5 ff ff       	call   801000d0 <bread>
80101bcf:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101bd1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101bd4:	89 f1                	mov    %esi,%ecx
80101bd6:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101bdc:	83 c4 0c             	add    $0xc,%esp
    memmove(dst, bp->data + off%BSIZE, m);
80101bdf:	89 55 dc             	mov    %edx,-0x24(%ebp)
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101be2:	29 cb                	sub    %ecx,%ebx
80101be4:	29 f8                	sub    %edi,%eax
80101be6:	39 c3                	cmp    %eax,%ebx
80101be8:	0f 47 d8             	cmova  %eax,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101beb:	8d 44 0a 5c          	lea    0x5c(%edx,%ecx,1),%eax
80101bef:	53                   	push   %ebx
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101bf0:	01 df                	add    %ebx,%edi
80101bf2:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
80101bf4:	50                   	push   %eax
80101bf5:	ff 75 e0             	pushl  -0x20(%ebp)
80101bf8:	e8 d3 2a 00 00       	call   801046d0 <memmove>
    brelse(bp);
80101bfd:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101c00:	89 14 24             	mov    %edx,(%esp)
80101c03:	e8 d8 e5 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c08:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101c0b:	83 c4 10             	add    $0x10,%esp
80101c0e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101c11:	77 9d                	ja     80101bb0 <readi+0x60>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101c13:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101c16:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c19:	5b                   	pop    %ebx
80101c1a:	5e                   	pop    %esi
80101c1b:	5f                   	pop    %edi
80101c1c:	5d                   	pop    %ebp
80101c1d:	c3                   	ret    
80101c1e:	66 90                	xchg   %ax,%ax
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101c20:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101c24:	66 83 f8 09          	cmp    $0x9,%ax
80101c28:	77 1e                	ja     80101c48 <readi+0xf8>
80101c2a:	8b 04 c5 00 19 11 80 	mov    -0x7feee700(,%eax,8),%eax
80101c31:	85 c0                	test   %eax,%eax
80101c33:	74 13                	je     80101c48 <readi+0xf8>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101c35:	89 7d 10             	mov    %edi,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
80101c38:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c3b:	5b                   	pop    %ebx
80101c3c:	5e                   	pop    %esi
80101c3d:	5f                   	pop    %edi
80101c3e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101c3f:	ff e0                	jmp    *%eax
80101c41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101c48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c4d:	eb c7                	jmp    80101c16 <readi+0xc6>
80101c4f:	90                   	nop

80101c50 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101c50:	55                   	push   %ebp
80101c51:	89 e5                	mov    %esp,%ebp
80101c53:	57                   	push   %edi
80101c54:	56                   	push   %esi
80101c55:	53                   	push   %ebx
80101c56:	83 ec 1c             	sub    $0x1c,%esp
80101c59:	8b 45 08             	mov    0x8(%ebp),%eax
80101c5c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101c5f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101c62:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101c67:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101c6a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101c6d:	8b 75 10             	mov    0x10(%ebp),%esi
80101c70:	89 7d e0             	mov    %edi,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101c73:	0f 84 b7 00 00 00    	je     80101d30 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101c79:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c7c:	39 70 58             	cmp    %esi,0x58(%eax)
80101c7f:	0f 82 eb 00 00 00    	jb     80101d70 <writei+0x120>
80101c85:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101c88:	89 f8                	mov    %edi,%eax
80101c8a:	01 f0                	add    %esi,%eax
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101c8c:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101c91:	0f 87 d9 00 00 00    	ja     80101d70 <writei+0x120>
80101c97:	39 c6                	cmp    %eax,%esi
80101c99:	0f 87 d1 00 00 00    	ja     80101d70 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c9f:	85 ff                	test   %edi,%edi
80101ca1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101ca8:	74 78                	je     80101d22 <writei+0xd2>
80101caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101cb0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101cb3:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101cb5:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101cba:	c1 ea 09             	shr    $0x9,%edx
80101cbd:	89 f8                	mov    %edi,%eax
80101cbf:	e8 1c f8 ff ff       	call   801014e0 <bmap>
80101cc4:	83 ec 08             	sub    $0x8,%esp
80101cc7:	50                   	push   %eax
80101cc8:	ff 37                	pushl  (%edi)
80101cca:	e8 01 e4 ff ff       	call   801000d0 <bread>
80101ccf:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101cd1:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101cd4:	2b 45 e4             	sub    -0x1c(%ebp),%eax
80101cd7:	89 f1                	mov    %esi,%ecx
80101cd9:	83 c4 0c             	add    $0xc,%esp
80101cdc:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101ce2:	29 cb                	sub    %ecx,%ebx
80101ce4:	39 c3                	cmp    %eax,%ebx
80101ce6:	0f 47 d8             	cmova  %eax,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101ce9:	8d 44 0f 5c          	lea    0x5c(%edi,%ecx,1),%eax
80101ced:	53                   	push   %ebx
80101cee:	ff 75 dc             	pushl  -0x24(%ebp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101cf1:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
80101cf3:	50                   	push   %eax
80101cf4:	e8 d7 29 00 00       	call   801046d0 <memmove>
    log_write(bp);
80101cf9:	89 3c 24             	mov    %edi,(%esp)
80101cfc:	e8 2f 12 00 00       	call   80102f30 <log_write>
    brelse(bp);
80101d01:	89 3c 24             	mov    %edi,(%esp)
80101d04:	e8 d7 e4 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101d09:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101d0c:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101d0f:	83 c4 10             	add    $0x10,%esp
80101d12:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101d15:	39 55 e0             	cmp    %edx,-0x20(%ebp)
80101d18:	77 96                	ja     80101cb0 <writei+0x60>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80101d1a:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101d1d:	3b 70 58             	cmp    0x58(%eax),%esi
80101d20:	77 36                	ja     80101d58 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101d22:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101d25:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d28:	5b                   	pop    %ebx
80101d29:	5e                   	pop    %esi
80101d2a:	5f                   	pop    %edi
80101d2b:	5d                   	pop    %ebp
80101d2c:	c3                   	ret    
80101d2d:	8d 76 00             	lea    0x0(%esi),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101d30:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101d34:	66 83 f8 09          	cmp    $0x9,%ax
80101d38:	77 36                	ja     80101d70 <writei+0x120>
80101d3a:	8b 04 c5 04 19 11 80 	mov    -0x7feee6fc(,%eax,8),%eax
80101d41:	85 c0                	test   %eax,%eax
80101d43:	74 2b                	je     80101d70 <writei+0x120>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101d45:	89 7d 10             	mov    %edi,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101d48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d4b:	5b                   	pop    %ebx
80101d4c:	5e                   	pop    %esi
80101d4d:	5f                   	pop    %edi
80101d4e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101d4f:	ff e0                	jmp    *%eax
80101d51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101d58:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101d5b:	83 ec 0c             	sub    $0xc,%esp
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101d5e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101d61:	50                   	push   %eax
80101d62:	e8 59 fa ff ff       	call   801017c0 <iupdate>
80101d67:	83 c4 10             	add    $0x10,%esp
80101d6a:	eb b6                	jmp    80101d22 <writei+0xd2>
80101d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101d70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101d75:	eb ae                	jmp    80101d25 <writei+0xd5>
80101d77:	89 f6                	mov    %esi,%esi
80101d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101d80 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101d80:	55                   	push   %ebp
80101d81:	89 e5                	mov    %esp,%ebp
80101d83:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101d86:	6a 0e                	push   $0xe
80101d88:	ff 75 0c             	pushl  0xc(%ebp)
80101d8b:	ff 75 08             	pushl  0x8(%ebp)
80101d8e:	e8 bd 29 00 00       	call   80104750 <strncmp>
}
80101d93:	c9                   	leave  
80101d94:	c3                   	ret    
80101d95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101da0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101da0:	55                   	push   %ebp
80101da1:	89 e5                	mov    %esp,%ebp
80101da3:	57                   	push   %edi
80101da4:	56                   	push   %esi
80101da5:	53                   	push   %ebx
80101da6:	83 ec 1c             	sub    $0x1c,%esp
80101da9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101dac:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101db1:	0f 85 80 00 00 00    	jne    80101e37 <dirlookup+0x97>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101db7:	8b 53 58             	mov    0x58(%ebx),%edx
80101dba:	31 ff                	xor    %edi,%edi
80101dbc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101dbf:	85 d2                	test   %edx,%edx
80101dc1:	75 0d                	jne    80101dd0 <dirlookup+0x30>
80101dc3:	eb 5b                	jmp    80101e20 <dirlookup+0x80>
80101dc5:	8d 76 00             	lea    0x0(%esi),%esi
80101dc8:	83 c7 10             	add    $0x10,%edi
80101dcb:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101dce:	76 50                	jbe    80101e20 <dirlookup+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101dd0:	6a 10                	push   $0x10
80101dd2:	57                   	push   %edi
80101dd3:	56                   	push   %esi
80101dd4:	53                   	push   %ebx
80101dd5:	e8 76 fd ff ff       	call   80101b50 <readi>
80101dda:	83 c4 10             	add    $0x10,%esp
80101ddd:	83 f8 10             	cmp    $0x10,%eax
80101de0:	75 48                	jne    80101e2a <dirlookup+0x8a>
      panic("dirlookup read");
    if(de.inum == 0)
80101de2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101de7:	74 df                	je     80101dc8 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
80101de9:	8d 45 da             	lea    -0x26(%ebp),%eax
80101dec:	83 ec 04             	sub    $0x4,%esp
80101def:	6a 0e                	push   $0xe
80101df1:	50                   	push   %eax
80101df2:	ff 75 0c             	pushl  0xc(%ebp)
80101df5:	e8 56 29 00 00       	call   80104750 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80101dfa:	83 c4 10             	add    $0x10,%esp
80101dfd:	85 c0                	test   %eax,%eax
80101dff:	75 c7                	jne    80101dc8 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101e01:	8b 45 10             	mov    0x10(%ebp),%eax
80101e04:	85 c0                	test   %eax,%eax
80101e06:	74 05                	je     80101e0d <dirlookup+0x6d>
        *poff = off;
80101e08:	8b 45 10             	mov    0x10(%ebp),%eax
80101e0b:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
      return iget(dp->dev, inum);
80101e0d:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80101e11:	8b 03                	mov    (%ebx),%eax
80101e13:	e8 f8 f5 ff ff       	call   80101410 <iget>
    }
  }

  return 0;
}
80101e18:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e1b:	5b                   	pop    %ebx
80101e1c:	5e                   	pop    %esi
80101e1d:	5f                   	pop    %edi
80101e1e:	5d                   	pop    %ebp
80101e1f:	c3                   	ret    
80101e20:	8d 65 f4             	lea    -0xc(%ebp),%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101e23:	31 c0                	xor    %eax,%eax
}
80101e25:	5b                   	pop    %ebx
80101e26:	5e                   	pop    %esi
80101e27:	5f                   	pop    %edi
80101e28:	5d                   	pop    %ebp
80101e29:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
80101e2a:	83 ec 0c             	sub    $0xc,%esp
80101e2d:	68 59 73 10 80       	push   $0x80107359
80101e32:	e8 39 e5 ff ff       	call   80100370 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101e37:	83 ec 0c             	sub    $0xc,%esp
80101e3a:	68 47 73 10 80       	push   $0x80107347
80101e3f:	e8 2c e5 ff ff       	call   80100370 <panic>
80101e44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101e4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101e50 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101e50:	55                   	push   %ebp
80101e51:	89 e5                	mov    %esp,%ebp
80101e53:	57                   	push   %edi
80101e54:	56                   	push   %esi
80101e55:	53                   	push   %ebx
80101e56:	89 cf                	mov    %ecx,%edi
80101e58:	89 c3                	mov    %eax,%ebx
80101e5a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101e5d:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101e60:	89 55 e0             	mov    %edx,-0x20(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101e63:	0f 84 53 01 00 00    	je     80101fbc <namex+0x16c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101e69:	e8 12 1b 00 00       	call   80103980 <myproc>
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101e6e:	83 ec 0c             	sub    $0xc,%esp
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101e71:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101e74:	68 80 19 11 80       	push   $0x80111980
80101e79:	e8 32 26 00 00       	call   801044b0 <acquire>
  ip->ref++;
80101e7e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101e82:	c7 04 24 80 19 11 80 	movl   $0x80111980,(%esp)
80101e89:	e8 42 27 00 00       	call   801045d0 <release>
80101e8e:	83 c4 10             	add    $0x10,%esp
80101e91:	eb 08                	jmp    80101e9b <namex+0x4b>
80101e93:	90                   	nop
80101e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101e98:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101e9b:	0f b6 03             	movzbl (%ebx),%eax
80101e9e:	3c 2f                	cmp    $0x2f,%al
80101ea0:	74 f6                	je     80101e98 <namex+0x48>
    path++;
  if(*path == 0)
80101ea2:	84 c0                	test   %al,%al
80101ea4:	0f 84 e3 00 00 00    	je     80101f8d <namex+0x13d>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101eaa:	0f b6 03             	movzbl (%ebx),%eax
80101ead:	89 da                	mov    %ebx,%edx
80101eaf:	84 c0                	test   %al,%al
80101eb1:	0f 84 ac 00 00 00    	je     80101f63 <namex+0x113>
80101eb7:	3c 2f                	cmp    $0x2f,%al
80101eb9:	75 09                	jne    80101ec4 <namex+0x74>
80101ebb:	e9 a3 00 00 00       	jmp    80101f63 <namex+0x113>
80101ec0:	84 c0                	test   %al,%al
80101ec2:	74 0a                	je     80101ece <namex+0x7e>
    path++;
80101ec4:	83 c2 01             	add    $0x1,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101ec7:	0f b6 02             	movzbl (%edx),%eax
80101eca:	3c 2f                	cmp    $0x2f,%al
80101ecc:	75 f2                	jne    80101ec0 <namex+0x70>
80101ece:	89 d1                	mov    %edx,%ecx
80101ed0:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101ed2:	83 f9 0d             	cmp    $0xd,%ecx
80101ed5:	0f 8e 8d 00 00 00    	jle    80101f68 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101edb:	83 ec 04             	sub    $0x4,%esp
80101ede:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101ee1:	6a 0e                	push   $0xe
80101ee3:	53                   	push   %ebx
80101ee4:	57                   	push   %edi
80101ee5:	e8 e6 27 00 00       	call   801046d0 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101eea:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
80101eed:	83 c4 10             	add    $0x10,%esp
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101ef0:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101ef2:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101ef5:	75 11                	jne    80101f08 <namex+0xb8>
80101ef7:	89 f6                	mov    %esi,%esi
80101ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101f00:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101f03:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101f06:	74 f8                	je     80101f00 <namex+0xb0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101f08:	83 ec 0c             	sub    $0xc,%esp
80101f0b:	56                   	push   %esi
80101f0c:	e8 5f f9 ff ff       	call   80101870 <ilock>
    if(ip->type != T_DIR){
80101f11:	83 c4 10             	add    $0x10,%esp
80101f14:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101f19:	0f 85 7f 00 00 00    	jne    80101f9e <namex+0x14e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101f1f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101f22:	85 d2                	test   %edx,%edx
80101f24:	74 09                	je     80101f2f <namex+0xdf>
80101f26:	80 3b 00             	cmpb   $0x0,(%ebx)
80101f29:	0f 84 a3 00 00 00    	je     80101fd2 <namex+0x182>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101f2f:	83 ec 04             	sub    $0x4,%esp
80101f32:	6a 00                	push   $0x0
80101f34:	57                   	push   %edi
80101f35:	56                   	push   %esi
80101f36:	e8 65 fe ff ff       	call   80101da0 <dirlookup>
80101f3b:	83 c4 10             	add    $0x10,%esp
80101f3e:	85 c0                	test   %eax,%eax
80101f40:	74 5c                	je     80101f9e <namex+0x14e>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101f42:	83 ec 0c             	sub    $0xc,%esp
80101f45:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101f48:	56                   	push   %esi
80101f49:	e8 02 fa ff ff       	call   80101950 <iunlock>
  iput(ip);
80101f4e:	89 34 24             	mov    %esi,(%esp)
80101f51:	e8 4a fa ff ff       	call   801019a0 <iput>
80101f56:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101f59:	83 c4 10             	add    $0x10,%esp
80101f5c:	89 c6                	mov    %eax,%esi
80101f5e:	e9 38 ff ff ff       	jmp    80101e9b <namex+0x4b>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101f63:	31 c9                	xor    %ecx,%ecx
80101f65:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101f68:	83 ec 04             	sub    $0x4,%esp
80101f6b:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101f6e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101f71:	51                   	push   %ecx
80101f72:	53                   	push   %ebx
80101f73:	57                   	push   %edi
80101f74:	e8 57 27 00 00       	call   801046d0 <memmove>
    name[len] = 0;
80101f79:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101f7c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101f7f:	83 c4 10             	add    $0x10,%esp
80101f82:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101f86:	89 d3                	mov    %edx,%ebx
80101f88:	e9 65 ff ff ff       	jmp    80101ef2 <namex+0xa2>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101f8d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101f90:	85 c0                	test   %eax,%eax
80101f92:	75 54                	jne    80101fe8 <namex+0x198>
80101f94:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101f96:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f99:	5b                   	pop    %ebx
80101f9a:	5e                   	pop    %esi
80101f9b:	5f                   	pop    %edi
80101f9c:	5d                   	pop    %ebp
80101f9d:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101f9e:	83 ec 0c             	sub    $0xc,%esp
80101fa1:	56                   	push   %esi
80101fa2:	e8 a9 f9 ff ff       	call   80101950 <iunlock>
  iput(ip);
80101fa7:	89 34 24             	mov    %esi,(%esp)
80101faa:	e8 f1 f9 ff ff       	call   801019a0 <iput>
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101faf:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101fb2:	8d 65 f4             	lea    -0xc(%ebp),%esp
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101fb5:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101fb7:	5b                   	pop    %ebx
80101fb8:	5e                   	pop    %esi
80101fb9:	5f                   	pop    %edi
80101fba:	5d                   	pop    %ebp
80101fbb:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101fbc:	ba 01 00 00 00       	mov    $0x1,%edx
80101fc1:	b8 01 00 00 00       	mov    $0x1,%eax
80101fc6:	e8 45 f4 ff ff       	call   80101410 <iget>
80101fcb:	89 c6                	mov    %eax,%esi
80101fcd:	e9 c9 fe ff ff       	jmp    80101e9b <namex+0x4b>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101fd2:	83 ec 0c             	sub    $0xc,%esp
80101fd5:	56                   	push   %esi
80101fd6:	e8 75 f9 ff ff       	call   80101950 <iunlock>
      return ip;
80101fdb:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101fde:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
      return ip;
80101fe1:	89 f0                	mov    %esi,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101fe3:	5b                   	pop    %ebx
80101fe4:	5e                   	pop    %esi
80101fe5:	5f                   	pop    %edi
80101fe6:	5d                   	pop    %ebp
80101fe7:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101fe8:	83 ec 0c             	sub    $0xc,%esp
80101feb:	56                   	push   %esi
80101fec:	e8 af f9 ff ff       	call   801019a0 <iput>
    return 0;
80101ff1:	83 c4 10             	add    $0x10,%esp
80101ff4:	31 c0                	xor    %eax,%eax
80101ff6:	eb 9e                	jmp    80101f96 <namex+0x146>
80101ff8:	90                   	nop
80101ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102000 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80102000:	55                   	push   %ebp
80102001:	89 e5                	mov    %esp,%ebp
80102003:	57                   	push   %edi
80102004:	56                   	push   %esi
80102005:	53                   	push   %ebx
80102006:	83 ec 20             	sub    $0x20,%esp
80102009:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
8010200c:	6a 00                	push   $0x0
8010200e:	ff 75 0c             	pushl  0xc(%ebp)
80102011:	53                   	push   %ebx
80102012:	e8 89 fd ff ff       	call   80101da0 <dirlookup>
80102017:	83 c4 10             	add    $0x10,%esp
8010201a:	85 c0                	test   %eax,%eax
8010201c:	75 67                	jne    80102085 <dirlink+0x85>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
8010201e:	8b 7b 58             	mov    0x58(%ebx),%edi
80102021:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102024:	85 ff                	test   %edi,%edi
80102026:	74 29                	je     80102051 <dirlink+0x51>
80102028:	31 ff                	xor    %edi,%edi
8010202a:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010202d:	eb 09                	jmp    80102038 <dirlink+0x38>
8010202f:	90                   	nop
80102030:	83 c7 10             	add    $0x10,%edi
80102033:	39 7b 58             	cmp    %edi,0x58(%ebx)
80102036:	76 19                	jbe    80102051 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102038:	6a 10                	push   $0x10
8010203a:	57                   	push   %edi
8010203b:	56                   	push   %esi
8010203c:	53                   	push   %ebx
8010203d:	e8 0e fb ff ff       	call   80101b50 <readi>
80102042:	83 c4 10             	add    $0x10,%esp
80102045:	83 f8 10             	cmp    $0x10,%eax
80102048:	75 4e                	jne    80102098 <dirlink+0x98>
      panic("dirlink read");
    if(de.inum == 0)
8010204a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010204f:	75 df                	jne    80102030 <dirlink+0x30>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80102051:	8d 45 da             	lea    -0x26(%ebp),%eax
80102054:	83 ec 04             	sub    $0x4,%esp
80102057:	6a 0e                	push   $0xe
80102059:	ff 75 0c             	pushl  0xc(%ebp)
8010205c:	50                   	push   %eax
8010205d:	e8 5e 27 00 00       	call   801047c0 <strncpy>
  de.inum = inum;
80102062:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102065:	6a 10                	push   $0x10
80102067:	57                   	push   %edi
80102068:	56                   	push   %esi
80102069:	53                   	push   %ebx
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
8010206a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010206e:	e8 dd fb ff ff       	call   80101c50 <writei>
80102073:	83 c4 20             	add    $0x20,%esp
80102076:	83 f8 10             	cmp    $0x10,%eax
80102079:	75 2a                	jne    801020a5 <dirlink+0xa5>
    panic("dirlink");

  return 0;
8010207b:	31 c0                	xor    %eax,%eax
}
8010207d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102080:	5b                   	pop    %ebx
80102081:	5e                   	pop    %esi
80102082:	5f                   	pop    %edi
80102083:	5d                   	pop    %ebp
80102084:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80102085:	83 ec 0c             	sub    $0xc,%esp
80102088:	50                   	push   %eax
80102089:	e8 12 f9 ff ff       	call   801019a0 <iput>
    return -1;
8010208e:	83 c4 10             	add    $0x10,%esp
80102091:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102096:	eb e5                	jmp    8010207d <dirlink+0x7d>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80102098:	83 ec 0c             	sub    $0xc,%esp
8010209b:	68 68 73 10 80       	push   $0x80107368
801020a0:	e8 cb e2 ff ff       	call   80100370 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
801020a5:	83 ec 0c             	sub    $0xc,%esp
801020a8:	68 6e 79 10 80       	push   $0x8010796e
801020ad:	e8 be e2 ff ff       	call   80100370 <panic>
801020b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801020c0 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
801020c0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
801020c1:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
801020c3:	89 e5                	mov    %esp,%ebp
801020c5:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
801020c8:	8b 45 08             	mov    0x8(%ebp),%eax
801020cb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
801020ce:	e8 7d fd ff ff       	call   80101e50 <namex>
}
801020d3:	c9                   	leave  
801020d4:	c3                   	ret    
801020d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801020d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801020e0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801020e0:	55                   	push   %ebp
  return namex(path, 1, name);
801020e1:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
801020e6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
801020e8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801020eb:	8b 45 08             	mov    0x8(%ebp),%eax
}
801020ee:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
801020ef:	e9 5c fd ff ff       	jmp    80101e50 <namex>
801020f4:	66 90                	xchg   %ax,%ax
801020f6:	66 90                	xchg   %ax,%ax
801020f8:	66 90                	xchg   %ax,%ax
801020fa:	66 90                	xchg   %ax,%ax
801020fc:	66 90                	xchg   %ax,%ax
801020fe:	66 90                	xchg   %ax,%ax

80102100 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102100:	55                   	push   %ebp
  if(b == 0)
80102101:	85 c0                	test   %eax,%eax
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102103:	89 e5                	mov    %esp,%ebp
80102105:	56                   	push   %esi
80102106:	53                   	push   %ebx
  if(b == 0)
80102107:	0f 84 ad 00 00 00    	je     801021ba <idestart+0xba>
    panic("idestart");
  if(b->blockno >= FSSIZE)
8010210d:	8b 58 08             	mov    0x8(%eax),%ebx
80102110:	89 c1                	mov    %eax,%ecx
80102112:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80102118:	0f 87 8f 00 00 00    	ja     801021ad <idestart+0xad>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010211e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102123:	90                   	nop
80102124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102128:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102129:	83 e0 c0             	and    $0xffffffc0,%eax
8010212c:	3c 40                	cmp    $0x40,%al
8010212e:	75 f8                	jne    80102128 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102130:	31 f6                	xor    %esi,%esi
80102132:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102137:	89 f0                	mov    %esi,%eax
80102139:	ee                   	out    %al,(%dx)
8010213a:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010213f:	b8 01 00 00 00       	mov    $0x1,%eax
80102144:	ee                   	out    %al,(%dx)
80102145:	ba f3 01 00 00       	mov    $0x1f3,%edx
8010214a:	89 d8                	mov    %ebx,%eax
8010214c:	ee                   	out    %al,(%dx)
8010214d:	89 d8                	mov    %ebx,%eax
8010214f:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102154:	c1 f8 08             	sar    $0x8,%eax
80102157:	ee                   	out    %al,(%dx)
80102158:	ba f5 01 00 00       	mov    $0x1f5,%edx
8010215d:	89 f0                	mov    %esi,%eax
8010215f:	ee                   	out    %al,(%dx)
80102160:	0f b6 41 04          	movzbl 0x4(%ecx),%eax
80102164:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102169:	83 e0 01             	and    $0x1,%eax
8010216c:	c1 e0 04             	shl    $0x4,%eax
8010216f:	83 c8 e0             	or     $0xffffffe0,%eax
80102172:	ee                   	out    %al,(%dx)
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
80102173:	f6 01 04             	testb  $0x4,(%ecx)
80102176:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010217b:	75 13                	jne    80102190 <idestart+0x90>
8010217d:	b8 20 00 00 00       	mov    $0x20,%eax
80102182:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102183:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102186:	5b                   	pop    %ebx
80102187:	5e                   	pop    %esi
80102188:	5d                   	pop    %ebp
80102189:	c3                   	ret    
8010218a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102190:	b8 30 00 00 00       	mov    $0x30,%eax
80102195:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80102196:	ba f0 01 00 00       	mov    $0x1f0,%edx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
8010219b:	8d 71 5c             	lea    0x5c(%ecx),%esi
8010219e:	b9 80 00 00 00       	mov    $0x80,%ecx
801021a3:	fc                   	cld    
801021a4:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
801021a6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801021a9:	5b                   	pop    %ebx
801021aa:	5e                   	pop    %esi
801021ab:	5d                   	pop    %ebp
801021ac:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
801021ad:	83 ec 0c             	sub    $0xc,%esp
801021b0:	68 d4 73 10 80       	push   $0x801073d4
801021b5:	e8 b6 e1 ff ff       	call   80100370 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
801021ba:	83 ec 0c             	sub    $0xc,%esp
801021bd:	68 cb 73 10 80       	push   $0x801073cb
801021c2:	e8 a9 e1 ff ff       	call   80100370 <panic>
801021c7:	89 f6                	mov    %esi,%esi
801021c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801021d0 <ideinit>:
  return 0;
}

void
ideinit(void)
{
801021d0:	55                   	push   %ebp
801021d1:	89 e5                	mov    %esp,%ebp
801021d3:	83 ec 10             	sub    $0x10,%esp
  int i;

  initlock(&idelock, "ide");
801021d6:	68 e6 73 10 80       	push   $0x801073e6
801021db:	68 20 b5 10 80       	push   $0x8010b520
801021e0:	e8 cb 21 00 00       	call   801043b0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801021e5:	58                   	pop    %eax
801021e6:	a1 a0 3c 11 80       	mov    0x80113ca0,%eax
801021eb:	5a                   	pop    %edx
801021ec:	83 e8 01             	sub    $0x1,%eax
801021ef:	50                   	push   %eax
801021f0:	6a 0e                	push   $0xe
801021f2:	e8 a9 02 00 00       	call   801024a0 <ioapicenable>
801021f7:	83 c4 10             	add    $0x10,%esp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021fa:	ba f7 01 00 00       	mov    $0x1f7,%edx
801021ff:	90                   	nop
80102200:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102201:	83 e0 c0             	and    $0xffffffc0,%eax
80102204:	3c 40                	cmp    $0x40,%al
80102206:	75 f8                	jne    80102200 <ideinit+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102208:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010220d:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102212:	ee                   	out    %al,(%dx)
80102213:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102218:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010221d:	eb 06                	jmp    80102225 <ideinit+0x55>
8010221f:	90                   	nop
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102220:	83 e9 01             	sub    $0x1,%ecx
80102223:	74 0f                	je     80102234 <ideinit+0x64>
80102225:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102226:	84 c0                	test   %al,%al
80102228:	74 f6                	je     80102220 <ideinit+0x50>
      havedisk1 = 1;
8010222a:	c7 05 00 b5 10 80 01 	movl   $0x1,0x8010b500
80102231:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102234:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102239:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
8010223e:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
8010223f:	c9                   	leave  
80102240:	c3                   	ret    
80102241:	eb 0d                	jmp    80102250 <ideintr>
80102243:	90                   	nop
80102244:	90                   	nop
80102245:	90                   	nop
80102246:	90                   	nop
80102247:	90                   	nop
80102248:	90                   	nop
80102249:	90                   	nop
8010224a:	90                   	nop
8010224b:	90                   	nop
8010224c:	90                   	nop
8010224d:	90                   	nop
8010224e:	90                   	nop
8010224f:	90                   	nop

80102250 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
80102250:	55                   	push   %ebp
80102251:	89 e5                	mov    %esp,%ebp
80102253:	57                   	push   %edi
80102254:	56                   	push   %esi
80102255:	53                   	push   %ebx
80102256:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102259:	68 20 b5 10 80       	push   $0x8010b520
8010225e:	e8 4d 22 00 00       	call   801044b0 <acquire>

  if((b = idequeue) == 0){
80102263:	8b 1d 04 b5 10 80    	mov    0x8010b504,%ebx
80102269:	83 c4 10             	add    $0x10,%esp
8010226c:	85 db                	test   %ebx,%ebx
8010226e:	74 34                	je     801022a4 <ideintr+0x54>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102270:	8b 43 58             	mov    0x58(%ebx),%eax
80102273:	a3 04 b5 10 80       	mov    %eax,0x8010b504

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102278:	8b 33                	mov    (%ebx),%esi
8010227a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102280:	74 3e                	je     801022c0 <ideintr+0x70>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102282:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102285:	83 ec 0c             	sub    $0xc,%esp
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102288:	83 ce 02             	or     $0x2,%esi
8010228b:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010228d:	53                   	push   %ebx
8010228e:	e8 5d 1e 00 00       	call   801040f0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102293:	a1 04 b5 10 80       	mov    0x8010b504,%eax
80102298:	83 c4 10             	add    $0x10,%esp
8010229b:	85 c0                	test   %eax,%eax
8010229d:	74 05                	je     801022a4 <ideintr+0x54>
    idestart(idequeue);
8010229f:	e8 5c fe ff ff       	call   80102100 <idestart>

  // First queued buffer is the active request.
  acquire(&idelock);

  if((b = idequeue) == 0){
    release(&idelock);
801022a4:	83 ec 0c             	sub    $0xc,%esp
801022a7:	68 20 b5 10 80       	push   $0x8010b520
801022ac:	e8 1f 23 00 00       	call   801045d0 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
801022b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022b4:	5b                   	pop    %ebx
801022b5:	5e                   	pop    %esi
801022b6:	5f                   	pop    %edi
801022b7:	5d                   	pop    %ebp
801022b8:	c3                   	ret    
801022b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801022c0:	ba f7 01 00 00       	mov    $0x1f7,%edx
801022c5:	8d 76 00             	lea    0x0(%esi),%esi
801022c8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801022c9:	89 c1                	mov    %eax,%ecx
801022cb:	83 e1 c0             	and    $0xffffffc0,%ecx
801022ce:	80 f9 40             	cmp    $0x40,%cl
801022d1:	75 f5                	jne    801022c8 <ideintr+0x78>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801022d3:	a8 21                	test   $0x21,%al
801022d5:	75 ab                	jne    80102282 <ideintr+0x32>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
801022d7:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
801022da:	b9 80 00 00 00       	mov    $0x80,%ecx
801022df:	ba f0 01 00 00       	mov    $0x1f0,%edx
801022e4:	fc                   	cld    
801022e5:	f3 6d                	rep insl (%dx),%es:(%edi)
801022e7:	8b 33                	mov    (%ebx),%esi
801022e9:	eb 97                	jmp    80102282 <ideintr+0x32>
801022eb:	90                   	nop
801022ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801022f0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801022f0:	55                   	push   %ebp
801022f1:	89 e5                	mov    %esp,%ebp
801022f3:	53                   	push   %ebx
801022f4:	83 ec 10             	sub    $0x10,%esp
801022f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801022fa:	8d 43 0c             	lea    0xc(%ebx),%eax
801022fd:	50                   	push   %eax
801022fe:	e8 7d 20 00 00       	call   80104380 <holdingsleep>
80102303:	83 c4 10             	add    $0x10,%esp
80102306:	85 c0                	test   %eax,%eax
80102308:	0f 84 ad 00 00 00    	je     801023bb <iderw+0xcb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010230e:	8b 03                	mov    (%ebx),%eax
80102310:	83 e0 06             	and    $0x6,%eax
80102313:	83 f8 02             	cmp    $0x2,%eax
80102316:	0f 84 b9 00 00 00    	je     801023d5 <iderw+0xe5>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010231c:	8b 53 04             	mov    0x4(%ebx),%edx
8010231f:	85 d2                	test   %edx,%edx
80102321:	74 0d                	je     80102330 <iderw+0x40>
80102323:	a1 00 b5 10 80       	mov    0x8010b500,%eax
80102328:	85 c0                	test   %eax,%eax
8010232a:	0f 84 98 00 00 00    	je     801023c8 <iderw+0xd8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102330:	83 ec 0c             	sub    $0xc,%esp
80102333:	68 20 b5 10 80       	push   $0x8010b520
80102338:	e8 73 21 00 00       	call   801044b0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010233d:	8b 15 04 b5 10 80    	mov    0x8010b504,%edx
80102343:	83 c4 10             	add    $0x10,%esp
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
80102346:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010234d:	85 d2                	test   %edx,%edx
8010234f:	75 09                	jne    8010235a <iderw+0x6a>
80102351:	eb 58                	jmp    801023ab <iderw+0xbb>
80102353:	90                   	nop
80102354:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102358:	89 c2                	mov    %eax,%edx
8010235a:	8b 42 58             	mov    0x58(%edx),%eax
8010235d:	85 c0                	test   %eax,%eax
8010235f:	75 f7                	jne    80102358 <iderw+0x68>
80102361:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102364:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102366:	3b 1d 04 b5 10 80    	cmp    0x8010b504,%ebx
8010236c:	74 44                	je     801023b2 <iderw+0xc2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010236e:	8b 03                	mov    (%ebx),%eax
80102370:	83 e0 06             	and    $0x6,%eax
80102373:	83 f8 02             	cmp    $0x2,%eax
80102376:	74 23                	je     8010239b <iderw+0xab>
80102378:	90                   	nop
80102379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102380:	83 ec 08             	sub    $0x8,%esp
80102383:	68 20 b5 10 80       	push   $0x8010b520
80102388:	53                   	push   %ebx
80102389:	e8 b2 1b 00 00       	call   80103f40 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010238e:	8b 03                	mov    (%ebx),%eax
80102390:	83 c4 10             	add    $0x10,%esp
80102393:	83 e0 06             	and    $0x6,%eax
80102396:	83 f8 02             	cmp    $0x2,%eax
80102399:	75 e5                	jne    80102380 <iderw+0x90>
    sleep(b, &idelock);
  }


  release(&idelock);
8010239b:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
}
801023a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801023a5:	c9                   	leave  
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }


  release(&idelock);
801023a6:	e9 25 22 00 00       	jmp    801045d0 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801023ab:	ba 04 b5 10 80       	mov    $0x8010b504,%edx
801023b0:	eb b2                	jmp    80102364 <iderw+0x74>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
801023b2:	89 d8                	mov    %ebx,%eax
801023b4:	e8 47 fd ff ff       	call   80102100 <idestart>
801023b9:	eb b3                	jmp    8010236e <iderw+0x7e>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
801023bb:	83 ec 0c             	sub    $0xc,%esp
801023be:	68 ea 73 10 80       	push   $0x801073ea
801023c3:	e8 a8 df ff ff       	call   80100370 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
801023c8:	83 ec 0c             	sub    $0xc,%esp
801023cb:	68 15 74 10 80       	push   $0x80107415
801023d0:	e8 9b df ff ff       	call   80100370 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
801023d5:	83 ec 0c             	sub    $0xc,%esp
801023d8:	68 00 74 10 80       	push   $0x80107400
801023dd:	e8 8e df ff ff       	call   80100370 <panic>
801023e2:	66 90                	xchg   %ax,%ax
801023e4:	66 90                	xchg   %ax,%ax
801023e6:	66 90                	xchg   %ax,%ax
801023e8:	66 90                	xchg   %ax,%ax
801023ea:	66 90                	xchg   %ax,%ax
801023ec:	66 90                	xchg   %ax,%ax
801023ee:	66 90                	xchg   %ax,%ax

801023f0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801023f0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801023f1:	c7 05 d4 35 11 80 00 	movl   $0xfec00000,0x801135d4
801023f8:	00 c0 fe 
  ioapic->data = data;
}

void
ioapicinit(void)
{
801023fb:	89 e5                	mov    %esp,%ebp
801023fd:	56                   	push   %esi
801023fe:	53                   	push   %ebx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
801023ff:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102406:	00 00 00 
  return ioapic->data;
80102409:	8b 15 d4 35 11 80    	mov    0x801135d4,%edx
8010240f:	8b 72 10             	mov    0x10(%edx),%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80102412:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102418:	8b 0d d4 35 11 80    	mov    0x801135d4,%ecx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010241e:	0f b6 15 00 37 11 80 	movzbl 0x80113700,%edx
ioapicinit(void)
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102425:	89 f0                	mov    %esi,%eax
80102427:	c1 e8 10             	shr    $0x10,%eax
8010242a:	0f b6 f0             	movzbl %al,%esi

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
8010242d:	8b 41 10             	mov    0x10(%ecx),%eax
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102430:	c1 e8 18             	shr    $0x18,%eax
80102433:	39 d0                	cmp    %edx,%eax
80102435:	74 16                	je     8010244d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102437:	83 ec 0c             	sub    $0xc,%esp
8010243a:	68 34 74 10 80       	push   $0x80107434
8010243f:	e8 3c e2 ff ff       	call   80100680 <cprintf>
80102444:	8b 0d d4 35 11 80    	mov    0x801135d4,%ecx
8010244a:	83 c4 10             	add    $0x10,%esp
8010244d:	83 c6 21             	add    $0x21,%esi
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102450:	ba 10 00 00 00       	mov    $0x10,%edx
80102455:	b8 20 00 00 00       	mov    $0x20,%eax
8010245a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102460:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102462:	8b 0d d4 35 11 80    	mov    0x801135d4,%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102468:	89 c3                	mov    %eax,%ebx
8010246a:	81 cb 00 00 01 00    	or     $0x10000,%ebx
80102470:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102473:	89 59 10             	mov    %ebx,0x10(%ecx)
80102476:	8d 5a 01             	lea    0x1(%edx),%ebx
80102479:	83 c2 02             	add    $0x2,%edx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010247c:	39 f0                	cmp    %esi,%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010247e:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
80102480:	8b 0d d4 35 11 80    	mov    0x801135d4,%ecx
80102486:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010248d:	75 d1                	jne    80102460 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010248f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102492:	5b                   	pop    %ebx
80102493:	5e                   	pop    %esi
80102494:	5d                   	pop    %ebp
80102495:	c3                   	ret    
80102496:	8d 76 00             	lea    0x0(%esi),%esi
80102499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024a0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801024a0:	55                   	push   %ebp
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801024a1:	8b 0d d4 35 11 80    	mov    0x801135d4,%ecx
  }
}

void
ioapicenable(int irq, int cpunum)
{
801024a7:	89 e5                	mov    %esp,%ebp
801024a9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801024ac:	8d 50 20             	lea    0x20(%eax),%edx
801024af:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801024b3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801024b5:	8b 0d d4 35 11 80    	mov    0x801135d4,%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801024bb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801024be:	89 51 10             	mov    %edx,0x10(%ecx)
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801024c1:	8b 55 0c             	mov    0xc(%ebp),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801024c4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801024c6:	a1 d4 35 11 80       	mov    0x801135d4,%eax
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801024cb:	c1 e2 18             	shl    $0x18,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801024ce:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
801024d1:	5d                   	pop    %ebp
801024d2:	c3                   	ret    
801024d3:	66 90                	xchg   %ax,%ax
801024d5:	66 90                	xchg   %ax,%ax
801024d7:	66 90                	xchg   %ax,%ax
801024d9:	66 90                	xchg   %ax,%ax
801024db:	66 90                	xchg   %ax,%ax
801024dd:	66 90                	xchg   %ax,%ax
801024df:	90                   	nop

801024e0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801024e0:	55                   	push   %ebp
801024e1:	89 e5                	mov    %esp,%ebp
801024e3:	53                   	push   %ebx
801024e4:	83 ec 04             	sub    $0x4,%esp
801024e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801024ea:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801024f0:	75 70                	jne    80102562 <kfree+0x82>
801024f2:	81 fb 48 64 11 80    	cmp    $0x80116448,%ebx
801024f8:	72 68                	jb     80102562 <kfree+0x82>
801024fa:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102500:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102505:	77 5b                	ja     80102562 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102507:	83 ec 04             	sub    $0x4,%esp
8010250a:	68 00 10 00 00       	push   $0x1000
8010250f:	6a 01                	push   $0x1
80102511:	53                   	push   %ebx
80102512:	e8 09 21 00 00       	call   80104620 <memset>

  if(kmem.use_lock)
80102517:	8b 15 14 36 11 80    	mov    0x80113614,%edx
8010251d:	83 c4 10             	add    $0x10,%esp
80102520:	85 d2                	test   %edx,%edx
80102522:	75 2c                	jne    80102550 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102524:	a1 18 36 11 80       	mov    0x80113618,%eax
80102529:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010252b:	a1 14 36 11 80       	mov    0x80113614,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
80102530:	89 1d 18 36 11 80    	mov    %ebx,0x80113618
  if(kmem.use_lock)
80102536:	85 c0                	test   %eax,%eax
80102538:	75 06                	jne    80102540 <kfree+0x60>
    release(&kmem.lock);
}
8010253a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010253d:	c9                   	leave  
8010253e:	c3                   	ret    
8010253f:	90                   	nop
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102540:	c7 45 08 e0 35 11 80 	movl   $0x801135e0,0x8(%ebp)
}
80102547:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010254a:	c9                   	leave  
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
8010254b:	e9 80 20 00 00       	jmp    801045d0 <release>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102550:	83 ec 0c             	sub    $0xc,%esp
80102553:	68 e0 35 11 80       	push   $0x801135e0
80102558:	e8 53 1f 00 00       	call   801044b0 <acquire>
8010255d:	83 c4 10             	add    $0x10,%esp
80102560:	eb c2                	jmp    80102524 <kfree+0x44>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
80102562:	83 ec 0c             	sub    $0xc,%esp
80102565:	68 66 74 10 80       	push   $0x80107466
8010256a:	e8 01 de ff ff       	call   80100370 <panic>
8010256f:	90                   	nop

80102570 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102570:	55                   	push   %ebp
80102571:	89 e5                	mov    %esp,%ebp
80102573:	56                   	push   %esi
80102574:	53                   	push   %ebx
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102575:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102578:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010257b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102581:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102587:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010258d:	39 de                	cmp    %ebx,%esi
8010258f:	72 23                	jb     801025b4 <freerange+0x44>
80102591:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102598:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010259e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025a1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801025a7:	50                   	push   %eax
801025a8:	e8 33 ff ff ff       	call   801024e0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025ad:	83 c4 10             	add    $0x10,%esp
801025b0:	39 f3                	cmp    %esi,%ebx
801025b2:	76 e4                	jbe    80102598 <freerange+0x28>
    kfree(p);
}
801025b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025b7:	5b                   	pop    %ebx
801025b8:	5e                   	pop    %esi
801025b9:	5d                   	pop    %ebp
801025ba:	c3                   	ret    
801025bb:	90                   	nop
801025bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801025c0 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
801025c0:	55                   	push   %ebp
801025c1:	89 e5                	mov    %esp,%ebp
801025c3:	56                   	push   %esi
801025c4:	53                   	push   %ebx
801025c5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801025c8:	83 ec 08             	sub    $0x8,%esp
801025cb:	68 6c 74 10 80       	push   $0x8010746c
801025d0:	68 e0 35 11 80       	push   $0x801135e0
801025d5:	e8 d6 1d 00 00       	call   801043b0 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801025da:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025dd:	83 c4 10             	add    $0x10,%esp
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
801025e0:	c7 05 14 36 11 80 00 	movl   $0x0,0x80113614
801025e7:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801025ea:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801025f0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025f6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801025fc:	39 de                	cmp    %ebx,%esi
801025fe:	72 1c                	jb     8010261c <kinit1+0x5c>
    kfree(p);
80102600:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102606:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102609:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010260f:	50                   	push   %eax
80102610:	e8 cb fe ff ff       	call   801024e0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102615:	83 c4 10             	add    $0x10,%esp
80102618:	39 de                	cmp    %ebx,%esi
8010261a:	73 e4                	jae    80102600 <kinit1+0x40>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
8010261c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010261f:	5b                   	pop    %ebx
80102620:	5e                   	pop    %esi
80102621:	5d                   	pop    %ebp
80102622:	c3                   	ret    
80102623:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102630 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102630:	55                   	push   %ebp
80102631:	89 e5                	mov    %esp,%ebp
80102633:	56                   	push   %esi
80102634:	53                   	push   %ebx

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102635:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
80102638:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010263b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102641:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102647:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010264d:	39 de                	cmp    %ebx,%esi
8010264f:	72 23                	jb     80102674 <kinit2+0x44>
80102651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102658:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010265e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102661:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102667:	50                   	push   %eax
80102668:	e8 73 fe ff ff       	call   801024e0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010266d:	83 c4 10             	add    $0x10,%esp
80102670:	39 de                	cmp    %ebx,%esi
80102672:	73 e4                	jae    80102658 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
80102674:	c7 05 14 36 11 80 01 	movl   $0x1,0x80113614
8010267b:	00 00 00 
}
8010267e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102681:	5b                   	pop    %ebx
80102682:	5e                   	pop    %esi
80102683:	5d                   	pop    %ebp
80102684:	c3                   	ret    
80102685:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102690 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102690:	55                   	push   %ebp
80102691:	89 e5                	mov    %esp,%ebp
80102693:	53                   	push   %ebx
80102694:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102697:	a1 14 36 11 80       	mov    0x80113614,%eax
8010269c:	85 c0                	test   %eax,%eax
8010269e:	75 30                	jne    801026d0 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
801026a0:	8b 1d 18 36 11 80    	mov    0x80113618,%ebx
  if(r)
801026a6:	85 db                	test   %ebx,%ebx
801026a8:	74 1c                	je     801026c6 <kalloc+0x36>
    kmem.freelist = r->next;
801026aa:	8b 13                	mov    (%ebx),%edx
801026ac:	89 15 18 36 11 80    	mov    %edx,0x80113618
  if(kmem.use_lock)
801026b2:	85 c0                	test   %eax,%eax
801026b4:	74 10                	je     801026c6 <kalloc+0x36>
    release(&kmem.lock);
801026b6:	83 ec 0c             	sub    $0xc,%esp
801026b9:	68 e0 35 11 80       	push   $0x801135e0
801026be:	e8 0d 1f 00 00       	call   801045d0 <release>
801026c3:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
}
801026c6:	89 d8                	mov    %ebx,%eax
801026c8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026cb:	c9                   	leave  
801026cc:	c3                   	ret    
801026cd:	8d 76 00             	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
801026d0:	83 ec 0c             	sub    $0xc,%esp
801026d3:	68 e0 35 11 80       	push   $0x801135e0
801026d8:	e8 d3 1d 00 00       	call   801044b0 <acquire>
  r = kmem.freelist;
801026dd:	8b 1d 18 36 11 80    	mov    0x80113618,%ebx
  if(r)
801026e3:	83 c4 10             	add    $0x10,%esp
801026e6:	a1 14 36 11 80       	mov    0x80113614,%eax
801026eb:	85 db                	test   %ebx,%ebx
801026ed:	75 bb                	jne    801026aa <kalloc+0x1a>
801026ef:	eb c1                	jmp    801026b2 <kalloc+0x22>
801026f1:	66 90                	xchg   %ax,%ax
801026f3:	66 90                	xchg   %ax,%ax
801026f5:	66 90                	xchg   %ax,%ax
801026f7:	66 90                	xchg   %ax,%ax
801026f9:	66 90                	xchg   %ax,%ax
801026fb:	66 90                	xchg   %ax,%ax
801026fd:	66 90                	xchg   %ax,%ax
801026ff:	90                   	nop

80102700 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102700:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102701:	ba 64 00 00 00       	mov    $0x64,%edx
80102706:	89 e5                	mov    %esp,%ebp
80102708:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102709:	a8 01                	test   $0x1,%al
8010270b:	0f 84 af 00 00 00    	je     801027c0 <kbdgetc+0xc0>
80102711:	ba 60 00 00 00       	mov    $0x60,%edx
80102716:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102717:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
8010271a:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102720:	74 7e                	je     801027a0 <kbdgetc+0xa0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102722:	84 c0                	test   %al,%al
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102724:	8b 0d 54 b5 10 80    	mov    0x8010b554,%ecx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
8010272a:	79 24                	jns    80102750 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
8010272c:	f6 c1 40             	test   $0x40,%cl
8010272f:	75 05                	jne    80102736 <kbdgetc+0x36>
80102731:	89 c2                	mov    %eax,%edx
80102733:	83 e2 7f             	and    $0x7f,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102736:	0f b6 82 a0 75 10 80 	movzbl -0x7fef8a60(%edx),%eax
8010273d:	83 c8 40             	or     $0x40,%eax
80102740:	0f b6 c0             	movzbl %al,%eax
80102743:	f7 d0                	not    %eax
80102745:	21 c8                	and    %ecx,%eax
80102747:	a3 54 b5 10 80       	mov    %eax,0x8010b554
    return 0;
8010274c:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010274e:	5d                   	pop    %ebp
8010274f:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102750:	f6 c1 40             	test   $0x40,%cl
80102753:	74 09                	je     8010275e <kbdgetc+0x5e>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102755:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102758:	83 e1 bf             	and    $0xffffffbf,%ecx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010275b:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
8010275e:	0f b6 82 a0 75 10 80 	movzbl -0x7fef8a60(%edx),%eax
80102765:	09 c1                	or     %eax,%ecx
80102767:	0f b6 82 a0 74 10 80 	movzbl -0x7fef8b60(%edx),%eax
8010276e:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102770:	89 c8                	mov    %ecx,%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80102772:	89 0d 54 b5 10 80    	mov    %ecx,0x8010b554
  c = charcode[shift & (CTL | SHIFT)][data];
80102778:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010277b:	83 e1 08             	and    $0x8,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
8010277e:	8b 04 85 80 74 10 80 	mov    -0x7fef8b80(,%eax,4),%eax
80102785:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102789:	74 c3                	je     8010274e <kbdgetc+0x4e>
    if('a' <= c && c <= 'z')
8010278b:	8d 50 9f             	lea    -0x61(%eax),%edx
8010278e:	83 fa 19             	cmp    $0x19,%edx
80102791:	77 1d                	ja     801027b0 <kbdgetc+0xb0>
      c += 'A' - 'a';
80102793:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102796:	5d                   	pop    %ebp
80102797:	c3                   	ret    
80102798:	90                   	nop
80102799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
801027a0:	31 c0                	xor    %eax,%eax
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
801027a2:	83 0d 54 b5 10 80 40 	orl    $0x40,0x8010b554
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801027a9:	5d                   	pop    %ebp
801027aa:	c3                   	ret    
801027ab:	90                   	nop
801027ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
801027b0:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801027b3:	8d 50 20             	lea    0x20(%eax),%edx
  }
  return c;
}
801027b6:	5d                   	pop    %ebp
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
801027b7:	83 f9 19             	cmp    $0x19,%ecx
801027ba:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
801027bd:	c3                   	ret    
801027be:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
801027c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801027c5:	5d                   	pop    %ebp
801027c6:	c3                   	ret    
801027c7:	89 f6                	mov    %esi,%esi
801027c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027d0 <kbdintr>:

void
kbdintr(void)
{
801027d0:	55                   	push   %ebp
801027d1:	89 e5                	mov    %esp,%ebp
801027d3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801027d6:	68 00 27 10 80       	push   $0x80102700
801027db:	e8 b0 e1 ff ff       	call   80100990 <consoleintr>
}
801027e0:	83 c4 10             	add    $0x10,%esp
801027e3:	c9                   	leave  
801027e4:	c3                   	ret    
801027e5:	66 90                	xchg   %ax,%ax
801027e7:	66 90                	xchg   %ax,%ax
801027e9:	66 90                	xchg   %ax,%ax
801027eb:	66 90                	xchg   %ax,%ax
801027ed:	66 90                	xchg   %ax,%ax
801027ef:	90                   	nop

801027f0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801027f0:	a1 1c 36 11 80       	mov    0x8011361c,%eax
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
801027f5:	55                   	push   %ebp
801027f6:	89 e5                	mov    %esp,%ebp
  if(!lapic)
801027f8:	85 c0                	test   %eax,%eax
801027fa:	0f 84 c8 00 00 00    	je     801028c8 <lapicinit+0xd8>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102800:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102807:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010280a:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010280d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102814:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102817:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010281a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102821:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102824:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102827:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010282e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102831:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102834:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010283b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010283e:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102841:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102848:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010284b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010284e:	8b 50 30             	mov    0x30(%eax),%edx
80102851:	c1 ea 10             	shr    $0x10,%edx
80102854:	80 fa 03             	cmp    $0x3,%dl
80102857:	77 77                	ja     801028d0 <lapicinit+0xe0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102859:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102860:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102863:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102866:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010286d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102870:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102873:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010287a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010287d:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102880:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102887:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010288a:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010288d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102894:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102897:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010289a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801028a1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801028a4:	8b 50 20             	mov    0x20(%eax),%edx
801028a7:	89 f6                	mov    %esi,%esi
801028a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801028b0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801028b6:	80 e6 10             	and    $0x10,%dh
801028b9:	75 f5                	jne    801028b0 <lapicinit+0xc0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028bb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801028c2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028c5:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801028c8:	5d                   	pop    %ebp
801028c9:	c3                   	ret    
801028ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028d0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801028d7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801028da:	8b 50 20             	mov    0x20(%eax),%edx
801028dd:	e9 77 ff ff ff       	jmp    80102859 <lapicinit+0x69>
801028e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801028f0 <lapicid>:
}

int
lapicid(void)
{
  if (!lapic)
801028f0:	a1 1c 36 11 80       	mov    0x8011361c,%eax
  lapicw(TPR, 0);
}

int
lapicid(void)
{
801028f5:	55                   	push   %ebp
801028f6:	89 e5                	mov    %esp,%ebp
  if (!lapic)
801028f8:	85 c0                	test   %eax,%eax
801028fa:	74 0c                	je     80102908 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
801028fc:	8b 40 20             	mov    0x20(%eax),%eax
}
801028ff:	5d                   	pop    %ebp
int
lapicid(void)
{
  if (!lapic)
    return 0;
  return lapic[ID] >> 24;
80102900:	c1 e8 18             	shr    $0x18,%eax
}
80102903:	c3                   	ret    
80102904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

int
lapicid(void)
{
  if (!lapic)
    return 0;
80102908:	31 c0                	xor    %eax,%eax
  return lapic[ID] >> 24;
}
8010290a:	5d                   	pop    %ebp
8010290b:	c3                   	ret    
8010290c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102910 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102910:	a1 1c 36 11 80       	mov    0x8011361c,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102915:	55                   	push   %ebp
80102916:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102918:	85 c0                	test   %eax,%eax
8010291a:	74 0d                	je     80102929 <lapiceoi+0x19>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010291c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102923:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102926:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
80102929:	5d                   	pop    %ebp
8010292a:	c3                   	ret    
8010292b:	90                   	nop
8010292c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102930 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102930:	55                   	push   %ebp
80102931:	89 e5                	mov    %esp,%ebp
}
80102933:	5d                   	pop    %ebp
80102934:	c3                   	ret    
80102935:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102940 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102940:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102941:	ba 70 00 00 00       	mov    $0x70,%edx
80102946:	b8 0f 00 00 00       	mov    $0xf,%eax
8010294b:	89 e5                	mov    %esp,%ebp
8010294d:	53                   	push   %ebx
8010294e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102951:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102954:	ee                   	out    %al,(%dx)
80102955:	ba 71 00 00 00       	mov    $0x71,%edx
8010295a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010295f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102960:	31 c0                	xor    %eax,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102962:	c1 e3 18             	shl    $0x18,%ebx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102965:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010296b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010296d:	c1 e9 0c             	shr    $0xc,%ecx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102970:	c1 e8 04             	shr    $0x4,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102973:	89 da                	mov    %ebx,%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102975:	80 cd 06             	or     $0x6,%ch
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102978:	66 a3 69 04 00 80    	mov    %ax,0x80000469

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010297e:	a1 1c 36 11 80       	mov    0x8011361c,%eax
80102983:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102989:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010298c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102993:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102996:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102999:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801029a0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029a3:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801029a6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029ac:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801029af:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029b5:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801029b8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029be:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801029c1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029c7:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801029ca:	5b                   	pop    %ebx
801029cb:	5d                   	pop    %ebp
801029cc:	c3                   	ret    
801029cd:	8d 76 00             	lea    0x0(%esi),%esi

801029d0 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
801029d0:	55                   	push   %ebp
801029d1:	ba 70 00 00 00       	mov    $0x70,%edx
801029d6:	b8 0b 00 00 00       	mov    $0xb,%eax
801029db:	89 e5                	mov    %esp,%ebp
801029dd:	57                   	push   %edi
801029de:	56                   	push   %esi
801029df:	53                   	push   %ebx
801029e0:	83 ec 4c             	sub    $0x4c,%esp
801029e3:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029e4:	ba 71 00 00 00       	mov    $0x71,%edx
801029e9:	ec                   	in     (%dx),%al
801029ea:	83 e0 04             	and    $0x4,%eax
801029ed:	8d 75 d0             	lea    -0x30(%ebp),%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029f0:	31 db                	xor    %ebx,%ebx
801029f2:	88 45 b7             	mov    %al,-0x49(%ebp)
801029f5:	bf 70 00 00 00       	mov    $0x70,%edi
801029fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102a00:	89 d8                	mov    %ebx,%eax
80102a02:	89 fa                	mov    %edi,%edx
80102a04:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a05:	b9 71 00 00 00       	mov    $0x71,%ecx
80102a0a:	89 ca                	mov    %ecx,%edx
80102a0c:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
80102a0d:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a10:	89 fa                	mov    %edi,%edx
80102a12:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102a15:	b8 02 00 00 00       	mov    $0x2,%eax
80102a1a:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a1b:	89 ca                	mov    %ecx,%edx
80102a1d:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
80102a1e:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a21:	89 fa                	mov    %edi,%edx
80102a23:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102a26:	b8 04 00 00 00       	mov    $0x4,%eax
80102a2b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a2c:	89 ca                	mov    %ecx,%edx
80102a2e:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
80102a2f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a32:	89 fa                	mov    %edi,%edx
80102a34:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102a37:	b8 07 00 00 00       	mov    $0x7,%eax
80102a3c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a3d:	89 ca                	mov    %ecx,%edx
80102a3f:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102a40:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a43:	89 fa                	mov    %edi,%edx
80102a45:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102a48:	b8 08 00 00 00       	mov    $0x8,%eax
80102a4d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a4e:	89 ca                	mov    %ecx,%edx
80102a50:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102a51:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a54:	89 fa                	mov    %edi,%edx
80102a56:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102a59:	b8 09 00 00 00       	mov    $0x9,%eax
80102a5e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a5f:	89 ca                	mov    %ecx,%edx
80102a61:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102a62:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a65:	89 fa                	mov    %edi,%edx
80102a67:	89 45 cc             	mov    %eax,-0x34(%ebp)
80102a6a:	b8 0a 00 00 00       	mov    $0xa,%eax
80102a6f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a70:	89 ca                	mov    %ecx,%edx
80102a72:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102a73:	84 c0                	test   %al,%al
80102a75:	78 89                	js     80102a00 <cmostime+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a77:	89 d8                	mov    %ebx,%eax
80102a79:	89 fa                	mov    %edi,%edx
80102a7b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a7c:	89 ca                	mov    %ecx,%edx
80102a7e:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
80102a7f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a82:	89 fa                	mov    %edi,%edx
80102a84:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102a87:	b8 02 00 00 00       	mov    $0x2,%eax
80102a8c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a8d:	89 ca                	mov    %ecx,%edx
80102a8f:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
80102a90:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a93:	89 fa                	mov    %edi,%edx
80102a95:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102a98:	b8 04 00 00 00       	mov    $0x4,%eax
80102a9d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a9e:	89 ca                	mov    %ecx,%edx
80102aa0:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
80102aa1:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102aa4:	89 fa                	mov    %edi,%edx
80102aa6:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102aa9:	b8 07 00 00 00       	mov    $0x7,%eax
80102aae:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102aaf:	89 ca                	mov    %ecx,%edx
80102ab1:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102ab2:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ab5:	89 fa                	mov    %edi,%edx
80102ab7:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102aba:	b8 08 00 00 00       	mov    $0x8,%eax
80102abf:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ac0:	89 ca                	mov    %ecx,%edx
80102ac2:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102ac3:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ac6:	89 fa                	mov    %edi,%edx
80102ac8:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102acb:	b8 09 00 00 00       	mov    $0x9,%eax
80102ad0:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ad1:	89 ca                	mov    %ecx,%edx
80102ad3:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102ad4:	0f b6 c0             	movzbl %al,%eax
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102ad7:	83 ec 04             	sub    $0x4,%esp
  r->second = cmos_read(SECS);
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
80102ada:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102add:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102ae0:	6a 18                	push   $0x18
80102ae2:	56                   	push   %esi
80102ae3:	50                   	push   %eax
80102ae4:	e8 87 1b 00 00       	call   80104670 <memcmp>
80102ae9:	83 c4 10             	add    $0x10,%esp
80102aec:	85 c0                	test   %eax,%eax
80102aee:	0f 85 0c ff ff ff    	jne    80102a00 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80102af4:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
80102af8:	75 78                	jne    80102b72 <cmostime+0x1a2>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102afa:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102afd:	89 c2                	mov    %eax,%edx
80102aff:	83 e0 0f             	and    $0xf,%eax
80102b02:	c1 ea 04             	shr    $0x4,%edx
80102b05:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b08:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b0b:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102b0e:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b11:	89 c2                	mov    %eax,%edx
80102b13:	83 e0 0f             	and    $0xf,%eax
80102b16:	c1 ea 04             	shr    $0x4,%edx
80102b19:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b1c:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b1f:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102b22:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b25:	89 c2                	mov    %eax,%edx
80102b27:	83 e0 0f             	and    $0xf,%eax
80102b2a:	c1 ea 04             	shr    $0x4,%edx
80102b2d:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b30:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b33:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102b36:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b39:	89 c2                	mov    %eax,%edx
80102b3b:	83 e0 0f             	and    $0xf,%eax
80102b3e:	c1 ea 04             	shr    $0x4,%edx
80102b41:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b44:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b47:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102b4a:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b4d:	89 c2                	mov    %eax,%edx
80102b4f:	83 e0 0f             	and    $0xf,%eax
80102b52:	c1 ea 04             	shr    $0x4,%edx
80102b55:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b58:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b5b:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102b5e:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b61:	89 c2                	mov    %eax,%edx
80102b63:	83 e0 0f             	and    $0xf,%eax
80102b66:	c1 ea 04             	shr    $0x4,%edx
80102b69:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b6c:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b6f:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102b72:	8b 75 08             	mov    0x8(%ebp),%esi
80102b75:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b78:	89 06                	mov    %eax,(%esi)
80102b7a:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b7d:	89 46 04             	mov    %eax,0x4(%esi)
80102b80:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b83:	89 46 08             	mov    %eax,0x8(%esi)
80102b86:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b89:	89 46 0c             	mov    %eax,0xc(%esi)
80102b8c:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b8f:	89 46 10             	mov    %eax,0x10(%esi)
80102b92:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b95:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102b98:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102b9f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ba2:	5b                   	pop    %ebx
80102ba3:	5e                   	pop    %esi
80102ba4:	5f                   	pop    %edi
80102ba5:	5d                   	pop    %ebp
80102ba6:	c3                   	ret    
80102ba7:	66 90                	xchg   %ax,%ax
80102ba9:	66 90                	xchg   %ax,%ax
80102bab:	66 90                	xchg   %ax,%ax
80102bad:	66 90                	xchg   %ax,%ax
80102baf:	90                   	nop

80102bb0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102bb0:	8b 0d 68 36 11 80    	mov    0x80113668,%ecx
80102bb6:	85 c9                	test   %ecx,%ecx
80102bb8:	0f 8e 85 00 00 00    	jle    80102c43 <install_trans+0x93>
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102bbe:	55                   	push   %ebp
80102bbf:	89 e5                	mov    %esp,%ebp
80102bc1:	57                   	push   %edi
80102bc2:	56                   	push   %esi
80102bc3:	53                   	push   %ebx
80102bc4:	31 db                	xor    %ebx,%ebx
80102bc6:	83 ec 0c             	sub    $0xc,%esp
80102bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102bd0:	a1 54 36 11 80       	mov    0x80113654,%eax
80102bd5:	83 ec 08             	sub    $0x8,%esp
80102bd8:	01 d8                	add    %ebx,%eax
80102bda:	83 c0 01             	add    $0x1,%eax
80102bdd:	50                   	push   %eax
80102bde:	ff 35 64 36 11 80    	pushl  0x80113664
80102be4:	e8 e7 d4 ff ff       	call   801000d0 <bread>
80102be9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102beb:	58                   	pop    %eax
80102bec:	5a                   	pop    %edx
80102bed:	ff 34 9d 6c 36 11 80 	pushl  -0x7feec994(,%ebx,4)
80102bf4:	ff 35 64 36 11 80    	pushl  0x80113664
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102bfa:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bfd:	e8 ce d4 ff ff       	call   801000d0 <bread>
80102c02:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102c04:	8d 47 5c             	lea    0x5c(%edi),%eax
80102c07:	83 c4 0c             	add    $0xc,%esp
80102c0a:	68 00 02 00 00       	push   $0x200
80102c0f:	50                   	push   %eax
80102c10:	8d 46 5c             	lea    0x5c(%esi),%eax
80102c13:	50                   	push   %eax
80102c14:	e8 b7 1a 00 00       	call   801046d0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102c19:	89 34 24             	mov    %esi,(%esp)
80102c1c:	e8 7f d5 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102c21:	89 3c 24             	mov    %edi,(%esp)
80102c24:	e8 b7 d5 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102c29:	89 34 24             	mov    %esi,(%esp)
80102c2c:	e8 af d5 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102c31:	83 c4 10             	add    $0x10,%esp
80102c34:	39 1d 68 36 11 80    	cmp    %ebx,0x80113668
80102c3a:	7f 94                	jg     80102bd0 <install_trans+0x20>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102c3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c3f:	5b                   	pop    %ebx
80102c40:	5e                   	pop    %esi
80102c41:	5f                   	pop    %edi
80102c42:	5d                   	pop    %ebp
80102c43:	f3 c3                	repz ret 
80102c45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c50 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102c50:	55                   	push   %ebp
80102c51:	89 e5                	mov    %esp,%ebp
80102c53:	53                   	push   %ebx
80102c54:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c57:	ff 35 54 36 11 80    	pushl  0x80113654
80102c5d:	ff 35 64 36 11 80    	pushl  0x80113664
80102c63:	e8 68 d4 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102c68:	8b 0d 68 36 11 80    	mov    0x80113668,%ecx
  for (i = 0; i < log.lh.n; i++) {
80102c6e:	83 c4 10             	add    $0x10,%esp
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102c71:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102c73:	85 c9                	test   %ecx,%ecx
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102c75:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102c78:	7e 1f                	jle    80102c99 <write_head+0x49>
80102c7a:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80102c81:	31 d2                	xor    %edx,%edx
80102c83:	90                   	nop
80102c84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102c88:	8b 8a 6c 36 11 80    	mov    -0x7feec994(%edx),%ecx
80102c8e:	89 4c 13 60          	mov    %ecx,0x60(%ebx,%edx,1)
80102c92:	83 c2 04             	add    $0x4,%edx
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102c95:	39 c2                	cmp    %eax,%edx
80102c97:	75 ef                	jne    80102c88 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102c99:	83 ec 0c             	sub    $0xc,%esp
80102c9c:	53                   	push   %ebx
80102c9d:	e8 fe d4 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102ca2:	89 1c 24             	mov    %ebx,(%esp)
80102ca5:	e8 36 d5 ff ff       	call   801001e0 <brelse>
}
80102caa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102cad:	c9                   	leave  
80102cae:	c3                   	ret    
80102caf:	90                   	nop

80102cb0 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102cb0:	55                   	push   %ebp
80102cb1:	89 e5                	mov    %esp,%ebp
80102cb3:	53                   	push   %ebx
80102cb4:	83 ec 2c             	sub    $0x2c,%esp
80102cb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102cba:	68 a0 76 10 80       	push   $0x801076a0
80102cbf:	68 20 36 11 80       	push   $0x80113620
80102cc4:	e8 e7 16 00 00       	call   801043b0 <initlock>
  readsb(dev, &sb);
80102cc9:	58                   	pop    %eax
80102cca:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102ccd:	5a                   	pop    %edx
80102cce:	50                   	push   %eax
80102ccf:	53                   	push   %ebx
80102cd0:	e8 db e8 ff ff       	call   801015b0 <readsb>
  log.start = sb.logstart;
  log.size = sb.nlog;
80102cd5:	8b 55 e8             	mov    -0x18(%ebp),%edx
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102cd8:	8b 45 ec             	mov    -0x14(%ebp),%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102cdb:	59                   	pop    %ecx
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102cdc:	89 1d 64 36 11 80    	mov    %ebx,0x80113664

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102ce2:	89 15 58 36 11 80    	mov    %edx,0x80113658
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102ce8:	a3 54 36 11 80       	mov    %eax,0x80113654

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102ced:	5a                   	pop    %edx
80102cee:	50                   	push   %eax
80102cef:	53                   	push   %ebx
80102cf0:	e8 db d3 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102cf5:	8b 48 5c             	mov    0x5c(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102cf8:	83 c4 10             	add    $0x10,%esp
80102cfb:	85 c9                	test   %ecx,%ecx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102cfd:	89 0d 68 36 11 80    	mov    %ecx,0x80113668
  for (i = 0; i < log.lh.n; i++) {
80102d03:	7e 1c                	jle    80102d21 <initlog+0x71>
80102d05:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102d0c:	31 d2                	xor    %edx,%edx
80102d0e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102d10:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102d14:	83 c2 04             	add    $0x4,%edx
80102d17:	89 8a 68 36 11 80    	mov    %ecx,-0x7feec998(%edx)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102d1d:	39 da                	cmp    %ebx,%edx
80102d1f:	75 ef                	jne    80102d10 <initlog+0x60>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102d21:	83 ec 0c             	sub    $0xc,%esp
80102d24:	50                   	push   %eax
80102d25:	e8 b6 d4 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102d2a:	e8 81 fe ff ff       	call   80102bb0 <install_trans>
  log.lh.n = 0;
80102d2f:	c7 05 68 36 11 80 00 	movl   $0x0,0x80113668
80102d36:	00 00 00 
  write_head(); // clear the log
80102d39:	e8 12 ff ff ff       	call   80102c50 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102d3e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d41:	c9                   	leave  
80102d42:	c3                   	ret    
80102d43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102d50 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102d50:	55                   	push   %ebp
80102d51:	89 e5                	mov    %esp,%ebp
80102d53:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102d56:	68 20 36 11 80       	push   $0x80113620
80102d5b:	e8 50 17 00 00       	call   801044b0 <acquire>
80102d60:	83 c4 10             	add    $0x10,%esp
80102d63:	eb 18                	jmp    80102d7d <begin_op+0x2d>
80102d65:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102d68:	83 ec 08             	sub    $0x8,%esp
80102d6b:	68 20 36 11 80       	push   $0x80113620
80102d70:	68 20 36 11 80       	push   $0x80113620
80102d75:	e8 c6 11 00 00       	call   80103f40 <sleep>
80102d7a:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102d7d:	a1 60 36 11 80       	mov    0x80113660,%eax
80102d82:	85 c0                	test   %eax,%eax
80102d84:	75 e2                	jne    80102d68 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102d86:	a1 5c 36 11 80       	mov    0x8011365c,%eax
80102d8b:	8b 15 68 36 11 80    	mov    0x80113668,%edx
80102d91:	83 c0 01             	add    $0x1,%eax
80102d94:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102d97:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102d9a:	83 fa 1e             	cmp    $0x1e,%edx
80102d9d:	7f c9                	jg     80102d68 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102d9f:	83 ec 0c             	sub    $0xc,%esp
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102da2:	a3 5c 36 11 80       	mov    %eax,0x8011365c
      release(&log.lock);
80102da7:	68 20 36 11 80       	push   $0x80113620
80102dac:	e8 1f 18 00 00       	call   801045d0 <release>
      break;
    }
  }
}
80102db1:	83 c4 10             	add    $0x10,%esp
80102db4:	c9                   	leave  
80102db5:	c3                   	ret    
80102db6:	8d 76 00             	lea    0x0(%esi),%esi
80102db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102dc0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102dc0:	55                   	push   %ebp
80102dc1:	89 e5                	mov    %esp,%ebp
80102dc3:	57                   	push   %edi
80102dc4:	56                   	push   %esi
80102dc5:	53                   	push   %ebx
80102dc6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102dc9:	68 20 36 11 80       	push   $0x80113620
80102dce:	e8 dd 16 00 00       	call   801044b0 <acquire>
  log.outstanding -= 1;
80102dd3:	a1 5c 36 11 80       	mov    0x8011365c,%eax
  if(log.committing)
80102dd8:	8b 1d 60 36 11 80    	mov    0x80113660,%ebx
80102dde:	83 c4 10             	add    $0x10,%esp
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102de1:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102de4:	85 db                	test   %ebx,%ebx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102de6:	a3 5c 36 11 80       	mov    %eax,0x8011365c
  if(log.committing)
80102deb:	0f 85 23 01 00 00    	jne    80102f14 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102df1:	85 c0                	test   %eax,%eax
80102df3:	0f 85 f7 00 00 00    	jne    80102ef0 <end_op+0x130>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102df9:	83 ec 0c             	sub    $0xc,%esp
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102dfc:	c7 05 60 36 11 80 01 	movl   $0x1,0x80113660
80102e03:	00 00 00 
}

static void
commit()
{
  if (log.lh.n > 0) {
80102e06:	31 db                	xor    %ebx,%ebx
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102e08:	68 20 36 11 80       	push   $0x80113620
80102e0d:	e8 be 17 00 00       	call   801045d0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102e12:	8b 0d 68 36 11 80    	mov    0x80113668,%ecx
80102e18:	83 c4 10             	add    $0x10,%esp
80102e1b:	85 c9                	test   %ecx,%ecx
80102e1d:	0f 8e 8a 00 00 00    	jle    80102ead <end_op+0xed>
80102e23:	90                   	nop
80102e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102e28:	a1 54 36 11 80       	mov    0x80113654,%eax
80102e2d:	83 ec 08             	sub    $0x8,%esp
80102e30:	01 d8                	add    %ebx,%eax
80102e32:	83 c0 01             	add    $0x1,%eax
80102e35:	50                   	push   %eax
80102e36:	ff 35 64 36 11 80    	pushl  0x80113664
80102e3c:	e8 8f d2 ff ff       	call   801000d0 <bread>
80102e41:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e43:	58                   	pop    %eax
80102e44:	5a                   	pop    %edx
80102e45:	ff 34 9d 6c 36 11 80 	pushl  -0x7feec994(,%ebx,4)
80102e4c:	ff 35 64 36 11 80    	pushl  0x80113664
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102e52:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e55:	e8 76 d2 ff ff       	call   801000d0 <bread>
80102e5a:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102e5c:	8d 40 5c             	lea    0x5c(%eax),%eax
80102e5f:	83 c4 0c             	add    $0xc,%esp
80102e62:	68 00 02 00 00       	push   $0x200
80102e67:	50                   	push   %eax
80102e68:	8d 46 5c             	lea    0x5c(%esi),%eax
80102e6b:	50                   	push   %eax
80102e6c:	e8 5f 18 00 00       	call   801046d0 <memmove>
    bwrite(to);  // write the log
80102e71:	89 34 24             	mov    %esi,(%esp)
80102e74:	e8 27 d3 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102e79:	89 3c 24             	mov    %edi,(%esp)
80102e7c:	e8 5f d3 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102e81:	89 34 24             	mov    %esi,(%esp)
80102e84:	e8 57 d3 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102e89:	83 c4 10             	add    $0x10,%esp
80102e8c:	3b 1d 68 36 11 80    	cmp    0x80113668,%ebx
80102e92:	7c 94                	jl     80102e28 <end_op+0x68>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102e94:	e8 b7 fd ff ff       	call   80102c50 <write_head>
    install_trans(); // Now install writes to home locations
80102e99:	e8 12 fd ff ff       	call   80102bb0 <install_trans>
    log.lh.n = 0;
80102e9e:	c7 05 68 36 11 80 00 	movl   $0x0,0x80113668
80102ea5:	00 00 00 
    write_head();    // Erase the transaction from the log
80102ea8:	e8 a3 fd ff ff       	call   80102c50 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102ead:	83 ec 0c             	sub    $0xc,%esp
80102eb0:	68 20 36 11 80       	push   $0x80113620
80102eb5:	e8 f6 15 00 00       	call   801044b0 <acquire>
    log.committing = 0;
    wakeup(&log);
80102eba:	c7 04 24 20 36 11 80 	movl   $0x80113620,(%esp)
  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
    log.committing = 0;
80102ec1:	c7 05 60 36 11 80 00 	movl   $0x0,0x80113660
80102ec8:	00 00 00 
    wakeup(&log);
80102ecb:	e8 20 12 00 00       	call   801040f0 <wakeup>
    release(&log.lock);
80102ed0:	c7 04 24 20 36 11 80 	movl   $0x80113620,(%esp)
80102ed7:	e8 f4 16 00 00       	call   801045d0 <release>
80102edc:	83 c4 10             	add    $0x10,%esp
  }
}
80102edf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ee2:	5b                   	pop    %ebx
80102ee3:	5e                   	pop    %esi
80102ee4:	5f                   	pop    %edi
80102ee5:	5d                   	pop    %ebp
80102ee6:	c3                   	ret    
80102ee7:	89 f6                	mov    %esi,%esi
80102ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
80102ef0:	83 ec 0c             	sub    $0xc,%esp
80102ef3:	68 20 36 11 80       	push   $0x80113620
80102ef8:	e8 f3 11 00 00       	call   801040f0 <wakeup>
  }
  release(&log.lock);
80102efd:	c7 04 24 20 36 11 80 	movl   $0x80113620,(%esp)
80102f04:	e8 c7 16 00 00       	call   801045d0 <release>
80102f09:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
80102f0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f0f:	5b                   	pop    %ebx
80102f10:	5e                   	pop    %esi
80102f11:	5f                   	pop    %edi
80102f12:	5d                   	pop    %ebp
80102f13:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102f14:	83 ec 0c             	sub    $0xc,%esp
80102f17:	68 a4 76 10 80       	push   $0x801076a4
80102f1c:	e8 4f d4 ff ff       	call   80100370 <panic>
80102f21:	eb 0d                	jmp    80102f30 <log_write>
80102f23:	90                   	nop
80102f24:	90                   	nop
80102f25:	90                   	nop
80102f26:	90                   	nop
80102f27:	90                   	nop
80102f28:	90                   	nop
80102f29:	90                   	nop
80102f2a:	90                   	nop
80102f2b:	90                   	nop
80102f2c:	90                   	nop
80102f2d:	90                   	nop
80102f2e:	90                   	nop
80102f2f:	90                   	nop

80102f30 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102f30:	55                   	push   %ebp
80102f31:	89 e5                	mov    %esp,%ebp
80102f33:	53                   	push   %ebx
80102f34:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f37:	8b 15 68 36 11 80    	mov    0x80113668,%edx
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102f3d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f40:	83 fa 1d             	cmp    $0x1d,%edx
80102f43:	0f 8f 97 00 00 00    	jg     80102fe0 <log_write+0xb0>
80102f49:	a1 58 36 11 80       	mov    0x80113658,%eax
80102f4e:	83 e8 01             	sub    $0x1,%eax
80102f51:	39 c2                	cmp    %eax,%edx
80102f53:	0f 8d 87 00 00 00    	jge    80102fe0 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102f59:	a1 5c 36 11 80       	mov    0x8011365c,%eax
80102f5e:	85 c0                	test   %eax,%eax
80102f60:	0f 8e 87 00 00 00    	jle    80102fed <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102f66:	83 ec 0c             	sub    $0xc,%esp
80102f69:	68 20 36 11 80       	push   $0x80113620
80102f6e:	e8 3d 15 00 00       	call   801044b0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102f73:	8b 15 68 36 11 80    	mov    0x80113668,%edx
80102f79:	83 c4 10             	add    $0x10,%esp
80102f7c:	83 fa 00             	cmp    $0x0,%edx
80102f7f:	7e 50                	jle    80102fd1 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f81:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102f84:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f86:	3b 0d 6c 36 11 80    	cmp    0x8011366c,%ecx
80102f8c:	75 0b                	jne    80102f99 <log_write+0x69>
80102f8e:	eb 38                	jmp    80102fc8 <log_write+0x98>
80102f90:	39 0c 85 6c 36 11 80 	cmp    %ecx,-0x7feec994(,%eax,4)
80102f97:	74 2f                	je     80102fc8 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102f99:	83 c0 01             	add    $0x1,%eax
80102f9c:	39 d0                	cmp    %edx,%eax
80102f9e:	75 f0                	jne    80102f90 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102fa0:	89 0c 95 6c 36 11 80 	mov    %ecx,-0x7feec994(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102fa7:	83 c2 01             	add    $0x1,%edx
80102faa:	89 15 68 36 11 80    	mov    %edx,0x80113668
  b->flags |= B_DIRTY; // prevent eviction
80102fb0:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102fb3:	c7 45 08 20 36 11 80 	movl   $0x80113620,0x8(%ebp)
}
80102fba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102fbd:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102fbe:	e9 0d 16 00 00       	jmp    801045d0 <release>
80102fc3:	90                   	nop
80102fc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102fc8:	89 0c 85 6c 36 11 80 	mov    %ecx,-0x7feec994(,%eax,4)
80102fcf:	eb df                	jmp    80102fb0 <log_write+0x80>
80102fd1:	8b 43 08             	mov    0x8(%ebx),%eax
80102fd4:	a3 6c 36 11 80       	mov    %eax,0x8011366c
  if (i == log.lh.n)
80102fd9:	75 d5                	jne    80102fb0 <log_write+0x80>
80102fdb:	eb ca                	jmp    80102fa7 <log_write+0x77>
80102fdd:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102fe0:	83 ec 0c             	sub    $0xc,%esp
80102fe3:	68 b3 76 10 80       	push   $0x801076b3
80102fe8:	e8 83 d3 ff ff       	call   80100370 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102fed:	83 ec 0c             	sub    $0xc,%esp
80102ff0:	68 c9 76 10 80       	push   $0x801076c9
80102ff5:	e8 76 d3 ff ff       	call   80100370 <panic>
80102ffa:	66 90                	xchg   %ax,%ax
80102ffc:	66 90                	xchg   %ax,%ax
80102ffe:	66 90                	xchg   %ax,%ax

80103000 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103000:	55                   	push   %ebp
80103001:	89 e5                	mov    %esp,%ebp
80103003:	53                   	push   %ebx
80103004:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103007:	e8 54 09 00 00       	call   80103960 <cpuid>
8010300c:	89 c3                	mov    %eax,%ebx
8010300e:	e8 4d 09 00 00       	call   80103960 <cpuid>
80103013:	83 ec 04             	sub    $0x4,%esp
80103016:	53                   	push   %ebx
80103017:	50                   	push   %eax
80103018:	68 e4 76 10 80       	push   $0x801076e4
8010301d:	e8 5e d6 ff ff       	call   80100680 <cprintf>
  idtinit();       // load idt register
80103022:	e8 e9 29 00 00       	call   80105a10 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103027:	e8 b4 08 00 00       	call   801038e0 <mycpu>
8010302c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010302e:	b8 01 00 00 00       	mov    $0x1,%eax
80103033:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010303a:	e8 01 0c 00 00       	call   80103c40 <scheduler>
8010303f:	90                   	nop

80103040 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80103040:	55                   	push   %ebp
80103041:	89 e5                	mov    %esp,%ebp
80103043:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103046:	e8 e5 3a 00 00       	call   80106b30 <switchkvm>
  seginit();
8010304b:	e8 e0 39 00 00       	call   80106a30 <seginit>
  lapicinit();
80103050:	e8 9b f7 ff ff       	call   801027f0 <lapicinit>
  mpmain();
80103055:	e8 a6 ff ff ff       	call   80103000 <mpmain>
8010305a:	66 90                	xchg   %ax,%ax
8010305c:	66 90                	xchg   %ax,%ax
8010305e:	66 90                	xchg   %ax,%ax

80103060 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80103060:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103064:	83 e4 f0             	and    $0xfffffff0,%esp
80103067:	ff 71 fc             	pushl  -0x4(%ecx)
8010306a:	55                   	push   %ebp
8010306b:	89 e5                	mov    %esp,%ebp
8010306d:	53                   	push   %ebx
8010306e:	51                   	push   %ecx
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
8010306f:	bb 20 37 11 80       	mov    $0x80113720,%ebx
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103074:	83 ec 08             	sub    $0x8,%esp
80103077:	68 00 00 40 80       	push   $0x80400000
8010307c:	68 48 64 11 80       	push   $0x80116448
80103081:	e8 3a f5 ff ff       	call   801025c0 <kinit1>
  kvmalloc();      // kernel page table
80103086:	e8 45 3f 00 00       	call   80106fd0 <kvmalloc>
  mpinit();        // detect other processors
8010308b:	e8 70 01 00 00       	call   80103200 <mpinit>
  lapicinit();     // interrupt controller
80103090:	e8 5b f7 ff ff       	call   801027f0 <lapicinit>
  seginit();       // segment descriptors
80103095:	e8 96 39 00 00       	call   80106a30 <seginit>
  picinit();       // disable pic
8010309a:	e8 31 03 00 00       	call   801033d0 <picinit>
  ioapicinit();    // another interrupt controller
8010309f:	e8 4c f3 ff ff       	call   801023f0 <ioapicinit>
  consoleinit();   // console hardware
801030a4:	e8 c7 da ff ff       	call   80100b70 <consoleinit>
  uartinit();      // serial port
801030a9:	e8 52 2c 00 00       	call   80105d00 <uartinit>
  pinit();         // process table
801030ae:	e8 0d 08 00 00       	call   801038c0 <pinit>
  tvinit();        // trap vectors
801030b3:	e8 b8 28 00 00       	call   80105970 <tvinit>
  binit();         // buffer cache
801030b8:	e8 83 cf ff ff       	call   80100040 <binit>
  fileinit();      // file table
801030bd:	e8 8e de ff ff       	call   80100f50 <fileinit>
  ideinit();       // disk 
801030c2:	e8 09 f1 ff ff       	call   801021d0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801030c7:	83 c4 0c             	add    $0xc,%esp
801030ca:	68 8a 00 00 00       	push   $0x8a
801030cf:	68 8c a4 10 80       	push   $0x8010a48c
801030d4:	68 00 70 00 80       	push   $0x80007000
801030d9:	e8 f2 15 00 00       	call   801046d0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801030de:	69 05 a0 3c 11 80 b0 	imul   $0xb0,0x80113ca0,%eax
801030e5:	00 00 00 
801030e8:	83 c4 10             	add    $0x10,%esp
801030eb:	05 20 37 11 80       	add    $0x80113720,%eax
801030f0:	39 d8                	cmp    %ebx,%eax
801030f2:	76 6f                	jbe    80103163 <main+0x103>
801030f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
801030f8:	e8 e3 07 00 00       	call   801038e0 <mycpu>
801030fd:	39 d8                	cmp    %ebx,%eax
801030ff:	74 49                	je     8010314a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103101:	e8 8a f5 ff ff       	call   80102690 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80103106:	05 00 10 00 00       	add    $0x1000,%eax
    *(void**)(code-8) = mpenter;
8010310b:	c7 05 f8 6f 00 80 40 	movl   $0x80103040,0x80006ff8
80103112:	30 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103115:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
8010311c:	90 10 00 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
8010311f:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103124:	0f b6 03             	movzbl (%ebx),%eax
80103127:	83 ec 08             	sub    $0x8,%esp
8010312a:	68 00 70 00 00       	push   $0x7000
8010312f:	50                   	push   %eax
80103130:	e8 0b f8 ff ff       	call   80102940 <lapicstartap>
80103135:	83 c4 10             	add    $0x10,%esp
80103138:	90                   	nop
80103139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103140:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103146:	85 c0                	test   %eax,%eax
80103148:	74 f6                	je     80103140 <main+0xe0>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
8010314a:	69 05 a0 3c 11 80 b0 	imul   $0xb0,0x80113ca0,%eax
80103151:	00 00 00 
80103154:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010315a:	05 20 37 11 80       	add    $0x80113720,%eax
8010315f:	39 c3                	cmp    %eax,%ebx
80103161:	72 95                	jb     801030f8 <main+0x98>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk 
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103163:	83 ec 08             	sub    $0x8,%esp
80103166:	68 00 00 00 8e       	push   $0x8e000000
8010316b:	68 00 00 40 80       	push   $0x80400000
80103170:	e8 bb f4 ff ff       	call   80102630 <kinit2>
  userinit();      // first user process
80103175:	e8 36 08 00 00       	call   801039b0 <userinit>
  mpmain();        // finish this processor's setup
8010317a:	e8 81 fe ff ff       	call   80103000 <mpmain>
8010317f:	90                   	nop

80103180 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103180:	55                   	push   %ebp
80103181:	89 e5                	mov    %esp,%ebp
80103183:	57                   	push   %edi
80103184:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103185:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
8010318b:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
8010318c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
8010318f:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103192:	39 de                	cmp    %ebx,%esi
80103194:	73 48                	jae    801031de <mpsearch1+0x5e>
80103196:	8d 76 00             	lea    0x0(%esi),%esi
80103199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801031a0:	83 ec 04             	sub    $0x4,%esp
801031a3:	8d 7e 10             	lea    0x10(%esi),%edi
801031a6:	6a 04                	push   $0x4
801031a8:	68 f8 76 10 80       	push   $0x801076f8
801031ad:	56                   	push   %esi
801031ae:	e8 bd 14 00 00       	call   80104670 <memcmp>
801031b3:	83 c4 10             	add    $0x10,%esp
801031b6:	85 c0                	test   %eax,%eax
801031b8:	75 1e                	jne    801031d8 <mpsearch1+0x58>
801031ba:	8d 7e 10             	lea    0x10(%esi),%edi
801031bd:	89 f2                	mov    %esi,%edx
801031bf:	31 c9                	xor    %ecx,%ecx
801031c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
801031c8:	0f b6 02             	movzbl (%edx),%eax
801031cb:	83 c2 01             	add    $0x1,%edx
801031ce:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801031d0:	39 fa                	cmp    %edi,%edx
801031d2:	75 f4                	jne    801031c8 <mpsearch1+0x48>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801031d4:	84 c9                	test   %cl,%cl
801031d6:	74 10                	je     801031e8 <mpsearch1+0x68>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
801031d8:	39 fb                	cmp    %edi,%ebx
801031da:	89 fe                	mov    %edi,%esi
801031dc:	77 c2                	ja     801031a0 <mpsearch1+0x20>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
801031de:	8d 65 f4             	lea    -0xc(%ebp),%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
801031e1:	31 c0                	xor    %eax,%eax
}
801031e3:	5b                   	pop    %ebx
801031e4:	5e                   	pop    %esi
801031e5:	5f                   	pop    %edi
801031e6:	5d                   	pop    %ebp
801031e7:	c3                   	ret    
801031e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031eb:	89 f0                	mov    %esi,%eax
801031ed:	5b                   	pop    %ebx
801031ee:	5e                   	pop    %esi
801031ef:	5f                   	pop    %edi
801031f0:	5d                   	pop    %ebp
801031f1:	c3                   	ret    
801031f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103200 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103200:	55                   	push   %ebp
80103201:	89 e5                	mov    %esp,%ebp
80103203:	57                   	push   %edi
80103204:	56                   	push   %esi
80103205:	53                   	push   %ebx
80103206:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103209:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103210:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103217:	c1 e0 08             	shl    $0x8,%eax
8010321a:	09 d0                	or     %edx,%eax
8010321c:	c1 e0 04             	shl    $0x4,%eax
8010321f:	85 c0                	test   %eax,%eax
80103221:	75 1b                	jne    8010323e <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
80103223:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010322a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103231:	c1 e0 08             	shl    $0x8,%eax
80103234:	09 d0                	or     %edx,%eax
80103236:	c1 e0 0a             	shl    $0xa,%eax
80103239:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
8010323e:	ba 00 04 00 00       	mov    $0x400,%edx
80103243:	e8 38 ff ff ff       	call   80103180 <mpsearch1>
80103248:	85 c0                	test   %eax,%eax
8010324a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010324d:	0f 84 37 01 00 00    	je     8010338a <mpinit+0x18a>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103253:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103256:	8b 58 04             	mov    0x4(%eax),%ebx
80103259:	85 db                	test   %ebx,%ebx
8010325b:	0f 84 43 01 00 00    	je     801033a4 <mpinit+0x1a4>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103261:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103267:	83 ec 04             	sub    $0x4,%esp
8010326a:	6a 04                	push   $0x4
8010326c:	68 fd 76 10 80       	push   $0x801076fd
80103271:	56                   	push   %esi
80103272:	e8 f9 13 00 00       	call   80104670 <memcmp>
80103277:	83 c4 10             	add    $0x10,%esp
8010327a:	85 c0                	test   %eax,%eax
8010327c:	0f 85 22 01 00 00    	jne    801033a4 <mpinit+0x1a4>
    return 0;
  if(conf->version != 1 && conf->version != 4)
80103282:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103289:	3c 01                	cmp    $0x1,%al
8010328b:	74 08                	je     80103295 <mpinit+0x95>
8010328d:	3c 04                	cmp    $0x4,%al
8010328f:	0f 85 0f 01 00 00    	jne    801033a4 <mpinit+0x1a4>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80103295:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
8010329c:	85 ff                	test   %edi,%edi
8010329e:	74 21                	je     801032c1 <mpinit+0xc1>
801032a0:	31 d2                	xor    %edx,%edx
801032a2:	31 c0                	xor    %eax,%eax
801032a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
801032a8:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
801032af:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801032b0:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801032b3:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801032b5:	39 c7                	cmp    %eax,%edi
801032b7:	75 ef                	jne    801032a8 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801032b9:	84 d2                	test   %dl,%dl
801032bb:	0f 85 e3 00 00 00    	jne    801033a4 <mpinit+0x1a4>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801032c1:	85 f6                	test   %esi,%esi
801032c3:	0f 84 db 00 00 00    	je     801033a4 <mpinit+0x1a4>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801032c9:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801032cf:	a3 1c 36 11 80       	mov    %eax,0x8011361c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032d4:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
801032db:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
801032e1:	bb 01 00 00 00       	mov    $0x1,%ebx
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032e6:	01 d6                	add    %edx,%esi
801032e8:	90                   	nop
801032e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032f0:	39 c6                	cmp    %eax,%esi
801032f2:	76 23                	jbe    80103317 <mpinit+0x117>
801032f4:	0f b6 10             	movzbl (%eax),%edx
    switch(*p){
801032f7:	80 fa 04             	cmp    $0x4,%dl
801032fa:	0f 87 c0 00 00 00    	ja     801033c0 <mpinit+0x1c0>
80103300:	ff 24 95 3c 77 10 80 	jmp    *-0x7fef88c4(,%edx,4)
80103307:	89 f6                	mov    %esi,%esi
80103309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103310:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103313:	39 c6                	cmp    %eax,%esi
80103315:	77 dd                	ja     801032f4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103317:	85 db                	test   %ebx,%ebx
80103319:	0f 84 92 00 00 00    	je     801033b1 <mpinit+0x1b1>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010331f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103322:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103326:	74 15                	je     8010333d <mpinit+0x13d>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103328:	ba 22 00 00 00       	mov    $0x22,%edx
8010332d:	b8 70 00 00 00       	mov    $0x70,%eax
80103332:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103333:	ba 23 00 00 00       	mov    $0x23,%edx
80103338:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103339:	83 c8 01             	or     $0x1,%eax
8010333c:	ee                   	out    %al,(%dx)
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
8010333d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103340:	5b                   	pop    %ebx
80103341:	5e                   	pop    %esi
80103342:	5f                   	pop    %edi
80103343:	5d                   	pop    %ebp
80103344:	c3                   	ret    
80103345:	8d 76 00             	lea    0x0(%esi),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80103348:	8b 0d a0 3c 11 80    	mov    0x80113ca0,%ecx
8010334e:	83 f9 07             	cmp    $0x7,%ecx
80103351:	7f 19                	jg     8010336c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103353:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103357:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010335d:	83 c1 01             	add    $0x1,%ecx
80103360:	89 0d a0 3c 11 80    	mov    %ecx,0x80113ca0
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103366:	88 97 20 37 11 80    	mov    %dl,-0x7feec8e0(%edi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
8010336c:	83 c0 14             	add    $0x14,%eax
      continue;
8010336f:	e9 7c ff ff ff       	jmp    801032f0 <mpinit+0xf0>
80103374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80103378:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010337c:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
8010337f:	88 15 00 37 11 80    	mov    %dl,0x80113700
      p += sizeof(struct mpioapic);
      continue;
80103385:	e9 66 ff ff ff       	jmp    801032f0 <mpinit+0xf0>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
8010338a:	ba 00 00 01 00       	mov    $0x10000,%edx
8010338f:	b8 00 00 0f 00       	mov    $0xf0000,%eax
80103394:	e8 e7 fd ff ff       	call   80103180 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103399:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
8010339b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010339e:	0f 85 af fe ff ff    	jne    80103253 <mpinit+0x53>
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
801033a4:	83 ec 0c             	sub    $0xc,%esp
801033a7:	68 02 77 10 80       	push   $0x80107702
801033ac:	e8 bf cf ff ff       	call   80100370 <panic>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
801033b1:	83 ec 0c             	sub    $0xc,%esp
801033b4:	68 1c 77 10 80       	push   $0x8010771c
801033b9:	e8 b2 cf ff ff       	call   80100370 <panic>
801033be:	66 90                	xchg   %ax,%ax
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
801033c0:	31 db                	xor    %ebx,%ebx
801033c2:	e9 30 ff ff ff       	jmp    801032f7 <mpinit+0xf7>
801033c7:	66 90                	xchg   %ax,%ax
801033c9:	66 90                	xchg   %ax,%ax
801033cb:	66 90                	xchg   %ax,%ax
801033cd:	66 90                	xchg   %ax,%ax
801033cf:	90                   	nop

801033d0 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801033d0:	55                   	push   %ebp
801033d1:	ba 21 00 00 00       	mov    $0x21,%edx
801033d6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801033db:	89 e5                	mov    %esp,%ebp
801033dd:	ee                   	out    %al,(%dx)
801033de:	ba a1 00 00 00       	mov    $0xa1,%edx
801033e3:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801033e4:	5d                   	pop    %ebp
801033e5:	c3                   	ret    
801033e6:	66 90                	xchg   %ax,%ax
801033e8:	66 90                	xchg   %ax,%ax
801033ea:	66 90                	xchg   %ax,%ax
801033ec:	66 90                	xchg   %ax,%ax
801033ee:	66 90                	xchg   %ax,%ax

801033f0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801033f0:	55                   	push   %ebp
801033f1:	89 e5                	mov    %esp,%ebp
801033f3:	57                   	push   %edi
801033f4:	56                   	push   %esi
801033f5:	53                   	push   %ebx
801033f6:	83 ec 0c             	sub    $0xc,%esp
801033f9:	8b 75 08             	mov    0x8(%ebp),%esi
801033fc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801033ff:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103405:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010340b:	e8 60 db ff ff       	call   80100f70 <filealloc>
80103410:	85 c0                	test   %eax,%eax
80103412:	89 06                	mov    %eax,(%esi)
80103414:	0f 84 a8 00 00 00    	je     801034c2 <pipealloc+0xd2>
8010341a:	e8 51 db ff ff       	call   80100f70 <filealloc>
8010341f:	85 c0                	test   %eax,%eax
80103421:	89 03                	mov    %eax,(%ebx)
80103423:	0f 84 87 00 00 00    	je     801034b0 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103429:	e8 62 f2 ff ff       	call   80102690 <kalloc>
8010342e:	85 c0                	test   %eax,%eax
80103430:	89 c7                	mov    %eax,%edi
80103432:	0f 84 b0 00 00 00    	je     801034e8 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103438:	83 ec 08             	sub    $0x8,%esp
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
  p->readopen = 1;
8010343b:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103442:	00 00 00 
  p->writeopen = 1;
80103445:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010344c:	00 00 00 
  p->nwrite = 0;
8010344f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103456:	00 00 00 
  p->nread = 0;
80103459:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103460:	00 00 00 
  initlock(&p->lock, "pipe");
80103463:	68 50 77 10 80       	push   $0x80107750
80103468:	50                   	push   %eax
80103469:	e8 42 0f 00 00       	call   801043b0 <initlock>
  (*f0)->type = FD_PIPE;
8010346e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103470:	83 c4 10             	add    $0x10,%esp
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
80103473:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103479:	8b 06                	mov    (%esi),%eax
8010347b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010347f:	8b 06                	mov    (%esi),%eax
80103481:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103485:	8b 06                	mov    (%esi),%eax
80103487:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010348a:	8b 03                	mov    (%ebx),%eax
8010348c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103492:	8b 03                	mov    (%ebx),%eax
80103494:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103498:	8b 03                	mov    (%ebx),%eax
8010349a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010349e:	8b 03                	mov    (%ebx),%eax
801034a0:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801034a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801034a6:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801034a8:	5b                   	pop    %ebx
801034a9:	5e                   	pop    %esi
801034aa:	5f                   	pop    %edi
801034ab:	5d                   	pop    %ebp
801034ac:	c3                   	ret    
801034ad:	8d 76 00             	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801034b0:	8b 06                	mov    (%esi),%eax
801034b2:	85 c0                	test   %eax,%eax
801034b4:	74 1e                	je     801034d4 <pipealloc+0xe4>
    fileclose(*f0);
801034b6:	83 ec 0c             	sub    $0xc,%esp
801034b9:	50                   	push   %eax
801034ba:	e8 71 db ff ff       	call   80101030 <fileclose>
801034bf:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801034c2:	8b 03                	mov    (%ebx),%eax
801034c4:	85 c0                	test   %eax,%eax
801034c6:	74 0c                	je     801034d4 <pipealloc+0xe4>
    fileclose(*f1);
801034c8:	83 ec 0c             	sub    $0xc,%esp
801034cb:	50                   	push   %eax
801034cc:	e8 5f db ff ff       	call   80101030 <fileclose>
801034d1:	83 c4 10             	add    $0x10,%esp
  return -1;
}
801034d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
801034d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801034dc:	5b                   	pop    %ebx
801034dd:	5e                   	pop    %esi
801034de:	5f                   	pop    %edi
801034df:	5d                   	pop    %ebp
801034e0:	c3                   	ret    
801034e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801034e8:	8b 06                	mov    (%esi),%eax
801034ea:	85 c0                	test   %eax,%eax
801034ec:	75 c8                	jne    801034b6 <pipealloc+0xc6>
801034ee:	eb d2                	jmp    801034c2 <pipealloc+0xd2>

801034f0 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
801034f0:	55                   	push   %ebp
801034f1:	89 e5                	mov    %esp,%ebp
801034f3:	56                   	push   %esi
801034f4:	53                   	push   %ebx
801034f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801034f8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801034fb:	83 ec 0c             	sub    $0xc,%esp
801034fe:	53                   	push   %ebx
801034ff:	e8 ac 0f 00 00       	call   801044b0 <acquire>
  if(writable){
80103504:	83 c4 10             	add    $0x10,%esp
80103507:	85 f6                	test   %esi,%esi
80103509:	74 45                	je     80103550 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010350b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103511:	83 ec 0c             	sub    $0xc,%esp
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
80103514:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010351b:	00 00 00 
    wakeup(&p->nread);
8010351e:	50                   	push   %eax
8010351f:	e8 cc 0b 00 00       	call   801040f0 <wakeup>
80103524:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103527:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010352d:	85 d2                	test   %edx,%edx
8010352f:	75 0a                	jne    8010353b <pipeclose+0x4b>
80103531:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103537:	85 c0                	test   %eax,%eax
80103539:	74 35                	je     80103570 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010353b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010353e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103541:	5b                   	pop    %ebx
80103542:	5e                   	pop    %esi
80103543:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103544:	e9 87 10 00 00       	jmp    801045d0 <release>
80103549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
80103550:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103556:	83 ec 0c             	sub    $0xc,%esp
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
80103559:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103560:	00 00 00 
    wakeup(&p->nwrite);
80103563:	50                   	push   %eax
80103564:	e8 87 0b 00 00       	call   801040f0 <wakeup>
80103569:	83 c4 10             	add    $0x10,%esp
8010356c:	eb b9                	jmp    80103527 <pipeclose+0x37>
8010356e:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80103570:	83 ec 0c             	sub    $0xc,%esp
80103573:	53                   	push   %ebx
80103574:	e8 57 10 00 00       	call   801045d0 <release>
    kfree((char*)p);
80103579:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010357c:	83 c4 10             	add    $0x10,%esp
  } else
    release(&p->lock);
}
8010357f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103582:	5b                   	pop    %ebx
80103583:	5e                   	pop    %esi
80103584:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
80103585:	e9 56 ef ff ff       	jmp    801024e0 <kfree>
8010358a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103590 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103590:	55                   	push   %ebp
80103591:	89 e5                	mov    %esp,%ebp
80103593:	57                   	push   %edi
80103594:	56                   	push   %esi
80103595:	53                   	push   %ebx
80103596:	83 ec 28             	sub    $0x28,%esp
80103599:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010359c:	53                   	push   %ebx
8010359d:	e8 0e 0f 00 00       	call   801044b0 <acquire>
  for(i = 0; i < n; i++){
801035a2:	8b 45 10             	mov    0x10(%ebp),%eax
801035a5:	83 c4 10             	add    $0x10,%esp
801035a8:	85 c0                	test   %eax,%eax
801035aa:	0f 8e b9 00 00 00    	jle    80103669 <pipewrite+0xd9>
801035b0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801035b3:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801035b9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035bf:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
801035c5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801035c8:	03 4d 10             	add    0x10(%ebp),%ecx
801035cb:	89 4d e0             	mov    %ecx,-0x20(%ebp)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035ce:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
801035d4:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
801035da:	39 d0                	cmp    %edx,%eax
801035dc:	74 38                	je     80103616 <pipewrite+0x86>
801035de:	eb 59                	jmp    80103639 <pipewrite+0xa9>
      if(p->readopen == 0 || myproc()->killed){
801035e0:	e8 9b 03 00 00       	call   80103980 <myproc>
801035e5:	8b 48 24             	mov    0x24(%eax),%ecx
801035e8:	85 c9                	test   %ecx,%ecx
801035ea:	75 34                	jne    80103620 <pipewrite+0x90>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801035ec:	83 ec 0c             	sub    $0xc,%esp
801035ef:	57                   	push   %edi
801035f0:	e8 fb 0a 00 00       	call   801040f0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035f5:	58                   	pop    %eax
801035f6:	5a                   	pop    %edx
801035f7:	53                   	push   %ebx
801035f8:	56                   	push   %esi
801035f9:	e8 42 09 00 00       	call   80103f40 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035fe:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103604:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010360a:	83 c4 10             	add    $0x10,%esp
8010360d:	05 00 02 00 00       	add    $0x200,%eax
80103612:	39 c2                	cmp    %eax,%edx
80103614:	75 2a                	jne    80103640 <pipewrite+0xb0>
      if(p->readopen == 0 || myproc()->killed){
80103616:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010361c:	85 c0                	test   %eax,%eax
8010361e:	75 c0                	jne    801035e0 <pipewrite+0x50>
        release(&p->lock);
80103620:	83 ec 0c             	sub    $0xc,%esp
80103623:	53                   	push   %ebx
80103624:	e8 a7 0f 00 00       	call   801045d0 <release>
        return -1;
80103629:	83 c4 10             	add    $0x10,%esp
8010362c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103631:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103634:	5b                   	pop    %ebx
80103635:	5e                   	pop    %esi
80103636:	5f                   	pop    %edi
80103637:	5d                   	pop    %ebp
80103638:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103639:	89 c2                	mov    %eax,%edx
8010363b:	90                   	nop
8010363c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103640:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103643:	8d 42 01             	lea    0x1(%edx),%eax
80103646:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010364a:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103650:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103656:	0f b6 09             	movzbl (%ecx),%ecx
80103659:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
8010365d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80103660:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
80103663:	0f 85 65 ff ff ff    	jne    801035ce <pipewrite+0x3e>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103669:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010366f:	83 ec 0c             	sub    $0xc,%esp
80103672:	50                   	push   %eax
80103673:	e8 78 0a 00 00       	call   801040f0 <wakeup>
  release(&p->lock);
80103678:	89 1c 24             	mov    %ebx,(%esp)
8010367b:	e8 50 0f 00 00       	call   801045d0 <release>
  return n;
80103680:	83 c4 10             	add    $0x10,%esp
80103683:	8b 45 10             	mov    0x10(%ebp),%eax
80103686:	eb a9                	jmp    80103631 <pipewrite+0xa1>
80103688:	90                   	nop
80103689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103690 <piperead>:
}

int
piperead(struct pipe *p, char *addr, int n)
{
80103690:	55                   	push   %ebp
80103691:	89 e5                	mov    %esp,%ebp
80103693:	57                   	push   %edi
80103694:	56                   	push   %esi
80103695:	53                   	push   %ebx
80103696:	83 ec 18             	sub    $0x18,%esp
80103699:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010369c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010369f:	53                   	push   %ebx
801036a0:	e8 0b 0e 00 00       	call   801044b0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036a5:	83 c4 10             	add    $0x10,%esp
801036a8:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801036ae:	39 83 38 02 00 00    	cmp    %eax,0x238(%ebx)
801036b4:	75 6a                	jne    80103720 <piperead+0x90>
801036b6:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
801036bc:	85 f6                	test   %esi,%esi
801036be:	0f 84 cc 00 00 00    	je     80103790 <piperead+0x100>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801036c4:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
801036ca:	eb 2d                	jmp    801036f9 <piperead+0x69>
801036cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036d0:	83 ec 08             	sub    $0x8,%esp
801036d3:	53                   	push   %ebx
801036d4:	56                   	push   %esi
801036d5:	e8 66 08 00 00       	call   80103f40 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036da:	83 c4 10             	add    $0x10,%esp
801036dd:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801036e3:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
801036e9:	75 35                	jne    80103720 <piperead+0x90>
801036eb:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
801036f1:	85 d2                	test   %edx,%edx
801036f3:	0f 84 97 00 00 00    	je     80103790 <piperead+0x100>
    if(myproc()->killed){
801036f9:	e8 82 02 00 00       	call   80103980 <myproc>
801036fe:	8b 48 24             	mov    0x24(%eax),%ecx
80103701:	85 c9                	test   %ecx,%ecx
80103703:	74 cb                	je     801036d0 <piperead+0x40>
      release(&p->lock);
80103705:	83 ec 0c             	sub    $0xc,%esp
80103708:	53                   	push   %ebx
80103709:	e8 c2 0e 00 00       	call   801045d0 <release>
      return -1;
8010370e:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103711:	8d 65 f4             	lea    -0xc(%ebp),%esp

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(myproc()->killed){
      release(&p->lock);
      return -1;
80103714:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103719:	5b                   	pop    %ebx
8010371a:	5e                   	pop    %esi
8010371b:	5f                   	pop    %edi
8010371c:	5d                   	pop    %ebp
8010371d:	c3                   	ret    
8010371e:	66 90                	xchg   %ax,%ax
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103720:	8b 45 10             	mov    0x10(%ebp),%eax
80103723:	85 c0                	test   %eax,%eax
80103725:	7e 69                	jle    80103790 <piperead+0x100>
    if(p->nread == p->nwrite)
80103727:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010372d:	31 c9                	xor    %ecx,%ecx
8010372f:	eb 15                	jmp    80103746 <piperead+0xb6>
80103731:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103738:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010373e:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
80103744:	74 5a                	je     801037a0 <piperead+0x110>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103746:	8d 70 01             	lea    0x1(%eax),%esi
80103749:	25 ff 01 00 00       	and    $0x1ff,%eax
8010374e:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
80103754:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
80103759:	88 04 0f             	mov    %al,(%edi,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010375c:	83 c1 01             	add    $0x1,%ecx
8010375f:	39 4d 10             	cmp    %ecx,0x10(%ebp)
80103762:	75 d4                	jne    80103738 <piperead+0xa8>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103764:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
8010376a:	83 ec 0c             	sub    $0xc,%esp
8010376d:	50                   	push   %eax
8010376e:	e8 7d 09 00 00       	call   801040f0 <wakeup>
  release(&p->lock);
80103773:	89 1c 24             	mov    %ebx,(%esp)
80103776:	e8 55 0e 00 00       	call   801045d0 <release>
  return i;
8010377b:	8b 45 10             	mov    0x10(%ebp),%eax
8010377e:	83 c4 10             	add    $0x10,%esp
}
80103781:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103784:	5b                   	pop    %ebx
80103785:	5e                   	pop    %esi
80103786:	5f                   	pop    %edi
80103787:	5d                   	pop    %ebp
80103788:	c3                   	ret    
80103789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103790:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
80103797:	eb cb                	jmp    80103764 <piperead+0xd4>
80103799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801037a0:	89 4d 10             	mov    %ecx,0x10(%ebp)
801037a3:	eb bf                	jmp    80103764 <piperead+0xd4>
801037a5:	66 90                	xchg   %ax,%ax
801037a7:	66 90                	xchg   %ax,%ax
801037a9:	66 90                	xchg   %ax,%ax
801037ab:	66 90                	xchg   %ax,%ax
801037ad:	66 90                	xchg   %ax,%ax
801037af:	90                   	nop

801037b0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801037b0:	55                   	push   %ebp
801037b1:	89 e5                	mov    %esp,%ebp
801037b3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037b4:	bb f4 3c 11 80       	mov    $0x80113cf4,%ebx
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801037b9:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
801037bc:	68 c0 3c 11 80       	push   $0x80113cc0
801037c1:	e8 ea 0c 00 00       	call   801044b0 <acquire>
801037c6:	83 c4 10             	add    $0x10,%esp
801037c9:	eb 10                	jmp    801037db <allocproc+0x2b>
801037cb:	90                   	nop
801037cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037d0:	83 c3 7c             	add    $0x7c,%ebx
801037d3:	81 fb f4 5b 11 80    	cmp    $0x80115bf4,%ebx
801037d9:	74 75                	je     80103850 <allocproc+0xa0>
    if(p->state == UNUSED)
801037db:	8b 43 0c             	mov    0xc(%ebx),%eax
801037de:	85 c0                	test   %eax,%eax
801037e0:	75 ee                	jne    801037d0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801037e2:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
801037e7:	83 ec 0c             	sub    $0xc,%esp

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
801037ea:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;

  release(&ptable.lock);
801037f1:	68 c0 3c 11 80       	push   $0x80113cc0
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801037f6:	8d 50 01             	lea    0x1(%eax),%edx
801037f9:	89 43 10             	mov    %eax,0x10(%ebx)
801037fc:	89 15 04 a0 10 80    	mov    %edx,0x8010a004

  release(&ptable.lock);
80103802:	e8 c9 0d 00 00       	call   801045d0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103807:	e8 84 ee ff ff       	call   80102690 <kalloc>
8010380c:	83 c4 10             	add    $0x10,%esp
8010380f:	85 c0                	test   %eax,%eax
80103811:	89 43 08             	mov    %eax,0x8(%ebx)
80103814:	74 51                	je     80103867 <allocproc+0xb7>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103816:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010381c:	83 ec 04             	sub    $0x4,%esp
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
8010381f:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103824:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
80103827:	c7 40 14 60 59 10 80 	movl   $0x80105960,0x14(%eax)

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010382e:	6a 14                	push   $0x14
80103830:	6a 00                	push   $0x0
80103832:	50                   	push   %eax
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
80103833:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103836:	e8 e5 0d 00 00       	call   80104620 <memset>
  p->context->eip = (uint)forkret;
8010383b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010383e:	83 c4 10             	add    $0x10,%esp
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
80103841:	c7 40 10 70 38 10 80 	movl   $0x80103870,0x10(%eax)

  return p;
80103848:	89 d8                	mov    %ebx,%eax
}
8010384a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010384d:	c9                   	leave  
8010384e:	c3                   	ret    
8010384f:	90                   	nop

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80103850:	83 ec 0c             	sub    $0xc,%esp
80103853:	68 c0 3c 11 80       	push   $0x80113cc0
80103858:	e8 73 0d 00 00       	call   801045d0 <release>
  return 0;
8010385d:	83 c4 10             	add    $0x10,%esp
80103860:	31 c0                	xor    %eax,%eax
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
80103862:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103865:	c9                   	leave  
80103866:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
80103867:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
8010386e:	eb da                	jmp    8010384a <allocproc+0x9a>

80103870 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103870:	55                   	push   %ebp
80103871:	89 e5                	mov    %esp,%ebp
80103873:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103876:	68 c0 3c 11 80       	push   $0x80113cc0
8010387b:	e8 50 0d 00 00       	call   801045d0 <release>

  if (first) {
80103880:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103885:	83 c4 10             	add    $0x10,%esp
80103888:	85 c0                	test   %eax,%eax
8010388a:	75 04                	jne    80103890 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010388c:	c9                   	leave  
8010388d:	c3                   	ret    
8010388e:	66 90                	xchg   %ax,%ax
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
80103890:	83 ec 0c             	sub    $0xc,%esp

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80103893:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
8010389a:	00 00 00 
    iinit(ROOTDEV);
8010389d:	6a 01                	push   $0x1
8010389f:	e8 cc dd ff ff       	call   80101670 <iinit>
    initlog(ROOTDEV);
801038a4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801038ab:	e8 00 f4 ff ff       	call   80102cb0 <initlog>
801038b0:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
801038b3:	c9                   	leave  
801038b4:	c3                   	ret    
801038b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801038b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801038c0 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
801038c0:	55                   	push   %ebp
801038c1:	89 e5                	mov    %esp,%ebp
801038c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801038c6:	68 55 77 10 80       	push   $0x80107755
801038cb:	68 c0 3c 11 80       	push   $0x80113cc0
801038d0:	e8 db 0a 00 00       	call   801043b0 <initlock>
}
801038d5:	83 c4 10             	add    $0x10,%esp
801038d8:	c9                   	leave  
801038d9:	c3                   	ret    
801038da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801038e0 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
801038e0:	55                   	push   %ebp
801038e1:	89 e5                	mov    %esp,%ebp
801038e3:	56                   	push   %esi
801038e4:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801038e5:	9c                   	pushf  
801038e6:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
801038e7:	f6 c4 02             	test   $0x2,%ah
801038ea:	75 5b                	jne    80103947 <mycpu+0x67>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
801038ec:	e8 ff ef ff ff       	call   801028f0 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
801038f1:	8b 35 a0 3c 11 80    	mov    0x80113ca0,%esi
801038f7:	85 f6                	test   %esi,%esi
801038f9:	7e 3f                	jle    8010393a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
801038fb:	0f b6 15 20 37 11 80 	movzbl 0x80113720,%edx
80103902:	39 d0                	cmp    %edx,%eax
80103904:	74 30                	je     80103936 <mycpu+0x56>
80103906:	b9 d0 37 11 80       	mov    $0x801137d0,%ecx
8010390b:	31 d2                	xor    %edx,%edx
8010390d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103910:	83 c2 01             	add    $0x1,%edx
80103913:	39 f2                	cmp    %esi,%edx
80103915:	74 23                	je     8010393a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
80103917:	0f b6 19             	movzbl (%ecx),%ebx
8010391a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103920:	39 d8                	cmp    %ebx,%eax
80103922:	75 ec                	jne    80103910 <mycpu+0x30>
      return &cpus[i];
80103924:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
  }
  panic("unknown apicid\n");
}
8010392a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010392d:	5b                   	pop    %ebx
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
8010392e:	05 20 37 11 80       	add    $0x80113720,%eax
  }
  panic("unknown apicid\n");
}
80103933:	5e                   	pop    %esi
80103934:	5d                   	pop    %ebp
80103935:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103936:	31 d2                	xor    %edx,%edx
80103938:	eb ea                	jmp    80103924 <mycpu+0x44>
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
8010393a:	83 ec 0c             	sub    $0xc,%esp
8010393d:	68 5c 77 10 80       	push   $0x8010775c
80103942:	e8 29 ca ff ff       	call   80100370 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
80103947:	83 ec 0c             	sub    $0xc,%esp
8010394a:	68 38 78 10 80       	push   $0x80107838
8010394f:	e8 1c ca ff ff       	call   80100370 <panic>
80103954:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010395a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103960 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
80103960:	55                   	push   %ebp
80103961:	89 e5                	mov    %esp,%ebp
80103963:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103966:	e8 75 ff ff ff       	call   801038e0 <mycpu>
8010396b:	2d 20 37 11 80       	sub    $0x80113720,%eax
}
80103970:	c9                   	leave  
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
80103971:	c1 f8 04             	sar    $0x4,%eax
80103974:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010397a:	c3                   	ret    
8010397b:	90                   	nop
8010397c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103980 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
80103980:	55                   	push   %ebp
80103981:	89 e5                	mov    %esp,%ebp
80103983:	53                   	push   %ebx
80103984:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
80103987:	e8 e4 0a 00 00       	call   80104470 <pushcli>
  c = mycpu();
8010398c:	e8 4f ff ff ff       	call   801038e0 <mycpu>
  p = c->proc;
80103991:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103997:	e8 c4 0b 00 00       	call   80104560 <popcli>
  return p;
}
8010399c:	83 c4 04             	add    $0x4,%esp
8010399f:	89 d8                	mov    %ebx,%eax
801039a1:	5b                   	pop    %ebx
801039a2:	5d                   	pop    %ebp
801039a3:	c3                   	ret    
801039a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801039aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801039b0 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
801039b0:	55                   	push   %ebp
801039b1:	89 e5                	mov    %esp,%ebp
801039b3:	53                   	push   %ebx
801039b4:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
801039b7:	e8 f4 fd ff ff       	call   801037b0 <allocproc>
801039bc:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
801039be:	a3 58 b5 10 80       	mov    %eax,0x8010b558
  if((p->pgdir = setupkvm()) == 0)
801039c3:	e8 88 35 00 00       	call   80106f50 <setupkvm>
801039c8:	85 c0                	test   %eax,%eax
801039ca:	89 43 04             	mov    %eax,0x4(%ebx)
801039cd:	0f 84 bd 00 00 00    	je     80103a90 <userinit+0xe0>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801039d3:	83 ec 04             	sub    $0x4,%esp
801039d6:	68 2c 00 00 00       	push   $0x2c
801039db:	68 60 a4 10 80       	push   $0x8010a460
801039e0:	50                   	push   %eax
801039e1:	e8 7a 32 00 00       	call   80106c60 <inituvm>
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
801039e6:	83 c4 0c             	add    $0xc,%esp
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
801039e9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801039ef:	6a 4c                	push   $0x4c
801039f1:	6a 00                	push   $0x0
801039f3:	ff 73 18             	pushl  0x18(%ebx)
801039f6:	e8 25 0c 00 00       	call   80104620 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801039fb:	8b 43 18             	mov    0x18(%ebx),%eax
801039fe:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a03:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a08:	83 c4 0c             	add    $0xc,%esp
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a0b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a0f:	8b 43 18             	mov    0x18(%ebx),%eax
80103a12:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103a16:	8b 43 18             	mov    0x18(%ebx),%eax
80103a19:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a1d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103a21:	8b 43 18             	mov    0x18(%ebx),%eax
80103a24:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a28:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103a2c:	8b 43 18             	mov    0x18(%ebx),%eax
80103a2f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103a36:	8b 43 18             	mov    0x18(%ebx),%eax
80103a39:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103a40:	8b 43 18             	mov    0x18(%ebx),%eax
80103a43:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a4a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103a4d:	6a 10                	push   $0x10
80103a4f:	68 85 77 10 80       	push   $0x80107785
80103a54:	50                   	push   %eax
80103a55:	e8 c6 0d 00 00       	call   80104820 <safestrcpy>
  p->cwd = namei("/");
80103a5a:	c7 04 24 8e 77 10 80 	movl   $0x8010778e,(%esp)
80103a61:	e8 5a e6 ff ff       	call   801020c0 <namei>
80103a66:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80103a69:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103a70:	e8 3b 0a 00 00       	call   801044b0 <acquire>

  p->state = RUNNABLE;
80103a75:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
80103a7c:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103a83:	e8 48 0b 00 00       	call   801045d0 <release>
}
80103a88:	83 c4 10             	add    $0x10,%esp
80103a8b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a8e:	c9                   	leave  
80103a8f:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
80103a90:	83 ec 0c             	sub    $0xc,%esp
80103a93:	68 6c 77 10 80       	push   $0x8010776c
80103a98:	e8 d3 c8 ff ff       	call   80100370 <panic>
80103a9d:	8d 76 00             	lea    0x0(%esi),%esi

80103aa0 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80103aa0:	55                   	push   %ebp
80103aa1:	89 e5                	mov    %esp,%ebp
80103aa3:	56                   	push   %esi
80103aa4:	53                   	push   %ebx
80103aa5:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103aa8:	e8 c3 09 00 00       	call   80104470 <pushcli>
  c = mycpu();
80103aad:	e8 2e fe ff ff       	call   801038e0 <mycpu>
  p = c->proc;
80103ab2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ab8:	e8 a3 0a 00 00       	call   80104560 <popcli>
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
80103abd:	83 fe 00             	cmp    $0x0,%esi
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
80103ac0:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103ac2:	7e 34                	jle    80103af8 <growproc+0x58>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103ac4:	83 ec 04             	sub    $0x4,%esp
80103ac7:	01 c6                	add    %eax,%esi
80103ac9:	56                   	push   %esi
80103aca:	50                   	push   %eax
80103acb:	ff 73 04             	pushl  0x4(%ebx)
80103ace:	e8 cd 32 00 00       	call   80106da0 <allocuvm>
80103ad3:	83 c4 10             	add    $0x10,%esp
80103ad6:	85 c0                	test   %eax,%eax
80103ad8:	74 36                	je     80103b10 <growproc+0x70>
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
80103ada:	83 ec 0c             	sub    $0xc,%esp
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
80103add:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103adf:	53                   	push   %ebx
80103ae0:	e8 6b 30 00 00       	call   80106b50 <switchuvm>
  return 0;
80103ae5:	83 c4 10             	add    $0x10,%esp
80103ae8:	31 c0                	xor    %eax,%eax
}
80103aea:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103aed:	5b                   	pop    %ebx
80103aee:	5e                   	pop    %esi
80103aef:	5d                   	pop    %ebp
80103af0:	c3                   	ret    
80103af1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80103af8:	74 e0                	je     80103ada <growproc+0x3a>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103afa:	83 ec 04             	sub    $0x4,%esp
80103afd:	01 c6                	add    %eax,%esi
80103aff:	56                   	push   %esi
80103b00:	50                   	push   %eax
80103b01:	ff 73 04             	pushl  0x4(%ebx)
80103b04:	e8 97 33 00 00       	call   80106ea0 <deallocuvm>
80103b09:	83 c4 10             	add    $0x10,%esp
80103b0c:	85 c0                	test   %eax,%eax
80103b0e:	75 ca                	jne    80103ada <growproc+0x3a>
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
80103b10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b15:	eb d3                	jmp    80103aea <growproc+0x4a>
80103b17:	89 f6                	mov    %esi,%esi
80103b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b20 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103b20:	55                   	push   %ebp
80103b21:	89 e5                	mov    %esp,%ebp
80103b23:	57                   	push   %edi
80103b24:	56                   	push   %esi
80103b25:	53                   	push   %ebx
80103b26:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103b29:	e8 42 09 00 00       	call   80104470 <pushcli>
  c = mycpu();
80103b2e:	e8 ad fd ff ff       	call   801038e0 <mycpu>
  p = c->proc;
80103b33:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b39:	e8 22 0a 00 00       	call   80104560 <popcli>
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
80103b3e:	e8 6d fc ff ff       	call   801037b0 <allocproc>
80103b43:	85 c0                	test   %eax,%eax
80103b45:	89 c7                	mov    %eax,%edi
80103b47:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103b4a:	0f 84 b5 00 00 00    	je     80103c05 <fork+0xe5>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103b50:	83 ec 08             	sub    $0x8,%esp
80103b53:	ff 33                	pushl  (%ebx)
80103b55:	ff 73 04             	pushl  0x4(%ebx)
80103b58:	e8 c3 34 00 00       	call   80107020 <copyuvm>
80103b5d:	83 c4 10             	add    $0x10,%esp
80103b60:	85 c0                	test   %eax,%eax
80103b62:	89 47 04             	mov    %eax,0x4(%edi)
80103b65:	0f 84 a1 00 00 00    	je     80103c0c <fork+0xec>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
80103b6b:	8b 03                	mov    (%ebx),%eax
80103b6d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103b70:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103b72:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103b75:	89 c8                	mov    %ecx,%eax
80103b77:	8b 79 18             	mov    0x18(%ecx),%edi
80103b7a:	8b 73 18             	mov    0x18(%ebx),%esi
80103b7d:	b9 13 00 00 00       	mov    $0x13,%ecx
80103b82:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103b84:	31 f6                	xor    %esi,%esi
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103b86:	8b 40 18             	mov    0x18(%eax),%eax
80103b89:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
80103b90:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103b94:	85 c0                	test   %eax,%eax
80103b96:	74 13                	je     80103bab <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103b98:	83 ec 0c             	sub    $0xc,%esp
80103b9b:	50                   	push   %eax
80103b9c:	e8 3f d4 ff ff       	call   80100fe0 <filedup>
80103ba1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103ba4:	83 c4 10             	add    $0x10,%esp
80103ba7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103bab:	83 c6 01             	add    $0x1,%esi
80103bae:	83 fe 10             	cmp    $0x10,%esi
80103bb1:	75 dd                	jne    80103b90 <fork+0x70>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103bb3:	83 ec 0c             	sub    $0xc,%esp
80103bb6:	ff 73 68             	pushl  0x68(%ebx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103bb9:	83 c3 6c             	add    $0x6c,%ebx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103bbc:	e8 7f dc ff ff       	call   80101840 <idup>
80103bc1:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103bc4:	83 c4 0c             	add    $0xc,%esp
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103bc7:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103bca:	8d 47 6c             	lea    0x6c(%edi),%eax
80103bcd:	6a 10                	push   $0x10
80103bcf:	53                   	push   %ebx
80103bd0:	50                   	push   %eax
80103bd1:	e8 4a 0c 00 00       	call   80104820 <safestrcpy>

  pid = np->pid;
80103bd6:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
80103bd9:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103be0:	e8 cb 08 00 00       	call   801044b0 <acquire>

  np->state = RUNNABLE;
80103be5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
80103bec:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103bf3:	e8 d8 09 00 00       	call   801045d0 <release>

  return pid;
80103bf8:	83 c4 10             	add    $0x10,%esp
80103bfb:	89 d8                	mov    %ebx,%eax
}
80103bfd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c00:	5b                   	pop    %ebx
80103c01:	5e                   	pop    %esi
80103c02:	5f                   	pop    %edi
80103c03:	5d                   	pop    %ebp
80103c04:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103c05:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103c0a:	eb f1                	jmp    80103bfd <fork+0xdd>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
80103c0c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103c0f:	83 ec 0c             	sub    $0xc,%esp
80103c12:	ff 77 08             	pushl  0x8(%edi)
80103c15:	e8 c6 e8 ff ff       	call   801024e0 <kfree>
    np->kstack = 0;
80103c1a:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103c21:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103c28:	83 c4 10             	add    $0x10,%esp
80103c2b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103c30:	eb cb                	jmp    80103bfd <fork+0xdd>
80103c32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c40 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103c40:	55                   	push   %ebp
80103c41:	89 e5                	mov    %esp,%ebp
80103c43:	57                   	push   %edi
80103c44:	56                   	push   %esi
80103c45:	53                   	push   %ebx
80103c46:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80103c49:	e8 92 fc ff ff       	call   801038e0 <mycpu>
80103c4e:	8d 78 04             	lea    0x4(%eax),%edi
80103c51:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103c53:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103c5a:	00 00 00 
80103c5d:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103c60:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103c61:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c64:	bb f4 3c 11 80       	mov    $0x80113cf4,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103c69:	68 c0 3c 11 80       	push   $0x80113cc0
80103c6e:	e8 3d 08 00 00       	call   801044b0 <acquire>
80103c73:	83 c4 10             	add    $0x10,%esp
80103c76:	eb 13                	jmp    80103c8b <scheduler+0x4b>
80103c78:	90                   	nop
80103c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c80:	83 c3 7c             	add    $0x7c,%ebx
80103c83:	81 fb f4 5b 11 80    	cmp    $0x80115bf4,%ebx
80103c89:	74 45                	je     80103cd0 <scheduler+0x90>
      if(p->state != RUNNABLE)
80103c8b:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103c8f:	75 ef                	jne    80103c80 <scheduler+0x40>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103c91:	83 ec 0c             	sub    $0xc,%esp
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
80103c94:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103c9a:	53                   	push   %ebx
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c9b:	83 c3 7c             	add    $0x7c,%ebx

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103c9e:	e8 ad 2e 00 00       	call   80106b50 <switchuvm>
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
80103ca3:	58                   	pop    %eax
80103ca4:	5a                   	pop    %edx
80103ca5:	ff 73 a0             	pushl  -0x60(%ebx)
80103ca8:	57                   	push   %edi
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103ca9:	c7 43 90 04 00 00 00 	movl   $0x4,-0x70(%ebx)

      swtch(&(c->scheduler), p->context);
80103cb0:	e8 c6 0b 00 00       	call   8010487b <swtch>
      switchkvm();
80103cb5:	e8 76 2e 00 00       	call   80106b30 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103cba:	83 c4 10             	add    $0x10,%esp
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103cbd:	81 fb f4 5b 11 80    	cmp    $0x80115bf4,%ebx
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103cc3:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103cca:	00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ccd:	75 bc                	jne    80103c8b <scheduler+0x4b>
80103ccf:	90                   	nop

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
80103cd0:	83 ec 0c             	sub    $0xc,%esp
80103cd3:	68 c0 3c 11 80       	push   $0x80113cc0
80103cd8:	e8 f3 08 00 00       	call   801045d0 <release>

  }
80103cdd:	83 c4 10             	add    $0x10,%esp
80103ce0:	e9 7b ff ff ff       	jmp    80103c60 <scheduler+0x20>
80103ce5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103cf0 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103cf0:	55                   	push   %ebp
80103cf1:	89 e5                	mov    %esp,%ebp
80103cf3:	56                   	push   %esi
80103cf4:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103cf5:	e8 76 07 00 00       	call   80104470 <pushcli>
  c = mycpu();
80103cfa:	e8 e1 fb ff ff       	call   801038e0 <mycpu>
  p = c->proc;
80103cff:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d05:	e8 56 08 00 00       	call   80104560 <popcli>
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
80103d0a:	83 ec 0c             	sub    $0xc,%esp
80103d0d:	68 c0 3c 11 80       	push   $0x80113cc0
80103d12:	e8 19 07 00 00       	call   80104430 <holding>
80103d17:	83 c4 10             	add    $0x10,%esp
80103d1a:	85 c0                	test   %eax,%eax
80103d1c:	74 4f                	je     80103d6d <sched+0x7d>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
80103d1e:	e8 bd fb ff ff       	call   801038e0 <mycpu>
80103d23:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103d2a:	75 68                	jne    80103d94 <sched+0xa4>
    panic("sched locks");
  if(p->state == RUNNING)
80103d2c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103d30:	74 55                	je     80103d87 <sched+0x97>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103d32:	9c                   	pushf  
80103d33:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
80103d34:	f6 c4 02             	test   $0x2,%ah
80103d37:	75 41                	jne    80103d7a <sched+0x8a>
    panic("sched interruptible");
  intena = mycpu()->intena;
80103d39:	e8 a2 fb ff ff       	call   801038e0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103d3e:	83 c3 1c             	add    $0x1c,%ebx
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
80103d41:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103d47:	e8 94 fb ff ff       	call   801038e0 <mycpu>
80103d4c:	83 ec 08             	sub    $0x8,%esp
80103d4f:	ff 70 04             	pushl  0x4(%eax)
80103d52:	53                   	push   %ebx
80103d53:	e8 23 0b 00 00       	call   8010487b <swtch>
  mycpu()->intena = intena;
80103d58:	e8 83 fb ff ff       	call   801038e0 <mycpu>
}
80103d5d:	83 c4 10             	add    $0x10,%esp
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
80103d60:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103d66:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103d69:	5b                   	pop    %ebx
80103d6a:	5e                   	pop    %esi
80103d6b:	5d                   	pop    %ebp
80103d6c:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103d6d:	83 ec 0c             	sub    $0xc,%esp
80103d70:	68 90 77 10 80       	push   $0x80107790
80103d75:	e8 f6 c5 ff ff       	call   80100370 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103d7a:	83 ec 0c             	sub    $0xc,%esp
80103d7d:	68 bc 77 10 80       	push   $0x801077bc
80103d82:	e8 e9 c5 ff ff       	call   80100370 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
80103d87:	83 ec 0c             	sub    $0xc,%esp
80103d8a:	68 ae 77 10 80       	push   $0x801077ae
80103d8f:	e8 dc c5 ff ff       	call   80100370 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80103d94:	83 ec 0c             	sub    $0xc,%esp
80103d97:	68 a2 77 10 80       	push   $0x801077a2
80103d9c:	e8 cf c5 ff ff       	call   80100370 <panic>
80103da1:	eb 0d                	jmp    80103db0 <exit>
80103da3:	90                   	nop
80103da4:	90                   	nop
80103da5:	90                   	nop
80103da6:	90                   	nop
80103da7:	90                   	nop
80103da8:	90                   	nop
80103da9:	90                   	nop
80103daa:	90                   	nop
80103dab:	90                   	nop
80103dac:	90                   	nop
80103dad:	90                   	nop
80103dae:	90                   	nop
80103daf:	90                   	nop

80103db0 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103db0:	55                   	push   %ebp
80103db1:	89 e5                	mov    %esp,%ebp
80103db3:	57                   	push   %edi
80103db4:	56                   	push   %esi
80103db5:	53                   	push   %ebx
80103db6:	83 ec 0c             	sub    $0xc,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103db9:	e8 b2 06 00 00       	call   80104470 <pushcli>
  c = mycpu();
80103dbe:	e8 1d fb ff ff       	call   801038e0 <mycpu>
  p = c->proc;
80103dc3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103dc9:	e8 92 07 00 00       	call   80104560 <popcli>
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  freescreen(curproc->pid);
80103dce:	83 ec 0c             	sub    $0xc,%esp
80103dd1:	ff 76 10             	pushl  0x10(%esi)
80103dd4:	8d 5e 28             	lea    0x28(%esi),%ebx
80103dd7:	8d 7e 68             	lea    0x68(%esi),%edi
80103dda:	e8 c1 ca ff ff       	call   801008a0 <freescreen>

  if(curproc == initproc)
80103ddf:	83 c4 10             	add    $0x10,%esp
80103de2:	39 35 58 b5 10 80    	cmp    %esi,0x8010b558
80103de8:	0f 84 e9 00 00 00    	je     80103ed7 <exit+0x127>
80103dee:	66 90                	xchg   %ax,%ax
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
80103df0:	8b 03                	mov    (%ebx),%eax
80103df2:	85 c0                	test   %eax,%eax
80103df4:	74 12                	je     80103e08 <exit+0x58>
      fileclose(curproc->ofile[fd]);
80103df6:	83 ec 0c             	sub    $0xc,%esp
80103df9:	50                   	push   %eax
80103dfa:	e8 31 d2 ff ff       	call   80101030 <fileclose>
      curproc->ofile[fd] = 0;
80103dff:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103e05:	83 c4 10             	add    $0x10,%esp
80103e08:	83 c3 04             	add    $0x4,%ebx

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103e0b:	39 df                	cmp    %ebx,%edi
80103e0d:	75 e1                	jne    80103df0 <exit+0x40>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
80103e0f:	e8 3c ef ff ff       	call   80102d50 <begin_op>
  iput(curproc->cwd);
80103e14:	83 ec 0c             	sub    $0xc,%esp
80103e17:	ff 76 68             	pushl  0x68(%esi)
80103e1a:	e8 81 db ff ff       	call   801019a0 <iput>
  end_op();
80103e1f:	e8 9c ef ff ff       	call   80102dc0 <end_op>
  curproc->cwd = 0;
80103e24:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)

  acquire(&ptable.lock);
80103e2b:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103e32:	e8 79 06 00 00       	call   801044b0 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80103e37:	8b 56 14             	mov    0x14(%esi),%edx
80103e3a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e3d:	b8 f4 3c 11 80       	mov    $0x80113cf4,%eax
80103e42:	eb 0e                	jmp    80103e52 <exit+0xa2>
80103e44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e48:	83 c0 7c             	add    $0x7c,%eax
80103e4b:	3d f4 5b 11 80       	cmp    $0x80115bf4,%eax
80103e50:	74 1c                	je     80103e6e <exit+0xbe>
    if(p->state == SLEEPING && p->chan == chan)
80103e52:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e56:	75 f0                	jne    80103e48 <exit+0x98>
80103e58:	3b 50 20             	cmp    0x20(%eax),%edx
80103e5b:	75 eb                	jne    80103e48 <exit+0x98>
      p->state = RUNNABLE;
80103e5d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e64:	83 c0 7c             	add    $0x7c,%eax
80103e67:	3d f4 5b 11 80       	cmp    $0x80115bf4,%eax
80103e6c:	75 e4                	jne    80103e52 <exit+0xa2>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103e6e:	8b 0d 58 b5 10 80    	mov    0x8010b558,%ecx
80103e74:	ba f4 3c 11 80       	mov    $0x80113cf4,%edx
80103e79:	eb 10                	jmp    80103e8b <exit+0xdb>
80103e7b:	90                   	nop
80103e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e80:	83 c2 7c             	add    $0x7c,%edx
80103e83:	81 fa f4 5b 11 80    	cmp    $0x80115bf4,%edx
80103e89:	74 33                	je     80103ebe <exit+0x10e>
    if(p->parent == curproc){
80103e8b:	39 72 14             	cmp    %esi,0x14(%edx)
80103e8e:	75 f0                	jne    80103e80 <exit+0xd0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103e90:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103e94:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103e97:	75 e7                	jne    80103e80 <exit+0xd0>
80103e99:	b8 f4 3c 11 80       	mov    $0x80113cf4,%eax
80103e9e:	eb 0a                	jmp    80103eaa <exit+0xfa>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ea0:	83 c0 7c             	add    $0x7c,%eax
80103ea3:	3d f4 5b 11 80       	cmp    $0x80115bf4,%eax
80103ea8:	74 d6                	je     80103e80 <exit+0xd0>
    if(p->state == SLEEPING && p->chan == chan)
80103eaa:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103eae:	75 f0                	jne    80103ea0 <exit+0xf0>
80103eb0:	3b 48 20             	cmp    0x20(%eax),%ecx
80103eb3:	75 eb                	jne    80103ea0 <exit+0xf0>
      p->state = RUNNABLE;
80103eb5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103ebc:	eb e2                	jmp    80103ea0 <exit+0xf0>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80103ebe:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103ec5:	e8 26 fe ff ff       	call   80103cf0 <sched>
  panic("zombie exit");
80103eca:	83 ec 0c             	sub    $0xc,%esp
80103ecd:	68 dd 77 10 80       	push   $0x801077dd
80103ed2:	e8 99 c4 ff ff       	call   80100370 <panic>
  int fd;

  freescreen(curproc->pid);

  if(curproc == initproc)
    panic("init exiting");
80103ed7:	83 ec 0c             	sub    $0xc,%esp
80103eda:	68 d0 77 10 80       	push   $0x801077d0
80103edf:	e8 8c c4 ff ff       	call   80100370 <panic>
80103ee4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103eea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103ef0 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103ef0:	55                   	push   %ebp
80103ef1:	89 e5                	mov    %esp,%ebp
80103ef3:	53                   	push   %ebx
80103ef4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103ef7:	68 c0 3c 11 80       	push   $0x80113cc0
80103efc:	e8 af 05 00 00       	call   801044b0 <acquire>
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103f01:	e8 6a 05 00 00       	call   80104470 <pushcli>
  c = mycpu();
80103f06:	e8 d5 f9 ff ff       	call   801038e0 <mycpu>
  p = c->proc;
80103f0b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f11:	e8 4a 06 00 00       	call   80104560 <popcli>
// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
80103f16:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103f1d:	e8 ce fd ff ff       	call   80103cf0 <sched>
  release(&ptable.lock);
80103f22:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103f29:	e8 a2 06 00 00       	call   801045d0 <release>
}
80103f2e:	83 c4 10             	add    $0x10,%esp
80103f31:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f34:	c9                   	leave  
80103f35:	c3                   	ret    
80103f36:	8d 76 00             	lea    0x0(%esi),%esi
80103f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103f40 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103f40:	55                   	push   %ebp
80103f41:	89 e5                	mov    %esp,%ebp
80103f43:	57                   	push   %edi
80103f44:	56                   	push   %esi
80103f45:	53                   	push   %ebx
80103f46:	83 ec 0c             	sub    $0xc,%esp
80103f49:	8b 7d 08             	mov    0x8(%ebp),%edi
80103f4c:	8b 75 0c             	mov    0xc(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103f4f:	e8 1c 05 00 00       	call   80104470 <pushcli>
  c = mycpu();
80103f54:	e8 87 f9 ff ff       	call   801038e0 <mycpu>
  p = c->proc;
80103f59:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f5f:	e8 fc 05 00 00       	call   80104560 <popcli>
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
80103f64:	85 db                	test   %ebx,%ebx
80103f66:	0f 84 87 00 00 00    	je     80103ff3 <sleep+0xb3>
    panic("sleep");

  if(lk == 0)
80103f6c:	85 f6                	test   %esi,%esi
80103f6e:	74 76                	je     80103fe6 <sleep+0xa6>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103f70:	81 fe c0 3c 11 80    	cmp    $0x80113cc0,%esi
80103f76:	74 50                	je     80103fc8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103f78:	83 ec 0c             	sub    $0xc,%esp
80103f7b:	68 c0 3c 11 80       	push   $0x80113cc0
80103f80:	e8 2b 05 00 00       	call   801044b0 <acquire>
    release(lk);
80103f85:	89 34 24             	mov    %esi,(%esp)
80103f88:	e8 43 06 00 00       	call   801045d0 <release>
  }
  // Go to sleep.
  p->chan = chan;
80103f8d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103f90:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80103f97:	e8 54 fd ff ff       	call   80103cf0 <sched>

  // Tidy up.
  p->chan = 0;
80103f9c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80103fa3:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
80103faa:	e8 21 06 00 00       	call   801045d0 <release>
    acquire(lk);
80103faf:	89 75 08             	mov    %esi,0x8(%ebp)
80103fb2:	83 c4 10             	add    $0x10,%esp
  }
}
80103fb5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103fb8:	5b                   	pop    %ebx
80103fb9:	5e                   	pop    %esi
80103fba:	5f                   	pop    %edi
80103fbb:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
80103fbc:	e9 ef 04 00 00       	jmp    801044b0 <acquire>
80103fc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
80103fc8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103fcb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80103fd2:	e8 19 fd ff ff       	call   80103cf0 <sched>

  // Tidy up.
  p->chan = 0;
80103fd7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
80103fde:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103fe1:	5b                   	pop    %ebx
80103fe2:	5e                   	pop    %esi
80103fe3:	5f                   	pop    %edi
80103fe4:	5d                   	pop    %ebp
80103fe5:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80103fe6:	83 ec 0c             	sub    $0xc,%esp
80103fe9:	68 ef 77 10 80       	push   $0x801077ef
80103fee:	e8 7d c3 ff ff       	call   80100370 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
80103ff3:	83 ec 0c             	sub    $0xc,%esp
80103ff6:	68 e9 77 10 80       	push   $0x801077e9
80103ffb:	e8 70 c3 ff ff       	call   80100370 <panic>

80104000 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80104000:	55                   	push   %ebp
80104001:	89 e5                	mov    %esp,%ebp
80104003:	56                   	push   %esi
80104004:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80104005:	e8 66 04 00 00       	call   80104470 <pushcli>
  c = mycpu();
8010400a:	e8 d1 f8 ff ff       	call   801038e0 <mycpu>
  p = c->proc;
8010400f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104015:	e8 46 05 00 00       	call   80104560 <popcli>
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
8010401a:	83 ec 0c             	sub    $0xc,%esp
8010401d:	68 c0 3c 11 80       	push   $0x80113cc0
80104022:	e8 89 04 00 00       	call   801044b0 <acquire>
80104027:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
8010402a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010402c:	bb f4 3c 11 80       	mov    $0x80113cf4,%ebx
80104031:	eb 10                	jmp    80104043 <wait+0x43>
80104033:	90                   	nop
80104034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104038:	83 c3 7c             	add    $0x7c,%ebx
8010403b:	81 fb f4 5b 11 80    	cmp    $0x80115bf4,%ebx
80104041:	74 1d                	je     80104060 <wait+0x60>
      if(p->parent != curproc)
80104043:	39 73 14             	cmp    %esi,0x14(%ebx)
80104046:	75 f0                	jne    80104038 <wait+0x38>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80104048:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010404c:	74 30                	je     8010407e <wait+0x7e>
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010404e:	83 c3 7c             	add    $0x7c,%ebx
      if(p->parent != curproc)
        continue;
      havekids = 1;
80104051:	b8 01 00 00 00       	mov    $0x1,%eax
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104056:	81 fb f4 5b 11 80    	cmp    $0x80115bf4,%ebx
8010405c:	75 e5                	jne    80104043 <wait+0x43>
8010405e:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80104060:	85 c0                	test   %eax,%eax
80104062:	74 70                	je     801040d4 <wait+0xd4>
80104064:	8b 46 24             	mov    0x24(%esi),%eax
80104067:	85 c0                	test   %eax,%eax
80104069:	75 69                	jne    801040d4 <wait+0xd4>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
8010406b:	83 ec 08             	sub    $0x8,%esp
8010406e:	68 c0 3c 11 80       	push   $0x80113cc0
80104073:	56                   	push   %esi
80104074:	e8 c7 fe ff ff       	call   80103f40 <sleep>
  }
80104079:	83 c4 10             	add    $0x10,%esp
8010407c:	eb ac                	jmp    8010402a <wait+0x2a>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
8010407e:	83 ec 0c             	sub    $0xc,%esp
80104081:	ff 73 08             	pushl  0x8(%ebx)
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80104084:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104087:	e8 54 e4 ff ff       	call   801024e0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
8010408c:	5a                   	pop    %edx
8010408d:	ff 73 04             	pushl  0x4(%ebx)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80104090:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104097:	e8 34 2e 00 00       	call   80106ed0 <freevm>
        p->pid = 0;
8010409c:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801040a3:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801040aa:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801040ae:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801040b5:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801040bc:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
801040c3:	e8 08 05 00 00       	call   801045d0 <release>
        return pid;
801040c8:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
801040cb:	8d 65 f8             	lea    -0x8(%ebp),%esp
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
801040ce:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
801040d0:	5b                   	pop    %ebx
801040d1:	5e                   	pop    %esi
801040d2:	5d                   	pop    %ebp
801040d3:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
801040d4:	83 ec 0c             	sub    $0xc,%esp
801040d7:	68 c0 3c 11 80       	push   $0x80113cc0
801040dc:	e8 ef 04 00 00       	call   801045d0 <release>
      return -1;
801040e1:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
801040e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
801040e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
801040ec:	5b                   	pop    %ebx
801040ed:	5e                   	pop    %esi
801040ee:	5d                   	pop    %ebp
801040ef:	c3                   	ret    

801040f0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801040f0:	55                   	push   %ebp
801040f1:	89 e5                	mov    %esp,%ebp
801040f3:	53                   	push   %ebx
801040f4:	83 ec 10             	sub    $0x10,%esp
801040f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801040fa:	68 c0 3c 11 80       	push   $0x80113cc0
801040ff:	e8 ac 03 00 00       	call   801044b0 <acquire>
80104104:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104107:	b8 f4 3c 11 80       	mov    $0x80113cf4,%eax
8010410c:	eb 0c                	jmp    8010411a <wakeup+0x2a>
8010410e:	66 90                	xchg   %ax,%ax
80104110:	83 c0 7c             	add    $0x7c,%eax
80104113:	3d f4 5b 11 80       	cmp    $0x80115bf4,%eax
80104118:	74 1c                	je     80104136 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010411a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010411e:	75 f0                	jne    80104110 <wakeup+0x20>
80104120:	3b 58 20             	cmp    0x20(%eax),%ebx
80104123:	75 eb                	jne    80104110 <wakeup+0x20>
      p->state = RUNNABLE;
80104125:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010412c:	83 c0 7c             	add    $0x7c,%eax
8010412f:	3d f4 5b 11 80       	cmp    $0x80115bf4,%eax
80104134:	75 e4                	jne    8010411a <wakeup+0x2a>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80104136:	c7 45 08 c0 3c 11 80 	movl   $0x80113cc0,0x8(%ebp)
}
8010413d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104140:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80104141:	e9 8a 04 00 00       	jmp    801045d0 <release>
80104146:	8d 76 00             	lea    0x0(%esi),%esi
80104149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104150 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104150:	55                   	push   %ebp
80104151:	89 e5                	mov    %esp,%ebp
80104153:	53                   	push   %ebx
80104154:	83 ec 10             	sub    $0x10,%esp
80104157:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010415a:	68 c0 3c 11 80       	push   $0x80113cc0
8010415f:	e8 4c 03 00 00       	call   801044b0 <acquire>
80104164:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104167:	b8 f4 3c 11 80       	mov    $0x80113cf4,%eax
8010416c:	eb 0c                	jmp    8010417a <kill+0x2a>
8010416e:	66 90                	xchg   %ax,%ax
80104170:	83 c0 7c             	add    $0x7c,%eax
80104173:	3d f4 5b 11 80       	cmp    $0x80115bf4,%eax
80104178:	74 3e                	je     801041b8 <kill+0x68>
    if(p->pid == pid){
8010417a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010417d:	75 f1                	jne    80104170 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010417f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
80104183:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010418a:	74 1c                	je     801041a8 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
8010418c:	83 ec 0c             	sub    $0xc,%esp
8010418f:	68 c0 3c 11 80       	push   $0x80113cc0
80104194:	e8 37 04 00 00       	call   801045d0 <release>
      return 0;
80104199:	83 c4 10             	add    $0x10,%esp
8010419c:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
8010419e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041a1:	c9                   	leave  
801041a2:	c3                   	ret    
801041a3:	90                   	nop
801041a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
801041a8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801041af:	eb db                	jmp    8010418c <kill+0x3c>
801041b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
801041b8:	83 ec 0c             	sub    $0xc,%esp
801041bb:	68 c0 3c 11 80       	push   $0x80113cc0
801041c0:	e8 0b 04 00 00       	call   801045d0 <release>
  return -1;
801041c5:	83 c4 10             	add    $0x10,%esp
801041c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801041cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041d0:	c9                   	leave  
801041d1:	c3                   	ret    
801041d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801041e0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801041e0:	55                   	push   %ebp
801041e1:	89 e5                	mov    %esp,%ebp
801041e3:	57                   	push   %edi
801041e4:	56                   	push   %esi
801041e5:	53                   	push   %ebx
801041e6:	8d 75 e8             	lea    -0x18(%ebp),%esi
801041e9:	bb 60 3d 11 80       	mov    $0x80113d60,%ebx
801041ee:	83 ec 3c             	sub    $0x3c,%esp
801041f1:	eb 24                	jmp    80104217 <procdump+0x37>
801041f3:	90                   	nop
801041f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801041f8:	83 ec 0c             	sub    $0xc,%esp
801041fb:	68 87 7b 10 80       	push   $0x80107b87
80104200:	e8 7b c4 ff ff       	call   80100680 <cprintf>
80104205:	83 c4 10             	add    $0x10,%esp
80104208:	83 c3 7c             	add    $0x7c,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010420b:	81 fb 60 5c 11 80    	cmp    $0x80115c60,%ebx
80104211:	0f 84 81 00 00 00    	je     80104298 <procdump+0xb8>
    if(p->state == UNUSED)
80104217:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010421a:	85 c0                	test   %eax,%eax
8010421c:	74 ea                	je     80104208 <procdump+0x28>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010421e:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
80104221:	ba 00 78 10 80       	mov    $0x80107800,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104226:	77 11                	ja     80104239 <procdump+0x59>
80104228:	8b 14 85 60 78 10 80 	mov    -0x7fef87a0(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
8010422f:	b8 00 78 10 80       	mov    $0x80107800,%eax
80104234:	85 d2                	test   %edx,%edx
80104236:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104239:	53                   	push   %ebx
8010423a:	52                   	push   %edx
8010423b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010423e:	68 04 78 10 80       	push   $0x80107804
80104243:	e8 38 c4 ff ff       	call   80100680 <cprintf>
    if(p->state == SLEEPING){
80104248:	83 c4 10             	add    $0x10,%esp
8010424b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010424f:	75 a7                	jne    801041f8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104251:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104254:	83 ec 08             	sub    $0x8,%esp
80104257:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010425a:	50                   	push   %eax
8010425b:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010425e:	8b 40 0c             	mov    0xc(%eax),%eax
80104261:	83 c0 08             	add    $0x8,%eax
80104264:	50                   	push   %eax
80104265:	e8 66 01 00 00       	call   801043d0 <getcallerpcs>
8010426a:	83 c4 10             	add    $0x10,%esp
8010426d:	8d 76 00             	lea    0x0(%esi),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104270:	8b 17                	mov    (%edi),%edx
80104272:	85 d2                	test   %edx,%edx
80104274:	74 82                	je     801041f8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104276:	83 ec 08             	sub    $0x8,%esp
80104279:	83 c7 04             	add    $0x4,%edi
8010427c:	52                   	push   %edx
8010427d:	68 41 72 10 80       	push   $0x80107241
80104282:	e8 f9 c3 ff ff       	call   80100680 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104287:	83 c4 10             	add    $0x10,%esp
8010428a:	39 f7                	cmp    %esi,%edi
8010428c:	75 e2                	jne    80104270 <procdump+0x90>
8010428e:	e9 65 ff ff ff       	jmp    801041f8 <procdump+0x18>
80104293:	90                   	nop
80104294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104298:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010429b:	5b                   	pop    %ebx
8010429c:	5e                   	pop    %esi
8010429d:	5f                   	pop    %edi
8010429e:	5d                   	pop    %ebp
8010429f:	c3                   	ret    

801042a0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801042a0:	55                   	push   %ebp
801042a1:	89 e5                	mov    %esp,%ebp
801042a3:	53                   	push   %ebx
801042a4:	83 ec 0c             	sub    $0xc,%esp
801042a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801042aa:	68 78 78 10 80       	push   $0x80107878
801042af:	8d 43 04             	lea    0x4(%ebx),%eax
801042b2:	50                   	push   %eax
801042b3:	e8 f8 00 00 00       	call   801043b0 <initlock>
  lk->name = name;
801042b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801042bb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801042c1:	83 c4 10             	add    $0x10,%esp
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
  lk->locked = 0;
  lk->pid = 0;
801042c4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
801042cb:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
801042ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042d1:	c9                   	leave  
801042d2:	c3                   	ret    
801042d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801042d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801042e0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801042e0:	55                   	push   %ebp
801042e1:	89 e5                	mov    %esp,%ebp
801042e3:	56                   	push   %esi
801042e4:	53                   	push   %ebx
801042e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801042e8:	83 ec 0c             	sub    $0xc,%esp
801042eb:	8d 73 04             	lea    0x4(%ebx),%esi
801042ee:	56                   	push   %esi
801042ef:	e8 bc 01 00 00       	call   801044b0 <acquire>
  while (lk->locked) {
801042f4:	8b 13                	mov    (%ebx),%edx
801042f6:	83 c4 10             	add    $0x10,%esp
801042f9:	85 d2                	test   %edx,%edx
801042fb:	74 16                	je     80104313 <acquiresleep+0x33>
801042fd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104300:	83 ec 08             	sub    $0x8,%esp
80104303:	56                   	push   %esi
80104304:	53                   	push   %ebx
80104305:	e8 36 fc ff ff       	call   80103f40 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
8010430a:	8b 03                	mov    (%ebx),%eax
8010430c:	83 c4 10             	add    $0x10,%esp
8010430f:	85 c0                	test   %eax,%eax
80104311:	75 ed                	jne    80104300 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80104313:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104319:	e8 62 f6 ff ff       	call   80103980 <myproc>
8010431e:	8b 40 10             	mov    0x10(%eax),%eax
80104321:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104324:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104327:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010432a:	5b                   	pop    %ebx
8010432b:	5e                   	pop    %esi
8010432c:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
8010432d:	e9 9e 02 00 00       	jmp    801045d0 <release>
80104332:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104340 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
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
8010434f:	e8 5c 01 00 00       	call   801044b0 <acquire>
  lk->locked = 0;
80104354:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010435a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104361:	89 1c 24             	mov    %ebx,(%esp)
80104364:	e8 87 fd ff ff       	call   801040f0 <wakeup>
  release(&lk->lk);
80104369:	89 75 08             	mov    %esi,0x8(%ebp)
8010436c:	83 c4 10             	add    $0x10,%esp
}
8010436f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104372:	5b                   	pop    %ebx
80104373:	5e                   	pop    %esi
80104374:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
80104375:	e9 56 02 00 00       	jmp    801045d0 <release>
8010437a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104380 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
80104380:	55                   	push   %ebp
80104381:	89 e5                	mov    %esp,%ebp
80104383:	56                   	push   %esi
80104384:	53                   	push   %ebx
80104385:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
80104388:	83 ec 0c             	sub    $0xc,%esp
8010438b:	8d 5e 04             	lea    0x4(%esi),%ebx
8010438e:	53                   	push   %ebx
8010438f:	e8 1c 01 00 00       	call   801044b0 <acquire>
  r = lk->locked;
80104394:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
80104396:	89 1c 24             	mov    %ebx,(%esp)
80104399:	e8 32 02 00 00       	call   801045d0 <release>
  return r;
}
8010439e:	8d 65 f8             	lea    -0x8(%ebp),%esp
801043a1:	89 f0                	mov    %esi,%eax
801043a3:	5b                   	pop    %ebx
801043a4:	5e                   	pop    %esi
801043a5:	5d                   	pop    %ebp
801043a6:	c3                   	ret    
801043a7:	66 90                	xchg   %ax,%ax
801043a9:	66 90                	xchg   %ax,%ax
801043ab:	66 90                	xchg   %ax,%ax
801043ad:	66 90                	xchg   %ax,%ax
801043af:	90                   	nop

801043b0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801043b0:	55                   	push   %ebp
801043b1:	89 e5                	mov    %esp,%ebp
801043b3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801043b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801043b9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
801043bf:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
801043c2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801043c9:	5d                   	pop    %ebp
801043ca:	c3                   	ret    
801043cb:	90                   	nop
801043cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801043d0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801043d0:	55                   	push   %ebp
801043d1:	89 e5                	mov    %esp,%ebp
801043d3:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801043d4:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801043d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801043da:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
801043dd:	31 c0                	xor    %eax,%eax
801043df:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801043e0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801043e6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801043ec:	77 1a                	ja     80104408 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
801043ee:	8b 5a 04             	mov    0x4(%edx),%ebx
801043f1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801043f4:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
801043f7:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801043f9:	83 f8 0a             	cmp    $0xa,%eax
801043fc:	75 e2                	jne    801043e0 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801043fe:	5b                   	pop    %ebx
801043ff:	5d                   	pop    %ebp
80104400:	c3                   	ret    
80104401:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104408:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010440f:	83 c0 01             	add    $0x1,%eax
80104412:	83 f8 0a             	cmp    $0xa,%eax
80104415:	74 e7                	je     801043fe <getcallerpcs+0x2e>
    pcs[i] = 0;
80104417:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010441e:	83 c0 01             	add    $0x1,%eax
80104421:	83 f8 0a             	cmp    $0xa,%eax
80104424:	75 e2                	jne    80104408 <getcallerpcs+0x38>
80104426:	eb d6                	jmp    801043fe <getcallerpcs+0x2e>
80104428:	90                   	nop
80104429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104430 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104430:	55                   	push   %ebp
80104431:	89 e5                	mov    %esp,%ebp
80104433:	53                   	push   %ebx
80104434:	83 ec 04             	sub    $0x4,%esp
80104437:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == mycpu();
8010443a:	8b 02                	mov    (%edx),%eax
8010443c:	85 c0                	test   %eax,%eax
8010443e:	75 10                	jne    80104450 <holding+0x20>
}
80104440:	83 c4 04             	add    $0x4,%esp
80104443:	31 c0                	xor    %eax,%eax
80104445:	5b                   	pop    %ebx
80104446:	5d                   	pop    %ebp
80104447:	c3                   	ret    
80104448:	90                   	nop
80104449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80104450:	8b 5a 08             	mov    0x8(%edx),%ebx
80104453:	e8 88 f4 ff ff       	call   801038e0 <mycpu>
80104458:	39 c3                	cmp    %eax,%ebx
8010445a:	0f 94 c0             	sete   %al
}
8010445d:	83 c4 04             	add    $0x4,%esp

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80104460:	0f b6 c0             	movzbl %al,%eax
}
80104463:	5b                   	pop    %ebx
80104464:	5d                   	pop    %ebp
80104465:	c3                   	ret    
80104466:	8d 76 00             	lea    0x0(%esi),%esi
80104469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104470 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104470:	55                   	push   %ebp
80104471:	89 e5                	mov    %esp,%ebp
80104473:	53                   	push   %ebx
80104474:	83 ec 04             	sub    $0x4,%esp
80104477:	9c                   	pushf  
80104478:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
80104479:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010447a:	e8 61 f4 ff ff       	call   801038e0 <mycpu>
8010447f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104485:	85 c0                	test   %eax,%eax
80104487:	75 11                	jne    8010449a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104489:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010448f:	e8 4c f4 ff ff       	call   801038e0 <mycpu>
80104494:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010449a:	e8 41 f4 ff ff       	call   801038e0 <mycpu>
8010449f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801044a6:	83 c4 04             	add    $0x4,%esp
801044a9:	5b                   	pop    %ebx
801044aa:	5d                   	pop    %ebp
801044ab:	c3                   	ret    
801044ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801044b0 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
801044b0:	55                   	push   %ebp
801044b1:	89 e5                	mov    %esp,%ebp
801044b3:	56                   	push   %esi
801044b4:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
801044b5:	e8 b6 ff ff ff       	call   80104470 <pushcli>
  if(holding(lk))
801044ba:	8b 5d 08             	mov    0x8(%ebp),%ebx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
801044bd:	8b 03                	mov    (%ebx),%eax
801044bf:	85 c0                	test   %eax,%eax
801044c1:	75 7d                	jne    80104540 <acquire+0x90>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801044c3:	ba 01 00 00 00       	mov    $0x1,%edx
801044c8:	eb 09                	jmp    801044d3 <acquire+0x23>
801044ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801044d0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801044d3:	89 d0                	mov    %edx,%eax
801044d5:	f0 87 03             	lock xchg %eax,(%ebx)
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
801044d8:	85 c0                	test   %eax,%eax
801044da:	75 f4                	jne    801044d0 <acquire+0x20>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
801044dc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
801044e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801044e4:	e8 f7 f3 ff ff       	call   801038e0 <mycpu>
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801044e9:	89 ea                	mov    %ebp,%edx
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
801044eb:	8d 4b 0c             	lea    0xc(%ebx),%ecx
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
801044ee:	89 43 08             	mov    %eax,0x8(%ebx)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801044f1:	31 c0                	xor    %eax,%eax
801044f3:	90                   	nop
801044f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801044f8:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801044fe:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104504:	77 1a                	ja     80104520 <acquire+0x70>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104506:	8b 5a 04             	mov    0x4(%edx),%ebx
80104509:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
8010450c:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
8010450f:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104511:	83 f8 0a             	cmp    $0xa,%eax
80104514:	75 e2                	jne    801044f8 <acquire+0x48>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}
80104516:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104519:	5b                   	pop    %ebx
8010451a:	5e                   	pop    %esi
8010451b:	5d                   	pop    %ebp
8010451c:	c3                   	ret    
8010451d:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104520:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104527:	83 c0 01             	add    $0x1,%eax
8010452a:	83 f8 0a             	cmp    $0xa,%eax
8010452d:	74 e7                	je     80104516 <acquire+0x66>
    pcs[i] = 0;
8010452f:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104536:	83 c0 01             	add    $0x1,%eax
80104539:	83 f8 0a             	cmp    $0xa,%eax
8010453c:	75 e2                	jne    80104520 <acquire+0x70>
8010453e:	eb d6                	jmp    80104516 <acquire+0x66>

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80104540:	8b 73 08             	mov    0x8(%ebx),%esi
80104543:	e8 98 f3 ff ff       	call   801038e0 <mycpu>
80104548:	39 c6                	cmp    %eax,%esi
8010454a:	0f 85 73 ff ff ff    	jne    801044c3 <acquire+0x13>
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80104550:	83 ec 0c             	sub    $0xc,%esp
80104553:	68 83 78 10 80       	push   $0x80107883
80104558:	e8 13 be ff ff       	call   80100370 <panic>
8010455d:	8d 76 00             	lea    0x0(%esi),%esi

80104560 <popcli>:
  mycpu()->ncli += 1;
}

void
popcli(void)
{
80104560:	55                   	push   %ebp
80104561:	89 e5                	mov    %esp,%ebp
80104563:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104566:	9c                   	pushf  
80104567:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104568:	f6 c4 02             	test   $0x2,%ah
8010456b:	75 52                	jne    801045bf <popcli+0x5f>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010456d:	e8 6e f3 ff ff       	call   801038e0 <mycpu>
80104572:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80104578:	8d 51 ff             	lea    -0x1(%ecx),%edx
8010457b:	85 d2                	test   %edx,%edx
8010457d:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80104583:	78 2d                	js     801045b2 <popcli+0x52>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104585:	e8 56 f3 ff ff       	call   801038e0 <mycpu>
8010458a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104590:	85 d2                	test   %edx,%edx
80104592:	74 0c                	je     801045a0 <popcli+0x40>
    sti();
}
80104594:	c9                   	leave  
80104595:	c3                   	ret    
80104596:	8d 76 00             	lea    0x0(%esi),%esi
80104599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801045a0:	e8 3b f3 ff ff       	call   801038e0 <mycpu>
801045a5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801045ab:	85 c0                	test   %eax,%eax
801045ad:	74 e5                	je     80104594 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
801045af:	fb                   	sti    
    sti();
}
801045b0:	c9                   	leave  
801045b1:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
801045b2:	83 ec 0c             	sub    $0xc,%esp
801045b5:	68 a2 78 10 80       	push   $0x801078a2
801045ba:	e8 b1 bd ff ff       	call   80100370 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
801045bf:	83 ec 0c             	sub    $0xc,%esp
801045c2:	68 8b 78 10 80       	push   $0x8010788b
801045c7:	e8 a4 bd ff ff       	call   80100370 <panic>
801045cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801045d0 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
801045d0:	55                   	push   %ebp
801045d1:	89 e5                	mov    %esp,%ebp
801045d3:	56                   	push   %esi
801045d4:	53                   	push   %ebx
801045d5:	8b 5d 08             	mov    0x8(%ebp),%ebx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
801045d8:	8b 03                	mov    (%ebx),%eax
801045da:	85 c0                	test   %eax,%eax
801045dc:	75 12                	jne    801045f0 <release+0x20>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
801045de:	83 ec 0c             	sub    $0xc,%esp
801045e1:	68 a9 78 10 80       	push   $0x801078a9
801045e6:	e8 85 bd ff ff       	call   80100370 <panic>
801045eb:	90                   	nop
801045ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
801045f0:	8b 73 08             	mov    0x8(%ebx),%esi
801045f3:	e8 e8 f2 ff ff       	call   801038e0 <mycpu>
801045f8:	39 c6                	cmp    %eax,%esi
801045fa:	75 e2                	jne    801045de <release+0xe>
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");

  lk->pcs[0] = 0;
801045fc:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104603:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
8010460a:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010460f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
80104615:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104618:	5b                   	pop    %ebx
80104619:	5e                   	pop    %esi
8010461a:	5d                   	pop    %ebp
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
8010461b:	e9 40 ff ff ff       	jmp    80104560 <popcli>

80104620 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104620:	55                   	push   %ebp
80104621:	89 e5                	mov    %esp,%ebp
80104623:	57                   	push   %edi
80104624:	53                   	push   %ebx
80104625:	8b 55 08             	mov    0x8(%ebp),%edx
80104628:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010462b:	f6 c2 03             	test   $0x3,%dl
8010462e:	75 05                	jne    80104635 <memset+0x15>
80104630:	f6 c1 03             	test   $0x3,%cl
80104633:	74 13                	je     80104648 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
80104635:	89 d7                	mov    %edx,%edi
80104637:	8b 45 0c             	mov    0xc(%ebp),%eax
8010463a:	fc                   	cld    
8010463b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010463d:	5b                   	pop    %ebx
8010463e:	89 d0                	mov    %edx,%eax
80104640:	5f                   	pop    %edi
80104641:	5d                   	pop    %ebp
80104642:	c3                   	ret    
80104643:	90                   	nop
80104644:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
80104648:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
8010464c:	c1 e9 02             	shr    $0x2,%ecx
8010464f:	89 fb                	mov    %edi,%ebx
80104651:	89 f8                	mov    %edi,%eax
80104653:	c1 e3 18             	shl    $0x18,%ebx
80104656:	c1 e0 10             	shl    $0x10,%eax
80104659:	09 d8                	or     %ebx,%eax
8010465b:	09 f8                	or     %edi,%eax
8010465d:	c1 e7 08             	shl    $0x8,%edi
80104660:	09 f8                	or     %edi,%eax
80104662:	89 d7                	mov    %edx,%edi
80104664:	fc                   	cld    
80104665:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104667:	5b                   	pop    %ebx
80104668:	89 d0                	mov    %edx,%eax
8010466a:	5f                   	pop    %edi
8010466b:	5d                   	pop    %ebp
8010466c:	c3                   	ret    
8010466d:	8d 76 00             	lea    0x0(%esi),%esi

80104670 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104670:	55                   	push   %ebp
80104671:	89 e5                	mov    %esp,%ebp
80104673:	57                   	push   %edi
80104674:	56                   	push   %esi
80104675:	8b 45 10             	mov    0x10(%ebp),%eax
80104678:	53                   	push   %ebx
80104679:	8b 75 0c             	mov    0xc(%ebp),%esi
8010467c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010467f:	85 c0                	test   %eax,%eax
80104681:	74 29                	je     801046ac <memcmp+0x3c>
    if(*s1 != *s2)
80104683:	0f b6 13             	movzbl (%ebx),%edx
80104686:	0f b6 0e             	movzbl (%esi),%ecx
80104689:	38 d1                	cmp    %dl,%cl
8010468b:	75 2b                	jne    801046b8 <memcmp+0x48>
8010468d:	8d 78 ff             	lea    -0x1(%eax),%edi
80104690:	31 c0                	xor    %eax,%eax
80104692:	eb 14                	jmp    801046a8 <memcmp+0x38>
80104694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104698:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
8010469d:	83 c0 01             	add    $0x1,%eax
801046a0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
801046a4:	38 ca                	cmp    %cl,%dl
801046a6:	75 10                	jne    801046b8 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801046a8:	39 f8                	cmp    %edi,%eax
801046aa:	75 ec                	jne    80104698 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
801046ac:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
801046ad:	31 c0                	xor    %eax,%eax
}
801046af:	5e                   	pop    %esi
801046b0:	5f                   	pop    %edi
801046b1:	5d                   	pop    %ebp
801046b2:	c3                   	ret    
801046b3:	90                   	nop
801046b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
801046b8:	0f b6 c2             	movzbl %dl,%eax
    s1++, s2++;
  }

  return 0;
}
801046bb:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
801046bc:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
801046be:	5e                   	pop    %esi
801046bf:	5f                   	pop    %edi
801046c0:	5d                   	pop    %ebp
801046c1:	c3                   	ret    
801046c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046d0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801046d0:	55                   	push   %ebp
801046d1:	89 e5                	mov    %esp,%ebp
801046d3:	56                   	push   %esi
801046d4:	53                   	push   %ebx
801046d5:	8b 45 08             	mov    0x8(%ebp),%eax
801046d8:	8b 75 0c             	mov    0xc(%ebp),%esi
801046db:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801046de:	39 c6                	cmp    %eax,%esi
801046e0:	73 2e                	jae    80104710 <memmove+0x40>
801046e2:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
801046e5:	39 c8                	cmp    %ecx,%eax
801046e7:	73 27                	jae    80104710 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
801046e9:	85 db                	test   %ebx,%ebx
801046eb:	8d 53 ff             	lea    -0x1(%ebx),%edx
801046ee:	74 17                	je     80104707 <memmove+0x37>
      *--d = *--s;
801046f0:	29 d9                	sub    %ebx,%ecx
801046f2:	89 cb                	mov    %ecx,%ebx
801046f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046f8:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801046fc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
801046ff:	83 ea 01             	sub    $0x1,%edx
80104702:	83 fa ff             	cmp    $0xffffffff,%edx
80104705:	75 f1                	jne    801046f8 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104707:	5b                   	pop    %ebx
80104708:	5e                   	pop    %esi
80104709:	5d                   	pop    %ebp
8010470a:	c3                   	ret    
8010470b:	90                   	nop
8010470c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80104710:	31 d2                	xor    %edx,%edx
80104712:	85 db                	test   %ebx,%ebx
80104714:	74 f1                	je     80104707 <memmove+0x37>
80104716:	8d 76 00             	lea    0x0(%esi),%esi
80104719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *d++ = *s++;
80104720:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104724:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104727:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
8010472a:	39 d3                	cmp    %edx,%ebx
8010472c:	75 f2                	jne    80104720 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
8010472e:	5b                   	pop    %ebx
8010472f:	5e                   	pop    %esi
80104730:	5d                   	pop    %ebp
80104731:	c3                   	ret    
80104732:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104740 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104743:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104744:	eb 8a                	jmp    801046d0 <memmove>
80104746:	8d 76 00             	lea    0x0(%esi),%esi
80104749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104750 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104750:	55                   	push   %ebp
80104751:	89 e5                	mov    %esp,%ebp
80104753:	57                   	push   %edi
80104754:	56                   	push   %esi
80104755:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104758:	53                   	push   %ebx
80104759:	8b 7d 08             	mov    0x8(%ebp),%edi
8010475c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010475f:	85 c9                	test   %ecx,%ecx
80104761:	74 37                	je     8010479a <strncmp+0x4a>
80104763:	0f b6 17             	movzbl (%edi),%edx
80104766:	0f b6 1e             	movzbl (%esi),%ebx
80104769:	84 d2                	test   %dl,%dl
8010476b:	74 3f                	je     801047ac <strncmp+0x5c>
8010476d:	38 d3                	cmp    %dl,%bl
8010476f:	75 3b                	jne    801047ac <strncmp+0x5c>
80104771:	8d 47 01             	lea    0x1(%edi),%eax
80104774:	01 cf                	add    %ecx,%edi
80104776:	eb 1b                	jmp    80104793 <strncmp+0x43>
80104778:	90                   	nop
80104779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104780:	0f b6 10             	movzbl (%eax),%edx
80104783:	84 d2                	test   %dl,%dl
80104785:	74 21                	je     801047a8 <strncmp+0x58>
80104787:	0f b6 19             	movzbl (%ecx),%ebx
8010478a:	83 c0 01             	add    $0x1,%eax
8010478d:	89 ce                	mov    %ecx,%esi
8010478f:	38 da                	cmp    %bl,%dl
80104791:	75 19                	jne    801047ac <strncmp+0x5c>
80104793:	39 c7                	cmp    %eax,%edi
    n--, p++, q++;
80104795:	8d 4e 01             	lea    0x1(%esi),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80104798:	75 e6                	jne    80104780 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
8010479a:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
8010479b:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
8010479d:	5e                   	pop    %esi
8010479e:	5f                   	pop    %edi
8010479f:	5d                   	pop    %ebp
801047a0:	c3                   	ret    
801047a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047a8:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
801047ac:	0f b6 c2             	movzbl %dl,%eax
801047af:	29 d8                	sub    %ebx,%eax
}
801047b1:	5b                   	pop    %ebx
801047b2:	5e                   	pop    %esi
801047b3:	5f                   	pop    %edi
801047b4:	5d                   	pop    %ebp
801047b5:	c3                   	ret    
801047b6:	8d 76 00             	lea    0x0(%esi),%esi
801047b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047c0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801047c0:	55                   	push   %ebp
801047c1:	89 e5                	mov    %esp,%ebp
801047c3:	56                   	push   %esi
801047c4:	53                   	push   %ebx
801047c5:	8b 45 08             	mov    0x8(%ebp),%eax
801047c8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801047cb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801047ce:	89 c2                	mov    %eax,%edx
801047d0:	eb 19                	jmp    801047eb <strncpy+0x2b>
801047d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801047d8:	83 c3 01             	add    $0x1,%ebx
801047db:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
801047df:	83 c2 01             	add    $0x1,%edx
801047e2:	84 c9                	test   %cl,%cl
801047e4:	88 4a ff             	mov    %cl,-0x1(%edx)
801047e7:	74 09                	je     801047f2 <strncpy+0x32>
801047e9:	89 f1                	mov    %esi,%ecx
801047eb:	85 c9                	test   %ecx,%ecx
801047ed:	8d 71 ff             	lea    -0x1(%ecx),%esi
801047f0:	7f e6                	jg     801047d8 <strncpy+0x18>
    ;
  while(n-- > 0)
801047f2:	31 c9                	xor    %ecx,%ecx
801047f4:	85 f6                	test   %esi,%esi
801047f6:	7e 17                	jle    8010480f <strncpy+0x4f>
801047f8:	90                   	nop
801047f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104800:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104804:	89 f3                	mov    %esi,%ebx
80104806:	83 c1 01             	add    $0x1,%ecx
80104809:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
8010480b:	85 db                	test   %ebx,%ebx
8010480d:	7f f1                	jg     80104800 <strncpy+0x40>
    *s++ = 0;
  return os;
}
8010480f:	5b                   	pop    %ebx
80104810:	5e                   	pop    %esi
80104811:	5d                   	pop    %ebp
80104812:	c3                   	ret    
80104813:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104820 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104820:	55                   	push   %ebp
80104821:	89 e5                	mov    %esp,%ebp
80104823:	56                   	push   %esi
80104824:	53                   	push   %ebx
80104825:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104828:	8b 45 08             	mov    0x8(%ebp),%eax
8010482b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010482e:	85 c9                	test   %ecx,%ecx
80104830:	7e 26                	jle    80104858 <safestrcpy+0x38>
80104832:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104836:	89 c1                	mov    %eax,%ecx
80104838:	eb 17                	jmp    80104851 <safestrcpy+0x31>
8010483a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104840:	83 c2 01             	add    $0x1,%edx
80104843:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104847:	83 c1 01             	add    $0x1,%ecx
8010484a:	84 db                	test   %bl,%bl
8010484c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010484f:	74 04                	je     80104855 <safestrcpy+0x35>
80104851:	39 f2                	cmp    %esi,%edx
80104853:	75 eb                	jne    80104840 <safestrcpy+0x20>
    ;
  *s = 0;
80104855:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104858:	5b                   	pop    %ebx
80104859:	5e                   	pop    %esi
8010485a:	5d                   	pop    %ebp
8010485b:	c3                   	ret    
8010485c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104860 <strlen>:

int
strlen(const char *s)
{
80104860:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104861:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
80104863:	89 e5                	mov    %esp,%ebp
80104865:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80104868:	80 3a 00             	cmpb   $0x0,(%edx)
8010486b:	74 0c                	je     80104879 <strlen+0x19>
8010486d:	8d 76 00             	lea    0x0(%esi),%esi
80104870:	83 c0 01             	add    $0x1,%eax
80104873:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104877:	75 f7                	jne    80104870 <strlen+0x10>
    ;
  return n;
}
80104879:	5d                   	pop    %ebp
8010487a:	c3                   	ret    

8010487b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010487b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010487f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80104883:	55                   	push   %ebp
  pushl %ebx
80104884:	53                   	push   %ebx
  pushl %esi
80104885:	56                   	push   %esi
  pushl %edi
80104886:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104887:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104889:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
8010488b:	5f                   	pop    %edi
  popl %esi
8010488c:	5e                   	pop    %esi
  popl %ebx
8010488d:	5b                   	pop    %ebx
  popl %ebp
8010488e:	5d                   	pop    %ebp
  ret
8010488f:	c3                   	ret    

80104890 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104890:	55                   	push   %ebp
80104891:	89 e5                	mov    %esp,%ebp
80104893:	53                   	push   %ebx
80104894:	83 ec 04             	sub    $0x4,%esp
80104897:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010489a:	e8 e1 f0 ff ff       	call   80103980 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010489f:	8b 00                	mov    (%eax),%eax
801048a1:	39 d8                	cmp    %ebx,%eax
801048a3:	76 1b                	jbe    801048c0 <fetchint+0x30>
801048a5:	8d 53 04             	lea    0x4(%ebx),%edx
801048a8:	39 d0                	cmp    %edx,%eax
801048aa:	72 14                	jb     801048c0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801048ac:	8b 45 0c             	mov    0xc(%ebp),%eax
801048af:	8b 13                	mov    (%ebx),%edx
801048b1:	89 10                	mov    %edx,(%eax)
  return 0;
801048b3:	31 c0                	xor    %eax,%eax
}
801048b5:	83 c4 04             	add    $0x4,%esp
801048b8:	5b                   	pop    %ebx
801048b9:	5d                   	pop    %ebp
801048ba:	c3                   	ret    
801048bb:	90                   	nop
801048bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
801048c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801048c5:	eb ee                	jmp    801048b5 <fetchint+0x25>
801048c7:	89 f6                	mov    %esi,%esi
801048c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048d0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801048d0:	55                   	push   %ebp
801048d1:	89 e5                	mov    %esp,%ebp
801048d3:	53                   	push   %ebx
801048d4:	83 ec 04             	sub    $0x4,%esp
801048d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801048da:	e8 a1 f0 ff ff       	call   80103980 <myproc>

  if(addr >= curproc->sz)
801048df:	39 18                	cmp    %ebx,(%eax)
801048e1:	76 29                	jbe    8010490c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
801048e3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801048e6:	89 da                	mov    %ebx,%edx
801048e8:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
801048ea:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
801048ec:	39 c3                	cmp    %eax,%ebx
801048ee:	73 1c                	jae    8010490c <fetchstr+0x3c>
    if(*s == 0)
801048f0:	80 3b 00             	cmpb   $0x0,(%ebx)
801048f3:	75 10                	jne    80104905 <fetchstr+0x35>
801048f5:	eb 29                	jmp    80104920 <fetchstr+0x50>
801048f7:	89 f6                	mov    %esi,%esi
801048f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104900:	80 3a 00             	cmpb   $0x0,(%edx)
80104903:	74 1b                	je     80104920 <fetchstr+0x50>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
80104905:	83 c2 01             	add    $0x1,%edx
80104908:	39 d0                	cmp    %edx,%eax
8010490a:	77 f4                	ja     80104900 <fetchstr+0x30>
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
8010490c:	83 c4 04             	add    $0x4,%esp
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
8010490f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80104914:	5b                   	pop    %ebx
80104915:	5d                   	pop    %ebp
80104916:	c3                   	ret    
80104917:	89 f6                	mov    %esi,%esi
80104919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104920:	83 c4 04             	add    $0x4,%esp
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
80104923:	89 d0                	mov    %edx,%eax
80104925:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104927:	5b                   	pop    %ebx
80104928:	5d                   	pop    %ebp
80104929:	c3                   	ret    
8010492a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104930 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104930:	55                   	push   %ebp
80104931:	89 e5                	mov    %esp,%ebp
80104933:	56                   	push   %esi
80104934:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104935:	e8 46 f0 ff ff       	call   80103980 <myproc>
8010493a:	8b 40 18             	mov    0x18(%eax),%eax
8010493d:	8b 55 08             	mov    0x8(%ebp),%edx
80104940:	8b 40 44             	mov    0x44(%eax),%eax
80104943:	8d 1c 90             	lea    (%eax,%edx,4),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();
80104946:	e8 35 f0 ff ff       	call   80103980 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010494b:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010494d:	8d 73 04             	lea    0x4(%ebx),%esi
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104950:	39 c6                	cmp    %eax,%esi
80104952:	73 1c                	jae    80104970 <argint+0x40>
80104954:	8d 53 08             	lea    0x8(%ebx),%edx
80104957:	39 d0                	cmp    %edx,%eax
80104959:	72 15                	jb     80104970 <argint+0x40>
    return -1;
  *ip = *(int*)(addr);
8010495b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010495e:	8b 53 04             	mov    0x4(%ebx),%edx
80104961:	89 10                	mov    %edx,(%eax)
  return 0;
80104963:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
}
80104965:	5b                   	pop    %ebx
80104966:	5e                   	pop    %esi
80104967:	5d                   	pop    %ebp
80104968:	c3                   	ret    
80104969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104970:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104975:	eb ee                	jmp    80104965 <argint+0x35>
80104977:	89 f6                	mov    %esi,%esi
80104979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104980 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104980:	55                   	push   %ebp
80104981:	89 e5                	mov    %esp,%ebp
80104983:	56                   	push   %esi
80104984:	53                   	push   %ebx
80104985:	83 ec 10             	sub    $0x10,%esp
80104988:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010498b:	e8 f0 ef ff ff       	call   80103980 <myproc>
80104990:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104992:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104995:	83 ec 08             	sub    $0x8,%esp
80104998:	50                   	push   %eax
80104999:	ff 75 08             	pushl  0x8(%ebp)
8010499c:	e8 8f ff ff ff       	call   80104930 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801049a1:	c1 e8 1f             	shr    $0x1f,%eax
801049a4:	83 c4 10             	add    $0x10,%esp
801049a7:	84 c0                	test   %al,%al
801049a9:	75 2d                	jne    801049d8 <argptr+0x58>
801049ab:	89 d8                	mov    %ebx,%eax
801049ad:	c1 e8 1f             	shr    $0x1f,%eax
801049b0:	84 c0                	test   %al,%al
801049b2:	75 24                	jne    801049d8 <argptr+0x58>
801049b4:	8b 16                	mov    (%esi),%edx
801049b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049b9:	39 c2                	cmp    %eax,%edx
801049bb:	76 1b                	jbe    801049d8 <argptr+0x58>
801049bd:	01 c3                	add    %eax,%ebx
801049bf:	39 da                	cmp    %ebx,%edx
801049c1:	72 15                	jb     801049d8 <argptr+0x58>
    return -1;
  *pp = (char*)i;
801049c3:	8b 55 0c             	mov    0xc(%ebp),%edx
801049c6:	89 02                	mov    %eax,(%edx)
  return 0;
801049c8:	31 c0                	xor    %eax,%eax
}
801049ca:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049cd:	5b                   	pop    %ebx
801049ce:	5e                   	pop    %esi
801049cf:	5d                   	pop    %ebp
801049d0:	c3                   	ret    
801049d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
801049d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049dd:	eb eb                	jmp    801049ca <argptr+0x4a>
801049df:	90                   	nop

801049e0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801049e0:	55                   	push   %ebp
801049e1:	89 e5                	mov    %esp,%ebp
801049e3:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
801049e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801049e9:	50                   	push   %eax
801049ea:	ff 75 08             	pushl  0x8(%ebp)
801049ed:	e8 3e ff ff ff       	call   80104930 <argint>
801049f2:	83 c4 10             	add    $0x10,%esp
801049f5:	85 c0                	test   %eax,%eax
801049f7:	78 17                	js     80104a10 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
801049f9:	83 ec 08             	sub    $0x8,%esp
801049fc:	ff 75 0c             	pushl  0xc(%ebp)
801049ff:	ff 75 f4             	pushl  -0xc(%ebp)
80104a02:	e8 c9 fe ff ff       	call   801048d0 <fetchstr>
80104a07:	83 c4 10             	add    $0x10,%esp
}
80104a0a:	c9                   	leave  
80104a0b:	c3                   	ret    
80104a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80104a10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80104a15:	c9                   	leave  
80104a16:	c3                   	ret    
80104a17:	89 f6                	mov    %esi,%esi
80104a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a20 <syscall>:
[SYS_getkey]  sys_getkey,
};

void
syscall(void)
{
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	56                   	push   %esi
80104a24:	53                   	push   %ebx
  int num;
  struct proc *curproc = myproc();
80104a25:	e8 56 ef ff ff       	call   80103980 <myproc>

  num = curproc->tf->eax;
80104a2a:	8b 70 18             	mov    0x18(%eax),%esi

void
syscall(void)
{
  int num;
  struct proc *curproc = myproc();
80104a2d:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104a2f:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104a32:	8d 50 ff             	lea    -0x1(%eax),%edx
80104a35:	83 fa 18             	cmp    $0x18,%edx
80104a38:	77 1e                	ja     80104a58 <syscall+0x38>
80104a3a:	8b 14 85 e0 78 10 80 	mov    -0x7fef8720(,%eax,4),%edx
80104a41:	85 d2                	test   %edx,%edx
80104a43:	74 13                	je     80104a58 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104a45:	ff d2                	call   *%edx
80104a47:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104a4a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a4d:	5b                   	pop    %ebx
80104a4e:	5e                   	pop    %esi
80104a4f:	5d                   	pop    %ebp
80104a50:	c3                   	ret    
80104a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104a58:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104a59:	8d 43 6c             	lea    0x6c(%ebx),%eax

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104a5c:	50                   	push   %eax
80104a5d:	ff 73 10             	pushl  0x10(%ebx)
80104a60:	68 b1 78 10 80       	push   $0x801078b1
80104a65:	e8 16 bc ff ff       	call   80100680 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
80104a6a:	8b 43 18             	mov    0x18(%ebx),%eax
80104a6d:	83 c4 10             	add    $0x10,%esp
80104a70:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80104a77:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a7a:	5b                   	pop    %ebx
80104a7b:	5e                   	pop    %esi
80104a7c:	5d                   	pop    %ebp
80104a7d:	c3                   	ret    
80104a7e:	66 90                	xchg   %ax,%ax

80104a80 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104a80:	55                   	push   %ebp
80104a81:	89 e5                	mov    %esp,%ebp
80104a83:	57                   	push   %edi
80104a84:	56                   	push   %esi
80104a85:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104a86:	8d 75 da             	lea    -0x26(%ebp),%esi
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104a89:	83 ec 44             	sub    $0x44,%esp
80104a8c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104a8f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104a92:	56                   	push   %esi
80104a93:	50                   	push   %eax
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104a94:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104a97:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104a9a:	e8 41 d6 ff ff       	call   801020e0 <nameiparent>
80104a9f:	83 c4 10             	add    $0x10,%esp
80104aa2:	85 c0                	test   %eax,%eax
80104aa4:	0f 84 f6 00 00 00    	je     80104ba0 <create+0x120>
    return 0;
  ilock(dp);
80104aaa:	83 ec 0c             	sub    $0xc,%esp
80104aad:	89 c7                	mov    %eax,%edi
80104aaf:	50                   	push   %eax
80104ab0:	e8 bb cd ff ff       	call   80101870 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104ab5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104ab8:	83 c4 0c             	add    $0xc,%esp
80104abb:	50                   	push   %eax
80104abc:	56                   	push   %esi
80104abd:	57                   	push   %edi
80104abe:	e8 dd d2 ff ff       	call   80101da0 <dirlookup>
80104ac3:	83 c4 10             	add    $0x10,%esp
80104ac6:	85 c0                	test   %eax,%eax
80104ac8:	89 c3                	mov    %eax,%ebx
80104aca:	74 54                	je     80104b20 <create+0xa0>
    iunlockput(dp);
80104acc:	83 ec 0c             	sub    $0xc,%esp
80104acf:	57                   	push   %edi
80104ad0:	e8 2b d0 ff ff       	call   80101b00 <iunlockput>
    ilock(ip);
80104ad5:	89 1c 24             	mov    %ebx,(%esp)
80104ad8:	e8 93 cd ff ff       	call   80101870 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104add:	83 c4 10             	add    $0x10,%esp
80104ae0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104ae5:	75 19                	jne    80104b00 <create+0x80>
80104ae7:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
80104aec:	89 d8                	mov    %ebx,%eax
80104aee:	75 10                	jne    80104b00 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104af0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104af3:	5b                   	pop    %ebx
80104af4:	5e                   	pop    %esi
80104af5:	5f                   	pop    %edi
80104af6:	5d                   	pop    %ebp
80104af7:	c3                   	ret    
80104af8:	90                   	nop
80104af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80104b00:	83 ec 0c             	sub    $0xc,%esp
80104b03:	53                   	push   %ebx
80104b04:	e8 f7 cf ff ff       	call   80101b00 <iunlockput>
    return 0;
80104b09:	83 c4 10             	add    $0x10,%esp
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104b0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
80104b0f:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104b11:	5b                   	pop    %ebx
80104b12:	5e                   	pop    %esi
80104b13:	5f                   	pop    %edi
80104b14:	5d                   	pop    %ebp
80104b15:	c3                   	ret    
80104b16:	8d 76 00             	lea    0x0(%esi),%esi
80104b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80104b20:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104b24:	83 ec 08             	sub    $0x8,%esp
80104b27:	50                   	push   %eax
80104b28:	ff 37                	pushl  (%edi)
80104b2a:	e8 d1 cb ff ff       	call   80101700 <ialloc>
80104b2f:	83 c4 10             	add    $0x10,%esp
80104b32:	85 c0                	test   %eax,%eax
80104b34:	89 c3                	mov    %eax,%ebx
80104b36:	0f 84 cc 00 00 00    	je     80104c08 <create+0x188>
    panic("create: ialloc");

  ilock(ip);
80104b3c:	83 ec 0c             	sub    $0xc,%esp
80104b3f:	50                   	push   %eax
80104b40:	e8 2b cd ff ff       	call   80101870 <ilock>
  ip->major = major;
80104b45:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104b49:	66 89 43 52          	mov    %ax,0x52(%ebx)
  ip->minor = minor;
80104b4d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104b51:	66 89 43 54          	mov    %ax,0x54(%ebx)
  ip->nlink = 1;
80104b55:	b8 01 00 00 00       	mov    $0x1,%eax
80104b5a:	66 89 43 56          	mov    %ax,0x56(%ebx)
  iupdate(ip);
80104b5e:	89 1c 24             	mov    %ebx,(%esp)
80104b61:	e8 5a cc ff ff       	call   801017c0 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80104b66:	83 c4 10             	add    $0x10,%esp
80104b69:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104b6e:	74 40                	je     80104bb0 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80104b70:	83 ec 04             	sub    $0x4,%esp
80104b73:	ff 73 04             	pushl  0x4(%ebx)
80104b76:	56                   	push   %esi
80104b77:	57                   	push   %edi
80104b78:	e8 83 d4 ff ff       	call   80102000 <dirlink>
80104b7d:	83 c4 10             	add    $0x10,%esp
80104b80:	85 c0                	test   %eax,%eax
80104b82:	78 77                	js     80104bfb <create+0x17b>
    panic("create: dirlink");

  iunlockput(dp);
80104b84:	83 ec 0c             	sub    $0xc,%esp
80104b87:	57                   	push   %edi
80104b88:	e8 73 cf ff ff       	call   80101b00 <iunlockput>

  return ip;
80104b8d:	83 c4 10             	add    $0x10,%esp
}
80104b90:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
80104b93:	89 d8                	mov    %ebx,%eax
}
80104b95:	5b                   	pop    %ebx
80104b96:	5e                   	pop    %esi
80104b97:	5f                   	pop    %edi
80104b98:	5d                   	pop    %ebp
80104b99:	c3                   	ret    
80104b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80104ba0:	31 c0                	xor    %eax,%eax
80104ba2:	e9 49 ff ff ff       	jmp    80104af0 <create+0x70>
80104ba7:	89 f6                	mov    %esi,%esi
80104ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80104bb0:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
    iupdate(dp);
80104bb5:	83 ec 0c             	sub    $0xc,%esp
80104bb8:	57                   	push   %edi
80104bb9:	e8 02 cc ff ff       	call   801017c0 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104bbe:	83 c4 0c             	add    $0xc,%esp
80104bc1:	ff 73 04             	pushl  0x4(%ebx)
80104bc4:	68 64 79 10 80       	push   $0x80107964
80104bc9:	53                   	push   %ebx
80104bca:	e8 31 d4 ff ff       	call   80102000 <dirlink>
80104bcf:	83 c4 10             	add    $0x10,%esp
80104bd2:	85 c0                	test   %eax,%eax
80104bd4:	78 18                	js     80104bee <create+0x16e>
80104bd6:	83 ec 04             	sub    $0x4,%esp
80104bd9:	ff 77 04             	pushl  0x4(%edi)
80104bdc:	68 63 79 10 80       	push   $0x80107963
80104be1:	53                   	push   %ebx
80104be2:	e8 19 d4 ff ff       	call   80102000 <dirlink>
80104be7:	83 c4 10             	add    $0x10,%esp
80104bea:	85 c0                	test   %eax,%eax
80104bec:	79 82                	jns    80104b70 <create+0xf0>
      panic("create dots");
80104bee:	83 ec 0c             	sub    $0xc,%esp
80104bf1:	68 57 79 10 80       	push   $0x80107957
80104bf6:	e8 75 b7 ff ff       	call   80100370 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
80104bfb:	83 ec 0c             	sub    $0xc,%esp
80104bfe:	68 66 79 10 80       	push   $0x80107966
80104c03:	e8 68 b7 ff ff       	call   80100370 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80104c08:	83 ec 0c             	sub    $0xc,%esp
80104c0b:	68 48 79 10 80       	push   $0x80107948
80104c10:	e8 5b b7 ff ff       	call   80100370 <panic>
80104c15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c20 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104c20:	55                   	push   %ebp
80104c21:	89 e5                	mov    %esp,%ebp
80104c23:	56                   	push   %esi
80104c24:	53                   	push   %ebx
80104c25:	89 c6                	mov    %eax,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104c27:	8d 45 f4             	lea    -0xc(%ebp),%eax
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104c2a:	89 d3                	mov    %edx,%ebx
80104c2c:	83 ec 18             	sub    $0x18,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104c2f:	50                   	push   %eax
80104c30:	6a 00                	push   $0x0
80104c32:	e8 f9 fc ff ff       	call   80104930 <argint>
80104c37:	83 c4 10             	add    $0x10,%esp
80104c3a:	85 c0                	test   %eax,%eax
80104c3c:	78 32                	js     80104c70 <argfd.constprop.0+0x50>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104c3e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104c42:	77 2c                	ja     80104c70 <argfd.constprop.0+0x50>
80104c44:	e8 37 ed ff ff       	call   80103980 <myproc>
80104c49:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104c4c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104c50:	85 c0                	test   %eax,%eax
80104c52:	74 1c                	je     80104c70 <argfd.constprop.0+0x50>
    return -1;
  if(pfd)
80104c54:	85 f6                	test   %esi,%esi
80104c56:	74 02                	je     80104c5a <argfd.constprop.0+0x3a>
    *pfd = fd;
80104c58:	89 16                	mov    %edx,(%esi)
  if(pf)
80104c5a:	85 db                	test   %ebx,%ebx
80104c5c:	74 22                	je     80104c80 <argfd.constprop.0+0x60>
    *pf = f;
80104c5e:	89 03                	mov    %eax,(%ebx)
  return 0;
80104c60:	31 c0                	xor    %eax,%eax
}
80104c62:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c65:	5b                   	pop    %ebx
80104c66:	5e                   	pop    %esi
80104c67:	5d                   	pop    %ebp
80104c68:	c3                   	ret    
80104c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c70:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
80104c73:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
80104c78:	5b                   	pop    %ebx
80104c79:	5e                   	pop    %esi
80104c7a:	5d                   	pop    %ebp
80104c7b:	c3                   	ret    
80104c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
80104c80:	31 c0                	xor    %eax,%eax
80104c82:	eb de                	jmp    80104c62 <argfd.constprop.0+0x42>
80104c84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104c90 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80104c90:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104c91:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80104c93:	89 e5                	mov    %esp,%ebp
80104c95:	56                   	push   %esi
80104c96:	53                   	push   %ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104c97:	8d 55 f4             	lea    -0xc(%ebp),%edx
  return -1;
}

int
sys_dup(void)
{
80104c9a:	83 ec 10             	sub    $0x10,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104c9d:	e8 7e ff ff ff       	call   80104c20 <argfd.constprop.0>
80104ca2:	85 c0                	test   %eax,%eax
80104ca4:	78 1a                	js     80104cc0 <sys_dup+0x30>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104ca6:	31 db                	xor    %ebx,%ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
80104ca8:	8b 75 f4             	mov    -0xc(%ebp),%esi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80104cab:	e8 d0 ec ff ff       	call   80103980 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80104cb0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104cb4:	85 d2                	test   %edx,%edx
80104cb6:	74 18                	je     80104cd0 <sys_dup+0x40>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104cb8:	83 c3 01             	add    $0x1,%ebx
80104cbb:	83 fb 10             	cmp    $0x10,%ebx
80104cbe:	75 f0                	jne    80104cb0 <sys_dup+0x20>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104cc0:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80104cc3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104cc8:	5b                   	pop    %ebx
80104cc9:	5e                   	pop    %esi
80104cca:	5d                   	pop    %ebp
80104ccb:	c3                   	ret    
80104ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80104cd0:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80104cd4:	83 ec 0c             	sub    $0xc,%esp
80104cd7:	ff 75 f4             	pushl  -0xc(%ebp)
80104cda:	e8 01 c3 ff ff       	call   80100fe0 <filedup>
  return fd;
80104cdf:	83 c4 10             	add    $0x10,%esp
}
80104ce2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
80104ce5:	89 d8                	mov    %ebx,%eax
}
80104ce7:	5b                   	pop    %ebx
80104ce8:	5e                   	pop    %esi
80104ce9:	5d                   	pop    %ebp
80104cea:	c3                   	ret    
80104ceb:	90                   	nop
80104cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104cf0 <sys_read>:

int
sys_read(void)
{
80104cf0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104cf1:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80104cf3:	89 e5                	mov    %esp,%ebp
80104cf5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104cf8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104cfb:	e8 20 ff ff ff       	call   80104c20 <argfd.constprop.0>
80104d00:	85 c0                	test   %eax,%eax
80104d02:	78 4c                	js     80104d50 <sys_read+0x60>
80104d04:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d07:	83 ec 08             	sub    $0x8,%esp
80104d0a:	50                   	push   %eax
80104d0b:	6a 02                	push   $0x2
80104d0d:	e8 1e fc ff ff       	call   80104930 <argint>
80104d12:	83 c4 10             	add    $0x10,%esp
80104d15:	85 c0                	test   %eax,%eax
80104d17:	78 37                	js     80104d50 <sys_read+0x60>
80104d19:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d1c:	83 ec 04             	sub    $0x4,%esp
80104d1f:	ff 75 f0             	pushl  -0x10(%ebp)
80104d22:	50                   	push   %eax
80104d23:	6a 01                	push   $0x1
80104d25:	e8 56 fc ff ff       	call   80104980 <argptr>
80104d2a:	83 c4 10             	add    $0x10,%esp
80104d2d:	85 c0                	test   %eax,%eax
80104d2f:	78 1f                	js     80104d50 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80104d31:	83 ec 04             	sub    $0x4,%esp
80104d34:	ff 75 f0             	pushl  -0x10(%ebp)
80104d37:	ff 75 f4             	pushl  -0xc(%ebp)
80104d3a:	ff 75 ec             	pushl  -0x14(%ebp)
80104d3d:	e8 0e c4 ff ff       	call   80101150 <fileread>
80104d42:	83 c4 10             	add    $0x10,%esp
}
80104d45:	c9                   	leave  
80104d46:	c3                   	ret    
80104d47:	89 f6                	mov    %esi,%esi
80104d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104d50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80104d55:	c9                   	leave  
80104d56:	c3                   	ret    
80104d57:	89 f6                	mov    %esi,%esi
80104d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d60 <sys_write>:

int
sys_write(void)
{
80104d60:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d61:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80104d63:	89 e5                	mov    %esp,%ebp
80104d65:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d68:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104d6b:	e8 b0 fe ff ff       	call   80104c20 <argfd.constprop.0>
80104d70:	85 c0                	test   %eax,%eax
80104d72:	78 4c                	js     80104dc0 <sys_write+0x60>
80104d74:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d77:	83 ec 08             	sub    $0x8,%esp
80104d7a:	50                   	push   %eax
80104d7b:	6a 02                	push   $0x2
80104d7d:	e8 ae fb ff ff       	call   80104930 <argint>
80104d82:	83 c4 10             	add    $0x10,%esp
80104d85:	85 c0                	test   %eax,%eax
80104d87:	78 37                	js     80104dc0 <sys_write+0x60>
80104d89:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d8c:	83 ec 04             	sub    $0x4,%esp
80104d8f:	ff 75 f0             	pushl  -0x10(%ebp)
80104d92:	50                   	push   %eax
80104d93:	6a 01                	push   $0x1
80104d95:	e8 e6 fb ff ff       	call   80104980 <argptr>
80104d9a:	83 c4 10             	add    $0x10,%esp
80104d9d:	85 c0                	test   %eax,%eax
80104d9f:	78 1f                	js     80104dc0 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80104da1:	83 ec 04             	sub    $0x4,%esp
80104da4:	ff 75 f0             	pushl  -0x10(%ebp)
80104da7:	ff 75 f4             	pushl  -0xc(%ebp)
80104daa:	ff 75 ec             	pushl  -0x14(%ebp)
80104dad:	e8 2e c4 ff ff       	call   801011e0 <filewrite>
80104db2:	83 c4 10             	add    $0x10,%esp
}
80104db5:	c9                   	leave  
80104db6:	c3                   	ret    
80104db7:	89 f6                	mov    %esi,%esi
80104db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104dc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
80104dc5:	c9                   	leave  
80104dc6:	c3                   	ret    
80104dc7:	89 f6                	mov    %esi,%esi
80104dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104dd0 <sys_close>:

int
sys_close(void)
{
80104dd0:	55                   	push   %ebp
80104dd1:	89 e5                	mov    %esp,%ebp
80104dd3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80104dd6:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104dd9:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104ddc:	e8 3f fe ff ff       	call   80104c20 <argfd.constprop.0>
80104de1:	85 c0                	test   %eax,%eax
80104de3:	78 2b                	js     80104e10 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
80104de5:	e8 96 eb ff ff       	call   80103980 <myproc>
80104dea:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104ded:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  myproc()->ofile[fd] = 0;
80104df0:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104df7:	00 
  fileclose(f);
80104df8:	ff 75 f4             	pushl  -0xc(%ebp)
80104dfb:	e8 30 c2 ff ff       	call   80101030 <fileclose>
  return 0;
80104e00:	83 c4 10             	add    $0x10,%esp
80104e03:	31 c0                	xor    %eax,%eax
}
80104e05:	c9                   	leave  
80104e06:	c3                   	ret    
80104e07:	89 f6                	mov    %esi,%esi
80104e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80104e10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80104e15:	c9                   	leave  
80104e16:	c3                   	ret    
80104e17:	89 f6                	mov    %esi,%esi
80104e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e20 <sys_fstat>:

int
sys_fstat(void)
{
80104e20:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104e21:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80104e23:	89 e5                	mov    %esp,%ebp
80104e25:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104e28:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104e2b:	e8 f0 fd ff ff       	call   80104c20 <argfd.constprop.0>
80104e30:	85 c0                	test   %eax,%eax
80104e32:	78 2c                	js     80104e60 <sys_fstat+0x40>
80104e34:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e37:	83 ec 04             	sub    $0x4,%esp
80104e3a:	6a 14                	push   $0x14
80104e3c:	50                   	push   %eax
80104e3d:	6a 01                	push   $0x1
80104e3f:	e8 3c fb ff ff       	call   80104980 <argptr>
80104e44:	83 c4 10             	add    $0x10,%esp
80104e47:	85 c0                	test   %eax,%eax
80104e49:	78 15                	js     80104e60 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
80104e4b:	83 ec 08             	sub    $0x8,%esp
80104e4e:	ff 75 f4             	pushl  -0xc(%ebp)
80104e51:	ff 75 f0             	pushl  -0x10(%ebp)
80104e54:	e8 a7 c2 ff ff       	call   80101100 <filestat>
80104e59:	83 c4 10             	add    $0x10,%esp
}
80104e5c:	c9                   	leave  
80104e5d:	c3                   	ret    
80104e5e:	66 90                	xchg   %ax,%ax
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80104e60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80104e65:	c9                   	leave  
80104e66:	c3                   	ret    
80104e67:	89 f6                	mov    %esi,%esi
80104e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e70 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104e70:	55                   	push   %ebp
80104e71:	89 e5                	mov    %esp,%ebp
80104e73:	57                   	push   %edi
80104e74:	56                   	push   %esi
80104e75:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104e76:	8d 45 d4             	lea    -0x2c(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104e79:	83 ec 34             	sub    $0x34,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104e7c:	50                   	push   %eax
80104e7d:	6a 00                	push   $0x0
80104e7f:	e8 5c fb ff ff       	call   801049e0 <argstr>
80104e84:	83 c4 10             	add    $0x10,%esp
80104e87:	85 c0                	test   %eax,%eax
80104e89:	0f 88 fb 00 00 00    	js     80104f8a <sys_link+0x11a>
80104e8f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104e92:	83 ec 08             	sub    $0x8,%esp
80104e95:	50                   	push   %eax
80104e96:	6a 01                	push   $0x1
80104e98:	e8 43 fb ff ff       	call   801049e0 <argstr>
80104e9d:	83 c4 10             	add    $0x10,%esp
80104ea0:	85 c0                	test   %eax,%eax
80104ea2:	0f 88 e2 00 00 00    	js     80104f8a <sys_link+0x11a>
    return -1;

  begin_op();
80104ea8:	e8 a3 de ff ff       	call   80102d50 <begin_op>
  if((ip = namei(old)) == 0){
80104ead:	83 ec 0c             	sub    $0xc,%esp
80104eb0:	ff 75 d4             	pushl  -0x2c(%ebp)
80104eb3:	e8 08 d2 ff ff       	call   801020c0 <namei>
80104eb8:	83 c4 10             	add    $0x10,%esp
80104ebb:	85 c0                	test   %eax,%eax
80104ebd:	89 c3                	mov    %eax,%ebx
80104ebf:	0f 84 f3 00 00 00    	je     80104fb8 <sys_link+0x148>
    end_op();
    return -1;
  }

  ilock(ip);
80104ec5:	83 ec 0c             	sub    $0xc,%esp
80104ec8:	50                   	push   %eax
80104ec9:	e8 a2 c9 ff ff       	call   80101870 <ilock>
  if(ip->type == T_DIR){
80104ece:	83 c4 10             	add    $0x10,%esp
80104ed1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104ed6:	0f 84 c4 00 00 00    	je     80104fa0 <sys_link+0x130>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
80104edc:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104ee1:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80104ee4:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80104ee7:	53                   	push   %ebx
80104ee8:	e8 d3 c8 ff ff       	call   801017c0 <iupdate>
  iunlock(ip);
80104eed:	89 1c 24             	mov    %ebx,(%esp)
80104ef0:	e8 5b ca ff ff       	call   80101950 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80104ef5:	58                   	pop    %eax
80104ef6:	5a                   	pop    %edx
80104ef7:	57                   	push   %edi
80104ef8:	ff 75 d0             	pushl  -0x30(%ebp)
80104efb:	e8 e0 d1 ff ff       	call   801020e0 <nameiparent>
80104f00:	83 c4 10             	add    $0x10,%esp
80104f03:	85 c0                	test   %eax,%eax
80104f05:	89 c6                	mov    %eax,%esi
80104f07:	74 5b                	je     80104f64 <sys_link+0xf4>
    goto bad;
  ilock(dp);
80104f09:	83 ec 0c             	sub    $0xc,%esp
80104f0c:	50                   	push   %eax
80104f0d:	e8 5e c9 ff ff       	call   80101870 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104f12:	83 c4 10             	add    $0x10,%esp
80104f15:	8b 03                	mov    (%ebx),%eax
80104f17:	39 06                	cmp    %eax,(%esi)
80104f19:	75 3d                	jne    80104f58 <sys_link+0xe8>
80104f1b:	83 ec 04             	sub    $0x4,%esp
80104f1e:	ff 73 04             	pushl  0x4(%ebx)
80104f21:	57                   	push   %edi
80104f22:	56                   	push   %esi
80104f23:	e8 d8 d0 ff ff       	call   80102000 <dirlink>
80104f28:	83 c4 10             	add    $0x10,%esp
80104f2b:	85 c0                	test   %eax,%eax
80104f2d:	78 29                	js     80104f58 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80104f2f:	83 ec 0c             	sub    $0xc,%esp
80104f32:	56                   	push   %esi
80104f33:	e8 c8 cb ff ff       	call   80101b00 <iunlockput>
  iput(ip);
80104f38:	89 1c 24             	mov    %ebx,(%esp)
80104f3b:	e8 60 ca ff ff       	call   801019a0 <iput>

  end_op();
80104f40:	e8 7b de ff ff       	call   80102dc0 <end_op>

  return 0;
80104f45:	83 c4 10             	add    $0x10,%esp
80104f48:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80104f4a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f4d:	5b                   	pop    %ebx
80104f4e:	5e                   	pop    %esi
80104f4f:	5f                   	pop    %edi
80104f50:	5d                   	pop    %ebp
80104f51:	c3                   	ret    
80104f52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80104f58:	83 ec 0c             	sub    $0xc,%esp
80104f5b:	56                   	push   %esi
80104f5c:	e8 9f cb ff ff       	call   80101b00 <iunlockput>
    goto bad;
80104f61:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  ilock(ip);
80104f64:	83 ec 0c             	sub    $0xc,%esp
80104f67:	53                   	push   %ebx
80104f68:	e8 03 c9 ff ff       	call   80101870 <ilock>
  ip->nlink--;
80104f6d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104f72:	89 1c 24             	mov    %ebx,(%esp)
80104f75:	e8 46 c8 ff ff       	call   801017c0 <iupdate>
  iunlockput(ip);
80104f7a:	89 1c 24             	mov    %ebx,(%esp)
80104f7d:	e8 7e cb ff ff       	call   80101b00 <iunlockput>
  end_op();
80104f82:	e8 39 de ff ff       	call   80102dc0 <end_op>
  return -1;
80104f87:	83 c4 10             	add    $0x10,%esp
}
80104f8a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
80104f8d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f92:	5b                   	pop    %ebx
80104f93:	5e                   	pop    %esi
80104f94:	5f                   	pop    %edi
80104f95:	5d                   	pop    %ebp
80104f96:	c3                   	ret    
80104f97:	89 f6                	mov    %esi,%esi
80104f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
80104fa0:	83 ec 0c             	sub    $0xc,%esp
80104fa3:	53                   	push   %ebx
80104fa4:	e8 57 cb ff ff       	call   80101b00 <iunlockput>
    end_op();
80104fa9:	e8 12 de ff ff       	call   80102dc0 <end_op>
    return -1;
80104fae:	83 c4 10             	add    $0x10,%esp
80104fb1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fb6:	eb 92                	jmp    80104f4a <sys_link+0xda>
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
80104fb8:	e8 03 de ff ff       	call   80102dc0 <end_op>
    return -1;
80104fbd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fc2:	eb 86                	jmp    80104f4a <sys_link+0xda>
80104fc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104fca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104fd0 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104fd0:	55                   	push   %ebp
80104fd1:	89 e5                	mov    %esp,%ebp
80104fd3:	57                   	push   %edi
80104fd4:	56                   	push   %esi
80104fd5:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104fd6:	8d 45 c0             	lea    -0x40(%ebp),%eax
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104fd9:	83 ec 54             	sub    $0x54,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104fdc:	50                   	push   %eax
80104fdd:	6a 00                	push   $0x0
80104fdf:	e8 fc f9 ff ff       	call   801049e0 <argstr>
80104fe4:	83 c4 10             	add    $0x10,%esp
80104fe7:	85 c0                	test   %eax,%eax
80104fe9:	0f 88 82 01 00 00    	js     80105171 <sys_unlink+0x1a1>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
80104fef:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
80104ff2:	e8 59 dd ff ff       	call   80102d50 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104ff7:	83 ec 08             	sub    $0x8,%esp
80104ffa:	53                   	push   %ebx
80104ffb:	ff 75 c0             	pushl  -0x40(%ebp)
80104ffe:	e8 dd d0 ff ff       	call   801020e0 <nameiparent>
80105003:	83 c4 10             	add    $0x10,%esp
80105006:	85 c0                	test   %eax,%eax
80105008:	89 45 b4             	mov    %eax,-0x4c(%ebp)
8010500b:	0f 84 6a 01 00 00    	je     8010517b <sys_unlink+0x1ab>
    end_op();
    return -1;
  }

  ilock(dp);
80105011:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80105014:	83 ec 0c             	sub    $0xc,%esp
80105017:	56                   	push   %esi
80105018:	e8 53 c8 ff ff       	call   80101870 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010501d:	58                   	pop    %eax
8010501e:	5a                   	pop    %edx
8010501f:	68 64 79 10 80       	push   $0x80107964
80105024:	53                   	push   %ebx
80105025:	e8 56 cd ff ff       	call   80101d80 <namecmp>
8010502a:	83 c4 10             	add    $0x10,%esp
8010502d:	85 c0                	test   %eax,%eax
8010502f:	0f 84 fc 00 00 00    	je     80105131 <sys_unlink+0x161>
80105035:	83 ec 08             	sub    $0x8,%esp
80105038:	68 63 79 10 80       	push   $0x80107963
8010503d:	53                   	push   %ebx
8010503e:	e8 3d cd ff ff       	call   80101d80 <namecmp>
80105043:	83 c4 10             	add    $0x10,%esp
80105046:	85 c0                	test   %eax,%eax
80105048:	0f 84 e3 00 00 00    	je     80105131 <sys_unlink+0x161>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
8010504e:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105051:	83 ec 04             	sub    $0x4,%esp
80105054:	50                   	push   %eax
80105055:	53                   	push   %ebx
80105056:	56                   	push   %esi
80105057:	e8 44 cd ff ff       	call   80101da0 <dirlookup>
8010505c:	83 c4 10             	add    $0x10,%esp
8010505f:	85 c0                	test   %eax,%eax
80105061:	89 c3                	mov    %eax,%ebx
80105063:	0f 84 c8 00 00 00    	je     80105131 <sys_unlink+0x161>
    goto bad;
  ilock(ip);
80105069:	83 ec 0c             	sub    $0xc,%esp
8010506c:	50                   	push   %eax
8010506d:	e8 fe c7 ff ff       	call   80101870 <ilock>

  if(ip->nlink < 1)
80105072:	83 c4 10             	add    $0x10,%esp
80105075:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010507a:	0f 8e 24 01 00 00    	jle    801051a4 <sys_unlink+0x1d4>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80105080:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105085:	8d 75 d8             	lea    -0x28(%ebp),%esi
80105088:	74 66                	je     801050f0 <sys_unlink+0x120>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
8010508a:	83 ec 04             	sub    $0x4,%esp
8010508d:	6a 10                	push   $0x10
8010508f:	6a 00                	push   $0x0
80105091:	56                   	push   %esi
80105092:	e8 89 f5 ff ff       	call   80104620 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105097:	6a 10                	push   $0x10
80105099:	ff 75 c4             	pushl  -0x3c(%ebp)
8010509c:	56                   	push   %esi
8010509d:	ff 75 b4             	pushl  -0x4c(%ebp)
801050a0:	e8 ab cb ff ff       	call   80101c50 <writei>
801050a5:	83 c4 20             	add    $0x20,%esp
801050a8:	83 f8 10             	cmp    $0x10,%eax
801050ab:	0f 85 e6 00 00 00    	jne    80105197 <sys_unlink+0x1c7>
    panic("unlink: writei");
  if(ip->type == T_DIR){
801050b1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801050b6:	0f 84 9c 00 00 00    	je     80105158 <sys_unlink+0x188>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
801050bc:	83 ec 0c             	sub    $0xc,%esp
801050bf:	ff 75 b4             	pushl  -0x4c(%ebp)
801050c2:	e8 39 ca ff ff       	call   80101b00 <iunlockput>

  ip->nlink--;
801050c7:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801050cc:	89 1c 24             	mov    %ebx,(%esp)
801050cf:	e8 ec c6 ff ff       	call   801017c0 <iupdate>
  iunlockput(ip);
801050d4:	89 1c 24             	mov    %ebx,(%esp)
801050d7:	e8 24 ca ff ff       	call   80101b00 <iunlockput>

  end_op();
801050dc:	e8 df dc ff ff       	call   80102dc0 <end_op>

  return 0;
801050e1:	83 c4 10             	add    $0x10,%esp
801050e4:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
801050e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801050e9:	5b                   	pop    %ebx
801050ea:	5e                   	pop    %esi
801050eb:	5f                   	pop    %edi
801050ec:	5d                   	pop    %ebp
801050ed:	c3                   	ret    
801050ee:	66 90                	xchg   %ax,%ax
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801050f0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801050f4:	76 94                	jbe    8010508a <sys_unlink+0xba>
801050f6:	bf 20 00 00 00       	mov    $0x20,%edi
801050fb:	eb 0f                	jmp    8010510c <sys_unlink+0x13c>
801050fd:	8d 76 00             	lea    0x0(%esi),%esi
80105100:	83 c7 10             	add    $0x10,%edi
80105103:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105106:	0f 83 7e ff ff ff    	jae    8010508a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010510c:	6a 10                	push   $0x10
8010510e:	57                   	push   %edi
8010510f:	56                   	push   %esi
80105110:	53                   	push   %ebx
80105111:	e8 3a ca ff ff       	call   80101b50 <readi>
80105116:	83 c4 10             	add    $0x10,%esp
80105119:	83 f8 10             	cmp    $0x10,%eax
8010511c:	75 6c                	jne    8010518a <sys_unlink+0x1ba>
      panic("isdirempty: readi");
    if(de.inum != 0)
8010511e:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105123:	74 db                	je     80105100 <sys_unlink+0x130>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
80105125:	83 ec 0c             	sub    $0xc,%esp
80105128:	53                   	push   %ebx
80105129:	e8 d2 c9 ff ff       	call   80101b00 <iunlockput>
    goto bad;
8010512e:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  iunlockput(dp);
80105131:	83 ec 0c             	sub    $0xc,%esp
80105134:	ff 75 b4             	pushl  -0x4c(%ebp)
80105137:	e8 c4 c9 ff ff       	call   80101b00 <iunlockput>
  end_op();
8010513c:	e8 7f dc ff ff       	call   80102dc0 <end_op>
  return -1;
80105141:	83 c4 10             	add    $0x10,%esp
}
80105144:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
80105147:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010514c:	5b                   	pop    %ebx
8010514d:	5e                   	pop    %esi
8010514e:	5f                   	pop    %edi
8010514f:	5d                   	pop    %ebp
80105150:	c3                   	ret    
80105151:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80105158:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
8010515b:	83 ec 0c             	sub    $0xc,%esp

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
8010515e:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80105163:	50                   	push   %eax
80105164:	e8 57 c6 ff ff       	call   801017c0 <iupdate>
80105169:	83 c4 10             	add    $0x10,%esp
8010516c:	e9 4b ff ff ff       	jmp    801050bc <sys_unlink+0xec>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
80105171:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105176:	e9 6b ff ff ff       	jmp    801050e6 <sys_unlink+0x116>

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
8010517b:	e8 40 dc ff ff       	call   80102dc0 <end_op>
    return -1;
80105180:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105185:	e9 5c ff ff ff       	jmp    801050e6 <sys_unlink+0x116>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
8010518a:	83 ec 0c             	sub    $0xc,%esp
8010518d:	68 88 79 10 80       	push   $0x80107988
80105192:	e8 d9 b1 ff ff       	call   80100370 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
80105197:	83 ec 0c             	sub    $0xc,%esp
8010519a:	68 9a 79 10 80       	push   $0x8010799a
8010519f:	e8 cc b1 ff ff       	call   80100370 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
801051a4:	83 ec 0c             	sub    $0xc,%esp
801051a7:	68 76 79 10 80       	push   $0x80107976
801051ac:	e8 bf b1 ff ff       	call   80100370 <panic>
801051b1:	eb 0d                	jmp    801051c0 <sys_open>
801051b3:	90                   	nop
801051b4:	90                   	nop
801051b5:	90                   	nop
801051b6:	90                   	nop
801051b7:	90                   	nop
801051b8:	90                   	nop
801051b9:	90                   	nop
801051ba:	90                   	nop
801051bb:	90                   	nop
801051bc:	90                   	nop
801051bd:	90                   	nop
801051be:	90                   	nop
801051bf:	90                   	nop

801051c0 <sys_open>:
  return ip;
}

int
sys_open(void)
{
801051c0:	55                   	push   %ebp
801051c1:	89 e5                	mov    %esp,%ebp
801051c3:	57                   	push   %edi
801051c4:	56                   	push   %esi
801051c5:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801051c6:	8d 45 e0             	lea    -0x20(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
801051c9:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801051cc:	50                   	push   %eax
801051cd:	6a 00                	push   $0x0
801051cf:	e8 0c f8 ff ff       	call   801049e0 <argstr>
801051d4:	83 c4 10             	add    $0x10,%esp
801051d7:	85 c0                	test   %eax,%eax
801051d9:	0f 88 9e 00 00 00    	js     8010527d <sys_open+0xbd>
801051df:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801051e2:	83 ec 08             	sub    $0x8,%esp
801051e5:	50                   	push   %eax
801051e6:	6a 01                	push   $0x1
801051e8:	e8 43 f7 ff ff       	call   80104930 <argint>
801051ed:	83 c4 10             	add    $0x10,%esp
801051f0:	85 c0                	test   %eax,%eax
801051f2:	0f 88 85 00 00 00    	js     8010527d <sys_open+0xbd>
    return -1;

  begin_op();
801051f8:	e8 53 db ff ff       	call   80102d50 <begin_op>

  if(omode & O_CREATE){
801051fd:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105201:	0f 85 89 00 00 00    	jne    80105290 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105207:	83 ec 0c             	sub    $0xc,%esp
8010520a:	ff 75 e0             	pushl  -0x20(%ebp)
8010520d:	e8 ae ce ff ff       	call   801020c0 <namei>
80105212:	83 c4 10             	add    $0x10,%esp
80105215:	85 c0                	test   %eax,%eax
80105217:	89 c6                	mov    %eax,%esi
80105219:	0f 84 8e 00 00 00    	je     801052ad <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
8010521f:	83 ec 0c             	sub    $0xc,%esp
80105222:	50                   	push   %eax
80105223:	e8 48 c6 ff ff       	call   80101870 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105228:	83 c4 10             	add    $0x10,%esp
8010522b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105230:	0f 84 d2 00 00 00    	je     80105308 <sys_open+0x148>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105236:	e8 35 bd ff ff       	call   80100f70 <filealloc>
8010523b:	85 c0                	test   %eax,%eax
8010523d:	89 c7                	mov    %eax,%edi
8010523f:	74 2b                	je     8010526c <sys_open+0xac>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105241:	31 db                	xor    %ebx,%ebx
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105243:	e8 38 e7 ff ff       	call   80103980 <myproc>
80105248:	90                   	nop
80105249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80105250:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105254:	85 d2                	test   %edx,%edx
80105256:	74 68                	je     801052c0 <sys_open+0x100>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105258:	83 c3 01             	add    $0x1,%ebx
8010525b:	83 fb 10             	cmp    $0x10,%ebx
8010525e:	75 f0                	jne    80105250 <sys_open+0x90>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
80105260:	83 ec 0c             	sub    $0xc,%esp
80105263:	57                   	push   %edi
80105264:	e8 c7 bd ff ff       	call   80101030 <fileclose>
80105269:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010526c:	83 ec 0c             	sub    $0xc,%esp
8010526f:	56                   	push   %esi
80105270:	e8 8b c8 ff ff       	call   80101b00 <iunlockput>
    end_op();
80105275:	e8 46 db ff ff       	call   80102dc0 <end_op>
    return -1;
8010527a:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
8010527d:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
80105280:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80105285:	5b                   	pop    %ebx
80105286:	5e                   	pop    %esi
80105287:	5f                   	pop    %edi
80105288:	5d                   	pop    %ebp
80105289:	c3                   	ret    
8010528a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105290:	83 ec 0c             	sub    $0xc,%esp
80105293:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105296:	31 c9                	xor    %ecx,%ecx
80105298:	6a 00                	push   $0x0
8010529a:	ba 02 00 00 00       	mov    $0x2,%edx
8010529f:	e8 dc f7 ff ff       	call   80104a80 <create>
    if(ip == 0){
801052a4:	83 c4 10             	add    $0x10,%esp
801052a7:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
801052a9:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801052ab:	75 89                	jne    80105236 <sys_open+0x76>
      end_op();
801052ad:	e8 0e db ff ff       	call   80102dc0 <end_op>
      return -1;
801052b2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052b7:	eb 43                	jmp    801052fc <sys_open+0x13c>
801052b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801052c0:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
801052c3:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801052c7:	56                   	push   %esi
801052c8:	e8 83 c6 ff ff       	call   80101950 <iunlock>
  end_op();
801052cd:	e8 ee da ff ff       	call   80102dc0 <end_op>

  f->type = FD_INODE;
801052d2:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801052d8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052db:	83 c4 10             	add    $0x10,%esp
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
801052de:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801052e1:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801052e8:	89 d0                	mov    %edx,%eax
801052ea:	83 e0 01             	and    $0x1,%eax
801052ed:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052f0:	83 e2 03             	and    $0x3,%edx
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801052f3:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052f6:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
801052fa:	89 d8                	mov    %ebx,%eax
}
801052fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052ff:	5b                   	pop    %ebx
80105300:	5e                   	pop    %esi
80105301:	5f                   	pop    %edi
80105302:	5d                   	pop    %ebp
80105303:	c3                   	ret    
80105304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
80105308:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010530b:	85 c9                	test   %ecx,%ecx
8010530d:	0f 84 23 ff ff ff    	je     80105236 <sys_open+0x76>
80105313:	e9 54 ff ff ff       	jmp    8010526c <sys_open+0xac>
80105318:	90                   	nop
80105319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105320 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105326:	e8 25 da ff ff       	call   80102d50 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010532b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010532e:	83 ec 08             	sub    $0x8,%esp
80105331:	50                   	push   %eax
80105332:	6a 00                	push   $0x0
80105334:	e8 a7 f6 ff ff       	call   801049e0 <argstr>
80105339:	83 c4 10             	add    $0x10,%esp
8010533c:	85 c0                	test   %eax,%eax
8010533e:	78 30                	js     80105370 <sys_mkdir+0x50>
80105340:	83 ec 0c             	sub    $0xc,%esp
80105343:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105346:	31 c9                	xor    %ecx,%ecx
80105348:	6a 00                	push   $0x0
8010534a:	ba 01 00 00 00       	mov    $0x1,%edx
8010534f:	e8 2c f7 ff ff       	call   80104a80 <create>
80105354:	83 c4 10             	add    $0x10,%esp
80105357:	85 c0                	test   %eax,%eax
80105359:	74 15                	je     80105370 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010535b:	83 ec 0c             	sub    $0xc,%esp
8010535e:	50                   	push   %eax
8010535f:	e8 9c c7 ff ff       	call   80101b00 <iunlockput>
  end_op();
80105364:	e8 57 da ff ff       	call   80102dc0 <end_op>
  return 0;
80105369:	83 c4 10             	add    $0x10,%esp
8010536c:	31 c0                	xor    %eax,%eax
}
8010536e:	c9                   	leave  
8010536f:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
80105370:	e8 4b da ff ff       	call   80102dc0 <end_op>
    return -1;
80105375:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010537a:	c9                   	leave  
8010537b:	c3                   	ret    
8010537c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105380 <sys_mknod>:

int
sys_mknod(void)
{
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105386:	e8 c5 d9 ff ff       	call   80102d50 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010538b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010538e:	83 ec 08             	sub    $0x8,%esp
80105391:	50                   	push   %eax
80105392:	6a 00                	push   $0x0
80105394:	e8 47 f6 ff ff       	call   801049e0 <argstr>
80105399:	83 c4 10             	add    $0x10,%esp
8010539c:	85 c0                	test   %eax,%eax
8010539e:	78 60                	js     80105400 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801053a0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801053a3:	83 ec 08             	sub    $0x8,%esp
801053a6:	50                   	push   %eax
801053a7:	6a 01                	push   $0x1
801053a9:	e8 82 f5 ff ff       	call   80104930 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
801053ae:	83 c4 10             	add    $0x10,%esp
801053b1:	85 c0                	test   %eax,%eax
801053b3:	78 4b                	js     80105400 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
801053b5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053b8:	83 ec 08             	sub    $0x8,%esp
801053bb:	50                   	push   %eax
801053bc:	6a 02                	push   $0x2
801053be:	e8 6d f5 ff ff       	call   80104930 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
801053c3:	83 c4 10             	add    $0x10,%esp
801053c6:	85 c0                	test   %eax,%eax
801053c8:	78 36                	js     80105400 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801053ca:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801053ce:	83 ec 0c             	sub    $0xc,%esp
801053d1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801053d5:	ba 03 00 00 00       	mov    $0x3,%edx
801053da:	50                   	push   %eax
801053db:	8b 45 ec             	mov    -0x14(%ebp),%eax
801053de:	e8 9d f6 ff ff       	call   80104a80 <create>
801053e3:	83 c4 10             	add    $0x10,%esp
801053e6:	85 c0                	test   %eax,%eax
801053e8:	74 16                	je     80105400 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
801053ea:	83 ec 0c             	sub    $0xc,%esp
801053ed:	50                   	push   %eax
801053ee:	e8 0d c7 ff ff       	call   80101b00 <iunlockput>
  end_op();
801053f3:	e8 c8 d9 ff ff       	call   80102dc0 <end_op>
  return 0;
801053f8:	83 c4 10             	add    $0x10,%esp
801053fb:	31 c0                	xor    %eax,%eax
}
801053fd:	c9                   	leave  
801053fe:	c3                   	ret    
801053ff:	90                   	nop
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80105400:	e8 bb d9 ff ff       	call   80102dc0 <end_op>
    return -1;
80105405:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010540a:	c9                   	leave  
8010540b:	c3                   	ret    
8010540c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105410 <sys_chdir>:

int
sys_chdir(void)
{
80105410:	55                   	push   %ebp
80105411:	89 e5                	mov    %esp,%ebp
80105413:	56                   	push   %esi
80105414:	53                   	push   %ebx
80105415:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105418:	e8 63 e5 ff ff       	call   80103980 <myproc>
8010541d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010541f:	e8 2c d9 ff ff       	call   80102d50 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105424:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105427:	83 ec 08             	sub    $0x8,%esp
8010542a:	50                   	push   %eax
8010542b:	6a 00                	push   $0x0
8010542d:	e8 ae f5 ff ff       	call   801049e0 <argstr>
80105432:	83 c4 10             	add    $0x10,%esp
80105435:	85 c0                	test   %eax,%eax
80105437:	78 77                	js     801054b0 <sys_chdir+0xa0>
80105439:	83 ec 0c             	sub    $0xc,%esp
8010543c:	ff 75 f4             	pushl  -0xc(%ebp)
8010543f:	e8 7c cc ff ff       	call   801020c0 <namei>
80105444:	83 c4 10             	add    $0x10,%esp
80105447:	85 c0                	test   %eax,%eax
80105449:	89 c3                	mov    %eax,%ebx
8010544b:	74 63                	je     801054b0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010544d:	83 ec 0c             	sub    $0xc,%esp
80105450:	50                   	push   %eax
80105451:	e8 1a c4 ff ff       	call   80101870 <ilock>
  if(ip->type != T_DIR){
80105456:	83 c4 10             	add    $0x10,%esp
80105459:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010545e:	75 30                	jne    80105490 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105460:	83 ec 0c             	sub    $0xc,%esp
80105463:	53                   	push   %ebx
80105464:	e8 e7 c4 ff ff       	call   80101950 <iunlock>
  iput(curproc->cwd);
80105469:	58                   	pop    %eax
8010546a:	ff 76 68             	pushl  0x68(%esi)
8010546d:	e8 2e c5 ff ff       	call   801019a0 <iput>
  end_op();
80105472:	e8 49 d9 ff ff       	call   80102dc0 <end_op>
  curproc->cwd = ip;
80105477:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010547a:	83 c4 10             	add    $0x10,%esp
8010547d:	31 c0                	xor    %eax,%eax
}
8010547f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105482:	5b                   	pop    %ebx
80105483:	5e                   	pop    %esi
80105484:	5d                   	pop    %ebp
80105485:	c3                   	ret    
80105486:	8d 76 00             	lea    0x0(%esi),%esi
80105489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
80105490:	83 ec 0c             	sub    $0xc,%esp
80105493:	53                   	push   %ebx
80105494:	e8 67 c6 ff ff       	call   80101b00 <iunlockput>
    end_op();
80105499:	e8 22 d9 ff ff       	call   80102dc0 <end_op>
    return -1;
8010549e:	83 c4 10             	add    $0x10,%esp
801054a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054a6:	eb d7                	jmp    8010547f <sys_chdir+0x6f>
801054a8:	90                   	nop
801054a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct inode *ip;
  struct proc *curproc = myproc();
  
  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
801054b0:	e8 0b d9 ff ff       	call   80102dc0 <end_op>
    return -1;
801054b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054ba:	eb c3                	jmp    8010547f <sys_chdir+0x6f>
801054bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054c0 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
801054c0:	55                   	push   %ebp
801054c1:	89 e5                	mov    %esp,%ebp
801054c3:	57                   	push   %edi
801054c4:	56                   	push   %esi
801054c5:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801054c6:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
801054cc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801054d2:	50                   	push   %eax
801054d3:	6a 00                	push   $0x0
801054d5:	e8 06 f5 ff ff       	call   801049e0 <argstr>
801054da:	83 c4 10             	add    $0x10,%esp
801054dd:	85 c0                	test   %eax,%eax
801054df:	78 7f                	js     80105560 <sys_exec+0xa0>
801054e1:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801054e7:	83 ec 08             	sub    $0x8,%esp
801054ea:	50                   	push   %eax
801054eb:	6a 01                	push   $0x1
801054ed:	e8 3e f4 ff ff       	call   80104930 <argint>
801054f2:	83 c4 10             	add    $0x10,%esp
801054f5:	85 c0                	test   %eax,%eax
801054f7:	78 67                	js     80105560 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801054f9:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801054ff:	83 ec 04             	sub    $0x4,%esp
80105502:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80105508:	68 80 00 00 00       	push   $0x80
8010550d:	6a 00                	push   $0x0
8010550f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105515:	50                   	push   %eax
80105516:	31 db                	xor    %ebx,%ebx
80105518:	e8 03 f1 ff ff       	call   80104620 <memset>
8010551d:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105520:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105526:	83 ec 08             	sub    $0x8,%esp
80105529:	57                   	push   %edi
8010552a:	8d 04 98             	lea    (%eax,%ebx,4),%eax
8010552d:	50                   	push   %eax
8010552e:	e8 5d f3 ff ff       	call   80104890 <fetchint>
80105533:	83 c4 10             	add    $0x10,%esp
80105536:	85 c0                	test   %eax,%eax
80105538:	78 26                	js     80105560 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
8010553a:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105540:	85 c0                	test   %eax,%eax
80105542:	74 2c                	je     80105570 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105544:	83 ec 08             	sub    $0x8,%esp
80105547:	56                   	push   %esi
80105548:	50                   	push   %eax
80105549:	e8 82 f3 ff ff       	call   801048d0 <fetchstr>
8010554e:	83 c4 10             	add    $0x10,%esp
80105551:	85 c0                	test   %eax,%eax
80105553:	78 0b                	js     80105560 <sys_exec+0xa0>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80105555:	83 c3 01             	add    $0x1,%ebx
80105558:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
8010555b:	83 fb 20             	cmp    $0x20,%ebx
8010555e:	75 c0                	jne    80105520 <sys_exec+0x60>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105560:	8d 65 f4             	lea    -0xc(%ebp),%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
80105563:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105568:	5b                   	pop    %ebx
80105569:	5e                   	pop    %esi
8010556a:	5f                   	pop    %edi
8010556b:	5d                   	pop    %ebp
8010556c:	c3                   	ret    
8010556d:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105570:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105576:	83 ec 08             	sub    $0x8,%esp
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
80105579:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105580:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105584:	50                   	push   %eax
80105585:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010558b:	e8 60 b6 ff ff       	call   80100bf0 <exec>
80105590:	83 c4 10             	add    $0x10,%esp
}
80105593:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105596:	5b                   	pop    %ebx
80105597:	5e                   	pop    %esi
80105598:	5f                   	pop    %edi
80105599:	5d                   	pop    %ebp
8010559a:	c3                   	ret    
8010559b:	90                   	nop
8010559c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801055a0 <sys_pipe>:

int
sys_pipe(void)
{
801055a0:	55                   	push   %ebp
801055a1:	89 e5                	mov    %esp,%ebp
801055a3:	57                   	push   %edi
801055a4:	56                   	push   %esi
801055a5:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801055a6:	8d 45 dc             	lea    -0x24(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
801055a9:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801055ac:	6a 08                	push   $0x8
801055ae:	50                   	push   %eax
801055af:	6a 00                	push   $0x0
801055b1:	e8 ca f3 ff ff       	call   80104980 <argptr>
801055b6:	83 c4 10             	add    $0x10,%esp
801055b9:	85 c0                	test   %eax,%eax
801055bb:	78 4a                	js     80105607 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801055bd:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801055c0:	83 ec 08             	sub    $0x8,%esp
801055c3:	50                   	push   %eax
801055c4:	8d 45 e0             	lea    -0x20(%ebp),%eax
801055c7:	50                   	push   %eax
801055c8:	e8 23 de ff ff       	call   801033f0 <pipealloc>
801055cd:	83 c4 10             	add    $0x10,%esp
801055d0:	85 c0                	test   %eax,%eax
801055d2:	78 33                	js     80105607 <sys_pipe+0x67>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801055d4:	31 db                	xor    %ebx,%ebx
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801055d6:	8b 7d e0             	mov    -0x20(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801055d9:	e8 a2 e3 ff ff       	call   80103980 <myproc>
801055de:	66 90                	xchg   %ax,%ax

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
801055e0:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801055e4:	85 f6                	test   %esi,%esi
801055e6:	74 30                	je     80105618 <sys_pipe+0x78>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801055e8:	83 c3 01             	add    $0x1,%ebx
801055eb:	83 fb 10             	cmp    $0x10,%ebx
801055ee:	75 f0                	jne    801055e0 <sys_pipe+0x40>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
801055f0:	83 ec 0c             	sub    $0xc,%esp
801055f3:	ff 75 e0             	pushl  -0x20(%ebp)
801055f6:	e8 35 ba ff ff       	call   80101030 <fileclose>
    fileclose(wf);
801055fb:	58                   	pop    %eax
801055fc:	ff 75 e4             	pushl  -0x1c(%ebp)
801055ff:	e8 2c ba ff ff       	call   80101030 <fileclose>
    return -1;
80105604:	83 c4 10             	add    $0x10,%esp
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
80105607:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
8010560a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
8010560f:	5b                   	pop    %ebx
80105610:	5e                   	pop    %esi
80105611:	5f                   	pop    %edi
80105612:	5d                   	pop    %ebp
80105613:	c3                   	ret    
80105614:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105618:	8d 73 08             	lea    0x8(%ebx),%esi
8010561b:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010561f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105622:	e8 59 e3 ff ff       	call   80103980 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
80105627:	31 d2                	xor    %edx,%edx
80105629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105630:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105634:	85 c9                	test   %ecx,%ecx
80105636:	74 18                	je     80105650 <sys_pipe+0xb0>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105638:	83 c2 01             	add    $0x1,%edx
8010563b:	83 fa 10             	cmp    $0x10,%edx
8010563e:	75 f0                	jne    80105630 <sys_pipe+0x90>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80105640:	e8 3b e3 ff ff       	call   80103980 <myproc>
80105645:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
8010564c:	00 
8010564d:	eb a1                	jmp    801055f0 <sys_pipe+0x50>
8010564f:	90                   	nop
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105650:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105654:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105657:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105659:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010565c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
}
8010565f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
80105662:	31 c0                	xor    %eax,%eax
}
80105664:	5b                   	pop    %ebx
80105665:	5e                   	pop    %esi
80105666:	5f                   	pop    %edi
80105667:	5d                   	pop    %ebp
80105668:	c3                   	ret    
80105669:	66 90                	xchg   %ax,%ax
8010566b:	66 90                	xchg   %ax,%ax
8010566d:	66 90                	xchg   %ax,%ax
8010566f:	90                   	nop

80105670 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105670:	55                   	push   %ebp
80105671:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105673:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105674:	e9 a7 e4 ff ff       	jmp    80103b20 <fork>
80105679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105680 <sys_exit>:
}

int
sys_exit(void)
{
80105680:	55                   	push   %ebp
80105681:	89 e5                	mov    %esp,%ebp
80105683:	83 ec 08             	sub    $0x8,%esp
  exit();
80105686:	e8 25 e7 ff ff       	call   80103db0 <exit>
  return 0;  // not reached
}
8010568b:	31 c0                	xor    %eax,%eax
8010568d:	c9                   	leave  
8010568e:	c3                   	ret    
8010568f:	90                   	nop

80105690 <sys_wait>:

int
sys_wait(void)
{
80105690:	55                   	push   %ebp
80105691:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105693:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
80105694:	e9 67 e9 ff ff       	jmp    80104000 <wait>
80105699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801056a0 <sys_kill>:
}

int
sys_kill(void)
{
801056a0:	55                   	push   %ebp
801056a1:	89 e5                	mov    %esp,%ebp
801056a3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801056a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056a9:	50                   	push   %eax
801056aa:	6a 00                	push   $0x0
801056ac:	e8 7f f2 ff ff       	call   80104930 <argint>
801056b1:	83 c4 10             	add    $0x10,%esp
801056b4:	85 c0                	test   %eax,%eax
801056b6:	78 18                	js     801056d0 <sys_kill+0x30>
    return -1;
  return kill(pid);
801056b8:	83 ec 0c             	sub    $0xc,%esp
801056bb:	ff 75 f4             	pushl  -0xc(%ebp)
801056be:	e8 8d ea ff ff       	call   80104150 <kill>
801056c3:	83 c4 10             	add    $0x10,%esp
}
801056c6:	c9                   	leave  
801056c7:	c3                   	ret    
801056c8:	90                   	nop
801056c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
801056d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
801056d5:	c9                   	leave  
801056d6:	c3                   	ret    
801056d7:	89 f6                	mov    %esi,%esi
801056d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801056e0 <sys_getpid>:

int
sys_getpid(void)
{
801056e0:	55                   	push   %ebp
801056e1:	89 e5                	mov    %esp,%ebp
801056e3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801056e6:	e8 95 e2 ff ff       	call   80103980 <myproc>
801056eb:	8b 40 10             	mov    0x10(%eax),%eax
}
801056ee:	c9                   	leave  
801056ef:	c3                   	ret    

801056f0 <sys_sbrk>:

int
sys_sbrk(void)
{
801056f0:	55                   	push   %ebp
801056f1:	89 e5                	mov    %esp,%ebp
801056f3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801056f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return myproc()->pid;
}

int
sys_sbrk(void)
{
801056f7:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801056fa:	50                   	push   %eax
801056fb:	6a 00                	push   $0x0
801056fd:	e8 2e f2 ff ff       	call   80104930 <argint>
80105702:	83 c4 10             	add    $0x10,%esp
80105705:	85 c0                	test   %eax,%eax
80105707:	78 27                	js     80105730 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105709:	e8 72 e2 ff ff       	call   80103980 <myproc>
  if(growproc(n) < 0)
8010570e:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
80105711:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105713:	ff 75 f4             	pushl  -0xc(%ebp)
80105716:	e8 85 e3 ff ff       	call   80103aa0 <growproc>
8010571b:	83 c4 10             	add    $0x10,%esp
8010571e:	85 c0                	test   %eax,%eax
80105720:	78 0e                	js     80105730 <sys_sbrk+0x40>
    return -1;
  return addr;
80105722:	89 d8                	mov    %ebx,%eax
}
80105724:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105727:	c9                   	leave  
80105728:	c3                   	ret    
80105729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80105730:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105735:	eb ed                	jmp    80105724 <sys_sbrk+0x34>
80105737:	89 f6                	mov    %esi,%esi
80105739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105740 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
80105740:	55                   	push   %ebp
80105741:	89 e5                	mov    %esp,%ebp
80105743:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105744:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return addr;
}

int
sys_sleep(void)
{
80105747:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
8010574a:	50                   	push   %eax
8010574b:	6a 00                	push   $0x0
8010574d:	e8 de f1 ff ff       	call   80104930 <argint>
80105752:	83 c4 10             	add    $0x10,%esp
80105755:	85 c0                	test   %eax,%eax
80105757:	0f 88 8a 00 00 00    	js     801057e7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010575d:	83 ec 0c             	sub    $0xc,%esp
80105760:	68 00 5c 11 80       	push   $0x80115c00
80105765:	e8 46 ed ff ff       	call   801044b0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010576a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010576d:	83 c4 10             	add    $0x10,%esp
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
80105770:	8b 1d 40 64 11 80    	mov    0x80116440,%ebx
  while(ticks - ticks0 < n){
80105776:	85 d2                	test   %edx,%edx
80105778:	75 27                	jne    801057a1 <sys_sleep+0x61>
8010577a:	eb 54                	jmp    801057d0 <sys_sleep+0x90>
8010577c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105780:	83 ec 08             	sub    $0x8,%esp
80105783:	68 00 5c 11 80       	push   $0x80115c00
80105788:	68 40 64 11 80       	push   $0x80116440
8010578d:	e8 ae e7 ff ff       	call   80103f40 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105792:	a1 40 64 11 80       	mov    0x80116440,%eax
80105797:	83 c4 10             	add    $0x10,%esp
8010579a:	29 d8                	sub    %ebx,%eax
8010579c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010579f:	73 2f                	jae    801057d0 <sys_sleep+0x90>
    if(myproc()->killed){
801057a1:	e8 da e1 ff ff       	call   80103980 <myproc>
801057a6:	8b 40 24             	mov    0x24(%eax),%eax
801057a9:	85 c0                	test   %eax,%eax
801057ab:	74 d3                	je     80105780 <sys_sleep+0x40>
      release(&tickslock);
801057ad:	83 ec 0c             	sub    $0xc,%esp
801057b0:	68 00 5c 11 80       	push   $0x80115c00
801057b5:	e8 16 ee ff ff       	call   801045d0 <release>
      return -1;
801057ba:	83 c4 10             	add    $0x10,%esp
801057bd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
801057c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057c5:	c9                   	leave  
801057c6:	c3                   	ret    
801057c7:	89 f6                	mov    %esi,%esi
801057c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
801057d0:	83 ec 0c             	sub    $0xc,%esp
801057d3:	68 00 5c 11 80       	push   $0x80115c00
801057d8:	e8 f3 ed ff ff       	call   801045d0 <release>
  return 0;
801057dd:	83 c4 10             	add    $0x10,%esp
801057e0:	31 c0                	xor    %eax,%eax
}
801057e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057e5:	c9                   	leave  
801057e6:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
801057e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057ec:	eb d4                	jmp    801057c2 <sys_sleep+0x82>
801057ee:	66 90                	xchg   %ax,%ax

801057f0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801057f0:	55                   	push   %ebp
801057f1:	89 e5                	mov    %esp,%ebp
801057f3:	53                   	push   %ebx
801057f4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801057f7:	68 00 5c 11 80       	push   $0x80115c00
801057fc:	e8 af ec ff ff       	call   801044b0 <acquire>
  xticks = ticks;
80105801:	8b 1d 40 64 11 80    	mov    0x80116440,%ebx
  release(&tickslock);
80105807:	c7 04 24 00 5c 11 80 	movl   $0x80115c00,(%esp)
8010580e:	e8 bd ed ff ff       	call   801045d0 <release>
  return xticks;
}
80105813:	89 d8                	mov    %ebx,%eax
80105815:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105818:	c9                   	leave  
80105819:	c3                   	ret    
8010581a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105820 <sys_captsc>:

int
sys_captsc(void)
{
80105820:	55                   	push   %ebp
80105821:	89 e5                	mov    %esp,%ebp
80105823:	53                   	push   %ebx
  int* handler;
  if (argptr(0, (void*)&handler, sizeof(handler)) < 0)
80105824:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return xticks;
}

int
sys_captsc(void)
{
80105827:	83 ec 18             	sub    $0x18,%esp
  int* handler;
  if (argptr(0, (void*)&handler, sizeof(handler)) < 0)
8010582a:	6a 04                	push   $0x4
8010582c:	50                   	push   %eax
8010582d:	6a 00                	push   $0x0
8010582f:	e8 4c f1 ff ff       	call   80104980 <argptr>
80105834:	83 c4 10             	add    $0x10,%esp
80105837:	85 c0                	test   %eax,%eax
80105839:	78 25                	js     80105860 <sys_captsc+0x40>
    return -1;
  return capturescreen(myproc()->pid, handler);
8010583b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010583e:	e8 3d e1 ff ff       	call   80103980 <myproc>
80105843:	83 ec 08             	sub    $0x8,%esp
80105846:	53                   	push   %ebx
80105847:	ff 70 10             	pushl  0x10(%eax)
8010584a:	e8 c1 af ff ff       	call   80100810 <capturescreen>
8010584f:	83 c4 10             	add    $0x10,%esp
}
80105852:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105855:	c9                   	leave  
80105856:	c3                   	ret    
80105857:	89 f6                	mov    %esi,%esi
80105859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
int
sys_captsc(void)
{
  int* handler;
  if (argptr(0, (void*)&handler, sizeof(handler)) < 0)
    return -1;
80105860:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105865:	eb eb                	jmp    80105852 <sys_captsc+0x32>
80105867:	89 f6                	mov    %esi,%esi
80105869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105870 <sys_freesc>:
  return capturescreen(myproc()->pid, handler);
}

int
sys_freesc(void)
{
80105870:	55                   	push   %ebp
80105871:	89 e5                	mov    %esp,%ebp
80105873:	83 ec 08             	sub    $0x8,%esp
  return freescreen(myproc()->pid);
80105876:	e8 05 e1 ff ff       	call   80103980 <myproc>
8010587b:	83 ec 0c             	sub    $0xc,%esp
8010587e:	ff 70 10             	pushl  0x10(%eax)
80105881:	e8 1a b0 ff ff       	call   801008a0 <freescreen>
}
80105886:	c9                   	leave  
80105887:	c3                   	ret    
80105888:	90                   	nop
80105889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105890 <sys_updatesc>:

int
sys_updatesc(void) {
80105890:	55                   	push   %ebp
80105891:	89 e5                	mov    %esp,%ebp
80105893:	57                   	push   %edi
80105894:	56                   	push   %esi
80105895:	53                   	push   %ebx
  int x, y, color;
  char* content;
  if(argint(0, &x) < 0)
80105896:	8d 45 d8             	lea    -0x28(%ebp),%eax
{
  return freescreen(myproc()->pid);
}

int
sys_updatesc(void) {
80105899:	83 ec 34             	sub    $0x34,%esp
  int x, y, color;
  char* content;
  if(argint(0, &x) < 0)
8010589c:	50                   	push   %eax
8010589d:	6a 00                	push   $0x0
8010589f:	e8 8c f0 ff ff       	call   80104930 <argint>
801058a4:	83 c4 10             	add    $0x10,%esp
801058a7:	85 c0                	test   %eax,%eax
801058a9:	78 75                	js     80105920 <sys_updatesc+0x90>
    return -1;
  if(argint(1, &y) < 0)
801058ab:	8d 45 dc             	lea    -0x24(%ebp),%eax
801058ae:	83 ec 08             	sub    $0x8,%esp
801058b1:	50                   	push   %eax
801058b2:	6a 01                	push   $0x1
801058b4:	e8 77 f0 ff ff       	call   80104930 <argint>
801058b9:	83 c4 10             	add    $0x10,%esp
801058bc:	85 c0                	test   %eax,%eax
801058be:	78 60                	js     80105920 <sys_updatesc+0x90>
    return -1;
  if (argptr(2, (void*)&content, sizeof(content)) < 0)
801058c0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801058c3:	83 ec 04             	sub    $0x4,%esp
801058c6:	6a 04                	push   $0x4
801058c8:	50                   	push   %eax
801058c9:	6a 02                	push   $0x2
801058cb:	e8 b0 f0 ff ff       	call   80104980 <argptr>
801058d0:	83 c4 10             	add    $0x10,%esp
801058d3:	85 c0                	test   %eax,%eax
801058d5:	78 49                	js     80105920 <sys_updatesc+0x90>
    return -1;
  if(argint(3, &color) < 0)
801058d7:	8d 45 e0             	lea    -0x20(%ebp),%eax
801058da:	83 ec 08             	sub    $0x8,%esp
801058dd:	50                   	push   %eax
801058de:	6a 03                	push   $0x3
801058e0:	e8 4b f0 ff ff       	call   80104930 <argint>
801058e5:	83 c4 10             	add    $0x10,%esp
801058e8:	85 c0                	test   %eax,%eax
801058ea:	78 34                	js     80105920 <sys_updatesc+0x90>
    return -1;
  return updatescreen(myproc()->pid, x, y, content, color);
801058ec:	8b 55 e0             	mov    -0x20(%ebp),%edx
801058ef:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801058f2:	8b 75 dc             	mov    -0x24(%ebp),%esi
801058f5:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801058f8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801058fb:	e8 80 e0 ff ff       	call   80103980 <myproc>
80105900:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80105903:	83 ec 0c             	sub    $0xc,%esp
80105906:	52                   	push   %edx
80105907:	57                   	push   %edi
80105908:	56                   	push   %esi
80105909:	53                   	push   %ebx
8010590a:	ff 70 10             	pushl  0x10(%eax)
8010590d:	e8 fe af ff ff       	call   80100910 <updatescreen>
80105912:	83 c4 20             	add    $0x20,%esp
}
80105915:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105918:	5b                   	pop    %ebx
80105919:	5e                   	pop    %esi
8010591a:	5f                   	pop    %edi
8010591b:	5d                   	pop    %ebp
8010591c:	c3                   	ret    
8010591d:	8d 76 00             	lea    0x0(%esi),%esi
80105920:	8d 65 f4             	lea    -0xc(%ebp),%esp
int
sys_updatesc(void) {
  int x, y, color;
  char* content;
  if(argint(0, &x) < 0)
    return -1;
80105923:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if (argptr(2, (void*)&content, sizeof(content)) < 0)
    return -1;
  if(argint(3, &color) < 0)
    return -1;
  return updatescreen(myproc()->pid, x, y, content, color);
}
80105928:	5b                   	pop    %ebx
80105929:	5e                   	pop    %esi
8010592a:	5f                   	pop    %edi
8010592b:	5d                   	pop    %ebp
8010592c:	c3                   	ret    
8010592d:	8d 76 00             	lea    0x0(%esi),%esi

80105930 <sys_getkey>:

int 
sys_getkey(void)
{
80105930:	55                   	push   %ebp
80105931:	89 e5                	mov    %esp,%ebp
80105933:	83 ec 08             	sub    $0x8,%esp
  return readkey(myproc()->pid);
80105936:	e8 45 e0 ff ff       	call   80103980 <myproc>
8010593b:	83 ec 0c             	sub    $0xc,%esp
8010593e:	ff 70 10             	pushl  0x10(%eax)
80105941:	e8 7a b2 ff ff       	call   80100bc0 <readkey>
}
80105946:	c9                   	leave  
80105947:	c3                   	ret    

80105948 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105948:	1e                   	push   %ds
  pushl %es
80105949:	06                   	push   %es
  pushl %fs
8010594a:	0f a0                	push   %fs
  pushl %gs
8010594c:	0f a8                	push   %gs
  pushal
8010594e:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
8010594f:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105953:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105955:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105957:	54                   	push   %esp
  call trap
80105958:	e8 e3 00 00 00       	call   80105a40 <trap>
  addl $4, %esp
8010595d:	83 c4 04             	add    $0x4,%esp

80105960 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105960:	61                   	popa   
  popl %gs
80105961:	0f a9                	pop    %gs
  popl %fs
80105963:	0f a1                	pop    %fs
  popl %es
80105965:	07                   	pop    %es
  popl %ds
80105966:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105967:	83 c4 08             	add    $0x8,%esp
  iret
8010596a:	cf                   	iret   
8010596b:	66 90                	xchg   %ax,%ax
8010596d:	66 90                	xchg   %ax,%ax
8010596f:	90                   	nop

80105970 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105970:	31 c0                	xor    %eax,%eax
80105972:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105978:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
8010597f:	b9 08 00 00 00       	mov    $0x8,%ecx
80105984:	c6 04 c5 44 5c 11 80 	movb   $0x0,-0x7feea3bc(,%eax,8)
8010598b:	00 
8010598c:	66 89 0c c5 42 5c 11 	mov    %cx,-0x7feea3be(,%eax,8)
80105993:	80 
80105994:	c6 04 c5 45 5c 11 80 	movb   $0x8e,-0x7feea3bb(,%eax,8)
8010599b:	8e 
8010599c:	66 89 14 c5 40 5c 11 	mov    %dx,-0x7feea3c0(,%eax,8)
801059a3:	80 
801059a4:	c1 ea 10             	shr    $0x10,%edx
801059a7:	66 89 14 c5 46 5c 11 	mov    %dx,-0x7feea3ba(,%eax,8)
801059ae:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
801059af:	83 c0 01             	add    $0x1,%eax
801059b2:	3d 00 01 00 00       	cmp    $0x100,%eax
801059b7:	75 bf                	jne    80105978 <tvinit+0x8>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801059b9:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801059ba:	ba 08 00 00 00       	mov    $0x8,%edx
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801059bf:	89 e5                	mov    %esp,%ebp
801059c1:	83 ec 10             	sub    $0x10,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801059c4:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
801059c9:	68 a9 79 10 80       	push   $0x801079a9
801059ce:	68 00 5c 11 80       	push   $0x80115c00
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801059d3:	66 89 15 42 5e 11 80 	mov    %dx,0x80115e42
801059da:	c6 05 44 5e 11 80 00 	movb   $0x0,0x80115e44
801059e1:	66 a3 40 5e 11 80    	mov    %ax,0x80115e40
801059e7:	c1 e8 10             	shr    $0x10,%eax
801059ea:	c6 05 45 5e 11 80 ef 	movb   $0xef,0x80115e45
801059f1:	66 a3 46 5e 11 80    	mov    %ax,0x80115e46

  initlock(&tickslock, "time");
801059f7:	e8 b4 e9 ff ff       	call   801043b0 <initlock>
}
801059fc:	83 c4 10             	add    $0x10,%esp
801059ff:	c9                   	leave  
80105a00:	c3                   	ret    
80105a01:	eb 0d                	jmp    80105a10 <idtinit>
80105a03:	90                   	nop
80105a04:	90                   	nop
80105a05:	90                   	nop
80105a06:	90                   	nop
80105a07:	90                   	nop
80105a08:	90                   	nop
80105a09:	90                   	nop
80105a0a:	90                   	nop
80105a0b:	90                   	nop
80105a0c:	90                   	nop
80105a0d:	90                   	nop
80105a0e:	90                   	nop
80105a0f:	90                   	nop

80105a10 <idtinit>:

void
idtinit(void)
{
80105a10:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80105a11:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105a16:	89 e5                	mov    %esp,%ebp
80105a18:	83 ec 10             	sub    $0x10,%esp
80105a1b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105a1f:	b8 40 5c 11 80       	mov    $0x80115c40,%eax
80105a24:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105a28:	c1 e8 10             	shr    $0x10,%eax
80105a2b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80105a2f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105a32:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105a35:	c9                   	leave  
80105a36:	c3                   	ret    
80105a37:	89 f6                	mov    %esi,%esi
80105a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a40 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105a40:	55                   	push   %ebp
80105a41:	89 e5                	mov    %esp,%ebp
80105a43:	57                   	push   %edi
80105a44:	56                   	push   %esi
80105a45:	53                   	push   %ebx
80105a46:	83 ec 1c             	sub    $0x1c,%esp
80105a49:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
80105a4c:	8b 47 30             	mov    0x30(%edi),%eax
80105a4f:	83 f8 40             	cmp    $0x40,%eax
80105a52:	0f 84 88 01 00 00    	je     80105be0 <trap+0x1a0>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105a58:	83 e8 20             	sub    $0x20,%eax
80105a5b:	83 f8 1f             	cmp    $0x1f,%eax
80105a5e:	77 10                	ja     80105a70 <trap+0x30>
80105a60:	ff 24 85 50 7a 10 80 	jmp    *-0x7fef85b0(,%eax,4)
80105a67:	89 f6                	mov    %esi,%esi
80105a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105a70:	e8 0b df ff ff       	call   80103980 <myproc>
80105a75:	85 c0                	test   %eax,%eax
80105a77:	0f 84 d7 01 00 00    	je     80105c54 <trap+0x214>
80105a7d:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105a81:	0f 84 cd 01 00 00    	je     80105c54 <trap+0x214>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105a87:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a8a:	8b 57 38             	mov    0x38(%edi),%edx
80105a8d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105a90:	89 55 dc             	mov    %edx,-0x24(%ebp)
80105a93:	e8 c8 de ff ff       	call   80103960 <cpuid>
80105a98:	8b 77 34             	mov    0x34(%edi),%esi
80105a9b:	8b 5f 30             	mov    0x30(%edi),%ebx
80105a9e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105aa1:	e8 da de ff ff       	call   80103980 <myproc>
80105aa6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105aa9:	e8 d2 de ff ff       	call   80103980 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105aae:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105ab1:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105ab4:	51                   	push   %ecx
80105ab5:	52                   	push   %edx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105ab6:	8b 55 e0             	mov    -0x20(%ebp),%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105ab9:	ff 75 e4             	pushl  -0x1c(%ebp)
80105abc:	56                   	push   %esi
80105abd:	53                   	push   %ebx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105abe:	83 c2 6c             	add    $0x6c,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105ac1:	52                   	push   %edx
80105ac2:	ff 70 10             	pushl  0x10(%eax)
80105ac5:	68 0c 7a 10 80       	push   $0x80107a0c
80105aca:	e8 b1 ab ff ff       	call   80100680 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105acf:	83 c4 20             	add    $0x20,%esp
80105ad2:	e8 a9 de ff ff       	call   80103980 <myproc>
80105ad7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80105ade:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ae0:	e8 9b de ff ff       	call   80103980 <myproc>
80105ae5:	85 c0                	test   %eax,%eax
80105ae7:	74 0c                	je     80105af5 <trap+0xb5>
80105ae9:	e8 92 de ff ff       	call   80103980 <myproc>
80105aee:	8b 50 24             	mov    0x24(%eax),%edx
80105af1:	85 d2                	test   %edx,%edx
80105af3:	75 4b                	jne    80105b40 <trap+0x100>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105af5:	e8 86 de ff ff       	call   80103980 <myproc>
80105afa:	85 c0                	test   %eax,%eax
80105afc:	74 0b                	je     80105b09 <trap+0xc9>
80105afe:	e8 7d de ff ff       	call   80103980 <myproc>
80105b03:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105b07:	74 4f                	je     80105b58 <trap+0x118>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b09:	e8 72 de ff ff       	call   80103980 <myproc>
80105b0e:	85 c0                	test   %eax,%eax
80105b10:	74 1d                	je     80105b2f <trap+0xef>
80105b12:	e8 69 de ff ff       	call   80103980 <myproc>
80105b17:	8b 40 24             	mov    0x24(%eax),%eax
80105b1a:	85 c0                	test   %eax,%eax
80105b1c:	74 11                	je     80105b2f <trap+0xef>
80105b1e:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105b22:	83 e0 03             	and    $0x3,%eax
80105b25:	66 83 f8 03          	cmp    $0x3,%ax
80105b29:	0f 84 da 00 00 00    	je     80105c09 <trap+0x1c9>
    exit();
}
80105b2f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b32:	5b                   	pop    %ebx
80105b33:	5e                   	pop    %esi
80105b34:	5f                   	pop    %edi
80105b35:	5d                   	pop    %ebp
80105b36:	c3                   	ret    
80105b37:	89 f6                	mov    %esi,%esi
80105b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b40:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105b44:	83 e0 03             	and    $0x3,%eax
80105b47:	66 83 f8 03          	cmp    $0x3,%ax
80105b4b:	75 a8                	jne    80105af5 <trap+0xb5>
    exit();
80105b4d:	e8 5e e2 ff ff       	call   80103db0 <exit>
80105b52:	eb a1                	jmp    80105af5 <trap+0xb5>
80105b54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105b58:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105b5c:	75 ab                	jne    80105b09 <trap+0xc9>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
80105b5e:	e8 8d e3 ff ff       	call   80103ef0 <yield>
80105b63:	eb a4                	jmp    80105b09 <trap+0xc9>
80105b65:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80105b68:	e8 f3 dd ff ff       	call   80103960 <cpuid>
80105b6d:	85 c0                	test   %eax,%eax
80105b6f:	0f 84 ab 00 00 00    	je     80105c20 <trap+0x1e0>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80105b75:	e8 96 cd ff ff       	call   80102910 <lapiceoi>
    break;
80105b7a:	e9 61 ff ff ff       	jmp    80105ae0 <trap+0xa0>
80105b7f:	90                   	nop
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80105b80:	e8 4b cc ff ff       	call   801027d0 <kbdintr>
    lapiceoi();
80105b85:	e8 86 cd ff ff       	call   80102910 <lapiceoi>
    break;
80105b8a:	e9 51 ff ff ff       	jmp    80105ae0 <trap+0xa0>
80105b8f:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80105b90:	e8 5b 02 00 00       	call   80105df0 <uartintr>
    lapiceoi();
80105b95:	e8 76 cd ff ff       	call   80102910 <lapiceoi>
    break;
80105b9a:	e9 41 ff ff ff       	jmp    80105ae0 <trap+0xa0>
80105b9f:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105ba0:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105ba4:	8b 77 38             	mov    0x38(%edi),%esi
80105ba7:	e8 b4 dd ff ff       	call   80103960 <cpuid>
80105bac:	56                   	push   %esi
80105bad:	53                   	push   %ebx
80105bae:	50                   	push   %eax
80105baf:	68 b4 79 10 80       	push   $0x801079b4
80105bb4:	e8 c7 aa ff ff       	call   80100680 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
80105bb9:	e8 52 cd ff ff       	call   80102910 <lapiceoi>
    break;
80105bbe:	83 c4 10             	add    $0x10,%esp
80105bc1:	e9 1a ff ff ff       	jmp    80105ae0 <trap+0xa0>
80105bc6:	8d 76 00             	lea    0x0(%esi),%esi
80105bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105bd0:	e8 7b c6 ff ff       	call   80102250 <ideintr>
80105bd5:	eb 9e                	jmp    80105b75 <trap+0x135>
80105bd7:	89 f6                	mov    %esi,%esi
80105bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
80105be0:	e8 9b dd ff ff       	call   80103980 <myproc>
80105be5:	8b 58 24             	mov    0x24(%eax),%ebx
80105be8:	85 db                	test   %ebx,%ebx
80105bea:	75 2c                	jne    80105c18 <trap+0x1d8>
      exit();
    myproc()->tf = tf;
80105bec:	e8 8f dd ff ff       	call   80103980 <myproc>
80105bf1:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80105bf4:	e8 27 ee ff ff       	call   80104a20 <syscall>
    if(myproc()->killed)
80105bf9:	e8 82 dd ff ff       	call   80103980 <myproc>
80105bfe:	8b 48 24             	mov    0x24(%eax),%ecx
80105c01:	85 c9                	test   %ecx,%ecx
80105c03:	0f 84 26 ff ff ff    	je     80105b2f <trap+0xef>
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80105c09:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c0c:	5b                   	pop    %ebx
80105c0d:	5e                   	pop    %esi
80105c0e:	5f                   	pop    %edi
80105c0f:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
80105c10:	e9 9b e1 ff ff       	jmp    80103db0 <exit>
80105c15:	8d 76 00             	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
80105c18:	e8 93 e1 ff ff       	call   80103db0 <exit>
80105c1d:	eb cd                	jmp    80105bec <trap+0x1ac>
80105c1f:	90                   	nop
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
80105c20:	83 ec 0c             	sub    $0xc,%esp
80105c23:	68 00 5c 11 80       	push   $0x80115c00
80105c28:	e8 83 e8 ff ff       	call   801044b0 <acquire>
      ticks++;
      wakeup(&ticks);
80105c2d:	c7 04 24 40 64 11 80 	movl   $0x80116440,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
80105c34:	83 05 40 64 11 80 01 	addl   $0x1,0x80116440
      wakeup(&ticks);
80105c3b:	e8 b0 e4 ff ff       	call   801040f0 <wakeup>
      release(&tickslock);
80105c40:	c7 04 24 00 5c 11 80 	movl   $0x80115c00,(%esp)
80105c47:	e8 84 e9 ff ff       	call   801045d0 <release>
80105c4c:	83 c4 10             	add    $0x10,%esp
80105c4f:	e9 21 ff ff ff       	jmp    80105b75 <trap+0x135>
80105c54:	0f 20 d6             	mov    %cr2,%esi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105c57:	8b 5f 38             	mov    0x38(%edi),%ebx
80105c5a:	e8 01 dd ff ff       	call   80103960 <cpuid>
80105c5f:	83 ec 0c             	sub    $0xc,%esp
80105c62:	56                   	push   %esi
80105c63:	53                   	push   %ebx
80105c64:	50                   	push   %eax
80105c65:	ff 77 30             	pushl  0x30(%edi)
80105c68:	68 d8 79 10 80       	push   $0x801079d8
80105c6d:	e8 0e aa ff ff       	call   80100680 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
80105c72:	83 c4 14             	add    $0x14,%esp
80105c75:	68 ae 79 10 80       	push   $0x801079ae
80105c7a:	e8 f1 a6 ff ff       	call   80100370 <panic>
80105c7f:	90                   	nop

80105c80 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105c80:	a1 5c b5 10 80       	mov    0x8010b55c,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80105c85:	55                   	push   %ebp
80105c86:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105c88:	85 c0                	test   %eax,%eax
80105c8a:	74 1c                	je     80105ca8 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105c8c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105c91:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105c92:	a8 01                	test   $0x1,%al
80105c94:	74 12                	je     80105ca8 <uartgetc+0x28>
80105c96:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c9b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105c9c:	0f b6 c0             	movzbl %al,%eax
}
80105c9f:	5d                   	pop    %ebp
80105ca0:	c3                   	ret    
80105ca1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80105ca8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
80105cad:	5d                   	pop    %ebp
80105cae:	c3                   	ret    
80105caf:	90                   	nop

80105cb0 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
80105cb0:	55                   	push   %ebp
80105cb1:	89 e5                	mov    %esp,%ebp
80105cb3:	57                   	push   %edi
80105cb4:	56                   	push   %esi
80105cb5:	53                   	push   %ebx
80105cb6:	89 c7                	mov    %eax,%edi
80105cb8:	bb 80 00 00 00       	mov    $0x80,%ebx
80105cbd:	be fd 03 00 00       	mov    $0x3fd,%esi
80105cc2:	83 ec 0c             	sub    $0xc,%esp
80105cc5:	eb 1b                	jmp    80105ce2 <uartputc.part.0+0x32>
80105cc7:	89 f6                	mov    %esi,%esi
80105cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80105cd0:	83 ec 0c             	sub    $0xc,%esp
80105cd3:	6a 0a                	push   $0xa
80105cd5:	e8 56 cc ff ff       	call   80102930 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105cda:	83 c4 10             	add    $0x10,%esp
80105cdd:	83 eb 01             	sub    $0x1,%ebx
80105ce0:	74 07                	je     80105ce9 <uartputc.part.0+0x39>
80105ce2:	89 f2                	mov    %esi,%edx
80105ce4:	ec                   	in     (%dx),%al
80105ce5:	a8 20                	test   $0x20,%al
80105ce7:	74 e7                	je     80105cd0 <uartputc.part.0+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105ce9:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105cee:	89 f8                	mov    %edi,%eax
80105cf0:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80105cf1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105cf4:	5b                   	pop    %ebx
80105cf5:	5e                   	pop    %esi
80105cf6:	5f                   	pop    %edi
80105cf7:	5d                   	pop    %ebp
80105cf8:	c3                   	ret    
80105cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d00 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80105d00:	55                   	push   %ebp
80105d01:	31 c9                	xor    %ecx,%ecx
80105d03:	89 c8                	mov    %ecx,%eax
80105d05:	89 e5                	mov    %esp,%ebp
80105d07:	57                   	push   %edi
80105d08:	56                   	push   %esi
80105d09:	53                   	push   %ebx
80105d0a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105d0f:	89 da                	mov    %ebx,%edx
80105d11:	83 ec 0c             	sub    $0xc,%esp
80105d14:	ee                   	out    %al,(%dx)
80105d15:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105d1a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105d1f:	89 fa                	mov    %edi,%edx
80105d21:	ee                   	out    %al,(%dx)
80105d22:	b8 0c 00 00 00       	mov    $0xc,%eax
80105d27:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d2c:	ee                   	out    %al,(%dx)
80105d2d:	be f9 03 00 00       	mov    $0x3f9,%esi
80105d32:	89 c8                	mov    %ecx,%eax
80105d34:	89 f2                	mov    %esi,%edx
80105d36:	ee                   	out    %al,(%dx)
80105d37:	b8 03 00 00 00       	mov    $0x3,%eax
80105d3c:	89 fa                	mov    %edi,%edx
80105d3e:	ee                   	out    %al,(%dx)
80105d3f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105d44:	89 c8                	mov    %ecx,%eax
80105d46:	ee                   	out    %al,(%dx)
80105d47:	b8 01 00 00 00       	mov    $0x1,%eax
80105d4c:	89 f2                	mov    %esi,%edx
80105d4e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105d4f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105d54:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80105d55:	3c ff                	cmp    $0xff,%al
80105d57:	74 5a                	je     80105db3 <uartinit+0xb3>
    return;
  uart = 1;
80105d59:	c7 05 5c b5 10 80 01 	movl   $0x1,0x8010b55c
80105d60:	00 00 00 
80105d63:	89 da                	mov    %ebx,%edx
80105d65:	ec                   	in     (%dx),%al
80105d66:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d6b:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
80105d6c:	83 ec 08             	sub    $0x8,%esp
80105d6f:	bb d0 7a 10 80       	mov    $0x80107ad0,%ebx
80105d74:	6a 00                	push   $0x0
80105d76:	6a 04                	push   $0x4
80105d78:	e8 23 c7 ff ff       	call   801024a0 <ioapicenable>
80105d7d:	83 c4 10             	add    $0x10,%esp
80105d80:	b8 78 00 00 00       	mov    $0x78,%eax
80105d85:	eb 13                	jmp    80105d9a <uartinit+0x9a>
80105d87:	89 f6                	mov    %esi,%esi
80105d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105d90:	83 c3 01             	add    $0x1,%ebx
80105d93:	0f be 03             	movsbl (%ebx),%eax
80105d96:	84 c0                	test   %al,%al
80105d98:	74 19                	je     80105db3 <uartinit+0xb3>
void
uartputc(int c)
{
  int i;

  if(!uart)
80105d9a:	8b 15 5c b5 10 80    	mov    0x8010b55c,%edx
80105da0:	85 d2                	test   %edx,%edx
80105da2:	74 ec                	je     80105d90 <uartinit+0x90>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105da4:	83 c3 01             	add    $0x1,%ebx
80105da7:	e8 04 ff ff ff       	call   80105cb0 <uartputc.part.0>
80105dac:	0f be 03             	movsbl (%ebx),%eax
80105daf:	84 c0                	test   %al,%al
80105db1:	75 e7                	jne    80105d9a <uartinit+0x9a>
    uartputc(*p);
}
80105db3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105db6:	5b                   	pop    %ebx
80105db7:	5e                   	pop    %esi
80105db8:	5f                   	pop    %edi
80105db9:	5d                   	pop    %ebp
80105dba:	c3                   	ret    
80105dbb:	90                   	nop
80105dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105dc0 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80105dc0:	8b 15 5c b5 10 80    	mov    0x8010b55c,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105dc6:	55                   	push   %ebp
80105dc7:	89 e5                	mov    %esp,%ebp
  int i;

  if(!uart)
80105dc9:	85 d2                	test   %edx,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105dcb:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
80105dce:	74 10                	je     80105de0 <uartputc+0x20>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80105dd0:	5d                   	pop    %ebp
80105dd1:	e9 da fe ff ff       	jmp    80105cb0 <uartputc.part.0>
80105dd6:	8d 76 00             	lea    0x0(%esi),%esi
80105dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105de0:	5d                   	pop    %ebp
80105de1:	c3                   	ret    
80105de2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105df0 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80105df0:	55                   	push   %ebp
80105df1:	89 e5                	mov    %esp,%ebp
80105df3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105df6:	68 80 5c 10 80       	push   $0x80105c80
80105dfb:	e8 90 ab ff ff       	call   80100990 <consoleintr>
}
80105e00:	83 c4 10             	add    $0x10,%esp
80105e03:	c9                   	leave  
80105e04:	c3                   	ret    

80105e05 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105e05:	6a 00                	push   $0x0
  pushl $0
80105e07:	6a 00                	push   $0x0
  jmp alltraps
80105e09:	e9 3a fb ff ff       	jmp    80105948 <alltraps>

80105e0e <vector1>:
.globl vector1
vector1:
  pushl $0
80105e0e:	6a 00                	push   $0x0
  pushl $1
80105e10:	6a 01                	push   $0x1
  jmp alltraps
80105e12:	e9 31 fb ff ff       	jmp    80105948 <alltraps>

80105e17 <vector2>:
.globl vector2
vector2:
  pushl $0
80105e17:	6a 00                	push   $0x0
  pushl $2
80105e19:	6a 02                	push   $0x2
  jmp alltraps
80105e1b:	e9 28 fb ff ff       	jmp    80105948 <alltraps>

80105e20 <vector3>:
.globl vector3
vector3:
  pushl $0
80105e20:	6a 00                	push   $0x0
  pushl $3
80105e22:	6a 03                	push   $0x3
  jmp alltraps
80105e24:	e9 1f fb ff ff       	jmp    80105948 <alltraps>

80105e29 <vector4>:
.globl vector4
vector4:
  pushl $0
80105e29:	6a 00                	push   $0x0
  pushl $4
80105e2b:	6a 04                	push   $0x4
  jmp alltraps
80105e2d:	e9 16 fb ff ff       	jmp    80105948 <alltraps>

80105e32 <vector5>:
.globl vector5
vector5:
  pushl $0
80105e32:	6a 00                	push   $0x0
  pushl $5
80105e34:	6a 05                	push   $0x5
  jmp alltraps
80105e36:	e9 0d fb ff ff       	jmp    80105948 <alltraps>

80105e3b <vector6>:
.globl vector6
vector6:
  pushl $0
80105e3b:	6a 00                	push   $0x0
  pushl $6
80105e3d:	6a 06                	push   $0x6
  jmp alltraps
80105e3f:	e9 04 fb ff ff       	jmp    80105948 <alltraps>

80105e44 <vector7>:
.globl vector7
vector7:
  pushl $0
80105e44:	6a 00                	push   $0x0
  pushl $7
80105e46:	6a 07                	push   $0x7
  jmp alltraps
80105e48:	e9 fb fa ff ff       	jmp    80105948 <alltraps>

80105e4d <vector8>:
.globl vector8
vector8:
  pushl $8
80105e4d:	6a 08                	push   $0x8
  jmp alltraps
80105e4f:	e9 f4 fa ff ff       	jmp    80105948 <alltraps>

80105e54 <vector9>:
.globl vector9
vector9:
  pushl $0
80105e54:	6a 00                	push   $0x0
  pushl $9
80105e56:	6a 09                	push   $0x9
  jmp alltraps
80105e58:	e9 eb fa ff ff       	jmp    80105948 <alltraps>

80105e5d <vector10>:
.globl vector10
vector10:
  pushl $10
80105e5d:	6a 0a                	push   $0xa
  jmp alltraps
80105e5f:	e9 e4 fa ff ff       	jmp    80105948 <alltraps>

80105e64 <vector11>:
.globl vector11
vector11:
  pushl $11
80105e64:	6a 0b                	push   $0xb
  jmp alltraps
80105e66:	e9 dd fa ff ff       	jmp    80105948 <alltraps>

80105e6b <vector12>:
.globl vector12
vector12:
  pushl $12
80105e6b:	6a 0c                	push   $0xc
  jmp alltraps
80105e6d:	e9 d6 fa ff ff       	jmp    80105948 <alltraps>

80105e72 <vector13>:
.globl vector13
vector13:
  pushl $13
80105e72:	6a 0d                	push   $0xd
  jmp alltraps
80105e74:	e9 cf fa ff ff       	jmp    80105948 <alltraps>

80105e79 <vector14>:
.globl vector14
vector14:
  pushl $14
80105e79:	6a 0e                	push   $0xe
  jmp alltraps
80105e7b:	e9 c8 fa ff ff       	jmp    80105948 <alltraps>

80105e80 <vector15>:
.globl vector15
vector15:
  pushl $0
80105e80:	6a 00                	push   $0x0
  pushl $15
80105e82:	6a 0f                	push   $0xf
  jmp alltraps
80105e84:	e9 bf fa ff ff       	jmp    80105948 <alltraps>

80105e89 <vector16>:
.globl vector16
vector16:
  pushl $0
80105e89:	6a 00                	push   $0x0
  pushl $16
80105e8b:	6a 10                	push   $0x10
  jmp alltraps
80105e8d:	e9 b6 fa ff ff       	jmp    80105948 <alltraps>

80105e92 <vector17>:
.globl vector17
vector17:
  pushl $17
80105e92:	6a 11                	push   $0x11
  jmp alltraps
80105e94:	e9 af fa ff ff       	jmp    80105948 <alltraps>

80105e99 <vector18>:
.globl vector18
vector18:
  pushl $0
80105e99:	6a 00                	push   $0x0
  pushl $18
80105e9b:	6a 12                	push   $0x12
  jmp alltraps
80105e9d:	e9 a6 fa ff ff       	jmp    80105948 <alltraps>

80105ea2 <vector19>:
.globl vector19
vector19:
  pushl $0
80105ea2:	6a 00                	push   $0x0
  pushl $19
80105ea4:	6a 13                	push   $0x13
  jmp alltraps
80105ea6:	e9 9d fa ff ff       	jmp    80105948 <alltraps>

80105eab <vector20>:
.globl vector20
vector20:
  pushl $0
80105eab:	6a 00                	push   $0x0
  pushl $20
80105ead:	6a 14                	push   $0x14
  jmp alltraps
80105eaf:	e9 94 fa ff ff       	jmp    80105948 <alltraps>

80105eb4 <vector21>:
.globl vector21
vector21:
  pushl $0
80105eb4:	6a 00                	push   $0x0
  pushl $21
80105eb6:	6a 15                	push   $0x15
  jmp alltraps
80105eb8:	e9 8b fa ff ff       	jmp    80105948 <alltraps>

80105ebd <vector22>:
.globl vector22
vector22:
  pushl $0
80105ebd:	6a 00                	push   $0x0
  pushl $22
80105ebf:	6a 16                	push   $0x16
  jmp alltraps
80105ec1:	e9 82 fa ff ff       	jmp    80105948 <alltraps>

80105ec6 <vector23>:
.globl vector23
vector23:
  pushl $0
80105ec6:	6a 00                	push   $0x0
  pushl $23
80105ec8:	6a 17                	push   $0x17
  jmp alltraps
80105eca:	e9 79 fa ff ff       	jmp    80105948 <alltraps>

80105ecf <vector24>:
.globl vector24
vector24:
  pushl $0
80105ecf:	6a 00                	push   $0x0
  pushl $24
80105ed1:	6a 18                	push   $0x18
  jmp alltraps
80105ed3:	e9 70 fa ff ff       	jmp    80105948 <alltraps>

80105ed8 <vector25>:
.globl vector25
vector25:
  pushl $0
80105ed8:	6a 00                	push   $0x0
  pushl $25
80105eda:	6a 19                	push   $0x19
  jmp alltraps
80105edc:	e9 67 fa ff ff       	jmp    80105948 <alltraps>

80105ee1 <vector26>:
.globl vector26
vector26:
  pushl $0
80105ee1:	6a 00                	push   $0x0
  pushl $26
80105ee3:	6a 1a                	push   $0x1a
  jmp alltraps
80105ee5:	e9 5e fa ff ff       	jmp    80105948 <alltraps>

80105eea <vector27>:
.globl vector27
vector27:
  pushl $0
80105eea:	6a 00                	push   $0x0
  pushl $27
80105eec:	6a 1b                	push   $0x1b
  jmp alltraps
80105eee:	e9 55 fa ff ff       	jmp    80105948 <alltraps>

80105ef3 <vector28>:
.globl vector28
vector28:
  pushl $0
80105ef3:	6a 00                	push   $0x0
  pushl $28
80105ef5:	6a 1c                	push   $0x1c
  jmp alltraps
80105ef7:	e9 4c fa ff ff       	jmp    80105948 <alltraps>

80105efc <vector29>:
.globl vector29
vector29:
  pushl $0
80105efc:	6a 00                	push   $0x0
  pushl $29
80105efe:	6a 1d                	push   $0x1d
  jmp alltraps
80105f00:	e9 43 fa ff ff       	jmp    80105948 <alltraps>

80105f05 <vector30>:
.globl vector30
vector30:
  pushl $0
80105f05:	6a 00                	push   $0x0
  pushl $30
80105f07:	6a 1e                	push   $0x1e
  jmp alltraps
80105f09:	e9 3a fa ff ff       	jmp    80105948 <alltraps>

80105f0e <vector31>:
.globl vector31
vector31:
  pushl $0
80105f0e:	6a 00                	push   $0x0
  pushl $31
80105f10:	6a 1f                	push   $0x1f
  jmp alltraps
80105f12:	e9 31 fa ff ff       	jmp    80105948 <alltraps>

80105f17 <vector32>:
.globl vector32
vector32:
  pushl $0
80105f17:	6a 00                	push   $0x0
  pushl $32
80105f19:	6a 20                	push   $0x20
  jmp alltraps
80105f1b:	e9 28 fa ff ff       	jmp    80105948 <alltraps>

80105f20 <vector33>:
.globl vector33
vector33:
  pushl $0
80105f20:	6a 00                	push   $0x0
  pushl $33
80105f22:	6a 21                	push   $0x21
  jmp alltraps
80105f24:	e9 1f fa ff ff       	jmp    80105948 <alltraps>

80105f29 <vector34>:
.globl vector34
vector34:
  pushl $0
80105f29:	6a 00                	push   $0x0
  pushl $34
80105f2b:	6a 22                	push   $0x22
  jmp alltraps
80105f2d:	e9 16 fa ff ff       	jmp    80105948 <alltraps>

80105f32 <vector35>:
.globl vector35
vector35:
  pushl $0
80105f32:	6a 00                	push   $0x0
  pushl $35
80105f34:	6a 23                	push   $0x23
  jmp alltraps
80105f36:	e9 0d fa ff ff       	jmp    80105948 <alltraps>

80105f3b <vector36>:
.globl vector36
vector36:
  pushl $0
80105f3b:	6a 00                	push   $0x0
  pushl $36
80105f3d:	6a 24                	push   $0x24
  jmp alltraps
80105f3f:	e9 04 fa ff ff       	jmp    80105948 <alltraps>

80105f44 <vector37>:
.globl vector37
vector37:
  pushl $0
80105f44:	6a 00                	push   $0x0
  pushl $37
80105f46:	6a 25                	push   $0x25
  jmp alltraps
80105f48:	e9 fb f9 ff ff       	jmp    80105948 <alltraps>

80105f4d <vector38>:
.globl vector38
vector38:
  pushl $0
80105f4d:	6a 00                	push   $0x0
  pushl $38
80105f4f:	6a 26                	push   $0x26
  jmp alltraps
80105f51:	e9 f2 f9 ff ff       	jmp    80105948 <alltraps>

80105f56 <vector39>:
.globl vector39
vector39:
  pushl $0
80105f56:	6a 00                	push   $0x0
  pushl $39
80105f58:	6a 27                	push   $0x27
  jmp alltraps
80105f5a:	e9 e9 f9 ff ff       	jmp    80105948 <alltraps>

80105f5f <vector40>:
.globl vector40
vector40:
  pushl $0
80105f5f:	6a 00                	push   $0x0
  pushl $40
80105f61:	6a 28                	push   $0x28
  jmp alltraps
80105f63:	e9 e0 f9 ff ff       	jmp    80105948 <alltraps>

80105f68 <vector41>:
.globl vector41
vector41:
  pushl $0
80105f68:	6a 00                	push   $0x0
  pushl $41
80105f6a:	6a 29                	push   $0x29
  jmp alltraps
80105f6c:	e9 d7 f9 ff ff       	jmp    80105948 <alltraps>

80105f71 <vector42>:
.globl vector42
vector42:
  pushl $0
80105f71:	6a 00                	push   $0x0
  pushl $42
80105f73:	6a 2a                	push   $0x2a
  jmp alltraps
80105f75:	e9 ce f9 ff ff       	jmp    80105948 <alltraps>

80105f7a <vector43>:
.globl vector43
vector43:
  pushl $0
80105f7a:	6a 00                	push   $0x0
  pushl $43
80105f7c:	6a 2b                	push   $0x2b
  jmp alltraps
80105f7e:	e9 c5 f9 ff ff       	jmp    80105948 <alltraps>

80105f83 <vector44>:
.globl vector44
vector44:
  pushl $0
80105f83:	6a 00                	push   $0x0
  pushl $44
80105f85:	6a 2c                	push   $0x2c
  jmp alltraps
80105f87:	e9 bc f9 ff ff       	jmp    80105948 <alltraps>

80105f8c <vector45>:
.globl vector45
vector45:
  pushl $0
80105f8c:	6a 00                	push   $0x0
  pushl $45
80105f8e:	6a 2d                	push   $0x2d
  jmp alltraps
80105f90:	e9 b3 f9 ff ff       	jmp    80105948 <alltraps>

80105f95 <vector46>:
.globl vector46
vector46:
  pushl $0
80105f95:	6a 00                	push   $0x0
  pushl $46
80105f97:	6a 2e                	push   $0x2e
  jmp alltraps
80105f99:	e9 aa f9 ff ff       	jmp    80105948 <alltraps>

80105f9e <vector47>:
.globl vector47
vector47:
  pushl $0
80105f9e:	6a 00                	push   $0x0
  pushl $47
80105fa0:	6a 2f                	push   $0x2f
  jmp alltraps
80105fa2:	e9 a1 f9 ff ff       	jmp    80105948 <alltraps>

80105fa7 <vector48>:
.globl vector48
vector48:
  pushl $0
80105fa7:	6a 00                	push   $0x0
  pushl $48
80105fa9:	6a 30                	push   $0x30
  jmp alltraps
80105fab:	e9 98 f9 ff ff       	jmp    80105948 <alltraps>

80105fb0 <vector49>:
.globl vector49
vector49:
  pushl $0
80105fb0:	6a 00                	push   $0x0
  pushl $49
80105fb2:	6a 31                	push   $0x31
  jmp alltraps
80105fb4:	e9 8f f9 ff ff       	jmp    80105948 <alltraps>

80105fb9 <vector50>:
.globl vector50
vector50:
  pushl $0
80105fb9:	6a 00                	push   $0x0
  pushl $50
80105fbb:	6a 32                	push   $0x32
  jmp alltraps
80105fbd:	e9 86 f9 ff ff       	jmp    80105948 <alltraps>

80105fc2 <vector51>:
.globl vector51
vector51:
  pushl $0
80105fc2:	6a 00                	push   $0x0
  pushl $51
80105fc4:	6a 33                	push   $0x33
  jmp alltraps
80105fc6:	e9 7d f9 ff ff       	jmp    80105948 <alltraps>

80105fcb <vector52>:
.globl vector52
vector52:
  pushl $0
80105fcb:	6a 00                	push   $0x0
  pushl $52
80105fcd:	6a 34                	push   $0x34
  jmp alltraps
80105fcf:	e9 74 f9 ff ff       	jmp    80105948 <alltraps>

80105fd4 <vector53>:
.globl vector53
vector53:
  pushl $0
80105fd4:	6a 00                	push   $0x0
  pushl $53
80105fd6:	6a 35                	push   $0x35
  jmp alltraps
80105fd8:	e9 6b f9 ff ff       	jmp    80105948 <alltraps>

80105fdd <vector54>:
.globl vector54
vector54:
  pushl $0
80105fdd:	6a 00                	push   $0x0
  pushl $54
80105fdf:	6a 36                	push   $0x36
  jmp alltraps
80105fe1:	e9 62 f9 ff ff       	jmp    80105948 <alltraps>

80105fe6 <vector55>:
.globl vector55
vector55:
  pushl $0
80105fe6:	6a 00                	push   $0x0
  pushl $55
80105fe8:	6a 37                	push   $0x37
  jmp alltraps
80105fea:	e9 59 f9 ff ff       	jmp    80105948 <alltraps>

80105fef <vector56>:
.globl vector56
vector56:
  pushl $0
80105fef:	6a 00                	push   $0x0
  pushl $56
80105ff1:	6a 38                	push   $0x38
  jmp alltraps
80105ff3:	e9 50 f9 ff ff       	jmp    80105948 <alltraps>

80105ff8 <vector57>:
.globl vector57
vector57:
  pushl $0
80105ff8:	6a 00                	push   $0x0
  pushl $57
80105ffa:	6a 39                	push   $0x39
  jmp alltraps
80105ffc:	e9 47 f9 ff ff       	jmp    80105948 <alltraps>

80106001 <vector58>:
.globl vector58
vector58:
  pushl $0
80106001:	6a 00                	push   $0x0
  pushl $58
80106003:	6a 3a                	push   $0x3a
  jmp alltraps
80106005:	e9 3e f9 ff ff       	jmp    80105948 <alltraps>

8010600a <vector59>:
.globl vector59
vector59:
  pushl $0
8010600a:	6a 00                	push   $0x0
  pushl $59
8010600c:	6a 3b                	push   $0x3b
  jmp alltraps
8010600e:	e9 35 f9 ff ff       	jmp    80105948 <alltraps>

80106013 <vector60>:
.globl vector60
vector60:
  pushl $0
80106013:	6a 00                	push   $0x0
  pushl $60
80106015:	6a 3c                	push   $0x3c
  jmp alltraps
80106017:	e9 2c f9 ff ff       	jmp    80105948 <alltraps>

8010601c <vector61>:
.globl vector61
vector61:
  pushl $0
8010601c:	6a 00                	push   $0x0
  pushl $61
8010601e:	6a 3d                	push   $0x3d
  jmp alltraps
80106020:	e9 23 f9 ff ff       	jmp    80105948 <alltraps>

80106025 <vector62>:
.globl vector62
vector62:
  pushl $0
80106025:	6a 00                	push   $0x0
  pushl $62
80106027:	6a 3e                	push   $0x3e
  jmp alltraps
80106029:	e9 1a f9 ff ff       	jmp    80105948 <alltraps>

8010602e <vector63>:
.globl vector63
vector63:
  pushl $0
8010602e:	6a 00                	push   $0x0
  pushl $63
80106030:	6a 3f                	push   $0x3f
  jmp alltraps
80106032:	e9 11 f9 ff ff       	jmp    80105948 <alltraps>

80106037 <vector64>:
.globl vector64
vector64:
  pushl $0
80106037:	6a 00                	push   $0x0
  pushl $64
80106039:	6a 40                	push   $0x40
  jmp alltraps
8010603b:	e9 08 f9 ff ff       	jmp    80105948 <alltraps>

80106040 <vector65>:
.globl vector65
vector65:
  pushl $0
80106040:	6a 00                	push   $0x0
  pushl $65
80106042:	6a 41                	push   $0x41
  jmp alltraps
80106044:	e9 ff f8 ff ff       	jmp    80105948 <alltraps>

80106049 <vector66>:
.globl vector66
vector66:
  pushl $0
80106049:	6a 00                	push   $0x0
  pushl $66
8010604b:	6a 42                	push   $0x42
  jmp alltraps
8010604d:	e9 f6 f8 ff ff       	jmp    80105948 <alltraps>

80106052 <vector67>:
.globl vector67
vector67:
  pushl $0
80106052:	6a 00                	push   $0x0
  pushl $67
80106054:	6a 43                	push   $0x43
  jmp alltraps
80106056:	e9 ed f8 ff ff       	jmp    80105948 <alltraps>

8010605b <vector68>:
.globl vector68
vector68:
  pushl $0
8010605b:	6a 00                	push   $0x0
  pushl $68
8010605d:	6a 44                	push   $0x44
  jmp alltraps
8010605f:	e9 e4 f8 ff ff       	jmp    80105948 <alltraps>

80106064 <vector69>:
.globl vector69
vector69:
  pushl $0
80106064:	6a 00                	push   $0x0
  pushl $69
80106066:	6a 45                	push   $0x45
  jmp alltraps
80106068:	e9 db f8 ff ff       	jmp    80105948 <alltraps>

8010606d <vector70>:
.globl vector70
vector70:
  pushl $0
8010606d:	6a 00                	push   $0x0
  pushl $70
8010606f:	6a 46                	push   $0x46
  jmp alltraps
80106071:	e9 d2 f8 ff ff       	jmp    80105948 <alltraps>

80106076 <vector71>:
.globl vector71
vector71:
  pushl $0
80106076:	6a 00                	push   $0x0
  pushl $71
80106078:	6a 47                	push   $0x47
  jmp alltraps
8010607a:	e9 c9 f8 ff ff       	jmp    80105948 <alltraps>

8010607f <vector72>:
.globl vector72
vector72:
  pushl $0
8010607f:	6a 00                	push   $0x0
  pushl $72
80106081:	6a 48                	push   $0x48
  jmp alltraps
80106083:	e9 c0 f8 ff ff       	jmp    80105948 <alltraps>

80106088 <vector73>:
.globl vector73
vector73:
  pushl $0
80106088:	6a 00                	push   $0x0
  pushl $73
8010608a:	6a 49                	push   $0x49
  jmp alltraps
8010608c:	e9 b7 f8 ff ff       	jmp    80105948 <alltraps>

80106091 <vector74>:
.globl vector74
vector74:
  pushl $0
80106091:	6a 00                	push   $0x0
  pushl $74
80106093:	6a 4a                	push   $0x4a
  jmp alltraps
80106095:	e9 ae f8 ff ff       	jmp    80105948 <alltraps>

8010609a <vector75>:
.globl vector75
vector75:
  pushl $0
8010609a:	6a 00                	push   $0x0
  pushl $75
8010609c:	6a 4b                	push   $0x4b
  jmp alltraps
8010609e:	e9 a5 f8 ff ff       	jmp    80105948 <alltraps>

801060a3 <vector76>:
.globl vector76
vector76:
  pushl $0
801060a3:	6a 00                	push   $0x0
  pushl $76
801060a5:	6a 4c                	push   $0x4c
  jmp alltraps
801060a7:	e9 9c f8 ff ff       	jmp    80105948 <alltraps>

801060ac <vector77>:
.globl vector77
vector77:
  pushl $0
801060ac:	6a 00                	push   $0x0
  pushl $77
801060ae:	6a 4d                	push   $0x4d
  jmp alltraps
801060b0:	e9 93 f8 ff ff       	jmp    80105948 <alltraps>

801060b5 <vector78>:
.globl vector78
vector78:
  pushl $0
801060b5:	6a 00                	push   $0x0
  pushl $78
801060b7:	6a 4e                	push   $0x4e
  jmp alltraps
801060b9:	e9 8a f8 ff ff       	jmp    80105948 <alltraps>

801060be <vector79>:
.globl vector79
vector79:
  pushl $0
801060be:	6a 00                	push   $0x0
  pushl $79
801060c0:	6a 4f                	push   $0x4f
  jmp alltraps
801060c2:	e9 81 f8 ff ff       	jmp    80105948 <alltraps>

801060c7 <vector80>:
.globl vector80
vector80:
  pushl $0
801060c7:	6a 00                	push   $0x0
  pushl $80
801060c9:	6a 50                	push   $0x50
  jmp alltraps
801060cb:	e9 78 f8 ff ff       	jmp    80105948 <alltraps>

801060d0 <vector81>:
.globl vector81
vector81:
  pushl $0
801060d0:	6a 00                	push   $0x0
  pushl $81
801060d2:	6a 51                	push   $0x51
  jmp alltraps
801060d4:	e9 6f f8 ff ff       	jmp    80105948 <alltraps>

801060d9 <vector82>:
.globl vector82
vector82:
  pushl $0
801060d9:	6a 00                	push   $0x0
  pushl $82
801060db:	6a 52                	push   $0x52
  jmp alltraps
801060dd:	e9 66 f8 ff ff       	jmp    80105948 <alltraps>

801060e2 <vector83>:
.globl vector83
vector83:
  pushl $0
801060e2:	6a 00                	push   $0x0
  pushl $83
801060e4:	6a 53                	push   $0x53
  jmp alltraps
801060e6:	e9 5d f8 ff ff       	jmp    80105948 <alltraps>

801060eb <vector84>:
.globl vector84
vector84:
  pushl $0
801060eb:	6a 00                	push   $0x0
  pushl $84
801060ed:	6a 54                	push   $0x54
  jmp alltraps
801060ef:	e9 54 f8 ff ff       	jmp    80105948 <alltraps>

801060f4 <vector85>:
.globl vector85
vector85:
  pushl $0
801060f4:	6a 00                	push   $0x0
  pushl $85
801060f6:	6a 55                	push   $0x55
  jmp alltraps
801060f8:	e9 4b f8 ff ff       	jmp    80105948 <alltraps>

801060fd <vector86>:
.globl vector86
vector86:
  pushl $0
801060fd:	6a 00                	push   $0x0
  pushl $86
801060ff:	6a 56                	push   $0x56
  jmp alltraps
80106101:	e9 42 f8 ff ff       	jmp    80105948 <alltraps>

80106106 <vector87>:
.globl vector87
vector87:
  pushl $0
80106106:	6a 00                	push   $0x0
  pushl $87
80106108:	6a 57                	push   $0x57
  jmp alltraps
8010610a:	e9 39 f8 ff ff       	jmp    80105948 <alltraps>

8010610f <vector88>:
.globl vector88
vector88:
  pushl $0
8010610f:	6a 00                	push   $0x0
  pushl $88
80106111:	6a 58                	push   $0x58
  jmp alltraps
80106113:	e9 30 f8 ff ff       	jmp    80105948 <alltraps>

80106118 <vector89>:
.globl vector89
vector89:
  pushl $0
80106118:	6a 00                	push   $0x0
  pushl $89
8010611a:	6a 59                	push   $0x59
  jmp alltraps
8010611c:	e9 27 f8 ff ff       	jmp    80105948 <alltraps>

80106121 <vector90>:
.globl vector90
vector90:
  pushl $0
80106121:	6a 00                	push   $0x0
  pushl $90
80106123:	6a 5a                	push   $0x5a
  jmp alltraps
80106125:	e9 1e f8 ff ff       	jmp    80105948 <alltraps>

8010612a <vector91>:
.globl vector91
vector91:
  pushl $0
8010612a:	6a 00                	push   $0x0
  pushl $91
8010612c:	6a 5b                	push   $0x5b
  jmp alltraps
8010612e:	e9 15 f8 ff ff       	jmp    80105948 <alltraps>

80106133 <vector92>:
.globl vector92
vector92:
  pushl $0
80106133:	6a 00                	push   $0x0
  pushl $92
80106135:	6a 5c                	push   $0x5c
  jmp alltraps
80106137:	e9 0c f8 ff ff       	jmp    80105948 <alltraps>

8010613c <vector93>:
.globl vector93
vector93:
  pushl $0
8010613c:	6a 00                	push   $0x0
  pushl $93
8010613e:	6a 5d                	push   $0x5d
  jmp alltraps
80106140:	e9 03 f8 ff ff       	jmp    80105948 <alltraps>

80106145 <vector94>:
.globl vector94
vector94:
  pushl $0
80106145:	6a 00                	push   $0x0
  pushl $94
80106147:	6a 5e                	push   $0x5e
  jmp alltraps
80106149:	e9 fa f7 ff ff       	jmp    80105948 <alltraps>

8010614e <vector95>:
.globl vector95
vector95:
  pushl $0
8010614e:	6a 00                	push   $0x0
  pushl $95
80106150:	6a 5f                	push   $0x5f
  jmp alltraps
80106152:	e9 f1 f7 ff ff       	jmp    80105948 <alltraps>

80106157 <vector96>:
.globl vector96
vector96:
  pushl $0
80106157:	6a 00                	push   $0x0
  pushl $96
80106159:	6a 60                	push   $0x60
  jmp alltraps
8010615b:	e9 e8 f7 ff ff       	jmp    80105948 <alltraps>

80106160 <vector97>:
.globl vector97
vector97:
  pushl $0
80106160:	6a 00                	push   $0x0
  pushl $97
80106162:	6a 61                	push   $0x61
  jmp alltraps
80106164:	e9 df f7 ff ff       	jmp    80105948 <alltraps>

80106169 <vector98>:
.globl vector98
vector98:
  pushl $0
80106169:	6a 00                	push   $0x0
  pushl $98
8010616b:	6a 62                	push   $0x62
  jmp alltraps
8010616d:	e9 d6 f7 ff ff       	jmp    80105948 <alltraps>

80106172 <vector99>:
.globl vector99
vector99:
  pushl $0
80106172:	6a 00                	push   $0x0
  pushl $99
80106174:	6a 63                	push   $0x63
  jmp alltraps
80106176:	e9 cd f7 ff ff       	jmp    80105948 <alltraps>

8010617b <vector100>:
.globl vector100
vector100:
  pushl $0
8010617b:	6a 00                	push   $0x0
  pushl $100
8010617d:	6a 64                	push   $0x64
  jmp alltraps
8010617f:	e9 c4 f7 ff ff       	jmp    80105948 <alltraps>

80106184 <vector101>:
.globl vector101
vector101:
  pushl $0
80106184:	6a 00                	push   $0x0
  pushl $101
80106186:	6a 65                	push   $0x65
  jmp alltraps
80106188:	e9 bb f7 ff ff       	jmp    80105948 <alltraps>

8010618d <vector102>:
.globl vector102
vector102:
  pushl $0
8010618d:	6a 00                	push   $0x0
  pushl $102
8010618f:	6a 66                	push   $0x66
  jmp alltraps
80106191:	e9 b2 f7 ff ff       	jmp    80105948 <alltraps>

80106196 <vector103>:
.globl vector103
vector103:
  pushl $0
80106196:	6a 00                	push   $0x0
  pushl $103
80106198:	6a 67                	push   $0x67
  jmp alltraps
8010619a:	e9 a9 f7 ff ff       	jmp    80105948 <alltraps>

8010619f <vector104>:
.globl vector104
vector104:
  pushl $0
8010619f:	6a 00                	push   $0x0
  pushl $104
801061a1:	6a 68                	push   $0x68
  jmp alltraps
801061a3:	e9 a0 f7 ff ff       	jmp    80105948 <alltraps>

801061a8 <vector105>:
.globl vector105
vector105:
  pushl $0
801061a8:	6a 00                	push   $0x0
  pushl $105
801061aa:	6a 69                	push   $0x69
  jmp alltraps
801061ac:	e9 97 f7 ff ff       	jmp    80105948 <alltraps>

801061b1 <vector106>:
.globl vector106
vector106:
  pushl $0
801061b1:	6a 00                	push   $0x0
  pushl $106
801061b3:	6a 6a                	push   $0x6a
  jmp alltraps
801061b5:	e9 8e f7 ff ff       	jmp    80105948 <alltraps>

801061ba <vector107>:
.globl vector107
vector107:
  pushl $0
801061ba:	6a 00                	push   $0x0
  pushl $107
801061bc:	6a 6b                	push   $0x6b
  jmp alltraps
801061be:	e9 85 f7 ff ff       	jmp    80105948 <alltraps>

801061c3 <vector108>:
.globl vector108
vector108:
  pushl $0
801061c3:	6a 00                	push   $0x0
  pushl $108
801061c5:	6a 6c                	push   $0x6c
  jmp alltraps
801061c7:	e9 7c f7 ff ff       	jmp    80105948 <alltraps>

801061cc <vector109>:
.globl vector109
vector109:
  pushl $0
801061cc:	6a 00                	push   $0x0
  pushl $109
801061ce:	6a 6d                	push   $0x6d
  jmp alltraps
801061d0:	e9 73 f7 ff ff       	jmp    80105948 <alltraps>

801061d5 <vector110>:
.globl vector110
vector110:
  pushl $0
801061d5:	6a 00                	push   $0x0
  pushl $110
801061d7:	6a 6e                	push   $0x6e
  jmp alltraps
801061d9:	e9 6a f7 ff ff       	jmp    80105948 <alltraps>

801061de <vector111>:
.globl vector111
vector111:
  pushl $0
801061de:	6a 00                	push   $0x0
  pushl $111
801061e0:	6a 6f                	push   $0x6f
  jmp alltraps
801061e2:	e9 61 f7 ff ff       	jmp    80105948 <alltraps>

801061e7 <vector112>:
.globl vector112
vector112:
  pushl $0
801061e7:	6a 00                	push   $0x0
  pushl $112
801061e9:	6a 70                	push   $0x70
  jmp alltraps
801061eb:	e9 58 f7 ff ff       	jmp    80105948 <alltraps>

801061f0 <vector113>:
.globl vector113
vector113:
  pushl $0
801061f0:	6a 00                	push   $0x0
  pushl $113
801061f2:	6a 71                	push   $0x71
  jmp alltraps
801061f4:	e9 4f f7 ff ff       	jmp    80105948 <alltraps>

801061f9 <vector114>:
.globl vector114
vector114:
  pushl $0
801061f9:	6a 00                	push   $0x0
  pushl $114
801061fb:	6a 72                	push   $0x72
  jmp alltraps
801061fd:	e9 46 f7 ff ff       	jmp    80105948 <alltraps>

80106202 <vector115>:
.globl vector115
vector115:
  pushl $0
80106202:	6a 00                	push   $0x0
  pushl $115
80106204:	6a 73                	push   $0x73
  jmp alltraps
80106206:	e9 3d f7 ff ff       	jmp    80105948 <alltraps>

8010620b <vector116>:
.globl vector116
vector116:
  pushl $0
8010620b:	6a 00                	push   $0x0
  pushl $116
8010620d:	6a 74                	push   $0x74
  jmp alltraps
8010620f:	e9 34 f7 ff ff       	jmp    80105948 <alltraps>

80106214 <vector117>:
.globl vector117
vector117:
  pushl $0
80106214:	6a 00                	push   $0x0
  pushl $117
80106216:	6a 75                	push   $0x75
  jmp alltraps
80106218:	e9 2b f7 ff ff       	jmp    80105948 <alltraps>

8010621d <vector118>:
.globl vector118
vector118:
  pushl $0
8010621d:	6a 00                	push   $0x0
  pushl $118
8010621f:	6a 76                	push   $0x76
  jmp alltraps
80106221:	e9 22 f7 ff ff       	jmp    80105948 <alltraps>

80106226 <vector119>:
.globl vector119
vector119:
  pushl $0
80106226:	6a 00                	push   $0x0
  pushl $119
80106228:	6a 77                	push   $0x77
  jmp alltraps
8010622a:	e9 19 f7 ff ff       	jmp    80105948 <alltraps>

8010622f <vector120>:
.globl vector120
vector120:
  pushl $0
8010622f:	6a 00                	push   $0x0
  pushl $120
80106231:	6a 78                	push   $0x78
  jmp alltraps
80106233:	e9 10 f7 ff ff       	jmp    80105948 <alltraps>

80106238 <vector121>:
.globl vector121
vector121:
  pushl $0
80106238:	6a 00                	push   $0x0
  pushl $121
8010623a:	6a 79                	push   $0x79
  jmp alltraps
8010623c:	e9 07 f7 ff ff       	jmp    80105948 <alltraps>

80106241 <vector122>:
.globl vector122
vector122:
  pushl $0
80106241:	6a 00                	push   $0x0
  pushl $122
80106243:	6a 7a                	push   $0x7a
  jmp alltraps
80106245:	e9 fe f6 ff ff       	jmp    80105948 <alltraps>

8010624a <vector123>:
.globl vector123
vector123:
  pushl $0
8010624a:	6a 00                	push   $0x0
  pushl $123
8010624c:	6a 7b                	push   $0x7b
  jmp alltraps
8010624e:	e9 f5 f6 ff ff       	jmp    80105948 <alltraps>

80106253 <vector124>:
.globl vector124
vector124:
  pushl $0
80106253:	6a 00                	push   $0x0
  pushl $124
80106255:	6a 7c                	push   $0x7c
  jmp alltraps
80106257:	e9 ec f6 ff ff       	jmp    80105948 <alltraps>

8010625c <vector125>:
.globl vector125
vector125:
  pushl $0
8010625c:	6a 00                	push   $0x0
  pushl $125
8010625e:	6a 7d                	push   $0x7d
  jmp alltraps
80106260:	e9 e3 f6 ff ff       	jmp    80105948 <alltraps>

80106265 <vector126>:
.globl vector126
vector126:
  pushl $0
80106265:	6a 00                	push   $0x0
  pushl $126
80106267:	6a 7e                	push   $0x7e
  jmp alltraps
80106269:	e9 da f6 ff ff       	jmp    80105948 <alltraps>

8010626e <vector127>:
.globl vector127
vector127:
  pushl $0
8010626e:	6a 00                	push   $0x0
  pushl $127
80106270:	6a 7f                	push   $0x7f
  jmp alltraps
80106272:	e9 d1 f6 ff ff       	jmp    80105948 <alltraps>

80106277 <vector128>:
.globl vector128
vector128:
  pushl $0
80106277:	6a 00                	push   $0x0
  pushl $128
80106279:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010627e:	e9 c5 f6 ff ff       	jmp    80105948 <alltraps>

80106283 <vector129>:
.globl vector129
vector129:
  pushl $0
80106283:	6a 00                	push   $0x0
  pushl $129
80106285:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010628a:	e9 b9 f6 ff ff       	jmp    80105948 <alltraps>

8010628f <vector130>:
.globl vector130
vector130:
  pushl $0
8010628f:	6a 00                	push   $0x0
  pushl $130
80106291:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106296:	e9 ad f6 ff ff       	jmp    80105948 <alltraps>

8010629b <vector131>:
.globl vector131
vector131:
  pushl $0
8010629b:	6a 00                	push   $0x0
  pushl $131
8010629d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801062a2:	e9 a1 f6 ff ff       	jmp    80105948 <alltraps>

801062a7 <vector132>:
.globl vector132
vector132:
  pushl $0
801062a7:	6a 00                	push   $0x0
  pushl $132
801062a9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801062ae:	e9 95 f6 ff ff       	jmp    80105948 <alltraps>

801062b3 <vector133>:
.globl vector133
vector133:
  pushl $0
801062b3:	6a 00                	push   $0x0
  pushl $133
801062b5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801062ba:	e9 89 f6 ff ff       	jmp    80105948 <alltraps>

801062bf <vector134>:
.globl vector134
vector134:
  pushl $0
801062bf:	6a 00                	push   $0x0
  pushl $134
801062c1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801062c6:	e9 7d f6 ff ff       	jmp    80105948 <alltraps>

801062cb <vector135>:
.globl vector135
vector135:
  pushl $0
801062cb:	6a 00                	push   $0x0
  pushl $135
801062cd:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801062d2:	e9 71 f6 ff ff       	jmp    80105948 <alltraps>

801062d7 <vector136>:
.globl vector136
vector136:
  pushl $0
801062d7:	6a 00                	push   $0x0
  pushl $136
801062d9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801062de:	e9 65 f6 ff ff       	jmp    80105948 <alltraps>

801062e3 <vector137>:
.globl vector137
vector137:
  pushl $0
801062e3:	6a 00                	push   $0x0
  pushl $137
801062e5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801062ea:	e9 59 f6 ff ff       	jmp    80105948 <alltraps>

801062ef <vector138>:
.globl vector138
vector138:
  pushl $0
801062ef:	6a 00                	push   $0x0
  pushl $138
801062f1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801062f6:	e9 4d f6 ff ff       	jmp    80105948 <alltraps>

801062fb <vector139>:
.globl vector139
vector139:
  pushl $0
801062fb:	6a 00                	push   $0x0
  pushl $139
801062fd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106302:	e9 41 f6 ff ff       	jmp    80105948 <alltraps>

80106307 <vector140>:
.globl vector140
vector140:
  pushl $0
80106307:	6a 00                	push   $0x0
  pushl $140
80106309:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010630e:	e9 35 f6 ff ff       	jmp    80105948 <alltraps>

80106313 <vector141>:
.globl vector141
vector141:
  pushl $0
80106313:	6a 00                	push   $0x0
  pushl $141
80106315:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010631a:	e9 29 f6 ff ff       	jmp    80105948 <alltraps>

8010631f <vector142>:
.globl vector142
vector142:
  pushl $0
8010631f:	6a 00                	push   $0x0
  pushl $142
80106321:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106326:	e9 1d f6 ff ff       	jmp    80105948 <alltraps>

8010632b <vector143>:
.globl vector143
vector143:
  pushl $0
8010632b:	6a 00                	push   $0x0
  pushl $143
8010632d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106332:	e9 11 f6 ff ff       	jmp    80105948 <alltraps>

80106337 <vector144>:
.globl vector144
vector144:
  pushl $0
80106337:	6a 00                	push   $0x0
  pushl $144
80106339:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010633e:	e9 05 f6 ff ff       	jmp    80105948 <alltraps>

80106343 <vector145>:
.globl vector145
vector145:
  pushl $0
80106343:	6a 00                	push   $0x0
  pushl $145
80106345:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010634a:	e9 f9 f5 ff ff       	jmp    80105948 <alltraps>

8010634f <vector146>:
.globl vector146
vector146:
  pushl $0
8010634f:	6a 00                	push   $0x0
  pushl $146
80106351:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106356:	e9 ed f5 ff ff       	jmp    80105948 <alltraps>

8010635b <vector147>:
.globl vector147
vector147:
  pushl $0
8010635b:	6a 00                	push   $0x0
  pushl $147
8010635d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106362:	e9 e1 f5 ff ff       	jmp    80105948 <alltraps>

80106367 <vector148>:
.globl vector148
vector148:
  pushl $0
80106367:	6a 00                	push   $0x0
  pushl $148
80106369:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010636e:	e9 d5 f5 ff ff       	jmp    80105948 <alltraps>

80106373 <vector149>:
.globl vector149
vector149:
  pushl $0
80106373:	6a 00                	push   $0x0
  pushl $149
80106375:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010637a:	e9 c9 f5 ff ff       	jmp    80105948 <alltraps>

8010637f <vector150>:
.globl vector150
vector150:
  pushl $0
8010637f:	6a 00                	push   $0x0
  pushl $150
80106381:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106386:	e9 bd f5 ff ff       	jmp    80105948 <alltraps>

8010638b <vector151>:
.globl vector151
vector151:
  pushl $0
8010638b:	6a 00                	push   $0x0
  pushl $151
8010638d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106392:	e9 b1 f5 ff ff       	jmp    80105948 <alltraps>

80106397 <vector152>:
.globl vector152
vector152:
  pushl $0
80106397:	6a 00                	push   $0x0
  pushl $152
80106399:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010639e:	e9 a5 f5 ff ff       	jmp    80105948 <alltraps>

801063a3 <vector153>:
.globl vector153
vector153:
  pushl $0
801063a3:	6a 00                	push   $0x0
  pushl $153
801063a5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801063aa:	e9 99 f5 ff ff       	jmp    80105948 <alltraps>

801063af <vector154>:
.globl vector154
vector154:
  pushl $0
801063af:	6a 00                	push   $0x0
  pushl $154
801063b1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801063b6:	e9 8d f5 ff ff       	jmp    80105948 <alltraps>

801063bb <vector155>:
.globl vector155
vector155:
  pushl $0
801063bb:	6a 00                	push   $0x0
  pushl $155
801063bd:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801063c2:	e9 81 f5 ff ff       	jmp    80105948 <alltraps>

801063c7 <vector156>:
.globl vector156
vector156:
  pushl $0
801063c7:	6a 00                	push   $0x0
  pushl $156
801063c9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801063ce:	e9 75 f5 ff ff       	jmp    80105948 <alltraps>

801063d3 <vector157>:
.globl vector157
vector157:
  pushl $0
801063d3:	6a 00                	push   $0x0
  pushl $157
801063d5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801063da:	e9 69 f5 ff ff       	jmp    80105948 <alltraps>

801063df <vector158>:
.globl vector158
vector158:
  pushl $0
801063df:	6a 00                	push   $0x0
  pushl $158
801063e1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801063e6:	e9 5d f5 ff ff       	jmp    80105948 <alltraps>

801063eb <vector159>:
.globl vector159
vector159:
  pushl $0
801063eb:	6a 00                	push   $0x0
  pushl $159
801063ed:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801063f2:	e9 51 f5 ff ff       	jmp    80105948 <alltraps>

801063f7 <vector160>:
.globl vector160
vector160:
  pushl $0
801063f7:	6a 00                	push   $0x0
  pushl $160
801063f9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801063fe:	e9 45 f5 ff ff       	jmp    80105948 <alltraps>

80106403 <vector161>:
.globl vector161
vector161:
  pushl $0
80106403:	6a 00                	push   $0x0
  pushl $161
80106405:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010640a:	e9 39 f5 ff ff       	jmp    80105948 <alltraps>

8010640f <vector162>:
.globl vector162
vector162:
  pushl $0
8010640f:	6a 00                	push   $0x0
  pushl $162
80106411:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106416:	e9 2d f5 ff ff       	jmp    80105948 <alltraps>

8010641b <vector163>:
.globl vector163
vector163:
  pushl $0
8010641b:	6a 00                	push   $0x0
  pushl $163
8010641d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106422:	e9 21 f5 ff ff       	jmp    80105948 <alltraps>

80106427 <vector164>:
.globl vector164
vector164:
  pushl $0
80106427:	6a 00                	push   $0x0
  pushl $164
80106429:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010642e:	e9 15 f5 ff ff       	jmp    80105948 <alltraps>

80106433 <vector165>:
.globl vector165
vector165:
  pushl $0
80106433:	6a 00                	push   $0x0
  pushl $165
80106435:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010643a:	e9 09 f5 ff ff       	jmp    80105948 <alltraps>

8010643f <vector166>:
.globl vector166
vector166:
  pushl $0
8010643f:	6a 00                	push   $0x0
  pushl $166
80106441:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106446:	e9 fd f4 ff ff       	jmp    80105948 <alltraps>

8010644b <vector167>:
.globl vector167
vector167:
  pushl $0
8010644b:	6a 00                	push   $0x0
  pushl $167
8010644d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106452:	e9 f1 f4 ff ff       	jmp    80105948 <alltraps>

80106457 <vector168>:
.globl vector168
vector168:
  pushl $0
80106457:	6a 00                	push   $0x0
  pushl $168
80106459:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010645e:	e9 e5 f4 ff ff       	jmp    80105948 <alltraps>

80106463 <vector169>:
.globl vector169
vector169:
  pushl $0
80106463:	6a 00                	push   $0x0
  pushl $169
80106465:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010646a:	e9 d9 f4 ff ff       	jmp    80105948 <alltraps>

8010646f <vector170>:
.globl vector170
vector170:
  pushl $0
8010646f:	6a 00                	push   $0x0
  pushl $170
80106471:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106476:	e9 cd f4 ff ff       	jmp    80105948 <alltraps>

8010647b <vector171>:
.globl vector171
vector171:
  pushl $0
8010647b:	6a 00                	push   $0x0
  pushl $171
8010647d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106482:	e9 c1 f4 ff ff       	jmp    80105948 <alltraps>

80106487 <vector172>:
.globl vector172
vector172:
  pushl $0
80106487:	6a 00                	push   $0x0
  pushl $172
80106489:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010648e:	e9 b5 f4 ff ff       	jmp    80105948 <alltraps>

80106493 <vector173>:
.globl vector173
vector173:
  pushl $0
80106493:	6a 00                	push   $0x0
  pushl $173
80106495:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010649a:	e9 a9 f4 ff ff       	jmp    80105948 <alltraps>

8010649f <vector174>:
.globl vector174
vector174:
  pushl $0
8010649f:	6a 00                	push   $0x0
  pushl $174
801064a1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801064a6:	e9 9d f4 ff ff       	jmp    80105948 <alltraps>

801064ab <vector175>:
.globl vector175
vector175:
  pushl $0
801064ab:	6a 00                	push   $0x0
  pushl $175
801064ad:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801064b2:	e9 91 f4 ff ff       	jmp    80105948 <alltraps>

801064b7 <vector176>:
.globl vector176
vector176:
  pushl $0
801064b7:	6a 00                	push   $0x0
  pushl $176
801064b9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801064be:	e9 85 f4 ff ff       	jmp    80105948 <alltraps>

801064c3 <vector177>:
.globl vector177
vector177:
  pushl $0
801064c3:	6a 00                	push   $0x0
  pushl $177
801064c5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801064ca:	e9 79 f4 ff ff       	jmp    80105948 <alltraps>

801064cf <vector178>:
.globl vector178
vector178:
  pushl $0
801064cf:	6a 00                	push   $0x0
  pushl $178
801064d1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801064d6:	e9 6d f4 ff ff       	jmp    80105948 <alltraps>

801064db <vector179>:
.globl vector179
vector179:
  pushl $0
801064db:	6a 00                	push   $0x0
  pushl $179
801064dd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801064e2:	e9 61 f4 ff ff       	jmp    80105948 <alltraps>

801064e7 <vector180>:
.globl vector180
vector180:
  pushl $0
801064e7:	6a 00                	push   $0x0
  pushl $180
801064e9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801064ee:	e9 55 f4 ff ff       	jmp    80105948 <alltraps>

801064f3 <vector181>:
.globl vector181
vector181:
  pushl $0
801064f3:	6a 00                	push   $0x0
  pushl $181
801064f5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801064fa:	e9 49 f4 ff ff       	jmp    80105948 <alltraps>

801064ff <vector182>:
.globl vector182
vector182:
  pushl $0
801064ff:	6a 00                	push   $0x0
  pushl $182
80106501:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106506:	e9 3d f4 ff ff       	jmp    80105948 <alltraps>

8010650b <vector183>:
.globl vector183
vector183:
  pushl $0
8010650b:	6a 00                	push   $0x0
  pushl $183
8010650d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106512:	e9 31 f4 ff ff       	jmp    80105948 <alltraps>

80106517 <vector184>:
.globl vector184
vector184:
  pushl $0
80106517:	6a 00                	push   $0x0
  pushl $184
80106519:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010651e:	e9 25 f4 ff ff       	jmp    80105948 <alltraps>

80106523 <vector185>:
.globl vector185
vector185:
  pushl $0
80106523:	6a 00                	push   $0x0
  pushl $185
80106525:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010652a:	e9 19 f4 ff ff       	jmp    80105948 <alltraps>

8010652f <vector186>:
.globl vector186
vector186:
  pushl $0
8010652f:	6a 00                	push   $0x0
  pushl $186
80106531:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106536:	e9 0d f4 ff ff       	jmp    80105948 <alltraps>

8010653b <vector187>:
.globl vector187
vector187:
  pushl $0
8010653b:	6a 00                	push   $0x0
  pushl $187
8010653d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106542:	e9 01 f4 ff ff       	jmp    80105948 <alltraps>

80106547 <vector188>:
.globl vector188
vector188:
  pushl $0
80106547:	6a 00                	push   $0x0
  pushl $188
80106549:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010654e:	e9 f5 f3 ff ff       	jmp    80105948 <alltraps>

80106553 <vector189>:
.globl vector189
vector189:
  pushl $0
80106553:	6a 00                	push   $0x0
  pushl $189
80106555:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010655a:	e9 e9 f3 ff ff       	jmp    80105948 <alltraps>

8010655f <vector190>:
.globl vector190
vector190:
  pushl $0
8010655f:	6a 00                	push   $0x0
  pushl $190
80106561:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106566:	e9 dd f3 ff ff       	jmp    80105948 <alltraps>

8010656b <vector191>:
.globl vector191
vector191:
  pushl $0
8010656b:	6a 00                	push   $0x0
  pushl $191
8010656d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106572:	e9 d1 f3 ff ff       	jmp    80105948 <alltraps>

80106577 <vector192>:
.globl vector192
vector192:
  pushl $0
80106577:	6a 00                	push   $0x0
  pushl $192
80106579:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010657e:	e9 c5 f3 ff ff       	jmp    80105948 <alltraps>

80106583 <vector193>:
.globl vector193
vector193:
  pushl $0
80106583:	6a 00                	push   $0x0
  pushl $193
80106585:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010658a:	e9 b9 f3 ff ff       	jmp    80105948 <alltraps>

8010658f <vector194>:
.globl vector194
vector194:
  pushl $0
8010658f:	6a 00                	push   $0x0
  pushl $194
80106591:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106596:	e9 ad f3 ff ff       	jmp    80105948 <alltraps>

8010659b <vector195>:
.globl vector195
vector195:
  pushl $0
8010659b:	6a 00                	push   $0x0
  pushl $195
8010659d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801065a2:	e9 a1 f3 ff ff       	jmp    80105948 <alltraps>

801065a7 <vector196>:
.globl vector196
vector196:
  pushl $0
801065a7:	6a 00                	push   $0x0
  pushl $196
801065a9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801065ae:	e9 95 f3 ff ff       	jmp    80105948 <alltraps>

801065b3 <vector197>:
.globl vector197
vector197:
  pushl $0
801065b3:	6a 00                	push   $0x0
  pushl $197
801065b5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801065ba:	e9 89 f3 ff ff       	jmp    80105948 <alltraps>

801065bf <vector198>:
.globl vector198
vector198:
  pushl $0
801065bf:	6a 00                	push   $0x0
  pushl $198
801065c1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801065c6:	e9 7d f3 ff ff       	jmp    80105948 <alltraps>

801065cb <vector199>:
.globl vector199
vector199:
  pushl $0
801065cb:	6a 00                	push   $0x0
  pushl $199
801065cd:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801065d2:	e9 71 f3 ff ff       	jmp    80105948 <alltraps>

801065d7 <vector200>:
.globl vector200
vector200:
  pushl $0
801065d7:	6a 00                	push   $0x0
  pushl $200
801065d9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801065de:	e9 65 f3 ff ff       	jmp    80105948 <alltraps>

801065e3 <vector201>:
.globl vector201
vector201:
  pushl $0
801065e3:	6a 00                	push   $0x0
  pushl $201
801065e5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801065ea:	e9 59 f3 ff ff       	jmp    80105948 <alltraps>

801065ef <vector202>:
.globl vector202
vector202:
  pushl $0
801065ef:	6a 00                	push   $0x0
  pushl $202
801065f1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801065f6:	e9 4d f3 ff ff       	jmp    80105948 <alltraps>

801065fb <vector203>:
.globl vector203
vector203:
  pushl $0
801065fb:	6a 00                	push   $0x0
  pushl $203
801065fd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106602:	e9 41 f3 ff ff       	jmp    80105948 <alltraps>

80106607 <vector204>:
.globl vector204
vector204:
  pushl $0
80106607:	6a 00                	push   $0x0
  pushl $204
80106609:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010660e:	e9 35 f3 ff ff       	jmp    80105948 <alltraps>

80106613 <vector205>:
.globl vector205
vector205:
  pushl $0
80106613:	6a 00                	push   $0x0
  pushl $205
80106615:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010661a:	e9 29 f3 ff ff       	jmp    80105948 <alltraps>

8010661f <vector206>:
.globl vector206
vector206:
  pushl $0
8010661f:	6a 00                	push   $0x0
  pushl $206
80106621:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106626:	e9 1d f3 ff ff       	jmp    80105948 <alltraps>

8010662b <vector207>:
.globl vector207
vector207:
  pushl $0
8010662b:	6a 00                	push   $0x0
  pushl $207
8010662d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106632:	e9 11 f3 ff ff       	jmp    80105948 <alltraps>

80106637 <vector208>:
.globl vector208
vector208:
  pushl $0
80106637:	6a 00                	push   $0x0
  pushl $208
80106639:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010663e:	e9 05 f3 ff ff       	jmp    80105948 <alltraps>

80106643 <vector209>:
.globl vector209
vector209:
  pushl $0
80106643:	6a 00                	push   $0x0
  pushl $209
80106645:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010664a:	e9 f9 f2 ff ff       	jmp    80105948 <alltraps>

8010664f <vector210>:
.globl vector210
vector210:
  pushl $0
8010664f:	6a 00                	push   $0x0
  pushl $210
80106651:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106656:	e9 ed f2 ff ff       	jmp    80105948 <alltraps>

8010665b <vector211>:
.globl vector211
vector211:
  pushl $0
8010665b:	6a 00                	push   $0x0
  pushl $211
8010665d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106662:	e9 e1 f2 ff ff       	jmp    80105948 <alltraps>

80106667 <vector212>:
.globl vector212
vector212:
  pushl $0
80106667:	6a 00                	push   $0x0
  pushl $212
80106669:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010666e:	e9 d5 f2 ff ff       	jmp    80105948 <alltraps>

80106673 <vector213>:
.globl vector213
vector213:
  pushl $0
80106673:	6a 00                	push   $0x0
  pushl $213
80106675:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010667a:	e9 c9 f2 ff ff       	jmp    80105948 <alltraps>

8010667f <vector214>:
.globl vector214
vector214:
  pushl $0
8010667f:	6a 00                	push   $0x0
  pushl $214
80106681:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106686:	e9 bd f2 ff ff       	jmp    80105948 <alltraps>

8010668b <vector215>:
.globl vector215
vector215:
  pushl $0
8010668b:	6a 00                	push   $0x0
  pushl $215
8010668d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106692:	e9 b1 f2 ff ff       	jmp    80105948 <alltraps>

80106697 <vector216>:
.globl vector216
vector216:
  pushl $0
80106697:	6a 00                	push   $0x0
  pushl $216
80106699:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010669e:	e9 a5 f2 ff ff       	jmp    80105948 <alltraps>

801066a3 <vector217>:
.globl vector217
vector217:
  pushl $0
801066a3:	6a 00                	push   $0x0
  pushl $217
801066a5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801066aa:	e9 99 f2 ff ff       	jmp    80105948 <alltraps>

801066af <vector218>:
.globl vector218
vector218:
  pushl $0
801066af:	6a 00                	push   $0x0
  pushl $218
801066b1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801066b6:	e9 8d f2 ff ff       	jmp    80105948 <alltraps>

801066bb <vector219>:
.globl vector219
vector219:
  pushl $0
801066bb:	6a 00                	push   $0x0
  pushl $219
801066bd:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801066c2:	e9 81 f2 ff ff       	jmp    80105948 <alltraps>

801066c7 <vector220>:
.globl vector220
vector220:
  pushl $0
801066c7:	6a 00                	push   $0x0
  pushl $220
801066c9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801066ce:	e9 75 f2 ff ff       	jmp    80105948 <alltraps>

801066d3 <vector221>:
.globl vector221
vector221:
  pushl $0
801066d3:	6a 00                	push   $0x0
  pushl $221
801066d5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801066da:	e9 69 f2 ff ff       	jmp    80105948 <alltraps>

801066df <vector222>:
.globl vector222
vector222:
  pushl $0
801066df:	6a 00                	push   $0x0
  pushl $222
801066e1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801066e6:	e9 5d f2 ff ff       	jmp    80105948 <alltraps>

801066eb <vector223>:
.globl vector223
vector223:
  pushl $0
801066eb:	6a 00                	push   $0x0
  pushl $223
801066ed:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801066f2:	e9 51 f2 ff ff       	jmp    80105948 <alltraps>

801066f7 <vector224>:
.globl vector224
vector224:
  pushl $0
801066f7:	6a 00                	push   $0x0
  pushl $224
801066f9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801066fe:	e9 45 f2 ff ff       	jmp    80105948 <alltraps>

80106703 <vector225>:
.globl vector225
vector225:
  pushl $0
80106703:	6a 00                	push   $0x0
  pushl $225
80106705:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010670a:	e9 39 f2 ff ff       	jmp    80105948 <alltraps>

8010670f <vector226>:
.globl vector226
vector226:
  pushl $0
8010670f:	6a 00                	push   $0x0
  pushl $226
80106711:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106716:	e9 2d f2 ff ff       	jmp    80105948 <alltraps>

8010671b <vector227>:
.globl vector227
vector227:
  pushl $0
8010671b:	6a 00                	push   $0x0
  pushl $227
8010671d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106722:	e9 21 f2 ff ff       	jmp    80105948 <alltraps>

80106727 <vector228>:
.globl vector228
vector228:
  pushl $0
80106727:	6a 00                	push   $0x0
  pushl $228
80106729:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010672e:	e9 15 f2 ff ff       	jmp    80105948 <alltraps>

80106733 <vector229>:
.globl vector229
vector229:
  pushl $0
80106733:	6a 00                	push   $0x0
  pushl $229
80106735:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010673a:	e9 09 f2 ff ff       	jmp    80105948 <alltraps>

8010673f <vector230>:
.globl vector230
vector230:
  pushl $0
8010673f:	6a 00                	push   $0x0
  pushl $230
80106741:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106746:	e9 fd f1 ff ff       	jmp    80105948 <alltraps>

8010674b <vector231>:
.globl vector231
vector231:
  pushl $0
8010674b:	6a 00                	push   $0x0
  pushl $231
8010674d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106752:	e9 f1 f1 ff ff       	jmp    80105948 <alltraps>

80106757 <vector232>:
.globl vector232
vector232:
  pushl $0
80106757:	6a 00                	push   $0x0
  pushl $232
80106759:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010675e:	e9 e5 f1 ff ff       	jmp    80105948 <alltraps>

80106763 <vector233>:
.globl vector233
vector233:
  pushl $0
80106763:	6a 00                	push   $0x0
  pushl $233
80106765:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010676a:	e9 d9 f1 ff ff       	jmp    80105948 <alltraps>

8010676f <vector234>:
.globl vector234
vector234:
  pushl $0
8010676f:	6a 00                	push   $0x0
  pushl $234
80106771:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106776:	e9 cd f1 ff ff       	jmp    80105948 <alltraps>

8010677b <vector235>:
.globl vector235
vector235:
  pushl $0
8010677b:	6a 00                	push   $0x0
  pushl $235
8010677d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106782:	e9 c1 f1 ff ff       	jmp    80105948 <alltraps>

80106787 <vector236>:
.globl vector236
vector236:
  pushl $0
80106787:	6a 00                	push   $0x0
  pushl $236
80106789:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010678e:	e9 b5 f1 ff ff       	jmp    80105948 <alltraps>

80106793 <vector237>:
.globl vector237
vector237:
  pushl $0
80106793:	6a 00                	push   $0x0
  pushl $237
80106795:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010679a:	e9 a9 f1 ff ff       	jmp    80105948 <alltraps>

8010679f <vector238>:
.globl vector238
vector238:
  pushl $0
8010679f:	6a 00                	push   $0x0
  pushl $238
801067a1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801067a6:	e9 9d f1 ff ff       	jmp    80105948 <alltraps>

801067ab <vector239>:
.globl vector239
vector239:
  pushl $0
801067ab:	6a 00                	push   $0x0
  pushl $239
801067ad:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801067b2:	e9 91 f1 ff ff       	jmp    80105948 <alltraps>

801067b7 <vector240>:
.globl vector240
vector240:
  pushl $0
801067b7:	6a 00                	push   $0x0
  pushl $240
801067b9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801067be:	e9 85 f1 ff ff       	jmp    80105948 <alltraps>

801067c3 <vector241>:
.globl vector241
vector241:
  pushl $0
801067c3:	6a 00                	push   $0x0
  pushl $241
801067c5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801067ca:	e9 79 f1 ff ff       	jmp    80105948 <alltraps>

801067cf <vector242>:
.globl vector242
vector242:
  pushl $0
801067cf:	6a 00                	push   $0x0
  pushl $242
801067d1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801067d6:	e9 6d f1 ff ff       	jmp    80105948 <alltraps>

801067db <vector243>:
.globl vector243
vector243:
  pushl $0
801067db:	6a 00                	push   $0x0
  pushl $243
801067dd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801067e2:	e9 61 f1 ff ff       	jmp    80105948 <alltraps>

801067e7 <vector244>:
.globl vector244
vector244:
  pushl $0
801067e7:	6a 00                	push   $0x0
  pushl $244
801067e9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801067ee:	e9 55 f1 ff ff       	jmp    80105948 <alltraps>

801067f3 <vector245>:
.globl vector245
vector245:
  pushl $0
801067f3:	6a 00                	push   $0x0
  pushl $245
801067f5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801067fa:	e9 49 f1 ff ff       	jmp    80105948 <alltraps>

801067ff <vector246>:
.globl vector246
vector246:
  pushl $0
801067ff:	6a 00                	push   $0x0
  pushl $246
80106801:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106806:	e9 3d f1 ff ff       	jmp    80105948 <alltraps>

8010680b <vector247>:
.globl vector247
vector247:
  pushl $0
8010680b:	6a 00                	push   $0x0
  pushl $247
8010680d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106812:	e9 31 f1 ff ff       	jmp    80105948 <alltraps>

80106817 <vector248>:
.globl vector248
vector248:
  pushl $0
80106817:	6a 00                	push   $0x0
  pushl $248
80106819:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010681e:	e9 25 f1 ff ff       	jmp    80105948 <alltraps>

80106823 <vector249>:
.globl vector249
vector249:
  pushl $0
80106823:	6a 00                	push   $0x0
  pushl $249
80106825:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010682a:	e9 19 f1 ff ff       	jmp    80105948 <alltraps>

8010682f <vector250>:
.globl vector250
vector250:
  pushl $0
8010682f:	6a 00                	push   $0x0
  pushl $250
80106831:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106836:	e9 0d f1 ff ff       	jmp    80105948 <alltraps>

8010683b <vector251>:
.globl vector251
vector251:
  pushl $0
8010683b:	6a 00                	push   $0x0
  pushl $251
8010683d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106842:	e9 01 f1 ff ff       	jmp    80105948 <alltraps>

80106847 <vector252>:
.globl vector252
vector252:
  pushl $0
80106847:	6a 00                	push   $0x0
  pushl $252
80106849:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010684e:	e9 f5 f0 ff ff       	jmp    80105948 <alltraps>

80106853 <vector253>:
.globl vector253
vector253:
  pushl $0
80106853:	6a 00                	push   $0x0
  pushl $253
80106855:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010685a:	e9 e9 f0 ff ff       	jmp    80105948 <alltraps>

8010685f <vector254>:
.globl vector254
vector254:
  pushl $0
8010685f:	6a 00                	push   $0x0
  pushl $254
80106861:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106866:	e9 dd f0 ff ff       	jmp    80105948 <alltraps>

8010686b <vector255>:
.globl vector255
vector255:
  pushl $0
8010686b:	6a 00                	push   $0x0
  pushl $255
8010686d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106872:	e9 d1 f0 ff ff       	jmp    80105948 <alltraps>
80106877:	66 90                	xchg   %ax,%ax
80106879:	66 90                	xchg   %ax,%ax
8010687b:	66 90                	xchg   %ax,%ax
8010687d:	66 90                	xchg   %ax,%ax
8010687f:	90                   	nop

80106880 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106880:	55                   	push   %ebp
80106881:	89 e5                	mov    %esp,%ebp
80106883:	57                   	push   %edi
80106884:	56                   	push   %esi
80106885:	53                   	push   %ebx
80106886:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106888:	c1 ea 16             	shr    $0x16,%edx
8010688b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
8010688e:	83 ec 0c             	sub    $0xc,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
80106891:	8b 07                	mov    (%edi),%eax
80106893:	a8 01                	test   $0x1,%al
80106895:	74 29                	je     801068c0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106897:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010689c:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
801068a2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801068a5:	c1 eb 0a             	shr    $0xa,%ebx
801068a8:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
801068ae:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
801068b1:	5b                   	pop    %ebx
801068b2:	5e                   	pop    %esi
801068b3:	5f                   	pop    %edi
801068b4:	5d                   	pop    %ebp
801068b5:	c3                   	ret    
801068b6:	8d 76 00             	lea    0x0(%esi),%esi
801068b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801068c0:	85 c9                	test   %ecx,%ecx
801068c2:	74 2c                	je     801068f0 <walkpgdir+0x70>
801068c4:	e8 c7 bd ff ff       	call   80102690 <kalloc>
801068c9:	85 c0                	test   %eax,%eax
801068cb:	89 c6                	mov    %eax,%esi
801068cd:	74 21                	je     801068f0 <walkpgdir+0x70>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
801068cf:	83 ec 04             	sub    $0x4,%esp
801068d2:	68 00 10 00 00       	push   $0x1000
801068d7:	6a 00                	push   $0x0
801068d9:	50                   	push   %eax
801068da:	e8 41 dd ff ff       	call   80104620 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801068df:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801068e5:	83 c4 10             	add    $0x10,%esp
801068e8:	83 c8 07             	or     $0x7,%eax
801068eb:	89 07                	mov    %eax,(%edi)
801068ed:	eb b3                	jmp    801068a2 <walkpgdir+0x22>
801068ef:	90                   	nop
  }
  return &pgtab[PTX(va)];
}
801068f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
801068f3:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
801068f5:	5b                   	pop    %ebx
801068f6:	5e                   	pop    %esi
801068f7:	5f                   	pop    %edi
801068f8:	5d                   	pop    %ebp
801068f9:	c3                   	ret    
801068fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106900 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106900:	55                   	push   %ebp
80106901:	89 e5                	mov    %esp,%ebp
80106903:	57                   	push   %edi
80106904:	56                   	push   %esi
80106905:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106906:	89 d3                	mov    %edx,%ebx
80106908:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
8010690e:	83 ec 1c             	sub    $0x1c,%esp
80106911:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106914:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106918:	8b 7d 08             	mov    0x8(%ebp),%edi
8010691b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106920:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106923:	8b 45 0c             	mov    0xc(%ebp),%eax
80106926:	29 df                	sub    %ebx,%edi
80106928:	83 c8 01             	or     $0x1,%eax
8010692b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010692e:	eb 15                	jmp    80106945 <mappages+0x45>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80106930:	f6 00 01             	testb  $0x1,(%eax)
80106933:	75 45                	jne    8010697a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80106935:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106938:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
8010693b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010693d:	74 31                	je     80106970 <mappages+0x70>
      break;
    a += PGSIZE;
8010693f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106945:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106948:	b9 01 00 00 00       	mov    $0x1,%ecx
8010694d:	89 da                	mov    %ebx,%edx
8010694f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106952:	e8 29 ff ff ff       	call   80106880 <walkpgdir>
80106957:	85 c0                	test   %eax,%eax
80106959:	75 d5                	jne    80106930 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
8010695b:	8d 65 f4             	lea    -0xc(%ebp),%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
8010695e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80106963:	5b                   	pop    %ebx
80106964:	5e                   	pop    %esi
80106965:	5f                   	pop    %edi
80106966:	5d                   	pop    %ebp
80106967:	c3                   	ret    
80106968:	90                   	nop
80106969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106970:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80106973:	31 c0                	xor    %eax,%eax
}
80106975:	5b                   	pop    %ebx
80106976:	5e                   	pop    %esi
80106977:	5f                   	pop    %edi
80106978:	5d                   	pop    %ebp
80106979:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
8010697a:	83 ec 0c             	sub    $0xc,%esp
8010697d:	68 d8 7a 10 80       	push   $0x80107ad8
80106982:	e8 e9 99 ff ff       	call   80100370 <panic>
80106987:	89 f6                	mov    %esi,%esi
80106989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106990 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106990:	55                   	push   %ebp
80106991:	89 e5                	mov    %esp,%ebp
80106993:	57                   	push   %edi
80106994:	56                   	push   %esi
80106995:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106996:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010699c:	89 c7                	mov    %eax,%edi
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
8010699e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801069a4:	83 ec 1c             	sub    $0x1c,%esp
801069a7:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801069aa:	39 d3                	cmp    %edx,%ebx
801069ac:	73 66                	jae    80106a14 <deallocuvm.part.0+0x84>
801069ae:	89 d6                	mov    %edx,%esi
801069b0:	eb 3d                	jmp    801069ef <deallocuvm.part.0+0x5f>
801069b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
801069b8:	8b 10                	mov    (%eax),%edx
801069ba:	f6 c2 01             	test   $0x1,%dl
801069bd:	74 26                	je     801069e5 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801069bf:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801069c5:	74 58                	je     80106a1f <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
801069c7:	83 ec 0c             	sub    $0xc,%esp
801069ca:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801069d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801069d3:	52                   	push   %edx
801069d4:	e8 07 bb ff ff       	call   801024e0 <kfree>
      *pte = 0;
801069d9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801069dc:	83 c4 10             	add    $0x10,%esp
801069df:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801069e5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801069eb:	39 f3                	cmp    %esi,%ebx
801069ed:	73 25                	jae    80106a14 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
801069ef:	31 c9                	xor    %ecx,%ecx
801069f1:	89 da                	mov    %ebx,%edx
801069f3:	89 f8                	mov    %edi,%eax
801069f5:	e8 86 fe ff ff       	call   80106880 <walkpgdir>
    if(!pte)
801069fa:	85 c0                	test   %eax,%eax
801069fc:	75 ba                	jne    801069b8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801069fe:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106a04:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106a0a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106a10:	39 f3                	cmp    %esi,%ebx
80106a12:	72 db                	jb     801069ef <deallocuvm.part.0+0x5f>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106a14:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106a17:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a1a:	5b                   	pop    %ebx
80106a1b:	5e                   	pop    %esi
80106a1c:	5f                   	pop    %edi
80106a1d:	5d                   	pop    %ebp
80106a1e:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80106a1f:	83 ec 0c             	sub    $0xc,%esp
80106a22:	68 66 74 10 80       	push   $0x80107466
80106a27:	e8 44 99 ff ff       	call   80100370 <panic>
80106a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106a30 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80106a30:	55                   	push   %ebp
80106a31:	89 e5                	mov    %esp,%ebp
80106a33:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80106a36:	e8 25 cf ff ff       	call   80103960 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106a3b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106a41:	31 c9                	xor    %ecx,%ecx
80106a43:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106a48:	66 89 90 98 37 11 80 	mov    %dx,-0x7feec868(%eax)
80106a4f:	66 89 88 9a 37 11 80 	mov    %cx,-0x7feec866(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106a56:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106a5b:	31 c9                	xor    %ecx,%ecx
80106a5d:	66 89 90 a0 37 11 80 	mov    %dx,-0x7feec860(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106a64:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106a69:	66 89 88 a2 37 11 80 	mov    %cx,-0x7feec85e(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106a70:	31 c9                	xor    %ecx,%ecx
80106a72:	66 89 90 a8 37 11 80 	mov    %dx,-0x7feec858(%eax)
80106a79:	66 89 88 aa 37 11 80 	mov    %cx,-0x7feec856(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106a80:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106a85:	31 c9                	xor    %ecx,%ecx
80106a87:	66 89 90 b0 37 11 80 	mov    %dx,-0x7feec850(%eax)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106a8e:	c6 80 9c 37 11 80 00 	movb   $0x0,-0x7feec864(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106a95:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106a9a:	c6 80 9d 37 11 80 9a 	movb   $0x9a,-0x7feec863(%eax)
80106aa1:	c6 80 9e 37 11 80 cf 	movb   $0xcf,-0x7feec862(%eax)
80106aa8:	c6 80 9f 37 11 80 00 	movb   $0x0,-0x7feec861(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106aaf:	c6 80 a4 37 11 80 00 	movb   $0x0,-0x7feec85c(%eax)
80106ab6:	c6 80 a5 37 11 80 92 	movb   $0x92,-0x7feec85b(%eax)
80106abd:	c6 80 a6 37 11 80 cf 	movb   $0xcf,-0x7feec85a(%eax)
80106ac4:	c6 80 a7 37 11 80 00 	movb   $0x0,-0x7feec859(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106acb:	c6 80 ac 37 11 80 00 	movb   $0x0,-0x7feec854(%eax)
80106ad2:	c6 80 ad 37 11 80 fa 	movb   $0xfa,-0x7feec853(%eax)
80106ad9:	c6 80 ae 37 11 80 cf 	movb   $0xcf,-0x7feec852(%eax)
80106ae0:	c6 80 af 37 11 80 00 	movb   $0x0,-0x7feec851(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106ae7:	66 89 88 b2 37 11 80 	mov    %cx,-0x7feec84e(%eax)
80106aee:	c6 80 b4 37 11 80 00 	movb   $0x0,-0x7feec84c(%eax)
80106af5:	c6 80 b5 37 11 80 f2 	movb   $0xf2,-0x7feec84b(%eax)
80106afc:	c6 80 b6 37 11 80 cf 	movb   $0xcf,-0x7feec84a(%eax)
80106b03:	c6 80 b7 37 11 80 00 	movb   $0x0,-0x7feec849(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80106b0a:	05 90 37 11 80       	add    $0x80113790,%eax
80106b0f:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
80106b13:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106b17:	c1 e8 10             	shr    $0x10,%eax
80106b1a:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80106b1e:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106b21:	0f 01 10             	lgdtl  (%eax)
}
80106b24:	c9                   	leave  
80106b25:	c3                   	ret    
80106b26:	8d 76 00             	lea    0x0(%esi),%esi
80106b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b30 <switchkvm>:
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106b30:	a1 44 64 11 80       	mov    0x80116444,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106b35:	55                   	push   %ebp
80106b36:	89 e5                	mov    %esp,%ebp
80106b38:	05 00 00 00 80       	add    $0x80000000,%eax
80106b3d:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
80106b40:	5d                   	pop    %ebp
80106b41:	c3                   	ret    
80106b42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b50 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80106b50:	55                   	push   %ebp
80106b51:	89 e5                	mov    %esp,%ebp
80106b53:	57                   	push   %edi
80106b54:	56                   	push   %esi
80106b55:	53                   	push   %ebx
80106b56:	83 ec 1c             	sub    $0x1c,%esp
80106b59:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106b5c:	85 f6                	test   %esi,%esi
80106b5e:	0f 84 cd 00 00 00    	je     80106c31 <switchuvm+0xe1>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80106b64:	8b 46 08             	mov    0x8(%esi),%eax
80106b67:	85 c0                	test   %eax,%eax
80106b69:	0f 84 dc 00 00 00    	je     80106c4b <switchuvm+0xfb>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80106b6f:	8b 7e 04             	mov    0x4(%esi),%edi
80106b72:	85 ff                	test   %edi,%edi
80106b74:	0f 84 c4 00 00 00    	je     80106c3e <switchuvm+0xee>
    panic("switchuvm: no pgdir");

  pushcli();
80106b7a:	e8 f1 d8 ff ff       	call   80104470 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106b7f:	e8 5c cd ff ff       	call   801038e0 <mycpu>
80106b84:	89 c3                	mov    %eax,%ebx
80106b86:	e8 55 cd ff ff       	call   801038e0 <mycpu>
80106b8b:	89 c7                	mov    %eax,%edi
80106b8d:	e8 4e cd ff ff       	call   801038e0 <mycpu>
80106b92:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106b95:	83 c7 08             	add    $0x8,%edi
80106b98:	e8 43 cd ff ff       	call   801038e0 <mycpu>
80106b9d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106ba0:	83 c0 08             	add    $0x8,%eax
80106ba3:	ba 67 00 00 00       	mov    $0x67,%edx
80106ba8:	c1 e8 18             	shr    $0x18,%eax
80106bab:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80106bb2:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106bb9:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
80106bc0:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80106bc7:	83 c1 08             	add    $0x8,%ecx
80106bca:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106bd0:	c1 e9 10             	shr    $0x10,%ecx
80106bd3:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106bd9:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    panic("switchuvm: no pgdir");

  pushcli();
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
80106bde:	e8 fd cc ff ff       	call   801038e0 <mycpu>
80106be3:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106bea:	e8 f1 cc ff ff       	call   801038e0 <mycpu>
80106bef:	b9 10 00 00 00       	mov    $0x10,%ecx
80106bf4:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106bf8:	e8 e3 cc ff ff       	call   801038e0 <mycpu>
80106bfd:	8b 56 08             	mov    0x8(%esi),%edx
80106c00:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80106c06:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106c09:	e8 d2 cc ff ff       	call   801038e0 <mycpu>
80106c0e:	66 89 58 6e          	mov    %bx,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
80106c12:	b8 28 00 00 00       	mov    $0x28,%eax
80106c17:	0f 00 d8             	ltr    %ax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106c1a:	8b 46 04             	mov    0x4(%esi),%eax
80106c1d:	05 00 00 00 80       	add    $0x80000000,%eax
80106c22:	0f 22 d8             	mov    %eax,%cr3
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
80106c25:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c28:	5b                   	pop    %ebx
80106c29:	5e                   	pop    %esi
80106c2a:	5f                   	pop    %edi
80106c2b:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
80106c2c:	e9 2f d9 ff ff       	jmp    80104560 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
80106c31:	83 ec 0c             	sub    $0xc,%esp
80106c34:	68 de 7a 10 80       	push   $0x80107ade
80106c39:	e8 32 97 ff ff       	call   80100370 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
80106c3e:	83 ec 0c             	sub    $0xc,%esp
80106c41:	68 09 7b 10 80       	push   $0x80107b09
80106c46:	e8 25 97 ff ff       	call   80100370 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
80106c4b:	83 ec 0c             	sub    $0xc,%esp
80106c4e:	68 f4 7a 10 80       	push   $0x80107af4
80106c53:	e8 18 97 ff ff       	call   80100370 <panic>
80106c58:	90                   	nop
80106c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106c60 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106c60:	55                   	push   %ebp
80106c61:	89 e5                	mov    %esp,%ebp
80106c63:	57                   	push   %edi
80106c64:	56                   	push   %esi
80106c65:	53                   	push   %ebx
80106c66:	83 ec 1c             	sub    $0x1c,%esp
80106c69:	8b 75 10             	mov    0x10(%ebp),%esi
80106c6c:	8b 45 08             	mov    0x8(%ebp),%eax
80106c6f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80106c72:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106c78:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80106c7b:	77 49                	ja     80106cc6 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
80106c7d:	e8 0e ba ff ff       	call   80102690 <kalloc>
  memset(mem, 0, PGSIZE);
80106c82:	83 ec 04             	sub    $0x4,%esp
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80106c85:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106c87:	68 00 10 00 00       	push   $0x1000
80106c8c:	6a 00                	push   $0x0
80106c8e:	50                   	push   %eax
80106c8f:	e8 8c d9 ff ff       	call   80104620 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106c94:	58                   	pop    %eax
80106c95:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106c9b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106ca0:	5a                   	pop    %edx
80106ca1:	6a 06                	push   $0x6
80106ca3:	50                   	push   %eax
80106ca4:	31 d2                	xor    %edx,%edx
80106ca6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106ca9:	e8 52 fc ff ff       	call   80106900 <mappages>
  memmove(mem, init, sz);
80106cae:	89 75 10             	mov    %esi,0x10(%ebp)
80106cb1:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106cb4:	83 c4 10             	add    $0x10,%esp
80106cb7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106cba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106cbd:	5b                   	pop    %ebx
80106cbe:	5e                   	pop    %esi
80106cbf:	5f                   	pop    %edi
80106cc0:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80106cc1:	e9 0a da ff ff       	jmp    801046d0 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80106cc6:	83 ec 0c             	sub    $0xc,%esp
80106cc9:	68 1d 7b 10 80       	push   $0x80107b1d
80106cce:	e8 9d 96 ff ff       	call   80100370 <panic>
80106cd3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ce0 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80106ce0:	55                   	push   %ebp
80106ce1:	89 e5                	mov    %esp,%ebp
80106ce3:	57                   	push   %edi
80106ce4:	56                   	push   %esi
80106ce5:	53                   	push   %ebx
80106ce6:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80106ce9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106cf0:	0f 85 91 00 00 00    	jne    80106d87 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80106cf6:	8b 75 18             	mov    0x18(%ebp),%esi
80106cf9:	31 db                	xor    %ebx,%ebx
80106cfb:	85 f6                	test   %esi,%esi
80106cfd:	75 1a                	jne    80106d19 <loaduvm+0x39>
80106cff:	eb 6f                	jmp    80106d70 <loaduvm+0x90>
80106d01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d08:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d0e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106d14:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106d17:	76 57                	jbe    80106d70 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106d19:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d1c:	8b 45 08             	mov    0x8(%ebp),%eax
80106d1f:	31 c9                	xor    %ecx,%ecx
80106d21:	01 da                	add    %ebx,%edx
80106d23:	e8 58 fb ff ff       	call   80106880 <walkpgdir>
80106d28:	85 c0                	test   %eax,%eax
80106d2a:	74 4e                	je     80106d7a <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106d2c:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106d2e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
80106d31:	bf 00 10 00 00       	mov    $0x1000,%edi
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106d36:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106d3b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106d41:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106d44:	01 d9                	add    %ebx,%ecx
80106d46:	05 00 00 00 80       	add    $0x80000000,%eax
80106d4b:	57                   	push   %edi
80106d4c:	51                   	push   %ecx
80106d4d:	50                   	push   %eax
80106d4e:	ff 75 10             	pushl  0x10(%ebp)
80106d51:	e8 fa ad ff ff       	call   80101b50 <readi>
80106d56:	83 c4 10             	add    $0x10,%esp
80106d59:	39 c7                	cmp    %eax,%edi
80106d5b:	74 ab                	je     80106d08 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80106d5d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80106d60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80106d65:	5b                   	pop    %ebx
80106d66:	5e                   	pop    %esi
80106d67:	5f                   	pop    %edi
80106d68:	5d                   	pop    %ebp
80106d69:	c3                   	ret    
80106d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d70:	8d 65 f4             	lea    -0xc(%ebp),%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80106d73:	31 c0                	xor    %eax,%eax
}
80106d75:	5b                   	pop    %ebx
80106d76:	5e                   	pop    %esi
80106d77:	5f                   	pop    %edi
80106d78:	5d                   	pop    %ebp
80106d79:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80106d7a:	83 ec 0c             	sub    $0xc,%esp
80106d7d:	68 37 7b 10 80       	push   $0x80107b37
80106d82:	e8 e9 95 ff ff       	call   80100370 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80106d87:	83 ec 0c             	sub    $0xc,%esp
80106d8a:	68 d8 7b 10 80       	push   $0x80107bd8
80106d8f:	e8 dc 95 ff ff       	call   80100370 <panic>
80106d94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106da0 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106da0:	55                   	push   %ebp
80106da1:	89 e5                	mov    %esp,%ebp
80106da3:	57                   	push   %edi
80106da4:	56                   	push   %esi
80106da5:	53                   	push   %ebx
80106da6:	83 ec 0c             	sub    $0xc,%esp
80106da9:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80106dac:	85 ff                	test   %edi,%edi
80106dae:	0f 88 ca 00 00 00    	js     80106e7e <allocuvm+0xde>
    return 0;
  if(newsz < oldsz)
80106db4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80106db7:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
80106dba:	0f 82 82 00 00 00    	jb     80106e42 <allocuvm+0xa2>
    return oldsz;

  a = PGROUNDUP(oldsz);
80106dc0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106dc6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106dcc:	39 df                	cmp    %ebx,%edi
80106dce:	77 43                	ja     80106e13 <allocuvm+0x73>
80106dd0:	e9 bb 00 00 00       	jmp    80106e90 <allocuvm+0xf0>
80106dd5:	8d 76 00             	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80106dd8:	83 ec 04             	sub    $0x4,%esp
80106ddb:	68 00 10 00 00       	push   $0x1000
80106de0:	6a 00                	push   $0x0
80106de2:	50                   	push   %eax
80106de3:	e8 38 d8 ff ff       	call   80104620 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106de8:	58                   	pop    %eax
80106de9:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106def:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106df4:	5a                   	pop    %edx
80106df5:	6a 06                	push   $0x6
80106df7:	50                   	push   %eax
80106df8:	89 da                	mov    %ebx,%edx
80106dfa:	8b 45 08             	mov    0x8(%ebp),%eax
80106dfd:	e8 fe fa ff ff       	call   80106900 <mappages>
80106e02:	83 c4 10             	add    $0x10,%esp
80106e05:	85 c0                	test   %eax,%eax
80106e07:	78 47                	js     80106e50 <allocuvm+0xb0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106e09:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106e0f:	39 df                	cmp    %ebx,%edi
80106e11:	76 7d                	jbe    80106e90 <allocuvm+0xf0>
    mem = kalloc();
80106e13:	e8 78 b8 ff ff       	call   80102690 <kalloc>
    if(mem == 0){
80106e18:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
80106e1a:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106e1c:	75 ba                	jne    80106dd8 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
80106e1e:	83 ec 0c             	sub    $0xc,%esp
80106e21:	68 55 7b 10 80       	push   $0x80107b55
80106e26:	e8 55 98 ff ff       	call   80100680 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106e2b:	83 c4 10             	add    $0x10,%esp
80106e2e:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106e31:	76 4b                	jbe    80106e7e <allocuvm+0xde>
80106e33:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106e36:	8b 45 08             	mov    0x8(%ebp),%eax
80106e39:	89 fa                	mov    %edi,%edx
80106e3b:	e8 50 fb ff ff       	call   80106990 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80106e40:	31 c0                	xor    %eax,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106e42:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e45:	5b                   	pop    %ebx
80106e46:	5e                   	pop    %esi
80106e47:	5f                   	pop    %edi
80106e48:	5d                   	pop    %ebp
80106e49:	c3                   	ret    
80106e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80106e50:	83 ec 0c             	sub    $0xc,%esp
80106e53:	68 6d 7b 10 80       	push   $0x80107b6d
80106e58:	e8 23 98 ff ff       	call   80100680 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106e5d:	83 c4 10             	add    $0x10,%esp
80106e60:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106e63:	76 0d                	jbe    80106e72 <allocuvm+0xd2>
80106e65:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106e68:	8b 45 08             	mov    0x8(%ebp),%eax
80106e6b:	89 fa                	mov    %edi,%edx
80106e6d:	e8 1e fb ff ff       	call   80106990 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80106e72:	83 ec 0c             	sub    $0xc,%esp
80106e75:	56                   	push   %esi
80106e76:	e8 65 b6 ff ff       	call   801024e0 <kfree>
      return 0;
80106e7b:	83 c4 10             	add    $0x10,%esp
    }
  }
  return newsz;
}
80106e7e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80106e81:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
80106e83:	5b                   	pop    %ebx
80106e84:	5e                   	pop    %esi
80106e85:	5f                   	pop    %edi
80106e86:	5d                   	pop    %ebp
80106e87:	c3                   	ret    
80106e88:	90                   	nop
80106e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e90:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106e93:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106e95:	5b                   	pop    %ebx
80106e96:	5e                   	pop    %esi
80106e97:	5f                   	pop    %edi
80106e98:	5d                   	pop    %ebp
80106e99:	c3                   	ret    
80106e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106ea0 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106ea0:	55                   	push   %ebp
80106ea1:	89 e5                	mov    %esp,%ebp
80106ea3:	8b 55 0c             	mov    0xc(%ebp),%edx
80106ea6:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106ea9:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106eac:	39 d1                	cmp    %edx,%ecx
80106eae:	73 10                	jae    80106ec0 <deallocuvm+0x20>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106eb0:	5d                   	pop    %ebp
80106eb1:	e9 da fa ff ff       	jmp    80106990 <deallocuvm.part.0>
80106eb6:	8d 76 00             	lea    0x0(%esi),%esi
80106eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106ec0:	89 d0                	mov    %edx,%eax
80106ec2:	5d                   	pop    %ebp
80106ec3:	c3                   	ret    
80106ec4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106eca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106ed0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106ed0:	55                   	push   %ebp
80106ed1:	89 e5                	mov    %esp,%ebp
80106ed3:	57                   	push   %edi
80106ed4:	56                   	push   %esi
80106ed5:	53                   	push   %ebx
80106ed6:	83 ec 0c             	sub    $0xc,%esp
80106ed9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106edc:	85 f6                	test   %esi,%esi
80106ede:	74 59                	je     80106f39 <freevm+0x69>
80106ee0:	31 c9                	xor    %ecx,%ecx
80106ee2:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106ee7:	89 f0                	mov    %esi,%eax
80106ee9:	e8 a2 fa ff ff       	call   80106990 <deallocuvm.part.0>
80106eee:	89 f3                	mov    %esi,%ebx
80106ef0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106ef6:	eb 0f                	jmp    80106f07 <freevm+0x37>
80106ef8:	90                   	nop
80106ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f00:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106f03:	39 fb                	cmp    %edi,%ebx
80106f05:	74 23                	je     80106f2a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106f07:	8b 03                	mov    (%ebx),%eax
80106f09:	a8 01                	test   $0x1,%al
80106f0b:	74 f3                	je     80106f00 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
80106f0d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106f12:	83 ec 0c             	sub    $0xc,%esp
80106f15:	83 c3 04             	add    $0x4,%ebx
80106f18:	05 00 00 00 80       	add    $0x80000000,%eax
80106f1d:	50                   	push   %eax
80106f1e:	e8 bd b5 ff ff       	call   801024e0 <kfree>
80106f23:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106f26:	39 fb                	cmp    %edi,%ebx
80106f28:	75 dd                	jne    80106f07 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106f2a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106f2d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f30:	5b                   	pop    %ebx
80106f31:	5e                   	pop    %esi
80106f32:	5f                   	pop    %edi
80106f33:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106f34:	e9 a7 b5 ff ff       	jmp    801024e0 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80106f39:	83 ec 0c             	sub    $0xc,%esp
80106f3c:	68 89 7b 10 80       	push   $0x80107b89
80106f41:	e8 2a 94 ff ff       	call   80100370 <panic>
80106f46:	8d 76 00             	lea    0x0(%esi),%esi
80106f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f50 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80106f50:	55                   	push   %ebp
80106f51:	89 e5                	mov    %esp,%ebp
80106f53:	56                   	push   %esi
80106f54:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80106f55:	e8 36 b7 ff ff       	call   80102690 <kalloc>
80106f5a:	85 c0                	test   %eax,%eax
80106f5c:	74 6a                	je     80106fc8 <setupkvm+0x78>
    return 0;
  memset(pgdir, 0, PGSIZE);
80106f5e:	83 ec 04             	sub    $0x4,%esp
80106f61:	89 c6                	mov    %eax,%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106f63:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
80106f68:	68 00 10 00 00       	push   $0x1000
80106f6d:	6a 00                	push   $0x0
80106f6f:	50                   	push   %eax
80106f70:	e8 ab d6 ff ff       	call   80104620 <memset>
80106f75:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106f78:	8b 43 04             	mov    0x4(%ebx),%eax
80106f7b:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106f7e:	83 ec 08             	sub    $0x8,%esp
80106f81:	8b 13                	mov    (%ebx),%edx
80106f83:	ff 73 0c             	pushl  0xc(%ebx)
80106f86:	50                   	push   %eax
80106f87:	29 c1                	sub    %eax,%ecx
80106f89:	89 f0                	mov    %esi,%eax
80106f8b:	e8 70 f9 ff ff       	call   80106900 <mappages>
80106f90:	83 c4 10             	add    $0x10,%esp
80106f93:	85 c0                	test   %eax,%eax
80106f95:	78 19                	js     80106fb0 <setupkvm+0x60>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106f97:	83 c3 10             	add    $0x10,%ebx
80106f9a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106fa0:	75 d6                	jne    80106f78 <setupkvm+0x28>
80106fa2:	89 f0                	mov    %esi,%eax
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
80106fa4:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106fa7:	5b                   	pop    %ebx
80106fa8:	5e                   	pop    %esi
80106fa9:	5d                   	pop    %ebp
80106faa:	c3                   	ret    
80106fab:	90                   	nop
80106fac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
80106fb0:	83 ec 0c             	sub    $0xc,%esp
80106fb3:	56                   	push   %esi
80106fb4:	e8 17 ff ff ff       	call   80106ed0 <freevm>
      return 0;
80106fb9:	83 c4 10             	add    $0x10,%esp
    }
  return pgdir;
}
80106fbc:	8d 65 f8             	lea    -0x8(%ebp),%esp
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
80106fbf:	31 c0                	xor    %eax,%eax
    }
  return pgdir;
}
80106fc1:	5b                   	pop    %ebx
80106fc2:	5e                   	pop    %esi
80106fc3:	5d                   	pop    %ebp
80106fc4:	c3                   	ret    
80106fc5:	8d 76 00             	lea    0x0(%esi),%esi
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80106fc8:	31 c0                	xor    %eax,%eax
80106fca:	eb d8                	jmp    80106fa4 <setupkvm+0x54>
80106fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106fd0 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80106fd0:	55                   	push   %ebp
80106fd1:	89 e5                	mov    %esp,%ebp
80106fd3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106fd6:	e8 75 ff ff ff       	call   80106f50 <setupkvm>
80106fdb:	a3 44 64 11 80       	mov    %eax,0x80116444
80106fe0:	05 00 00 00 80       	add    $0x80000000,%eax
80106fe5:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
80106fe8:	c9                   	leave  
80106fe9:	c3                   	ret    
80106fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106ff0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106ff0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106ff1:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106ff3:	89 e5                	mov    %esp,%ebp
80106ff5:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106ff8:	8b 55 0c             	mov    0xc(%ebp),%edx
80106ffb:	8b 45 08             	mov    0x8(%ebp),%eax
80106ffe:	e8 7d f8 ff ff       	call   80106880 <walkpgdir>
  if(pte == 0)
80107003:	85 c0                	test   %eax,%eax
80107005:	74 05                	je     8010700c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107007:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010700a:	c9                   	leave  
8010700b:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
8010700c:	83 ec 0c             	sub    $0xc,%esp
8010700f:	68 9a 7b 10 80       	push   $0x80107b9a
80107014:	e8 57 93 ff ff       	call   80100370 <panic>
80107019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107020 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107020:	55                   	push   %ebp
80107021:	89 e5                	mov    %esp,%ebp
80107023:	57                   	push   %edi
80107024:	56                   	push   %esi
80107025:	53                   	push   %ebx
80107026:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107029:	e8 22 ff ff ff       	call   80106f50 <setupkvm>
8010702e:	85 c0                	test   %eax,%eax
80107030:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107033:	0f 84 b2 00 00 00    	je     801070eb <copyuvm+0xcb>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107039:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010703c:	85 c9                	test   %ecx,%ecx
8010703e:	0f 84 9c 00 00 00    	je     801070e0 <copyuvm+0xc0>
80107044:	31 f6                	xor    %esi,%esi
80107046:	eb 4a                	jmp    80107092 <copyuvm+0x72>
80107048:	90                   	nop
80107049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107050:	83 ec 04             	sub    $0x4,%esp
80107053:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107059:	68 00 10 00 00       	push   $0x1000
8010705e:	57                   	push   %edi
8010705f:	50                   	push   %eax
80107060:	e8 6b d6 ff ff       	call   801046d0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80107065:	58                   	pop    %eax
80107066:	5a                   	pop    %edx
80107067:	8d 93 00 00 00 80    	lea    -0x80000000(%ebx),%edx
8010706d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107070:	ff 75 e4             	pushl  -0x1c(%ebp)
80107073:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107078:	52                   	push   %edx
80107079:	89 f2                	mov    %esi,%edx
8010707b:	e8 80 f8 ff ff       	call   80106900 <mappages>
80107080:	83 c4 10             	add    $0x10,%esp
80107083:	85 c0                	test   %eax,%eax
80107085:	78 3e                	js     801070c5 <copyuvm+0xa5>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107087:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010708d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107090:	76 4e                	jbe    801070e0 <copyuvm+0xc0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107092:	8b 45 08             	mov    0x8(%ebp),%eax
80107095:	31 c9                	xor    %ecx,%ecx
80107097:	89 f2                	mov    %esi,%edx
80107099:	e8 e2 f7 ff ff       	call   80106880 <walkpgdir>
8010709e:	85 c0                	test   %eax,%eax
801070a0:	74 5a                	je     801070fc <copyuvm+0xdc>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
801070a2:	8b 18                	mov    (%eax),%ebx
801070a4:	f6 c3 01             	test   $0x1,%bl
801070a7:	74 46                	je     801070ef <copyuvm+0xcf>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
801070a9:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
801070ab:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
801070b1:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
801070b4:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
801070ba:	e8 d1 b5 ff ff       	call   80102690 <kalloc>
801070bf:	85 c0                	test   %eax,%eax
801070c1:	89 c3                	mov    %eax,%ebx
801070c3:	75 8b                	jne    80107050 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
801070c5:	83 ec 0c             	sub    $0xc,%esp
801070c8:	ff 75 e0             	pushl  -0x20(%ebp)
801070cb:	e8 00 fe ff ff       	call   80106ed0 <freevm>
  return 0;
801070d0:	83 c4 10             	add    $0x10,%esp
801070d3:	31 c0                	xor    %eax,%eax
}
801070d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070d8:	5b                   	pop    %ebx
801070d9:	5e                   	pop    %esi
801070da:	5f                   	pop    %edi
801070db:	5d                   	pop    %ebp
801070dc:	c3                   	ret    
801070dd:	8d 76 00             	lea    0x0(%esi),%esi
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801070e0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
801070e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070e6:	5b                   	pop    %ebx
801070e7:	5e                   	pop    %esi
801070e8:	5f                   	pop    %edi
801070e9:	5d                   	pop    %ebp
801070ea:	c3                   	ret    
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
801070eb:	31 c0                	xor    %eax,%eax
801070ed:	eb e6                	jmp    801070d5 <copyuvm+0xb5>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
801070ef:	83 ec 0c             	sub    $0xc,%esp
801070f2:	68 be 7b 10 80       	push   $0x80107bbe
801070f7:	e8 74 92 ff ff       	call   80100370 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
801070fc:	83 ec 0c             	sub    $0xc,%esp
801070ff:	68 a4 7b 10 80       	push   $0x80107ba4
80107104:	e8 67 92 ff ff       	call   80100370 <panic>
80107109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107110 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107110:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107111:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107113:	89 e5                	mov    %esp,%ebp
80107115:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107118:	8b 55 0c             	mov    0xc(%ebp),%edx
8010711b:	8b 45 08             	mov    0x8(%ebp),%eax
8010711e:	e8 5d f7 ff ff       	call   80106880 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107123:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80107125:	89 c2                	mov    %eax,%edx
80107127:	83 e2 05             	and    $0x5,%edx
8010712a:	83 fa 05             	cmp    $0x5,%edx
8010712d:	75 11                	jne    80107140 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
8010712f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
80107134:	c9                   	leave  
  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80107135:	05 00 00 00 80       	add    $0x80000000,%eax
}
8010713a:	c3                   	ret    
8010713b:	90                   	nop
8010713c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
80107140:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
80107142:	c9                   	leave  
80107143:	c3                   	ret    
80107144:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010714a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107150 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107150:	55                   	push   %ebp
80107151:	89 e5                	mov    %esp,%ebp
80107153:	57                   	push   %edi
80107154:	56                   	push   %esi
80107155:	53                   	push   %ebx
80107156:	83 ec 1c             	sub    $0x1c,%esp
80107159:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010715c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010715f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107162:	85 db                	test   %ebx,%ebx
80107164:	75 40                	jne    801071a6 <copyout+0x56>
80107166:	eb 70                	jmp    801071d8 <copyout+0x88>
80107168:	90                   	nop
80107169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107170:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107173:	89 f1                	mov    %esi,%ecx
80107175:	29 d1                	sub    %edx,%ecx
80107177:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010717d:	39 d9                	cmp    %ebx,%ecx
8010717f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107182:	29 f2                	sub    %esi,%edx
80107184:	83 ec 04             	sub    $0x4,%esp
80107187:	01 d0                	add    %edx,%eax
80107189:	51                   	push   %ecx
8010718a:	57                   	push   %edi
8010718b:	50                   	push   %eax
8010718c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010718f:	e8 3c d5 ff ff       	call   801046d0 <memmove>
    len -= n;
    buf += n;
80107194:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107197:	83 c4 10             	add    $0x10,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
8010719a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
801071a0:	01 cf                	add    %ecx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801071a2:	29 cb                	sub    %ecx,%ebx
801071a4:	74 32                	je     801071d8 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
801071a6:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801071a8:	83 ec 08             	sub    $0x8,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
801071ab:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801071ae:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801071b4:	56                   	push   %esi
801071b5:	ff 75 08             	pushl  0x8(%ebp)
801071b8:	e8 53 ff ff ff       	call   80107110 <uva2ka>
    if(pa0 == 0)
801071bd:	83 c4 10             	add    $0x10,%esp
801071c0:	85 c0                	test   %eax,%eax
801071c2:	75 ac                	jne    80107170 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
801071c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
801071c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
801071cc:	5b                   	pop    %ebx
801071cd:	5e                   	pop    %esi
801071ce:	5f                   	pop    %edi
801071cf:	5d                   	pop    %ebp
801071d0:	c3                   	ret    
801071d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
801071db:	31 c0                	xor    %eax,%eax
}
801071dd:	5b                   	pop    %ebx
801071de:	5e                   	pop    %esi
801071df:	5f                   	pop    %edi
801071e0:	5d                   	pop    %ebp
801071e1:	c3                   	ret    
