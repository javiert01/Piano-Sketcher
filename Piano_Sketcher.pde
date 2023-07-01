import themidibus.*;
import javax.sound.midi.MidiMessage;

int numberOfWhiteKeys = 35;
int numberOfBlackKeys = 25;
int whiteKeyWidth = 0;
int blackKeyWidth = 0;
ArrayList<Star> stars = new ArrayList();
int numberOfStars = 200;
int keyCrystalIndex = 0;
float speed;
int numberOfCrystals = 10;
MidiBus myBus;
Piano piano;
Crystal crMouse;
PImage backgroundPhoto;
color leafColor;

void setup() {
  size(1800, 800);
  backgroundPhoto = loadImage("sky.png");
  MidiBus.list(); 
  myBus = new MidiBus(this, 1, 1);
  whiteKeyWidth = width/numberOfWhiteKeys;
  blackKeyWidth = 2* whiteKeyWidth / 3;
  piano = new Piano(numberOfWhiteKeys,numberOfBlackKeys,36);
  piano.keys.entrySet().forEach(auxKey -> {
   for(int i=0; i <numberOfCrystals; i++){
    auxKey.getValue().crystals.add(new Crystal(0,0));
  }
  });
  for (int i = 0; i < numberOfStars; i++) {
    stars.add(new Star());
  }
  leafColor = color(220,120,170, 100);
}


void draw() {
  image(backgroundPhoto,0, 0);
  stroke(0);
  strokeWeight(1);
  piano.show();
  speed = 5;
  pushMatrix();
  translate(width/2, height);
  branch(80, color(180,100));
  popMatrix();
  pushMatrix();
  translate(width/4, height);
  branch(60, leafColor);
  popMatrix();
  pushMatrix();
  translate(3*width/4, height);
  branch(60, leafColor);
  popMatrix();
  //pushMatrix();
  //// I shift the entire composition,
  //// moving its center from the top left corner to the center of the canvas.
  //translate(width/2, height/2);
  //// I draw each star, running the "update" method to update its position and
  //// the "show" method to show it on the canvas.
  //for (int i = 0; i < numberOfStars; i++) {
  //  stars.get(i).update();
  //  stars.get(i).show();
  //}
  //popMatrix();
  piano.keys.entrySet().forEach(auxKey -> {
    for(Crystal cr :auxKey.getValue().crystals) {
    cr.update();
    cr.show();
    }
  });
  
}


void midiMessage(MidiMessage message, long timestamp, String bus_name) { 
  if(message.getLength() < 2) {
    return;
  }
  int note = (int)(message.getMessage()[1] & 0xFF);
  int vel = (int)(message.getMessage()[2] & 0xFF);
  Key currentKey = piano.keys.get(note);
  if(currentKey.currentIndex >= numberOfCrystals) {
    currentKey.currentIndex = 0;
  }
  Crystal cr = currentKey.crystals.get(currentKey.currentIndex);
  cr.setPosition(currentKey.xPosition, currentKey.yPosition);
  if(vel > 64) {
    noteOn(currentKey, currentKey.currentIndex);
  } else {
    noteOff(currentKey, currentKey.currentIndex - 1);
  }
  currentKey.currentIndex++;
}

void branch(float len, color leafColor) {
  pushMatrix();
  if(len > 10) {
    stroke(0);
    strokeWeight(map(len,10,100,1,15));
    line(0,0,0,-len);
    translate(0, -len);
    rotate(radians(30));
    branch(len * 0.8, leafColor);
    rotate(radians(-55));
    branch(len * 0.75, leafColor);
  } else {
    fill(leafColor);
    noStroke();
    ellipse(0,0,10,10);
  }
  popMatrix();
}

void mousePressed() {
  crMouse.increaseLength = true;
  crMouse.setPosition(width/2, 0);
  crMouse.canShow = true;
}

void mouseReleased() {
  crMouse.increaseLength = false;
}

void noteOn(Key currentKey, int index) {
  Crystal cr = currentKey.crystals.get(index);
  cr.crLength = 0.5;
  cr.canShow = true;
  cr.increaseLength = true;
  currentKey.showPosition = true;
}

void noteOff(Key currentKey,int index) {
  currentKey.setCrystalLength(index, false);
  currentKey.showPosition = false;
}
