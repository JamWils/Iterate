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
        _emitterCellPropertyControlHeight.animator.constant = 0;
        _containerHeight.animator.constant = 40;
        
        containerLayoutView = [self retrieveContainerView];
        if (containerLayoutView != nil) {
            containerLayoutView.containerHeight.animator.constant = 40;
            containerLayoutView.scrollViewHeight.animator.constant -= (_defaultHeight - 40);
        }
        
    } else {
        sender.title = @"Hide";
        _emitterCellPropertyControlHeight.animator.constant = 56;
        _containerHeight.animator.constant = _defaultHeight;
        
        containerLayoutView = [self retrieveContainerView];
        if (containerLayoutView != nil) {
            containerLayoutView.containerHeight.animator.constant = _defaultHeight;
            containerLayoutView.scrollViewHeight.animator.constant += (_defaultHeight - 40);
        }
    }
    
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {        
        [self.window layoutIfNeeded];
    } completionHandler:^{
        
    }];
    
//    if ([self.owner isKindOfClass:[NSScrollView class]]) {
//        NSScrollView *scrollView = (NSScrollView*)self.owner;
//        NSView *documentView = (NSView*)scrollView.documentView;
//        documentView.frame = NSRectFromCGRect(CGRectMake(0, 0, 250.0, 5000.0));
////        scrollView.documentView.frame = NSRectFromCGRect(CGRectMake(0, 0, 250, 5000));
//    }
    
//    NSScrollView *scrollView = [[NSScrollView alloc] init];
//    scrollView.translatesAutoresizingMaskIntoConstraints
}

- (ContainerLayoutView*)retrieveContainerView {
    ContainerLayoutView *containerView = nil;
    if ([self.owner isKindOfClass:[NSView class]]) {
        NSView *view = (NSView*)self.owner;
        if ([view.superview isKindOfClass:[ContainerLayoutView class]]) {
            containerView = (ContainerLayoutView*)view.superview;
        }
    }
    
    return containerView;
}

@end
