var sketch = function( p ) {
 
  
    p.setup = function() {
      p.createCanvas(400, 400);
    };

    p.draw = function() {
      
      p.background(255);
      
      p.push();
      p.stroke(255, 204, 0);
      p.rotate(PI / 3.0);
      p.line(0,300, 400, 300);
      p.pop();
      p.stroke(0,0, 255);
      p.line(300, 0, 300, 400)
    };
  };
  
  p5Man.add(new p5(sketch, 'rotating_crosses_id'));
  