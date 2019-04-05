
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
  18:	68 80 11 00 00       	push   $0x1180
  1d:	e8 40 08 00 00       	call   862 <captsc>
	drawHeader();
  22:	e8 29 02 00 00       	call   250 <drawHeader>
	updatesc(50, 0, "                         v0.1 ", UI_COLOR);
}

void
drawFooter() {
	updatesc(0, 24, " ^Q - Quit                                                                      ", UI_COLOR);
  27:	68 c0 00 00 00       	push   $0xc0
  2c:	68 90 0c 00 00       	push   $0xc90
  31:	6a 18                	push   $0x18
  33:	6a 00                	push   $0x0
  35:	e8 38 08 00 00       	call   872 <updatesc>
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
  45:	68 17 0d 00 00       	push   $0xd17
  4a:	6a 01                	push   $0x1
  4c:	e8 df 08 00 00       	call   930 <printf>
  51:	83 c4 10             	add    $0x10,%esp
  54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	}
	while(1) {
		while ((c = getkey()) <= 0) {
  58:	e8 1d 08 00 00       	call   87a <getkey>
  5d:	85 c0                	test   %eax,%eax
  5f:	a3 80 11 00 00       	mov    %eax,0x1180
  64:	7e f2                	jle    58 <main+0x58>
		}
		handleInput(c);
  66:	83 ec 0c             	sub    $0xc,%esp
  69:	50                   	push   %eax
  6a:	e8 71 04 00 00       	call   4e0 <handleInput>
		c = 0;
  6f:	c7 05 80 11 00 00 00 	movl   $0x0,0x1180
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
  86:	e8 77 07 00 00       	call   802 <open>
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
  9c:	ff 35 a8 11 00 00    	pushl  0x11a8
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
  b2:	68 07 0d 00 00       	push   $0xd07
  b7:	6a 01                	push   $0x1
  b9:	e8 72 08 00 00       	call   930 <printf>
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
  e0:	e8 7b 0a 00 00       	call   b60 <malloc>
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
  ea:	a3 a8 11 00 00       	mov    %eax,0x11a8
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
 109:	e8 cc 06 00 00       	call   7da <read>
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
 142:	e8 19 0a 00 00       	call   b60 <malloc>
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
 170:	a1 a8 11 00 00       	mov    0x11a8,%eax
 175:	a3 a0 11 00 00       	mov    %eax,0x11a0
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
 1b0:	c6 84 03 c0 11 00 00 	movb   $0x20,0x11c0(%ebx,%eax,1)
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
 1c9:	88 94 03 c0 11 00 00 	mov    %dl,0x11c0(%ebx,%eax,1)
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
 1f8:	c6 84 03 c0 11 00 00 	movb   $0x20,0x11c0(%ebx,%eax,1)
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
 211:	88 94 03 c0 11 00 00 	mov    %dl,0x11c0(%ebx,%eax,1)
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
 222:	68 c0 11 00 00       	push   $0x11c0
 227:	6a 01                	push   $0x1
 229:	6a 00                	push   $0x0
			}
			bufindex++;
	}
	lastOnScreen = cur;

	buf[bufindex] = '\0';
 22b:	c6 83 10 12 00 00 00 	movb   $0x0,0x1210(%ebx)
			} else{
				buf[bufindex] = cur->line[i];
			}
			bufindex++;
	}
	lastOnScreen = cur;
 232:	89 0d a4 11 00 00    	mov    %ecx,0x11a4

	buf[bufindex] = '\0';
	//printf(1, "%s\n", buf);
	updatesc(0, 1, buf, TEXT_COLOR);
 238:	e8 35 06 00 00       	call   872 <updatesc>
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
 25b:	68 50 0c 00 00       	push   $0xc50
 260:	6a 00                	push   $0x0
 262:	6a 00                	push   $0x0
 264:	e8 09 06 00 00       	call   872 <updatesc>
	updatesc(30, 0, "        PICO        ", UI_COLOR);
 269:	68 c0 00 00 00       	push   $0xc0
 26e:	68 e4 0c 00 00       	push   $0xce4
 273:	6a 00                	push   $0x0
 275:	6a 1e                	push   $0x1e
 277:	e8 f6 05 00 00       	call   872 <updatesc>
	updatesc(50, 0, "                         v0.1 ", UI_COLOR);
 27c:	83 c4 20             	add    $0x20,%esp
 27f:	68 c0 00 00 00       	push   $0xc0
 284:	68 70 0c 00 00       	push   $0xc70
 289:	6a 00                	push   $0x0
 28b:	6a 32                	push   $0x32
 28d:	e8 e0 05 00 00       	call   872 <updatesc>
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
 2ab:	68 90 0c 00 00       	push   $0xc90
 2b0:	6a 18                	push   $0x18
 2b2:	6a 00                	push   $0x0
 2b4:	e8 b9 05 00 00       	call   872 <updatesc>
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
 2c1:	8b 0d a0 11 00 00    	mov    0x11a0,%ecx
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
 2ca:	8b 35 a4 11 00 00    	mov    0x11a4,%esi
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
 2e8:	0f b6 94 03 c0 11 00 	movzbl 0x11c0(%ebx,%eax,1),%edx
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
 31b:	8b 35 a4 11 00 00    	mov    0x11a4,%esi
}

void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
 321:	8b 3d a0 11 00 00    	mov    0x11a0,%edi
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
 338:	0f b6 94 03 c0 11 00 	movzbl 0x11c0(%ebx,%eax,1),%edx
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
 362:	a1 a0 11 00 00       	mov    0x11a0,%eax
 367:	8b 40 58             	mov    0x58(%eax),%eax
 36a:	a3 a0 11 00 00       	mov    %eax,0x11a0
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
 38b:	8b 35 a4 11 00 00    	mov    0x11a4,%esi
}

