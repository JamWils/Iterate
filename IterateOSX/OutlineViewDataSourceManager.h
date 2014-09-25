//
//  OutlineViewController.h
//  IterateOSX
//
//  Created by James Wilson on 9/23/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface OutlineViewDataSourceManager : NSObject <NSOutlineViewDataSource>

- (instancetype)initWithLayers:(NSMutableArray*)layers;

@property (copy) NSMutableArray *layers;

@end
