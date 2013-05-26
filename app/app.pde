/**
 * App Sample
 */
 
void setup() {
  //size(screen.width, screen.height, P3D); // for 3D

  size(screen.width, screen.height);
  noStroke();
  background(0);
}

void draw() {
  /*
  // test 3D
  pushMatrix();
    translate(width/2, height/2, 10);
    fill(0, 128, 0, 32);
    rect(-100, -100, 200, 200);
    fill(0, 255, 0);
    rotateY(radians(frameCount));
    box(100);
  popMatrix();
  */

  fill(255);
  rect(0, height-60, width, 60);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(16);
  text("SubView", width/2, height-40);
}

void mouseDragged() {
  fill(random(255), random(255), random(255));
  ellipse(mouseX, mouseY, 100, 100);
}

void mouseReleased() {
  if(mouseY >= height-60) {
    nativeAPI_showSubView();
  }
}

