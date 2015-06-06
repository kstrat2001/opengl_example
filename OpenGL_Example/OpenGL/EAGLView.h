//
//  EAGLView.h
//  GLKitTest
//
//  Created by Kain Osterholt on 6/5/15.
//  Copyright (c) 2015 Kain Osterholt. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <OpenGLES/EAGL.h>
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
#import <OpenGLES/ES3/gl.h>
#import <OpenGLES/ES3/glext.h>
#elif __IPHONE_OS_VERSION_MAX_ALLOWED >= 30000
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#else
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#endif

#import "EAGLViewDelegate.h"

//CLASSES:
extern int __OPENGLES_VERSION;

//CLASS INTERFACE:

/*
This class wraps the CAEAGLLayer from CoreAnimation into a convenient UIView subclass.
The view content is basically an EAGL surface you render your OpenGL scene into.
Note that setting the view non-opaque will only work if the EAGL surface has an alpha channel.
*/
@interface EAGLView : UIView
{
@private
	GLuint					_format;
	GLuint					_depthFormat;
	BOOL					_autoresize;
	EAGLContext				*_context;
	GLuint					_framebuffer;
	GLuint					_renderbuffer;
	GLuint					_depthBuffer;
	CGSize					_size;
	BOOL					_hasBeenCurrent;
    
    // Store whether the device supports multisampling or not
    BOOL                    _multisampling;
    
    // Add multisampling buffers
    GLuint                  _sampleFramebuffer;
    GLuint                  _sampleColorRenderbuffer;
    GLuint                  _sampleDepthRenderbuffer;
}
- (id) initWithFrame:(CGRect)frame; //These also set the current context
- (id) initWithFrame:(CGRect)frame pixelFormat:(GLuint)format;
- (id) initWithFrame:(CGRect)frame pixelFormat:(GLuint)format depthFormat:(GLuint)depth preserveBackbuffer:(BOOL)retained;
- (void) releaseContext;

@property(readonly) GLuint framebuffer;
@property(readonly) GLuint pixelFormat;
@property(readonly) GLuint depthFormat;
@property(readonly) EAGLContext *context;

@property BOOL autoresizesSurface; //NO by default - Set to YES to have the EAGL surface automatically resized when the view bounds change, otherwise the EAGL surface contents is rendered scaled
@property(readonly, nonatomic) CGSize surfaceSize;

@property(assign) id<EAGLViewDelegate> delegate;

- (void) setCurrentContext;
- (BOOL) isCurrentContext;
- (void) clearCurrentContext;

- (void) swapBuffers; //This also checks the current OpenGL error and logs an error if needed

- (CGPoint) convertPointFromViewToSurface:(CGPoint)point;
- (CGRect) convertRectFromViewToSurface:(CGRect)rect;
@end
