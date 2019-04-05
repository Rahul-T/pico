
_pico:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
	updatesc(0, 1, buf, TEXT_COLOR);
	// printf(1, "new input");
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
  18:	68 e0 0d 00 00       	push   $0xde0
  1d:	e8 a0 05 00 00       	call   5c2 <captsc>
	drawHeader();
  22:	e8 09 02 00 00       	call   230 <drawHeader>
	updatesc(50, 0, "                         v0.1 ", UI_COLOR);
}

void
drawFooter() {
	updatesc(0, 24, " ^Q - Quit                                                                      ", UI_COLOR);
  27:	68 c0 00 00 00       	push   $0xc0
  2c:	68 28 0a 00 00       	push   $0xa28
  31:	6a 18                	push   $0x18
  33:	6a 00                	push   $0x0
  35:	e8 98 05 00 00       	call   5d2 <updatesc>
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
			printfile(fd);
		}
	} else {
		printf(1, "No file selected");
  42:	83 ec 08             	sub    $0x8,%esp
  45:	68 d5 09 00 00       	push   $0x9d5
  4a:	6a 01                	push   $0x1
  4c:	e8 3f 06 00 00       	call   690 <printf>
  51:	83 c4 10             	add    $0x10,%esp
  54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	}
	while(1) {
		while ((c = getkey()) <= 0) {
  58:	e8 7d 05 00 00       	call   5da <getkey>
  5d:	85 c0                	test   %eax,%eax
  5f:	a3 e0 0d 00 00       	mov    %eax,0xde0
  64:	7e f2                	jle    58 <main+0x58>
		}
		handleInput(c);
  66:	83 ec 0c             	sub    $0xc,%esp
  69:	50                   	push   %eax
  6a:	e8 31 02 00 00       	call   2a0 <handleInput>
		c = 0;
  6f:	c7 05 e0 0d 00 00 00 	movl   $0x0,0xde0
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
  86:	e8 d7 04 00 00       	call   562 <open>
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
  a0:	e8 a5 04 00 00       	call   54a <close>
			fd = open(argv[1], 0);
  a5:	58                   	pop    %eax
  a6:	5a                   	pop    %edx
  a7:	6a 00                	push   $0x0
  a9:	ff 73 04             	pushl  0x4(%ebx)
  ac:	e8 b1 04 00 00       	call   562 <open>
			printfile(fd);
  b1:	89 04 24             	mov    %eax,(%esp)
  b4:	e8 b7 00 00 00       	call   170 <printfile>
  b9:	83 c4 10             	add    $0x10,%esp
  bc:	eb 9a                	jmp    58 <main+0x58>
	drawFooter();
	int fd;

	if (argc == 2) {
		if((fd = open(argv[1], 0)) < 0){
			printf(1, "Cannot open %s\n", argv[1]);
  be:	83 ec 04             	sub    $0x4,%esp
  c1:	ff 73 04             	pushl  0x4(%ebx)
  c4:	68 c5 09 00 00       	push   $0x9c5
  c9:	6a 01                	push   $0x1
  cb:	e8 c0 05 00 00       	call   690 <printf>
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
  eb:	83 ec 28             	sub    $0x28,%esp
	int n;
	char singlechar[1];
	head = malloc(sizeof(struct fileline));
  ee:	6a 58                	push   $0x58
  f0:	e8 cb 07 00 00       	call   8c0 <malloc>
	struct fileline* cur = head;
	int linecounter = 0;

	while((n = read(fd, singlechar, 1)) > 0) {
  f5:	83 c4 10             	add    $0x10,%esp
void
initLinkedList(int fd)
{
	int n;
	char singlechar[1];
	head = malloc(sizeof(struct fileline));
  f8:	89 c3                	mov    %eax,%ebx
  fa:	a3 08 0e 00 00       	mov    %eax,0xe08
  ff:	90                   	nop
	struct fileline* cur = head;
	int linecounter = 0;

	while((n = read(fd, singlechar, 1)) > 0) {
 100:	83 ec 04             	sub    $0x4,%esp
 103:	6a 01                	push   $0x1
 105:	56                   	push   %esi
 106:	ff 75 08             	pushl  0x8(%ebp)
 109:	e8 2c 04 00 00       	call   53a <read>
 10e:	83 c4 10             	add    $0x10,%esp
 111:	85 c0                	test   %eax,%eax
 113:	7e 4b                	jle    160 <initLinkedList+0x80>
		if(linecounter < WIDTH){
 115:	83 ff 50             	cmp    $0x50,%edi
 118:	74 1e                	je     138 <initLinkedList+0x58>
			cur->line[linecounter] = singlechar[0];
 11a:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
			linecounter++;
 11e:	8d 57 01             	lea    0x1(%edi),%edx
	struct fileline* cur = head;
	int linecounter = 0;

	while((n = read(fd, singlechar, 1)) > 0) {
		if(linecounter < WIDTH){
			cur->line[linecounter] = singlechar[0];
 121:	88 04 3b             	mov    %al,(%ebx,%edi,1)
			linecounter++;
 124:	80 7d e7 0a          	cmpb   $0xa,-0x19(%ebp)
 128:	bf 50 00 00 00       	mov    $0x50,%edi
 12d:	0f 45 fa             	cmovne %edx,%edi
 130:	eb ce                	jmp    100 <initLinkedList+0x20>
 132:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
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
 140:	6a 58                	push   $0x58
 142:	e8 79 07 00 00       	call   8c0 <malloc>
			nextline->prev = cur;
			cur->next = nextline;
			cur = nextline;
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
 147:	0f b6 55 e7          	movzbl -0x19(%ebp),%edx
				linecounter = WIDTH;
			}
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
			nextline->prev = cur;
 14b:	89 58 50             	mov    %ebx,0x50(%eax)
			cur->next = nextline;
			cur = nextline;
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
 14e:	83 c4 10             	add    $0x10,%esp
			}
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
			nextline->prev = cur;
			cur->next = nextline;
 151:	89 43 54             	mov    %eax,0x54(%ebx)
			cur = nextline;
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
 154:	89 c3                	mov    %eax,%ebx
 156:	88 10                	mov    %dl,(%eax)
 158:	eb a6                	jmp    100 <initLinkedList+0x20>
 15a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	// 	printf(1, "%s", cur->line);
	// 	cur = cur->next;
	// }
	// printf(1, "%s", cur->line);

}
 160:	8d 65 f4             	lea    -0xc(%ebp),%esp
 163:	5b                   	pop    %ebx
 164:	5e                   	pop    %esi
 165:	5f                   	pop    %edi
 166:	5d                   	pop    %ebp
 167:	c3                   	ret    
 168:	90                   	nop
 169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000170 <printfile>:

void
printfile(int fd)
{
	struct fileline* cur = head;
 170:	8b 0d 08 0e 00 00    	mov    0xe08,%ecx

}

void
printfile(int fd)
{
 176:	55                   	push   %ebp
 177:	89 e5                	mov    %esp,%ebp
 179:	56                   	push   %esi
 17a:	53                   	push   %ebx
	struct fileline* cur = head;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
 17b:	8b 51 54             	mov    0x54(%ecx),%edx
 17e:	31 db                	xor    %ebx,%ebx

}

void
printfile(int fd)
{
 180:	8b 75 08             	mov    0x8(%ebp),%esi
	struct fileline* cur = head;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
 183:	85 d2                	test   %edx,%edx
 185:	74 4d                	je     1d4 <printfile+0x64>
 187:	89 f6                	mov    %esi,%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 190:	31 c0                	xor    %eax,%eax
 192:	eb 14                	jmp    1a8 <printfile+0x38>
 194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		for(int i=0; i<WIDTH; i++){
			if(cur->line[i] == '\0'){
				buf[bufindex] = ' ';
 198:	c6 84 03 20 0e 00 00 	movb   $0x20,0xe20(%ebx,%eax,1)
 19f:	20 
printfile(int fd)
{
	struct fileline* cur = head;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
		for(int i=0; i<WIDTH; i++){
 1a0:	83 c0 01             	add    $0x1,%eax
 1a3:	83 f8 50             	cmp    $0x50,%eax
 1a6:	74 17                	je     1bf <printfile+0x4f>
			if(cur->line[i] == '\0'){
 1a8:	0f b6 14 01          	movzbl (%ecx,%eax,1),%edx
 1ac:	84 d2                	test   %dl,%dl
 1ae:	74 e8                	je     198 <printfile+0x28>
				buf[bufindex] = ' ';
			} else{
				buf[bufindex] = cur->line[i];
 1b0:	88 94 03 20 0e 00 00 	mov    %dl,0xe20(%ebx,%eax,1)
printfile(int fd)
{
	struct fileline* cur = head;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
		for(int i=0; i<WIDTH; i++){
 1b7:	83 c0 01             	add    $0x1,%eax
 1ba:	83 f8 50             	cmp    $0x50,%eax
 1bd:	75 e9                	jne    1a8 <printfile+0x38>
			} else{
				buf[bufindex] = cur->line[i];
			}
			bufindex++;
		}
		cur = cur->next;
 1bf:	8b 49 54             	mov    0x54(%ecx),%ecx
 1c2:	83 c3 50             	add    $0x50,%ebx
void
printfile(int fd)
{
	struct fileline* cur = head;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
 1c5:	8b 41 54             	mov    0x54(%ecx),%eax
 1c8:	85 c0                	test   %eax,%eax
 1ca:	74 08                	je     1d4 <printfile+0x64>
 1cc:	81 fb e0 06 00 00    	cmp    $0x6e0,%ebx
 1d2:	75 bc                	jne    190 <printfile+0x20>

void
printfile(int fd)
{
	struct fileline* cur = head;
	int bufindex = 0;
 1d4:	31 d2                	xor    %edx,%edx
 1d6:	8d 76 00             	lea    0x0(%esi),%esi
 1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
			bufindex++;
		}
		cur = cur->next;
	}
	for(int i=0; i<WIDTH; i++){
			buf[bufindex] = cur->line[i];
 1e0:	0f b6 04 11          	movzbl (%ecx,%edx,1),%eax
 1e4:	88 84 13 20 0e 00 00 	mov    %al,0xe20(%ebx,%edx,1)
			}
			bufindex++;
		}
		cur = cur->next;
	}
	for(int i=0; i<WIDTH; i++){
 1eb:	83 c2 01             	add    $0x1,%edx
 1ee:	83 fa 50             	cmp    $0x50,%edx
 1f1:	75 ed                	jne    1e0 <printfile+0x70>
			buf[bufindex] = cur->line[i];
			bufindex++;
	}

	buf[bufindex] = '\0';
	printf(1, "%s\n", buf);
 1f3:	83 ec 04             	sub    $0x4,%esp
	for(int i=0; i<WIDTH; i++){
			buf[bufindex] = cur->line[i];
			bufindex++;
	}

	buf[bufindex] = '\0';
 1f6:	c6 83 70 0e 00 00 00 	movb   $0x0,0xe70(%ebx)
	printf(1, "%s\n", buf);
 1fd:	68 20 0e 00 00       	push   $0xe20
 202:	68 d1 09 00 00       	push   $0x9d1
 207:	6a 01                	push   $0x1
 209:	e8 82 04 00 00       	call   690 <printf>
	updatesc(0, 1, buf, TEXT_COLOR);
 20e:	6a 07                	push   $0x7
 210:	68 20 0e 00 00       	push   $0xe20
 215:	6a 01                	push   $0x1
 217:	6a 00                	push   $0x0
 219:	e8 b4 03 00 00       	call   5d2 <updatesc>
	close(fd);
 21e:	89 75 08             	mov    %esi,0x8(%ebp)
 221:	83 c4 20             	add    $0x20,%esp
}
 224:	8d 65 f8             	lea    -0x8(%ebp),%esp
 227:	5b                   	pop    %ebx
 228:	5e                   	pop    %esi
 229:	5d                   	pop    %ebp
	}

	buf[bufindex] = '\0';
	printf(1, "%s\n", buf);
	updatesc(0, 1, buf, TEXT_COLOR);
	close(fd);
 22a:	e9 1b 03 00 00       	jmp    54a <close>
 22f:	90                   	nop

00000230 <drawHeader>:
}

void
drawHeader() {
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	83 ec 08             	sub    $0x8,%esp
	updatesc(0, 0, "                              ", UI_COLOR);
 236:	68 c0 00 00 00       	push   $0xc0
 23b:	68 e8 09 00 00       	push   $0x9e8
 240:	6a 00                	push   $0x0
 242:	6a 00                	push   $0x0
 244:	e8 89 03 00 00       	call   5d2 <updatesc>
	updatesc(30, 0, "        PICO        ", UI_COLOR);
 249:	68 c0 00 00 00       	push   $0xc0
 24e:	68 b0 09 00 00       	push   $0x9b0
 253:	6a 00                	push   $0x0
 255:	6a 1e                	push   $0x1e
 257:	e8 76 03 00 00       	call   5d2 <updatesc>
	updatesc(50, 0, "                         v0.1 ", UI_COLOR);
 25c:	83 c4 20             	add    $0x20,%esp
 25f:	68 c0 00 00 00       	push   $0xc0
 264:	68 08 0a 00 00       	push   $0xa08
 269:	6a 00                	push   $0x0
 26b:	6a 32                	push   $0x32
 26d:	e8 60 03 00 00       	call   5d2 <updatesc>
}
 272:	83 c4 10             	add    $0x10,%esp
 275:	c9                   	leave  
 276:	c3                   	ret    
 277:	89 f6                	mov    %esi,%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000280 <drawFooter>:

void
drawFooter() {
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	83 ec 08             	sub    $0x8,%esp
	updatesc(0, 24, " ^Q - Quit                                                                      ", UI_COLOR);
 286:	68 c0 00 00 00       	push   $0xc0
 28b:	68 28 0a 00 00       	push   $0xa28
 290:	6a 18                	push   $0x18
 292:	6a 00                	push   $0x0
 294:	e8 39 03 00 00       	call   5d2 <updatesc>
}
 299:	83 c4 10             	add    $0x10,%esp
 29c:	c9                   	leave  
 29d:	c3                   	ret    
 29e:	66 90                	xchg   %ax,%ax

000002a0 <handleInput>:

void
handleInput(int i) {
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	83 ec 08             	sub    $0x8,%esp
 2a6:	8b 45 08             	mov    0x8(%ebp),%eax
	if (i == 17) {
 2a9:	83 f8 11             	cmp    $0x11,%eax
 2ac:	74 2a                	je     2d8 <handleInput+0x38>
		exit();
	}
	buf[currChar++] = (char) i & 0xff;
 2ae:	8b 15 e4 0d 00 00    	mov    0xde4,%edx
	updatesc(0, 1, buf, TEXT_COLOR);
 2b4:	6a 07                	push   $0x7
 2b6:	68 20 0e 00 00       	push   $0xe20
 2bb:	6a 01                	push   $0x1
 2bd:	6a 00                	push   $0x0
void
handleInput(int i) {
	if (i == 17) {
		exit();
	}
	buf[currChar++] = (char) i & 0xff;
 2bf:	8d 4a 01             	lea    0x1(%edx),%ecx
 2c2:	88 82 20 0e 00 00    	mov    %al,0xe20(%edx)
 2c8:	89 0d e4 0d 00 00    	mov    %ecx,0xde4
	updatesc(0, 1, buf, TEXT_COLOR);
 2ce:	e8 ff 02 00 00       	call   5d2 <updatesc>
	// printf(1, "new input");
}
 2d3:	83 c4 10             	add    $0x10,%esp
 2d6:	c9                   	leave  
 2d7:	c3                   	ret    
}

void
handleInput(int i) {
	if (i == 17) {
		exit();
 2d8:	e8 45 02 00 00       	call   522 <exit>
 2dd:	66 90                	xchg   %ax,%ax
 2df:	90                   	nop

000002e0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	53                   	push   %ebx
 2e4:	8b 45 08             	mov    0x8(%ebp),%eax
 2e7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2ea:	89 c2                	mov    %eax,%edx
 2ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2f0:	83 c1 01             	add    $0x1,%ecx
 2f3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 2f7:	83 c2 01             	add    $0x1,%edx
 2fa:	84 db                	test   %bl,%bl
 2fc:	88 5a ff             	mov    %bl,-0x1(%edx)
 2ff:	75 ef                	jne    2f0 <strcpy+0x10>
    ;
  return os;
}
 301:	5b                   	pop    %ebx
 302:	5d                   	pop    %ebp
 303:	c3                   	ret    
 304:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 30a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000310 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	56                   	push   %esi
 314:	53                   	push   %ebx
 315:	8b 55 08             	mov    0x8(%ebp),%edx
 318:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 31b:	0f b6 02             	movzbl (%edx),%eax
 31e:	0f b6 19             	movzbl (%ecx),%ebx
 321:	84 c0                	test   %al,%al
 323:	75 1e                	jne    343 <strcmp+0x33>
 325:	eb 29                	jmp    350 <strcmp+0x40>
 327:	89 f6                	mov    %esi,%esi
 329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 330:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 333:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 336:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 339:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 33d:	84 c0                	test   %al,%al
 33f:	74 0f                	je     350 <strcmp+0x40>
 341:	89 f1                	mov    %esi,%ecx
 343:	38 d8                	cmp    %bl,%al
 345:	74 e9                	je     330 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 347:	29 d8                	sub    %ebx,%eax
}
 349:	5b                   	pop    %ebx
 34a:	5e                   	pop    %esi
 34b:	5d                   	pop    %ebp
 34c:	c3                   	ret    
 34d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 350:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 352:	29 d8                	sub    %ebx,%eax
}
 354:	5b                   	pop    %ebx
 355:	5e                   	pop    %esi
 356:	5d                   	pop    %ebp
 357:	c3                   	ret    
 358:	90                   	nop
 359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000360 <strlen>:

uint
strlen(char *s)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 366:	80 39 00             	cmpb   $0x0,(%ecx)
 369:	74 12                	je     37d <strlen+0x1d>
 36b:	31 d2                	xor    %edx,%edx
 36d:	8d 76 00             	lea    0x0(%esi),%esi
 370:	83 c2 01             	add    $0x1,%edx
 373:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 377:	89 d0                	mov    %edx,%eax
 379:	75 f5                	jne    370 <strlen+0x10>
    ;
  return n;
}
 37b:	5d                   	pop    %ebp
 37c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 37d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 37f:	5d                   	pop    %ebp
 380:	c3                   	ret    
 381:	eb 0d                	jmp    390 <memset>
 383:	90                   	nop
 384:	90                   	nop
 385:	90                   	nop
 386:	90                   	nop
 387:	90                   	nop
 388:	90                   	nop
 389:	90                   	nop
 38a:	90                   	nop
 38b:	90                   	nop
 38c:	90                   	nop
 38d:	90                   	nop
 38e:	90                   	nop
 38f:	90                   	nop

00000390 <memset>:

void*
memset(void *dst, int c, uint n)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 397:	8b 4d 10             	mov    0x10(%ebp),%ecx
 39a:	8b 45 0c             	mov    0xc(%ebp),%eax
 39d:	89 d7                	mov    %edx,%edi
 39f:	fc                   	cld    
 3a0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3a2:	89 d0                	mov    %edx,%eax
 3a4:	5f                   	pop    %edi
 3a5:	5d                   	pop    %ebp
 3a6:	c3                   	ret    
 3a7:	89 f6                	mov    %esi,%esi
 3a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003b0 <strchr>:

char*
strchr(const char *s, char c)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	53                   	push   %ebx
 3b4:	8b 45 08             	mov    0x8(%ebp),%eax
 3b7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 3ba:	0f b6 10             	movzbl (%eax),%edx
 3bd:	84 d2                	test   %dl,%dl
 3bf:	74 1d                	je     3de <strchr+0x2e>
    if(*s == c)
 3c1:	38 d3                	cmp    %dl,%bl
 3c3:	89 d9                	mov    %ebx,%ecx
 3c5:	75 0d                	jne    3d4 <strchr+0x24>
 3c7:	eb 17                	jmp    3e0 <strchr+0x30>
 3c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3d0:	38 ca                	cmp    %cl,%dl
 3d2:	74 0c                	je     3e0 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 3d4:	83 c0 01             	add    $0x1,%eax
 3d7:	0f b6 10             	movzbl (%eax),%edx
 3da:	84 d2                	test   %dl,%dl
 3dc:	75 f2                	jne    3d0 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 3de:	31 c0                	xor    %eax,%eax
}
 3e0:	5b                   	pop    %ebx
 3e1:	5d                   	pop    %ebp
 3e2:	c3                   	ret    
 3e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003f0 <gets>:

char*
gets(char *buf, int max)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	56                   	push   %esi
 3f5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3f6:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 3f8:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 3fb:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3fe:	eb 29                	jmp    429 <gets+0x39>
    cc = read(0, &c, 1);
 400:	83 ec 04             	sub    $0x4,%esp
 403:	6a 01                	push   $0x1
 405:	57                   	push   %edi
 406:	6a 00                	push   $0x0
 408:	e8 2d 01 00 00       	call   53a <read>
    if(cc < 1)
 40d:	83 c4 10             	add    $0x10,%esp
 410:	85 c0                	test   %eax,%eax
 412:	7e 1d                	jle    431 <gets+0x41>
      break;
    buf[i++] = c;
 414:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 418:	8b 55 08             	mov    0x8(%ebp),%edx
 41b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 41d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 41f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 423:	74 1b                	je     440 <gets+0x50>
 425:	3c 0d                	cmp    $0xd,%al
 427:	74 17                	je     440 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 429:	8d 5e 01             	lea    0x1(%esi),%ebx
 42c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 42f:	7c cf                	jl     400 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 431:	8b 45 08             	mov    0x8(%ebp),%eax
 434:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 438:	8d 65 f4             	lea    -0xc(%ebp),%esp
 43b:	5b                   	pop    %ebx
 43c:	5e                   	pop    %esi
 43d:	5f                   	pop    %edi
 43e:	5d                   	pop    %ebp
 43f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 440:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 443:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 445:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 449:	8d 65 f4             	lea    -0xc(%ebp),%esp
 44c:	5b                   	pop    %ebx
 44d:	5e                   	pop    %esi
 44e:	5f                   	pop    %edi
 44f:	5d                   	pop    %ebp
 450:	c3                   	ret    
 451:	eb 0d                	jmp    460 <stat>
 453:	90                   	nop
 454:	90                   	nop
 455:	90                   	nop
 456:	90                   	nop
 457:	90                   	nop
 458:	90                   	nop
 459:	90                   	nop
 45a:	90                   	nop
 45b:	90                   	nop
 45c:	90                   	nop
 45d:	90                   	nop
 45e:	90                   	nop
 45f:	90                   	nop

00000460 <stat>:

int
stat(char *n, struct stat *st)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	56                   	push   %esi
 464:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 465:	83 ec 08             	sub    $0x8,%esp
 468:	6a 00                	push   $0x0
 46a:	ff 75 08             	pushl  0x8(%ebp)
 46d:	e8 f0 00 00 00       	call   562 <open>
  if(fd < 0)
 472:	83 c4 10             	add    $0x10,%esp
 475:	85 c0                	test   %eax,%eax
 477:	78 27                	js     4a0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 479:	83 ec 08             	sub    $0x8,%esp
 47c:	ff 75 0c             	pushl  0xc(%ebp)
 47f:	89 c3                	mov    %eax,%ebx
 481:	50                   	push   %eax
 482:	e8 f3 00 00 00       	call   57a <fstat>
 487:	89 c6                	mov    %eax,%esi
  close(fd);
 489:	89 1c 24             	mov    %ebx,(%esp)
 48c:	e8 b9 00 00 00       	call   54a <close>
  return r;
 491:	83 c4 10             	add    $0x10,%esp
 494:	89 f0                	mov    %esi,%eax
}
 496:	8d 65 f8             	lea    -0x8(%ebp),%esp
 499:	5b                   	pop    %ebx
 49a:	5e                   	pop    %esi
 49b:	5d                   	pop    %ebp
 49c:	c3                   	ret    
 49d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 4a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4a5:	eb ef                	jmp    496 <stat+0x36>
 4a7:	89 f6                	mov    %esi,%esi
 4a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004b0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	53                   	push   %ebx
 4b4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4b7:	0f be 11             	movsbl (%ecx),%edx
 4ba:	8d 42 d0             	lea    -0x30(%edx),%eax
 4bd:	3c 09                	cmp    $0x9,%al
 4bf:	b8 00 00 00 00       	mov    $0x0,%eax
 4c4:	77 1f                	ja     4e5 <atoi+0x35>
 4c6:	8d 76 00             	lea    0x0(%esi),%esi
 4c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 4d0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 4d3:	83 c1 01             	add    $0x1,%ecx
 4d6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4da:	0f be 11             	movsbl (%ecx),%edx
 4dd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 4e0:	80 fb 09             	cmp    $0x9,%bl
 4e3:	76 eb                	jbe    4d0 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 4e5:	5b                   	pop    %ebx
 4e6:	5d                   	pop    %ebp
 4e7:	c3                   	ret    
 4e8:	90                   	nop
 4e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004f0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	56                   	push   %esi
 4f4:	53                   	push   %ebx
 4f5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4f8:	8b 45 08             	mov    0x8(%ebp),%eax
 4fb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4fe:	85 db                	test   %ebx,%ebx
 500:	7e 14                	jle    516 <memmove+0x26>
 502:	31 d2                	xor    %edx,%edx
 504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 508:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 50c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 50f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 512:	39 da                	cmp    %ebx,%edx
 514:	75 f2                	jne    508 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 516:	5b                   	pop    %ebx
 517:	5e                   	pop    %esi
 518:	5d                   	pop    %ebp
 519:	c3                   	ret    

0000051a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 51a:	b8 01 00 00 00       	mov    $0x1,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <exit>:
SYSCALL(exit)
 522:	b8 02 00 00 00       	mov    $0x2,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    

0000052a <wait>:
SYSCALL(wait)
 52a:	b8 03 00 00 00       	mov    $0x3,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    

00000532 <pipe>:
SYSCALL(pipe)
 532:	b8 04 00 00 00       	mov    $0x4,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret    

0000053a <read>:
SYSCALL(read)
 53a:	b8 05 00 00 00       	mov    $0x5,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret    

00000542 <write>:
SYSCALL(write)
 542:	b8 10 00 00 00       	mov    $0x10,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret    

0000054a <close>:
SYSCALL(close)
 54a:	b8 15 00 00 00       	mov    $0x15,%eax
 54f:	cd 40                	int    $0x40
 551:	c3                   	ret    

00000552 <kill>:
SYSCALL(kill)
 552:	b8 06 00 00 00       	mov    $0x6,%eax
 557:	cd 40                	int    $0x40
 559:	c3                   	ret    

0000055a <exec>:
SYSCALL(exec)
 55a:	b8 07 00 00 00       	mov    $0x7,%eax
 55f:	cd 40                	int    $0x40
 561:	c3                   	ret    

00000562 <open>:
SYSCALL(open)
 562:	b8 0f 00 00 00       	mov    $0xf,%eax
 567:	cd 40                	int    $0x40
 569:	c3                   	ret    

0000056a <mknod>:
SYSCALL(mknod)
 56a:	b8 11 00 00 00       	mov    $0x11,%eax
 56f:	cd 40                	int    $0x40
 571:	c3                   	ret    

00000572 <unlink>:
SYSCALL(unlink)
 572:	b8 12 00 00 00       	mov    $0x12,%eax
 577:	cd 40                	int    $0x40
 579:	c3                   	ret    

0000057a <fstat>:
SYSCALL(fstat)
 57a:	b8 08 00 00 00       	mov    $0x8,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <link>:
SYSCALL(link)
 582:	b8 13 00 00 00       	mov    $0x13,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    

0000058a <mkdir>:
SYSCALL(mkdir)
 58a:	b8 14 00 00 00       	mov    $0x14,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    

00000592 <chdir>:
SYSCALL(chdir)
 592:	b8 09 00 00 00       	mov    $0x9,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    

0000059a <dup>:
SYSCALL(dup)
 59a:	b8 0a 00 00 00       	mov    $0xa,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret    

000005a2 <getpid>:
SYSCALL(getpid)
 5a2:	b8 0b 00 00 00       	mov    $0xb,%eax
 5a7:	cd 40                	int    $0x40
 5a9:	c3                   	ret    

000005aa <sbrk>:
SYSCALL(sbrk)
 5aa:	b8 0c 00 00 00       	mov    $0xc,%eax
 5af:	cd 40                	int    $0x40
 5b1:	c3                   	ret    

000005b2 <sleep>:
SYSCALL(sleep)
 5b2:	b8 0d 00 00 00       	mov    $0xd,%eax
 5b7:	cd 40                	int    $0x40
 5b9:	c3                   	ret    

000005ba <uptime>:
SYSCALL(uptime)
 5ba:	b8 0e 00 00 00       	mov    $0xe,%eax
 5bf:	cd 40                	int    $0x40
 5c1:	c3                   	ret    

000005c2 <captsc>:
SYSCALL(captsc)
 5c2:	b8 16 00 00 00       	mov    $0x16,%eax
 5c7:	cd 40                	int    $0x40
 5c9:	c3                   	ret    

000005ca <freesc>:
SYSCALL(freesc)
 5ca:	b8 17 00 00 00       	mov    $0x17,%eax
 5cf:	cd 40                	int    $0x40
 5d1:	c3                   	ret    

000005d2 <updatesc>:
SYSCALL(updatesc)
 5d2:	b8 18 00 00 00       	mov    $0x18,%eax
 5d7:	cd 40                	int    $0x40
 5d9:	c3                   	ret    

000005da <getkey>:
SYSCALL(getkey)
 5da:	b8 19 00 00 00       	mov    $0x19,%eax
 5df:	cd 40                	int    $0x40
 5e1:	c3                   	ret    
 5e2:	66 90                	xchg   %ax,%ax
 5e4:	66 90                	xchg   %ax,%ax
 5e6:	66 90                	xchg   %ax,%ax
 5e8:	66 90                	xchg   %ax,%ax
 5ea:	66 90                	xchg   %ax,%ax
 5ec:	66 90                	xchg   %ax,%ax
 5ee:	66 90                	xchg   %ax,%ax

000005f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	57                   	push   %edi
 5f4:	56                   	push   %esi
 5f5:	53                   	push   %ebx
 5f6:	89 c6                	mov    %eax,%esi
 5f8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5fe:	85 db                	test   %ebx,%ebx
 600:	74 7e                	je     680 <printint+0x90>
 602:	89 d0                	mov    %edx,%eax
 604:	c1 e8 1f             	shr    $0x1f,%eax
 607:	84 c0                	test   %al,%al
 609:	74 75                	je     680 <printint+0x90>
    neg = 1;
    x = -xx;
 60b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 60d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 614:	f7 d8                	neg    %eax
 616:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 619:	31 ff                	xor    %edi,%edi
 61b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 61e:	89 ce                	mov    %ecx,%esi
 620:	eb 08                	jmp    62a <printint+0x3a>
 622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 628:	89 cf                	mov    %ecx,%edi
 62a:	31 d2                	xor    %edx,%edx
 62c:	8d 4f 01             	lea    0x1(%edi),%ecx
 62f:	f7 f6                	div    %esi
 631:	0f b6 92 84 0a 00 00 	movzbl 0xa84(%edx),%edx
  }while((x /= base) != 0);
 638:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 63a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 63d:	75 e9                	jne    628 <printint+0x38>
  if(neg)
 63f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 642:	8b 75 c0             	mov    -0x40(%ebp),%esi
 645:	85 c0                	test   %eax,%eax
 647:	74 08                	je     651 <printint+0x61>
    buf[i++] = '-';
 649:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 64e:	8d 4f 02             	lea    0x2(%edi),%ecx
 651:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 655:	8d 76 00             	lea    0x0(%esi),%esi
 658:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 65b:	83 ec 04             	sub    $0x4,%esp
 65e:	83 ef 01             	sub    $0x1,%edi
 661:	6a 01                	push   $0x1
 663:	53                   	push   %ebx
 664:	56                   	push   %esi
 665:	88 45 d7             	mov    %al,-0x29(%ebp)
 668:	e8 d5 fe ff ff       	call   542 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 66d:	83 c4 10             	add    $0x10,%esp
 670:	39 df                	cmp    %ebx,%edi
 672:	75 e4                	jne    658 <printint+0x68>
    putc(fd, buf[i]);
}
 674:	8d 65 f4             	lea    -0xc(%ebp),%esp
 677:	5b                   	pop    %ebx
 678:	5e                   	pop    %esi
 679:	5f                   	pop    %edi
 67a:	5d                   	pop    %ebp
 67b:	c3                   	ret    
 67c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 680:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 682:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 689:	eb 8b                	jmp    616 <printint+0x26>
 68b:	90                   	nop
 68c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000690 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	57                   	push   %edi
 694:	56                   	push   %esi
 695:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 696:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 699:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 69c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 69f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6a2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 6a5:	0f b6 1e             	movzbl (%esi),%ebx
 6a8:	83 c6 01             	add    $0x1,%esi
 6ab:	84 db                	test   %bl,%bl
 6ad:	0f 84 b0 00 00 00    	je     763 <printf+0xd3>
 6b3:	31 d2                	xor    %edx,%edx
 6b5:	eb 39                	jmp    6f0 <printf+0x60>
 6b7:	89 f6                	mov    %esi,%esi
 6b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6c0:	83 f8 25             	cmp    $0x25,%eax
 6c3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 6c6:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6cb:	74 18                	je     6e5 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6cd:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 6d0:	83 ec 04             	sub    $0x4,%esp
 6d3:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 6d6:	6a 01                	push   $0x1
 6d8:	50                   	push   %eax
 6d9:	57                   	push   %edi
 6da:	e8 63 fe ff ff       	call   542 <write>
 6df:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 6e2:	83 c4 10             	add    $0x10,%esp
 6e5:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6e8:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 6ec:	84 db                	test   %bl,%bl
 6ee:	74 73                	je     763 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 6f0:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 6f2:	0f be cb             	movsbl %bl,%ecx
 6f5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 6f8:	74 c6                	je     6c0 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6fa:	83 fa 25             	cmp    $0x25,%edx
 6fd:	75 e6                	jne    6e5 <printf+0x55>
      if(c == 'd'){
 6ff:	83 f8 64             	cmp    $0x64,%eax
 702:	0f 84 f8 00 00 00    	je     800 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 708:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 70e:	83 f9 70             	cmp    $0x70,%ecx
 711:	74 5d                	je     770 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 713:	83 f8 73             	cmp    $0x73,%eax
 716:	0f 84 84 00 00 00    	je     7a0 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 71c:	83 f8 63             	cmp    $0x63,%eax
 71f:	0f 84 ea 00 00 00    	je     80f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 725:	83 f8 25             	cmp    $0x25,%eax
 728:	0f 84 c2 00 00 00    	je     7f0 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 72e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 731:	83 ec 04             	sub    $0x4,%esp
 734:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 738:	6a 01                	push   $0x1
 73a:	50                   	push   %eax
 73b:	57                   	push   %edi
 73c:	e8 01 fe ff ff       	call   542 <write>
 741:	83 c4 0c             	add    $0xc,%esp
 744:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 747:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 74a:	6a 01                	push   $0x1
 74c:	50                   	push   %eax
 74d:	57                   	push   %edi
 74e:	83 c6 01             	add    $0x1,%esi
 751:	e8 ec fd ff ff       	call   542 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 756:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 75a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 75d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 75f:	84 db                	test   %bl,%bl
 761:	75 8d                	jne    6f0 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 763:	8d 65 f4             	lea    -0xc(%ebp),%esp
 766:	5b                   	pop    %ebx
 767:	5e                   	pop    %esi
 768:	5f                   	pop    %edi
 769:	5d                   	pop    %ebp
 76a:	c3                   	ret    
 76b:	90                   	nop
 76c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 770:	83 ec 0c             	sub    $0xc,%esp
 773:	b9 10 00 00 00       	mov    $0x10,%ecx
 778:	6a 00                	push   $0x0
 77a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 77d:	89 f8                	mov    %edi,%eax
 77f:	8b 13                	mov    (%ebx),%edx
 781:	e8 6a fe ff ff       	call   5f0 <printint>
        ap++;
 786:	89 d8                	mov    %ebx,%eax
 788:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 78b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 78d:	83 c0 04             	add    $0x4,%eax
 790:	89 45 d0             	mov    %eax,-0x30(%ebp)
 793:	e9 4d ff ff ff       	jmp    6e5 <printf+0x55>
 798:	90                   	nop
 799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 7a0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 7a3:	8b 18                	mov    (%eax),%ebx
        ap++;
 7a5:	83 c0 04             	add    $0x4,%eax
 7a8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 7ab:	b8 7c 0a 00 00       	mov    $0xa7c,%eax
 7b0:	85 db                	test   %ebx,%ebx
 7b2:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 7b5:	0f b6 03             	movzbl (%ebx),%eax
 7b8:	84 c0                	test   %al,%al
 7ba:	74 23                	je     7df <printf+0x14f>
 7bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7c0:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7c3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 7c6:	83 ec 04             	sub    $0x4,%esp
 7c9:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 7cb:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7ce:	50                   	push   %eax
 7cf:	57                   	push   %edi
 7d0:	e8 6d fd ff ff       	call   542 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7d5:	0f b6 03             	movzbl (%ebx),%eax
 7d8:	83 c4 10             	add    $0x10,%esp
 7db:	84 c0                	test   %al,%al
 7dd:	75 e1                	jne    7c0 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7df:	31 d2                	xor    %edx,%edx
 7e1:	e9 ff fe ff ff       	jmp    6e5 <printf+0x55>
 7e6:	8d 76 00             	lea    0x0(%esi),%esi
 7e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7f0:	83 ec 04             	sub    $0x4,%esp
 7f3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 7f6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 7f9:	6a 01                	push   $0x1
 7fb:	e9 4c ff ff ff       	jmp    74c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 800:	83 ec 0c             	sub    $0xc,%esp
 803:	b9 0a 00 00 00       	mov    $0xa,%ecx
 808:	6a 01                	push   $0x1
 80a:	e9 6b ff ff ff       	jmp    77a <printf+0xea>
 80f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 812:	83 ec 04             	sub    $0x4,%esp
 815:	8b 03                	mov    (%ebx),%eax
 817:	6a 01                	push   $0x1
 819:	88 45 e4             	mov    %al,-0x1c(%ebp)
 81c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 81f:	50                   	push   %eax
 820:	57                   	push   %edi
 821:	e8 1c fd ff ff       	call   542 <write>
 826:	e9 5b ff ff ff       	jmp    786 <printf+0xf6>
 82b:	66 90                	xchg   %ax,%ax
 82d:	66 90                	xchg   %ax,%ax
 82f:	90                   	nop

00000830 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 830:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 831:	a1 e8 0d 00 00       	mov    0xde8,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 836:	89 e5                	mov    %esp,%ebp
 838:	57                   	push   %edi
 839:	56                   	push   %esi
 83a:	53                   	push   %ebx
 83b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 83e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 840:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 843:	39 c8                	cmp    %ecx,%eax
 845:	73 19                	jae    860 <free+0x30>
 847:	89 f6                	mov    %esi,%esi
 849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 850:	39 d1                	cmp    %edx,%ecx
 852:	72 1c                	jb     870 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 854:	39 d0                	cmp    %edx,%eax
 856:	73 18                	jae    870 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 858:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 85a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 85c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 85e:	72 f0                	jb     850 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 860:	39 d0                	cmp    %edx,%eax
 862:	72 f4                	jb     858 <free+0x28>
 864:	39 d1                	cmp    %edx,%ecx
 866:	73 f0                	jae    858 <free+0x28>
 868:	90                   	nop
 869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 870:	8b 73 fc             	mov    -0x4(%ebx),%esi
 873:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 876:	39 d7                	cmp    %edx,%edi
 878:	74 19                	je     893 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 87a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 87d:	8b 50 04             	mov    0x4(%eax),%edx
 880:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 883:	39 f1                	cmp    %esi,%ecx
 885:	74 23                	je     8aa <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 887:	89 08                	mov    %ecx,(%eax)
  freep = p;
 889:	a3 e8 0d 00 00       	mov    %eax,0xde8
}
 88e:	5b                   	pop    %ebx
 88f:	5e                   	pop    %esi
 890:	5f                   	pop    %edi
 891:	5d                   	pop    %ebp
 892:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 893:	03 72 04             	add    0x4(%edx),%esi
 896:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 899:	8b 10                	mov    (%eax),%edx
 89b:	8b 12                	mov    (%edx),%edx
 89d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 8a0:	8b 50 04             	mov    0x4(%eax),%edx
 8a3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8a6:	39 f1                	cmp    %esi,%ecx
 8a8:	75 dd                	jne    887 <free+0x57>
    p->s.size += bp->s.size;
 8aa:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 8ad:	a3 e8 0d 00 00       	mov    %eax,0xde8
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8b2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8b5:	8b 53 f8             	mov    -0x8(%ebx),%edx
 8b8:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 8ba:	5b                   	pop    %ebx
 8bb:	5e                   	pop    %esi
 8bc:	5f                   	pop    %edi
 8bd:	5d                   	pop    %ebp
 8be:	c3                   	ret    
 8bf:	90                   	nop

000008c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8c0:	55                   	push   %ebp
 8c1:	89 e5                	mov    %esp,%ebp
 8c3:	57                   	push   %edi
 8c4:	56                   	push   %esi
 8c5:	53                   	push   %ebx
 8c6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 8cc:	8b 15 e8 0d 00 00    	mov    0xde8,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8d2:	8d 78 07             	lea    0x7(%eax),%edi
 8d5:	c1 ef 03             	shr    $0x3,%edi
 8d8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 8db:	85 d2                	test   %edx,%edx
 8dd:	0f 84 a3 00 00 00    	je     986 <malloc+0xc6>
 8e3:	8b 02                	mov    (%edx),%eax
 8e5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 8e8:	39 cf                	cmp    %ecx,%edi
 8ea:	76 74                	jbe    960 <malloc+0xa0>
 8ec:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 8f2:	be 00 10 00 00       	mov    $0x1000,%esi
 8f7:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 8fe:	0f 43 f7             	cmovae %edi,%esi
 901:	ba 00 80 00 00       	mov    $0x8000,%edx
 906:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 90c:	0f 46 da             	cmovbe %edx,%ebx
 90f:	eb 10                	jmp    921 <malloc+0x61>
 911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 918:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 91a:	8b 48 04             	mov    0x4(%eax),%ecx
 91d:	39 cf                	cmp    %ecx,%edi
 91f:	76 3f                	jbe    960 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 921:	39 05 e8 0d 00 00    	cmp    %eax,0xde8
 927:	89 c2                	mov    %eax,%edx
 929:	75 ed                	jne    918 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 92b:	83 ec 0c             	sub    $0xc,%esp
 92e:	53                   	push   %ebx
 92f:	e8 76 fc ff ff       	call   5aa <sbrk>
  if(p == (char*)-1)
 934:	83 c4 10             	add    $0x10,%esp
 937:	83 f8 ff             	cmp    $0xffffffff,%eax
 93a:	74 1c                	je     958 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 93c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 93f:	83 ec 0c             	sub    $0xc,%esp
 942:	83 c0 08             	add    $0x8,%eax
 945:	50                   	push   %eax
 946:	e8 e5 fe ff ff       	call   830 <free>
  return freep;
 94b:	8b 15 e8 0d 00 00    	mov    0xde8,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 951:	83 c4 10             	add    $0x10,%esp
 954:	85 d2                	test   %edx,%edx
 956:	75 c0                	jne    918 <malloc+0x58>
        return 0;
 958:	31 c0                	xor    %eax,%eax
 95a:	eb 1c                	jmp    978 <malloc+0xb8>
 95c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 960:	39 cf                	cmp    %ecx,%edi
 962:	74 1c                	je     980 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 964:	29 f9                	sub    %edi,%ecx
 966:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 969:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 96c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 96f:	89 15 e8 0d 00 00    	mov    %edx,0xde8
      return (void*)(p + 1);
 975:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 978:	8d 65 f4             	lea    -0xc(%ebp),%esp
 97b:	5b                   	pop    %ebx
 97c:	5e                   	pop    %esi
 97d:	5f                   	pop    %edi
 97e:	5d                   	pop    %ebp
 97f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 980:	8b 08                	mov    (%eax),%ecx
 982:	89 0a                	mov    %ecx,(%edx)
 984:	eb e9                	jmp    96f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 986:	c7 05 e8 0d 00 00 ec 	movl   $0xdec,0xde8
 98d:	0d 00 00 
 990:	c7 05 ec 0d 00 00 ec 	movl   $0xdec,0xdec
 997:	0d 00 00 
    base.s.size = 0;
 99a:	b8 ec 0d 00 00       	mov    $0xdec,%eax
 99f:	c7 05 f0 0d 00 00 00 	movl   $0x0,0xdf0
 9a6:	00 00 00 
 9a9:	e9 3e ff ff ff       	jmp    8ec <malloc+0x2c>
