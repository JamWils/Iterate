//
//  EmitterSizeControlBehaviorTests.m
//  IterateOSX
//
//  Created by James Wilson on 9/29/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <objc/message.h>
@import QuartzCore;

#import "EmitterSizeControlBehavior.h"
#import "EmitterFloatControlBehavior.h"

@interface EmitterSizeControlBehaviorTests : XCTestCase

@property (strong) EmitterSizeControlBehavior *emitterBehavior;
@property (strong) id mockControlWidth;
@property (strong) id mockControlHeight;
@property (strong) CAEmitterLayer *emitterLayer;

@property (strong) id mockSliderWidth;
@property (strong) id mockStepperWidth;
@property (strong) id mockTextFieldWidth;

@property (strong) id mockSliderHeight;
@property (strong) id mockStepperHeight;
@property (strong) id mockTextFieldHeight;

@end

@implementation EmitterSizeControlBehaviorTests

- (void)setUp {
    [super setUp];
    
    _emitterBehavior = [[EmitterSizeControlBehavior alloc] init];
    _mockControlWidth = [OCMockObject niceMockForClass:[EmitterFloatControlBehavior class]];
    _mockControlHeight = [OCMockObject niceMockForClass:[EmitterFloatControlBehavior class]];
    
    [_emitterBehavior setValue:_mockControlWidth forKey:@"widthControl"];
    [_emitterBehavior setValue:_mockControlHeight forKey:@"heightControl"];
    
    _mockTextFieldWidth = [OCMockObject mockForClass:[NSTextField class]];
    _mockSliderWidth = [OCMockObject mockForClass:[NSSlider class]];
    _mockStepperWidth = [OCMockObject mockForClass:[NSStepper class]];
    
    _mockTextFieldHeight = [OCMockObject mockForClass:[NSTextField class]];
    _mockSliderHeight = [OCMockObject mockForClass:[NSSlider class]];
    _mockStepperHeight = [OCMockObject mockForClass:[NSStepper class]];
    
    _emitterBehavior.emitterProperty = @"emitterSize";
    
    
    _emitterLayer = [[CAEmitterLayer alloc] init];
    _emitterLayer.emitterSize = CGSizeMake(500, 400);
}

- (void)tearDown {
    _emitterLayer = nil;
    
    _mockTextFieldHeight = nil;
    _mockSliderHeight = nil;
    _mockStepperHeight = nil;
    
    _mockSliderWidth = nil;
    _mockStepperWidth = nil;
    _mockTextFieldWidth = nil;
    
    _mockControlHeight = nil;
    _mockControlWidth = nil;
    _emitterBehavior = nil;
    [super tearDown];
}

- (void)testTextFieldWidthIsUpdatedWhenSelectedViewNotificationIsFired {
    
    [self testUpdateControlsWithUIMock:_mockTextFieldWidth
                        forControlMock:_mockControlWidth
                           forSelector:NSStringFromSelector(@selector(textField))
                              forValue:_emitterLayer.emitterSize.width];
}

//TODO: Write this unit test
//- (void)testControlWidthIsNotUpdatedWithoutValidEmitterPropertyWhenSelectedViewNotificationIsFired {
//    _emitterBehavior.emitterProperty = @"position";
//    [self testUpdateControlsWithUIMock:_mockTextFieldWidth
//                        forControlMock:_mockControlWidth
//                           forSelector:NSStringFromSelector(@selector(textField))
//                              forValue:_emitterLayer.emitterSize.width];
//}

- (void)testSliderWidthIsUpdatedWhenSelectedViewNotificationIsFired {
    [self testUpdateControlsWithUIMock:_mockSliderWidth
                        forControlMock:_mockControlWidth
                           forSelector:NSStringFromSelector(@selector(slider))
                              forValue:_emitterLayer.emitterSize.width];
}

- (void)testStepperWidthIsUpdatedWhenSelectedViewNotificationIsFired {
    [self testUpdateControlsWithUIMock:_mockStepperWidth
                        forControlMock:_mockControlWidth
                           forSelector:NSStringFromSelector(@selector(stepper))
                              forValue:_emitterLayer.emitterSize.width];
}

