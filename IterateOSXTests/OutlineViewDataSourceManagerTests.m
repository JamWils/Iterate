//
//  OutlineViewDataSourceManagerTests.m
//  IterateOSX
//
//  Created by James Wilson on 9/25/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import <QuartzCore/QuartzCore.h>
#import <OCMock/OCMock.h>

#import "OutlineViewDataSourceManager.h"


@interface OutlineViewDataSourceManagerTests : XCTestCase

@property (strong) NSMutableArray *layers;
@property (strong) OutlineViewDataSourceManager *dataSourceManager;
@property (strong) id outlineTableView;

@end

@implementation OutlineViewDataSourceManagerTests

- (void)setUp {
    [super setUp];
    
    [self initializeLayerTestData];
    
    _dataSourceManager = [[OutlineViewDataSourceManager alloc] initWithLayers:_layers];
}

- (void)tearDown {
    _dataSourceManager = nil;
    _layers = nil;
    
    [super tearDown];
}

- (void)testInitReturnsNil {
    _dataSourceManager = [[OutlineViewDataSourceManager alloc] init];
    XCTAssertNil(_dataSourceManager, @"The basic init should return nil");
}

- (void)testInitReturnsNotNil {
    XCTAssertNotNil(_dataSourceManager, @"The init with layers should return not nil");
}

- (void)testOutlineReturnsNumberOfRowsInArray {
    id mockOutlineView = [OCMockObject mockForClass:[NSOutlineView class]];
    NSUInteger expectedNumberOfChildren = [_layers count];
    NSUInteger numberOfChildren = [_dataSourceManager outlineView:mockOutlineView numberOfChildrenOfItem:_layers];
    XCTAssertEqual(numberOfChildren, expectedNumberOfChildren, @"The number of rows should be %ld", expectedNumberOfChildren);
}

- (void)testNumberOfRowsInMainLayer {
    id mockOutlineView = [OCMockObject mockForClass:[NSOutlineView class]];
    NSUInteger expectedNumberOfChildren = [[_layers[0] sublayers] count];
    NSUInteger numberOfChildren = [_dataSourceManager outlineView:mockOutlineView numberOfChildrenOfItem:_layers[0]];
    XCTAssertEqual(numberOfChildren, expectedNumberOfChildren, @"The number of rows should be %ld", expectedNumberOfChildren);
}

- (void)testNumberOfRowsInFirstSubLayer {
    id mockOutlineView = [OCMockObject mockForClass:[NSOutlineView class]];
    NSUInteger expectedNumberOfChildren = [[[[_layers[0] valueForKey:@"sublayers"] objectAtIndex:0] valueForKey:@"emitterCells"] count];
    NSUInteger numberOfChildren = [_dataSourceManager outlineView:mockOutlineView numberOfChildrenOfItem:[[_layers[0] valueForKey:@"sublayers"] objectAtIndex:0]];
    XCTAssertEqual(numberOfChildren, expectedNumberOfChildren, @"The number of rows should be %ld", expectedNumberOfChildren);
}

- (void)testNumberOfSubCellsInCellAtIndexOne {
    id mockOutlineView = [OCMockObject mockForClass:[NSOutlineView class]];
    NSUInteger expectedNumberOfChildren = [[[[[[_layers[0] valueForKey:@"sublayers"] objectAtIndex:0]
                                                          valueForKey:@"emitterCells"] objectAtIndex:1]
                                                          valueForKey:@"emitterCells"] count];
    CAEmitterCell *cell = (CAEmitterCell*)[[[[_layers[0] valueForKey:@"sublayers"] objectAtIndex:0]
                                              valueForKey:@"emitterCells"] objectAtIndex:1];
    NSUInteger numberOfChildren = [_dataSourceManager outlineView:mockOutlineView numberOfChildrenOfItem:cell];
    XCTAssertEqual(numberOfChildren, expectedNumberOfChildren, @"The number of rows should be %ld", expectedNumberOfChildren);
}

