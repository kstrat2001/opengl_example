//
//  BlendTestViewController.h
//  GLKitTest
//
//  Created by Kain Osterholt on 6/4/15.
//  Copyright (c) 2015 Kain Osterholt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphicsViewController.h"

@class Drawable;

@interface BlendTestViewController : GraphicsViewController
{
    Drawable* _drawable;
    Drawable* _drawable2;
    
    float _zRotation;
}

@end
