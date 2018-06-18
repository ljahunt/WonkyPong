class Circle {
  Body body;
  float w;
  float h;
  float r;
  
  // Constructor
  Circle(float x, float y) {
    w = 25;
    h = 25;
    
    // Define circle
    CircleShape cs = new CircleShape();
    r = box2d.scalarPixelsToWorld(w/2);
    cs.m_radius = r;
    
    // Define fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    
    // Physics parameters
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 1.125;
    
    // Define body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(new Vec2(x, y)));
    bd.bullet=true;
    
    body = box2d.createBody(bd);
    body.createFixture(fd);
    
    // Give some initial linear velocity
    body.setLinearVelocity(new Vec2(random(-30, 30), random(0,50)));
    
  }
  
  boolean done() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if(pos.y > height + 100) {
      box2d.destroyBody(body);
      return true;
    }
    return false;
  }
  
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    
    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(255,0,0);
    stroke(0);
    ellipse(0,0,w,h);
    popMatrix();
  }
}
    
