
_pico:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
		updatesc(0, 1, buf, TEXT_COLOR);
	}
}

int
main(int argc, char *argv[]) {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
  10:	83 ec 18             	sub    $0x18,%esp
  13:	8b 59 04             	mov    0x4(%ecx),%ebx
  16:	8b 31                	mov    (%ecx),%esi
	captsc(&c);
  18:	68 a0 13 00 00       	push   $0x13a0
  1d:	e8 20 0a 00 00       	call   a42 <captsc>
	drawHeader();
  22:	e8 29 02 00 00       	call   250 <drawHeader>
	updatesc(50, 0, "                         v0.1 ", UI_COLOR);
}

void
drawFooter() {
	updatesc(0, 24, " ^Q - Quit                                                                      ", UI_COLOR);
  27:	68 c0 00 00 00       	push   $0xc0
  2c:	68 70 0e 00 00       	push   $0xe70
  31:	6a 18                	push   $0x18
  33:	6a 00                	push   $0x0
  35:	e8 18 0a 00 00       	call   a52 <updatesc>
	captsc(&c);
	drawHeader();
	drawFooter();
	int fd;

	if (argc == 2) {
  3a:	83 c4 20             	add    $0x20,%esp
  3d:	83 fe 02             	cmp    $0x2,%esi
  40:	74 3c                	je     7e <main+0x7e>
		} else {
			initLinkedList(fd);
			printfile(head);
		}
	} else {
		printf(1, "No file selected");
  42:	83 ec 08             	sub    $0x8,%esp
  45:	68 01 0f 00 00       	push   $0xf01
  4a:	6a 01                	push   $0x1
  4c:	e8 bf 0a 00 00       	call   b10 <printf>
  51:	83 c4 10             	add    $0x10,%esp
  54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	}
	while(1) {
		while ((c = getkey()) <= 0) {
  58:	e8 fd 09 00 00       	call   a5a <getkey>
  5d:	85 c0                	test   %eax,%eax
  5f:	a3 a0 13 00 00       	mov    %eax,0x13a0
  64:	7e f2                	jle    58 <main+0x58>
		}
		handleInput(c);
  66:	83 ec 0c             	sub    $0xc,%esp
  69:	50                   	push   %eax
  6a:	e8 c1 05 00 00       	call   630 <handleInput>
		c = 0;
  6f:	c7 05 a0 13 00 00 00 	movl   $0x0,0x13a0
  76:	00 00 00 
	}
  79:	83 c4 10             	add    $0x10,%esp
  7c:	eb da                	jmp    58 <main+0x58>
	drawHeader();
	drawFooter();
	int fd;

	if (argc == 2) {
		if((fd = open(argv[1], 0)) < 0){
  7e:	83 ec 08             	sub    $0x8,%esp
  81:	6a 00                	push   $0x0
  83:	ff 73 04             	pushl  0x4(%ebx)
  86:	e8 57 09 00 00       	call   9e2 <open>
  8b:	83 c4 10             	add    $0x10,%esp
  8e:	85 c0                	test   %eax,%eax
  90:	78 1a                	js     ac <main+0xac>
			printf(1, "Cannot open %s\n", argv[1]);
		} else {
			initLinkedList(fd);
  92:	83 ec 0c             	sub    $0xc,%esp
  95:	50                   	push   %eax
  96:	e8 35 00 00 00       	call   d0 <initLinkedList>
			printfile(head);
  9b:	58                   	pop    %eax
  9c:	ff 35 cc 13 00 00    	pushl  0x13cc
  a2:	e8 e9 00 00 00       	call   190 <printfile>
  a7:	83 c4 10             	add    $0x10,%esp
  aa:	eb ac                	jmp    58 <main+0x58>
	drawFooter();
	int fd;

	if (argc == 2) {
		if((fd = open(argv[1], 0)) < 0){
			printf(1, "Cannot open %s\n", argv[1]);
  ac:	83 ec 04             	sub    $0x4,%esp
  af:	ff 73 04             	pushl  0x4(%ebx)
  b2:	68 f1 0e 00 00       	push   $0xef1
  b7:	6a 01                	push   $0x1
  b9:	e8 52 0a 00 00       	call   b10 <printf>
  be:	83 c4 10             	add    $0x10,%esp
  c1:	eb 95                	jmp    58 <main+0x58>
  c3:	66 90                	xchg   %ax,%ax
  c5:	66 90                	xchg   %ax,%ax
  c7:	66 90                	xchg   %ax,%ax
  c9:	66 90                	xchg   %ax,%ax
  cb:	66 90                	xchg   %ax,%ax
  cd:	66 90                	xchg   %ax,%ax
  cf:	90                   	nop

000000d0 <initLinkedList>:
struct fileline* lastOnScreen;
struct fileline* tail;

void
initLinkedList(int fd)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	57                   	push   %edi
  d4:	56                   	push   %esi
  d5:	53                   	push   %ebx
  d6:	8d 75 e7             	lea    -0x19(%ebp),%esi
	int n;
	char singlechar[1];
	head = malloc(sizeof(struct fileline));
	struct fileline* cur = head;
	int linecounter = 0;
  d9:	31 ff                	xor    %edi,%edi
struct fileline* lastOnScreen;
struct fileline* tail;

void
initLinkedList(int fd)
{
  db:	83 ec 38             	sub    $0x38,%esp
	int n;
	char singlechar[1];
	head = malloc(sizeof(struct fileline));
  de:	6a 5c                	push   $0x5c
  e0:	e8 5b 0c 00 00       	call   d40 <malloc>
	struct fileline* cur = head;
	int linecounter = 0;
	int linenumber = 0;

	while((n = read(fd, singlechar, 1)) > 0) {
  e5:	83 c4 10             	add    $0x10,%esp
void
initLinkedList(int fd)
{
	int n;
	char singlechar[1];
	head = malloc(sizeof(struct fileline));
  e8:	89 c3                	mov    %eax,%ebx
  ea:	a3 cc 13 00 00       	mov    %eax,0x13cc
	struct fileline* cur = head;
	int linecounter = 0;
	int linenumber = 0;
  ef:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  f6:	8d 76 00             	lea    0x0(%esi),%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

	while((n = read(fd, singlechar, 1)) > 0) {
 100:	83 ec 04             	sub    $0x4,%esp
 103:	6a 01                	push   $0x1
 105:	56                   	push   %esi
 106:	ff 75 08             	pushl  0x8(%ebp)
 109:	e8 ac 08 00 00       	call   9ba <read>
 10e:	83 c4 10             	add    $0x10,%esp
 111:	85 c0                	test   %eax,%eax
 113:	7e 5b                	jle    170 <initLinkedList+0xa0>
		if(linecounter < WIDTH){
 115:	83 ff 50             	cmp    $0x50,%edi
 118:	74 1e                	je     138 <initLinkedList+0x68>
			cur->line[linecounter] = singlechar[0];
 11a:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 11e:	88 44 3b 04          	mov    %al,0x4(%ebx,%edi,1)
			linecounter++;
 122:	83 c7 01             	add    $0x1,%edi
 125:	3c 0a                	cmp    $0xa,%al
 127:	b8 50 00 00 00       	mov    $0x50,%eax
 12c:	0f 44 f8             	cmove  %eax,%edi
 12f:	eb cf                	jmp    100 <initLinkedList+0x30>
 131:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			if(singlechar[0] == '\n'){
				linecounter = WIDTH;
			}
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
 138:	83 ec 0c             	sub    $0xc,%esp
			nextline->prev = cur;
			cur->next = nextline;
			cur = nextline;
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
			linecounter++;
 13b:	bf 01 00 00 00       	mov    $0x1,%edi
			if(singlechar[0] == '\n'){
				linecounter = WIDTH;
			}
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
 140:	6a 5c                	push   $0x5c
 142:	e8 f9 0b 00 00       	call   d40 <malloc>
			cur->filelinenum = linenumber;
 147:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
			linecounter++;
			// int nmbr = (int)(cur->filelinenum);
			// printf(1, "linenum: %d\n", nmbr);
			linenumber++;
 14a:	83 c4 10             	add    $0x10,%esp
				linecounter = WIDTH;
			}
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
			cur->filelinenum = linenumber;
 14d:	89 0b                	mov    %ecx,(%ebx)
			nextline->prev = cur;
			cur->next = nextline;
			cur = nextline;
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
 14f:	0f b6 55 e7          	movzbl -0x19(%ebp),%edx
			linecounter++;
			// int nmbr = (int)(cur->filelinenum);
			// printf(1, "linenum: %d\n", nmbr);
			linenumber++;
 153:	83 c1 01             	add    $0x1,%ecx
			}
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
			cur->filelinenum = linenumber;
			nextline->prev = cur;
 156:	89 58 54             	mov    %ebx,0x54(%eax)
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
			linecounter++;
			// int nmbr = (int)(cur->filelinenum);
			// printf(1, "linenum: %d\n", nmbr);
			linenumber++;
 159:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
			cur->filelinenum = linenumber;
			nextline->prev = cur;
			cur->next = nextline;
 15c:	89 43 58             	mov    %eax,0x58(%ebx)
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
			linecounter++;
			// int nmbr = (int)(cur->filelinenum);
			// printf(1, "linenum: %d\n", nmbr);
			linenumber++;
 15f:	89 c3                	mov    %eax,%ebx
			cur->filelinenum = linenumber;
			nextline->prev = cur;
			cur->next = nextline;
			cur = nextline;
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
 161:	88 50 04             	mov    %dl,0x4(%eax)
 164:	eb 9a                	jmp    100 <initLinkedList+0x30>
 166:	8d 76 00             	lea    0x0(%esi),%esi
 169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
			// int nmbr = (int)(cur->filelinenum);
			// printf(1, "linenum: %d\n", nmbr);
			linenumber++;
		}
	}
	cur->filelinenum = linenumber;
 170:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 173:	89 03                	mov    %eax,(%ebx)

	firstOnScreen = head;
 175:	a1 cc 13 00 00       	mov    0x13cc,%eax
	tail = cur;
 17a:	89 1d c8 13 00 00    	mov    %ebx,0x13c8
			linenumber++;
		}
	}
	cur->filelinenum = linenumber;

	firstOnScreen = head;
 180:	a3 c0 13 00 00       	mov    %eax,0x13c0
	// 	printf(1, "%s", cur->line);
	// 	cur = cur->next;
	// }
	// printf(1, "%s", tail->line);

}
 185:	8d 65 f4             	lea    -0xc(%ebp),%esp
 188:	5b                   	pop    %ebx
 189:	5e                   	pop    %esi
 18a:	5f                   	pop    %edi
 18b:	5d                   	pop    %ebp
 18c:	c3                   	ret    
 18d:	8d 76 00             	lea    0x0(%esi),%esi

00000190 <printfile>:

void
printfile(struct fileline* first)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	53                   	push   %ebx
	struct fileline* cur = first;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
 194:	31 db                	xor    %ebx,%ebx

}

void
printfile(struct fileline* first)
{
 196:	83 ec 04             	sub    $0x4,%esp
 199:	8b 4d 08             	mov    0x8(%ebp),%ecx
	struct fileline* cur = first;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
 19c:	8b 51 58             	mov    0x58(%ecx),%edx
 19f:	85 d2                	test   %edx,%edx
 1a1:	74 4a                	je     1ed <printfile+0x5d>
 1a3:	90                   	nop
 1a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1a8:	31 c0                	xor    %eax,%eax
 1aa:	eb 14                	jmp    1c0 <printfile+0x30>
 1ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		for(int i=0; i<WIDTH; i++){
			if(cur->line[i] == '\0'){
				buf[bufindex] = ' ';
 1b0:	c6 84 03 e0 13 00 00 	movb   $0x20,0x13e0(%ebx,%eax,1)
 1b7:	20 
printfile(struct fileline* first)
{
	struct fileline* cur = first;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
		for(int i=0; i<WIDTH; i++){
 1b8:	83 c0 01             	add    $0x1,%eax
 1bb:	83 f8 50             	cmp    $0x50,%eax
 1be:	74 18                	je     1d8 <printfile+0x48>
			if(cur->line[i] == '\0'){
 1c0:	0f b6 54 01 04       	movzbl 0x4(%ecx,%eax,1),%edx
 1c5:	84 d2                	test   %dl,%dl
 1c7:	74 e7                	je     1b0 <printfile+0x20>
				buf[bufindex] = ' ';
			} else{
				buf[bufindex] = cur->line[i];
 1c9:	88 94 03 e0 13 00 00 	mov    %dl,0x13e0(%ebx,%eax,1)
printfile(struct fileline* first)
{
	struct fileline* cur = first;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
		for(int i=0; i<WIDTH; i++){
 1d0:	83 c0 01             	add    $0x1,%eax
 1d3:	83 f8 50             	cmp    $0x50,%eax
 1d6:	75 e8                	jne    1c0 <printfile+0x30>
			} else{
				buf[bufindex] = cur->line[i];
			}
			bufindex++;
		}
		cur = cur->next;
 1d8:	8b 49 58             	mov    0x58(%ecx),%ecx
 1db:	83 c3 50             	add    $0x50,%ebx
void
printfile(struct fileline* first)
{
	struct fileline* cur = first;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
 1de:	8b 41 58             	mov    0x58(%ecx),%eax
 1e1:	85 c0                	test   %eax,%eax
 1e3:	74 08                	je     1ed <printfile+0x5d>
 1e5:	81 fb e0 06 00 00    	cmp    $0x6e0,%ebx
 1eb:	75 bb                	jne    1a8 <printfile+0x18>

void
printfile(struct fileline* first)
{
	struct fileline* cur = first;
	int bufindex = 0;
 1ed:	31 c0                	xor    %eax,%eax
 1ef:	eb 17                	jmp    208 <printfile+0x78>
 1f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		}
		cur = cur->next;
	}
	for(int i=0; i<WIDTH; i++){
			if(cur->line[i] == '\0'){
				buf[bufindex] = ' ';
 1f8:	c6 84 03 e0 13 00 00 	movb   $0x20,0x13e0(%ebx,%eax,1)
 1ff:	20 
			}
			bufindex++;
		}
		cur = cur->next;
	}
	for(int i=0; i<WIDTH; i++){
 200:	83 c0 01             	add    $0x1,%eax
 203:	83 f8 50             	cmp    $0x50,%eax
 206:	74 18                	je     220 <printfile+0x90>
			if(cur->line[i] == '\0'){
 208:	0f b6 54 01 04       	movzbl 0x4(%ecx,%eax,1),%edx
 20d:	84 d2                	test   %dl,%dl
 20f:	74 e7                	je     1f8 <printfile+0x68>
				buf[bufindex] = ' ';
			} else{
				buf[bufindex] = cur->line[i];
 211:	88 94 03 e0 13 00 00 	mov    %dl,0x13e0(%ebx,%eax,1)
			}
			bufindex++;
		}
		cur = cur->next;
	}
	for(int i=0; i<WIDTH; i++){
 218:	83 c0 01             	add    $0x1,%eax
 21b:	83 f8 50             	cmp    $0x50,%eax
 21e:	75 e8                	jne    208 <printfile+0x78>
	}
	lastOnScreen = cur;

	buf[bufindex] = '\0';
	//printf(1, "%s\n", buf);
	updatesc(0, 1, buf, TEXT_COLOR);
 220:	6a 07                	push   $0x7
 222:	68 e0 13 00 00       	push   $0x13e0
 227:	6a 01                	push   $0x1
 229:	6a 00                	push   $0x0
			}
			bufindex++;
	}
	lastOnScreen = cur;

	buf[bufindex] = '\0';
 22b:	c6 83 30 14 00 00 00 	movb   $0x0,0x1430(%ebx)
			} else{
				buf[bufindex] = cur->line[i];
			}
			bufindex++;
	}
	lastOnScreen = cur;
 232:	89 0d c4 13 00 00    	mov    %ecx,0x13c4

	buf[bufindex] = '\0';
	//printf(1, "%s\n", buf);
	updatesc(0, 1, buf, TEXT_COLOR);
 238:	e8 15 08 00 00       	call   a52 <updatesc>
}
 23d:	83 c4 10             	add    $0x10,%esp
 240:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 243:	c9                   	leave  
 244:	c3                   	ret    
 245:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <drawHeader>:

