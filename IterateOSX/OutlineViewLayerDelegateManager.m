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
    NSMutableString *_keyPathForSelectedItem;
}

- (instancetype)init {
    return nil;
}

- (instancetype)initWithParentObjectBlock:(OutlineViewParentObjectBlock)parentObjectBlock {
    self = [super init];
    if (self) {
        _parentObjectBlock = [parentObjectBlock copy];
        _keyPathForSelectedItem = [[NSMutableString alloc] init];
    }
    
    return self;
}

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
    NSTableCellView *cellView = [outlineView makeViewWithIdentifier:@"MainCell" owner:self];
    if ([[tableColumn identifier] isEqualToString:@"name"]) {
        cellView.textField.stringValue = [item name];
        if ([item isKindOfClass:[CAEmitterCell class]]) {
            cellView.imageView.image = [NSImage imageNamed:@"CAEmitterCell OutlineIcon Active"];
        }
        else if ([item isKindOfClass:[CAEmitterLayer class]]) {
            cellView.imageView.image = [NSImage imageNamed:@"CAEmitterLayer OutlineIcon Active"];
        } else if ([item isKindOfClass:[CATransformLayer class]]) {
            cellView.imageView.image = [NSImage imageNamed:@"CATransformLayer OutlineIcon Active"];
        } else {
            cellView.imageView.image = [NSImage imageNamed:@"CALayer OutlineIcon Active"];
        }
        
    }
    
    return cellView;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item {
    [_keyPathForSelectedItem setString:@""];
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
        if (_parentObjectBlock) {
            _parentObjectBlock(_activeLayer, _selectedItem, _keyPathForSelectedItem);
        }
        
        
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
    
    [_keyPathForSelectedItem insertString:[NSString stringWithFormat:@"emitterCells.%@.", emitterCell.name] atIndex:0];
    
    id parentItem = [outlineView parentForItem:emitterCell];
    if ([parentItem isKindOfClass:[CAEmitterCell class]]) {
        
        parentItem = [self layerForEmitterCell:parentItem inOutlineView:outlineView];
        
        if ([parentItem isKindOfClass:[CAEmitterLayer class]]) {
            emitterLayer = parentItem;
        }
    } else {
        emitterLayer = parentItem;
    }
    
    return emitterLayer;
}

@end
