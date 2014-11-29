//
//  ArrayTableViewDataSourceManagerTests.m
//  IterateOSX
//
//  Created by James Wilson on 11/10/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import IterateiOSFramework;

@interface ArrayTableViewDataSourceManagerTests : XCTestCase

@end

@implementation ArrayTableViewDataSourceManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitializing
{
    XCTAssertNil([[ArrayTableViewDataSourceManager alloc] init], @"Should not be allowed.");
    
    id obj1 = [[ArrayTableViewDataSourceManager alloc] initWithItems:@[] cellIdentifier:@"foo" tableViewMode: UITableViewModeNormal configureCellBlock:^(UITableViewCell *a, id b){}];
    XCTAssertNotNil(obj1, @"");
}

- (void)testCellConfiguration
{
    __block UITableViewCell *configuredCell = nil;
    __block id configuredObject = nil;
    TableViewCellConfigureBlock block = ^(UITableViewCell *a, id b){
        configuredCell = a;
        configuredObject = b;
    };
    ArrayTableViewDataSourceManager *dataSource = [[ArrayTableViewDataSourceManager alloc] initWithItems:@[@"a", @"b"] cellIdentifier:@"foo" tableViewMode: UITableViewModeNormal configureCellBlock:block];
    
    id mockTableView = [OCMockObject mockForClass:[UITableView class]];
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    [[[mockTableView expect] andReturn:cell] dequeueReusableCellWithIdentifier:@"foo" forIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    id result = [dataSource tableView:mockTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    [mockTableView verify];
    XCTAssertEqual(result, cell, @"Should return the dummy cell.");
    XCTAssertEqual(configuredCell, cell, @"This should have been passed to the block.");
    XCTAssertEqualObjects(configuredObject, @"a", @"This should have been passed to the block.");
}

- (void)testNumberOfRows
{
    id mockTableView = [OCMockObject mockForClass:[UITableView class]];
    ArrayTableViewDataSourceManager *dataSource = [[ArrayTableViewDataSourceManager alloc] initWithItems:@[@"a", @"b"] cellIdentifier:@"foo" tableViewMode:UITableViewModeNormal configureCellBlock:nil];
    
    [mockTableView verify];
    XCTAssertEqual([dataSource tableView:mockTableView numberOfRowsInSection:0], (NSInteger) 2, @"");
}


@end
