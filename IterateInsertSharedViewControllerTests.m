//
//  IterateInsertSharedViewControllerTests.m
//  IterateOSX
//
//  Created by James Wilson on 11/1/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "MainCoordinatorProtocol.h"
#import "IterateInsertSharedViewController.h"

@interface IterateInsertSharedViewControllerTests : XCTestCase

@property (strong) IterateInsertSharedViewController *viewController;

@property (strong) id mockWindowController;

@property (strong) NSMutableArray *layers;
@property (strong) id selectedItem;

@end

@implementation IterateInsertSharedViewControllerTests

- (void)setUp {
    [super setUp];
    
    _layers = [[NSMutableArray alloc] init];
    _selectedItem = [[CAEmitterLayer alloc] init];
    _mockWindowController = OCMProtocolMock(@protocol(MainCoordinatorProtocol));
    CGRect canvasBounds = CGRectMake(0, 0, 10, 10);
    
    _viewController = [[IterateInsertSharedViewController alloc] initWithCoordinator:_mockWindowController layers:_layers selectedItem:_selectedItem canvasBounds:canvasBounds ];
}

- (void)tearDown {
    _layers = nil;
    _selectedItem = nil;
    _mockWindowController = nil;
    _viewController = nil;
    [super tearDown];
}

#pragma mark Initializer Unit Tests

- (void)testInitReturnsNil {
    _viewController = [[IterateInsertSharedViewController alloc] init];
    XCTAssertNil(_viewController, @"Init with no parameters should return nil.");
}

- (void)testInjectedParametersWereSetToProperties {
    XCTAssertEqualObjects(_layers, _viewController.layers, @"The layers property should be set to the value passed into the initializer");
    XCTAssertEqualObjects(_selectedItem, _viewController.selectedItem, @"The selected item property should be to the value pass into the initializer");
    XCTAssertTrue(CGRectEqualToRect(_viewController.canvasBounds, CGRectMake(0, 0, 10, 10)), @"The canvas bounds should be equal");
    XCTAssertEqualObjects(_viewController.parentWindow, _mockWindowController);
}

#pragma mark Add Layer Unit Tests

- (void)testLayerIsAddedToArrayWhenSelectedItemIsNil {
    NSUInteger layersCount = _viewController.layers.count;
    _viewController.selectedItem = nil;
    
    [_viewController addLayer:nil];
    
    XCTAssertTrue(_viewController.layers.count == (layersCount + 1), "Array count should be one higher than layers count");
}

- (void)testLayerIsAddedAsSublayerWhenSelectedItemIsALayer {
    [_viewController.layers addObject:[[CALayer alloc] init]];
    NSUInteger layersCount = [_viewController.layers[0] sublayers].count;
    
    [_viewController addLayer:nil];
    
    XCTAssertTrue([_selectedItem sublayers].count == (layersCount + 1), "Array count should be one higher than layer's sublayer count");
}

- (void)testLayerIsNotAddedWhenSelectedItemIsNotALayer {
    _selectedItem = @"A String that shouldn't be here.";
    [_viewController.layers addObject:[[CALayer alloc] init]];
    NSUInteger layersCount = [_viewController.layers[0] sublayers].count;
    
    [_viewController addLayer:nil];
    XCTAssertTrue(_viewController.layers.count == (layersCount + 1), "Array count should be one higher than layers count");
}

- (void)testAddLayerCallsDistributeLayerOnMainCoordinator {
    [_viewController.layers addObject:[[CAEmitterLayer alloc] init]];
    _viewController.selectedItem = _layers[0];
    
    [[_mockWindowController expect] distributeLayers:[OCMArg any] fromViewController:[OCMArg any]];
    
    [_viewController addLayer:nil];
    
    [_mockWindowController verify];
}

- (void)testNewLayerNameIsDifferentFromPriorLayers {
    _viewController.selectedItem = nil;
    
    [_viewController addLayer:nil];
    [_viewController addLayer:nil];
    [_viewController addLayer:nil];

    XCTAssertTrue([[_layers[1] name] isEqualToString:@"layer2"], @"The second layer should be named layer2");
    XCTAssertTrue([[_layers[2] name] isEqualToString:@"layer3"], @"The third layer should equal layer3");
}

- (void)testNewLayerNameIsDifferentFromPriorLayersOnSubLayers {
    [_viewController addLayer:nil];
    [_viewController addLayer:nil];
    [_viewController addLayer:nil];
    
    XCTAssertTrue([[[_selectedItem sublayers][1] name] isEqualToString:@"layer2"], @"The second layer should be named layer2");
    XCTAssertTrue([[[_selectedItem sublayers][2] name] isEqualToString:@"layer3"], @"The third layer should equal layer3");
}

#pragma mark Transform Layer Unit Tests

