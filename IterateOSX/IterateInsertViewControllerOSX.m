//
//  IterateInsertViewController.m
//  IterateOSX
//
//  Created by James Wilson on 9/29/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "IterateInsertViewControllerOSX.h"
#import "IterateWindowController.h"
#import "IterateMacDocument.h"
#import "IterateInsertSharedViewController.h"
@import QuartzCore;

@interface IterateInsertViewControllerOSX ()

@end

@implementation IterateInsertViewControllerOSX

@synthesize sharedViewController = _sharedViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear {
    [super viewWillAppear];
    [self connectTargetActionsToButtons];
    
    _addEmitterCellButton.enabled = _sharedViewController.selectedItem != nil;
    
    if ([_sharedViewController.selectedItem isKindOfClass:[CAEmitterCell class]]) {
        _addLayerButton.enabled = NO;
        _addTransformLayerButton.enabled = NO;
        _addEmitterLayerButton.enabled = NO;
    }
}

- (void) connectTargetActionsToButtons {
    [_addLayerButton setTarget:self.sharedViewController];
    [_addLayerButton setAction:@selector(addLayer:)];
    
    [_addTransformLayerButton setTarget:self.sharedViewController];
    [_addTransformLayerButton setAction:@selector(addTransformLayer:)];
    
    [_addEmitterLayerButton setTarget:self.sharedViewController];
    [_addEmitterLayerButton setAction:@selector(addEmitterLayer:)];
    
    [_addEmitterCellButton setTarget:self.sharedViewController];
    [_addEmitterCellButton setAction:@selector(addEmitterCell:)];
}

@end
