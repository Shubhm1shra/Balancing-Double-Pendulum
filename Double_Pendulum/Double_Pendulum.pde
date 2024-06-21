// For Bob-1
float theta_1 = random(0, PI);
float mass_1 = 20;
float r_1 = 10;
float l_1 = 100;
float x_1, y_1;
float ang_v1 = 0;
float ang_a1;

// For Bob-2
float theta_2 = random(0, PI);
float mass_2 = 20;
float r_2 = 10;
float l_2 = 150;
float x_2, y_2;
float ang_v2 = 0;
float ang_a2;

// Previous Bob-2 Position
float p_x2 = -1;
float p_y2 = -1;

// Gravity
float g = 1;

PGraphics canvas;

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
  
  calcAngles();
  
  x_1 = l_1 * sin(theta_1);
  y_1 = l_1 * cos(theta_1);
  
  x_2 = x_1 + l_2 * sin(theta_2);
  y_2 = y_1 + l_2 * cos(theta_2);
  
  stroke(255);
  line(0, 0, x_1, y_1);
  fill(255);
  circle(x_1, y_1, r_1 * 2);

  stroke(255);
  line(x_1, y_1, x_2, y_2);
  fill(255);
  circle(x_2, y_2, r_2 * 2);
  
  canvas.beginDraw();
  canvas.translate(width/2, 200);
  canvas.stroke(random(255), random(255), random(255));
  if(p_x2 != -1 && p_y2 != -1){canvas.line(p_x2, p_y2, x_2, y_2);}
  canvas.endDraw();
  
  ang_v1 += ang_a1;
  ang_v2 += ang_a2;
  
  theta_1 += ang_v1;
  theta_2 += ang_v2;
  
  p_x2 = x_2;
  p_y2 = y_2;
}

void calcAngles(){
  float num1 = -g * (2 * mass_1 + mass_2) * sin(theta_1);
  float num2 = -mass_2 * g * sin(theta_1 - 2 * theta_2);
  float num3 = -2 * sin(theta_1 - theta_2) * mass_2;
  float num4 = ang_v2 * ang_v2 * l_2 + ang_v1 * ang_v1 * l_1 * cos(theta_1 - theta_2);
  float den = l_1 * (2 * mass_1 + mass_2 - mass_2 * cos(2 * theta_1 - 2 * theta_2));
  
  ang_a1 = (num1 + num2 + num3 * num4) / den;
  
  num1 = 2 * sin(theta_1 - theta_2);
  num2 = ang_v1 * ang_v1 * l_1 * (mass_1 + mass_2);
  num3 = g * (mass_1 + mass_2) * cos(theta_1);
  num4 = ang_v2 * ang_v2 * l_2 * mass_2 * cos(theta_1 - theta_2);
  den = l_2 * (2 * mass_1 + mass_2 - mass_2 * cos(2 * theta_1 - 2 * theta_2));
  
  ang_a2 = (num1 * (num2 + num3 + num4)) / den;
}