- (void)testTransformLayerIsAddedToArrayWhenSelectedItemIsNil {
    NSUInteger layersCount = _viewController.layers.count;
    _viewController.selectedItem = nil;
    
    [_viewController addTransformLayer:nil];
    
    XCTAssertTrue(_viewController.layers.count == (layersCount + 1), "Array count should be one higher than layers count");
}

- (void)testTransformLayerIsAddedAsSublayerWhenSelectedItemIsALayer {
    [_viewController.layers addObject:[[CALayer alloc] init]];
    NSUInteger layersCount = [_viewController.layers[0] sublayers].count;
    
    [_viewController addTransformLayer:nil];
    
    XCTAssertTrue([_selectedItem sublayers].count == (layersCount + 1), "Array count should be one higher than layer's sublayer count");
}

- (void)testTransformLayerIsNotAddedWhenSelectedItemIsNotALayer {
    _selectedItem = @"A String that shouldn't be here.";
    [_viewController.layers addObject:[[CALayer alloc] init]];
    NSUInteger layersCount = [_viewController.layers[0] sublayers].count;
    
    [_viewController addTransformLayer:nil];
    XCTAssertTrue(_viewController.layers.count == (layersCount + 1), "Array count should be one higher than layers count");
}

- (void)testAddTransformLayerCallsDistributeLayerOnMainCoordinator {
    [_viewController.layers addObject:[[CAEmitterLayer alloc] init]];
    _viewController.selectedItem = _layers[0];
    
    [[_mockWindowController expect] distributeLayers:[OCMArg any] fromViewController:[OCMArg any]];
    
    [_viewController addTransformLayer:nil];
    
    [_mockWindowController verify];
}

- (void)testNewTransformLayerNameIsDifferentFromPriorLayers {
    _viewController.selectedItem = nil;
    
    [_viewController addTransformLayer:nil];
    [_viewController addTransformLayer:nil];
    [_viewController addTransformLayer:nil];
    
    XCTAssertTrue([[_layers[1] name] isEqualToString:@"transformLayer2"], @"The second layer should be named layer2");
    XCTAssertTrue([[_layers[2] name] isEqualToString:@"transformLayer3"], @"The third layer should equal layer3");
}

- (void)testNewTransformLayerNameIsDifferentFromPriorLayersOnSubLayers {
    [_viewController addTransformLayer:nil];
    [_viewController addTransformLayer:nil];
    [_viewController addTransformLayer:nil];
    
    XCTAssertTrue([[[_selectedItem sublayers][1] name] isEqualToString:@"transformLayer2"], @"The second layer should be named layer2");
    XCTAssertTrue([[[_selectedItem sublayers][2] name] isEqualToString:@"transformLayer3"], @"The third layer should equal layer3");
}



#pragma mark Emitter Layer Unit Tests

- (void)testAddEmitterLayerCallsDistributeLayerOnMainCoordinator {
    [_viewController.layers addObject:[[CAEmitterLayer alloc] init]];
    _viewController.selectedItem = _layers[0];
    
    [[_mockWindowController expect] distributeLayers:[OCMArg any] fromViewController:[OCMArg any]];
    
    [_viewController addEmitterLayer:nil];
    
    [_mockWindowController verify];
}

- (void)testEmitterLayerIsAddedToArrayWhenSelectedItemIsNil {
    NSUInteger layersCount = _viewController.layers.count;
    _viewController.selectedItem = nil;

    
    [_viewController addEmitterLayer:nil];
    
    XCTAssertTrue(_viewController.layers.count == (layersCount + 1), "Array count should be one higher than layers count");
}

- (void)testEmitterLayerIsAddedAsSublayerWhenSelectedItemIsALayer {
    [_viewController.layers addObject:[[CAEmitterLayer alloc] init]];
    NSUInteger layersCount = [_viewController.layers[0] sublayers].count;
    
    [_viewController addEmitterLayer:nil];
    
    XCTAssertTrue([_selectedItem sublayers].count == (layersCount + 1), "Array count should be one higher than layer's sublayer count");
}

- (void)testEmitterLayerIsNotAddedWhenSelectedItemIsNotALayer {
    _selectedItem = @"A String that shouldn't be here.";
    [_viewController.layers addObject:[[CAEmitterLayer alloc] init]];
    NSUInteger layersCount = [_viewController.layers[0] sublayers].count;
    
    [_viewController addEmitterLayer:nil];
    XCTAssertTrue(_viewController.layers.count == (layersCount + 1), "Array count should be one higher than layers count");
}