- (void)testNumberOfRowsInSecondMainLayer {
    id mockOutlineView = [OCMockObject mockForClass:[NSOutlineView class]];
    NSUInteger expectedNumberOfChildren = [[_layers[1] sublayers] count];
    NSUInteger numberOfChildren = [_dataSourceManager outlineView:mockOutlineView numberOfChildrenOfItem:_layers[1]];
    XCTAssertEqual(numberOfChildren, expectedNumberOfChildren, @"The number of rows should be %ld", expectedNumberOfChildren);
}

//- (void)testOutlineReturnsNumberOfRowsInArray {
//    id mockOutlineView = [OCMockObject mockForClass:[NSOutlineView class]];
//    NSUInteger shouldExpand = [_layers count] > 0;
//    NSUInteger numberOfChildren = [_dataSourceManager outlineView:mockOutlineView numberOfChildrenOfItem:_layers];
//    XCTAssertEqual(numberOfChildren, shouldExpand, @"The number of rows should be %ld", expectedNumberOfChildren);
//}

- (void)testMainLayerShouldExpand {
    id mockOutlineView = [OCMockObject mockForClass:[NSOutlineView class]];
    BOOL shouldExpand = [[_layers[0] sublayers] count] > 0;
    BOOL willExpand = [_dataSourceManager outlineView:mockOutlineView isItemExpandable:_layers[0]];
    XCTAssertEqual(willExpand, shouldExpand, @"This section should expand %hhd", shouldExpand);
}

- (void)testFirstSublayerShouldExpand {
    id mockOutlineView = [OCMockObject mockForClass:[NSOutlineView class]];
    BOOL shouldExpand = [[[[_layers[0] valueForKey:@"sublayers"] objectAtIndex:0] valueForKey:@"emitterCells"] count] > 0;
    BOOL willExpand = [_dataSourceManager outlineView:mockOutlineView isItemExpandable:[[_layers[0] valueForKey:@"sublayers"] objectAtIndex:0]];
    XCTAssertEqual(willExpand, shouldExpand, @"This section should expand %hhd", shouldExpand);
}

- (void)testSubCellAtIndexOneShouldExpand {
    id mockOutlineView = [OCMockObject mockForClass:[NSOutlineView class]];
    BOOL shouldExpand = [[[[[[_layers[0] valueForKey:@"sublayers"] objectAtIndex:0]
                                              valueForKey:@"emitterCells"] objectAtIndex:1]
                                            valueForKey:@"emitterCells"] count] > 0;
    CAEmitterCell *cell = (CAEmitterCell*)[[[[_layers[0] valueForKey:@"sublayers"] objectAtIndex:0]
                                            valueForKey:@"emitterCells"] objectAtIndex:1];
    BOOL willExpand = [_dataSourceManager outlineView:mockOutlineView isItemExpandable:cell];
    XCTAssertEqual(willExpand, shouldExpand, @"This section should expand %hhd", shouldExpand);
}

- (void)testSecondMainLayerShouldNotExpand {
    id mockOutlineView = [OCMockObject mockForClass:[NSOutlineView class]];
    BOOL shouldExpand = [[_layers[1] sublayers] count] > 0;
    BOOL willExpand = [_dataSourceManager outlineView:mockOutlineView isItemExpandable:_layers[1]];
    XCTAssertEqual(willExpand, shouldExpand, @"This section should not expand %hhd", shouldExpand);
}

- (void)testMainLayerIsReturned {
    id mockOutlineView = [OCMockObject mockForClass:[NSOutlineView class]];
    id expectedObject = _layers[0];
    id object = [_dataSourceManager outlineView:mockOutlineView child:0 ofItem:nil];
    XCTAssertEqualObjects(object, expectedObject, @"Expecting %@", [expectedObject valueForKey:@"name"]);
}

