//
//  VertexDescriptorPositionNormalTexcoord.cpp
//  GLKitTest
//
//  Created by Kain Osterholt on 6/3/15.
//  Copyright (c) 2015 Kain Osterholt. All rights reserved.
//

#include "VertexDescriptorPositionNormalTexcoord.h"
#include <stdio.h>

using namespace kengine;

VertexDescriptorPositionNormalTexcoord::VertexDescriptorPositionNormalTexcoord()
:
_x(0.0f), _y(0.0f), _z(0.0f),
_nx(0.0f), _ny(0.0f), _nz(0.0f),
_u(0.0), _v(0.0)
{
    
}

VertexDescriptorPositionNormalTexcoord::VertexDescriptorPositionNormalTexcoord(float x, float y, float z,
                                                                               float nx, float ny, float nz,
                                                                               float u, float v)
:
_x(x), _y(y), _z(z),
_nx(nx), _ny(ny), _nz(nz),
_u(u), _v(v)
{
    
}

VertexDescriptorPositionNormalTexcoord::~VertexDescriptorPositionNormalTexcoord()
{
    
}

void VertexDescriptorPositionNormalTexcoord::print() const
{
    printf("vtx: %f, %f, %f \n", _x, _y, _z);
    printf("norm: %f, %f, %f \n", _nx, _ny, _nz);
    printf("tex: %f, %f \n", _u, _v);
}

void* VertexDescriptorPositionNormalTexcoord::GetOffset( VTX_ATTRIB attribute )
{
    switch (attribute) {
        case kengine::NORMAL:
            return (void*)12;
            break;
        case kengine::TEXCOORD0:
            return (void*)24;
            break;
        default:
            return (void*)0;
            break;
    }
}

size_t VertexDescriptorPositionNormalTexcoord::GetNumElements( VTX_ATTRIB attribute )
{
    switch (attribute) {
        case POSITION:
            return 3;
            break;
        case NORMAL:
            return 3;
            break;
        case TEXCOORD0:
            return 2;
            break;
        default:
            return 0;
            break;
    }
}

size_t VertexDescriptorPositionNormalTexcoord::GetNumBytesPerElement( VTX_ATTRIB attribute )
{
    switch (attribute) {
        default:
            return 4;
            break;
    }
}

VTX_ELEMENT_TYPE VertexDescriptorPositionNormalTexcoord::GetElementType( VTX_ATTRIB attribute )
{
    switch (attribute) {
        default:
            return FLOAT32;
            break;
    }
}

