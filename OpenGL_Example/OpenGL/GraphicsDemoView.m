//
//  GraphicsDemoView.m
//  GLKitTest
//
//  Created by Kain Osterholt on 6/5/15.
//  Copyright (c) 2015 Kain Osterholt. All rights reserved.
//

#import "GraphicsDemoView.h"

#import "EAGLView.h"

@implementation GraphicsDemoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // create the OpenGL view and add it to the window
        mGLView = [[EAGLView alloc] initWithFrame:frame
                                       pixelFormat:GL_RGBA
                                       depthFormat:0
                                preserveBackbuffer:NO];
        
        [self addSubview:mGLView];
    }
    return self;
}

-(void) setCurrentContext
{
    [mGLView setCurrentContext];
}

-(void) swapBuffers
{
    [mGLView swapBuffers];
}

-(void) unload
{
    [mGLView releaseContext];
}

@end
