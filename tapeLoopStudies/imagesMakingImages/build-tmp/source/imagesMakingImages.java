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

public class imagesMakingImages extends PApplet {

/*
	Image Recycler
 
	"I've lost all the seconds that led up to this"
	

	brightness: '+' '-'
	hue: '>' '<'
	

*/

PImage loadedImage;
PImage newImage;

int programPos = 0;
int memoryPos = 0;
int memoryVal = 0;

public void setup() {
	//smooth(0);
	loadedImage = loadImage("imageIn.png");
	newImage = createImage(loadedImage.width, loadedImage.height, RGB);
	for(int i = 0; i < newImage.pixels.length; i++){
		newImage.pixels[i] = 0;
	}
}

public void draw() {
	interpret(loadedImage, newImage);
	newImage.save("./data/imageOut.png");
	exit();
}
 
public void interpret(PImage program, PImage memory){

	while(programPos < loadedImage.pixels.length){

		int c = loadedImage.pixels[programPos];
		
		if(brightness(c) < 85){
			newImage.pixels[memoryPos] = PApplet.parseInt(brightness(c));
		}
		else if(brightness(c) > 170){
			newImage.pixels[memoryPos] = PApplet.parseInt(brightness(c));
		}

		if(hue(c) < 85){
			memoryPos += 1;
			if(memoryPos > loadedImage.pixels.length){
				memoryPos = 0;
			}
		}
		else if(hue(c) > 170){
			memoryPos -= 1;
			if(memoryPos < 0){
				memoryPos = loadedImage.pixels.length;
			}
		}

		programPos += 1;

	}

}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "imagesMakingImages" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
