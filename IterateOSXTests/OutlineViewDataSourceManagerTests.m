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

#import "OutlineViewEmitterTestCase.h"
#import "OutlineViewDataSourceManager.h"


@interface OutlineViewDataSourceManagerTests : OutlineViewEmitterTestCase

@property (strong) NSMutableArray *layers;
@property (strong) OutlineViewDataSourceManager *dataSourceManager;
@property (strong) id outlineTableView;

@end

@implementation OutlineViewDataSourceManagerTests

- (void)setUp {
    [super setUp];
    
    _dataSourceManager = [[OutlineViewDataSourceManager alloc] initWithLayers:self.layers];
}

- (void)tearDown {
    _dataSourceManager = nil;
    self.layers = nil;
    
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
    NSUInteger expectedNumberOfChildren = [self.layers count];
    NSUInteger numberOfChildren = [_dataSourceManager outlineView:mockOutlineView numberOfChildrenOfItem:self.layers];
    XCTAssertEqual(numberOfChildren, expectedNumberOfChildren, @"The number of rows should be %ld", expectedNumberOfChildren);
}

- (void)testNumberOfRowsInMainLayer {
    id mockOutlineView = [OCMockObject mockForClass:[NSOutlineView class]];
    NSUInteger expectedNumberOfChildren = [[self.layers[0] sublayers] count];
    NSUInteger numberOfChildren = [_dataSourceManager outlineView:mockOutlineView numberOfChildrenOfItem:self.layers[0]];
    XCTAssertEqual(numberOfChildren, expectedNumberOfChildren, @"The number of rows should be %ld", expectedNumberOfChildren);
}

- (void)testNumberOfRowsInFirstSubLayer {
    id mockOutlineView = [OCMockObject mockForClass:[NSOutlineView class]];
    NSUInteger expectedNumberOfChildren = [[[[self.layers[0] valueForKey:@"sublayers"] objectAtIndex:0] valueForKey:@"emitterCells"] count];
    NSUInteger numberOfChildren = [_dataSourceManager outlineView:mockOutlineView numberOfChildrenOfItem:[[self.layers[0] valueForKey:@"sublayers"] objectAtIndex:0]];
    XCTAssertEqual(numberOfChildren, expectedNumberOfChildren, @"The number of rows should be %ld", expectedNumberOfChildren);
}

- (void)testNumberOfSubCellsInCellAtIndexOne {
    id mockOutlineView = [OCMockObject mockForClass:[NSOutlineView class]];
    NSUInteger expectedNumberOfChildren = [[[[[[self.layers[0] valueForKey:@"sublayers"] objectAtIndex:0]
                                                          valueForKey:@"emitterCells"] objectAtIndex:1]
                                                          valueForKey:@"emitterCells"] count];
    CAEmitterCell *cell = (CAEmitterCell*)[[[[self.layers[0] valueForKey:@"sublayers"] objectAtIndex:0]
                                              valueForKey:@"emitterCells"] objectAtIndex:1];
    NSUInteger numberOfChildren = [_dataSourceManager outlineView:mockOutlineView numberOfChildrenOfItem:cell];
    XCTAssertEqual(numberOfChildren, expectedNumberOfChildren, @"The number of rows should be %ld", expectedNumberOfChildren);
}

- (void)testNumberOfRowsInSecondMainLayer {
    id mockOutlineView = [OCMockObject mockForClass:[NSOutlineView class]];
    NSUInteger expectedNumberOfChildren = [[self.layers[1] sublayers] count];
    NSUInteger numberOfChildren = [_dataSourceManager outlineView:mockOutlineView numberOfChildrenOfItem:self.layers[1]];
    XCTAssertEqual(numberOfChildren, expectedNumberOfChildren, @"The number of rows should be %ld", expectedNumberOfChildren);
}

- (void)testMainLayerShouldExpand {
    id mockOutlineView = [OCMockObject mockForClass:[NSOutlineView class]];
    BOOL shouldExpand = [[self.layers[0] sublayers] count] > 0;
    BOOL willExpand = [_dataSourceManager outlineView:mockOutlineView isItemExpandable:self.layers[0]];
    XCTAssertEqual(willExpand, shouldExpand, @"This section should expand %hhd", shouldExpand);
}

