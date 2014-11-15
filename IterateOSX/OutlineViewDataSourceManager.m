//
//  OutlineViewController.m
//  IterateOSX
//
//  Created by James Wilson on 9/23/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "OutlineViewDataSourceManager.h"
#import <QuartzCore/QuartzCore.h>

@interface OutlineViewDataSourceManager ()

@property (strong, nonatomic) OutlineDataManager *dataManager;

@end

@implementation OutlineViewDataSourceManager

- (instancetype)init {
    return nil;
}

- (instancetype)initWithDataSourceManager:(OutlineDataManager*)dataManager{
    self = [super init];
    if (self) {
        _dataManager = dataManager;
    }
    
    return self;
}

-(NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    return [_dataManager numberOfChildrenOfItem:item];
}

-(BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
    return [_dataManager isItemExpandable:item];
}

-(id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    return [_dataManager child:index ofItem:item];
}


@end
