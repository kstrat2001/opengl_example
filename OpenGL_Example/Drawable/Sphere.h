//
//  Sphere.h
//  GLKitTest
//
//  Created by Kain Osterholt on 6/3/15.
//  Copyright (c) 2015 Kain Osterholt. All rights reserved.
//

#import "Drawable.h"

#import "VertexDescriptorPositionNormalTexcoord.h"
#import "VertexArray.h"
#import "IndexArray.h"

@interface Sphere : Drawable
{
    GLuint _vbo;
    GLuint _ibo;
    
    VertexArray<VertexDescriptorPositionNormalTexcoord> _vtxArray;
    IndexArray<unsigned int> _idxArray;
}

// Base class methods
-(void) load;
-(void) unload;
-(void) update:(float)dt;
-(void) draw;

// extension methods
- (void)setVertexAttribWithType:(kengine::VTX_ATTRIB)attribType withAttrName:(NSString*)attrName;
- (void)loadModel;


@end