void
drawHeader() {
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	83 ec 08             	sub    $0x8,%esp
	updatesc(0, 0, "                              ", UI_COLOR);
 256:	68 c0 00 00 00       	push   $0xc0
 25b:	68 30 0e 00 00       	push   $0xe30
 260:	6a 00                	push   $0x0
 262:	6a 00                	push   $0x0
 264:	e8 e9 07 00 00       	call   a52 <updatesc>
	updatesc(30, 0, "        PICO        ", UI_COLOR);
 269:	68 c0 00 00 00       	push   $0xc0
 26e:	68 c4 0e 00 00       	push   $0xec4
 273:	6a 00                	push   $0x0
 275:	6a 1e                	push   $0x1e
 277:	e8 d6 07 00 00       	call   a52 <updatesc>
	updatesc(50, 0, "                         v0.1 ", UI_COLOR);
 27c:	83 c4 20             	add    $0x20,%esp
 27f:	68 c0 00 00 00       	push   $0xc0
 284:	68 50 0e 00 00       	push   $0xe50
 289:	6a 00                	push   $0x0
 28b:	6a 32                	push   $0x32
 28d:	e8 c0 07 00 00       	call   a52 <updatesc>
}
 292:	83 c4 10             	add    $0x10,%esp
 295:	c9                   	leave  
 296:	c3                   	ret    
 297:	89 f6                	mov    %esi,%esi
 299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002a0 <drawFooter>:

void
drawFooter() {
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	83 ec 08             	sub    $0x8,%esp
	updatesc(0, 24, " ^Q - Quit                                                                      ", UI_COLOR);
 2a6:	68 c0 00 00 00       	push   $0xc0
 2ab:	68 70 0e 00 00       	push   $0xe70
 2b0:	6a 18                	push   $0x18
 2b2:	6a 00                	push   $0x0
 2b4:	e8 99 07 00 00       	call   a52 <updatesc>
}
 2b9:	83 c4 10             	add    $0x10,%esp
 2bc:	c9                   	leave  
 2bd:	c3                   	ret    
 2be:	66 90                	xchg   %ax,%ax

000002c0 <saveedits>:

