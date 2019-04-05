
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
  18:	68 00 10 00 00       	push   $0x1000
  1d:	e8 50 07 00 00       	call   772 <captsc>
	drawHeader();
  22:	e8 29 02 00 00       	call   250 <drawHeader>
	updatesc(50, 0, "                         v0.1 ", UI_COLOR);
}

void
drawFooter() {
	updatesc(0, 24, " ^Q - Quit                                                                      ", UI_COLOR);
  27:	68 c0 00 00 00       	push   $0xc0
  2c:	68 a0 0b 00 00       	push   $0xba0
  31:	6a 18                	push   $0x18
  33:	6a 00                	push   $0x0
  35:	e8 48 07 00 00       	call   782 <updatesc>
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
  45:	68 27 0c 00 00       	push   $0xc27
  4a:	6a 01                	push   $0x1
  4c:	e8 ef 07 00 00       	call   840 <printf>
  51:	83 c4 10             	add    $0x10,%esp
  54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	}
	while(1) {
		while ((c = getkey()) <= 0) {
  58:	e8 2d 07 00 00       	call   78a <getkey>
  5d:	85 c0                	test   %eax,%eax
  5f:	a3 00 10 00 00       	mov    %eax,0x1000
  64:	7e f2                	jle    58 <main+0x58>
		}
		handleInput(c);
  66:	83 ec 0c             	sub    $0xc,%esp
  69:	50                   	push   %eax
  6a:	e8 81 03 00 00       	call   3f0 <handleInput>
		c = 0;
  6f:	c7 05 00 10 00 00 00 	movl   $0x0,0x1000
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
  86:	e8 87 06 00 00       	call   712 <open>
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
  9c:	ff 35 28 10 00 00    	pushl  0x1028
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
  b2:	68 17 0c 00 00       	push   $0xc17
  b7:	6a 01                	push   $0x1
  b9:	e8 82 07 00 00       	call   840 <printf>
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
struct fileline* firstOnScreen;
struct fileline* lastOnScreen;

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
struct fileline* firstOnScreen;
struct fileline* lastOnScreen;

void
initLinkedList(int fd)
{
  db:	83 ec 38             	sub    $0x38,%esp
	int n;
	char singlechar[1];
	head = malloc(sizeof(struct fileline));
  de:	6a 5c                	push   $0x5c
  e0:	e8 8b 09 00 00       	call   a70 <malloc>
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
  ea:	a3 28 10 00 00       	mov    %eax,0x1028
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
 109:	e8 dc 05 00 00       	call   6ea <read>
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
 142:	e8 29 09 00 00       	call   a70 <malloc>
			cur->filelinenum = linenumber;
 147:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
			cur->next = nextline;
			cur = nextline;
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
			linecounter++;
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
			linenumber++;
 153:	83 c1 01             	add    $0x1,%ecx
			}
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
			cur->filelinenum = linenumber;
			nextline->prev = cur;
 156:	89 58 54             	mov    %ebx,0x54(%eax)
			cur->next = nextline;
			cur = nextline;
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
			linecounter++;
			linenumber++;
 159:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
			cur->filelinenum = linenumber;
			nextline->prev = cur;
			cur->next = nextline;
 15c:	89 43 58             	mov    %eax,0x58(%ebx)
			cur = nextline;
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
			linecounter++;
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
			linecounter++;
			linenumber++;
		}
	}
	firstOnScreen = head;
 170:	a1 28 10 00 00       	mov    0x1028,%eax
 175:	a3 20 10 00 00       	mov    %eax,0x1020
	// 	printf(1, "%s", cur->line);
	// 	cur = cur->next;
	// }
	// printf(1, "%s", cur->line);

}
 17a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 17d:	5b                   	pop    %ebx
 17e:	5e                   	pop    %esi
 17f:	5f                   	pop    %edi
 180:	5d                   	pop    %ebp
 181:	c3                   	ret    
 182:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

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
 1b0:	c6 84 03 40 10 00 00 	movb   $0x20,0x1040(%ebx,%eax,1)
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
 1c9:	88 94 03 40 10 00 00 	mov    %dl,0x1040(%ebx,%eax,1)
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
 1f8:	c6 84 03 40 10 00 00 	movb   $0x20,0x1040(%ebx,%eax,1)
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
 211:	88 94 03 40 10 00 00 	mov    %dl,0x1040(%ebx,%eax,1)
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
 222:	68 40 10 00 00       	push   $0x1040
 227:	6a 01                	push   $0x1
 229:	6a 00                	push   $0x0
			}
			bufindex++;
	}
	lastOnScreen = cur;

	buf[bufindex] = '\0';
 22b:	c6 83 90 10 00 00 00 	movb   $0x0,0x1090(%ebx)
			} else{
				buf[bufindex] = cur->line[i];
			}
			bufindex++;
	}
	lastOnScreen = cur;
 232:	89 0d 24 10 00 00    	mov    %ecx,0x1024

	buf[bufindex] = '\0';
	//printf(1, "%s\n", buf);
	updatesc(0, 1, buf, TEXT_COLOR);
 238:	e8 45 05 00 00       	call   782 <updatesc>
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
 25b:	68 60 0b 00 00       	push   $0xb60
 260:	6a 00                	push   $0x0
 262:	6a 00                	push   $0x0
 264:	e8 19 05 00 00       	call   782 <updatesc>
	updatesc(30, 0, "        PICO        ", UI_COLOR);
 269:	68 c0 00 00 00       	push   $0xc0
 26e:	68 f4 0b 00 00       	push   $0xbf4
 273:	6a 00                	push   $0x0
 275:	6a 1e                	push   $0x1e
 277:	e8 06 05 00 00       	call   782 <updatesc>
	updatesc(50, 0, "                         v0.1 ", UI_COLOR);
 27c:	83 c4 20             	add    $0x20,%esp
 27f:	68 c0 00 00 00       	push   $0xc0
 284:	68 80 0b 00 00       	push   $0xb80
 289:	6a 00                	push   $0x0
 28b:	6a 32                	push   $0x32
 28d:	e8 f0 04 00 00       	call   782 <updatesc>
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
 2ab:	68 a0 0b 00 00       	push   $0xba0
 2b0:	6a 18                	push   $0x18
 2b2:	6a 00                	push   $0x0
 2b4:	e8 c9 04 00 00       	call   782 <updatesc>
}
 2b9:	83 c4 10             	add    $0x10,%esp
 2bc:	c9                   	leave  
 2bd:	c3                   	ret    
 2be:	66 90                	xchg   %ax,%ax

