
static final int OCTAVE = 8;
int numberOfWhiteKeys = 40;
int numberOfBlackKeys = 20;
int whiteKeyWidth = 0;
int blackKeyWidth = 0;
void setup() {
  size(1800, 800);
  background(0);
  whiteKeyWidth = width/numberOfWhiteKeys;
  blackKeyWidth = 2* whiteKeyWidth / 3;
}

void draw() {
  strokeWeight(2);
  stroke(220,0,0);
  fill(255);
  for(int i=0; i<width; i+=whiteKeyWidth*OCTAVE){
    drawOctave(i);
  } 
  
}

void drawOctave(int initialX) {
  for(int i=0; i<OCTAVE; i++) {
    fill(255);
    int initialKeyPosition = initialX+(whiteKeyWidth*i);
    rect(initialKeyPosition,0,whiteKeyWidth,80);
  }
  for(int i=0; i<OCTAVE; i++) {
    if(i!=2 && i != OCTAVE - 1) {
      int initialKeyPosition = initialX+(whiteKeyWidth*i);
      fill(0);
      rect(2*whiteKeyWidth/3 + initialKeyPosition,0,blackKeyWidth,50);
    }
  }
}
