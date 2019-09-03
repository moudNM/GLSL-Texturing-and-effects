#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXLIGHT_SHADER

uniform sampler2D texture;

varying vec4 outputTexCoord;

/////

varying vec3 normalInterp;
varying vec3 vertPos;

uniform float time;
uniform vec2 resolution;

uniform int lightCount;
uniform vec4 lightPosition[8];

float random (vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(time * 12.9898,78.233)))*
                 43758.5453123);
}

void main() {

    float lightR = 0.0;
    float lightG = 0.0;
    float lightB = 0.0;
    
    vec4 scales = texture2D(texture, outputTexCoord.xy);
    
    for (int i = 0; i < lightCount; i++)
    {
        vec3 normal = normalize(normalInterp);
        vec3 lightDir = normalize(lightPosition[i].xyz - vertPos);
        
        //diffuse– output is between 0 to 1.0
        float diffuse = max(dot(lightDir,normal), 0.0);
        
        //restrict to 4 tones
        if(diffuse>0.95){
              diffuse = 1.2;
        }else if (diffuse>0.75){
            diffuse = 0.9;
        }else if (diffuse > 0.35){
            diffuse = 0.7;
        }else if (diffuse > 0.1){
            diffuse = 0.5;
        }else{
            diffuse = 0.3;
        }

        vec3 colorLinear = diffuse * scales.xyz;

        lightR += colorLinear.x;
        lightG += colorLinear.y;
        lightB += colorLinear.z;
        
        vec2 st = outputTexCoord.xy/lightPosition[i].xy;
        float rnd = random(st);
        lightR *= rnd;
        lightG *= rnd;
        lightB *= rnd;
        
    }
    
    gl_FragColor = vec4(vec3(lightR,lightG,lightB),1.0);
}

