/**
 * Game Life in shader
 * @author Gimeron
 * 
 * Click the R or T buttons to reset world, and click space to pause.
 * 
 * You can load your custom world from file. Just put image in sketch directory before run.
 * Press W for reload world from file.
 */
 
int WINDOW_WIDTH = 1920;
int WINDOW_HEIGHT = 1080;
boolean FULLSCREEN_MODE = false;
// Custom world file
String WORLD_FILENAME = ""; // "custom_world.png";

String[] shaders = new String[] {"life.glsl"};

PShader shade;
PImage imgLife;

boolean Pause = false;


void settings() {
  if (FULLSCREEN_MODE) {
    fullScreen(P2D);
  } else {
    size(WINDOW_WIDTH, WINDOW_HEIGHT, P2D);
  }
}


void setup() {

  // create world
  if (WORLD_FILENAME == "") {
    imgLife = createImage(width, height, RGB);
    imgLife.loadPixels();
    for (int idxPix = 0; idxPix < imgLife.width * imgLife.height; idxPix++) {
      int c = (random(2) > 1.9) ? 255 : 0;
      imgLife.pixels[idxPix] = color(c, c, c);
    }
    imgLife.updatePixels();
  } else {
    imgLife = loadImage(WORLD_FILENAME);
  }
  
  shade = loadShader(shaders[0]);
}


void draw() {
  
  background(0);
  // turn on shader and load world
  shader(shade);
  image(imgLife, 0, 0, width, height);
  
  // turn off shader and get next generation
  resetShader();
  
  loadPixels();
  imgLife.loadPixels();
  imgLife.pixels = pixels;
  imgLife.updatePixels();
  
  println(frameRate);
}


void keyPressed() {
  if        (keyCode=='R') {
    // reset world b/w
    imgLife.loadPixels();
    for (int idxPix = 0; idxPix < imgLife.width * imgLife.height; idxPix++) {
      int c = (random(2) > 1.0) ? 255 : 0;
      imgLife.pixels[idxPix] = color(c, c, c  );
    }
    imgLife.updatePixels();
    
  } else if (keyCode=='C') {
    // reset world color
    /*
    imgLife.loadPixels();
    for (int idxPix = 0; idxPix < imgLife.width * imgLife.height; idxPix++) {
      int r = (random(2) > 1.0) ? 255 : 0;
      int g = (random(2) > 1.0) ? 255 : 0;
      int b = (random(2) > 1.0) ? 255 : 0;
      imgLife.pixels[idxPix] = color(r, g, b);
    }
    imgLife.updatePixels();
    */
    
  } else if (keyCode=='T') {
    // reset world empty
    imgLife.loadPixels();
    for (int idxPix = 0; idxPix < imgLife.width * imgLife.height; idxPix++) {
      int c = (random(2) > 1.9) ? 255 : 0;
      imgLife.pixels[idxPix] = color(c, c, c);
    }
    imgLife.updatePixels();
    
  } else if (keyCode=='E') {
    // reset world empty
    imgLife.loadPixels();
    for (int idxPix = 0; idxPix < imgLife.width * imgLife.height; idxPix++) {
      imgLife.pixels[idxPix] = color(0, 0, 0);
    }
    imgLife.updatePixels();
    
  } else if (keyCode=='W') {
    // reload world from file
    if (WORLD_FILENAME != "") {
      imgLife = loadImage(WORLD_FILENAME);
    }
    
  } else if (keyCode==' ') {
    if (Pause) {
      Pause = false;
      loop();
    } else {
      Pause = true;
      noLoop();
    }
  }
}