- (void)testTextFieldHeightIsUpdatedWhenSelectedViewNotificationIsFired {
    [self testUpdateControlsWithUIMock:_mockTextFieldHeight
                        forControlMock:_mockControlHeight
                           forSelector:NSStringFromSelector(@selector(textField))
                              forValue:_emitterLayer.emitterSize.height];
}

- (void)testSliderHeightIsUpdatedWhenSelectedViewNotificationIsFired {
    [self testUpdateControlsWithUIMock:_mockSliderHeight
                        forControlMock:_mockControlHeight
                           forSelector:NSStringFromSelector(@selector(slider))
                              forValue:_emitterLayer.emitterSize.height];
}

- (void)testStepperHeightIsUpdatedWhenSelectedViewNotificationIsFired {
    [self testUpdateControlsWithUIMock:_mockStepperHeight
                        forControlMock:_mockControlHeight
                           forSelector:NSStringFromSelector(@selector(stepper))
                              forValue:_emitterLayer.emitterSize.height];
}

- (void)testWidthControlsStepperIsUpdatedWhenXValueUpdatedIsCalled {
    [self testUpdateXValuesWithUIMock:_mockStepperWidth
                       forControlMock:_mockControlWidth
                          forSelector:NSStringFromSelector(@selector(stepper))];
}

- (void)testWidthControlsSliderIsUpdatedWhenXValueUpdatedIsCalled {
    [self testUpdateXValuesWithUIMock:_mockSliderWidth
                       forControlMock:_mockControlWidth
                          forSelector:NSStringFromSelector(@selector(slider))];
}

- (void)testWidthControlsTextFieldIsUpdatedWhenXValueUpdatedIsCalled {
    [self testUpdateXValuesWithUIMock:_mockTextFieldWidth
                       forControlMock:_mockControlWidth
                          forSelector:NSStringFromSelector(@selector(textField))];
}

- (void)testHeightControlsStepperIsUpdatedWhenXValueUpdatedIsCalled {
    [self testUpdateYValuesWithUIMock:_mockStepperHeight
                       forControlMock:_mockControlHeight
                          forSelector:NSStringFromSelector(@selector(stepper))];
}

- (void)testHeightControlsSliderIsUpdatedWhenXValueUpdatedIsCalled {
    [self testUpdateYValuesWithUIMock:_mockSliderHeight
                       forControlMock:_mockControlHeight
                          forSelector:NSStringFromSelector(@selector(slider))];
}

- (void)testHeightControlsTextFieldIsUpdatedWhenXValueUpdatedIsCalled {
    [self testUpdateYValuesWithUIMock:_mockTextFieldHeight
                       forControlMock:_mockControlHeight
                          forSelector:NSStringFromSelector(@selector(textField))];
}

- (void)testUpdateValuesIsCalledWhenWidthValueUpdatedsIsCalled {
    id partialMock = [OCMockObject partialMockForObject:_emitterBehavior];
    
    [[partialMock expect] updateValues:[OCMArg any]];
    
    [partialMock widthValueUpdated:nil];
    [partialMock verify];
    partialMock = nil;
}

- (void)testUpdateValuesIsCalledWhenHeightValueUpdatedsIsCalled {
    id partialMock = [OCMockObject partialMockForObject:_emitterBehavior];
    
    [[partialMock expect] updateValues:[OCMArg any]];
    
    [partialMock heightValueUpdated:nil];
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
    
    [_emitterBehavior updateControls:_emitterLayer];
    
    [mockUI verify];
}

- (void)testUpdateXValuesWithUIMock:(id)mockUI forControlMock:(id)mockControl forSelector:(NSString*)selector {
    [self testUpdateValuesWithUIMock:mockUI forControlMock:mockControl forSelector:selector completionBlock:^(id sender) {
        [_emitterBehavior widthValueUpdated:sender];
    }];
}

- (void)testUpdateYValuesWithUIMock:(id)mockUI forControlMock:(id)mockControl forSelector:(NSString*)selector {
    [self testUpdateValuesWithUIMock:mockUI forControlMock:mockControl forSelector:selector completionBlock:^(id sender) {
        [_emitterBehavior heightValueUpdated:sender];
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
