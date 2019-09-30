/**
 * Mirror 2 
 * by Daniel Shiffman. 
 *
 * Each pixel from the video source is drawn as a rectangle with size based on brightness.  
 */
 
import processing.video.*;

int cnt = 0;
Capture video;
boolean lmn = true; 


PGraphics pg_filter;

float [][][] all_matrix = {{ { -1, -1, -1 },
                             { -1, 8 , -1 },  
                             { -1, -1, -1 } },
                           { { 0 , 1 , 0 }, 
                             { 0 , 0 , 0 }, 
                             { 0 , -1, 0 } }, 
                           { { 0 , -1, 0 }, 
                             { -1, 5, -1 }, 
                             { 0, -1, 0} }};
String mname [] = { "Edge", "Emboss" , "Sharpen"};
int currm = 0;

void setup() {
  size(1000, 500);
  // Set up columns and rows
  pg_filter = createGraphics(500, 500);
  rectMode(CENTER);

  // This the default video input, see the GettingStartedCapture 
  // example if it creates an error
  video = new Capture(this, 500, 500);
    
  // Start capturing the images from the camera
  video.start();  
  
  background(0);
}


void draw() { 
  if (video.available()) {
    image(video, 0, 0);
    if ( cnt < 2) {
      GenerateGrayScale(pg_filter,cnt==0,video,500,0);
    } else {
      int m = cnt - 2;
      GenerateFilter( pg_filter, all_matrix[m], 3,video, 500, 0);
      
    }
    println(video.frameRate);
    textSize(30);
    fill(255,69,0);
    text(frameRate,video.width/2,height - 30);
    println(frameRate);

  }
}
void mouseClicked() {
  cnt = (cnt+1) % 5;
}
void GenerateGrayScale(PGraphics pg, boolean luma, Capture vid, int px, int py) {
  if (!video.available()) return;
  pg.beginDraw();
  //pg.background(100, 50, 35);
  pg.loadPixels();
  vid.read();
  vid.loadPixels();
  for (int x = 0; x < vid.height; x++) {
    for (int y = 0; y < vid.width; y++ ) {
      int loc = x + y*vid.width;
      float r = (red(vid.pixels[loc]));
      float g =(green(vid.pixels[loc]));
      float b = (blue(vid.pixels[loc]));
      float result;
      if (luma) result = 0.2126*r+0.7152*g+0.0722*b;
      else result = (r+g+b)/3.0;
      color c = color(result);
      pg.pixels[loc] = c;
    }
  }
  
  pg.updatePixels();
  pg.textSize(30);
  pg.fill(0,0,255);
  if (luma){
    pg.text("Lumen",pg.width/2,30);
  } else { pg.text("AVG" , pg.width /2 , 30);}
  pg.endDraw();
  image(pg, px, py);
}

void GenerateFilter( PGraphics pg, float[][] matrix, int matrixsize, Capture vid, int px, int py) {
  pg.beginDraw();
  pg.background(100, 50, 35);
  vid.read();
  vid.loadPixels();
  pg.loadPixels();
  for (int x = 0; x < pg.height; x++) {
    for (int y = 0; y < pg.width; y++ ) {
      color c = convolution(x, y, matrix, matrixsize, vid);
      int loc = x + y*vid.width;
      pg.pixels[loc] = c;
    }
  }
  pg.updatePixels();
  pg.textSize(30);
  pg.fill(0,0,255);
  pg.text(mname[cnt-2],pg.width/2, 30);
  pg.endDraw();
  image(pg, px, py);
}
// References:
// https://processing.org/examples/convolution.html
color convolution(int x, int y, float[][] matrix, int matrixsize, Capture vid)
{
  vid.read();
  vid.loadPixels();
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  int offset = matrixsize / 2;
  for (int i = 0; i < matrixsize; i++) {
    for (int j= 0; j < matrixsize; j++) {
      // What pixel are we testing
      int xloc = x+i-offset;
      int yloc = y+j-offset;
      int loc = xloc + vid.width*yloc;
      // Make sure we haven't walked off our image, we could do better here
      loc = constrain(loc, 0, vid.pixels.length-1);
      // Calculate the convolution
      rtotal += (red(vid.pixels[loc]) * matrix[i][j]);
      gtotal += (green(vid.pixels[loc]) * matrix[i][j]);
      btotal += (blue(vid.pixels[loc]) * matrix[i][j]);
    }
  }
  // Make sure RGB is within range
  rtotal = constrain(rtotal, 0, 255);
  gtotal = constrain(gtotal, 0, 255);
  btotal = constrain(btotal, 0, 255);
  // Return the resulting color
  return color(rtotal, gtotal, btotal);
}
