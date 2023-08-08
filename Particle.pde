class Particle
{
  PVector position;
  PVector velocity;
  PVector acceleration;
  float oppacity;
  float w;
  color clr;
  boolean alive;
  
  protected Particle(float x, float y, float wth, color c, float o)
  {
    position = new PVector(x, y);
    velocity = new PVector(0,0);
    acceleration = new PVector(1.2,0);
    w = wth;
    clr = c;
    oppacity = o;
    alive = true;
  }
  
  public void reproduce(ArrayList<Particle> particles)
  {
    if(w > 1)
    {
      for(int i = 0; i < 2; i++)
      {
        float newX = position.x + random(-w, w);
        float newY = position.y + random(-w/2, w/4);
        float r = random(10);
        float newW = w - r;
        if(newW < 1)
          newW = 1;
        particles.add(new Particle(newX, newY, newW, clr, oppacity));
        alive = false;
      }
    }
  }
  
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }
  
  void applyForce(PVector force) {
    acceleration.add(force);
  }
  
  void run() {
    update();
    display();
  }
  
  public void display()
  {
    fill(clr, oppacity);
    ellipse(position.x, position.y, w, w);
  }
}
