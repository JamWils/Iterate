//
//  ViewControllerTests.m
//  IterateOSX
//
//  Created by James Wilson on 9/30/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
@import QuartzCore;


#import "ContentViewController.h"
#import "LayerContentViewControllerProtocol.h"

@interface ContentViewControllerTests : XCTestCase

@property (strong) ContentViewController *viewController;

@end

@implementation ContentViewControllerTests

- (void)setUp {
    [super setUp];
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    _viewController = (ContentViewController*)[storyboard instantiateControllerWithIdentifier:@"ContentViewController"];
    [_viewController view];
    
    
    CAEmitterLayer *emitterLayer = [[CAEmitterLayer alloc] init];
    emitterLayer.name = @"Test Layer";
    emitterLayer.emitterSize = CGSizeMake(100, 100);
    
    CAEmitterCell *emitterCell = [[CAEmitterCell alloc] init];
    emitterCell.name = @"Test Cell";
    emitterCell.velocity = 100;
    emitterLayer.emitterCells = @[emitterCell];
    
    _viewController.activeLayer = emitterLayer;
    _viewController.selectedItem = emitterCell;
    _viewController.layers = @[emitterLayer];
    
}

- (void)tearDown {
    _viewController = nil;
    [super tearDown];
}

- (void)testContentViewControllerIsNotNil {
    XCTAssertNotNil(_viewController, @"Content View Controller should not be nil");
}

- (void)testContentViewControllerConformsToContentViewControllerProtocol {
    XCTAssertTrue([_viewController conformsToProtocol:@protocol(LayerContentViewControllerProtocol)], @"Content View Controller should conform to Layer Content View Controller protocol.");
}

- (void)testUpdatePropertyUpdatesActiveLayerWhenIsCellValueIsNo {
    CGSize newSize = CGSizeMake(500, 500);
    [_viewController updateEmitterCellProperty:@"emitterSize" withValue:[NSValue valueWithSize:newSize] isCellValue:NO];
    
    CGSize updatedSize = [[_viewController.activeLayer valueForKey:@"emitterSize"] sizeValue];
    XCTAssertTrue(CGSizeEqualToSize(updatedSize, newSize), @"The active layers size should match the new size.");
}

- (void)testUpdatePropertyDoesNotUpdateActiveLayerWhenCellValueIsYes {
    CGSize newSize = CGSizeMake(500, 500);
    [_viewController updateEmitterCellProperty:@"emitterSize" withValue:[NSValue valueWithSize:newSize] isCellValue:YES];
    
    CGSize updatedSize = [[_viewController.activeLayer valueForKey:@"emitterSize"] sizeValue];
    XCTAssertFalse(CGSizeEqualToSize(updatedSize, newSize), @"The active layers size should not match the new size.");
}

- (void)testUpdatePropertyUpdatesSelectedItemWhenIsCellValueIsYes {
    CGFloat newVelocity = 1000;
    _viewController.keyPathForSelectedItem = @"emitterCells.Test Cell.";
    [_viewController updateEmitterCellProperty:@"velocity" withValue:@(newVelocity) isCellValue:YES];
    
    float updatedVelocity = [[_viewController.selectedItem valueForKey:@"velocity"] floatValue];
    XCTAssertTrue(newVelocity == updatedVelocity, @"The selected items velocity should match the new velocity.");
}

- (void)testUpdatePropertyDoesNotUpdateSelectedItemWhenIsCellValueIsYes {
    CGFloat newVelocity = 1000;
    [_viewController updateEmitterCellProperty:@"velocity" withValue:@(newVelocity) isCellValue:NO];
    
    float updatedVelocity = [[_viewController.selectedItem valueForKey:@"velocity"] floatValue];
    XCTAssertFalse(newVelocity == updatedVelocity, @"The selected item's velocity should not match new velocity.");
}

- (void)testUpdatePropertyUpdatesActiveLayerWhenSelectedItemIsNotEmitterCell {
    _viewController.selectedItem = _viewController.activeLayer;
    CGSize newSize = CGSizeMake(500, 500);
    [_viewController updateEmitterCellProperty:@"emitterSize" withValue:[NSValue valueWithSize:newSize] isCellValue:YES];
    
    CGSize updatedSize = [[_viewController.activeLayer valueForKey:@"emitterSize"] sizeValue];
    XCTAssertTrue(CGSizeEqualToSize(updatedSize, newSize), @"The active layers emitter size should equal new size when selected item is not a CAEmitterCell.");
}

@end
