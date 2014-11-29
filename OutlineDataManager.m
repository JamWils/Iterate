//
//  OutlineDataManager.m
//  IterateOSX
//
//  Created by James Wilson on 11/13/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "OutlineDataManager.h"

@implementation OutlineDataManager

- (instancetype) init {
    return nil;
}

- (instancetype)initWithLayers:(NSMutableArray*)layers {
    self = [super init];
    if (self) {
        _layers = layers;
    }

    return self;
}

- (NSInteger) numberOfChildrenOfItem:(id)item {
    NSUInteger number = 0;
    
    if (!item) {
        number = [self.layers count];
    } else if ([[item valueForKey:@"emitterCells"] count] > 0) {
        number = [[item valueForKey:@"emitterCells"] count];
    } else {
        number = [[item valueForKey:@"sublayers"] count];
    }
    return number;
}

- (NSString*) keyForChildren:(id)item {
    NSString *key;
    
    if ([[item valueForKey:@"emitterCells"] count] > 0) {
        key = @"emitterCells";
    } else {
        key = @"sublayers";
    }
    return key;
}

- (BOOL) isItemExpandable:(id)item {
    BOOL expand = NO;
    
    if (!item) {
        expand = NO;
    } else if ([[item valueForKey:@"emitterCells"] count] > 0) {
        expand = [[item valueForKey:@"emitterCells"] count] != 0;
    } else {
        expand = [[item valueForKey:@"sublayers"] count] != 0;
    }
    
    return expand;
}

-(id)child:(NSInteger)index ofItem:(id)item {
    id itemToReturn;
    
    if (!item) {
        itemToReturn = self.layers[index];
    } else if ([[item valueForKey:@"emitterCells"] objectAtIndex:index] != nil) {
        itemToReturn = [[item valueForKey:@"emitterCells"] objectAtIndex:index];
    } else {
        itemToReturn = [[item valueForKey:@"sublayers"] objectAtIndex:index];
    }
    
    return itemToReturn;
}

- (NSInteger)numberOfTotalChildren:(NSMutableArray*)item {
    __block NSInteger numberOfChildren = 0;
    NSLog(@"Count: %li", item.count);
    
    [item enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        numberOfChildren++;
        NSInteger children = [self numberOfChildrenOfItem:obj];
        
        if (children > 0) {
            NSString *keyProperty = [self keyForChildren:obj];
            numberOfChildren += [self numberOfTotalChildren:[obj valueForKey:keyProperty]];
        }
        
    }];
    
    return numberOfChildren;
}

@end
