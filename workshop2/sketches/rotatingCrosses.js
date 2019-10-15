var sketch = function( p ) {
 
    var deg = 0;
    var x = [], y =[];
    p.setup = function() {
      p.createCanvas(400, 400);
      for ( var i=-160; i<160; i+=30) {
        x.push(i);
        x.push(i+20);
      }
    };
    var vel = 1;
    var flag = false;
    p.draw = function() {
      if (deg%5 == 0) flag = !flag; 
      p.background(255);
      p.translate(p.width / 2, p.height / 2);
      p.push();
      p.strokeWeight(3);
      p.stroke(0, 255, 0);
     
      p.rotate(Math.PI*deg/180);
      for (var i=-150; i<=150; i+=30) {
        for (var j=0; j<x.length; j+=2 ){
            p.line(x[j],i, x[j+1], i);
            p.line(i, x[j], i, x[j+1]);
        }
      }
      p.pop();

      p.strokeWeight(6);

      p.stroke(0, 0, 255);
      p.line(-80, 80,-80, 80);
      p.line(109, 30,109, 30);
      p.line(-30, -109,-30, -109);

      p.stroke(255, 0, 0);
      if (flag)  p.line(0, 0, 0, 0);

      deg +=vel;
    };
  };
  
  p5Man.add(new p5(sketch, 'rotating_crosses_id'));
  