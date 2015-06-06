//
//  ViewController.h
//  GLKitTest
//
//  Created by Kain Osterholt on 6/2/15.
//  Copyright (c) 2015 Kain Osterholt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphicsViewController.h"

@class Drawable;

@interface TextureTestViewController : GraphicsViewController
{
    Drawable* _drawable;
    
    float _yRotation;
}

@end