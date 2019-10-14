var sketch = function(p){
	p.setup = function(){
		p.createCanvas(400,400);
	};
	var c = 0;
	var fw = 120 , fh = 360 , fx = 60 , fy= 20; 
	var gw = 20; 

	p.setGrill = function(){
		p.fill(c);
		p.noStroke();
		for ( let i = 20 ; i < 380 ; i += 40){
			p.rect(20,i,360,gw); }
	};  

	p.mouseClicked = function(){
		if (c == 0) c = 255; 
		else c = 0;
	};

	p.setFigure = function(){
		p.fill(226, 164, 245);
		p.noStroke();
		p.rect(fx,fy,fw,fh);
		p.rect(fx + 160,fy,fw,fh);
		if ( c == 0)
		for ( let i = fy ; i < fy + fh ; i += 40){
			p.fill(0);
			p.rect(fx,i,fw,20);
			p.fill(255);
			p.rect(fx+160,i+20,fw,20); 
		};
	};

	p.draw  = function(){
		p.background(255);
		p.setGrill();
		p.setFigure();
	};
};

p5Man.add(new p5(sketch, 'mysketch_id'));