PImage photo;

  
PGraphics pg_edge, pg_sharpen, pg_emboss, pg_luma, pg_avg ;

float[][] matrix_edge = { { -1, -1, -1 },
                     { -1, 8, -1 },
                     { -1, -1, -1 } }; 
float[][] matrix_emboss = { { 0, 1, 0 },
                     { 0,  0, 0 },
                     { 0, -1, 0} };
float[][] matrix_sharpen = { { 0, -1, 0 },
                     { -1,  5, -1 },
                     { 0, -1, 0} };                     
                     
float [][] selected_matrix = matrix_edge;
void setup() {
  size(960, 480);
  pg_edge = createGraphics(240, 240);
  pg_sharpen = createGraphics(240, 240);
  pg_emboss = createGraphics(240, 240);
  pg_luma = createGraphics(240,240);
  pg_avg = createGraphics(240,240);
  photo = loadImage("img/girl.jpg");
  
}
int n  = 0 ;
void draw() {
  image(photo, 0, 0);
  loadPixels();
  if (n == 0) {
    for (int i=0; i <240; i++) {
     for (int j=0; j <240; j++) {
       print(pixels[i*240+j] + ",");
     }
    }
  }
  GenerateFilter(pg_edge, matrix_edge, 3, photo, 240, 0);
  GenerateFilter(pg_sharpen, matrix_sharpen, 3, photo, 0, 240);
  GenerateFilter(pg_emboss, matrix_emboss, 3, photo, 240, 240);
  GenerateGrayScale(pg_luma,true,photo,480,0);
  GenerateGrayScale(pg_avg,false,photo,480,240);
  n++; 
}


void GenerateGrayScale(PGraphics pg, boolean luma, PImage img, int px, int py){
  pg.beginDraw();
  pg.background(100,50,35);
  
  pg.loadPixels();
  for (int x = 0; x < pg.height; x++) {
    for (int y = 0; y < pg.width; y++ ) {
      int loc = x + y*img.width;
      float r = (red(img.pixels[loc]));
      float g =(green(img.pixels[loc]));
      float b = (blue(img.pixels[loc]));
      color c;
      if (luma) c = color(0.2126*r+0.7152*g+0.0722*b);
      else c = color((r+g+b)/3.0);
      pg.pixels[loc] = c;
    }
  }
  pg.updatePixels();
  pg.endDraw();
  image(pg, px, py);  
}

void GenerateFilter( PGraphics pg, float[][] matrix, int matrixsize, PImage img, int px, int py){
  pg.beginDraw();
  pg.background(100,50,35);
  
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
  for (int i = 0; i < matrixsize; i++){
    for (int j= 0; j < matrixsize; j++){
      // What pixel are we testing
      int xloc = x+i-offset;
      int yloc = y+j-offset;
      int loc = xloc + img.width*yloc;
      // Make sure we haven't walked off our image, we could do better here
      loc = constrain(loc,0,img.pixels.length-1);
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
/*
void DrawHistogram(int[] hist) {
  int histMax = max(hist);

  stroke(255);
  // Draw half of the histogram (skip every second value)
  for (int i = 0; i < img.width; i += 2) {
    // Map i (from 0..img.width) to a location in the histogram (0..255)
    int which = int(map(i, 0, img.width, 0, 255));
    // Convert the histogram value to a location between 
    // the bottom and the top of the picture
    int y = int(map(hist[which], 0, histMax, img.height, 0));
    line(i, img.height, i, y);
  }
}*/
