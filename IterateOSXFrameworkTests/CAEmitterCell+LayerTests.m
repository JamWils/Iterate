//
//  CAEmitterCell+LayerTests.m
//  IterateOSX
//
//  Created by James Wilson on 9/25/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import <QuartzCore/QuartzCore.h>
#import "CAEmitterCell+Layer.h"

@interface CAEmitterCell_LayerTests : XCTestCase

@property (strong) NSMutableArray *layers;
@property (strong) CAEmitterCell *testCell;
@property (strong) CAEmitterLayer *validLayer;

@end

@implementation CAEmitterCell_LayerTests

- (void)setUp {
    [super setUp];
    
    _layers = [[NSMutableArray alloc] init];
    [self initializeLayerTestData];
}

- (void)tearDown {
    _testCell = nil;
    _layers = nil;
    [super tearDown];
}

- (void)testReturnsNilWhenNoLayerIsFound {
    _layers = nil;
    XCTAssertNil([_testCell iterateLayerForCell:_layers], @"No layers will return nil");
}

//- (void)testReturnsLayerEqualToValidLayer {
//    XCTAssertEqualObjects([_testCell iterateLayerForCell:_layers], _validLayer, @"Layers should be same object");
//}

#pragma mark Helper Methods

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
    
    _testCell = emitterCellA;
    _validLayer = emitterLayer;
    
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
