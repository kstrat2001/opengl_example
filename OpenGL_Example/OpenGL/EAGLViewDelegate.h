//
//  EAGLView2Delegate.h
//  GLKitTest
//
//  Created by Kain Osterholt on 6/5/15.
//  Copyright (c) 2015 Kain Osterholt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EAGLView;

@protocol EAGLViewDelegate <NSObject>
- (void) didResizeEAGLSurfaceForView:(EAGLView*)view; //Called whenever the EAGL surface has been resized
@end
