public class Key {
  public int id;
  public boolean isWhite;
  public float xPosition;
  public float yPosition;
  
  public Key(int id, boolean isWhite, float xPosition, float yPosition){
    this.id = id;
    this.isWhite = isWhite;
    this.xPosition = xPosition;
    this.yPosition = yPosition;
  }
  
  void show() {
    if(isWhite){
      fill(255);
      rect(xPosition,0,whiteKeyWidth,yPosition);
      fill(255,0,0);
      text(id,xPosition,40);
    }else{
      fill(0);
      rect(xPosition,0,blackKeyWidth,yPosition);
    }
  }
  
}
