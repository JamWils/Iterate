//
//  OutlineDelegate.m
//  IterateOSX
//
//  Created by James Wilson on 11/14/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "OutlineDelegateManager.h"

@interface OutlineDelegateManager ()

@property (copy) OutlineTableViewParentObjectBlock parentObjectBlock;

@end

@implementation OutlineDelegateManager  {
    CAEmitterCell *_cell;
    id _selectedItem;
    NSMutableString *_keyPathForSelectedItem;
}

- (instancetype)init {
    return nil;
}

- (instancetype)initWithParentObjectBlock:(OutlineTableViewParentObjectBlock)parentObjectBlock {
    self = [super init];
    if (self) {
        _parentObjectBlock = [parentObjectBlock copy];
        _keyPathForSelectedItem = [[NSMutableString alloc] init];
    }
    
    return self;
}

- (NSString*)imageNameForItem:(id)item {
    NSString *imageName = @"";
    
    if ([item isKindOfClass:[CAEmitterCell class]]) {
        imageName = @"CAEmitterCell OutlineIcon Active";
    } else if ([item isKindOfClass:[CAEmitterLayer class]]) {
        imageName = @"CAEmitterLayer OutlineIcon Active";
    } else if ([item isKindOfClass:[CATransformLayer class]]) {
        imageName = @"CATransformLayer OutlineIcon Active";
    } else {
        imageName = @"CALayer OutlineIcon Active";
    }
    
    return imageName;
}

- (CAEmitterLayer*)layerForEmitterCell:(CAEmitterCell*)emitterCell {
    CAEmitterLayer *emitterLayer = nil;
    
    [_keyPathForSelectedItem insertString:[NSString stringWithFormat:@"emitterCells.%@.", emitterCell.name] atIndex:0];
    
//    id parentItem = [outlineView parentForItem:emitterCell];
    id parentItem;
    if ([parentItem isKindOfClass:[CAEmitterCell class]]) {
        
        parentItem = [self layerForEmitterCell:parentItem /*There is a missing outline view parameter here*/];
        
        if ([parentItem isKindOfClass:[CAEmitterLayer class]]) {
            emitterLayer = parentItem;
        }
    } else {
        emitterLayer = parentItem;
    }
    
    return emitterLayer;
}

@end
