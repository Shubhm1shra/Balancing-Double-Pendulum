class Bob {
  float x, y, angle, mass, radius, l;
  float angle_V = 0;
  float angle_A = 0;
  Bob() {
    this.angle = random(0, 3 * PI/2);
    this.mass = 15;
    this.l = 150;
    this.radius = 15;
  }
  Bob(float angle, float mass, float l) {
    this.angle = angle;
    this.mass = mass;
    this.l = l;
    this.radius = 15;
  }
  Bob(float angle, float mass, float l, float radius) {
    this.angle = angle;
    this.mass = mass;
    this.l = l;
    this.radius = radius;
  }
}

class doublePendulum {
  Bob b1, b2;
  float g = 1;
  float dampFactor = 1;
  
  doublePendulum(Bob b1, Bob b2) {
    this.b1 = b1;
    this.b2 = b2;
  }
  doublePendulum(Bob b1, Bob b2, float g) {
    this.b1 = b1;
    this.b2 = b2;
    this.g = g;
  }
  doublePendulum(Bob b1, Bob b2, float g, float dampFactor) {
    this.b1 = b1;
    this.b2 = b2;
    this.g = g;
    this.dampFactor = dampFactor;
  }
  
  void update() {
    this.b1.x = this.b1.l * sin(this.b1.angle);
    this.b1.y = this.b1.l * cos(this.b1.angle);
    
    this.b2.x = this.b1.x + this.b2.l * sin(this.b2.angle);
    this.b2.y = this.b1.y + this.b2.l * cos(this.b2.angle);
    
    calcAngAcc();
    
    this.b1.angle_V += this.b1.angle_A;
    this.b2.angle_V += this.b2.angle_A;
    
    this.b1.angle += this.b1.angle_V;
    this.b2.angle += this.b2.angle_V;
  }
  
  void calcAngAcc() {
    float num1 = -this.g * (2 * this.b1.mass + this.b2.mass) * sin(this.b1.angle);
    float num2 = -this.b2.mass * this.g * sin(this.b1.angle - 2 * this.b2.angle);
    float num3 = -2 * sin(this.b1.angle - this.b2.angle) * this.b2.mass;
    float num4 = this.b2.angle_V * this.b2.angle_V * this.b2.l + this.b1.angle_V * this.b1.angle_V * this.b1.l * cos(this.b1.angle - this.b2.angle);
    float den = this.b1.l * (2 * this.b1.mass + this.b2.mass - this.b2.mass * cos(2 * this.b1.angle - 2 * this.b2.angle));
    
    this.b1.angle_A = (num1 + num2 + num3 * num4) / den;
    
    num1 = 2 * sin(this.b1.angle - this.b2.angle);
    num2 = this.b1.angle_V * this.b1.angle_V * this.b1.l * (this.b1.mass + this.b2.mass);
    num3 = this.g * (this.b1.mass + this.b2.mass) * cos(this.b1.angle);
    num4 = this.b2.angle_V * this.b2.angle_V * this.b2.l * this.b2.mass * cos(this.b1.angle - this.b2.angle);
    den = this.b2.l * (2 * this.b1.mass + this.b2.mass - this.b2.mass * cos(2 * this.b1.angle - 2 * this.b2.angle));
    
    this.b2.angle_A = (num1 * (num2 + num3 + num4)) / den;
  }
}

PGraphics canvas;
Bob b1 = new Bob();
Bob b2 = new Bob();
doublePendulum P = new doublePendulum(b1, b2);

float p_x2 = -1;
float p_y2 = -1;

void setup() {
  size(800, 800);
  
  canvas = createGraphics(width, height);
  canvas.beginDraw();
  canvas.background(0);
  canvas.endDraw();
}

void draw() {
  image(canvas, 0, 0);
  
  translate(width/2, 200);
  
  P.update();
  
  stroke(255);
  line(0, 0, P.b1.x, P.b1.y);
  fill(255);
  circle(P.b1.x, P.b1.y, 2 * P.b1.radius);

  stroke(255);
  line(P.b1.x, P.b1.y, P.b2.x, P.b2.y);
  fill(255);
  circle(P.b2.x, P.b2.y, 2 * P.b2.radius);
  
  canvas.beginDraw();
  canvas.translate(width/2, 200);
  canvas.stroke(random(255), random(255), random(255));
  if(p_x2 != -1 && p_y2 != -1){canvas.line(p_x2, p_y2, P.b2.x, P.b2.y);}
  canvas.endDraw();
  
  p_x2 = P.b2.x;
  p_y2 = P.b2.y;
  
  print("Angular Acceleration --> B1 : " + this.b1.angle_A + " B2 : " + this.b2.angle_A + "\n");
  print("\n");
}
