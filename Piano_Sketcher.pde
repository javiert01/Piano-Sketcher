import themidibus.*;
import javax.sound.midi.MidiMessage;

int numberOfWhiteKeys = 35;
int numberOfBlackKeys = 25;
int whiteKeyWidth = 0;
int blackKeyWidth = 0;
ArrayList<Crystal> crystals = new ArrayList();
MidiBus myBus;
Piano piano;

void setup() {
  size(1800, 800);
  background(0);
  MidiBus.list(); 
  myBus = new MidiBus(this, 1, 1);
  whiteKeyWidth = width/numberOfWhiteKeys;
  blackKeyWidth = 2* whiteKeyWidth / 3;
  piano = new Piano(numberOfWhiteKeys,numberOfBlackKeys,36);
  piano.printKeys();
}

void draw() {
  background(0);
  piano.show();
  for(Crystal cr :crystals) {
    cr.update();
    cr.show();
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
}

void noteOn(int note) {
  Key currentKey = piano.keys.get(note);
  currentKey.showPosition = true;
  crystals.add(new Crystal(currentKey.xPosition, currentKey.yPosition));
}

void noteOff(int note) {
  piano.keys.get(note).showPosition = false;
}
