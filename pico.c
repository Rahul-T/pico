#include "types.h"
#include "stat.h"
#include "user.h"
#include "console.h"

#define WIDTH 80
#define HEIGHT 23
#define TOTAL_CHARS WIDTH * HEIGHT

#define UI_COLOR 0xc0
#define TEXT_COLOR 0x0F
#define CURSOR_COLOR 0x70

#define BLANK_CHAR ' '

#define NO_FILE 0

int currChar = 0;
int c = 0;
// static int lastChar;

// A row is the 80 characters displayed on the screen
// A line is the group of characters between '\n' in a file - this can be longer than 80 characters
// Since we don't want horizontal scrolling, there can be multiple rows per line


struct row {
	int linenum;
	int linelen;
	char line[WIDTH];
	struct row* prev;
	struct row* next;
};

struct charandcolor {
	char character;
	int color;
};

struct charandcolor buf[TOTAL_CHARS + 1];

struct row* head;
struct row* firstOnScreen;
struct row* lastOnScreen;
//struct row* tail;

struct row* getcursorrow();

void
initLinkedList(int fd, int new_file)
{
	head = malloc(sizeof(struct row));
	struct row* cur = head;
	cur->linenum = 0;

	char c;
	int column = 0;
	int line = 0;
	int row = 0;

	// TODO(nussey): add error handling for file reading
	while(!new_file && read(fd, &c, 1) > 0) {

		// Newline character
		uint newline = 0;
		if(c == '\n'){
			line++;
			cur->linelen = column;
			newline = 1;
		} else {
			cur->line[column++] = c;
		}

		// If this row is part of a wrapping line, set its length to maximum
		if(column >= WIDTH) {
			cur->linelen = WIDTH;
		}

		if(column == WIDTH || newline) {
			// Allocate a new row
			struct row* nextrow = malloc(sizeof(struct row));
			nextrow->linenum = line;

			// Move linked list pointers
			nextrow->prev = cur;
			cur->next = nextrow;
			cur = nextrow;

			// Update counts
			column = 0;
			row++;
		}
	}
	cur->linelen = column;

	//printf(1, "Read in %d lines to %d rows\n", line, row);

	firstOnScreen = head;

	// struct row* temp = malloc(sizeof(struct row));
	// temp->linelen = -1;
	// temp->linenum = -1;
	// memset(temp->line, BLANK_CHAR, WIDTH);

	// Fill in enough rows to fill the screen
	for(; row < HEIGHT; row++) {
		// Negative length indicates a "fake" row
		struct row* blank = malloc(sizeof(struct row));
		blank->linelen = -1;
		blank->linenum = -1;

		// Update linked list
		cur->next = blank;
		blank->prev = cur;
		cur = blank;
	}
}

void
printfile(struct row* first)
{
	struct row* cur = first;
	int bufindex = 0;
	while(cur->next != 0 && bufindex < TOTAL_CHARS - WIDTH){
		for(int i=0; i<WIDTH; i++){
			if(cur->line[i] == '\0'){
				buf[bufindex].character = BLANK_CHAR;
			} else if(cur->line[i] == 9){
				// Tab character
				buf[bufindex].character = 26;
			} else {
				buf[bufindex].character = cur->line[i];
			}
			bufindex++;
		}
		cur = cur->next;
	}
	for(int i=0; i<WIDTH; i++){
			if(cur->line[i] == '\0'){
				buf[bufindex].character = BLANK_CHAR;
			} else if(cur->line[i] == 9){
				// Tab character
				buf[bufindex].character = 26;
			} else{
				buf[bufindex].character = cur->line[i];
			}
			bufindex++;
	}
	lastOnScreen = cur;

	buf[bufindex].character = '\0';
	//printf(1, "asdfasdfdsf: %d", lastOnScreen->linenum);
	//printf(1, "%s\n", buf);
	updatesc(0, 1, buf, TEXT_COLOR);
}

void
drawHeader() {
	char header1string[30] = "                              ";
	struct charandcolor header1[30];
	for(int i=0; i<30; i++){
		header1[i].character = header1string[i];
	}
	updatesc(0, 0, header1, UI_COLOR);

	char header2string[20] = "        PICO        ";
	struct charandcolor header2[20];
	for(int i=0; i<20; i++){
		header2[i].character = header2string[i];
	}
	updatesc(30, 0, header2, UI_COLOR);

	char header3string[30] = "                         v0.1 ";
	struct charandcolor header3[30];
	for(int i=0; i<30; i++){
		header3[i].character = header3string[i];
	}
	updatesc(50, 0, header3, UI_COLOR);
}

