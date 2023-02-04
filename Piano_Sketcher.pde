import themidibus.*;
import javax.sound.midi.MidiMessage;

static final int OCTAVE = 8;
int numberOfWhiteKeys = 40;
int numberOfBlackKeys = 20;
int whiteKeyWidth = 0;
int blackKeyWidth = 0;
MidiBus myBus;
Piano piano;

void setup() {
  size(1800, 800);
  background(0);
  MidiBus.list(); 
  myBus = new MidiBus(this, 1, 1);
  whiteKeyWidth = width/numberOfWhiteKeys;
  blackKeyWidth = 2* whiteKeyWidth / 3;
  piano = new Piano(35,25,36);
  piano.printKeys();
}

void draw() {
  strokeWeight(2);
  stroke(220,0,0);
  fill(255);
  piano.show();
  
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

void midiMessage(MidiMessage message, long timestamp, String bus_name) { 
  if(message.getLength() < 2) {
    return;
  }
  int note = (int)(message.getMessage()[1] & 0xFF);
  int vel = (int)(message.getMessage()[2] & 0xFF);
  if(vel > 64) {
    noteOn(note);
  } else {
    noteOff(note);
  }
  println("Bus " + bus_name + ": Note "+ note + ", vel " + vel);
}

void noteOn(int note) {
}

void noteOff(int note) {
}
