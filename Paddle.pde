class Paddle {
  Body body;
  float w;
  float h;
  
  BodyDef bd;
  Vec2 pos;
  
  // Constructor
  Paddle(float x, float y) {
    w = 60;
    h = 20;
    
    // Define polygon
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    sd.setAsBox(box2dW, box2dH);
    
    // Define fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    
    fd.density = 0;
    fd.friction = 0;
    
    // Define body
    bd = new BodyDef();
    bd.bullet = true;
    bd.type = BodyType.KINEMATIC;
    bd.position.set(box2d.coordPixelsToWorld(new Vec2(x, y)));
    bd.linearDamping = 1;
    bd.bullet=true;
    
    body = box2d.createBody(bd);
    body.createFixture(fd);
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
    
    // Implement keystroke movement
    if(keyPressed == true && key =='j') {
      body.setLinearVelocity(new Vec2(-30,0));
    }
    else if(keyPressed == true && key == 'l') {
      body.setLinearVelocity(new Vec2(30,0));
    }
    else {
      body.setLinearVelocity(new Vec2(0,0));
    }
    
    float a = body.getAngle();
    
    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(0);
    stroke(0);
    rect(0,0,w,h);
    popMatrix();
  }
}
