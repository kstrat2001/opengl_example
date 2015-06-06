//
//  ViewController.m
//  GLKitTest
//
//  Created by Kain Osterholt on 6/2/15.
//  Copyright (c) 2015 Kain Osterholt. All rights reserved.
//

#import "TextureTestViewController.h"
#import "Sphere.h"

@interface TextureTestViewController ()

@end

@implementation TextureTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _yRotation = 0.0f;
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
    
    glViewport(0.0f,
               0.0f,
               self.view.frame.size.width/* * screenScale */,
               self.view.frame.size.height /** screenScale */);
    
    [_drawable draw];
    
    [self swapBuffers];
}

- (void) update:(float)dt
{
    _yRotation += dt * M_PI_2;  // 90 degrees per second
    
    if( pinchRecognizer.scale != 1.0f )
        _pinchScale = pinchRecognizer.scale;
    
    // Move the sphere away from the viewer and behind the light source
    _drawable.modelViewMat = GLKMatrix4MakeTranslation(0, 0, -7);
    
    // Apply the rotation calculated above
    _drawable.modelViewMat = GLKMatrix4Rotate(_drawable.modelViewMat, _yRotation, 0.0, 1.0, 0.0);
    
    // Apply pinch gesture scaling factor
    _drawable.modelViewMat = GLKMatrix4Scale(_drawable.modelViewMat, _pinchScale, _pinchScale, _pinchScale);
    
    [_drawable update:dt];
}

- (void)setupGL
{
    [super setupGL]; // sets up the right context
    [super bindContext];
    
    _drawable = [[Sphere alloc] init];
    _drawable.textureName = @"texture";
    _drawable.modelName = @"sphere";
    _drawable.ambientColor = GLKVector4Make(0.2f, 0.2f, 0.2f, 1.0f);
    _drawable.objectColor = GLKVector4Make(1.0f, 0.0f, 0.0f, 1.0f);
    _drawable.lightPosition = GLKVector3Make(0, 0, -3.5);
    _drawable.projectionMat = GLKMatrix4MakePerspective(M_PI_4,
                                                        self.view.frame.size.width/self.view.frame.size.height,
                                                        1.0f, 100.0f);
    
    [_drawable load];
}

- (void)tearDownGL
{
    [self bindContext];
    
    [_drawable unload];
    _drawable = nil;
    
    [super tearDownGL];
}

@end
