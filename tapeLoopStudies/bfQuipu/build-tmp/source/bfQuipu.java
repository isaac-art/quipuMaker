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

public class bfQuipu extends PApplet {

String[] fileAsStrings;
String allTheText;

int programPosition = 0;
char[] programTape;


public void setup() {
	
	fileAsStrings = loadStrings("./bfQuipu.pde");
	allTheText = join(fileAsStrings, " ");
	programTape = allTheText.toCharArray();
}

public void draw() {
	charsToAsciiCodes();

}

public void charsToAsciiCodes(){
	for(int i = 0; i < programTape.length; i++){
		int charNum = PApplet.parseInt(programTape[i]);
		int hundreds = charNum/100;
		int tens = (charNum%100)/10;
		int ones = (charNum%10)/1;
		println(programTape[programPosition]+" = hundreds:"+hundreds+", tens:"+tens+", ones:"+ones);
	}
}


  public void settings() { 	size(6000, 3375); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "bfQuipu" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
