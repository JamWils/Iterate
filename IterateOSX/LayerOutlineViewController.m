//
//  LayerOutlineViewController.m
//  IterateOSX
//
//  Created by James Wilson on 9/24/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "LayerOutlineViewController.h"
#import "OutlineViewDataSourceManager.h"
#import "OutlineViewLayerDelegateManager.h"

@interface LayerOutlineViewController ()

@property (strong) OutlineViewDataSourceManager *layerSourceManager;
@property (strong) OutlineViewLayerDelegateManager *layerDelegate;
@property (strong) id item;

@end

@implementation LayerOutlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    id value = [_layers count] > 0 ? @(0) : nil;
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:@"selectedOutlineViewRow"];
    
}

- (void)viewWillAppear {
    [super viewWillAppear];
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _layerSourceManager = [[OutlineViewDataSourceManager alloc] initWithLayers:_layers];
    _layerOutlineView.dataSource = _layerSourceManager;
    
    _layerDelegate = [[OutlineViewLayerDelegateManager alloc] init];
    _layerOutlineView.delegate = _layerDelegate;
    
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedOutlineViewRow"];
    [_layerOutlineView selectRowIndexes:[NSIndexSet indexSetWithIndex:[number intValue]] byExtendingSelection:YES];
}

- (void)viewWillDisappear {
    [super viewWillDisappear];
    NSLog(@"%s", __PRETTY_FUNCTION__);
}


- (void)allProperties {
    
}

@end
