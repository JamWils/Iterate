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

#import "IterateInsertViewController.h"
#import "IterateDocument.h"

@interface IterateInsertViewControllerTests : XCTestCase

@property (strong) IterateInsertViewController *viewController;
@property (strong) id partialMockInsertController;
@property (strong) id mockIterateDocument;

@end

@implementation IterateInsertViewControllerTests

- (void)setUp {
    [super setUp];
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    _viewController = [storyboard instantiateControllerWithIdentifier:@"IterateInsertViewController"];
    [_viewController view];
    
    _mockIterateDocument = [OCMockObject mockForClass:[IterateDocument class]];
    _viewController.document = _mockIterateDocument;
    
}

- (void)tearDown {
    _mockIterateDocument = nil;
    _viewController = nil;
    [super tearDown];
}

- (void)testIterateInsertViewControllerIsNotNil {
    XCTAssertNotNil(_viewController, @"The view controller should not be nil.");
}

- (void)testAddLayerButtonIsNotNil {
    XCTAssertNotNil(_viewController.addLayerButton, @"Add Layer button should not be nil.");
}

- (void)testAddEmitterCellButtonIsNotNil {
    XCTAssertNotNil(_viewController.addEmitterCellButton, @"Add Emitter Cell button should not be nil.");
}

- (void)testAddEmitterCellButtonIsDisabledWhenSelectedItemIsNil {
    _viewController.selectedItem = nil;
    [_viewController viewWillAppear];
    
    XCTAssertFalse(_viewController.addEmitterCellButton.enabled, @"The add emitter cell button should be disabled when selected item is nil");
}

- (void)testAddEmitterCellButtonIsEnabledWhenSelectedItemIsNotNil {
    _viewController.selectedItem = [[CAEmitterCell alloc] init];
    [_viewController viewWillAppear];
    
    XCTAssertTrue(_viewController.addEmitterCellButton.enabled, @"The add emitter cell button should be enabled when selected item is not nil");
}

- (void)testEmitterLayerIsAdded {
    _viewController.selectedItem = nil;
    _viewController.canvasBounds = CGRectMake(0, 0, 10, 10);
    NSMutableArray *layers = [[NSMutableArray alloc] init];
    [[[_mockIterateDocument stub] andReturn:layers] mutableArrayValueForKey:@"layers"];
    
    [_viewController addEmitterLayer:nil];
    
    CAEmitterLayer *layer = layers[0];
    XCTAssertNotNil(layer, @"An emitter layer should have been added to the document.");
    XCTAssertTrue(CGSizeEqualToSize(CGSizeMake(30, 30), layer.emitterSize), @"The default emitter size for new layer should by 30 x 30.");
    XCTAssertTrue(layer.renderMode == kCAEmitterLayerAdditive, @"The default layer mode should be additive.");
    XCTAssertTrue(layer.emitterShape == kCAEmitterLayerPoint, @"The default shape should be point.");
    XCTAssertTrue(CGPointEqualToPoint(layer.emitterPosition, CGPointMake(CGRectGetMidX(_viewController.canvasBounds), CGRectGetMidY(_viewController.canvasBounds))), @"The partical should be positioned in the center of the canvas.");
    XCTAssertTrue([layer.name isEqualToString:@"emitterLayer"], @"The first emitter layer should be named emitterLayer");
}

- (void)testNewEmitterLayerHasACellAdded {
    _viewController.selectedItem = nil;
    _viewController.canvasBounds = CGRectMake(0, 0, 10, 10);
    NSMutableArray *layers = [[NSMutableArray alloc] init];
    [[[_mockIterateDocument stub] andReturn:layers] layers];
    [[[_mockIterateDocument stub] andReturn:layers] mutableArrayValueForKey:@"layers"];
    
    [_viewController addEmitterLayer:nil];
    
    CAEmitterCell *emitterCell = [layers[0] valueForKey:@"emitterCells"][0];
    XCTAssertNotNil(emitterCell, @"An emitter cell should be added to a new emitter layer.");
    XCTAssertTrue(emitterCell.birthRate == 20, @"The default birthrate should be 20.");
    XCTAssertTrue(emitterCell.lifetime == 1, @"The default lifetime should be 1.");
    XCTAssertTrue(emitterCell.lifetimeRange == 1, @"The default lifetime range should be 1.");
    XCTAssertTrue(emitterCell.velocity == 0, @"The default velocity should be 0.");
    XCTAssertTrue([emitterCell.name isEqualToString:@"emitterCell"], @"The first emitter cell should be named emitterCell.");
}

- (void)testNewEmitterCellNotAddedWhenSelectedItemEqualsNil {
    _viewController.selectedItem = nil;
    NSMutableArray *layers = [[NSMutableArray alloc] init];
    [[[_mockIterateDocument stub] andReturn:layers] layers];
    [[[_mockIterateDocument stub] andReturn:layers] mutableArrayValueForKey:@"layers"];
    
    [_viewController addEmitterLayer:nil];
    [_viewController addEmitterCell:nil];
    
    NSArray *emitterCells = [layers[0] valueForKey:@"emitterCells"];
    XCTAssertTrue([emitterCells count] == 1, @"A second emitter cell will not be added when selected item is nil");
}

- (void)testNewEmitterCellIsAddedToSelectedItem {
    _viewController.selectedItem = nil;
    NSMutableArray *layers = [[NSMutableArray alloc] init];
    [[[_mockIterateDocument stub] andReturn:layers] layers];
    [[[_mockIterateDocument stub] andReturn:layers] mutableArrayValueForKey:@"layers"];
    
    [_viewController addEmitterLayer:nil];
    _viewController.selectedItem = layers[0];
    [_viewController addEmitterCell:nil];
    
    NSArray *emitterCells = [layers[0] valueForKey:@"emitterCells"];
    XCTAssertTrue([emitterCells count] == 2, @"A second emitter cell will be added when the selected item is an emitter layer");
}

- (void)testNewEmitterCellNameIsDifferentFromPriorCells {
    _viewController.selectedItem = nil;
    NSMutableArray *layers = [[NSMutableArray alloc] init];
    [[[_mockIterateDocument stub] andReturn:layers] layers];
    [[[_mockIterateDocument stub] andReturn:layers] mutableArrayValueForKey:@"layers"];
    
    [_viewController addEmitterLayer:nil];
    _viewController.selectedItem = layers[0];
    [_viewController addEmitterCell:nil];
    [_viewController addEmitterCell:nil];
    
    NSArray *emitterCells = [layers[0] valueForKey:@"emitterCells"];
    
    CAEmitterCell *cellTwo = emitterCells[1];
    CAEmitterCell *cellThree = emitterCells[2];
    XCTAssertTrue([cellTwo.name isEqualToString:@"emitterCell2"], @"The second emitter cell should be named emitterCell02");
    XCTAssertTrue([cellThree.name isEqualToString:@"emitterCell3"], @"The second emitter cell should be named emitterCell03");
}

@end
