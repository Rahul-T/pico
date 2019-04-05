
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
  18:	68 00 12 00 00       	push   $0x1200
  1d:	e8 d0 08 00 00       	call   8f2 <captsc>
	drawHeader();
  22:	e8 29 02 00 00       	call   250 <drawHeader>
	updatesc(50, 0, "                         v0.1 ", UI_COLOR);
}

void
drawFooter() {
	updatesc(0, 24, " ^Q - Quit                                                                      ", UI_COLOR);
  27:	68 c0 00 00 00       	push   $0xc0
  2c:	68 20 0d 00 00       	push   $0xd20
  31:	6a 18                	push   $0x18
  33:	6a 00                	push   $0x0
  35:	e8 c8 08 00 00       	call   902 <updatesc>
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
  45:	68 a7 0d 00 00       	push   $0xda7
  4a:	6a 01                	push   $0x1
  4c:	e8 6f 09 00 00       	call   9c0 <printf>
  51:	83 c4 10             	add    $0x10,%esp
  54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	}
	while(1) {
		while ((c = getkey()) <= 0) {
  58:	e8 ad 08 00 00       	call   90a <getkey>
  5d:	85 c0                	test   %eax,%eax
  5f:	a3 00 12 00 00       	mov    %eax,0x1200
  64:	7e f2                	jle    58 <main+0x58>
		}
		handleInput(c);
  66:	83 ec 0c             	sub    $0xc,%esp
  69:	50                   	push   %eax
  6a:	e8 71 04 00 00       	call   4e0 <handleInput>
		c = 0;
  6f:	c7 05 00 12 00 00 00 	movl   $0x0,0x1200
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
  86:	e8 07 08 00 00       	call   892 <open>
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
  9c:	ff 35 28 12 00 00    	pushl  0x1228
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
  b2:	68 97 0d 00 00       	push   $0xd97
  b7:	6a 01                	push   $0x1
  b9:	e8 02 09 00 00       	call   9c0 <printf>
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
  e0:	e8 0b 0b 00 00       	call   bf0 <malloc>
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
  ea:	a3 28 12 00 00       	mov    %eax,0x1228
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
 109:	e8 5c 07 00 00       	call   86a <read>
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
 142:	e8 a9 0a 00 00       	call   bf0 <malloc>
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
 170:	a1 28 12 00 00       	mov    0x1228,%eax
 175:	a3 20 12 00 00       	mov    %eax,0x1220
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
 1b0:	c6 84 03 40 12 00 00 	movb   $0x20,0x1240(%ebx,%eax,1)
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
 1c9:	88 94 03 40 12 00 00 	mov    %dl,0x1240(%ebx,%eax,1)
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
 1f8:	c6 84 03 40 12 00 00 	movb   $0x20,0x1240(%ebx,%eax,1)
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
 211:	88 94 03 40 12 00 00 	mov    %dl,0x1240(%ebx,%eax,1)
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
 222:	68 40 12 00 00       	push   $0x1240
 227:	6a 01                	push   $0x1
 229:	6a 00                	push   $0x0
			}
			bufindex++;
	}
	lastOnScreen = cur;

	buf[bufindex] = '\0';
 22b:	c6 83 90 12 00 00 00 	movb   $0x0,0x1290(%ebx)
			} else{
				buf[bufindex] = cur->line[i];
			}
			bufindex++;
	}
	lastOnScreen = cur;
 232:	89 0d 24 12 00 00    	mov    %ecx,0x1224

	buf[bufindex] = '\0';
	//printf(1, "%s\n", buf);
	updatesc(0, 1, buf, TEXT_COLOR);
 238:	e8 c5 06 00 00       	call   902 <updatesc>
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
 25b:	68 e0 0c 00 00       	push   $0xce0
 260:	6a 00                	push   $0x0
 262:	6a 00                	push   $0x0
 264:	e8 99 06 00 00       	call   902 <updatesc>
	updatesc(30, 0, "        PICO        ", UI_COLOR);
 269:	68 c0 00 00 00       	push   $0xc0
 26e:	68 74 0d 00 00       	push   $0xd74
 273:	6a 00                	push   $0x0
 275:	6a 1e                	push   $0x1e
 277:	e8 86 06 00 00       	call   902 <updatesc>
	updatesc(50, 0, "                         v0.1 ", UI_COLOR);
 27c:	83 c4 20             	add    $0x20,%esp
 27f:	68 c0 00 00 00       	push   $0xc0
 284:	68 00 0d 00 00       	push   $0xd00
 289:	6a 00                	push   $0x0
 28b:	6a 32                	push   $0x32
 28d:	e8 70 06 00 00       	call   902 <updatesc>
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
 2ab:	68 20 0d 00 00       	push   $0xd20
 2b0:	6a 18                	push   $0x18
 2b2:	6a 00                	push   $0x0
 2b4:	e8 49 06 00 00       	call   902 <updatesc>
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
 2c1:	8b 0d 20 12 00 00    	mov    0x1220,%ecx
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
 2ca:	8b 35 24 12 00 00    	mov    0x1224,%esi
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
 2e8:	0f b6 94 03 40 12 00 	movzbl 0x1240(%ebx,%eax,1),%edx
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
 31b:	8b 35 24 12 00 00    	mov    0x1224,%esi
}

void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
 321:	8b 3d 20 12 00 00    	mov    0x1220,%edi
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
 338:	0f b6 94 03 40 12 00 	movzbl 0x1240(%ebx,%eax,1),%edx
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
 362:	a1 20 12 00 00       	mov    0x1220,%eax
 367:	8b 40 58             	mov    0x58(%eax),%eax
 36a:	a3 20 12 00 00       	mov    %eax,0x1220
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
 38b:	8b 35 24 12 00 00    	mov    0x1224,%esi
}

