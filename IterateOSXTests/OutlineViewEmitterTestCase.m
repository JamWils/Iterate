//
//  OutlineViewEmitterTestCase.m
//  IterateOSX
//
//  Created by James Wilson on 9/26/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "OutlineViewEmitterTestCase.h"
@import QuartzCore;

@implementation OutlineViewEmitterTestCase

- (void)setUp {
    [super setUp];
    [self initializeLayerTestData];
}

- (void)tearDown {
    _layers = nil;
    [super tearDown];
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
