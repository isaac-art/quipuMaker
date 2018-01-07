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

void setup() {
	//smooth(0);
	loadedImage = loadImage("imageIn.png");
	newImage = createImage(loadedImage.width, loadedImage.height, RGB);
	for(int i = 0; i < newImage.pixels.length; i++){
		newImage.pixels[i] = 0;
	}
}

void draw() {
	interpret(loadedImage, newImage);
	newImage.save("./data/imageOut.png");
	exit();
}
 
void interpret(PImage program, PImage memory){

	while(programPos < loadedImage.pixels.length){

		color c = loadedImage.pixels[programPos];
		
		if(brightness(c) < 85){
			newImage.pixels[memoryPos] = int(brightness(c));
		}
		else if(brightness(c) > 170){
			newImage.pixels[memoryPos] = int(brightness(c));
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
