//
//  EmitterFloatControlBehaviorTests.m
//  IterateOSX
//
//  Created by James Wilson on 9/24/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <QuartzCore/QuartzCore.h>
@import IterateOSXFramework;

#import <IterateOSXFramework/IterateOSXFramework.h>

@interface EmitterFloatControlBehaviorTests : XCTestCase

@property (strong) EmitterFloatControlBehavior *emitterBehavior;

@property (strong) id mockSlider;
@property (strong) id mockStepper;
@property (strong) id mockLabel;
@property (strong) id mockTextField;
@property (strong) NSNumberFormatter *numberFormatter;

@property (strong) CAEmitterCell *emitterCell;

@property (strong) NSNotificationCenter *notificationCenter;
@property (strong) id observerMock;


@end

@implementation EmitterFloatControlBehaviorTests
//
- (void)setUp {
    [super setUp];
    _emitterBehavior = [[EmitterFloatControlBehavior alloc] init];
    
    _mockLabel = [OCMockObject mockForClass:[NSTextField class]];
    [_emitterBehavior setValue:_mockLabel forKey:@"label"];
    
    _mockTextField = [OCMockObject mockForClass:[NSTextField class]];
    _mockSlider = [OCMockObject mockForClass:[NSSlider class]];
    _mockStepper = [OCMockObject mockForClass:[NSStepper class]];
    
    self.emitterCell = [[CAEmitterCell alloc] init];
    self.notificationCenter = [[NSNotificationCenter alloc] init];
    self.observerMock = [OCMockObject observerMock];
}

- (void)tearDown {
    _observerMock = nil;
    _observerMock = nil;
    
    _emitterCell = nil;
    _mockSlider = nil;
    _mockStepper = nil;
    _mockLabel = nil;
    _mockTextField = nil;
    _numberFormatter = nil;
    
    _emitterBehavior = nil;
    [super tearDown];
}

- (void)testLabelIsNotNull {
    XCTAssertNotNil(self.emitterBehavior.label);
}

- (void)testLabelStringIsSet {
    [[self.mockLabel expect] setStringValue:OCMOCK_ANY];
    [_emitterBehavior awakeFromNib];
    
    XCTAssertNoThrow([self.mockLabel verify], @"The Label string value should be set with a value");
}

- (void)testLabelStringValueEqualsBehaviorsNameProperty {
    _emitterBehavior.name = @"Test";

    [[self.mockLabel expect] setStringValue:@"Test"];
    [_emitterBehavior awakeFromNib];
    
    XCTAssertNoThrow([self.mockLabel verify], @"The Label string value should match the behavior name property");
}

- (void)testTextFieldIsNotNull {
    [_emitterBehavior setValue:_mockTextField forKey:@"textField"];
    XCTAssertNotNil(self.emitterBehavior.textField);
}

- (void)testSliderIsNotNull {
    [_emitterBehavior setValue:_mockSlider forKey:@"slider"];
    XCTAssertNotNil(self.emitterBehavior.slider);
}

- (void)testStepperIsNotNull {
    [_emitterBehavior setValue:_mockStepper forKey:@"stepper"];
    XCTAssertNotNil(self.emitterBehavior.stepper);
}

- (void)testTextFieldIsUpdatedWhenSelectedViewNotificationIsFired {
    _emitterBehavior.defaultValue = 0;
    _emitterBehavior.emitterProperty = @"spin";
    _emitterCell.spin = 500;
    
    [[self.mockTextField expect] setFloatValue:_emitterCell.spin];
    [_emitterBehavior setValue:_mockTextField forKey:@"textField"];

    [_emitterBehavior updateControls:_emitterCell];
    
    [self.mockTextField verify];
}

- (void)testSliderIsUpdatedWhenSelectedViewNotificationIsFired {
    _emitterBehavior.defaultValue = 0;
    _emitterBehavior.emitterProperty = @"spin";
    _emitterCell.spin = 500;
    
    [[self.mockSlider expect] setFloatValue:_emitterCell.spin];
    [_emitterBehavior setValue:_mockSlider forKey:@"slider"];
    
    [_emitterBehavior updateControls:_emitterCell];
    
    [self.mockSlider verify];
}

- (void)testStepperIsUpdatedWhenSelectingViewNotificationIsFired {
    _emitterBehavior.defaultValue = 0;
    _emitterBehavior.emitterProperty = @"spin";
    _emitterCell.spin = 500;
    
    [[self.mockStepper expect] setFloatValue:_emitterCell.spin];
    [_emitterBehavior setValue:_mockStepper forKey:@"stepper"];
    
    [_emitterBehavior updateControls:_emitterCell];
    
    [self.mockStepper verify];
}


@end
