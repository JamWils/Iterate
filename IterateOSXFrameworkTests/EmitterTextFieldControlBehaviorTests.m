//
//  EmitterTextFieldControlBehaviorTests.m
//  IterateOSX
//
//  Created by James Wilson on 9/28/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
@import QuartzCore;

#import "EmitterTextFieldControlBehavior.h"

@interface EmitterTextFieldControlBehaviorTests : XCTestCase

@property (strong) id mockTextField;
@property (strong) EmitterTextFieldControlBehavior *emitterControl;

@end

@implementation EmitterTextFieldControlBehaviorTests

- (void)setUp {
    [super setUp];
    _emitterControl = [[EmitterTextFieldControlBehavior alloc] init];
    _mockTextField = [OCMockObject mockForClass:[NSTextField class]];
    _emitterControl.textField = _mockTextField;
}

- (void)tearDown {
    _emitterControl = nil;
    [super tearDown];
}

- (void)testTextFieldUpdatedWhenUpdateControlsIsCalled {
    _emitterControl.emitterProperty = @"name";
    CALayer *layer = [[CALayer alloc] init];
    layer.name = @"Test";
    [[_mockTextField expect] setStringValue:@"Test"];
    [_emitterControl updateControls:layer];
    
    [_mockTextField verify];
}

- (void)testTextFieldUpdatedDoesNotThrowErrorWhenEmitterPropertyNameIsMissing {
    [[_mockTextField expect] setStringValue:@"Test"];
    CALayer *layer = [[CALayer alloc] init];
    layer.name = @"Test";

    XCTAssertNoThrow([_emitterControl updateControls:layer], @"An error should not occur.");
}

- (void)testTextFieldActionTextFieldEditedCallsUpdateValueOnControl {
    id emitterControl = [OCMockObject partialMockForObject:[[EmitterTextFieldControlBehavior alloc] init]];
    [[[_mockTextField stub] andReturn:[OCMArg any]] stringValue];
    [[emitterControl expect] updateValues:[OCMArg any]];
    
    [emitterControl textFieldEdited:_mockTextField];
    
    XCTAssertNoThrow([emitterControl verify], @"Update Value should be called on emitter control");
}

@end
