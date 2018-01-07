import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class PWhenever extends PApplet {

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

public void setup() {
	
	blankTape();
}

public void draw() {
	String task = "++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.";
	parse(task);
	noLoop();
}

public void blankTape(){
	// initialise a blank tape
	for(int i = 0; i < tape.length; i++){
		tape[i] = 0;
	}
}

public void defer(int procID, int defID){}
public void again(int procID){}
public void loadFile(){}


public void incrementData(int pos){
	tape[pos] += 1;
}
public void decrementData(int pos){
	tape[pos] -= 1;
}
public void incrementPointer(int pos){
	pos +=1;
}
public void decrementPointer(int pos){
	pos -=1;
}
public void getPos(int pos){
	currentVal = tape[pos];
}
public void putPos(int pos){
	tape[pos] = currentVal;
}
public void beginLoop(int pos){

}
public void endLoop(int pos){

}


public void parse(String task){
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

		println("tape: "+tape);
	}

}

  public void settings() { 	size(256, 256); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "PWhenever" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
