/*
	References:
	TIMING
	http://www.dangermouse.net/esoteric/whenever.html
	https://github.com/sarahgp/talking-to-machines/blob/master/examples/whenever.js/lib/grammar.txt

	TAPE
	https://esolangs.org/wiki/Tape
	TAPE moves left right reads and writes
	+ - > < , . [ ]

*/

// the tape 
int[] tape = new int[256];
// the pointer 
int pos = 0;
int currentVal = 0;

void setup() {
	size(256, 256);
	blankTape();
}

void draw() {
	String task = "++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.";
	parse(task);
	noLoop();
}

void blankTape(){
	// initialise a blank tape
	for(int i = 0; i < tape.length; i++){
		tape[i] = 0;
	}
}

void defer(int procID, int defID){}
void again(int procID){}
void loadFile(){}


void incrementData(int pos){
	tape[pos] += 1;
}
void decrementData(int pos){
	tape[pos] -= 1;
}
void incrementPointer(int pos){
	pos +=1;
}
void decrementPointer(int pos){
	pos -=1;
}
void getPos(int pos){
	currentVal = tape[pos];
}
void putPos(int pos){
	tape[pos] = currentVal;
}
void beginLoop(int pos){

}
void endLoop(int pos){

}


void parse(String task){
	// + - > < , . [ ]
	for(int i = 0; i < task.length(); i++){
		//println("i: "+i+", task.charAt(i): "+task.charAt(i));
		println("i: "+i);
		char thisChar = task.charAt(i);
		switch(thisChar) {
			case '+':
				println("+");
				incrementData(pos);
				break;
			case '-':
				println("-");
				decrementData(pos);
				break;
			case '>':
				println("gt");
				incrementPointer(pos);
				break;
			case '<':
				println("lt");
				decrementPointer(pos);
				break;
			case ',':
				println(",");
				getPos(pos);
				break;
			case '.':
				println(".");
				putPos(pos);
				break;
			case '[':
				println("[");
				beginLoop(pos);
				break;
			case ']':
				println("]");
				endLoop(pos);
				break;
			case ' ':
				println("space");
				break;
			default:
				println("invalid");
				break;
		}

	}

}

