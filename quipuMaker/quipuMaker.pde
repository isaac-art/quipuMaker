/////////////////////////////////////////
//             Quipu Maker             //
//           by Isaac Clarke           //  
//      December 2017 - January 2018   //
/////////////////////////////////////////

/*     
 ASCII TO QUIPU TRANSLATOR
 
 "I've lost all the seconds that led up to this"
 
 ------------REQUIREMENTS----------
 ControlP5
 an input file (defaults to itself)
 
 ------------INSTRUCTIONS----------
 - Select an ASCII file with 'Load New File', by default the program 
 uses itself as the input file.
 - Click 'Create Quipu' to run the loaded file through the quipuMaker
 - returns a pdf 'fileName-quipu.pdf' 
 - and an image 'fileName-singleExampleQuipu.png '
 

 
 ------------ABOUT-----------------
 *Quipu*
 Quipu (or talking knots) are knotted databases used by the Incas. 
 Quipiu became the main form of record-keeping for the Inca Empire. 
 As they had no written language the Quipu is our main evidence for 
 theory on the society and culture of that time.
 They were used as census databases, recording infomation about the 
 distribution of wealth. They were used in markets to display the 
 prices of different goods. They recorded the ownership of land, 
 or any other information you wanted to store.
 
 In this script I have taken the numerical structure of the Quipu 
 and aligned it to the ASCII values for characters. This allows me 
 to print out diagrams for knotting quipus and store the files as 
 fabric.
 
 The acknowledgement of the previous forms of technology: weaving to 
 computers, fabric to paper, knots to mysql. Allows us a perspective 
 from which we can look at human interaction with current digital
 technology as a relationship that has been happening for a long, long
 time. 
 
 *Language*
 I began this project think of quipu as a programming language, and spent
 a long time thinking of how to use qupiu as an input for a processing 
 script. I began by writing an interpretor for the Brainfuck programming 
 language, and attempting to convert Brainfuck to Quipu. So mapping all the
 accepted characters ( . , < > [ ] + -  ) to qualities of a Pendant (knot numbers,
 color, cord twist, knot direction). I quickly began to see that the combined 
 restriction fo the two systems on top of each other would make the amount of 
 knots required to record anything an astronomical figure. 
 This is something I would like to return to at some point, but 
 for this work I found it made more sense to get a good understanding of
 the Qupiu structure and its traditional use as data storage.
 
 *Database or File Type*
 This presented two options for me, illustration of somthing like a csv, 
 where there is a consistent structure to the data which can be mapped. 
 This would allow a user to select a csv file and have a quipu drawn 
 that contains the information. Alternatively thinking of the quipu as 
 a filetype and instead translating anyfile into the quipus numerical 
 strucuture. I decided to go with the second process as I was interested 
 in creating a quipu that contained the information that created it (as in 
 a quipu which was made by this script that contained this script). This 
 made the quipu still data storage but less like a database and more like 
 a hard-drive. I like the versitility of this. 
 
 This script takes an input text file converts it to ascii values, 
 seperates the ones, tens, hundreds, and draw them as knots. This isn't 
 optimized, so numbers are also read as ascii values. It currently doesn't 
 create any sub-pendants on the quipu, or use knot direction.
 Originally this output a single image containing all of the quipus of
 a file. The problem with this was if the file was long then the image 
 would either have to get really big or too small to be read. Visully 
 interesting but not useful as knotting instructions. So this version
 creates a PDF instead and each quipu is on a new page.
 
 It also outputs a single example image of one of the quipus randomly and 
 saves that as an example alongside the PDF.
 
 The previous version can be found here:
 https://github.com/isaac-art/quipuMaker/tree/master/previousVersions/quipuMakerSingleImage
 
 During this process I have also been thinking about where decay fits in
 the Memory, Action, Decision, Repetition, of programming. I guess it fits 
 undder memory, as memory can decay. I think it is an important part of an 
 ecosystem. I started playing with the tape based programming languages like
 Brainfuck andjust allowing the tape to loop, rather than ahaving an unlimited 
 length. There were some interesting experiments where images were inputted and
 translated onto a tape loop and reprinted. I think I will also return to this
 at some point. 
 
 The experiments with brainfuck and tape memerory languages can also be found
 in the git repository. https://github.com/isaac-art/quipuMaker
 
 
 
 ------------REFERENCES------------
 Parr, T (2010) Language Implementation Patterns. Pragmatic Bookshelf.
 Ascher, M. Ascher, R (1982) Mathematics of the Incas, Code of the Quipu. Dover Publications Inc.
 Blackwell, A (2006) Metaphors we program by: Space, Action and Society in Java. University of Cambridge
 Fuller, M (2008) Software Studies: a lexicon. MIT Press.
 McLean, A (2011) Artist-Programmers and Programming Languages for the Arts. Thesis Paper. Goldsmiths UoL.
 "Esolangs" - https://esolangs.org (sourced 7/1/18)
 "Esoteric Codes" - http://esoteric.codes/ (sourced 7/1/18)
 "Harvard Quipu Database" - http://khipukamayuq.fas.harvard.edu/ (sourced 7/1/18)
 "PENELOPE Weaving as Techinical Existance" - https://penelope.hypotheses.org/ (sourced 7/1/18)
 
 
 */

