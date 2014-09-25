//
//  LayerOutlineViewController.m
//  IterateOSX
//
//  Created by James Wilson on 9/24/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "LayerOutlineViewController.h"
#import "OutlineViewDataSourceManager.h"

@interface LayerOutlineViewController () <NSOutlineViewDelegate>

@property (strong) OutlineViewDataSourceManager *layerSourceManager;
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
    _layerOutlineView.delegate = self;
    
//    self.item = self.layers[0];

//    [self.layerOutlineView addObserver:self forKeyPath:@"selectedRow" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewWillDisappear {
    [super viewWillDisappear];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item {
    _item = item;
    return YES;
}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification {
    NSDictionary *userInfo = @{ @"Layer" : _item };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DidChangeSelectedViewNotification" object:self userInfo:userInfo];
}

- (void)outlineViewSelectionIsChanging:(NSNotification *)notification {
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
}

- (void)allProperties {
    
}

@end
