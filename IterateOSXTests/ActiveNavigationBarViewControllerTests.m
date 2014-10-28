//
//  ActiveNavigationBarViewControllerTests.m
//  IterateOSX
//
//  Created by James Wilson on 10/17/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
@import QuartzCore;

#import "ActiveNavigationBarViewController.h"

@interface ActiveNavigationBarViewControllerTests : XCTestCase

@property (strong) ActiveNavigationBarViewController *navigationBarViewController;

@end

@implementation ActiveNavigationBarViewControllerTests

- (void)setUp {
    [super setUp];
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    _navigationBarViewController = (ActiveNavigationBarViewController*)[storyboard instantiateControllerWithIdentifier:@"ActiveNavigationBarViewController"];
    [_navigationBarViewController view];
}

- (void)tearDown {
    _navigationBarViewController = nil;
    [super tearDown];
}

- (void)testViewControllerIsNotNil {
    XCTAssertNotNil(_navigationBarViewController, @"The active navigation bar view controller should not be nil.");
}

- (void)testTransformLayerButtonsFirstConstraintIsAWidthConstraint {
    NSLayoutConstraint *constraint = [_navigationBarViewController.transformLayerMenuButton.constraints firstObject];
    
    XCTAssertNotNil(constraint, @"The constraint should not be nil.");
    XCTAssertTrue(constraint.firstAttribute == NSLayoutAttributeWidth, @"The first constraint should be for width.");
}

- (void)testLayerButtonsFirstConstraintIsAWidthConstraint {
    NSLayoutConstraint *constraint = [_navigationBarViewController.layerMenuButton.constraints firstObject];
    
    XCTAssertNotNil(constraint, @"The constraint should not be nil.");
    XCTAssertTrue(constraint.firstAttribute == NSLayoutAttributeWidth, @"The first constraint should be for width.");
}

- (void)testEmitterLayerButtonsFirstConstraintIsAWidthConstraint {
    NSLayoutConstraint *constraint = [_navigationBarViewController.emitterLayerMenuButton.constraints firstObject];
    
    XCTAssertNotNil(constraint, @"The constraint should not be nil.");
    XCTAssertTrue(constraint.firstAttribute == NSLayoutAttributeWidth, @"The first constraint should be for width.");
}

- (void)testEmitterCellButtonsFirstConstraintIsAWidthConstraint {
    NSLayoutConstraint *constraint = [_navigationBarViewController.emitterCellMenuButton.constraints firstObject];
    
    XCTAssertNotNil(constraint, @"The constraint should not be nil.");
    XCTAssertTrue(constraint.firstAttribute == NSLayoutAttributeWidth, @"The first constraint should be for width.");
}

- (void)testDefaultConstraintWidthForButtonsIsZero {
    NSLayoutConstraint *transformLayerButtonConstraint = [_navigationBarViewController.transformLayerMenuButton.constraints firstObject];
    NSLayoutConstraint *layerButtonConstraint = [_navigationBarViewController.layerMenuButton.constraints firstObject];
    NSLayoutConstraint *emitterLayerButtonConstraint = [_navigationBarViewController.emitterLayerMenuButton.constraints firstObject];
    NSLayoutConstraint *emitterCellButtonConstraint = [_navigationBarViewController.emitterCellMenuButton.constraints firstObject];
    
    XCTAssertTrue(transformLayerButtonConstraint.constant == 0);
    XCTAssertTrue(layerButtonConstraint.constant == 0);
    XCTAssertTrue(emitterLayerButtonConstraint.constant == 0);
    XCTAssertTrue(emitterCellButtonConstraint.constant == 0);
}

