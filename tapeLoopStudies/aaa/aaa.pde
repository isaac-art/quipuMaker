PImage plane;
String[] tokens;
int[][] tape = new int[256][256];
int[][] resolutions = new int[256][256];
float inc = 0.0;


void setup() {
	surface.setTitle("..."); 
	size(256,256);
	smooth(0);
	setupTokens();
	setupPlane();
	background(255);
}


void draw() {
	loadPixels();
	for(int i =  0; i < 256; i++){
    	for(int j =  0; j < 256; j++){
      		pixels[ j * 256 + i  ] = color(tape[i][j], resolutions[i][j]);
      		decay(i, j, j * 256 + i );
    	}
  	}
	updatePixels();
	inc += 0.001;
}

//----------------------TIMING----------------------







//----------------------TOKENIZING------------------
void setupTokens(){
	//String[] lines = loadStrings("my.txt");
	String lines = "alpha, beta, gamma, delta";
	String allText = lines.toLowerCase();
	tokens = splitTokens(allText, " ,.?!:;[]-\"");
}

void textToTokens(){
	for(int i = 0; i < tokens.length; i++){	
		//loop over each word
		println("word: "+tokens[i]);
		for(int j = 0; j < tokens[i].length(); j++){
			////loop over each letter
			int charNum = int(tokens[i].charAt(j));

			println("char: "+tokens[i].charAt(j)+", charNum: "+charNum);

			//split the number into its parts
			int hundreds = charNum/100;
			int tens = (charNum%100)/10;
			int ones = (charNum%10)/1;

			println("hundreds: "+hundreds+", tens: "+tens+", ones: "+ones);

		}
		println("------------ ");

	}
}


//----------------------TAPELOOP--------------------

void setupPlane(){
	plane = createImage(256, 256, ARGB);
	
	for(int i = 0; i < width; i++){
		for(int j = 0; j < height; j++){

			//tape[i][j] = int(random(255));
			//resolutions[i][j] = int(random(255));
			tape[i][j] = j;
			resolutions[i][j] = i;
	
		}
	}
}

void updatePlane(){
	plane.loadPixels();
	for(int i =  0; i < 256; i++){
    	for(int j =  0; j < 256; j++){
      		plane.pixels[ j * 256 + i  ] = color(tape[i][j], resolutions[i][j]);
      		decay(i, j, j * 256 + i );
    	}
  	}
	plane.updatePixels();
	inc += 0.001;
}

void decay(int tapePosition, int tapePositionTwo, int fullPos){
	//decay the tape at this position
	float noi = map(noise(inc+(fullPos)), 0, 1, 0, 15);
	if(resolutions[tapePosition][tapePositionTwo] - noi <= 0){
		tape[tapePosition][tapePositionTwo] = 0;
		resolutions[tapePosition][tapePositionTwo] = 256;
	}else{
		tape[tapePosition][tapePositionTwo] += 1;
		resolutions[tapePosition][tapePositionTwo] -= noi;
	}	
}