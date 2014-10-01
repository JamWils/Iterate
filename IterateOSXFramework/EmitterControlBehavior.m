//
//  EmitterControlBehavior.m
//  IterateOSX
//
//  Created by James Wilson on 9/21/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "EmitterControlBehavior.h"
#import "IterateConstants.h"
#import "LayerContentViewControllerProtocol.h"
@import QuartzCore;

@implementation EmitterControlBehavior

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (_isCellProperty) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emitterCellNotification:) name:kDidChangeSelectedEmitterCellNotification object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(layerNotification:) name:kDidChangeSelectedLayerNotification object:nil];
    }

}

- (void)updateValues:(id)value {
    if ([self.owner isKindOfClass:[NSViewController class]]) {
        NSViewController *viewController = (NSViewController*)self.owner;
        if ([viewController.parentViewController isKindOfClass:[NSViewController class]]) {
            NSViewController *containerViewController = (NSViewController*)viewController.parentViewController;
            
            if ([containerViewController.parentViewController isKindOfClass:[NSSplitViewController class]]) {
                id detailViewController = nil;
                
                NSString *keyPath = nil;
                if (_isCellProperty) {
                    NSSplitViewController *splitViewController = (NSSplitViewController*)containerViewController.parentViewController;
                    detailViewController = splitViewController.childViewControllers[1];
                    keyPath = _emitterProperty;
                } else {
                    NSSplitViewController *splitViewController = (NSSplitViewController*)containerViewController.parentViewController;
                    NSViewController *leftBottomController = (NSViewController*)splitViewController.childViewControllers[1];
                    if ([leftBottomController.parentViewController isKindOfClass:[NSSplitViewController class]]) {
                        NSSplitViewController *parentSplitViewController = (NSSplitViewController*)leftBottomController.parentViewController.parentViewController;
                        detailViewController = parentSplitViewController.childViewControllers[1];
                    }
                    
                    keyPath = _emitterProperty;
                }
                
                if ([detailViewController respondsToSelector:@selector(updateEmitterCellProperty:withValue:isCellValue:)]) {
                    NSMethodSignature *signature  = [detailViewController methodSignatureForSelector:@selector(updateEmitterCellProperty:withValue:isCellValue:)];
                    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
                    
                    [invocation setTarget:detailViewController];
                    [invocation setSelector:@selector(updateEmitterCellProperty:withValue:isCellValue:)];
                    [invocation setArgument:&keyPath atIndex:2];
                    [invocation setArgument:&value atIndex:3];
                    [invocation setArgument:&_isCellProperty atIndex:4];
                    [invocation invoke];
                }
                
            }
        }
    }
}



- (void)updateControls:(id)aObject {
    
}

- (void)layerNotification:(NSNotification*)notification {
    id layer = [notification.userInfo valueForKey:@"layer"];
    [self updateControls:layer];
}

- (void)emitterCellNotification:(NSNotification*)notification {
    if (notification.userInfo != nil || [notification.userInfo valueForKey:@"emitterCell"]) {
        id emitterCell = [notification.userInfo valueForKey:@"emitterCell"];
        [self updateControls:emitterCell];
    }
}

- (void)dealloc {
    //TODO: Write unit tests for deallocation
    if (_isCellProperty) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kDidChangeSelectedEmitterCellNotification object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kDidChangeSelectedLayerNotification object:nil];
    }
}

@end