void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
 391:	8b 3d 20 12 00 00    	mov    0x1220,%edi
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
 3a8:	0f b6 94 03 40 12 00 	movzbl 0x1240(%ebx,%eax,1),%edx
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
 3d2:	a1 20 12 00 00       	mov    0x1220,%eax
 3d7:	8b 40 54             	mov    0x54(%eax),%eax
 3da:	a3 20 12 00 00       	mov    %eax,0x1220
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
 40e:	a1 04 12 00 00       	mov    0x1204,%eax
 413:	83 f8 4f             	cmp    $0x4f,%eax
 416:	0f 8f b4 00 00 00    	jg     4d0 <arrowkeys+0xe0>
			currChar -= WIDTH;
		}
		else{
			if(firstOnScreen->prev != 0)
 41c:	a1 20 12 00 00       	mov    0x1220,%eax
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
 430:	a1 04 12 00 00       	mov    0x1204,%eax
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
 460:	a1 04 12 00 00       	mov    0x1204,%eax
 465:	3d df 06 00 00       	cmp    $0x6df,%eax
 46a:	7e 54                	jle    4c0 <arrowkeys+0xd0>
			currChar += WIDTH;
		}
		else{
			if(lastOnScreen->next != 0)
 46c:	a1 24 12 00 00       	mov    0x1224,%eax
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
 480:	8b 0d 04 12 00 00    	mov    0x1204,%ecx
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
 4aa:	89 0d 04 12 00 00    	mov    %ecx,0x1204
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
 4b8:	89 0d 04 12 00 00    	mov    %ecx,0x1204
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
 4c3:	a3 04 12 00 00       	mov    %eax,0x1204
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
 4d3:	a3 04 12 00 00       	mov    %eax,0x1204
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
 4eb:	0f 84 11 01 00 00    	je     602 <handleInput+0x122>
		exit();
	}
	printf(1, "currChar: %d\n", currChar);
 4f1:	83 ec 04             	sub    $0x4,%esp
 4f4:	ff 35 04 12 00 00    	pushl  0x1204
 4fa:	68 89 0d 00 00       	push   $0xd89
 4ff:	6a 01                	push   $0x1
 501:	e8 ba 04 00 00       	call   9c0 <printf>
	if(i >= 9 && i<= 12){
 506:	8d 43 f7             	lea    -0x9(%ebx),%eax
 509:	83 c4 10             	add    $0x10,%esp
 50c:	83 f8 03             	cmp    $0x3,%eax
 50f:	0f 86 db 00 00 00    	jbe    5f0 <handleInput+0x110>
		arrowkeys(i);
	}
	//backspace
	else if(i == 127){
 515:	83 fb 7f             	cmp    $0x7f,%ebx
 518:	74 56                	je     570 <handleInput+0x90>
			buf[bufindex] = ' ';
			updatesc(0, 1, buf, TEXT_COLOR);
		}
	}
	//On right edge of window 
	else if((currChar+1) % WIDTH == 0){
 51a:	8b 35 04 12 00 00    	mov    0x1204,%esi
 520:	ba 67 66 66 66       	mov    $0x66666667,%edx
 525:	8d 4e 01             	lea    0x1(%esi),%ecx
 528:	89 c8                	mov    %ecx,%eax
 52a:	f7 ea                	imul   %edx
 52c:	89 c8                	mov    %ecx,%eax
 52e:	c1 f8 1f             	sar    $0x1f,%eax
 531:	c1 fa 05             	sar    $0x5,%edx
 534:	29 c2                	sub    %eax,%edx
 536:	8d 04 92             	lea    (%edx,%edx,4),%eax
 539:	c1 e0 04             	shl    $0x4,%eax
 53c:	39 c1                	cmp    %eax,%ecx
 53e:	74 06                	je     546 <handleInput+0x66>
		buf[currChar] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
		// printf(1, "new input");
	}
	else{
		buf[currChar++] = (char) i & 0xff;
 540:	89 0d 04 12 00 00    	mov    %ecx,0x1204
 546:	88 9e 40 12 00 00    	mov    %bl,0x1240(%esi)
		updatesc(0, 1, buf, TEXT_COLOR);
 54c:	6a 07                	push   $0x7
 54e:	68 40 12 00 00       	push   $0x1240
 553:	6a 01                	push   $0x1
 555:	6a 00                	push   $0x0
 557:	e8 a6 03 00 00       	call   902 <updatesc>
 55c:	83 c4 10             	add    $0x10,%esp
	}
}
 55f:	8d 65 f8             	lea    -0x8(%ebp),%esp
 562:	5b                   	pop    %ebx
 563:	5e                   	pop    %esi
 564:	5d                   	pop    %ebp
 565:	c3                   	ret    
 566:	8d 76 00             	lea    0x0(%esi),%esi
 569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	if(i >= 9 && i<= 12){
		arrowkeys(i);
	}
	//backspace
	else if(i == 127){
		if(currChar > 0){
 570:	8b 1d 04 12 00 00    	mov    0x1204,%ebx
 576:	85 db                	test   %ebx,%ebx
 578:	7e e5                	jle    55f <handleInput+0x7f>
			currChar--;
			int bufindex = currChar;
			while(((bufindex+1) % WIDTH) != 0){
 57a:	89 d8                	mov    %ebx,%eax
 57c:	ba 67 66 66 66       	mov    $0x66666667,%edx
		arrowkeys(i);
	}
	//backspace
	else if(i == 127){
		if(currChar > 0){
			currChar--;
 581:	8d 4b ff             	lea    -0x1(%ebx),%ecx
			int bufindex = currChar;
			while(((bufindex+1) % WIDTH) != 0){
 584:	f7 ea                	imul   %edx
 586:	89 d8                	mov    %ebx,%eax
 588:	c1 f8 1f             	sar    $0x1f,%eax
		arrowkeys(i);
	}
	//backspace
	else if(i == 127){
		if(currChar > 0){
			currChar--;
 58b:	89 0d 04 12 00 00    	mov    %ecx,0x1204
			int bufindex = currChar;
			while(((bufindex+1) % WIDTH) != 0){
 591:	c1 fa 05             	sar    $0x5,%edx
 594:	29 c2                	sub    %eax,%edx
 596:	8d 04 92             	lea    (%edx,%edx,4),%eax
 599:	c1 e0 04             	shl    $0x4,%eax
 59c:	39 c3                	cmp    %eax,%ebx
 59e:	74 5e                	je     5fe <handleInput+0x11e>
 5a0:	be 67 66 66 66       	mov    $0x66666667,%esi
 5a5:	eb 0b                	jmp    5b2 <handleInput+0xd2>
 5a7:	89 f6                	mov    %esi,%esi
 5a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 5b0:	89 cb                	mov    %ecx,%ebx
				buf[bufindex] = buf[bufindex+1];
 5b2:	0f b6 83 40 12 00 00 	movzbl 0x1240(%ebx),%eax
	//backspace
	else if(i == 127){
		if(currChar > 0){
			currChar--;
			int bufindex = currChar;
			while(((bufindex+1) % WIDTH) != 0){
 5b9:	8d 4b 01             	lea    0x1(%ebx),%ecx
				buf[bufindex] = buf[bufindex+1];
 5bc:	88 83 3f 12 00 00    	mov    %al,0x123f(%ebx)
	//backspace
	else if(i == 127){
		if(currChar > 0){
			currChar--;
			int bufindex = currChar;
			while(((bufindex+1) % WIDTH) != 0){
 5c2:	89 c8                	mov    %ecx,%eax
 5c4:	f7 ee                	imul   %esi
 5c6:	89 c8                	mov    %ecx,%eax
 5c8:	c1 f8 1f             	sar    $0x1f,%eax
 5cb:	c1 fa 05             	sar    $0x5,%edx
 5ce:	29 c2                	sub    %eax,%edx
 5d0:	8d 04 92             	lea    (%edx,%edx,4),%eax
 5d3:	c1 e0 04             	shl    $0x4,%eax
 5d6:	39 c1                	cmp    %eax,%ecx
 5d8:	75 d6                	jne    5b0 <handleInput+0xd0>
				buf[bufindex] = buf[bufindex+1];
				bufindex++;
			}
			buf[bufindex] = ' ';
 5da:	c6 83 40 12 00 00 20 	movb   $0x20,0x1240(%ebx)
 5e1:	e9 66 ff ff ff       	jmp    54c <handleInput+0x6c>
 5e6:	8d 76 00             	lea    0x0(%esi),%esi
 5e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	if (i == 17) {
		exit();
	}
	printf(1, "currChar: %d\n", currChar);
	if(i >= 9 && i<= 12){
		arrowkeys(i);
 5f0:	89 5d 08             	mov    %ebx,0x8(%ebp)
	}
	else{
		buf[currChar++] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
	}
}
 5f3:	8d 65 f8             	lea    -0x8(%ebp),%esp
 5f6:	5b                   	pop    %ebx
 5f7:	5e                   	pop    %esi
 5f8:	5d                   	pop    %ebp
	if (i == 17) {
		exit();
	}
	printf(1, "currChar: %d\n", currChar);
	if(i >= 9 && i<= 12){
		arrowkeys(i);
 5f9:	e9 f2 fd ff ff       	jmp    3f0 <arrowkeys>
	}
	//backspace
	else if(i == 127){
		if(currChar > 0){
			currChar--;
			int bufindex = currChar;
 5fe:	89 cb                	mov    %ecx,%ebx
 600:	eb d8                	jmp    5da <handleInput+0xfa>

void
handleInput(int i) {
	//ctrl+q
	if (i == 17) {
		exit();
 602:	e8 4b 02 00 00       	call   852 <exit>
 607:	66 90                	xchg   %ax,%ax
 609:	66 90                	xchg   %ax,%ax
 60b:	66 90                	xchg   %ax,%ax
 60d:	66 90                	xchg   %ax,%ax
 60f:	90                   	nop

00000610 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 610:	55                   	push   %ebp
 611:	89 e5                	mov    %esp,%ebp
 613:	53                   	push   %ebx
 614:	8b 45 08             	mov    0x8(%ebp),%eax
 617:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 61a:	89 c2                	mov    %eax,%edx
 61c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 620:	83 c1 01             	add    $0x1,%ecx
 623:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 627:	83 c2 01             	add    $0x1,%edx
 62a:	84 db                	test   %bl,%bl
 62c:	88 5a ff             	mov    %bl,-0x1(%edx)
 62f:	75 ef                	jne    620 <strcpy+0x10>
    ;
  return os;
}
 631:	5b                   	pop    %ebx
 632:	5d                   	pop    %ebp
 633:	c3                   	ret    
 634:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 63a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000640 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	56                   	push   %esi
 644:	53                   	push   %ebx
 645:	8b 55 08             	mov    0x8(%ebp),%edx
 648:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 64b:	0f b6 02             	movzbl (%edx),%eax
 64e:	0f b6 19             	movzbl (%ecx),%ebx
 651:	84 c0                	test   %al,%al
 653:	75 1e                	jne    673 <strcmp+0x33>
 655:	eb 29                	jmp    680 <strcmp+0x40>
 657:	89 f6                	mov    %esi,%esi
 659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 660:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 663:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 666:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 669:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 66d:	84 c0                	test   %al,%al
 66f:	74 0f                	je     680 <strcmp+0x40>
 671:	89 f1                	mov    %esi,%ecx
 673:	38 d8                	cmp    %bl,%al
 675:	74 e9                	je     660 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 677:	29 d8                	sub    %ebx,%eax
}
 679:	5b                   	pop    %ebx
 67a:	5e                   	pop    %esi
 67b:	5d                   	pop    %ebp
 67c:	c3                   	ret    
 67d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 680:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 682:	29 d8                	sub    %ebx,%eax
}
 684:	5b                   	pop    %ebx
 685:	5e                   	pop    %esi
 686:	5d                   	pop    %ebp
 687:	c3                   	ret    
 688:	90                   	nop
 689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000690 <strlen>:

uint
strlen(char *s)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 696:	80 39 00             	cmpb   $0x0,(%ecx)
 699:	74 12                	je     6ad <strlen+0x1d>
 69b:	31 d2                	xor    %edx,%edx
 69d:	8d 76 00             	lea    0x0(%esi),%esi
 6a0:	83 c2 01             	add    $0x1,%edx
 6a3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 6a7:	89 d0                	mov    %edx,%eax
 6a9:	75 f5                	jne    6a0 <strlen+0x10>
    ;
  return n;
}
 6ab:	5d                   	pop    %ebp
 6ac:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 6ad:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 6af:	5d                   	pop    %ebp
 6b0:	c3                   	ret    
 6b1:	eb 0d                	jmp    6c0 <memset>
 6b3:	90                   	nop
 6b4:	90                   	nop
 6b5:	90                   	nop
 6b6:	90                   	nop
 6b7:	90                   	nop
 6b8:	90                   	nop
 6b9:	90                   	nop
 6ba:	90                   	nop
 6bb:	90                   	nop
 6bc:	90                   	nop
 6bd:	90                   	nop
 6be:	90                   	nop
 6bf:	90                   	nop

000006c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	57                   	push   %edi
 6c4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 6c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 6ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 6cd:	89 d7                	mov    %edx,%edi
 6cf:	fc                   	cld    
 6d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 6d2:	89 d0                	mov    %edx,%eax
 6d4:	5f                   	pop    %edi
 6d5:	5d                   	pop    %ebp
 6d6:	c3                   	ret    
 6d7:	89 f6                	mov    %esi,%esi
 6d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006e0 <strchr>:

char*
strchr(const char *s, char c)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	53                   	push   %ebx
 6e4:	8b 45 08             	mov    0x8(%ebp),%eax
 6e7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 6ea:	0f b6 10             	movzbl (%eax),%edx
 6ed:	84 d2                	test   %dl,%dl
 6ef:	74 1d                	je     70e <strchr+0x2e>
    if(*s == c)
 6f1:	38 d3                	cmp    %dl,%bl
 6f3:	89 d9                	mov    %ebx,%ecx
 6f5:	75 0d                	jne    704 <strchr+0x24>
 6f7:	eb 17                	jmp    710 <strchr+0x30>
 6f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 700:	38 ca                	cmp    %cl,%dl
 702:	74 0c                	je     710 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 704:	83 c0 01             	add    $0x1,%eax
 707:	0f b6 10             	movzbl (%eax),%edx
 70a:	84 d2                	test   %dl,%dl
 70c:	75 f2                	jne    700 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 70e:	31 c0                	xor    %eax,%eax
}
 710:	5b                   	pop    %ebx
 711:	5d                   	pop    %ebp
 712:	c3                   	ret    
 713:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000720 <gets>:

char*
gets(char *buf, int max)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	57                   	push   %edi
 724:	56                   	push   %esi
 725:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 726:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 728:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 72b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 72e:	eb 29                	jmp    759 <gets+0x39>
    cc = read(0, &c, 1);
 730:	83 ec 04             	sub    $0x4,%esp
 733:	6a 01                	push   $0x1
 735:	57                   	push   %edi
 736:	6a 00                	push   $0x0
 738:	e8 2d 01 00 00       	call   86a <read>
    if(cc < 1)
 73d:	83 c4 10             	add    $0x10,%esp
 740:	85 c0                	test   %eax,%eax
 742:	7e 1d                	jle    761 <gets+0x41>
      break;
    buf[i++] = c;
 744:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 748:	8b 55 08             	mov    0x8(%ebp),%edx
 74b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 74d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 74f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 753:	74 1b                	je     770 <gets+0x50>
 755:	3c 0d                	cmp    $0xd,%al
 757:	74 17                	je     770 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 759:	8d 5e 01             	lea    0x1(%esi),%ebx
 75c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 75f:	7c cf                	jl     730 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 761:	8b 45 08             	mov    0x8(%ebp),%eax
 764:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 768:	8d 65 f4             	lea    -0xc(%ebp),%esp
 76b:	5b                   	pop    %ebx
 76c:	5e                   	pop    %esi
 76d:	5f                   	pop    %edi
 76e:	5d                   	pop    %ebp
 76f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 770:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 773:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 775:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 779:	8d 65 f4             	lea    -0xc(%ebp),%esp
 77c:	5b                   	pop    %ebx
 77d:	5e                   	pop    %esi
 77e:	5f                   	pop    %edi
 77f:	5d                   	pop    %ebp
 780:	c3                   	ret    
 781:	eb 0d                	jmp    790 <stat>
 783:	90                   	nop
 784:	90                   	nop
 785:	90                   	nop
 786:	90                   	nop
 787:	90                   	nop
 788:	90                   	nop
 789:	90                   	nop
 78a:	90                   	nop
 78b:	90                   	nop
 78c:	90                   	nop
 78d:	90                   	nop
 78e:	90                   	nop
 78f:	90                   	nop

00000790 <stat>:

int
stat(char *n, struct stat *st)
{
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	56                   	push   %esi
 794:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 795:	83 ec 08             	sub    $0x8,%esp
 798:	6a 00                	push   $0x0
 79a:	ff 75 08             	pushl  0x8(%ebp)
 79d:	e8 f0 00 00 00       	call   892 <open>
  if(fd < 0)
 7a2:	83 c4 10             	add    $0x10,%esp
 7a5:	85 c0                	test   %eax,%eax
 7a7:	78 27                	js     7d0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 7a9:	83 ec 08             	sub    $0x8,%esp
 7ac:	ff 75 0c             	pushl  0xc(%ebp)
 7af:	89 c3                	mov    %eax,%ebx
 7b1:	50                   	push   %eax
 7b2:	e8 f3 00 00 00       	call   8aa <fstat>
 7b7:	89 c6                	mov    %eax,%esi
  close(fd);
 7b9:	89 1c 24             	mov    %ebx,(%esp)
 7bc:	e8 b9 00 00 00       	call   87a <close>
  return r;
 7c1:	83 c4 10             	add    $0x10,%esp
 7c4:	89 f0                	mov    %esi,%eax
}
 7c6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 7c9:	5b                   	pop    %ebx
 7ca:	5e                   	pop    %esi
 7cb:	5d                   	pop    %ebp
 7cc:	c3                   	ret    
 7cd:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 7d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 7d5:	eb ef                	jmp    7c6 <stat+0x36>
 7d7:	89 f6                	mov    %esi,%esi
 7d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000007e0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 7e0:	55                   	push   %ebp
 7e1:	89 e5                	mov    %esp,%ebp
 7e3:	53                   	push   %ebx
 7e4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 7e7:	0f be 11             	movsbl (%ecx),%edx
 7ea:	8d 42 d0             	lea    -0x30(%edx),%eax
 7ed:	3c 09                	cmp    $0x9,%al
 7ef:	b8 00 00 00 00       	mov    $0x0,%eax
 7f4:	77 1f                	ja     815 <atoi+0x35>
 7f6:	8d 76 00             	lea    0x0(%esi),%esi
 7f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 800:	8d 04 80             	lea    (%eax,%eax,4),%eax
 803:	83 c1 01             	add    $0x1,%ecx
 806:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 80a:	0f be 11             	movsbl (%ecx),%edx
 80d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 810:	80 fb 09             	cmp    $0x9,%bl
 813:	76 eb                	jbe    800 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 815:	5b                   	pop    %ebx
 816:	5d                   	pop    %ebp
 817:	c3                   	ret    
 818:	90                   	nop
 819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000820 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 820:	55                   	push   %ebp
 821:	89 e5                	mov    %esp,%ebp
 823:	56                   	push   %esi
 824:	53                   	push   %ebx
 825:	8b 5d 10             	mov    0x10(%ebp),%ebx
 828:	8b 45 08             	mov    0x8(%ebp),%eax
 82b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 82e:	85 db                	test   %ebx,%ebx
 830:	7e 14                	jle    846 <memmove+0x26>
 832:	31 d2                	xor    %edx,%edx
 834:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 838:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 83c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 83f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 842:	39 da                	cmp    %ebx,%edx
 844:	75 f2                	jne    838 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 846:	5b                   	pop    %ebx
 847:	5e                   	pop    %esi
 848:	5d                   	pop    %ebp
 849:	c3                   	ret    

0000084a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 84a:	b8 01 00 00 00       	mov    $0x1,%eax
 84f:	cd 40                	int    $0x40
 851:	c3                   	ret    

00000852 <exit>:
SYSCALL(exit)
 852:	b8 02 00 00 00       	mov    $0x2,%eax
 857:	cd 40                	int    $0x40
 859:	c3                   	ret    

0000085a <wait>:
SYSCALL(wait)
 85a:	b8 03 00 00 00       	mov    $0x3,%eax
 85f:	cd 40                	int    $0x40
 861:	c3                   	ret    

00000862 <pipe>:
SYSCALL(pipe)
 862:	b8 04 00 00 00       	mov    $0x4,%eax
 867:	cd 40                	int    $0x40
 869:	c3                   	ret    

0000086a <read>:
SYSCALL(read)
 86a:	b8 05 00 00 00       	mov    $0x5,%eax
 86f:	cd 40                	int    $0x40
 871:	c3                   	ret    

00000872 <write>:
SYSCALL(write)
 872:	b8 10 00 00 00       	mov    $0x10,%eax
 877:	cd 40                	int    $0x40
 879:	c3                   	ret    

0000087a <close>:
SYSCALL(close)
 87a:	b8 15 00 00 00       	mov    $0x15,%eax
 87f:	cd 40                	int    $0x40
 881:	c3                   	ret    

00000882 <kill>:
SYSCALL(kill)
 882:	b8 06 00 00 00       	mov    $0x6,%eax
 887:	cd 40                	int    $0x40
 889:	c3                   	ret    

0000088a <exec>:
SYSCALL(exec)
 88a:	b8 07 00 00 00       	mov    $0x7,%eax
 88f:	cd 40                	int    $0x40
 891:	c3                   	ret    

00000892 <open>:
SYSCALL(open)
 892:	b8 0f 00 00 00       	mov    $0xf,%eax
 897:	cd 40                	int    $0x40
 899:	c3                   	ret    

0000089a <mknod>:
SYSCALL(mknod)
 89a:	b8 11 00 00 00       	mov    $0x11,%eax
 89f:	cd 40                	int    $0x40
 8a1:	c3                   	ret    

000008a2 <unlink>:
SYSCALL(unlink)
 8a2:	b8 12 00 00 00       	mov    $0x12,%eax
 8a7:	cd 40                	int    $0x40
 8a9:	c3                   	ret    

000008aa <fstat>:
SYSCALL(fstat)
 8aa:	b8 08 00 00 00       	mov    $0x8,%eax
 8af:	cd 40                	int    $0x40
 8b1:	c3                   	ret    

000008b2 <link>:
SYSCALL(link)
 8b2:	b8 13 00 00 00       	mov    $0x13,%eax
 8b7:	cd 40                	int    $0x40
 8b9:	c3                   	ret    

000008ba <mkdir>:
SYSCALL(mkdir)
 8ba:	b8 14 00 00 00       	mov    $0x14,%eax
 8bf:	cd 40                	int    $0x40
 8c1:	c3                   	ret    

000008c2 <chdir>:
SYSCALL(chdir)
 8c2:	b8 09 00 00 00       	mov    $0x9,%eax
 8c7:	cd 40                	int    $0x40
 8c9:	c3                   	ret    

000008ca <dup>:
SYSCALL(dup)
 8ca:	b8 0a 00 00 00       	mov    $0xa,%eax
 8cf:	cd 40                	int    $0x40
 8d1:	c3                   	ret    

000008d2 <getpid>:
SYSCALL(getpid)
 8d2:	b8 0b 00 00 00       	mov    $0xb,%eax
 8d7:	cd 40                	int    $0x40
 8d9:	c3                   	ret    

000008da <sbrk>:
SYSCALL(sbrk)
 8da:	b8 0c 00 00 00       	mov    $0xc,%eax
 8df:	cd 40                	int    $0x40
 8e1:	c3                   	ret    

000008e2 <sleep>:
SYSCALL(sleep)
 8e2:	b8 0d 00 00 00       	mov    $0xd,%eax
 8e7:	cd 40                	int    $0x40
 8e9:	c3                   	ret    

000008ea <uptime>:
SYSCALL(uptime)
 8ea:	b8 0e 00 00 00       	mov    $0xe,%eax
 8ef:	cd 40                	int    $0x40
 8f1:	c3                   	ret    

000008f2 <captsc>:
SYSCALL(captsc)
 8f2:	b8 16 00 00 00       	mov    $0x16,%eax
 8f7:	cd 40                	int    $0x40
 8f9:	c3                   	ret    

000008fa <freesc>:
SYSCALL(freesc)
 8fa:	b8 17 00 00 00       	mov    $0x17,%eax
 8ff:	cd 40                	int    $0x40
 901:	c3                   	ret    

00000902 <updatesc>:
SYSCALL(updatesc)
 902:	b8 18 00 00 00       	mov    $0x18,%eax
 907:	cd 40                	int    $0x40
 909:	c3                   	ret    

0000090a <getkey>:
SYSCALL(getkey)
 90a:	b8 19 00 00 00       	mov    $0x19,%eax
 90f:	cd 40                	int    $0x40
 911:	c3                   	ret    
 912:	66 90                	xchg   %ax,%ax
 914:	66 90                	xchg   %ax,%ax
 916:	66 90                	xchg   %ax,%ax
 918:	66 90                	xchg   %ax,%ax
 91a:	66 90                	xchg   %ax,%ax
 91c:	66 90                	xchg   %ax,%ax
 91e:	66 90                	xchg   %ax,%ax

00000920 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 920:	55                   	push   %ebp
 921:	89 e5                	mov    %esp,%ebp
 923:	57                   	push   %edi
 924:	56                   	push   %esi
 925:	53                   	push   %ebx
 926:	89 c6                	mov    %eax,%esi
 928:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 92b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 92e:	85 db                	test   %ebx,%ebx
 930:	74 7e                	je     9b0 <printint+0x90>
 932:	89 d0                	mov    %edx,%eax
 934:	c1 e8 1f             	shr    $0x1f,%eax
 937:	84 c0                	test   %al,%al
 939:	74 75                	je     9b0 <printint+0x90>
    neg = 1;
    x = -xx;
 93b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 93d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 944:	f7 d8                	neg    %eax
 946:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 949:	31 ff                	xor    %edi,%edi
 94b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 94e:	89 ce                	mov    %ecx,%esi
 950:	eb 08                	jmp    95a <printint+0x3a>
 952:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 958:	89 cf                	mov    %ecx,%edi
 95a:	31 d2                	xor    %edx,%edx
 95c:	8d 4f 01             	lea    0x1(%edi),%ecx
 95f:	f7 f6                	div    %esi
 961:	0f b6 92 c0 0d 00 00 	movzbl 0xdc0(%edx),%edx
  }while((x /= base) != 0);
 968:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 96a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 96d:	75 e9                	jne    958 <printint+0x38>
  if(neg)
 96f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 972:	8b 75 c0             	mov    -0x40(%ebp),%esi
 975:	85 c0                	test   %eax,%eax
 977:	74 08                	je     981 <printint+0x61>
    buf[i++] = '-';
 979:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 97e:	8d 4f 02             	lea    0x2(%edi),%ecx
 981:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 985:	8d 76 00             	lea    0x0(%esi),%esi
 988:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 98b:	83 ec 04             	sub    $0x4,%esp
 98e:	83 ef 01             	sub    $0x1,%edi
 991:	6a 01                	push   $0x1
 993:	53                   	push   %ebx
 994:	56                   	push   %esi
 995:	88 45 d7             	mov    %al,-0x29(%ebp)
 998:	e8 d5 fe ff ff       	call   872 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 99d:	83 c4 10             	add    $0x10,%esp
 9a0:	39 df                	cmp    %ebx,%edi
 9a2:	75 e4                	jne    988 <printint+0x68>
    putc(fd, buf[i]);
}
 9a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9a7:	5b                   	pop    %ebx
 9a8:	5e                   	pop    %esi
 9a9:	5f                   	pop    %edi
 9aa:	5d                   	pop    %ebp
 9ab:	c3                   	ret    
 9ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 9b0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 9b2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 9b9:	eb 8b                	jmp    946 <printint+0x26>
 9bb:	90                   	nop
 9bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000009c0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 9c0:	55                   	push   %ebp
 9c1:	89 e5                	mov    %esp,%ebp
 9c3:	57                   	push   %edi
 9c4:	56                   	push   %esi
 9c5:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 9c6:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 9c9:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 9cc:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 9cf:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 9d2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 9d5:	0f b6 1e             	movzbl (%esi),%ebx
 9d8:	83 c6 01             	add    $0x1,%esi
 9db:	84 db                	test   %bl,%bl
 9dd:	0f 84 b0 00 00 00    	je     a93 <printf+0xd3>
 9e3:	31 d2                	xor    %edx,%edx
 9e5:	eb 39                	jmp    a20 <printf+0x60>
 9e7:	89 f6                	mov    %esi,%esi
 9e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 9f0:	83 f8 25             	cmp    $0x25,%eax
 9f3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 9f6:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 9fb:	74 18                	je     a15 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 9fd:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 a00:	83 ec 04             	sub    $0x4,%esp
 a03:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 a06:	6a 01                	push   $0x1
 a08:	50                   	push   %eax
 a09:	57                   	push   %edi
 a0a:	e8 63 fe ff ff       	call   872 <write>
 a0f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 a12:	83 c4 10             	add    $0x10,%esp
 a15:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 a18:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 a1c:	84 db                	test   %bl,%bl
 a1e:	74 73                	je     a93 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 a20:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 a22:	0f be cb             	movsbl %bl,%ecx
 a25:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 a28:	74 c6                	je     9f0 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 a2a:	83 fa 25             	cmp    $0x25,%edx
 a2d:	75 e6                	jne    a15 <printf+0x55>
      if(c == 'd'){
 a2f:	83 f8 64             	cmp    $0x64,%eax
 a32:	0f 84 f8 00 00 00    	je     b30 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 a38:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 a3e:	83 f9 70             	cmp    $0x70,%ecx
 a41:	74 5d                	je     aa0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 a43:	83 f8 73             	cmp    $0x73,%eax
 a46:	0f 84 84 00 00 00    	je     ad0 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 a4c:	83 f8 63             	cmp    $0x63,%eax
 a4f:	0f 84 ea 00 00 00    	je     b3f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 a55:	83 f8 25             	cmp    $0x25,%eax
 a58:	0f 84 c2 00 00 00    	je     b20 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 a5e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 a61:	83 ec 04             	sub    $0x4,%esp
 a64:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 a68:	6a 01                	push   $0x1
 a6a:	50                   	push   %eax
 a6b:	57                   	push   %edi
 a6c:	e8 01 fe ff ff       	call   872 <write>
 a71:	83 c4 0c             	add    $0xc,%esp
 a74:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 a77:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 a7a:	6a 01                	push   $0x1
 a7c:	50                   	push   %eax
 a7d:	57                   	push   %edi
 a7e:	83 c6 01             	add    $0x1,%esi
 a81:	e8 ec fd ff ff       	call   872 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 a86:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 a8a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 a8d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 a8f:	84 db                	test   %bl,%bl
 a91:	75 8d                	jne    a20 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 a93:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a96:	5b                   	pop    %ebx
 a97:	5e                   	pop    %esi
 a98:	5f                   	pop    %edi
 a99:	5d                   	pop    %ebp
 a9a:	c3                   	ret    
 a9b:	90                   	nop
 a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 aa0:	83 ec 0c             	sub    $0xc,%esp
 aa3:	b9 10 00 00 00       	mov    $0x10,%ecx
 aa8:	6a 00                	push   $0x0
 aaa:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 aad:	89 f8                	mov    %edi,%eax
 aaf:	8b 13                	mov    (%ebx),%edx
 ab1:	e8 6a fe ff ff       	call   920 <printint>
        ap++;
 ab6:	89 d8                	mov    %ebx,%eax
 ab8:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 abb:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 abd:	83 c0 04             	add    $0x4,%eax
 ac0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 ac3:	e9 4d ff ff ff       	jmp    a15 <printf+0x55>
 ac8:	90                   	nop
 ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 ad0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 ad3:	8b 18                	mov    (%eax),%ebx
        ap++;
 ad5:	83 c0 04             	add    $0x4,%eax
 ad8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 adb:	b8 b8 0d 00 00       	mov    $0xdb8,%eax
 ae0:	85 db                	test   %ebx,%ebx
 ae2:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 ae5:	0f b6 03             	movzbl (%ebx),%eax
 ae8:	84 c0                	test   %al,%al
 aea:	74 23                	je     b0f <printf+0x14f>
 aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 af0:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 af3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 af6:	83 ec 04             	sub    $0x4,%esp
 af9:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 afb:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 afe:	50                   	push   %eax
 aff:	57                   	push   %edi
 b00:	e8 6d fd ff ff       	call   872 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 b05:	0f b6 03             	movzbl (%ebx),%eax
 b08:	83 c4 10             	add    $0x10,%esp
 b0b:	84 c0                	test   %al,%al
 b0d:	75 e1                	jne    af0 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 b0f:	31 d2                	xor    %edx,%edx
 b11:	e9 ff fe ff ff       	jmp    a15 <printf+0x55>
 b16:	8d 76 00             	lea    0x0(%esi),%esi
 b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 b20:	83 ec 04             	sub    $0x4,%esp
 b23:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 b26:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 b29:	6a 01                	push   $0x1
 b2b:	e9 4c ff ff ff       	jmp    a7c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 b30:	83 ec 0c             	sub    $0xc,%esp
 b33:	b9 0a 00 00 00       	mov    $0xa,%ecx
 b38:	6a 01                	push   $0x1
 b3a:	e9 6b ff ff ff       	jmp    aaa <printf+0xea>
 b3f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 b42:	83 ec 04             	sub    $0x4,%esp
 b45:	8b 03                	mov    (%ebx),%eax
 b47:	6a 01                	push   $0x1
 b49:	88 45 e4             	mov    %al,-0x1c(%ebp)
 b4c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 b4f:	50                   	push   %eax
 b50:	57                   	push   %edi
 b51:	e8 1c fd ff ff       	call   872 <write>
 b56:	e9 5b ff ff ff       	jmp    ab6 <printf+0xf6>
 b5b:	66 90                	xchg   %ax,%ax
 b5d:	66 90                	xchg   %ax,%ax
 b5f:	90                   	nop

00000b60 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b60:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b61:	a1 08 12 00 00       	mov    0x1208,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 b66:	89 e5                	mov    %esp,%ebp
 b68:	57                   	push   %edi
 b69:	56                   	push   %esi
 b6a:	53                   	push   %ebx
 b6b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b6e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b70:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b73:	39 c8                	cmp    %ecx,%eax
 b75:	73 19                	jae    b90 <free+0x30>
 b77:	89 f6                	mov    %esi,%esi
 b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 b80:	39 d1                	cmp    %edx,%ecx
 b82:	72 1c                	jb     ba0 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b84:	39 d0                	cmp    %edx,%eax
 b86:	73 18                	jae    ba0 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 b88:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b8a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b8c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b8e:	72 f0                	jb     b80 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b90:	39 d0                	cmp    %edx,%eax
 b92:	72 f4                	jb     b88 <free+0x28>
 b94:	39 d1                	cmp    %edx,%ecx
 b96:	73 f0                	jae    b88 <free+0x28>
 b98:	90                   	nop
 b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 ba0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 ba3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 ba6:	39 d7                	cmp    %edx,%edi
 ba8:	74 19                	je     bc3 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 baa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 bad:	8b 50 04             	mov    0x4(%eax),%edx
 bb0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 bb3:	39 f1                	cmp    %esi,%ecx
 bb5:	74 23                	je     bda <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 bb7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 bb9:	a3 08 12 00 00       	mov    %eax,0x1208
}
 bbe:	5b                   	pop    %ebx
 bbf:	5e                   	pop    %esi
 bc0:	5f                   	pop    %edi
 bc1:	5d                   	pop    %ebp
 bc2:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 bc3:	03 72 04             	add    0x4(%edx),%esi
 bc6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 bc9:	8b 10                	mov    (%eax),%edx
 bcb:	8b 12                	mov    (%edx),%edx
 bcd:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 bd0:	8b 50 04             	mov    0x4(%eax),%edx
 bd3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 bd6:	39 f1                	cmp    %esi,%ecx
 bd8:	75 dd                	jne    bb7 <free+0x57>
    p->s.size += bp->s.size;
 bda:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 bdd:	a3 08 12 00 00       	mov    %eax,0x1208
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 be2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 be5:	8b 53 f8             	mov    -0x8(%ebx),%edx
 be8:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 bea:	5b                   	pop    %ebx
 beb:	5e                   	pop    %esi
 bec:	5f                   	pop    %edi
 bed:	5d                   	pop    %ebp
 bee:	c3                   	ret    
 bef:	90                   	nop

00000bf0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 bf0:	55                   	push   %ebp
 bf1:	89 e5                	mov    %esp,%ebp
 bf3:	57                   	push   %edi
 bf4:	56                   	push   %esi
 bf5:	53                   	push   %ebx
 bf6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bf9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 bfc:	8b 15 08 12 00 00    	mov    0x1208,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c02:	8d 78 07             	lea    0x7(%eax),%edi
 c05:	c1 ef 03             	shr    $0x3,%edi
 c08:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 c0b:	85 d2                	test   %edx,%edx
 c0d:	0f 84 a3 00 00 00    	je     cb6 <malloc+0xc6>
 c13:	8b 02                	mov    (%edx),%eax
 c15:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 c18:	39 cf                	cmp    %ecx,%edi
 c1a:	76 74                	jbe    c90 <malloc+0xa0>
 c1c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 c22:	be 00 10 00 00       	mov    $0x1000,%esi
 c27:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 c2e:	0f 43 f7             	cmovae %edi,%esi
 c31:	ba 00 80 00 00       	mov    $0x8000,%edx
 c36:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 c3c:	0f 46 da             	cmovbe %edx,%ebx
 c3f:	eb 10                	jmp    c51 <malloc+0x61>
 c41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c48:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 c4a:	8b 48 04             	mov    0x4(%eax),%ecx
 c4d:	39 cf                	cmp    %ecx,%edi
 c4f:	76 3f                	jbe    c90 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c51:	39 05 08 12 00 00    	cmp    %eax,0x1208
 c57:	89 c2                	mov    %eax,%edx
 c59:	75 ed                	jne    c48 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 c5b:	83 ec 0c             	sub    $0xc,%esp
 c5e:	53                   	push   %ebx
 c5f:	e8 76 fc ff ff       	call   8da <sbrk>
  if(p == (char*)-1)
 c64:	83 c4 10             	add    $0x10,%esp
 c67:	83 f8 ff             	cmp    $0xffffffff,%eax
 c6a:	74 1c                	je     c88 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 c6c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 c6f:	83 ec 0c             	sub    $0xc,%esp
 c72:	83 c0 08             	add    $0x8,%eax
 c75:	50                   	push   %eax
 c76:	e8 e5 fe ff ff       	call   b60 <free>
  return freep;
 c7b:	8b 15 08 12 00 00    	mov    0x1208,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 c81:	83 c4 10             	add    $0x10,%esp
 c84:	85 d2                	test   %edx,%edx
 c86:	75 c0                	jne    c48 <malloc+0x58>
        return 0;
 c88:	31 c0                	xor    %eax,%eax
 c8a:	eb 1c                	jmp    ca8 <malloc+0xb8>
 c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 c90:	39 cf                	cmp    %ecx,%edi
 c92:	74 1c                	je     cb0 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 c94:	29 f9                	sub    %edi,%ecx
 c96:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 c99:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 c9c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 c9f:	89 15 08 12 00 00    	mov    %edx,0x1208
      return (void*)(p + 1);
 ca5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 ca8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 cab:	5b                   	pop    %ebx
 cac:	5e                   	pop    %esi
 cad:	5f                   	pop    %edi
 cae:	5d                   	pop    %ebp
 caf:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 cb0:	8b 08                	mov    (%eax),%ecx
 cb2:	89 0a                	mov    %ecx,(%edx)
 cb4:	eb e9                	jmp    c9f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 cb6:	c7 05 08 12 00 00 0c 	movl   $0x120c,0x1208
 cbd:	12 00 00 
 cc0:	c7 05 0c 12 00 00 0c 	movl   $0x120c,0x120c
 cc7:	12 00 00 
    base.s.size = 0;
 cca:	b8 0c 12 00 00       	mov    $0x120c,%eax
 ccf:	c7 05 10 12 00 00 00 	movl   $0x0,0x1210
 cd6:	00 00 00 
 cd9:	e9 3e ff ff ff       	jmp    c1c <malloc+0x2c>
