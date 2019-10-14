var sketch = function(p){
	p.setup = function(){
		p.createCanvas(400,400);
	};
	var c = false;
	var fw = 30 , fh = 40	 , fx = 45 , fy= 20; 
	var gw = 10; 
	var v = 1, dir = 1;
	p.setGrill = function(){
		p.fill(0);
		p.noStroke();
		for ( let i = 20 ; i < 380 ; i += 2*gw){
			p.rect(20,i,360,gw); }
	};  

	p.mouseClicked = function(){
		c = !c;
	};

	p.setFigure = function(){
		
		if (c && fw < 80)
			fw++;
		else if( !c && fw > 30)
			fw--;
		p.fill(0, 0, 255);
		p.noStroke();	
		p.rect(fx,fy,fw,fh);
		p.rect(fx + 160,fy,fw,fh);
		p.fill(255, 255 , 0);
		p.noStroke();
		p.rect(fx + 80,fy,fw,fh);
		p.rect(fx + 240,fy,fw,fh);
	};

	p.setVel = function() {
		fy += dir*v;
		if (fy >= 360-fh || fy <= 20)
			dir *= -1;
 	}
	p.draw  = function(){
		p.background(255);
		p.setGrill();
		p.setVel();
		p.setFigure();
		
	};
};

p5Man.add(new p5(sketch, 'moving_rectangles_id'));