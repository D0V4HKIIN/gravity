class Circle{
  float x,y,r;
  float xv,yv,xa,ya;
  int ind;
  int clrr,clrb,clrg;
  
  float[][] trail = new float[10][2];
  
  Circle(int r,int i){
    this.r = r;
    this.x = random(r,width-r);
    this.y = random(r,height-r);
    this.xv = random(0.5);
    this.yv = random(0.5);
    this.ind = i;
    
    this.clrr = (int)random(255);
    this.clrb = (int)random(255);
    this.clrg = (int)random(255);
    
    for(int l = 0;l<trail.length;l++){
      trail[l][0] = x;
      trail[l][1] = y;
    }
  }
  void update(){
    
    
    //x pos
    xa = (mouseX-x)/1000;
    xv += xa;
    x += xv+xa;  
    if(x-r/2 < 0){
      xv *= -1;
      x = r/2;
    }
    if(x+r/2 > width){
      xv *= -1;
      x = width-r/2;
    }
    
    //y pos
    ya = (mouseY-y)/1000;
    yv += ya; 
    y += yv+ya;   
    if(y-r/2 < 0){
      yv *= -1;
      y = r/2;
    }
    if(y+r/2 > height){
      yv *= -1;
      y = height-r/2;
    }
    
    float d,nx,ny,p;
    for(int i = 0;i<ball.length;i++){
      d = dist(x,y,ball[i].x,ball[i].y);
      if(ind != ball[i].ind && d < r){
        nx = (ball[i].x-x)/d;
        ny = (ball[i].y-y)/d;
        p = xv*nx+yv*ny-ball[i].xv*nx-ball[i].yv*ny;
        xv = xv - p * nx;
        yv = yv - p * ny;
        ball[i].xv = ball[i].xv + p * nx;
        ball[i].yv = ball[i].yv + p * ny;
        x += xv;
        y += yv;
        ball[i].x += ball[i].xv;
        ball[i].y += ball[i].yv;
      }
    }
    
    
    
    fill(255);
    ellipse(x,y,r,r);
    
    for(int j = trail.length-2;j>-1;j--){
      trail[j+1][0] = trail[j][0];
      trail[j+1][1] = trail[j][1];
    }
    trail[0][0] = x;
    trail[0][1] = y;
    strokeWeight(4);
    for(int i = 0;i<trail.length-1;i++){
      stroke(255,0,0);
      line(trail[i][0],trail[i][1],trail[i+1][0],trail[i+1][1]);
    }
  }
}


Circle[] ball;
void setup(){
  //fullScreen();
  size(900,900);
  frameRate(30);
  ball = new Circle[20];
  for(int i = 0;i<ball.length;i++){
    ball[i] = new Circle(50,i);
  }
}

void draw(){
  background(0);
  for(int i = 0;i<ball.length;i++){
    ball[i].update();
  }
}
