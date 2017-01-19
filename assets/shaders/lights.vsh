attribute vec4 vertex_positions;
attribute vec4 quad_colors;
attribute float s;

uniform mat4 u_projTrans;
varying vec4 v_lightColor;

void main() {
    // we cant just removeOnNextProcess the s, stuff gets broken for whatever reason if we do
    // perhaps we will do that if we do different attenuation
    //v_lightColor = quad_colors * (1. + s-s);
    v_lightColor = s * quad_colors;
    gl_Position =  u_projTrans * vertex_positions;
}
