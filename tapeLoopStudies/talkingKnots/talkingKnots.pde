/*
	REFERENCES:
	Parr, T. (2010) Language Implementation Patterns. Pragmatic Bookshelf.
	Ascher, M. Ascher, R. (1981) Mathematics of the Incas. Dover Publications Inc.

	EsoLangs - https://esolangs.org/ && http://esoteric.codes/
	Programming should eat itself: https://www.youtube.com/watch?v=SrKj4hYic5A

	TEXT TO IMAGE
	IMAGE TO TEXT
*/

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
// int memoryPositionTwo = 0;
// int[] memoryTapeTwo;
// int memoryPositionThree = 0;
// int[] memoryTapeThree;

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
	fileAsStrings = loadStrings("./talkingKnots.pde");
	// Strings are joined together as one string
	allText = join(fileAsStrings, " ").toLowerCase();
	// the string is turned to array of characters
	programTape = allText.toCharArray();

	// Set the memory 
	memoryTapeOne = new int[memSize];
	//memoryTapeTwo = new int[memSize];
	//memoryTapeThree = new int[memSize];
	for(int i = 0; i < memSize; i++){
		memoryTapeOne[i] = 0;
		//memoryTapeTwo[i] = 0;
		//memoryTapeThree[i] = 0;
	}

	newImage = createImage(1920, 1080, RGB);

}

void draw() {
	background(0);

	interpreter();
	visualizer();
	printMemoryTapeToConsole(1);
	newImage.save("./data/imageOut.png");
	exit();

	//Press 'c' to print tapes to console
	// if(debugConsole){
	// 	//printMemoryTapeToConsole(1);
	// 	// printMemoryTapeToConsole(2);
	// 	// printMemoryTapeToConsole(3);
	// 	//switch off so it just prints once.
	// 	debugConsole = false;
	// }
	// //Press 'd' to toggle tapes on screen
	// if(debugScreen){
	// 	//drawMemoryTapeValues(memoryTapeOne);
	// 	// drawMemoryTapeValues(memoryTapeTwo);
	// 	// drawMemoryTapeValues(memoryTapeThree);
	// }
	
}

void visualizer(){

	for(int i = 0; i < memoryTapeOne.length; i++){

		newImage.pixels[i] += memoryTapeOne[i];
		// newImage.pixels[i] += memoryTapeTwo[i];
		// newImage.pixels[i] += memoryTapeThree[i];

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
				activeTape[activeTapePosition] += 1;
				if(activeTape[activeTapePosition]  >= 255){
					activeTape[activeTapePosition] = 0;
				}
				break;
			case '-':
				activeTape[activeTapePosition] -= 1;
				if(activeTape[activeTapePosition]  <= -1){
					activeTape[activeTapePosition] = 255;
				}
				break;
			case '>':
				activeTapePosition += 1;
				if(activeTapePosition > memSize-1){
					activeTapePosition = 0;
				}
				break;
			case '<':
				activeTapePosition -= 1;
				if(activeTapePosition < 0){
					activeTapePosition = memSize-1;
				}
				break;
			// case '1':
			// 	if(selectedTape == 2){
			// 		memoryTapeTwo = activeTape;
			// 	}else if(selectedTape == 3){
			// 		memoryTapeThree = activeTape;
			// 	}	
			// 	selectedTape = 1;
			// 	activeTape = memoryTapeOne;
			// 	break;
			// case '2':
			// 	if(selectedTape == 1){
			// 		memoryTapeOne = activeTape;
			// 	}else if(selectedTape == 3){
			// 		memoryTapeThree = activeTape;
			// 	}	
			// 	selectedTape = 2;
			// 	activeTape = memoryTapeTwo;
			// 	break;
			// case '3':
			// 	if(selectedTape == 1){
			// 		memoryTapeOne = activeTape;
			// 	}else if(selectedTape == 2){
			// 		memoryTapeTwo = activeTape;
			// 	}	
			// 	selectedTape = 3;
			// 	activeTape = memoryTapeThree;
			// 	break;
			//DEFAULT SKIPS CHARACTER
			default:
				break;
		}

		programPosition += 1;
	}

}




//--------------------------HELPERS--------------------------//

// void drawMemoryTapeValues(int[] memTape){
// 	int i = 0;
// 	float startingX = 10;
// 	float startingY = 10;
// 	if(memTape == memoryTapeOne){
// 		startingY = 10;
// 	}
// 	else if(memTape == memoryTapeTwo){
// 		startingY = 20;
// 	}
// 	else if(memTape == memoryTapeThree){
// 		startingY = 30;
// 	}
// 	//DRAWS THE MEMORY TAPE CELLS IN 8x8 GRID (64 PLACES)
// 	for(int x = 0; x < sqrt(memTape.length); x++){
// 		for(int y = 0; y < sqrt(memTape.length); y++){
// 			float spacingX = width/sqrt(memTape.length);
// 			float spacingY = height/sqrt(memTape.length);
// 			text(memTape[i], x*spacingX+startingX, y*spacingY+startingY);
// 			i++;
// 		}
// 	}
// }

void printMemoryTapeToConsole(int memTapeNum){
	//PRINT THE VALUES OF THE MEMORY TAPES TO THE CONSOLE
	println("memoryTape: "+memTapeNum);
	if(memTapeNum == 1){
		for(int i =0; i < memoryTapeOne.length; i ++){
			print(memoryTapeOne[i]);
			print("0");
		}
		print("\n");
	// } else if(memTapeNum == 2){
	// 	for(int i =0; i < memoryTapeTwo.length; i ++){
	// 		print(memoryTapeTwo[i]);
	// 		print("0");
	// 	}
	// 	print("\n");
	// } else if(memTapeNum == 3){
	// 	for(int i =0; i < memoryTapeThree.length; i ++){
	// 		print(memoryTapeThree[i]);
	// 		print("0");
	// 	}
	// 	print("\n");
	}
}


// void keyPressed(){
//   	//Press 'd' to toggle tapes on screen
// 	if(key == 'd'){
// 		debugScreen = !debugScreen;
// 	}
// 	//Press 'c' to print tapes to console
// 	if(key == 'c'){
// 		debugConsole = !debugConsole;
// 	}
// }