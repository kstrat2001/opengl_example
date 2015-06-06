//
//  GraphicsViewController.h
//  GLKitTest
//
//  Created by Kain Osterholt on 6/4/15.
//  Copyright (c) 2015 Kain Osterholt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GraphicsDemoView;

@interface GraphicsViewController : UIViewController <UIGestureRecognizerDelegate>
{
    IBOutlet UIPinchGestureRecognizer* pinchRecognizer;
    
    float _pinchScale;
    
    CADisplayLink* _displayLink;
}

@property (strong, nonatomic) GraphicsDemoView* graphicsView;

-(void)setupDisplayLink;
-(void)pause:(BOOL)pause;

-(void)setupGL;
-(void)tearDownGL;

-(void)bindContext;

- (void) updateAndRender:(float)dt;
- (void)doFrame:(CADisplayLink*)displayLink;
- (void)swapBuffers;

@end
