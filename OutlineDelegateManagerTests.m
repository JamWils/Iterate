//
//  OutlineDelegateManagerTests.m
//  IterateOSX
//
//  Created by James Wilson on 11/15/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

@import QuartzCore;
#import <XCTest/XCTest.h>
#import "OutlineDelegateManager.h"

@interface OutlineDelegateManagerTests : XCTestCase

@property (nonatomic, strong) OutlineDelegateManager *delegateManager;

@end

@implementation OutlineDelegateManagerTests

- (void)setUp {
    [super setUp];
    _delegateManager = [[OutlineDelegateManager alloc] initWithParentObjectBlock:nil];
}

- (void)tearDown {
    _delegateManager = nil;
    [super tearDown];
}



- (void)testImageNameForLayers {
    NSString *layerImageName = [_delegateManager imageNameForItem:[[CALayer alloc] init]];
    XCTAssertEqualObjects(layerImageName, @"CALayer OutlineIcon Active");
    
    NSString *emitterLayerImageName = [_delegateManager imageNameForItem:[[CAEmitterLayer alloc] init]];
    XCTAssertEqualObjects(emitterLayerImageName, @"CAEmitterLayer OutlineIcon Active");
    
    NSString *transformLayerImageName = [_delegateManager imageNameForItem:[[CATransformLayer alloc] init]];
    XCTAssertEqualObjects(transformLayerImageName, @"CATransformLayer OutlineIcon Active");
    
    NSString *emitterCellImageName = [_delegateManager imageNameForItem:[[CAEmitterCell alloc] init]];
    XCTAssertEqualObjects(emitterCellImageName, @"CAEmitterCell OutlineIcon Active");
}

@end
