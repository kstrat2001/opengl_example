//
//  VertexDescriptor.h
//  GLKitTest
//
//  Created by Kain Osterholt on 6/3/15.
//  Copyright (c) 2015 Kain Osterholt. All rights reserved.
//

#ifndef __GLKitTest__VertexDescriptor__
#define __GLKitTest__VertexDescriptor__

#include "defs.h"

#include <unistd.h>

class VertexDescriptorPositionColor
{
private:
    float _x;
    float _y;
    float _z;
    
    float _r;
    float _g;
    float _b;
    float _a;
    
public:
    VertexDescriptorPositionColor();
    VertexDescriptorPositionColor(float x, float y, float z, float r, float g, float b, float a);
    ~VertexDescriptorPositionColor();
    
    static void* GetOffset( kengine::VTX_ATTRIB attribute );
    static size_t GetNumElements( kengine::VTX_ATTRIB attribute );
    static size_t GetNumBytesPerElement( kengine::VTX_ATTRIB attribute );
    static kengine::VTX_ELEMENT_TYPE GetElementType( kengine::VTX_ATTRIB attribute );
};

#endif /* defined(__GLKitTest__VertexDescriptor__) */
