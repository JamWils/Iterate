//
//  OutlineViewLayerDelegateManager.h
//  IterateOSX
//
//  Created by James Wilson on 9/26/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

@import AppKit;
@import QuartzCore;

@interface OutlineViewLayerDelegateManager : NSObject <NSOutlineViewDelegate>

@property (strong) CALayer *activeLayer;
@property (strong) id selectedItem;

@end