- (void)testEmitterLayerIsAdded {
    _viewController.selectedItem = nil;
    
    [_viewController addEmitterLayer:nil];
    
    CAEmitterLayer *layer = _layers[0];
    XCTAssertNotNil(layer, @"An emitter layer should have been added to the document.");
    XCTAssertTrue(CGSizeEqualToSize(CGSizeMake(30, 30), layer.emitterSize), @"The default emitter size for new layer should by 30 x 30.");
    XCTAssertTrue(layer.renderMode == kCAEmitterLayerAdditive, @"The default layer mode should be additive.");
    XCTAssertTrue(layer.emitterShape == kCAEmitterLayerPoint, @"The default shape should be point.");
    XCTAssertTrue(CGPointEqualToPoint(layer.emitterPosition, CGPointMake(CGRectGetMidX(_viewController.canvasBounds), CGRectGetMidY(_viewController.canvasBounds))), @"The partical should be positioned in the center of the canvas.");
    XCTAssertTrue([layer.name isEqualToString:@"emitterLayer"], @"The first emitter layer should be named emitterLayer");
}

- (void)testNewEmitterLayerHasACellAdded {
    _viewController.selectedItem = nil;
    [_viewController addEmitterLayer:nil];
    
    CAEmitterCell *emitterCell = [_layers[0] valueForKey:@"emitterCells"][0];
    XCTAssertNotNil(emitterCell, @"An emitter cell should be added to a new emitter layer.");
    XCTAssertTrue(emitterCell.birthRate == 5, @"The default birthrate should be 20.");
    XCTAssertTrue(emitterCell.lifetime == 1, @"The default lifetime should be 1.");
    XCTAssertTrue(emitterCell.lifetimeRange == 1, @"The default lifetime range should be 1.");
    XCTAssertTrue(emitterCell.velocity == 0, @"The default velocity should be 0.");
    XCTAssertTrue([emitterCell.name isEqualToString:@"emitterCell"], @"The first emitter cell should be named emitterCell.");
}

- (void)testNewEmitterLayerNameIsDifferentFromPriorLayers {
    _viewController.selectedItem = nil;
    [_viewController addEmitterLayer:nil];
    [_viewController addEmitterLayer:nil];
    [_viewController addEmitterLayer:nil];
    
    CAEmitterLayer *layerTwo = _layers[1];
    CAEmitterLayer *layerThree = _layers[2];
    XCTAssertTrue([layerTwo.name isEqualToString:@"emitterLayer2"], @"The second emitter layer should be named emitterLayer2");
    XCTAssertTrue([layerThree.name isEqualToString:@"emitterLayer3"], @"The third emitter layer should be named emitterLayer3");
}

- (void)testNewEmitterLayerNameIsDifferentFromPriorLayersOnSubLayers {
    [_viewController addEmitterLayer:nil];
    [_viewController addEmitterLayer:nil];
    [_viewController addEmitterLayer:nil];
    
    XCTAssertTrue([[[_selectedItem sublayers][1] name] isEqualToString:@"emitterLayer2"], @"The second layer should be named emitterLayer2");
    XCTAssertTrue([[[_selectedItem sublayers][2] name] isEqualToString:@"emitterLayer3"], @"The third layer should equal emitterLayer3");
}

#pragma mark Add Emitter Cell Unit Tests

- (void)testNewEmitterCellNotAddedWhenSelectedItemEqualsNil {
    _viewController.selectedItem = nil;
    [_viewController addEmitterLayer:nil];
    [_viewController addEmitterCell:nil];
    
    NSArray *emitterCells = [_layers[0] valueForKey:@"emitterCells"];
    XCTAssertTrue([emitterCells count] == 1, @"A second emitter cell will not be added when selected item is nil");
}

- (void)testNewEmitterCellCallsDistributeLayerOnMainCoordinator {
    [_viewController.layers addObject:[[CAEmitterLayer alloc] init]];
    _viewController.selectedItem = _layers[0];
    
    [[_mockWindowController expect] distributeLayers:[OCMArg any] fromViewController:[OCMArg any]];
    
    [_viewController addEmitterCell:nil];
    
    [_mockWindowController verify];
}

- (void)testNewEmitterCellIsAddedToSelectedItem {
    _viewController.selectedItem = nil;
    [_viewController addEmitterLayer:nil];
    _viewController.selectedItem = _layers[0];
    [_viewController addEmitterCell:nil];
    
    NSArray *emitterCells = [_layers[0] valueForKey:@"emitterCells"];
    XCTAssertTrue([emitterCells count] == 2, @"A second emitter cell will be added when the selected item is an emitter layer");
}

- (void)testNewEmitterCellNameIsDifferentFromPriorCells {
    _viewController.selectedItem = nil;
    [_viewController addEmitterLayer:nil];
    _viewController.selectedItem = _layers[0];
    [_viewController addEmitterCell:nil];
    [_viewController addEmitterCell:nil];
    
    NSArray *emitterCells = [_layers[0] valueForKey:@"emitterCells"];
    
    CAEmitterCell *cellTwo = emitterCells[1];
    CAEmitterCell *cellThree = emitterCells[2];
    XCTAssertTrue([cellTwo.name isEqualToString:@"emitterCell2"], @"The second emitter cell should be named emitterCell2");
    XCTAssertTrue([cellThree.name isEqualToString:@"emitterCell3"], @"The third emitter cell should be named emitterCell3");
}

@end
