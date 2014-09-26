//
//  IterateEmitterCell.m
//  IterateOSX
//
//  Created by James Wilson on 9/25/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "CAEmitterCell+Layer.h"

@implementation CAEmitterCell (Layer)

- (CAEmitterLayer*)iterateLayerForCell:(NSArray*)layers {
    CAEmitterLayer *parentLayer = nil;
    
    for (CALayer* layer in layers) {
        if ([layer isKindOfClass:[CAEmitterLayer class]]) {
            NSArray *cells = ((CAEmitterLayer*)layer).emitterCells;
            [self isEmitterCellInCells:cells];
        }
        
        if ([[layer sublayers] count] > 0) {
            parentLayer = (CAEmitterLayer*)[self iterateLayerForCell:[layer sublayers]];
        }
    }
    
    return parentLayer;
}

- (BOOL)isEmitterCellInCells:(NSArray*)cells {
    __block BOOL isCell = NO;
    [cells enumerateObjectsUsingBlock:^(CAEmitterCell* cell, NSUInteger idx, BOOL *stop) {
        if (cell == self) {
            
        } else if ([cell.emitterCells count] > 0) {
            isCell = [self isEmitterCellInCells:cell.emitterCells];
        }
    }];
    
    return isCell;
}

@end

