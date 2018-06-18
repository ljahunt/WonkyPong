import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;
Paddle p;
Circle circle;

float initx;
float inity;

ArrayList<Paddle> paddles;
ArrayList<Circle> circles;
ArrayList<Boundary> boundaries;

void setup() {
  size(640, 360);
  smooth(8);
  
  initx = width / 2;
  inity = height - 10;
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  // Create array lists
  paddles = new ArrayList<Paddle>();
  circles = new ArrayList<Circle>();
  boundaries = new ArrayList<Boundary>();
  
  // Add some fixed boundaries
  boundaries.add(new Boundary(0,height/2,20,height));
  boundaries.add(new Boundary(width/2,5,width,10));
  boundaries.add(new Boundary(width,height/2,20,height));
  
  
  // Add a single paddle
  Paddle p = new Paddle(initx, inity);
  paddles.add(p);
  
  // Add a single circle
  Circle circle = new Circle(width/2, 30);
  circles.add(circle);
}

void draw() {
  background(255);
  
  // Step through time
  box2d.step();
  
  // Display the box
  paddles.get(0).display();
  
  // Display the circle
  circles.get(0).display();
 
  // Redundant paddle respawn as density = 0
  Paddle b = paddles.get(0);
  if(b.done()) {
    Paddle p = new Paddle(initx, inity);
    paddles.add(p);
    paddles.remove(0);
  }
  
  // Ball respawn
  Circle circle = circles.get(0);
  if(circle.done()) {
    Circle circle2 = new Circle(width/2, 30);
    circles.add(circle2);
    circles.remove(0);
  }
  
    // Display all the boundaries
  for (Boundary wall: boundaries) {
    wall.display();
  }

}
