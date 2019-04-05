#include "types.h"
#include "stat.h"
#include "user.h"

#define WIDTH 80
#define HEIGHT 23
#define TOTAL_CHARS WIDTH * HEIGHT
#define C(x)  ((x)-'@')  // Control-x

#define UI_COLOR 0xc0
#define TEXT_COLOR 0x07

char buf[TOTAL_CHARS + 1];
int currChar = 0;
int c = 0;
// static int lastChar;


struct fileline{
	int filelinenum;
	char line[80];
	struct fileline* prev;
	struct fileline* next;
};

struct fileline* head;
struct fileline* firstOnScreen;
struct fileline* lastOnScreen;
//struct fileline* tail;

void
initLinkedList(int fd)
{
	int n;
	char singlechar[1];
	head = malloc(sizeof(struct fileline));
	struct fileline* cur = head;
	int linecounter = 0;
	int linenumber = 0;

	while((n = read(fd, singlechar, 1)) > 0) {
		if(linecounter < WIDTH){
			cur->line[linecounter] = singlechar[0];
			linecounter++;
			if(singlechar[0] == '\n'){
				linecounter = WIDTH;
			}
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
			cur->filelinenum = linenumber;
			nextline->prev = cur;
			cur->next = nextline;
			cur = nextline;
			linecounter = 0;
			cur->line[linecounter] = singlechar[0];
			linecounter++;
			// int nmbr = (int)(cur->filelinenum);
			// printf(1, "linenum: %d\n", nmbr);
			linenumber++;
		}
	}

	cur->filelinenum = linenumber;
	linenumber++;
	firstOnScreen = head;

	struct fileline* temp;

	if(linenumber < 23){
		temp = malloc(sizeof(struct fileline));
		cur->next = temp;
		temp->prev = cur;
	}
	linecounter = 0;
	while(linenumber < 23){
		if(linecounter < WIDTH){
			temp->line[linecounter] = ' ';
			linecounter++;
		}
		else {
			struct fileline* nextline = malloc(sizeof(struct fileline));
			temp->filelinenum = linenumber;
			nextline->prev = temp;
			temp->next = nextline;
			temp = nextline;
			linecounter = 0;
			temp->line[linecounter] = ' ';
			linecounter++;
			// int nmbr = (int)(cur->filelinenum);
			// printf(1, "linenum: %d\n", nmbr);
			linenumber++;
		}
	}
	// cur = head;
	// while(cur->next != 0){
	// 	printf(1, "%s", cur->line);
	// 	cur = cur->next;
	// }
	// printf(1, "%s", tail->line);

}

void
printfile(struct fileline* first)
{
	struct fileline* cur = first;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
		for(int i=0; i<WIDTH; i++){
			if(cur->line[i] == '\0'){
				buf[bufindex] = ' ';
			} else{
				buf[bufindex] = cur->line[i];
			}
			bufindex++;
		}
		cur = cur->next;
	}
	for(int i=0; i<WIDTH; i++){
			if(cur->line[i] == '\0'){
				buf[bufindex] = ' ';
			} else{
				buf[bufindex] = cur->line[i];
			}
			bufindex++;
	}
	lastOnScreen = cur;

	buf[bufindex] = '\0';
	printf(1, "asdfasdfdsf: %d", lastOnScreen->filelinenum);
	//printf(1, "%s\n", buf);
	updatesc(0, 1, buf, TEXT_COLOR);
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
saveedits(void){
	//Save edits
	struct fileline* cur = firstOnScreen;
	int bufindex = 0;
	while(cur != lastOnScreen->next){
		for(int i=0; i<WIDTH; i++){
			cur->line[i] = buf[bufindex];
			bufindex++;
		}
		cur = cur->next;
	}
}

void
scrolldown(void){
	saveedits();
	printfile(firstOnScreen->next);
	firstOnScreen = firstOnScreen->next;
}

void
scrollup(void){
	saveedits();
	printfile(firstOnScreen->prev);
	firstOnScreen = firstOnScreen->prev;
}