void
drawFooter() {
	char footerstring[80] = " ^Q - Quit       ^X - Cutline                                                   ";
	struct charandcolor footer[80];
	for(int i=0; i<80; i++){
		footer[i].character = footerstring[i];
	}
	char charsProc = 0;
	// Draw column number
	int currCharProc = currChar%WIDTH+1;
	struct row* currRow = getcursorrow();
	struct row* rowiter = currRow;
	if (rowiter != 0) {
		while (rowiter->prev != 0 && rowiter->prev->linenum == rowiter->linenum) {
			currCharProc += WIDTH;
			rowiter = rowiter->prev;
		} 
	}
	do {
		footer[78-charsProc++].character = 48 + currCharProc % 10;
		currCharProc = currCharProc / 10;
	} while (currCharProc > 0);
	footer[78-charsProc++].character = 58;
	// Draw line number 
	currCharProc = currRow->linenum + 1;
	if (currCharProc > 74000) {
		currCharProc = 1;
	}
	do {
		footer[78-charsProc++].character = 48 + currCharProc % 10;
		currCharProc = currCharProc / 10;
	} while (currCharProc > 0);
	updatesc(0, 24, footer, UI_COLOR);
}

void
scrolldown(void){
	printfile(firstOnScreen->next);
	firstOnScreen = firstOnScreen->next;
}

void
scrollup(void){
	printfile(firstOnScreen->prev);
	firstOnScreen = firstOnScreen->prev;
}

void
updateCursor(int prev, int curr) {
	struct charandcolor firstUpdate[2];
	firstUpdate[1].character = 0;
	firstUpdate[0].character = buf[prev].character;
	updatesc(prev, 1, firstUpdate, buf[prev].color);
	firstUpdate[0].character = buf[curr].character;
	updatesc(curr, 1, firstUpdate, CURSOR_COLOR);
}


// TODO(alex) it is probably better to just keep track of this
// instead of looping to find it each time
struct row* getcursorrow() {
	int row = currChar/WIDTH;
	struct row* cur = firstOnScreen;
	for(int i=0; i<row; i++){
		cur = cur->next;
	}

	return cur;
}

void
leftaligncursor(void){
	struct row* currline = getcursorrow();
	int row = currChar/WIDTH;
	int col = currline->linelen;
	int lastvalidchar = row*WIDTH+col;
	while(currChar > lastvalidchar){
		currChar--;
	}
}

void
arrowkeys(int i){
	//ctrl+j (go left)
	if((i == 10 || i == 228) && (currChar % WIDTH != 0) && currChar > 0){
		currChar--;
	}
	//ctrl+l (go right)
	else if((i==12 || i == 229) && ((currChar+1) % WIDTH != 0)){
		currChar++;
	}
	//ctrl+k (go down)
	//Second condition avoid the cursor to go down if there is not line written below (lepl3)
	else if((i == 11 || i == 227) && !(getcursorrow()->next->linelen == -1)){
		if(currChar < TOTAL_CHARS - WIDTH){
			currChar += WIDTH;
		}
		else{
			if(lastOnScreen->next != 0)
				scrolldown();
		}
	}
	//ctrl+i (go up)
	else if(i == 9 || i == 226){
		if(currChar >= WIDTH){
			currChar -= WIDTH;
		}
		else{
			if(firstOnScreen->prev != 0)
				scrollup();
		}
	}
	leftaligncursor();
}

void
changelinenumbers(struct row* start, int amount) {
	while(start != 0 && start->linenum >= 0) {
		start->linenum += amount;
		start = start->next;
	}
}

struct row*
insertnewrow(struct row* pred) {
	struct row* new = malloc(sizeof(struct row));

	new->next = pred->next;
	new->prev = pred;

	pred->next = new;

	if(new->next != 0) {
		new->next->prev = new;
	}

	return new;
}

struct row*
removerow(struct row* row) {
	struct row* next = row->next;
	if(row->prev != 0) {
		row->prev->next = row->next;
	}
	if(row->next != 0) {
		row->next->prev = row->prev;
	}

	free(row);

	return next;
}

void
cutline(void) {
	struct row* cur = getcursorrow();

	// Find the first row with this line number
	int linenum = cur->linenum;
	while(cur->prev != 0 && cur->prev->linenum == linenum) {
		cur = cur->prev;
	}

	while(cur != 0 && cur->linenum == linenum) {
		cur = removerow(cur);
	}

	while(cur != 0) {
		cur->linenum--;
		cur = cur->next;
	}

	printfile(firstOnScreen);
}

void
printlinenums(void)
{
	struct row* cur = firstOnScreen;
	int row = 0;
	while(cur != lastOnScreen) {
		//printf(1, "Row %d of len %d - line# %d\n", row, cur->linelen, cur->linenum);
		row++;
		cur = cur->next;
	}

	//printf(1, "Row %d of len %d - line# %d\n", row, cur->linelen, cur->linenum);
}

