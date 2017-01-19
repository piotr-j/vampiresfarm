#ifdef GL_ES
#define LOWP lowp
precision mediump float;
#else
#define LOWP
#endif

//varying LOWP vec4 v_color;
varying vec2 v_texCoords;
varying mat2 v_rot;
uniform sampler2D u_texture;
//uniform sampler2D u_diffuse;

void main() {
    vec4 normal = texture2D(u_texture, v_texCoords).rgba;
    // fix alpha, batch thing
//    float alpha = texture2D(u_diffuse, v_texCoords).a * (255.0/254.0);

    // got to translate normal vector to -1, 1 range
    vec2 rotated = v_rot * (normal.xy * 2.0 - 1.0);

    // and back to 0, 1
    rotated = (rotated.xy / 2.0 + 0.5 );
//    gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
    gl_FragColor = vec4(rotated.xy, normal.z, normal.a);
//    gl_FragColor = vec4(normal);
//    gl_FragColor = vec4(alpha);
}
