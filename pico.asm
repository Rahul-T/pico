
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
  18:	68 a0 11 00 00       	push   $0x11a0
  1d:	e8 50 08 00 00       	call   872 <captsc>
	drawHeader();
  22:	e8 39 02 00 00       	call   260 <drawHeader>
	updatesc(50, 0, "                         v0.1 ", UI_COLOR);
}

void
drawFooter() {
	updatesc(0, 24, " ^Q - Quit                                                                      ", UI_COLOR);
  27:	68 c0 00 00 00       	push   $0xc0
  2c:	68 f4 0c 00 00       	push   $0xcf4
  31:	6a 18                	push   $0x18
  33:	6a 00                	push   $0x0
  35:	e8 48 08 00 00       	call   882 <updatesc>
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
  45:	68 a2 0c 00 00       	push   $0xca2
  4a:	6a 01                	push   $0x1
  4c:	e8 ef 08 00 00       	call   940 <printf>
  51:	83 c4 10             	add    $0x10,%esp
  54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	}
	while(1) {
		while ((c = getkey()) <= 0) {
  58:	e8 2d 08 00 00       	call   88a <getkey>
  5d:	85 c0                	test   %eax,%eax
  5f:	a3 a0 11 00 00       	mov    %eax,0x11a0
  64:	7e f2                	jle    58 <main+0x58>
		}
		handleInput(c);
  66:	83 ec 0c             	sub    $0xc,%esp
  69:	50                   	push   %eax
  6a:	e8 81 04 00 00       	call   4f0 <handleInput>
		c = 0;
  6f:	c7 05 a0 11 00 00 00 	movl   $0x0,0x11a0
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
  86:	e8 87 07 00 00       	call   812 <open>
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
  9c:	ff 35 c8 11 00 00    	pushl  0x11c8
  a2:	e8 f9 00 00 00       	call   1a0 <printfile>
  a7:	83 c4 10             	add    $0x10,%esp
  aa:	eb ac                	jmp    58 <main+0x58>
	drawFooter();
	int fd;

	if (argc == 2) {
		if((fd = open(argv[1], 0)) < 0){
			printf(1, "Cannot open %s\n", argv[1]);
  ac:	83 ec 04             	sub    $0x4,%esp
  af:	ff 73 04             	pushl  0x4(%ebx)
  b2:	68 92 0c 00 00       	push   $0xc92
  b7:	6a 01                	push   $0x1
  b9:	e8 82 08 00 00       	call   940 <printf>
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
  d6:	8d 7d e7             	lea    -0x19(%ebp),%edi
	int n;
	char singlechar[1];
	head = malloc(sizeof(struct fileline));
	struct fileline* cur = head;
	int linecounter = 0;
  d9:	31 f6                	xor    %esi,%esi
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
  e0:	e8 8b 0a 00 00       	call   b70 <malloc>
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
  ea:	a3 c8 11 00 00       	mov    %eax,0x11c8
	struct fileline* cur = head;
	int linecounter = 0;
	int linenumber = 0;
  ef:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  f6:	8d 76 00             	lea    0x0(%esi),%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

	while((n = read(fd, singlechar, 1)) > 0) {
 100:	83 ec 04             	sub    $0x4,%esp
 103:	6a 01                	push   $0x1
 105:	57                   	push   %edi
 106:	ff 75 08             	pushl  0x8(%ebp)
 109:	e8 dc 06 00 00       	call   7ea <read>
 10e:	83 c4 10             	add    $0x10,%esp
 111:	85 c0                	test   %eax,%eax
 113:	7e 6b                	jle    180 <initLinkedList+0xb0>
		if(linecounter < WIDTH){
 115:	83 fe 50             	cmp    $0x50,%esi
 118:	74 1e                	je     138 <initLinkedList+0x68>
			cur->line[linecounter] = singlechar[0];
 11a:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 11e:	88 44 33 04          	mov    %al,0x4(%ebx,%esi,1)
			linecounter++;
 122:	83 c6 01             	add    $0x1,%esi
 125:	3c 0a                	cmp    $0xa,%al
 127:	b8 50 00 00 00       	mov    $0x50,%eax
 12c:	0f 44 f0             	cmove  %eax,%esi
 12f:	eb cf                	jmp    100 <initLinkedList+0x30>
 131:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			if(singlechar[0] == '\n'){
				linecounter = WIDTH;
			}
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
 138:	83 ec 0c             	sub    $0xc,%esp
 13b:	6a 5c                	push   $0x5c
 13d:	e8 2e 0a 00 00       	call   b70 <malloc>
			cur->filelinenum = linenumber;
 142:	8b 55 d4             	mov    -0x2c(%ebp),%edx
			if(singlechar[0] == '\n'){
				linecounter = WIDTH;
			}
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
 145:	89 c6                	mov    %eax,%esi
			cur->next = nextline;
			cur = nextline;
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
			linecounter++;
			printf(1, "linenumber %d\n", linenumber);
 147:	83 c4 0c             	add    $0xc,%esp
				linecounter = WIDTH;
			}
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
			cur->filelinenum = linenumber;
 14a:	89 13                	mov    %edx,(%ebx)
			nextline->prev = cur;
			cur->next = nextline;
			cur = nextline;
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
 14c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
			}
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
			cur->filelinenum = linenumber;
			nextline->prev = cur;
 150:	89 5e 54             	mov    %ebx,0x54(%esi)
			cur->next = nextline;
 153:	89 73 58             	mov    %esi,0x58(%ebx)
			cur = nextline;
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
			linecounter++;
			printf(1, "linenumber %d\n", linenumber);
 156:	89 d3                	mov    %edx,%ebx
			cur->filelinenum = linenumber;
			nextline->prev = cur;
			cur->next = nextline;
			cur = nextline;
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
 158:	88 46 04             	mov    %al,0x4(%esi)
			linecounter++;
			printf(1, "linenumber %d\n", linenumber);
 15b:	52                   	push   %edx
 15c:	68 60 0c 00 00       	push   $0xc60
 161:	6a 01                	push   $0x1
 163:	e8 d8 07 00 00       	call   940 <printf>
			linenumber++;
 168:	89 d8                	mov    %ebx,%eax
 16a:	83 c4 10             	add    $0x10,%esp
 16d:	89 f3                	mov    %esi,%ebx
 16f:	83 c0 01             	add    $0x1,%eax
			nextline->prev = cur;
			cur->next = nextline;
			cur = nextline;
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
			linecounter++;
 172:	be 01 00 00 00       	mov    $0x1,%esi
			printf(1, "linenumber %d\n", linenumber);
			linenumber++;
 177:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 17a:	eb 84                	jmp    100 <initLinkedList+0x30>
 17c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		}
	}
	firstOnScreen = head;
 180:	a1 c8 11 00 00       	mov    0x11c8,%eax
 185:	a3 c0 11 00 00       	mov    %eax,0x11c0
	// 	printf(1, "%s", cur->line);
	// 	cur = cur->next;
	// }
	// printf(1, "%s", cur->line);

}
 18a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 18d:	5b                   	pop    %ebx
 18e:	5e                   	pop    %esi
 18f:	5f                   	pop    %edi
 190:	5d                   	pop    %ebp
 191:	c3                   	ret    
 192:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001a0 <printfile>:

void
printfile(struct fileline* first)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	53                   	push   %ebx
	struct fileline* cur = first;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
 1a4:	31 db                	xor    %ebx,%ebx

}