000002c0 <arrowkeys>:


void
arrowkeys(int i){
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	83 ec 08             	sub    $0x8,%esp
 2c6:	8b 45 08             	mov    0x8(%ebp),%eax
	//ctrl+j (go left)
	if(i == 10 && (currChar % WIDTH != 0) && currChar > 0){
 2c9:	83 f8 0a             	cmp    $0xa,%eax
 2cc:	0f 84 be 00 00 00    	je     390 <arrowkeys+0xd0>
		currChar--;
	}
	//ctrl+l (go right)
	else if(i==12 && ((currChar+1) % WIDTH != 0)){
 2d2:	83 f8 0c             	cmp    $0xc,%eax
 2d5:	74 49                	je     320 <arrowkeys+0x60>
		currChar++;
	}
	//ctrl+k (go down)
	else if(i == 11){
 2d7:	83 f8 0b             	cmp    $0xb,%eax
 2da:	74 74                	je     350 <arrowkeys+0x90>
				firstOnScreen = firstOnScreen->next;
			}
		}
	}
	//ctrl+i (go up)
	else if(i == 9){
 2dc:	83 f8 09             	cmp    $0x9,%eax
 2df:	75 33                	jne    314 <arrowkeys+0x54>
		if(currChar >= WIDTH){
 2e1:	a1 04 10 00 00       	mov    0x1004,%eax
 2e6:	83 f8 4f             	cmp    $0x4f,%eax
 2e9:	0f 8f f1 00 00 00    	jg     3e0 <arrowkeys+0x120>
			currChar -= WIDTH;
		}
		else{
			if(firstOnScreen->prev != 0){
 2ef:	a1 20 10 00 00       	mov    0x1020,%eax
 2f4:	8b 40 54             	mov    0x54(%eax),%eax
 2f7:	85 c0                	test   %eax,%eax
 2f9:	74 19                	je     314 <arrowkeys+0x54>
				printfile(firstOnScreen->prev);
 2fb:	83 ec 0c             	sub    $0xc,%esp
 2fe:	50                   	push   %eax
 2ff:	e8 8c fe ff ff       	call   190 <printfile>
				firstOnScreen = firstOnScreen->prev;
 304:	a1 20 10 00 00       	mov    0x1020,%eax
 309:	83 c4 10             	add    $0x10,%esp
 30c:	8b 40 54             	mov    0x54(%eax),%eax
 30f:	a3 20 10 00 00       	mov    %eax,0x1020
			}
		}
	}
}
 314:	c9                   	leave  
 315:	c3                   	ret    
 316:	8d 76 00             	lea    0x0(%esi),%esi
 319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	//ctrl+j (go left)
	if(i == 10 && (currChar % WIDTH != 0) && currChar > 0){
		currChar--;
	}
	//ctrl+l (go right)
	else if(i==12 && ((currChar+1) % WIDTH != 0)){
 320:	a1 04 10 00 00       	mov    0x1004,%eax
 325:	ba 67 66 66 66       	mov    $0x66666667,%edx
 32a:	8d 48 01             	lea    0x1(%eax),%ecx
 32d:	89 c8                	mov    %ecx,%eax
 32f:	f7 ea                	imul   %edx
 331:	89 c8                	mov    %ecx,%eax
 333:	c1 f8 1f             	sar    $0x1f,%eax
 336:	c1 fa 05             	sar    $0x5,%edx
 339:	29 c2                	sub    %eax,%edx
 33b:	8d 04 92             	lea    (%edx,%edx,4),%eax
 33e:	c1 e0 04             	shl    $0x4,%eax
 341:	39 c1                	cmp    %eax,%ecx
 343:	74 cf                	je     314 <arrowkeys+0x54>
		currChar++;
 345:	89 0d 04 10 00 00    	mov    %ecx,0x1004
				printfile(firstOnScreen->prev);
				firstOnScreen = firstOnScreen->prev;
			}
		}
	}
}
 34b:	c9                   	leave  
 34c:	c3                   	ret    
 34d:	8d 76 00             	lea    0x0(%esi),%esi
	else if(i==12 && ((currChar+1) % WIDTH != 0)){
		currChar++;
	}
	//ctrl+k (go down)
	else if(i == 11){
		if(currChar < TOTAL_CHARS - WIDTH){
 350:	a1 04 10 00 00       	mov    0x1004,%eax
 355:	3d df 06 00 00       	cmp    $0x6df,%eax
 35a:	7e 74                	jle    3d0 <arrowkeys+0x110>
			currChar += WIDTH;
		}
		else{
			//scroll down
			if(lastOnScreen->next != 0){
 35c:	a1 24 10 00 00       	mov    0x1024,%eax
 361:	8b 40 58             	mov    0x58(%eax),%eax
 364:	85 c0                	test   %eax,%eax
 366:	74 ac                	je     314 <arrowkeys+0x54>
				printfile(firstOnScreen->next);
 368:	a1 20 10 00 00       	mov    0x1020,%eax
 36d:	83 ec 0c             	sub    $0xc,%esp
 370:	ff 70 58             	pushl  0x58(%eax)
 373:	e8 18 fe ff ff       	call   190 <printfile>
				firstOnScreen = firstOnScreen->next;
 378:	a1 20 10 00 00       	mov    0x1020,%eax
 37d:	83 c4 10             	add    $0x10,%esp
 380:	8b 40 58             	mov    0x58(%eax),%eax
 383:	a3 20 10 00 00       	mov    %eax,0x1020
				printfile(firstOnScreen->prev);
				firstOnScreen = firstOnScreen->prev;
			}
		}
	}
}
 388:	c9                   	leave  
 389:	c3                   	ret    
 38a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi


