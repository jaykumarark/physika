#version 330

//In variables
in vec3 VertexPosition; 
in vec3 VertexNormal;
in vec2 VertexTexture; 
in vec3 VertexColor;


//Out Variables
out vec2 texcoord0;
out vec3 normal0 ;
out vec4 color0;


//Matrices
uniform mat4 ModelViewMatrix;
uniform mat4 ProjectionMatrix; 
uniform mat4 NormalMatrix;
uniform mat4 mvp;

uniform vec4 lightPosition;
uniform vec3 kd; 
uniform vec3 ld; 

void main()
{
	vec3 tnorm = vec3(NormalMatrix * vec4(VertexNormal,0));
	vec4 eyeCoords = ModelViewMatrix * vec4(VertexPosition, 1.0);
	vec3 s = normalize( vec3(lightPosition - eyeCoords));
	vec3 r = reflect(-s, tnorm);
	vec3 v = normalize(-eyeCoords.xyz);
	//ambient material
	vec3 la = vec3(0.2, .2, .2);
	vec3 ka = vec3(1.0, 1.0, 1);

	//specular
	vec3 ls = vec3(1.0, 1.0, 1.0);
	vec3 ks = vec3(0.5, 0.5, 0.5);
	float shininess = 32;

	vec3 spec = vec3(0);

	float sdotn = max(dot(s, tnorm), 0.0);

	vec3 diffuseTerm = ld * kd * sdotn;

	vec3 ambientTerm = la*ka;

	if(sdotn > 0.0)
		spec = ls * ks * pow(max(dot(r,v), 0.0),shininess); 

	color0		=	vec4(diffuseTerm+ambientTerm+spec, 1.f);
	texcoord0	=	VertexTexture;
	gl_Position =	mvp * vec4(VertexPosition, 1.0f);


}