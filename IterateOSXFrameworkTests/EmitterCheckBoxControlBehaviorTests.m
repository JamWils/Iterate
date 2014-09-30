//
//  EmitterCheckBoxControlBehaviorTests.m
//  IterateOSX
//
//  Created by James Wilson on 9/29/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
@import QuartzCore;

#import "EmitterCheckBoxControlBehavior.h"

@interface EmitterCheckBoxControlBehaviorTests : XCTestCase

@property (strong) EmitterCheckBoxControlBehavior *controlBehavior;
@property (strong) CAEmitterLayer *emitterLayer;
@property (strong) id mockCheckbox;

@end

@implementation EmitterCheckBoxControlBehaviorTests

- (void)setUp {
    [super setUp];
    _controlBehavior = [[EmitterCheckBoxControlBehavior alloc] init];
    _mockCheckbox = [OCMockObject mockForClass:[NSButton class]];
    _emitterLayer = [[CAEmitterLayer alloc] init];
    
    [_controlBehavior setValue:_mockCheckbox forKey:@"checkBox"];
}

- (void)tearDown {
    _emitterLayer = nil;
    _mockCheckbox = nil;
    _controlBehavior = nil;
    [super tearDown];
}

- (void)testCustomBehaviorsCheckBoxIsNotNil {
    XCTAssertNotNil(_controlBehavior.checkBox, @"Check box should not be nil");
}

- (void)testUpdateValuesIsPassedYesWhenCheckBoxStateIsOn {
    id partialControlBehavior = [OCMockObject partialMockForObject:_controlBehavior];
    [[[_mockCheckbox stub] andReturnValue:@(NSOnState)] state];
    [[partialControlBehavior expect] updateValues:[OCMArg checkWithBlock:^BOOL(id obj) {
        XCTAssertTrue([obj boolValue] == YES, @"Is on state should pass yes to update values");
        return YES;
    }]];
    [_controlBehavior checkBoxToggled:_mockCheckbox];
    
    [partialControlBehavior verify];
}

- (void)testUpdateValuesIsPassedNoWhenCheckBoxStateIsOff {
    id partialControlBehavior = [OCMockObject partialMockForObject:_controlBehavior];
    [[[_mockCheckbox stub] andReturnValue:@(NSOffState)] state];
    [[partialControlBehavior expect] updateValues:[OCMArg checkWithBlock:^BOOL(id obj) {
        XCTAssertTrue([obj boolValue] == NO, @"Is off state should pass no to update values");
        return YES;
    }]];
    [_controlBehavior checkBoxToggled:_mockCheckbox];
    
    [partialControlBehavior verify];
}

- (void)testUpdateControlsWillSetCheckBoxStateToOff {
    _controlBehavior.emitterProperty = @"preservesDepth";
    _emitterLayer.preservesDepth = NO;
    
    [[_mockCheckbox expect] setState:NSOffState];
    
    [_controlBehavior updateControls:_emitterLayer];
    
    [_mockCheckbox verify];
}

- (void)testUpdateControlsWillSetCheckBoxStateToOn {
    _controlBehavior.emitterProperty = @"preservesDepth";
    _emitterLayer.preservesDepth = YES;
    
    [[_mockCheckbox expect] setState:NSOnState];
    
    [_controlBehavior updateControls:_emitterLayer];
    
    [_mockCheckbox verify];
}

- (void)testUpdateControlsDoesNotThrowErrorWhenPropertyCannotRespondToBoolValue {
    _controlBehavior.emitterProperty = @"transform";
    
    [[_mockCheckbox expect] setState:NSOnState];
    
    XCTAssertNoThrow([_controlBehavior updateControls:_emitterLayer], @"Update control should not throw an error if property doesn't respond to boolValue");
}

@end
