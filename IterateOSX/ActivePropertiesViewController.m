//
//  IteratePropertiesActiveViewController.m
//  IterateOSX
//
//  Created by James Wilson on 10/5/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "ActivePropertiesViewController.h"

@import IterateOSXFramework;

@interface ActivePropertiesViewController ()

@property (strong) NSViewController *mainCellViewController;
@property (strong, nonatomic) NSLayoutConstraint *scrollViewDocumentHeightConstraint;

@end

@implementation ActivePropertiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;

    if ([_scrollView.documentView respondsToSelector:@selector(translatesAutoresizingMaskIntoConstraints)]) {
        [_scrollView.documentView setValue:@(NO) forKey:@"translatesAutoresizingMaskIntoConstraints"];
    }
    
    NSLayoutConstraint *contentViewHeight = [NSLayoutConstraint constraintWithItem:_scrollView.documentView
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1.0
                                                                          constant:0];
    _scrollViewDocumentHeightConstraint = contentViewHeight;
    [_scrollView.documentView addConstraint:contentViewHeight];
    
    [self addConstraintWithView:_scrollView.documentView toView:_scrollView.contentView withAttributes:@[@(NSLayoutAttributeRight)] withConstant:0];
    [self addConstraintWithView:_scrollView.documentView toView:_scrollView.contentView withAttributes:@[@(NSLayoutAttributeLeft)] withConstant:0];
    
    [self addConstraintWithView:_scrollView.documentView toView:_scrollView.contentView withAttributes:@[@(NSLayoutAttributeTop)] withConstant:0];
}

- (void)viewDidLayout {
    [super viewDidLayout];
}

- (void)addChildViewControllers:(NSArray*)categoryItems {
    __block id previousView = _scrollView.documentView;
    
    __block float heights = 0;
    
    [categoryItems enumerateObjectsUsingBlock:^(CategoryInformation *categoryItem, NSUInteger idx, BOOL *stop) {
        heights += categoryItem.height;
        NSViewController *viewController = [self.storyboard instantiateControllerWithIdentifier:categoryItem.storyboardIdentifier];
        
        
        [self addChildViewController:viewController];
        [_scrollView.documentView addSubview:viewController.view];
        [viewController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self addConstraintWithView:viewController.view
                             toView:nil
                     withAttributes:@[@(NSLayoutAttributeHeight), @(NSLayoutAttributeNotAnAttribute)]
                       withConstant:categoryItem.height];
        
        [self addConstraintWithView:viewController.view
                             toView:_scrollView.documentView
                     withAttributes:@[@(NSLayoutAttributeRight)]
                       withConstant:0];
        
        [self addConstraintWithView:viewController.view
                             toView:_scrollView.documentView
                     withAttributes:@[@(NSLayoutAttributeLeft)]
                       withConstant:0];
        
        if (previousView == _scrollView.documentView) {
            [self addConstraintWithView:viewController.view
                                 toView:previousView
                                forView:_scrollView.documentView
                         withAttributes:@[@(NSLayoutAttributeTop), @(NSLayoutAttributeTop)]
                           withConstant:0];
        } else {
            [self addConstraintWithView:viewController.view
                                 toView:previousView
                                forView:_scrollView.documentView
                         withAttributes:@[@(NSLayoutAttributeTop), @(NSLayoutAttributeBottom)]
                           withConstant:0];
            
        }
        
        
        previousView = viewController.view;
    }];
    
//    for (CategoryInformation *categoryItem in categoryItems) {
//        
//    }
    
    _scrollViewDocumentHeightConstraint.constant = heights;
}

- (void)addConstraintWithView:(NSView*)view toView:(NSView*)toView withAttributes:(NSArray*)attributes withConstant:(float)constant {
    
    NSLayoutAttribute attributeOne = [attributes[0] intValue];
    NSLayoutAttribute attributeTwo = attributes.count == 1 ? [attributes[0] intValue] : [attributes[1] intValue];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view
                                                              attribute:attributeOne
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:toView
                                                              attribute:attributeTwo
                                                             multiplier:1.0
                                                               constant:constant];
    if (toView != nil) {
        [toView addConstraint:constraint];
    } else {
        [view addConstraint:constraint];
        
        if (attributeOne == NSLayoutAttributeHeight && [view isKindOfClass:[ContainerLayoutView class]]) {
            ContainerLayoutView *containerView = (ContainerLayoutView*)view;
            containerView.containerHeightConstraint = constraint;
            containerView.scrollViewDocumentHeightConstraint = _scrollViewDocumentHeightConstraint;
        }
    }
}

- (void)addConstraintWithView:(NSView*)view toView:(NSView*)toView forView:(NSView*)forView withAttributes:(NSArray*)attributes withConstant:(float)constant {
    
    NSLayoutAttribute attributeOne = [attributes[0] intValue];
    NSLayoutAttribute attributeTwo = attributes.count == 1 ? [attributes[0] intValue] : [attributes[1] intValue];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view
                                                                  attribute:attributeOne
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:toView
                                                                  attribute:attributeTwo
                                                                 multiplier:1.0
                                                                   constant:constant];
    [forView addConstraint:constraint];
}



@end
