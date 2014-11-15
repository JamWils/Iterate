//
//  OutlineDelegate.h
//  IterateOSX
//
//  Created by James Wilson on 11/14/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
@import QuartzCore;

typedef void (^OutlineTableViewParentObjectBlock)(id parentObject, id selectedItem, NSString *keyPathForSelectedItem);

@interface OutlineDelegateManager : NSObject

- (instancetype)initWithParentObjectBlock:(OutlineTableViewParentObjectBlock)parentObjectBlock;

- (NSString*)imageNameForItem:(id)item;

@property (strong) CALayer *activeLayer;
@property (strong) id selectedItem;

@end
