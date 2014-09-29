//
//  EmitterPointBehaviorTests.m
//  IterateOSX
//
//  Created by James Wilson on 9/28/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <objc/message.h>
//@import IterateOSXFramework;
@import QuartzCore;

#import "EmitterPointControlBehavior.h"
#import "EmitterFloatControlBehavior.h"

@interface EmitterPointControlBehaviorTests : XCTestCase

@property (strong) EmitterPointControlBehavior *emitterBehavior;
@property (strong) id mockControlX;
@property (strong) id mockControlY;
@property (strong) CALayer *layer;

@property (strong) id mockSliderX;
@property (strong) id mockStepperX;
@property (strong) id mockTextFieldX;

@property (strong) id mockSliderY;
@property (strong) id mockStepperY;
@property (strong) id mockTextFieldY;

@end

@implementation EmitterPointControlBehaviorTests

- (void)setUp {
    [super setUp];
    _emitterBehavior = [[EmitterPointControlBehavior alloc] init];
    _mockControlX = [OCMockObject niceMockForClass:[EmitterFloatControlBehavior class]];
    _mockControlY = [OCMockObject niceMockForClass:[EmitterFloatControlBehavior class]];
    
    [_emitterBehavior setValue:_mockControlX forKey:@"xControl"];
    [_emitterBehavior setValue:_mockControlY forKey:@"yControl"];
    
    _mockTextFieldX = [OCMockObject mockForClass:[NSTextField class]];
    _mockSliderX = [OCMockObject mockForClass:[NSSlider class]];
    _mockStepperX = [OCMockObject mockForClass:[NSStepper class]];

    _mockTextFieldY = [OCMockObject mockForClass:[NSTextField class]];
    _mockSliderY = [OCMockObject mockForClass:[NSSlider class]];
    _mockStepperY = [OCMockObject mockForClass:[NSStepper class]];
    
    _emitterBehavior.emitterProperty = @"position";
    _layer.position = CGPointMake(500, 400);
    
    _layer = [[CALayer alloc] init];
}

- (void)tearDown {
    _layer = nil;
    
    _mockTextFieldY = nil;
    _mockSliderY = nil;
    _mockStepperY = nil;
    
    _mockSliderX = nil;
    _mockStepperX = nil;
    _mockTextFieldX = nil;
    
    _mockControlY = nil;
    _mockControlX = nil;
    _emitterBehavior = nil;
    [super tearDown];
}

- (void)testTextFieldXIsUpdatedWhenSelectedViewNotificationIsFired {
    
    [self testUpdateControlsWithUIMock:_mockTextFieldX
                        forControlMock:_mockControlX
                           forSelector:NSStringFromSelector(@selector(textField))
     forValue:_layer.position.x];
}

- (void)testSliderXIsUpdatedWhenSelectedViewNotificationIsFired {
    [self testUpdateControlsWithUIMock:_mockSliderX
                        forControlMock:_mockControlX
                           forSelector:NSStringFromSelector(@selector(slider))
     forValue:_layer.position.x];
}

- (void)testStepperXIsUpdatedWhenSelectedViewNotificationIsFired {
    [self testUpdateControlsWithUIMock:_mockStepperX
                        forControlMock:_mockControlX
                           forSelector:NSStringFromSelector(@selector(stepper))
     forValue:_layer.position.x];
}

- (void)testTextFieldYIsUpdatedWhenSelectedViewNotificationIsFired {
    [self testUpdateControlsWithUIMock:_mockTextFieldY
                        forControlMock:_mockControlY
                           forSelector:NSStringFromSelector(@selector(textField))
     forValue:_layer.position.y];
}

- (void)testSliderYIsUpdatedWhenSelectedViewNotificationIsFired {
    [self testUpdateControlsWithUIMock:_mockSliderY
                        forControlMock:_mockControlY
                           forSelector:NSStringFromSelector(@selector(slider))
     forValue:_layer.position.y];
}

- (void)testStepperYIsUpdatedWhenSelectedViewNotificationIsFired {
    [self testUpdateControlsWithUIMock:_mockStepperY
                        forControlMock:_mockControlY
                           forSelector:NSStringFromSelector(@selector(stepper))
     forValue:_layer.position.y];
}

#pragma mark Helper Methods

- (void)testUpdateControlsWithUIMock:(id)mockUI forControlMock:(id)mockControl forSelector:(NSString*)selector forValue:(float)value{
//    SEL selectorToCall = NSSelectorFromString(selector);
//    IMP imp = [mockControl methodForSelector:selectorToCall];
//    void (*func)(id, SEL) = (void *)imp;
    [[[mockControl stub] andReturn:mockUI] performSelector:NSSelectorFromString(selector)];
    [[mockUI expect] setFloatValue:value];
    
    [_emitterBehavior updateControls:_layer];
    
    [mockUI verify];
}

@end