- (void)testButtonWidthsWhenUpdateMenuWithSelectedItemReceivedCATransformLayer {
    [_navigationBarViewController updateMenuWithSelectedItem:[[CATransformLayer alloc] init]];
    
    NSLayoutConstraint *transformLayerButtonConstraint = [_navigationBarViewController.transformLayerMenuButton.constraints firstObject];
    NSLayoutConstraint *layerButtonConstraint = [_navigationBarViewController.layerMenuButton.constraints firstObject];
    NSLayoutConstraint *emitterLayerButtonConstraint = [_navigationBarViewController.emitterLayerMenuButton.constraints firstObject];
    NSLayoutConstraint *emitterCellButtonConstraint = [_navigationBarViewController.emitterCellMenuButton.constraints firstObject];
    
    XCTAssertTrue(transformLayerButtonConstraint.animator.constant == 40);
    XCTAssertTrue(layerButtonConstraint.animator.constant == 0);
    XCTAssertTrue(emitterLayerButtonConstraint.animator.constant == 0);
    XCTAssertTrue(emitterCellButtonConstraint.animator.constant == 0);
    //TODO: Need more tests on business logic for transform layer, this includes all tests below
}

- (void)testButtonWidthsWhenUpdateMenuWithSelectedItemReceivedCALayer {
    [_navigationBarViewController updateMenuWithSelectedItem:[[CALayer alloc] init]];
    
    NSLayoutConstraint *layerButtonConstraint = [_navigationBarViewController.layerMenuButton.constraints firstObject];
    NSLayoutConstraint *emitterLayerButtonConstraint = [_navigationBarViewController.emitterLayerMenuButton.constraints firstObject];
    NSLayoutConstraint *emitterCellButtonConstraint = [_navigationBarViewController.emitterCellMenuButton.constraints firstObject];
    
    XCTAssertTrue(layerButtonConstraint.animator.constant == 40);
    XCTAssertTrue(emitterLayerButtonConstraint.animator.constant == 0);
    XCTAssertTrue(emitterCellButtonConstraint.animator.constant == 0);
}

- (void)testButtonWidthsWhenUpdateMenuWithSelectedItemReceivedCAEmitterLayer {
    [_navigationBarViewController updateMenuWithSelectedItem:[[CAEmitterLayer alloc] init]];
    
    NSLayoutConstraint *layerButtonConstraint = [_navigationBarViewController.layerMenuButton.constraints firstObject];
    NSLayoutConstraint *emitterLayerButtonConstraint = [_navigationBarViewController.emitterLayerMenuButton.constraints firstObject];
    NSLayoutConstraint *emitterCellButtonConstraint = [_navigationBarViewController.emitterCellMenuButton.constraints firstObject];
    
    XCTAssertTrue(layerButtonConstraint.animator.constant == 40);
    XCTAssertTrue(emitterLayerButtonConstraint.animator.constant == 40);
    XCTAssertTrue(emitterCellButtonConstraint.animator.constant == 0);
}

- (void)testButtonWidthsWhenUpdateMenuWithSelectedItemReceivedCAEmitterCell {
    [_navigationBarViewController updateMenuWithSelectedItem:[[CAEmitterCell alloc] init]];
    
    NSLayoutConstraint *layerButtonConstraint = [_navigationBarViewController.layerMenuButton.constraints firstObject];
    NSLayoutConstraint *emitterLayerButtonConstraint = [_navigationBarViewController.emitterLayerMenuButton.constraints firstObject];
    NSLayoutConstraint *emitterCellButtonConstraint = [_navigationBarViewController.emitterCellMenuButton.constraints firstObject];
    
    XCTAssertTrue(layerButtonConstraint.animator.constant == 40);
    XCTAssertTrue(emitterLayerButtonConstraint.animator.constant == 40);
    XCTAssertTrue(emitterCellButtonConstraint.animator.constant == 40);
}

