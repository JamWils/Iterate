//
//  OutlineViewController.m
//  IterateOSX
//
//  Created by James Wilson on 9/23/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "OutlineViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation OutlineViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _layers = [[NSMutableArray alloc] init];
        CAEmitterLayer *mainLayer = [[CAEmitterLayer alloc] init];
        mainLayer.name = @"Main Layer";
        
        CAEmitterCell *cellOne = [[CAEmitterCell alloc] init];
        cellOne.name = @"Cell One";
        
        CAEmitterCell *cellTwo = [[CAEmitterCell alloc] init];
        cellTwo.name = @"Cell Two";
        
        mainLayer.emitterCells = @[cellOne, cellTwo];
        CAEmitterCell *cellA = [[CAEmitterCell alloc] init];
        cellTwo.name = @"Cell A";
        [mainLayer.emitterCells[0] setEmitterCells:@[cellA]];
        
        [_layers addObject:mainLayer];
        
    }
    
    return self;
}

-(NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    return !item ? [self.layers count] : [[item emitterCells] count];
}

-(BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
    return !item ? NO : [[item emitterCells] count] != 0;
}

-(id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    return !item ? self.layers[index] : [[item emitterCells] objectAtIndex:index];
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
    if ([[tableColumn identifier] isEqualToString:@"name"]) {
        NSLog(@"%@", [item name]);
        return [item name];
    }
    
    return @"";
}

@end