import controlP5.*;
import processing.pdf.*;
ControlP5 cp5;
PGraphicsPDF pdf;
PGraphics quipu;
PFont largerTitleFont, titleFont;
String[] fileAsStrings;
String allTheText;
String fileName;
String filePathText;
int pageCounter = 0;
int rowCount = 0;
int fillAlternator = 255;
int lineHeight;
int lineStart = 120;
int quipuWidth;
int quipuHeight;
int spacing = 0;
int squareSz;
float previousWidth;
float previousX;
float previousY;
boolean saveQuipu = false;
boolean hasLoadedFile = false;
boolean startRecordPDF = false;

void setup() {
  // set the window as resizable to change between the gui and recording the images
  surface.setResizable(true);
  surface.setSize(300, 220);
  background(224, 101, 93);
  // setup the buttons for GUI
  cp5 = new ControlP5(this);
  setupUI();
  // config fonts and sizes
  largerTitleFont = createFont("Arial", 140);
  titleFont = createFont("Arial", 80);
  // load this file as the default input
  fileAsStrings = loadStrings("./quipuMaker.pde");
  filePathText = "./quipuMaker.pde";
  fileName = "quipuMaker";
  // some layout variables.
  previousY = 120;
  previousX = 240;
  previousWidth = 0;
  lineHeight = 1400;
  spacing = 40;
}

void draw() {
  // if the button to make the quipu hasn't been pressed, or a quipu has
  // already made, then show the GUI controls
  if (!saveQuipu) {
    //ui is being displayed
    surface.setSize(300, 220);
    background(6, 3, 3);
    cp5.show();
  }
  if (saveQuipu) { 
    if (startRecordPDF) {
      cp5.hide();
      surface.setSize(6000, 3375);
      pdf = (PGraphicsPDF)beginRecord(PDF, fileName+"-quipu.pdf");
      beginRecord(pdf);
      startRecordPDF = false;
    }
    // draw the cover and intro first
    if (pageCounter == 0) {
      // FIRST PAGE
      background(255);
      drawFrontCover();
      pdf.nextPage();
      pageCounter++;
      pdf.nextPage();
      pageCounter++;
    }
    //draw the end pages at the end
    else if (pageCounter-2 >= fileAsStrings.length) {
      background(255);
      drawBackCover();
      endRecord(); 
      // also draw a single image of one of the quipus
      drawSingleImage();
      saveQuipu = false;
      //exit();
    }
    //draw all the pages
    else {
      background(255);
      drawQuipuPage();
      pdf.nextPage();
    }
  }
}

// draw the GUI controls
void setupUI() {
  cp5.addButton("loadTheFile")
    .setPosition(40, 40)
    .setSize(220, 40)
    .setColorBackground(color(227, 162, 66))
    .setLabel("Load New File");

  cp5.addButton("saveTheQuipu")
    .setPosition(40, 140)
    .setSize(220, 40)
    .setColorBackground(color(177, 70, 76))
    .setLabel("create Quipu");
}

void loadTheFile() {
  selectInput("Choose a text file to translate:", "fileSelected");
}

void fileSelected(File theFile) {
  if (theFile != null) {
    println("Importing the file at:"+theFile.getAbsolutePath());
    // load this file as array of Strings.
    fileAsStrings = loadStrings(theFile.getAbsolutePath());
    fileName = theFile.getName();
    filePathText = theFile.getAbsolutePath();
    hasLoadedFile = true;
  }
}
void saveTheQuipu() {
  saveQuipu = true;
  startRecordPDF = true;
}