void
arrowkeys(int i){
	//ctrl+j (go left)
	if(i == 10 && (currChar % WIDTH != 0) && currChar > 0){
		currChar--;
	}
	//ctrl+l (go right)
	else if(i==12 && ((currChar+1) % WIDTH != 0)){
		currChar++;
	}
	//ctrl+k (go down)
	else if(i == 11){
		if(currChar < TOTAL_CHARS - WIDTH){
			currChar += WIDTH;
		}
		else{
			if(lastOnScreen->next != 0)
				scrolldown();
		}
	}
	//ctrl+i (go up)
	else if(i == 9){
		if(currChar >= WIDTH){
			currChar -= WIDTH;
		}
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
}


void
cutline(void){
	int line = currChar/WIDTH;
	struct fileline* cur = firstOnScreen;
	for(int i=0; i<line; i++){
		cur = cur->next;
	}
	if(lastOnScreen->next == 0){
		if(firstOnScreen->prev != 0){
			scrollup();
		} else {
			for(int i=0; i<WIDTH; i++){
				cur->line[i] = ' ';
			}
			printfile(firstOnScreen);
			return;
		}
	}
	struct fileline* temp = cur;
	while(temp != 0){
		temp->filelinenum = temp->filelinenum-1;
		temp = temp->next;
	}
	if(firstOnScreen == cur){
		firstOnScreen = cur->next;
	}
	if(lastOnScreen == cur){
		if(cur->next != 0){
			lastOnScreen = cur->next;
		} 
		else if(cur->prev != 0){
			lastOnScreen = cur->prev;
		}
	}
	if(head == cur){
		head = cur->next;
	}
	if(cur->prev != 0){
		cur->prev->next = cur->next;
	}
	if(cur->next != 0){
		cur->next->prev = cur->prev;
	}
	free(cur);
	printfile(firstOnScreen);
}

void
newline(void)
{
	saveedits();
	int line = currChar/WIDTH;
	struct fileline* cur = firstOnScreen;
	for(int i=0; i<line; i++){
		cur = cur->next;
	}
	int linechar = currChar % WIDTH;
	//enter pressed in any column except first
	if(linechar != 0){
		struct fileline* newfileline = malloc(sizeof(struct fileline));
		int i = 0;
		for(i = 0; linechar<WIDTH; i++, linechar++){
			newfileline->line[i] = cur->line[linechar];
			cur->line[linechar] = ' ';
		}
		for(int j = i; j<WIDTH; j++){
			newfileline->line[j] = ' ';
		}
		newfileline->next = cur->next;
		newfileline->prev = cur;
		if(cur->next != 0){
			cur->next->prev = newfileline;
		} else {
			lastOnScreen = newfileline;
		}
		cur->next = newfileline;
		newfileline->filelinenum = cur->filelinenum;
		struct fileline* temp = newfileline;
		while(temp != 0){
			temp->filelinenum = temp->filelinenum + 1;
			temp = temp->next;
		}
	} 
	//enter was pressed in first column
	else
	{
		struct fileline* newfileline = malloc(sizeof(struct fileline));
		int i = 0;
		for(i = 0; linechar<WIDTH; i++, linechar++){
			newfileline->line[i] = ' ';
		}
		newfileline->next = cur;
		newfileline->prev = cur->prev;
		if(cur->prev != 0){
			cur->prev->next = newfileline;
		} else {
			firstOnScreen = newfileline;
		}
		cur->prev = newfileline;
		newfileline->filelinenum = cur->filelinenum;
		struct fileline* temp = newfileline->next;
		while(temp != 0){
			temp->filelinenum = temp->filelinenum + 1;
			temp = temp->next;
		}
		lastOnScreen = lastOnScreen->prev;
	}
	printfile(firstOnScreen);
}

void
handleInput(int i) {
	printf(1, "currChar: %d\n", currChar);
	//ctrl+q
	if (i == 17) {
		exit();
	}
	else if(i >= 9 && i<= 12){
		arrowkeys(i);
	}

	//ctrl+x
	else if(i == 24){
		cutline();
	}

	//return key
	else if(i == 13){
		newline();
	}

	//backspace
	else if(i == 127){
		if(currChar > 0){
			currChar--;
			int bufindex = currChar;
			while(((bufindex+1) % WIDTH) != 0){
				buf[bufindex] = buf[bufindex+1];
				bufindex++;
			}
			buf[bufindex] = ' ';
			updatesc(0, 1, buf, TEXT_COLOR);
		}
	}
	//On right edge of window 
	else if((currChar+1) % WIDTH == 0){
		buf[currChar] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
		// printf(1, "new input");
	}
	else{
		buf[currChar++] = (char) i & 0xff;
		updatesc(0, 1, buf, TEXT_COLOR);
	}
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
			initLinkedList(fd);
			printfile(head);
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