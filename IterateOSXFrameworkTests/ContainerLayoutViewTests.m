//
//  ContentLayoutViewTests.m
//  IterateOSX
//
//  Created by James Wilson on 10/6/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

#import "ContainerLayoutView.h"

@interface ContainerLayoutViewTests : XCTestCase

@property (strong) ContainerLayoutView *view;

@end

@implementation ContainerLayoutViewTests

- (void)setUp {
    [super setUp];
    _view = [[ContainerLayoutView alloc] init];
}

- (void)tearDown {
    
    [super tearDown];
}

- (void)testViewIsNotNil {
    XCTAssert(_view, @"View should not be nil");
}

//- (void)testTranlsatesAutoresizingMaskIntoConstraintsIsFalse {
//    XCTAssertFalse(_view.translatesAutoresizingMaskIntoConstraints, @"Translates autoresizing mask into constraints should be set to no for ContainerLayoutViews");
//}

@end
