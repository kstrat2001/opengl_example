//
//  IndexArray.h
//  GLKitTest
//
//  Created by Kain Osterholt on 6/3/15.
//  Copyright (c) 2015 Kain Osterholt. All rights reserved.
//

#ifndef GLKitTest_IndexArray_h
#define GLKitTest_IndexArray_h

#include <vector>

#include "defs.h"

template <typename T>
class IndexArray
{
public:
    IndexArray() {}
    ~IndexArray() {}
    
    void AddIndex( T index ) { indexes.push_back(index); }
    const T* GetBufferPtr() const { return &indexes[0]; }
    
    size_t GetNumIndexes() const { return indexes.size(); }
    size_t GetBufferSize() const { return GetNumIndexes() * sizeof(T); }
    
    kengine::VTX_ELEMENT_TYPE GetType() const
    {
        kengine::VTX_ELEMENT_TYPE retval = kengine::UINT8;
        
        if(sizeof(T) == 4)
            retval = kengine::UINT32;
        else if(sizeof(T) == 2)
            retval = kengine::UINT16;
        else if(sizeof(T) == 1)
            retval = kengine::UINT8;
        else
            assert(false);
        
        return retval;
    }
    
private:
    
    std::vector<T> indexes;
};


#endif
