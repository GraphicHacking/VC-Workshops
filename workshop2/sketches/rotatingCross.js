var sketch = function( p ) {
 
    var deg = 0;
    p.setup = function() {
      p.createCanvas(400, 400);
    };
    var vel = 1;
    var linew = 8;  
    var dir = -3;
    var r = 0;


    p.mouseClicked = function(){
      if (r==0) r = 200;
      else r = 0;
    };
    p.draw = function() {

      p.translate(p.width / 2, p.height / 2);
      p.background(255);
      p.stroke(0, 0, 0);
      p.strokeWeight(3);
      p.circle(0,0, 2*r);
      if (deg % 9 == 0) {
        if (linew == 5 || linew == 20) dir*=-1;
        linew += dir;
      }

      
      p.stroke(255, 204, 0);
      p.strokeWeight(linew);
      p.rotate(Math.PI*deg/180);
      p.line(-200,0, 200, 0);
      p.stroke(0,0, 255);
      p.line(0, 200, 0, -200)


    
      deg +=vel;
      deg %= 360;
    };
  };
  
  p5Man.add(new p5(sketch, 'rotating_cross_id'));
  