void
printfile(struct fileline* first)
{
 1a6:	83 ec 04             	sub    $0x4,%esp
 1a9:	8b 4d 08             	mov    0x8(%ebp),%ecx
	struct fileline* cur = first;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
 1ac:	8b 51 58             	mov    0x58(%ecx),%edx
 1af:	85 d2                	test   %edx,%edx
 1b1:	74 4a                	je     1fd <printfile+0x5d>
 1b3:	90                   	nop
 1b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1b8:	31 c0                	xor    %eax,%eax
 1ba:	eb 14                	jmp    1d0 <printfile+0x30>
 1bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		for(int i=0; i<WIDTH; i++){
			if(cur->line[i] == '\0'){
				buf[bufindex] = ' ';
 1c0:	c6 84 03 e0 11 00 00 	movb   $0x20,0x11e0(%ebx,%eax,1)
 1c7:	20 
printfile(struct fileline* first)
{
	struct fileline* cur = first;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
		for(int i=0; i<WIDTH; i++){
 1c8:	83 c0 01             	add    $0x1,%eax
 1cb:	83 f8 50             	cmp    $0x50,%eax
 1ce:	74 18                	je     1e8 <printfile+0x48>
			if(cur->line[i] == '\0'){
 1d0:	0f b6 54 01 04       	movzbl 0x4(%ecx,%eax,1),%edx
 1d5:	84 d2                	test   %dl,%dl
 1d7:	74 e7                	je     1c0 <printfile+0x20>
				buf[bufindex] = ' ';
			} else{
				buf[bufindex] = cur->line[i];
 1d9:	88 94 03 e0 11 00 00 	mov    %dl,0x11e0(%ebx,%eax,1)
printfile(struct fileline* first)
{
	struct fileline* cur = first;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
		for(int i=0; i<WIDTH; i++){
 1e0:	83 c0 01             	add    $0x1,%eax
 1e3:	83 f8 50             	cmp    $0x50,%eax
 1e6:	75 e8                	jne    1d0 <printfile+0x30>
			} else{
				buf[bufindex] = cur->line[i];
			}
			bufindex++;
		}
		cur = cur->next;
 1e8:	8b 49 58             	mov    0x58(%ecx),%ecx
 1eb:	83 c3 50             	add    $0x50,%ebx
void
printfile(struct fileline* first)
{
	struct fileline* cur = first;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
 1ee:	8b 41 58             	mov    0x58(%ecx),%eax
 1f1:	85 c0                	test   %eax,%eax
 1f3:	74 08                	je     1fd <printfile+0x5d>
 1f5:	81 fb e0 06 00 00    	cmp    $0x6e0,%ebx
 1fb:	75 bb                	jne    1b8 <printfile+0x18>

void
printfile(struct fileline* first)
{
	struct fileline* cur = first;
	int bufindex = 0;
 1fd:	31 c0                	xor    %eax,%eax
 1ff:	eb 17                	jmp    218 <printfile+0x78>
 201:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		}
		cur = cur->next;
	}
	for(int i=0; i<WIDTH; i++){
			if(cur->line[i] == '\0'){
				buf[bufindex] = ' ';
 208:	c6 84 03 e0 11 00 00 	movb   $0x20,0x11e0(%ebx,%eax,1)
 20f:	20 
			}
			bufindex++;
		}
		cur = cur->next;
	}
	for(int i=0; i<WIDTH; i++){
 210:	83 c0 01             	add    $0x1,%eax
 213:	83 f8 50             	cmp    $0x50,%eax
 216:	74 18                	je     230 <printfile+0x90>
			if(cur->line[i] == '\0'){
 218:	0f b6 54 01 04       	movzbl 0x4(%ecx,%eax,1),%edx
 21d:	84 d2                	test   %dl,%dl
 21f:	74 e7                	je     208 <printfile+0x68>
				buf[bufindex] = ' ';
			} else{
				buf[bufindex] = cur->line[i];
 221:	88 94 03 e0 11 00 00 	mov    %dl,0x11e0(%ebx,%eax,1)
			}
			bufindex++;
		}
		cur = cur->next;
	}
	for(int i=0; i<WIDTH; i++){
 228:	83 c0 01             	add    $0x1,%eax
 22b:	83 f8 50             	cmp    $0x50,%eax
 22e:	75 e8                	jne    218 <printfile+0x78>
	}
	lastOnScreen = cur;

	buf[bufindex] = '\0';
	//printf(1, "%s\n", buf);
	updatesc(0, 1, buf, TEXT_COLOR);
 230:	6a 07                	push   $0x7
 232:	68 e0 11 00 00       	push   $0x11e0
 237:	6a 01                	push   $0x1
 239:	6a 00                	push   $0x0
			}
			bufindex++;
	}
	lastOnScreen = cur;

	buf[bufindex] = '\0';
 23b:	c6 83 30 12 00 00 00 	movb   $0x0,0x1230(%ebx)
			} else{
				buf[bufindex] = cur->line[i];
			}
			bufindex++;
	}
	lastOnScreen = cur;
 242:	89 0d c4 11 00 00    	mov    %ecx,0x11c4

	buf[bufindex] = '\0';
	//printf(1, "%s\n", buf);
	updatesc(0, 1, buf, TEXT_COLOR);
 248:	e8 35 06 00 00       	call   882 <updatesc>
}
 24d:	83 c4 10             	add    $0x10,%esp
 250:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 253:	c9                   	leave  
 254:	c3                   	ret    
 255:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000260 <drawHeader>:

void
drawHeader() {
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	83 ec 08             	sub    $0x8,%esp
	updatesc(0, 0, "                              ", UI_COLOR);
 266:	68 c0 00 00 00       	push   $0xc0
 26b:	68 b4 0c 00 00       	push   $0xcb4
 270:	6a 00                	push   $0x0
 272:	6a 00                	push   $0x0
 274:	e8 09 06 00 00       	call   882 <updatesc>
	updatesc(30, 0, "        PICO        ", UI_COLOR);
 279:	68 c0 00 00 00       	push   $0xc0
 27e:	68 6f 0c 00 00       	push   $0xc6f
 283:	6a 00                	push   $0x0
 285:	6a 1e                	push   $0x1e
 287:	e8 f6 05 00 00       	call   882 <updatesc>
	updatesc(50, 0, "                         v0.1 ", UI_COLOR);
 28c:	83 c4 20             	add    $0x20,%esp
 28f:	68 c0 00 00 00       	push   $0xc0
 294:	68 d4 0c 00 00       	push   $0xcd4
 299:	6a 00                	push   $0x0
 29b:	6a 32                	push   $0x32
 29d:	e8 e0 05 00 00       	call   882 <updatesc>
}
 2a2:	83 c4 10             	add    $0x10,%esp
 2a5:	c9                   	leave  
 2a6:	c3                   	ret    
 2a7:	89 f6                	mov    %esi,%esi
 2a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002b0 <drawFooter>:

void
drawFooter() {
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	83 ec 08             	sub    $0x8,%esp
	updatesc(0, 24, " ^Q - Quit                                                                      ", UI_COLOR);
 2b6:	68 c0 00 00 00       	push   $0xc0
 2bb:	68 f4 0c 00 00       	push   $0xcf4
 2c0:	6a 18                	push   $0x18
 2c2:	6a 00                	push   $0x0
 2c4:	e8 b9 05 00 00       	call   882 <updatesc>
}
 2c9:	83 c4 10             	add    $0x10,%esp
 2cc:	c9                   	leave  
 2cd:	c3                   	ret    
 2ce:	66 90                	xchg   %ax,%ax

000002d0 <saveedits>:

