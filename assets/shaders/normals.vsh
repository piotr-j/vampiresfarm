#define DEG2RAD 0.017453292

attribute vec4 a_position;
attribute vec4 a_color;
attribute vec2 a_texCoord0;
attribute float a_rot;

uniform mat4 u_projTrans;
//varying vec4 v_color;
varying vec2 v_texCoords;
varying mat2 v_rot;

void main() {
   vec2 rad = vec2(-sin(a_rot * DEG2RAD), cos(a_rot * DEG2RAD));
   v_rot = mat2(rad.y, -rad.x, rad.x, rad.y);
//   v_color = a_color;
//   v_color.a = v_color.a * (255.0/254.0);
   v_texCoords = a_texCoord0;
   gl_Position =  u_projTrans * a_position;
}
