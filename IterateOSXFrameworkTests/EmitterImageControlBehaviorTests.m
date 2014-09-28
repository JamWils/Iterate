//
//  EmitterImageControlBehaviorTests.m
//  IterateOSX
//
//  Created by James Wilson on 9/28/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "EmitterImageControlBehavior.h"

@interface EmitterImageControlBehaviorTests : XCTestCase

@property (strong) id mockImageView;
@property (strong) EmitterImageControlBehavior *emitterControl;
@property (strong) NSImage *testImage;

@end

@implementation EmitterImageControlBehaviorTests

- (void)setUp {
    [super setUp];
    
    _emitterControl = [[EmitterImageControlBehavior alloc] init];
    _mockImageView = [OCMockObject mockForClass:[NSImageView class]];
    _emitterControl.imageView = _mockImageView;
    
    _testImage = [NSImage imageNamed:@"Moon"];
}

- (void)tearDown {
    _testImage = nil;
    
    _mockImageView = nil;
    _emitterControl = nil;
    [super tearDown];
}

- (void)testImageViewUpdatedWhenUpdateControlsIsCalled {
    _emitterControl.emitterProperty = @"contents";
    CALayer *layer = [[CALayer alloc] init];
    layer.contents = (__bridge id)([self CGImageFromNSImage:_testImage]);
    
    [[_mockImageView expect] setImage:[OCMArg any]];
    [_emitterControl updateControls:layer];
    
    [_mockImageView verify];
}

- (void)testTextFieldUpdatedDoesNotThrowErrorWhenEmitterPropertyNameIsMissing {
    [[_mockImageView expect] setStringValue:@"Test"];
    CALayer *layer = [[CALayer alloc] init];
    layer.name = @"Test";
    
    XCTAssertNoThrow([_emitterControl updateControls:layer], @"An error should not occur.");
}

- (void)testImageViewActionUpdateImageCallsUpdateValueOnControl {
    id emitterControl = [OCMockObject partialMockForObject:[[EmitterImageControlBehavior alloc] init]];
    [[[_mockImageView stub] andReturn:_testImage] image];
    [[emitterControl expect] updateValues:[OCMArg any]];
    
    [emitterControl updateImage:_mockImageView];
    
    XCTAssertNoThrow([emitterControl verify], @"Update Value should be called on emitter control");
}

#pragma mark Helper Methods

-(CGImageRef)CGImageNamed:(NSString*)name {
    NSImage *testImage = [NSImage imageNamed:@"Moon"];

    CGImageSourceRef source;

    source = CGImageSourceCreateWithData((CFDataRef)[testImage TIFFRepresentation], NULL);
    CGImageRef maskRef =  CGImageSourceCreateImageAtIndex(source, 0, NULL);
    return maskRef;
}

-(CGImageRef)CGImageFromNSImage:(NSImage*)image {
    
    CGImageSourceRef source;
    
    source = CGImageSourceCreateWithData((CFDataRef)[image TIFFRepresentation], NULL);
    CGImageRef maskRef =  CGImageSourceCreateImageAtIndex(source, 0, NULL);
    return maskRef;
}

@end
