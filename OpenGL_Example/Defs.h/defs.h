//
//  defs.h
//  GLKitTest
//
//  Created by Kain Osterholt on 6/3/15.
//  Copyright (c) 2015 Kain Osterholt. All rights reserved.
//

#ifndef GLKitTest_defs_h
#define GLKitTest_defs_h

namespace kengine
{
    enum VTX_ATTRIB
    {
        POSITION = 0,
        NORMAL,
        COLOR,
        TEXCOORD0
    };

    enum VTX_ELEMENT_TYPE
    {
        UINT8 = 0,
        UINT16,
        UINT32,
        FLOAT16,
        FLOAT32
    };
}

#endif