void
saveedits(void){
 2d0:	55                   	push   %ebp
	//Save edits
	struct fileline* cur = firstOnScreen;
 2d1:	8b 0d c0 11 00 00    	mov    0x11c0,%ecx
drawFooter() {
	updatesc(0, 24, " ^Q - Quit                                                                      ", UI_COLOR);
}

void
saveedits(void){
 2d7:	89 e5                	mov    %esp,%ebp
 2d9:	56                   	push   %esi
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
 2da:	8b 35 c4 11 00 00    	mov    0x11c4,%esi
drawFooter() {
	updatesc(0, 24, " ^Q - Quit                                                                      ", UI_COLOR);
}

void
saveedits(void){
 2e0:	53                   	push   %ebx
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
 2e1:	3b 4e 58             	cmp    0x58(%esi),%ecx
 2e4:	74 31                	je     317 <saveedits+0x47>
 2e6:	31 db                	xor    %ebx,%ebx
 2e8:	90                   	nop
 2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2f0:	31 c0                	xor    %eax,%eax
 2f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		for(int i=0; i<WIDTH; i++){
			cur->line[i] = buf[bufindex];
 2f8:	0f b6 94 03 e0 11 00 	movzbl 0x11e0(%ebx,%eax,1),%edx
 2ff:	00 
 300:	88 54 01 04          	mov    %dl,0x4(%ecx,%eax,1)
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
		for(int i=0; i<WIDTH; i++){
 304:	83 c0 01             	add    $0x1,%eax
 307:	83 f8 50             	cmp    $0x50,%eax
 30a:	75 ec                	jne    2f8 <saveedits+0x28>
 30c:	83 c3 50             	add    $0x50,%ebx
			cur->line[i] = buf[bufindex];
			bufindex++;
		}
		cur = cur->next;
 30f:	8b 49 58             	mov    0x58(%ecx),%ecx
void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
 312:	39 4e 58             	cmp    %ecx,0x58(%esi)
 315:	75 d9                	jne    2f0 <saveedits+0x20>
			cur->line[i] = buf[bufindex];
			bufindex++;
		}
		cur = cur->next;
	}
}
 317:	5b                   	pop    %ebx
 318:	5e                   	pop    %esi
 319:	5d                   	pop    %ebp
 31a:	c3                   	ret    
 31b:	90                   	nop
 31c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000320 <scrolldown>:

void
scrolldown(void){
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	57                   	push   %edi
 324:	56                   	push   %esi
 325:	53                   	push   %ebx
 326:	31 db                	xor    %ebx,%ebx
 328:	83 ec 0c             	sub    $0xc,%esp
void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
 32b:	8b 35 c4 11 00 00    	mov    0x11c4,%esi
}

void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
 331:	8b 3d c0 11 00 00    	mov    0x11c0,%edi
	int bufindex = 0;
	while(cur != lastOnScreen->next){
 337:	39 7e 58             	cmp    %edi,0x58(%esi)
 33a:	89 f9                	mov    %edi,%ecx
 33c:	74 29                	je     367 <scrolldown+0x47>
 33e:	66 90                	xchg   %ax,%ax
 340:	31 c0                	xor    %eax,%eax
 342:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		for(int i=0; i<WIDTH; i++){
			cur->line[i] = buf[bufindex];
 348:	0f b6 94 03 e0 11 00 	movzbl 0x11e0(%ebx,%eax,1),%edx
 34f:	00 
 350:	88 54 01 04          	mov    %dl,0x4(%ecx,%eax,1)
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
		for(int i=0; i<WIDTH; i++){
 354:	83 c0 01             	add    $0x1,%eax
 357:	83 f8 50             	cmp    $0x50,%eax
 35a:	75 ec                	jne    348 <scrolldown+0x28>
 35c:	83 c3 50             	add    $0x50,%ebx
			cur->line[i] = buf[bufindex];
			bufindex++;
		}
		cur = cur->next;
 35f:	8b 49 58             	mov    0x58(%ecx),%ecx
void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
 362:	3b 4e 58             	cmp    0x58(%esi),%ecx
 365:	75 d9                	jne    340 <scrolldown+0x20>
}

void
scrolldown(void){
	saveedits();
	printfile(firstOnScreen->next);
 367:	83 ec 0c             	sub    $0xc,%esp
 36a:	ff 77 58             	pushl  0x58(%edi)
 36d:	e8 2e fe ff ff       	call   1a0 <printfile>
	firstOnScreen = firstOnScreen->next;
 372:	a1 c0 11 00 00       	mov    0x11c0,%eax
 377:	8b 40 58             	mov    0x58(%eax),%eax
 37a:	a3 c0 11 00 00       	mov    %eax,0x11c0
}
 37f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 382:	5b                   	pop    %ebx
 383:	5e                   	pop    %esi
 384:	5f                   	pop    %edi
 385:	5d                   	pop    %ebp
 386:	c3                   	ret    
 387:	89 f6                	mov    %esi,%esi
 389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000390 <scrollup>:

void
scrollup(void){
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	56                   	push   %esi
 395:	53                   	push   %ebx
 396:	31 db                	xor    %ebx,%ebx
 398:	83 ec 0c             	sub    $0xc,%esp
void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
 39b:	8b 35 c4 11 00 00    	mov    0x11c4,%esi
}

void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
 3a1:	8b 3d c0 11 00 00    	mov    0x11c0,%edi
	int bufindex = 0;
	while(cur != lastOnScreen->next){
 3a7:	39 7e 58             	cmp    %edi,0x58(%esi)
 3aa:	89 f9                	mov    %edi,%ecx
 3ac:	74 29                	je     3d7 <scrollup+0x47>
 3ae:	66 90                	xchg   %ax,%ax
 3b0:	31 c0                	xor    %eax,%eax
 3b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		for(int i=0; i<WIDTH; i++){
			cur->line[i] = buf[bufindex];
 3b8:	0f b6 94 03 e0 11 00 	movzbl 0x11e0(%ebx,%eax,1),%edx
 3bf:	00 
 3c0:	88 54 01 04          	mov    %dl,0x4(%ecx,%eax,1)
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
		for(int i=0; i<WIDTH; i++){
 3c4:	83 c0 01             	add    $0x1,%eax
 3c7:	83 f8 50             	cmp    $0x50,%eax
 3ca:	75 ec                	jne    3b8 <scrollup+0x28>
 3cc:	83 c3 50             	add    $0x50,%ebx
			cur->line[i] = buf[bufindex];
			bufindex++;
		}
		cur = cur->next;
 3cf:	8b 49 58             	mov    0x58(%ecx),%ecx
void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
 3d2:	3b 4e 58             	cmp    0x58(%esi),%ecx
 3d5:	75 d9                	jne    3b0 <scrollup+0x20>
}

void
scrollup(void){
	saveedits();
	printfile(firstOnScreen->prev);
 3d7:	83 ec 0c             	sub    $0xc,%esp
 3da:	ff 77 54             	pushl  0x54(%edi)
 3dd:	e8 be fd ff ff       	call   1a0 <printfile>
	firstOnScreen = firstOnScreen->prev;
 3e2:	a1 c0 11 00 00       	mov    0x11c0,%eax
 3e7:	8b 40 54             	mov    0x54(%eax),%eax
 3ea:	a3 c0 11 00 00       	mov    %eax,0x11c0
}
 3ef:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3f2:	5b                   	pop    %ebx
 3f3:	5e                   	pop    %esi
 3f4:	5f                   	pop    %edi
 3f5:	5d                   	pop    %ebp
 3f6:	c3                   	ret    
 3f7:	89 f6                	mov    %esi,%esi
 3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000400 <arrowkeys>:

void
arrowkeys(int i){
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	8b 45 08             	mov    0x8(%ebp),%eax
	//ctrl+j (go left)
	if(i == 10 && (currChar % WIDTH != 0) && currChar > 0){
 406:	83 f8 0a             	cmp    $0xa,%eax
 409:	0f 84 81 00 00 00    	je     490 <arrowkeys+0x90>
		currChar--;
	}
	//ctrl+l (go right)
	else if(i==12 && ((currChar+1) % WIDTH != 0)){
 40f:	83 f8 0c             	cmp    $0xc,%eax
 412:	74 2c                	je     440 <arrowkeys+0x40>
		currChar++;
	}
	//ctrl+k (go down)
	else if(i == 11){
 414:	83 f8 0b             	cmp    $0xb,%eax
 417:	74 57                	je     470 <arrowkeys+0x70>
			if(lastOnScreen->next != 0)
				scrolldown();
		}
	}
	//ctrl+i (go up)
	else if(i == 9){
 419:	83 f8 09             	cmp    $0x9,%eax
 41c:	75 47                	jne    465 <arrowkeys+0x65>
		if(currChar >= WIDTH){
 41e:	a1 a4 11 00 00       	mov    0x11a4,%eax
 423:	83 f8 4f             	cmp    $0x4f,%eax
 426:	0f 8f b4 00 00 00    	jg     4e0 <arrowkeys+0xe0>
			currChar -= WIDTH;
		}
		else{
			if(firstOnScreen->prev != 0)
 42c:	a1 c0 11 00 00       	mov    0x11c0,%eax
 431:	8b 40 54             	mov    0x54(%eax),%eax
 434:	85 c0                	test   %eax,%eax
 436:	74 2d                	je     465 <arrowkeys+0x65>
				scrollup();
		}
	}
}
 438:	5d                   	pop    %ebp
		if(currChar >= WIDTH){
			currChar -= WIDTH;
		}
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
 439:	e9 52 ff ff ff       	jmp    390 <scrollup>
 43e:	66 90                	xchg   %ax,%ax
	//ctrl+j (go left)
	if(i == 10 && (currChar % WIDTH != 0) && currChar > 0){
		currChar--;
	}
	//ctrl+l (go right)
	else if(i==12 && ((currChar+1) % WIDTH != 0)){
 440:	a1 a4 11 00 00       	mov    0x11a4,%eax
 445:	ba 67 66 66 66       	mov    $0x66666667,%edx
 44a:	8d 48 01             	lea    0x1(%eax),%ecx
 44d:	89 c8                	mov    %ecx,%eax
 44f:	f7 ea                	imul   %edx
 451:	89 c8                	mov    %ecx,%eax
 453:	c1 f8 1f             	sar    $0x1f,%eax
 456:	c1 fa 05             	sar    $0x5,%edx
 459:	29 c2                	sub    %eax,%edx
 45b:	8d 04 92             	lea    (%edx,%edx,4),%eax
 45e:	c1 e0 04             	shl    $0x4,%eax
 461:	39 c1                	cmp    %eax,%ecx
 463:	75 63                	jne    4c8 <arrowkeys+0xc8>
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
}
 465:	5d                   	pop    %ebp
 466:	c3                   	ret    
 467:	89 f6                	mov    %esi,%esi
 469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	else if(i==12 && ((currChar+1) % WIDTH != 0)){
		currChar++;
	}
	//ctrl+k (go down)
	else if(i == 11){
		if(currChar < TOTAL_CHARS - WIDTH){
 470:	a1 a4 11 00 00       	mov    0x11a4,%eax
 475:	3d df 06 00 00       	cmp    $0x6df,%eax
 47a:	7e 54                	jle    4d0 <arrowkeys+0xd0>
			currChar += WIDTH;
		}
		else{
			if(lastOnScreen->next != 0)
 47c:	a1 c4 11 00 00       	mov    0x11c4,%eax
 481:	8b 50 58             	mov    0x58(%eax),%edx
 484:	85 d2                	test   %edx,%edx
 486:	74 dd                	je     465 <arrowkeys+0x65>
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
}
 488:	5d                   	pop    %ebp
		if(currChar < TOTAL_CHARS - WIDTH){
			currChar += WIDTH;
		}
		else{
			if(lastOnScreen->next != 0)
				scrolldown();
 489:	e9 92 fe ff ff       	jmp    320 <scrolldown>
 48e:	66 90                	xchg   %ax,%ax
}

void
arrowkeys(int i){
	//ctrl+j (go left)
	if(i == 10 && (currChar % WIDTH != 0) && currChar > 0){
 490:	8b 0d a4 11 00 00    	mov    0x11a4,%ecx
 496:	ba 67 66 66 66       	mov    $0x66666667,%edx
 49b:	89 c8                	mov    %ecx,%eax
 49d:	f7 ea                	imul   %edx
 49f:	89 c8                	mov    %ecx,%eax
 4a1:	c1 f8 1f             	sar    $0x1f,%eax
 4a4:	c1 fa 05             	sar    $0x5,%edx
 4a7:	29 c2                	sub    %eax,%edx
 4a9:	8d 04 92             	lea    (%edx,%edx,4),%eax
 4ac:	c1 e0 04             	shl    $0x4,%eax
 4af:	39 c1                	cmp    %eax,%ecx
 4b1:	74 b2                	je     465 <arrowkeys+0x65>
 4b3:	85 c9                	test   %ecx,%ecx
 4b5:	7e ae                	jle    465 <arrowkeys+0x65>
		currChar--;
 4b7:	83 e9 01             	sub    $0x1,%ecx
 4ba:	89 0d a4 11 00 00    	mov    %ecx,0x11a4
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
}
 4c0:	5d                   	pop    %ebp
 4c1:	c3                   	ret    
 4c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	if(i == 10 && (currChar % WIDTH != 0) && currChar > 0){
		currChar--;
	}
	//ctrl+l (go right)
	else if(i==12 && ((currChar+1) % WIDTH != 0)){
		currChar++;
 4c8:	89 0d a4 11 00 00    	mov    %ecx,0x11a4
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
}
 4ce:	5d                   	pop    %ebp
 4cf:	c3                   	ret    
		currChar++;
	}
	//ctrl+k (go down)
	else if(i == 11){
		if(currChar < TOTAL_CHARS - WIDTH){
			currChar += WIDTH;
 4d0:	83 c0 50             	add    $0x50,%eax
 4d3:	a3 a4 11 00 00       	mov    %eax,0x11a4
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
}
 4d8:	5d                   	pop    %ebp
 4d9:	c3                   	ret    
 4da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		}
	}
	//ctrl+i (go up)
	else if(i == 9){
		if(currChar >= WIDTH){
			currChar -= WIDTH;
 4e0:	83 e8 50             	sub    $0x50,%eax
 4e3:	a3 a4 11 00 00       	mov    %eax,0x11a4
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
}
 4e8:	5d                   	pop    %ebp
 4e9:	c3                   	ret    
 4ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000004f0 <handleInput>:

void
handleInput(int i) {
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	56                   	push   %esi
 4f4:	53                   	push   %ebx
 4f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
	//ctrl+q
	if (i == 17) {
 4f8:	83 fb 11             	cmp    $0x11,%ebx
 4fb:	0f 84 85 00 00 00    	je     586 <handleInput+0x96>
		exit();
	}
	printf(1, "currChar: %d\n", currChar);
 501:	83 ec 04             	sub    $0x4,%esp
 504:	ff 35 a4 11 00 00    	pushl  0x11a4
 50a:	68 84 0c 00 00       	push   $0xc84
 50f:	6a 01                	push   $0x1
 511:	e8 2a 04 00 00       	call   940 <printf>
	if(i >= 9 && i<= 12){
 516:	8d 43 f7             	lea    -0x9(%ebx),%eax
 519:	83 c4 10             	add    $0x10,%esp
 51c:	83 f8 03             	cmp    $0x3,%eax
 51f:	76 57                	jbe    578 <handleInput+0x88>
		arrowkeys(i);
	}
	//backspace
	else if(i == 127){
 521:	83 fb 7f             	cmp    $0x7f,%ebx
 524:	74 45                	je     56b <handleInput+0x7b>

	}
	//On right edge of window 
	else if((currChar+1) % WIDTH == 0){
 526:	8b 35 a4 11 00 00    	mov    0x11a4,%esi
 52c:	ba 67 66 66 66       	mov    $0x66666667,%edx
 531:	8d 4e 01             	lea    0x1(%esi),%ecx
 534:	89 c8                	mov    %ecx,%eax
 536:	f7 ea                	imul   %edx
 538:	89 c8                	mov    %ecx,%eax
 53a:	c1 f8 1f             	sar    $0x1f,%eax
 53d:	c1 fa 05             	sar    $0x5,%edx
 540:	29 c2                	sub    %eax,%edx
 542:	8d 04 92             	lea    (%edx,%edx,4),%eax
 545:	c1 e0 04             	shl    $0x4,%eax
 548:	39 c1                	cmp    %eax,%ecx
 54a:	74 06                	je     552 <handleInput+0x62>
		buf[currChar] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
		// printf(1, "new input");
	}
	else{
		buf[currChar++] = (char) i & 0xff;
 54c:	89 0d a4 11 00 00    	mov    %ecx,0x11a4
		updatesc(0, 1, buf, TEXT_COLOR);
 552:	6a 07                	push   $0x7
 554:	68 e0 11 00 00       	push   $0x11e0
 559:	6a 01                	push   $0x1
 55b:	6a 00                	push   $0x0
		buf[currChar] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
		// printf(1, "new input");
	}
	else{
		buf[currChar++] = (char) i & 0xff;
 55d:	88 9e e0 11 00 00    	mov    %bl,0x11e0(%esi)
		updatesc(0, 1, buf, TEXT_COLOR);
 563:	e8 1a 03 00 00       	call   882 <updatesc>
 568:	83 c4 10             	add    $0x10,%esp
	}
}
 56b:	8d 65 f8             	lea    -0x8(%ebp),%esp
 56e:	5b                   	pop    %ebx
 56f:	5e                   	pop    %esi
 570:	5d                   	pop    %ebp
 571:	c3                   	ret    
 572:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	if (i == 17) {
		exit();
	}
	printf(1, "currChar: %d\n", currChar);
	if(i >= 9 && i<= 12){
		arrowkeys(i);
 578:	89 5d 08             	mov    %ebx,0x8(%ebp)
	}
	else{
		buf[currChar++] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
	}
}
 57b:	8d 65 f8             	lea    -0x8(%ebp),%esp
 57e:	5b                   	pop    %ebx
 57f:	5e                   	pop    %esi
 580:	5d                   	pop    %ebp
	if (i == 17) {
		exit();
	}
	printf(1, "currChar: %d\n", currChar);
	if(i >= 9 && i<= 12){
		arrowkeys(i);
 581:	e9 7a fe ff ff       	jmp    400 <arrowkeys>

void
handleInput(int i) {
	//ctrl+q
	if (i == 17) {
		exit();
 586:	e8 47 02 00 00       	call   7d2 <exit>
 58b:	66 90                	xchg   %ax,%ax
 58d:	66 90                	xchg   %ax,%ax
 58f:	90                   	nop

00000590 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	53                   	push   %ebx
 594:	8b 45 08             	mov    0x8(%ebp),%eax
 597:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 59a:	89 c2                	mov    %eax,%edx
 59c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5a0:	83 c1 01             	add    $0x1,%ecx
 5a3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 5a7:	83 c2 01             	add    $0x1,%edx
 5aa:	84 db                	test   %bl,%bl
 5ac:	88 5a ff             	mov    %bl,-0x1(%edx)
 5af:	75 ef                	jne    5a0 <strcpy+0x10>
    ;
  return os;
}
 5b1:	5b                   	pop    %ebx
 5b2:	5d                   	pop    %ebp
 5b3:	c3                   	ret    
 5b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000005c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	56                   	push   %esi
 5c4:	53                   	push   %ebx
 5c5:	8b 55 08             	mov    0x8(%ebp),%edx
 5c8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 5cb:	0f b6 02             	movzbl (%edx),%eax
 5ce:	0f b6 19             	movzbl (%ecx),%ebx
 5d1:	84 c0                	test   %al,%al
 5d3:	75 1e                	jne    5f3 <strcmp+0x33>
 5d5:	eb 29                	jmp    600 <strcmp+0x40>
 5d7:	89 f6                	mov    %esi,%esi
 5d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 5e0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 5e3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 5e6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 5e9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 5ed:	84 c0                	test   %al,%al
 5ef:	74 0f                	je     600 <strcmp+0x40>
 5f1:	89 f1                	mov    %esi,%ecx
 5f3:	38 d8                	cmp    %bl,%al
 5f5:	74 e9                	je     5e0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 5f7:	29 d8                	sub    %ebx,%eax
}
 5f9:	5b                   	pop    %ebx
 5fa:	5e                   	pop    %esi
 5fb:	5d                   	pop    %ebp
 5fc:	c3                   	ret    
 5fd:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 600:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 602:	29 d8                	sub    %ebx,%eax
}
 604:	5b                   	pop    %ebx
 605:	5e                   	pop    %esi
 606:	5d                   	pop    %ebp
 607:	c3                   	ret    
 608:	90                   	nop
 609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000610 <strlen>:

uint
strlen(char *s)
{
 610:	55                   	push   %ebp
 611:	89 e5                	mov    %esp,%ebp
 613:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 616:	80 39 00             	cmpb   $0x0,(%ecx)
 619:	74 12                	je     62d <strlen+0x1d>
 61b:	31 d2                	xor    %edx,%edx
 61d:	8d 76 00             	lea    0x0(%esi),%esi
 620:	83 c2 01             	add    $0x1,%edx
 623:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 627:	89 d0                	mov    %edx,%eax
 629:	75 f5                	jne    620 <strlen+0x10>
    ;
  return n;
}
 62b:	5d                   	pop    %ebp
 62c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 62d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 62f:	5d                   	pop    %ebp
 630:	c3                   	ret    
 631:	eb 0d                	jmp    640 <memset>
 633:	90                   	nop
 634:	90                   	nop
 635:	90                   	nop
 636:	90                   	nop
 637:	90                   	nop
 638:	90                   	nop
 639:	90                   	nop
 63a:	90                   	nop
 63b:	90                   	nop
 63c:	90                   	nop
 63d:	90                   	nop
 63e:	90                   	nop
 63f:	90                   	nop

00000640 <memset>:

void*
memset(void *dst, int c, uint n)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	57                   	push   %edi
 644:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 647:	8b 4d 10             	mov    0x10(%ebp),%ecx
 64a:	8b 45 0c             	mov    0xc(%ebp),%eax
 64d:	89 d7                	mov    %edx,%edi
 64f:	fc                   	cld    
 650:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 652:	89 d0                	mov    %edx,%eax
 654:	5f                   	pop    %edi
 655:	5d                   	pop    %ebp
 656:	c3                   	ret    
 657:	89 f6                	mov    %esi,%esi
 659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000660 <strchr>:

char*
strchr(const char *s, char c)
{
 660:	55                   	push   %ebp
 661:	89 e5                	mov    %esp,%ebp
 663:	53                   	push   %ebx
 664:	8b 45 08             	mov    0x8(%ebp),%eax
 667:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 66a:	0f b6 10             	movzbl (%eax),%edx
 66d:	84 d2                	test   %dl,%dl
 66f:	74 1d                	je     68e <strchr+0x2e>
    if(*s == c)
 671:	38 d3                	cmp    %dl,%bl
 673:	89 d9                	mov    %ebx,%ecx
 675:	75 0d                	jne    684 <strchr+0x24>
 677:	eb 17                	jmp    690 <strchr+0x30>
 679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 680:	38 ca                	cmp    %cl,%dl
 682:	74 0c                	je     690 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 684:	83 c0 01             	add    $0x1,%eax
 687:	0f b6 10             	movzbl (%eax),%edx
 68a:	84 d2                	test   %dl,%dl
 68c:	75 f2                	jne    680 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 68e:	31 c0                	xor    %eax,%eax
}
 690:	5b                   	pop    %ebx
 691:	5d                   	pop    %ebp
 692:	c3                   	ret    
 693:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006a0 <gets>:

char*
gets(char *buf, int max)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	57                   	push   %edi
 6a4:	56                   	push   %esi
 6a5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 6a6:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 6a8:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 6ab:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 6ae:	eb 29                	jmp    6d9 <gets+0x39>
    cc = read(0, &c, 1);
 6b0:	83 ec 04             	sub    $0x4,%esp
 6b3:	6a 01                	push   $0x1
 6b5:	57                   	push   %edi
 6b6:	6a 00                	push   $0x0
 6b8:	e8 2d 01 00 00       	call   7ea <read>
    if(cc < 1)
 6bd:	83 c4 10             	add    $0x10,%esp
 6c0:	85 c0                	test   %eax,%eax
 6c2:	7e 1d                	jle    6e1 <gets+0x41>
      break;
    buf[i++] = c;
 6c4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 6c8:	8b 55 08             	mov    0x8(%ebp),%edx
 6cb:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 6cd:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 6cf:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 6d3:	74 1b                	je     6f0 <gets+0x50>
 6d5:	3c 0d                	cmp    $0xd,%al
 6d7:	74 17                	je     6f0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 6d9:	8d 5e 01             	lea    0x1(%esi),%ebx
 6dc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 6df:	7c cf                	jl     6b0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 6e1:	8b 45 08             	mov    0x8(%ebp),%eax
 6e4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 6e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6eb:	5b                   	pop    %ebx
 6ec:	5e                   	pop    %esi
 6ed:	5f                   	pop    %edi
 6ee:	5d                   	pop    %ebp
 6ef:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 6f0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 6f3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 6f5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 6f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6fc:	5b                   	pop    %ebx
 6fd:	5e                   	pop    %esi
 6fe:	5f                   	pop    %edi
 6ff:	5d                   	pop    %ebp
 700:	c3                   	ret    
 701:	eb 0d                	jmp    710 <stat>
 703:	90                   	nop
 704:	90                   	nop
 705:	90                   	nop
 706:	90                   	nop
 707:	90                   	nop
 708:	90                   	nop
 709:	90                   	nop
 70a:	90                   	nop
 70b:	90                   	nop
 70c:	90                   	nop
 70d:	90                   	nop
 70e:	90                   	nop
 70f:	90                   	nop

00000710 <stat>:

int
stat(char *n, struct stat *st)
{
 710:	55                   	push   %ebp
 711:	89 e5                	mov    %esp,%ebp
 713:	56                   	push   %esi
 714:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 715:	83 ec 08             	sub    $0x8,%esp
 718:	6a 00                	push   $0x0
 71a:	ff 75 08             	pushl  0x8(%ebp)
 71d:	e8 f0 00 00 00       	call   812 <open>
  if(fd < 0)
 722:	83 c4 10             	add    $0x10,%esp
 725:	85 c0                	test   %eax,%eax
 727:	78 27                	js     750 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 729:	83 ec 08             	sub    $0x8,%esp
 72c:	ff 75 0c             	pushl  0xc(%ebp)
 72f:	89 c3                	mov    %eax,%ebx
 731:	50                   	push   %eax
 732:	e8 f3 00 00 00       	call   82a <fstat>
 737:	89 c6                	mov    %eax,%esi
  close(fd);
 739:	89 1c 24             	mov    %ebx,(%esp)
 73c:	e8 b9 00 00 00       	call   7fa <close>
  return r;
 741:	83 c4 10             	add    $0x10,%esp
 744:	89 f0                	mov    %esi,%eax
}
 746:	8d 65 f8             	lea    -0x8(%ebp),%esp
 749:	5b                   	pop    %ebx
 74a:	5e                   	pop    %esi
 74b:	5d                   	pop    %ebp
 74c:	c3                   	ret    
 74d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 750:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 755:	eb ef                	jmp    746 <stat+0x36>
 757:	89 f6                	mov    %esi,%esi
 759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000760 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	53                   	push   %ebx
 764:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 767:	0f be 11             	movsbl (%ecx),%edx
 76a:	8d 42 d0             	lea    -0x30(%edx),%eax
 76d:	3c 09                	cmp    $0x9,%al
 76f:	b8 00 00 00 00       	mov    $0x0,%eax
 774:	77 1f                	ja     795 <atoi+0x35>
 776:	8d 76 00             	lea    0x0(%esi),%esi
 779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 780:	8d 04 80             	lea    (%eax,%eax,4),%eax
 783:	83 c1 01             	add    $0x1,%ecx
 786:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 78a:	0f be 11             	movsbl (%ecx),%edx
 78d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 790:	80 fb 09             	cmp    $0x9,%bl
 793:	76 eb                	jbe    780 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 795:	5b                   	pop    %ebx
 796:	5d                   	pop    %ebp
 797:	c3                   	ret    
 798:	90                   	nop
 799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000007a0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 7a0:	55                   	push   %ebp
 7a1:	89 e5                	mov    %esp,%ebp
 7a3:	56                   	push   %esi
 7a4:	53                   	push   %ebx
 7a5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 7a8:	8b 45 08             	mov    0x8(%ebp),%eax
 7ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 7ae:	85 db                	test   %ebx,%ebx
 7b0:	7e 14                	jle    7c6 <memmove+0x26>
 7b2:	31 d2                	xor    %edx,%edx
 7b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 7b8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 7bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 7bf:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 7c2:	39 da                	cmp    %ebx,%edx
 7c4:	75 f2                	jne    7b8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 7c6:	5b                   	pop    %ebx
 7c7:	5e                   	pop    %esi
 7c8:	5d                   	pop    %ebp
 7c9:	c3                   	ret    

000007ca <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 7ca:	b8 01 00 00 00       	mov    $0x1,%eax
 7cf:	cd 40                	int    $0x40
 7d1:	c3                   	ret    

000007d2 <exit>:
SYSCALL(exit)
 7d2:	b8 02 00 00 00       	mov    $0x2,%eax
 7d7:	cd 40                	int    $0x40
 7d9:	c3                   	ret    

000007da <wait>:
SYSCALL(wait)
 7da:	b8 03 00 00 00       	mov    $0x3,%eax
 7df:	cd 40                	int    $0x40
 7e1:	c3                   	ret    

000007e2 <pipe>:
SYSCALL(pipe)
 7e2:	b8 04 00 00 00       	mov    $0x4,%eax
 7e7:	cd 40                	int    $0x40
 7e9:	c3                   	ret    

000007ea <read>:
SYSCALL(read)
 7ea:	b8 05 00 00 00       	mov    $0x5,%eax
 7ef:	cd 40                	int    $0x40
 7f1:	c3                   	ret    

000007f2 <write>:
SYSCALL(write)
 7f2:	b8 10 00 00 00       	mov    $0x10,%eax
 7f7:	cd 40                	int    $0x40
 7f9:	c3                   	ret    

000007fa <close>:
SYSCALL(close)
 7fa:	b8 15 00 00 00       	mov    $0x15,%eax
 7ff:	cd 40                	int    $0x40
 801:	c3                   	ret    

00000802 <kill>:
SYSCALL(kill)
 802:	b8 06 00 00 00       	mov    $0x6,%eax
 807:	cd 40                	int    $0x40
 809:	c3                   	ret    

0000080a <exec>:
SYSCALL(exec)
 80a:	b8 07 00 00 00       	mov    $0x7,%eax
 80f:	cd 40                	int    $0x40
 811:	c3                   	ret    

00000812 <open>:
SYSCALL(open)
 812:	b8 0f 00 00 00       	mov    $0xf,%eax
 817:	cd 40                	int    $0x40
 819:	c3                   	ret    

0000081a <mknod>:
SYSCALL(mknod)
 81a:	b8 11 00 00 00       	mov    $0x11,%eax
 81f:	cd 40                	int    $0x40
 821:	c3                   	ret    

00000822 <unlink>:
SYSCALL(unlink)
 822:	b8 12 00 00 00       	mov    $0x12,%eax
 827:	cd 40                	int    $0x40
 829:	c3                   	ret    

0000082a <fstat>:
SYSCALL(fstat)
 82a:	b8 08 00 00 00       	mov    $0x8,%eax
 82f:	cd 40                	int    $0x40
 831:	c3                   	ret    

00000832 <link>:
SYSCALL(link)
 832:	b8 13 00 00 00       	mov    $0x13,%eax
 837:	cd 40                	int    $0x40
 839:	c3                   	ret    

0000083a <mkdir>:
SYSCALL(mkdir)
 83a:	b8 14 00 00 00       	mov    $0x14,%eax
 83f:	cd 40                	int    $0x40
 841:	c3                   	ret    

00000842 <chdir>:
SYSCALL(chdir)
 842:	b8 09 00 00 00       	mov    $0x9,%eax
 847:	cd 40                	int    $0x40
 849:	c3                   	ret    

0000084a <dup>:
SYSCALL(dup)
 84a:	b8 0a 00 00 00       	mov    $0xa,%eax
 84f:	cd 40                	int    $0x40
 851:	c3                   	ret    

00000852 <getpid>:
SYSCALL(getpid)
 852:	b8 0b 00 00 00       	mov    $0xb,%eax
 857:	cd 40                	int    $0x40
 859:	c3                   	ret    

0000085a <sbrk>:
SYSCALL(sbrk)
 85a:	b8 0c 00 00 00       	mov    $0xc,%eax
 85f:	cd 40                	int    $0x40
 861:	c3                   	ret    

00000862 <sleep>:
SYSCALL(sleep)
 862:	b8 0d 00 00 00       	mov    $0xd,%eax
 867:	cd 40                	int    $0x40
 869:	c3                   	ret    

0000086a <uptime>:
SYSCALL(uptime)
 86a:	b8 0e 00 00 00       	mov    $0xe,%eax
 86f:	cd 40                	int    $0x40
 871:	c3                   	ret    

00000872 <captsc>:
SYSCALL(captsc)
 872:	b8 16 00 00 00       	mov    $0x16,%eax
 877:	cd 40                	int    $0x40
 879:	c3                   	ret    

0000087a <freesc>:
SYSCALL(freesc)
 87a:	b8 17 00 00 00       	mov    $0x17,%eax
 87f:	cd 40                	int    $0x40
 881:	c3                   	ret    

00000882 <updatesc>:
SYSCALL(updatesc)
 882:	b8 18 00 00 00       	mov    $0x18,%eax
 887:	cd 40                	int    $0x40
 889:	c3                   	ret    

0000088a <getkey>:
SYSCALL(getkey)
 88a:	b8 19 00 00 00       	mov    $0x19,%eax
 88f:	cd 40                	int    $0x40
 891:	c3                   	ret    
 892:	66 90                	xchg   %ax,%ax
 894:	66 90                	xchg   %ax,%ax
 896:	66 90                	xchg   %ax,%ax
 898:	66 90                	xchg   %ax,%ax
 89a:	66 90                	xchg   %ax,%ax
 89c:	66 90                	xchg   %ax,%ax
 89e:	66 90                	xchg   %ax,%ax

000008a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 8a0:	55                   	push   %ebp
 8a1:	89 e5                	mov    %esp,%ebp
 8a3:	57                   	push   %edi
 8a4:	56                   	push   %esi
 8a5:	53                   	push   %ebx
 8a6:	89 c6                	mov    %eax,%esi
 8a8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 8ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
 8ae:	85 db                	test   %ebx,%ebx
 8b0:	74 7e                	je     930 <printint+0x90>
 8b2:	89 d0                	mov    %edx,%eax
 8b4:	c1 e8 1f             	shr    $0x1f,%eax
 8b7:	84 c0                	test   %al,%al
 8b9:	74 75                	je     930 <printint+0x90>
    neg = 1;
    x = -xx;
 8bb:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 8bd:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 8c4:	f7 d8                	neg    %eax
 8c6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 8c9:	31 ff                	xor    %edi,%edi
 8cb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 8ce:	89 ce                	mov    %ecx,%esi
 8d0:	eb 08                	jmp    8da <printint+0x3a>
 8d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 8d8:	89 cf                	mov    %ecx,%edi
 8da:	31 d2                	xor    %edx,%edx
 8dc:	8d 4f 01             	lea    0x1(%edi),%ecx
 8df:	f7 f6                	div    %esi
 8e1:	0f b6 92 50 0d 00 00 	movzbl 0xd50(%edx),%edx
  }while((x /= base) != 0);
 8e8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 8ea:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 8ed:	75 e9                	jne    8d8 <printint+0x38>
  if(neg)
 8ef:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 8f2:	8b 75 c0             	mov    -0x40(%ebp),%esi
 8f5:	85 c0                	test   %eax,%eax
 8f7:	74 08                	je     901 <printint+0x61>
    buf[i++] = '-';
 8f9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 8fe:	8d 4f 02             	lea    0x2(%edi),%ecx
 901:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 905:	8d 76 00             	lea    0x0(%esi),%esi
 908:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 90b:	83 ec 04             	sub    $0x4,%esp
 90e:	83 ef 01             	sub    $0x1,%edi
 911:	6a 01                	push   $0x1
 913:	53                   	push   %ebx
 914:	56                   	push   %esi
 915:	88 45 d7             	mov    %al,-0x29(%ebp)
 918:	e8 d5 fe ff ff       	call   7f2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 91d:	83 c4 10             	add    $0x10,%esp
 920:	39 df                	cmp    %ebx,%edi
 922:	75 e4                	jne    908 <printint+0x68>
    putc(fd, buf[i]);
}
 924:	8d 65 f4             	lea    -0xc(%ebp),%esp
 927:	5b                   	pop    %ebx
 928:	5e                   	pop    %esi
 929:	5f                   	pop    %edi
 92a:	5d                   	pop    %ebp
 92b:	c3                   	ret    
 92c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 930:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 932:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 939:	eb 8b                	jmp    8c6 <printint+0x26>
 93b:	90                   	nop
 93c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000940 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 940:	55                   	push   %ebp
 941:	89 e5                	mov    %esp,%ebp
 943:	57                   	push   %edi
 944:	56                   	push   %esi
 945:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 946:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 949:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 94c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 94f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 952:	89 45 d0             	mov    %eax,-0x30(%ebp)
 955:	0f b6 1e             	movzbl (%esi),%ebx
 958:	83 c6 01             	add    $0x1,%esi
 95b:	84 db                	test   %bl,%bl
 95d:	0f 84 b0 00 00 00    	je     a13 <printf+0xd3>
 963:	31 d2                	xor    %edx,%edx
 965:	eb 39                	jmp    9a0 <printf+0x60>
 967:	89 f6                	mov    %esi,%esi
 969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 970:	83 f8 25             	cmp    $0x25,%eax
 973:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 976:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 97b:	74 18                	je     995 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 97d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 980:	83 ec 04             	sub    $0x4,%esp
 983:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 986:	6a 01                	push   $0x1
 988:	50                   	push   %eax
 989:	57                   	push   %edi
 98a:	e8 63 fe ff ff       	call   7f2 <write>
 98f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 992:	83 c4 10             	add    $0x10,%esp
 995:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 998:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 99c:	84 db                	test   %bl,%bl
 99e:	74 73                	je     a13 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 9a0:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 9a2:	0f be cb             	movsbl %bl,%ecx
 9a5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 9a8:	74 c6                	je     970 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 9aa:	83 fa 25             	cmp    $0x25,%edx
 9ad:	75 e6                	jne    995 <printf+0x55>
      if(c == 'd'){
 9af:	83 f8 64             	cmp    $0x64,%eax
 9b2:	0f 84 f8 00 00 00    	je     ab0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 9b8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 9be:	83 f9 70             	cmp    $0x70,%ecx
 9c1:	74 5d                	je     a20 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 9c3:	83 f8 73             	cmp    $0x73,%eax
 9c6:	0f 84 84 00 00 00    	je     a50 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 9cc:	83 f8 63             	cmp    $0x63,%eax
 9cf:	0f 84 ea 00 00 00    	je     abf <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 9d5:	83 f8 25             	cmp    $0x25,%eax
 9d8:	0f 84 c2 00 00 00    	je     aa0 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 9de:	8d 45 e7             	lea    -0x19(%ebp),%eax
 9e1:	83 ec 04             	sub    $0x4,%esp
 9e4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 9e8:	6a 01                	push   $0x1
 9ea:	50                   	push   %eax
 9eb:	57                   	push   %edi
 9ec:	e8 01 fe ff ff       	call   7f2 <write>
 9f1:	83 c4 0c             	add    $0xc,%esp
 9f4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 9f7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 9fa:	6a 01                	push   $0x1
 9fc:	50                   	push   %eax
 9fd:	57                   	push   %edi
 9fe:	83 c6 01             	add    $0x1,%esi
 a01:	e8 ec fd ff ff       	call   7f2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 a06:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 a0a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 a0d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 a0f:	84 db                	test   %bl,%bl
 a11:	75 8d                	jne    9a0 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 a13:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a16:	5b                   	pop    %ebx
 a17:	5e                   	pop    %esi
 a18:	5f                   	pop    %edi
 a19:	5d                   	pop    %ebp
 a1a:	c3                   	ret    
 a1b:	90                   	nop
 a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 a20:	83 ec 0c             	sub    $0xc,%esp
 a23:	b9 10 00 00 00       	mov    $0x10,%ecx
 a28:	6a 00                	push   $0x0
 a2a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 a2d:	89 f8                	mov    %edi,%eax
 a2f:	8b 13                	mov    (%ebx),%edx
 a31:	e8 6a fe ff ff       	call   8a0 <printint>
        ap++;
 a36:	89 d8                	mov    %ebx,%eax
 a38:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 a3b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 a3d:	83 c0 04             	add    $0x4,%eax
 a40:	89 45 d0             	mov    %eax,-0x30(%ebp)
 a43:	e9 4d ff ff ff       	jmp    995 <printf+0x55>
 a48:	90                   	nop
 a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 a50:	8b 45 d0             	mov    -0x30(%ebp),%eax
 a53:	8b 18                	mov    (%eax),%ebx
        ap++;
 a55:	83 c0 04             	add    $0x4,%eax
 a58:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 a5b:	b8 48 0d 00 00       	mov    $0xd48,%eax
 a60:	85 db                	test   %ebx,%ebx
 a62:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 a65:	0f b6 03             	movzbl (%ebx),%eax
 a68:	84 c0                	test   %al,%al
 a6a:	74 23                	je     a8f <printf+0x14f>
 a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 a70:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 a73:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 a76:	83 ec 04             	sub    $0x4,%esp
 a79:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 a7b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 a7e:	50                   	push   %eax
 a7f:	57                   	push   %edi
 a80:	e8 6d fd ff ff       	call   7f2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 a85:	0f b6 03             	movzbl (%ebx),%eax
 a88:	83 c4 10             	add    $0x10,%esp
 a8b:	84 c0                	test   %al,%al
 a8d:	75 e1                	jne    a70 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 a8f:	31 d2                	xor    %edx,%edx
 a91:	e9 ff fe ff ff       	jmp    995 <printf+0x55>
 a96:	8d 76 00             	lea    0x0(%esi),%esi
 a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 aa0:	83 ec 04             	sub    $0x4,%esp
 aa3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 aa6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 aa9:	6a 01                	push   $0x1
 aab:	e9 4c ff ff ff       	jmp    9fc <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 ab0:	83 ec 0c             	sub    $0xc,%esp
 ab3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 ab8:	6a 01                	push   $0x1
 aba:	e9 6b ff ff ff       	jmp    a2a <printf+0xea>
 abf:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 ac2:	83 ec 04             	sub    $0x4,%esp
 ac5:	8b 03                	mov    (%ebx),%eax
 ac7:	6a 01                	push   $0x1
 ac9:	88 45 e4             	mov    %al,-0x1c(%ebp)
 acc:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 acf:	50                   	push   %eax
 ad0:	57                   	push   %edi
 ad1:	e8 1c fd ff ff       	call   7f2 <write>
 ad6:	e9 5b ff ff ff       	jmp    a36 <printf+0xf6>
 adb:	66 90                	xchg   %ax,%ax
 add:	66 90                	xchg   %ax,%ax
 adf:	90                   	nop

00000ae0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ae0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ae1:	a1 a8 11 00 00       	mov    0x11a8,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 ae6:	89 e5                	mov    %esp,%ebp
 ae8:	57                   	push   %edi
 ae9:	56                   	push   %esi
 aea:	53                   	push   %ebx
 aeb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aee:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 af0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 af3:	39 c8                	cmp    %ecx,%eax
 af5:	73 19                	jae    b10 <free+0x30>
 af7:	89 f6                	mov    %esi,%esi
 af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 b00:	39 d1                	cmp    %edx,%ecx
 b02:	72 1c                	jb     b20 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b04:	39 d0                	cmp    %edx,%eax
 b06:	73 18                	jae    b20 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 b08:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b0a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b0c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b0e:	72 f0                	jb     b00 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b10:	39 d0                	cmp    %edx,%eax
 b12:	72 f4                	jb     b08 <free+0x28>
 b14:	39 d1                	cmp    %edx,%ecx
 b16:	73 f0                	jae    b08 <free+0x28>
 b18:	90                   	nop
 b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 b20:	8b 73 fc             	mov    -0x4(%ebx),%esi
 b23:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 b26:	39 d7                	cmp    %edx,%edi
 b28:	74 19                	je     b43 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 b2a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b2d:	8b 50 04             	mov    0x4(%eax),%edx
 b30:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b33:	39 f1                	cmp    %esi,%ecx
 b35:	74 23                	je     b5a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 b37:	89 08                	mov    %ecx,(%eax)
  freep = p;
 b39:	a3 a8 11 00 00       	mov    %eax,0x11a8
}
 b3e:	5b                   	pop    %ebx
 b3f:	5e                   	pop    %esi
 b40:	5f                   	pop    %edi
 b41:	5d                   	pop    %ebp
 b42:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b43:	03 72 04             	add    0x4(%edx),%esi
 b46:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 b49:	8b 10                	mov    (%eax),%edx
 b4b:	8b 12                	mov    (%edx),%edx
 b4d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 b50:	8b 50 04             	mov    0x4(%eax),%edx
 b53:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b56:	39 f1                	cmp    %esi,%ecx
 b58:	75 dd                	jne    b37 <free+0x57>
    p->s.size += bp->s.size;
 b5a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 b5d:	a3 a8 11 00 00       	mov    %eax,0x11a8
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 b62:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 b65:	8b 53 f8             	mov    -0x8(%ebx),%edx
 b68:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 b6a:	5b                   	pop    %ebx
 b6b:	5e                   	pop    %esi
 b6c:	5f                   	pop    %edi
 b6d:	5d                   	pop    %ebp
 b6e:	c3                   	ret    
 b6f:	90                   	nop

