//
//  OutlineDataManagerTests.m
//  IterateOSX
//
//  Created by James Wilson on 11/13/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

@import QuartzCore;
#import <XCTest/XCTest.h>
#import "OutlineDataManager.h"
#import "OutlineViewEmitterTestCase.h"

@interface OutlineDataManagerTests : OutlineViewEmitterTestCase

@property (nonatomic, strong) OutlineDataManager *dataSourceManager;
@property (strong) NSMutableArray *layers;

@end

@implementation OutlineDataManagerTests

- (void)setUp {
    [super setUp];
    _dataSourceManager = [[OutlineDataManager alloc] initWithLayers:self.layers];
}

- (void)tearDown {
    _dataSourceManager = nil;
    [super tearDown];
}

- (void)testOutlineDataManagerWithoutParametersIsNil {
    _dataSourceManager = [[OutlineDataManager alloc] init];
    XCTAssertNil(_dataSourceManager);
}

- (void)testInitReturnsNotNil {
    XCTAssertNotNil(_dataSourceManager, @"The init with layers should return not nil");
}

- (void)testOutlineReturnsNumberOfRowsInArray {
    NSUInteger expectedNumberOfChildren = [self.layers count];
    NSUInteger numberOfChildren = [_dataSourceManager numberOfChildrenOfItem:self.layers];
    XCTAssertEqual(numberOfChildren, expectedNumberOfChildren, @"The number of rows should be %ld", expectedNumberOfChildren);
}

- (void)testNumberOfRowsInMainLayer {
    NSUInteger expectedNumberOfChildren = [[self.layers[0] sublayers] count];
    NSUInteger numberOfChildren = [_dataSourceManager numberOfChildrenOfItem:self.layers[0]];
    XCTAssertEqual(numberOfChildren, expectedNumberOfChildren, @"The number of rows should be %ld", expectedNumberOfChildren);
}

- (void)testNumberOfRowsInFirstSubLayer {
    
    NSUInteger expectedNumberOfChildren = [[[[self.layers[0] valueForKey:@"sublayers"] objectAtIndex:0] valueForKey:@"emitterCells"] count];
    NSUInteger numberOfChildren = [_dataSourceManager numberOfChildrenOfItem:[[self.layers[0] valueForKey:@"sublayers"] objectAtIndex:0]];
    XCTAssertEqual(numberOfChildren, expectedNumberOfChildren, @"The number of rows should be %ld", expectedNumberOfChildren);
}

- (void)testNumberOfSubCellsInCellAtIndexOne {
    
    NSUInteger expectedNumberOfChildren = [[[[[[self.layers[0] valueForKey:@"sublayers"] objectAtIndex:0]
                                              valueForKey:@"emitterCells"] objectAtIndex:1]
                                            valueForKey:@"emitterCells"] count];
    CAEmitterCell *cell = (CAEmitterCell*)[[[[self.layers[0] valueForKey:@"sublayers"] objectAtIndex:0]
                                            valueForKey:@"emitterCells"] objectAtIndex:1];
    NSUInteger numberOfChildren = [_dataSourceManager numberOfChildrenOfItem:cell];
    XCTAssertEqual(numberOfChildren, expectedNumberOfChildren, @"The number of rows should be %ld", expectedNumberOfChildren);
}

- (void)testNumberOfRowsInSecondMainLayer {
    
    NSUInteger expectedNumberOfChildren = [[self.layers[1] sublayers] count];
    NSUInteger numberOfChildren = [_dataSourceManager numberOfChildrenOfItem:self.layers[1]];
    XCTAssertEqual(numberOfChildren, expectedNumberOfChildren, @"The number of rows should be %ld", expectedNumberOfChildren);
}

- (void)testMainLayerShouldExpand {
    
    BOOL shouldExpand = [[self.layers[0] sublayers] count] > 0;
    BOOL willExpand = [_dataSourceManager isItemExpandable:self.layers[0]];
    XCTAssertEqual(willExpand, shouldExpand, @"This section should expand");
}

- (void)testFirstSublayerShouldExpand {
    
    BOOL shouldExpand = [[[[self.layers[0] valueForKey:@"sublayers"] objectAtIndex:0] valueForKey:@"emitterCells"] count] > 0;
    BOOL willExpand = [_dataSourceManager isItemExpandable:[[self.layers[0] valueForKey:@"sublayers"] objectAtIndex:0]];
    XCTAssertEqual(willExpand, shouldExpand, @"This section should expand");
}

