//
//  ActiveNavigationBarViewControllerTests.m
//  IterateOSX
//
//  Created by James Wilson on 10/17/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

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

@end