void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
 391:	8b 3d a0 11 00 00    	mov    0x11a0,%edi
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
 3a8:	0f b6 94 03 c0 11 00 	movzbl 0x11c0(%ebx,%eax,1),%edx
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
 3d2:	a1 a0 11 00 00       	mov    0x11a0,%eax
 3d7:	8b 40 54             	mov    0x54(%eax),%eax
 3da:	a3 a0 11 00 00       	mov    %eax,0x11a0
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
 40e:	a1 84 11 00 00       	mov    0x1184,%eax
 413:	83 f8 4f             	cmp    $0x4f,%eax
 416:	0f 8f b4 00 00 00    	jg     4d0 <arrowkeys+0xe0>
			currChar -= WIDTH;
		}
		else{
			if(firstOnScreen->prev != 0)
 41c:	a1 a0 11 00 00       	mov    0x11a0,%eax
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
 430:	a1 84 11 00 00       	mov    0x1184,%eax
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
 460:	a1 84 11 00 00       	mov    0x1184,%eax
 465:	3d df 06 00 00       	cmp    $0x6df,%eax
 46a:	7e 54                	jle    4c0 <arrowkeys+0xd0>
			currChar += WIDTH;
		}
		else{
			if(lastOnScreen->next != 0)
 46c:	a1 a4 11 00 00       	mov    0x11a4,%eax
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
 480:	8b 0d 84 11 00 00    	mov    0x1184,%ecx
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
 4aa:	89 0d 84 11 00 00    	mov    %ecx,0x1184
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
 4b8:	89 0d 84 11 00 00    	mov    %ecx,0x1184
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
 4c3:	a3 84 11 00 00       	mov    %eax,0x1184
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
 4d3:	a3 84 11 00 00       	mov    %eax,0x1184
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
}
 4d8:	5d                   	pop    %ebp
 4d9:	c3                   	ret    
 4da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000004e0 <handleInput>:

void
handleInput(int i) {
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	56                   	push   %esi
 4e4:	53                   	push   %ebx
 4e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
	//ctrl+q
	if (i == 17) {
 4e8:	83 fb 11             	cmp    $0x11,%ebx
 4eb:	0f 84 85 00 00 00    	je     576 <handleInput+0x96>
		exit();
	}
	printf(1, "currChar: %d\n", currChar);
 4f1:	83 ec 04             	sub    $0x4,%esp
 4f4:	ff 35 84 11 00 00    	pushl  0x1184
 4fa:	68 f9 0c 00 00       	push   $0xcf9
 4ff:	6a 01                	push   $0x1
 501:	e8 2a 04 00 00       	call   930 <printf>
	if(i >= 9 && i<= 12){
 506:	8d 43 f7             	lea    -0x9(%ebx),%eax
 509:	83 c4 10             	add    $0x10,%esp
 50c:	83 f8 03             	cmp    $0x3,%eax
 50f:	76 57                	jbe    568 <handleInput+0x88>
		arrowkeys(i);
	}
	//backspace
	else if(i == 127){
 511:	83 fb 7f             	cmp    $0x7f,%ebx
 514:	74 45                	je     55b <handleInput+0x7b>

	}
	//On right edge of window 
	else if((currChar+1) % WIDTH == 0){
 516:	8b 35 84 11 00 00    	mov    0x1184,%esi
 51c:	ba 67 66 66 66       	mov    $0x66666667,%edx
 521:	8d 4e 01             	lea    0x1(%esi),%ecx
 524:	89 c8                	mov    %ecx,%eax
 526:	f7 ea                	imul   %edx
 528:	89 c8                	mov    %ecx,%eax
 52a:	c1 f8 1f             	sar    $0x1f,%eax
 52d:	c1 fa 05             	sar    $0x5,%edx
 530:	29 c2                	sub    %eax,%edx
 532:	8d 04 92             	lea    (%edx,%edx,4),%eax
 535:	c1 e0 04             	shl    $0x4,%eax
 538:	39 c1                	cmp    %eax,%ecx
 53a:	74 06                	je     542 <handleInput+0x62>
		buf[currChar] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
		// printf(1, "new input");
	}
	else{
		buf[currChar++] = (char) i & 0xff;
 53c:	89 0d 84 11 00 00    	mov    %ecx,0x1184
		updatesc(0, 1, buf, TEXT_COLOR);
 542:	6a 07                	push   $0x7
 544:	68 c0 11 00 00       	push   $0x11c0
 549:	6a 01                	push   $0x1
 54b:	6a 00                	push   $0x0
		buf[currChar] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
		// printf(1, "new input");
	}
	else{
		buf[currChar++] = (char) i & 0xff;
 54d:	88 9e c0 11 00 00    	mov    %bl,0x11c0(%esi)
		updatesc(0, 1, buf, TEXT_COLOR);
 553:	e8 1a 03 00 00       	call   872 <updatesc>
 558:	83 c4 10             	add    $0x10,%esp
	}
}
 55b:	8d 65 f8             	lea    -0x8(%ebp),%esp
 55e:	5b                   	pop    %ebx
 55f:	5e                   	pop    %esi
 560:	5d                   	pop    %ebp
 561:	c3                   	ret    
 562:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	if (i == 17) {
		exit();
	}
	printf(1, "currChar: %d\n", currChar);
	if(i >= 9 && i<= 12){
		arrowkeys(i);
 568:	89 5d 08             	mov    %ebx,0x8(%ebp)
	}
	else{
		buf[currChar++] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
	}
}
 56b:	8d 65 f8             	lea    -0x8(%ebp),%esp
 56e:	5b                   	pop    %ebx
 56f:	5e                   	pop    %esi
 570:	5d                   	pop    %ebp
	if (i == 17) {
		exit();
	}
	printf(1, "currChar: %d\n", currChar);
	if(i >= 9 && i<= 12){
		arrowkeys(i);
 571:	e9 7a fe ff ff       	jmp    3f0 <arrowkeys>

void
handleInput(int i) {
	//ctrl+q
	if (i == 17) {
		exit();
 576:	e8 47 02 00 00       	call   7c2 <exit>
 57b:	66 90                	xchg   %ax,%ax
 57d:	66 90                	xchg   %ax,%ax
 57f:	90                   	nop

00000580 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	53                   	push   %ebx
 584:	8b 45 08             	mov    0x8(%ebp),%eax
 587:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 58a:	89 c2                	mov    %eax,%edx
 58c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 590:	83 c1 01             	add    $0x1,%ecx
 593:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 597:	83 c2 01             	add    $0x1,%edx
 59a:	84 db                	test   %bl,%bl
 59c:	88 5a ff             	mov    %bl,-0x1(%edx)
 59f:	75 ef                	jne    590 <strcpy+0x10>
    ;
  return os;
}
 5a1:	5b                   	pop    %ebx
 5a2:	5d                   	pop    %ebp
 5a3:	c3                   	ret    
 5a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000005b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	56                   	push   %esi
 5b4:	53                   	push   %ebx
 5b5:	8b 55 08             	mov    0x8(%ebp),%edx
 5b8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 5bb:	0f b6 02             	movzbl (%edx),%eax
 5be:	0f b6 19             	movzbl (%ecx),%ebx
 5c1:	84 c0                	test   %al,%al
 5c3:	75 1e                	jne    5e3 <strcmp+0x33>
 5c5:	eb 29                	jmp    5f0 <strcmp+0x40>
 5c7:	89 f6                	mov    %esi,%esi
 5c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 5d0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 5d3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 5d6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 5d9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 5dd:	84 c0                	test   %al,%al
 5df:	74 0f                	je     5f0 <strcmp+0x40>
 5e1:	89 f1                	mov    %esi,%ecx
 5e3:	38 d8                	cmp    %bl,%al
 5e5:	74 e9                	je     5d0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 5e7:	29 d8                	sub    %ebx,%eax
}
 5e9:	5b                   	pop    %ebx
 5ea:	5e                   	pop    %esi
 5eb:	5d                   	pop    %ebp
 5ec:	c3                   	ret    
 5ed:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 5f0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 5f2:	29 d8                	sub    %ebx,%eax
}
 5f4:	5b                   	pop    %ebx
 5f5:	5e                   	pop    %esi
 5f6:	5d                   	pop    %ebp
 5f7:	c3                   	ret    
 5f8:	90                   	nop
 5f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000600 <strlen>:

uint
strlen(char *s)
{
 600:	55                   	push   %ebp
 601:	89 e5                	mov    %esp,%ebp
 603:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 606:	80 39 00             	cmpb   $0x0,(%ecx)
 609:	74 12                	je     61d <strlen+0x1d>
 60b:	31 d2                	xor    %edx,%edx
 60d:	8d 76 00             	lea    0x0(%esi),%esi
 610:	83 c2 01             	add    $0x1,%edx
 613:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 617:	89 d0                	mov    %edx,%eax
 619:	75 f5                	jne    610 <strlen+0x10>
    ;
  return n;
}
 61b:	5d                   	pop    %ebp
 61c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 61d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 61f:	5d                   	pop    %ebp
 620:	c3                   	ret    
 621:	eb 0d                	jmp    630 <memset>
 623:	90                   	nop
 624:	90                   	nop
 625:	90                   	nop
 626:	90                   	nop
 627:	90                   	nop
 628:	90                   	nop
 629:	90                   	nop
 62a:	90                   	nop
 62b:	90                   	nop
 62c:	90                   	nop
 62d:	90                   	nop
 62e:	90                   	nop
 62f:	90                   	nop

00000630 <memset>:

void*
memset(void *dst, int c, uint n)
{
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	57                   	push   %edi
 634:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 637:	8b 4d 10             	mov    0x10(%ebp),%ecx
 63a:	8b 45 0c             	mov    0xc(%ebp),%eax
 63d:	89 d7                	mov    %edx,%edi
 63f:	fc                   	cld    
 640:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 642:	89 d0                	mov    %edx,%eax
 644:	5f                   	pop    %edi
 645:	5d                   	pop    %ebp
 646:	c3                   	ret    
 647:	89 f6                	mov    %esi,%esi
 649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000650 <strchr>:

char*
strchr(const char *s, char c)
{
 650:	55                   	push   %ebp
 651:	89 e5                	mov    %esp,%ebp
 653:	53                   	push   %ebx
 654:	8b 45 08             	mov    0x8(%ebp),%eax
 657:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 65a:	0f b6 10             	movzbl (%eax),%edx
 65d:	84 d2                	test   %dl,%dl
 65f:	74 1d                	je     67e <strchr+0x2e>
    if(*s == c)
 661:	38 d3                	cmp    %dl,%bl
 663:	89 d9                	mov    %ebx,%ecx
 665:	75 0d                	jne    674 <strchr+0x24>
 667:	eb 17                	jmp    680 <strchr+0x30>
 669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 670:	38 ca                	cmp    %cl,%dl
 672:	74 0c                	je     680 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 674:	83 c0 01             	add    $0x1,%eax
 677:	0f b6 10             	movzbl (%eax),%edx
 67a:	84 d2                	test   %dl,%dl
 67c:	75 f2                	jne    670 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 67e:	31 c0                	xor    %eax,%eax
}
 680:	5b                   	pop    %ebx
 681:	5d                   	pop    %ebp
 682:	c3                   	ret    
 683:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000690 <gets>:

char*
gets(char *buf, int max)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	57                   	push   %edi
 694:	56                   	push   %esi
 695:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 696:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 698:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 69b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 69e:	eb 29                	jmp    6c9 <gets+0x39>
    cc = read(0, &c, 1);
 6a0:	83 ec 04             	sub    $0x4,%esp
 6a3:	6a 01                	push   $0x1
 6a5:	57                   	push   %edi
 6a6:	6a 00                	push   $0x0
 6a8:	e8 2d 01 00 00       	call   7da <read>
    if(cc < 1)
 6ad:	83 c4 10             	add    $0x10,%esp
 6b0:	85 c0                	test   %eax,%eax
 6b2:	7e 1d                	jle    6d1 <gets+0x41>
      break;
    buf[i++] = c;
 6b4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 6b8:	8b 55 08             	mov    0x8(%ebp),%edx
 6bb:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 6bd:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 6bf:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 6c3:	74 1b                	je     6e0 <gets+0x50>
 6c5:	3c 0d                	cmp    $0xd,%al
 6c7:	74 17                	je     6e0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 6c9:	8d 5e 01             	lea    0x1(%esi),%ebx
 6cc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 6cf:	7c cf                	jl     6a0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 6d1:	8b 45 08             	mov    0x8(%ebp),%eax
 6d4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 6d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6db:	5b                   	pop    %ebx
 6dc:	5e                   	pop    %esi
 6dd:	5f                   	pop    %edi
 6de:	5d                   	pop    %ebp
 6df:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 6e0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 6e3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 6e5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 6e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6ec:	5b                   	pop    %ebx
 6ed:	5e                   	pop    %esi
 6ee:	5f                   	pop    %edi
 6ef:	5d                   	pop    %ebp
 6f0:	c3                   	ret    
 6f1:	eb 0d                	jmp    700 <stat>
 6f3:	90                   	nop
 6f4:	90                   	nop
 6f5:	90                   	nop
 6f6:	90                   	nop
 6f7:	90                   	nop
 6f8:	90                   	nop
 6f9:	90                   	nop
 6fa:	90                   	nop
 6fb:	90                   	nop
 6fc:	90                   	nop
 6fd:	90                   	nop
 6fe:	90                   	nop
 6ff:	90                   	nop

00000700 <stat>:

int
stat(char *n, struct stat *st)
{
 700:	55                   	push   %ebp
 701:	89 e5                	mov    %esp,%ebp
 703:	56                   	push   %esi
 704:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 705:	83 ec 08             	sub    $0x8,%esp
 708:	6a 00                	push   $0x0
 70a:	ff 75 08             	pushl  0x8(%ebp)
 70d:	e8 f0 00 00 00       	call   802 <open>
  if(fd < 0)
 712:	83 c4 10             	add    $0x10,%esp
 715:	85 c0                	test   %eax,%eax
 717:	78 27                	js     740 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 719:	83 ec 08             	sub    $0x8,%esp
 71c:	ff 75 0c             	pushl  0xc(%ebp)
 71f:	89 c3                	mov    %eax,%ebx
 721:	50                   	push   %eax
 722:	e8 f3 00 00 00       	call   81a <fstat>
 727:	89 c6                	mov    %eax,%esi
  close(fd);
 729:	89 1c 24             	mov    %ebx,(%esp)
 72c:	e8 b9 00 00 00       	call   7ea <close>
  return r;
 731:	83 c4 10             	add    $0x10,%esp
 734:	89 f0                	mov    %esi,%eax
}
 736:	8d 65 f8             	lea    -0x8(%ebp),%esp
 739:	5b                   	pop    %ebx
 73a:	5e                   	pop    %esi
 73b:	5d                   	pop    %ebp
 73c:	c3                   	ret    
 73d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 740:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 745:	eb ef                	jmp    736 <stat+0x36>
 747:	89 f6                	mov    %esi,%esi
 749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000750 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	53                   	push   %ebx
 754:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 757:	0f be 11             	movsbl (%ecx),%edx
 75a:	8d 42 d0             	lea    -0x30(%edx),%eax
 75d:	3c 09                	cmp    $0x9,%al
 75f:	b8 00 00 00 00       	mov    $0x0,%eax
 764:	77 1f                	ja     785 <atoi+0x35>
 766:	8d 76 00             	lea    0x0(%esi),%esi
 769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 770:	8d 04 80             	lea    (%eax,%eax,4),%eax
 773:	83 c1 01             	add    $0x1,%ecx
 776:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 77a:	0f be 11             	movsbl (%ecx),%edx
 77d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 780:	80 fb 09             	cmp    $0x9,%bl
 783:	76 eb                	jbe    770 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 785:	5b                   	pop    %ebx
 786:	5d                   	pop    %ebp
 787:	c3                   	ret    
 788:	90                   	nop
 789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000790 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	56                   	push   %esi
 794:	53                   	push   %ebx
 795:	8b 5d 10             	mov    0x10(%ebp),%ebx
 798:	8b 45 08             	mov    0x8(%ebp),%eax
 79b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 79e:	85 db                	test   %ebx,%ebx
 7a0:	7e 14                	jle    7b6 <memmove+0x26>
 7a2:	31 d2                	xor    %edx,%edx
 7a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 7a8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 7ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 7af:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 7b2:	39 da                	cmp    %ebx,%edx
 7b4:	75 f2                	jne    7a8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 7b6:	5b                   	pop    %ebx
 7b7:	5e                   	pop    %esi
 7b8:	5d                   	pop    %ebp
 7b9:	c3                   	ret    

000007ba <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 7ba:	b8 01 00 00 00       	mov    $0x1,%eax
 7bf:	cd 40                	int    $0x40
 7c1:	c3                   	ret    

000007c2 <exit>:
SYSCALL(exit)
 7c2:	b8 02 00 00 00       	mov    $0x2,%eax
 7c7:	cd 40                	int    $0x40
 7c9:	c3                   	ret    

000007ca <wait>:
SYSCALL(wait)
 7ca:	b8 03 00 00 00       	mov    $0x3,%eax
 7cf:	cd 40                	int    $0x40
 7d1:	c3                   	ret    

000007d2 <pipe>:
SYSCALL(pipe)
 7d2:	b8 04 00 00 00       	mov    $0x4,%eax
 7d7:	cd 40                	int    $0x40
 7d9:	c3                   	ret    

000007da <read>:
SYSCALL(read)
 7da:	b8 05 00 00 00       	mov    $0x5,%eax
 7df:	cd 40                	int    $0x40
 7e1:	c3                   	ret    

000007e2 <write>:
SYSCALL(write)
 7e2:	b8 10 00 00 00       	mov    $0x10,%eax
 7e7:	cd 40                	int    $0x40
 7e9:	c3                   	ret    

000007ea <close>:
SYSCALL(close)
 7ea:	b8 15 00 00 00       	mov    $0x15,%eax
 7ef:	cd 40                	int    $0x40
 7f1:	c3                   	ret    

000007f2 <kill>:
SYSCALL(kill)
 7f2:	b8 06 00 00 00       	mov    $0x6,%eax
 7f7:	cd 40                	int    $0x40
 7f9:	c3                   	ret    

000007fa <exec>:
SYSCALL(exec)
 7fa:	b8 07 00 00 00       	mov    $0x7,%eax
 7ff:	cd 40                	int    $0x40
 801:	c3                   	ret    

00000802 <open>:
SYSCALL(open)
 802:	b8 0f 00 00 00       	mov    $0xf,%eax
 807:	cd 40                	int    $0x40
 809:	c3                   	ret    

0000080a <mknod>:
SYSCALL(mknod)
 80a:	b8 11 00 00 00       	mov    $0x11,%eax
 80f:	cd 40                	int    $0x40
 811:	c3                   	ret    

00000812 <unlink>:
SYSCALL(unlink)
 812:	b8 12 00 00 00       	mov    $0x12,%eax
 817:	cd 40                	int    $0x40
 819:	c3                   	ret    

0000081a <fstat>:
SYSCALL(fstat)
 81a:	b8 08 00 00 00       	mov    $0x8,%eax
 81f:	cd 40                	int    $0x40
 821:	c3                   	ret    

00000822 <link>:
SYSCALL(link)
 822:	b8 13 00 00 00       	mov    $0x13,%eax
 827:	cd 40                	int    $0x40
 829:	c3                   	ret    

0000082a <mkdir>:
SYSCALL(mkdir)
 82a:	b8 14 00 00 00       	mov    $0x14,%eax
 82f:	cd 40                	int    $0x40
 831:	c3                   	ret    

00000832 <chdir>:
SYSCALL(chdir)
 832:	b8 09 00 00 00       	mov    $0x9,%eax
 837:	cd 40                	int    $0x40
 839:	c3                   	ret    

0000083a <dup>:
SYSCALL(dup)
 83a:	b8 0a 00 00 00       	mov    $0xa,%eax
 83f:	cd 40                	int    $0x40
 841:	c3                   	ret    

00000842 <getpid>:
SYSCALL(getpid)
 842:	b8 0b 00 00 00       	mov    $0xb,%eax
 847:	cd 40                	int    $0x40
 849:	c3                   	ret    

0000084a <sbrk>:
SYSCALL(sbrk)
 84a:	b8 0c 00 00 00       	mov    $0xc,%eax
 84f:	cd 40                	int    $0x40
 851:	c3                   	ret    

00000852 <sleep>:
SYSCALL(sleep)
 852:	b8 0d 00 00 00       	mov    $0xd,%eax
 857:	cd 40                	int    $0x40
 859:	c3                   	ret    

0000085a <uptime>:
SYSCALL(uptime)
 85a:	b8 0e 00 00 00       	mov    $0xe,%eax
 85f:	cd 40                	int    $0x40
 861:	c3                   	ret    

00000862 <captsc>:
SYSCALL(captsc)
 862:	b8 16 00 00 00       	mov    $0x16,%eax
 867:	cd 40                	int    $0x40
 869:	c3                   	ret    

0000086a <freesc>:
SYSCALL(freesc)
 86a:	b8 17 00 00 00       	mov    $0x17,%eax
 86f:	cd 40                	int    $0x40
 871:	c3                   	ret    

00000872 <updatesc>:
SYSCALL(updatesc)
 872:	b8 18 00 00 00       	mov    $0x18,%eax
 877:	cd 40                	int    $0x40
 879:	c3                   	ret    

0000087a <getkey>:
SYSCALL(getkey)
 87a:	b8 19 00 00 00       	mov    $0x19,%eax
 87f:	cd 40                	int    $0x40
 881:	c3                   	ret    
 882:	66 90                	xchg   %ax,%ax
 884:	66 90                	xchg   %ax,%ax
 886:	66 90                	xchg   %ax,%ax
 888:	66 90                	xchg   %ax,%ax
 88a:	66 90                	xchg   %ax,%ax
 88c:	66 90                	xchg   %ax,%ax
 88e:	66 90                	xchg   %ax,%ax

00000890 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 890:	55                   	push   %ebp
 891:	89 e5                	mov    %esp,%ebp
 893:	57                   	push   %edi
 894:	56                   	push   %esi
 895:	53                   	push   %ebx
 896:	89 c6                	mov    %eax,%esi
 898:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 89b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 89e:	85 db                	test   %ebx,%ebx
 8a0:	74 7e                	je     920 <printint+0x90>
 8a2:	89 d0                	mov    %edx,%eax
 8a4:	c1 e8 1f             	shr    $0x1f,%eax
 8a7:	84 c0                	test   %al,%al
 8a9:	74 75                	je     920 <printint+0x90>
    neg = 1;
    x = -xx;
 8ab:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 8ad:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 8b4:	f7 d8                	neg    %eax
 8b6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 8b9:	31 ff                	xor    %edi,%edi
 8bb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 8be:	89 ce                	mov    %ecx,%esi
 8c0:	eb 08                	jmp    8ca <printint+0x3a>
 8c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 8c8:	89 cf                	mov    %ecx,%edi
 8ca:	31 d2                	xor    %edx,%edx
 8cc:	8d 4f 01             	lea    0x1(%edi),%ecx
 8cf:	f7 f6                	div    %esi
 8d1:	0f b6 92 30 0d 00 00 	movzbl 0xd30(%edx),%edx
  }while((x /= base) != 0);
 8d8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 8da:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 8dd:	75 e9                	jne    8c8 <printint+0x38>
  if(neg)
 8df:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 8e2:	8b 75 c0             	mov    -0x40(%ebp),%esi
 8e5:	85 c0                	test   %eax,%eax
 8e7:	74 08                	je     8f1 <printint+0x61>
    buf[i++] = '-';
 8e9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 8ee:	8d 4f 02             	lea    0x2(%edi),%ecx
 8f1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 8f5:	8d 76 00             	lea    0x0(%esi),%esi
 8f8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8fb:	83 ec 04             	sub    $0x4,%esp
 8fe:	83 ef 01             	sub    $0x1,%edi
 901:	6a 01                	push   $0x1
 903:	53                   	push   %ebx
 904:	56                   	push   %esi
 905:	88 45 d7             	mov    %al,-0x29(%ebp)
 908:	e8 d5 fe ff ff       	call   7e2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 90d:	83 c4 10             	add    $0x10,%esp
 910:	39 df                	cmp    %ebx,%edi
 912:	75 e4                	jne    8f8 <printint+0x68>
    putc(fd, buf[i]);
}
 914:	8d 65 f4             	lea    -0xc(%ebp),%esp
 917:	5b                   	pop    %ebx
 918:	5e                   	pop    %esi
 919:	5f                   	pop    %edi
 91a:	5d                   	pop    %ebp
 91b:	c3                   	ret    
 91c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 920:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 922:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 929:	eb 8b                	jmp    8b6 <printint+0x26>
 92b:	90                   	nop
 92c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000930 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 930:	55                   	push   %ebp
 931:	89 e5                	mov    %esp,%ebp
 933:	57                   	push   %edi
 934:	56                   	push   %esi
 935:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 936:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 939:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 93c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 93f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 942:	89 45 d0             	mov    %eax,-0x30(%ebp)
 945:	0f b6 1e             	movzbl (%esi),%ebx
 948:	83 c6 01             	add    $0x1,%esi
 94b:	84 db                	test   %bl,%bl
 94d:	0f 84 b0 00 00 00    	je     a03 <printf+0xd3>
 953:	31 d2                	xor    %edx,%edx
 955:	eb 39                	jmp    990 <printf+0x60>
 957:	89 f6                	mov    %esi,%esi
 959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 960:	83 f8 25             	cmp    $0x25,%eax
 963:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 966:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 96b:	74 18                	je     985 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 96d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 970:	83 ec 04             	sub    $0x4,%esp
 973:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 976:	6a 01                	push   $0x1
 978:	50                   	push   %eax
 979:	57                   	push   %edi
 97a:	e8 63 fe ff ff       	call   7e2 <write>
 97f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 982:	83 c4 10             	add    $0x10,%esp
 985:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 988:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 98c:	84 db                	test   %bl,%bl
 98e:	74 73                	je     a03 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 990:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 992:	0f be cb             	movsbl %bl,%ecx
 995:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 998:	74 c6                	je     960 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 99a:	83 fa 25             	cmp    $0x25,%edx
 99d:	75 e6                	jne    985 <printf+0x55>
      if(c == 'd'){
 99f:	83 f8 64             	cmp    $0x64,%eax
 9a2:	0f 84 f8 00 00 00    	je     aa0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 9a8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 9ae:	83 f9 70             	cmp    $0x70,%ecx
 9b1:	74 5d                	je     a10 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 9b3:	83 f8 73             	cmp    $0x73,%eax
 9b6:	0f 84 84 00 00 00    	je     a40 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 9bc:	83 f8 63             	cmp    $0x63,%eax
 9bf:	0f 84 ea 00 00 00    	je     aaf <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 9c5:	83 f8 25             	cmp    $0x25,%eax
 9c8:	0f 84 c2 00 00 00    	je     a90 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 9ce:	8d 45 e7             	lea    -0x19(%ebp),%eax
 9d1:	83 ec 04             	sub    $0x4,%esp
 9d4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 9d8:	6a 01                	push   $0x1
 9da:	50                   	push   %eax
 9db:	57                   	push   %edi
 9dc:	e8 01 fe ff ff       	call   7e2 <write>
 9e1:	83 c4 0c             	add    $0xc,%esp
 9e4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 9e7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 9ea:	6a 01                	push   $0x1
 9ec:	50                   	push   %eax
 9ed:	57                   	push   %edi
 9ee:	83 c6 01             	add    $0x1,%esi
 9f1:	e8 ec fd ff ff       	call   7e2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 9f6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 9fa:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9fd:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 9ff:	84 db                	test   %bl,%bl
 a01:	75 8d                	jne    990 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 a03:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a06:	5b                   	pop    %ebx
 a07:	5e                   	pop    %esi
 a08:	5f                   	pop    %edi
 a09:	5d                   	pop    %ebp
 a0a:	c3                   	ret    
 a0b:	90                   	nop
 a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 a10:	83 ec 0c             	sub    $0xc,%esp
 a13:	b9 10 00 00 00       	mov    $0x10,%ecx
 a18:	6a 00                	push   $0x0
 a1a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 a1d:	89 f8                	mov    %edi,%eax
 a1f:	8b 13                	mov    (%ebx),%edx
 a21:	e8 6a fe ff ff       	call   890 <printint>
        ap++;
 a26:	89 d8                	mov    %ebx,%eax
 a28:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 a2b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 a2d:	83 c0 04             	add    $0x4,%eax
 a30:	89 45 d0             	mov    %eax,-0x30(%ebp)
 a33:	e9 4d ff ff ff       	jmp    985 <printf+0x55>
 a38:	90                   	nop
 a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 a40:	8b 45 d0             	mov    -0x30(%ebp),%eax
 a43:	8b 18                	mov    (%eax),%ebx
        ap++;
 a45:	83 c0 04             	add    $0x4,%eax
 a48:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 a4b:	b8 28 0d 00 00       	mov    $0xd28,%eax
 a50:	85 db                	test   %ebx,%ebx
 a52:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 a55:	0f b6 03             	movzbl (%ebx),%eax
 a58:	84 c0                	test   %al,%al
 a5a:	74 23                	je     a7f <printf+0x14f>
 a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 a60:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 a63:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 a66:	83 ec 04             	sub    $0x4,%esp
 a69:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 a6b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 a6e:	50                   	push   %eax
 a6f:	57                   	push   %edi
 a70:	e8 6d fd ff ff       	call   7e2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 a75:	0f b6 03             	movzbl (%ebx),%eax
 a78:	83 c4 10             	add    $0x10,%esp
 a7b:	84 c0                	test   %al,%al
 a7d:	75 e1                	jne    a60 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 a7f:	31 d2                	xor    %edx,%edx
 a81:	e9 ff fe ff ff       	jmp    985 <printf+0x55>
 a86:	8d 76 00             	lea    0x0(%esi),%esi
 a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 a90:	83 ec 04             	sub    $0x4,%esp
 a93:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 a96:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 a99:	6a 01                	push   $0x1
 a9b:	e9 4c ff ff ff       	jmp    9ec <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 aa0:	83 ec 0c             	sub    $0xc,%esp
 aa3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 aa8:	6a 01                	push   $0x1
 aaa:	e9 6b ff ff ff       	jmp    a1a <printf+0xea>
 aaf:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 ab2:	83 ec 04             	sub    $0x4,%esp
 ab5:	8b 03                	mov    (%ebx),%eax
 ab7:	6a 01                	push   $0x1
 ab9:	88 45 e4             	mov    %al,-0x1c(%ebp)
 abc:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 abf:	50                   	push   %eax
 ac0:	57                   	push   %edi
 ac1:	e8 1c fd ff ff       	call   7e2 <write>
 ac6:	e9 5b ff ff ff       	jmp    a26 <printf+0xf6>
 acb:	66 90                	xchg   %ax,%ax
 acd:	66 90                	xchg   %ax,%ax
 acf:	90                   	nop

00000ad0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ad0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ad1:	a1 88 11 00 00       	mov    0x1188,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 ad6:	89 e5                	mov    %esp,%ebp
 ad8:	57                   	push   %edi
 ad9:	56                   	push   %esi
 ada:	53                   	push   %ebx
 adb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ade:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 ae0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ae3:	39 c8                	cmp    %ecx,%eax
 ae5:	73 19                	jae    b00 <free+0x30>
 ae7:	89 f6                	mov    %esi,%esi
 ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 af0:	39 d1                	cmp    %edx,%ecx
 af2:	72 1c                	jb     b10 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 af4:	39 d0                	cmp    %edx,%eax
 af6:	73 18                	jae    b10 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 af8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 afa:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 afc:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 afe:	72 f0                	jb     af0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b00:	39 d0                	cmp    %edx,%eax
 b02:	72 f4                	jb     af8 <free+0x28>
 b04:	39 d1                	cmp    %edx,%ecx
 b06:	73 f0                	jae    af8 <free+0x28>
 b08:	90                   	nop
 b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 b10:	8b 73 fc             	mov    -0x4(%ebx),%esi
 b13:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 b16:	39 d7                	cmp    %edx,%edi
 b18:	74 19                	je     b33 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 b1a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b1d:	8b 50 04             	mov    0x4(%eax),%edx
 b20:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b23:	39 f1                	cmp    %esi,%ecx
 b25:	74 23                	je     b4a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 b27:	89 08                	mov    %ecx,(%eax)
  freep = p;
 b29:	a3 88 11 00 00       	mov    %eax,0x1188
}
 b2e:	5b                   	pop    %ebx
 b2f:	5e                   	pop    %esi
 b30:	5f                   	pop    %edi
 b31:	5d                   	pop    %ebp
 b32:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b33:	03 72 04             	add    0x4(%edx),%esi
 b36:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 b39:	8b 10                	mov    (%eax),%edx
 b3b:	8b 12                	mov    (%edx),%edx
 b3d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 b40:	8b 50 04             	mov    0x4(%eax),%edx
 b43:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b46:	39 f1                	cmp    %esi,%ecx
 b48:	75 dd                	jne    b27 <free+0x57>
    p->s.size += bp->s.size;
 b4a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 b4d:	a3 88 11 00 00       	mov    %eax,0x1188
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 b52:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 b55:	8b 53 f8             	mov    -0x8(%ebx),%edx
 b58:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 b5a:	5b                   	pop    %ebx
 b5b:	5e                   	pop    %esi
 b5c:	5f                   	pop    %edi
 b5d:	5d                   	pop    %ebp
 b5e:	c3                   	ret    
 b5f:	90                   	nop

