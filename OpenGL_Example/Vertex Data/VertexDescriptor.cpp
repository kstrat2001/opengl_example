//
//  VertexDescriptor.cpp
//  GLKitTest
//
//  Created by Kain Osterholt on 6/3/15.
//  Copyright (c) 2015 Kain Osterholt. All rights reserved.
//

#include "VertexDescriptor.h"

using namespace kengine;

VertexDescriptorPositionColor::VertexDescriptorPositionColor()
: _x(0.0f), _y(0.0f), _z(0.0f), _r(0.0f), _g(0.0f), _b(0.0f), _a(0.0)
{
    
}

VertexDescriptorPositionColor::VertexDescriptorPositionColor(float x, float y, float z, float r, float g, float b, float a)
: _x(x), _y(y), _z(z), _r(r), _g(g), _b(b), _a(a)
{
    
}

VertexDescriptorPositionColor::~VertexDescriptorPositionColor()
{
    
}

void* VertexDescriptorPositionColor::GetOffset( VTX_ATTRIB attribute )
{
    switch (attribute) {
        case COLOR:
            return (void*)12;
            break;
        default:
            return (void*)0;
            break;
    }
}

size_t VertexDescriptorPositionColor::GetNumElements( VTX_ATTRIB attribute )
{
    switch (attribute) {
        case POSITION:
            return 3;
            break;
        case COLOR:
            return 4;
            break;
        default:
            return 0;
            break;
    }
}

size_t VertexDescriptorPositionColor::GetNumBytesPerElement( VTX_ATTRIB attribute )
{
    switch (attribute) {
        default:
            return 4;
            break;
    }
}

VTX_ELEMENT_TYPE VertexDescriptorPositionColor::GetElementType( VTX_ATTRIB attribute )
{
    switch (attribute) {
        default:
            return FLOAT32;
            break;
    }
}

