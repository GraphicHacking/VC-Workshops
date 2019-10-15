var sketch = function( p ) {
    var nlines = [2,4,8,10,16,20,25];
    var sep,c = 4;
    p.setup = function() {
      p.createCanvas(400, 400);
      console.log(sep + p.height);
    };
    p.draw = function(){
        p.background(255); 
        p.strokeWeight(1);
        p.line(0,p.height/2,p.width,p.height/2);
        p.line(p.width/2,0,p.width/2,p.height);
        p.drawLines();
        p.strokeWeight(7);
        p.line(20,p.height-20,40,p.height-20);
        p.line(p.width-30,p.height-30,p.width-30,p.height-10);
        p.line(p.width-20,p.height-20,p.width - 40,p.height-20);
    };
    p.drawLines = function(){
        sep = p.height/2/nlines[c];
        for ( let i = 0 ; i < p.width/2 ; i += sep){
            p.line(i,p.height/2,p.width/2,p.height/2 - i );
            p.line(p.width/2 + i,p.height/2,p.width/2,i);
            p.line(p.width/2 + i,p.height/2,p.width/2,p.width - i);
            p.line(p.height/2-i,p.height/2,p.width/2,p.width - i);
        }
    };
    p.mouseClicked = function() {
        if ( p.mouseX > p.width/2 && c < nlines.length -1){
            console.log("more");
            c ++;
        }
        else if ( p.mouseX <  p.width/2 && c > 0){
            c --;
            console.log("less");
        }
    };
  };
  
  p5Man.add(new p5(sketch, 'depthLines_id'));
  