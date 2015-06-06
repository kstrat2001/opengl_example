//
//  Util.cpp
//  GLKitTest
//
//  Created by Kain Osterholt on 6/3/15.
//  Copyright (c) 2015 Kain Osterholt. All rights reserved.
//

#include "Util.h"

using namespace kengine;

GLenum Util::GetGLType( kengine::VTX_ELEMENT_TYPE type )
{
    switch (type) {
        case kengine::UINT8:
            return GL_UNSIGNED_BYTE;
            break;
        case kengine::UINT16:
            return GL_UNSIGNED_SHORT;
            break;
        case kengine::UINT32:
            return GL_UNSIGNED_INT;
            break;
        case kengine::FLOAT16:
            return GL_HALF_FLOAT;
            break;
        case kengine::FLOAT32:
            return GL_FLOAT;
            break;
        default:
            break;
    }
}