void drawQuipuPage() {
  // translate to the correct location for drawing the next quipu
  pushMatrix();
  // use the lenght of this line to determine the spacing so it can be drawn 
  // in the center of the page
  previousWidth = (spacing*fileAsStrings[pageCounter-2].length())-20;
  translate((6000-previousWidth)/2, (3375-lineHeight)/2);
  // draw the top line of the quipu, ignore if the line is empty
  stroke(random(160), 80, 120);
  strokeWeight(10);
  if (fileAsStrings[pageCounter-2].length() > 0) {
    line(0, lineStart, (spacing*fileAsStrings[pageCounter-2].length())-spacing, lineStart);
  }
  // for each character of the line draw a new pendant line and add the knots
  for (int i = 0; i < fileAsStrings[pageCounter-2].length(); i++) {
    // get this characted
    int charNum = int(fileAsStrings[pageCounter-2].charAt(i));
    // split the hundreds, tens, and ones
    int hundreds = charNum/100;
    int tens = (charNum%100)/10;
    int ones = (charNum%10)/1;
    // print for debugging
    // println(fileAsStrings[pageCounter-2].charAt(i)+" = hundreds:"+hundreds+", tens:"+tens+", ones:"+ones);
    float spaceY = lineHeight/4;
    // draw the pendant line
    strokeWeight(6);
    line(i*spacing, lineStart, i*spacing, lineHeight);
    // draw the knots in the correct locations
    strokeWeight(2);
    int knotSize = 36;
    for (int h = 0; h < hundreds; h++) {
      fill(fillAlternator); 
      rect(i*spacing-(knotSize/2), spaceY + (spaceY/2) + (h*knotSize), knotSize, knotSize);
      fillAlt();
    }
    for (int t = 0; t < tens; t++) {
      fill(fillAlternator);
      rect(i*spacing-(knotSize/2), spaceY*2 + (spaceY/2) + (t*knotSize), knotSize, knotSize); 
      fillAlt();
    }
    for (int o = 0; o < ones; o++) {
      fill(fillAlternator);
      rect(i*spacing-(knotSize/2), spaceY*3 + (spaceY/2) + (o*knotSize), knotSize, knotSize);
      fillAlt();
    }
  }
  popMatrix();
  // increment the counter
  pageCounter++;
}

// fillAlt alternates the colors of the knots between dark 
// and light so that they are easier to read
void fillAlt() {
  if (fillAlternator == 30) {
    fillAlternator = 255;
  } else {
    fillAlternator = 30;
  }
}

// check if the given line is empty
void checkEmptyLine(int line) {
  if (fileAsStrings[line].length() == 0) {
    line = int(random(fileAsStrings.length));
    checkEmptyLine(line);
  }
}

// This is very similar to the pages of the PDF except it is only called 
// once and draws to the quipu PGraphics which is then saved as a PNG.
// It is useful for a single example image.
void drawSingleImage() {
  // pick a line from the file
  int line = int(random(fileAsStrings.length));
  // check it isn't empty, if it is pick a different one that isn't empty.
  checkEmptyLine(line);
  // create the PGraphics object  
  quipu = createGraphics(6000, 3375);
  quipu.beginDraw();
  quipu.background(255);
  quipu.pushMatrix();
  previousWidth = (spacing*fileAsStrings[line].length())-20;
  quipu.translate((quipu.width-previousWidth)/2, (quipu.height-lineHeight)/2);
  quipu.stroke(random(160), 80, 120);
  quipu.strokeWeight(10);
  quipu.line(0, lineStart, (spacing*fileAsStrings[line].length())-spacing, lineStart);
  for (int i = 0; i < fileAsStrings[line].length(); i++) {
    int charNum = int(fileAsStrings[line].charAt(i));
    int hundreds = charNum/100;
    int tens = (charNum%100)/10;
    int ones = (charNum%10)/1;
    float spaceY = lineHeight/4;
    quipu.strokeWeight(6);
    quipu.line(i*spacing, lineStart, i*spacing, lineHeight);
    quipu.strokeWeight(2);
    int knotSize = 36;
    for (int h = 0; h < hundreds; h++) {
      quipu.fill(fillAlternator); 
      quipu.rect(i*spacing-(knotSize/2), spaceY + (spaceY/2) + (h*knotSize), knotSize, knotSize);
      fillAlt();
    }
    for (int t = 0; t < tens; t++) {
      quipu.fill(fillAlternator);
      quipu.rect(i*spacing-(knotSize/2), spaceY*2 + (spaceY/2) + (t*knotSize), knotSize, knotSize); 
      fillAlt();
    }
    for (int o = 0; o < ones; o++) {
      quipu.fill(fillAlternator);
      quipu.rect(i*spacing-(knotSize/2), spaceY*3 + (spaceY/2) + (o*knotSize), knotSize, knotSize);
      fillAlt();
    }
  }
  quipu.popMatrix();
  quipu.endDraw();
  //println("quipu created. ");
  // save the png
  quipu.save(fileName+"-singleExampleQuipu.png");
}

void drawFrontCover() {
  // TITLE PAGE
  fill(0);
  textFont(titleFont);
  textAlign(CENTER, CENTER);
  text("Quipu Diagrams For", 6000/2, (3375/2)-180);
  textFont(largerTitleFont);
  text(fileName, 6000/2, 3375/2);
}

void drawBackCover() {
  //add a blank page at the end.
  background(255);
  pdf.nextPage();
}