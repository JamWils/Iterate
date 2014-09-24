//
//  EmitterFloatControlBehaviorTests.m
//  IterateOSX
//
//  Created by James Wilson on 9/24/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

//#import "EmitterFloatControlBehavior.h"
//#import "IterateOSXFramework.h"
#import <IterateOSXFramework/IterateOSXFramework.h>

@interface EmitterFloatControlBehaviorTests : XCTestCase

@property (strong) EmitterFloatControlBehavior *emitterBehavior;

@property (strong) NSSlider *slider;
@property (strong) NSStepper *stepper;
@property (strong) NSTextField *label;
@property (strong) NSTextField *textField;
@property (strong) NSNumberFormatter *numberFormatter;

@end

@implementation EmitterFloatControlBehaviorTests
//
- (void)setUp {
    [super setUp];
    _emitterBehavior = [[EmitterFloatControlBehavior alloc] init];
    _label = [[NSTextField alloc] initWithFrame:NSRectFromCGRect(CGRectMake(0,0,0,0))];
    _emitterBehavior.label = _label;
    
//    [_emitterBehavior awakeFromNib];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    _slider = nil;
    _stepper = nil;
    _label = nil;
    _textField = nil;
    _numberFormatter = nil;
    
    _emitterBehavior = nil;
    [super tearDown];
}

- (void)testLabelStringValueEqualsBehaviorsNameProperty {
    _emitterBehavior.name = @"Test";
    [_emitterBehavior awakeFromNib];
    
    XCTAssertTrue([_emitterBehavior.stringValue isEqualToString:@"Test"], @"The Label string value should match the behavior name property");
}

@end
