import themidibus.*;
import javax.sound.midi.MidiMessage;

int numberOfWhiteKeys = 35;
int numberOfBlackKeys = 25;
int whiteKeyWidth = 0;
int blackKeyWidth = 0;
ArrayList<Star> stars = new ArrayList();
ArrayList<Crystal> crystals = new ArrayList();
int numberOfStars = 300;
float speed;
int numberOfCrystals = 50;
int crystalIndex = 0;
MidiBus myBus;
Piano piano;
Crystal crMouse;

void setup() {
  size(1800, 800);
  background(0);
  MidiBus.list(); 
  myBus = new MidiBus(this, 1, 1);
  whiteKeyWidth = width/numberOfWhiteKeys;
  blackKeyWidth = 2* whiteKeyWidth / 3;
  piano = new Piano(numberOfWhiteKeys,numberOfBlackKeys,36);
  piano.printKeys();
  for(int i=0; i <numberOfCrystals; i++){
    crystals.add(new Crystal(0,0));
  }
   crMouse = crystals.get(5);
  for (int i = 0; i < numberOfStars; i++) {
    stars.add(new Star());
  }
}

void draw() {
  background(0);
  stroke(0);
  strokeWeight(1);
  piano.show();
  speed = 5;
  pushMatrix();
  // I shift the entire composition,
  // moving its center from the top left corner to the center of the canvas.
  translate(width/2, height/2);
  // I draw each star, running the "update" method to update its position and
  // the "show" method to show it on the canvas.
  for (int i = 0; i < numberOfStars; i++) {
    stars.get(i).update();
    stars.get(i).show();
  }
  popMatrix();
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

void mousePressed() {
  crMouse.increaseLength = true;
  crMouse.setPosition(width/2, 0);
  crMouse.canShow = true;
}

void mouseReleased() {
  crMouse.increaseLength = false;
}

void noteOn(int note) {
  if(crystalIndex > numberOfCrystals - 1) {
    crystalIndex = 0;
  }
  Key currentKey = piano.keys.get(note);
  Crystal cr = crystals.get(crystalIndex);
  cr.setPosition(currentKey.xPosition, currentKey.yPosition);
  cr.canShow = true;
  currentKey.showPosition = true;
  crystalIndex++;
}

void noteOff(int note) {
  piano.keys.get(note).showPosition = false;
}
