public class Crystal {
  float xPosition;
  float yPosition;
  float size;
  float crLength;
  float angle;
  int numberOfSides;
  boolean canShow;
  boolean increaseLength;
  
  public Crystal(float xPosition, float yPosition){
    this.xPosition = xPosition;
    this.yPosition = yPosition;
    this.size = 20;
    this.crLength = 20;
    this.numberOfSides = 8;
    this.angle = TWO_PI / this.numberOfSides;
    this.canShow = false;
    this.increaseLength = true;
  }
  
  void setPosition(float xPosition, float yPosition) {
    this.xPosition = xPosition;
    this.yPosition = yPosition;
  }
  
  void show() {
    if(!this.canShow){
      return;
    }
    strokeWeight(8);
    stroke(90,148,240);
    fill(70,150,200);
    float centerX = xPosition + size/2;
    float centerY = yPosition + size;
    beginShape();
    for (int i = 0; i < numberOfSides; i++) {
      // Compute the x and y positions of each vertex using trigonometry
      float x = centerX + size * cos(i * angle + angle/2);
      float y = centerY + size * sin(i * angle + angle/2);
      if(i < 4) {
        y += crLength;
      }
      // Add the vertex to the shape
      vertex(x, y);
    }
    endShape(CLOSE);
    //rect(xPosition,yPosition,whiteKeyWidth,crLength); 
  }
  
  void update() {
    if(!this.canShow){
      return;
    }
    if(this.yPosition > height + 20){
      this.canShow = false;
      this.xPosition = 0;
      this.yPosition = 0;
      return;
    }
    if(this.increaseLength) {
      this.crLength += 1;
      return;
    }
    this.yPosition += 1;
  }
}
