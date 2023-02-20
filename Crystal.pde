public class Crystal {
  float xPosition;
  float yPosition;
  
  public Crystal(float xPosition, float yPosition){
    this.xPosition = xPosition;
    this.yPosition = yPosition;
  }
  
  void show() {
    fill(255,0,0);
    rect(xPosition,yPosition,whiteKeyWidth,yPosition+ 20); 
  }
  
  void update() {
    this.yPosition += 1;
  }
}
