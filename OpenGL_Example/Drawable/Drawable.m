//
//  Drawable.m
//  GLKitTest
//
//  Created by Kain Osterholt on 6/3/15.
//  Copyright (c) 2015 Kain Osterholt. All rights reserved.
//

#import "Drawable.h"

@implementation Drawable

@synthesize objectColor = _objectColor;
@synthesize ambientColor = _ambientColor;
@synthesize lightPosition = _lightPosition;

@synthesize shaderName = _shaderName;
@synthesize textureName = _textureName;
@synthesize modelName = _modelName;

@synthesize projectionMat = _projectionMat;
@synthesize modelViewMat = _modelViewMat;

-(id) init
{
    self = [super init];
    
    if( self != nil )
    {
        self.objectColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
        self.ambientColor = GLKVector4Make(0.2f, 0.2f, 0.2f, 1.0f);
        self.lightPosition = GLKVector3Make(0.0f, 0.0f, -3.0f);
        self.shaderName = @"default";
        self.modelName = @"plane";
        self.textureName = nil;
        
        CGRect screenBound = [[UIScreen mainScreen] bounds];
        self.projectionMat = GLKMatrix4MakePerspective(M_PI_4,
                                                       screenBound.size.width / screenBound.size.height,
                                                       1.0f, 100.0f);
        
        self.modelViewMat = GLKMatrix4Identity;
        
        _texInfo = nil;
        
        _frgShader = 0;
        _vtxShader = 0;
        _shaderProgram = 0;
    }
    
    return self;
}

-(void) load
{
    _vtxShader = [self compileShader:self.shaderName withType:GL_VERTEX_SHADER];
    _frgShader = [self compileShader:self.shaderName withType:GL_FRAGMENT_SHADER];
    
    _shaderProgram = [self createProgramWithShaders:_vtxShader fragmentShader:_frgShader];
    
    glUseProgram(_shaderProgram);
    GLint uniformProjection = glGetUniformLocation(_shaderProgram, "Projection");
    glUniformMatrix4fv(uniformProjection, 1, 0, self.projectionMat.m);
    
    GLint uniformObjectColor = glGetUniformLocation(_shaderProgram, "ObjectColor");
    glUniform4fv(uniformObjectColor, 1, self.objectColor.v);
    
    GLint uniformAmbientGlobal = glGetUniformLocation(_shaderProgram, "AmbientGlobal");
    glUniform4fv(uniformAmbientGlobal, 1, self.ambientColor.v);
    
    GLint uniformLightPosition = glGetUniformLocation(_shaderProgram, "LightPosition");
    glUniform3fv(uniformLightPosition, 1, self.lightPosition.v);
    
    glUseProgram(0);
    
    if( self.textureName != nil)
    {
        // Load a texture
        NSError *theError;
        NSString *filePath = [[NSBundle mainBundle] pathForResource:self.textureName ofType:@"png"];
        _texInfo = [GLKTextureLoader textureWithContentsOfFile:filePath options:nil error:&theError];
    }
}

-(void) unload
{
    glDetachShader(_shaderProgram, _vtxShader);
    glDetachShader(_shaderProgram, _frgShader);
    glDeleteShader(_vtxShader);
    glDeleteShader(_frgShader);
    glDeleteProgram(_shaderProgram);
    
    if( _texInfo != nil)
    {
        glBindTexture(_texInfo.target, 0);
        GLuint texID = _texInfo.name;
        glDeleteTextures(1, &texID);
    }
    
    glUseProgram(0);
}

-(void) update:(float)dt
{
    glUseProgram(_shaderProgram);
    GLint uniformModelview = glGetUniformLocation(_shaderProgram, "Modelview");
    glUniformMatrix4fv(uniformModelview, 1, 0, self.modelViewMat.m);
    
    GLint uniformNormalMat = glGetUniformLocation(_shaderProgram, "NormalMat");
    bool isInvertable = true;
    GLKMatrix4 normalMat = GLKMatrix4Transpose(GLKMatrix4Invert(self.modelViewMat, &isInvertable));
    glUniformMatrix4fv(uniformNormalMat, 1, 0, normalMat.m);
}

-(void) draw
{
    
}

- (GLuint)compileShader:(NSString*)shaderName withType:(GLenum)shaderType
{
    
    // Open the file
    NSString* shaderExtension = shaderType == GL_VERTEX_SHADER ? @"vtx" : @"frg";
    NSString* shaderPath = [[NSBundle mainBundle] pathForResource:shaderName
                                                           ofType:shaderExtension];
    NSError* error;
    NSString* shaderString = [NSString stringWithContentsOfFile:shaderPath
                                                       encoding:NSUTF8StringEncoding error:&error];
    if (!shaderString) {
        NSLog(@"Error loading shader: %@", error.localizedDescription);
        exit(1);
    }
    
    // Create OpenGL resource
    GLuint shaderHandle = glCreateShader(shaderType);
    
    // Set shader source string
    const char * shaderStringUTF8 = [shaderString UTF8String];
    GLint shaderStringLength = (GLint)[shaderString length];
    glShaderSource(shaderHandle, 1, &shaderStringUTF8, &shaderStringLength);
    
    // Compile
    glCompileShader(shaderHandle);
    
    // Check the compilation success/failure
    GLint compileSuccess;
    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &compileSuccess);
    if (compileSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetShaderInfoLog(shaderHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"Error compiling shader: %@.%@", shaderName, shaderExtension);
        NSLog(@"%@", messageString);
        exit(1);
    }
    
    return shaderHandle;
}

- (GLuint)createProgramWithShaders:(GLuint)vertexShader fragmentShader:(GLuint)fragmentShader
{
    GLuint programHandle = glCreateProgram();
    glAttachShader(programHandle, vertexShader);
    glAttachShader(programHandle, fragmentShader);
    glLinkProgram(programHandle);
    
    GLint linkSuccess;
    glGetProgramiv(programHandle, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetProgramInfoLog(programHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }

    return programHandle;
}

@end