void
unwrapline(struct row* row) {
	int linenum = row->linenum;

	int freespace = WIDTH - row->linelen;
	while(row->next->linenum == linenum) {
		if(row->next->linelen <= freespace && row->next->linelen != WIDTH) {
			memmove(row->line + row->linelen, row->next->line, row->next->linelen);
			row->linelen = row->linelen + row->next->linelen;
			memset(row->line + row->linelen, 0, WIDTH-row->linelen);
			removerow(row->next);
		} else {
			memmove(row->line + row->linelen, row->next->line, freespace);
			memmove(row->next->line, row->next->line + freespace, WIDTH-freespace);
			row->linelen = WIDTH;
			row->next->linelen = row->next->linelen - freespace;
			row = row->next;
		}
	}
}

void
backspace(void) {
	struct row* row = getcursorrow();
	int column = currChar % WIDTH;

	if(column > 0) {
		memmove(row->line + column - 1, row->line + column, row->linelen - column + 1);
		row->linelen--;
		if(row->linelen >= WIDTH - 1) {
			unwrapline(row);
		}
		// Move the cursor
		currChar--;
	} else {
		if(row->prev == 0) {
			return;
		}

		// The scrolling part here has a bug
		if(row->prev->linenum == row->linenum) {
			row->prev->linelen--;
			unwrapline(row->prev);

			if(row == firstOnScreen) {
				scrolldown();
			}
			currChar--;
		} else {
			changelinenumbers(row, -1);
			if(row->prev->linelen < WIDTH) {
				unwrapline(row->prev);
			}
	
		}
	}

	printfile(firstOnScreen);
}

void
newline(void)
{
	struct row* row = getcursorrow();
	int column = currChar % WIDTH;

	struct row* nextrow = insertnewrow(row);
	nextrow->linenum = row->linenum;

	// Calculate new line lengths
	nextrow->linelen = row->linelen - column;
	row->linelen = column;

	memmove(nextrow->line, row->line + row->linelen, nextrow->linelen);
	memset(row->line + row->linelen, 0, nextrow->linelen);

	if(nextrow->linelen != WIDTH) {
		unwrapline(nextrow);
	}

	while(nextrow != 0 && nextrow->linenum != -1) {
		nextrow->linenum++;
		nextrow = nextrow->next;
	}

	if(row == lastOnScreen) {
		firstOnScreen = firstOnScreen->next;
	} else {
		currChar = (currChar/WIDTH + 1) * WIDTH;
	}

	printfile(firstOnScreen);
	return;
}

void insertchar(char c) {
	struct row* row = getcursorrow();
	int column = currChar % WIDTH;

	printf(1, "Linelen: %d; Column: %d\n", row->linelen, column);

	// Inserting the last character with the cursor at the end of the row
	if (row->linelen == WIDTH - 1 && column == WIDTH-1 && row->next->linenum != row->linenum) {
		struct row* newrow = insertnewrow(row);
		newrow->linenum = row->linenum;
		newrow->linelen = 0;
	} // Inserting a character into an already full row
	else if (row->linelen == WIDTH ) {

		struct row* endrow = row;
		while(endrow->next->linenum == row->linenum && endrow->linelen == WIDTH) {
			endrow = endrow->next;
		}

		if(endrow->linelen == WIDTH) {
			struct row* newrow = insertnewrow(endrow);
			newrow->linelen = 0;
			newrow->linenum = row->linenum;

			endrow = newrow;
		}

		while(endrow != row) {
			memmove(endrow->line + 1, endrow->line, endrow->linelen);
			endrow->linelen++;
			endrow->prev->linelen--;
			endrow->line[0] = endrow->prev->line[WIDTH-1];

			endrow = endrow->prev;
		}

	}

	if(column < row->linelen) {
		memmove(row->line + column + 1, row->line+column, row->linelen-column);
		
	} else if (column > row->linelen) {
		printf(1, "NOT GOOD\n");
	}

	row->line[column] = c;
	currChar++;
	row->linelen++;

	printfile(firstOnScreen);
}

void
handleInput(int i) {
	//printf(1, "Key pressed: %d\n", i);
	//printf(1, "currChar pre-handleInput: %d\n", currChar);
	int prevChar = currChar;
	//ctrl+q
	if (i == 17) {
		exit();
	}
	// Change the arrow key bounds to work VM (lepl3)
	else if((i >= 226 && i <= 229)) {
		arrowkeys(i);
	}

	//ctrl+x
	else if(i == 24 || i == 23){
		cutline();
	}

	//return key
	// Add 10 because of VM mapping (lepl3)
	else if(i == 13 || i == 10){
		newline();
	}

	//backspace 
	// lepl3 in my VM backspace is equal to 8
	else if(i == 127 || i == 8){
		backspace();
	}
	else {
		insertchar((char)i);
	}
	printf(1, "%d\n", i);
	updateCursor(prevChar, currChar);
	drawFooter();
	printlinenums();
	//printf(1, "currChar post-handleInput: %d\n", currChar);
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
			initLinkedList(fd, 0);
			printfile(head);
		}
	} else {
		initLinkedList(NO_FILE, 1);
		printf(1, "No file selected");
	}
	updateCursor(0, 0);
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