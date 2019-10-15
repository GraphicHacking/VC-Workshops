var sketch = function( p ) {

    var angle = 0, PI = 3.14159265358979323846, HALF_PI = 1.57079632679489661923;
    p.setup = function() {
        p.createCanvas(400, 400);

        
    };

    p.draw = function() {
        p.background(220);

        //First
        p.fill(255, 0, 0);
        p.stroke('gray');
        p.strokeWeight(2);
         

        p.push();
        p.translate(50, 150);
        p.rotate(HALF_PI + angle);
        p.arc(0, 0, 80, 80, PI, HALF_PI);  
        p.pop();

        p.push();
        p.strokeWeight(2);
        p.translate(150, 150);
        p.rotate(HALF_PI * 2 - angle);
        p.arc(0, 0, 80, 80, PI, HALF_PI);
        p.pop();

        p.push();
        p.strokeWeight(2);
        p.translate(150, 250);
        p.rotate(HALF_PI * 3 + angle);
        p.arc(0, 0, 80, 80, PI, HALF_PI);
        p.pop();

        p.push();
        p.strokeWeight(2);
        p.translate(50, 250);
        p.rotate(HALF_PI * 4 - angle);
        p.arc(0, 0, 80, 80, PI, HALF_PI);
        p.pop();


        //Second
        p.fill(0, 0, 255);
        p.stroke('gray');
        p.strokeWeight(2);

        p.push();
        p.strokeWeight(2);
        p.translate(250, 150);
        p.rotate(HALF_PI * 3 - angle);
        p.arc(0, 0, 80, 80, PI, HALF_PI);
        p.pop();

        p.push();
        p.strokeWeight(2);
        p.translate(350, 150);
        p.rotate(HALF_PI * 4 + angle);
        p.arc(0, 0, 80, 80, PI, HALF_PI);
        p.pop();

        p.push();
        p.strokeWeight(2);
        p.translate(250, 250);
        p.rotate(HALF_PI * 2 + angle);
        p.arc(0, 0, 80, 80, PI, HALF_PI);
        p.pop();

        p.push();
        p.strokeWeight(2);
        p.translate(350, 250);
        p.rotate(HALF_PI - angle);
        p.arc(0, 0, 80, 80, PI, HALF_PI);
        p.pop();

        angle += 0.005;
    };
  };
  
  p5Man.add(new p5(sketch, 'rotatingCircles_id'));