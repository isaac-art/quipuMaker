# quipuMaker

![](https://raw.githubusercontent.com/isaac-art/quipuMaker/master/quipuMaker/exampleSingleImage-1920x1080.png)
##### Sample Image (1920 x 1080)

---

### quipuMaker
quipuMaker is an ASCII to Quipu knot diagram maker.   
  **produced by**: Isaac Clarke   

<br/>
Documentation Video: https://vimeo.com/250792355

<br/>
<br/>

Quipu (or talking knots) are knotted databases used by the Incas.  Quipiu became the main form of record-keeping for the Inca Empire. As they had no written language the Quipu is our main evidence for theory on the society and culture of that time. They were used for a wide variety of reasone such as census databases, recording infomation about the distribution of wealth, or displaying the  prices of different goods at a market.     
<br/>
 In this script I have taken the numerical structure of the Quipu and aligned it to the ASCII values for characters. This allows me to print out diagrams for knotting quipus and store the files as fabric.   
<br/>
  The acknowledgement of the previous forms of technology: weaving to computers, fabric to paper, knots to mysql. Allows us a perspective from which we can look at human interaction with current digital technology as a relationship that has been happening for a long, long time.   
 <br/>
 I began this project think of quipu as a programming language, and spent a long time thinking of how to use qupiu as an input for a processing script. I began by writing an interpretor for the Brainfuck programming language, and attempting to convert Brainfuck to Quipu, mapping all the accepted characters ( . , < > [ ] + -  ) to qualities of a Pendant (knot numbers, color, cord twist, knot direction). I quickly began to see that the combined restriction fo the two systems on top of each other would make the amount of knots required to record anything an astronomical figure.  This is something I would like to return to at some point, but for this work I found it made more sense to get a good understanding of the Qupiu structure and its traditional use as data storage.  
  <br/>
  This presented two options for me, illustration of something like a csv, where there is a consistent structure to the data which can be mapped, this would allow a user to select a csv file and have a quipu drawn that contains the information. Alternatively, thinking of the quipu as a filetype and instead translating any file into the quipu numerical strucuture. I decided to go with the second process as I was interested in creating a quipu that contained the information that created it ( a quipu which was made by this script that contained this script, a program that ate itself). This made the quipu still data storage but less like a database and more like a hard-drive. I like the versitility of this.   
  <br/>
  This script takes an input text file converts it to ascii values, seperates the ones, tens, hundreds, and draw them as knots. This isn't optimized, so numbers are also read as ascii values. It currently doesn't create any sub-pendants on the quipu, or use knot direction.  
 <br/>
Originally this output a single image containing all of the quipus of a file. The problem with this was if the file was long then the image would either have to get really big, or the drawing too small to be read. Visully interesting but not useful as knotting instructions. So this version creates a PDF instead and each quipu is on a new page.  
  <br/>
  It also outputs a single example image of one of the quipus randomly and saves that as an example alongside the PDF. The previous version can be found here:   [https://github.com/isaac-art/quipuMaker/tree/master/previousVersions/](https://github.com/isaac-art/quipuMaker/tree/master/previousVersions/)  
<br/> During this process I have also been thinking about where decay fits in the Memory, Action, Decision, Repetition, of programming. I guess it fits under memory, as memory can decay. I think it is an important part of an ecosystem. I started playing with the tape based programming languages like Brainfuck by allowing the tape to loop, rather than having an unlimited length. There were some interesting experiments where images were inputted and translated onto a tape loop and reprinted. I think I will also return to these experiments at some point in the near future.  
  <br/> The experiments with tape-loop-memory languages can also be found in the git repository. [https://github.com/isaac-art/quipuMaker](https://github.com/isaac-art/quipuMaker)
  
---

### Sketchbook  <br/>
![](https://raw.githubusercontent.com/isaac-art/quipuMaker/master/sketchbook/IMG_1187.jpg) <br/> 
![](https://raw.githubusercontent.com/isaac-art/quipuMaker/master/sketchbook/IMG_1188.jpg) <br/>
![](https://raw.githubusercontent.com/isaac-art/quipuMaker/master/sketchbook/IMG_1189.jpg) <br/>
![](https://raw.githubusercontent.com/isaac-art/quipuMaker/master/sketchbook/IMG_1190.jpg) <br/>
![](https://raw.githubusercontent.com/isaac-art/quipuMaker/master/sketchbook/IMG_1191.jpg) <br/>
![](https://raw.githubusercontent.com/isaac-art/quipuMaker/master/sketchbook/IMG_1192.jpg) <br/>
![](https://raw.githubusercontent.com/isaac-art/quipuMaker/master/sketchbook/IMG_1193.jpg) <br/>
![](https://raw.githubusercontent.com/isaac-art/quipuMaker/master/sketchbook/IMG_1194.jpg) <br/>
![](https://raw.githubusercontent.com/isaac-art/quipuMaker/master/sketchbook/IMG_1195.jpg) <br/>
![](https://raw.githubusercontent.com/isaac-art/quipuMaker/master/sketchbook/IMG_1196.jpg) <br/>
![](https://raw.githubusercontent.com/isaac-art/quipuMaker/master/sketchbook/IMG_1197.jpg) <br/>
![](https://raw.githubusercontent.com/isaac-art/quipuMaker/master/sketchbook/IMG_1198.jpg) <br/>
![](https://raw.githubusercontent.com/isaac-art/quipuMaker/master/sketchbook/IMG_1199.jpg) <br/>
![](https://raw.githubusercontent.com/isaac-art/quipuMaker/master/sketchbook/IMG_1200.jpg) <br/>
![](https://raw.githubusercontent.com/isaac-art/quipuMaker/master/sketchbook/quipuTest.JPG) <br/>
<br/>
![](https://raw.githubusercontent.com/isaac-art/quipuMaker/master/quipuMaker/exampleThumb.png)
<br/>
##### Thumbnail (740 x 450) <br/>

<br/>

![](https://raw.githubusercontent.com/isaac-art/quipuMaker/master/sketchbook/IMG_E1213.jpg)
<br/>
##### Test Quipu <br/>


---

<br/>

### References  <br/>
 Parr, T (2010) Language Implementation Patterns. Pragmatic Bookshelf.  <br/>  Ascher, M. Ascher, R (1982) Mathematics of the Incas, Code of the Quipu. Dover Publications Inc.  <br/>  Blackwell, A (2006) Metaphors we program by: Space, Action and Society in Java. University of Cambridge. <br/>  Fuller, M (2008) Software Studies: a lexicon. MIT Press.  <br/>  McLean, A (2011) Artist-Programmers and Programming Languages for the Arts. Thesis Paper. Goldsmiths UoL.  <br/>  "Esolangs" - [https://esolangs.org](https://esolangs.org) (sourced 7/1/18). <br/>  "Esoteric Codes" - [http://esoteric.codes/](http://esoteric.codes/) (sourced 7/1/18). <br/>  "Harvard Quipu Database" - [http://khipukamayuq.fas.harvard.edu/](http://khipukamayuq.fas.harvard.edu/) (sourced 7/1/18). <br/>  "PENELOPE Weaving as Techinical Existance" - [https://penelope.hypotheses.org/](https://penelope.hypotheses.org/) (sourced 7/1/18). <br/>  <br/> The quipuMaker Documentation Video is available here - [https://vimeo.com/250792355](https://vimeo.com/250792355). 
