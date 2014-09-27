//
//  EmitterControlBehavior.m
//  IterateOSX
//
//  Created by James Wilson on 9/21/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "EmitterControlBehavior.h"
#import "ViewController.h"
#import "IterateConstants.h"

@implementation EmitterControlBehavior

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (_isCellProperty) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateEmitterCellControls:) name:kDidChangeSelectedEmitterCellNotification object:nil];
    }
    
}

- (void)updateValues:(id)value {
    if ([self.owner isKindOfClass:[NSViewController class]]) {
        NSViewController *viewController = (NSViewController*)self.owner;
        if ([viewController.parentViewController isKindOfClass:[NSViewController class]]) {
            NSViewController *containerViewController = (NSViewController*)viewController.parentViewController;
            
            if ([containerViewController.parentViewController isKindOfClass:[NSSplitViewController class]]) {
                NSSplitViewController *splitViewController = (NSSplitViewController*)containerViewController.parentViewController;
                NSViewController *detailViewController = nil;
                
                NSString *keyPath = nil;
                if (_isCellProperty) {
                    NSSplitViewController *splitViewController = (NSSplitViewController*)containerViewController.parentViewController;
                    detailViewController = (NSViewController*)splitViewController.childViewControllers[1];
                    
                    keyPath = [NSString stringWithFormat:@"%@.%@.%@", @"emitterCells", @"moonParticle", _emitterProperty];
                } else {
                    NSSplitViewController *splitViewController = (NSSplitViewController*)containerViewController.parentViewController;
                    NSViewController *leftBottomController = (NSViewController*)splitViewController.childViewControllers[1];
                    if ([leftBottomController.parentViewController isKindOfClass:[NSSplitViewController class]]) {
                        NSSplitViewController *parentSplitViewController = (NSSplitViewController*)leftBottomController.parentViewController.parentViewController;
                        detailViewController = (NSViewController*)parentSplitViewController.childViewControllers[1];
                    }
                    
                    keyPath = _emitterProperty;
                }
                
                if ([detailViewController respondsToSelector:@selector(updateEmitterCellProperty:withValue:)]) {
                    [detailViewController performSelector:@selector(updateEmitterCellProperty:withValue:) withObject:keyPath withObject:value];
                }
                
            }
        }
    }
}

- (void)updateControls:(NSNotification*)notification {
    
}

- (void)updateEmitterCellControls:(NSNotification*)notification {
    
}

@end
