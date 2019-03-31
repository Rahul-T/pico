
_pico:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
drawFooter() {
	updatesc(0, 24, " PRESS ENTER TO CLOSE                                                           ", UI_COLOR);
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
  10:	83 ec 0c             	sub    $0xc,%esp
  13:	8b 19                	mov    (%ecx),%ebx
  15:	8b 71 04             	mov    0x4(%ecx),%esi
	captsc();
  18:	e8 45 04 00 00       	call   462 <captsc>
	drawHeader();
  1d:	e8 ee 00 00 00       	call   110 <drawHeader>
	updatesc(50, 0, "                         v0.1 ", UI_COLOR);
}

void
drawFooter() {
	updatesc(0, 24, " PRESS ENTER TO CLOSE                                                           ", UI_COLOR);
  22:	68 c0 00 00 00       	push   $0xc0
  27:	68 c4 08 00 00       	push   $0x8c4
  2c:	6a 18                	push   $0x18
  2e:	6a 00                	push   $0x0
  30:	e8 3d 04 00 00       	call   472 <updatesc>
	drawHeader();
	drawFooter();

	int fd;

	if (argc == 2) {
  35:	83 c4 10             	add    $0x10,%esp
  38:	83 fb 02             	cmp    $0x2,%ebx
  3b:	74 2a                	je     67 <main+0x67>
			printf(1, "Cannot open %s\n", argv[1]);
		} else {
			printfile(fd);
		}
	} else {
		printf(1, "No file selected");
  3d:	83 ec 08             	sub    $0x8,%esp
  40:	68 71 08 00 00       	push   $0x871
  45:	6a 01                	push   $0x1
  47:	e8 d4 04 00 00       	call   520 <printf>
  4c:	83 c4 10             	add    $0x10,%esp
	}
	read(0, 0, 100);
  4f:	83 ec 04             	sub    $0x4,%esp
  52:	6a 64                	push   $0x64
  54:	6a 00                	push   $0x0
  56:	6a 00                	push   $0x0
  58:	e8 7d 03 00 00       	call   3da <read>
	freesc();
  5d:	e8 08 04 00 00       	call   46a <freesc>

	exit();
  62:	e8 5b 03 00 00       	call   3c2 <exit>
	drawFooter();

	int fd;

	if (argc == 2) {
		if((fd = open(argv[1], 0)) < 0){
  67:	52                   	push   %edx
  68:	52                   	push   %edx
  69:	6a 00                	push   $0x0
  6b:	ff 76 04             	pushl  0x4(%esi)
  6e:	e8 8f 03 00 00       	call   402 <open>
  73:	83 c4 10             	add    $0x10,%esp
  76:	85 c0                	test   %eax,%eax
  78:	78 0e                	js     88 <main+0x88>
			printf(1, "Cannot open %s\n", argv[1]);
		} else {
			printfile(fd);
  7a:	83 ec 0c             	sub    $0xc,%esp
  7d:	50                   	push   %eax
  7e:	e8 1d 00 00 00       	call   a0 <printfile>
  83:	83 c4 10             	add    $0x10,%esp
  86:	eb c7                	jmp    4f <main+0x4f>

	int fd;

	if (argc == 2) {
		if((fd = open(argv[1], 0)) < 0){
			printf(1, "Cannot open %s\n", argv[1]);
  88:	50                   	push   %eax
  89:	ff 76 04             	pushl  0x4(%esi)
  8c:	68 61 08 00 00       	push   $0x861
  91:	6a 01                	push   $0x1
  93:	e8 88 04 00 00       	call   520 <printf>
  98:	83 c4 10             	add    $0x10,%esp
  9b:	eb b2                	jmp    4f <main+0x4f>
  9d:	66 90                	xchg   %ax,%ax
  9f:	90                   	nop

000000a0 <printfile>:

char buf[TOTAL_CHARS];

void
printfile(int fd)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	53                   	push   %ebx
  a4:	83 ec 04             	sub    $0x4,%esp
  a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
	int n;

	while((n = read(fd, buf, TOTAL_CHARS)) > 0) {
  aa:	eb 17                	jmp    c3 <printfile+0x23>
  ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		// if (write(1, buf, n) != n) {
		// 	printf(1, "Write error\n");
		// 	return;
		// }
		updatesc(0, 1, buf, TEXT_COLOR);
  b0:	6a 07                	push   $0x7
  b2:	68 60 0c 00 00       	push   $0xc60
  b7:	6a 01                	push   $0x1
  b9:	6a 00                	push   $0x0
  bb:	e8 b2 03 00 00       	call   472 <updatesc>
  c0:	83 c4 10             	add    $0x10,%esp
void
printfile(int fd)
{
	int n;

	while((n = read(fd, buf, TOTAL_CHARS)) > 0) {
  c3:	83 ec 04             	sub    $0x4,%esp
  c6:	68 80 07 00 00       	push   $0x780
  cb:	68 60 0c 00 00       	push   $0xc60
  d0:	53                   	push   %ebx
  d1:	e8 04 03 00 00       	call   3da <read>
  d6:	83 c4 10             	add    $0x10,%esp
  d9:	83 f8 00             	cmp    $0x0,%eax
  dc:	7f d2                	jg     b0 <printfile+0x10>
		// 	printf(1, "Write error\n");
		// 	return;
		// }
		updatesc(0, 1, buf, TEXT_COLOR);
	}
	if(n < 0){
  de:	75 10                	jne    f0 <printfile+0x50>
		printf(1, "Read error\n");
		return;
	}
	close(fd);
  e0:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
  e3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  e6:	c9                   	leave  
	}
	if(n < 0){
		printf(1, "Read error\n");
		return;
	}
	close(fd);
  e7:	e9 fe 02 00 00       	jmp    3ea <close>
  ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		// 	return;
		// }
		updatesc(0, 1, buf, TEXT_COLOR);
	}
	if(n < 0){
		printf(1, "Read error\n");
  f0:	83 ec 08             	sub    $0x8,%esp
  f3:	68 40 08 00 00       	push   $0x840
  f8:	6a 01                	push   $0x1
  fa:	e8 21 04 00 00       	call   520 <printf>
  ff:	83 c4 10             	add    $0x10,%esp
		return;
	}
	close(fd);
}
 102:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 105:	c9                   	leave  
 106:	c3                   	ret    
 107:	89 f6                	mov    %esi,%esi
 109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000110 <drawHeader>:

void
drawHeader() {
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	83 ec 08             	sub    $0x8,%esp
	updatesc(0, 0, "                              ", UI_COLOR);
 116:	68 c0 00 00 00       	push   $0xc0
 11b:	68 84 08 00 00       	push   $0x884
 120:	6a 00                	push   $0x0
 122:	6a 00                	push   $0x0
 124:	e8 49 03 00 00       	call   472 <updatesc>
	updatesc(30, 0, "        PICO        ", UI_COLOR);
 129:	68 c0 00 00 00       	push   $0xc0
 12e:	68 4c 08 00 00       	push   $0x84c
 133:	6a 00                	push   $0x0
 135:	6a 1e                	push   $0x1e
 137:	e8 36 03 00 00       	call   472 <updatesc>
	updatesc(50, 0, "                         v0.1 ", UI_COLOR);
 13c:	83 c4 20             	add    $0x20,%esp
 13f:	68 c0 00 00 00       	push   $0xc0
 144:	68 a4 08 00 00       	push   $0x8a4
 149:	6a 00                	push   $0x0
 14b:	6a 32                	push   $0x32
 14d:	e8 20 03 00 00       	call   472 <updatesc>
}
 152:	83 c4 10             	add    $0x10,%esp
 155:	c9                   	leave  
 156:	c3                   	ret    
 157:	89 f6                	mov    %esi,%esi
 159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000160 <drawFooter>:

void
drawFooter() {
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	83 ec 08             	sub    $0x8,%esp
	updatesc(0, 24, " PRESS ENTER TO CLOSE                                                           ", UI_COLOR);
 166:	68 c0 00 00 00       	push   $0xc0
 16b:	68 c4 08 00 00       	push   $0x8c4
 170:	6a 18                	push   $0x18
 172:	6a 00                	push   $0x0
 174:	e8 f9 02 00 00       	call   472 <updatesc>
}
 179:	83 c4 10             	add    $0x10,%esp
 17c:	c9                   	leave  
 17d:	c3                   	ret    
 17e:	66 90                	xchg   %ax,%ax

00000180 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	53                   	push   %ebx
 184:	8b 45 08             	mov    0x8(%ebp),%eax
 187:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 18a:	89 c2                	mov    %eax,%edx
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 190:	83 c1 01             	add    $0x1,%ecx
 193:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 197:	83 c2 01             	add    $0x1,%edx
 19a:	84 db                	test   %bl,%bl
 19c:	88 5a ff             	mov    %bl,-0x1(%edx)
 19f:	75 ef                	jne    190 <strcpy+0x10>
    ;
  return os;
}
 1a1:	5b                   	pop    %ebx
 1a2:	5d                   	pop    %ebp
 1a3:	c3                   	ret    
 1a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	56                   	push   %esi
 1b4:	53                   	push   %ebx
 1b5:	8b 55 08             	mov    0x8(%ebp),%edx
 1b8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1bb:	0f b6 02             	movzbl (%edx),%eax
 1be:	0f b6 19             	movzbl (%ecx),%ebx
 1c1:	84 c0                	test   %al,%al
 1c3:	75 1e                	jne    1e3 <strcmp+0x33>
 1c5:	eb 29                	jmp    1f0 <strcmp+0x40>
 1c7:	89 f6                	mov    %esi,%esi
 1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 1d0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1d3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 1d6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1d9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 1dd:	84 c0                	test   %al,%al
 1df:	74 0f                	je     1f0 <strcmp+0x40>
 1e1:	89 f1                	mov    %esi,%ecx
 1e3:	38 d8                	cmp    %bl,%al
 1e5:	74 e9                	je     1d0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1e7:	29 d8                	sub    %ebx,%eax
}
 1e9:	5b                   	pop    %ebx
 1ea:	5e                   	pop    %esi
 1eb:	5d                   	pop    %ebp
 1ec:	c3                   	ret    
 1ed:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1f0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1f2:	29 d8                	sub    %ebx,%eax
}
 1f4:	5b                   	pop    %ebx
 1f5:	5e                   	pop    %esi
 1f6:	5d                   	pop    %ebp
 1f7:	c3                   	ret    
 1f8:	90                   	nop
 1f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000200 <strlen>:

uint
strlen(char *s)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 206:	80 39 00             	cmpb   $0x0,(%ecx)
 209:	74 12                	je     21d <strlen+0x1d>
 20b:	31 d2                	xor    %edx,%edx
 20d:	8d 76 00             	lea    0x0(%esi),%esi
 210:	83 c2 01             	add    $0x1,%edx
 213:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 217:	89 d0                	mov    %edx,%eax
 219:	75 f5                	jne    210 <strlen+0x10>
    ;
  return n;
}
 21b:	5d                   	pop    %ebp
 21c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 21d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 21f:	5d                   	pop    %ebp
 220:	c3                   	ret    
 221:	eb 0d                	jmp    230 <memset>
 223:	90                   	nop
 224:	90                   	nop
 225:	90                   	nop
 226:	90                   	nop
 227:	90                   	nop
 228:	90                   	nop
 229:	90                   	nop
 22a:	90                   	nop
 22b:	90                   	nop
 22c:	90                   	nop
 22d:	90                   	nop
 22e:	90                   	nop
 22f:	90                   	nop

00000230 <memset>:

void*
memset(void *dst, int c, uint n)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	57                   	push   %edi
 234:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 237:	8b 4d 10             	mov    0x10(%ebp),%ecx
 23a:	8b 45 0c             	mov    0xc(%ebp),%eax
 23d:	89 d7                	mov    %edx,%edi
 23f:	fc                   	cld    
 240:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 242:	89 d0                	mov    %edx,%eax
 244:	5f                   	pop    %edi
 245:	5d                   	pop    %ebp
 246:	c3                   	ret    
 247:	89 f6                	mov    %esi,%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <strchr>:

char*
strchr(const char *s, char c)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	53                   	push   %ebx
 254:	8b 45 08             	mov    0x8(%ebp),%eax
 257:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 25a:	0f b6 10             	movzbl (%eax),%edx
 25d:	84 d2                	test   %dl,%dl
 25f:	74 1d                	je     27e <strchr+0x2e>
    if(*s == c)
 261:	38 d3                	cmp    %dl,%bl
 263:	89 d9                	mov    %ebx,%ecx
 265:	75 0d                	jne    274 <strchr+0x24>
 267:	eb 17                	jmp    280 <strchr+0x30>
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 270:	38 ca                	cmp    %cl,%dl
 272:	74 0c                	je     280 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 274:	83 c0 01             	add    $0x1,%eax
 277:	0f b6 10             	movzbl (%eax),%edx
 27a:	84 d2                	test   %dl,%dl
 27c:	75 f2                	jne    270 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 27e:	31 c0                	xor    %eax,%eax
}
 280:	5b                   	pop    %ebx
 281:	5d                   	pop    %ebp
 282:	c3                   	ret    
 283:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000290 <gets>:

char*
gets(char *buf, int max)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	57                   	push   %edi
 294:	56                   	push   %esi
 295:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 296:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 298:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 29b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 29e:	eb 29                	jmp    2c9 <gets+0x39>
    cc = read(0, &c, 1);
 2a0:	83 ec 04             	sub    $0x4,%esp
 2a3:	6a 01                	push   $0x1
 2a5:	57                   	push   %edi
 2a6:	6a 00                	push   $0x0
 2a8:	e8 2d 01 00 00       	call   3da <read>
    if(cc < 1)
 2ad:	83 c4 10             	add    $0x10,%esp
 2b0:	85 c0                	test   %eax,%eax
 2b2:	7e 1d                	jle    2d1 <gets+0x41>
      break;
    buf[i++] = c;
 2b4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2b8:	8b 55 08             	mov    0x8(%ebp),%edx
 2bb:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 2bd:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 2bf:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 2c3:	74 1b                	je     2e0 <gets+0x50>
 2c5:	3c 0d                	cmp    $0xd,%al
 2c7:	74 17                	je     2e0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2c9:	8d 5e 01             	lea    0x1(%esi),%ebx
 2cc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2cf:	7c cf                	jl     2a0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2d1:	8b 45 08             	mov    0x8(%ebp),%eax
 2d4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2db:	5b                   	pop    %ebx
 2dc:	5e                   	pop    %esi
 2dd:	5f                   	pop    %edi
 2de:	5d                   	pop    %ebp
 2df:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2e0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2e3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2e5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2ec:	5b                   	pop    %ebx
 2ed:	5e                   	pop    %esi
 2ee:	5f                   	pop    %edi
 2ef:	5d                   	pop    %ebp
 2f0:	c3                   	ret    
 2f1:	eb 0d                	jmp    300 <stat>
 2f3:	90                   	nop
 2f4:	90                   	nop
 2f5:	90                   	nop
 2f6:	90                   	nop
 2f7:	90                   	nop
 2f8:	90                   	nop
 2f9:	90                   	nop
 2fa:	90                   	nop
 2fb:	90                   	nop
 2fc:	90                   	nop
 2fd:	90                   	nop
 2fe:	90                   	nop
 2ff:	90                   	nop