void
saveedits(void){
 2c0:	55                   	push   %ebp
	//Save edits
	struct fileline* cur = firstOnScreen;
 2c1:	8b 0d c0 13 00 00    	mov    0x13c0,%ecx
drawFooter() {
	updatesc(0, 24, " ^Q - Quit                                                                      ", UI_COLOR);
}

void
saveedits(void){
 2c7:	89 e5                	mov    %esp,%ebp
 2c9:	56                   	push   %esi
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
 2ca:	8b 35 c4 13 00 00    	mov    0x13c4,%esi
drawFooter() {
	updatesc(0, 24, " ^Q - Quit                                                                      ", UI_COLOR);
}

void
saveedits(void){
 2d0:	53                   	push   %ebx
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
 2d1:	3b 4e 58             	cmp    0x58(%esi),%ecx
 2d4:	74 31                	je     307 <saveedits+0x47>
 2d6:	31 db                	xor    %ebx,%ebx
 2d8:	90                   	nop
 2d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2e0:	31 c0                	xor    %eax,%eax
 2e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		for(int i=0; i<WIDTH; i++){
			cur->line[i] = buf[bufindex];
 2e8:	0f b6 94 03 e0 13 00 	movzbl 0x13e0(%ebx,%eax,1),%edx
 2ef:	00 
 2f0:	88 54 01 04          	mov    %dl,0x4(%ecx,%eax,1)
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
		for(int i=0; i<WIDTH; i++){
 2f4:	83 c0 01             	add    $0x1,%eax
 2f7:	83 f8 50             	cmp    $0x50,%eax
 2fa:	75 ec                	jne    2e8 <saveedits+0x28>
 2fc:	83 c3 50             	add    $0x50,%ebx
			cur->line[i] = buf[bufindex];
			bufindex++;
		}
		cur = cur->next;
 2ff:	8b 49 58             	mov    0x58(%ecx),%ecx
void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
 302:	39 4e 58             	cmp    %ecx,0x58(%esi)
 305:	75 d9                	jne    2e0 <saveedits+0x20>
			cur->line[i] = buf[bufindex];
			bufindex++;
		}
		cur = cur->next;
	}
}
 307:	5b                   	pop    %ebx
 308:	5e                   	pop    %esi
 309:	5d                   	pop    %ebp
 30a:	c3                   	ret    
 30b:	90                   	nop
 30c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000310 <scrolldown>:

void
scrolldown(void){
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	57                   	push   %edi
 314:	56                   	push   %esi
 315:	53                   	push   %ebx
 316:	31 db                	xor    %ebx,%ebx
 318:	83 ec 0c             	sub    $0xc,%esp
void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
 31b:	8b 35 c4 13 00 00    	mov    0x13c4,%esi
}

void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
 321:	8b 3d c0 13 00 00    	mov    0x13c0,%edi
	int bufindex = 0;
	while(cur != lastOnScreen->next){
 327:	39 7e 58             	cmp    %edi,0x58(%esi)
 32a:	89 f9                	mov    %edi,%ecx
 32c:	74 29                	je     357 <scrolldown+0x47>
 32e:	66 90                	xchg   %ax,%ax
 330:	31 c0                	xor    %eax,%eax
 332:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		for(int i=0; i<WIDTH; i++){
			cur->line[i] = buf[bufindex];
 338:	0f b6 94 03 e0 13 00 	movzbl 0x13e0(%ebx,%eax,1),%edx
 33f:	00 
 340:	88 54 01 04          	mov    %dl,0x4(%ecx,%eax,1)
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
		for(int i=0; i<WIDTH; i++){
 344:	83 c0 01             	add    $0x1,%eax
 347:	83 f8 50             	cmp    $0x50,%eax
 34a:	75 ec                	jne    338 <scrolldown+0x28>
 34c:	83 c3 50             	add    $0x50,%ebx
			cur->line[i] = buf[bufindex];
			bufindex++;
		}
		cur = cur->next;
 34f:	8b 49 58             	mov    0x58(%ecx),%ecx
void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
 352:	3b 4e 58             	cmp    0x58(%esi),%ecx
 355:	75 d9                	jne    330 <scrolldown+0x20>
}

void
scrolldown(void){
	saveedits();
	printfile(firstOnScreen->next);
 357:	83 ec 0c             	sub    $0xc,%esp
 35a:	ff 77 58             	pushl  0x58(%edi)
 35d:	e8 2e fe ff ff       	call   190 <printfile>
	firstOnScreen = firstOnScreen->next;
 362:	a1 c0 13 00 00       	mov    0x13c0,%eax
 367:	8b 40 58             	mov    0x58(%eax),%eax
 36a:	a3 c0 13 00 00       	mov    %eax,0x13c0
}
 36f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 372:	5b                   	pop    %ebx
 373:	5e                   	pop    %esi
 374:	5f                   	pop    %edi
 375:	5d                   	pop    %ebp
 376:	c3                   	ret    
 377:	89 f6                	mov    %esi,%esi
 379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000380 <scrollup>:

void
scrollup(void){
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	56                   	push   %esi
 385:	53                   	push   %ebx
 386:	31 db                	xor    %ebx,%ebx
 388:	83 ec 0c             	sub    $0xc,%esp
void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
 38b:	8b 35 c4 13 00 00    	mov    0x13c4,%esi
}

void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
 391:	8b 3d c0 13 00 00    	mov    0x13c0,%edi
	int bufindex = 0;
	while(cur != lastOnScreen->next){
 397:	39 7e 58             	cmp    %edi,0x58(%esi)
 39a:	89 f9                	mov    %edi,%ecx
 39c:	74 29                	je     3c7 <scrollup+0x47>
 39e:	66 90                	xchg   %ax,%ax
 3a0:	31 c0                	xor    %eax,%eax
 3a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		for(int i=0; i<WIDTH; i++){
			cur->line[i] = buf[bufindex];
 3a8:	0f b6 94 03 e0 13 00 	movzbl 0x13e0(%ebx,%eax,1),%edx
 3af:	00 
 3b0:	88 54 01 04          	mov    %dl,0x4(%ecx,%eax,1)
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
		for(int i=0; i<WIDTH; i++){
 3b4:	83 c0 01             	add    $0x1,%eax
 3b7:	83 f8 50             	cmp    $0x50,%eax
 3ba:	75 ec                	jne    3a8 <scrollup+0x28>
 3bc:	83 c3 50             	add    $0x50,%ebx
			cur->line[i] = buf[bufindex];
			bufindex++;
		}
		cur = cur->next;
 3bf:	8b 49 58             	mov    0x58(%ecx),%ecx
void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
 3c2:	3b 4e 58             	cmp    0x58(%esi),%ecx
 3c5:	75 d9                	jne    3a0 <scrollup+0x20>
}

void
scrollup(void){
	saveedits();
	printfile(firstOnScreen->prev);
 3c7:	83 ec 0c             	sub    $0xc,%esp
 3ca:	ff 77 54             	pushl  0x54(%edi)
 3cd:	e8 be fd ff ff       	call   190 <printfile>
	firstOnScreen = firstOnScreen->prev;
 3d2:	a1 c0 13 00 00       	mov    0x13c0,%eax
 3d7:	8b 40 54             	mov    0x54(%eax),%eax
 3da:	a3 c0 13 00 00       	mov    %eax,0x13c0
}
 3df:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3e2:	5b                   	pop    %ebx
 3e3:	5e                   	pop    %esi
 3e4:	5f                   	pop    %edi
 3e5:	5d                   	pop    %ebp
 3e6:	c3                   	ret    
 3e7:	89 f6                	mov    %esi,%esi
 3e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003f0 <arrowkeys>:

void
arrowkeys(int i){
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	8b 45 08             	mov    0x8(%ebp),%eax
	//ctrl+j (go left)
	if(i == 10 && (currChar % WIDTH != 0) && currChar > 0){
 3f6:	83 f8 0a             	cmp    $0xa,%eax
 3f9:	0f 84 81 00 00 00    	je     480 <arrowkeys+0x90>
		currChar--;
	}
	//ctrl+l (go right)
	else if(i==12 && ((currChar+1) % WIDTH != 0)){
 3ff:	83 f8 0c             	cmp    $0xc,%eax
 402:	74 2c                	je     430 <arrowkeys+0x40>
		currChar++;
	}
	//ctrl+k (go down)
	else if(i == 11){
 404:	83 f8 0b             	cmp    $0xb,%eax
 407:	74 57                	je     460 <arrowkeys+0x70>
			if(lastOnScreen->next != 0)
				scrolldown();
		}
	}
	//ctrl+i (go up)
	else if(i == 9){
 409:	83 f8 09             	cmp    $0x9,%eax
 40c:	75 47                	jne    455 <arrowkeys+0x65>
		if(currChar >= WIDTH){
 40e:	a1 a4 13 00 00       	mov    0x13a4,%eax
 413:	83 f8 4f             	cmp    $0x4f,%eax
 416:	0f 8f b4 00 00 00    	jg     4d0 <arrowkeys+0xe0>
			currChar -= WIDTH;
		}
		else{
			if(firstOnScreen->prev != 0)
 41c:	a1 c0 13 00 00       	mov    0x13c0,%eax
 421:	8b 40 54             	mov    0x54(%eax),%eax
 424:	85 c0                	test   %eax,%eax
 426:	74 2d                	je     455 <arrowkeys+0x65>
				scrollup();
		}
	}
}
 428:	5d                   	pop    %ebp
		if(currChar >= WIDTH){
			currChar -= WIDTH;
		}
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
 429:	e9 52 ff ff ff       	jmp    380 <scrollup>
 42e:	66 90                	xchg   %ax,%ax
	//ctrl+j (go left)
	if(i == 10 && (currChar % WIDTH != 0) && currChar > 0){
		currChar--;
	}
	//ctrl+l (go right)
	else if(i==12 && ((currChar+1) % WIDTH != 0)){
 430:	a1 a4 13 00 00       	mov    0x13a4,%eax
 435:	ba 67 66 66 66       	mov    $0x66666667,%edx
 43a:	8d 48 01             	lea    0x1(%eax),%ecx
 43d:	89 c8                	mov    %ecx,%eax
 43f:	f7 ea                	imul   %edx
 441:	89 c8                	mov    %ecx,%eax
 443:	c1 f8 1f             	sar    $0x1f,%eax
 446:	c1 fa 05             	sar    $0x5,%edx
 449:	29 c2                	sub    %eax,%edx
 44b:	8d 04 92             	lea    (%edx,%edx,4),%eax
 44e:	c1 e0 04             	shl    $0x4,%eax
 451:	39 c1                	cmp    %eax,%ecx
 453:	75 63                	jne    4b8 <arrowkeys+0xc8>
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
}
 455:	5d                   	pop    %ebp
 456:	c3                   	ret    
 457:	89 f6                	mov    %esi,%esi
 459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	else if(i==12 && ((currChar+1) % WIDTH != 0)){
		currChar++;
	}
	//ctrl+k (go down)
	else if(i == 11){
		if(currChar < TOTAL_CHARS - WIDTH){
 460:	a1 a4 13 00 00       	mov    0x13a4,%eax
 465:	3d df 06 00 00       	cmp    $0x6df,%eax
 46a:	7e 54                	jle    4c0 <arrowkeys+0xd0>
			currChar += WIDTH;
		}
		else{
			if(lastOnScreen->next != 0)
 46c:	a1 c4 13 00 00       	mov    0x13c4,%eax
 471:	8b 50 58             	mov    0x58(%eax),%edx
 474:	85 d2                	test   %edx,%edx
 476:	74 dd                	je     455 <arrowkeys+0x65>
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
}
 478:	5d                   	pop    %ebp
		if(currChar < TOTAL_CHARS - WIDTH){
			currChar += WIDTH;
		}
		else{
			if(lastOnScreen->next != 0)
				scrolldown();
 479:	e9 92 fe ff ff       	jmp    310 <scrolldown>
 47e:	66 90                	xchg   %ax,%ax
}

void
arrowkeys(int i){
	//ctrl+j (go left)
	if(i == 10 && (currChar % WIDTH != 0) && currChar > 0){
 480:	8b 0d a4 13 00 00    	mov    0x13a4,%ecx
 486:	ba 67 66 66 66       	mov    $0x66666667,%edx
 48b:	89 c8                	mov    %ecx,%eax
 48d:	f7 ea                	imul   %edx
 48f:	89 c8                	mov    %ecx,%eax
 491:	c1 f8 1f             	sar    $0x1f,%eax
 494:	c1 fa 05             	sar    $0x5,%edx
 497:	29 c2                	sub    %eax,%edx
 499:	8d 04 92             	lea    (%edx,%edx,4),%eax
 49c:	c1 e0 04             	shl    $0x4,%eax
 49f:	39 c1                	cmp    %eax,%ecx
 4a1:	74 b2                	je     455 <arrowkeys+0x65>
 4a3:	85 c9                	test   %ecx,%ecx
 4a5:	7e ae                	jle    455 <arrowkeys+0x65>
		currChar--;
 4a7:	83 e9 01             	sub    $0x1,%ecx
 4aa:	89 0d a4 13 00 00    	mov    %ecx,0x13a4
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
}
 4b0:	5d                   	pop    %ebp
 4b1:	c3                   	ret    
 4b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	if(i == 10 && (currChar % WIDTH != 0) && currChar > 0){
		currChar--;
	}
	//ctrl+l (go right)
	else if(i==12 && ((currChar+1) % WIDTH != 0)){
		currChar++;
 4b8:	89 0d a4 13 00 00    	mov    %ecx,0x13a4
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
}
 4be:	5d                   	pop    %ebp
 4bf:	c3                   	ret    
		currChar++;
	}
	//ctrl+k (go down)
	else if(i == 11){
		if(currChar < TOTAL_CHARS - WIDTH){
			currChar += WIDTH;
 4c0:	83 c0 50             	add    $0x50,%eax
 4c3:	a3 a4 13 00 00       	mov    %eax,0x13a4
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
}
 4c8:	5d                   	pop    %ebp
 4c9:	c3                   	ret    
 4ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		}
	}
	//ctrl+i (go up)
	else if(i == 9){
		if(currChar >= WIDTH){
			currChar -= WIDTH;
 4d0:	83 e8 50             	sub    $0x50,%eax
 4d3:	a3 a4 13 00 00       	mov    %eax,0x13a4
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
}
 4d8:	5d                   	pop    %ebp
 4d9:	c3                   	ret    
 4da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000004e0 <cutline>:


void
cutline(void){
	int line = currChar/WIDTH;
 4e0:	8b 0d a4 13 00 00    	mov    0x13a4,%ecx
 4e6:	ba 67 66 66 66       	mov    $0x66666667,%edx
	}
}


void
cutline(void){
 4eb:	55                   	push   %ebp
 4ec:	89 e5                	mov    %esp,%ebp
 4ee:	56                   	push   %esi
 4ef:	53                   	push   %ebx
	int line = currChar/WIDTH;
 4f0:	89 c8                	mov    %ecx,%eax
 4f2:	c1 f9 1f             	sar    $0x1f,%ecx
 4f5:	f7 ea                	imul   %edx
	printf(1, "line: %d\n", line);
 4f7:	83 ec 04             	sub    $0x4,%esp
}


void
cutline(void){
	int line = currChar/WIDTH;
 4fa:	c1 fa 05             	sar    $0x5,%edx
 4fd:	29 ca                	sub    %ecx,%edx
	printf(1, "line: %d\n", line);
 4ff:	52                   	push   %edx
 500:	68 d9 0e 00 00       	push   $0xed9
}


void
cutline(void){
	int line = currChar/WIDTH;
 505:	89 d6                	mov    %edx,%esi
	printf(1, "line: %d\n", line);
 507:	6a 01                	push   $0x1
 509:	e8 02 06 00 00       	call   b10 <printf>
	struct fileline* cur = firstOnScreen;
 50e:	8b 15 c0 13 00 00    	mov    0x13c0,%edx
	for(int i=0; i<line; i++){
 514:	83 c4 10             	add    $0x10,%esp
 517:	85 f6                	test   %esi,%esi

void
cutline(void){
	int line = currChar/WIDTH;
	printf(1, "line: %d\n", line);
	struct fileline* cur = firstOnScreen;
 519:	89 d3                	mov    %edx,%ebx
	for(int i=0; i<line; i++){
 51b:	7e 0d                	jle    52a <cutline+0x4a>
 51d:	31 c0                	xor    %eax,%eax
 51f:	90                   	nop
 520:	83 c0 01             	add    $0x1,%eax
		cur = cur->next;
 523:	8b 5b 58             	mov    0x58(%ebx),%ebx
void
cutline(void){
	int line = currChar/WIDTH;
	printf(1, "line: %d\n", line);
	struct fileline* cur = firstOnScreen;
	for(int i=0; i<line; i++){
 526:	39 c6                	cmp    %eax,%esi
 528:	75 f6                	jne    520 <cutline+0x40>
		cur = cur->next;
	}
	if(lastOnScreen->next == 0){
 52a:	a1 c4 13 00 00       	mov    0x13c4,%eax
 52f:	8b 70 58             	mov    0x58(%eax),%esi
 532:	85 f6                	test   %esi,%esi
 534:	74 6a                	je     5a0 <cutline+0xc0>
			printfile(firstOnScreen);
			return;
		}
	}
	struct fileline* temp = cur;
	while(temp != 0){
 536:	85 db                	test   %ebx,%ebx
 538:	89 d8                	mov    %ebx,%eax
 53a:	74 0e                	je     54a <cutline+0x6a>
 53c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		temp->filelinenum = temp->filelinenum-1;
 540:	83 28 01             	subl   $0x1,(%eax)
		temp = temp->next;
 543:	8b 40 58             	mov    0x58(%eax),%eax
			printfile(firstOnScreen);
			return;
		}
	}
	struct fileline* temp = cur;
	while(temp != 0){
 546:	85 c0                	test   %eax,%eax
 548:	75 f6                	jne    540 <cutline+0x60>
		temp->filelinenum = temp->filelinenum-1;
		temp = temp->next;
	}
	if(firstOnScreen == cur){
 54a:	3b 1d c0 13 00 00    	cmp    0x13c0,%ebx
 550:	74 5e                	je     5b0 <cutline+0xd0>
		firstOnScreen = cur->next;
	}
	if(lastOnScreen == cur){
 552:	3b 1d c4 13 00 00    	cmp    0x13c4,%ebx
 558:	8b 43 58             	mov    0x58(%ebx),%eax
 55b:	74 63                	je     5c0 <cutline+0xe0>
		} 
		else if(cur->prev != 0){
			lastOnScreen = cur->prev;
		}
	}
	if(head == cur){
 55d:	3b 1d cc 13 00 00    	cmp    0x13cc,%ebx
 563:	8b 53 54             	mov    0x54(%ebx),%edx
 566:	74 70                	je     5d8 <cutline+0xf8>
		head = cur->next;
	}
	if(cur->prev != 0){
 568:	85 d2                	test   %edx,%edx
 56a:	74 06                	je     572 <cutline+0x92>
		cur->prev->next = cur->next;
 56c:	89 42 58             	mov    %eax,0x58(%edx)
 56f:	8b 43 58             	mov    0x58(%ebx),%eax
	}
	if(cur->next != 0){
 572:	85 c0                	test   %eax,%eax
 574:	74 06                	je     57c <cutline+0x9c>
		cur->next->prev = cur->prev;
 576:	8b 53 54             	mov    0x54(%ebx),%edx
 579:	89 50 54             	mov    %edx,0x54(%eax)
	}
	free(cur);
 57c:	83 ec 0c             	sub    $0xc,%esp
 57f:	53                   	push   %ebx
 580:	e8 2b 07 00 00       	call   cb0 <free>
	printfile(firstOnScreen);
 585:	58                   	pop    %eax
 586:	ff 35 c0 13 00 00    	pushl  0x13c0
 58c:	e8 ff fb ff ff       	call   190 <printfile>
 591:	83 c4 10             	add    $0x10,%esp
}
 594:	8d 65 f8             	lea    -0x8(%ebp),%esp
 597:	5b                   	pop    %ebx
 598:	5e                   	pop    %esi
 599:	5d                   	pop    %ebp
 59a:	c3                   	ret    
 59b:	90                   	nop
 59c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	struct fileline* cur = firstOnScreen;
	for(int i=0; i<line; i++){
		cur = cur->next;
	}
	if(lastOnScreen->next == 0){
		if(firstOnScreen->prev != 0){
 5a0:	8b 4a 54             	mov    0x54(%edx),%ecx
 5a3:	85 c9                	test   %ecx,%ecx
 5a5:	74 38                	je     5df <cutline+0xff>
			scrollup();
 5a7:	e8 d4 fd ff ff       	call   380 <scrollup>
 5ac:	eb 88                	jmp    536 <cutline+0x56>
 5ae:	66 90                	xchg   %ax,%ax
		temp = temp->next;
	}
	if(firstOnScreen == cur){
		firstOnScreen = cur->next;
	}
	if(lastOnScreen == cur){
 5b0:	3b 1d c4 13 00 00    	cmp    0x13c4,%ebx
	while(temp != 0){
		temp->filelinenum = temp->filelinenum-1;
		temp = temp->next;
	}
	if(firstOnScreen == cur){
		firstOnScreen = cur->next;
 5b6:	8b 43 58             	mov    0x58(%ebx),%eax
 5b9:	a3 c0 13 00 00       	mov    %eax,0x13c0
	}
	if(lastOnScreen == cur){
 5be:	75 9d                	jne    55d <cutline+0x7d>
		if(cur->next != 0){
 5c0:	85 c0                	test   %eax,%eax
 5c2:	74 3c                	je     600 <cutline+0x120>
		} 
		else if(cur->prev != 0){
			lastOnScreen = cur->prev;
		}
	}
	if(head == cur){
 5c4:	3b 1d cc 13 00 00    	cmp    0x13cc,%ebx
	if(firstOnScreen == cur){
		firstOnScreen = cur->next;
	}
	if(lastOnScreen == cur){
		if(cur->next != 0){
			lastOnScreen = cur->next;
 5ca:	a3 c4 13 00 00       	mov    %eax,0x13c4
 5cf:	8b 53 54             	mov    0x54(%ebx),%edx
		} 
		else if(cur->prev != 0){
			lastOnScreen = cur->prev;
		}
	}
	if(head == cur){
 5d2:	75 94                	jne    568 <cutline+0x88>
 5d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		head = cur->next;
 5d8:	a3 cc 13 00 00       	mov    %eax,0x13cc
 5dd:	eb 89                	jmp    568 <cutline+0x88>
 5df:	8d 43 04             	lea    0x4(%ebx),%eax
 5e2:	83 c3 54             	add    $0x54,%ebx
 5e5:	8d 76 00             	lea    0x0(%esi),%esi
	if(lastOnScreen->next == 0){
		if(firstOnScreen->prev != 0){
			scrollup();
		} else {
			for(int i=0; i<WIDTH; i++){
				cur->line[i] = ' ';
 5e8:	c6 00 20             	movb   $0x20,(%eax)
 5eb:	83 c0 01             	add    $0x1,%eax
	}
	if(lastOnScreen->next == 0){
		if(firstOnScreen->prev != 0){
			scrollup();
		} else {
			for(int i=0; i<WIDTH; i++){
 5ee:	39 d8                	cmp    %ebx,%eax
 5f0:	75 f6                	jne    5e8 <cutline+0x108>
				cur->line[i] = ' ';
			}
			printfile(firstOnScreen);
 5f2:	83 ec 0c             	sub    $0xc,%esp
 5f5:	52                   	push   %edx
 5f6:	e8 95 fb ff ff       	call   190 <printfile>
			return;
 5fb:	83 c4 10             	add    $0x10,%esp
 5fe:	eb 94                	jmp    594 <cutline+0xb4>
	}
	if(lastOnScreen == cur){
		if(cur->next != 0){
			lastOnScreen = cur->next;
		} 
		else if(cur->prev != 0){
 600:	8b 53 54             	mov    0x54(%ebx),%edx
 603:	85 d2                	test   %edx,%edx
 605:	74 14                	je     61b <cutline+0x13b>
			lastOnScreen = cur->prev;
		}
	}
	if(head == cur){
 607:	3b 1d cc 13 00 00    	cmp    0x13cc,%ebx
	if(lastOnScreen == cur){
		if(cur->next != 0){
			lastOnScreen = cur->next;
		} 
		else if(cur->prev != 0){
			lastOnScreen = cur->prev;
 60d:	89 15 c4 13 00 00    	mov    %edx,0x13c4
		}
	}
	if(head == cur){
 613:	0f 85 53 ff ff ff    	jne    56c <cutline+0x8c>
 619:	eb bd                	jmp    5d8 <cutline+0xf8>
 61b:	3b 1d cc 13 00 00    	cmp    0x13cc,%ebx
 621:	0f 85 55 ff ff ff    	jne    57c <cutline+0x9c>
 627:	eb af                	jmp    5d8 <cutline+0xf8>
 629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000630 <handleInput>:
	free(cur);
	printfile(firstOnScreen);
}

void
handleInput(int i) {
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	56                   	push   %esi
 634:	53                   	push   %ebx
 635:	8b 5d 08             	mov    0x8(%ebp),%ebx
	printf(1, "currChar: %d\n", currChar);
 638:	83 ec 04             	sub    $0x4,%esp
 63b:	ff 35 a4 13 00 00    	pushl  0x13a4
 641:	68 e3 0e 00 00       	push   $0xee3
 646:	6a 01                	push   $0x1
 648:	e8 c3 04 00 00       	call   b10 <printf>
	//ctrl+q
	if (i == 17) {
 64d:	83 c4 10             	add    $0x10,%esp
 650:	83 fb 11             	cmp    $0x11,%ebx
 653:	0f 84 fc 00 00 00    	je     755 <handleInput+0x125>
		exit();
	}
	else if(i >= 9 && i<= 12){
 659:	8d 43 f7             	lea    -0x9(%ebx),%eax
 65c:	83 f8 03             	cmp    $0x3,%eax
 65f:	76 5f                	jbe    6c0 <handleInput+0x90>
		arrowkeys(i);
	}

	//ctrl+x
	else if(i == 24){
 661:	83 fb 18             	cmp    $0x18,%ebx
 664:	0f 84 dc 00 00 00    	je     746 <handleInput+0x116>
		cutline();
	}

	//backspace
	else if(i == 127){
 66a:	83 fb 7f             	cmp    $0x7f,%ebx
 66d:	74 61                	je     6d0 <handleInput+0xa0>
			buf[bufindex] = ' ';
			updatesc(0, 1, buf, TEXT_COLOR);
		}
	}
	//On right edge of window 
	else if((currChar+1) % WIDTH == 0){
 66f:	8b 35 a4 13 00 00    	mov    0x13a4,%esi
 675:	ba 67 66 66 66       	mov    $0x66666667,%edx
 67a:	8d 4e 01             	lea    0x1(%esi),%ecx
 67d:	89 c8                	mov    %ecx,%eax
 67f:	f7 ea                	imul   %edx
 681:	89 c8                	mov    %ecx,%eax
 683:	c1 f8 1f             	sar    $0x1f,%eax
 686:	c1 fa 05             	sar    $0x5,%edx
 689:	29 c2                	sub    %eax,%edx
 68b:	8d 04 92             	lea    (%edx,%edx,4),%eax
 68e:	c1 e0 04             	shl    $0x4,%eax
 691:	39 c1                	cmp    %eax,%ecx
 693:	74 06                	je     69b <handleInput+0x6b>
		buf[currChar] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
		// printf(1, "new input");
	}
	else{
		buf[currChar++] = (char) i & 0xff;
 695:	89 0d a4 13 00 00    	mov    %ecx,0x13a4
 69b:	88 9e e0 13 00 00    	mov    %bl,0x13e0(%esi)
		updatesc(0, 1, buf, TEXT_COLOR);
 6a1:	6a 07                	push   $0x7
 6a3:	68 e0 13 00 00       	push   $0x13e0
 6a8:	6a 01                	push   $0x1
 6aa:	6a 00                	push   $0x0
 6ac:	e8 a1 03 00 00       	call   a52 <updatesc>
 6b1:	83 c4 10             	add    $0x10,%esp
	}
}
 6b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 6b7:	5b                   	pop    %ebx
 6b8:	5e                   	pop    %esi
 6b9:	5d                   	pop    %ebp
 6ba:	c3                   	ret    
 6bb:	90                   	nop
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	//ctrl+q
	if (i == 17) {
		exit();
	}
	else if(i >= 9 && i<= 12){
		arrowkeys(i);
 6c0:	89 5d 08             	mov    %ebx,0x8(%ebp)
	}
	else{
		buf[currChar++] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
	}
}
 6c3:	8d 65 f8             	lea    -0x8(%ebp),%esp
 6c6:	5b                   	pop    %ebx
 6c7:	5e                   	pop    %esi
 6c8:	5d                   	pop    %ebp
	//ctrl+q
	if (i == 17) {
		exit();
	}
	else if(i >= 9 && i<= 12){
		arrowkeys(i);
 6c9:	e9 22 fd ff ff       	jmp    3f0 <arrowkeys>
 6ce:	66 90                	xchg   %ax,%ax
		cutline();
	}

	//backspace
	else if(i == 127){
		if(currChar > 0){
 6d0:	8b 1d a4 13 00 00    	mov    0x13a4,%ebx
 6d6:	85 db                	test   %ebx,%ebx
 6d8:	7e da                	jle    6b4 <handleInput+0x84>
			currChar--;
			int bufindex = currChar;
			while(((bufindex+1) % WIDTH) != 0){
 6da:	89 d8                	mov    %ebx,%eax
 6dc:	ba 67 66 66 66       	mov    $0x66666667,%edx
	}

	//backspace
	else if(i == 127){
		if(currChar > 0){
			currChar--;
 6e1:	8d 4b ff             	lea    -0x1(%ebx),%ecx
			int bufindex = currChar;
			while(((bufindex+1) % WIDTH) != 0){
 6e4:	f7 ea                	imul   %edx
 6e6:	89 d8                	mov    %ebx,%eax
 6e8:	c1 f8 1f             	sar    $0x1f,%eax
	}

	//backspace
	else if(i == 127){
		if(currChar > 0){
			currChar--;
 6eb:	89 0d a4 13 00 00    	mov    %ecx,0x13a4
			int bufindex = currChar;
			while(((bufindex+1) % WIDTH) != 0){
 6f1:	c1 fa 05             	sar    $0x5,%edx
 6f4:	29 c2                	sub    %eax,%edx
 6f6:	8d 04 92             	lea    (%edx,%edx,4),%eax
 6f9:	c1 e0 04             	shl    $0x4,%eax
 6fc:	39 c3                	cmp    %eax,%ebx
 6fe:	74 51                	je     751 <handleInput+0x121>
 700:	be 67 66 66 66       	mov    $0x66666667,%esi
 705:	eb 0b                	jmp    712 <handleInput+0xe2>
 707:	89 f6                	mov    %esi,%esi
 709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 710:	89 cb                	mov    %ecx,%ebx
				buf[bufindex] = buf[bufindex+1];
 712:	0f b6 83 e0 13 00 00 	movzbl 0x13e0(%ebx),%eax
	//backspace
	else if(i == 127){
		if(currChar > 0){
			currChar--;
			int bufindex = currChar;
			while(((bufindex+1) % WIDTH) != 0){
 719:	8d 4b 01             	lea    0x1(%ebx),%ecx
				buf[bufindex] = buf[bufindex+1];
 71c:	88 83 df 13 00 00    	mov    %al,0x13df(%ebx)
	//backspace
	else if(i == 127){
		if(currChar > 0){
			currChar--;
			int bufindex = currChar;
			while(((bufindex+1) % WIDTH) != 0){
 722:	89 c8                	mov    %ecx,%eax
 724:	f7 ee                	imul   %esi
 726:	89 c8                	mov    %ecx,%eax
 728:	c1 f8 1f             	sar    $0x1f,%eax
 72b:	c1 fa 05             	sar    $0x5,%edx
 72e:	29 c2                	sub    %eax,%edx
 730:	8d 04 92             	lea    (%edx,%edx,4),%eax
 733:	c1 e0 04             	shl    $0x4,%eax
 736:	39 c1                	cmp    %eax,%ecx
 738:	75 d6                	jne    710 <handleInput+0xe0>
				buf[bufindex] = buf[bufindex+1];
				bufindex++;
			}
			buf[bufindex] = ' ';
 73a:	c6 83 e0 13 00 00 20 	movb   $0x20,0x13e0(%ebx)
 741:	e9 5b ff ff ff       	jmp    6a1 <handleInput+0x71>
	}
	else{
		buf[currChar++] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
	}
}
 746:	8d 65 f8             	lea    -0x8(%ebp),%esp
 749:	5b                   	pop    %ebx
 74a:	5e                   	pop    %esi
 74b:	5d                   	pop    %ebp
		arrowkeys(i);
	}

	//ctrl+x
	else if(i == 24){
		cutline();
 74c:	e9 8f fd ff ff       	jmp    4e0 <cutline>

	//backspace
	else if(i == 127){
		if(currChar > 0){
			currChar--;
			int bufindex = currChar;
 751:	89 cb                	mov    %ecx,%ebx
 753:	eb e5                	jmp    73a <handleInput+0x10a>
void
handleInput(int i) {
	printf(1, "currChar: %d\n", currChar);
	//ctrl+q
	if (i == 17) {
		exit();
 755:	e8 48 02 00 00       	call   9a2 <exit>
 75a:	66 90                	xchg   %ax,%ax
 75c:	66 90                	xchg   %ax,%ax
 75e:	66 90                	xchg   %ax,%ax

00000760 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	53                   	push   %ebx
 764:	8b 45 08             	mov    0x8(%ebp),%eax
 767:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 76a:	89 c2                	mov    %eax,%edx
 76c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 770:	83 c1 01             	add    $0x1,%ecx
 773:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 777:	83 c2 01             	add    $0x1,%edx
 77a:	84 db                	test   %bl,%bl
 77c:	88 5a ff             	mov    %bl,-0x1(%edx)
 77f:	75 ef                	jne    770 <strcpy+0x10>
    ;
  return os;
}
 781:	5b                   	pop    %ebx
 782:	5d                   	pop    %ebp
 783:	c3                   	ret    
 784:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 78a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000790 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	56                   	push   %esi
 794:	53                   	push   %ebx
 795:	8b 55 08             	mov    0x8(%ebp),%edx
 798:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 79b:	0f b6 02             	movzbl (%edx),%eax
 79e:	0f b6 19             	movzbl (%ecx),%ebx
 7a1:	84 c0                	test   %al,%al
 7a3:	75 1e                	jne    7c3 <strcmp+0x33>
 7a5:	eb 29                	jmp    7d0 <strcmp+0x40>
 7a7:	89 f6                	mov    %esi,%esi
 7a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 7b0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 7b3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 7b6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 7b9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 7bd:	84 c0                	test   %al,%al
 7bf:	74 0f                	je     7d0 <strcmp+0x40>
 7c1:	89 f1                	mov    %esi,%ecx
 7c3:	38 d8                	cmp    %bl,%al
 7c5:	74 e9                	je     7b0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 7c7:	29 d8                	sub    %ebx,%eax
}
 7c9:	5b                   	pop    %ebx
 7ca:	5e                   	pop    %esi
 7cb:	5d                   	pop    %ebp
 7cc:	c3                   	ret    
 7cd:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 7d0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 7d2:	29 d8                	sub    %ebx,%eax
}
 7d4:	5b                   	pop    %ebx
 7d5:	5e                   	pop    %esi
 7d6:	5d                   	pop    %ebp
 7d7:	c3                   	ret    
 7d8:	90                   	nop
 7d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000007e0 <strlen>:

uint
strlen(char *s)
{
 7e0:	55                   	push   %ebp
 7e1:	89 e5                	mov    %esp,%ebp
 7e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 7e6:	80 39 00             	cmpb   $0x0,(%ecx)
 7e9:	74 12                	je     7fd <strlen+0x1d>
 7eb:	31 d2                	xor    %edx,%edx
 7ed:	8d 76 00             	lea    0x0(%esi),%esi
 7f0:	83 c2 01             	add    $0x1,%edx
 7f3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 7f7:	89 d0                	mov    %edx,%eax
 7f9:	75 f5                	jne    7f0 <strlen+0x10>
    ;
  return n;
}
 7fb:	5d                   	pop    %ebp
 7fc:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 7fd:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 7ff:	5d                   	pop    %ebp
 800:	c3                   	ret    
 801:	eb 0d                	jmp    810 <memset>
 803:	90                   	nop
 804:	90                   	nop
 805:	90                   	nop
 806:	90                   	nop
 807:	90                   	nop
 808:	90                   	nop
 809:	90                   	nop
 80a:	90                   	nop
 80b:	90                   	nop
 80c:	90                   	nop
 80d:	90                   	nop
 80e:	90                   	nop
 80f:	90                   	nop

00000810 <memset>:

void*
memset(void *dst, int c, uint n)
{
 810:	55                   	push   %ebp
 811:	89 e5                	mov    %esp,%ebp
 813:	57                   	push   %edi
 814:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 817:	8b 4d 10             	mov    0x10(%ebp),%ecx
 81a:	8b 45 0c             	mov    0xc(%ebp),%eax
 81d:	89 d7                	mov    %edx,%edi
 81f:	fc                   	cld    
 820:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 822:	89 d0                	mov    %edx,%eax
 824:	5f                   	pop    %edi
 825:	5d                   	pop    %ebp
 826:	c3                   	ret    
 827:	89 f6                	mov    %esi,%esi
 829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000830 <strchr>:

char*
strchr(const char *s, char c)
{
 830:	55                   	push   %ebp
 831:	89 e5                	mov    %esp,%ebp
 833:	53                   	push   %ebx
 834:	8b 45 08             	mov    0x8(%ebp),%eax
 837:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 83a:	0f b6 10             	movzbl (%eax),%edx
 83d:	84 d2                	test   %dl,%dl
 83f:	74 1d                	je     85e <strchr+0x2e>
    if(*s == c)
 841:	38 d3                	cmp    %dl,%bl
 843:	89 d9                	mov    %ebx,%ecx
 845:	75 0d                	jne    854 <strchr+0x24>
 847:	eb 17                	jmp    860 <strchr+0x30>
 849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 850:	38 ca                	cmp    %cl,%dl
 852:	74 0c                	je     860 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 854:	83 c0 01             	add    $0x1,%eax
 857:	0f b6 10             	movzbl (%eax),%edx
 85a:	84 d2                	test   %dl,%dl
 85c:	75 f2                	jne    850 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 85e:	31 c0                	xor    %eax,%eax
}
 860:	5b                   	pop    %ebx
 861:	5d                   	pop    %ebp
 862:	c3                   	ret    
 863:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000870 <gets>:

char*
gets(char *buf, int max)
{
 870:	55                   	push   %ebp
 871:	89 e5                	mov    %esp,%ebp
 873:	57                   	push   %edi
 874:	56                   	push   %esi
 875:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 876:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 878:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 87b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 87e:	eb 29                	jmp    8a9 <gets+0x39>
    cc = read(0, &c, 1);
 880:	83 ec 04             	sub    $0x4,%esp
 883:	6a 01                	push   $0x1
 885:	57                   	push   %edi
 886:	6a 00                	push   $0x0
 888:	e8 2d 01 00 00       	call   9ba <read>
    if(cc < 1)
 88d:	83 c4 10             	add    $0x10,%esp
 890:	85 c0                	test   %eax,%eax
 892:	7e 1d                	jle    8b1 <gets+0x41>
      break;
    buf[i++] = c;
 894:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 898:	8b 55 08             	mov    0x8(%ebp),%edx
 89b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 89d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 89f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 8a3:	74 1b                	je     8c0 <gets+0x50>
 8a5:	3c 0d                	cmp    $0xd,%al
 8a7:	74 17                	je     8c0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 8a9:	8d 5e 01             	lea    0x1(%esi),%ebx
 8ac:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 8af:	7c cf                	jl     880 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 8b1:	8b 45 08             	mov    0x8(%ebp),%eax
 8b4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 8b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8bb:	5b                   	pop    %ebx
 8bc:	5e                   	pop    %esi
 8bd:	5f                   	pop    %edi
 8be:	5d                   	pop    %ebp
 8bf:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 8c0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 8c3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 8c5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 8c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8cc:	5b                   	pop    %ebx
 8cd:	5e                   	pop    %esi
 8ce:	5f                   	pop    %edi
 8cf:	5d                   	pop    %ebp
 8d0:	c3                   	ret    
 8d1:	eb 0d                	jmp    8e0 <stat>
 8d3:	90                   	nop
 8d4:	90                   	nop
 8d5:	90                   	nop
 8d6:	90                   	nop
 8d7:	90                   	nop
 8d8:	90                   	nop
 8d9:	90                   	nop
 8da:	90                   	nop
 8db:	90                   	nop
 8dc:	90                   	nop
 8dd:	90                   	nop
 8de:	90                   	nop
 8df:	90                   	nop

000008e0 <stat>:

int
stat(char *n, struct stat *st)
{
 8e0:	55                   	push   %ebp
 8e1:	89 e5                	mov    %esp,%ebp
 8e3:	56                   	push   %esi
 8e4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 8e5:	83 ec 08             	sub    $0x8,%esp
 8e8:	6a 00                	push   $0x0
 8ea:	ff 75 08             	pushl  0x8(%ebp)
 8ed:	e8 f0 00 00 00       	call   9e2 <open>
  if(fd < 0)
 8f2:	83 c4 10             	add    $0x10,%esp
 8f5:	85 c0                	test   %eax,%eax
 8f7:	78 27                	js     920 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 8f9:	83 ec 08             	sub    $0x8,%esp
 8fc:	ff 75 0c             	pushl  0xc(%ebp)
 8ff:	89 c3                	mov    %eax,%ebx
 901:	50                   	push   %eax
 902:	e8 f3 00 00 00       	call   9fa <fstat>
 907:	89 c6                	mov    %eax,%esi
  close(fd);
 909:	89 1c 24             	mov    %ebx,(%esp)
 90c:	e8 b9 00 00 00       	call   9ca <close>
  return r;
 911:	83 c4 10             	add    $0x10,%esp
 914:	89 f0                	mov    %esi,%eax
}
 916:	8d 65 f8             	lea    -0x8(%ebp),%esp
 919:	5b                   	pop    %ebx
 91a:	5e                   	pop    %esi
 91b:	5d                   	pop    %ebp
 91c:	c3                   	ret    
 91d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 920:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 925:	eb ef                	jmp    916 <stat+0x36>
 927:	89 f6                	mov    %esi,%esi
 929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000930 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 930:	55                   	push   %ebp
 931:	89 e5                	mov    %esp,%ebp
 933:	53                   	push   %ebx
 934:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 937:	0f be 11             	movsbl (%ecx),%edx
 93a:	8d 42 d0             	lea    -0x30(%edx),%eax
 93d:	3c 09                	cmp    $0x9,%al
 93f:	b8 00 00 00 00       	mov    $0x0,%eax
 944:	77 1f                	ja     965 <atoi+0x35>
 946:	8d 76 00             	lea    0x0(%esi),%esi
 949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 950:	8d 04 80             	lea    (%eax,%eax,4),%eax
 953:	83 c1 01             	add    $0x1,%ecx
 956:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 95a:	0f be 11             	movsbl (%ecx),%edx
 95d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 960:	80 fb 09             	cmp    $0x9,%bl
 963:	76 eb                	jbe    950 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 965:	5b                   	pop    %ebx
 966:	5d                   	pop    %ebp
 967:	c3                   	ret    
 968:	90                   	nop
 969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000970 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 970:	55                   	push   %ebp
 971:	89 e5                	mov    %esp,%ebp
 973:	56                   	push   %esi
 974:	53                   	push   %ebx
 975:	8b 5d 10             	mov    0x10(%ebp),%ebx
 978:	8b 45 08             	mov    0x8(%ebp),%eax
 97b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 97e:	85 db                	test   %ebx,%ebx
 980:	7e 14                	jle    996 <memmove+0x26>
 982:	31 d2                	xor    %edx,%edx
 984:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 988:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 98c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 98f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 992:	39 da                	cmp    %ebx,%edx
 994:	75 f2                	jne    988 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 996:	5b                   	pop    %ebx
 997:	5e                   	pop    %esi
 998:	5d                   	pop    %ebp
 999:	c3                   	ret    

0000099a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 99a:	b8 01 00 00 00       	mov    $0x1,%eax
 99f:	cd 40                	int    $0x40
 9a1:	c3                   	ret    

000009a2 <exit>:
SYSCALL(exit)
 9a2:	b8 02 00 00 00       	mov    $0x2,%eax
 9a7:	cd 40                	int    $0x40
 9a9:	c3                   	ret    

000009aa <wait>:
SYSCALL(wait)
 9aa:	b8 03 00 00 00       	mov    $0x3,%eax
 9af:	cd 40                	int    $0x40
 9b1:	c3                   	ret    

000009b2 <pipe>:
SYSCALL(pipe)
 9b2:	b8 04 00 00 00       	mov    $0x4,%eax
 9b7:	cd 40                	int    $0x40
 9b9:	c3                   	ret    

000009ba <read>:
SYSCALL(read)
 9ba:	b8 05 00 00 00       	mov    $0x5,%eax
 9bf:	cd 40                	int    $0x40
 9c1:	c3                   	ret    

000009c2 <write>:
SYSCALL(write)
 9c2:	b8 10 00 00 00       	mov    $0x10,%eax
 9c7:	cd 40                	int    $0x40
 9c9:	c3                   	ret    

000009ca <close>:
SYSCALL(close)
 9ca:	b8 15 00 00 00       	mov    $0x15,%eax
 9cf:	cd 40                	int    $0x40
 9d1:	c3                   	ret    

000009d2 <kill>:
SYSCALL(kill)
 9d2:	b8 06 00 00 00       	mov    $0x6,%eax
 9d7:	cd 40                	int    $0x40
 9d9:	c3                   	ret    

000009da <exec>:
SYSCALL(exec)
 9da:	b8 07 00 00 00       	mov    $0x7,%eax
 9df:	cd 40                	int    $0x40
 9e1:	c3                   	ret    

000009e2 <open>:
SYSCALL(open)
 9e2:	b8 0f 00 00 00       	mov    $0xf,%eax
 9e7:	cd 40                	int    $0x40
 9e9:	c3                   	ret    

000009ea <mknod>:
SYSCALL(mknod)
 9ea:	b8 11 00 00 00       	mov    $0x11,%eax
 9ef:	cd 40                	int    $0x40
 9f1:	c3                   	ret    

000009f2 <unlink>:
SYSCALL(unlink)
 9f2:	b8 12 00 00 00       	mov    $0x12,%eax
 9f7:	cd 40                	int    $0x40
 9f9:	c3                   	ret    

000009fa <fstat>:
SYSCALL(fstat)
 9fa:	b8 08 00 00 00       	mov    $0x8,%eax
 9ff:	cd 40                	int    $0x40
 a01:	c3                   	ret    

00000a02 <link>:
SYSCALL(link)
 a02:	b8 13 00 00 00       	mov    $0x13,%eax
 a07:	cd 40                	int    $0x40
 a09:	c3                   	ret    

00000a0a <mkdir>:
SYSCALL(mkdir)
 a0a:	b8 14 00 00 00       	mov    $0x14,%eax
 a0f:	cd 40                	int    $0x40
 a11:	c3                   	ret    

00000a12 <chdir>:
SYSCALL(chdir)
 a12:	b8 09 00 00 00       	mov    $0x9,%eax
 a17:	cd 40                	int    $0x40
 a19:	c3                   	ret    

00000a1a <dup>:
SYSCALL(dup)
 a1a:	b8 0a 00 00 00       	mov    $0xa,%eax
 a1f:	cd 40                	int    $0x40
 a21:	c3                   	ret    

00000a22 <getpid>:
SYSCALL(getpid)
 a22:	b8 0b 00 00 00       	mov    $0xb,%eax
 a27:	cd 40                	int    $0x40
 a29:	c3                   	ret    

00000a2a <sbrk>:
SYSCALL(sbrk)
 a2a:	b8 0c 00 00 00       	mov    $0xc,%eax
 a2f:	cd 40                	int    $0x40
 a31:	c3                   	ret    

00000a32 <sleep>:
SYSCALL(sleep)
 a32:	b8 0d 00 00 00       	mov    $0xd,%eax
 a37:	cd 40                	int    $0x40
 a39:	c3                   	ret    

00000a3a <uptime>:
SYSCALL(uptime)
 a3a:	b8 0e 00 00 00       	mov    $0xe,%eax
 a3f:	cd 40                	int    $0x40
 a41:	c3                   	ret    

00000a42 <captsc>:
SYSCALL(captsc)
 a42:	b8 16 00 00 00       	mov    $0x16,%eax
 a47:	cd 40                	int    $0x40
 a49:	c3                   	ret    

00000a4a <freesc>:
SYSCALL(freesc)
 a4a:	b8 17 00 00 00       	mov    $0x17,%eax
 a4f:	cd 40                	int    $0x40
 a51:	c3                   	ret    

00000a52 <updatesc>:
SYSCALL(updatesc)
 a52:	b8 18 00 00 00       	mov    $0x18,%eax
 a57:	cd 40                	int    $0x40
 a59:	c3                   	ret    

00000a5a <getkey>:
SYSCALL(getkey)
 a5a:	b8 19 00 00 00       	mov    $0x19,%eax
 a5f:	cd 40                	int    $0x40
 a61:	c3                   	ret    
 a62:	66 90                	xchg   %ax,%ax
 a64:	66 90                	xchg   %ax,%ax
 a66:	66 90                	xchg   %ax,%ax
 a68:	66 90                	xchg   %ax,%ax
 a6a:	66 90                	xchg   %ax,%ax
 a6c:	66 90                	xchg   %ax,%ax
 a6e:	66 90                	xchg   %ax,%ax

00000a70 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 a70:	55                   	push   %ebp
 a71:	89 e5                	mov    %esp,%ebp
 a73:	57                   	push   %edi
 a74:	56                   	push   %esi
 a75:	53                   	push   %ebx
 a76:	89 c6                	mov    %eax,%esi
 a78:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 a7b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 a7e:	85 db                	test   %ebx,%ebx
 a80:	74 7e                	je     b00 <printint+0x90>
 a82:	89 d0                	mov    %edx,%eax
 a84:	c1 e8 1f             	shr    $0x1f,%eax
 a87:	84 c0                	test   %al,%al
 a89:	74 75                	je     b00 <printint+0x90>
    neg = 1;
    x = -xx;
 a8b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 a8d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 a94:	f7 d8                	neg    %eax
 a96:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 a99:	31 ff                	xor    %edi,%edi
 a9b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 a9e:	89 ce                	mov    %ecx,%esi
 aa0:	eb 08                	jmp    aaa <printint+0x3a>
 aa2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 aa8:	89 cf                	mov    %ecx,%edi
 aaa:	31 d2                	xor    %edx,%edx
 aac:	8d 4f 01             	lea    0x1(%edi),%ecx
 aaf:	f7 f6                	div    %esi
 ab1:	0f b6 92 1c 0f 00 00 	movzbl 0xf1c(%edx),%edx
  }while((x /= base) != 0);
 ab8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 aba:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 abd:	75 e9                	jne    aa8 <printint+0x38>
  if(neg)
 abf:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 ac2:	8b 75 c0             	mov    -0x40(%ebp),%esi
 ac5:	85 c0                	test   %eax,%eax
 ac7:	74 08                	je     ad1 <printint+0x61>
    buf[i++] = '-';
 ac9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 ace:	8d 4f 02             	lea    0x2(%edi),%ecx
 ad1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 ad5:	8d 76 00             	lea    0x0(%esi),%esi
 ad8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 adb:	83 ec 04             	sub    $0x4,%esp
 ade:	83 ef 01             	sub    $0x1,%edi
 ae1:	6a 01                	push   $0x1
 ae3:	53                   	push   %ebx
 ae4:	56                   	push   %esi
 ae5:	88 45 d7             	mov    %al,-0x29(%ebp)
 ae8:	e8 d5 fe ff ff       	call   9c2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 aed:	83 c4 10             	add    $0x10,%esp
 af0:	39 df                	cmp    %ebx,%edi
 af2:	75 e4                	jne    ad8 <printint+0x68>
    putc(fd, buf[i]);
}
 af4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 af7:	5b                   	pop    %ebx
 af8:	5e                   	pop    %esi
 af9:	5f                   	pop    %edi
 afa:	5d                   	pop    %ebp
 afb:	c3                   	ret    
 afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 b00:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 b02:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 b09:	eb 8b                	jmp    a96 <printint+0x26>
 b0b:	90                   	nop
 b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000b10 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 b10:	55                   	push   %ebp
 b11:	89 e5                	mov    %esp,%ebp
 b13:	57                   	push   %edi
 b14:	56                   	push   %esi
 b15:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 b16:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 b19:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 b1c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 b1f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 b22:	89 45 d0             	mov    %eax,-0x30(%ebp)
 b25:	0f b6 1e             	movzbl (%esi),%ebx
 b28:	83 c6 01             	add    $0x1,%esi
 b2b:	84 db                	test   %bl,%bl
 b2d:	0f 84 b0 00 00 00    	je     be3 <printf+0xd3>
 b33:	31 d2                	xor    %edx,%edx
 b35:	eb 39                	jmp    b70 <printf+0x60>
 b37:	89 f6                	mov    %esi,%esi
 b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 b40:	83 f8 25             	cmp    $0x25,%eax
 b43:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 b46:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 b4b:	74 18                	je     b65 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 b4d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 b50:	83 ec 04             	sub    $0x4,%esp
 b53:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 b56:	6a 01                	push   $0x1
 b58:	50                   	push   %eax
 b59:	57                   	push   %edi
 b5a:	e8 63 fe ff ff       	call   9c2 <write>
 b5f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 b62:	83 c4 10             	add    $0x10,%esp
 b65:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 b68:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 b6c:	84 db                	test   %bl,%bl
 b6e:	74 73                	je     be3 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 b70:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 b72:	0f be cb             	movsbl %bl,%ecx
 b75:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 b78:	74 c6                	je     b40 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 b7a:	83 fa 25             	cmp    $0x25,%edx
 b7d:	75 e6                	jne    b65 <printf+0x55>
      if(c == 'd'){
 b7f:	83 f8 64             	cmp    $0x64,%eax
 b82:	0f 84 f8 00 00 00    	je     c80 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 b88:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 b8e:	83 f9 70             	cmp    $0x70,%ecx
 b91:	74 5d                	je     bf0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 b93:	83 f8 73             	cmp    $0x73,%eax
 b96:	0f 84 84 00 00 00    	je     c20 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 b9c:	83 f8 63             	cmp    $0x63,%eax
 b9f:	0f 84 ea 00 00 00    	je     c8f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 ba5:	83 f8 25             	cmp    $0x25,%eax
 ba8:	0f 84 c2 00 00 00    	je     c70 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 bae:	8d 45 e7             	lea    -0x19(%ebp),%eax
 bb1:	83 ec 04             	sub    $0x4,%esp
 bb4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 bb8:	6a 01                	push   $0x1
 bba:	50                   	push   %eax
 bbb:	57                   	push   %edi
 bbc:	e8 01 fe ff ff       	call   9c2 <write>
 bc1:	83 c4 0c             	add    $0xc,%esp
 bc4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 bc7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 bca:	6a 01                	push   $0x1
 bcc:	50                   	push   %eax
 bcd:	57                   	push   %edi
 bce:	83 c6 01             	add    $0x1,%esi
 bd1:	e8 ec fd ff ff       	call   9c2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 bd6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 bda:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 bdd:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 bdf:	84 db                	test   %bl,%bl
 be1:	75 8d                	jne    b70 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 be3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 be6:	5b                   	pop    %ebx
 be7:	5e                   	pop    %esi
 be8:	5f                   	pop    %edi
 be9:	5d                   	pop    %ebp
 bea:	c3                   	ret    
 beb:	90                   	nop
 bec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 bf0:	83 ec 0c             	sub    $0xc,%esp
 bf3:	b9 10 00 00 00       	mov    $0x10,%ecx
 bf8:	6a 00                	push   $0x0
 bfa:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 bfd:	89 f8                	mov    %edi,%eax
 bff:	8b 13                	mov    (%ebx),%edx
 c01:	e8 6a fe ff ff       	call   a70 <printint>
        ap++;
 c06:	89 d8                	mov    %ebx,%eax
 c08:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 c0b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 c0d:	83 c0 04             	add    $0x4,%eax
 c10:	89 45 d0             	mov    %eax,-0x30(%ebp)
 c13:	e9 4d ff ff ff       	jmp    b65 <printf+0x55>
 c18:	90                   	nop
 c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 c20:	8b 45 d0             	mov    -0x30(%ebp),%eax
 c23:	8b 18                	mov    (%eax),%ebx
        ap++;
 c25:	83 c0 04             	add    $0x4,%eax
 c28:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 c2b:	b8 12 0f 00 00       	mov    $0xf12,%eax
 c30:	85 db                	test   %ebx,%ebx
 c32:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 c35:	0f b6 03             	movzbl (%ebx),%eax
 c38:	84 c0                	test   %al,%al
 c3a:	74 23                	je     c5f <printf+0x14f>
 c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 c40:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 c43:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 c46:	83 ec 04             	sub    $0x4,%esp
 c49:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 c4b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 c4e:	50                   	push   %eax
 c4f:	57                   	push   %edi
 c50:	e8 6d fd ff ff       	call   9c2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 c55:	0f b6 03             	movzbl (%ebx),%eax
 c58:	83 c4 10             	add    $0x10,%esp
 c5b:	84 c0                	test   %al,%al
 c5d:	75 e1                	jne    c40 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 c5f:	31 d2                	xor    %edx,%edx
 c61:	e9 ff fe ff ff       	jmp    b65 <printf+0x55>
 c66:	8d 76 00             	lea    0x0(%esi),%esi
 c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 c70:	83 ec 04             	sub    $0x4,%esp
 c73:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 c76:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 c79:	6a 01                	push   $0x1
 c7b:	e9 4c ff ff ff       	jmp    bcc <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 c80:	83 ec 0c             	sub    $0xc,%esp
 c83:	b9 0a 00 00 00       	mov    $0xa,%ecx
 c88:	6a 01                	push   $0x1
 c8a:	e9 6b ff ff ff       	jmp    bfa <printf+0xea>
 c8f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 c92:	83 ec 04             	sub    $0x4,%esp
 c95:	8b 03                	mov    (%ebx),%eax
 c97:	6a 01                	push   $0x1
 c99:	88 45 e4             	mov    %al,-0x1c(%ebp)
 c9c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 c9f:	50                   	push   %eax
 ca0:	57                   	push   %edi
 ca1:	e8 1c fd ff ff       	call   9c2 <write>
 ca6:	e9 5b ff ff ff       	jmp    c06 <printf+0xf6>
 cab:	66 90                	xchg   %ax,%ax
 cad:	66 90                	xchg   %ax,%ax
 caf:	90                   	nop

00000cb0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 cb0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 cb1:	a1 a8 13 00 00       	mov    0x13a8,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 cb6:	89 e5                	mov    %esp,%ebp
 cb8:	57                   	push   %edi
 cb9:	56                   	push   %esi
 cba:	53                   	push   %ebx
 cbb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 cbe:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 cc0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 cc3:	39 c8                	cmp    %ecx,%eax
 cc5:	73 19                	jae    ce0 <free+0x30>
 cc7:	89 f6                	mov    %esi,%esi
 cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 cd0:	39 d1                	cmp    %edx,%ecx
 cd2:	72 1c                	jb     cf0 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 cd4:	39 d0                	cmp    %edx,%eax
 cd6:	73 18                	jae    cf0 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 cd8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 cda:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 cdc:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 cde:	72 f0                	jb     cd0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ce0:	39 d0                	cmp    %edx,%eax
 ce2:	72 f4                	jb     cd8 <free+0x28>
 ce4:	39 d1                	cmp    %edx,%ecx
 ce6:	73 f0                	jae    cd8 <free+0x28>
 ce8:	90                   	nop
 ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 cf0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 cf3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 cf6:	39 d7                	cmp    %edx,%edi
 cf8:	74 19                	je     d13 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 cfa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 cfd:	8b 50 04             	mov    0x4(%eax),%edx
 d00:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 d03:	39 f1                	cmp    %esi,%ecx
 d05:	74 23                	je     d2a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 d07:	89 08                	mov    %ecx,(%eax)
  freep = p;
 d09:	a3 a8 13 00 00       	mov    %eax,0x13a8
}
 d0e:	5b                   	pop    %ebx
 d0f:	5e                   	pop    %esi
 d10:	5f                   	pop    %edi
 d11:	5d                   	pop    %ebp
 d12:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 d13:	03 72 04             	add    0x4(%edx),%esi
 d16:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 d19:	8b 10                	mov    (%eax),%edx
 d1b:	8b 12                	mov    (%edx),%edx
 d1d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 d20:	8b 50 04             	mov    0x4(%eax),%edx
 d23:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 d26:	39 f1                	cmp    %esi,%ecx
 d28:	75 dd                	jne    d07 <free+0x57>
    p->s.size += bp->s.size;
 d2a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 d2d:	a3 a8 13 00 00       	mov    %eax,0x13a8
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 d32:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 d35:	8b 53 f8             	mov    -0x8(%ebx),%edx
 d38:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 d3a:	5b                   	pop    %ebx
 d3b:	5e                   	pop    %esi
 d3c:	5f                   	pop    %edi
 d3d:	5d                   	pop    %ebp
 d3e:	c3                   	ret    
 d3f:	90                   	nop

00000d40 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 d40:	55                   	push   %ebp
 d41:	89 e5                	mov    %esp,%ebp
 d43:	57                   	push   %edi
 d44:	56                   	push   %esi
 d45:	53                   	push   %ebx
 d46:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d49:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 d4c:	8b 15 a8 13 00 00    	mov    0x13a8,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d52:	8d 78 07             	lea    0x7(%eax),%edi
 d55:	c1 ef 03             	shr    $0x3,%edi
 d58:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 d5b:	85 d2                	test   %edx,%edx
 d5d:	0f 84 a3 00 00 00    	je     e06 <malloc+0xc6>
 d63:	8b 02                	mov    (%edx),%eax
 d65:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 d68:	39 cf                	cmp    %ecx,%edi
 d6a:	76 74                	jbe    de0 <malloc+0xa0>
 d6c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 d72:	be 00 10 00 00       	mov    $0x1000,%esi
 d77:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 d7e:	0f 43 f7             	cmovae %edi,%esi
 d81:	ba 00 80 00 00       	mov    $0x8000,%edx
 d86:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 d8c:	0f 46 da             	cmovbe %edx,%ebx
 d8f:	eb 10                	jmp    da1 <malloc+0x61>
 d91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d98:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 d9a:	8b 48 04             	mov    0x4(%eax),%ecx
 d9d:	39 cf                	cmp    %ecx,%edi
 d9f:	76 3f                	jbe    de0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 da1:	39 05 a8 13 00 00    	cmp    %eax,0x13a8
 da7:	89 c2                	mov    %eax,%edx
 da9:	75 ed                	jne    d98 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 dab:	83 ec 0c             	sub    $0xc,%esp
 dae:	53                   	push   %ebx
 daf:	e8 76 fc ff ff       	call   a2a <sbrk>
  if(p == (char*)-1)
 db4:	83 c4 10             	add    $0x10,%esp
 db7:	83 f8 ff             	cmp    $0xffffffff,%eax
 dba:	74 1c                	je     dd8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 dbc:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 dbf:	83 ec 0c             	sub    $0xc,%esp
 dc2:	83 c0 08             	add    $0x8,%eax
 dc5:	50                   	push   %eax
 dc6:	e8 e5 fe ff ff       	call   cb0 <free>
  return freep;
 dcb:	8b 15 a8 13 00 00    	mov    0x13a8,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 dd1:	83 c4 10             	add    $0x10,%esp
 dd4:	85 d2                	test   %edx,%edx
 dd6:	75 c0                	jne    d98 <malloc+0x58>
        return 0;
 dd8:	31 c0                	xor    %eax,%eax
 dda:	eb 1c                	jmp    df8 <malloc+0xb8>
 ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 de0:	39 cf                	cmp    %ecx,%edi
 de2:	74 1c                	je     e00 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 de4:	29 f9                	sub    %edi,%ecx
 de6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 de9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 dec:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 def:	89 15 a8 13 00 00    	mov    %edx,0x13a8
      return (void*)(p + 1);
 df5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 df8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 dfb:	5b                   	pop    %ebx
 dfc:	5e                   	pop    %esi
 dfd:	5f                   	pop    %edi
 dfe:	5d                   	pop    %ebp
 dff:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 e00:	8b 08                	mov    (%eax),%ecx
 e02:	89 0a                	mov    %ecx,(%edx)
 e04:	eb e9                	jmp    def <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 e06:	c7 05 a8 13 00 00 ac 	movl   $0x13ac,0x13a8
 e0d:	13 00 00 
 e10:	c7 05 ac 13 00 00 ac 	movl   $0x13ac,0x13ac
 e17:	13 00 00 
    base.s.size = 0;
 e1a:	b8 ac 13 00 00       	mov    $0x13ac,%eax
 e1f:	c7 05 b0 13 00 00 00 	movl   $0x0,0x13b0
 e26:	00 00 00 
 e29:	e9 3e ff ff ff       	jmp    d6c <malloc+0x2c>
