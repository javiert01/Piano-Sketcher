class Piano {
  static final int OCTAVE = 7;
  int numberOfWhiteKeys;
  int numberOfBlackKeys;
  int initialKeyId;
  HashMap<Integer, Key> keys = new HashMap<>();
  
  Piano(int numberOfWhiteKeys, int numberOfBlackKeys, int initialKeyId) {
    this.numberOfWhiteKeys = numberOfWhiteKeys;
    this.numberOfBlackKeys = numberOfBlackKeys;
    this.initialKeyId = initialKeyId;
    this.initializeKeysPiano();
  }
  
  void initializeKeysByOctave(int initialId, float initialX) {
     for(int i=0; i<OCTAVE; i++) {
       float initialKeyPosition = initialX+(whiteKeyWidth*i);
       this.keys.put(initialId, new Key(initialId, true, initialKeyPosition, 80));
       initialId++;
       if(i!=2 && i != OCTAVE - 1) {
        this.keys.put(initialId, new Key(initialId, false, 2*whiteKeyWidth/3 + initialKeyPosition, 50));
        initialId++;
      }
     }
  }
  
  void initializeKeysPiano() {
    for(int i = this.initialKeyId, j=0; i< this.initialKeyId + numberOfWhiteKeys + numberOfBlackKeys; i+=12) {
      this.initializeKeysByOctave(i, j);
      j+=whiteKeyWidth*OCTAVE;
    }
  }
  
  void show() {
     this.keys.entrySet().forEach(key -> {
      if(key.getValue().isWhite) {
          key.getValue().show();
      }
    });
    this.keys.entrySet().forEach(key -> {
      if(!key.getValue().isWhite) {
          key.getValue().show();
      }
    });
  }
 
  void printKeys() {
    println("The keys are: ", this.keys.size());
    this.keys.entrySet().forEach(key -> {
      println(key.getKey() + " " + key.getValue().isWhite);
    });
  }
}