00000300 <stat>:

int
stat(char *n, struct stat *st)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	56                   	push   %esi
 304:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 305:	83 ec 08             	sub    $0x8,%esp
 308:	6a 00                	push   $0x0
 30a:	ff 75 08             	pushl  0x8(%ebp)
 30d:	e8 f0 00 00 00       	call   402 <open>
  if(fd < 0)
 312:	83 c4 10             	add    $0x10,%esp
 315:	85 c0                	test   %eax,%eax
 317:	78 27                	js     340 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 319:	83 ec 08             	sub    $0x8,%esp
 31c:	ff 75 0c             	pushl  0xc(%ebp)
 31f:	89 c3                	mov    %eax,%ebx
 321:	50                   	push   %eax
 322:	e8 f3 00 00 00       	call   41a <fstat>
 327:	89 c6                	mov    %eax,%esi
  close(fd);
 329:	89 1c 24             	mov    %ebx,(%esp)
 32c:	e8 b9 00 00 00       	call   3ea <close>
  return r;
 331:	83 c4 10             	add    $0x10,%esp
 334:	89 f0                	mov    %esi,%eax
}
 336:	8d 65 f8             	lea    -0x8(%ebp),%esp
 339:	5b                   	pop    %ebx
 33a:	5e                   	pop    %esi
 33b:	5d                   	pop    %ebp
 33c:	c3                   	ret    
 33d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 340:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 345:	eb ef                	jmp    336 <stat+0x36>
 347:	89 f6                	mov    %esi,%esi
 349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000350 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	53                   	push   %ebx
 354:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 357:	0f be 11             	movsbl (%ecx),%edx
 35a:	8d 42 d0             	lea    -0x30(%edx),%eax
 35d:	3c 09                	cmp    $0x9,%al
 35f:	b8 00 00 00 00       	mov    $0x0,%eax
 364:	77 1f                	ja     385 <atoi+0x35>
 366:	8d 76 00             	lea    0x0(%esi),%esi
 369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 370:	8d 04 80             	lea    (%eax,%eax,4),%eax
 373:	83 c1 01             	add    $0x1,%ecx
 376:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 37a:	0f be 11             	movsbl (%ecx),%edx
 37d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 380:	80 fb 09             	cmp    $0x9,%bl
 383:	76 eb                	jbe    370 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 385:	5b                   	pop    %ebx
 386:	5d                   	pop    %ebp
 387:	c3                   	ret    
 388:	90                   	nop
 389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000390 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	56                   	push   %esi
 394:	53                   	push   %ebx
 395:	8b 5d 10             	mov    0x10(%ebp),%ebx
 398:	8b 45 08             	mov    0x8(%ebp),%eax
 39b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 39e:	85 db                	test   %ebx,%ebx
 3a0:	7e 14                	jle    3b6 <memmove+0x26>
 3a2:	31 d2                	xor    %edx,%edx
 3a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 3a8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 3ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 3af:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3b2:	39 da                	cmp    %ebx,%edx
 3b4:	75 f2                	jne    3a8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 3b6:	5b                   	pop    %ebx
 3b7:	5e                   	pop    %esi
 3b8:	5d                   	pop    %ebp
 3b9:	c3                   	ret    