00000b70 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b70:	55                   	push   %ebp
 b71:	89 e5                	mov    %esp,%ebp
 b73:	57                   	push   %edi
 b74:	56                   	push   %esi
 b75:	53                   	push   %ebx
 b76:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b79:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 b7c:	8b 15 a8 11 00 00    	mov    0x11a8,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b82:	8d 78 07             	lea    0x7(%eax),%edi
 b85:	c1 ef 03             	shr    $0x3,%edi
 b88:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 b8b:	85 d2                	test   %edx,%edx
 b8d:	0f 84 a3 00 00 00    	je     c36 <malloc+0xc6>
 b93:	8b 02                	mov    (%edx),%eax
 b95:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 b98:	39 cf                	cmp    %ecx,%edi
 b9a:	76 74                	jbe    c10 <malloc+0xa0>
 b9c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 ba2:	be 00 10 00 00       	mov    $0x1000,%esi
 ba7:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 bae:	0f 43 f7             	cmovae %edi,%esi
 bb1:	ba 00 80 00 00       	mov    $0x8000,%edx
 bb6:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 bbc:	0f 46 da             	cmovbe %edx,%ebx
 bbf:	eb 10                	jmp    bd1 <malloc+0x61>
 bc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bc8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 bca:	8b 48 04             	mov    0x4(%eax),%ecx
 bcd:	39 cf                	cmp    %ecx,%edi
 bcf:	76 3f                	jbe    c10 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 bd1:	39 05 a8 11 00 00    	cmp    %eax,0x11a8
 bd7:	89 c2                	mov    %eax,%edx
 bd9:	75 ed                	jne    bc8 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 bdb:	83 ec 0c             	sub    $0xc,%esp
 bde:	53                   	push   %ebx
 bdf:	e8 76 fc ff ff       	call   85a <sbrk>
  if(p == (char*)-1)
 be4:	83 c4 10             	add    $0x10,%esp
 be7:	83 f8 ff             	cmp    $0xffffffff,%eax
 bea:	74 1c                	je     c08 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 bec:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 bef:	83 ec 0c             	sub    $0xc,%esp
 bf2:	83 c0 08             	add    $0x8,%eax
 bf5:	50                   	push   %eax
 bf6:	e8 e5 fe ff ff       	call   ae0 <free>
  return freep;
 bfb:	8b 15 a8 11 00 00    	mov    0x11a8,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 c01:	83 c4 10             	add    $0x10,%esp
 c04:	85 d2                	test   %edx,%edx
 c06:	75 c0                	jne    bc8 <malloc+0x58>
        return 0;
 c08:	31 c0                	xor    %eax,%eax
 c0a:	eb 1c                	jmp    c28 <malloc+0xb8>
 c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 c10:	39 cf                	cmp    %ecx,%edi
 c12:	74 1c                	je     c30 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 c14:	29 f9                	sub    %edi,%ecx
 c16:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 c19:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 c1c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 c1f:	89 15 a8 11 00 00    	mov    %edx,0x11a8
      return (void*)(p + 1);
 c25:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 c28:	8d 65 f4             	lea    -0xc(%ebp),%esp
 c2b:	5b                   	pop    %ebx
 c2c:	5e                   	pop    %esi
 c2d:	5f                   	pop    %edi
 c2e:	5d                   	pop    %ebp
 c2f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 c30:	8b 08                	mov    (%eax),%ecx
 c32:	89 0a                	mov    %ecx,(%edx)
 c34:	eb e9                	jmp    c1f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 c36:	c7 05 a8 11 00 00 ac 	movl   $0x11ac,0x11a8
 c3d:	11 00 00 
 c40:	c7 05 ac 11 00 00 ac 	movl   $0x11ac,0x11ac
 c47:	11 00 00 
    base.s.size = 0;
 c4a:	b8 ac 11 00 00       	mov    $0x11ac,%eax
 c4f:	c7 05 b0 11 00 00 00 	movl   $0x0,0x11b0
 c56:	00 00 00 
 c59:	e9 3e ff ff ff       	jmp    b9c <malloc+0x2c>
