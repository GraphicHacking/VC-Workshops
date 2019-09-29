PImage photo;


PGraphics pg_edge, pg_sharpen, pg_emboss, pg_luma, pg_avg, pg_hist ;

float[][] matrix_edge = { { -1, -1, -1 }, 
  { -1, 8, -1 }, 
  { -1, -1, -1 } }; 
float[][] matrix_emboss = { { 0, 1, 0 }, 
  { 0, 0, 0 }, 
  { 0, -1, 0} };
float[][] matrix_sharpen = { { 0, -1, 0 }, 
  { -1, 5, -1 }, 
  { 0, -1, 0} };                     

float [][] selected_matrix = matrix_edge;

int hist[] = new int[256];
int fr = -1, to = -1;
void setup() {
  size(960, 480);
  pg_edge = createGraphics(240, 240);
  pg_sharpen = createGraphics(240, 240);
  pg_emboss = createGraphics(240, 240);
  pg_luma = createGraphics(240, 240);
  pg_hist = createGraphics(500, 240);
  pg_avg = createGraphics(240, 240);
  photo = loadImage("img/girl.jpg");
}
int n  = 0 ;
boolean lmn = true; 
void draw() {
  loadPixels();
  background(0,0,0);
  image(photo, 0, 0);
  if (n == 0) {
    for (int i=0; i <240; i++) {
      for (int j=0; j <240; j++) {
        //print(pixels[i*240+j] + ",");
      }
    }
  }
  InitHistogram(lmn, photo);
  GenerateFilter(pg_edge, matrix_edge, 3, photo, 240, 0);
  // GenerateFilter(pg_sharpen, matrix_sharpen, 3, photo, 0, 240);
  // GenerateFilter(pg_emboss, matrix_emboss, 3, photo, 240, 240);
  GenerateGrayScale(pg_luma, lmn, photo, 480, 0);
  // GenerateGrayScale(pg_avg,false,photo,480,240);
  DrawHistogram(pg_hist, 0, 240);  
  n++;
}

void InitHistogram(boolean luma, PImage img) {
  for (int x = 0; x < img.height; x++) {
    for (int y = 0; y < img.width; y++ ) {
      int loc = x + y*img.width;
      float r = (red(img.pixels[loc]));
      float g =(green(img.pixels[loc]));
      float b = (blue(img.pixels[loc]));
      float result;
      if (luma) result = 0.2126*r+0.7152*g+0.0722*b;
      else result = (r+g+b)/3.0;
      hist[(int)result]++;
    }
  }
}



void GenerateGrayScale(PGraphics pg, boolean luma, PImage img, int px, int py) {
  pg.beginDraw();
  //pg.background(100, 50, 35);
  pg.loadPixels();
  for (int x = 0; x < pg.height; x++) {
    for (int y = 0; y < pg.width; y++ ) {
      int loc = x + y*img.width;
      float r = (red(img.pixels[loc]));
      float g =(green(img.pixels[loc]));
      float b = (blue(img.pixels[loc]));
      float result;
      if (luma) result = 0.2126*r+0.7152*g+0.0722*b;
      else result = (r+g+b)/3.0;
      color c = color(result);
      if ((result > to   || result < fr ) && (rangemax != -10 && rangemin != -10)) c = color(0,0,0);
      pg.pixels[loc] = c;
    }
  }
  pg.updatePixels();
  pg.endDraw();
  image(pg, px, py);
}
int clk = 0;
int rangemin = -10;
int rangemax = -10;
void mouseClicked() {
  if(mouseX > hist0 && mouseX < hist2 && mouseY > hist1 && mouseY < hist3){
    if (clk == 0) {
      clk =1; 
      rangemin = mouseX;
    } else if (clk == 1) {
      clk = 2; 
      rangemax = mouseX;
      if(rangemin > rangemax){ 
        int tmp = rangemin ; 
        rangemin = rangemax;
        rangemax = tmp;
      }
      fr = int(map(rangemin, hist0, hist2, 0, 255));
      to = int(map(rangemax, hist0, hist2, 0, 255));
      print (rangemax + "  " + rangemin);
    } else {
      rangemin = -10;
      rangemax = -10;
      clk = 0;
    }
  }else{
    lmn = !lmn; 
    print (lmn);
  }
}
int hist0;
int hist1; 
int hist2;
int hist3;
void DrawHistogram(PGraphics pg, int px, int py) {
  pg.beginDraw();
  pg.background(100, 50, 30);
  int histMax = max(hist);
  hist0 = px;
  hist1 = py;
  hist2 = px + pg.width; 
  hist3 = py + pg.height; 
  pg.stroke(255);
  // Draw half of the histogram (skip every second value)
  for (int i = 0; i < pg.width; i ++) {
    // Map i (from 0..img.width) to a location in the histogram (0..255)
    int which = int(map(i, 0, pg.width, 0, 255));
    // Convert the histogram value to a location between 
    // the bottom and the top of the picture
    int y = int(map(hist[which], 0, histMax, pg.height, 0));
    if (i < rangemax && i > rangemin ) pg.stroke(20,75,200);
    else pg.stroke (255); 
    pg.line(i, pg.height, i, y);
  }
  pg.endDraw();
  image(pg, px, py); 
  strokeWeight(15); 
  stroke(255, 127, 80);
  point(rangemin, 450);
  stroke(20,75,200);
  point(rangemax, 450);
}

void GenerateFilter( PGraphics pg, float[][] matrix, int matrixsize, PImage img, int px, int py) {
  pg.beginDraw();
  pg.background(100, 50, 35);

  pg.loadPixels();
  for (int x = 0; x < pg.height; x++) {
    for (int y = 0; y < pg.width; y++ ) {
      color c = convolution(x, y, matrix, matrixsize, img);
      int loc = x + y*img.width;
      pg.pixels[loc] = c;
    }
  }
  pg.updatePixels();
  pg.endDraw();
  image(pg, px, py);
}


color convolution(int x, int y, float[][] matrix, int matrixsize, PImage img)
{
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  int offset = matrixsize / 2;
  for (int i = 0; i < matrixsize; i++) {
    for (int j= 0; j < matrixsize; j++) {
      // What pixel are we testing
      int xloc = x+i-offset;
      int yloc = y+j-offset;
      int loc = xloc + img.width*yloc;
      // Make sure we haven't walked off our image, we could do better here
      loc = constrain(loc, 0, img.pixels.length-1);
      // Calculate the convolution
      rtotal += (red(img.pixels[loc]) * matrix[i][j]);
      gtotal += (green(img.pixels[loc]) * matrix[i][j]);
      btotal += (blue(img.pixels[loc]) * matrix[i][j]);
    }
  }
  // Make sure RGB is within range
  rtotal = constrain(rtotal, 0, 255);
  gtotal = constrain(gtotal, 0, 255);
  btotal = constrain(btotal, 0, 255);
  // Return the resulting color
  return color(rtotal, gtotal, btotal);
}