- (void)testSecondMainLayerIsReturned {
    id mockOutlineView = [OCMockObject mockForClass:[NSOutlineView class]];
    id expectedObject = _layers[1];
    id object = [_dataSourceManager outlineView:mockOutlineView child:1 ofItem:nil];
    XCTAssertEqualObjects(object, expectedObject, @"Expecting %@", [expectedObject valueForKey:@"name"]);
}

- (void)testMainLayersFirstSubLayerIsReturned {
    id mockOutlineView = [OCMockObject mockForClass:[NSOutlineView class]];
    id expectedObject = [[_layers[0] valueForKey:@"sublayers"] objectAtIndex:0];
    id object = [_dataSourceManager outlineView:mockOutlineView child:0 ofItem:_layers[0]];
    XCTAssertEqualObjects(object, expectedObject, @"Expecting %@", [expectedObject valueForKey:@"name"]);
}

- (void)testMainLayersFirstSubLayersSecondCellIsReturned {
    id mockOutlineView = [OCMockObject mockForClass:[NSOutlineView class]];
    id expectedObject = [[[[_layers[0] valueForKey:@"sublayers"] objectAtIndex:0]
                                       valueForKey:@"emitterCells"] objectAtIndex:1];
    id object = [_dataSourceManager outlineView:mockOutlineView child:1 ofItem:[[_layers[0] valueForKey:@"sublayers"] objectAtIndex:0]];
    XCTAssertEqualObjects(object, expectedObject, @"Expecting %@", [expectedObject valueForKey:@"name"]);
}



- (void)initializeLayerTestData {
    _layers = [[NSMutableArray alloc] init];
    CALayer *layer = [[CALayer alloc] init];
    layer.name = @"mainLayer";
    
    CAEmitterLayer *emitterLayer = [[CAEmitterLayer alloc] init];
    emitterLayer.name = @"emitterLayerOne";
    
    CAEmitterCell *emitterCell = [[CAEmitterCell alloc] init];
    emitterCell.name = @"emitterCellOne";
    
    CAEmitterCell *emitterCellTwo = [[CAEmitterCell alloc] init];
    emitterCellTwo.name = @"emitterCellTwo";
    
    CAEmitterCell *emitterCellSix = [[CAEmitterCell alloc] init];
    emitterCellSix.name = @"emitterCellSix";
    emitterLayer.emitterCells = @[emitterCell, emitterCellTwo, emitterCellSix];
    
    CAEmitterCell *emitterCellA = [[CAEmitterCell alloc] init];
    emitterCellA.name = @"emitterCellA";
    emitterCellTwo.emitterCells = @[emitterCellA];
    
    CAEmitterLayer *subEmitterLayer = [[CAEmitterLayer alloc] init];
    subEmitterLayer.name = @"subLayer";
    
    CAEmitterCell *subEmitterCell = [[CAEmitterCell alloc] init];
    subEmitterCell.name = @"subEmitterCell";
    subEmitterLayer.emitterCells = @[subEmitterCell];
    [emitterLayer addSublayer:subEmitterLayer];
    [layer addSublayer:emitterLayer];
    
    CAEmitterLayer *emitterLayerTwo = [[CAEmitterLayer alloc] init];
    emitterLayerTwo.name = @"emitterLayerTwo";
    
    CAEmitterCell *emitterCellThree = [[CAEmitterCell alloc] init];
    emitterCellThree.name = @"emitterCellThree";
    
    CAEmitterCell *emitterCellFour = [[CAEmitterCell alloc] init];
    emitterCellFour.name = @"emitterCellFour";
    
    CAEmitterCell *emitterCellFive = [[CAEmitterCell alloc] init];
    emitterCellFive.name = @"emitterCellFive";
    
    emitterLayerTwo.emitterCells = @[emitterCellThree, emitterCellFour, emitterCellFive];
    [layer addSublayer:emitterLayerTwo];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.name = @"shapeLayer";

    [_layers addObject:layer];
    [_layers addObject:shapeLayer];
}

@end
