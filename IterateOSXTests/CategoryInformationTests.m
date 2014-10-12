//
//  CategoryInformationTests.m
//  IterateOSX
//
//  Created by James Wilson on 10/6/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "CategoryInformation.h"


@interface CategoryInformationTests : XCTestCase

@property (strong) CategoryInformation *categoryInformation;
@property (strong) NSStoryboard *mainStoryboard;

@end

@implementation CategoryInformationTests

- (void)setUp {
    [super setUp];
    _categoryInformation = [[CategoryInformation alloc] initWithStoryboardIdentifier:@"Test" height:200];
}

- (void)tearDown {
    _categoryInformation = nil;
    [super tearDown];
}

- (void)testInitReturnsNil {
    XCTAssertNil([[CategoryInformation alloc] init], @"Base init should return nil.");
}

- (void)testCategoryInformationInitWithStoryboardAndHeightIsNotNil {
    XCTAssertNotNil(_categoryInformation, @"The init with storyboard identifier should not return nil");
}

- (void)testStoryboardIdentifierIsSet {
    XCTAssertTrue([_categoryInformation.storyboardIdentifier isEqualToString:@"Test"], @"Storyboard property was not set properly");
}

- (void)testHeightIs200 {
    XCTAssertTrue(_categoryInformation.height == 200, @"The height was not set properly");
}

- (void)testArrayForEmitterCellsReturnsCountOfFive {
    XCTAssertTrue([[CategoryInformation arrayForEmitterCells] count] == 5, @"The count should be 5.");
}

- (void)testAllEmitterCellMenuViewsAreAllContainerLayoutViews {
    
}

@end
