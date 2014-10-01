//
//  OutlineViewLayerDelegateManager.m
//  IterateOSX
//
//  Created by James Wilson on 9/26/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "OutlineViewLayerDelegateManager.h"
@import IterateOSXFramework;

@interface OutlineViewLayerDelegateManager ()

@property (copy) OutlineViewParentObjectBlock parentObjectBlock;

@end

@implementation OutlineViewLayerDelegateManager {
    CAEmitterCell *_cell;
    id _selectedItem;
}

- (instancetype)init {
    return nil;
}

- (instancetype)initWithParentObjectBlock:(OutlineViewParentObjectBlock)parentObjectBlock {
    self = [super init];
    if (self) {
        _parentObjectBlock = [parentObjectBlock copy];
    }
    
    return self;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item {
    _selectedItem = item;
    if ([_selectedItem isKindOfClass:[CAEmitterCell class]]) {
        CAEmitterLayer *emitterLayer = [self layerForEmitterCell:_selectedItem inOutlineView:outlineView];
        _activeLayer = emitterLayer;
    } else {
        _activeLayer = item;
    }
    
    return YES;
}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification {
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    
    if (_selectedItem != nil && _activeLayer != nil) {
        [userInfo setValue:_activeLayer forKey:@"layer"];
        _parentObjectBlock(_activeLayer, _selectedItem);
        
        if ([_selectedItem isKindOfClass:[CAEmitterCell class]]) {
            
            [userInfo setValue:_selectedItem forKey:@"emitterCell"];
            [[NSNotificationCenter defaultCenter] postNotificationName:kDidChangeSelectedEmitterCellNotification object:self userInfo:userInfo];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kDidChangeSelectedLayerNotification object:self userInfo:userInfo];
    }
    
    
}

- (void)outlineViewSelectionIsChanging:(NSNotification *)notification {
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
}

- (CAEmitterLayer*)layerForEmitterCell:(CAEmitterCell*)emitterCell inOutlineView:(NSOutlineView*)outlineView {
    CAEmitterLayer *emitterLayer = nil;
    
    id parentItem = [outlineView parentForItem:emitterCell];
    if ([parentItem isKindOfClass:[CAEmitterCell class]]) {
        parentItem = [self layerForEmitterCell:parentItem inOutlineView:outlineView];
    } else {
        emitterLayer = parentItem;
    }
    
    return emitterLayer;
}

@end
