//
//  GraphicsDemoView.h
//  GLKitTest
//
//  Created by Kain Osterholt on 6/5/15.
//  Copyright (c) 2015 Kain Osterholt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EAGLView;

@interface GraphicsDemoView : UIView
{
    EAGLView* mGLView;
}

-(void)setCurrentContext;
-(void)swapBuffers;

-(void)unload;

@end
