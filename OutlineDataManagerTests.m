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

@interface OutlineDataManagerTests : XCTestCase

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

@end
