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

#import "IterateWindowController.h"

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
    
    [self addObserver:self.layers forKeyPath:@"layers" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)viewWillAppear {
    [super viewWillAppear];
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _layerSourceManager = [[OutlineViewDataSourceManager alloc] initWithLayers:_layers];
    _layerOutlineView.dataSource = _layerSourceManager;
    
    _layerDelegate = [[OutlineViewLayerDelegateManager alloc] initWithParentObjectBlock:^(id parentObject, id selectedItem, NSString *keyPathForSelectedItem) {
        id windowController = self.view.window.windowController;
        if ([windowController isKindOfClass:[IterateWindowController class]]) {
            IterateWindowController *iterateWindowController = (IterateWindowController*)windowController;
            iterateWindowController.parentObject = parentObject;
            iterateWindowController.selectedItem = selectedItem;
            iterateWindowController.keyPathForSelectedItem = keyPathForSelectedItem;
        }
        
    }];
    _layerOutlineView.delegate = _layerDelegate;
    
    
    
//    [_layerDelegate outlineView:_layerOutlineView shouldSelectItem:_layerOutlineView.selectedCell];
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedOutlineViewRow"];
    [_layerOutlineView selectRowIndexes:[NSIndexSet indexSetWithIndex:[number intValue]] byExtendingSelection:YES];
}

- (void)viewWillDisappear {
    [super viewWillDisappear];
    [[NSUserDefaults standardUserDefaults] setObject:@(_layerOutlineView.selectedRow) forKey:@"selectedOutlineViewRow"];
}

- (void)setLayers:(NSMutableArray *)layers {
    _layers = layers;
    [_layerSourceManager setValue:_layers forKey:@"layers"];
    [_layerOutlineView reloadData];
}
@end
