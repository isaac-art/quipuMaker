PGraphics quipu;

String[] fileAsStrings;
String allTheText;

int programPosition = 0;
char[] programTape;

int lineStart = 20;
int lineHeight = 400;
int spacing = 0;

void setup() {
	size(256, 256);
	fileAsStrings = loadStrings("./bfQuipu.pde");
	allTheText = join(fileAsStrings, " ");
	programTape = allTheText.toCharArray();
  quipu = createGraphics(6000, 3375);
}

void draw() {
	charsToAsciiCodes();
  println("quipu created. "+programTape.length+" characters");
  quipu.save("./images/"+year()+month()+day()+hour()+minute()+second()+".png");
  exit();
}

void charsToAsciiCodes(){
  quipu.beginDraw();
  quipu.background(255);
  quipu.line(0, lineStart, quipu.width, lineStart);
	for(int i = 0; i < programTape.length; i++){
		int charNum = int(programTape[i]);
		int hundreds = charNum/100;
		int tens = (charNum%100)/10;
		int ones = (charNum%10)/1;
		println(programTape[i]+" = hundreds:"+hundreds+", tens:"+tens+", ones:"+ones);

    spacing = quipu.width/(programTape.length + 2);
    float spaceY = lineHeight/4;
    
    quipu.stroke(0);
    quipu.line(i*spacing, lineStart, i*spacing, lineHeight);
   
    quipu.stroke(map(i,0,quipu.width,120,255), 30, 60);
    for(int h = 0; h < hundreds; h++){
      quipu.rect(i*spacing-2, spaceY + (spaceY/2) + (h*(spacing/2)), spacing/2, spacing/2); 
	  }
    for(int t = 0; t < tens; t++){
      quipu.rect(i*spacing-2, spaceY*2 + (spaceY/2) + (t*(spacing/2)), spacing/2, spacing/2); 
    }
    for(int o = 0; o < ones; o++){
      quipu.rect(i*spacing-2, spaceY*3 + (spaceY/2) + (o*(spacing/2)), spacing/2, spacing/2); 
    }
  }
  quipu.endDraw();
}