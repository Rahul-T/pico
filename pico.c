#include "types.h"
#include "stat.h"
#include "user.h"

#define WIDTH 80
#define HEIGHT 25
#define TOTAL_CHARS 1920
#define C(x)  ((x)-'@')  // Control-x

#define UI_COLOR 0xc0
#define TEXT_COLOR 0x07

char buf[TOTAL_CHARS];
int currChar = 0;
int c = 0;
// static int lastChar;

void
printfile(int fd)
{
	int n;

	while((n = read(fd, buf, TOTAL_CHARS)) > 0) {
		// if (write(1, buf, n) != n) {
		// 	printf(1, "Write error\n");
		// 	return;
		// }
		updatesc(0, 1, buf, TEXT_COLOR);
	}
	if(n < 0){
		printf(1, "Read error\n");
		return;
	}
	close(fd);
}

void
drawHeader() {
	updatesc(0, 0, "                              ", UI_COLOR);
	updatesc(30, 0, "        PICO        ", UI_COLOR);
	updatesc(50, 0, "                         v0.1 ", UI_COLOR);
}

void
drawFooter() {
	updatesc(0, 24, " ^Q - Quit                                                                      ", UI_COLOR);
}

void
handleInput(int i) {
	if (i == 17) {
		exit();
	}
	buf[currChar++] = (char) i & 0xff;
	updatesc(0, 1, buf, TEXT_COLOR);
	// printf(1, "new input");
}

int
main(int argc, char *argv[]) {
	captsc(&c);
	drawHeader();
	drawFooter();
	int fd;

	if (argc == 2) {
		if((fd = open(argv[1], 0)) < 0){
			printf(1, "Cannot open %s\n", argv[1]);
		} else {
			printfile(fd);
		}
	} else {
		printf(1, "No file selected");
	}
	while(1) {
		while ((c = getkey()) <= 0) {
		}
		handleInput(c);
		c = 0;
	}
	read(0, 0, 100);
	freesc();

	exit();
}