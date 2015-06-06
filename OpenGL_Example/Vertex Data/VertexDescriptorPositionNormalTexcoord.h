//
//  VertexDescriptorPositionNormalTexcoord.h
//  GLKitTest
//
//  Created by Kain Osterholt on 6/3/15.
//  Copyright (c) 2015 Kain Osterholt. All rights reserved.
//

#ifndef __GLKitTest__VertexDescriptorPositionNormalTexcoord__
#define __GLKitTest__VertexDescriptorPositionNormalTexcoord__

#include "defs.h"

#include <unistd.h>

class VertexDescriptorPositionNormalTexcoord
{
private:
    float _x;
    float _y;
    float _z;
    
    float _nx;
    float _ny;
    float _nz;
    
    float _u;
    float _v;
    
public:
    VertexDescriptorPositionNormalTexcoord();
    VertexDescriptorPositionNormalTexcoord(float x, float y, float z, float nx, float ny, float nz, float u, float v);
    ~VertexDescriptorPositionNormalTexcoord();
    
    void print() const;
    
    static void* GetOffset( kengine::VTX_ATTRIB attribute );
    static size_t GetNumElements( kengine::VTX_ATTRIB attribute );
    static size_t GetNumBytesPerElement( kengine::VTX_ATTRIB attribute );
    static kengine::VTX_ELEMENT_TYPE GetElementType( kengine::VTX_ATTRIB attribute );
};


#endif /* defined(__GLKitTest__VertexDescriptorPositionNormalTexcoord__) */
