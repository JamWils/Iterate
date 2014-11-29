//
//  OutlineViewDataSourceManagerTests.m
//  IterateOSX
//
//  Created by James Wilson on 9/25/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

@import Cocoa;
@import QuartzCore;
@import IterateOSXFramework;

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "OutlineViewEmitterTestCase.h"
#import "OutlineViewDataSourceManager.h"


@interface OutlineViewDataSourceManagerTests : XCTestCase

@property (strong) OutlineViewDataSourceManager *dataSourceManager;
@property (strong) id outlineTableView;
@property (strong) id dataManager;

@end

@implementation OutlineViewDataSourceManagerTests

- (void)setUp {
    [super setUp];
    
    _dataManager = [OCMockObject mockForClass:[OutlineDataManager class]];
    _dataSourceManager = [[OutlineViewDataSourceManager alloc] initWithDataSourceManager:_dataManager];
}

- (void)tearDown {
    _dataManager = nil;
    _dataSourceManager = nil;
    
    [super tearDown];
}

- (void)testInitReturnsNil {
    _dataSourceManager = [[OutlineViewDataSourceManager alloc] init];
    XCTAssertNil(_dataSourceManager, @"The basic init should return nil");
}

- (void)testInitReturnsNotNil {
    XCTAssertNotNil(_dataSourceManager, @"The init with layers should return not nil");
}

- (void)testDataManagerIsItemExpandableIsCalled {
    [[_dataManager expect] isItemExpandable:[OCMArg any]];
    [_dataSourceManager outlineView:[OCMArg any] isItemExpandable:@(YES)];
    
    [_dataManager verify];
}

- (void)testDataManagerNumberOfChildrenOfItemIsCalledInDataSourceManager {
    [[_dataManager expect] numberOfChildrenOfItem:[OCMArg any]];
    [_dataSourceManager outlineView:[OCMArg any] numberOfChildrenOfItem:[OCMArg any]];
    
    [_dataManager verify];
}

- (void) testChildOfItemIsCalledInDataSourceManager {
    [[_dataManager expect] child:100 ofItem:[OCMArg any]];
    [_dataSourceManager outlineView:[OCMArg any] child:100 ofItem:[OCMArg any]];
    
    [_dataManager verify];
}




@end
