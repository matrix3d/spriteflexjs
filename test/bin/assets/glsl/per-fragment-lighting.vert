attribute vec3 aVertexPosition;
attribute vec3 aVertexNormal;
attribute vec2 aTextureCoord;

uniform mat4 uMMatrix;
uniform mat4 uVMatrix;
uniform mat4 uPMatrix;

varying vec2 vTextureCoord;
varying vec3 vTransformedNormal;
varying vec4 vPosition;


void main(void) {
	gl_Position = uPMatrix*uVMatrix*uMMatrix * vec4(aVertexPosition, 1.0);
	vTextureCoord = aTextureCoord;
	vTransformedNormal =mat3(uVMatrix)* mat3(uMMatrix) * aVertexNormal;
}