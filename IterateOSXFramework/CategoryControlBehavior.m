//
//  CategoryControlBehavior.m
//  IterateOSX
//
//  Created by James Wilson on 9/18/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "CategoryControlBehavior.h"
#import "ContainerLayoutView.h"

@interface CategoryControlBehavior ()

@property (weak) IBOutlet NSLayoutConstraint *emitterCellPropertyControlHeight;
@property (weak) IBOutlet NSLayoutConstraint *containerHeight;


@end

@implementation CategoryControlBehavior

- (void)awakeFromNib {
    _categoryLabel.stringValue = _categoryName;
}

- (IBAction)toggleHiddenClicked:(NSButton*)sender {
    ContainerLayoutView *containerLayoutView = nil;
    
    if ([sender.title isEqualToString:@"Hide"]) {
        sender.title = @"Show";
//        _emitterCellPropertyControlHeight.animator.constant = 0;
        _containerHeight.animator.constant = 40;
        
        containerLayoutView = [self retrieveContainerView];
        if (containerLayoutView != nil) {
            containerLayoutView.containerHeight.animator.constant = 40;
            containerLayoutView.scrollViewDocumentHeight.animator.constant -= (_defaultHeight - 40);
        }
        
    } else {
        sender.title = @"Hide";
//        _emitterCellPropertyControlHeight.animator.constant = 56;
        _containerHeight.animator.constant = _defaultHeight;
        
        containerLayoutView = [self retrieveContainerView];
        if (containerLayoutView != nil) {
            containerLayoutView.containerHeight.animator.constant = _defaultHeight;
            containerLayoutView.scrollViewDocumentHeight.animator.constant += (_defaultHeight - 40);
        }
    }
    
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {        
        [self.window layoutIfNeeded];
    } completionHandler:^{
        
    }];
}

- (ContainerLayoutView*)retrieveContainerView {
    ContainerLayoutView *containerView = nil;
    if ([self.owner isKindOfClass:[NSView class]]) {
        NSView *view = (NSView*)self.owner;
        if ([view isKindOfClass:[ContainerLayoutView class]]) {
            containerView = (ContainerLayoutView*)view;
        }
    }
    
    return containerView;
}

-(void)changeConstraint:(NSLayoutConstraint*)constraint toConstant:(int)newConstant {
    int oldConstant = constraint.constant;
    
    if (oldConstant != newConstant) {
        constraint.animator.constant = newConstant;
        
        ContainerLayoutView *containerLayoutView = [self retrieveContainerView];
        if (containerLayoutView != nil) {
            if (oldConstant < newConstant) {
                containerLayoutView.containerHeight.animator.constant += newConstant;
                containerLayoutView.scrollViewDocumentHeight.animator.constant += newConstant;
                _defaultHeight += newConstant;
                _containerHeight.animator.constant = _defaultHeight;
            } else {
                containerLayoutView.containerHeight.animator.constant -= oldConstant;
                containerLayoutView.scrollViewDocumentHeight.animator.constant -= oldConstant;
                _defaultHeight -= oldConstant;
                _containerHeight.animator.constant = _defaultHeight;
            }
            
        }
        
        [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
            [self.window layoutIfNeeded];
        } completionHandler:^{
            
        }];
    }
    
}

@end
