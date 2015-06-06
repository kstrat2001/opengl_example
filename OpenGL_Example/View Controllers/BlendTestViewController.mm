//
//  BlendTestViewController.m
//  GLKitTest
//
//  Created by Kain Osterholt on 6/4/15.
//  Copyright (c) 2015 Kain Osterholt. All rights reserved.
//

#import "BlendTestViewController.h"

#import "Sphere.h"

@interface BlendTestViewController ()

@end

@implementation BlendTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _zRotation = 0.0f;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)updateAndRender:(float)dt
{
    [self bindContext];
    [self update:dt];
    
    glClearColor(0.4, 0.4, 0.4, 1.0);
    
    glClear(GL_COLOR_BUFFER_BIT);

    // Enable blending for this test so that sphere 2 is seen behind sphere 1
    glEnable(GL_BLEND);
    glBlendEquation(GL_FUNC_ADD);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    glViewport(0.0f,
               0.0f,
               self.view.frame.size.width,
               self.view.frame.size.height);
    
    // Draw the small sphere first so it is in the framebuffer
    [_drawable2 draw];
    
    // Draw the larger sphere over the first to blend it
    [_drawable draw];
    
    glDisable(GL_BLEND);
    
    [self swapBuffers];
}

#pragma mark - GLKViewControllerDelegate

- (void) update:(float)dt
{
    _zRotation += dt * M_PI_2;
    
    if( pinchRecognizer.scale != 1.0f )
        _pinchScale = pinchRecognizer.scale;
    
    // Transform the large sphere
    _drawable.modelViewMat = GLKMatrix4Identity;
    _drawable.modelViewMat = GLKMatrix4Translate(_drawable.modelViewMat, 0, 0, -7);
    _drawable.modelViewMat = GLKMatrix4Scale(_drawable.modelViewMat, _pinchScale, _pinchScale, _pinchScale);
    
    // Transform the smaller sphere but use the big sphere transform as a parent (a kinda cheap scene graph)
    _drawable2.modelViewMat = _drawable.modelViewMat;
    _drawable2.modelViewMat = GLKMatrix4Rotate(_drawable2.modelViewMat, _zRotation, 0.0f, 0.0f, 1.0f);
    
    // Move the smaller sphere exacly 1 unit (the sphere model's radius) on the y axis
    // This makes the second sphere's midpoint touch the surface of sphere 1
    _drawable2.modelViewMat = GLKMatrix4Translate(_drawable2.modelViewMat, 0.0f, -1.0f, 0.0f);
    
    // Then scale the second sphere so that it is smaller
    _drawable2.modelViewMat = GLKMatrix4Scale(_drawable2.modelViewMat, 0.3f, 0.3f, 0.3f);
    
    [_drawable2 update:dt];
    [_drawable update:dt];
}

- (void)setupGL
{
    [super setupGL];
    
    [self bindContext];
    
    // Set the properties for the big sphere
    _drawable = [[Sphere alloc] init];
    _drawable.modelName = @"sphere";
    _drawable.ambientColor = GLKVector4Make(0.3f, 0.3f, 0.3f, 1.0f);
    _drawable.objectColor = GLKVector4Make(1.0f, 0.0f, 0.0f, 0.6f);
    _drawable.lightPosition = GLKVector3Make(0, 0, -3.5);
    _drawable.projectionMat = GLKMatrix4MakePerspective(M_PI_4,
                                                        self.view.frame.size.width/self.view.frame.size.height,
                                                        1.0f, 100.0f);
    
    // Set the properties for the smaller sphere
    _drawable2 = [[Sphere alloc] init];
    _drawable2.modelName = @"sphere";
    _drawable2.ambientColor = GLKVector4Make(0.3f, 0.3f, 0.3f, 1.0f);
    _drawable2.objectColor = GLKVector4Make(0.0f, 1.0f, 1.0f, 1.0f);
    _drawable2.lightPosition = GLKVector3Make(0, 0, -3.5);
    _drawable2.projectionMat = GLKMatrix4MakePerspective(M_PI_4,
                                                        self.view.frame.size.width/self.view.frame.size.height,
                                                        1.0f, 100.0f);
    
    _drawable.shaderName = @"blend";
    _drawable2.shaderName = @"blend";
    
    // Load resources and set properties in shaders
    [_drawable load];
    [_drawable2 load];
}

- (void)tearDownGL
{
    [self bindContext];
    
    [_drawable unload];
    _drawable = nil;
    
    [_drawable2 unload];
    _drawable2 = nil;
    
    [super tearDownGL];
}

@end