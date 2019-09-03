#define PROCESSING_TEXLIGHT_SHADER

uniform mat4 transform;

attribute vec4 vertex;
attribute vec2 texCoord;

varying vec4 outputTexCoord;

/////////

uniform mat4 modelview;
uniform mat3 normalMatrix;

attribute vec3 normal;

varying vec3 normalInterp;
varying vec3 vertPos;



void main(){
	gl_Position = transform*vertex;
	
	outputTexCoord.x = texCoord.x*800;
	outputTexCoord.y = texCoord.y*600;
	outputTexCoord.zw = vec2(1.0, 1.0);
}
