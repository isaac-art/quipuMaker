import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 
import processing.pdf.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class PDFQuipu extends PApplet {



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

public void setup() {
  surface.setResizable(true);
  surface.setSize(400, 300);
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

public void draw() {
  if (!saveQuipu) {
  	//ui is being displayed
  }
  if (saveQuipu) {
    cp5.hide();

    surface.setSize(6000, 3375);
	pdf = (PGraphicsPDF)beginRecord(PDF, fileName+"-quipu.pdf");
	beginRecord(pdf);
	background(255);
	// draw the cover and intro first
	if (pageCounter == 0) {
		// FIRST PAGE
		drawFrontCover();
		pdf.nextPage();
		pageCounter++;
		pdf.nextPage();
		pageCounter++;
	}
	//draw the end pages at the end
	else if (pageCounter-2 >= fileAsStrings.length) {
		drawBackCover();
		endRecord(); 
		drawSingleImage();
		exit();
	}
	//draw all the pages
	else {
		drawQuipuPage();
		pdf.nextPage();
	}

  }
}

public void setupUI() {
  cp5.addButton("loadTheFile")
    .setPosition(40, 40)
    .setSize(220, 40)
    .setLabel("Load New File");

  cp5.addButton("saveTheQuipu")
    .setPosition(40, 140)
    .setSize(220, 40)
    .setLabel("create Quipu");
}

public void loadTheFile() {
  selectInput("Choose a text file to translate:", "fileSelected");
}

public void fileSelected(File theFile) {
  if (theFile != null) {
    println("Importing the file at:"+theFile.getAbsolutePath());
    // load this file as array of Strings.
    fileAsStrings = loadStrings(theFile.getAbsolutePath());
    fileName = theFile.getName();
    filePathText = theFile.getAbsolutePath();
    hasLoadedFile = true;
  }
}

public void saveTheQuipu() {
  saveQuipu = true;
}


public void drawQuipuPage() {
   //translate to the correct location for drawing the next quipu
  pushMatrix();
  previousWidth = (spacing*fileAsStrings[pageCounter-2].length())-20;
  translate((width-previousWidth)/2, (height-lineHeight)/2);
  
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
    int charNum = PApplet.parseInt(fileAsStrings[pageCounter-2].charAt(i));
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

public void fillAlt() {
  if (fillAlternator == 30) {
    fillAlternator = 255;
  } else {
    fillAlternator = 30;
  }
}

public void checkEmptyLine(int line) {
  if (fileAsStrings[line].length() == 0) {
    line = PApplet.parseInt(random(fileAsStrings.length));
    checkEmptyLine(line);
  }
}

public void drawSingleImage() {
  int line = PApplet.parseInt(random(fileAsStrings.length));
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
    int charNum = PApplet.parseInt(fileAsStrings[line].charAt(i));
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

public void drawFrontCover() {
  // TITLE PAGE
  fill(0);
  textFont(titleFont);
  textAlign(CENTER, CENTER);
  text("Quipu Diagrams For", width/2, (height/2)-180);
  textFont(largerTitleFont);
  text(fileName, width/2, height/2);
}

public void drawBackCover() {
  //add a blank page at the end.
  background(255);
  pdf.nextPage();
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "PDFQuipu" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