- (void)testFirstSublayerShouldExpand {
    id mockOutlineView = [OCMockObject mockForClass:[NSOutlineView class]];
    BOOL shouldExpand = [[[[self.layers[0] valueForKey:@"sublayers"] objectAtIndex:0] valueForKey:@"emitterCells"] count] > 0;
    BOOL willExpand = [_dataSourceManager outlineView:mockOutlineView isItemExpandable:[[self.layers[0] valueForKey:@"sublayers"] objectAtIndex:0]];
    XCTAssertEqual(willExpand, shouldExpand, @"This section should expand %hhd", shouldExpand);
}

- (void)testSubCellAtIndexOneShouldExpand {
    id mockOutlineView = [OCMockObject mockForClass:[NSOutlineView class]];
    BOOL shouldExpand = [[[[[[self.layers[0] valueForKey:@"sublayers"] objectAtIndex:0]
                                              valueForKey:@"emitterCells"] objectAtIndex:1]
                                            valueForKey:@"emitterCells"] count] > 0;
    CAEmitterCell *cell = (CAEmitterCell*)[[[[self.layers[0] valueForKey:@"sublayers"] objectAtIndex:0]
                                            valueForKey:@"emitterCells"] objectAtIndex:1];
    BOOL willExpand = [_dataSourceManager outlineView:mockOutlineView isItemExpandable:cell];
    XCTAssertEqual(willExpand, shouldExpand, @"This section should expand %hhd", shouldExpand);
}

- (void)testSecondMainLayerShouldNotExpand {
    id mockOutlineView = [OCMockObject mockForClass:[NSOutlineView class]];
    BOOL shouldExpand = [[self.layers[1] sublayers] count] > 0;
    BOOL willExpand = [_dataSourceManager outlineView:mockOutlineView isItemExpandable:self.layers[1]];
    XCTAssertEqual(willExpand, shouldExpand, @"This section should not expand %hhd", shouldExpand);
}

- (void)testMainLayerIsReturned {
    id mockOutlineView = [OCMockObject mockForClass:[NSOutlineView class]];
    id expectedObject = self.layers[0];
    id object = [_dataSourceManager outlineView:mockOutlineView child:0 ofItem:nil];
    XCTAssertEqualObjects(object, expectedObject, @"Expecting %@", [expectedObject valueForKey:@"name"]);
}

- (void)testSecondMainLayerIsReturned {
    id mockOutlineView = [OCMockObject mockForClass:[NSOutlineView class]];
    id expectedObject = self.layers[1];
    id object = [_dataSourceManager outlineView:mockOutlineView child:1 ofItem:nil];
    XCTAssertEqualObjects(object, expectedObject, @"Expecting %@", [expectedObject valueForKey:@"name"]);
}

- (void)testMainLayersFirstSubLayerIsReturned {
    id mockOutlineView = [OCMockObject mockForClass:[NSOutlineView class]];
    id expectedObject = [[self.layers[0] valueForKey:@"sublayers"] objectAtIndex:0];
    id object = [_dataSourceManager outlineView:mockOutlineView child:0 ofItem:self.layers[0]];
    XCTAssertEqualObjects(object, expectedObject, @"Expecting %@", [expectedObject valueForKey:@"name"]);
}

- (void)testMainLayersFirstSubLayersSecondCellIsReturned {
    id mockOutlineView = [OCMockObject mockForClass:[NSOutlineView class]];
    id expectedObject = [[[[self.layers[0] valueForKey:@"sublayers"] objectAtIndex:0]
                                       valueForKey:@"emitterCells"] objectAtIndex:1];
    id object = [_dataSourceManager outlineView:mockOutlineView child:1 ofItem:[[self.layers[0] valueForKey:@"sublayers"] objectAtIndex:0]];
    XCTAssertEqualObjects(object, expectedObject, @"Expecting %@", [expectedObject valueForKey:@"name"]);
}




@end