000003ba <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3ba:	b8 01 00 00 00       	mov    $0x1,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <exit>:
SYSCALL(exit)
 3c2:	b8 02 00 00 00       	mov    $0x2,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <wait>:
SYSCALL(wait)
 3ca:	b8 03 00 00 00       	mov    $0x3,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <pipe>:
SYSCALL(pipe)
 3d2:	b8 04 00 00 00       	mov    $0x4,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <read>:
SYSCALL(read)
 3da:	b8 05 00 00 00       	mov    $0x5,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <write>:
SYSCALL(write)
 3e2:	b8 10 00 00 00       	mov    $0x10,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <close>:
SYSCALL(close)
 3ea:	b8 15 00 00 00       	mov    $0x15,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <kill>:
SYSCALL(kill)
 3f2:	b8 06 00 00 00       	mov    $0x6,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <exec>:
SYSCALL(exec)
 3fa:	b8 07 00 00 00       	mov    $0x7,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <open>:
SYSCALL(open)
 402:	b8 0f 00 00 00       	mov    $0xf,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <mknod>:
SYSCALL(mknod)
 40a:	b8 11 00 00 00       	mov    $0x11,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <unlink>:
SYSCALL(unlink)
 412:	b8 12 00 00 00       	mov    $0x12,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <fstat>:
SYSCALL(fstat)
 41a:	b8 08 00 00 00       	mov    $0x8,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <link>:
SYSCALL(link)
 422:	b8 13 00 00 00       	mov    $0x13,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <mkdir>:
SYSCALL(mkdir)
 42a:	b8 14 00 00 00       	mov    $0x14,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <chdir>:
SYSCALL(chdir)
 432:	b8 09 00 00 00       	mov    $0x9,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <dup>:
SYSCALL(dup)
 43a:	b8 0a 00 00 00       	mov    $0xa,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <getpid>:
SYSCALL(getpid)
 442:	b8 0b 00 00 00       	mov    $0xb,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <sbrk>:
SYSCALL(sbrk)
 44a:	b8 0c 00 00 00       	mov    $0xc,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <sleep>:
SYSCALL(sleep)
 452:	b8 0d 00 00 00       	mov    $0xd,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <uptime>:
SYSCALL(uptime)
 45a:	b8 0e 00 00 00       	mov    $0xe,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <captsc>:
SYSCALL(captsc)
 462:	b8 16 00 00 00       	mov    $0x16,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <freesc>:
SYSCALL(freesc)
 46a:	b8 17 00 00 00       	mov    $0x17,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <updatesc>:
SYSCALL(updatesc)
 472:	b8 18 00 00 00       	mov    $0x18,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    
 47a:	66 90                	xchg   %ax,%ax
 47c:	66 90                	xchg   %ax,%ax
 47e:	66 90                	xchg   %ax,%ax

