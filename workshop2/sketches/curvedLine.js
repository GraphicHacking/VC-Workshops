var sketch = function( p ) {

    var c = 40;
    var f = 30;
    p.setup = function() {
      p.createCanvas(400, 200);
      p.background(255); 
      //p.line(0,200,400,200);
      //p.strokeWeight(2);
      for ( let i = -350 ; i < 750 ; i += c){
        p.line(200,p.height/2,i,0);
        p.line(200,p.height/2,i,p.height);
      }
      p.strokeWeight(2);
      p.stroke(255,0,0);
      p.line(0,p.height/2+f,400,p.height/2+f);
      p.line(0,p.height/2-f,400,p.height/2-f);
    };
  };
  
  p5Man.add(new p5(sketch, 'curvedLine_id'));
  