var sketch = function( p ) {

    var flag = 0 ,xi = 85 , yi = 85, ang = 60, r = 80 , dir = 1 , c = 10 , v = 5;
    var x , y  ; 
  
    p.setup = function() {
      p.createCanvas(400, 400);
    };
    p.setCircles = function(){
      p.fill(226,164,245);
      p.noStroke();
      p.ellipse(xi,yi,55,55);
      if ( flag == 1 ) {p.noFill();}
      for ( let i = 0 ; i < 360 ; i += ang){
        x = r * Math.cos(2*Math.PI*i/360) + xi;
        y = r * Math.sin(2*Math.PI*i/360) + yi; 
        p.ellipse(x,y,c,c);
      }
    };
    p.mousePressed = function(){ //p.noLoop();
      flag = 1;
    };
    p.mouseReleased = function(){ //p.loop();
      flag = 0; 
    };
    p.draw = function() {
      p.background(204);
      p.setCircles();
      xi += dir * v;
      yi += dir * v ; 
      c += 2 * dir; 
      if (xi > p.width - r || xi < r ){
        dir = dir * -1; 
      } 
    };
  };
  
  p5Man.add(new p5(sketch, 'motionCircles_id'));
  