- (void)testButtonWidthsAreZeroWhenUpdateMenuWithSelectedItemReceivesNil {
    [_navigationBarViewController updateMenuWithSelectedItem:[[CALayer alloc] init]];
    [_navigationBarViewController updateMenuWithSelectedItem:nil];
    
    NSLayoutConstraint *layerButtonConstraint = [_navigationBarViewController.layerMenuButton.constraints firstObject];
    NSLayoutConstraint *emitterLayerButtonConstraint = [_navigationBarViewController.emitterLayerMenuButton.constraints firstObject];
    NSLayoutConstraint *emitterCellButtonConstraint = [_navigationBarViewController.emitterCellMenuButton.constraints firstObject];
    
    XCTAssertTrue(layerButtonConstraint.constant == 0);
    XCTAssertTrue(emitterLayerButtonConstraint.constant == 0);
    XCTAssertTrue(emitterCellButtonConstraint.constant == 0);
}

- (void)testLayerButtonIsSelectedWhenUpdateMenuWithSelectedItemReceivesALayer {
    XCTAssertTrue(_navigationBarViewController.layerMenuButton.state == NSOffState, @"The layer button should be toggled off by default.");
    [_navigationBarViewController updateMenuWithSelectedItem:[[CALayer alloc] init]];
    
    XCTAssertTrue(_navigationBarViewController.layerMenuButton.state == NSOnState, @"The layer button should be toggled on.");
}

- (void)testEmitterLayerButtonIsSelectedWhenUpdateMenuWithSelectedItemReceivesAnEmitterLayer {
    XCTAssertTrue(_navigationBarViewController.emitterLayerMenuButton.state == NSOffState, @"The emitter layer button should be toggled off by default.");
    [_navigationBarViewController updateMenuWithSelectedItem:[[CAEmitterLayer alloc] init]];
    
    XCTAssertTrue(_navigationBarViewController.emitterLayerMenuButton.state == NSOnState, @"The emitter layer button should be toggled on.");
}

- (void)testEmitterCellButtonIsSelectedWhenUpdateMenuWithSelectedItemReceivesAnEmitterCell {
    XCTAssertTrue(_navigationBarViewController.emitterCellMenuButton.state == NSOffState, @"The emitter cells button should be toggled off by default.");
    [_navigationBarViewController updateMenuWithSelectedItem:[[CAEmitterCell alloc] init]];
    
    XCTAssertTrue(_navigationBarViewController.emitterCellMenuButton.state == NSOnState, @"The emitter cells button should be toggled on.");
}

- (void)testLayerButtonSelectedIsCalledWhenUpdateMenuWithSelectedItemReceivesAnEmitterLayer {
    id partialMockViewController = [OCMockObject partialMockForObject:_navigationBarViewController];
    [[partialMockViewController expect] layerButtonSelected:[OCMArg checkWithBlock:^BOOL(id obj) {
        return obj == _navigationBarViewController.layerMenuButton;
    }]];
    
    [_navigationBarViewController updateMenuWithSelectedItem:[[CALayer alloc] init]];
    
    [partialMockViewController verify];
}

- (void)testEmitterLayerButtonSelectedIsCalledWhenUpdateMenuWithSelectedItemReceivesAnEmitterLayer {
    id partialMockViewController = [OCMockObject partialMockForObject:_navigationBarViewController];
    [[partialMockViewController expect] emitterLayerButtonSelected:[OCMArg checkWithBlock:^BOOL(id obj) {
        return obj == _navigationBarViewController.emitterLayerMenuButton;
    }]];
    
    [_navigationBarViewController updateMenuWithSelectedItem:[[CAEmitterLayer alloc] init]];
    
    [partialMockViewController verify];
}

- (void)testEmitterCellButtonSelectedIsCalledWhenUpdateMenuWithSelectedItemReceivesAnEmitterCell {
    id partialMockViewController = [OCMockObject partialMockForObject:_navigationBarViewController];
    [[partialMockViewController expect] EmitterCellButtonSelected:[OCMArg checkWithBlock:^BOOL(id obj) {
        return obj == _navigationBarViewController.emitterCellMenuButton;
    }]];
    
    [_navigationBarViewController updateMenuWithSelectedItem:[[CAEmitterCell alloc] init]];
    
    [partialMockViewController verify];
}

//TODO: Write unit tests for button toggles

//TODO: Add keyboard shortcuts for buttons and write unit tests



@end