- (void)testSubCellAtIndexOneShouldExpand {
    
    BOOL shouldExpand = [[[[[[self.layers[0] valueForKey:@"sublayers"] objectAtIndex:0]
                            valueForKey:@"emitterCells"] objectAtIndex:1]
                          valueForKey:@"emitterCells"] count] > 0;
    CAEmitterCell *cell = (CAEmitterCell*)[[[[self.layers[0] valueForKey:@"sublayers"] objectAtIndex:0]
                                            valueForKey:@"emitterCells"] objectAtIndex:1];
    BOOL willExpand = [_dataSourceManager isItemExpandable:cell];
    XCTAssertEqual(willExpand, shouldExpand, @"This section should expand");
}

- (void)testSecondMainLayerShouldNotExpand {
    
    BOOL shouldExpand = [[self.layers[1] sublayers] count] > 0;
    BOOL willExpand = [_dataSourceManager isItemExpandable:self.layers[1]];
    XCTAssertEqual(willExpand, shouldExpand, @"This section should not expand");
}

- (void)testMainLayerIsReturned {
    
    id expectedObject = self.layers[0];
    id object = [_dataSourceManager child:0 ofItem:nil];
    XCTAssertEqualObjects(object, expectedObject, @"Expecting %@", [expectedObject valueForKey:@"name"]);
}

- (void)testSecondMainLayerIsReturned {
    
    id expectedObject = self.layers[1];
    id object = [_dataSourceManager child:1 ofItem:nil];
    XCTAssertEqualObjects(object, expectedObject, @"Expecting %@", [expectedObject valueForKey:@"name"]);
}

- (void)testMainLayersFirstSubLayerIsReturned {
    
    id expectedObject = [[self.layers[0] valueForKey:@"sublayers"] objectAtIndex:0];
    id object = [_dataSourceManager child:0 ofItem:self.layers[0]];
    XCTAssertEqualObjects(object, expectedObject, @"Expecting %@", [expectedObject valueForKey:@"name"]);
}

- (void)testMainLayersFirstSubLayersSecondCellIsReturned {
    
    id expectedObject = [[[[self.layers[0] valueForKey:@"sublayers"] objectAtIndex:0]
                          valueForKey:@"emitterCells"] objectAtIndex:1];
    id object = [_dataSourceManager child:1 ofItem:[[self.layers[0] valueForKey:@"sublayers"] objectAtIndex:0]];
    XCTAssertEqualObjects(object, expectedObject, @"Expecting %@", [expectedObject valueForKey:@"name"]);
}

#pragma mark -
#pragma mark Total Number Of Children Tests

- (void)testSimpleOneLevelTotalNumberOfChildren {
    CALayer *layer = [[CALayer alloc] init];
    layer.sublayers = @[[[CALayer alloc] init], [[CALayer alloc] init], [[CALayer alloc] init]];
    
    [self assertTotalNumberOfChildrenForDataManager:[@[layer] mutableCopy] andNumberOfChildren:4];
}

- (void)testOutlineViewOfChildren {
    CALayer *layer = [[CALayer alloc] init];
    
    CALayer *layer2 = [[CALayer alloc] init];
    layer2.sublayers = @[[[CALayer alloc] init], [[CALayer alloc] init], [[CALayer alloc] init]];
    layer.sublayers = @[[[CALayer alloc] init], [[CALayer alloc] init], [[CALayer alloc] init], layer2];
    
    [self assertTotalNumberOfChildrenForDataManager:[@[layer] mutableCopy] andNumberOfChildren:8];
}

- (void)testTotalNumberOfChildrenWithEmitterCellsAndLayers {
    CALayer *layer = [[CALayer alloc] init];
    CALayer *layer2 = [[CALayer alloc] init];
    CAEmitterLayer *layer3 = [[CAEmitterLayer alloc] init];
    layer3.emitterCells = @[[[CAEmitterCell alloc] init], [[CAEmitterCell alloc] init], [[CAEmitterCell alloc] init], [[CAEmitterCell alloc] init]];
    layer2.sublayers = @[[[CALayer alloc] init], [[CALayer alloc] init], [[CALayer alloc] init]];
    layer.sublayers = @[[[CALayer alloc] init], [[CALayer alloc] init], layer2, layer3];
    
    [self assertTotalNumberOfChildrenForDataManager:[@[layer] mutableCopy] andNumberOfChildren:12];
}

#pragma mark -
#pragma mark Assertion Methods

- (void)assertTotalNumberOfChildrenForDataManager:(NSMutableArray*)items andNumberOfChildren:(NSInteger)numberOfChildren {
    _dataSourceManager = [[OutlineDataManager alloc] initWithLayers:items];
    NSInteger totalNumberOfChildren = [_dataSourceManager numberOfTotalChildren:_dataSourceManager.layers];
    XCTAssertTrue(totalNumberOfChildren == numberOfChildren, @"The total number was %li", (long)totalNumberOfChildren);

}

@end
