//
//  ViewControllerTests.m
//  IterateOSX
//
//  Created by James Wilson on 11/4/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ViewController.h"
@import IterateiOSFramework;

@interface ViewControllerTests : XCTestCase

@property (strong, nonatomic) ViewController *viewController;

@end

@implementation ViewControllerTests

- (void)setUp {
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    _viewController = [storyboard instantiateInitialViewController];
}

- (void)tearDown {
    _viewController = nil;
    [super tearDown];
}

- (void)testViewControllerIsNotNil {
    XCTAssertNotNil(_viewController, @"The view controller should not be nil");
}

- (void)testViewControllerConformsToMainCoordinatorProtocol {
    XCTAssertTrue([_viewController conformsToProtocol:@protocol(MainCoordinatorProtocol)], @"The view controller should conform to main coordinator protocol");
}

- (void)testCanvasViewControllerIsNotNil {
    
    XCTAssertNotNil(_viewController.canvasViewController);
}

@end
