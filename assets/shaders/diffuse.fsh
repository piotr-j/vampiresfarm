#ifdef GL_ES
precision lowp float;
#define MED mediump
#else
#define MED 
#endif

varying MED vec2 v_texCoords;
uniform sampler2D u_texture;
uniform sampler2D u_normals;
uniform vec4 ambient;
uniform vec3 u_lightDir;
uniform vec4 u_lightColor;
uniform float u_intensity;

void main() {
    vec3 L = normalize(u_lightDir);
    vec3 rawNormal = texture2D(u_normals, v_texCoords).rgb;
    vec3 N = normalize(rawNormal * 2.0 - 1.0);
    float df = max(dot(N, L), 0.);
    vec3 lights = texture2D(u_texture, v_texCoords).rgb;
    // now this is more or less full blinn-phong reflection model
    // do we want to normalize stuff or max or something?
    gl_FragColor.rgb = ambient.rgb + u_lightColor.rgb * df * u_intensity + lights;
    gl_FragColor.a = 1.0;
}
