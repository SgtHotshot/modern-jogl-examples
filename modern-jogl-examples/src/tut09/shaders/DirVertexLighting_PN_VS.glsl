#version 330

layout(location = 0) in vec3 position;
layout(location = 2) in vec3 normal;

smooth out vec4 interpColor;

uniform vec3 dirToLight;
uniform vec4 lightIntensity;

uniform mat4 modelToCameraMatrix;
uniform mat3 normalModelToCameraMatrix;

layout(std140) uniform Projection
{
    mat4 cameraToClipMatrix;
};

void main()
{
    gl_Position = cameraToClipMatrix * (modelToCameraMatrix * vec4(position, 1.0));

    vec3 normCamSpace = normalize(normalModelToCameraMatrix * normal);

    float cosIncidenceAngle = dot(normCamSpace, dirToLight);
    
    cosIncidenceAngle = clamp(cosIncidenceAngle, 0, 1);

    interpColor = lightIntensity * cosIncidenceAngle;
}