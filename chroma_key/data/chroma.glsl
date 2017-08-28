// Author: Prince Polka
// Title: chroma
#ifdef GL_ES
precision mediump float;
#endif
uniform sampler2D u_tex;
uniform vec2 u_res;
uniform vec3 u_low;
uniform vec3 u_high;
uniform float u_foo;
const vec3 _024=vec3(0.0,2.0,4.0);
const vec3 zero=vec3(0.0);
const vec3 one=vec3(1.0);

float len(vec3 A){
    return length((A-(u_low+u_high)*0.5)*2./(u_high-u_low));
}

vec3 rgb2hsb(vec3 c){
    float low=min(min(c.r,c.g),c.b);
    float high=max(max(c.r,c.g),c.b);
    vec3 foo =((c-c.gbr)/(high-low)+_024)*vec3(c.b==high,c.r==high,c.g==high);
    return clamp(vec3(mod(4.0+dot(foo,one),6.0)/6.0,(high-low)/high,high),zero,one);
}

void main() {
  vec2 st = gl_FragCoord.xy/u_res;  st.y=1.0-st.y;
  vec3 col=texture(u_tex,st).rgb;
  vec3 bar=rgb2hsb(col);
  float alpha =len(bar);
  alpha-=u_foo;
  alpha/=(1.0-u_foo);
  alpha=clamp(alpha,0.0,1.0);

  gl_FragColor = vec4(col,alpha);
}