void
arrowkeys(int i){
	//ctrl+j (go left)
	if(i == 10 && (currChar % WIDTH != 0) && currChar > 0){
 390:	8b 0d 04 10 00 00    	mov    0x1004,%ecx
 396:	ba 67 66 66 66       	mov    $0x66666667,%edx
 39b:	89 c8                	mov    %ecx,%eax
 39d:	f7 ea                	imul   %edx
 39f:	89 c8                	mov    %ecx,%eax
 3a1:	c1 f8 1f             	sar    $0x1f,%eax
 3a4:	c1 fa 05             	sar    $0x5,%edx
 3a7:	29 c2                	sub    %eax,%edx
 3a9:	8d 04 92             	lea    (%edx,%edx,4),%eax
 3ac:	c1 e0 04             	shl    $0x4,%eax
 3af:	39 c1                	cmp    %eax,%ecx
 3b1:	0f 84 5d ff ff ff    	je     314 <arrowkeys+0x54>
 3b7:	85 c9                	test   %ecx,%ecx
 3b9:	0f 8e 55 ff ff ff    	jle    314 <arrowkeys+0x54>
		currChar--;
 3bf:	83 e9 01             	sub    $0x1,%ecx
 3c2:	89 0d 04 10 00 00    	mov    %ecx,0x1004
				printfile(firstOnScreen->prev);
				firstOnScreen = firstOnScreen->prev;
			}
		}
	}
}
 3c8:	c9                   	leave  
 3c9:	c3                   	ret    
 3ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		currChar++;
	}
	//ctrl+k (go down)
	else if(i == 11){
		if(currChar < TOTAL_CHARS - WIDTH){
			currChar += WIDTH;
 3d0:	83 c0 50             	add    $0x50,%eax
 3d3:	a3 04 10 00 00       	mov    %eax,0x1004
				printfile(firstOnScreen->prev);
				firstOnScreen = firstOnScreen->prev;
			}
		}
	}
}
 3d8:	c9                   	leave  
 3d9:	c3                   	ret    
 3da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		}
	}
	//ctrl+i (go up)
	else if(i == 9){
		if(currChar >= WIDTH){
			currChar -= WIDTH;
 3e0:	83 e8 50             	sub    $0x50,%eax
 3e3:	a3 04 10 00 00       	mov    %eax,0x1004
				printfile(firstOnScreen->prev);
				firstOnScreen = firstOnScreen->prev;
			}
		}
	}
}
 3e8:	c9                   	leave  
 3e9:	c3                   	ret    
 3ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003f0 <handleInput>:

void
handleInput(int i) {
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	56                   	push   %esi
 3f4:	53                   	push   %ebx
 3f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
	//ctrl+q
	if (i == 17) {
 3f8:	83 fb 11             	cmp    $0x11,%ebx
 3fb:	0f 84 7d 00 00 00    	je     47e <handleInput+0x8e>
		exit();
	}
	printf(1, "currChar: %d\n", currChar);
 401:	83 ec 04             	sub    $0x4,%esp
 404:	ff 35 04 10 00 00    	pushl  0x1004
 40a:	68 09 0c 00 00       	push   $0xc09
 40f:	6a 01                	push   $0x1
 411:	e8 2a 04 00 00       	call   840 <printf>
	if(i >= 9 && i<= 12){
 416:	8d 43 f7             	lea    -0x9(%ebx),%eax
 419:	83 c4 10             	add    $0x10,%esp
 41c:	83 f8 03             	cmp    $0x3,%eax
 41f:	76 4f                	jbe    470 <handleInput+0x80>
		arrowkeys(i);
	}
	//On right edge of window 
	else if((currChar+1) % WIDTH == 0){
 421:	8b 35 04 10 00 00    	mov    0x1004,%esi
 427:	ba 67 66 66 66       	mov    $0x66666667,%edx
 42c:	8d 4e 01             	lea    0x1(%esi),%ecx
 42f:	89 c8                	mov    %ecx,%eax
 431:	f7 ea                	imul   %edx
 433:	89 c8                	mov    %ecx,%eax
 435:	c1 f8 1f             	sar    $0x1f,%eax
 438:	c1 fa 05             	sar    $0x5,%edx
 43b:	29 c2                	sub    %eax,%edx
 43d:	8d 04 92             	lea    (%edx,%edx,4),%eax
 440:	c1 e0 04             	shl    $0x4,%eax
 443:	39 c1                	cmp    %eax,%ecx
 445:	74 06                	je     44d <handleInput+0x5d>
		buf[currChar] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
		// printf(1, "new input");
	}
	else{
		buf[currChar++] = (char) i & 0xff;
 447:	89 0d 04 10 00 00    	mov    %ecx,0x1004
		updatesc(0, 1, buf, TEXT_COLOR);
 44d:	6a 07                	push   $0x7
 44f:	68 40 10 00 00       	push   $0x1040
 454:	6a 01                	push   $0x1
 456:	6a 00                	push   $0x0
		buf[currChar] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
		// printf(1, "new input");
	}
	else{
		buf[currChar++] = (char) i & 0xff;
 458:	88 9e 40 10 00 00    	mov    %bl,0x1040(%esi)
		updatesc(0, 1, buf, TEXT_COLOR);
 45e:	e8 1f 03 00 00       	call   782 <updatesc>
 463:	83 c4 10             	add    $0x10,%esp
	}
}
 466:	8d 65 f8             	lea    -0x8(%ebp),%esp
 469:	5b                   	pop    %ebx
 46a:	5e                   	pop    %esi
 46b:	5d                   	pop    %ebp
 46c:	c3                   	ret    
 46d:	8d 76 00             	lea    0x0(%esi),%esi
	if (i == 17) {
		exit();
	}
	printf(1, "currChar: %d\n", currChar);
	if(i >= 9 && i<= 12){
		arrowkeys(i);
 470:	89 5d 08             	mov    %ebx,0x8(%ebp)
	}
	else{
		buf[currChar++] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
	}
}
 473:	8d 65 f8             	lea    -0x8(%ebp),%esp
 476:	5b                   	pop    %ebx
 477:	5e                   	pop    %esi
 478:	5d                   	pop    %ebp
	if (i == 17) {
		exit();
	}
	printf(1, "currChar: %d\n", currChar);
	if(i >= 9 && i<= 12){
		arrowkeys(i);
 479:	e9 42 fe ff ff       	jmp    2c0 <arrowkeys>

void
handleInput(int i) {
	//ctrl+q
	if (i == 17) {
		exit();
 47e:	e8 4f 02 00 00       	call   6d2 <exit>
 483:	66 90                	xchg   %ax,%ax
 485:	66 90                	xchg   %ax,%ax
 487:	66 90                	xchg   %ax,%ax
 489:	66 90                	xchg   %ax,%ax
 48b:	66 90                	xchg   %ax,%ax
 48d:	66 90                	xchg   %ax,%ax
 48f:	90                   	nop

00000490 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	53                   	push   %ebx
 494:	8b 45 08             	mov    0x8(%ebp),%eax
 497:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 49a:	89 c2                	mov    %eax,%edx
 49c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4a0:	83 c1 01             	add    $0x1,%ecx
 4a3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 4a7:	83 c2 01             	add    $0x1,%edx
 4aa:	84 db                	test   %bl,%bl
 4ac:	88 5a ff             	mov    %bl,-0x1(%edx)
 4af:	75 ef                	jne    4a0 <strcpy+0x10>
    ;
  return os;
}
 4b1:	5b                   	pop    %ebx
 4b2:	5d                   	pop    %ebp
 4b3:	c3                   	ret    
 4b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000004c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	56                   	push   %esi
 4c4:	53                   	push   %ebx
 4c5:	8b 55 08             	mov    0x8(%ebp),%edx
 4c8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 4cb:	0f b6 02             	movzbl (%edx),%eax
 4ce:	0f b6 19             	movzbl (%ecx),%ebx
 4d1:	84 c0                	test   %al,%al
 4d3:	75 1e                	jne    4f3 <strcmp+0x33>
 4d5:	eb 29                	jmp    500 <strcmp+0x40>
 4d7:	89 f6                	mov    %esi,%esi
 4d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 4e0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 4e3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 4e6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 4e9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 4ed:	84 c0                	test   %al,%al
 4ef:	74 0f                	je     500 <strcmp+0x40>
 4f1:	89 f1                	mov    %esi,%ecx
 4f3:	38 d8                	cmp    %bl,%al
 4f5:	74 e9                	je     4e0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 4f7:	29 d8                	sub    %ebx,%eax
}
 4f9:	5b                   	pop    %ebx
 4fa:	5e                   	pop    %esi
 4fb:	5d                   	pop    %ebp
 4fc:	c3                   	ret    
 4fd:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 500:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 502:	29 d8                	sub    %ebx,%eax
}
 504:	5b                   	pop    %ebx
 505:	5e                   	pop    %esi
 506:	5d                   	pop    %ebp
 507:	c3                   	ret    
 508:	90                   	nop
 509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000510 <strlen>:

