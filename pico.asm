
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
  18:	68 80 15 00 00       	push   $0x1580
  1d:	e8 d0 0b 00 00       	call   bf2 <captsc>
	drawHeader();
  22:	e8 29 02 00 00       	call   250 <drawHeader>
	updatesc(50, 0, "                         v0.1 ", UI_COLOR);
}

void
drawFooter() {
	updatesc(0, 24, " ^Q - Quit                                                                      ", UI_COLOR);
  27:	68 c0 00 00 00       	push   $0xc0
  2c:	68 20 10 00 00       	push   $0x1020
  31:	6a 18                	push   $0x18
  33:	6a 00                	push   $0x0
  35:	e8 c8 0b 00 00       	call   c02 <updatesc>
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
  45:	68 a7 10 00 00       	push   $0x10a7
  4a:	6a 01                	push   $0x1
  4c:	e8 6f 0c 00 00       	call   cc0 <printf>
  51:	83 c4 10             	add    $0x10,%esp
  54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	}
	while(1) {
		while ((c = getkey()) <= 0) {
  58:	e8 ad 0b 00 00       	call   c0a <getkey>
  5d:	85 c0                	test   %eax,%eax
  5f:	a3 80 15 00 00       	mov    %eax,0x1580
  64:	7e f2                	jle    58 <main+0x58>
		}
		handleInput(c);
  66:	83 ec 0c             	sub    $0xc,%esp
  69:	50                   	push   %eax
  6a:	e8 51 07 00 00       	call   7c0 <handleInput>
		c = 0;
  6f:	c7 05 80 15 00 00 00 	movl   $0x0,0x1580
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
  86:	e8 07 0b 00 00       	call   b92 <open>
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
  9c:	ff 35 ac 15 00 00    	pushl  0x15ac
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
  b2:	68 97 10 00 00       	push   $0x1097
  b7:	6a 01                	push   $0x1
  b9:	e8 02 0c 00 00       	call   cc0 <printf>
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
  e0:	e8 0b 0e 00 00       	call   ef0 <malloc>
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
  ea:	a3 ac 15 00 00       	mov    %eax,0x15ac
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
 109:	e8 5c 0a 00 00       	call   b6a <read>
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
 142:	e8 a9 0d 00 00       	call   ef0 <malloc>
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
 175:	a1 ac 15 00 00       	mov    0x15ac,%eax
	tail = cur;
 17a:	89 1d a8 15 00 00    	mov    %ebx,0x15a8
			linenumber++;
		}
	}
	cur->filelinenum = linenumber;

	firstOnScreen = head;
 180:	a3 a0 15 00 00       	mov    %eax,0x15a0
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
 1b0:	c6 84 03 c0 15 00 00 	movb   $0x20,0x15c0(%ebx,%eax,1)
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
 1c9:	88 94 03 c0 15 00 00 	mov    %dl,0x15c0(%ebx,%eax,1)
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
 1f8:	c6 84 03 c0 15 00 00 	movb   $0x20,0x15c0(%ebx,%eax,1)
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
 211:	88 94 03 c0 15 00 00 	mov    %dl,0x15c0(%ebx,%eax,1)
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
			bufindex++;
	}
	lastOnScreen = cur;

	while(bufindex < TOTAL_CHARS){
 220:	81 fb e0 06 00 00    	cmp    $0x6e0,%ebx
			} else{
				buf[bufindex] = cur->line[i];
			}
			bufindex++;
	}
	lastOnScreen = cur;
 226:	89 0d a4 15 00 00    	mov    %ecx,0x15a4

	while(bufindex < TOTAL_CHARS){
 22c:	74 02                	je     230 <printfile+0xa0>
 22e:	eb fe                	jmp    22e <printfile+0x9e>
		buf[bufindex] = ' ';
	}

	buf[bufindex] = '\0';
	//printf(1, "%s\n", buf);
	updatesc(0, 1, buf, TEXT_COLOR);
 230:	6a 07                	push   $0x7
 232:	68 c0 15 00 00       	push   $0x15c0
 237:	6a 01                	push   $0x1
 239:	6a 00                	push   $0x0

	while(bufindex < TOTAL_CHARS){
		buf[bufindex] = ' ';
	}

	buf[bufindex] = '\0';
 23b:	c6 05 f0 1c 00 00 00 	movb   $0x0,0x1cf0
	//printf(1, "%s\n", buf);
	updatesc(0, 1, buf, TEXT_COLOR);
 242:	e8 bb 09 00 00       	call   c02 <updatesc>
}
 247:	83 c4 10             	add    $0x10,%esp
 24a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 24d:	c9                   	leave  
 24e:	c3                   	ret    
 24f:	90                   	nop

00000250 <drawHeader>:

void
drawHeader() {
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	83 ec 08             	sub    $0x8,%esp
	updatesc(0, 0, "                              ", UI_COLOR);
 256:	68 c0 00 00 00       	push   $0xc0
 25b:	68 e0 0f 00 00       	push   $0xfe0
 260:	6a 00                	push   $0x0
 262:	6a 00                	push   $0x0
 264:	e8 99 09 00 00       	call   c02 <updatesc>
	updatesc(30, 0, "        PICO        ", UI_COLOR);
 269:	68 c0 00 00 00       	push   $0xc0
 26e:	68 74 10 00 00       	push   $0x1074
 273:	6a 00                	push   $0x0
 275:	6a 1e                	push   $0x1e
 277:	e8 86 09 00 00       	call   c02 <updatesc>
	updatesc(50, 0, "                         v0.1 ", UI_COLOR);
 27c:	83 c4 20             	add    $0x20,%esp
 27f:	68 c0 00 00 00       	push   $0xc0
 284:	68 00 10 00 00       	push   $0x1000
 289:	6a 00                	push   $0x0
 28b:	6a 32                	push   $0x32
 28d:	e8 70 09 00 00       	call   c02 <updatesc>
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
 2ab:	68 20 10 00 00       	push   $0x1020
 2b0:	6a 18                	push   $0x18
 2b2:	6a 00                	push   $0x0
 2b4:	e8 49 09 00 00       	call   c02 <updatesc>
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
 2c1:	8b 0d a0 15 00 00    	mov    0x15a0,%ecx
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
 2ca:	8b 35 a4 15 00 00    	mov    0x15a4,%esi
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
 2e8:	0f b6 94 03 c0 15 00 	movzbl 0x15c0(%ebx,%eax,1),%edx
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
 31b:	8b 35 a4 15 00 00    	mov    0x15a4,%esi
}

void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
 321:	8b 3d a0 15 00 00    	mov    0x15a0,%edi
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
 338:	0f b6 94 03 c0 15 00 	movzbl 0x15c0(%ebx,%eax,1),%edx
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
 362:	a1 a0 15 00 00       	mov    0x15a0,%eax
 367:	8b 40 58             	mov    0x58(%eax),%eax
 36a:	a3 a0 15 00 00       	mov    %eax,0x15a0
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
 38b:	8b 35 a4 15 00 00    	mov    0x15a4,%esi
}

void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
 391:	8b 3d a0 15 00 00    	mov    0x15a0,%edi
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
 3a8:	0f b6 94 03 c0 15 00 	movzbl 0x15c0(%ebx,%eax,1),%edx
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
 3d2:	a1 a0 15 00 00       	mov    0x15a0,%eax
 3d7:	8b 40 54             	mov    0x54(%eax),%eax
 3da:	a3 a0 15 00 00       	mov    %eax,0x15a0
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
 40e:	a1 84 15 00 00       	mov    0x1584,%eax
 413:	83 f8 4f             	cmp    $0x4f,%eax
 416:	0f 8f b4 00 00 00    	jg     4d0 <arrowkeys+0xe0>
			currChar -= WIDTH;
		}
		else{
			if(firstOnScreen->prev != 0)
 41c:	a1 a0 15 00 00       	mov    0x15a0,%eax
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
 430:	a1 84 15 00 00       	mov    0x1584,%eax
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
 460:	a1 84 15 00 00       	mov    0x1584,%eax
 465:	3d df 06 00 00       	cmp    $0x6df,%eax
 46a:	7e 54                	jle    4c0 <arrowkeys+0xd0>
			currChar += WIDTH;
		}
		else{
			if(lastOnScreen->next != 0)
 46c:	a1 a4 15 00 00       	mov    0x15a4,%eax
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
 480:	8b 0d 84 15 00 00    	mov    0x1584,%ecx
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
 4aa:	89 0d 84 15 00 00    	mov    %ecx,0x1584
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
 4b8:	89 0d 84 15 00 00    	mov    %ecx,0x1584
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
 4c3:	a3 84 15 00 00       	mov    %eax,0x1584
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
 4d3:	a3 84 15 00 00       	mov    %eax,0x1584
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
 4e0:	55                   	push   %ebp
	int line = currChar/WIDTH;
 4e1:	ba 67 66 66 66       	mov    $0x66666667,%edx
	}
}


