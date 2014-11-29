//
//  OutlineDataManager.h
//  IterateOSX
//
//  Created by James Wilson on 11/13/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OutlineDataManager : NSObject

- (instancetype)initWithLayers:(NSMutableArray*)layers;

@property (copy) NSMutableArray *layers;

- (NSInteger) numberOfChildrenOfItem:(id)item;
- (BOOL) isItemExpandable:(id)item;
- (id)child:(NSInteger)index ofItem:(id)item;

- (NSInteger)numberOfTotalChildren:(id)item;

@end
