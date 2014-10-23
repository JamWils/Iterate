//
//  EmitterColorControlBehaviorTests.m
//  IterateOSX
//
//  Created by James Wilson on 9/28/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import QuartzCore;

#import "EmitterColorControlBehavior.h"
#import "AlphaColorWell.h"

@interface EmitterColorControlBehaviorTests : XCTestCase

@property (strong) EmitterColorControlBehavior *colorBehavior;
@property (strong) id mockColorWell;

@end

@implementation EmitterColorControlBehaviorTests

- (void)setUp {
    [super setUp];
    _colorBehavior = [[EmitterColorControlBehavior alloc] init];
    _mockColorWell = [OCMockObject mockForClass:[AlphaColorWell class]];
    
    _colorBehavior.colorWell = _mockColorWell;
}

- (void)tearDown {
    _mockColorWell = nil;
    _colorBehavior = nil;
    [super tearDown];
}

- (void)testColorBehaviorDoesNotEqualNil {
    XCTAssertNotNil(_colorBehavior, @"The color behavior should not be nil");
}

- (void)testColorWellIsNotNil {
    //TODO: Should this test be delete an assert thrown in the class so I know whether the color well was connected in IB?
    XCTAssertNotNil(_colorBehavior.colorWell, @"The color well should be set");
}

- (void)testColorSelectedCallsUpdateValueOnColorBehavior {
    [[[_mockColorWell stub] andReturn:[NSColor greenColor]] color];
    
    id colorBehaviorPartialMock = [OCMockObject partialMockForObject:_colorBehavior];
    [[colorBehaviorPartialMock expect] updateValues:[OCMArg checkWithBlock:^BOOL(id obj) {
        CGColorRef cgColor = (__bridge CGColorRef)obj;
        bool result = cgColor == [NSColor greenColor].CGColor;
        if (!result) {
            XCTAssertTrue(result, @"The color well color should be equal to the color passed to updateValues");
        }
        return result;
    }]];
    
    [colorBehaviorPartialMock colorSelected:_mockColorWell];
    
    [colorBehaviorPartialMock verify];
}

- (void)testUpdateControl {
    CALayer *testLayer = [[CALayer alloc] init];
    testLayer.shadowColor = [NSColor orangeColor].CGColor;
    _colorBehavior.emitterProperty = @"shadowColor";
    
    [[_mockColorWell expect] setColor:[OCMArg checkWithBlock:^BOOL(id obj) {
        NSColor *color = (NSColor*)obj;
        BOOL result = [color isEqual:[NSColor orangeColor]];
        if (!result) {
            XCTAssert(result, @"The color passed in from the CA Layer should update the well color.");
        }
        return result;
    }]];
    
    [_colorBehavior updateControls:testLayer];
    
    [_mockColorWell verify];
}



@end