void
cutline(void){
 4e6:	89 e5                	mov    %esp,%ebp
 4e8:	53                   	push   %ebx
 4e9:	83 ec 04             	sub    $0x4,%esp
	int line = currChar/WIDTH;
 4ec:	8b 0d 84 15 00 00    	mov    0x1584,%ecx
 4f2:	89 c8                	mov    %ecx,%eax
 4f4:	c1 f9 1f             	sar    $0x1f,%ecx
 4f7:	f7 ea                	imul   %edx
 4f9:	c1 fa 05             	sar    $0x5,%edx
 4fc:	29 ca                	sub    %ecx,%edx
	struct fileline* cur = firstOnScreen;
 4fe:	8b 0d a0 15 00 00    	mov    0x15a0,%ecx
	for(int i=0; i<line; i++){
 504:	85 d2                	test   %edx,%edx


void
cutline(void){
	int line = currChar/WIDTH;
	struct fileline* cur = firstOnScreen;
 506:	89 cb                	mov    %ecx,%ebx
	for(int i=0; i<line; i++){
 508:	7e 10                	jle    51a <cutline+0x3a>
 50a:	31 c0                	xor    %eax,%eax
 50c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 510:	83 c0 01             	add    $0x1,%eax
		cur = cur->next;
 513:	8b 5b 58             	mov    0x58(%ebx),%ebx

void
cutline(void){
	int line = currChar/WIDTH;
	struct fileline* cur = firstOnScreen;
	for(int i=0; i<line; i++){
 516:	39 c2                	cmp    %eax,%edx
 518:	75 f6                	jne    510 <cutline+0x30>
		cur = cur->next;
	}
	if(lastOnScreen->next == 0){
 51a:	a1 a4 15 00 00       	mov    0x15a4,%eax
 51f:	8b 40 58             	mov    0x58(%eax),%eax
 522:	85 c0                	test   %eax,%eax
 524:	74 6a                	je     590 <cutline+0xb0>
			printfile(firstOnScreen);
			return;
		}
	}
	struct fileline* temp = cur;
	while(temp != 0){
 526:	85 db                	test   %ebx,%ebx
 528:	89 d8                	mov    %ebx,%eax
 52a:	74 0e                	je     53a <cutline+0x5a>
 52c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		temp->filelinenum = temp->filelinenum-1;
 530:	83 28 01             	subl   $0x1,(%eax)
		temp = temp->next;
 533:	8b 40 58             	mov    0x58(%eax),%eax
			printfile(firstOnScreen);
			return;
		}
	}
	struct fileline* temp = cur;
	while(temp != 0){
 536:	85 c0                	test   %eax,%eax
 538:	75 f6                	jne    530 <cutline+0x50>
		temp->filelinenum = temp->filelinenum-1;
		temp = temp->next;
	}
	if(firstOnScreen == cur){
 53a:	3b 1d a0 15 00 00    	cmp    0x15a0,%ebx
 540:	74 5e                	je     5a0 <cutline+0xc0>
		firstOnScreen = cur->next;
	}
	if(lastOnScreen == cur){
 542:	3b 1d a4 15 00 00    	cmp    0x15a4,%ebx
 548:	8b 43 58             	mov    0x58(%ebx),%eax
 54b:	74 63                	je     5b0 <cutline+0xd0>
		} 
		else if(cur->prev != 0){
			lastOnScreen = cur->prev;
		}
	}
	if(head == cur){
 54d:	3b 1d ac 15 00 00    	cmp    0x15ac,%ebx
 553:	8b 53 54             	mov    0x54(%ebx),%edx
 556:	74 70                	je     5c8 <cutline+0xe8>
		head = cur->next;
	}
	if(cur->prev != 0){
 558:	85 d2                	test   %edx,%edx
 55a:	74 06                	je     562 <cutline+0x82>
		cur->prev->next = cur->next;
 55c:	89 42 58             	mov    %eax,0x58(%edx)
 55f:	8b 43 58             	mov    0x58(%ebx),%eax
	}
	if(cur->next != 0){
 562:	85 c0                	test   %eax,%eax
 564:	74 06                	je     56c <cutline+0x8c>
		cur->next->prev = cur->prev;
 566:	8b 53 54             	mov    0x54(%ebx),%edx
 569:	89 50 54             	mov    %edx,0x54(%eax)
	}
	free(cur);
 56c:	83 ec 0c             	sub    $0xc,%esp
 56f:	53                   	push   %ebx
 570:	e8 eb 08 00 00       	call   e60 <free>
	printfile(firstOnScreen);
 575:	58                   	pop    %eax
 576:	ff 35 a0 15 00 00    	pushl  0x15a0
 57c:	e8 0f fc ff ff       	call   190 <printfile>
 581:	83 c4 10             	add    $0x10,%esp
}
 584:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 587:	c9                   	leave  
 588:	c3                   	ret    
 589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	struct fileline* cur = firstOnScreen;
	for(int i=0; i<line; i++){
		cur = cur->next;
	}
	if(lastOnScreen->next == 0){
		if(firstOnScreen->prev != 0){
 590:	8b 51 54             	mov    0x54(%ecx),%edx
 593:	85 d2                	test   %edx,%edx
 595:	74 38                	je     5cf <cutline+0xef>
			scrollup();
 597:	e8 e4 fd ff ff       	call   380 <scrollup>
 59c:	eb 88                	jmp    526 <cutline+0x46>
 59e:	66 90                	xchg   %ax,%ax
		temp = temp->next;
	}
	if(firstOnScreen == cur){
		firstOnScreen = cur->next;
	}
	if(lastOnScreen == cur){
 5a0:	3b 1d a4 15 00 00    	cmp    0x15a4,%ebx
	while(temp != 0){
		temp->filelinenum = temp->filelinenum-1;
		temp = temp->next;
	}
	if(firstOnScreen == cur){
		firstOnScreen = cur->next;
 5a6:	8b 43 58             	mov    0x58(%ebx),%eax
 5a9:	a3 a0 15 00 00       	mov    %eax,0x15a0
	}
	if(lastOnScreen == cur){
 5ae:	75 9d                	jne    54d <cutline+0x6d>
		if(cur->next != 0){
 5b0:	85 c0                	test   %eax,%eax
 5b2:	74 3c                	je     5f0 <cutline+0x110>
		} 
		else if(cur->prev != 0){
			lastOnScreen = cur->prev;
		}
	}
	if(head == cur){
 5b4:	3b 1d ac 15 00 00    	cmp    0x15ac,%ebx
	if(firstOnScreen == cur){
		firstOnScreen = cur->next;
	}
	if(lastOnScreen == cur){
		if(cur->next != 0){
			lastOnScreen = cur->next;
 5ba:	a3 a4 15 00 00       	mov    %eax,0x15a4
 5bf:	8b 53 54             	mov    0x54(%ebx),%edx
		} 
		else if(cur->prev != 0){
			lastOnScreen = cur->prev;
		}
	}
	if(head == cur){
 5c2:	75 94                	jne    558 <cutline+0x78>
 5c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		head = cur->next;
 5c8:	a3 ac 15 00 00       	mov    %eax,0x15ac
 5cd:	eb 89                	jmp    558 <cutline+0x78>
 5cf:	8d 43 04             	lea    0x4(%ebx),%eax
 5d2:	83 c3 54             	add    $0x54,%ebx
 5d5:	8d 76 00             	lea    0x0(%esi),%esi
	if(lastOnScreen->next == 0){
		if(firstOnScreen->prev != 0){
			scrollup();
		} else {
			for(int i=0; i<WIDTH; i++){
				cur->line[i] = ' ';
 5d8:	c6 00 20             	movb   $0x20,(%eax)
 5db:	83 c0 01             	add    $0x1,%eax
	}
	if(lastOnScreen->next == 0){
		if(firstOnScreen->prev != 0){
			scrollup();
		} else {
			for(int i=0; i<WIDTH; i++){
 5de:	39 d8                	cmp    %ebx,%eax
 5e0:	75 f6                	jne    5d8 <cutline+0xf8>
				cur->line[i] = ' ';
			}
			printfile(firstOnScreen);
 5e2:	83 ec 0c             	sub    $0xc,%esp
 5e5:	51                   	push   %ecx
 5e6:	e8 a5 fb ff ff       	call   190 <printfile>
			return;
 5eb:	83 c4 10             	add    $0x10,%esp
 5ee:	eb 94                	jmp    584 <cutline+0xa4>
	}
	if(lastOnScreen == cur){
		if(cur->next != 0){
			lastOnScreen = cur->next;
		} 
		else if(cur->prev != 0){
 5f0:	8b 53 54             	mov    0x54(%ebx),%edx
 5f3:	85 d2                	test   %edx,%edx
 5f5:	74 14                	je     60b <cutline+0x12b>
			lastOnScreen = cur->prev;
		}
	}
	if(head == cur){
 5f7:	3b 1d ac 15 00 00    	cmp    0x15ac,%ebx
	if(lastOnScreen == cur){
		if(cur->next != 0){
			lastOnScreen = cur->next;
		} 
		else if(cur->prev != 0){
			lastOnScreen = cur->prev;
 5fd:	89 15 a4 15 00 00    	mov    %edx,0x15a4
		}
	}
	if(head == cur){
 603:	0f 85 53 ff ff ff    	jne    55c <cutline+0x7c>
 609:	eb bd                	jmp    5c8 <cutline+0xe8>
 60b:	3b 1d ac 15 00 00    	cmp    0x15ac,%ebx
 611:	0f 85 55 ff ff ff    	jne    56c <cutline+0x8c>
 617:	eb af                	jmp    5c8 <cutline+0xe8>
 619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000620 <newline>:
	printfile(firstOnScreen);
}

void
newline(void)
{
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	57                   	push   %edi
 624:	56                   	push   %esi
 625:	53                   	push   %ebx
 626:	31 f6                	xor    %esi,%esi
 628:	83 ec 0c             	sub    $0xc,%esp
void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
 62b:	8b 3d a4 15 00 00    	mov    0x15a4,%edi
}

void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
 631:	8b 1d a0 15 00 00    	mov    0x15a0,%ebx
	int bufindex = 0;
	while(cur != lastOnScreen->next){
 637:	3b 5f 58             	cmp    0x58(%edi),%ebx
 63a:	89 d9                	mov    %ebx,%ecx
 63c:	74 29                	je     667 <newline+0x47>
 63e:	66 90                	xchg   %ax,%ax
 640:	31 c0                	xor    %eax,%eax
 642:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		for(int i=0; i<WIDTH; i++){
			cur->line[i] = buf[bufindex];
 648:	0f b6 94 06 c0 15 00 	movzbl 0x15c0(%esi,%eax,1),%edx
 64f:	00 
 650:	88 54 01 04          	mov    %dl,0x4(%ecx,%eax,1)
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
		for(int i=0; i<WIDTH; i++){
 654:	83 c0 01             	add    $0x1,%eax
 657:	83 f8 50             	cmp    $0x50,%eax
 65a:	75 ec                	jne    648 <newline+0x28>
 65c:	83 c6 50             	add    $0x50,%esi
			cur->line[i] = buf[bufindex];
			bufindex++;
		}
		cur = cur->next;
 65f:	8b 49 58             	mov    0x58(%ecx),%ecx
void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
 662:	3b 4f 58             	cmp    0x58(%edi),%ecx
 665:	75 d9                	jne    640 <newline+0x20>

void
newline(void)
{
	saveedits();
	int line = currChar/WIDTH;
 667:	8b 0d 84 15 00 00    	mov    0x1584,%ecx
 66d:	ba 67 66 66 66       	mov    $0x66666667,%edx
 672:	89 c8                	mov    %ecx,%eax
 674:	f7 ea                	imul   %edx
 676:	89 c8                	mov    %ecx,%eax
 678:	c1 f8 1f             	sar    $0x1f,%eax
 67b:	c1 fa 05             	sar    $0x5,%edx
 67e:	29 c2                	sub    %eax,%edx
	struct fileline* cur = firstOnScreen;
	for(int i=0; i<line; i++){
 680:	31 c0                	xor    %eax,%eax
 682:	85 d2                	test   %edx,%edx
 684:	7e 14                	jle    69a <newline+0x7a>
 686:	8d 76 00             	lea    0x0(%esi),%esi
 689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 690:	83 c0 01             	add    $0x1,%eax
		cur = cur->next;
 693:	8b 5b 58             	mov    0x58(%ebx),%ebx
newline(void)
{
	saveedits();
	int line = currChar/WIDTH;
	struct fileline* cur = firstOnScreen;
	for(int i=0; i<line; i++){
 696:	39 c2                	cmp    %eax,%edx
 698:	75 f6                	jne    690 <newline+0x70>
		cur = cur->next;
	}
	int linechar = currChar % WIDTH;
 69a:	89 c8                	mov    %ecx,%eax
 69c:	ba 67 66 66 66       	mov    $0x66666667,%edx
 6a1:	f7 ea                	imul   %edx
 6a3:	89 c8                	mov    %ecx,%eax
 6a5:	c1 f8 1f             	sar    $0x1f,%eax
 6a8:	c1 fa 05             	sar    $0x5,%edx
 6ab:	89 d6                	mov    %edx,%esi
 6ad:	29 c6                	sub    %eax,%esi
 6af:	8d 04 b6             	lea    (%esi,%esi,4),%eax
	//enter pressed in any column except first
	if(linechar != 0){
 6b2:	89 ce                	mov    %ecx,%esi
	int line = currChar/WIDTH;
	struct fileline* cur = firstOnScreen;
	for(int i=0; i<line; i++){
		cur = cur->next;
	}
	int linechar = currChar % WIDTH;
 6b4:	c1 e0 04             	shl    $0x4,%eax
	//enter pressed in any column except first
	if(linechar != 0){
 6b7:	29 c6                	sub    %eax,%esi
 6b9:	74 77                	je     732 <newline+0x112>
		struct fileline* newfileline = malloc(sizeof(struct fileline));
 6bb:	83 ec 0c             	sub    $0xc,%esp
 6be:	6a 5c                	push   $0x5c
 6c0:	e8 2b 08 00 00       	call   ef0 <malloc>
		int i = 0;
		for(i = 0; linechar<WIDTH; i++, linechar++){
			newfileline->line[i] = cur->line[linechar];
 6c5:	89 c7                	mov    %eax,%edi
		cur = cur->next;
	}
	int linechar = currChar % WIDTH;
	//enter pressed in any column except first
	if(linechar != 0){
		struct fileline* newfileline = malloc(sizeof(struct fileline));
 6c7:	83 c4 10             	add    $0x10,%esp
 6ca:	89 f2                	mov    %esi,%edx
		int i = 0;
		for(i = 0; linechar<WIDTH; i++, linechar++){
			newfileline->line[i] = cur->line[linechar];
 6cc:	29 f7                	sub    %esi,%edi
 6ce:	66 90                	xchg   %ax,%ax
 6d0:	0f b6 4c 13 04       	movzbl 0x4(%ebx,%edx,1),%ecx
 6d5:	88 4c 17 04          	mov    %cl,0x4(%edi,%edx,1)
			cur->line[linechar] = ' ';
 6d9:	c6 44 13 04 20       	movb   $0x20,0x4(%ebx,%edx,1)
	int linechar = currChar % WIDTH;
	//enter pressed in any column except first
	if(linechar != 0){
		struct fileline* newfileline = malloc(sizeof(struct fileline));
		int i = 0;
		for(i = 0; linechar<WIDTH; i++, linechar++){
 6de:	83 c2 01             	add    $0x1,%edx
 6e1:	83 fa 50             	cmp    $0x50,%edx
 6e4:	75 ea                	jne    6d0 <newline+0xb0>
			newfileline->line[i] = cur->line[linechar];
			cur->line[linechar] = ' ';
		}
		for(int j = i; j<WIDTH; j++){
 6e6:	85 f6                	test   %esi,%esi
 6e8:	74 18                	je     702 <newline+0xe2>
 6ea:	89 c2                	mov    %eax,%edx
 6ec:	8d 48 54             	lea    0x54(%eax),%ecx
 6ef:	29 f2                	sub    %esi,%edx
 6f1:	83 c2 54             	add    $0x54,%edx
 6f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
			newfileline->line[j] = ' ';
 6f8:	c6 02 20             	movb   $0x20,(%edx)
 6fb:	83 c2 01             	add    $0x1,%edx
		int i = 0;
		for(i = 0; linechar<WIDTH; i++, linechar++){
			newfileline->line[i] = cur->line[linechar];
			cur->line[linechar] = ' ';
		}
		for(int j = i; j<WIDTH; j++){
 6fe:	39 ca                	cmp    %ecx,%edx
 700:	75 f6                	jne    6f8 <newline+0xd8>
			newfileline->line[j] = ' ';
		}
		newfileline->next = cur->next;
 702:	8b 53 58             	mov    0x58(%ebx),%edx
		newfileline->prev = cur;
 705:	89 58 54             	mov    %ebx,0x54(%eax)
			cur->line[linechar] = ' ';
		}
		for(int j = i; j<WIDTH; j++){
			newfileline->line[j] = ' ';
		}
		newfileline->next = cur->next;
 708:	89 50 58             	mov    %edx,0x58(%eax)
		newfileline->prev = cur;
		if(cur->next != 0){
 70b:	8b 53 58             	mov    0x58(%ebx),%edx
 70e:	85 d2                	test   %edx,%edx
 710:	0f 84 8d 00 00 00    	je     7a3 <newline+0x183>
			cur->next->prev = newfileline;
 716:	89 42 54             	mov    %eax,0x54(%edx)
		} else {
			lastOnScreen = newfileline;
		}
		cur->next = newfileline;
		newfileline->filelinenum = cur->filelinenum;
 719:	8b 13                	mov    (%ebx),%edx
		if(cur->next != 0){
			cur->next->prev = newfileline;
		} else {
			lastOnScreen = newfileline;
		}
		cur->next = newfileline;
 71b:	89 43 58             	mov    %eax,0x58(%ebx)
		newfileline->filelinenum = cur->filelinenum;
 71e:	89 10                	mov    %edx,(%eax)
 720:	eb 02                	jmp    724 <newline+0x104>
 722:	8b 10                	mov    (%eax),%edx
		struct fileline* temp = newfileline;
		while(temp != 0){
			temp->filelinenum = temp->filelinenum + 1;
 724:	83 c2 01             	add    $0x1,%edx
 727:	89 10                	mov    %edx,(%eax)
			temp = temp->next;
 729:	8b 40 58             	mov    0x58(%eax),%eax
			lastOnScreen = newfileline;
		}
		cur->next = newfileline;
		newfileline->filelinenum = cur->filelinenum;
		struct fileline* temp = newfileline;
		while(temp != 0){
 72c:	85 c0                	test   %eax,%eax
 72e:	75 f2                	jne    722 <newline+0x102>
 730:	eb 58                	jmp    78a <newline+0x16a>
		}
	} 
	//enter was pressed in first column
	else
	{
		struct fileline* newfileline = malloc(sizeof(struct fileline));
 732:	83 ec 0c             	sub    $0xc,%esp
 735:	6a 5c                	push   $0x5c
 737:	e8 b4 07 00 00       	call   ef0 <malloc>
 73c:	8d 50 04             	lea    0x4(%eax),%edx
 73f:	8d 48 54             	lea    0x54(%eax),%ecx
 742:	83 c4 10             	add    $0x10,%esp
 745:	8d 76 00             	lea    0x0(%esi),%esi
		int i = 0;
		for(i = 0; linechar<WIDTH; i++, linechar++){
			newfileline->line[i] = ' ';
 748:	c6 02 20             	movb   $0x20,(%edx)
 74b:	83 c2 01             	add    $0x1,%edx
	//enter was pressed in first column
	else
	{
		struct fileline* newfileline = malloc(sizeof(struct fileline));
		int i = 0;
		for(i = 0; linechar<WIDTH; i++, linechar++){
 74e:	39 ca                	cmp    %ecx,%edx
 750:	75 f6                	jne    748 <newline+0x128>
			newfileline->line[i] = ' ';
		}
		newfileline->next = cur;
 752:	89 58 58             	mov    %ebx,0x58(%eax)
		newfileline->prev = cur->prev;
 755:	8b 53 54             	mov    0x54(%ebx),%edx
 758:	89 50 54             	mov    %edx,0x54(%eax)
		if(cur->prev != 0){
 75b:	8b 53 54             	mov    0x54(%ebx),%edx
 75e:	85 d2                	test   %edx,%edx
 760:	74 4b                	je     7ad <newline+0x18d>
			cur->prev->next = newfileline;
 762:	89 42 58             	mov    %eax,0x58(%edx)
		} else {
			firstOnScreen = newfileline;
		}
		cur->prev = newfileline;
		newfileline->filelinenum = cur->filelinenum;
 765:	8b 13                	mov    (%ebx),%edx
		if(cur->prev != 0){
			cur->prev->next = newfileline;
		} else {
			firstOnScreen = newfileline;
		}
		cur->prev = newfileline;
 767:	89 43 54             	mov    %eax,0x54(%ebx)
		newfileline->filelinenum = cur->filelinenum;
 76a:	89 10                	mov    %edx,(%eax)
		struct fileline* temp = newfileline->next;
 76c:	8b 40 58             	mov    0x58(%eax),%eax
		while(temp != 0){
 76f:	85 c0                	test   %eax,%eax
 771:	74 0a                	je     77d <newline+0x15d>
			temp->filelinenum = temp->filelinenum + 1;
 773:	83 00 01             	addl   $0x1,(%eax)
			temp = temp->next;
 776:	8b 40 58             	mov    0x58(%eax),%eax
			firstOnScreen = newfileline;
		}
		cur->prev = newfileline;
		newfileline->filelinenum = cur->filelinenum;
		struct fileline* temp = newfileline->next;
		while(temp != 0){
 779:	85 c0                	test   %eax,%eax
 77b:	75 f6                	jne    773 <newline+0x153>
			temp->filelinenum = temp->filelinenum + 1;
			temp = temp->next;
		}
		lastOnScreen = lastOnScreen->prev;
 77d:	a1 a4 15 00 00       	mov    0x15a4,%eax
 782:	8b 40 54             	mov    0x54(%eax),%eax
 785:	a3 a4 15 00 00       	mov    %eax,0x15a4
	}
	printfile(firstOnScreen);
 78a:	83 ec 0c             	sub    $0xc,%esp
 78d:	ff 35 a0 15 00 00    	pushl  0x15a0
 793:	e8 f8 f9 ff ff       	call   190 <printfile>
}
 798:	83 c4 10             	add    $0x10,%esp
 79b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 79e:	5b                   	pop    %ebx
 79f:	5e                   	pop    %esi
 7a0:	5f                   	pop    %edi
 7a1:	5d                   	pop    %ebp
 7a2:	c3                   	ret    
		newfileline->next = cur->next;
		newfileline->prev = cur;
		if(cur->next != 0){
			cur->next->prev = newfileline;
		} else {
			lastOnScreen = newfileline;
 7a3:	a3 a4 15 00 00       	mov    %eax,0x15a4
 7a8:	e9 6c ff ff ff       	jmp    719 <newline+0xf9>
		newfileline->next = cur;
		newfileline->prev = cur->prev;
		if(cur->prev != 0){
			cur->prev->next = newfileline;
		} else {
			firstOnScreen = newfileline;
 7ad:	a3 a0 15 00 00       	mov    %eax,0x15a0
 7b2:	eb b1                	jmp    765 <newline+0x145>
 7b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 7ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000007c0 <handleInput>:
	}
	printfile(firstOnScreen);
}

void
handleInput(int i) {
 7c0:	55                   	push   %ebp
 7c1:	89 e5                	mov    %esp,%ebp
 7c3:	56                   	push   %esi
 7c4:	53                   	push   %ebx
 7c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
	printf(1, "currChar: %d\n", currChar);
 7c8:	83 ec 04             	sub    $0x4,%esp
 7cb:	ff 35 84 15 00 00    	pushl  0x1584
 7d1:	68 89 10 00 00       	push   $0x1089
 7d6:	6a 01                	push   $0x1
 7d8:	e8 e3 04 00 00       	call   cc0 <printf>
	//ctrl+q
	if (i == 17) {
 7dd:	83 c4 10             	add    $0x10,%esp
 7e0:	83 fb 11             	cmp    $0x11,%ebx
 7e3:	0f 84 17 01 00 00    	je     900 <handleInput+0x140>
		exit();
	}
	else if(i >= 9 && i<= 12){
 7e9:	8d 43 f7             	lea    -0x9(%ebx),%eax
 7ec:	83 f8 03             	cmp    $0x3,%eax
 7ef:	76 67                	jbe    858 <handleInput+0x98>
		arrowkeys(i);
	}

	//ctrl+x
	else if(i == 24){
 7f1:	83 fb 18             	cmp    $0x18,%ebx
 7f4:	0f 84 ec 00 00 00    	je     8e6 <handleInput+0x126>
		cutline();
	}

	//return key
	else if(i == 13){
 7fa:	83 fb 0d             	cmp    $0xd,%ebx
 7fd:	0f 84 ee 00 00 00    	je     8f1 <handleInput+0x131>
		newline();
	}

	//backspace
	else if(i == 127){
 803:	83 fb 7f             	cmp    $0x7f,%ebx
 806:	74 68                	je     870 <handleInput+0xb0>
			buf[bufindex] = ' ';
			updatesc(0, 1, buf, TEXT_COLOR);
		}
	}
	//On right edge of window 
	else if((currChar+1) % WIDTH == 0){
 808:	8b 35 84 15 00 00    	mov    0x1584,%esi
 80e:	ba 67 66 66 66       	mov    $0x66666667,%edx
 813:	8d 4e 01             	lea    0x1(%esi),%ecx
 816:	89 c8                	mov    %ecx,%eax
 818:	f7 ea                	imul   %edx
 81a:	89 c8                	mov    %ecx,%eax
 81c:	c1 f8 1f             	sar    $0x1f,%eax
 81f:	c1 fa 05             	sar    $0x5,%edx
 822:	29 c2                	sub    %eax,%edx
 824:	8d 04 92             	lea    (%edx,%edx,4),%eax
 827:	c1 e0 04             	shl    $0x4,%eax
 82a:	39 c1                	cmp    %eax,%ecx
 82c:	74 06                	je     834 <handleInput+0x74>
		buf[currChar] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
		// printf(1, "new input");
	}
	else{
		buf[currChar++] = (char) i & 0xff;
 82e:	89 0d 84 15 00 00    	mov    %ecx,0x1584
 834:	88 9e c0 15 00 00    	mov    %bl,0x15c0(%esi)
		updatesc(0, 1, buf, TEXT_COLOR);
 83a:	6a 07                	push   $0x7
 83c:	68 c0 15 00 00       	push   $0x15c0
 841:	6a 01                	push   $0x1
 843:	6a 00                	push   $0x0
 845:	e8 b8 03 00 00       	call   c02 <updatesc>
 84a:	83 c4 10             	add    $0x10,%esp
	}
}
 84d:	8d 65 f8             	lea    -0x8(%ebp),%esp
 850:	5b                   	pop    %ebx
 851:	5e                   	pop    %esi
 852:	5d                   	pop    %ebp
 853:	c3                   	ret    
 854:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	//ctrl+q
	if (i == 17) {
		exit();
	}
	else if(i >= 9 && i<= 12){
		arrowkeys(i);
 858:	89 5d 08             	mov    %ebx,0x8(%ebp)
	}
	else{
		buf[currChar++] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
	}
}
 85b:	8d 65 f8             	lea    -0x8(%ebp),%esp
 85e:	5b                   	pop    %ebx
 85f:	5e                   	pop    %esi
 860:	5d                   	pop    %ebp
	//ctrl+q
	if (i == 17) {
		exit();
	}
	else if(i >= 9 && i<= 12){
		arrowkeys(i);
 861:	e9 8a fb ff ff       	jmp    3f0 <arrowkeys>
 866:	8d 76 00             	lea    0x0(%esi),%esi
 869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		newline();
	}

	//backspace
	else if(i == 127){
		if(currChar > 0){
 870:	8b 1d 84 15 00 00    	mov    0x1584,%ebx
 876:	85 db                	test   %ebx,%ebx
 878:	7e d3                	jle    84d <handleInput+0x8d>
			currChar--;
			int bufindex = currChar;
			while(((bufindex+1) % WIDTH) != 0){
 87a:	89 d8                	mov    %ebx,%eax
 87c:	ba 67 66 66 66       	mov    $0x66666667,%edx
	}

	//backspace
	else if(i == 127){
		if(currChar > 0){
			currChar--;
 881:	8d 4b ff             	lea    -0x1(%ebx),%ecx
			int bufindex = currChar;
			while(((bufindex+1) % WIDTH) != 0){
 884:	f7 ea                	imul   %edx
 886:	89 d8                	mov    %ebx,%eax
 888:	c1 f8 1f             	sar    $0x1f,%eax
	}

	//backspace
	else if(i == 127){
		if(currChar > 0){
			currChar--;
 88b:	89 0d 84 15 00 00    	mov    %ecx,0x1584
			int bufindex = currChar;
			while(((bufindex+1) % WIDTH) != 0){
 891:	c1 fa 05             	sar    $0x5,%edx
 894:	29 c2                	sub    %eax,%edx
 896:	8d 04 92             	lea    (%edx,%edx,4),%eax
 899:	c1 e0 04             	shl    $0x4,%eax
 89c:	39 c3                	cmp    %eax,%ebx
 89e:	74 5c                	je     8fc <handleInput+0x13c>
 8a0:	be 67 66 66 66       	mov    $0x66666667,%esi
 8a5:	eb 0b                	jmp    8b2 <handleInput+0xf2>
 8a7:	89 f6                	mov    %esi,%esi
 8a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 8b0:	89 cb                	mov    %ecx,%ebx
				buf[bufindex] = buf[bufindex+1];
 8b2:	0f b6 83 c0 15 00 00 	movzbl 0x15c0(%ebx),%eax
	//backspace
	else if(i == 127){
		if(currChar > 0){
			currChar--;
			int bufindex = currChar;
			while(((bufindex+1) % WIDTH) != 0){
 8b9:	8d 4b 01             	lea    0x1(%ebx),%ecx
				buf[bufindex] = buf[bufindex+1];
 8bc:	88 83 bf 15 00 00    	mov    %al,0x15bf(%ebx)
	//backspace
	else if(i == 127){
		if(currChar > 0){
			currChar--;
			int bufindex = currChar;
			while(((bufindex+1) % WIDTH) != 0){
 8c2:	89 c8                	mov    %ecx,%eax
 8c4:	f7 ee                	imul   %esi
 8c6:	89 c8                	mov    %ecx,%eax
 8c8:	c1 f8 1f             	sar    $0x1f,%eax
 8cb:	c1 fa 05             	sar    $0x5,%edx
 8ce:	29 c2                	sub    %eax,%edx
 8d0:	8d 04 92             	lea    (%edx,%edx,4),%eax
 8d3:	c1 e0 04             	shl    $0x4,%eax
 8d6:	39 c1                	cmp    %eax,%ecx
 8d8:	75 d6                	jne    8b0 <handleInput+0xf0>
				buf[bufindex] = buf[bufindex+1];
				bufindex++;
			}
			buf[bufindex] = ' ';
 8da:	c6 83 c0 15 00 00 20 	movb   $0x20,0x15c0(%ebx)
 8e1:	e9 54 ff ff ff       	jmp    83a <handleInput+0x7a>
	}
	else{
		buf[currChar++] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
	}
}
 8e6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 8e9:	5b                   	pop    %ebx
 8ea:	5e                   	pop    %esi
 8eb:	5d                   	pop    %ebp
		arrowkeys(i);
	}

	//ctrl+x
	else if(i == 24){
		cutline();
 8ec:	e9 ef fb ff ff       	jmp    4e0 <cutline>
	}
	else{
		buf[currChar++] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
	}
}
 8f1:	8d 65 f8             	lea    -0x8(%ebp),%esp
 8f4:	5b                   	pop    %ebx
 8f5:	5e                   	pop    %esi
 8f6:	5d                   	pop    %ebp
		cutline();
	}

	//return key
	else if(i == 13){
		newline();
 8f7:	e9 24 fd ff ff       	jmp    620 <newline>

	//backspace
	else if(i == 127){
		if(currChar > 0){
			currChar--;
			int bufindex = currChar;
 8fc:	89 cb                	mov    %ecx,%ebx
 8fe:	eb da                	jmp    8da <handleInput+0x11a>
void
handleInput(int i) {
	printf(1, "currChar: %d\n", currChar);
	//ctrl+q
	if (i == 17) {
		exit();
 900:	e8 4d 02 00 00       	call   b52 <exit>
 905:	66 90                	xchg   %ax,%ax
 907:	66 90                	xchg   %ax,%ax
 909:	66 90                	xchg   %ax,%ax
 90b:	66 90                	xchg   %ax,%ax
 90d:	66 90                	xchg   %ax,%ax
 90f:	90                   	nop

00000910 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 910:	55                   	push   %ebp
 911:	89 e5                	mov    %esp,%ebp
 913:	53                   	push   %ebx
 914:	8b 45 08             	mov    0x8(%ebp),%eax
 917:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 91a:	89 c2                	mov    %eax,%edx
 91c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 920:	83 c1 01             	add    $0x1,%ecx
 923:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 927:	83 c2 01             	add    $0x1,%edx
 92a:	84 db                	test   %bl,%bl
 92c:	88 5a ff             	mov    %bl,-0x1(%edx)
 92f:	75 ef                	jne    920 <strcpy+0x10>
    ;
  return os;
}
 931:	5b                   	pop    %ebx
 932:	5d                   	pop    %ebp
 933:	c3                   	ret    
 934:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 93a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000940 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 940:	55                   	push   %ebp
 941:	89 e5                	mov    %esp,%ebp
 943:	56                   	push   %esi
 944:	53                   	push   %ebx
 945:	8b 55 08             	mov    0x8(%ebp),%edx
 948:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 94b:	0f b6 02             	movzbl (%edx),%eax
 94e:	0f b6 19             	movzbl (%ecx),%ebx
 951:	84 c0                	test   %al,%al
 953:	75 1e                	jne    973 <strcmp+0x33>
 955:	eb 29                	jmp    980 <strcmp+0x40>
 957:	89 f6                	mov    %esi,%esi
 959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 960:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 963:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 966:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 969:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 96d:	84 c0                	test   %al,%al
 96f:	74 0f                	je     980 <strcmp+0x40>
 971:	89 f1                	mov    %esi,%ecx
 973:	38 d8                	cmp    %bl,%al
 975:	74 e9                	je     960 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 977:	29 d8                	sub    %ebx,%eax
}
 979:	5b                   	pop    %ebx
 97a:	5e                   	pop    %esi
 97b:	5d                   	pop    %ebp
 97c:	c3                   	ret    
 97d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 980:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 982:	29 d8                	sub    %ebx,%eax
}
 984:	5b                   	pop    %ebx
 985:	5e                   	pop    %esi
 986:	5d                   	pop    %ebp
 987:	c3                   	ret    
 988:	90                   	nop
 989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000990 <strlen>:

uint
strlen(char *s)
{
 990:	55                   	push   %ebp
 991:	89 e5                	mov    %esp,%ebp
 993:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 996:	80 39 00             	cmpb   $0x0,(%ecx)
 999:	74 12                	je     9ad <strlen+0x1d>
 99b:	31 d2                	xor    %edx,%edx
 99d:	8d 76 00             	lea    0x0(%esi),%esi
 9a0:	83 c2 01             	add    $0x1,%edx
 9a3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 9a7:	89 d0                	mov    %edx,%eax
 9a9:	75 f5                	jne    9a0 <strlen+0x10>
    ;
  return n;
}
 9ab:	5d                   	pop    %ebp
 9ac:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 9ad:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 9af:	5d                   	pop    %ebp
 9b0:	c3                   	ret    
 9b1:	eb 0d                	jmp    9c0 <memset>
 9b3:	90                   	nop
 9b4:	90                   	nop
 9b5:	90                   	nop
 9b6:	90                   	nop
 9b7:	90                   	nop
 9b8:	90                   	nop
 9b9:	90                   	nop
 9ba:	90                   	nop
 9bb:	90                   	nop
 9bc:	90                   	nop
 9bd:	90                   	nop
 9be:	90                   	nop
 9bf:	90                   	nop

000009c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 9c0:	55                   	push   %ebp
 9c1:	89 e5                	mov    %esp,%ebp
 9c3:	57                   	push   %edi
 9c4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 9c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 9ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 9cd:	89 d7                	mov    %edx,%edi
 9cf:	fc                   	cld    
 9d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 9d2:	89 d0                	mov    %edx,%eax
 9d4:	5f                   	pop    %edi
 9d5:	5d                   	pop    %ebp
 9d6:	c3                   	ret    
 9d7:	89 f6                	mov    %esi,%esi
 9d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009e0 <strchr>:

char*
strchr(const char *s, char c)
{
 9e0:	55                   	push   %ebp
 9e1:	89 e5                	mov    %esp,%ebp
 9e3:	53                   	push   %ebx
 9e4:	8b 45 08             	mov    0x8(%ebp),%eax
 9e7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 9ea:	0f b6 10             	movzbl (%eax),%edx
 9ed:	84 d2                	test   %dl,%dl
 9ef:	74 1d                	je     a0e <strchr+0x2e>
    if(*s == c)
 9f1:	38 d3                	cmp    %dl,%bl
 9f3:	89 d9                	mov    %ebx,%ecx
 9f5:	75 0d                	jne    a04 <strchr+0x24>
 9f7:	eb 17                	jmp    a10 <strchr+0x30>
 9f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a00:	38 ca                	cmp    %cl,%dl
 a02:	74 0c                	je     a10 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 a04:	83 c0 01             	add    $0x1,%eax
 a07:	0f b6 10             	movzbl (%eax),%edx
 a0a:	84 d2                	test   %dl,%dl
 a0c:	75 f2                	jne    a00 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 a0e:	31 c0                	xor    %eax,%eax
}
 a10:	5b                   	pop    %ebx
 a11:	5d                   	pop    %ebp
 a12:	c3                   	ret    
 a13:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a20 <gets>:

char*
gets(char *buf, int max)
{
 a20:	55                   	push   %ebp
 a21:	89 e5                	mov    %esp,%ebp
 a23:	57                   	push   %edi
 a24:	56                   	push   %esi
 a25:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 a26:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 a28:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 a2b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 a2e:	eb 29                	jmp    a59 <gets+0x39>
    cc = read(0, &c, 1);
 a30:	83 ec 04             	sub    $0x4,%esp
 a33:	6a 01                	push   $0x1
 a35:	57                   	push   %edi
 a36:	6a 00                	push   $0x0
 a38:	e8 2d 01 00 00       	call   b6a <read>
    if(cc < 1)
 a3d:	83 c4 10             	add    $0x10,%esp
 a40:	85 c0                	test   %eax,%eax
 a42:	7e 1d                	jle    a61 <gets+0x41>
      break;
    buf[i++] = c;
 a44:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 a48:	8b 55 08             	mov    0x8(%ebp),%edx
 a4b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 a4d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 a4f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 a53:	74 1b                	je     a70 <gets+0x50>
 a55:	3c 0d                	cmp    $0xd,%al
 a57:	74 17                	je     a70 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 a59:	8d 5e 01             	lea    0x1(%esi),%ebx
 a5c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 a5f:	7c cf                	jl     a30 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 a61:	8b 45 08             	mov    0x8(%ebp),%eax
 a64:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 a68:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a6b:	5b                   	pop    %ebx
 a6c:	5e                   	pop    %esi
 a6d:	5f                   	pop    %edi
 a6e:	5d                   	pop    %ebp
 a6f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 a70:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 a73:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 a75:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 a79:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a7c:	5b                   	pop    %ebx
 a7d:	5e                   	pop    %esi
 a7e:	5f                   	pop    %edi
 a7f:	5d                   	pop    %ebp
 a80:	c3                   	ret    
 a81:	eb 0d                	jmp    a90 <stat>
 a83:	90                   	nop
 a84:	90                   	nop
 a85:	90                   	nop
 a86:	90                   	nop
 a87:	90                   	nop
 a88:	90                   	nop
 a89:	90                   	nop
 a8a:	90                   	nop
 a8b:	90                   	nop
 a8c:	90                   	nop
 a8d:	90                   	nop
 a8e:	90                   	nop
 a8f:	90                   	nop

00000a90 <stat>:

int
stat(char *n, struct stat *st)
{
 a90:	55                   	push   %ebp
 a91:	89 e5                	mov    %esp,%ebp
 a93:	56                   	push   %esi
 a94:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 a95:	83 ec 08             	sub    $0x8,%esp
 a98:	6a 00                	push   $0x0
 a9a:	ff 75 08             	pushl  0x8(%ebp)
 a9d:	e8 f0 00 00 00       	call   b92 <open>
  if(fd < 0)
 aa2:	83 c4 10             	add    $0x10,%esp
 aa5:	85 c0                	test   %eax,%eax
 aa7:	78 27                	js     ad0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 aa9:	83 ec 08             	sub    $0x8,%esp
 aac:	ff 75 0c             	pushl  0xc(%ebp)
 aaf:	89 c3                	mov    %eax,%ebx
 ab1:	50                   	push   %eax
 ab2:	e8 f3 00 00 00       	call   baa <fstat>
 ab7:	89 c6                	mov    %eax,%esi
  close(fd);
 ab9:	89 1c 24             	mov    %ebx,(%esp)
 abc:	e8 b9 00 00 00       	call   b7a <close>
  return r;
 ac1:	83 c4 10             	add    $0x10,%esp
 ac4:	89 f0                	mov    %esi,%eax
}
 ac6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 ac9:	5b                   	pop    %ebx
 aca:	5e                   	pop    %esi
 acb:	5d                   	pop    %ebp
 acc:	c3                   	ret    
 acd:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 ad0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 ad5:	eb ef                	jmp    ac6 <stat+0x36>
 ad7:	89 f6                	mov    %esi,%esi
 ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ae0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 ae0:	55                   	push   %ebp
 ae1:	89 e5                	mov    %esp,%ebp
 ae3:	53                   	push   %ebx
 ae4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 ae7:	0f be 11             	movsbl (%ecx),%edx
 aea:	8d 42 d0             	lea    -0x30(%edx),%eax
 aed:	3c 09                	cmp    $0x9,%al
 aef:	b8 00 00 00 00       	mov    $0x0,%eax
 af4:	77 1f                	ja     b15 <atoi+0x35>
 af6:	8d 76 00             	lea    0x0(%esi),%esi
 af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 b00:	8d 04 80             	lea    (%eax,%eax,4),%eax
 b03:	83 c1 01             	add    $0x1,%ecx
 b06:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 b0a:	0f be 11             	movsbl (%ecx),%edx
 b0d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 b10:	80 fb 09             	cmp    $0x9,%bl
 b13:	76 eb                	jbe    b00 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 b15:	5b                   	pop    %ebx
 b16:	5d                   	pop    %ebp
 b17:	c3                   	ret    
 b18:	90                   	nop
 b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000b20 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 b20:	55                   	push   %ebp
 b21:	89 e5                	mov    %esp,%ebp
 b23:	56                   	push   %esi
 b24:	53                   	push   %ebx
 b25:	8b 5d 10             	mov    0x10(%ebp),%ebx
 b28:	8b 45 08             	mov    0x8(%ebp),%eax
 b2b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 b2e:	85 db                	test   %ebx,%ebx
 b30:	7e 14                	jle    b46 <memmove+0x26>
 b32:	31 d2                	xor    %edx,%edx
 b34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 b38:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 b3c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 b3f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 b42:	39 da                	cmp    %ebx,%edx
 b44:	75 f2                	jne    b38 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 b46:	5b                   	pop    %ebx
 b47:	5e                   	pop    %esi
 b48:	5d                   	pop    %ebp
 b49:	c3                   	ret    

00000b4a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 b4a:	b8 01 00 00 00       	mov    $0x1,%eax
 b4f:	cd 40                	int    $0x40
 b51:	c3                   	ret    

00000b52 <exit>:
SYSCALL(exit)
 b52:	b8 02 00 00 00       	mov    $0x2,%eax
 b57:	cd 40                	int    $0x40
 b59:	c3                   	ret    

00000b5a <wait>:
SYSCALL(wait)
 b5a:	b8 03 00 00 00       	mov    $0x3,%eax
 b5f:	cd 40                	int    $0x40
 b61:	c3                   	ret    

00000b62 <pipe>:
SYSCALL(pipe)
 b62:	b8 04 00 00 00       	mov    $0x4,%eax
 b67:	cd 40                	int    $0x40
 b69:	c3                   	ret    

00000b6a <read>:
SYSCALL(read)
 b6a:	b8 05 00 00 00       	mov    $0x5,%eax
 b6f:	cd 40                	int    $0x40
 b71:	c3                   	ret    

00000b72 <write>:
SYSCALL(write)
 b72:	b8 10 00 00 00       	mov    $0x10,%eax
 b77:	cd 40                	int    $0x40
 b79:	c3                   	ret    

00000b7a <close>:
SYSCALL(close)
 b7a:	b8 15 00 00 00       	mov    $0x15,%eax
 b7f:	cd 40                	int    $0x40
 b81:	c3                   	ret    

00000b82 <kill>:
SYSCALL(kill)
 b82:	b8 06 00 00 00       	mov    $0x6,%eax
 b87:	cd 40                	int    $0x40
 b89:	c3                   	ret    

00000b8a <exec>:
SYSCALL(exec)
 b8a:	b8 07 00 00 00       	mov    $0x7,%eax
 b8f:	cd 40                	int    $0x40
 b91:	c3                   	ret    

00000b92 <open>:
SYSCALL(open)
 b92:	b8 0f 00 00 00       	mov    $0xf,%eax
 b97:	cd 40                	int    $0x40
 b99:	c3                   	ret    

00000b9a <mknod>:
SYSCALL(mknod)
 b9a:	b8 11 00 00 00       	mov    $0x11,%eax
 b9f:	cd 40                	int    $0x40
 ba1:	c3                   	ret    

00000ba2 <unlink>:
SYSCALL(unlink)
 ba2:	b8 12 00 00 00       	mov    $0x12,%eax
 ba7:	cd 40                	int    $0x40
 ba9:	c3                   	ret    

00000baa <fstat>:
SYSCALL(fstat)
 baa:	b8 08 00 00 00       	mov    $0x8,%eax
 baf:	cd 40                	int    $0x40
 bb1:	c3                   	ret    

00000bb2 <link>:
SYSCALL(link)
 bb2:	b8 13 00 00 00       	mov    $0x13,%eax
 bb7:	cd 40                	int    $0x40
 bb9:	c3                   	ret    

00000bba <mkdir>:
SYSCALL(mkdir)
 bba:	b8 14 00 00 00       	mov    $0x14,%eax
 bbf:	cd 40                	int    $0x40
 bc1:	c3                   	ret    

00000bc2 <chdir>:
SYSCALL(chdir)
 bc2:	b8 09 00 00 00       	mov    $0x9,%eax
 bc7:	cd 40                	int    $0x40
 bc9:	c3                   	ret    

00000bca <dup>:
SYSCALL(dup)
 bca:	b8 0a 00 00 00       	mov    $0xa,%eax
 bcf:	cd 40                	int    $0x40
 bd1:	c3                   	ret    

00000bd2 <getpid>:
SYSCALL(getpid)
 bd2:	b8 0b 00 00 00       	mov    $0xb,%eax
 bd7:	cd 40                	int    $0x40
 bd9:	c3                   	ret    

00000bda <sbrk>:
SYSCALL(sbrk)
 bda:	b8 0c 00 00 00       	mov    $0xc,%eax
 bdf:	cd 40                	int    $0x40
 be1:	c3                   	ret    

00000be2 <sleep>:
SYSCALL(sleep)
 be2:	b8 0d 00 00 00       	mov    $0xd,%eax
 be7:	cd 40                	int    $0x40
 be9:	c3                   	ret    

00000bea <uptime>:
SYSCALL(uptime)
 bea:	b8 0e 00 00 00       	mov    $0xe,%eax
 bef:	cd 40                	int    $0x40
 bf1:	c3                   	ret    

00000bf2 <captsc>:
SYSCALL(captsc)
 bf2:	b8 16 00 00 00       	mov    $0x16,%eax
 bf7:	cd 40                	int    $0x40
 bf9:	c3                   	ret    

00000bfa <freesc>:
SYSCALL(freesc)
 bfa:	b8 17 00 00 00       	mov    $0x17,%eax
 bff:	cd 40                	int    $0x40
 c01:	c3                   	ret    

00000c02 <updatesc>:
SYSCALL(updatesc)
 c02:	b8 18 00 00 00       	mov    $0x18,%eax
 c07:	cd 40                	int    $0x40
 c09:	c3                   	ret    

00000c0a <getkey>:
SYSCALL(getkey)
 c0a:	b8 19 00 00 00       	mov    $0x19,%eax
 c0f:	cd 40                	int    $0x40
 c11:	c3                   	ret    
 c12:	66 90                	xchg   %ax,%ax
 c14:	66 90                	xchg   %ax,%ax
 c16:	66 90                	xchg   %ax,%ax
 c18:	66 90                	xchg   %ax,%ax
 c1a:	66 90                	xchg   %ax,%ax
 c1c:	66 90                	xchg   %ax,%ax
 c1e:	66 90                	xchg   %ax,%ax

00000c20 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 c20:	55                   	push   %ebp
 c21:	89 e5                	mov    %esp,%ebp
 c23:	57                   	push   %edi
 c24:	56                   	push   %esi
 c25:	53                   	push   %ebx
 c26:	89 c6                	mov    %eax,%esi
 c28:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 c2b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 c2e:	85 db                	test   %ebx,%ebx
 c30:	74 7e                	je     cb0 <printint+0x90>
 c32:	89 d0                	mov    %edx,%eax
 c34:	c1 e8 1f             	shr    $0x1f,%eax
 c37:	84 c0                	test   %al,%al
 c39:	74 75                	je     cb0 <printint+0x90>
    neg = 1;
    x = -xx;
 c3b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 c3d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 c44:	f7 d8                	neg    %eax
 c46:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 c49:	31 ff                	xor    %edi,%edi
 c4b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 c4e:	89 ce                	mov    %ecx,%esi
 c50:	eb 08                	jmp    c5a <printint+0x3a>
 c52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 c58:	89 cf                	mov    %ecx,%edi
 c5a:	31 d2                	xor    %edx,%edx
 c5c:	8d 4f 01             	lea    0x1(%edi),%ecx
 c5f:	f7 f6                	div    %esi
 c61:	0f b6 92 c0 10 00 00 	movzbl 0x10c0(%edx),%edx
  }while((x /= base) != 0);
 c68:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 c6a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 c6d:	75 e9                	jne    c58 <printint+0x38>
  if(neg)
 c6f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 c72:	8b 75 c0             	mov    -0x40(%ebp),%esi
 c75:	85 c0                	test   %eax,%eax
 c77:	74 08                	je     c81 <printint+0x61>
    buf[i++] = '-';
 c79:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 c7e:	8d 4f 02             	lea    0x2(%edi),%ecx
 c81:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 c85:	8d 76 00             	lea    0x0(%esi),%esi
 c88:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 c8b:	83 ec 04             	sub    $0x4,%esp
 c8e:	83 ef 01             	sub    $0x1,%edi
 c91:	6a 01                	push   $0x1
 c93:	53                   	push   %ebx
 c94:	56                   	push   %esi
 c95:	88 45 d7             	mov    %al,-0x29(%ebp)
 c98:	e8 d5 fe ff ff       	call   b72 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 c9d:	83 c4 10             	add    $0x10,%esp
 ca0:	39 df                	cmp    %ebx,%edi
 ca2:	75 e4                	jne    c88 <printint+0x68>
    putc(fd, buf[i]);
}
 ca4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 ca7:	5b                   	pop    %ebx
 ca8:	5e                   	pop    %esi
 ca9:	5f                   	pop    %edi
 caa:	5d                   	pop    %ebp
 cab:	c3                   	ret    
 cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 cb0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 cb2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 cb9:	eb 8b                	jmp    c46 <printint+0x26>
 cbb:	90                   	nop
 cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000cc0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 cc0:	55                   	push   %ebp
 cc1:	89 e5                	mov    %esp,%ebp
 cc3:	57                   	push   %edi
 cc4:	56                   	push   %esi
 cc5:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 cc6:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 cc9:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 ccc:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 ccf:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 cd2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 cd5:	0f b6 1e             	movzbl (%esi),%ebx
 cd8:	83 c6 01             	add    $0x1,%esi
 cdb:	84 db                	test   %bl,%bl
 cdd:	0f 84 b0 00 00 00    	je     d93 <printf+0xd3>
 ce3:	31 d2                	xor    %edx,%edx
 ce5:	eb 39                	jmp    d20 <printf+0x60>
 ce7:	89 f6                	mov    %esi,%esi
 ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 cf0:	83 f8 25             	cmp    $0x25,%eax
 cf3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 cf6:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 cfb:	74 18                	je     d15 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 cfd:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 d00:	83 ec 04             	sub    $0x4,%esp
 d03:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 d06:	6a 01                	push   $0x1
 d08:	50                   	push   %eax
 d09:	57                   	push   %edi
 d0a:	e8 63 fe ff ff       	call   b72 <write>
 d0f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 d12:	83 c4 10             	add    $0x10,%esp
 d15:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 d18:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 d1c:	84 db                	test   %bl,%bl
 d1e:	74 73                	je     d93 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 d20:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 d22:	0f be cb             	movsbl %bl,%ecx
 d25:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 d28:	74 c6                	je     cf0 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 d2a:	83 fa 25             	cmp    $0x25,%edx
 d2d:	75 e6                	jne    d15 <printf+0x55>
      if(c == 'd'){
 d2f:	83 f8 64             	cmp    $0x64,%eax
 d32:	0f 84 f8 00 00 00    	je     e30 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 d38:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 d3e:	83 f9 70             	cmp    $0x70,%ecx
 d41:	74 5d                	je     da0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 d43:	83 f8 73             	cmp    $0x73,%eax
 d46:	0f 84 84 00 00 00    	je     dd0 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 d4c:	83 f8 63             	cmp    $0x63,%eax
 d4f:	0f 84 ea 00 00 00    	je     e3f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 d55:	83 f8 25             	cmp    $0x25,%eax
 d58:	0f 84 c2 00 00 00    	je     e20 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 d5e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 d61:	83 ec 04             	sub    $0x4,%esp
 d64:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 d68:	6a 01                	push   $0x1
 d6a:	50                   	push   %eax
 d6b:	57                   	push   %edi
 d6c:	e8 01 fe ff ff       	call   b72 <write>
 d71:	83 c4 0c             	add    $0xc,%esp
 d74:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 d77:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 d7a:	6a 01                	push   $0x1
 d7c:	50                   	push   %eax
 d7d:	57                   	push   %edi
 d7e:	83 c6 01             	add    $0x1,%esi
 d81:	e8 ec fd ff ff       	call   b72 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 d86:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 d8a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 d8d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 d8f:	84 db                	test   %bl,%bl
 d91:	75 8d                	jne    d20 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 d93:	8d 65 f4             	lea    -0xc(%ebp),%esp
 d96:	5b                   	pop    %ebx
 d97:	5e                   	pop    %esi
 d98:	5f                   	pop    %edi
 d99:	5d                   	pop    %ebp
 d9a:	c3                   	ret    
 d9b:	90                   	nop
 d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 da0:	83 ec 0c             	sub    $0xc,%esp
 da3:	b9 10 00 00 00       	mov    $0x10,%ecx
 da8:	6a 00                	push   $0x0
 daa:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 dad:	89 f8                	mov    %edi,%eax
 daf:	8b 13                	mov    (%ebx),%edx
 db1:	e8 6a fe ff ff       	call   c20 <printint>
        ap++;
 db6:	89 d8                	mov    %ebx,%eax
 db8:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 dbb:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 dbd:	83 c0 04             	add    $0x4,%eax
 dc0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 dc3:	e9 4d ff ff ff       	jmp    d15 <printf+0x55>
 dc8:	90                   	nop
 dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 dd0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 dd3:	8b 18                	mov    (%eax),%ebx
        ap++;
 dd5:	83 c0 04             	add    $0x4,%eax
 dd8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 ddb:	b8 b8 10 00 00       	mov    $0x10b8,%eax
 de0:	85 db                	test   %ebx,%ebx
 de2:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 de5:	0f b6 03             	movzbl (%ebx),%eax
 de8:	84 c0                	test   %al,%al
 dea:	74 23                	je     e0f <printf+0x14f>
 dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 df0:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 df3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 df6:	83 ec 04             	sub    $0x4,%esp
 df9:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 dfb:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 dfe:	50                   	push   %eax
 dff:	57                   	push   %edi
 e00:	e8 6d fd ff ff       	call   b72 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 e05:	0f b6 03             	movzbl (%ebx),%eax
 e08:	83 c4 10             	add    $0x10,%esp
 e0b:	84 c0                	test   %al,%al
 e0d:	75 e1                	jne    df0 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 e0f:	31 d2                	xor    %edx,%edx
 e11:	e9 ff fe ff ff       	jmp    d15 <printf+0x55>
 e16:	8d 76 00             	lea    0x0(%esi),%esi
 e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 e20:	83 ec 04             	sub    $0x4,%esp
 e23:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 e26:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 e29:	6a 01                	push   $0x1
 e2b:	e9 4c ff ff ff       	jmp    d7c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 e30:	83 ec 0c             	sub    $0xc,%esp
 e33:	b9 0a 00 00 00       	mov    $0xa,%ecx
 e38:	6a 01                	push   $0x1
 e3a:	e9 6b ff ff ff       	jmp    daa <printf+0xea>
 e3f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 e42:	83 ec 04             	sub    $0x4,%esp
 e45:	8b 03                	mov    (%ebx),%eax
 e47:	6a 01                	push   $0x1
 e49:	88 45 e4             	mov    %al,-0x1c(%ebp)
 e4c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 e4f:	50                   	push   %eax
 e50:	57                   	push   %edi
 e51:	e8 1c fd ff ff       	call   b72 <write>
 e56:	e9 5b ff ff ff       	jmp    db6 <printf+0xf6>
 e5b:	66 90                	xchg   %ax,%ax
 e5d:	66 90                	xchg   %ax,%ax
 e5f:	90                   	nop

00000e60 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 e60:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e61:	a1 88 15 00 00       	mov    0x1588,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 e66:	89 e5                	mov    %esp,%ebp
 e68:	57                   	push   %edi
 e69:	56                   	push   %esi
 e6a:	53                   	push   %ebx
 e6b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e6e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 e70:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e73:	39 c8                	cmp    %ecx,%eax
 e75:	73 19                	jae    e90 <free+0x30>
 e77:	89 f6                	mov    %esi,%esi
 e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 e80:	39 d1                	cmp    %edx,%ecx
 e82:	72 1c                	jb     ea0 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e84:	39 d0                	cmp    %edx,%eax
 e86:	73 18                	jae    ea0 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 e88:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e8a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e8c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e8e:	72 f0                	jb     e80 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e90:	39 d0                	cmp    %edx,%eax
 e92:	72 f4                	jb     e88 <free+0x28>
 e94:	39 d1                	cmp    %edx,%ecx
 e96:	73 f0                	jae    e88 <free+0x28>
 e98:	90                   	nop
 e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 ea0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 ea3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 ea6:	39 d7                	cmp    %edx,%edi
 ea8:	74 19                	je     ec3 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 eaa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 ead:	8b 50 04             	mov    0x4(%eax),%edx
 eb0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 eb3:	39 f1                	cmp    %esi,%ecx
 eb5:	74 23                	je     eda <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 eb7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 eb9:	a3 88 15 00 00       	mov    %eax,0x1588
}
 ebe:	5b                   	pop    %ebx
 ebf:	5e                   	pop    %esi
 ec0:	5f                   	pop    %edi
 ec1:	5d                   	pop    %ebp
 ec2:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 ec3:	03 72 04             	add    0x4(%edx),%esi
 ec6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 ec9:	8b 10                	mov    (%eax),%edx
 ecb:	8b 12                	mov    (%edx),%edx
 ecd:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 ed0:	8b 50 04             	mov    0x4(%eax),%edx
 ed3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 ed6:	39 f1                	cmp    %esi,%ecx
 ed8:	75 dd                	jne    eb7 <free+0x57>
    p->s.size += bp->s.size;
 eda:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 edd:	a3 88 15 00 00       	mov    %eax,0x1588
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 ee2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 ee5:	8b 53 f8             	mov    -0x8(%ebx),%edx
 ee8:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 eea:	5b                   	pop    %ebx
 eeb:	5e                   	pop    %esi
 eec:	5f                   	pop    %edi
 eed:	5d                   	pop    %ebp
 eee:	c3                   	ret    
 eef:	90                   	nop

00000ef0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ef0:	55                   	push   %ebp
 ef1:	89 e5                	mov    %esp,%ebp
 ef3:	57                   	push   %edi
 ef4:	56                   	push   %esi
 ef5:	53                   	push   %ebx
 ef6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ef9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 efc:	8b 15 88 15 00 00    	mov    0x1588,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 f02:	8d 78 07             	lea    0x7(%eax),%edi
 f05:	c1 ef 03             	shr    $0x3,%edi
 f08:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 f0b:	85 d2                	test   %edx,%edx
 f0d:	0f 84 a3 00 00 00    	je     fb6 <malloc+0xc6>
 f13:	8b 02                	mov    (%edx),%eax
 f15:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 f18:	39 cf                	cmp    %ecx,%edi
 f1a:	76 74                	jbe    f90 <malloc+0xa0>
 f1c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 f22:	be 00 10 00 00       	mov    $0x1000,%esi
 f27:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 f2e:	0f 43 f7             	cmovae %edi,%esi
 f31:	ba 00 80 00 00       	mov    $0x8000,%edx
 f36:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 f3c:	0f 46 da             	cmovbe %edx,%ebx
 f3f:	eb 10                	jmp    f51 <malloc+0x61>
 f41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 f48:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 f4a:	8b 48 04             	mov    0x4(%eax),%ecx
 f4d:	39 cf                	cmp    %ecx,%edi
 f4f:	76 3f                	jbe    f90 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 f51:	39 05 88 15 00 00    	cmp    %eax,0x1588
 f57:	89 c2                	mov    %eax,%edx
 f59:	75 ed                	jne    f48 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 f5b:	83 ec 0c             	sub    $0xc,%esp
 f5e:	53                   	push   %ebx
 f5f:	e8 76 fc ff ff       	call   bda <sbrk>
  if(p == (char*)-1)
 f64:	83 c4 10             	add    $0x10,%esp
 f67:	83 f8 ff             	cmp    $0xffffffff,%eax
 f6a:	74 1c                	je     f88 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 f6c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 f6f:	83 ec 0c             	sub    $0xc,%esp
 f72:	83 c0 08             	add    $0x8,%eax
 f75:	50                   	push   %eax
 f76:	e8 e5 fe ff ff       	call   e60 <free>
  return freep;
 f7b:	8b 15 88 15 00 00    	mov    0x1588,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 f81:	83 c4 10             	add    $0x10,%esp
 f84:	85 d2                	test   %edx,%edx
 f86:	75 c0                	jne    f48 <malloc+0x58>
        return 0;
 f88:	31 c0                	xor    %eax,%eax
 f8a:	eb 1c                	jmp    fa8 <malloc+0xb8>
 f8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 f90:	39 cf                	cmp    %ecx,%edi
 f92:	74 1c                	je     fb0 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 f94:	29 f9                	sub    %edi,%ecx
 f96:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 f99:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 f9c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 f9f:	89 15 88 15 00 00    	mov    %edx,0x1588
      return (void*)(p + 1);
 fa5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 fa8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 fab:	5b                   	pop    %ebx
 fac:	5e                   	pop    %esi
 fad:	5f                   	pop    %edi
 fae:	5d                   	pop    %ebp
 faf:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 fb0:	8b 08                	mov    (%eax),%ecx
 fb2:	89 0a                	mov    %ecx,(%edx)
 fb4:	eb e9                	jmp    f9f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 fb6:	c7 05 88 15 00 00 8c 	movl   $0x158c,0x1588
 fbd:	15 00 00 
 fc0:	c7 05 8c 15 00 00 8c 	movl   $0x158c,0x158c
 fc7:	15 00 00 
    base.s.size = 0;
 fca:	b8 8c 15 00 00       	mov    $0x158c,%eax
 fcf:	c7 05 90 15 00 00 00 	movl   $0x0,0x1590
 fd6:	00 00 00 
 fd9:	e9 3e ff ff ff       	jmp    f1c <malloc+0x2c>