00000480 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
 485:	53                   	push   %ebx
 486:	89 c6                	mov    %eax,%esi
 488:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 48b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 48e:	85 db                	test   %ebx,%ebx
 490:	74 7e                	je     510 <printint+0x90>
 492:	89 d0                	mov    %edx,%eax
 494:	c1 e8 1f             	shr    $0x1f,%eax
 497:	84 c0                	test   %al,%al
 499:	74 75                	je     510 <printint+0x90>
    neg = 1;
    x = -xx;
 49b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 49d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 4a4:	f7 d8                	neg    %eax
 4a6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 4a9:	31 ff                	xor    %edi,%edi
 4ab:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 4ae:	89 ce                	mov    %ecx,%esi
 4b0:	eb 08                	jmp    4ba <printint+0x3a>
 4b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4b8:	89 cf                	mov    %ecx,%edi
 4ba:	31 d2                	xor    %edx,%edx
 4bc:	8d 4f 01             	lea    0x1(%edi),%ecx
 4bf:	f7 f6                	div    %esi
 4c1:	0f b6 92 20 09 00 00 	movzbl 0x920(%edx),%edx
  }while((x /= base) != 0);
 4c8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 4ca:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 4cd:	75 e9                	jne    4b8 <printint+0x38>
  if(neg)
 4cf:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 4d2:	8b 75 c0             	mov    -0x40(%ebp),%esi
 4d5:	85 c0                	test   %eax,%eax
 4d7:	74 08                	je     4e1 <printint+0x61>
    buf[i++] = '-';
 4d9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 4de:	8d 4f 02             	lea    0x2(%edi),%ecx
 4e1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 4e5:	8d 76 00             	lea    0x0(%esi),%esi
 4e8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4eb:	83 ec 04             	sub    $0x4,%esp
 4ee:	83 ef 01             	sub    $0x1,%edi
 4f1:	6a 01                	push   $0x1
 4f3:	53                   	push   %ebx
 4f4:	56                   	push   %esi
 4f5:	88 45 d7             	mov    %al,-0x29(%ebp)
 4f8:	e8 e5 fe ff ff       	call   3e2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4fd:	83 c4 10             	add    $0x10,%esp
 500:	39 df                	cmp    %ebx,%edi
 502:	75 e4                	jne    4e8 <printint+0x68>
    putc(fd, buf[i]);
}
 504:	8d 65 f4             	lea    -0xc(%ebp),%esp
 507:	5b                   	pop    %ebx
 508:	5e                   	pop    %esi
 509:	5f                   	pop    %edi
 50a:	5d                   	pop    %ebp
 50b:	c3                   	ret    
 50c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 510:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 512:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 519:	eb 8b                	jmp    4a6 <printint+0x26>
 51b:	90                   	nop
 51c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000520 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	57                   	push   %edi
 524:	56                   	push   %esi
 525:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 526:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 529:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 52c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 52f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 532:	89 45 d0             	mov    %eax,-0x30(%ebp)
 535:	0f b6 1e             	movzbl (%esi),%ebx
 538:	83 c6 01             	add    $0x1,%esi
 53b:	84 db                	test   %bl,%bl
 53d:	0f 84 b0 00 00 00    	je     5f3 <printf+0xd3>
 543:	31 d2                	xor    %edx,%edx
 545:	eb 39                	jmp    580 <printf+0x60>
 547:	89 f6                	mov    %esi,%esi
 549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 550:	83 f8 25             	cmp    $0x25,%eax
 553:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 556:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 55b:	74 18                	je     575 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 55d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 560:	83 ec 04             	sub    $0x4,%esp
 563:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 566:	6a 01                	push   $0x1
 568:	50                   	push   %eax
 569:	57                   	push   %edi
 56a:	e8 73 fe ff ff       	call   3e2 <write>
 56f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 572:	83 c4 10             	add    $0x10,%esp
 575:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 578:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 57c:	84 db                	test   %bl,%bl
 57e:	74 73                	je     5f3 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 580:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 582:	0f be cb             	movsbl %bl,%ecx
 585:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 588:	74 c6                	je     550 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 58a:	83 fa 25             	cmp    $0x25,%edx
 58d:	75 e6                	jne    575 <printf+0x55>
      if(c == 'd'){
 58f:	83 f8 64             	cmp    $0x64,%eax
 592:	0f 84 f8 00 00 00    	je     690 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 598:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 59e:	83 f9 70             	cmp    $0x70,%ecx
 5a1:	74 5d                	je     600 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5a3:	83 f8 73             	cmp    $0x73,%eax
 5a6:	0f 84 84 00 00 00    	je     630 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5ac:	83 f8 63             	cmp    $0x63,%eax
 5af:	0f 84 ea 00 00 00    	je     69f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5b5:	83 f8 25             	cmp    $0x25,%eax
 5b8:	0f 84 c2 00 00 00    	je     680 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5be:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5c1:	83 ec 04             	sub    $0x4,%esp
 5c4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5c8:	6a 01                	push   $0x1
 5ca:	50                   	push   %eax
 5cb:	57                   	push   %edi
 5cc:	e8 11 fe ff ff       	call   3e2 <write>
 5d1:	83 c4 0c             	add    $0xc,%esp
 5d4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5d7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 5da:	6a 01                	push   $0x1
 5dc:	50                   	push   %eax
 5dd:	57                   	push   %edi
 5de:	83 c6 01             	add    $0x1,%esi
 5e1:	e8 fc fd ff ff       	call   3e2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5e6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5ea:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5ed:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5ef:	84 db                	test   %bl,%bl
 5f1:	75 8d                	jne    580 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5f6:	5b                   	pop    %ebx
 5f7:	5e                   	pop    %esi
 5f8:	5f                   	pop    %edi
 5f9:	5d                   	pop    %ebp
 5fa:	c3                   	ret    
 5fb:	90                   	nop
 5fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 600:	83 ec 0c             	sub    $0xc,%esp
 603:	b9 10 00 00 00       	mov    $0x10,%ecx
 608:	6a 00                	push   $0x0
 60a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 60d:	89 f8                	mov    %edi,%eax
 60f:	8b 13                	mov    (%ebx),%edx
 611:	e8 6a fe ff ff       	call   480 <printint>
        ap++;
 616:	89 d8                	mov    %ebx,%eax
 618:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 61b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 61d:	83 c0 04             	add    $0x4,%eax
 620:	89 45 d0             	mov    %eax,-0x30(%ebp)
 623:	e9 4d ff ff ff       	jmp    575 <printf+0x55>
 628:	90                   	nop
 629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 630:	8b 45 d0             	mov    -0x30(%ebp),%eax
 633:	8b 18                	mov    (%eax),%ebx
        ap++;
 635:	83 c0 04             	add    $0x4,%eax
 638:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 63b:	b8 18 09 00 00       	mov    $0x918,%eax
 640:	85 db                	test   %ebx,%ebx
 642:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 645:	0f b6 03             	movzbl (%ebx),%eax
 648:	84 c0                	test   %al,%al
 64a:	74 23                	je     66f <printf+0x14f>
 64c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 650:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 653:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 656:	83 ec 04             	sub    $0x4,%esp
 659:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 65b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 65e:	50                   	push   %eax
 65f:	57                   	push   %edi
 660:	e8 7d fd ff ff       	call   3e2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 665:	0f b6 03             	movzbl (%ebx),%eax
 668:	83 c4 10             	add    $0x10,%esp
 66b:	84 c0                	test   %al,%al
 66d:	75 e1                	jne    650 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 66f:	31 d2                	xor    %edx,%edx
 671:	e9 ff fe ff ff       	jmp    575 <printf+0x55>
 676:	8d 76 00             	lea    0x0(%esi),%esi
 679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 680:	83 ec 04             	sub    $0x4,%esp
 683:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 686:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 689:	6a 01                	push   $0x1
 68b:	e9 4c ff ff ff       	jmp    5dc <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 690:	83 ec 0c             	sub    $0xc,%esp
 693:	b9 0a 00 00 00       	mov    $0xa,%ecx
 698:	6a 01                	push   $0x1
 69a:	e9 6b ff ff ff       	jmp    60a <printf+0xea>
 69f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6a2:	83 ec 04             	sub    $0x4,%esp
 6a5:	8b 03                	mov    (%ebx),%eax
 6a7:	6a 01                	push   $0x1
 6a9:	88 45 e4             	mov    %al,-0x1c(%ebp)
 6ac:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6af:	50                   	push   %eax
 6b0:	57                   	push   %edi
 6b1:	e8 2c fd ff ff       	call   3e2 <write>
 6b6:	e9 5b ff ff ff       	jmp    616 <printf+0xf6>
 6bb:	66 90                	xchg   %ax,%ax
 6bd:	66 90                	xchg   %ax,%ax
 6bf:	90                   	nop

000006c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c1:	a1 40 0c 00 00       	mov    0xc40,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c6:	89 e5                	mov    %esp,%ebp
 6c8:	57                   	push   %edi
 6c9:	56                   	push   %esi
 6ca:	53                   	push   %ebx
 6cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ce:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6d0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d3:	39 c8                	cmp    %ecx,%eax
 6d5:	73 19                	jae    6f0 <free+0x30>
 6d7:	89 f6                	mov    %esi,%esi
 6d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 6e0:	39 d1                	cmp    %edx,%ecx
 6e2:	72 1c                	jb     700 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e4:	39 d0                	cmp    %edx,%eax
 6e6:	73 18                	jae    700 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 6e8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ea:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ec:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ee:	72 f0                	jb     6e0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f0:	39 d0                	cmp    %edx,%eax
 6f2:	72 f4                	jb     6e8 <free+0x28>
 6f4:	39 d1                	cmp    %edx,%ecx
 6f6:	73 f0                	jae    6e8 <free+0x28>
 6f8:	90                   	nop
 6f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 700:	8b 73 fc             	mov    -0x4(%ebx),%esi
 703:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 706:	39 d7                	cmp    %edx,%edi
 708:	74 19                	je     723 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 70a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 70d:	8b 50 04             	mov    0x4(%eax),%edx
 710:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 713:	39 f1                	cmp    %esi,%ecx
 715:	74 23                	je     73a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 717:	89 08                	mov    %ecx,(%eax)
  freep = p;
 719:	a3 40 0c 00 00       	mov    %eax,0xc40
}
 71e:	5b                   	pop    %ebx
 71f:	5e                   	pop    %esi
 720:	5f                   	pop    %edi
 721:	5d                   	pop    %ebp
 722:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 723:	03 72 04             	add    0x4(%edx),%esi
 726:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 729:	8b 10                	mov    (%eax),%edx
 72b:	8b 12                	mov    (%edx),%edx
 72d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 730:	8b 50 04             	mov    0x4(%eax),%edx
 733:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 736:	39 f1                	cmp    %esi,%ecx
 738:	75 dd                	jne    717 <free+0x57>
    p->s.size += bp->s.size;
 73a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 73d:	a3 40 0c 00 00       	mov    %eax,0xc40
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 742:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 745:	8b 53 f8             	mov    -0x8(%ebx),%edx
 748:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 74a:	5b                   	pop    %ebx
 74b:	5e                   	pop    %esi
 74c:	5f                   	pop    %edi
 74d:	5d                   	pop    %ebp
 74e:	c3                   	ret    
 74f:	90                   	nop