00000b60 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b60:	55                   	push   %ebp
 b61:	89 e5                	mov    %esp,%ebp
 b63:	57                   	push   %edi
 b64:	56                   	push   %esi
 b65:	53                   	push   %ebx
 b66:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b69:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 b6c:	8b 15 88 11 00 00    	mov    0x1188,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b72:	8d 78 07             	lea    0x7(%eax),%edi
 b75:	c1 ef 03             	shr    $0x3,%edi
 b78:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 b7b:	85 d2                	test   %edx,%edx
 b7d:	0f 84 a3 00 00 00    	je     c26 <malloc+0xc6>
 b83:	8b 02                	mov    (%edx),%eax
 b85:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 b88:	39 cf                	cmp    %ecx,%edi
 b8a:	76 74                	jbe    c00 <malloc+0xa0>
 b8c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 b92:	be 00 10 00 00       	mov    $0x1000,%esi
 b97:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 b9e:	0f 43 f7             	cmovae %edi,%esi
 ba1:	ba 00 80 00 00       	mov    $0x8000,%edx
 ba6:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 bac:	0f 46 da             	cmovbe %edx,%ebx
 baf:	eb 10                	jmp    bc1 <malloc+0x61>
 bb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bb8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 bba:	8b 48 04             	mov    0x4(%eax),%ecx
 bbd:	39 cf                	cmp    %ecx,%edi
 bbf:	76 3f                	jbe    c00 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 bc1:	39 05 88 11 00 00    	cmp    %eax,0x1188
 bc7:	89 c2                	mov    %eax,%edx
 bc9:	75 ed                	jne    bb8 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 bcb:	83 ec 0c             	sub    $0xc,%esp
 bce:	53                   	push   %ebx
 bcf:	e8 76 fc ff ff       	call   84a <sbrk>
  if(p == (char*)-1)
 bd4:	83 c4 10             	add    $0x10,%esp
 bd7:	83 f8 ff             	cmp    $0xffffffff,%eax
 bda:	74 1c                	je     bf8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 bdc:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 bdf:	83 ec 0c             	sub    $0xc,%esp
 be2:	83 c0 08             	add    $0x8,%eax
 be5:	50                   	push   %eax
 be6:	e8 e5 fe ff ff       	call   ad0 <free>
  return freep;
 beb:	8b 15 88 11 00 00    	mov    0x1188,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 bf1:	83 c4 10             	add    $0x10,%esp
 bf4:	85 d2                	test   %edx,%edx
 bf6:	75 c0                	jne    bb8 <malloc+0x58>
        return 0;
 bf8:	31 c0                	xor    %eax,%eax
 bfa:	eb 1c                	jmp    c18 <malloc+0xb8>
 bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 c00:	39 cf                	cmp    %ecx,%edi
 c02:	74 1c                	je     c20 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 c04:	29 f9                	sub    %edi,%ecx
 c06:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 c09:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 c0c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 c0f:	89 15 88 11 00 00    	mov    %edx,0x1188
      return (void*)(p + 1);
 c15:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 c18:	8d 65 f4             	lea    -0xc(%ebp),%esp
 c1b:	5b                   	pop    %ebx
 c1c:	5e                   	pop    %esi
 c1d:	5f                   	pop    %edi
 c1e:	5d                   	pop    %ebp
 c1f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 c20:	8b 08                	mov    (%eax),%ecx
 c22:	89 0a                	mov    %ecx,(%edx)
 c24:	eb e9                	jmp    c0f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 c26:	c7 05 88 11 00 00 8c 	movl   $0x118c,0x1188
 c2d:	11 00 00 
 c30:	c7 05 8c 11 00 00 8c 	movl   $0x118c,0x118c
 c37:	11 00 00 
    base.s.size = 0;
 c3a:	b8 8c 11 00 00       	mov    $0x118c,%eax
 c3f:	c7 05 90 11 00 00 00 	movl   $0x0,0x1190
 c46:	00 00 00 
 c49:	e9 3e ff ff ff       	jmp    b8c <malloc+0x2c>
