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
#import "IterateMacDocument.h"
#import "IterateWindowController.h"

@interface IterateInsertViewControllerTests : XCTestCase

@property (strong) IterateInsertViewControllerOSX *viewController;
@property (strong) id partialMockInsertController;
@property (strong) id mockIterateDocument;

@property (strong) id mockWindowController;

@end

@implementation IterateInsertViewControllerTests

- (void)setUp {
    [super setUp];
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    _viewController = [storyboard instantiateControllerWithIdentifier:@"IterateInsertViewController"];
    [_viewController view];
    
//    _mockIterateDocument = [OCMockObject mockForClass:[IterateMacDocument class]];
    _mockWindowController = [OCMockObject mockForClass:[IterateWindowController class]];
    _viewController.sharedViewController.parentWindow = _mockWindowController;
//    _viewController.document = _mockIterateDocument;
    
}

- (void)tearDown {
    _mockWindowController = nil;
//    _mockIterateDocument = nil;
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



@end
