    /////////////////////////////////////////
   //             Quipu Maker             //
  //           by Isaac Clarke           //  
 //      December 2017 - January 2018   //
/////////////////////////////////////////

/*

  ASCII TO QUIPU DIAGRAM
 
  OPERATION
  Input a file
  Convert to ASCII code
  Draw as Quipu knot diagrams
  A Quipu for each line of the file.
  
  This isn't optimized, so numbers are read as ascii values,
  and currently doesn't create any sub-pendants on the quipu
  or use knot direction.
 
 */
import controlP5.*;
ControlP5 cp5;
ColorPicker cp;
PFont f;
PGraphics quipu;
String[] fileAsStrings;
String allTheText;
int lineStart = 20;
int lineHeight;
int spacing = 0;
float previousX;
float previousY;
float previousWidth;
boolean quipuCreated = false;
boolean goGoGo = false;
boolean selectedFile = true;
String filePathText;
int quipuWidth;
int quipuHeight;
int squareSz;
String fileName;
int fillAlternator = 255;

void setup() {
  size(300, 280);
  cp5 = new ControlP5(this);
  f = createFont("Arial", 20);
  // load this as default file
  fileAsStrings = loadStrings("./quipuMaker.pde");
  filePathText = "./quipuMaker.pde";
  fileName = "quipuMaker";
  previousY = 20;
  previousX = 40;
  previousWidth = 0;
  //12000 6750
  quipuWidth = 6000;
  quipuHeight = 3375;
  setupUI();
}

void draw() {
  background(100, 80, 120);
  text("Loaded:"+filePathText, 40, 210, 220, 40);
  if (quipuCreated) {
    text("Quipu Created!", 40, 240, 220, 40);
  }
  if (goGoGo) {
    if (selectedFile) {
      drawQuipu();
    }
    goGoGo = false;
  }
}

void setupUI() {
  cp5.addButton("loadFile")
    .setPosition(40, 40)
    .setSize(220, 40)
    .setLabel("Load New File");
    
  cp5.addButton("createQuipu")
    .setPosition(40, 140)
    .setSize(220, 40)
    .setLabel("create Quipu");
}

// choose a file to interpret
void loadFile() {
  selectInput("Choose a text file to translate:", "fileSelected");
}
void fileSelected(File theFile) {
  if (theFile != null) {
    println("Importing the file at:"+theFile.getAbsolutePath());
    // load this file as array of Strings.
    fileAsStrings = loadStrings(theFile.getAbsolutePath());
    fileName = theFile.getName();
    selectedFile = true;
    filePathText = theFile.getAbsolutePath();
  }
}

// Allow the draw loop to check for a file and make the quipu.
void createQuipu() {
  goGoGo = true;
}

void drawQuipu() {
  quipu = createGraphics(quipuWidth, quipuHeight);
  /*
   The multplier in the next line is optimized for this document. 
   I'm not sure how to get the lines to fit any input file size.
   If they are too small they cant be seen, too big and you lose 
   part of the text.
   This can be solved if I output a multi-page pdf as I can just put
   a quipu on each page instead, which would be much better for use,
   but for this proejct I am asked for one image, so I have tuned it 
   for one image.
   */
  //lineHeight = (quipu.height*14)/fileAsStrings.length;
  lineHeight = 300;
  //begin drawing the quipu PGraphics
  quipu.beginDraw();
  quipu.background(255);
  // for every line make a quipu
  for (int i = 0; i < fileAsStrings.length; i++) {
    stringToQuipu(fileAsStrings[i], i);
  }
  quipu.endDraw();
  println("quipu created. ");
  // save the image as timestamp
  quipu.save("./images/"+fileName+"-"+year()+"-"+month()+"-"+day()+"-"+hour()+"-"+minute()+"-"+second()+".png");
  //toggle the done message on UI
  quipuCreated = true;
}

// stringToQuipu takes the current line of the input 
// converts it into ascii, splits the numbers into 
// its hundreds, tens, and ones, and knots them on 
// a new diagram which is drawn onto the quipu PGraphics
void stringToQuipu(String programLine, int lineNum) {
  //set the spacing between each quipu
  spacing = 20;
  // print this line to console for debugging
  println(programLine);
  
  //translate to the correct location for drawing the next quipu
  quipu.pushMatrix();
  if (lineNum > 0 && lineNum < fileAsStrings.length) {
    previousX += previousWidth+60;
    // if next location if off the quipu PGraphics then wrap to next line
    if (previousX+(spacing*programLine.length()) > quipu.width) {
      previousX = 40;
      previousY += lineHeight+60;
    }
  } else {
    previousX = 40;
    previousY = 20;
  }
  quipu.translate(previousX, previousY);
  previousWidth = (spacing*programLine.length())-20;
  quipu.stroke(random(160), 80, 120);
  quipu.strokeWeight(4);
  
  //draw the top line of the quipu
  //ignore if the line is blank
  if (programLine.length() > 0) {
    quipu.line(0, lineStart, (spacing*programLine.length())-20, lineStart);
  }
  
  quipu.strokeWeight(2);
  // for each character of the line draw a new pendant line and add the knots
  for (int i = 0; i < programLine.length(); i++) {
    // get this characted
    int charNum = int(programLine.charAt(i));
    //split the hundreds, tens, and ones
    int hundreds = charNum/100;
    int tens = (charNum%100)/10;
    int ones = (charNum%10)/1;
    //print for debugging
    println(programLine.charAt(i)+" = hundreds:"+hundreds+", tens:"+tens+", ones:"+ones);

    float spaceY = lineHeight/4;
    // draw the pendant line
    quipu.line(i*spacing, lineStart, i*spacing, lineHeight);

    //add the knots in the correct locations
    for (int h = 0; h < hundreds; h++) {
      quipu.fill(fillAlternator); 
      quipu.rect(i*spacing-4, spaceY + (spaceY/2) + (h*8), 8, 8);
      fillAlt();
    }
    for (int t = 0; t < tens; t++) {
      quipu.fill(fillAlternator);
      quipu.rect(i*spacing-4, spaceY*2 + (spaceY/2) + (t*8), 8, 8); 
      fillAlt();
    }
    for (int o = 0; o < ones; o++) {
      quipu.fill(fillAlternator);
      quipu.rect(i*spacing-4, spaceY*3 + (spaceY/2) + (o*8), 8, 8);
      fillAlt();
    }
  }
  quipu.popMatrix();
}


// fillAlt alternates the colors of the knots between dark 
// and light so that they are easier to read
void fillAlt(){
  if(fillAlternator == 30){
    fillAlternator = 255;
  }else{
    fillAlternator = 30;
  }
  
}