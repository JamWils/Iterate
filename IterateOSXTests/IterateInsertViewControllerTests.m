//
//  IterateInsertViewControllerTests.m
//  IterateOSX
//
//  Created by James Wilson on 9/29/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
@import QuartzCore;

#import "IterateInsertViewControllerOSX.h"

@interface IterateInsertViewControllerTests : XCTestCase

@property (strong) IterateInsertViewControllerOSX *viewController;

@end

@implementation IterateInsertViewControllerTests

- (void)setUp {
    [super setUp];
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    _viewController = [storyboard instantiateControllerWithIdentifier:@"IterateInsertViewController"];
    [_viewController view];
    
    NSArray *layers = @[[[CAEmitterLayer alloc] init]];
    _viewController.sharedViewController = [[IterateInsertSharedViewController alloc] initWithCoordinator:nil layers:[layers mutableCopy] selectedItem:layers[0] canvasBounds:CGRectZero];
}

- (void)tearDown {
    _viewController = nil;
    [super tearDown];
}

- (void)testIterateInsertViewControllerIsNotNil {
    XCTAssertNotNil(_viewController, @"The view controller should not be nil.");
}

- (void)testAddTransformButtonIsNotNil {
    XCTAssertNotNil(_viewController.addTransformLayerButton, @"Add transform layer button should not be nil.");
}

- (void)testAddLayerButtonIsNotNil {
    XCTAssertNotNil(_viewController.addLayerButton, @"Add Layer button should not be nil.");
}

- (void)testAddEmitterCellButtonIsNotNil {
    XCTAssertNotNil(_viewController.addEmitterCellButton, @"Add Emitter Cell button should not be nil.");
}

- (void)testAddEmitterCellButtonIsDisabledWhenSelectedItemIsNil {
    _viewController.sharedViewController.selectedItem = nil;
    [_viewController viewWillAppear];
    
    XCTAssertFalse(_viewController.addEmitterCellButton.enabled, @"The add emitter cell button should be disabled when selected item is nil");
}

- (void)testAddEmitterCellButtonIsEnabledWhenSelectedItemIsNotNil {
    _viewController.sharedViewController.selectedItem = [[CAEmitterCell alloc] init];
    [_viewController viewWillAppear];
    
    XCTAssertTrue(_viewController.addEmitterCellButton.enabled, @"The add emitter cell button should be enabled when selected item is not nil");
}

- (void)testAddLayerButtonIsDisabledWhenSelectedItemIsEmitterCell {
    _viewController.sharedViewController.selectedItem = [[CAEmitterCell alloc] init];
    [_viewController viewWillAppear];
    
    XCTAssertFalse(_viewController.addLayerButton.enabled, @"The add layer button should be disabled when selected item is an emitter cell");
}

- (void)testAddTransformLayerButtonIsDisabledWhenSelectedItemIsEmitterCell {
    _viewController.sharedViewController.selectedItem = [[CAEmitterCell alloc] init];
    [_viewController viewWillAppear];
    
    XCTAssertFalse(_viewController.addTransformLayerButton.enabled, @"The add transform layer button should be disabled when selected item is an emitter cell");
}

- (void)testAddEmitterLayerButtonIsDisabledWhenSelectedItemIsEmitterCell {
    _viewController.sharedViewController.selectedItem = [[CAEmitterCell alloc] init];
    [_viewController viewWillAppear];
    
    XCTAssertFalse(_viewController.addEmitterLayerButton.enabled, @"The add emitter layer button should be disabled when selected item is an emitter cell");
}

- (void)testAddLayerButtonIsEnabledWhenSelectedItemIsNotNil {
    _viewController.sharedViewController.selectedItem = nil;
    [_viewController viewWillAppear];
    
    XCTAssertTrue(_viewController.addLayerButton.enabled, @"The add emitter cell button should be enabled when selected item is not nil");
}

#pragma mark Target-Action Tests

- (void)testAddLayerButtonHasTargetActionWithSharedViewController {
    [_viewController viewWillAppear];
    
    XCTAssertEqual(_viewController.sharedViewController, _viewController.addLayerButton.target, @"The target should equal shared view controller.");
    XCTAssertTrue(_viewController.addLayerButton.action == @selector(addLayer:), "The action for layer button should be add layer");
}

- (void)testAddTransformLayerButtonHasTargetActionWithSharedViewController {
    [_viewController viewWillAppear];
    
    XCTAssertEqual(_viewController.sharedViewController, _viewController.addTransformLayerButton.target, @"The target should equal shared view controller.");
    XCTAssertTrue(_viewController.addTransformLayerButton.action == @selector(addTransformLayer:), "The action for transform layer button should be add layer");
}

- (void)testAddEmitterLayerButtonHasTargetActionWithSharedViewController {
    [_viewController viewWillAppear];
    
    XCTAssertEqual(_viewController.sharedViewController, _viewController.addEmitterLayerButton.target, @"The target should equal shared view controller.");
    XCTAssertTrue(_viewController.addEmitterLayerButton.action == @selector(addEmitterLayer:), "The action for emitter layer button should be add emitter layer");
}

- (void)testAddEmitterCellButtonHasTargetActionWithSharedViewController {
    [_viewController viewWillAppear];
    
    XCTAssertEqual(_viewController.sharedViewController, _viewController.addEmitterCellButton.target, @"The target should equal shared view controller.");
    XCTAssertTrue(_viewController.addEmitterCellButton.action == @selector(addEmitterCell:), "The action for emitter cell button should be add emitter cell");
}



@end
