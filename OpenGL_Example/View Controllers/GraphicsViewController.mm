//
//  GraphicsViewController.m
//  GLKitTest
//
//  Created by Kain Osterholt on 6/4/15.
//  Copyright (c) 2015 Kain Osterholt. All rights reserved.
//

#import "GraphicsViewController.h"

#import "GraphicsDemoView.h"

@interface GraphicsViewController ()

@end

@implementation GraphicsViewController

@synthesize graphicsView = _graphicsView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect frame = self.view.bounds;
    
    self.graphicsView = [[GraphicsDemoView alloc] initWithFrame:frame];
    [self.view addSubview:self.graphicsView];
    
    _pinchScale = 1.0f;
    
    [self setupGL];
    
    // Remove call to render in initWithFrame and replace it with the following
    [self setupDisplayLink];
}


- (void)setupDisplayLink
{
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(doFrame:)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

-(void)pause:(BOOL)pause
{
    _displayLink.paused = pause;
}

- (void)viewDidUnload
{
    [self tearDownGL];
    
    // Will release the surface and set the context to nil
    [self.graphicsView unload];
    self.graphicsView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Gesture recognition
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    pinchRecognizer.scale = _pinchScale;
    return YES;
}

-(void)swapBuffers
{
    [self.graphicsView swapBuffers];
}

#pragma mark - Overridable subclass methods

- (void) setupGL
{
}

- (void) tearDownGL
{
}

- (void) bindContext
{
    [self.graphicsView setCurrentContext];
}

- (void) updateAndRender:(float)dt
{
    // Override me
}

// Modify render method to take a parameter
- (void)doFrame:(CADisplayLink*)displayLink
{
    [self updateAndRender:displayLink.duration];
}

@end