uint
strlen(char *s)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 516:	80 39 00             	cmpb   $0x0,(%ecx)
 519:	74 12                	je     52d <strlen+0x1d>
 51b:	31 d2                	xor    %edx,%edx
 51d:	8d 76 00             	lea    0x0(%esi),%esi
 520:	83 c2 01             	add    $0x1,%edx
 523:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 527:	89 d0                	mov    %edx,%eax
 529:	75 f5                	jne    520 <strlen+0x10>
    ;
  return n;
}
 52b:	5d                   	pop    %ebp
 52c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 52d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 52f:	5d                   	pop    %ebp
 530:	c3                   	ret    
 531:	eb 0d                	jmp    540 <memset>
 533:	90                   	nop
 534:	90                   	nop
 535:	90                   	nop
 536:	90                   	nop
 537:	90                   	nop
 538:	90                   	nop
 539:	90                   	nop
 53a:	90                   	nop
 53b:	90                   	nop
 53c:	90                   	nop
 53d:	90                   	nop
 53e:	90                   	nop
 53f:	90                   	nop

00000540 <memset>:

void*
memset(void *dst, int c, uint n)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	57                   	push   %edi
 544:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 547:	8b 4d 10             	mov    0x10(%ebp),%ecx
 54a:	8b 45 0c             	mov    0xc(%ebp),%eax
 54d:	89 d7                	mov    %edx,%edi
 54f:	fc                   	cld    
 550:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 552:	89 d0                	mov    %edx,%eax
 554:	5f                   	pop    %edi
 555:	5d                   	pop    %ebp
 556:	c3                   	ret    
 557:	89 f6                	mov    %esi,%esi
 559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000560 <strchr>:

char*
strchr(const char *s, char c)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	53                   	push   %ebx
 564:	8b 45 08             	mov    0x8(%ebp),%eax
 567:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 56a:	0f b6 10             	movzbl (%eax),%edx
 56d:	84 d2                	test   %dl,%dl
 56f:	74 1d                	je     58e <strchr+0x2e>
    if(*s == c)
 571:	38 d3                	cmp    %dl,%bl
 573:	89 d9                	mov    %ebx,%ecx
 575:	75 0d                	jne    584 <strchr+0x24>
 577:	eb 17                	jmp    590 <strchr+0x30>
 579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 580:	38 ca                	cmp    %cl,%dl
 582:	74 0c                	je     590 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 584:	83 c0 01             	add    $0x1,%eax
 587:	0f b6 10             	movzbl (%eax),%edx
 58a:	84 d2                	test   %dl,%dl
 58c:	75 f2                	jne    580 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 58e:	31 c0                	xor    %eax,%eax
}
 590:	5b                   	pop    %ebx
 591:	5d                   	pop    %ebp
 592:	c3                   	ret    
 593:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005a0 <gets>:

char*
gets(char *buf, int max)
{
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	57                   	push   %edi
 5a4:	56                   	push   %esi
 5a5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 5a6:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 5a8:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 5ab:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 5ae:	eb 29                	jmp    5d9 <gets+0x39>
    cc = read(0, &c, 1);
 5b0:	83 ec 04             	sub    $0x4,%esp
 5b3:	6a 01                	push   $0x1
 5b5:	57                   	push   %edi
 5b6:	6a 00                	push   $0x0
 5b8:	e8 2d 01 00 00       	call   6ea <read>
    if(cc < 1)
 5bd:	83 c4 10             	add    $0x10,%esp
 5c0:	85 c0                	test   %eax,%eax
 5c2:	7e 1d                	jle    5e1 <gets+0x41>
      break;
    buf[i++] = c;
 5c4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 5c8:	8b 55 08             	mov    0x8(%ebp),%edx
 5cb:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 5cd:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 5cf:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 5d3:	74 1b                	je     5f0 <gets+0x50>
 5d5:	3c 0d                	cmp    $0xd,%al
 5d7:	74 17                	je     5f0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 5d9:	8d 5e 01             	lea    0x1(%esi),%ebx
 5dc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 5df:	7c cf                	jl     5b0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 5e1:	8b 45 08             	mov    0x8(%ebp),%eax
 5e4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 5e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5eb:	5b                   	pop    %ebx
 5ec:	5e                   	pop    %esi
 5ed:	5f                   	pop    %edi
 5ee:	5d                   	pop    %ebp
 5ef:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 5f0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 5f3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 5f5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 5f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5fc:	5b                   	pop    %ebx
 5fd:	5e                   	pop    %esi
 5fe:	5f                   	pop    %edi
 5ff:	5d                   	pop    %ebp
 600:	c3                   	ret    
 601:	eb 0d                	jmp    610 <stat>
 603:	90                   	nop
 604:	90                   	nop
 605:	90                   	nop
 606:	90                   	nop
 607:	90                   	nop
 608:	90                   	nop
 609:	90                   	nop
 60a:	90                   	nop
 60b:	90                   	nop
 60c:	90                   	nop
 60d:	90                   	nop
 60e:	90                   	nop
 60f:	90                   	nop

00000610 <stat>:

int
stat(char *n, struct stat *st)
{
 610:	55                   	push   %ebp
 611:	89 e5                	mov    %esp,%ebp
 613:	56                   	push   %esi
 614:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 615:	83 ec 08             	sub    $0x8,%esp
 618:	6a 00                	push   $0x0
 61a:	ff 75 08             	pushl  0x8(%ebp)
 61d:	e8 f0 00 00 00       	call   712 <open>
  if(fd < 0)
 622:	83 c4 10             	add    $0x10,%esp
 625:	85 c0                	test   %eax,%eax
 627:	78 27                	js     650 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 629:	83 ec 08             	sub    $0x8,%esp
 62c:	ff 75 0c             	pushl  0xc(%ebp)
 62f:	89 c3                	mov    %eax,%ebx
 631:	50                   	push   %eax
 632:	e8 f3 00 00 00       	call   72a <fstat>
 637:	89 c6                	mov    %eax,%esi
  close(fd);
 639:	89 1c 24             	mov    %ebx,(%esp)
 63c:	e8 b9 00 00 00       	call   6fa <close>
  return r;
 641:	83 c4 10             	add    $0x10,%esp
 644:	89 f0                	mov    %esi,%eax
}
 646:	8d 65 f8             	lea    -0x8(%ebp),%esp
 649:	5b                   	pop    %ebx
 64a:	5e                   	pop    %esi
 64b:	5d                   	pop    %ebp
 64c:	c3                   	ret    
 64d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 650:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 655:	eb ef                	jmp    646 <stat+0x36>
 657:	89 f6                	mov    %esi,%esi
 659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000660 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 660:	55                   	push   %ebp
 661:	89 e5                	mov    %esp,%ebp
 663:	53                   	push   %ebx
 664:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 667:	0f be 11             	movsbl (%ecx),%edx
 66a:	8d 42 d0             	lea    -0x30(%edx),%eax
 66d:	3c 09                	cmp    $0x9,%al
 66f:	b8 00 00 00 00       	mov    $0x0,%eax
 674:	77 1f                	ja     695 <atoi+0x35>
 676:	8d 76 00             	lea    0x0(%esi),%esi
 679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 680:	8d 04 80             	lea    (%eax,%eax,4),%eax
 683:	83 c1 01             	add    $0x1,%ecx
 686:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 68a:	0f be 11             	movsbl (%ecx),%edx
 68d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 690:	80 fb 09             	cmp    $0x9,%bl
 693:	76 eb                	jbe    680 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 695:	5b                   	pop    %ebx
 696:	5d                   	pop    %ebp
 697:	c3                   	ret    
 698:	90                   	nop
 699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006a0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	56                   	push   %esi
 6a4:	53                   	push   %ebx
 6a5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 6a8:	8b 45 08             	mov    0x8(%ebp),%eax
 6ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 6ae:	85 db                	test   %ebx,%ebx
 6b0:	7e 14                	jle    6c6 <memmove+0x26>
 6b2:	31 d2                	xor    %edx,%edx
 6b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 6b8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 6bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 6bf:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 6c2:	39 da                	cmp    %ebx,%edx
 6c4:	75 f2                	jne    6b8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 6c6:	5b                   	pop    %ebx
 6c7:	5e                   	pop    %esi
 6c8:	5d                   	pop    %ebp
 6c9:	c3                   	ret    

000006ca <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 6ca:	b8 01 00 00 00       	mov    $0x1,%eax
 6cf:	cd 40                	int    $0x40
 6d1:	c3                   	ret    

000006d2 <exit>:
SYSCALL(exit)
 6d2:	b8 02 00 00 00       	mov    $0x2,%eax
 6d7:	cd 40                	int    $0x40
 6d9:	c3                   	ret    

000006da <wait>:
SYSCALL(wait)
 6da:	b8 03 00 00 00       	mov    $0x3,%eax
 6df:	cd 40                	int    $0x40
 6e1:	c3                   	ret    

000006e2 <pipe>:
SYSCALL(pipe)
 6e2:	b8 04 00 00 00       	mov    $0x4,%eax
 6e7:	cd 40                	int    $0x40
 6e9:	c3                   	ret    

000006ea <read>:
SYSCALL(read)
 6ea:	b8 05 00 00 00       	mov    $0x5,%eax
 6ef:	cd 40                	int    $0x40
 6f1:	c3                   	ret    

000006f2 <write>:
SYSCALL(write)
 6f2:	b8 10 00 00 00       	mov    $0x10,%eax
 6f7:	cd 40                	int    $0x40
 6f9:	c3                   	ret    

000006fa <close>:
SYSCALL(close)
 6fa:	b8 15 00 00 00       	mov    $0x15,%eax
 6ff:	cd 40                	int    $0x40
 701:	c3                   	ret    

00000702 <kill>:
SYSCALL(kill)
 702:	b8 06 00 00 00       	mov    $0x6,%eax
 707:	cd 40                	int    $0x40
 709:	c3                   	ret    

0000070a <exec>:
SYSCALL(exec)
 70a:	b8 07 00 00 00       	mov    $0x7,%eax
 70f:	cd 40                	int    $0x40
 711:	c3                   	ret    

00000712 <open>:
SYSCALL(open)
 712:	b8 0f 00 00 00       	mov    $0xf,%eax
 717:	cd 40                	int    $0x40
 719:	c3                   	ret    

0000071a <mknod>:
SYSCALL(mknod)
 71a:	b8 11 00 00 00       	mov    $0x11,%eax
 71f:	cd 40                	int    $0x40
 721:	c3                   	ret    

00000722 <unlink>:
SYSCALL(unlink)
 722:	b8 12 00 00 00       	mov    $0x12,%eax
 727:	cd 40                	int    $0x40
 729:	c3                   	ret    

0000072a <fstat>:
SYSCALL(fstat)
 72a:	b8 08 00 00 00       	mov    $0x8,%eax
 72f:	cd 40                	int    $0x40
 731:	c3                   	ret    

00000732 <link>:
SYSCALL(link)
 732:	b8 13 00 00 00       	mov    $0x13,%eax
 737:	cd 40                	int    $0x40
 739:	c3                   	ret    

0000073a <mkdir>:
SYSCALL(mkdir)
 73a:	b8 14 00 00 00       	mov    $0x14,%eax
 73f:	cd 40                	int    $0x40
 741:	c3                   	ret    

00000742 <chdir>:
SYSCALL(chdir)
 742:	b8 09 00 00 00       	mov    $0x9,%eax
 747:	cd 40                	int    $0x40
 749:	c3                   	ret    

0000074a <dup>:
SYSCALL(dup)
 74a:	b8 0a 00 00 00       	mov    $0xa,%eax
 74f:	cd 40                	int    $0x40
 751:	c3                   	ret    

00000752 <getpid>:
SYSCALL(getpid)
 752:	b8 0b 00 00 00       	mov    $0xb,%eax
 757:	cd 40                	int    $0x40
 759:	c3                   	ret    

0000075a <sbrk>:
SYSCALL(sbrk)
 75a:	b8 0c 00 00 00       	mov    $0xc,%eax
 75f:	cd 40                	int    $0x40
 761:	c3                   	ret    

00000762 <sleep>:
SYSCALL(sleep)
 762:	b8 0d 00 00 00       	mov    $0xd,%eax
 767:	cd 40                	int    $0x40
 769:	c3                   	ret    

0000076a <uptime>:
SYSCALL(uptime)
 76a:	b8 0e 00 00 00       	mov    $0xe,%eax
 76f:	cd 40                	int    $0x40
 771:	c3                   	ret    

00000772 <captsc>:
SYSCALL(captsc)
 772:	b8 16 00 00 00       	mov    $0x16,%eax
 777:	cd 40                	int    $0x40
 779:	c3                   	ret    

0000077a <freesc>:
SYSCALL(freesc)
 77a:	b8 17 00 00 00       	mov    $0x17,%eax
 77f:	cd 40                	int    $0x40
 781:	c3                   	ret    

00000782 <updatesc>:
SYSCALL(updatesc)
 782:	b8 18 00 00 00       	mov    $0x18,%eax
 787:	cd 40                	int    $0x40
 789:	c3                   	ret    

0000078a <getkey>:
SYSCALL(getkey)
 78a:	b8 19 00 00 00       	mov    $0x19,%eax
 78f:	cd 40                	int    $0x40
 791:	c3                   	ret    
 792:	66 90                	xchg   %ax,%ax
 794:	66 90                	xchg   %ax,%ax
 796:	66 90                	xchg   %ax,%ax
 798:	66 90                	xchg   %ax,%ax
 79a:	66 90                	xchg   %ax,%ax
 79c:	66 90                	xchg   %ax,%ax
 79e:	66 90                	xchg   %ax,%ax

000007a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 7a0:	55                   	push   %ebp
 7a1:	89 e5                	mov    %esp,%ebp
 7a3:	57                   	push   %edi
 7a4:	56                   	push   %esi
 7a5:	53                   	push   %ebx
 7a6:	89 c6                	mov    %eax,%esi
 7a8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 7ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
 7ae:	85 db                	test   %ebx,%ebx
 7b0:	74 7e                	je     830 <printint+0x90>
 7b2:	89 d0                	mov    %edx,%eax
 7b4:	c1 e8 1f             	shr    $0x1f,%eax
 7b7:	84 c0                	test   %al,%al
 7b9:	74 75                	je     830 <printint+0x90>
    neg = 1;
    x = -xx;
 7bb:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 7bd:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 7c4:	f7 d8                	neg    %eax
 7c6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 7c9:	31 ff                	xor    %edi,%edi
 7cb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 7ce:	89 ce                	mov    %ecx,%esi
 7d0:	eb 08                	jmp    7da <printint+0x3a>
 7d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 7d8:	89 cf                	mov    %ecx,%edi
 7da:	31 d2                	xor    %edx,%edx
 7dc:	8d 4f 01             	lea    0x1(%edi),%ecx
 7df:	f7 f6                	div    %esi
 7e1:	0f b6 92 40 0c 00 00 	movzbl 0xc40(%edx),%edx
  }while((x /= base) != 0);
 7e8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 7ea:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 7ed:	75 e9                	jne    7d8 <printint+0x38>
  if(neg)
 7ef:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 7f2:	8b 75 c0             	mov    -0x40(%ebp),%esi
 7f5:	85 c0                	test   %eax,%eax
 7f7:	74 08                	je     801 <printint+0x61>
    buf[i++] = '-';
 7f9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 7fe:	8d 4f 02             	lea    0x2(%edi),%ecx
 801:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 805:	8d 76 00             	lea    0x0(%esi),%esi
 808:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 80b:	83 ec 04             	sub    $0x4,%esp
 80e:	83 ef 01             	sub    $0x1,%edi
 811:	6a 01                	push   $0x1
 813:	53                   	push   %ebx
 814:	56                   	push   %esi
 815:	88 45 d7             	mov    %al,-0x29(%ebp)
 818:	e8 d5 fe ff ff       	call   6f2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 81d:	83 c4 10             	add    $0x10,%esp
 820:	39 df                	cmp    %ebx,%edi
 822:	75 e4                	jne    808 <printint+0x68>
    putc(fd, buf[i]);
}
 824:	8d 65 f4             	lea    -0xc(%ebp),%esp
 827:	5b                   	pop    %ebx
 828:	5e                   	pop    %esi
 829:	5f                   	pop    %edi
 82a:	5d                   	pop    %ebp
 82b:	c3                   	ret    
 82c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 830:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 832:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 839:	eb 8b                	jmp    7c6 <printint+0x26>
 83b:	90                   	nop
 83c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000840 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 840:	55                   	push   %ebp
 841:	89 e5                	mov    %esp,%ebp
 843:	57                   	push   %edi
 844:	56                   	push   %esi
 845:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 846:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 849:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 84c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 84f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 852:	89 45 d0             	mov    %eax,-0x30(%ebp)
 855:	0f b6 1e             	movzbl (%esi),%ebx
 858:	83 c6 01             	add    $0x1,%esi
 85b:	84 db                	test   %bl,%bl
 85d:	0f 84 b0 00 00 00    	je     913 <printf+0xd3>
 863:	31 d2                	xor    %edx,%edx
 865:	eb 39                	jmp    8a0 <printf+0x60>
 867:	89 f6                	mov    %esi,%esi
 869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 870:	83 f8 25             	cmp    $0x25,%eax
 873:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 876:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 87b:	74 18                	je     895 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 87d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 880:	83 ec 04             	sub    $0x4,%esp
 883:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 886:	6a 01                	push   $0x1
 888:	50                   	push   %eax
 889:	57                   	push   %edi
 88a:	e8 63 fe ff ff       	call   6f2 <write>
 88f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 892:	83 c4 10             	add    $0x10,%esp
 895:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 898:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 89c:	84 db                	test   %bl,%bl
 89e:	74 73                	je     913 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 8a0:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 8a2:	0f be cb             	movsbl %bl,%ecx
 8a5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 8a8:	74 c6                	je     870 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 8aa:	83 fa 25             	cmp    $0x25,%edx
 8ad:	75 e6                	jne    895 <printf+0x55>
      if(c == 'd'){
 8af:	83 f8 64             	cmp    $0x64,%eax
 8b2:	0f 84 f8 00 00 00    	je     9b0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 8b8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 8be:	83 f9 70             	cmp    $0x70,%ecx
 8c1:	74 5d                	je     920 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 8c3:	83 f8 73             	cmp    $0x73,%eax
 8c6:	0f 84 84 00 00 00    	je     950 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 8cc:	83 f8 63             	cmp    $0x63,%eax
 8cf:	0f 84 ea 00 00 00    	je     9bf <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 8d5:	83 f8 25             	cmp    $0x25,%eax
 8d8:	0f 84 c2 00 00 00    	je     9a0 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8de:	8d 45 e7             	lea    -0x19(%ebp),%eax
 8e1:	83 ec 04             	sub    $0x4,%esp
 8e4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 8e8:	6a 01                	push   $0x1
 8ea:	50                   	push   %eax
 8eb:	57                   	push   %edi
 8ec:	e8 01 fe ff ff       	call   6f2 <write>
 8f1:	83 c4 0c             	add    $0xc,%esp
 8f4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 8f7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 8fa:	6a 01                	push   $0x1
 8fc:	50                   	push   %eax
 8fd:	57                   	push   %edi
 8fe:	83 c6 01             	add    $0x1,%esi
 901:	e8 ec fd ff ff       	call   6f2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 906:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 90a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 90d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 90f:	84 db                	test   %bl,%bl
 911:	75 8d                	jne    8a0 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 913:	8d 65 f4             	lea    -0xc(%ebp),%esp
 916:	5b                   	pop    %ebx
 917:	5e                   	pop    %esi
 918:	5f                   	pop    %edi
 919:	5d                   	pop    %ebp
 91a:	c3                   	ret    
 91b:	90                   	nop
 91c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 920:	83 ec 0c             	sub    $0xc,%esp
 923:	b9 10 00 00 00       	mov    $0x10,%ecx
 928:	6a 00                	push   $0x0
 92a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 92d:	89 f8                	mov    %edi,%eax
 92f:	8b 13                	mov    (%ebx),%edx
 931:	e8 6a fe ff ff       	call   7a0 <printint>
        ap++;
 936:	89 d8                	mov    %ebx,%eax
 938:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 93b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 93d:	83 c0 04             	add    $0x4,%eax
 940:	89 45 d0             	mov    %eax,-0x30(%ebp)
 943:	e9 4d ff ff ff       	jmp    895 <printf+0x55>
 948:	90                   	nop
 949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 950:	8b 45 d0             	mov    -0x30(%ebp),%eax
 953:	8b 18                	mov    (%eax),%ebx
        ap++;
 955:	83 c0 04             	add    $0x4,%eax
 958:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 95b:	b8 38 0c 00 00       	mov    $0xc38,%eax
 960:	85 db                	test   %ebx,%ebx
 962:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 965:	0f b6 03             	movzbl (%ebx),%eax
 968:	84 c0                	test   %al,%al
 96a:	74 23                	je     98f <printf+0x14f>
 96c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 970:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 973:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 976:	83 ec 04             	sub    $0x4,%esp
 979:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 97b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 97e:	50                   	push   %eax
 97f:	57                   	push   %edi
 980:	e8 6d fd ff ff       	call   6f2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 985:	0f b6 03             	movzbl (%ebx),%eax
 988:	83 c4 10             	add    $0x10,%esp
 98b:	84 c0                	test   %al,%al
 98d:	75 e1                	jne    970 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 98f:	31 d2                	xor    %edx,%edx
 991:	e9 ff fe ff ff       	jmp    895 <printf+0x55>
 996:	8d 76 00             	lea    0x0(%esi),%esi
 999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 9a0:	83 ec 04             	sub    $0x4,%esp
 9a3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 9a6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 9a9:	6a 01                	push   $0x1
 9ab:	e9 4c ff ff ff       	jmp    8fc <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 9b0:	83 ec 0c             	sub    $0xc,%esp
 9b3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 9b8:	6a 01                	push   $0x1
 9ba:	e9 6b ff ff ff       	jmp    92a <printf+0xea>
 9bf:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 9c2:	83 ec 04             	sub    $0x4,%esp
 9c5:	8b 03                	mov    (%ebx),%eax
 9c7:	6a 01                	push   $0x1
 9c9:	88 45 e4             	mov    %al,-0x1c(%ebp)
 9cc:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 9cf:	50                   	push   %eax
 9d0:	57                   	push   %edi
 9d1:	e8 1c fd ff ff       	call   6f2 <write>
 9d6:	e9 5b ff ff ff       	jmp    936 <printf+0xf6>
 9db:	66 90                	xchg   %ax,%ax
 9dd:	66 90                	xchg   %ax,%ax
 9df:	90                   	nop

000009e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9e1:	a1 08 10 00 00       	mov    0x1008,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 9e6:	89 e5                	mov    %esp,%ebp
 9e8:	57                   	push   %edi
 9e9:	56                   	push   %esi
 9ea:	53                   	push   %ebx
 9eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9ee:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9f0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9f3:	39 c8                	cmp    %ecx,%eax
 9f5:	73 19                	jae    a10 <free+0x30>
 9f7:	89 f6                	mov    %esi,%esi
 9f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 a00:	39 d1                	cmp    %edx,%ecx
 a02:	72 1c                	jb     a20 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a04:	39 d0                	cmp    %edx,%eax
 a06:	73 18                	jae    a20 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 a08:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a0a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a0c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a0e:	72 f0                	jb     a00 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a10:	39 d0                	cmp    %edx,%eax
 a12:	72 f4                	jb     a08 <free+0x28>
 a14:	39 d1                	cmp    %edx,%ecx
 a16:	73 f0                	jae    a08 <free+0x28>
 a18:	90                   	nop
 a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 a20:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a23:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a26:	39 d7                	cmp    %edx,%edi
 a28:	74 19                	je     a43 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 a2a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 a2d:	8b 50 04             	mov    0x4(%eax),%edx
 a30:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a33:	39 f1                	cmp    %esi,%ecx
 a35:	74 23                	je     a5a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 a37:	89 08                	mov    %ecx,(%eax)
  freep = p;
 a39:	a3 08 10 00 00       	mov    %eax,0x1008
}
 a3e:	5b                   	pop    %ebx
 a3f:	5e                   	pop    %esi
 a40:	5f                   	pop    %edi
 a41:	5d                   	pop    %ebp
 a42:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a43:	03 72 04             	add    0x4(%edx),%esi
 a46:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 a49:	8b 10                	mov    (%eax),%edx
 a4b:	8b 12                	mov    (%edx),%edx
 a4d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 a50:	8b 50 04             	mov    0x4(%eax),%edx
 a53:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a56:	39 f1                	cmp    %esi,%ecx
 a58:	75 dd                	jne    a37 <free+0x57>
    p->s.size += bp->s.size;
 a5a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 a5d:	a3 08 10 00 00       	mov    %eax,0x1008
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a62:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 a65:	8b 53 f8             	mov    -0x8(%ebx),%edx
 a68:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 a6a:	5b                   	pop    %ebx
 a6b:	5e                   	pop    %esi
 a6c:	5f                   	pop    %edi
 a6d:	5d                   	pop    %ebp
 a6e:	c3                   	ret    
 a6f:	90                   	nop

