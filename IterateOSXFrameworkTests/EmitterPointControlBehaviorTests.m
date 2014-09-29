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

- (void)testXControlsStepperIsUpdatedWhenXValueUpdatedIsCalled {
    [self testUpdateXValuesWithUIMock:_mockStepperX
                        forControlMock:_mockControlX
                           forSelector:NSStringFromSelector(@selector(stepper))];
}

- (void)testXControlsSliderIsUpdatedWhenXValueUpdatedIsCalled {
    [self testUpdateXValuesWithUIMock:_mockSliderX
                      forControlMock:_mockControlX
                         forSelector:NSStringFromSelector(@selector(slider))];
}

- (void)testXControlsTextFieldIsUpdatedWhenXValueUpdatedIsCalled {
    [self testUpdateXValuesWithUIMock:_mockTextFieldX
                      forControlMock:_mockControlX
                         forSelector:NSStringFromSelector(@selector(textField))];
}

- (void)testYControlsStepperIsUpdatedWhenXValueUpdatedIsCalled {
    [self testUpdateYValuesWithUIMock:_mockStepperY
                       forControlMock:_mockControlY
                          forSelector:NSStringFromSelector(@selector(stepper))];
}

- (void)testYControlsSliderIsUpdatedWhenXValueUpdatedIsCalled {
    [self testUpdateYValuesWithUIMock:_mockSliderY
                       forControlMock:_mockControlY
                          forSelector:NSStringFromSelector(@selector(slider))];
}

- (void)testYControlsTextFieldIsUpdatedWhenXValueUpdatedIsCalled {
    [self testUpdateYValuesWithUIMock:_mockTextFieldY
                       forControlMock:_mockControlY
                          forSelector:NSStringFromSelector(@selector(textField))];
}

- (void)testUpdateValuesIsCalledWhenXValueUpdatedsIsCalled {
    id partialMock = [OCMockObject partialMockForObject:_emitterBehavior];
    
    [[partialMock expect] updateValues:[OCMArg any]];
    
    [partialMock xValueUpdated:nil];
    [partialMock verify];
    partialMock = nil;
}

- (void)testUpdateValuesIsCalledWhenYValueUpdatedsIsCalled {
    id partialMock = [OCMockObject partialMockForObject:_emitterBehavior];
    
    [[partialMock expect] updateValues:[OCMArg any]];
    
    [partialMock yValueUpdated:nil];
    [partialMock verify];
    partialMock = nil;
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

- (void)testUpdateXValuesWithUIMock:(id)mockUI forControlMock:(id)mockControl forSelector:(NSString*)selector {
    [self testUpdateValuesWithUIMock:mockUI forControlMock:mockControl forSelector:selector completionBlock:^(id sender) {
        [_emitterBehavior xValueUpdated:sender];
    }];
}

- (void)testUpdateYValuesWithUIMock:(id)mockUI forControlMock:(id)mockControl forSelector:(NSString*)selector {
    [self testUpdateValuesWithUIMock:mockUI forControlMock:mockControl forSelector:selector completionBlock:^(id sender) {
        [_emitterBehavior yValueUpdated:sender];
    }];
}

- (void)testUpdateValuesWithUIMock:(id)mockUI forControlMock:(id)mockControl forSelector:(NSString*)selector completionBlock:(void (^)(id))callFuncBlock {
    int number = 200;
    id mockSender = [OCMockObject mockForClass:[NSTextField class]];
    [[[mockSender stub] andReturnValue:@(number)] floatValue];
    [[[mockControl stub] andReturn:mockUI] performSelector:NSSelectorFromString(selector)];
    [[mockUI expect] setFloatValue:number];
    
    callFuncBlock(mockSender);
    
    [mockUI verify];
}

@end
