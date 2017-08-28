PShader chroma;
PImage guy;
PImage beach;
void setup(){
 size(1080,720,P2D);
 chroma = loadShader("chroma.glsl");
 chroma.set("u_res",(float)width,(float)height);
 beach=loadImage("beach.jpg");
 guy=loadImage("guy.jpg");
 chroma.set("u_tex",guy);
}

void draw(){
  resetShader();
  image(beach,0,0);
  shader(chroma);
  
  float HUE,SAT,BRI,
        HUE_range,SAT_range,BRI_range,
        yikes;
  // hsb values
  HUE=0.39;  SAT=0.80;  BRI=0.90;
  //hsb tolerances
  HUE_range=0.10;  SAT_range=0.60;  BRI_range=1.80;
  //experiment
  yikes=0.47;
  
  chroma.set("u_low",HUE-HUE_range,SAT-SAT_range,BRI-BRI_range);
  chroma.set("u_high",HUE+HUE_range,SAT+SAT_range,BRI+BRI_range);
  chroma.set("u_foo",yikes);
  rect(0,0,width,height);
}