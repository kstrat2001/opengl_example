//
//  Sphere.m
//  GLKitTest
//
//  Created by Kain Osterholt on 6/3/15.
//  Copyright (c) 2015 Kain Osterholt. All rights reserved.
//

#import "Sphere.h"
#import "Util.h"

#include <string>
#include <vector>
#include <iostream>

#include "tiny_obj_loader.h"

@implementation Sphere

-(id) init
{
    self = [super init];
    if( self != nil )
    {
        _vbo = 0;
        _ibo = 0;
        
        _texInfo = nil;
    }
    
    return self;
}

-(void) load
{
    [super load];
    
    [self loadModel];
    
    glGenBuffers(1, &_vbo);
    glBindBuffer(GL_ARRAY_BUFFER, _vbo);
    glBufferData(GL_ARRAY_BUFFER,
                 _vtxArray.GetBufferSize(),
                 _vtxArray.GetBufferPtr(),
                 GL_STATIC_DRAW);
    
    glGenBuffers(1, &_ibo);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _ibo);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER,
                 _idxArray.GetBufferSize(),
                 _idxArray.GetBufferPtr(),
                 GL_STATIC_DRAW);
    
    // Unbind resources
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
}

-(void) unload
{
    glDeleteBuffers(1, &_vbo);
    glDeleteBuffers(1, &_ibo);
    
    [super unload];
}

-(void) update:(float)dt
{
    [super update:dt];
}

-(void) draw
{
    // Bind buffers, shaders and setup state
    glBindBuffer(GL_ARRAY_BUFFER, _vbo);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _ibo);
    
    if( _texInfo != nil)
    {
        glActiveTexture(_texInfo.target);
        glBindTexture(_texInfo.target, _texInfo.name);
    }
    
    glUseProgram(_shaderProgram);
    glEnable(GL_CULL_FACE);
    
    // Set vertex attribs
    [self setVertexAttribWithType:kengine::POSITION withAttrName:@"vtxPosition"];
    [self setVertexAttribWithType:kengine::NORMAL withAttrName:@"vtxNormal"];
    [self setVertexAttribWithType:kengine::TEXCOORD0 withAttrName:@"vtxUV"];
    
    // Draw the currently bound object
    glDrawElements(GL_TRIANGLES,
                   (GLsizei)_idxArray.GetNumIndexes(),
                   Util::GetGLType(_idxArray.GetType()),
                   0);
    
    // Unbind and reset state
    glDisable(GL_CULL_FACE);
    glUseProgram(0);
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
    
    if(_texInfo != nil)
        glBindTexture(_texInfo.target, 0);
}

#pragma mark extension methods

- (void)setVertexAttribWithType:(kengine::VTX_ATTRIB)attribType withAttrName:(NSString*)attrName
{
    GLint vtxAttribLocation = glGetAttribLocation(_shaderProgram, [attrName UTF8String]);
    
    if( vtxAttribLocation != -1)
    {
        glEnableVertexAttribArray(vtxAttribLocation);
        glVertexAttribPointer(vtxAttribLocation,
                              (GLint)_vtxArray.GetNumElements(attribType),
                              Util::GetGLType(_vtxArray.GetElementType(attribType)),
                              GL_FALSE,
                              (GLsizei)_vtxArray.GetStride(),
                              (const GLvoid *) _vtxArray.GetOffset(attribType));
    }
}

- (void) loadModel
{
    NSString* path = [[NSBundle mainBundle] pathForResource:self.modelName ofType:@"obj"];
    std::string inputfile = [path UTF8String];
    std::vector<tinyobj::shape_t> shapes;
    std::vector<tinyobj::material_t> materials;
    
    std::string err = tinyobj::LoadObj(shapes, materials, inputfile.c_str());
    
    if (!err.empty() || shapes.empty()) {
        std::cerr << err << std::endl;
        exit(1);
    }
    
    printf("shape[0].name = %s\n", shapes[0].name.c_str());
    printf("Size of shape[0].indices: %ld\n", shapes[0].mesh.indices.size());
    assert((shapes[0].mesh.indices.size() % 3) == 0);
    size_t numVertElements = shapes[0].mesh.positions.size();
    printf("shape[0].vertices.size: %ld\n", numVertElements);
    assert((numVertElements % 3) == 0  && "expecting triangles");
    assert(shapes[0].mesh.normals.size() == numVertElements);
    
    for( size_t i = 0; i < shapes[0].mesh.positions.size() / 3; ++i )
    {
        VertexDescriptorPositionNormalTexcoord desc(shapes[0].mesh.positions[i * 3 + 0],
                                                    shapes[0].mesh.positions[i * 3 + 1],
                                                    shapes[0].mesh.positions[i * 3 + 2],
                                                    //normals
                                                    shapes[0].mesh.normals[i * 3 + 0],
                                                    shapes[0].mesh.normals[i * 3 + 1],
                                                    shapes[0].mesh.normals[i * 3 + 2],
                                                    // uvs
                                                    shapes[0].mesh.texcoords[i * 2 + 0],
                                                    shapes[0].mesh.texcoords[i * 2 + 1]);
        
        //desc.print();
        
        _vtxArray.AddVertex(desc);
    }
    
    for (size_t i = 0; i < shapes[0].mesh.indices.size(); i++)
    {
        unsigned int idx = shapes[0].mesh.indices[i];
        //std::cout << "Index[" << i << "] = " << idx << std::endl;
        _idxArray.AddIndex(idx);
    }
    
    printf("Successfully loaded model: %s.obj\n", [self.modelName UTF8String]);
}


@end
