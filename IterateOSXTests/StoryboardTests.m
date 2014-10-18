//
//  StoryboardTests.m
//  IterateOSX
//
//  Created by James Wilson on 10/11/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

@import IterateOSXFramework;

@interface StoryboardTests : XCTestCase

@property (strong) NSStoryboard *mainStoryboard;

@end

@implementation StoryboardTests

- (void)setUp {
    [super setUp];
    _mainStoryboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
}

- (void)tearDown {
    _mainStoryboard = nil;
    [super tearDown];
}

- (void)testMainStoryboardIsNotNil {
    XCTAssert(_mainStoryboard, @"Storyboard should not be nil");
}

- (void)testArrayForLayerViewsAreAllContainerLayoutViews {
    NSArray *layerInformation = [CategoryInformation arrayForLayer];
    
    [layerInformation enumerateObjectsUsingBlock:^(CategoryInformation *categoryInfo, NSUInteger idx, BOOL *stop) {
        NSViewController *viewController = [_mainStoryboard instantiateControllerWithIdentifier:categoryInfo.storyboardIdentifier];
        XCTAssertTrue([viewController.view isKindOfClass:[ContainerLayoutView class]], @"%@ view controller's view should be a container layout view.", categoryInfo.storyboardIdentifier);
    }];
    
    XCTAssertTrue([layerInformation count] > 0, @"The array count should be greater than zero");
}

- (void)testArrayForEmitterLayerViewsAreAllContainerLayoutViews {
    NSArray *emitterLayerInformation = [CategoryInformation arrayForEmitterLayer];
    
    [emitterLayerInformation enumerateObjectsUsingBlock:^(CategoryInformation *categoryInfo, NSUInteger idx, BOOL *stop) {
        NSViewController *viewController = [_mainStoryboard instantiateControllerWithIdentifier:categoryInfo.storyboardIdentifier];
        XCTAssertTrue([viewController.view isKindOfClass:[ContainerLayoutView class]], @"%@ view controller's view should be a container layout view.", categoryInfo.storyboardIdentifier);
    }];
    
    XCTAssertTrue([emitterLayerInformation count] > 0, @"The array count should be greater than zero");
}

- (void)testArrayForEmitterCellsViewsAreAllContainerLayoutViews {
    NSArray *emitterCellsInformation = [CategoryInformation arrayForEmitterCells];
    
    [emitterCellsInformation enumerateObjectsUsingBlock:^(CategoryInformation *categoryInfo, NSUInteger idx, BOOL *stop) {
        NSViewController *viewController = [_mainStoryboard instantiateControllerWithIdentifier:categoryInfo.storyboardIdentifier];
        XCTAssertTrue([viewController.view isKindOfClass:[ContainerLayoutView class]], @"%@ view controller's view should be a container layout view.", categoryInfo.storyboardIdentifier);
    }];
    
    XCTAssertTrue([emitterCellsInformation count] > 0, @"The array count should be greater than zero");
}



@end
