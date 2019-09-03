#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXLIGHT_SHADER

uniform sampler2D texture;

varying vec4 outputTexCoord;


void main() {

    
    gl_FragColor = texture2D(texture, outputTexCoord.xy);
    
}

