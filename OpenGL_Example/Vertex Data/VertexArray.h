//
//  VertexArray.h
//  GLKitTest
//
//  Created by Kain Osterholt on 6/3/15.
//  Copyright (c) 2015 Kain Osterholt. All rights reserved.
//

#ifndef GLKitTest_VertexArray_h
#define GLKitTest_VertexArray_h

#include "defs.h"

#include <vector>

template <class T>
class VertexArray
{
public:
    VertexArray() {};
    ~VertexArray() {};
    
    void AddVertex( T& vtx ) { verts.push_back(vtx); }
    const T* GetBufferPtr() const { return &verts[0]; }
    
    size_t GetStride() { return sizeof(T); }
    size_t GetNumVerts() { return verts.size(); }
    size_t GetBufferSize() { return GetNumVerts() * GetStride(); }
    size_t GetNumElements( kengine::VTX_ATTRIB attr ) { return T::GetNumElements( attr ); }
    void* GetOffset( kengine::VTX_ATTRIB attr ) { return T::GetOffset( attr ); }
    kengine::VTX_ELEMENT_TYPE GetElementType( kengine::VTX_ATTRIB attr ) { return T::GetElementType( attr ); }
    
    
private:
    
    std::vector<T> verts;
};

#endif
