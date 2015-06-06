//
//  Drawable.h
//  GLKitTest
//
//  Created by Kain Osterholt on 6/3/15.
//  Copyright (c) 2015 Kain Osterholt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface Drawable : NSObject
{
    GLuint _vtxShader;
    GLuint _frgShader;
    GLuint _shaderProgram;
    
    GLKTextureInfo* _texInfo;
}

@property (nonatomic) GLKVector4 objectColor;
@property (nonatomic) GLKVector4 ambientColor;
@property (nonatomic) GLKVector3 lightPosition;

@property (strong, nonatomic) NSString* shaderName;
@property (strong, nonatomic) NSString* textureName;
@property (strong, nonatomic) NSString* modelName;

@property (nonatomic) GLKMatrix4 projectionMat;
@property (nonatomic) GLKMatrix4 modelViewMat;

-(void) load;
-(void) unload;

-(void) update:(float)dt;
-(void) draw;

- (GLuint)compileShader:(NSString*)shaderName withType:(GLenum)shaderType;
- (GLuint)createProgramWithShaders:(GLuint)vertexShader fragmentShader:(GLuint)fragmentShader;

@end
