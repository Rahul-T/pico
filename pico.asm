
_pico:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
	}
	updateCursor(prevChar, currChar);
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
      18:	68 20 17 00 00       	push   $0x1720
      1d:	e8 20 0d 00 00       	call   d42 <captsc>
	drawHeader();
      22:	e8 e9 02 00 00       	call   310 <drawHeader>
	updatesc(50, 0, "                         v0.1 ", UI_COLOR);
}

void
drawFooter() {
	updatesc(0, 24, " ^Q - Quit                                                                      ", UI_COLOR);
      27:	68 c0 00 00 00       	push   $0xc0
      2c:	68 c4 11 00 00       	push   $0x11c4
      31:	6a 18                	push   $0x18
      33:	6a 00                	push   $0x0
      35:	e8 18 0d 00 00       	call   d52 <updatesc>
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
      45:	68 73 11 00 00       	push   $0x1173
      4a:	6a 01                	push   $0x1
      4c:	e8 bf 0d 00 00       	call   e10 <printf>
      51:	83 c4 10             	add    $0x10,%esp
      54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	}
	while(1) {
		while ((c = getkey()) <= 0) {
      58:	e8 fd 0c 00 00       	call   d5a <getkey>
      5d:	85 c0                	test   %eax,%eax
      5f:	a3 20 17 00 00       	mov    %eax,0x1720
      64:	7e f2                	jle    58 <main+0x58>
		}
		handleInput(c);
      66:	83 ec 0c             	sub    $0xc,%esp
      69:	50                   	push   %eax
      6a:	e8 71 08 00 00       	call   8e0 <handleInput>
		c = 0;
      6f:	c7 05 20 17 00 00 00 	movl   $0x0,0x1720
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
      86:	e8 57 0c 00 00       	call   ce2 <open>
      8b:	83 c4 10             	add    $0x10,%esp
      8e:	85 c0                	test   %eax,%eax
      90:	78 1a                	js     ac <main+0xac>
			printf(1, "Cannot open %s\n", argv[1]);
		} else {
			initLinkedList(fd);
      92:	83 ec 0c             	sub    $0xc,%esp
      95:	50                   	push   %eax
      96:	e8 85 00 00 00       	call   120 <initLinkedList>
			printfile(head);
      9b:	58                   	pop    %eax
      9c:	ff 35 48 17 00 00    	pushl  0x1748
      a2:	e8 99 01 00 00       	call   240 <printfile>
      a7:	83 c4 10             	add    $0x10,%esp
      aa:	eb ac                	jmp    58 <main+0x58>
	drawFooter();
	int fd;

	if (argc == 2) {
		if((fd = open(argv[1], 0)) < 0){
			printf(1, "Cannot open %s\n", argv[1]);
      ac:	83 ec 04             	sub    $0x4,%esp
      af:	ff 73 04             	pushl  0x4(%ebx)
      b2:	68 63 11 00 00       	push   $0x1163
      b7:	6a 01                	push   $0x1
      b9:	e8 52 0d 00 00       	call   e10 <printf>
      be:	83 c4 10             	add    $0x10,%esp
      c1:	eb 95                	jmp    58 <main+0x58>
      c3:	66 90                	xchg   %ax,%ax
      c5:	66 90                	xchg   %ax,%ax
      c7:	66 90                	xchg   %ax,%ax
      c9:	66 90                	xchg   %ax,%ax
      cb:	66 90                	xchg   %ax,%ax
      cd:	66 90                	xchg   %ax,%ax
      cf:	90                   	nop

000000d0 <updateCursor.part.0>:
	printfile(firstOnScreen->prev);
	firstOnScreen = firstOnScreen->prev;
}

void
updateCursor(int prev, int curr) {
      d0:	55                   	push   %ebp
      d1:	89 e5                	mov    %esp,%ebp
      d3:	56                   	push   %esi
      d4:	53                   	push   %ebx
	if (prev == curr)
		return;
	char firstUpdate[2];
	firstUpdate[1] = 0;
	firstUpdate[0] = buf[prev];
	updatesc(prev, 1, firstUpdate, TEXT_COLOR);
      d5:	8d 75 f6             	lea    -0xa(%ebp),%esi
	printfile(firstOnScreen->prev);
	firstOnScreen = firstOnScreen->prev;
}

void
updateCursor(int prev, int curr) {
      d8:	89 d3                	mov    %edx,%ebx
      da:	83 ec 10             	sub    $0x10,%esp
	if (prev == curr)
		return;
	char firstUpdate[2];
	firstUpdate[1] = 0;
	firstUpdate[0] = buf[prev];
      dd:	0f b6 90 60 17 00 00 	movzbl 0x1760(%eax),%edx
void
updateCursor(int prev, int curr) {
	if (prev == curr)
		return;
	char firstUpdate[2];
	firstUpdate[1] = 0;
      e4:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
	firstUpdate[0] = buf[prev];
	updatesc(prev, 1, firstUpdate, TEXT_COLOR);
      e8:	6a 07                	push   $0x7
      ea:	56                   	push   %esi
      eb:	6a 01                	push   $0x1
      ed:	50                   	push   %eax
updateCursor(int prev, int curr) {
	if (prev == curr)
		return;
	char firstUpdate[2];
	firstUpdate[1] = 0;
	firstUpdate[0] = buf[prev];
      ee:	88 55 f6             	mov    %dl,-0xa(%ebp)
	updatesc(prev, 1, firstUpdate, TEXT_COLOR);
      f1:	e8 5c 0c 00 00       	call   d52 <updatesc>
	firstUpdate[0] = buf[curr];
      f6:	0f b6 83 60 17 00 00 	movzbl 0x1760(%ebx),%eax
	updatesc(curr, 1, firstUpdate, CURSOR_COLOR);
      fd:	6a 70                	push   $0x70
      ff:	56                   	push   %esi
     100:	6a 01                	push   $0x1
     102:	53                   	push   %ebx
		return;
	char firstUpdate[2];
	firstUpdate[1] = 0;
	firstUpdate[0] = buf[prev];
	updatesc(prev, 1, firstUpdate, TEXT_COLOR);
	firstUpdate[0] = buf[curr];
     103:	88 45 f6             	mov    %al,-0xa(%ebp)
	updatesc(curr, 1, firstUpdate, CURSOR_COLOR);
     106:	e8 47 0c 00 00       	call   d52 <updatesc>
     10b:	83 c4 20             	add    $0x20,%esp
}
     10e:	8d 65 f8             	lea    -0x8(%ebp),%esp
     111:	5b                   	pop    %ebx
     112:	5e                   	pop    %esi
     113:	5d                   	pop    %ebp
     114:	c3                   	ret    
     115:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000120 <initLinkedList>:
struct fileline* lastOnScreen;
//struct fileline* tail;

void
initLinkedList(int fd)
{
     120:	55                   	push   %ebp
     121:	89 e5                	mov    %esp,%ebp
     123:	57                   	push   %edi
     124:	56                   	push   %esi
     125:	53                   	push   %ebx
     126:	8d 75 e7             	lea    -0x19(%ebp),%esi
	int n;
	char singlechar[1];
	head = malloc(sizeof(struct fileline));
	struct fileline* cur = head;
	int linecounter = 0;
     129:	31 ff                	xor    %edi,%edi
struct fileline* lastOnScreen;
//struct fileline* tail;

void
initLinkedList(int fd)
{
     12b:	83 ec 38             	sub    $0x38,%esp
	int n;
	char singlechar[1];
	head = malloc(sizeof(struct fileline));
     12e:	6a 5c                	push   $0x5c
     130:	e8 0b 0f 00 00       	call   1040 <malloc>
	struct fileline* cur = head;
	int linecounter = 0;
	int linenumber = 0;

	while((n = read(fd, singlechar, 1)) > 0) {
     135:	83 c4 10             	add    $0x10,%esp
void
initLinkedList(int fd)
{
	int n;
	char singlechar[1];
	head = malloc(sizeof(struct fileline));
     138:	89 c3                	mov    %eax,%ebx
     13a:	a3 48 17 00 00       	mov    %eax,0x1748
	struct fileline* cur = head;
	int linecounter = 0;
	int linenumber = 0;
     13f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     146:	8d 76 00             	lea    0x0(%esi),%esi
     149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

	while((n = read(fd, singlechar, 1)) > 0) {
     150:	83 ec 04             	sub    $0x4,%esp
     153:	6a 01                	push   $0x1
     155:	56                   	push   %esi
     156:	ff 75 08             	pushl  0x8(%ebp)
     159:	e8 5c 0b 00 00       	call   cba <read>
     15e:	83 c4 10             	add    $0x10,%esp
     161:	85 c0                	test   %eax,%eax
     163:	7e 5b                	jle    1c0 <initLinkedList+0xa0>
		if(linecounter < WIDTH){
     165:	83 ff 50             	cmp    $0x50,%edi
     168:	74 1e                	je     188 <initLinkedList+0x68>
			cur->line[linecounter] = singlechar[0];
     16a:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     16e:	88 44 3b 04          	mov    %al,0x4(%ebx,%edi,1)
			linecounter++;
     172:	83 c7 01             	add    $0x1,%edi
     175:	3c 0a                	cmp    $0xa,%al
     177:	b8 50 00 00 00       	mov    $0x50,%eax
     17c:	0f 44 f8             	cmove  %eax,%edi
     17f:	eb cf                	jmp    150 <initLinkedList+0x30>
     181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			if(singlechar[0] == '\n'){
				linecounter = WIDTH;
			}
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
     188:	83 ec 0c             	sub    $0xc,%esp
			nextline->prev = cur;
			cur->next = nextline;
			cur = nextline;
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
			linecounter++;
     18b:	bf 01 00 00 00       	mov    $0x1,%edi
			if(singlechar[0] == '\n'){
				linecounter = WIDTH;
			}
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
     190:	6a 5c                	push   $0x5c
     192:	e8 a9 0e 00 00       	call   1040 <malloc>
			cur->filelinenum = linenumber;
     197:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
			linecounter++;
			// int nmbr = (int)(cur->filelinenum);
			// printf(1, "linenum: %d\n", nmbr);
			linenumber++;
     19a:	83 c4 10             	add    $0x10,%esp
				linecounter = WIDTH;
			}
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
			cur->filelinenum = linenumber;
     19d:	89 0b                	mov    %ecx,(%ebx)
			nextline->prev = cur;
			cur->next = nextline;
			cur = nextline;
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
     19f:	0f b6 55 e7          	movzbl -0x19(%ebp),%edx
			linecounter++;
			// int nmbr = (int)(cur->filelinenum);
			// printf(1, "linenum: %d\n", nmbr);
			linenumber++;
     1a3:	83 c1 01             	add    $0x1,%ecx
			}
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
			cur->filelinenum = linenumber;
			nextline->prev = cur;
     1a6:	89 58 54             	mov    %ebx,0x54(%eax)
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
			linecounter++;
			// int nmbr = (int)(cur->filelinenum);
			// printf(1, "linenum: %d\n", nmbr);
			linenumber++;
     1a9:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
			cur->filelinenum = linenumber;
			nextline->prev = cur;
			cur->next = nextline;
     1ac:	89 43 58             	mov    %eax,0x58(%ebx)
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
			linecounter++;
			// int nmbr = (int)(cur->filelinenum);
			// printf(1, "linenum: %d\n", nmbr);
			linenumber++;
     1af:	89 c3                	mov    %eax,%ebx
			cur->filelinenum = linenumber;
			nextline->prev = cur;
			cur->next = nextline;
			cur = nextline;
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
     1b1:	88 50 04             	mov    %dl,0x4(%eax)
     1b4:	eb 9a                	jmp    150 <initLinkedList+0x30>
     1b6:	8d 76 00             	lea    0x0(%esi),%esi
     1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
			// printf(1, "linenum: %d\n", nmbr);
			linenumber++;
		}
	}

	cur->filelinenum = linenumber;
     1c0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     1c3:	89 03                	mov    %eax,(%ebx)
	linenumber++;
     1c5:	8d 78 01             	lea    0x1(%eax),%edi
	firstOnScreen = head;
     1c8:	a1 48 17 00 00       	mov    0x1748,%eax

	struct fileline* temp;

	if(linenumber < 23){
     1cd:	83 ff 16             	cmp    $0x16,%edi
		}
	}

	cur->filelinenum = linenumber;
	linenumber++;
	firstOnScreen = head;
     1d0:	a3 40 17 00 00       	mov    %eax,0x1740

	struct fileline* temp;

	if(linenumber < 23){
     1d5:	7e 09                	jle    1e0 <initLinkedList+0xc0>
	// 	printf(1, "%s", cur->line);
	// 	cur = cur->next;
	// }
	// printf(1, "%s", tail->line);

}
     1d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
     1da:	5b                   	pop    %ebx
     1db:	5e                   	pop    %esi
     1dc:	5f                   	pop    %edi
     1dd:	5d                   	pop    %ebp
     1de:	c3                   	ret    
     1df:	90                   	nop
	firstOnScreen = head;

	struct fileline* temp;

	if(linenumber < 23){
		temp = malloc(sizeof(struct fileline));
     1e0:	83 ec 0c             	sub    $0xc,%esp
     1e3:	6a 5c                	push   $0x5c
     1e5:	e8 56 0e 00 00       	call   1040 <malloc>
		cur->next = temp;
		temp->prev = cur;
     1ea:	83 c4 10             	add    $0x10,%esp

	struct fileline* temp;

	if(linenumber < 23){
		temp = malloc(sizeof(struct fileline));
		cur->next = temp;
     1ed:	89 43 58             	mov    %eax,0x58(%ebx)
	firstOnScreen = head;

	struct fileline* temp;

	if(linenumber < 23){
		temp = malloc(sizeof(struct fileline));
     1f0:	89 c6                	mov    %eax,%esi
		cur->next = temp;
		temp->prev = cur;
     1f2:	89 58 54             	mov    %ebx,0x54(%eax)
     1f5:	31 c0                	xor    %eax,%eax
     1f7:	eb 14                	jmp    20d <initLinkedList+0xed>
     1f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	}
	linecounter = 0;
	while(linenumber < 23){
		if(linecounter < WIDTH){
			temp->line[linecounter] = ' ';
     200:	c6 44 06 04 20       	movb   $0x20,0x4(%esi,%eax,1)
			linecounter++;
     205:	83 c0 01             	add    $0x1,%eax
		temp = malloc(sizeof(struct fileline));
		cur->next = temp;
		temp->prev = cur;
	}
	linecounter = 0;
	while(linenumber < 23){
     208:	83 ff 17             	cmp    $0x17,%edi
     20b:	74 ca                	je     1d7 <initLinkedList+0xb7>
		if(linecounter < WIDTH){
     20d:	83 f8 4f             	cmp    $0x4f,%eax
     210:	7e ee                	jle    200 <initLinkedList+0xe0>
			temp->line[linecounter] = ' ';
			linecounter++;
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
     212:	83 ec 0c             	sub    $0xc,%esp
     215:	6a 5c                	push   $0x5c
     217:	e8 24 0e 00 00       	call   1040 <malloc>
			temp->filelinenum = linenumber;
     21c:	89 3e                	mov    %edi,(%esi)
			linecounter = 0;
			temp->line[linecounter] = ' ';
			linecounter++;
			// int nmbr = (int)(cur->filelinenum);
			// printf(1, "linenum: %d\n", nmbr);
			linenumber++;
     21e:	83 c4 10             	add    $0x10,%esp
			linecounter++;
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
			temp->filelinenum = linenumber;
			nextline->prev = temp;
     221:	89 70 54             	mov    %esi,0x54(%eax)
			linecounter = 0;
			temp->line[linecounter] = ' ';
			linecounter++;
			// int nmbr = (int)(cur->filelinenum);
			// printf(1, "linenum: %d\n", nmbr);
			linenumber++;
     224:	83 c7 01             	add    $0x1,%edi
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
			temp->filelinenum = linenumber;
			nextline->prev = temp;
			temp->next = nextline;
     227:	89 46 58             	mov    %eax,0x58(%esi)
			temp = nextline;
			linecounter = 0;
			temp->line[linecounter] = ' ';
     22a:	c6 40 04 20          	movb   $0x20,0x4(%eax)
			linecounter++;
			// int nmbr = (int)(cur->filelinenum);
			// printf(1, "linenum: %d\n", nmbr);
			linenumber++;
     22e:	89 c6                	mov    %eax,%esi
			nextline->prev = temp;
			temp->next = nextline;
			temp = nextline;
			linecounter = 0;
			temp->line[linecounter] = ' ';
			linecounter++;
     230:	b8 01 00 00 00       	mov    $0x1,%eax
     235:	eb d1                	jmp    208 <initLinkedList+0xe8>
     237:	89 f6                	mov    %esi,%esi
     239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000240 <printfile>:

}

void
printfile(struct fileline* first)
{
     240:	55                   	push   %ebp
     241:	89 e5                	mov    %esp,%ebp
     243:	53                   	push   %ebx
	struct fileline* cur = first;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
     244:	31 db                	xor    %ebx,%ebx

}

void
printfile(struct fileline* first)
{
     246:	83 ec 04             	sub    $0x4,%esp
     249:	8b 4d 08             	mov    0x8(%ebp),%ecx
	struct fileline* cur = first;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
     24c:	8b 51 58             	mov    0x58(%ecx),%edx
     24f:	85 d2                	test   %edx,%edx
     251:	74 4a                	je     29d <printfile+0x5d>
     253:	90                   	nop
     254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     258:	31 c0                	xor    %eax,%eax
     25a:	eb 14                	jmp    270 <printfile+0x30>
     25c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		for(int i=0; i<WIDTH; i++){
			if(cur->line[i] == '\0'){
				buf[bufindex] = ' ';
     260:	c6 84 03 60 17 00 00 	movb   $0x20,0x1760(%ebx,%eax,1)
     267:	20 
printfile(struct fileline* first)
{
	struct fileline* cur = first;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
		for(int i=0; i<WIDTH; i++){
     268:	83 c0 01             	add    $0x1,%eax
     26b:	83 f8 50             	cmp    $0x50,%eax
     26e:	74 18                	je     288 <printfile+0x48>
			if(cur->line[i] == '\0'){
     270:	0f b6 54 01 04       	movzbl 0x4(%ecx,%eax,1),%edx
     275:	84 d2                	test   %dl,%dl
     277:	74 e7                	je     260 <printfile+0x20>
				buf[bufindex] = ' ';
			} else{
				buf[bufindex] = cur->line[i];
     279:	88 94 03 60 17 00 00 	mov    %dl,0x1760(%ebx,%eax,1)
printfile(struct fileline* first)
{
	struct fileline* cur = first;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
		for(int i=0; i<WIDTH; i++){
     280:	83 c0 01             	add    $0x1,%eax
     283:	83 f8 50             	cmp    $0x50,%eax
     286:	75 e8                	jne    270 <printfile+0x30>
			} else{
				buf[bufindex] = cur->line[i];
			}
			bufindex++;
		}
		cur = cur->next;
     288:	8b 49 58             	mov    0x58(%ecx),%ecx
     28b:	83 c3 50             	add    $0x50,%ebx
void
printfile(struct fileline* first)
{
	struct fileline* cur = first;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
     28e:	8b 41 58             	mov    0x58(%ecx),%eax
     291:	85 c0                	test   %eax,%eax
     293:	74 08                	je     29d <printfile+0x5d>
     295:	81 fb e0 06 00 00    	cmp    $0x6e0,%ebx
     29b:	75 bb                	jne    258 <printfile+0x18>

void
printfile(struct fileline* first)
{
	struct fileline* cur = first;
	int bufindex = 0;
     29d:	31 c0                	xor    %eax,%eax
     29f:	eb 17                	jmp    2b8 <printfile+0x78>
     2a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		}
		cur = cur->next;
	}
	for(int i=0; i<WIDTH; i++){
			if(cur->line[i] == '\0'){
				buf[bufindex] = ' ';
     2a8:	c6 84 03 60 17 00 00 	movb   $0x20,0x1760(%ebx,%eax,1)
     2af:	20 
			}
			bufindex++;
		}
		cur = cur->next;
	}
	for(int i=0; i<WIDTH; i++){
     2b0:	83 c0 01             	add    $0x1,%eax
     2b3:	83 f8 50             	cmp    $0x50,%eax
     2b6:	74 18                	je     2d0 <printfile+0x90>
			if(cur->line[i] == '\0'){
     2b8:	0f b6 54 01 04       	movzbl 0x4(%ecx,%eax,1),%edx
     2bd:	84 d2                	test   %dl,%dl
     2bf:	74 e7                	je     2a8 <printfile+0x68>
				buf[bufindex] = ' ';
			} else{
				buf[bufindex] = cur->line[i];
     2c1:	88 94 03 60 17 00 00 	mov    %dl,0x1760(%ebx,%eax,1)
			}
			bufindex++;
		}
		cur = cur->next;
	}
	for(int i=0; i<WIDTH; i++){
     2c8:	83 c0 01             	add    $0x1,%eax
     2cb:	83 f8 50             	cmp    $0x50,%eax
     2ce:	75 e8                	jne    2b8 <printfile+0x78>
			bufindex++;
	}
	lastOnScreen = cur;

	buf[bufindex] = '\0';
	printf(1, "asdfasdfdsf: %d", lastOnScreen->filelinenum);
     2d0:	83 ec 04             	sub    $0x4,%esp
			} else{
				buf[bufindex] = cur->line[i];
			}
			bufindex++;
	}
	lastOnScreen = cur;
     2d3:	89 0d 44 17 00 00    	mov    %ecx,0x1744

	buf[bufindex] = '\0';
     2d9:	c6 83 b0 17 00 00 00 	movb   $0x0,0x17b0(%ebx)
	printf(1, "asdfasdfdsf: %d", lastOnScreen->filelinenum);
     2e0:	ff 31                	pushl  (%ecx)
     2e2:	68 30 11 00 00       	push   $0x1130
     2e7:	6a 01                	push   $0x1
     2e9:	e8 22 0b 00 00       	call   e10 <printf>
	//printf(1, "%s\n", buf);
	updatesc(0, 1, buf, TEXT_COLOR);
     2ee:	6a 07                	push   $0x7
     2f0:	68 60 17 00 00       	push   $0x1760
     2f5:	6a 01                	push   $0x1
     2f7:	6a 00                	push   $0x0
     2f9:	e8 54 0a 00 00       	call   d52 <updatesc>
}
     2fe:	83 c4 20             	add    $0x20,%esp
     301:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     304:	c9                   	leave  
     305:	c3                   	ret    
     306:	8d 76 00             	lea    0x0(%esi),%esi
     309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000310 <drawHeader>:

void
drawHeader() {
     310:	55                   	push   %ebp
     311:	89 e5                	mov    %esp,%ebp
     313:	83 ec 08             	sub    $0x8,%esp
	updatesc(0, 0, "                              ", UI_COLOR);
     316:	68 c0 00 00 00       	push   $0xc0
     31b:	68 84 11 00 00       	push   $0x1184
     320:	6a 00                	push   $0x0
     322:	6a 00                	push   $0x0
     324:	e8 29 0a 00 00       	call   d52 <updatesc>
	updatesc(30, 0, "        PICO        ", UI_COLOR);
     329:	68 c0 00 00 00       	push   $0xc0
     32e:	68 40 11 00 00       	push   $0x1140
     333:	6a 00                	push   $0x0
     335:	6a 1e                	push   $0x1e
     337:	e8 16 0a 00 00       	call   d52 <updatesc>
	updatesc(50, 0, "                         v0.1 ", UI_COLOR);
     33c:	83 c4 20             	add    $0x20,%esp
     33f:	68 c0 00 00 00       	push   $0xc0
     344:	68 a4 11 00 00       	push   $0x11a4
     349:	6a 00                	push   $0x0
     34b:	6a 32                	push   $0x32
     34d:	e8 00 0a 00 00       	call   d52 <updatesc>
}
     352:	83 c4 10             	add    $0x10,%esp
     355:	c9                   	leave  
     356:	c3                   	ret    
     357:	89 f6                	mov    %esi,%esi
     359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000360 <drawFooter>:

void
drawFooter() {
     360:	55                   	push   %ebp
     361:	89 e5                	mov    %esp,%ebp
     363:	83 ec 08             	sub    $0x8,%esp
	updatesc(0, 24, " ^Q - Quit                                                                      ", UI_COLOR);
     366:	68 c0 00 00 00       	push   $0xc0
     36b:	68 c4 11 00 00       	push   $0x11c4
     370:	6a 18                	push   $0x18
     372:	6a 00                	push   $0x0
     374:	e8 d9 09 00 00       	call   d52 <updatesc>
}
     379:	83 c4 10             	add    $0x10,%esp
     37c:	c9                   	leave  
     37d:	c3                   	ret    
     37e:	66 90                	xchg   %ax,%ax

00000380 <saveedits>:

void
saveedits(void){
     380:	55                   	push   %ebp
	//Save edits
	struct fileline* cur = firstOnScreen;
     381:	8b 0d 40 17 00 00    	mov    0x1740,%ecx
drawFooter() {
	updatesc(0, 24, " ^Q - Quit                                                                      ", UI_COLOR);
}

void
saveedits(void){
     387:	89 e5                	mov    %esp,%ebp
     389:	56                   	push   %esi
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
     38a:	8b 35 44 17 00 00    	mov    0x1744,%esi
drawFooter() {
	updatesc(0, 24, " ^Q - Quit                                                                      ", UI_COLOR);
}

void
saveedits(void){
     390:	53                   	push   %ebx
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
     391:	3b 4e 58             	cmp    0x58(%esi),%ecx
     394:	74 31                	je     3c7 <saveedits+0x47>
     396:	31 db                	xor    %ebx,%ebx
     398:	90                   	nop
     399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     3a0:	31 c0                	xor    %eax,%eax
     3a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		for(int i=0; i<WIDTH; i++){
			cur->line[i] = buf[bufindex];
     3a8:	0f b6 94 03 60 17 00 	movzbl 0x1760(%ebx,%eax,1),%edx
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
     3ba:	75 ec                	jne    3a8 <saveedits+0x28>
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
     3c2:	39 4e 58             	cmp    %ecx,0x58(%esi)
     3c5:	75 d9                	jne    3a0 <saveedits+0x20>
			cur->line[i] = buf[bufindex];
			bufindex++;
		}
		cur = cur->next;
	}
}
     3c7:	5b                   	pop    %ebx
     3c8:	5e                   	pop    %esi
     3c9:	5d                   	pop    %ebp
     3ca:	c3                   	ret    
     3cb:	90                   	nop
     3cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003d0 <scrolldown>:

void
scrolldown(void){
     3d0:	55                   	push   %ebp
     3d1:	89 e5                	mov    %esp,%ebp
     3d3:	57                   	push   %edi
     3d4:	56                   	push   %esi
     3d5:	53                   	push   %ebx
     3d6:	31 db                	xor    %ebx,%ebx
     3d8:	83 ec 0c             	sub    $0xc,%esp
void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
     3db:	8b 35 44 17 00 00    	mov    0x1744,%esi
}

void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
     3e1:	8b 3d 40 17 00 00    	mov    0x1740,%edi
	int bufindex = 0;
	while(cur != lastOnScreen->next){
     3e7:	39 7e 58             	cmp    %edi,0x58(%esi)
     3ea:	89 f9                	mov    %edi,%ecx
     3ec:	74 29                	je     417 <scrolldown+0x47>
     3ee:	66 90                	xchg   %ax,%ax
     3f0:	31 c0                	xor    %eax,%eax
     3f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		for(int i=0; i<WIDTH; i++){
			cur->line[i] = buf[bufindex];
     3f8:	0f b6 94 03 60 17 00 	movzbl 0x1760(%ebx,%eax,1),%edx
     3ff:	00 
     400:	88 54 01 04          	mov    %dl,0x4(%ecx,%eax,1)
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
		for(int i=0; i<WIDTH; i++){
     404:	83 c0 01             	add    $0x1,%eax
     407:	83 f8 50             	cmp    $0x50,%eax
     40a:	75 ec                	jne    3f8 <scrolldown+0x28>
     40c:	83 c3 50             	add    $0x50,%ebx
			cur->line[i] = buf[bufindex];
			bufindex++;
		}
		cur = cur->next;
     40f:	8b 49 58             	mov    0x58(%ecx),%ecx
void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
     412:	3b 4e 58             	cmp    0x58(%esi),%ecx
     415:	75 d9                	jne    3f0 <scrolldown+0x20>
}

void
scrolldown(void){
	saveedits();
	printfile(firstOnScreen->next);
     417:	83 ec 0c             	sub    $0xc,%esp
     41a:	ff 77 58             	pushl  0x58(%edi)
     41d:	e8 1e fe ff ff       	call   240 <printfile>
	firstOnScreen = firstOnScreen->next;
     422:	a1 40 17 00 00       	mov    0x1740,%eax
     427:	8b 40 58             	mov    0x58(%eax),%eax
     42a:	a3 40 17 00 00       	mov    %eax,0x1740
}
     42f:	8d 65 f4             	lea    -0xc(%ebp),%esp
     432:	5b                   	pop    %ebx
     433:	5e                   	pop    %esi
     434:	5f                   	pop    %edi
     435:	5d                   	pop    %ebp
     436:	c3                   	ret    
     437:	89 f6                	mov    %esi,%esi
     439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000440 <scrollup>:

void
scrollup(void){
     440:	55                   	push   %ebp
     441:	89 e5                	mov    %esp,%ebp
     443:	57                   	push   %edi
     444:	56                   	push   %esi
     445:	53                   	push   %ebx
     446:	31 db                	xor    %ebx,%ebx
     448:	83 ec 0c             	sub    $0xc,%esp
void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
     44b:	8b 35 44 17 00 00    	mov    0x1744,%esi
}

void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
     451:	8b 3d 40 17 00 00    	mov    0x1740,%edi
	int bufindex = 0;
	while(cur != lastOnScreen->next){
     457:	39 7e 58             	cmp    %edi,0x58(%esi)
     45a:	89 f9                	mov    %edi,%ecx
     45c:	74 29                	je     487 <scrollup+0x47>
     45e:	66 90                	xchg   %ax,%ax
     460:	31 c0                	xor    %eax,%eax
     462:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		for(int i=0; i<WIDTH; i++){
			cur->line[i] = buf[bufindex];
     468:	0f b6 94 03 60 17 00 	movzbl 0x1760(%ebx,%eax,1),%edx
     46f:	00 
     470:	88 54 01 04          	mov    %dl,0x4(%ecx,%eax,1)
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
		for(int i=0; i<WIDTH; i++){
     474:	83 c0 01             	add    $0x1,%eax
     477:	83 f8 50             	cmp    $0x50,%eax
     47a:	75 ec                	jne    468 <scrollup+0x28>
     47c:	83 c3 50             	add    $0x50,%ebx
			cur->line[i] = buf[bufindex];
			bufindex++;
		}
		cur = cur->next;
     47f:	8b 49 58             	mov    0x58(%ecx),%ecx
void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
     482:	3b 4e 58             	cmp    0x58(%esi),%ecx
     485:	75 d9                	jne    460 <scrollup+0x20>
}

void
scrollup(void){
	saveedits();
	printfile(firstOnScreen->prev);
     487:	83 ec 0c             	sub    $0xc,%esp
     48a:	ff 77 54             	pushl  0x54(%edi)
     48d:	e8 ae fd ff ff       	call   240 <printfile>
	firstOnScreen = firstOnScreen->prev;
     492:	a1 40 17 00 00       	mov    0x1740,%eax
     497:	8b 40 54             	mov    0x54(%eax),%eax
     49a:	a3 40 17 00 00       	mov    %eax,0x1740
}
     49f:	8d 65 f4             	lea    -0xc(%ebp),%esp
     4a2:	5b                   	pop    %ebx
     4a3:	5e                   	pop    %esi
     4a4:	5f                   	pop    %edi
     4a5:	5d                   	pop    %ebp
     4a6:	c3                   	ret    
     4a7:	89 f6                	mov    %esi,%esi
     4a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004b0 <updateCursor>:

void
updateCursor(int prev, int curr) {
     4b0:	55                   	push   %ebp
     4b1:	89 e5                	mov    %esp,%ebp
     4b3:	8b 45 08             	mov    0x8(%ebp),%eax
     4b6:	8b 55 0c             	mov    0xc(%ebp),%edx
	if (prev == curr)
     4b9:	39 d0                	cmp    %edx,%eax
     4bb:	75 03                	jne    4c0 <updateCursor+0x10>
	firstUpdate[1] = 0;
	firstUpdate[0] = buf[prev];
	updatesc(prev, 1, firstUpdate, TEXT_COLOR);
	firstUpdate[0] = buf[curr];
	updatesc(curr, 1, firstUpdate, CURSOR_COLOR);
}
     4bd:	5d                   	pop    %ebp
     4be:	c3                   	ret    
     4bf:	90                   	nop
     4c0:	5d                   	pop    %ebp
     4c1:	e9 0a fc ff ff       	jmp    d0 <updateCursor.part.0>
     4c6:	8d 76 00             	lea    0x0(%esi),%esi
     4c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004d0 <arrowkeys>:

void
arrowkeys(int i){
     4d0:	55                   	push   %ebp
     4d1:	89 e5                	mov    %esp,%ebp
     4d3:	53                   	push   %ebx
     4d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
	//ctrl+j (go left)
	if((i == 10 || i == 228) && (currChar % WIDTH != 0) && currChar > 0){
     4d7:	83 f9 0a             	cmp    $0xa,%ecx
     4da:	74 44                	je     520 <arrowkeys+0x50>
     4dc:	81 f9 e4 00 00 00    	cmp    $0xe4,%ecx
     4e2:	74 3c                	je     520 <arrowkeys+0x50>
		currChar--;
	}
	//ctrl+l (go right)
	else if((i==12 || i == 229) && ((currChar+1) % WIDTH != 0)){
     4e4:	83 f9 0c             	cmp    $0xc,%ecx
     4e7:	74 6f                	je     558 <arrowkeys+0x88>
     4e9:	81 f9 e5 00 00 00    	cmp    $0xe5,%ecx
     4ef:	74 67                	je     558 <arrowkeys+0x88>
		currChar++;
	}
	//ctrl+k (go down)
	else if(i == 11 || i == 227){
     4f1:	83 f9 0b             	cmp    $0xb,%ecx
     4f4:	0f 84 96 00 00 00    	je     590 <arrowkeys+0xc0>
     4fa:	81 f9 e3 00 00 00    	cmp    $0xe3,%ecx
     500:	0f 84 8a 00 00 00    	je     590 <arrowkeys+0xc0>
			if(lastOnScreen->next != 0)
				scrolldown();
		}
	}
	//ctrl+i (go up)
	else if(i == 9 || i == 226){
     506:	83 f9 09             	cmp    $0x9,%ecx
     509:	0f 84 a9 00 00 00    	je     5b8 <arrowkeys+0xe8>
     50f:	81 f9 e2 00 00 00    	cmp    $0xe2,%ecx
     515:	0f 84 9d 00 00 00    	je     5b8 <arrowkeys+0xe8>
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
}
     51b:	5b                   	pop    %ebx
     51c:	5d                   	pop    %ebp
     51d:	c3                   	ret    
     51e:	66 90                	xchg   %ax,%ax
}

void
arrowkeys(int i){
	//ctrl+j (go left)
	if((i == 10 || i == 228) && (currChar % WIDTH != 0) && currChar > 0){
     520:	8b 1d 24 17 00 00    	mov    0x1724,%ebx
     526:	ba 67 66 66 66       	mov    $0x66666667,%edx
     52b:	89 d8                	mov    %ebx,%eax
     52d:	f7 ea                	imul   %edx
     52f:	89 d8                	mov    %ebx,%eax
     531:	c1 f8 1f             	sar    $0x1f,%eax
     534:	c1 fa 05             	sar    $0x5,%edx
     537:	29 c2                	sub    %eax,%edx
     539:	8d 04 92             	lea    (%edx,%edx,4),%eax
     53c:	c1 e0 04             	shl    $0x4,%eax
     53f:	39 c3                	cmp    %eax,%ebx
     541:	74 a1                	je     4e4 <arrowkeys+0x14>
     543:	85 db                	test   %ebx,%ebx
     545:	7e 9d                	jle    4e4 <arrowkeys+0x14>
		currChar--;
     547:	83 eb 01             	sub    $0x1,%ebx
     54a:	89 1d 24 17 00 00    	mov    %ebx,0x1724
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
}
     550:	5b                   	pop    %ebx
     551:	5d                   	pop    %ebp
     552:	c3                   	ret    
     553:	90                   	nop
     554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	//ctrl+j (go left)
	if((i == 10 || i == 228) && (currChar % WIDTH != 0) && currChar > 0){
		currChar--;
	}
	//ctrl+l (go right)
	else if((i==12 || i == 229) && ((currChar+1) % WIDTH != 0)){
     558:	a1 24 17 00 00       	mov    0x1724,%eax
     55d:	ba 67 66 66 66       	mov    $0x66666667,%edx
     562:	8d 58 01             	lea    0x1(%eax),%ebx
     565:	89 d8                	mov    %ebx,%eax
     567:	f7 ea                	imul   %edx
     569:	89 d8                	mov    %ebx,%eax
     56b:	c1 f8 1f             	sar    $0x1f,%eax
     56e:	c1 fa 05             	sar    $0x5,%edx
     571:	29 c2                	sub    %eax,%edx
     573:	8d 04 92             	lea    (%edx,%edx,4),%eax
     576:	c1 e0 04             	shl    $0x4,%eax
     579:	39 c3                	cmp    %eax,%ebx
     57b:	0f 84 70 ff ff ff    	je     4f1 <arrowkeys+0x21>
		currChar++;
     581:	89 1d 24 17 00 00    	mov    %ebx,0x1724
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
}
     587:	5b                   	pop    %ebx
     588:	5d                   	pop    %ebp
     589:	c3                   	ret    
     58a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	else if((i==12 || i == 229) && ((currChar+1) % WIDTH != 0)){
		currChar++;
	}
	//ctrl+k (go down)
	else if(i == 11 || i == 227){
		if(currChar < TOTAL_CHARS - WIDTH){
     590:	a1 24 17 00 00       	mov    0x1724,%eax
     595:	3d df 06 00 00       	cmp    $0x6df,%eax
     59a:	7e 54                	jle    5f0 <arrowkeys+0x120>
			currChar += WIDTH;
		}
		else{
			if(lastOnScreen->next != 0)
     59c:	a1 44 17 00 00       	mov    0x1744,%eax
     5a1:	8b 50 58             	mov    0x58(%eax),%edx
     5a4:	85 d2                	test   %edx,%edx
     5a6:	0f 84 6f ff ff ff    	je     51b <arrowkeys+0x4b>
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
}
     5ac:	5b                   	pop    %ebx
     5ad:	5d                   	pop    %ebp
		if(currChar < TOTAL_CHARS - WIDTH){
			currChar += WIDTH;
		}
		else{
			if(lastOnScreen->next != 0)
				scrolldown();
     5ae:	e9 1d fe ff ff       	jmp    3d0 <scrolldown>
     5b3:	90                   	nop
     5b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		}
	}
	//ctrl+i (go up)
	else if(i == 9 || i == 226){
		if(currChar >= WIDTH){
     5b8:	a1 24 17 00 00       	mov    0x1724,%eax
     5bd:	83 f8 4f             	cmp    $0x4f,%eax
     5c0:	7f 1e                	jg     5e0 <arrowkeys+0x110>
			currChar -= WIDTH;
		}
		else{
			if(firstOnScreen->prev != 0)
     5c2:	a1 40 17 00 00       	mov    0x1740,%eax
     5c7:	8b 40 54             	mov    0x54(%eax),%eax
     5ca:	85 c0                	test   %eax,%eax
     5cc:	0f 84 49 ff ff ff    	je     51b <arrowkeys+0x4b>
				scrollup();
		}
	}
}
     5d2:	5b                   	pop    %ebx
     5d3:	5d                   	pop    %ebp
		if(currChar >= WIDTH){
			currChar -= WIDTH;
		}
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
     5d4:	e9 67 fe ff ff       	jmp    440 <scrollup>
     5d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		}
	}
	//ctrl+i (go up)
	else if(i == 9 || i == 226){
		if(currChar >= WIDTH){
			currChar -= WIDTH;
     5e0:	83 e8 50             	sub    $0x50,%eax
     5e3:	a3 24 17 00 00       	mov    %eax,0x1724
     5e8:	e9 2e ff ff ff       	jmp    51b <arrowkeys+0x4b>
     5ed:	8d 76 00             	lea    0x0(%esi),%esi
		currChar++;
	}
	//ctrl+k (go down)
	else if(i == 11 || i == 227){
		if(currChar < TOTAL_CHARS - WIDTH){
			currChar += WIDTH;
     5f0:	83 c0 50             	add    $0x50,%eax
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
}
     5f3:	5b                   	pop    %ebx
		currChar++;
	}
	//ctrl+k (go down)
	else if(i == 11 || i == 227){
		if(currChar < TOTAL_CHARS - WIDTH){
			currChar += WIDTH;
     5f4:	a3 24 17 00 00       	mov    %eax,0x1724
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
}
     5f9:	5d                   	pop    %ebp
     5fa:	c3                   	ret    
     5fb:	90                   	nop
     5fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000600 <cutline>:


void
cutline(void){
     600:	55                   	push   %ebp
	int line = currChar/WIDTH;
     601:	ba 67 66 66 66       	mov    $0x66666667,%edx
	}
}


void
cutline(void){
     606:	89 e5                	mov    %esp,%ebp
     608:	53                   	push   %ebx
     609:	83 ec 04             	sub    $0x4,%esp
	int line = currChar/WIDTH;
     60c:	8b 0d 24 17 00 00    	mov    0x1724,%ecx
     612:	89 c8                	mov    %ecx,%eax
     614:	c1 f9 1f             	sar    $0x1f,%ecx
     617:	f7 ea                	imul   %edx
     619:	c1 fa 05             	sar    $0x5,%edx
     61c:	29 ca                	sub    %ecx,%edx
	struct fileline* cur = firstOnScreen;
     61e:	8b 0d 40 17 00 00    	mov    0x1740,%ecx
	for(int i=0; i<line; i++){
     624:	85 d2                	test   %edx,%edx


void
cutline(void){
	int line = currChar/WIDTH;
	struct fileline* cur = firstOnScreen;
     626:	89 cb                	mov    %ecx,%ebx
	for(int i=0; i<line; i++){
     628:	7e 10                	jle    63a <cutline+0x3a>
     62a:	31 c0                	xor    %eax,%eax
     62c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     630:	83 c0 01             	add    $0x1,%eax
		cur = cur->next;
     633:	8b 5b 58             	mov    0x58(%ebx),%ebx

void
cutline(void){
	int line = currChar/WIDTH;
	struct fileline* cur = firstOnScreen;
	for(int i=0; i<line; i++){
     636:	39 c2                	cmp    %eax,%edx
     638:	75 f6                	jne    630 <cutline+0x30>
		cur = cur->next;
	}
	if(lastOnScreen->next == 0){
     63a:	a1 44 17 00 00       	mov    0x1744,%eax
     63f:	8b 40 58             	mov    0x58(%eax),%eax
     642:	85 c0                	test   %eax,%eax
     644:	74 6a                	je     6b0 <cutline+0xb0>
			printfile(firstOnScreen);
			return;
		}
	}
	struct fileline* temp = cur;
	while(temp != 0){
     646:	85 db                	test   %ebx,%ebx
     648:	89 d8                	mov    %ebx,%eax
     64a:	74 0e                	je     65a <cutline+0x5a>
     64c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		temp->filelinenum = temp->filelinenum-1;
     650:	83 28 01             	subl   $0x1,(%eax)
		temp = temp->next;
     653:	8b 40 58             	mov    0x58(%eax),%eax
			printfile(firstOnScreen);
			return;
		}
	}
	struct fileline* temp = cur;
	while(temp != 0){
     656:	85 c0                	test   %eax,%eax
     658:	75 f6                	jne    650 <cutline+0x50>
		temp->filelinenum = temp->filelinenum-1;
		temp = temp->next;
	}
	if(firstOnScreen == cur){
     65a:	3b 1d 40 17 00 00    	cmp    0x1740,%ebx
     660:	74 5e                	je     6c0 <cutline+0xc0>
		firstOnScreen = cur->next;
	}
	if(lastOnScreen == cur){
     662:	3b 1d 44 17 00 00    	cmp    0x1744,%ebx
     668:	8b 43 58             	mov    0x58(%ebx),%eax
     66b:	74 63                	je     6d0 <cutline+0xd0>
		} 
		else if(cur->prev != 0){
			lastOnScreen = cur->prev;
		}
	}
	if(head == cur){
     66d:	3b 1d 48 17 00 00    	cmp    0x1748,%ebx
     673:	8b 53 54             	mov    0x54(%ebx),%edx
     676:	74 70                	je     6e8 <cutline+0xe8>
		head = cur->next;
	}
	if(cur->prev != 0){
     678:	85 d2                	test   %edx,%edx
     67a:	74 06                	je     682 <cutline+0x82>
		cur->prev->next = cur->next;
     67c:	89 42 58             	mov    %eax,0x58(%edx)
     67f:	8b 43 58             	mov    0x58(%ebx),%eax
	}
	if(cur->next != 0){
     682:	85 c0                	test   %eax,%eax
     684:	74 06                	je     68c <cutline+0x8c>
		cur->next->prev = cur->prev;
     686:	8b 53 54             	mov    0x54(%ebx),%edx
     689:	89 50 54             	mov    %edx,0x54(%eax)
	}
	free(cur);
     68c:	83 ec 0c             	sub    $0xc,%esp
     68f:	53                   	push   %ebx
     690:	e8 1b 09 00 00       	call   fb0 <free>
	printfile(firstOnScreen);
     695:	58                   	pop    %eax
     696:	ff 35 40 17 00 00    	pushl  0x1740
     69c:	e8 9f fb ff ff       	call   240 <printfile>
     6a1:	83 c4 10             	add    $0x10,%esp
}
     6a4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     6a7:	c9                   	leave  
     6a8:	c3                   	ret    
     6a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	struct fileline* cur = firstOnScreen;
	for(int i=0; i<line; i++){
		cur = cur->next;
	}
	if(lastOnScreen->next == 0){
		if(firstOnScreen->prev != 0){
     6b0:	8b 51 54             	mov    0x54(%ecx),%edx
     6b3:	85 d2                	test   %edx,%edx
     6b5:	74 38                	je     6ef <cutline+0xef>
			scrollup();
     6b7:	e8 84 fd ff ff       	call   440 <scrollup>
     6bc:	eb 88                	jmp    646 <cutline+0x46>
     6be:	66 90                	xchg   %ax,%ax
		temp = temp->next;
	}
	if(firstOnScreen == cur){
		firstOnScreen = cur->next;
	}
	if(lastOnScreen == cur){
     6c0:	3b 1d 44 17 00 00    	cmp    0x1744,%ebx
	while(temp != 0){
		temp->filelinenum = temp->filelinenum-1;
		temp = temp->next;
	}
	if(firstOnScreen == cur){
		firstOnScreen = cur->next;
     6c6:	8b 43 58             	mov    0x58(%ebx),%eax
     6c9:	a3 40 17 00 00       	mov    %eax,0x1740
	}
	if(lastOnScreen == cur){
     6ce:	75 9d                	jne    66d <cutline+0x6d>
		if(cur->next != 0){
     6d0:	85 c0                	test   %eax,%eax
     6d2:	74 3c                	je     710 <cutline+0x110>
		} 
		else if(cur->prev != 0){
			lastOnScreen = cur->prev;
		}
	}
	if(head == cur){
     6d4:	3b 1d 48 17 00 00    	cmp    0x1748,%ebx
	if(firstOnScreen == cur){
		firstOnScreen = cur->next;
	}
	if(lastOnScreen == cur){
		if(cur->next != 0){
			lastOnScreen = cur->next;
     6da:	a3 44 17 00 00       	mov    %eax,0x1744
     6df:	8b 53 54             	mov    0x54(%ebx),%edx
		} 
		else if(cur->prev != 0){
			lastOnScreen = cur->prev;
		}
	}
	if(head == cur){
     6e2:	75 94                	jne    678 <cutline+0x78>
     6e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		head = cur->next;
     6e8:	a3 48 17 00 00       	mov    %eax,0x1748
     6ed:	eb 89                	jmp    678 <cutline+0x78>
     6ef:	8d 43 04             	lea    0x4(%ebx),%eax
     6f2:	83 c3 54             	add    $0x54,%ebx
     6f5:	8d 76 00             	lea    0x0(%esi),%esi
	if(lastOnScreen->next == 0){
		if(firstOnScreen->prev != 0){
			scrollup();
		} else {
			for(int i=0; i<WIDTH; i++){
				cur->line[i] = ' ';
     6f8:	c6 00 20             	movb   $0x20,(%eax)
     6fb:	83 c0 01             	add    $0x1,%eax
	}
	if(lastOnScreen->next == 0){
		if(firstOnScreen->prev != 0){
			scrollup();
		} else {
			for(int i=0; i<WIDTH; i++){
     6fe:	39 d8                	cmp    %ebx,%eax
     700:	75 f6                	jne    6f8 <cutline+0xf8>
				cur->line[i] = ' ';
			}
			printfile(firstOnScreen);
     702:	83 ec 0c             	sub    $0xc,%esp
     705:	51                   	push   %ecx
     706:	e8 35 fb ff ff       	call   240 <printfile>
			return;
     70b:	83 c4 10             	add    $0x10,%esp
     70e:	eb 94                	jmp    6a4 <cutline+0xa4>
	}
	if(lastOnScreen == cur){
		if(cur->next != 0){
			lastOnScreen = cur->next;
		} 
		else if(cur->prev != 0){
     710:	8b 53 54             	mov    0x54(%ebx),%edx
     713:	85 d2                	test   %edx,%edx
     715:	74 14                	je     72b <cutline+0x12b>
			lastOnScreen = cur->prev;
		}
	}
	if(head == cur){
     717:	3b 1d 48 17 00 00    	cmp    0x1748,%ebx
	if(lastOnScreen == cur){
		if(cur->next != 0){
			lastOnScreen = cur->next;
		} 
		else if(cur->prev != 0){
			lastOnScreen = cur->prev;
     71d:	89 15 44 17 00 00    	mov    %edx,0x1744
		}
	}
	if(head == cur){
     723:	0f 85 53 ff ff ff    	jne    67c <cutline+0x7c>
     729:	eb bd                	jmp    6e8 <cutline+0xe8>
     72b:	3b 1d 48 17 00 00    	cmp    0x1748,%ebx
     731:	0f 85 55 ff ff ff    	jne    68c <cutline+0x8c>
     737:	eb af                	jmp    6e8 <cutline+0xe8>
     739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000740 <newline>:
	printfile(firstOnScreen);
}

void
newline(void)
{
     740:	55                   	push   %ebp
     741:	89 e5                	mov    %esp,%ebp
     743:	57                   	push   %edi
     744:	56                   	push   %esi
     745:	53                   	push   %ebx
     746:	31 f6                	xor    %esi,%esi
     748:	83 ec 0c             	sub    $0xc,%esp
void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
     74b:	8b 3d 44 17 00 00    	mov    0x1744,%edi
}

void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
     751:	8b 1d 40 17 00 00    	mov    0x1740,%ebx
	int bufindex = 0;
	while(cur != lastOnScreen->next){
     757:	3b 5f 58             	cmp    0x58(%edi),%ebx
     75a:	89 d9                	mov    %ebx,%ecx
     75c:	74 29                	je     787 <newline+0x47>
     75e:	66 90                	xchg   %ax,%ax
     760:	31 c0                	xor    %eax,%eax
     762:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		for(int i=0; i<WIDTH; i++){
			cur->line[i] = buf[bufindex];
     768:	0f b6 94 06 60 17 00 	movzbl 0x1760(%esi,%eax,1),%edx
     76f:	00 
     770:	88 54 01 04          	mov    %dl,0x4(%ecx,%eax,1)
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
		for(int i=0; i<WIDTH; i++){
     774:	83 c0 01             	add    $0x1,%eax
     777:	83 f8 50             	cmp    $0x50,%eax
     77a:	75 ec                	jne    768 <newline+0x28>
     77c:	83 c6 50             	add    $0x50,%esi
			cur->line[i] = buf[bufindex];
			bufindex++;
		}
		cur = cur->next;
     77f:	8b 49 58             	mov    0x58(%ecx),%ecx
void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
     782:	3b 4f 58             	cmp    0x58(%edi),%ecx
     785:	75 d9                	jne    760 <newline+0x20>

void
newline(void)
{
	saveedits();
	int line = currChar/WIDTH;
     787:	8b 0d 24 17 00 00    	mov    0x1724,%ecx
     78d:	ba 67 66 66 66       	mov    $0x66666667,%edx
     792:	89 c8                	mov    %ecx,%eax
     794:	f7 ea                	imul   %edx
     796:	89 c8                	mov    %ecx,%eax
     798:	c1 f8 1f             	sar    $0x1f,%eax
     79b:	c1 fa 05             	sar    $0x5,%edx
     79e:	29 c2                	sub    %eax,%edx
	struct fileline* cur = firstOnScreen;
	for(int i=0; i<line; i++){
     7a0:	31 c0                	xor    %eax,%eax
     7a2:	85 d2                	test   %edx,%edx
     7a4:	7e 14                	jle    7ba <newline+0x7a>
     7a6:	8d 76 00             	lea    0x0(%esi),%esi
     7a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     7b0:	83 c0 01             	add    $0x1,%eax
		cur = cur->next;
     7b3:	8b 5b 58             	mov    0x58(%ebx),%ebx
newline(void)
{
	saveedits();
	int line = currChar/WIDTH;
	struct fileline* cur = firstOnScreen;
	for(int i=0; i<line; i++){
     7b6:	39 c2                	cmp    %eax,%edx
     7b8:	75 f6                	jne    7b0 <newline+0x70>
		cur = cur->next;
	}
	int linechar = currChar % WIDTH;
     7ba:	89 c8                	mov    %ecx,%eax
     7bc:	ba 67 66 66 66       	mov    $0x66666667,%edx
     7c1:	f7 ea                	imul   %edx
     7c3:	89 c8                	mov    %ecx,%eax
     7c5:	c1 f8 1f             	sar    $0x1f,%eax
     7c8:	c1 fa 05             	sar    $0x5,%edx
     7cb:	89 d6                	mov    %edx,%esi
     7cd:	29 c6                	sub    %eax,%esi
     7cf:	8d 04 b6             	lea    (%esi,%esi,4),%eax
	//enter pressed in any column except first
	if(linechar != 0){
     7d2:	89 ce                	mov    %ecx,%esi
	int line = currChar/WIDTH;
	struct fileline* cur = firstOnScreen;
	for(int i=0; i<line; i++){
		cur = cur->next;
	}
	int linechar = currChar % WIDTH;
     7d4:	c1 e0 04             	shl    $0x4,%eax
	//enter pressed in any column except first
	if(linechar != 0){
     7d7:	29 c6                	sub    %eax,%esi
     7d9:	74 77                	je     852 <newline+0x112>
		struct fileline* newfileline = malloc(sizeof(struct fileline));
     7db:	83 ec 0c             	sub    $0xc,%esp
     7de:	6a 5c                	push   $0x5c
     7e0:	e8 5b 08 00 00       	call   1040 <malloc>
		int i = 0;
		for(i = 0; linechar<WIDTH; i++, linechar++){
			newfileline->line[i] = cur->line[linechar];
     7e5:	89 c7                	mov    %eax,%edi
		cur = cur->next;
	}
	int linechar = currChar % WIDTH;
	//enter pressed in any column except first
	if(linechar != 0){
		struct fileline* newfileline = malloc(sizeof(struct fileline));
     7e7:	83 c4 10             	add    $0x10,%esp
     7ea:	89 f2                	mov    %esi,%edx
		int i = 0;
		for(i = 0; linechar<WIDTH; i++, linechar++){
			newfileline->line[i] = cur->line[linechar];
     7ec:	29 f7                	sub    %esi,%edi
     7ee:	66 90                	xchg   %ax,%ax
     7f0:	0f b6 4c 13 04       	movzbl 0x4(%ebx,%edx,1),%ecx
     7f5:	88 4c 17 04          	mov    %cl,0x4(%edi,%edx,1)
			cur->line[linechar] = ' ';
     7f9:	c6 44 13 04 20       	movb   $0x20,0x4(%ebx,%edx,1)
	int linechar = currChar % WIDTH;
	//enter pressed in any column except first
	if(linechar != 0){
		struct fileline* newfileline = malloc(sizeof(struct fileline));
		int i = 0;
		for(i = 0; linechar<WIDTH; i++, linechar++){
     7fe:	83 c2 01             	add    $0x1,%edx
     801:	83 fa 50             	cmp    $0x50,%edx
     804:	75 ea                	jne    7f0 <newline+0xb0>
			newfileline->line[i] = cur->line[linechar];
			cur->line[linechar] = ' ';
		}
		for(int j = i; j<WIDTH; j++){
     806:	85 f6                	test   %esi,%esi
     808:	74 18                	je     822 <newline+0xe2>
     80a:	89 c2                	mov    %eax,%edx
     80c:	8d 48 54             	lea    0x54(%eax),%ecx
     80f:	29 f2                	sub    %esi,%edx
     811:	83 c2 54             	add    $0x54,%edx
     814:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
			newfileline->line[j] = ' ';
     818:	c6 02 20             	movb   $0x20,(%edx)
     81b:	83 c2 01             	add    $0x1,%edx
		int i = 0;
		for(i = 0; linechar<WIDTH; i++, linechar++){
			newfileline->line[i] = cur->line[linechar];
			cur->line[linechar] = ' ';
		}
		for(int j = i; j<WIDTH; j++){
     81e:	39 ca                	cmp    %ecx,%edx
     820:	75 f6                	jne    818 <newline+0xd8>
			newfileline->line[j] = ' ';
		}
		newfileline->next = cur->next;
     822:	8b 53 58             	mov    0x58(%ebx),%edx
		newfileline->prev = cur;
     825:	89 58 54             	mov    %ebx,0x54(%eax)
			cur->line[linechar] = ' ';
		}
		for(int j = i; j<WIDTH; j++){
			newfileline->line[j] = ' ';
		}
		newfileline->next = cur->next;
     828:	89 50 58             	mov    %edx,0x58(%eax)
		newfileline->prev = cur;
		if(cur->next != 0){
     82b:	8b 53 58             	mov    0x58(%ebx),%edx
     82e:	85 d2                	test   %edx,%edx
     830:	0f 84 8d 00 00 00    	je     8c3 <newline+0x183>
			cur->next->prev = newfileline;
     836:	89 42 54             	mov    %eax,0x54(%edx)
		} else {
			lastOnScreen = newfileline;
		}
		cur->next = newfileline;
		newfileline->filelinenum = cur->filelinenum;
     839:	8b 13                	mov    (%ebx),%edx
		if(cur->next != 0){
			cur->next->prev = newfileline;
		} else {
			lastOnScreen = newfileline;
		}
		cur->next = newfileline;
     83b:	89 43 58             	mov    %eax,0x58(%ebx)
		newfileline->filelinenum = cur->filelinenum;
     83e:	89 10                	mov    %edx,(%eax)
     840:	eb 02                	jmp    844 <newline+0x104>
     842:	8b 10                	mov    (%eax),%edx
		struct fileline* temp = newfileline;
		while(temp != 0){
			temp->filelinenum = temp->filelinenum + 1;
     844:	83 c2 01             	add    $0x1,%edx
     847:	89 10                	mov    %edx,(%eax)
			temp = temp->next;
     849:	8b 40 58             	mov    0x58(%eax),%eax
			lastOnScreen = newfileline;
		}
		cur->next = newfileline;
		newfileline->filelinenum = cur->filelinenum;
		struct fileline* temp = newfileline;
		while(temp != 0){
     84c:	85 c0                	test   %eax,%eax
     84e:	75 f2                	jne    842 <newline+0x102>
     850:	eb 58                	jmp    8aa <newline+0x16a>
		}
	} 
	//enter was pressed in first column
	else
	{
		struct fileline* newfileline = malloc(sizeof(struct fileline));
     852:	83 ec 0c             	sub    $0xc,%esp
     855:	6a 5c                	push   $0x5c
     857:	e8 e4 07 00 00       	call   1040 <malloc>
     85c:	8d 50 04             	lea    0x4(%eax),%edx
     85f:	8d 48 54             	lea    0x54(%eax),%ecx
     862:	83 c4 10             	add    $0x10,%esp
     865:	8d 76 00             	lea    0x0(%esi),%esi
		int i = 0;
		for(i = 0; linechar<WIDTH; i++, linechar++){
			newfileline->line[i] = ' ';
     868:	c6 02 20             	movb   $0x20,(%edx)
     86b:	83 c2 01             	add    $0x1,%edx
	//enter was pressed in first column
	else
	{
		struct fileline* newfileline = malloc(sizeof(struct fileline));
		int i = 0;
		for(i = 0; linechar<WIDTH; i++, linechar++){
     86e:	39 ca                	cmp    %ecx,%edx
     870:	75 f6                	jne    868 <newline+0x128>
			newfileline->line[i] = ' ';
		}
		newfileline->next = cur;
     872:	89 58 58             	mov    %ebx,0x58(%eax)
		newfileline->prev = cur->prev;
     875:	8b 53 54             	mov    0x54(%ebx),%edx
     878:	89 50 54             	mov    %edx,0x54(%eax)
		if(cur->prev != 0){
     87b:	8b 53 54             	mov    0x54(%ebx),%edx
     87e:	85 d2                	test   %edx,%edx
     880:	74 4b                	je     8cd <newline+0x18d>
			cur->prev->next = newfileline;
     882:	89 42 58             	mov    %eax,0x58(%edx)
		} else {
			firstOnScreen = newfileline;
		}
		cur->prev = newfileline;
		newfileline->filelinenum = cur->filelinenum;
     885:	8b 13                	mov    (%ebx),%edx
		if(cur->prev != 0){
			cur->prev->next = newfileline;
		} else {
			firstOnScreen = newfileline;
		}
		cur->prev = newfileline;
     887:	89 43 54             	mov    %eax,0x54(%ebx)
		newfileline->filelinenum = cur->filelinenum;
     88a:	89 10                	mov    %edx,(%eax)
		struct fileline* temp = newfileline->next;
     88c:	8b 40 58             	mov    0x58(%eax),%eax
		while(temp != 0){
     88f:	85 c0                	test   %eax,%eax
     891:	74 0a                	je     89d <newline+0x15d>
			temp->filelinenum = temp->filelinenum + 1;
     893:	83 00 01             	addl   $0x1,(%eax)
			temp = temp->next;
     896:	8b 40 58             	mov    0x58(%eax),%eax
			firstOnScreen = newfileline;
		}
		cur->prev = newfileline;
		newfileline->filelinenum = cur->filelinenum;
		struct fileline* temp = newfileline->next;
		while(temp != 0){
     899:	85 c0                	test   %eax,%eax
     89b:	75 f6                	jne    893 <newline+0x153>
			temp->filelinenum = temp->filelinenum + 1;
			temp = temp->next;
		}
		lastOnScreen = lastOnScreen->prev;
     89d:	a1 44 17 00 00       	mov    0x1744,%eax
     8a2:	8b 40 54             	mov    0x54(%eax),%eax
     8a5:	a3 44 17 00 00       	mov    %eax,0x1744
	}
	printfile(firstOnScreen);
     8aa:	83 ec 0c             	sub    $0xc,%esp
     8ad:	ff 35 40 17 00 00    	pushl  0x1740
     8b3:	e8 88 f9 ff ff       	call   240 <printfile>
}
     8b8:	83 c4 10             	add    $0x10,%esp
     8bb:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8be:	5b                   	pop    %ebx
     8bf:	5e                   	pop    %esi
     8c0:	5f                   	pop    %edi
     8c1:	5d                   	pop    %ebp
     8c2:	c3                   	ret    
		newfileline->next = cur->next;
		newfileline->prev = cur;
		if(cur->next != 0){
			cur->next->prev = newfileline;
		} else {
			lastOnScreen = newfileline;
     8c3:	a3 44 17 00 00       	mov    %eax,0x1744
     8c8:	e9 6c ff ff ff       	jmp    839 <newline+0xf9>
		newfileline->next = cur;
		newfileline->prev = cur->prev;
		if(cur->prev != 0){
			cur->prev->next = newfileline;
		} else {
			firstOnScreen = newfileline;
     8cd:	a3 40 17 00 00       	mov    %eax,0x1740
     8d2:	eb b1                	jmp    885 <newline+0x145>
     8d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     8da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000008e0 <handleInput>:
	}
	printfile(firstOnScreen);
}

void
handleInput(int i) {
     8e0:	55                   	push   %ebp
     8e1:	89 e5                	mov    %esp,%ebp
     8e3:	57                   	push   %edi
     8e4:	56                   	push   %esi
     8e5:	53                   	push   %ebx
     8e6:	83 ec 10             	sub    $0x10,%esp
	int prevChar = currChar;
     8e9:	8b 35 24 17 00 00    	mov    0x1724,%esi
	}
	printfile(firstOnScreen);
}

void
handleInput(int i) {
     8ef:	8b 5d 08             	mov    0x8(%ebp),%ebx
	int prevChar = currChar;
	printf(1, "currChar: %d\n", currChar);
     8f2:	56                   	push   %esi
     8f3:	68 55 11 00 00       	push   $0x1155
     8f8:	6a 01                	push   $0x1
     8fa:	e8 11 05 00 00       	call   e10 <printf>
	//ctrl+q
	if (i == 17) {
     8ff:	83 c4 10             	add    $0x10,%esp
     902:	83 fb 11             	cmp    $0x11,%ebx
     905:	0f 84 4f 01 00 00    	je     a5a <handleInput+0x17a>
		exit();
	}
	else if((i >= 9 && i<= 12) || (i >= 226 && i <= 229)) {
     90b:	8d 43 f7             	lea    -0x9(%ebx),%eax
     90e:	83 f8 03             	cmp    $0x3,%eax
     911:	0f 86 89 00 00 00    	jbe    9a0 <handleInput+0xc0>
     917:	8d 83 1e ff ff ff    	lea    -0xe2(%ebx),%eax
     91d:	83 f8 03             	cmp    $0x3,%eax
     920:	76 7e                	jbe    9a0 <handleInput+0xc0>
		arrowkeys(i);
	}

	//ctrl+x
	else if(i == 24){
     922:	83 fb 18             	cmp    $0x18,%ebx
     925:	0f 84 0b 01 00 00    	je     a36 <handleInput+0x156>
		cutline();
	}

	//return key
	else if(i == 13){
     92b:	83 fb 0d             	cmp    $0xd,%ebx
     92e:	0f 84 12 01 00 00    	je     a46 <handleInput+0x166>
		newline();
	}

	//backspace
	else if(i == 127){
     934:	83 fb 7f             	cmp    $0x7f,%ebx
     937:	0f 84 83 00 00 00    	je     9c0 <handleInput+0xe0>
			buf[bufindex] = ' ';
			updatesc(0, 1, buf, TEXT_COLOR);
		}
	}
	//On right edge of window 
	else if((currChar+1) % WIDTH == 0){
     93d:	8b 3d 24 17 00 00    	mov    0x1724,%edi
     943:	ba 67 66 66 66       	mov    $0x66666667,%edx
     948:	8d 4f 01             	lea    0x1(%edi),%ecx
     94b:	89 c8                	mov    %ecx,%eax
     94d:	f7 ea                	imul   %edx
     94f:	89 c8                	mov    %ecx,%eax
     951:	c1 f8 1f             	sar    $0x1f,%eax
     954:	c1 fa 05             	sar    $0x5,%edx
     957:	29 c2                	sub    %eax,%edx
     959:	8d 04 92             	lea    (%edx,%edx,4),%eax
     95c:	c1 e0 04             	shl    $0x4,%eax
     95f:	39 c1                	cmp    %eax,%ecx
     961:	75 55                	jne    9b8 <handleInput+0xd8>
		buf[currChar] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
		// printf(1, "new input");
	}
	else{
		buf[currChar++] = (char) i & 0xff;
     963:	88 9f 60 17 00 00    	mov    %bl,0x1760(%edi)
		updatesc(0, 1, buf, TEXT_COLOR);
     969:	6a 07                	push   $0x7
     96b:	68 60 17 00 00       	push   $0x1760
     970:	6a 01                	push   $0x1
     972:	6a 00                	push   $0x0
     974:	e8 d9 03 00 00       	call   d52 <updatesc>
     979:	8b 15 24 17 00 00    	mov    0x1724,%edx
     97f:	83 c4 10             	add    $0x10,%esp
	firstOnScreen = firstOnScreen->prev;
}

void
updateCursor(int prev, int curr) {
	if (prev == curr)
     982:	39 d6                	cmp    %edx,%esi
     984:	74 12                	je     998 <handleInput+0xb8>
	else{
		buf[currChar++] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
	}
	updateCursor(prevChar, currChar);
}
     986:	8d 65 f4             	lea    -0xc(%ebp),%esp
     989:	89 f0                	mov    %esi,%eax
     98b:	5b                   	pop    %ebx
     98c:	5e                   	pop    %esi
     98d:	5f                   	pop    %edi
     98e:	5d                   	pop    %ebp
     98f:	e9 3c f7 ff ff       	jmp    d0 <updateCursor.part.0>
     994:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     998:	8d 65 f4             	lea    -0xc(%ebp),%esp
     99b:	5b                   	pop    %ebx
     99c:	5e                   	pop    %esi
     99d:	5f                   	pop    %edi
     99e:	5d                   	pop    %ebp
     99f:	c3                   	ret    
	//ctrl+q
	if (i == 17) {
		exit();
	}
	else if((i >= 9 && i<= 12) || (i >= 226 && i <= 229)) {
		arrowkeys(i);
     9a0:	83 ec 0c             	sub    $0xc,%esp
     9a3:	53                   	push   %ebx
     9a4:	e8 27 fb ff ff       	call   4d0 <arrowkeys>
     9a9:	8b 15 24 17 00 00    	mov    0x1724,%edx
     9af:	83 c4 10             	add    $0x10,%esp
     9b2:	eb ce                	jmp    982 <handleInput+0xa2>
     9b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		buf[currChar] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
		// printf(1, "new input");
	}
	else{
		buf[currChar++] = (char) i & 0xff;
     9b8:	89 0d 24 17 00 00    	mov    %ecx,0x1724
     9be:	eb a3                	jmp    963 <handleInput+0x83>
		newline();
	}

	//backspace
	else if(i == 127){
		if(currChar > 0){
     9c0:	8b 1d 24 17 00 00    	mov    0x1724,%ebx
     9c6:	85 db                	test   %ebx,%ebx
     9c8:	89 da                	mov    %ebx,%edx
     9ca:	7e b6                	jle    982 <handleInput+0xa2>
			currChar--;
			int bufindex = currChar;
			while(((bufindex+1) % WIDTH) != 0){
     9cc:	89 d8                	mov    %ebx,%eax
     9ce:	ba 67 66 66 66       	mov    $0x66666667,%edx
	}

	//backspace
	else if(i == 127){
		if(currChar > 0){
			currChar--;
     9d3:	8d 4b ff             	lea    -0x1(%ebx),%ecx
			int bufindex = currChar;
			while(((bufindex+1) % WIDTH) != 0){
     9d6:	f7 ea                	imul   %edx
     9d8:	89 d8                	mov    %ebx,%eax
     9da:	c1 f8 1f             	sar    $0x1f,%eax
	}

	//backspace
	else if(i == 127){
		if(currChar > 0){
			currChar--;
     9dd:	89 0d 24 17 00 00    	mov    %ecx,0x1724
			int bufindex = currChar;
			while(((bufindex+1) % WIDTH) != 0){
     9e3:	c1 fa 05             	sar    $0x5,%edx
     9e6:	29 c2                	sub    %eax,%edx
     9e8:	8d 04 92             	lea    (%edx,%edx,4),%eax
     9eb:	c1 e0 04             	shl    $0x4,%eax
     9ee:	39 c3                	cmp    %eax,%ebx
     9f0:	74 64                	je     a56 <handleInput+0x176>
     9f2:	bf 67 66 66 66       	mov    $0x66666667,%edi
     9f7:	eb 09                	jmp    a02 <handleInput+0x122>
     9f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a00:	89 cb                	mov    %ecx,%ebx
				buf[bufindex] = buf[bufindex+1];
     a02:	0f b6 83 60 17 00 00 	movzbl 0x1760(%ebx),%eax
	//backspace
	else if(i == 127){
		if(currChar > 0){
			currChar--;
			int bufindex = currChar;
			while(((bufindex+1) % WIDTH) != 0){
     a09:	8d 4b 01             	lea    0x1(%ebx),%ecx
				buf[bufindex] = buf[bufindex+1];
     a0c:	88 83 5f 17 00 00    	mov    %al,0x175f(%ebx)
	//backspace
	else if(i == 127){
		if(currChar > 0){
			currChar--;
			int bufindex = currChar;
			while(((bufindex+1) % WIDTH) != 0){
     a12:	89 c8                	mov    %ecx,%eax
     a14:	f7 ef                	imul   %edi
     a16:	89 c8                	mov    %ecx,%eax
     a18:	c1 f8 1f             	sar    $0x1f,%eax
     a1b:	c1 fa 05             	sar    $0x5,%edx
     a1e:	29 c2                	sub    %eax,%edx
     a20:	8d 04 92             	lea    (%edx,%edx,4),%eax
     a23:	c1 e0 04             	shl    $0x4,%eax
     a26:	39 c1                	cmp    %eax,%ecx
     a28:	75 d6                	jne    a00 <handleInput+0x120>
				buf[bufindex] = buf[bufindex+1];
				bufindex++;
			}
			buf[bufindex] = ' ';
     a2a:	c6 83 60 17 00 00 20 	movb   $0x20,0x1760(%ebx)
     a31:	e9 33 ff ff ff       	jmp    969 <handleInput+0x89>
		arrowkeys(i);
	}

	//ctrl+x
	else if(i == 24){
		cutline();
     a36:	e8 c5 fb ff ff       	call   600 <cutline>
     a3b:	8b 15 24 17 00 00    	mov    0x1724,%edx
     a41:	e9 3c ff ff ff       	jmp    982 <handleInput+0xa2>
	}

	//return key
	else if(i == 13){
		newline();
     a46:	e8 f5 fc ff ff       	call   740 <newline>
     a4b:	8b 15 24 17 00 00    	mov    0x1724,%edx
     a51:	e9 2c ff ff ff       	jmp    982 <handleInput+0xa2>

	//backspace
	else if(i == 127){
		if(currChar > 0){
			currChar--;
			int bufindex = currChar;
     a56:	89 cb                	mov    %ecx,%ebx
     a58:	eb d0                	jmp    a2a <handleInput+0x14a>
handleInput(int i) {
	int prevChar = currChar;
	printf(1, "currChar: %d\n", currChar);
	//ctrl+q
	if (i == 17) {
		exit();
     a5a:	e8 43 02 00 00       	call   ca2 <exit>
     a5f:	90                   	nop

00000a60 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     a60:	55                   	push   %ebp
     a61:	89 e5                	mov    %esp,%ebp
     a63:	53                   	push   %ebx
     a64:	8b 45 08             	mov    0x8(%ebp),%eax
     a67:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     a6a:	89 c2                	mov    %eax,%edx
     a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     a70:	83 c1 01             	add    $0x1,%ecx
     a73:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     a77:	83 c2 01             	add    $0x1,%edx
     a7a:	84 db                	test   %bl,%bl
     a7c:	88 5a ff             	mov    %bl,-0x1(%edx)
     a7f:	75 ef                	jne    a70 <strcpy+0x10>
    ;
  return os;
}
     a81:	5b                   	pop    %ebx
     a82:	5d                   	pop    %ebp
     a83:	c3                   	ret    
     a84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     a8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000a90 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     a90:	55                   	push   %ebp
     a91:	89 e5                	mov    %esp,%ebp
     a93:	56                   	push   %esi
     a94:	53                   	push   %ebx
     a95:	8b 55 08             	mov    0x8(%ebp),%edx
     a98:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     a9b:	0f b6 02             	movzbl (%edx),%eax
     a9e:	0f b6 19             	movzbl (%ecx),%ebx
     aa1:	84 c0                	test   %al,%al
     aa3:	75 1e                	jne    ac3 <strcmp+0x33>
     aa5:	eb 29                	jmp    ad0 <strcmp+0x40>
     aa7:	89 f6                	mov    %esi,%esi
     aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     ab0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     ab3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
     ab6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     ab9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
     abd:	84 c0                	test   %al,%al
     abf:	74 0f                	je     ad0 <strcmp+0x40>
     ac1:	89 f1                	mov    %esi,%ecx
     ac3:	38 d8                	cmp    %bl,%al
     ac5:	74 e9                	je     ab0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     ac7:	29 d8                	sub    %ebx,%eax
}
     ac9:	5b                   	pop    %ebx
     aca:	5e                   	pop    %esi
     acb:	5d                   	pop    %ebp
     acc:	c3                   	ret    
     acd:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     ad0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
     ad2:	29 d8                	sub    %ebx,%eax
}
     ad4:	5b                   	pop    %ebx
     ad5:	5e                   	pop    %esi
     ad6:	5d                   	pop    %ebp
     ad7:	c3                   	ret    
     ad8:	90                   	nop
     ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000ae0 <strlen>:

uint
strlen(char *s)
{
     ae0:	55                   	push   %ebp
     ae1:	89 e5                	mov    %esp,%ebp
     ae3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     ae6:	80 39 00             	cmpb   $0x0,(%ecx)
     ae9:	74 12                	je     afd <strlen+0x1d>
     aeb:	31 d2                	xor    %edx,%edx
     aed:	8d 76 00             	lea    0x0(%esi),%esi
     af0:	83 c2 01             	add    $0x1,%edx
     af3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     af7:	89 d0                	mov    %edx,%eax
     af9:	75 f5                	jne    af0 <strlen+0x10>
    ;
  return n;
}
     afb:	5d                   	pop    %ebp
     afc:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
     afd:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
     aff:	5d                   	pop    %ebp
     b00:	c3                   	ret    
     b01:	eb 0d                	jmp    b10 <memset>
     b03:	90                   	nop
     b04:	90                   	nop
     b05:	90                   	nop
     b06:	90                   	nop
     b07:	90                   	nop
     b08:	90                   	nop
     b09:	90                   	nop
     b0a:	90                   	nop
     b0b:	90                   	nop
     b0c:	90                   	nop
     b0d:	90                   	nop
     b0e:	90                   	nop
     b0f:	90                   	nop

00000b10 <memset>:

void*
memset(void *dst, int c, uint n)
{
     b10:	55                   	push   %ebp
     b11:	89 e5                	mov    %esp,%ebp
     b13:	57                   	push   %edi
     b14:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     b17:	8b 4d 10             	mov    0x10(%ebp),%ecx
     b1a:	8b 45 0c             	mov    0xc(%ebp),%eax
     b1d:	89 d7                	mov    %edx,%edi
     b1f:	fc                   	cld    
     b20:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     b22:	89 d0                	mov    %edx,%eax
     b24:	5f                   	pop    %edi
     b25:	5d                   	pop    %ebp
     b26:	c3                   	ret    
     b27:	89 f6                	mov    %esi,%esi
     b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b30 <strchr>:

char*
strchr(const char *s, char c)
{
     b30:	55                   	push   %ebp
     b31:	89 e5                	mov    %esp,%ebp
     b33:	53                   	push   %ebx
     b34:	8b 45 08             	mov    0x8(%ebp),%eax
     b37:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
     b3a:	0f b6 10             	movzbl (%eax),%edx
     b3d:	84 d2                	test   %dl,%dl
     b3f:	74 1d                	je     b5e <strchr+0x2e>
    if(*s == c)
     b41:	38 d3                	cmp    %dl,%bl
     b43:	89 d9                	mov    %ebx,%ecx
     b45:	75 0d                	jne    b54 <strchr+0x24>
     b47:	eb 17                	jmp    b60 <strchr+0x30>
     b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b50:	38 ca                	cmp    %cl,%dl
     b52:	74 0c                	je     b60 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     b54:	83 c0 01             	add    $0x1,%eax
     b57:	0f b6 10             	movzbl (%eax),%edx
     b5a:	84 d2                	test   %dl,%dl
     b5c:	75 f2                	jne    b50 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
     b5e:	31 c0                	xor    %eax,%eax
}
     b60:	5b                   	pop    %ebx
     b61:	5d                   	pop    %ebp
     b62:	c3                   	ret    
     b63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b70 <gets>:

char*
gets(char *buf, int max)
{
     b70:	55                   	push   %ebp
     b71:	89 e5                	mov    %esp,%ebp
     b73:	57                   	push   %edi
     b74:	56                   	push   %esi
     b75:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     b76:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
     b78:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
     b7b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     b7e:	eb 29                	jmp    ba9 <gets+0x39>
    cc = read(0, &c, 1);
     b80:	83 ec 04             	sub    $0x4,%esp
     b83:	6a 01                	push   $0x1
     b85:	57                   	push   %edi
     b86:	6a 00                	push   $0x0
     b88:	e8 2d 01 00 00       	call   cba <read>
    if(cc < 1)
     b8d:	83 c4 10             	add    $0x10,%esp
     b90:	85 c0                	test   %eax,%eax
     b92:	7e 1d                	jle    bb1 <gets+0x41>
      break;
    buf[i++] = c;
     b94:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     b98:	8b 55 08             	mov    0x8(%ebp),%edx
     b9b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
     b9d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
     b9f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
     ba3:	74 1b                	je     bc0 <gets+0x50>
     ba5:	3c 0d                	cmp    $0xd,%al
     ba7:	74 17                	je     bc0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     ba9:	8d 5e 01             	lea    0x1(%esi),%ebx
     bac:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     baf:	7c cf                	jl     b80 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     bb1:	8b 45 08             	mov    0x8(%ebp),%eax
     bb4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
     bb8:	8d 65 f4             	lea    -0xc(%ebp),%esp
     bbb:	5b                   	pop    %ebx
     bbc:	5e                   	pop    %esi
     bbd:	5f                   	pop    %edi
     bbe:	5d                   	pop    %ebp
     bbf:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     bc0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     bc3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     bc5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
     bc9:	8d 65 f4             	lea    -0xc(%ebp),%esp
     bcc:	5b                   	pop    %ebx
     bcd:	5e                   	pop    %esi
     bce:	5f                   	pop    %edi
     bcf:	5d                   	pop    %ebp
     bd0:	c3                   	ret    
     bd1:	eb 0d                	jmp    be0 <stat>
     bd3:	90                   	nop
     bd4:	90                   	nop
     bd5:	90                   	nop
     bd6:	90                   	nop
     bd7:	90                   	nop
     bd8:	90                   	nop
     bd9:	90                   	nop
     bda:	90                   	nop
     bdb:	90                   	nop
     bdc:	90                   	nop
     bdd:	90                   	nop
     bde:	90                   	nop
     bdf:	90                   	nop

00000be0 <stat>:

int
stat(char *n, struct stat *st)
{
     be0:	55                   	push   %ebp
     be1:	89 e5                	mov    %esp,%ebp
     be3:	56                   	push   %esi
     be4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     be5:	83 ec 08             	sub    $0x8,%esp
     be8:	6a 00                	push   $0x0
     bea:	ff 75 08             	pushl  0x8(%ebp)
     bed:	e8 f0 00 00 00       	call   ce2 <open>
  if(fd < 0)
     bf2:	83 c4 10             	add    $0x10,%esp
     bf5:	85 c0                	test   %eax,%eax
     bf7:	78 27                	js     c20 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     bf9:	83 ec 08             	sub    $0x8,%esp
     bfc:	ff 75 0c             	pushl  0xc(%ebp)
     bff:	89 c3                	mov    %eax,%ebx
     c01:	50                   	push   %eax
     c02:	e8 f3 00 00 00       	call   cfa <fstat>
     c07:	89 c6                	mov    %eax,%esi
  close(fd);
     c09:	89 1c 24             	mov    %ebx,(%esp)
     c0c:	e8 b9 00 00 00       	call   cca <close>
  return r;
     c11:	83 c4 10             	add    $0x10,%esp
     c14:	89 f0                	mov    %esi,%eax
}
     c16:	8d 65 f8             	lea    -0x8(%ebp),%esp
     c19:	5b                   	pop    %ebx
     c1a:	5e                   	pop    %esi
     c1b:	5d                   	pop    %ebp
     c1c:	c3                   	ret    
     c1d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
     c20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     c25:	eb ef                	jmp    c16 <stat+0x36>
     c27:	89 f6                	mov    %esi,%esi
     c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c30 <atoi>:
  return r;
}

int
atoi(const char *s)
{
     c30:	55                   	push   %ebp
     c31:	89 e5                	mov    %esp,%ebp
     c33:	53                   	push   %ebx
     c34:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     c37:	0f be 11             	movsbl (%ecx),%edx
     c3a:	8d 42 d0             	lea    -0x30(%edx),%eax
     c3d:	3c 09                	cmp    $0x9,%al
     c3f:	b8 00 00 00 00       	mov    $0x0,%eax
     c44:	77 1f                	ja     c65 <atoi+0x35>
     c46:	8d 76 00             	lea    0x0(%esi),%esi
     c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
     c50:	8d 04 80             	lea    (%eax,%eax,4),%eax
     c53:	83 c1 01             	add    $0x1,%ecx
     c56:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     c5a:	0f be 11             	movsbl (%ecx),%edx
     c5d:	8d 5a d0             	lea    -0x30(%edx),%ebx
     c60:	80 fb 09             	cmp    $0x9,%bl
     c63:	76 eb                	jbe    c50 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
     c65:	5b                   	pop    %ebx
     c66:	5d                   	pop    %ebp
     c67:	c3                   	ret    
     c68:	90                   	nop
     c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000c70 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     c70:	55                   	push   %ebp
     c71:	89 e5                	mov    %esp,%ebp
     c73:	56                   	push   %esi
     c74:	53                   	push   %ebx
     c75:	8b 5d 10             	mov    0x10(%ebp),%ebx
     c78:	8b 45 08             	mov    0x8(%ebp),%eax
     c7b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     c7e:	85 db                	test   %ebx,%ebx
     c80:	7e 14                	jle    c96 <memmove+0x26>
     c82:	31 d2                	xor    %edx,%edx
     c84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
     c88:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     c8c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     c8f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     c92:	39 da                	cmp    %ebx,%edx
     c94:	75 f2                	jne    c88 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
     c96:	5b                   	pop    %ebx
     c97:	5e                   	pop    %esi
     c98:	5d                   	pop    %ebp
     c99:	c3                   	ret    

00000c9a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     c9a:	b8 01 00 00 00       	mov    $0x1,%eax
     c9f:	cd 40                	int    $0x40
     ca1:	c3                   	ret    

00000ca2 <exit>:
SYSCALL(exit)
     ca2:	b8 02 00 00 00       	mov    $0x2,%eax
     ca7:	cd 40                	int    $0x40
     ca9:	c3                   	ret    

00000caa <wait>:
SYSCALL(wait)
     caa:	b8 03 00 00 00       	mov    $0x3,%eax
     caf:	cd 40                	int    $0x40
     cb1:	c3                   	ret    

00000cb2 <pipe>:
SYSCALL(pipe)
     cb2:	b8 04 00 00 00       	mov    $0x4,%eax
     cb7:	cd 40                	int    $0x40
     cb9:	c3                   	ret    

00000cba <read>:
SYSCALL(read)
     cba:	b8 05 00 00 00       	mov    $0x5,%eax
     cbf:	cd 40                	int    $0x40
     cc1:	c3                   	ret    

00000cc2 <write>:
SYSCALL(write)
     cc2:	b8 10 00 00 00       	mov    $0x10,%eax
     cc7:	cd 40                	int    $0x40
     cc9:	c3                   	ret    

00000cca <close>:
SYSCALL(close)
     cca:	b8 15 00 00 00       	mov    $0x15,%eax
     ccf:	cd 40                	int    $0x40
     cd1:	c3                   	ret    

00000cd2 <kill>:
SYSCALL(kill)
     cd2:	b8 06 00 00 00       	mov    $0x6,%eax
     cd7:	cd 40                	int    $0x40
     cd9:	c3                   	ret    

00000cda <exec>:
SYSCALL(exec)
     cda:	b8 07 00 00 00       	mov    $0x7,%eax
     cdf:	cd 40                	int    $0x40
     ce1:	c3                   	ret    

00000ce2 <open>:
SYSCALL(open)
     ce2:	b8 0f 00 00 00       	mov    $0xf,%eax
     ce7:	cd 40                	int    $0x40
     ce9:	c3                   	ret    

00000cea <mknod>:
SYSCALL(mknod)
     cea:	b8 11 00 00 00       	mov    $0x11,%eax
     cef:	cd 40                	int    $0x40
     cf1:	c3                   	ret    

00000cf2 <unlink>:
SYSCALL(unlink)
     cf2:	b8 12 00 00 00       	mov    $0x12,%eax
     cf7:	cd 40                	int    $0x40
     cf9:	c3                   	ret    

00000cfa <fstat>:
SYSCALL(fstat)
     cfa:	b8 08 00 00 00       	mov    $0x8,%eax
     cff:	cd 40                	int    $0x40
     d01:	c3                   	ret    

00000d02 <link>:
SYSCALL(link)
     d02:	b8 13 00 00 00       	mov    $0x13,%eax
     d07:	cd 40                	int    $0x40
     d09:	c3                   	ret    

00000d0a <mkdir>:
SYSCALL(mkdir)
     d0a:	b8 14 00 00 00       	mov    $0x14,%eax
     d0f:	cd 40                	int    $0x40
     d11:	c3                   	ret    

00000d12 <chdir>:
SYSCALL(chdir)
     d12:	b8 09 00 00 00       	mov    $0x9,%eax
     d17:	cd 40                	int    $0x40
     d19:	c3                   	ret    

00000d1a <dup>:
SYSCALL(dup)
     d1a:	b8 0a 00 00 00       	mov    $0xa,%eax
     d1f:	cd 40                	int    $0x40
     d21:	c3                   	ret    

00000d22 <getpid>:
SYSCALL(getpid)
     d22:	b8 0b 00 00 00       	mov    $0xb,%eax
     d27:	cd 40                	int    $0x40
     d29:	c3                   	ret    

00000d2a <sbrk>:
SYSCALL(sbrk)
     d2a:	b8 0c 00 00 00       	mov    $0xc,%eax
     d2f:	cd 40                	int    $0x40
     d31:	c3                   	ret    

00000d32 <sleep>:
SYSCALL(sleep)
     d32:	b8 0d 00 00 00       	mov    $0xd,%eax
     d37:	cd 40                	int    $0x40
     d39:	c3                   	ret    

00000d3a <uptime>:
SYSCALL(uptime)
     d3a:	b8 0e 00 00 00       	mov    $0xe,%eax
     d3f:	cd 40                	int    $0x40
     d41:	c3                   	ret    

00000d42 <captsc>:
SYSCALL(captsc)
     d42:	b8 16 00 00 00       	mov    $0x16,%eax
     d47:	cd 40                	int    $0x40
     d49:	c3                   	ret    

00000d4a <freesc>:
SYSCALL(freesc)
     d4a:	b8 17 00 00 00       	mov    $0x17,%eax
     d4f:	cd 40                	int    $0x40
     d51:	c3                   	ret    

00000d52 <updatesc>:
SYSCALL(updatesc)
     d52:	b8 18 00 00 00       	mov    $0x18,%eax
     d57:	cd 40                	int    $0x40
     d59:	c3                   	ret    

00000d5a <getkey>:
SYSCALL(getkey)
     d5a:	b8 19 00 00 00       	mov    $0x19,%eax
     d5f:	cd 40                	int    $0x40
     d61:	c3                   	ret    
     d62:	66 90                	xchg   %ax,%ax
     d64:	66 90                	xchg   %ax,%ax
     d66:	66 90                	xchg   %ax,%ax
     d68:	66 90                	xchg   %ax,%ax
     d6a:	66 90                	xchg   %ax,%ax
     d6c:	66 90                	xchg   %ax,%ax
     d6e:	66 90                	xchg   %ax,%ax

00000d70 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     d70:	55                   	push   %ebp
     d71:	89 e5                	mov    %esp,%ebp
     d73:	57                   	push   %edi
     d74:	56                   	push   %esi
     d75:	53                   	push   %ebx
     d76:	89 c6                	mov    %eax,%esi
     d78:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     d7b:	8b 5d 08             	mov    0x8(%ebp),%ebx
     d7e:	85 db                	test   %ebx,%ebx
     d80:	74 7e                	je     e00 <printint+0x90>
     d82:	89 d0                	mov    %edx,%eax
     d84:	c1 e8 1f             	shr    $0x1f,%eax
     d87:	84 c0                	test   %al,%al
     d89:	74 75                	je     e00 <printint+0x90>
    neg = 1;
    x = -xx;
     d8b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
     d8d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
     d94:	f7 d8                	neg    %eax
     d96:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
     d99:	31 ff                	xor    %edi,%edi
     d9b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
     d9e:	89 ce                	mov    %ecx,%esi
     da0:	eb 08                	jmp    daa <printint+0x3a>
     da2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
     da8:	89 cf                	mov    %ecx,%edi
     daa:	31 d2                	xor    %edx,%edx
     dac:	8d 4f 01             	lea    0x1(%edi),%ecx
     daf:	f7 f6                	div    %esi
     db1:	0f b6 92 20 12 00 00 	movzbl 0x1220(%edx),%edx
  }while((x /= base) != 0);
     db8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
     dba:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
     dbd:	75 e9                	jne    da8 <printint+0x38>
  if(neg)
     dbf:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     dc2:	8b 75 c0             	mov    -0x40(%ebp),%esi
     dc5:	85 c0                	test   %eax,%eax
     dc7:	74 08                	je     dd1 <printint+0x61>
    buf[i++] = '-';
     dc9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
     dce:	8d 4f 02             	lea    0x2(%edi),%ecx
     dd1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
     dd5:	8d 76 00             	lea    0x0(%esi),%esi
     dd8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     ddb:	83 ec 04             	sub    $0x4,%esp
     dde:	83 ef 01             	sub    $0x1,%edi
     de1:	6a 01                	push   $0x1
     de3:	53                   	push   %ebx
     de4:	56                   	push   %esi
     de5:	88 45 d7             	mov    %al,-0x29(%ebp)
     de8:	e8 d5 fe ff ff       	call   cc2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     ded:	83 c4 10             	add    $0x10,%esp
     df0:	39 df                	cmp    %ebx,%edi
     df2:	75 e4                	jne    dd8 <printint+0x68>
    putc(fd, buf[i]);
}
     df4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     df7:	5b                   	pop    %ebx
     df8:	5e                   	pop    %esi
     df9:	5f                   	pop    %edi
     dfa:	5d                   	pop    %ebp
     dfb:	c3                   	ret    
     dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     e00:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     e02:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     e09:	eb 8b                	jmp    d96 <printint+0x26>
     e0b:	90                   	nop
     e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000e10 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     e10:	55                   	push   %ebp
     e11:	89 e5                	mov    %esp,%ebp
     e13:	57                   	push   %edi
     e14:	56                   	push   %esi
     e15:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     e16:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     e19:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     e1c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     e1f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     e22:	89 45 d0             	mov    %eax,-0x30(%ebp)
     e25:	0f b6 1e             	movzbl (%esi),%ebx
     e28:	83 c6 01             	add    $0x1,%esi
     e2b:	84 db                	test   %bl,%bl
     e2d:	0f 84 b0 00 00 00    	je     ee3 <printf+0xd3>
     e33:	31 d2                	xor    %edx,%edx
     e35:	eb 39                	jmp    e70 <printf+0x60>
     e37:	89 f6                	mov    %esi,%esi
     e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     e40:	83 f8 25             	cmp    $0x25,%eax
     e43:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
     e46:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     e4b:	74 18                	je     e65 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     e4d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
     e50:	83 ec 04             	sub    $0x4,%esp
     e53:	88 5d e2             	mov    %bl,-0x1e(%ebp)
     e56:	6a 01                	push   $0x1
     e58:	50                   	push   %eax
     e59:	57                   	push   %edi
     e5a:	e8 63 fe ff ff       	call   cc2 <write>
     e5f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     e62:	83 c4 10             	add    $0x10,%esp
     e65:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     e68:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
     e6c:	84 db                	test   %bl,%bl
     e6e:	74 73                	je     ee3 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
     e70:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
     e72:	0f be cb             	movsbl %bl,%ecx
     e75:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
     e78:	74 c6                	je     e40 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     e7a:	83 fa 25             	cmp    $0x25,%edx
     e7d:	75 e6                	jne    e65 <printf+0x55>
      if(c == 'd'){
     e7f:	83 f8 64             	cmp    $0x64,%eax
     e82:	0f 84 f8 00 00 00    	je     f80 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     e88:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
     e8e:	83 f9 70             	cmp    $0x70,%ecx
     e91:	74 5d                	je     ef0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     e93:	83 f8 73             	cmp    $0x73,%eax
     e96:	0f 84 84 00 00 00    	je     f20 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     e9c:	83 f8 63             	cmp    $0x63,%eax
     e9f:	0f 84 ea 00 00 00    	je     f8f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     ea5:	83 f8 25             	cmp    $0x25,%eax
     ea8:	0f 84 c2 00 00 00    	je     f70 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     eae:	8d 45 e7             	lea    -0x19(%ebp),%eax
     eb1:	83 ec 04             	sub    $0x4,%esp
     eb4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
     eb8:	6a 01                	push   $0x1
     eba:	50                   	push   %eax
     ebb:	57                   	push   %edi
     ebc:	e8 01 fe ff ff       	call   cc2 <write>
     ec1:	83 c4 0c             	add    $0xc,%esp
     ec4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     ec7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
     eca:	6a 01                	push   $0x1
     ecc:	50                   	push   %eax
     ecd:	57                   	push   %edi
     ece:	83 c6 01             	add    $0x1,%esi
     ed1:	e8 ec fd ff ff       	call   cc2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     ed6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     eda:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     edd:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     edf:	84 db                	test   %bl,%bl
     ee1:	75 8d                	jne    e70 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     ee3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ee6:	5b                   	pop    %ebx
     ee7:	5e                   	pop    %esi
     ee8:	5f                   	pop    %edi
     ee9:	5d                   	pop    %ebp
     eea:	c3                   	ret    
     eeb:	90                   	nop
     eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
     ef0:	83 ec 0c             	sub    $0xc,%esp
     ef3:	b9 10 00 00 00       	mov    $0x10,%ecx
     ef8:	6a 00                	push   $0x0
     efa:	8b 5d d0             	mov    -0x30(%ebp),%ebx
     efd:	89 f8                	mov    %edi,%eax
     eff:	8b 13                	mov    (%ebx),%edx
     f01:	e8 6a fe ff ff       	call   d70 <printint>
        ap++;
     f06:	89 d8                	mov    %ebx,%eax
     f08:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     f0b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
     f0d:	83 c0 04             	add    $0x4,%eax
     f10:	89 45 d0             	mov    %eax,-0x30(%ebp)
     f13:	e9 4d ff ff ff       	jmp    e65 <printf+0x55>
     f18:	90                   	nop
     f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
     f20:	8b 45 d0             	mov    -0x30(%ebp),%eax
     f23:	8b 18                	mov    (%eax),%ebx
        ap++;
     f25:	83 c0 04             	add    $0x4,%eax
     f28:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
     f2b:	b8 18 12 00 00       	mov    $0x1218,%eax
     f30:	85 db                	test   %ebx,%ebx
     f32:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
     f35:	0f b6 03             	movzbl (%ebx),%eax
     f38:	84 c0                	test   %al,%al
     f3a:	74 23                	je     f5f <printf+0x14f>
     f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     f40:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     f43:	8d 45 e3             	lea    -0x1d(%ebp),%eax
     f46:	83 ec 04             	sub    $0x4,%esp
     f49:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
     f4b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     f4e:	50                   	push   %eax
     f4f:	57                   	push   %edi
     f50:	e8 6d fd ff ff       	call   cc2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     f55:	0f b6 03             	movzbl (%ebx),%eax
     f58:	83 c4 10             	add    $0x10,%esp
     f5b:	84 c0                	test   %al,%al
     f5d:	75 e1                	jne    f40 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     f5f:	31 d2                	xor    %edx,%edx
     f61:	e9 ff fe ff ff       	jmp    e65 <printf+0x55>
     f66:	8d 76 00             	lea    0x0(%esi),%esi
     f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     f70:	83 ec 04             	sub    $0x4,%esp
     f73:	88 5d e5             	mov    %bl,-0x1b(%ebp)
     f76:	8d 45 e5             	lea    -0x1b(%ebp),%eax
     f79:	6a 01                	push   $0x1
     f7b:	e9 4c ff ff ff       	jmp    ecc <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
     f80:	83 ec 0c             	sub    $0xc,%esp
     f83:	b9 0a 00 00 00       	mov    $0xa,%ecx
     f88:	6a 01                	push   $0x1
     f8a:	e9 6b ff ff ff       	jmp    efa <printf+0xea>
     f8f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     f92:	83 ec 04             	sub    $0x4,%esp
     f95:	8b 03                	mov    (%ebx),%eax
     f97:	6a 01                	push   $0x1
     f99:	88 45 e4             	mov    %al,-0x1c(%ebp)
     f9c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     f9f:	50                   	push   %eax
     fa0:	57                   	push   %edi
     fa1:	e8 1c fd ff ff       	call   cc2 <write>
     fa6:	e9 5b ff ff ff       	jmp    f06 <printf+0xf6>
     fab:	66 90                	xchg   %ax,%ax
     fad:	66 90                	xchg   %ax,%ax
     faf:	90                   	nop

00000fb0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     fb0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fb1:	a1 28 17 00 00       	mov    0x1728,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
     fb6:	89 e5                	mov    %esp,%ebp
     fb8:	57                   	push   %edi
     fb9:	56                   	push   %esi
     fba:	53                   	push   %ebx
     fbb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fbe:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
     fc0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fc3:	39 c8                	cmp    %ecx,%eax
     fc5:	73 19                	jae    fe0 <free+0x30>
     fc7:	89 f6                	mov    %esi,%esi
     fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     fd0:	39 d1                	cmp    %edx,%ecx
     fd2:	72 1c                	jb     ff0 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fd4:	39 d0                	cmp    %edx,%eax
     fd6:	73 18                	jae    ff0 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
     fd8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fda:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fdc:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fde:	72 f0                	jb     fd0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fe0:	39 d0                	cmp    %edx,%eax
     fe2:	72 f4                	jb     fd8 <free+0x28>
     fe4:	39 d1                	cmp    %edx,%ecx
     fe6:	73 f0                	jae    fd8 <free+0x28>
     fe8:	90                   	nop
     fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
     ff0:	8b 73 fc             	mov    -0x4(%ebx),%esi
     ff3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
     ff6:	39 d7                	cmp    %edx,%edi
     ff8:	74 19                	je     1013 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
     ffa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
     ffd:	8b 50 04             	mov    0x4(%eax),%edx
    1000:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1003:	39 f1                	cmp    %esi,%ecx
    1005:	74 23                	je     102a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1007:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1009:	a3 28 17 00 00       	mov    %eax,0x1728
}
    100e:	5b                   	pop    %ebx
    100f:	5e                   	pop    %esi
    1010:	5f                   	pop    %edi
    1011:	5d                   	pop    %ebp
    1012:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1013:	03 72 04             	add    0x4(%edx),%esi
    1016:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1019:	8b 10                	mov    (%eax),%edx
    101b:	8b 12                	mov    (%edx),%edx
    101d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1020:	8b 50 04             	mov    0x4(%eax),%edx
    1023:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1026:	39 f1                	cmp    %esi,%ecx
    1028:	75 dd                	jne    1007 <free+0x57>
    p->s.size += bp->s.size;
    102a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    102d:	a3 28 17 00 00       	mov    %eax,0x1728
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1032:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1035:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1038:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    103a:	5b                   	pop    %ebx
    103b:	5e                   	pop    %esi
    103c:	5f                   	pop    %edi
    103d:	5d                   	pop    %ebp
    103e:	c3                   	ret    
    103f:	90                   	nop

00001040 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1040:	55                   	push   %ebp
    1041:	89 e5                	mov    %esp,%ebp
    1043:	57                   	push   %edi
    1044:	56                   	push   %esi
    1045:	53                   	push   %ebx
    1046:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1049:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    104c:	8b 15 28 17 00 00    	mov    0x1728,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1052:	8d 78 07             	lea    0x7(%eax),%edi
    1055:	c1 ef 03             	shr    $0x3,%edi
    1058:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    105b:	85 d2                	test   %edx,%edx
    105d:	0f 84 a3 00 00 00    	je     1106 <malloc+0xc6>
    1063:	8b 02                	mov    (%edx),%eax
    1065:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1068:	39 cf                	cmp    %ecx,%edi
    106a:	76 74                	jbe    10e0 <malloc+0xa0>
    106c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1072:	be 00 10 00 00       	mov    $0x1000,%esi
    1077:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
    107e:	0f 43 f7             	cmovae %edi,%esi
    1081:	ba 00 80 00 00       	mov    $0x8000,%edx
    1086:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
    108c:	0f 46 da             	cmovbe %edx,%ebx
    108f:	eb 10                	jmp    10a1 <malloc+0x61>
    1091:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1098:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    109a:	8b 48 04             	mov    0x4(%eax),%ecx
    109d:	39 cf                	cmp    %ecx,%edi
    109f:	76 3f                	jbe    10e0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    10a1:	39 05 28 17 00 00    	cmp    %eax,0x1728
    10a7:	89 c2                	mov    %eax,%edx
    10a9:	75 ed                	jne    1098 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    10ab:	83 ec 0c             	sub    $0xc,%esp
    10ae:	53                   	push   %ebx
    10af:	e8 76 fc ff ff       	call   d2a <sbrk>
  if(p == (char*)-1)
    10b4:	83 c4 10             	add    $0x10,%esp
    10b7:	83 f8 ff             	cmp    $0xffffffff,%eax
    10ba:	74 1c                	je     10d8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    10bc:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
    10bf:	83 ec 0c             	sub    $0xc,%esp
    10c2:	83 c0 08             	add    $0x8,%eax
    10c5:	50                   	push   %eax
    10c6:	e8 e5 fe ff ff       	call   fb0 <free>
  return freep;
    10cb:	8b 15 28 17 00 00    	mov    0x1728,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    10d1:	83 c4 10             	add    $0x10,%esp
    10d4:	85 d2                	test   %edx,%edx
    10d6:	75 c0                	jne    1098 <malloc+0x58>
        return 0;
    10d8:	31 c0                	xor    %eax,%eax
    10da:	eb 1c                	jmp    10f8 <malloc+0xb8>
    10dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    10e0:	39 cf                	cmp    %ecx,%edi
    10e2:	74 1c                	je     1100 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    10e4:	29 f9                	sub    %edi,%ecx
    10e6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    10e9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    10ec:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
    10ef:	89 15 28 17 00 00    	mov    %edx,0x1728
      return (void*)(p + 1);
    10f5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    10f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    10fb:	5b                   	pop    %ebx
    10fc:	5e                   	pop    %esi
    10fd:	5f                   	pop    %edi
    10fe:	5d                   	pop    %ebp
    10ff:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    1100:	8b 08                	mov    (%eax),%ecx
    1102:	89 0a                	mov    %ecx,(%edx)
    1104:	eb e9                	jmp    10ef <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    1106:	c7 05 28 17 00 00 2c 	movl   $0x172c,0x1728
    110d:	17 00 00 
    1110:	c7 05 2c 17 00 00 2c 	movl   $0x172c,0x172c
    1117:	17 00 00 
    base.s.size = 0;
    111a:	b8 2c 17 00 00       	mov    $0x172c,%eax
    111f:	c7 05 30 17 00 00 00 	movl   $0x0,0x1730
    1126:	00 00 00 
    1129:	e9 3e ff ff ff       	jmp    106c <malloc+0x2c>