00000a70 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a70:	55                   	push   %ebp
 a71:	89 e5                	mov    %esp,%ebp
 a73:	57                   	push   %edi
 a74:	56                   	push   %esi
 a75:	53                   	push   %ebx
 a76:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a79:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 a7c:	8b 15 08 10 00 00    	mov    0x1008,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a82:	8d 78 07             	lea    0x7(%eax),%edi
 a85:	c1 ef 03             	shr    $0x3,%edi
 a88:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 a8b:	85 d2                	test   %edx,%edx
 a8d:	0f 84 a3 00 00 00    	je     b36 <malloc+0xc6>
 a93:	8b 02                	mov    (%edx),%eax
 a95:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 a98:	39 cf                	cmp    %ecx,%edi
 a9a:	76 74                	jbe    b10 <malloc+0xa0>
 a9c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 aa2:	be 00 10 00 00       	mov    $0x1000,%esi
 aa7:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 aae:	0f 43 f7             	cmovae %edi,%esi
 ab1:	ba 00 80 00 00       	mov    $0x8000,%edx
 ab6:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 abc:	0f 46 da             	cmovbe %edx,%ebx
 abf:	eb 10                	jmp    ad1 <malloc+0x61>
 ac1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ac8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 aca:	8b 48 04             	mov    0x4(%eax),%ecx
 acd:	39 cf                	cmp    %ecx,%edi
 acf:	76 3f                	jbe    b10 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ad1:	39 05 08 10 00 00    	cmp    %eax,0x1008
 ad7:	89 c2                	mov    %eax,%edx
 ad9:	75 ed                	jne    ac8 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 adb:	83 ec 0c             	sub    $0xc,%esp
 ade:	53                   	push   %ebx
 adf:	e8 76 fc ff ff       	call   75a <sbrk>
  if(p == (char*)-1)
 ae4:	83 c4 10             	add    $0x10,%esp
 ae7:	83 f8 ff             	cmp    $0xffffffff,%eax
 aea:	74 1c                	je     b08 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 aec:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 aef:	83 ec 0c             	sub    $0xc,%esp
 af2:	83 c0 08             	add    $0x8,%eax
 af5:	50                   	push   %eax
 af6:	e8 e5 fe ff ff       	call   9e0 <free>
  return freep;
 afb:	8b 15 08 10 00 00    	mov    0x1008,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 b01:	83 c4 10             	add    $0x10,%esp
 b04:	85 d2                	test   %edx,%edx
 b06:	75 c0                	jne    ac8 <malloc+0x58>
        return 0;
 b08:	31 c0                	xor    %eax,%eax
 b0a:	eb 1c                	jmp    b28 <malloc+0xb8>
 b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 b10:	39 cf                	cmp    %ecx,%edi
 b12:	74 1c                	je     b30 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 b14:	29 f9                	sub    %edi,%ecx
 b16:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 b19:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 b1c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 b1f:	89 15 08 10 00 00    	mov    %edx,0x1008
      return (void*)(p + 1);
 b25:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 b28:	8d 65 f4             	lea    -0xc(%ebp),%esp
 b2b:	5b                   	pop    %ebx
 b2c:	5e                   	pop    %esi
 b2d:	5f                   	pop    %edi
 b2e:	5d                   	pop    %ebp
 b2f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 b30:	8b 08                	mov    (%eax),%ecx
 b32:	89 0a                	mov    %ecx,(%edx)
 b34:	eb e9                	jmp    b1f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 b36:	c7 05 08 10 00 00 0c 	movl   $0x100c,0x1008
 b3d:	10 00 00 
 b40:	c7 05 0c 10 00 00 0c 	movl   $0x100c,0x100c
 b47:	10 00 00 
    base.s.size = 0;
 b4a:	b8 0c 10 00 00       	mov    $0x100c,%eax
 b4f:	c7 05 10 10 00 00 00 	movl   $0x0,0x1010
 b56:	00 00 00 
 b59:	e9 3e ff ff ff       	jmp    a9c <malloc+0x2c>
