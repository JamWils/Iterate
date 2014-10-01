//
//  OutlineViewLayerDelegateManager.h
//  IterateOSX
//
//  Created by James Wilson on 9/26/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

@import AppKit;
@import QuartzCore;

typedef void (^OutlineViewParentObjectBlock)(id parentObject, id selectedItem);

@interface OutlineViewLayerDelegateManager : NSObject <NSOutlineViewDelegate>

- (instancetype)initWithParentObjectBlock:(OutlineViewParentObjectBlock)parentObjectBlock;

@property (strong) CALayer *activeLayer;
@property (strong) id selectedItem;

@end
