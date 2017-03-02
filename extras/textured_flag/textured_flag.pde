// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/jrk_lOg_pVA

import toxi.physics3d.*;
import toxi.physics3d.behaviors.*;
import toxi.physics3d.constraints.*;
import toxi.geom.*;

float zoff = 0.0;

int cols = 80;
int rows = 40;

Particle[][] particles = new Particle[cols][rows];
ArrayList<Spring> springs;

float w = 8;

PImage flag;

VerletPhysics3D physics;

void setup() {
  size(800, 600, P3D); 
  springs = new ArrayList<Spring>();
  flag = loadImage("cat.jpg");

  physics = new VerletPhysics3D();
  Vec3D gravity = new Vec3D(0, 0.05, 0);
  GravityBehavior3D gb = new GravityBehavior3D(gravity);
  physics.addBehavior(gb);

  float x = -cols*w/2;
  for (int i = 0; i < cols; i++) {
    float y = -rows*w/2;
    for (int j = 0; j < rows; j++) {
      Particle p = new Particle(x, y, 0);
      particles[i][j] = p;
      physics.addParticle(p);
      y = y + w;
    }
    x = x + w;
  }

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      Particle a = particles[i][j];
      if (i != cols-1) {
        Particle b1 = particles[i+1][j];
        Spring s1 = new Spring(a, b1);
        springs.add(s1);
        physics.addSpring(s1);
      }
      if (j != rows-1) {
        Particle b2 = particles[i][j+1];
        Spring s2 = new Spring(a, b2);
        springs.add(s2);
        physics.addSpring(s2);
      }
    }
  }

  particles[0][0].lock();
  particles[0][rows-1].lock();
}
float a = 0;

void draw() {
  background(51);
  translate(width/2, height/2);
  //rotateY(a);
  //a += 0.01;
  physics.update();

  strokeWeight(4);
  stroke(255);
  line(-cols*w/2, -rows*w/2, -cols*w/2, rows*w);

  stroke(255);
  noStroke();
  noFill();
  float yoff = 0;
  for (int j = 0; j < rows-1; j++) {
    beginShape(TRIANGLE_STRIP);
    texture(flag);
    float xoff = 0;
    for (int i = 0; i < cols; i++) {
      float u = map(i, 0, cols, 0, flag.width);
      float v = map(j, 0, rows, 0, flag.height);
      Particle p1= particles[i][j];
      vertex(p1.x, p1.y, p1.z, u, v);
      Particle p2= particles[i][j+1];
      v = map(j+1, 0, rows, 0, flag.height);
      vertex(p2.x, p2.y, p2.z, u, v);
      //particles[i][j].display();

      float wx = map(noise(xoff, yoff, zoff), 0, 1, -0.1, 1);
      float wy = map(noise(xoff+5000, yoff+5000, zoff), 0, 1, -0.1, 0.1);
      float wz = map(noise(xoff+10000, yoff+10000, zoff), 0, 1, -0.1, 0.1);
      Vec3D wind = new Vec3D(wx,wy,wz);
      p1.addForce(wind);
      xoff += 0.1;
    }
    yoff += 0.1;
    endShape();
  }

  //for (Spring s : springs) {
  //  s.display();
  //}
  zoff += 0.1;
}