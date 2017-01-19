#ifdef GL_ES
precision lowp float;
#define MED mediump
#else
#define MED
#endif

// we use ortho projection, our view vector is always up
const vec3 V = vec3(0., 0., 1.);

uniform sampler2D u_normals;
//uniform sampler2D u_specular;

// global settings
uniform vec2 u_resolution;
uniform float u_aspectFix;

// light settings
varying vec4 v_lightColor;
uniform vec3 u_lightPos;
uniform float u_lightIntensity;

// material settings?
//uniform float u_specShininess;
//uniform vec4 u_specColor;

// NOTE based on http://sunandblackcat.com/tipFullView.php?l=eng&topicid=30&topic=Phong-Lighting

void main() {
    // this is more or less blinn-phong reflection model
    vec2 screenPos = gl_FragCoord.xy / u_resolution.xy;
    vec3 rawNormal = texture2D(u_normals, screenPos).rgb;

    // TODO this should come from the alpha of normal map probably
//    float specIntensity = texture2D(u_specular, screenPos).r;

    // u_lightPos is already normalized to screen space
    vec3 lightDir = vec3(u_lightPos.xy - screenPos, u_lightPos.z);
    // correct for aspect ratio
    lightDir.x *= u_aspectFix;

    vec3 L = normalize(lightDir);

    // unpack normal vector from map
    vec3 N = normalize(rawNormal * 2.0 - 1.0);

    // attenuation is built in v_lightColor, it is linearly interpolated from center to edge of the light
    // perhaps we want to control that?
    // ambient light is global, added after lights are rendered
    float df = dot(N, L);
//    float sf = 0.;

    // is branch really better then doing this every time?
//    if (df > 0.) {
//        vec3 H = normalize(L + V);
//        sf = pow(dot(N, H), u_specShininess);
//    }

    df = clamp(df, 0., 1.);
    // this is light color, not final color
//    gl_FragColor = v_lightColor * df * u_lightIntensity + sf * u_specColor * specIntensity;
    gl_FragColor = v_lightColor * df * u_lightIntensity;
    //gl_FragColor.a = 1.;
}
