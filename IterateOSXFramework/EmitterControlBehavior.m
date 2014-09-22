//
//  EmitterControlBehavior.m
//  IterateOSX
//
//  Created by James Wilson on 9/21/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "EmitterControlBehavior.h"
#import "ViewController.h"

@implementation EmitterControlBehavior

- (void)updateValues:(id)value {
    if ([self.owner isKindOfClass:[NSViewController class]]) {
        NSViewController *viewController = (NSViewController*)self.owner;
        if ([viewController.parentViewController isKindOfClass:[NSViewController class]]) {
            NSViewController *containerViewController = (NSViewController*)viewController.parentViewController;
            
            if ([containerViewController.parentViewController isKindOfClass:[NSSplitViewController class]]) {
                NSSplitViewController *splitViewController = (NSSplitViewController*)containerViewController.parentViewController;
                NSViewController *detailViewController = (NSViewController*)splitViewController.childViewControllers[1];
                
                if ([detailViewController respondsToSelector:@selector(updateEmitterCellProperty:withValue:)]) {
                    [detailViewController performSelector:@selector(updateEmitterCellProperty:withValue:) withObject:_emitterCellProperty withObject:value];
                }
                
            }
        }
    }
}

@end
