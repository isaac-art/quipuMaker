
int loopCounterOpen;
int loopCounterClosed;
String programString;

int m =0 ;
int programPosition = 0;
char[] programTape;

int memoryPosition = 0;
int[] memoryTape;

void setup() {
	size(128,128);
	programString = "++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.";
	programTape = programString.toCharArray();
	memoryTape = new int[16];

	for(int i = 0; i < memoryTape.length; i++){
		memoryTape[i] = 0;
	}

	println("programTape: ");
	for(int i =0; i < programTape.length; i ++){
		char c = char(programTape[i]);
		print(c);
	}
	println("\n");
	println("-------");
	println("memoryTape: ");
	for(int i =0; i < memoryTape.length; i ++){
		int c = memoryTape[i];
		print(c);
	}
	println("\n");
	println("-------");


}

void draw() {
	
	println("begin interpreter .... ");
	println("\n");
	interpreter();


	println("memoryTape: ");
	for(int i =0; i < memoryTape.length; i ++){
		char c = char(memoryTape[i]);
		print(c);
	}

	exit();
}


void interpreter(){

	while(programPosition < programTape.length){
		switch( programTape[programPosition]){
			case '+':
				memoryTape[memoryPosition] += 1;
				if(memoryTape[memoryPosition]  >= 255){
					memoryTape[memoryPosition] = 0;
				}
				break;
			case '-':
				memoryTape[memoryPosition] -= 1;
				if(memoryTape[memoryPosition]  <= -1){
					memoryTape[memoryPosition] = 255;
				}
				break;
			case '>':
				memoryPosition += 1;
				break;
			case '<':
				memoryPosition -= 1;
				break;
			case ',':
				// not using input 
				break;
			case '.':
				print(char(memoryTape[memoryPosition]));
				break;
			case '[':
				if(memoryTape[memoryPosition] == 0){
					loopCounterOpen = 0;
					programPosition +=1;

					while(loopCounterOpen > 0 || programTape[programPosition] != ']'){
						if(programTape[programPosition] == '['){
							loopCounterOpen +=1;
						}else if(programTape[programPosition] == ']'){
							loopCounterOpen -=1;
						}
						programPosition +=1;
					}

				}
				break;
			case ']':
				if(memoryTape[memoryPosition] != 0){
					loopCounterClosed = 0;
					programPosition -=1;
					while(loopCounterClosed > 0 || programTape[programPosition] != '['){
						if(programTape[programPosition] == ']'){
							loopCounterClosed +=1;
						}else if(programTape[programPosition] == '['){
							loopCounterClosed -=1;
						}
						programPosition -=1;
					}
				}
				break;
			default:
				break;
		}


		println("position:"+memoryPosition+", value:"+memoryTape[memoryPosition]);
		programPosition += 1;

	}

}