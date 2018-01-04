import controlP5.*;
import processing.pdf.*;
ControlP5 cp5;
PGraphicsPDF pdf;
PGraphics quipu;
PFont largerTitleFont, titleFont, nameFont, detailsFont, pageFont, wordFont;
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
  surface.setResizable(true);
  surface.setSize(300, 300);
  cp5 = new ControlP5(this);
  setupUI();
  //config fonts and sizes
  largerTitleFont = createFont("Arial", 140);
  titleFont = createFont("Arial", 80);
  wordFont = createFont("Arial", 40);
  pageFont = createFont("Arial", 60);
  nameFont = createFont("Arial", 32);
  detailsFont = createFont("Arial", 8);
  fileAsStrings = loadStrings("./PDFQuipu.pde");
  filePathText = "./quipuMaker.pde";
  fileName = "quipuMaker";
  previousY = 120;
  previousX = 240;
  previousWidth = 0;
  lineHeight = 1400;
  spacing = 40;
}

void draw() {
  if (!saveQuipu) {
    //ui is being displayed
    surface.setSize(300, 300);
    cp5.show();
  }

  if (saveQuipu) { 
    if(startRecordPDF){
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
    else if(pageCounter-2 >= fileAsStrings.length) {
      background(255);
      drawBackCover();
      endRecord(); 
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

void setupUI() {
  cp5.addButton("loadTheFile")
    .setPosition(40, 40)
    .setSize(220, 40)
    .setLabel("Load New File");

  cp5.addButton("saveTheQuipu")
    .setPosition(40, 140)
    .setSize(220, 40)
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
  //translate to the correct location for drawing the next quipu
  pushMatrix();
  previousWidth = (spacing*fileAsStrings[pageCounter-2].length())-20;
  translate((6000-previousWidth)/2, (3375-lineHeight)/2);

  //draw the top line of the quipu
  //ignore if the line is blank
  stroke(random(160), 80, 120);
  strokeWeight(10);
  if (fileAsStrings[pageCounter-2].length() > 0) {
    line(0, lineStart, (spacing*fileAsStrings[pageCounter-2].length())-spacing, lineStart);
  }


  // for each character of the line draw a new pendant line and add the knots
  for (int i = 0; i < fileAsStrings[pageCounter-2].length(); i++) {
    // get this characted
    int charNum = int(fileAsStrings[pageCounter-2].charAt(i));
    //split the hundreds, tens, and ones
    int hundreds = charNum/100;
    int tens = (charNum%100)/10;
    int ones = (charNum%10)/1;
    //print for debugging
    //println(fileAsStrings[pageCounter-2].charAt(i)+" = hundreds:"+hundreds+", tens:"+tens+", ones:"+ones);

    float spaceY = lineHeight/4;
    // draw the pendant line
    strokeWeight(6);
    line(i*spacing, lineStart, i*spacing, lineHeight);

    strokeWeight(2);
    int knotSize = 36;
    //add the knots in the correct locations
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
  //textFont(wordFont);
  //text(pageCounter++, width/2, height -40);
  pageCounter++;
}

void fillAlt() {
  if (fillAlternator == 30) {
    fillAlternator = 255;
  } else {
    fillAlternator = 30;
  }
}

void checkEmptyLine(int line) {
  if (fileAsStrings[line].length() == 0) {
    line = int(random(fileAsStrings.length));
    checkEmptyLine(line);
  }
}

void drawSingleImage() {
  int line = int(random(fileAsStrings.length));
  checkEmptyLine(line);
  quipu = createGraphics(6000, 3375);
  quipu.beginDraw();
  quipu.background(255);
  quipu.pushMatrix();
  previousWidth = (spacing*fileAsStrings[line].length())-20;
  quipu.translate((quipu.width-previousWidth)/2, (quipu.height-lineHeight)/2);
  //draw the top line of the quipu
  //ignore if the line is blank
  quipu.stroke(random(160), 80, 120);
  quipu.strokeWeight(10);
  quipu.line(0, lineStart, (spacing*fileAsStrings[line].length())-spacing, lineStart);
  // for each character of the line draw a new pendant line and add the knots
  for (int i = 0; i < fileAsStrings[line].length(); i++) {
    // get this characted
    int charNum = int(fileAsStrings[line].charAt(i));
    //split the hundreds, tens, and ones
    int hundreds = charNum/100;
    int tens = (charNum%100)/10;
    int ones = (charNum%10)/1;
    //print for debugging
    //println(fileAsStrings[pageCounter-2].charAt(i)+" = hundreds:"+hundreds+", tens:"+tens+", ones:"+ones);
    float spaceY = lineHeight/4;
    // draw the pendant line
    quipu.strokeWeight(6);
    quipu.line(i*spacing, lineStart, i*spacing, lineHeight);
    quipu.strokeWeight(2);
    int knotSize = 36;
    //add the knots in the correct locations
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
  println("quipu created. ");
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