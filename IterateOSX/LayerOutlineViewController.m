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
    
}

- (void)viewWillAppear {
    [super viewWillAppear];
    
    _layerSourceManager = [[OutlineViewDataSourceManager alloc] initWithLayers:_layers];
    _layerOutlineView.dataSource = _layerSourceManager;
    
    _layerDelegate = [[OutlineViewLayerDelegateManager alloc] init];
    _layerOutlineView.delegate = _layerDelegate;
}

- (void)viewWillDisappear {
    [super viewWillDisappear];
}



- (void)allProperties {
    
}

@end
