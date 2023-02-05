public class Key {
  public int id;
  public boolean isWhite;
  public float xPosition;
  public float yPosition;
  public boolean showPosition;
  
  public Key(int id, boolean isWhite, float xPosition, float yPosition){
    this.id = id;
    this.isWhite = isWhite;
    this.xPosition = xPosition;
    this.yPosition = yPosition;
    this.showPosition = false;
  }
  
  void show() {
    
    if(isWhite){
      fill(255);
      rect(xPosition,0,whiteKeyWidth,yPosition);  
    }else{
      fill(0);
      rect(xPosition,0,blackKeyWidth,yPosition);
    }
    if(this.showPosition){
      fill(0,255,0);
      circle(this.xPosition+whiteKeyWidth/2, this.yPosition/2, 30);
    }
  }
  
}
