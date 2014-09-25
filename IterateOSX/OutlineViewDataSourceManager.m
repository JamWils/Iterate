//
//  OutlineViewController.m
//  IterateOSX
//
//  Created by James Wilson on 9/23/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "OutlineViewDataSourceManager.h"
#import <QuartzCore/QuartzCore.h>

@implementation OutlineViewDataSourceManager

- (instancetype)init {
    return nil;
}

- (instancetype)initWithLayers:(NSMutableArray*)layers {
    self = [super init];
    if (self) {
        _layers = layers;
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
