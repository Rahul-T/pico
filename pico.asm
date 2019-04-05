
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
  18:	68 20 0f 00 00       	push   $0xf20
  1d:	e8 c0 06 00 00       	call   6e2 <captsc>
	drawHeader();
  22:	e8 19 02 00 00       	call   240 <drawHeader>
	updatesc(50, 0, "                         v0.1 ", UI_COLOR);
}

void
drawFooter() {
	updatesc(0, 24, " ^Q - Quit                                                                      ", UI_COLOR);
  27:	68 c0 00 00 00       	push   $0xc0
  2c:	68 10 0b 00 00       	push   $0xb10
  31:	6a 18                	push   $0x18
  33:	6a 00                	push   $0x0
  35:	e8 b8 06 00 00       	call   6f2 <updatesc>
	captsc(&c);
	drawHeader();
	drawFooter();
	int fd;

	if (argc == 2) {
  3a:	83 c4 20             	add    $0x20,%esp
  3d:	83 fe 02             	cmp    $0x2,%esi
  40:	74 3c                	je     7e <main+0x7e>
			close(fd);
			fd = open(argv[1], 0);
			initialprintfile(fd);
		}
	} else {
		printf(1, "No file selected");
  42:	83 ec 08             	sub    $0x8,%esp
  45:	68 97 0b 00 00       	push   $0xb97
  4a:	6a 01                	push   $0x1
  4c:	e8 5f 07 00 00       	call   7b0 <printf>
  51:	83 c4 10             	add    $0x10,%esp
  54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	}
	while(1) {
		while ((c = getkey()) <= 0) {
  58:	e8 9d 06 00 00       	call   6fa <getkey>
  5d:	85 c0                	test   %eax,%eax
  5f:	a3 20 0f 00 00       	mov    %eax,0xf20
  64:	7e f2                	jle    58 <main+0x58>
		}
		handleInput(c);
  66:	83 ec 0c             	sub    $0xc,%esp
  69:	50                   	push   %eax
  6a:	e8 41 02 00 00       	call   2b0 <handleInput>
		c = 0;
  6f:	c7 05 20 0f 00 00 00 	movl   $0x0,0xf20
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
  86:	e8 f7 05 00 00       	call   682 <open>
  8b:	83 c4 10             	add    $0x10,%esp
  8e:	85 c0                	test   %eax,%eax
  90:	89 c6                	mov    %eax,%esi
  92:	78 2a                	js     be <main+0xbe>
			printf(1, "Cannot open %s\n", argv[1]);
		} else {
			initLinkedList(fd);
  94:	83 ec 0c             	sub    $0xc,%esp
  97:	50                   	push   %eax
  98:	e8 43 00 00 00       	call   e0 <initLinkedList>
			close(fd);
  9d:	89 34 24             	mov    %esi,(%esp)
  a0:	e8 c5 05 00 00       	call   66a <close>
			fd = open(argv[1], 0);
  a5:	58                   	pop    %eax
  a6:	5a                   	pop    %edx
  a7:	6a 00                	push   $0x0
  a9:	ff 73 04             	pushl  0x4(%ebx)
  ac:	e8 d1 05 00 00       	call   682 <open>
			initialprintfile(fd);
  b1:	89 04 24             	mov    %eax,(%esp)
  b4:	e8 d7 00 00 00       	call   190 <initialprintfile>
  b9:	83 c4 10             	add    $0x10,%esp
  bc:	eb 9a                	jmp    58 <main+0x58>
	drawFooter();
	int fd;

	if (argc == 2) {
		if((fd = open(argv[1], 0)) < 0){
			printf(1, "Cannot open %s\n", argv[1]);
  be:	83 ec 04             	sub    $0x4,%esp
  c1:	ff 73 04             	pushl  0x4(%ebx)
  c4:	68 87 0b 00 00       	push   $0xb87
  c9:	6a 01                	push   $0x1
  cb:	e8 e0 06 00 00       	call   7b0 <printf>
  d0:	83 c4 10             	add    $0x10,%esp
  d3:	eb 83                	jmp    58 <main+0x58>
  d5:	66 90                	xchg   %ax,%ax
  d7:	66 90                	xchg   %ax,%ax
  d9:	66 90                	xchg   %ax,%ax
  db:	66 90                	xchg   %ax,%ax
  dd:	66 90                	xchg   %ax,%ax
  df:	90                   	nop

000000e0 <initLinkedList>:
struct fileline* firstOnScreen;
struct fileline* lastOnScreen;

void
initLinkedList(int fd)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	57                   	push   %edi
  e4:	56                   	push   %esi
  e5:	53                   	push   %ebx
  e6:	8d 75 e7             	lea    -0x19(%ebp),%esi
	int n;
	char singlechar[1];
	head = malloc(sizeof(struct fileline));
	struct fileline* cur = head;
	int linecounter = 0;
  e9:	31 ff                	xor    %edi,%edi
struct fileline* firstOnScreen;
struct fileline* lastOnScreen;

void
initLinkedList(int fd)
{
  eb:	83 ec 38             	sub    $0x38,%esp
	int n;
	char singlechar[1];
	head = malloc(sizeof(struct fileline));
  ee:	6a 5c                	push   $0x5c
  f0:	e8 eb 08 00 00       	call   9e0 <malloc>
	struct fileline* cur = head;
	int linecounter = 0;
	int linenumber = 0;

	while((n = read(fd, singlechar, 1)) > 0) {
  f5:	83 c4 10             	add    $0x10,%esp
void
initLinkedList(int fd)
{
	int n;
	char singlechar[1];
	head = malloc(sizeof(struct fileline));
  f8:	89 c3                	mov    %eax,%ebx
  fa:	a3 48 0f 00 00       	mov    %eax,0xf48
	struct fileline* cur = head;
	int linecounter = 0;
	int linenumber = 0;
  ff:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 106:	8d 76 00             	lea    0x0(%esi),%esi
 109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

	while((n = read(fd, singlechar, 1)) > 0) {
 110:	83 ec 04             	sub    $0x4,%esp
 113:	6a 01                	push   $0x1
 115:	56                   	push   %esi
 116:	ff 75 08             	pushl  0x8(%ebp)
 119:	e8 3c 05 00 00       	call   65a <read>
 11e:	83 c4 10             	add    $0x10,%esp
 121:	85 c0                	test   %eax,%eax
 123:	7e 5b                	jle    180 <initLinkedList+0xa0>
		if(linecounter < WIDTH){
 125:	83 ff 50             	cmp    $0x50,%edi
 128:	74 1e                	je     148 <initLinkedList+0x68>
			cur->line[linecounter] = singlechar[0];
 12a:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 12e:	88 44 3b 04          	mov    %al,0x4(%ebx,%edi,1)
			linecounter++;
 132:	83 c7 01             	add    $0x1,%edi
 135:	3c 0a                	cmp    $0xa,%al
 137:	b8 50 00 00 00       	mov    $0x50,%eax
 13c:	0f 44 f8             	cmove  %eax,%edi
 13f:	eb cf                	jmp    110 <initLinkedList+0x30>
 141:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			if(singlechar[0] == '\n'){
				linecounter = WIDTH;
			}
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
 148:	83 ec 0c             	sub    $0xc,%esp
			nextline->prev = cur;
			cur->next = nextline;
			cur = nextline;
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
			linecounter++;
 14b:	bf 01 00 00 00       	mov    $0x1,%edi
			if(singlechar[0] == '\n'){
				linecounter = WIDTH;
			}
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
 150:	6a 5c                	push   $0x5c
 152:	e8 89 08 00 00       	call   9e0 <malloc>
			cur->filelinenum = linenumber;
 157:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
			cur->next = nextline;
			cur = nextline;
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
			linecounter++;
			linenumber++;
 15a:	83 c4 10             	add    $0x10,%esp
				linecounter = WIDTH;
			}
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
			cur->filelinenum = linenumber;
 15d:	89 0b                	mov    %ecx,(%ebx)
			nextline->prev = cur;
			cur->next = nextline;
			cur = nextline;
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
 15f:	0f b6 55 e7          	movzbl -0x19(%ebp),%edx
			linecounter++;
			linenumber++;
 163:	83 c1 01             	add    $0x1,%ecx
			}
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
			cur->filelinenum = linenumber;
			nextline->prev = cur;
 166:	89 58 54             	mov    %ebx,0x54(%eax)
			cur->next = nextline;
			cur = nextline;
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
			linecounter++;
			linenumber++;
 169:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
			cur->filelinenum = linenumber;
			nextline->prev = cur;
			cur->next = nextline;
 16c:	89 43 58             	mov    %eax,0x58(%ebx)
			cur = nextline;
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
			linecounter++;
			linenumber++;
 16f:	89 c3                	mov    %eax,%ebx
			cur->filelinenum = linenumber;
			nextline->prev = cur;
			cur->next = nextline;
			cur = nextline;
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
 171:	88 50 04             	mov    %dl,0x4(%eax)
 174:	eb 9a                	jmp    110 <initLinkedList+0x30>
 176:	8d 76 00             	lea    0x0(%esi),%esi
 179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	// 	printf(1, "%s", cur->line);
	// 	cur = cur->next;
	// }
	// printf(1, "%s", cur->line);

}
 180:	8d 65 f4             	lea    -0xc(%ebp),%esp
 183:	5b                   	pop    %ebx
 184:	5e                   	pop    %esi
 185:	5f                   	pop    %edi
 186:	5d                   	pop    %ebp
 187:	c3                   	ret    
 188:	90                   	nop
 189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000190 <initialprintfile>:

void
initialprintfile(int fd)
{
	struct fileline* cur = head;
 190:	8b 0d 48 0f 00 00    	mov    0xf48,%ecx

}

void
initialprintfile(int fd)
{
 196:	55                   	push   %ebp
 197:	89 e5                	mov    %esp,%ebp
 199:	56                   	push   %esi
 19a:	53                   	push   %ebx
	struct fileline* cur = head;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
 19b:	8b 51 58             	mov    0x58(%ecx),%edx
 19e:	31 db                	xor    %ebx,%ebx

}

void
initialprintfile(int fd)
{
 1a0:	8b 75 08             	mov    0x8(%ebp),%esi
	struct fileline* cur = head;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
 1a3:	85 d2                	test   %edx,%edx
 1a5:	74 4e                	je     1f5 <initialprintfile+0x65>
 1a7:	89 f6                	mov    %esi,%esi
 1a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 1b0:	31 c0                	xor    %eax,%eax
 1b2:	eb 14                	jmp    1c8 <initialprintfile+0x38>
 1b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		for(int i=0; i<WIDTH; i++){
			if(cur->line[i] == '\0'){
				buf[bufindex] = ' ';
 1b8:	c6 84 03 60 0f 00 00 	movb   $0x20,0xf60(%ebx,%eax,1)
 1bf:	20 
initialprintfile(int fd)
{
	struct fileline* cur = head;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
		for(int i=0; i<WIDTH; i++){
 1c0:	83 c0 01             	add    $0x1,%eax
 1c3:	83 f8 50             	cmp    $0x50,%eax
 1c6:	74 18                	je     1e0 <initialprintfile+0x50>
			if(cur->line[i] == '\0'){
 1c8:	0f b6 54 01 04       	movzbl 0x4(%ecx,%eax,1),%edx
 1cd:	84 d2                	test   %dl,%dl
 1cf:	74 e7                	je     1b8 <initialprintfile+0x28>
				buf[bufindex] = ' ';
			} else{
				buf[bufindex] = cur->line[i];
 1d1:	88 94 03 60 0f 00 00 	mov    %dl,0xf60(%ebx,%eax,1)
initialprintfile(int fd)
{
	struct fileline* cur = head;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
		for(int i=0; i<WIDTH; i++){
 1d8:	83 c0 01             	add    $0x1,%eax
 1db:	83 f8 50             	cmp    $0x50,%eax
 1de:	75 e8                	jne    1c8 <initialprintfile+0x38>
			} else{
				buf[bufindex] = cur->line[i];
			}
			bufindex++;
		}
		cur = cur->next;
 1e0:	8b 49 58             	mov    0x58(%ecx),%ecx
 1e3:	83 c3 50             	add    $0x50,%ebx
void
initialprintfile(int fd)
{
	struct fileline* cur = head;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
 1e6:	8b 41 58             	mov    0x58(%ecx),%eax
 1e9:	85 c0                	test   %eax,%eax
 1eb:	74 08                	je     1f5 <initialprintfile+0x65>
 1ed:	81 fb e0 06 00 00    	cmp    $0x6e0,%ebx
 1f3:	75 bb                	jne    1b0 <initialprintfile+0x20>

void
initialprintfile(int fd)
{
	struct fileline* cur = head;
	int bufindex = 0;
 1f5:	31 d2                	xor    %edx,%edx
 1f7:	89 f6                	mov    %esi,%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
			bufindex++;
		}
		cur = cur->next;
	}
	for(int i=0; i<WIDTH; i++){
			buf[bufindex] = cur->line[i];
 200:	0f b6 44 11 04       	movzbl 0x4(%ecx,%edx,1),%eax
 205:	88 84 13 60 0f 00 00 	mov    %al,0xf60(%ebx,%edx,1)
			}
			bufindex++;
		}
		cur = cur->next;
	}
	for(int i=0; i<WIDTH; i++){
 20c:	83 c2 01             	add    $0x1,%edx
 20f:	83 fa 50             	cmp    $0x50,%edx
 212:	75 ec                	jne    200 <initialprintfile+0x70>
			bufindex++;
	}

	buf[bufindex] = '\0';
	//printf(1, "%s\n", buf);
	updatesc(0, 1, buf, TEXT_COLOR);
 214:	6a 07                	push   $0x7
 216:	68 60 0f 00 00       	push   $0xf60
 21b:	6a 01                	push   $0x1
 21d:	6a 00                	push   $0x0
	for(int i=0; i<WIDTH; i++){
			buf[bufindex] = cur->line[i];
			bufindex++;
	}

	buf[bufindex] = '\0';
 21f:	c6 83 b0 0f 00 00 00 	movb   $0x0,0xfb0(%ebx)
	//printf(1, "%s\n", buf);
	updatesc(0, 1, buf, TEXT_COLOR);
 226:	e8 c7 04 00 00       	call   6f2 <updatesc>
	close(fd);
 22b:	89 75 08             	mov    %esi,0x8(%ebp)
 22e:	83 c4 10             	add    $0x10,%esp
}
 231:	8d 65 f8             	lea    -0x8(%ebp),%esp
 234:	5b                   	pop    %ebx
 235:	5e                   	pop    %esi
 236:	5d                   	pop    %ebp
	}

	buf[bufindex] = '\0';
	//printf(1, "%s\n", buf);
	updatesc(0, 1, buf, TEXT_COLOR);
	close(fd);
 237:	e9 2e 04 00 00       	jmp    66a <close>
 23c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000240 <drawHeader>:
}

void
drawHeader() {
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	83 ec 08             	sub    $0x8,%esp
	updatesc(0, 0, "                              ", UI_COLOR);
 246:	68 c0 00 00 00       	push   $0xc0
 24b:	68 d0 0a 00 00       	push   $0xad0
 250:	6a 00                	push   $0x0
 252:	6a 00                	push   $0x0
 254:	e8 99 04 00 00       	call   6f2 <updatesc>
	updatesc(30, 0, "        PICO        ", UI_COLOR);
 259:	68 c0 00 00 00       	push   $0xc0
 25e:	68 64 0b 00 00       	push   $0xb64
 263:	6a 00                	push   $0x0
 265:	6a 1e                	push   $0x1e
 267:	e8 86 04 00 00       	call   6f2 <updatesc>
	updatesc(50, 0, "                         v0.1 ", UI_COLOR);
 26c:	83 c4 20             	add    $0x20,%esp
 26f:	68 c0 00 00 00       	push   $0xc0
 274:	68 f0 0a 00 00       	push   $0xaf0
 279:	6a 00                	push   $0x0
 27b:	6a 32                	push   $0x32
 27d:	e8 70 04 00 00       	call   6f2 <updatesc>
}
 282:	83 c4 10             	add    $0x10,%esp
 285:	c9                   	leave  
 286:	c3                   	ret    
 287:	89 f6                	mov    %esi,%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000290 <drawFooter>:

void
drawFooter() {
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	83 ec 08             	sub    $0x8,%esp
	updatesc(0, 24, " ^Q - Quit                                                                      ", UI_COLOR);
 296:	68 c0 00 00 00       	push   $0xc0
 29b:	68 10 0b 00 00       	push   $0xb10
 2a0:	6a 18                	push   $0x18
 2a2:	6a 00                	push   $0x0
 2a4:	e8 49 04 00 00       	call   6f2 <updatesc>
}
 2a9:	83 c4 10             	add    $0x10,%esp
 2ac:	c9                   	leave  
 2ad:	c3                   	ret    
 2ae:	66 90                	xchg   %ax,%ax

000002b0 <handleInput>:

void
handleInput(int i) {
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	56                   	push   %esi
 2b4:	53                   	push   %ebx
 2b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
	//ctrl+q
	if (i == 17) {
 2b8:	83 fb 11             	cmp    $0x11,%ebx
 2bb:	0f 84 33 01 00 00    	je     3f4 <handleInput+0x144>
		exit();
	}
	printf(1, "currChar: %d\n", currChar);
 2c1:	83 ec 04             	sub    $0x4,%esp
 2c4:	ff 35 24 0f 00 00    	pushl  0xf24
 2ca:	68 79 0b 00 00       	push   $0xb79
 2cf:	6a 01                	push   $0x1
 2d1:	e8 da 04 00 00       	call   7b0 <printf>
	if(i >= 9 && i<= 12){
 2d6:	8d 43 f7             	lea    -0x9(%ebx),%eax
 2d9:	83 c4 10             	add    $0x10,%esp
 2dc:	83 f8 03             	cmp    $0x3,%eax
 2df:	76 4f                	jbe    330 <handleInput+0x80>
		else if(i == 9 && currChar >= WIDTH){
			currChar -= WIDTH;
		}
	}
	//On right edge of window 
	else if((currChar+1) % WIDTH == 0){
 2e1:	8b 35 24 0f 00 00    	mov    0xf24,%esi
 2e7:	ba 67 66 66 66       	mov    $0x66666667,%edx
 2ec:	8d 4e 01             	lea    0x1(%esi),%ecx
 2ef:	89 c8                	mov    %ecx,%eax
 2f1:	f7 ea                	imul   %edx
 2f3:	89 c8                	mov    %ecx,%eax
 2f5:	c1 f8 1f             	sar    $0x1f,%eax
 2f8:	c1 fa 05             	sar    $0x5,%edx
 2fb:	29 c2                	sub    %eax,%edx
 2fd:	8d 04 92             	lea    (%edx,%edx,4),%eax
 300:	c1 e0 04             	shl    $0x4,%eax
 303:	39 c1                	cmp    %eax,%ecx
 305:	74 06                	je     30d <handleInput+0x5d>
		buf[currChar] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
		// printf(1, "new input");
	}
	else{
		buf[currChar++] = (char) i & 0xff;
 307:	89 0d 24 0f 00 00    	mov    %ecx,0xf24
		updatesc(0, 1, buf, TEXT_COLOR);
 30d:	6a 07                	push   $0x7
 30f:	68 60 0f 00 00       	push   $0xf60
 314:	6a 01                	push   $0x1
 316:	6a 00                	push   $0x0
		buf[currChar] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
		// printf(1, "new input");
	}
	else{
		buf[currChar++] = (char) i & 0xff;
 318:	88 9e 60 0f 00 00    	mov    %bl,0xf60(%esi)
		updatesc(0, 1, buf, TEXT_COLOR);
 31e:	e8 cf 03 00 00       	call   6f2 <updatesc>
 323:	83 c4 10             	add    $0x10,%esp
	}
}
 326:	8d 65 f8             	lea    -0x8(%ebp),%esp
 329:	5b                   	pop    %ebx
 32a:	5e                   	pop    %esi
 32b:	5d                   	pop    %ebp
 32c:	c3                   	ret    
 32d:	8d 76 00             	lea    0x0(%esi),%esi
		exit();
	}
	printf(1, "currChar: %d\n", currChar);
	if(i >= 9 && i<= 12){
		//ctrl+j (go left)
		if(i == 10 && (currChar % WIDTH != 0) && currChar > 0){
 330:	83 fb 0a             	cmp    $0xa,%ebx
 333:	74 4b                	je     380 <handleInput+0xd0>
			currChar--;
		}
		//ctrl+l (go right)
		else if(i==12 && ((currChar+1) % WIDTH != 0)){
 335:	83 fb 0c             	cmp    $0xc,%ebx
 338:	0f 84 82 00 00 00    	je     3c0 <handleInput+0x110>
			currChar++;
		}
		//ctrl+k (go down)
		else if(i == 11 && currChar < TOTAL_CHARS - WIDTH){
 33e:	83 fb 0b             	cmp    $0xb,%ebx
 341:	74 1d                	je     360 <handleInput+0xb0>
			currChar += WIDTH;
		}
		//ctrl+i (go up)
		else if(i == 9 && currChar >= WIDTH){
 343:	83 fb 09             	cmp    $0x9,%ebx
 346:	75 de                	jne    326 <handleInput+0x76>
 348:	a1 24 0f 00 00       	mov    0xf24,%eax
 34d:	83 f8 4f             	cmp    $0x4f,%eax
 350:	7e d4                	jle    326 <handleInput+0x76>
			currChar -= WIDTH;
 352:	83 e8 50             	sub    $0x50,%eax
 355:	a3 24 0f 00 00       	mov    %eax,0xf24
 35a:	eb ca                	jmp    326 <handleInput+0x76>
 35c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		//ctrl+l (go right)
		else if(i==12 && ((currChar+1) % WIDTH != 0)){
			currChar++;
		}
		//ctrl+k (go down)
		else if(i == 11 && currChar < TOTAL_CHARS - WIDTH){
 360:	a1 24 0f 00 00       	mov    0xf24,%eax
 365:	3d df 06 00 00       	cmp    $0x6df,%eax
 36a:	7f ba                	jg     326 <handleInput+0x76>
			currChar += WIDTH;
 36c:	83 c0 50             	add    $0x50,%eax
 36f:	a3 24 0f 00 00       	mov    %eax,0xf24
 374:	eb b0                	jmp    326 <handleInput+0x76>
 376:	8d 76 00             	lea    0x0(%esi),%esi
 379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		exit();
	}
	printf(1, "currChar: %d\n", currChar);
	if(i >= 9 && i<= 12){
		//ctrl+j (go left)
		if(i == 10 && (currChar % WIDTH != 0) && currChar > 0){
 380:	8b 0d 24 0f 00 00    	mov    0xf24,%ecx
 386:	ba 67 66 66 66       	mov    $0x66666667,%edx
 38b:	89 c8                	mov    %ecx,%eax
 38d:	f7 ea                	imul   %edx
 38f:	89 c8                	mov    %ecx,%eax
 391:	c1 f8 1f             	sar    $0x1f,%eax
 394:	c1 fa 05             	sar    $0x5,%edx
 397:	29 c2                	sub    %eax,%edx
 399:	8d 04 92             	lea    (%edx,%edx,4),%eax
 39c:	c1 e0 04             	shl    $0x4,%eax
 39f:	39 c1                	cmp    %eax,%ecx
 3a1:	74 83                	je     326 <handleInput+0x76>
 3a3:	85 c9                	test   %ecx,%ecx
 3a5:	0f 8e 7b ff ff ff    	jle    326 <handleInput+0x76>
			currChar--;
 3ab:	83 e9 01             	sub    $0x1,%ecx
 3ae:	89 0d 24 0f 00 00    	mov    %ecx,0xf24
 3b4:	e9 6d ff ff ff       	jmp    326 <handleInput+0x76>
 3b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		}
		//ctrl+l (go right)
		else if(i==12 && ((currChar+1) % WIDTH != 0)){
 3c0:	a1 24 0f 00 00       	mov    0xf24,%eax
 3c5:	ba 67 66 66 66       	mov    $0x66666667,%edx
 3ca:	8d 48 01             	lea    0x1(%eax),%ecx
 3cd:	89 c8                	mov    %ecx,%eax
 3cf:	f7 ea                	imul   %edx
 3d1:	89 c8                	mov    %ecx,%eax
 3d3:	c1 f8 1f             	sar    $0x1f,%eax
 3d6:	c1 fa 05             	sar    $0x5,%edx
 3d9:	29 c2                	sub    %eax,%edx
 3db:	8d 04 92             	lea    (%edx,%edx,4),%eax
 3de:	c1 e0 04             	shl    $0x4,%eax
 3e1:	39 c1                	cmp    %eax,%ecx
 3e3:	0f 84 3d ff ff ff    	je     326 <handleInput+0x76>
			currChar++;
 3e9:	89 0d 24 0f 00 00    	mov    %ecx,0xf24
 3ef:	e9 32 ff ff ff       	jmp    326 <handleInput+0x76>

void
handleInput(int i) {
	//ctrl+q
	if (i == 17) {
		exit();
 3f4:	e8 49 02 00 00       	call   642 <exit>
 3f9:	66 90                	xchg   %ax,%ax
 3fb:	66 90                	xchg   %ax,%ax
 3fd:	66 90                	xchg   %ax,%ax
 3ff:	90                   	nop

00000400 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	53                   	push   %ebx
 404:	8b 45 08             	mov    0x8(%ebp),%eax
 407:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 40a:	89 c2                	mov    %eax,%edx
 40c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 410:	83 c1 01             	add    $0x1,%ecx
 413:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 417:	83 c2 01             	add    $0x1,%edx
 41a:	84 db                	test   %bl,%bl
 41c:	88 5a ff             	mov    %bl,-0x1(%edx)
 41f:	75 ef                	jne    410 <strcpy+0x10>
    ;
  return os;
}
 421:	5b                   	pop    %ebx
 422:	5d                   	pop    %ebp
 423:	c3                   	ret    
 424:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 42a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000430 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	56                   	push   %esi
 434:	53                   	push   %ebx
 435:	8b 55 08             	mov    0x8(%ebp),%edx
 438:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 43b:	0f b6 02             	movzbl (%edx),%eax
 43e:	0f b6 19             	movzbl (%ecx),%ebx
 441:	84 c0                	test   %al,%al
 443:	75 1e                	jne    463 <strcmp+0x33>
 445:	eb 29                	jmp    470 <strcmp+0x40>
 447:	89 f6                	mov    %esi,%esi
 449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 450:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 453:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 456:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 459:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 45d:	84 c0                	test   %al,%al
 45f:	74 0f                	je     470 <strcmp+0x40>
 461:	89 f1                	mov    %esi,%ecx
 463:	38 d8                	cmp    %bl,%al
 465:	74 e9                	je     450 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 467:	29 d8                	sub    %ebx,%eax
}
 469:	5b                   	pop    %ebx
 46a:	5e                   	pop    %esi
 46b:	5d                   	pop    %ebp
 46c:	c3                   	ret    
 46d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 470:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 472:	29 d8                	sub    %ebx,%eax
}
 474:	5b                   	pop    %ebx
 475:	5e                   	pop    %esi
 476:	5d                   	pop    %ebp
 477:	c3                   	ret    
 478:	90                   	nop
 479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000480 <strlen>:

uint
strlen(char *s)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 486:	80 39 00             	cmpb   $0x0,(%ecx)
 489:	74 12                	je     49d <strlen+0x1d>
 48b:	31 d2                	xor    %edx,%edx
 48d:	8d 76 00             	lea    0x0(%esi),%esi
 490:	83 c2 01             	add    $0x1,%edx
 493:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 497:	89 d0                	mov    %edx,%eax
 499:	75 f5                	jne    490 <strlen+0x10>
    ;
  return n;
}
 49b:	5d                   	pop    %ebp
 49c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 49d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 49f:	5d                   	pop    %ebp
 4a0:	c3                   	ret    
 4a1:	eb 0d                	jmp    4b0 <memset>
 4a3:	90                   	nop
 4a4:	90                   	nop
 4a5:	90                   	nop
 4a6:	90                   	nop
 4a7:	90                   	nop
 4a8:	90                   	nop
 4a9:	90                   	nop
 4aa:	90                   	nop
 4ab:	90                   	nop
 4ac:	90                   	nop
 4ad:	90                   	nop
 4ae:	90                   	nop
 4af:	90                   	nop

000004b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	57                   	push   %edi
 4b4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 4b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 4ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 4bd:	89 d7                	mov    %edx,%edi
 4bf:	fc                   	cld    
 4c0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 4c2:	89 d0                	mov    %edx,%eax
 4c4:	5f                   	pop    %edi
 4c5:	5d                   	pop    %ebp
 4c6:	c3                   	ret    
 4c7:	89 f6                	mov    %esi,%esi
 4c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004d0 <strchr>:

char*
strchr(const char *s, char c)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	53                   	push   %ebx
 4d4:	8b 45 08             	mov    0x8(%ebp),%eax
 4d7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 4da:	0f b6 10             	movzbl (%eax),%edx
 4dd:	84 d2                	test   %dl,%dl
 4df:	74 1d                	je     4fe <strchr+0x2e>
    if(*s == c)
 4e1:	38 d3                	cmp    %dl,%bl
 4e3:	89 d9                	mov    %ebx,%ecx
 4e5:	75 0d                	jne    4f4 <strchr+0x24>
 4e7:	eb 17                	jmp    500 <strchr+0x30>
 4e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4f0:	38 ca                	cmp    %cl,%dl
 4f2:	74 0c                	je     500 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 4f4:	83 c0 01             	add    $0x1,%eax
 4f7:	0f b6 10             	movzbl (%eax),%edx
 4fa:	84 d2                	test   %dl,%dl
 4fc:	75 f2                	jne    4f0 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 4fe:	31 c0                	xor    %eax,%eax
}
 500:	5b                   	pop    %ebx
 501:	5d                   	pop    %ebp
 502:	c3                   	ret    
 503:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000510 <gets>:

char*
gets(char *buf, int max)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	57                   	push   %edi
 514:	56                   	push   %esi
 515:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 516:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 518:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 51b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 51e:	eb 29                	jmp    549 <gets+0x39>
    cc = read(0, &c, 1);
 520:	83 ec 04             	sub    $0x4,%esp
 523:	6a 01                	push   $0x1
 525:	57                   	push   %edi
 526:	6a 00                	push   $0x0
 528:	e8 2d 01 00 00       	call   65a <read>
    if(cc < 1)
 52d:	83 c4 10             	add    $0x10,%esp
 530:	85 c0                	test   %eax,%eax
 532:	7e 1d                	jle    551 <gets+0x41>
      break;
    buf[i++] = c;
 534:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 538:	8b 55 08             	mov    0x8(%ebp),%edx
 53b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 53d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 53f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 543:	74 1b                	je     560 <gets+0x50>
 545:	3c 0d                	cmp    $0xd,%al
 547:	74 17                	je     560 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 549:	8d 5e 01             	lea    0x1(%esi),%ebx
 54c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 54f:	7c cf                	jl     520 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 551:	8b 45 08             	mov    0x8(%ebp),%eax
 554:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 558:	8d 65 f4             	lea    -0xc(%ebp),%esp
 55b:	5b                   	pop    %ebx
 55c:	5e                   	pop    %esi
 55d:	5f                   	pop    %edi
 55e:	5d                   	pop    %ebp
 55f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 560:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 563:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 565:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 569:	8d 65 f4             	lea    -0xc(%ebp),%esp
 56c:	5b                   	pop    %ebx
 56d:	5e                   	pop    %esi
 56e:	5f                   	pop    %edi
 56f:	5d                   	pop    %ebp
 570:	c3                   	ret    
 571:	eb 0d                	jmp    580 <stat>
 573:	90                   	nop
 574:	90                   	nop
 575:	90                   	nop
 576:	90                   	nop
 577:	90                   	nop
 578:	90                   	nop
 579:	90                   	nop
 57a:	90                   	nop
 57b:	90                   	nop
 57c:	90                   	nop
 57d:	90                   	nop
 57e:	90                   	nop
 57f:	90                   	nop

00000580 <stat>:

int
stat(char *n, struct stat *st)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	56                   	push   %esi
 584:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 585:	83 ec 08             	sub    $0x8,%esp
 588:	6a 00                	push   $0x0
 58a:	ff 75 08             	pushl  0x8(%ebp)
 58d:	e8 f0 00 00 00       	call   682 <open>
  if(fd < 0)
 592:	83 c4 10             	add    $0x10,%esp
 595:	85 c0                	test   %eax,%eax
 597:	78 27                	js     5c0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 599:	83 ec 08             	sub    $0x8,%esp
 59c:	ff 75 0c             	pushl  0xc(%ebp)
 59f:	89 c3                	mov    %eax,%ebx
 5a1:	50                   	push   %eax
 5a2:	e8 f3 00 00 00       	call   69a <fstat>
 5a7:	89 c6                	mov    %eax,%esi
  close(fd);
 5a9:	89 1c 24             	mov    %ebx,(%esp)
 5ac:	e8 b9 00 00 00       	call   66a <close>
  return r;
 5b1:	83 c4 10             	add    $0x10,%esp
 5b4:	89 f0                	mov    %esi,%eax
}
 5b6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 5b9:	5b                   	pop    %ebx
 5ba:	5e                   	pop    %esi
 5bb:	5d                   	pop    %ebp
 5bc:	c3                   	ret    
 5bd:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 5c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 5c5:	eb ef                	jmp    5b6 <stat+0x36>
 5c7:	89 f6                	mov    %esi,%esi
 5c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005d0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 5d0:	55                   	push   %ebp
 5d1:	89 e5                	mov    %esp,%ebp
 5d3:	53                   	push   %ebx
 5d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 5d7:	0f be 11             	movsbl (%ecx),%edx
 5da:	8d 42 d0             	lea    -0x30(%edx),%eax
 5dd:	3c 09                	cmp    $0x9,%al
 5df:	b8 00 00 00 00       	mov    $0x0,%eax
 5e4:	77 1f                	ja     605 <atoi+0x35>
 5e6:	8d 76 00             	lea    0x0(%esi),%esi
 5e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 5f0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 5f3:	83 c1 01             	add    $0x1,%ecx
 5f6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 5fa:	0f be 11             	movsbl (%ecx),%edx
 5fd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 600:	80 fb 09             	cmp    $0x9,%bl
 603:	76 eb                	jbe    5f0 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 605:	5b                   	pop    %ebx
 606:	5d                   	pop    %ebp
 607:	c3                   	ret    
 608:	90                   	nop
 609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000610 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 610:	55                   	push   %ebp
 611:	89 e5                	mov    %esp,%ebp
 613:	56                   	push   %esi
 614:	53                   	push   %ebx
 615:	8b 5d 10             	mov    0x10(%ebp),%ebx
 618:	8b 45 08             	mov    0x8(%ebp),%eax
 61b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 61e:	85 db                	test   %ebx,%ebx
 620:	7e 14                	jle    636 <memmove+0x26>
 622:	31 d2                	xor    %edx,%edx
 624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 628:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 62c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 62f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 632:	39 da                	cmp    %ebx,%edx
 634:	75 f2                	jne    628 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 636:	5b                   	pop    %ebx
 637:	5e                   	pop    %esi
 638:	5d                   	pop    %ebp
 639:	c3                   	ret    

0000063a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 63a:	b8 01 00 00 00       	mov    $0x1,%eax
 63f:	cd 40                	int    $0x40
 641:	c3                   	ret    

00000642 <exit>:
SYSCALL(exit)
 642:	b8 02 00 00 00       	mov    $0x2,%eax
 647:	cd 40                	int    $0x40
 649:	c3                   	ret    

0000064a <wait>:
SYSCALL(wait)
 64a:	b8 03 00 00 00       	mov    $0x3,%eax
 64f:	cd 40                	int    $0x40
 651:	c3                   	ret    

00000652 <pipe>:
SYSCALL(pipe)
 652:	b8 04 00 00 00       	mov    $0x4,%eax
 657:	cd 40                	int    $0x40
 659:	c3                   	ret    

0000065a <read>:
SYSCALL(read)
 65a:	b8 05 00 00 00       	mov    $0x5,%eax
 65f:	cd 40                	int    $0x40
 661:	c3                   	ret    

00000662 <write>:
SYSCALL(write)
 662:	b8 10 00 00 00       	mov    $0x10,%eax
 667:	cd 40                	int    $0x40
 669:	c3                   	ret    

0000066a <close>:
SYSCALL(close)
 66a:	b8 15 00 00 00       	mov    $0x15,%eax
 66f:	cd 40                	int    $0x40
 671:	c3                   	ret    

00000672 <kill>:
SYSCALL(kill)
 672:	b8 06 00 00 00       	mov    $0x6,%eax
 677:	cd 40                	int    $0x40
 679:	c3                   	ret    

0000067a <exec>:
SYSCALL(exec)
 67a:	b8 07 00 00 00       	mov    $0x7,%eax
 67f:	cd 40                	int    $0x40
 681:	c3                   	ret    

00000682 <open>:
SYSCALL(open)
 682:	b8 0f 00 00 00       	mov    $0xf,%eax
 687:	cd 40                	int    $0x40
 689:	c3                   	ret    

0000068a <mknod>:
SYSCALL(mknod)
 68a:	b8 11 00 00 00       	mov    $0x11,%eax
 68f:	cd 40                	int    $0x40
 691:	c3                   	ret    

00000692 <unlink>:
SYSCALL(unlink)
 692:	b8 12 00 00 00       	mov    $0x12,%eax
 697:	cd 40                	int    $0x40
 699:	c3                   	ret    

0000069a <fstat>:
SYSCALL(fstat)
 69a:	b8 08 00 00 00       	mov    $0x8,%eax
 69f:	cd 40                	int    $0x40
 6a1:	c3                   	ret    

000006a2 <link>:
SYSCALL(link)
 6a2:	b8 13 00 00 00       	mov    $0x13,%eax
 6a7:	cd 40                	int    $0x40
 6a9:	c3                   	ret    

000006aa <mkdir>:
SYSCALL(mkdir)
 6aa:	b8 14 00 00 00       	mov    $0x14,%eax
 6af:	cd 40                	int    $0x40
 6b1:	c3                   	ret    

000006b2 <chdir>:
SYSCALL(chdir)
 6b2:	b8 09 00 00 00       	mov    $0x9,%eax
 6b7:	cd 40                	int    $0x40
 6b9:	c3                   	ret    

000006ba <dup>:
SYSCALL(dup)
 6ba:	b8 0a 00 00 00       	mov    $0xa,%eax
 6bf:	cd 40                	int    $0x40
 6c1:	c3                   	ret    

000006c2 <getpid>:
SYSCALL(getpid)
 6c2:	b8 0b 00 00 00       	mov    $0xb,%eax
 6c7:	cd 40                	int    $0x40
 6c9:	c3                   	ret    

000006ca <sbrk>:
SYSCALL(sbrk)
 6ca:	b8 0c 00 00 00       	mov    $0xc,%eax
 6cf:	cd 40                	int    $0x40
 6d1:	c3                   	ret    

000006d2 <sleep>:
SYSCALL(sleep)
 6d2:	b8 0d 00 00 00       	mov    $0xd,%eax
 6d7:	cd 40                	int    $0x40
 6d9:	c3                   	ret    

000006da <uptime>:
SYSCALL(uptime)
 6da:	b8 0e 00 00 00       	mov    $0xe,%eax
 6df:	cd 40                	int    $0x40
 6e1:	c3                   	ret    

000006e2 <captsc>:
SYSCALL(captsc)
 6e2:	b8 16 00 00 00       	mov    $0x16,%eax
 6e7:	cd 40                	int    $0x40
 6e9:	c3                   	ret    

000006ea <freesc>:
SYSCALL(freesc)
 6ea:	b8 17 00 00 00       	mov    $0x17,%eax
 6ef:	cd 40                	int    $0x40
 6f1:	c3                   	ret    

000006f2 <updatesc>:
SYSCALL(updatesc)
 6f2:	b8 18 00 00 00       	mov    $0x18,%eax
 6f7:	cd 40                	int    $0x40
 6f9:	c3                   	ret    

000006fa <getkey>:
SYSCALL(getkey)
 6fa:	b8 19 00 00 00       	mov    $0x19,%eax
 6ff:	cd 40                	int    $0x40
 701:	c3                   	ret    
 702:	66 90                	xchg   %ax,%ax
 704:	66 90                	xchg   %ax,%ax
 706:	66 90                	xchg   %ax,%ax
 708:	66 90                	xchg   %ax,%ax
 70a:	66 90                	xchg   %ax,%ax
 70c:	66 90                	xchg   %ax,%ax
 70e:	66 90                	xchg   %ax,%ax

00000710 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 710:	55                   	push   %ebp
 711:	89 e5                	mov    %esp,%ebp
 713:	57                   	push   %edi
 714:	56                   	push   %esi
 715:	53                   	push   %ebx
 716:	89 c6                	mov    %eax,%esi
 718:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 71b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 71e:	85 db                	test   %ebx,%ebx
 720:	74 7e                	je     7a0 <printint+0x90>
 722:	89 d0                	mov    %edx,%eax
 724:	c1 e8 1f             	shr    $0x1f,%eax
 727:	84 c0                	test   %al,%al
 729:	74 75                	je     7a0 <printint+0x90>
    neg = 1;
    x = -xx;
 72b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 72d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 734:	f7 d8                	neg    %eax
 736:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 739:	31 ff                	xor    %edi,%edi
 73b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 73e:	89 ce                	mov    %ecx,%esi
 740:	eb 08                	jmp    74a <printint+0x3a>
 742:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 748:	89 cf                	mov    %ecx,%edi
 74a:	31 d2                	xor    %edx,%edx
 74c:	8d 4f 01             	lea    0x1(%edi),%ecx
 74f:	f7 f6                	div    %esi
 751:	0f b6 92 b0 0b 00 00 	movzbl 0xbb0(%edx),%edx
  }while((x /= base) != 0);
 758:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 75a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 75d:	75 e9                	jne    748 <printint+0x38>
  if(neg)
 75f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 762:	8b 75 c0             	mov    -0x40(%ebp),%esi
 765:	85 c0                	test   %eax,%eax
 767:	74 08                	je     771 <printint+0x61>
    buf[i++] = '-';
 769:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 76e:	8d 4f 02             	lea    0x2(%edi),%ecx
 771:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 775:	8d 76 00             	lea    0x0(%esi),%esi
 778:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 77b:	83 ec 04             	sub    $0x4,%esp
 77e:	83 ef 01             	sub    $0x1,%edi
 781:	6a 01                	push   $0x1
 783:	53                   	push   %ebx
 784:	56                   	push   %esi
 785:	88 45 d7             	mov    %al,-0x29(%ebp)
 788:	e8 d5 fe ff ff       	call   662 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 78d:	83 c4 10             	add    $0x10,%esp
 790:	39 df                	cmp    %ebx,%edi
 792:	75 e4                	jne    778 <printint+0x68>
    putc(fd, buf[i]);
}
 794:	8d 65 f4             	lea    -0xc(%ebp),%esp
 797:	5b                   	pop    %ebx
 798:	5e                   	pop    %esi
 799:	5f                   	pop    %edi
 79a:	5d                   	pop    %ebp
 79b:	c3                   	ret    
 79c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 7a0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 7a2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 7a9:	eb 8b                	jmp    736 <printint+0x26>
 7ab:	90                   	nop
 7ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000007b0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 7b0:	55                   	push   %ebp
 7b1:	89 e5                	mov    %esp,%ebp
 7b3:	57                   	push   %edi
 7b4:	56                   	push   %esi
 7b5:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7b6:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 7b9:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7bc:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 7bf:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7c2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 7c5:	0f b6 1e             	movzbl (%esi),%ebx
 7c8:	83 c6 01             	add    $0x1,%esi
 7cb:	84 db                	test   %bl,%bl
 7cd:	0f 84 b0 00 00 00    	je     883 <printf+0xd3>
 7d3:	31 d2                	xor    %edx,%edx
 7d5:	eb 39                	jmp    810 <printf+0x60>
 7d7:	89 f6                	mov    %esi,%esi
 7d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 7e0:	83 f8 25             	cmp    $0x25,%eax
 7e3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 7e6:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 7eb:	74 18                	je     805 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7ed:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 7f0:	83 ec 04             	sub    $0x4,%esp
 7f3:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 7f6:	6a 01                	push   $0x1
 7f8:	50                   	push   %eax
 7f9:	57                   	push   %edi
 7fa:	e8 63 fe ff ff       	call   662 <write>
 7ff:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 802:	83 c4 10             	add    $0x10,%esp
 805:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 808:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 80c:	84 db                	test   %bl,%bl
 80e:	74 73                	je     883 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 810:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 812:	0f be cb             	movsbl %bl,%ecx
 815:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 818:	74 c6                	je     7e0 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 81a:	83 fa 25             	cmp    $0x25,%edx
 81d:	75 e6                	jne    805 <printf+0x55>
      if(c == 'd'){
 81f:	83 f8 64             	cmp    $0x64,%eax
 822:	0f 84 f8 00 00 00    	je     920 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 828:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 82e:	83 f9 70             	cmp    $0x70,%ecx
 831:	74 5d                	je     890 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 833:	83 f8 73             	cmp    $0x73,%eax
 836:	0f 84 84 00 00 00    	je     8c0 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 83c:	83 f8 63             	cmp    $0x63,%eax
 83f:	0f 84 ea 00 00 00    	je     92f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 845:	83 f8 25             	cmp    $0x25,%eax
 848:	0f 84 c2 00 00 00    	je     910 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 84e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 851:	83 ec 04             	sub    $0x4,%esp
 854:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 858:	6a 01                	push   $0x1
 85a:	50                   	push   %eax
 85b:	57                   	push   %edi
 85c:	e8 01 fe ff ff       	call   662 <write>
 861:	83 c4 0c             	add    $0xc,%esp
 864:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 867:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 86a:	6a 01                	push   $0x1
 86c:	50                   	push   %eax
 86d:	57                   	push   %edi
 86e:	83 c6 01             	add    $0x1,%esi
 871:	e8 ec fd ff ff       	call   662 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 876:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 87a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 87d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 87f:	84 db                	test   %bl,%bl
 881:	75 8d                	jne    810 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 883:	8d 65 f4             	lea    -0xc(%ebp),%esp
 886:	5b                   	pop    %ebx
 887:	5e                   	pop    %esi
 888:	5f                   	pop    %edi
 889:	5d                   	pop    %ebp
 88a:	c3                   	ret    
 88b:	90                   	nop
 88c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 890:	83 ec 0c             	sub    $0xc,%esp
 893:	b9 10 00 00 00       	mov    $0x10,%ecx
 898:	6a 00                	push   $0x0
 89a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 89d:	89 f8                	mov    %edi,%eax
 89f:	8b 13                	mov    (%ebx),%edx
 8a1:	e8 6a fe ff ff       	call   710 <printint>
        ap++;
 8a6:	89 d8                	mov    %ebx,%eax
 8a8:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8ab:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 8ad:	83 c0 04             	add    $0x4,%eax
 8b0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 8b3:	e9 4d ff ff ff       	jmp    805 <printf+0x55>
 8b8:	90                   	nop
 8b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 8c0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 8c3:	8b 18                	mov    (%eax),%ebx
        ap++;
 8c5:	83 c0 04             	add    $0x4,%eax
 8c8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 8cb:	b8 a8 0b 00 00       	mov    $0xba8,%eax
 8d0:	85 db                	test   %ebx,%ebx
 8d2:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 8d5:	0f b6 03             	movzbl (%ebx),%eax
 8d8:	84 c0                	test   %al,%al
 8da:	74 23                	je     8ff <printf+0x14f>
 8dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 8e0:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8e3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 8e6:	83 ec 04             	sub    $0x4,%esp
 8e9:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 8eb:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8ee:	50                   	push   %eax
 8ef:	57                   	push   %edi
 8f0:	e8 6d fd ff ff       	call   662 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 8f5:	0f b6 03             	movzbl (%ebx),%eax
 8f8:	83 c4 10             	add    $0x10,%esp
 8fb:	84 c0                	test   %al,%al
 8fd:	75 e1                	jne    8e0 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8ff:	31 d2                	xor    %edx,%edx
 901:	e9 ff fe ff ff       	jmp    805 <printf+0x55>
 906:	8d 76 00             	lea    0x0(%esi),%esi
 909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 910:	83 ec 04             	sub    $0x4,%esp
 913:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 916:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 919:	6a 01                	push   $0x1
 91b:	e9 4c ff ff ff       	jmp    86c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 920:	83 ec 0c             	sub    $0xc,%esp
 923:	b9 0a 00 00 00       	mov    $0xa,%ecx
 928:	6a 01                	push   $0x1
 92a:	e9 6b ff ff ff       	jmp    89a <printf+0xea>
 92f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 932:	83 ec 04             	sub    $0x4,%esp
 935:	8b 03                	mov    (%ebx),%eax
 937:	6a 01                	push   $0x1
 939:	88 45 e4             	mov    %al,-0x1c(%ebp)
 93c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 93f:	50                   	push   %eax
 940:	57                   	push   %edi
 941:	e8 1c fd ff ff       	call   662 <write>
 946:	e9 5b ff ff ff       	jmp    8a6 <printf+0xf6>
 94b:	66 90                	xchg   %ax,%ax
 94d:	66 90                	xchg   %ax,%ax
 94f:	90                   	nop

00000950 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 950:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 951:	a1 28 0f 00 00       	mov    0xf28,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 956:	89 e5                	mov    %esp,%ebp
 958:	57                   	push   %edi
 959:	56                   	push   %esi
 95a:	53                   	push   %ebx
 95b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 95e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 960:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 963:	39 c8                	cmp    %ecx,%eax
 965:	73 19                	jae    980 <free+0x30>
 967:	89 f6                	mov    %esi,%esi
 969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 970:	39 d1                	cmp    %edx,%ecx
 972:	72 1c                	jb     990 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 974:	39 d0                	cmp    %edx,%eax
 976:	73 18                	jae    990 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 978:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 97a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 97c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 97e:	72 f0                	jb     970 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 980:	39 d0                	cmp    %edx,%eax
 982:	72 f4                	jb     978 <free+0x28>
 984:	39 d1                	cmp    %edx,%ecx
 986:	73 f0                	jae    978 <free+0x28>
 988:	90                   	nop
 989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 990:	8b 73 fc             	mov    -0x4(%ebx),%esi
 993:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 996:	39 d7                	cmp    %edx,%edi
 998:	74 19                	je     9b3 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 99a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 99d:	8b 50 04             	mov    0x4(%eax),%edx
 9a0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 9a3:	39 f1                	cmp    %esi,%ecx
 9a5:	74 23                	je     9ca <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 9a7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 9a9:	a3 28 0f 00 00       	mov    %eax,0xf28
}
 9ae:	5b                   	pop    %ebx
 9af:	5e                   	pop    %esi
 9b0:	5f                   	pop    %edi
 9b1:	5d                   	pop    %ebp
 9b2:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9b3:	03 72 04             	add    0x4(%edx),%esi
 9b6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 9b9:	8b 10                	mov    (%eax),%edx
 9bb:	8b 12                	mov    (%edx),%edx
 9bd:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 9c0:	8b 50 04             	mov    0x4(%eax),%edx
 9c3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 9c6:	39 f1                	cmp    %esi,%ecx
 9c8:	75 dd                	jne    9a7 <free+0x57>
    p->s.size += bp->s.size;
 9ca:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 9cd:	a3 28 0f 00 00       	mov    %eax,0xf28
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9d2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 9d5:	8b 53 f8             	mov    -0x8(%ebx),%edx
 9d8:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 9da:	5b                   	pop    %ebx
 9db:	5e                   	pop    %esi
 9dc:	5f                   	pop    %edi
 9dd:	5d                   	pop    %ebp
 9de:	c3                   	ret    
 9df:	90                   	nop

000009e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9e0:	55                   	push   %ebp
 9e1:	89 e5                	mov    %esp,%ebp
 9e3:	57                   	push   %edi
 9e4:	56                   	push   %esi
 9e5:	53                   	push   %ebx
 9e6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 9ec:	8b 15 28 0f 00 00    	mov    0xf28,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9f2:	8d 78 07             	lea    0x7(%eax),%edi
 9f5:	c1 ef 03             	shr    $0x3,%edi
 9f8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 9fb:	85 d2                	test   %edx,%edx
 9fd:	0f 84 a3 00 00 00    	je     aa6 <malloc+0xc6>
 a03:	8b 02                	mov    (%edx),%eax
 a05:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 a08:	39 cf                	cmp    %ecx,%edi
 a0a:	76 74                	jbe    a80 <malloc+0xa0>
 a0c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 a12:	be 00 10 00 00       	mov    $0x1000,%esi
 a17:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 a1e:	0f 43 f7             	cmovae %edi,%esi
 a21:	ba 00 80 00 00       	mov    $0x8000,%edx
 a26:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 a2c:	0f 46 da             	cmovbe %edx,%ebx
 a2f:	eb 10                	jmp    a41 <malloc+0x61>
 a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a38:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a3a:	8b 48 04             	mov    0x4(%eax),%ecx
 a3d:	39 cf                	cmp    %ecx,%edi
 a3f:	76 3f                	jbe    a80 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a41:	39 05 28 0f 00 00    	cmp    %eax,0xf28
 a47:	89 c2                	mov    %eax,%edx
 a49:	75 ed                	jne    a38 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 a4b:	83 ec 0c             	sub    $0xc,%esp
 a4e:	53                   	push   %ebx
 a4f:	e8 76 fc ff ff       	call   6ca <sbrk>
  if(p == (char*)-1)
 a54:	83 c4 10             	add    $0x10,%esp
 a57:	83 f8 ff             	cmp    $0xffffffff,%eax
 a5a:	74 1c                	je     a78 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 a5c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 a5f:	83 ec 0c             	sub    $0xc,%esp
 a62:	83 c0 08             	add    $0x8,%eax
 a65:	50                   	push   %eax
 a66:	e8 e5 fe ff ff       	call   950 <free>
  return freep;
 a6b:	8b 15 28 0f 00 00    	mov    0xf28,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 a71:	83 c4 10             	add    $0x10,%esp
 a74:	85 d2                	test   %edx,%edx
 a76:	75 c0                	jne    a38 <malloc+0x58>
        return 0;
 a78:	31 c0                	xor    %eax,%eax
 a7a:	eb 1c                	jmp    a98 <malloc+0xb8>
 a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 a80:	39 cf                	cmp    %ecx,%edi
 a82:	74 1c                	je     aa0 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 a84:	29 f9                	sub    %edi,%ecx
 a86:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 a89:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 a8c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 a8f:	89 15 28 0f 00 00    	mov    %edx,0xf28
      return (void*)(p + 1);
 a95:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a98:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a9b:	5b                   	pop    %ebx
 a9c:	5e                   	pop    %esi
 a9d:	5f                   	pop    %edi
 a9e:	5d                   	pop    %ebp
 a9f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 aa0:	8b 08                	mov    (%eax),%ecx
 aa2:	89 0a                	mov    %ecx,(%edx)
 aa4:	eb e9                	jmp    a8f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 aa6:	c7 05 28 0f 00 00 2c 	movl   $0xf2c,0xf28
 aad:	0f 00 00 
 ab0:	c7 05 2c 0f 00 00 2c 	movl   $0xf2c,0xf2c
 ab7:	0f 00 00 
    base.s.size = 0;
 aba:	b8 2c 0f 00 00       	mov    $0xf2c,%eax
 abf:	c7 05 30 0f 00 00 00 	movl   $0x0,0xf30
 ac6:	00 00 00 
 ac9:	e9 3e ff ff ff       	jmp    a0c <malloc+0x2c>
