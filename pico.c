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

void
printfile(int fd)
{
	int n;

	while((n = read(fd, buf, TOTAL_CHARS)) > 0) {
		if (write(1, buf, n) != n) {
			printf(1, "cat: write error\n");
			exit();
		}
	}
	if(n < 0){
		printf(1, "cat: read error\n");
		exit();
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
	updatesc(0, 24, " PRESS ENTER TO CLOSE                                                           ", UI_COLOR);
}

int
main(int argc, char *argv[]) {
	captsc();
	drawHeader();
	drawFooter();
	read(0, 0, 100);
	freesc();

	exit();

	int fd;

	if (argc == 2) {
		if((fd = open(argv[1], 0)) < 0){
			printf(1, "cat: cannot open %s\n", argv[1]);
			exit();
		}
		printfile(fd);
	} else {
		printf(1, "No file selected");
		// for (int i = 0; i < HEIGHT-2; i++) {
		// 	printf(1, "\n");
		// }
	}
	char c;
	while(read(0, (void*) &c, 1) >= 0){
    switch(c){
    case C('C'):
    	exit();
    	break;
    default:
    	printf(1, "%c", c);
    	break;
    }
  }
	exit();
}