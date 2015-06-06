//
//  Util.h
//  GLKitTest
//
//  Created by Kain Osterholt on 6/3/15.
//  Copyright (c) 2015 Kain Osterholt. All rights reserved.
//

#ifndef __GLKitTest__Util__
#define __GLKitTest__Util__

#include "defs.h"

#include <OpenGLES/ES3/gl.h>

class Util
{
public:
    static GLenum GetGLType( kengine::VTX_ELEMENT_TYPE type );
};

#endif /* defined(__GLKitTest__Util__) */
