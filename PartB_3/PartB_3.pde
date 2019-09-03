/*
Student Name: Nur Muhammad Bin Khameed
SRN: 160269044
CO3355 Advanced Graphics and Animation CW2
Part B3

Instructions:
Press run to run file. A textured torus with toon effect is displayed.
No additional instructions.
*/
import peasy.*;

PShader shader;
PImage texture;
PeasyCam cam;

void setup(){
 size(500,500,P3D); 
 shader = loadShader("partBFragmentShader.glsl", "partBVertexShader.glsl");
 texture = loadImage("build.jpg");
 cam = new PeasyCam(this, 0, 0, 0, 1500);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(5000);
}

float angle=0;
void draw(){
  
  background(230);
  shader(shader);
  
  pointLight(255, 255, 0, 100, 100, 200);
  //pointLight(255, 255, 0, mouseX, mouseY, 200);
   
  translate(0, 0);
  rotateY(angle);  
  angle+=0.01;
  
  PShape myShape = getTorus(250, 130, 32, 32);
  shape(myShape);
}

PShape getTorus(float outerRad, float innerRad, int numc, int numt) {

  PShape sh = createShape();
  sh.beginShape(TRIANGLE_STRIP);
  sh.texture(texture);
  sh.noStroke();

  float x, y, z, s, t, u, v;
  float nx, ny, nz;
  float a1, a2;
  int idx = 0;
  for (int i = 0; i < numc; i++) {
    for (int j = 0; j <= numt; j++) {
      for (int k = 1; k >= 0; k--) {
         s = (i + k) % numc + 0.5;
         t = j % numt;
         u = s / numc;
         v = t / numt;
         a1 = s * TWO_PI / numc;
         a2 = t * TWO_PI / numt;
 
         x = (outerRad + innerRad * cos(a1)) * cos(a2);
         y = (outerRad + innerRad * cos(a1)) * sin(a2);
         z = innerRad * sin(a1);
 
         nx = cos(a1) * cos(a2); 
         ny = cos(a1) * sin(a2);
         nz = sin(a1);
         sh.normal(nx, ny, nz);
        
         sh.vertex(x, y, z, u, v);
         
      }
    }
  }
   sh.endShape(); 
  return sh;
}