00000750 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	57                   	push   %edi
 754:	56                   	push   %esi
 755:	53                   	push   %ebx
 756:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 759:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 75c:	8b 15 40 0c 00 00    	mov    0xc40,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 762:	8d 78 07             	lea    0x7(%eax),%edi
 765:	c1 ef 03             	shr    $0x3,%edi
 768:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 76b:	85 d2                	test   %edx,%edx
 76d:	0f 84 a3 00 00 00    	je     816 <malloc+0xc6>
 773:	8b 02                	mov    (%edx),%eax
 775:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 778:	39 cf                	cmp    %ecx,%edi
 77a:	76 74                	jbe    7f0 <malloc+0xa0>
 77c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 782:	be 00 10 00 00       	mov    $0x1000,%esi
 787:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 78e:	0f 43 f7             	cmovae %edi,%esi
 791:	ba 00 80 00 00       	mov    $0x8000,%edx
 796:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 79c:	0f 46 da             	cmovbe %edx,%ebx
 79f:	eb 10                	jmp    7b1 <malloc+0x61>
 7a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7aa:	8b 48 04             	mov    0x4(%eax),%ecx
 7ad:	39 cf                	cmp    %ecx,%edi
 7af:	76 3f                	jbe    7f0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7b1:	39 05 40 0c 00 00    	cmp    %eax,0xc40
 7b7:	89 c2                	mov    %eax,%edx
 7b9:	75 ed                	jne    7a8 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 7bb:	83 ec 0c             	sub    $0xc,%esp
 7be:	53                   	push   %ebx
 7bf:	e8 86 fc ff ff       	call   44a <sbrk>
  if(p == (char*)-1)
 7c4:	83 c4 10             	add    $0x10,%esp
 7c7:	83 f8 ff             	cmp    $0xffffffff,%eax
 7ca:	74 1c                	je     7e8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 7cc:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 7cf:	83 ec 0c             	sub    $0xc,%esp
 7d2:	83 c0 08             	add    $0x8,%eax
 7d5:	50                   	push   %eax
 7d6:	e8 e5 fe ff ff       	call   6c0 <free>
  return freep;
 7db:	8b 15 40 0c 00 00    	mov    0xc40,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 7e1:	83 c4 10             	add    $0x10,%esp
 7e4:	85 d2                	test   %edx,%edx
 7e6:	75 c0                	jne    7a8 <malloc+0x58>
        return 0;
 7e8:	31 c0                	xor    %eax,%eax
 7ea:	eb 1c                	jmp    808 <malloc+0xb8>
 7ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 7f0:	39 cf                	cmp    %ecx,%edi
 7f2:	74 1c                	je     810 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 7f4:	29 f9                	sub    %edi,%ecx
 7f6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7f9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7fc:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 7ff:	89 15 40 0c 00 00    	mov    %edx,0xc40
      return (void*)(p + 1);
 805:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 808:	8d 65 f4             	lea    -0xc(%ebp),%esp
 80b:	5b                   	pop    %ebx
 80c:	5e                   	pop    %esi
 80d:	5f                   	pop    %edi
 80e:	5d                   	pop    %ebp
 80f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 810:	8b 08                	mov    (%eax),%ecx
 812:	89 0a                	mov    %ecx,(%edx)
 814:	eb e9                	jmp    7ff <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 816:	c7 05 40 0c 00 00 44 	movl   $0xc44,0xc40
 81d:	0c 00 00 
 820:	c7 05 44 0c 00 00 44 	movl   $0xc44,0xc44
 827:	0c 00 00 
    base.s.size = 0;
 82a:	b8 44 0c 00 00       	mov    $0xc44,%eax
 82f:	c7 05 48 0c 00 00 00 	movl   $0x0,0xc48
 836:	00 00 00 
 839:	e9 3e ff ff ff       	jmp    77c <malloc+0x2c>
