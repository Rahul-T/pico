
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
      18:	68 00 16 00 00       	push   $0x1600
      1d:	e8 40 0c 00 00       	call   c62 <captsc>
	drawHeader();
      22:	e8 99 02 00 00       	call   2c0 <drawHeader>
	updatesc(50, 0, "                         v0.1 ", UI_COLOR);
}

void
drawFooter() {
	updatesc(0, 24, " ^Q - Quit                                                                      ", UI_COLOR);
      27:	68 c0 00 00 00       	push   $0xc0
      2c:	68 e4 10 00 00       	push   $0x10e4
      31:	6a 18                	push   $0x18
      33:	6a 00                	push   $0x0
      35:	e8 38 0c 00 00       	call   c72 <updatesc>
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
      45:	68 93 10 00 00       	push   $0x1093
      4a:	6a 01                	push   $0x1
      4c:	e8 df 0c 00 00       	call   d30 <printf>
      51:	83 c4 10             	add    $0x10,%esp
      54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	}
	while(1) {
		while ((c = getkey()) <= 0) {
      58:	e8 1d 0c 00 00       	call   c7a <getkey>
      5d:	85 c0                	test   %eax,%eax
      5f:	a3 00 16 00 00       	mov    %eax,0x1600
      64:	7e f2                	jle    58 <main+0x58>
		}
		handleInput(c);
      66:	83 ec 0c             	sub    $0xc,%esp
      69:	50                   	push   %eax
      6a:	e8 c1 07 00 00       	call   830 <handleInput>
		c = 0;
      6f:	c7 05 00 16 00 00 00 	movl   $0x0,0x1600
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
      86:	e8 77 0b 00 00       	call   c02 <open>
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
      9c:	ff 35 28 16 00 00    	pushl  0x1628
      a2:	e8 49 01 00 00       	call   1f0 <printfile>
      a7:	83 c4 10             	add    $0x10,%esp
      aa:	eb ac                	jmp    58 <main+0x58>
	drawFooter();
	int fd;

	if (argc == 2) {
		if((fd = open(argv[1], 0)) < 0){
			printf(1, "Cannot open %s\n", argv[1]);
      ac:	83 ec 04             	sub    $0x4,%esp
      af:	ff 73 04             	pushl  0x4(%ebx)
      b2:	68 83 10 00 00       	push   $0x1083
      b7:	6a 01                	push   $0x1
      b9:	e8 72 0c 00 00       	call   d30 <printf>
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
//struct fileline* tail;

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
//struct fileline* tail;

void
initLinkedList(int fd)
{
      db:	83 ec 38             	sub    $0x38,%esp
	int n;
	char singlechar[1];
	head = malloc(sizeof(struct fileline));
      de:	6a 5c                	push   $0x5c
      e0:	e8 7b 0e 00 00       	call   f60 <malloc>
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
      ea:	a3 28 16 00 00       	mov    %eax,0x1628
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
     109:	e8 cc 0a 00 00       	call   bda <read>
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
     142:	e8 19 0e 00 00       	call   f60 <malloc>
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
			// printf(1, "linenum: %d\n", nmbr);
			linenumber++;
		}
	}

	cur->filelinenum = linenumber;
     170:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     173:	89 03                	mov    %eax,(%ebx)
	linenumber++;
     175:	8d 78 01             	lea    0x1(%eax),%edi
	firstOnScreen = head;
     178:	a1 28 16 00 00       	mov    0x1628,%eax

	struct fileline* temp;

	if(linenumber < 23){
     17d:	83 ff 16             	cmp    $0x16,%edi
		}
	}

	cur->filelinenum = linenumber;
	linenumber++;
	firstOnScreen = head;
     180:	a3 20 16 00 00       	mov    %eax,0x1620

	struct fileline* temp;

	if(linenumber < 23){
     185:	7e 09                	jle    190 <initLinkedList+0xc0>
	// 	printf(1, "%s", cur->line);
	// 	cur = cur->next;
	// }
	// printf(1, "%s", tail->line);

}
     187:	8d 65 f4             	lea    -0xc(%ebp),%esp
     18a:	5b                   	pop    %ebx
     18b:	5e                   	pop    %esi
     18c:	5f                   	pop    %edi
     18d:	5d                   	pop    %ebp
     18e:	c3                   	ret    
     18f:	90                   	nop
	firstOnScreen = head;

	struct fileline* temp;

	if(linenumber < 23){
		temp = malloc(sizeof(struct fileline));
     190:	83 ec 0c             	sub    $0xc,%esp
     193:	6a 5c                	push   $0x5c
     195:	e8 c6 0d 00 00       	call   f60 <malloc>
		cur->next = temp;
		temp->prev = cur;
     19a:	83 c4 10             	add    $0x10,%esp

	struct fileline* temp;

	if(linenumber < 23){
		temp = malloc(sizeof(struct fileline));
		cur->next = temp;
     19d:	89 43 58             	mov    %eax,0x58(%ebx)
	firstOnScreen = head;

	struct fileline* temp;

	if(linenumber < 23){
		temp = malloc(sizeof(struct fileline));
     1a0:	89 c6                	mov    %eax,%esi
		cur->next = temp;
		temp->prev = cur;
     1a2:	89 58 54             	mov    %ebx,0x54(%eax)
     1a5:	31 c0                	xor    %eax,%eax
     1a7:	eb 14                	jmp    1bd <initLinkedList+0xed>
     1a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	}
	linecounter = 0;
	while(linenumber < 23){
		if(linecounter < WIDTH){
			temp->line[linecounter] = ' ';
     1b0:	c6 44 06 04 20       	movb   $0x20,0x4(%esi,%eax,1)
			linecounter++;
     1b5:	83 c0 01             	add    $0x1,%eax
		temp = malloc(sizeof(struct fileline));
		cur->next = temp;
		temp->prev = cur;
	}
	linecounter = 0;
	while(linenumber < 23){
     1b8:	83 ff 17             	cmp    $0x17,%edi
     1bb:	74 ca                	je     187 <initLinkedList+0xb7>
		if(linecounter < WIDTH){
     1bd:	83 f8 4f             	cmp    $0x4f,%eax
     1c0:	7e ee                	jle    1b0 <initLinkedList+0xe0>
			temp->line[linecounter] = ' ';
			linecounter++;
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
     1c2:	83 ec 0c             	sub    $0xc,%esp
     1c5:	6a 5c                	push   $0x5c
     1c7:	e8 94 0d 00 00       	call   f60 <malloc>
			temp->filelinenum = linenumber;
     1cc:	89 3e                	mov    %edi,(%esi)
			linecounter = 0;
			temp->line[linecounter] = ' ';
			linecounter++;
			// int nmbr = (int)(cur->filelinenum);
			// printf(1, "linenum: %d\n", nmbr);
			linenumber++;
     1ce:	83 c4 10             	add    $0x10,%esp
			linecounter++;
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
			temp->filelinenum = linenumber;
			nextline->prev = temp;
     1d1:	89 70 54             	mov    %esi,0x54(%eax)
			linecounter = 0;
			temp->line[linecounter] = ' ';
			linecounter++;
			// int nmbr = (int)(cur->filelinenum);
			// printf(1, "linenum: %d\n", nmbr);
			linenumber++;
     1d4:	83 c7 01             	add    $0x1,%edi
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
			temp->filelinenum = linenumber;
			nextline->prev = temp;
			temp->next = nextline;
     1d7:	89 46 58             	mov    %eax,0x58(%esi)
			temp = nextline;
			linecounter = 0;
			temp->line[linecounter] = ' ';
     1da:	c6 40 04 20          	movb   $0x20,0x4(%eax)
			linecounter++;
			// int nmbr = (int)(cur->filelinenum);
			// printf(1, "linenum: %d\n", nmbr);
			linenumber++;
     1de:	89 c6                	mov    %eax,%esi
			nextline->prev = temp;
			temp->next = nextline;
			temp = nextline;
			linecounter = 0;
			temp->line[linecounter] = ' ';
			linecounter++;
     1e0:	b8 01 00 00 00       	mov    $0x1,%eax
     1e5:	eb d1                	jmp    1b8 <initLinkedList+0xe8>
     1e7:	89 f6                	mov    %esi,%esi
     1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001f0 <printfile>:

}

void
printfile(struct fileline* first)
{
     1f0:	55                   	push   %ebp
     1f1:	89 e5                	mov    %esp,%ebp
     1f3:	53                   	push   %ebx
	struct fileline* cur = first;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
     1f4:	31 db                	xor    %ebx,%ebx

}

void
printfile(struct fileline* first)
{
     1f6:	83 ec 04             	sub    $0x4,%esp
     1f9:	8b 4d 08             	mov    0x8(%ebp),%ecx
	struct fileline* cur = first;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
     1fc:	8b 51 58             	mov    0x58(%ecx),%edx
     1ff:	85 d2                	test   %edx,%edx
     201:	74 4a                	je     24d <printfile+0x5d>
     203:	90                   	nop
     204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     208:	31 c0                	xor    %eax,%eax
     20a:	eb 14                	jmp    220 <printfile+0x30>
     20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		for(int i=0; i<WIDTH; i++){
			if(cur->line[i] == '\0'){
				buf[bufindex] = ' ';
     210:	c6 84 03 40 16 00 00 	movb   $0x20,0x1640(%ebx,%eax,1)
     217:	20 
printfile(struct fileline* first)
{
	struct fileline* cur = first;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
		for(int i=0; i<WIDTH; i++){
     218:	83 c0 01             	add    $0x1,%eax
     21b:	83 f8 50             	cmp    $0x50,%eax
     21e:	74 18                	je     238 <printfile+0x48>
			if(cur->line[i] == '\0'){
     220:	0f b6 54 01 04       	movzbl 0x4(%ecx,%eax,1),%edx
     225:	84 d2                	test   %dl,%dl
     227:	74 e7                	je     210 <printfile+0x20>
				buf[bufindex] = ' ';
			} else{
				buf[bufindex] = cur->line[i];
     229:	88 94 03 40 16 00 00 	mov    %dl,0x1640(%ebx,%eax,1)
printfile(struct fileline* first)
{
	struct fileline* cur = first;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
		for(int i=0; i<WIDTH; i++){
     230:	83 c0 01             	add    $0x1,%eax
     233:	83 f8 50             	cmp    $0x50,%eax
     236:	75 e8                	jne    220 <printfile+0x30>
			} else{
				buf[bufindex] = cur->line[i];
			}
			bufindex++;
		}
		cur = cur->next;
     238:	8b 49 58             	mov    0x58(%ecx),%ecx
     23b:	83 c3 50             	add    $0x50,%ebx
void
printfile(struct fileline* first)
{
	struct fileline* cur = first;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
     23e:	8b 41 58             	mov    0x58(%ecx),%eax
     241:	85 c0                	test   %eax,%eax
     243:	74 08                	je     24d <printfile+0x5d>
     245:	81 fb e0 06 00 00    	cmp    $0x6e0,%ebx
     24b:	75 bb                	jne    208 <printfile+0x18>

void
printfile(struct fileline* first)
{
	struct fileline* cur = first;
	int bufindex = 0;
     24d:	31 c0                	xor    %eax,%eax
     24f:	eb 17                	jmp    268 <printfile+0x78>
     251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		}
		cur = cur->next;
	}
	for(int i=0; i<WIDTH; i++){
			if(cur->line[i] == '\0'){
				buf[bufindex] = ' ';
     258:	c6 84 03 40 16 00 00 	movb   $0x20,0x1640(%ebx,%eax,1)
     25f:	20 
			}
			bufindex++;
		}
		cur = cur->next;
	}
	for(int i=0; i<WIDTH; i++){
     260:	83 c0 01             	add    $0x1,%eax
     263:	83 f8 50             	cmp    $0x50,%eax
     266:	74 18                	je     280 <printfile+0x90>
			if(cur->line[i] == '\0'){
     268:	0f b6 54 01 04       	movzbl 0x4(%ecx,%eax,1),%edx
     26d:	84 d2                	test   %dl,%dl
     26f:	74 e7                	je     258 <printfile+0x68>
				buf[bufindex] = ' ';
			} else{
				buf[bufindex] = cur->line[i];
     271:	88 94 03 40 16 00 00 	mov    %dl,0x1640(%ebx,%eax,1)
			}
			bufindex++;
		}
		cur = cur->next;
	}
	for(int i=0; i<WIDTH; i++){
     278:	83 c0 01             	add    $0x1,%eax
     27b:	83 f8 50             	cmp    $0x50,%eax
     27e:	75 e8                	jne    268 <printfile+0x78>
			bufindex++;
	}
	lastOnScreen = cur;

	buf[bufindex] = '\0';
	printf(1, "asdfasdfdsf: %d", lastOnScreen->filelinenum);
     280:	83 ec 04             	sub    $0x4,%esp
			} else{
				buf[bufindex] = cur->line[i];
			}
			bufindex++;
	}
	lastOnScreen = cur;
     283:	89 0d 24 16 00 00    	mov    %ecx,0x1624

	buf[bufindex] = '\0';
     289:	c6 83 90 16 00 00 00 	movb   $0x0,0x1690(%ebx)
	printf(1, "asdfasdfdsf: %d", lastOnScreen->filelinenum);
     290:	ff 31                	pushl  (%ecx)
     292:	68 50 10 00 00       	push   $0x1050
     297:	6a 01                	push   $0x1
     299:	e8 92 0a 00 00       	call   d30 <printf>
	//printf(1, "%s\n", buf);
	updatesc(0, 1, buf, TEXT_COLOR);
     29e:	6a 07                	push   $0x7
     2a0:	68 40 16 00 00       	push   $0x1640
     2a5:	6a 01                	push   $0x1
     2a7:	6a 00                	push   $0x0
     2a9:	e8 c4 09 00 00       	call   c72 <updatesc>
}
     2ae:	83 c4 20             	add    $0x20,%esp
     2b1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     2b4:	c9                   	leave  
     2b5:	c3                   	ret    
     2b6:	8d 76 00             	lea    0x0(%esi),%esi
     2b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002c0 <drawHeader>:

void
drawHeader() {
     2c0:	55                   	push   %ebp
     2c1:	89 e5                	mov    %esp,%ebp
     2c3:	83 ec 08             	sub    $0x8,%esp
	updatesc(0, 0, "                              ", UI_COLOR);
     2c6:	68 c0 00 00 00       	push   $0xc0
     2cb:	68 a4 10 00 00       	push   $0x10a4
     2d0:	6a 00                	push   $0x0
     2d2:	6a 00                	push   $0x0
     2d4:	e8 99 09 00 00       	call   c72 <updatesc>
	updatesc(30, 0, "        PICO        ", UI_COLOR);
     2d9:	68 c0 00 00 00       	push   $0xc0
     2de:	68 60 10 00 00       	push   $0x1060
     2e3:	6a 00                	push   $0x0
     2e5:	6a 1e                	push   $0x1e
     2e7:	e8 86 09 00 00       	call   c72 <updatesc>
	updatesc(50, 0, "                         v0.1 ", UI_COLOR);
     2ec:	83 c4 20             	add    $0x20,%esp
     2ef:	68 c0 00 00 00       	push   $0xc0
     2f4:	68 c4 10 00 00       	push   $0x10c4
     2f9:	6a 00                	push   $0x0
     2fb:	6a 32                	push   $0x32
     2fd:	e8 70 09 00 00       	call   c72 <updatesc>
}
     302:	83 c4 10             	add    $0x10,%esp
     305:	c9                   	leave  
     306:	c3                   	ret    
     307:	89 f6                	mov    %esi,%esi
     309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000310 <drawFooter>:

void
drawFooter() {
     310:	55                   	push   %ebp
     311:	89 e5                	mov    %esp,%ebp
     313:	83 ec 08             	sub    $0x8,%esp
	updatesc(0, 24, " ^Q - Quit                                                                      ", UI_COLOR);
     316:	68 c0 00 00 00       	push   $0xc0
     31b:	68 e4 10 00 00       	push   $0x10e4
     320:	6a 18                	push   $0x18
     322:	6a 00                	push   $0x0
     324:	e8 49 09 00 00       	call   c72 <updatesc>
}
     329:	83 c4 10             	add    $0x10,%esp
     32c:	c9                   	leave  
     32d:	c3                   	ret    
     32e:	66 90                	xchg   %ax,%ax

00000330 <saveedits>:

void
saveedits(void){
     330:	55                   	push   %ebp
	//Save edits
	struct fileline* cur = firstOnScreen;
     331:	8b 0d 20 16 00 00    	mov    0x1620,%ecx
drawFooter() {
	updatesc(0, 24, " ^Q - Quit                                                                      ", UI_COLOR);
}

void
saveedits(void){
     337:	89 e5                	mov    %esp,%ebp
     339:	56                   	push   %esi
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
     33a:	8b 35 24 16 00 00    	mov    0x1624,%esi
drawFooter() {
	updatesc(0, 24, " ^Q - Quit                                                                      ", UI_COLOR);
}

void
saveedits(void){
     340:	53                   	push   %ebx
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
     341:	3b 4e 58             	cmp    0x58(%esi),%ecx
     344:	74 31                	je     377 <saveedits+0x47>
     346:	31 db                	xor    %ebx,%ebx
     348:	90                   	nop
     349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     350:	31 c0                	xor    %eax,%eax
     352:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		for(int i=0; i<WIDTH; i++){
			cur->line[i] = buf[bufindex];
     358:	0f b6 94 03 40 16 00 	movzbl 0x1640(%ebx,%eax,1),%edx
     35f:	00 
     360:	88 54 01 04          	mov    %dl,0x4(%ecx,%eax,1)
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
		for(int i=0; i<WIDTH; i++){
     364:	83 c0 01             	add    $0x1,%eax
     367:	83 f8 50             	cmp    $0x50,%eax
     36a:	75 ec                	jne    358 <saveedits+0x28>
     36c:	83 c3 50             	add    $0x50,%ebx
			cur->line[i] = buf[bufindex];
			bufindex++;
		}
		cur = cur->next;
     36f:	8b 49 58             	mov    0x58(%ecx),%ecx
void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
     372:	39 4e 58             	cmp    %ecx,0x58(%esi)
     375:	75 d9                	jne    350 <saveedits+0x20>
			cur->line[i] = buf[bufindex];
			bufindex++;
		}
		cur = cur->next;
	}
}
     377:	5b                   	pop    %ebx
     378:	5e                   	pop    %esi
     379:	5d                   	pop    %ebp
     37a:	c3                   	ret    
     37b:	90                   	nop
     37c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000380 <scrolldown>:

void
scrolldown(void){
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
     38b:	8b 35 24 16 00 00    	mov    0x1624,%esi
}

void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
     391:	8b 3d 20 16 00 00    	mov    0x1620,%edi
	int bufindex = 0;
	while(cur != lastOnScreen->next){
     397:	39 7e 58             	cmp    %edi,0x58(%esi)
     39a:	89 f9                	mov    %edi,%ecx
     39c:	74 29                	je     3c7 <scrolldown+0x47>
     39e:	66 90                	xchg   %ax,%ax
     3a0:	31 c0                	xor    %eax,%eax
     3a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		for(int i=0; i<WIDTH; i++){
			cur->line[i] = buf[bufindex];
     3a8:	0f b6 94 03 40 16 00 	movzbl 0x1640(%ebx,%eax,1),%edx
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
     3ba:	75 ec                	jne    3a8 <scrolldown+0x28>
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
     3c5:	75 d9                	jne    3a0 <scrolldown+0x20>
}

void
scrolldown(void){
	saveedits();
	printfile(firstOnScreen->next);
     3c7:	83 ec 0c             	sub    $0xc,%esp
     3ca:	ff 77 58             	pushl  0x58(%edi)
     3cd:	e8 1e fe ff ff       	call   1f0 <printfile>
	firstOnScreen = firstOnScreen->next;
     3d2:	a1 20 16 00 00       	mov    0x1620,%eax
     3d7:	8b 40 58             	mov    0x58(%eax),%eax
     3da:	a3 20 16 00 00       	mov    %eax,0x1620
}
     3df:	8d 65 f4             	lea    -0xc(%ebp),%esp
     3e2:	5b                   	pop    %ebx
     3e3:	5e                   	pop    %esi
     3e4:	5f                   	pop    %edi
     3e5:	5d                   	pop    %ebp
     3e6:	c3                   	ret    
     3e7:	89 f6                	mov    %esi,%esi
     3e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003f0 <scrollup>:

void
scrollup(void){
     3f0:	55                   	push   %ebp
     3f1:	89 e5                	mov    %esp,%ebp
     3f3:	57                   	push   %edi
     3f4:	56                   	push   %esi
     3f5:	53                   	push   %ebx
     3f6:	31 db                	xor    %ebx,%ebx
     3f8:	83 ec 0c             	sub    $0xc,%esp
void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
     3fb:	8b 35 24 16 00 00    	mov    0x1624,%esi
}

void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
     401:	8b 3d 20 16 00 00    	mov    0x1620,%edi
	int bufindex = 0;
	while(cur != lastOnScreen->next){
     407:	39 7e 58             	cmp    %edi,0x58(%esi)
     40a:	89 f9                	mov    %edi,%ecx
     40c:	74 29                	je     437 <scrollup+0x47>
     40e:	66 90                	xchg   %ax,%ax
     410:	31 c0                	xor    %eax,%eax
     412:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		for(int i=0; i<WIDTH; i++){
			cur->line[i] = buf[bufindex];
     418:	0f b6 94 03 40 16 00 	movzbl 0x1640(%ebx,%eax,1),%edx
     41f:	00 
     420:	88 54 01 04          	mov    %dl,0x4(%ecx,%eax,1)
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
		for(int i=0; i<WIDTH; i++){
     424:	83 c0 01             	add    $0x1,%eax
     427:	83 f8 50             	cmp    $0x50,%eax
     42a:	75 ec                	jne    418 <scrollup+0x28>
     42c:	83 c3 50             	add    $0x50,%ebx
			cur->line[i] = buf[bufindex];
			bufindex++;
		}
		cur = cur->next;
     42f:	8b 49 58             	mov    0x58(%ecx),%ecx
void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
     432:	3b 4e 58             	cmp    0x58(%esi),%ecx
     435:	75 d9                	jne    410 <scrollup+0x20>
}

void
scrollup(void){
	saveedits();
	printfile(firstOnScreen->prev);
     437:	83 ec 0c             	sub    $0xc,%esp
     43a:	ff 77 54             	pushl  0x54(%edi)
     43d:	e8 ae fd ff ff       	call   1f0 <printfile>
	firstOnScreen = firstOnScreen->prev;
     442:	a1 20 16 00 00       	mov    0x1620,%eax
     447:	8b 40 54             	mov    0x54(%eax),%eax
     44a:	a3 20 16 00 00       	mov    %eax,0x1620
}
     44f:	8d 65 f4             	lea    -0xc(%ebp),%esp
     452:	5b                   	pop    %ebx
     453:	5e                   	pop    %esi
     454:	5f                   	pop    %edi
     455:	5d                   	pop    %ebp
     456:	c3                   	ret    
     457:	89 f6                	mov    %esi,%esi
     459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000460 <arrowkeys>:

void
arrowkeys(int i){
     460:	55                   	push   %ebp
     461:	89 e5                	mov    %esp,%ebp
     463:	8b 45 08             	mov    0x8(%ebp),%eax
	//ctrl+j (go left)
	if(i == 10 && (currChar % WIDTH != 0) && currChar > 0){
     466:	83 f8 0a             	cmp    $0xa,%eax
     469:	0f 84 81 00 00 00    	je     4f0 <arrowkeys+0x90>
		currChar--;
	}
	//ctrl+l (go right)
	else if(i==12 && ((currChar+1) % WIDTH != 0)){
     46f:	83 f8 0c             	cmp    $0xc,%eax
     472:	74 2c                	je     4a0 <arrowkeys+0x40>
		currChar++;
	}
	//ctrl+k (go down)
	else if(i == 11){
     474:	83 f8 0b             	cmp    $0xb,%eax
     477:	74 57                	je     4d0 <arrowkeys+0x70>
			if(lastOnScreen->next != 0)
				scrolldown();
		}
	}
	//ctrl+i (go up)
	else if(i == 9){
     479:	83 f8 09             	cmp    $0x9,%eax
     47c:	75 47                	jne    4c5 <arrowkeys+0x65>
		if(currChar >= WIDTH){
     47e:	a1 04 16 00 00       	mov    0x1604,%eax
     483:	83 f8 4f             	cmp    $0x4f,%eax
     486:	0f 8f b4 00 00 00    	jg     540 <arrowkeys+0xe0>
			currChar -= WIDTH;
		}
		else{
			if(firstOnScreen->prev != 0)
     48c:	a1 20 16 00 00       	mov    0x1620,%eax
     491:	8b 40 54             	mov    0x54(%eax),%eax
     494:	85 c0                	test   %eax,%eax
     496:	74 2d                	je     4c5 <arrowkeys+0x65>
				scrollup();
		}
	}
}
     498:	5d                   	pop    %ebp
		if(currChar >= WIDTH){
			currChar -= WIDTH;
		}
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
     499:	e9 52 ff ff ff       	jmp    3f0 <scrollup>
     49e:	66 90                	xchg   %ax,%ax
	//ctrl+j (go left)
	if(i == 10 && (currChar % WIDTH != 0) && currChar > 0){
		currChar--;
	}
	//ctrl+l (go right)
	else if(i==12 && ((currChar+1) % WIDTH != 0)){
     4a0:	a1 04 16 00 00       	mov    0x1604,%eax
     4a5:	ba 67 66 66 66       	mov    $0x66666667,%edx
     4aa:	8d 48 01             	lea    0x1(%eax),%ecx
     4ad:	89 c8                	mov    %ecx,%eax
     4af:	f7 ea                	imul   %edx
     4b1:	89 c8                	mov    %ecx,%eax
     4b3:	c1 f8 1f             	sar    $0x1f,%eax
     4b6:	c1 fa 05             	sar    $0x5,%edx
     4b9:	29 c2                	sub    %eax,%edx
     4bb:	8d 04 92             	lea    (%edx,%edx,4),%eax
     4be:	c1 e0 04             	shl    $0x4,%eax
     4c1:	39 c1                	cmp    %eax,%ecx
     4c3:	75 63                	jne    528 <arrowkeys+0xc8>
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
}
     4c5:	5d                   	pop    %ebp
     4c6:	c3                   	ret    
     4c7:	89 f6                	mov    %esi,%esi
     4c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	else if(i==12 && ((currChar+1) % WIDTH != 0)){
		currChar++;
	}
	//ctrl+k (go down)
	else if(i == 11){
		if(currChar < TOTAL_CHARS - WIDTH){
     4d0:	a1 04 16 00 00       	mov    0x1604,%eax
     4d5:	3d df 06 00 00       	cmp    $0x6df,%eax
     4da:	7e 54                	jle    530 <arrowkeys+0xd0>
			currChar += WIDTH;
		}
		else{
			if(lastOnScreen->next != 0)
     4dc:	a1 24 16 00 00       	mov    0x1624,%eax
     4e1:	8b 50 58             	mov    0x58(%eax),%edx
     4e4:	85 d2                	test   %edx,%edx
     4e6:	74 dd                	je     4c5 <arrowkeys+0x65>
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
}
     4e8:	5d                   	pop    %ebp
		if(currChar < TOTAL_CHARS - WIDTH){
			currChar += WIDTH;
		}
		else{
			if(lastOnScreen->next != 0)
				scrolldown();
     4e9:	e9 92 fe ff ff       	jmp    380 <scrolldown>
     4ee:	66 90                	xchg   %ax,%ax
}

void
arrowkeys(int i){
	//ctrl+j (go left)
	if(i == 10 && (currChar % WIDTH != 0) && currChar > 0){
     4f0:	8b 0d 04 16 00 00    	mov    0x1604,%ecx
     4f6:	ba 67 66 66 66       	mov    $0x66666667,%edx
     4fb:	89 c8                	mov    %ecx,%eax
     4fd:	f7 ea                	imul   %edx
     4ff:	89 c8                	mov    %ecx,%eax
     501:	c1 f8 1f             	sar    $0x1f,%eax
     504:	c1 fa 05             	sar    $0x5,%edx
     507:	29 c2                	sub    %eax,%edx
     509:	8d 04 92             	lea    (%edx,%edx,4),%eax
     50c:	c1 e0 04             	shl    $0x4,%eax
     50f:	39 c1                	cmp    %eax,%ecx
     511:	74 b2                	je     4c5 <arrowkeys+0x65>
     513:	85 c9                	test   %ecx,%ecx
     515:	7e ae                	jle    4c5 <arrowkeys+0x65>
		currChar--;
     517:	83 e9 01             	sub    $0x1,%ecx
     51a:	89 0d 04 16 00 00    	mov    %ecx,0x1604
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
}
     520:	5d                   	pop    %ebp
     521:	c3                   	ret    
     522:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	if(i == 10 && (currChar % WIDTH != 0) && currChar > 0){
		currChar--;
	}
	//ctrl+l (go right)
	else if(i==12 && ((currChar+1) % WIDTH != 0)){
		currChar++;
     528:	89 0d 04 16 00 00    	mov    %ecx,0x1604
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
}
     52e:	5d                   	pop    %ebp
     52f:	c3                   	ret    
		currChar++;
	}
	//ctrl+k (go down)
	else if(i == 11){
		if(currChar < TOTAL_CHARS - WIDTH){
			currChar += WIDTH;
     530:	83 c0 50             	add    $0x50,%eax
     533:	a3 04 16 00 00       	mov    %eax,0x1604
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
}
     538:	5d                   	pop    %ebp
     539:	c3                   	ret    
     53a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		}
	}
	//ctrl+i (go up)
	else if(i == 9){
		if(currChar >= WIDTH){
			currChar -= WIDTH;
     540:	83 e8 50             	sub    $0x50,%eax
     543:	a3 04 16 00 00       	mov    %eax,0x1604
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
}
     548:	5d                   	pop    %ebp
     549:	c3                   	ret    
     54a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000550 <cutline>:


void
cutline(void){
     550:	55                   	push   %ebp
	int line = currChar/WIDTH;
     551:	ba 67 66 66 66       	mov    $0x66666667,%edx
	}
}


void
cutline(void){
     556:	89 e5                	mov    %esp,%ebp
     558:	53                   	push   %ebx
     559:	83 ec 04             	sub    $0x4,%esp
	int line = currChar/WIDTH;
     55c:	8b 0d 04 16 00 00    	mov    0x1604,%ecx
     562:	89 c8                	mov    %ecx,%eax
     564:	c1 f9 1f             	sar    $0x1f,%ecx
     567:	f7 ea                	imul   %edx
     569:	c1 fa 05             	sar    $0x5,%edx
     56c:	29 ca                	sub    %ecx,%edx
	struct fileline* cur = firstOnScreen;
     56e:	8b 0d 20 16 00 00    	mov    0x1620,%ecx
	for(int i=0; i<line; i++){
     574:	85 d2                	test   %edx,%edx


void
cutline(void){
	int line = currChar/WIDTH;
	struct fileline* cur = firstOnScreen;
     576:	89 cb                	mov    %ecx,%ebx
	for(int i=0; i<line; i++){
     578:	7e 10                	jle    58a <cutline+0x3a>
     57a:	31 c0                	xor    %eax,%eax
     57c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     580:	83 c0 01             	add    $0x1,%eax
		cur = cur->next;
     583:	8b 5b 58             	mov    0x58(%ebx),%ebx

void
cutline(void){
	int line = currChar/WIDTH;
	struct fileline* cur = firstOnScreen;
	for(int i=0; i<line; i++){
     586:	39 c2                	cmp    %eax,%edx
     588:	75 f6                	jne    580 <cutline+0x30>
		cur = cur->next;
	}
	if(lastOnScreen->next == 0){
     58a:	a1 24 16 00 00       	mov    0x1624,%eax
     58f:	8b 40 58             	mov    0x58(%eax),%eax
     592:	85 c0                	test   %eax,%eax
     594:	74 6a                	je     600 <cutline+0xb0>
			printfile(firstOnScreen);
			return;
		}
	}
	struct fileline* temp = cur;
	while(temp != 0){
     596:	85 db                	test   %ebx,%ebx
     598:	89 d8                	mov    %ebx,%eax
     59a:	74 0e                	je     5aa <cutline+0x5a>
     59c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		temp->filelinenum = temp->filelinenum-1;
     5a0:	83 28 01             	subl   $0x1,(%eax)
		temp = temp->next;
     5a3:	8b 40 58             	mov    0x58(%eax),%eax
			printfile(firstOnScreen);
			return;
		}
	}
	struct fileline* temp = cur;
	while(temp != 0){
     5a6:	85 c0                	test   %eax,%eax
     5a8:	75 f6                	jne    5a0 <cutline+0x50>
		temp->filelinenum = temp->filelinenum-1;
		temp = temp->next;
	}
	if(firstOnScreen == cur){
     5aa:	3b 1d 20 16 00 00    	cmp    0x1620,%ebx
     5b0:	74 5e                	je     610 <cutline+0xc0>
		firstOnScreen = cur->next;
	}
	if(lastOnScreen == cur){
     5b2:	3b 1d 24 16 00 00    	cmp    0x1624,%ebx
     5b8:	8b 43 58             	mov    0x58(%ebx),%eax
     5bb:	74 63                	je     620 <cutline+0xd0>
		} 
		else if(cur->prev != 0){
			lastOnScreen = cur->prev;
		}
	}
	if(head == cur){
     5bd:	3b 1d 28 16 00 00    	cmp    0x1628,%ebx
     5c3:	8b 53 54             	mov    0x54(%ebx),%edx
     5c6:	74 70                	je     638 <cutline+0xe8>
		head = cur->next;
	}
	if(cur->prev != 0){
     5c8:	85 d2                	test   %edx,%edx
     5ca:	74 06                	je     5d2 <cutline+0x82>
		cur->prev->next = cur->next;
     5cc:	89 42 58             	mov    %eax,0x58(%edx)
     5cf:	8b 43 58             	mov    0x58(%ebx),%eax
	}
	if(cur->next != 0){
     5d2:	85 c0                	test   %eax,%eax
     5d4:	74 06                	je     5dc <cutline+0x8c>
		cur->next->prev = cur->prev;
     5d6:	8b 53 54             	mov    0x54(%ebx),%edx
     5d9:	89 50 54             	mov    %edx,0x54(%eax)
	}
	free(cur);
     5dc:	83 ec 0c             	sub    $0xc,%esp
     5df:	53                   	push   %ebx
     5e0:	e8 eb 08 00 00       	call   ed0 <free>
	printfile(firstOnScreen);
     5e5:	58                   	pop    %eax
     5e6:	ff 35 20 16 00 00    	pushl  0x1620
     5ec:	e8 ff fb ff ff       	call   1f0 <printfile>
     5f1:	83 c4 10             	add    $0x10,%esp
}
     5f4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     5f7:	c9                   	leave  
     5f8:	c3                   	ret    
     5f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	struct fileline* cur = firstOnScreen;
	for(int i=0; i<line; i++){
		cur = cur->next;
	}
	if(lastOnScreen->next == 0){
		if(firstOnScreen->prev != 0){
     600:	8b 51 54             	mov    0x54(%ecx),%edx
     603:	85 d2                	test   %edx,%edx
     605:	74 38                	je     63f <cutline+0xef>
			scrollup();
     607:	e8 e4 fd ff ff       	call   3f0 <scrollup>
     60c:	eb 88                	jmp    596 <cutline+0x46>
     60e:	66 90                	xchg   %ax,%ax
		temp = temp->next;
	}
	if(firstOnScreen == cur){
		firstOnScreen = cur->next;
	}
	if(lastOnScreen == cur){
     610:	3b 1d 24 16 00 00    	cmp    0x1624,%ebx
	while(temp != 0){
		temp->filelinenum = temp->filelinenum-1;
		temp = temp->next;
	}
	if(firstOnScreen == cur){
		firstOnScreen = cur->next;
     616:	8b 43 58             	mov    0x58(%ebx),%eax
     619:	a3 20 16 00 00       	mov    %eax,0x1620
	}
	if(lastOnScreen == cur){
     61e:	75 9d                	jne    5bd <cutline+0x6d>
		if(cur->next != 0){
     620:	85 c0                	test   %eax,%eax
     622:	74 3c                	je     660 <cutline+0x110>
		} 
		else if(cur->prev != 0){
			lastOnScreen = cur->prev;
		}
	}
	if(head == cur){
     624:	3b 1d 28 16 00 00    	cmp    0x1628,%ebx
	if(firstOnScreen == cur){
		firstOnScreen = cur->next;
	}
	if(lastOnScreen == cur){
		if(cur->next != 0){
			lastOnScreen = cur->next;
     62a:	a3 24 16 00 00       	mov    %eax,0x1624
     62f:	8b 53 54             	mov    0x54(%ebx),%edx
		} 
		else if(cur->prev != 0){
			lastOnScreen = cur->prev;
		}
	}
	if(head == cur){
     632:	75 94                	jne    5c8 <cutline+0x78>
     634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		head = cur->next;
     638:	a3 28 16 00 00       	mov    %eax,0x1628
     63d:	eb 89                	jmp    5c8 <cutline+0x78>
     63f:	8d 43 04             	lea    0x4(%ebx),%eax
     642:	83 c3 54             	add    $0x54,%ebx
     645:	8d 76 00             	lea    0x0(%esi),%esi
	if(lastOnScreen->next == 0){
		if(firstOnScreen->prev != 0){
			scrollup();
		} else {
			for(int i=0; i<WIDTH; i++){
				cur->line[i] = ' ';
     648:	c6 00 20             	movb   $0x20,(%eax)
     64b:	83 c0 01             	add    $0x1,%eax
	}
	if(lastOnScreen->next == 0){
		if(firstOnScreen->prev != 0){
			scrollup();
		} else {
			for(int i=0; i<WIDTH; i++){
     64e:	39 d8                	cmp    %ebx,%eax
     650:	75 f6                	jne    648 <cutline+0xf8>
				cur->line[i] = ' ';
			}
			printfile(firstOnScreen);
     652:	83 ec 0c             	sub    $0xc,%esp
     655:	51                   	push   %ecx
     656:	e8 95 fb ff ff       	call   1f0 <printfile>
			return;
     65b:	83 c4 10             	add    $0x10,%esp
     65e:	eb 94                	jmp    5f4 <cutline+0xa4>
	}
	if(lastOnScreen == cur){
		if(cur->next != 0){
			lastOnScreen = cur->next;
		} 
		else if(cur->prev != 0){
     660:	8b 53 54             	mov    0x54(%ebx),%edx
     663:	85 d2                	test   %edx,%edx
     665:	74 14                	je     67b <cutline+0x12b>
			lastOnScreen = cur->prev;
		}
	}
	if(head == cur){
     667:	3b 1d 28 16 00 00    	cmp    0x1628,%ebx
	if(lastOnScreen == cur){
		if(cur->next != 0){
			lastOnScreen = cur->next;
		} 
		else if(cur->prev != 0){
			lastOnScreen = cur->prev;
     66d:	89 15 24 16 00 00    	mov    %edx,0x1624
		}
	}
	if(head == cur){
     673:	0f 85 53 ff ff ff    	jne    5cc <cutline+0x7c>
     679:	eb bd                	jmp    638 <cutline+0xe8>
     67b:	3b 1d 28 16 00 00    	cmp    0x1628,%ebx
     681:	0f 85 55 ff ff ff    	jne    5dc <cutline+0x8c>
     687:	eb af                	jmp    638 <cutline+0xe8>
     689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000690 <newline>:
	printfile(firstOnScreen);
}

void
newline(void)
{
     690:	55                   	push   %ebp
     691:	89 e5                	mov    %esp,%ebp
     693:	57                   	push   %edi
     694:	56                   	push   %esi
     695:	53                   	push   %ebx
     696:	31 f6                	xor    %esi,%esi
     698:	83 ec 0c             	sub    $0xc,%esp
void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
     69b:	8b 3d 24 16 00 00    	mov    0x1624,%edi
}

void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
     6a1:	8b 1d 20 16 00 00    	mov    0x1620,%ebx
	int bufindex = 0;
	while(cur != lastOnScreen->next){
     6a7:	3b 5f 58             	cmp    0x58(%edi),%ebx
     6aa:	89 d9                	mov    %ebx,%ecx
     6ac:	74 29                	je     6d7 <newline+0x47>
     6ae:	66 90                	xchg   %ax,%ax
     6b0:	31 c0                	xor    %eax,%eax
     6b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		for(int i=0; i<WIDTH; i++){
			cur->line[i] = buf[bufindex];
     6b8:	0f b6 94 06 40 16 00 	movzbl 0x1640(%esi,%eax,1),%edx
     6bf:	00 
     6c0:	88 54 01 04          	mov    %dl,0x4(%ecx,%eax,1)
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
		for(int i=0; i<WIDTH; i++){
     6c4:	83 c0 01             	add    $0x1,%eax
     6c7:	83 f8 50             	cmp    $0x50,%eax
     6ca:	75 ec                	jne    6b8 <newline+0x28>
     6cc:	83 c6 50             	add    $0x50,%esi
			cur->line[i] = buf[bufindex];
			bufindex++;
		}
		cur = cur->next;
     6cf:	8b 49 58             	mov    0x58(%ecx),%ecx
void
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
     6d2:	3b 4f 58             	cmp    0x58(%edi),%ecx
     6d5:	75 d9                	jne    6b0 <newline+0x20>

void
newline(void)
{
	saveedits();
	int line = currChar/WIDTH;
     6d7:	8b 0d 04 16 00 00    	mov    0x1604,%ecx
     6dd:	ba 67 66 66 66       	mov    $0x66666667,%edx
     6e2:	89 c8                	mov    %ecx,%eax
     6e4:	f7 ea                	imul   %edx
     6e6:	89 c8                	mov    %ecx,%eax
     6e8:	c1 f8 1f             	sar    $0x1f,%eax
     6eb:	c1 fa 05             	sar    $0x5,%edx
     6ee:	29 c2                	sub    %eax,%edx
	struct fileline* cur = firstOnScreen;
	for(int i=0; i<line; i++){
     6f0:	31 c0                	xor    %eax,%eax
     6f2:	85 d2                	test   %edx,%edx
     6f4:	7e 14                	jle    70a <newline+0x7a>
     6f6:	8d 76 00             	lea    0x0(%esi),%esi
     6f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     700:	83 c0 01             	add    $0x1,%eax
		cur = cur->next;
     703:	8b 5b 58             	mov    0x58(%ebx),%ebx
newline(void)
{
	saveedits();
	int line = currChar/WIDTH;
	struct fileline* cur = firstOnScreen;
	for(int i=0; i<line; i++){
     706:	39 c2                	cmp    %eax,%edx
     708:	75 f6                	jne    700 <newline+0x70>
		cur = cur->next;
	}
	int linechar = currChar % WIDTH;
     70a:	89 c8                	mov    %ecx,%eax
     70c:	ba 67 66 66 66       	mov    $0x66666667,%edx
     711:	f7 ea                	imul   %edx
     713:	89 c8                	mov    %ecx,%eax
     715:	c1 f8 1f             	sar    $0x1f,%eax
     718:	c1 fa 05             	sar    $0x5,%edx
     71b:	89 d6                	mov    %edx,%esi
     71d:	29 c6                	sub    %eax,%esi
     71f:	8d 04 b6             	lea    (%esi,%esi,4),%eax
	//enter pressed in any column except first
	if(linechar != 0){
     722:	89 ce                	mov    %ecx,%esi
	int line = currChar/WIDTH;
	struct fileline* cur = firstOnScreen;
	for(int i=0; i<line; i++){
		cur = cur->next;
	}
	int linechar = currChar % WIDTH;
     724:	c1 e0 04             	shl    $0x4,%eax
	//enter pressed in any column except first
	if(linechar != 0){
     727:	29 c6                	sub    %eax,%esi
     729:	74 77                	je     7a2 <newline+0x112>
		struct fileline* newfileline = malloc(sizeof(struct fileline));
     72b:	83 ec 0c             	sub    $0xc,%esp
     72e:	6a 5c                	push   $0x5c
     730:	e8 2b 08 00 00       	call   f60 <malloc>
		int i = 0;
		for(i = 0; linechar<WIDTH; i++, linechar++){
			newfileline->line[i] = cur->line[linechar];
     735:	89 c7                	mov    %eax,%edi
		cur = cur->next;
	}
	int linechar = currChar % WIDTH;
	//enter pressed in any column except first
	if(linechar != 0){
		struct fileline* newfileline = malloc(sizeof(struct fileline));
     737:	83 c4 10             	add    $0x10,%esp
     73a:	89 f2                	mov    %esi,%edx
		int i = 0;
		for(i = 0; linechar<WIDTH; i++, linechar++){
			newfileline->line[i] = cur->line[linechar];
     73c:	29 f7                	sub    %esi,%edi
     73e:	66 90                	xchg   %ax,%ax
     740:	0f b6 4c 13 04       	movzbl 0x4(%ebx,%edx,1),%ecx
     745:	88 4c 17 04          	mov    %cl,0x4(%edi,%edx,1)
			cur->line[linechar] = ' ';
     749:	c6 44 13 04 20       	movb   $0x20,0x4(%ebx,%edx,1)
	int linechar = currChar % WIDTH;
	//enter pressed in any column except first
	if(linechar != 0){
		struct fileline* newfileline = malloc(sizeof(struct fileline));
		int i = 0;
		for(i = 0; linechar<WIDTH; i++, linechar++){
     74e:	83 c2 01             	add    $0x1,%edx
     751:	83 fa 50             	cmp    $0x50,%edx
     754:	75 ea                	jne    740 <newline+0xb0>
			newfileline->line[i] = cur->line[linechar];
			cur->line[linechar] = ' ';
		}
		for(int j = i; j<WIDTH; j++){
     756:	85 f6                	test   %esi,%esi
     758:	74 18                	je     772 <newline+0xe2>
     75a:	89 c2                	mov    %eax,%edx
     75c:	8d 48 54             	lea    0x54(%eax),%ecx
     75f:	29 f2                	sub    %esi,%edx
     761:	83 c2 54             	add    $0x54,%edx
     764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
			newfileline->line[j] = ' ';
     768:	c6 02 20             	movb   $0x20,(%edx)
     76b:	83 c2 01             	add    $0x1,%edx
		int i = 0;
		for(i = 0; linechar<WIDTH; i++, linechar++){
			newfileline->line[i] = cur->line[linechar];
			cur->line[linechar] = ' ';
		}
		for(int j = i; j<WIDTH; j++){
     76e:	39 ca                	cmp    %ecx,%edx
     770:	75 f6                	jne    768 <newline+0xd8>
			newfileline->line[j] = ' ';
		}
		newfileline->next = cur->next;
     772:	8b 53 58             	mov    0x58(%ebx),%edx
		newfileline->prev = cur;
     775:	89 58 54             	mov    %ebx,0x54(%eax)
			cur->line[linechar] = ' ';
		}
		for(int j = i; j<WIDTH; j++){
			newfileline->line[j] = ' ';
		}
		newfileline->next = cur->next;
     778:	89 50 58             	mov    %edx,0x58(%eax)
		newfileline->prev = cur;
		if(cur->next != 0){
     77b:	8b 53 58             	mov    0x58(%ebx),%edx
     77e:	85 d2                	test   %edx,%edx
     780:	0f 84 8d 00 00 00    	je     813 <newline+0x183>
			cur->next->prev = newfileline;
     786:	89 42 54             	mov    %eax,0x54(%edx)
		} else {
			lastOnScreen = newfileline;
		}
		cur->next = newfileline;
		newfileline->filelinenum = cur->filelinenum;
     789:	8b 13                	mov    (%ebx),%edx
		if(cur->next != 0){
			cur->next->prev = newfileline;
		} else {
			lastOnScreen = newfileline;
		}
		cur->next = newfileline;
     78b:	89 43 58             	mov    %eax,0x58(%ebx)
		newfileline->filelinenum = cur->filelinenum;
     78e:	89 10                	mov    %edx,(%eax)
     790:	eb 02                	jmp    794 <newline+0x104>
     792:	8b 10                	mov    (%eax),%edx
		struct fileline* temp = newfileline;
		while(temp != 0){
			temp->filelinenum = temp->filelinenum + 1;
     794:	83 c2 01             	add    $0x1,%edx
     797:	89 10                	mov    %edx,(%eax)
			temp = temp->next;
     799:	8b 40 58             	mov    0x58(%eax),%eax
			lastOnScreen = newfileline;
		}
		cur->next = newfileline;
		newfileline->filelinenum = cur->filelinenum;
		struct fileline* temp = newfileline;
		while(temp != 0){
     79c:	85 c0                	test   %eax,%eax
     79e:	75 f2                	jne    792 <newline+0x102>
     7a0:	eb 58                	jmp    7fa <newline+0x16a>
		}
	} 
	//enter was pressed in first column
	else
	{
		struct fileline* newfileline = malloc(sizeof(struct fileline));
     7a2:	83 ec 0c             	sub    $0xc,%esp
     7a5:	6a 5c                	push   $0x5c
     7a7:	e8 b4 07 00 00       	call   f60 <malloc>
     7ac:	8d 50 04             	lea    0x4(%eax),%edx
     7af:	8d 48 54             	lea    0x54(%eax),%ecx
     7b2:	83 c4 10             	add    $0x10,%esp
     7b5:	8d 76 00             	lea    0x0(%esi),%esi
		int i = 0;
		for(i = 0; linechar<WIDTH; i++, linechar++){
			newfileline->line[i] = ' ';
     7b8:	c6 02 20             	movb   $0x20,(%edx)
     7bb:	83 c2 01             	add    $0x1,%edx
	//enter was pressed in first column
	else
	{
		struct fileline* newfileline = malloc(sizeof(struct fileline));
		int i = 0;
		for(i = 0; linechar<WIDTH; i++, linechar++){
     7be:	39 ca                	cmp    %ecx,%edx
     7c0:	75 f6                	jne    7b8 <newline+0x128>
			newfileline->line[i] = ' ';
		}
		newfileline->next = cur;
     7c2:	89 58 58             	mov    %ebx,0x58(%eax)
		newfileline->prev = cur->prev;
     7c5:	8b 53 54             	mov    0x54(%ebx),%edx
     7c8:	89 50 54             	mov    %edx,0x54(%eax)
		if(cur->prev != 0){
     7cb:	8b 53 54             	mov    0x54(%ebx),%edx
     7ce:	85 d2                	test   %edx,%edx
     7d0:	74 4b                	je     81d <newline+0x18d>
			cur->prev->next = newfileline;
     7d2:	89 42 58             	mov    %eax,0x58(%edx)
		} else {
			firstOnScreen = newfileline;
		}
		cur->prev = newfileline;
		newfileline->filelinenum = cur->filelinenum;
     7d5:	8b 13                	mov    (%ebx),%edx
		if(cur->prev != 0){
			cur->prev->next = newfileline;
		} else {
			firstOnScreen = newfileline;
		}
		cur->prev = newfileline;
     7d7:	89 43 54             	mov    %eax,0x54(%ebx)
		newfileline->filelinenum = cur->filelinenum;
     7da:	89 10                	mov    %edx,(%eax)
		struct fileline* temp = newfileline->next;
     7dc:	8b 40 58             	mov    0x58(%eax),%eax
		while(temp != 0){
     7df:	85 c0                	test   %eax,%eax
     7e1:	74 0a                	je     7ed <newline+0x15d>
			temp->filelinenum = temp->filelinenum + 1;
     7e3:	83 00 01             	addl   $0x1,(%eax)
			temp = temp->next;
     7e6:	8b 40 58             	mov    0x58(%eax),%eax
			firstOnScreen = newfileline;
		}
		cur->prev = newfileline;
		newfileline->filelinenum = cur->filelinenum;
		struct fileline* temp = newfileline->next;
		while(temp != 0){
     7e9:	85 c0                	test   %eax,%eax
     7eb:	75 f6                	jne    7e3 <newline+0x153>
			temp->filelinenum = temp->filelinenum + 1;
			temp = temp->next;
		}
		lastOnScreen = lastOnScreen->prev;
     7ed:	a1 24 16 00 00       	mov    0x1624,%eax
     7f2:	8b 40 54             	mov    0x54(%eax),%eax
     7f5:	a3 24 16 00 00       	mov    %eax,0x1624
	}
	printfile(firstOnScreen);
     7fa:	83 ec 0c             	sub    $0xc,%esp
     7fd:	ff 35 20 16 00 00    	pushl  0x1620
     803:	e8 e8 f9 ff ff       	call   1f0 <printfile>
}
     808:	83 c4 10             	add    $0x10,%esp
     80b:	8d 65 f4             	lea    -0xc(%ebp),%esp
     80e:	5b                   	pop    %ebx
     80f:	5e                   	pop    %esi
     810:	5f                   	pop    %edi
     811:	5d                   	pop    %ebp
     812:	c3                   	ret    
		newfileline->next = cur->next;
		newfileline->prev = cur;
		if(cur->next != 0){
			cur->next->prev = newfileline;
		} else {
			lastOnScreen = newfileline;
     813:	a3 24 16 00 00       	mov    %eax,0x1624
     818:	e9 6c ff ff ff       	jmp    789 <newline+0xf9>
		newfileline->next = cur;
		newfileline->prev = cur->prev;
		if(cur->prev != 0){
			cur->prev->next = newfileline;
		} else {
			firstOnScreen = newfileline;
     81d:	a3 20 16 00 00       	mov    %eax,0x1620
     822:	eb b1                	jmp    7d5 <newline+0x145>
     824:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     82a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000830 <handleInput>:
	}
	printfile(firstOnScreen);
}

void
handleInput(int i) {
     830:	55                   	push   %ebp
     831:	89 e5                	mov    %esp,%ebp
     833:	56                   	push   %esi
     834:	53                   	push   %ebx
     835:	8b 5d 08             	mov    0x8(%ebp),%ebx
	printf(1, "currChar: %d\n", currChar);
     838:	83 ec 04             	sub    $0x4,%esp
     83b:	ff 35 04 16 00 00    	pushl  0x1604
     841:	68 75 10 00 00       	push   $0x1075
     846:	6a 01                	push   $0x1
     848:	e8 e3 04 00 00       	call   d30 <printf>
	//ctrl+q
	if (i == 17) {
     84d:	83 c4 10             	add    $0x10,%esp
     850:	83 fb 11             	cmp    $0x11,%ebx
     853:	0f 84 17 01 00 00    	je     970 <handleInput+0x140>
		exit();
	}
	else if(i >= 9 && i<= 12){
     859:	8d 43 f7             	lea    -0x9(%ebx),%eax
     85c:	83 f8 03             	cmp    $0x3,%eax
     85f:	76 67                	jbe    8c8 <handleInput+0x98>
		arrowkeys(i);
	}

	//ctrl+x
	else if(i == 24){
     861:	83 fb 18             	cmp    $0x18,%ebx
     864:	0f 84 ec 00 00 00    	je     956 <handleInput+0x126>
		cutline();
	}

	//return key
	else if(i == 13){
     86a:	83 fb 0d             	cmp    $0xd,%ebx
     86d:	0f 84 ee 00 00 00    	je     961 <handleInput+0x131>
		newline();
	}

	//backspace
	else if(i == 127){
     873:	83 fb 7f             	cmp    $0x7f,%ebx
     876:	74 68                	je     8e0 <handleInput+0xb0>
			buf[bufindex] = ' ';
			updatesc(0, 1, buf, TEXT_COLOR);
		}
	}
	//On right edge of window 
	else if((currChar+1) % WIDTH == 0){
     878:	8b 35 04 16 00 00    	mov    0x1604,%esi
     87e:	ba 67 66 66 66       	mov    $0x66666667,%edx
     883:	8d 4e 01             	lea    0x1(%esi),%ecx
     886:	89 c8                	mov    %ecx,%eax
     888:	f7 ea                	imul   %edx
     88a:	89 c8                	mov    %ecx,%eax
     88c:	c1 f8 1f             	sar    $0x1f,%eax
     88f:	c1 fa 05             	sar    $0x5,%edx
     892:	29 c2                	sub    %eax,%edx
     894:	8d 04 92             	lea    (%edx,%edx,4),%eax
     897:	c1 e0 04             	shl    $0x4,%eax
     89a:	39 c1                	cmp    %eax,%ecx
     89c:	74 06                	je     8a4 <handleInput+0x74>
		buf[currChar] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
		// printf(1, "new input");
	}
	else{
		buf[currChar++] = (char) i & 0xff;
     89e:	89 0d 04 16 00 00    	mov    %ecx,0x1604
     8a4:	88 9e 40 16 00 00    	mov    %bl,0x1640(%esi)
		updatesc(0, 1, buf, TEXT_COLOR);
     8aa:	6a 07                	push   $0x7
     8ac:	68 40 16 00 00       	push   $0x1640
     8b1:	6a 01                	push   $0x1
     8b3:	6a 00                	push   $0x0
     8b5:	e8 b8 03 00 00       	call   c72 <updatesc>
     8ba:	83 c4 10             	add    $0x10,%esp
	}
}
     8bd:	8d 65 f8             	lea    -0x8(%ebp),%esp
     8c0:	5b                   	pop    %ebx
     8c1:	5e                   	pop    %esi
     8c2:	5d                   	pop    %ebp
     8c3:	c3                   	ret    
     8c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	//ctrl+q
	if (i == 17) {
		exit();
	}
	else if(i >= 9 && i<= 12){
		arrowkeys(i);
     8c8:	89 5d 08             	mov    %ebx,0x8(%ebp)
	}
	else{
		buf[currChar++] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
	}
}
     8cb:	8d 65 f8             	lea    -0x8(%ebp),%esp
     8ce:	5b                   	pop    %ebx
     8cf:	5e                   	pop    %esi
     8d0:	5d                   	pop    %ebp
	//ctrl+q
	if (i == 17) {
		exit();
	}
	else if(i >= 9 && i<= 12){
		arrowkeys(i);
     8d1:	e9 8a fb ff ff       	jmp    460 <arrowkeys>
     8d6:	8d 76 00             	lea    0x0(%esi),%esi
     8d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		newline();
	}

	//backspace
	else if(i == 127){
		if(currChar > 0){
     8e0:	8b 1d 04 16 00 00    	mov    0x1604,%ebx
     8e6:	85 db                	test   %ebx,%ebx
     8e8:	7e d3                	jle    8bd <handleInput+0x8d>
			currChar--;
			int bufindex = currChar;
			while(((bufindex+1) % WIDTH) != 0){
     8ea:	89 d8                	mov    %ebx,%eax
     8ec:	ba 67 66 66 66       	mov    $0x66666667,%edx
	}

	//backspace
	else if(i == 127){
		if(currChar > 0){
			currChar--;
     8f1:	8d 4b ff             	lea    -0x1(%ebx),%ecx
			int bufindex = currChar;
			while(((bufindex+1) % WIDTH) != 0){
     8f4:	f7 ea                	imul   %edx
     8f6:	89 d8                	mov    %ebx,%eax
     8f8:	c1 f8 1f             	sar    $0x1f,%eax
	}

	//backspace
	else if(i == 127){
		if(currChar > 0){
			currChar--;
     8fb:	89 0d 04 16 00 00    	mov    %ecx,0x1604
			int bufindex = currChar;
			while(((bufindex+1) % WIDTH) != 0){
     901:	c1 fa 05             	sar    $0x5,%edx
     904:	29 c2                	sub    %eax,%edx
     906:	8d 04 92             	lea    (%edx,%edx,4),%eax
     909:	c1 e0 04             	shl    $0x4,%eax
     90c:	39 c3                	cmp    %eax,%ebx
     90e:	74 5c                	je     96c <handleInput+0x13c>
     910:	be 67 66 66 66       	mov    $0x66666667,%esi
     915:	eb 0b                	jmp    922 <handleInput+0xf2>
     917:	89 f6                	mov    %esi,%esi
     919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     920:	89 cb                	mov    %ecx,%ebx
				buf[bufindex] = buf[bufindex+1];
     922:	0f b6 83 40 16 00 00 	movzbl 0x1640(%ebx),%eax
	//backspace
	else if(i == 127){
		if(currChar > 0){
			currChar--;
			int bufindex = currChar;
			while(((bufindex+1) % WIDTH) != 0){
     929:	8d 4b 01             	lea    0x1(%ebx),%ecx
				buf[bufindex] = buf[bufindex+1];
     92c:	88 83 3f 16 00 00    	mov    %al,0x163f(%ebx)
	//backspace
	else if(i == 127){
		if(currChar > 0){
			currChar--;
			int bufindex = currChar;
			while(((bufindex+1) % WIDTH) != 0){
     932:	89 c8                	mov    %ecx,%eax
     934:	f7 ee                	imul   %esi
     936:	89 c8                	mov    %ecx,%eax
     938:	c1 f8 1f             	sar    $0x1f,%eax
     93b:	c1 fa 05             	sar    $0x5,%edx
     93e:	29 c2                	sub    %eax,%edx
     940:	8d 04 92             	lea    (%edx,%edx,4),%eax
     943:	c1 e0 04             	shl    $0x4,%eax
     946:	39 c1                	cmp    %eax,%ecx
     948:	75 d6                	jne    920 <handleInput+0xf0>
				buf[bufindex] = buf[bufindex+1];
				bufindex++;
			}
			buf[bufindex] = ' ';
     94a:	c6 83 40 16 00 00 20 	movb   $0x20,0x1640(%ebx)
     951:	e9 54 ff ff ff       	jmp    8aa <handleInput+0x7a>
	}
	else{
		buf[currChar++] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
	}
}
     956:	8d 65 f8             	lea    -0x8(%ebp),%esp
     959:	5b                   	pop    %ebx
     95a:	5e                   	pop    %esi
     95b:	5d                   	pop    %ebp
		arrowkeys(i);
	}

	//ctrl+x
	else if(i == 24){
		cutline();
     95c:	e9 ef fb ff ff       	jmp    550 <cutline>
	}
	else{
		buf[currChar++] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
	}
}
     961:	8d 65 f8             	lea    -0x8(%ebp),%esp
     964:	5b                   	pop    %ebx
     965:	5e                   	pop    %esi
     966:	5d                   	pop    %ebp
		cutline();
	}

	//return key
	else if(i == 13){
		newline();
     967:	e9 24 fd ff ff       	jmp    690 <newline>

	//backspace
	else if(i == 127){
		if(currChar > 0){
			currChar--;
			int bufindex = currChar;
     96c:	89 cb                	mov    %ecx,%ebx
     96e:	eb da                	jmp    94a <handleInput+0x11a>
void
handleInput(int i) {
	printf(1, "currChar: %d\n", currChar);
	//ctrl+q
	if (i == 17) {
		exit();
     970:	e8 4d 02 00 00       	call   bc2 <exit>
     975:	66 90                	xchg   %ax,%ax
     977:	66 90                	xchg   %ax,%ax
     979:	66 90                	xchg   %ax,%ax
     97b:	66 90                	xchg   %ax,%ax
     97d:	66 90                	xchg   %ax,%ax
     97f:	90                   	nop

00000980 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     980:	55                   	push   %ebp
     981:	89 e5                	mov    %esp,%ebp
     983:	53                   	push   %ebx
     984:	8b 45 08             	mov    0x8(%ebp),%eax
     987:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     98a:	89 c2                	mov    %eax,%edx
     98c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     990:	83 c1 01             	add    $0x1,%ecx
     993:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     997:	83 c2 01             	add    $0x1,%edx
     99a:	84 db                	test   %bl,%bl
     99c:	88 5a ff             	mov    %bl,-0x1(%edx)
     99f:	75 ef                	jne    990 <strcpy+0x10>
    ;
  return os;
}
     9a1:	5b                   	pop    %ebx
     9a2:	5d                   	pop    %ebp
     9a3:	c3                   	ret    
     9a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     9aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000009b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     9b0:	55                   	push   %ebp
     9b1:	89 e5                	mov    %esp,%ebp
     9b3:	56                   	push   %esi
     9b4:	53                   	push   %ebx
     9b5:	8b 55 08             	mov    0x8(%ebp),%edx
     9b8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     9bb:	0f b6 02             	movzbl (%edx),%eax
     9be:	0f b6 19             	movzbl (%ecx),%ebx
     9c1:	84 c0                	test   %al,%al
     9c3:	75 1e                	jne    9e3 <strcmp+0x33>
     9c5:	eb 29                	jmp    9f0 <strcmp+0x40>
     9c7:	89 f6                	mov    %esi,%esi
     9c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     9d0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     9d3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
     9d6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     9d9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
     9dd:	84 c0                	test   %al,%al
     9df:	74 0f                	je     9f0 <strcmp+0x40>
     9e1:	89 f1                	mov    %esi,%ecx
     9e3:	38 d8                	cmp    %bl,%al
     9e5:	74 e9                	je     9d0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     9e7:	29 d8                	sub    %ebx,%eax
}
     9e9:	5b                   	pop    %ebx
     9ea:	5e                   	pop    %esi
     9eb:	5d                   	pop    %ebp
     9ec:	c3                   	ret    
     9ed:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     9f0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
     9f2:	29 d8                	sub    %ebx,%eax
}
     9f4:	5b                   	pop    %ebx
     9f5:	5e                   	pop    %esi
     9f6:	5d                   	pop    %ebp
     9f7:	c3                   	ret    
     9f8:	90                   	nop
     9f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000a00 <strlen>:

uint
strlen(char *s)
{
     a00:	55                   	push   %ebp
     a01:	89 e5                	mov    %esp,%ebp
     a03:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     a06:	80 39 00             	cmpb   $0x0,(%ecx)
     a09:	74 12                	je     a1d <strlen+0x1d>
     a0b:	31 d2                	xor    %edx,%edx
     a0d:	8d 76 00             	lea    0x0(%esi),%esi
     a10:	83 c2 01             	add    $0x1,%edx
     a13:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     a17:	89 d0                	mov    %edx,%eax
     a19:	75 f5                	jne    a10 <strlen+0x10>
    ;
  return n;
}
     a1b:	5d                   	pop    %ebp
     a1c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
     a1d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
     a1f:	5d                   	pop    %ebp
     a20:	c3                   	ret    
     a21:	eb 0d                	jmp    a30 <memset>
     a23:	90                   	nop
     a24:	90                   	nop
     a25:	90                   	nop
     a26:	90                   	nop
     a27:	90                   	nop
     a28:	90                   	nop
     a29:	90                   	nop
     a2a:	90                   	nop
     a2b:	90                   	nop
     a2c:	90                   	nop
     a2d:	90                   	nop
     a2e:	90                   	nop
     a2f:	90                   	nop

00000a30 <memset>:

void*
memset(void *dst, int c, uint n)
{
     a30:	55                   	push   %ebp
     a31:	89 e5                	mov    %esp,%ebp
     a33:	57                   	push   %edi
     a34:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     a37:	8b 4d 10             	mov    0x10(%ebp),%ecx
     a3a:	8b 45 0c             	mov    0xc(%ebp),%eax
     a3d:	89 d7                	mov    %edx,%edi
     a3f:	fc                   	cld    
     a40:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     a42:	89 d0                	mov    %edx,%eax
     a44:	5f                   	pop    %edi
     a45:	5d                   	pop    %ebp
     a46:	c3                   	ret    
     a47:	89 f6                	mov    %esi,%esi
     a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a50 <strchr>:

char*
strchr(const char *s, char c)
{
     a50:	55                   	push   %ebp
     a51:	89 e5                	mov    %esp,%ebp
     a53:	53                   	push   %ebx
     a54:	8b 45 08             	mov    0x8(%ebp),%eax
     a57:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
     a5a:	0f b6 10             	movzbl (%eax),%edx
     a5d:	84 d2                	test   %dl,%dl
     a5f:	74 1d                	je     a7e <strchr+0x2e>
    if(*s == c)
     a61:	38 d3                	cmp    %dl,%bl
     a63:	89 d9                	mov    %ebx,%ecx
     a65:	75 0d                	jne    a74 <strchr+0x24>
     a67:	eb 17                	jmp    a80 <strchr+0x30>
     a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a70:	38 ca                	cmp    %cl,%dl
     a72:	74 0c                	je     a80 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     a74:	83 c0 01             	add    $0x1,%eax
     a77:	0f b6 10             	movzbl (%eax),%edx
     a7a:	84 d2                	test   %dl,%dl
     a7c:	75 f2                	jne    a70 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
     a7e:	31 c0                	xor    %eax,%eax
}
     a80:	5b                   	pop    %ebx
     a81:	5d                   	pop    %ebp
     a82:	c3                   	ret    
     a83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a90 <gets>:

char*
gets(char *buf, int max)
{
     a90:	55                   	push   %ebp
     a91:	89 e5                	mov    %esp,%ebp
     a93:	57                   	push   %edi
     a94:	56                   	push   %esi
     a95:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     a96:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
     a98:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
     a9b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     a9e:	eb 29                	jmp    ac9 <gets+0x39>
    cc = read(0, &c, 1);
     aa0:	83 ec 04             	sub    $0x4,%esp
     aa3:	6a 01                	push   $0x1
     aa5:	57                   	push   %edi
     aa6:	6a 00                	push   $0x0
     aa8:	e8 2d 01 00 00       	call   bda <read>
    if(cc < 1)
     aad:	83 c4 10             	add    $0x10,%esp
     ab0:	85 c0                	test   %eax,%eax
     ab2:	7e 1d                	jle    ad1 <gets+0x41>
      break;
    buf[i++] = c;
     ab4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     ab8:	8b 55 08             	mov    0x8(%ebp),%edx
     abb:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
     abd:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
     abf:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
     ac3:	74 1b                	je     ae0 <gets+0x50>
     ac5:	3c 0d                	cmp    $0xd,%al
     ac7:	74 17                	je     ae0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     ac9:	8d 5e 01             	lea    0x1(%esi),%ebx
     acc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     acf:	7c cf                	jl     aa0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     ad1:	8b 45 08             	mov    0x8(%ebp),%eax
     ad4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
     ad8:	8d 65 f4             	lea    -0xc(%ebp),%esp
     adb:	5b                   	pop    %ebx
     adc:	5e                   	pop    %esi
     add:	5f                   	pop    %edi
     ade:	5d                   	pop    %ebp
     adf:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     ae0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     ae3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     ae5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
     ae9:	8d 65 f4             	lea    -0xc(%ebp),%esp
     aec:	5b                   	pop    %ebx
     aed:	5e                   	pop    %esi
     aee:	5f                   	pop    %edi
     aef:	5d                   	pop    %ebp
     af0:	c3                   	ret    
     af1:	eb 0d                	jmp    b00 <stat>
     af3:	90                   	nop
     af4:	90                   	nop
     af5:	90                   	nop
     af6:	90                   	nop
     af7:	90                   	nop
     af8:	90                   	nop
     af9:	90                   	nop
     afa:	90                   	nop
     afb:	90                   	nop
     afc:	90                   	nop
     afd:	90                   	nop
     afe:	90                   	nop
     aff:	90                   	nop

00000b00 <stat>:

int
stat(char *n, struct stat *st)
{
     b00:	55                   	push   %ebp
     b01:	89 e5                	mov    %esp,%ebp
     b03:	56                   	push   %esi
     b04:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     b05:	83 ec 08             	sub    $0x8,%esp
     b08:	6a 00                	push   $0x0
     b0a:	ff 75 08             	pushl  0x8(%ebp)
     b0d:	e8 f0 00 00 00       	call   c02 <open>
  if(fd < 0)
     b12:	83 c4 10             	add    $0x10,%esp
     b15:	85 c0                	test   %eax,%eax
     b17:	78 27                	js     b40 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     b19:	83 ec 08             	sub    $0x8,%esp
     b1c:	ff 75 0c             	pushl  0xc(%ebp)
     b1f:	89 c3                	mov    %eax,%ebx
     b21:	50                   	push   %eax
     b22:	e8 f3 00 00 00       	call   c1a <fstat>
     b27:	89 c6                	mov    %eax,%esi
  close(fd);
     b29:	89 1c 24             	mov    %ebx,(%esp)
     b2c:	e8 b9 00 00 00       	call   bea <close>
  return r;
     b31:	83 c4 10             	add    $0x10,%esp
     b34:	89 f0                	mov    %esi,%eax
}
     b36:	8d 65 f8             	lea    -0x8(%ebp),%esp
     b39:	5b                   	pop    %ebx
     b3a:	5e                   	pop    %esi
     b3b:	5d                   	pop    %ebp
     b3c:	c3                   	ret    
     b3d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
     b40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     b45:	eb ef                	jmp    b36 <stat+0x36>
     b47:	89 f6                	mov    %esi,%esi
     b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b50 <atoi>:
  return r;
}

int
atoi(const char *s)
{
     b50:	55                   	push   %ebp
     b51:	89 e5                	mov    %esp,%ebp
     b53:	53                   	push   %ebx
     b54:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     b57:	0f be 11             	movsbl (%ecx),%edx
     b5a:	8d 42 d0             	lea    -0x30(%edx),%eax
     b5d:	3c 09                	cmp    $0x9,%al
     b5f:	b8 00 00 00 00       	mov    $0x0,%eax
     b64:	77 1f                	ja     b85 <atoi+0x35>
     b66:	8d 76 00             	lea    0x0(%esi),%esi
     b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
     b70:	8d 04 80             	lea    (%eax,%eax,4),%eax
     b73:	83 c1 01             	add    $0x1,%ecx
     b76:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     b7a:	0f be 11             	movsbl (%ecx),%edx
     b7d:	8d 5a d0             	lea    -0x30(%edx),%ebx
     b80:	80 fb 09             	cmp    $0x9,%bl
     b83:	76 eb                	jbe    b70 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
     b85:	5b                   	pop    %ebx
     b86:	5d                   	pop    %ebp
     b87:	c3                   	ret    
     b88:	90                   	nop
     b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000b90 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     b90:	55                   	push   %ebp
     b91:	89 e5                	mov    %esp,%ebp
     b93:	56                   	push   %esi
     b94:	53                   	push   %ebx
     b95:	8b 5d 10             	mov    0x10(%ebp),%ebx
     b98:	8b 45 08             	mov    0x8(%ebp),%eax
     b9b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     b9e:	85 db                	test   %ebx,%ebx
     ba0:	7e 14                	jle    bb6 <memmove+0x26>
     ba2:	31 d2                	xor    %edx,%edx
     ba4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
     ba8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     bac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     baf:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     bb2:	39 da                	cmp    %ebx,%edx
     bb4:	75 f2                	jne    ba8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
     bb6:	5b                   	pop    %ebx
     bb7:	5e                   	pop    %esi
     bb8:	5d                   	pop    %ebp
     bb9:	c3                   	ret    

00000bba <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     bba:	b8 01 00 00 00       	mov    $0x1,%eax
     bbf:	cd 40                	int    $0x40
     bc1:	c3                   	ret    

00000bc2 <exit>:
SYSCALL(exit)
     bc2:	b8 02 00 00 00       	mov    $0x2,%eax
     bc7:	cd 40                	int    $0x40
     bc9:	c3                   	ret    

00000bca <wait>:
SYSCALL(wait)
     bca:	b8 03 00 00 00       	mov    $0x3,%eax
     bcf:	cd 40                	int    $0x40
     bd1:	c3                   	ret    

00000bd2 <pipe>:
SYSCALL(pipe)
     bd2:	b8 04 00 00 00       	mov    $0x4,%eax
     bd7:	cd 40                	int    $0x40
     bd9:	c3                   	ret    

00000bda <read>:
SYSCALL(read)
     bda:	b8 05 00 00 00       	mov    $0x5,%eax
     bdf:	cd 40                	int    $0x40
     be1:	c3                   	ret    

00000be2 <write>:
SYSCALL(write)
     be2:	b8 10 00 00 00       	mov    $0x10,%eax
     be7:	cd 40                	int    $0x40
     be9:	c3                   	ret    

00000bea <close>:
SYSCALL(close)
     bea:	b8 15 00 00 00       	mov    $0x15,%eax
     bef:	cd 40                	int    $0x40
     bf1:	c3                   	ret    

00000bf2 <kill>:
SYSCALL(kill)
     bf2:	b8 06 00 00 00       	mov    $0x6,%eax
     bf7:	cd 40                	int    $0x40
     bf9:	c3                   	ret    

00000bfa <exec>:
SYSCALL(exec)
     bfa:	b8 07 00 00 00       	mov    $0x7,%eax
     bff:	cd 40                	int    $0x40
     c01:	c3                   	ret    

00000c02 <open>:
SYSCALL(open)
     c02:	b8 0f 00 00 00       	mov    $0xf,%eax
     c07:	cd 40                	int    $0x40
     c09:	c3                   	ret    

00000c0a <mknod>:
SYSCALL(mknod)
     c0a:	b8 11 00 00 00       	mov    $0x11,%eax
     c0f:	cd 40                	int    $0x40
     c11:	c3                   	ret    

00000c12 <unlink>:
SYSCALL(unlink)
     c12:	b8 12 00 00 00       	mov    $0x12,%eax
     c17:	cd 40                	int    $0x40
     c19:	c3                   	ret    

00000c1a <fstat>:
SYSCALL(fstat)
     c1a:	b8 08 00 00 00       	mov    $0x8,%eax
     c1f:	cd 40                	int    $0x40
     c21:	c3                   	ret    

00000c22 <link>:
SYSCALL(link)
     c22:	b8 13 00 00 00       	mov    $0x13,%eax
     c27:	cd 40                	int    $0x40
     c29:	c3                   	ret    

00000c2a <mkdir>:
SYSCALL(mkdir)
     c2a:	b8 14 00 00 00       	mov    $0x14,%eax
     c2f:	cd 40                	int    $0x40
     c31:	c3                   	ret    

00000c32 <chdir>:
SYSCALL(chdir)
     c32:	b8 09 00 00 00       	mov    $0x9,%eax
     c37:	cd 40                	int    $0x40
     c39:	c3                   	ret    

00000c3a <dup>:
SYSCALL(dup)
     c3a:	b8 0a 00 00 00       	mov    $0xa,%eax
     c3f:	cd 40                	int    $0x40
     c41:	c3                   	ret    

00000c42 <getpid>:
SYSCALL(getpid)
     c42:	b8 0b 00 00 00       	mov    $0xb,%eax
     c47:	cd 40                	int    $0x40
     c49:	c3                   	ret    

00000c4a <sbrk>:
SYSCALL(sbrk)
     c4a:	b8 0c 00 00 00       	mov    $0xc,%eax
     c4f:	cd 40                	int    $0x40
     c51:	c3                   	ret    

00000c52 <sleep>:
SYSCALL(sleep)
     c52:	b8 0d 00 00 00       	mov    $0xd,%eax
     c57:	cd 40                	int    $0x40
     c59:	c3                   	ret    

00000c5a <uptime>:
SYSCALL(uptime)
     c5a:	b8 0e 00 00 00       	mov    $0xe,%eax
     c5f:	cd 40                	int    $0x40
     c61:	c3                   	ret    

00000c62 <captsc>:
SYSCALL(captsc)
     c62:	b8 16 00 00 00       	mov    $0x16,%eax
     c67:	cd 40                	int    $0x40
     c69:	c3                   	ret    

00000c6a <freesc>:
SYSCALL(freesc)
     c6a:	b8 17 00 00 00       	mov    $0x17,%eax
     c6f:	cd 40                	int    $0x40
     c71:	c3                   	ret    

00000c72 <updatesc>:
SYSCALL(updatesc)
     c72:	b8 18 00 00 00       	mov    $0x18,%eax
     c77:	cd 40                	int    $0x40
     c79:	c3                   	ret    

00000c7a <getkey>:
SYSCALL(getkey)
     c7a:	b8 19 00 00 00       	mov    $0x19,%eax
     c7f:	cd 40                	int    $0x40
     c81:	c3                   	ret    
     c82:	66 90                	xchg   %ax,%ax
     c84:	66 90                	xchg   %ax,%ax
     c86:	66 90                	xchg   %ax,%ax
     c88:	66 90                	xchg   %ax,%ax
     c8a:	66 90                	xchg   %ax,%ax
     c8c:	66 90                	xchg   %ax,%ax
     c8e:	66 90                	xchg   %ax,%ax

00000c90 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     c90:	55                   	push   %ebp
     c91:	89 e5                	mov    %esp,%ebp
     c93:	57                   	push   %edi
     c94:	56                   	push   %esi
     c95:	53                   	push   %ebx
     c96:	89 c6                	mov    %eax,%esi
     c98:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     c9b:	8b 5d 08             	mov    0x8(%ebp),%ebx
     c9e:	85 db                	test   %ebx,%ebx
     ca0:	74 7e                	je     d20 <printint+0x90>
     ca2:	89 d0                	mov    %edx,%eax
     ca4:	c1 e8 1f             	shr    $0x1f,%eax
     ca7:	84 c0                	test   %al,%al
     ca9:	74 75                	je     d20 <printint+0x90>
    neg = 1;
    x = -xx;
     cab:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
     cad:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
     cb4:	f7 d8                	neg    %eax
     cb6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
     cb9:	31 ff                	xor    %edi,%edi
     cbb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
     cbe:	89 ce                	mov    %ecx,%esi
     cc0:	eb 08                	jmp    cca <printint+0x3a>
     cc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
     cc8:	89 cf                	mov    %ecx,%edi
     cca:	31 d2                	xor    %edx,%edx
     ccc:	8d 4f 01             	lea    0x1(%edi),%ecx
     ccf:	f7 f6                	div    %esi
     cd1:	0f b6 92 40 11 00 00 	movzbl 0x1140(%edx),%edx
  }while((x /= base) != 0);
     cd8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
     cda:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
     cdd:	75 e9                	jne    cc8 <printint+0x38>
  if(neg)
     cdf:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     ce2:	8b 75 c0             	mov    -0x40(%ebp),%esi
     ce5:	85 c0                	test   %eax,%eax
     ce7:	74 08                	je     cf1 <printint+0x61>
    buf[i++] = '-';
     ce9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
     cee:	8d 4f 02             	lea    0x2(%edi),%ecx
     cf1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
     cf5:	8d 76 00             	lea    0x0(%esi),%esi
     cf8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     cfb:	83 ec 04             	sub    $0x4,%esp
     cfe:	83 ef 01             	sub    $0x1,%edi
     d01:	6a 01                	push   $0x1
     d03:	53                   	push   %ebx
     d04:	56                   	push   %esi
     d05:	88 45 d7             	mov    %al,-0x29(%ebp)
     d08:	e8 d5 fe ff ff       	call   be2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     d0d:	83 c4 10             	add    $0x10,%esp
     d10:	39 df                	cmp    %ebx,%edi
     d12:	75 e4                	jne    cf8 <printint+0x68>
    putc(fd, buf[i]);
}
     d14:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d17:	5b                   	pop    %ebx
     d18:	5e                   	pop    %esi
     d19:	5f                   	pop    %edi
     d1a:	5d                   	pop    %ebp
     d1b:	c3                   	ret    
     d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     d20:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     d22:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     d29:	eb 8b                	jmp    cb6 <printint+0x26>
     d2b:	90                   	nop
     d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000d30 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     d30:	55                   	push   %ebp
     d31:	89 e5                	mov    %esp,%ebp
     d33:	57                   	push   %edi
     d34:	56                   	push   %esi
     d35:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     d36:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     d39:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     d3c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     d3f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     d42:	89 45 d0             	mov    %eax,-0x30(%ebp)
     d45:	0f b6 1e             	movzbl (%esi),%ebx
     d48:	83 c6 01             	add    $0x1,%esi
     d4b:	84 db                	test   %bl,%bl
     d4d:	0f 84 b0 00 00 00    	je     e03 <printf+0xd3>
     d53:	31 d2                	xor    %edx,%edx
     d55:	eb 39                	jmp    d90 <printf+0x60>
     d57:	89 f6                	mov    %esi,%esi
     d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     d60:	83 f8 25             	cmp    $0x25,%eax
     d63:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
     d66:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     d6b:	74 18                	je     d85 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     d6d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
     d70:	83 ec 04             	sub    $0x4,%esp
     d73:	88 5d e2             	mov    %bl,-0x1e(%ebp)
     d76:	6a 01                	push   $0x1
     d78:	50                   	push   %eax
     d79:	57                   	push   %edi
     d7a:	e8 63 fe ff ff       	call   be2 <write>
     d7f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     d82:	83 c4 10             	add    $0x10,%esp
     d85:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     d88:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
     d8c:	84 db                	test   %bl,%bl
     d8e:	74 73                	je     e03 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
     d90:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
     d92:	0f be cb             	movsbl %bl,%ecx
     d95:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
     d98:	74 c6                	je     d60 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     d9a:	83 fa 25             	cmp    $0x25,%edx
     d9d:	75 e6                	jne    d85 <printf+0x55>
      if(c == 'd'){
     d9f:	83 f8 64             	cmp    $0x64,%eax
     da2:	0f 84 f8 00 00 00    	je     ea0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     da8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
     dae:	83 f9 70             	cmp    $0x70,%ecx
     db1:	74 5d                	je     e10 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     db3:	83 f8 73             	cmp    $0x73,%eax
     db6:	0f 84 84 00 00 00    	je     e40 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     dbc:	83 f8 63             	cmp    $0x63,%eax
     dbf:	0f 84 ea 00 00 00    	je     eaf <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     dc5:	83 f8 25             	cmp    $0x25,%eax
     dc8:	0f 84 c2 00 00 00    	je     e90 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     dce:	8d 45 e7             	lea    -0x19(%ebp),%eax
     dd1:	83 ec 04             	sub    $0x4,%esp
     dd4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
     dd8:	6a 01                	push   $0x1
     dda:	50                   	push   %eax
     ddb:	57                   	push   %edi
     ddc:	e8 01 fe ff ff       	call   be2 <write>
     de1:	83 c4 0c             	add    $0xc,%esp
     de4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     de7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
     dea:	6a 01                	push   $0x1
     dec:	50                   	push   %eax
     ded:	57                   	push   %edi
     dee:	83 c6 01             	add    $0x1,%esi
     df1:	e8 ec fd ff ff       	call   be2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     df6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     dfa:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     dfd:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     dff:	84 db                	test   %bl,%bl
     e01:	75 8d                	jne    d90 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     e03:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e06:	5b                   	pop    %ebx
     e07:	5e                   	pop    %esi
     e08:	5f                   	pop    %edi
     e09:	5d                   	pop    %ebp
     e0a:	c3                   	ret    
     e0b:	90                   	nop
     e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
     e10:	83 ec 0c             	sub    $0xc,%esp
     e13:	b9 10 00 00 00       	mov    $0x10,%ecx
     e18:	6a 00                	push   $0x0
     e1a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
     e1d:	89 f8                	mov    %edi,%eax
     e1f:	8b 13                	mov    (%ebx),%edx
     e21:	e8 6a fe ff ff       	call   c90 <printint>
        ap++;
     e26:	89 d8                	mov    %ebx,%eax
     e28:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     e2b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
     e2d:	83 c0 04             	add    $0x4,%eax
     e30:	89 45 d0             	mov    %eax,-0x30(%ebp)
     e33:	e9 4d ff ff ff       	jmp    d85 <printf+0x55>
     e38:	90                   	nop
     e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
     e40:	8b 45 d0             	mov    -0x30(%ebp),%eax
     e43:	8b 18                	mov    (%eax),%ebx
        ap++;
     e45:	83 c0 04             	add    $0x4,%eax
     e48:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
     e4b:	b8 38 11 00 00       	mov    $0x1138,%eax
     e50:	85 db                	test   %ebx,%ebx
     e52:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
     e55:	0f b6 03             	movzbl (%ebx),%eax
     e58:	84 c0                	test   %al,%al
     e5a:	74 23                	je     e7f <printf+0x14f>
     e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e60:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     e63:	8d 45 e3             	lea    -0x1d(%ebp),%eax
     e66:	83 ec 04             	sub    $0x4,%esp
     e69:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
     e6b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     e6e:	50                   	push   %eax
     e6f:	57                   	push   %edi
     e70:	e8 6d fd ff ff       	call   be2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     e75:	0f b6 03             	movzbl (%ebx),%eax
     e78:	83 c4 10             	add    $0x10,%esp
     e7b:	84 c0                	test   %al,%al
     e7d:	75 e1                	jne    e60 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     e7f:	31 d2                	xor    %edx,%edx
     e81:	e9 ff fe ff ff       	jmp    d85 <printf+0x55>
     e86:	8d 76 00             	lea    0x0(%esi),%esi
     e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     e90:	83 ec 04             	sub    $0x4,%esp
     e93:	88 5d e5             	mov    %bl,-0x1b(%ebp)
     e96:	8d 45 e5             	lea    -0x1b(%ebp),%eax
     e99:	6a 01                	push   $0x1
     e9b:	e9 4c ff ff ff       	jmp    dec <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
     ea0:	83 ec 0c             	sub    $0xc,%esp
     ea3:	b9 0a 00 00 00       	mov    $0xa,%ecx
     ea8:	6a 01                	push   $0x1
     eaa:	e9 6b ff ff ff       	jmp    e1a <printf+0xea>
     eaf:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     eb2:	83 ec 04             	sub    $0x4,%esp
     eb5:	8b 03                	mov    (%ebx),%eax
     eb7:	6a 01                	push   $0x1
     eb9:	88 45 e4             	mov    %al,-0x1c(%ebp)
     ebc:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     ebf:	50                   	push   %eax
     ec0:	57                   	push   %edi
     ec1:	e8 1c fd ff ff       	call   be2 <write>
     ec6:	e9 5b ff ff ff       	jmp    e26 <printf+0xf6>
     ecb:	66 90                	xchg   %ax,%ax
     ecd:	66 90                	xchg   %ax,%ax
     ecf:	90                   	nop

00000ed0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     ed0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     ed1:	a1 08 16 00 00       	mov    0x1608,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
     ed6:	89 e5                	mov    %esp,%ebp
     ed8:	57                   	push   %edi
     ed9:	56                   	push   %esi
     eda:	53                   	push   %ebx
     edb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     ede:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
     ee0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     ee3:	39 c8                	cmp    %ecx,%eax
     ee5:	73 19                	jae    f00 <free+0x30>
     ee7:	89 f6                	mov    %esi,%esi
     ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     ef0:	39 d1                	cmp    %edx,%ecx
     ef2:	72 1c                	jb     f10 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     ef4:	39 d0                	cmp    %edx,%eax
     ef6:	73 18                	jae    f10 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
     ef8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     efa:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     efc:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     efe:	72 f0                	jb     ef0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     f00:	39 d0                	cmp    %edx,%eax
     f02:	72 f4                	jb     ef8 <free+0x28>
     f04:	39 d1                	cmp    %edx,%ecx
     f06:	73 f0                	jae    ef8 <free+0x28>
     f08:	90                   	nop
     f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
     f10:	8b 73 fc             	mov    -0x4(%ebx),%esi
     f13:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
     f16:	39 d7                	cmp    %edx,%edi
     f18:	74 19                	je     f33 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
     f1a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
     f1d:	8b 50 04             	mov    0x4(%eax),%edx
     f20:	8d 34 d0             	lea    (%eax,%edx,8),%esi
     f23:	39 f1                	cmp    %esi,%ecx
     f25:	74 23                	je     f4a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
     f27:	89 08                	mov    %ecx,(%eax)
  freep = p;
     f29:	a3 08 16 00 00       	mov    %eax,0x1608
}
     f2e:	5b                   	pop    %ebx
     f2f:	5e                   	pop    %esi
     f30:	5f                   	pop    %edi
     f31:	5d                   	pop    %ebp
     f32:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
     f33:	03 72 04             	add    0x4(%edx),%esi
     f36:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
     f39:	8b 10                	mov    (%eax),%edx
     f3b:	8b 12                	mov    (%edx),%edx
     f3d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
     f40:	8b 50 04             	mov    0x4(%eax),%edx
     f43:	8d 34 d0             	lea    (%eax,%edx,8),%esi
     f46:	39 f1                	cmp    %esi,%ecx
     f48:	75 dd                	jne    f27 <free+0x57>
    p->s.size += bp->s.size;
     f4a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
     f4d:	a3 08 16 00 00       	mov    %eax,0x1608
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
     f52:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     f55:	8b 53 f8             	mov    -0x8(%ebx),%edx
     f58:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
     f5a:	5b                   	pop    %ebx
     f5b:	5e                   	pop    %esi
     f5c:	5f                   	pop    %edi
     f5d:	5d                   	pop    %ebp
     f5e:	c3                   	ret    
     f5f:	90                   	nop

00000f60 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
     f60:	55                   	push   %ebp
     f61:	89 e5                	mov    %esp,%ebp
     f63:	57                   	push   %edi
     f64:	56                   	push   %esi
     f65:	53                   	push   %ebx
     f66:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     f69:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
     f6c:	8b 15 08 16 00 00    	mov    0x1608,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     f72:	8d 78 07             	lea    0x7(%eax),%edi
     f75:	c1 ef 03             	shr    $0x3,%edi
     f78:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
     f7b:	85 d2                	test   %edx,%edx
     f7d:	0f 84 a3 00 00 00    	je     1026 <malloc+0xc6>
     f83:	8b 02                	mov    (%edx),%eax
     f85:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
     f88:	39 cf                	cmp    %ecx,%edi
     f8a:	76 74                	jbe    1000 <malloc+0xa0>
     f8c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
     f92:	be 00 10 00 00       	mov    $0x1000,%esi
     f97:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
     f9e:	0f 43 f7             	cmovae %edi,%esi
     fa1:	ba 00 80 00 00       	mov    $0x8000,%edx
     fa6:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
     fac:	0f 46 da             	cmovbe %edx,%ebx
     faf:	eb 10                	jmp    fc1 <malloc+0x61>
     fb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     fb8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
     fba:	8b 48 04             	mov    0x4(%eax),%ecx
     fbd:	39 cf                	cmp    %ecx,%edi
     fbf:	76 3f                	jbe    1000 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
     fc1:	39 05 08 16 00 00    	cmp    %eax,0x1608
     fc7:	89 c2                	mov    %eax,%edx
     fc9:	75 ed                	jne    fb8 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
     fcb:	83 ec 0c             	sub    $0xc,%esp
     fce:	53                   	push   %ebx
     fcf:	e8 76 fc ff ff       	call   c4a <sbrk>
  if(p == (char*)-1)
     fd4:	83 c4 10             	add    $0x10,%esp
     fd7:	83 f8 ff             	cmp    $0xffffffff,%eax
     fda:	74 1c                	je     ff8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
     fdc:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
     fdf:	83 ec 0c             	sub    $0xc,%esp
     fe2:	83 c0 08             	add    $0x8,%eax
     fe5:	50                   	push   %eax
     fe6:	e8 e5 fe ff ff       	call   ed0 <free>
  return freep;
     feb:	8b 15 08 16 00 00    	mov    0x1608,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
     ff1:	83 c4 10             	add    $0x10,%esp
     ff4:	85 d2                	test   %edx,%edx
     ff6:	75 c0                	jne    fb8 <malloc+0x58>
        return 0;
     ff8:	31 c0                	xor    %eax,%eax
     ffa:	eb 1c                	jmp    1018 <malloc+0xb8>
     ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    1000:	39 cf                	cmp    %ecx,%edi
    1002:	74 1c                	je     1020 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    1004:	29 f9                	sub    %edi,%ecx
    1006:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1009:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    100c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
    100f:	89 15 08 16 00 00    	mov    %edx,0x1608
      return (void*)(p + 1);
    1015:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1018:	8d 65 f4             	lea    -0xc(%ebp),%esp
    101b:	5b                   	pop    %ebx
    101c:	5e                   	pop    %esi
    101d:	5f                   	pop    %edi
    101e:	5d                   	pop    %ebp
    101f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    1020:	8b 08                	mov    (%eax),%ecx
    1022:	89 0a                	mov    %ecx,(%edx)
    1024:	eb e9                	jmp    100f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    1026:	c7 05 08 16 00 00 0c 	movl   $0x160c,0x1608
    102d:	16 00 00 
    1030:	c7 05 0c 16 00 00 0c 	movl   $0x160c,0x160c
    1037:	16 00 00 
    base.s.size = 0;
    103a:	b8 0c 16 00 00       	mov    $0x160c,%eax
    103f:	c7 05 10 16 00 00 00 	movl   $0x0,0x1610
    1046:	00 00 00 
    1049:	e9 3e ff ff ff       	jmp    f8c <malloc+0x2c>
