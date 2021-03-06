#pragma once

#include <GL/glew.h>
#include <vector>
#include <glm\glm.hpp>
#include "image.h"
#include "ACamera.h"
#include "Light.h"
#include "VertexBufferObject.h"
#include "ModelLoader.h"
#include "texture.h"

class PlaneGrid
{
	struct Material
	{
		glm::vec3 Ka;
		glm::vec3 Kd;
		glm::vec3 Ks;
	};

	/*
	 for terrains with height maps already presented
	 use the image width and height as dimension for the 
	 terrain
	*/

public:
	PlaneGrid(glm::vec3 pos, 
		int cs,
		int side, 
		std::string textureFile,
		std::string vertexFile, 
		std::string fragmentFile,
		glm::vec3 a, 
		glm::vec3 d,
		glm::vec3 s);
	~PlaneGrid(void);
	void init();
	void initGrid();
	void setMaterial(glm::vec3 a, glm::vec3 d, glm::vec3  s);
	void render(ACamera* cam, Light* light);

private:
	int mW, mH, m_cs, m_elevation;
	glm::vec3 m_pos; 
	glm::mat4 m_model;
	Image* m_Heightmap; 
	Texture* mTex; 
	GLSLShader* m_shader;
	VertexBufferObject* m_vbo;
	Material m_material;


};

