//https://github.com/primaryobjects/AI-Programmer

PFont f;
PImage newImage;

String[] fileAsStrings;
String allText;

int loopCounterOpen = 0;
int loopCounterClosed = 0;

int programPosition = 0;
char[] programTape;

int memoryPositionOne = 0;
int[] memoryTapeOne;

int memSize = 2073600;

boolean debugScreen = true;
boolean debugConsole = false;

void setup() {
	size(960, 540);
	smooth(0);
	background(0);
	stroke(255)	;
	f = createFont("Arial", 20);
	// Loads itself as strings
	fileAsStrings = loadStrings("./v6.pde");
	// Strings are joined together as one string
	allText = join(fileAsStrings, " ").toLowerCase();
	// the string is turned to array of characters
	programTape = allText.toCharArray();

	// Set the memory 
	memoryTapeOne = new int[memSize];
	for(int i = 0; i < memSize; i++){
		memoryTapeOne[i] = 0;
	}

	newImage = createImage(1920, 1080, RGB);

}

void draw() {
	background(0);

	interpreter();
	visualizer();
	newImage.save("./data/imageOut.png");

	//Press 'c' to print tapes to console
	if(debugConsole){
		printMemoryTapeToConsole(1);
		//switch off so it just prints once.
		debugConsole = false;
	}
	//Press 'd' to toggle tapes on screen
	if(debugScreen){
		drawMemoryTapeValues(memoryTapeOne);
	}

	exit();
	
}

void visualizer(){

	for(int i = 0; i < memoryTapeOne.length; i++){

		newImage.pixels[i] += memoryTapeOne[i];

	}


}

void interpreter(){
	// GO OVER EACH CHARACTER IN THE PROGRAMTAPE ARRAY 
	// check each character against options
	// The characters change the memory tapes
	int selectedTape = 1;
	int activeTapePosition = memoryPositionOne;
	int[] activeTape = memoryTapeOne;

	while(programPosition < programTape.length){
		switch( programTape[programPosition]){
			// FIRST MEMORY TAPE CASES
			case '+':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
				activeTape[activeTapePosition] += 1;
				if(activeTape[activeTapePosition]  >= 255){
					activeTape[activeTapePosition] = 0;
				}
				break;
			case '-':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':
				activeTape[activeTapePosition] -= 1;
				if(activeTape[activeTapePosition]  <= -1){
					activeTape[activeTapePosition] = 255;
				}
				break;
			case '>':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
				activeTapePosition += 1;
				if(activeTapePosition > memSize-1){
					activeTapePosition = 0;
				}
				break;
			case '<':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
				activeTapePosition -= 1;
				if(activeTapePosition < 0){
					activeTapePosition = memSize-1;
				}
				break;
			default:
				break;
		}

		programPosition += 1;
	}

}




//--------------------------HELPERS--------------------------//

void drawMemoryTapeValues(int[] memTape){
	int i = 0;
	float startingX = 10;
	float startingY = 10;
	// DRAWS THE MEMORY TAPE CELLS IN A GRID
	// THIS IS ONLY ANY GOOD ON SMALL MEMORY TAPES
	// LIKE 64 PLACES OR SOMETHING
	// NOT THE MILLIONS FOR THE FINAL IMAGE
	for(int x = 0; x < sqrt(memTape.length); x++){
		for(int y = 0; y < sqrt(memTape.length); y++){
			float spacingX = width/sqrt(memTape.length);
			float spacingY = height/sqrt(memTape.length);
			text(memTape[i], x*spacingX+startingX, y*spacingY+startingY);
			i++;
		}
	}
}

void printMemoryTapeToConsole(int memTapeNum){
	//PRINT THE VALUES OF THE MEMORY TAPES TO THE CONSOLE
	println("memoryTape: "+memTapeNum);
	if(memTapeNum == 1){
		for(int i =0; i < memoryTapeOne.length; i ++){
			print(memoryTapeOne[i]);
			print("0");
		}
		print("\n");
	}
}


void keyPressed(){
  	//Press 'd' to toggle tapes on screen
	if(key == 'd'){
		debugScreen = !debugScreen;
	}
	//Press 'c' to print tapes to console
	if(key == 'c'){
		debugConsole = !debugConsole;
	}
}