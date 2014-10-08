//
//  IteratePropertiesActiveViewController.m
//  IterateOSX
//
//  Created by James Wilson on 10/5/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "ActivePropertiesViewController.h"
#import "ContainerLayoutView.h"
#import "CategoryInformation.h"

@interface ActivePropertiesViewController ()

@property (strong) NSViewController *mainCellViewController;

@end

@implementation ActivePropertiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
////
//    if ([_scrollView.documentView respondsToSelector:@selector(translatesAutoresizingMaskIntoConstraints)]) {
//        [_scrollView.documentView setValue:@(NO) forKey:@"translatesAutoresizingMaskIntoConstraints"];
//    }
//
//    
//    
//    NSViewController *emitterCellMainViewController = [self.storyboard instantiateControllerWithIdentifier:@"EmitterCellMainViewController"];
//    [self addChildViewController:emitterCellMainViewController];
//    [_scrollView.documentView addSubview:emitterCellMainViewController.view];
//    emitterCellMainViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    ContainerLayoutView *containerView = (ContainerLayoutView*)emitterCellMainViewController.view;
//    NSViewController *emitterCellColorViewController = [self.storyboard instantiateControllerWithIdentifier:@"EmitterCellColorViewController"];
//    [self addChildViewController:emitterCellColorViewController];
//    [_scrollView.documentView addSubview:emitterCellColorViewController.view];
//        emitterCellColorViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    NSViewController *emitterCellMotionViewController = [self.storyboard instantiateControllerWithIdentifier:@"EmitterCellMotionViewController"];
//    [self addChildViewController:emitterCellMotionViewController];
//    [_scrollView.documentView addSubview:emitterCellMotionViewController.view];
//        emitterCellMotionViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    NSLayoutConstraint *mainHeight = [NSLayoutConstraint constraintWithItem:emitterCellMainViewController.view
//                                                               attribute:NSLayoutAttributeHeight
//                                                               relatedBy:NSLayoutRelationEqual
//                                                                  toItem:nil
//                                                               attribute:NSLayoutAttributeNotAnAttribute
//                                                              multiplier:1.0
//                                                                constant:180];
//    [emitterCellMainViewController.view addConstraint:mainHeight];
//    
//    if ([containerView respondsToSelector:@selector(setContainerHeight:)]) {
//        containerView.containerHeight = mainHeight;
//    }
//    
//    
//    NSLayoutConstraint *mainTop = [NSLayoutConstraint constraintWithItem:emitterCellMainViewController.view
//                                                               attribute:NSLayoutAttributeTop
//                                                               relatedBy:NSLayoutRelationEqual
//                                                                  toItem:_scrollView.documentView
//                                                               attribute:NSLayoutAttributeTop
//                                                              multiplier:1.0
//                                                                constant:0];
//    [_scrollView.documentView addConstraint:mainTop];
//    
//    
//    NSLayoutConstraint *mainLeft = [NSLayoutConstraint constraintWithItem:emitterCellMainViewController.view
//                                                               attribute:NSLayoutAttributeLeft
//                                                               relatedBy:NSLayoutRelationEqual
//                                                                  toItem:_scrollView.documentView
//                                                               attribute:NSLayoutAttributeLeft
//                                                              multiplier:1.0
//                                                                constant:0];
//    [_scrollView.documentView addConstraint:mainLeft];
//    
//    NSLayoutConstraint *mainRight = [NSLayoutConstraint constraintWithItem:emitterCellMainViewController.view
//                                                                attribute:NSLayoutAttributeRight
//                                                                relatedBy:NSLayoutRelationEqual
//                                                                   toItem:_scrollView.documentView
//                                                                attribute:NSLayoutAttributeRight
//                                                               multiplier:1.0
//                                                                 constant:0];
//    [_scrollView.documentView addConstraint:mainRight];
//    
//    NSLayoutConstraint *colorHeight = [NSLayoutConstraint constraintWithItem:emitterCellColorViewController.view
//                                                                  attribute:NSLayoutAttributeHeight
//                                                                  relatedBy:NSLayoutRelationEqual
//                                                                     toItem:nil
//                                                                  attribute:NSLayoutAttributeNotAnAttribute
//                                                                 multiplier:1.0
//                                                                   constant:366];
//    [emitterCellColorViewController.view addConstraint:colorHeight];
//    
//    NSLayoutConstraint *colorTop = [NSLayoutConstraint constraintWithItem:emitterCellColorViewController.view
//                                                                attribute:NSLayoutAttributeTop
//                                                                relatedBy:NSLayoutRelationEqual
//                                                                   toItem:emitterCellMainViewController.view
//                                                                attribute:NSLayoutAttributeBottom
//                                                               multiplier:1.0
//                                                                 constant:0];
//    [_scrollView.documentView addConstraint:colorTop];
//    
//    NSLayoutConstraint *colorLeft = [NSLayoutConstraint constraintWithItem:emitterCellColorViewController.view
//                                                                attribute:NSLayoutAttributeLeft
//                                                                relatedBy:NSLayoutRelationEqual
//                                                                   toItem:_scrollView.documentView
//                                                                attribute:NSLayoutAttributeLeft
//                                                               multiplier:1.0
//                                                                 constant:0];
//    [_scrollView.documentView addConstraint:colorLeft];
//    
//    NSLayoutConstraint *colorRight = [NSLayoutConstraint constraintWithItem:emitterCellColorViewController.view
//                                                                 attribute:NSLayoutAttributeRight
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:_scrollView.documentView
//                                                                 attribute:NSLayoutAttributeRight
//                                                                multiplier:1.0
//                                                                  constant:0];
//    [_scrollView.documentView addConstraint:colorRight];
//    
//    NSLayoutConstraint *motionHeight = [NSLayoutConstraint constraintWithItem:emitterCellMotionViewController.view
//                                                                   attribute:NSLayoutAttributeHeight
//                                                                   relatedBy:NSLayoutRelationEqual
//                                                                      toItem:nil
//                                                                   attribute:NSLayoutAttributeNotAnAttribute
//                                                                  multiplier:1.0
//                                                                    constant:341];
//    [emitterCellMotionViewController.view addConstraint:motionHeight];
//    
//    NSLayoutConstraint *motionTop = [NSLayoutConstraint constraintWithItem:emitterCellMotionViewController.view
//                                                                attribute:NSLayoutAttributeTop
//                                                                relatedBy:NSLayoutRelationEqual
//                                                                   toItem:emitterCellColorViewController.view
//                                                                attribute:NSLayoutAttributeBottom
//                                                               multiplier:1.0
//                                                                 constant:0];
//    [_scrollView.documentView addConstraint:motionTop];
//    
//    NSLayoutConstraint *motionLeft = [NSLayoutConstraint constraintWithItem:emitterCellMotionViewController.view
//                                                                 attribute:NSLayoutAttributeLeft
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:_scrollView.documentView
//                                                                 attribute:NSLayoutAttributeLeft
//                                                                multiplier:1.0
//                                                                  constant:0];
//    [_scrollView.documentView addConstraint:motionLeft];
//    
//    NSLayoutConstraint *motionRight = [NSLayoutConstraint constraintWithItem:emitterCellMotionViewController.view
//                                                                  attribute:NSLayoutAttributeRight
//                                                                  relatedBy:NSLayoutRelationEqual
//                                                                     toItem:_scrollView.documentView
//                                                                  attribute:NSLayoutAttributeRight
//                                                                 multiplier:1.0
//                                                                   constant:0];
//    [_scrollView.documentView addConstraint:motionRight];
//    
//    NSLayoutConstraint *contentViewHeight = [NSLayoutConstraint constraintWithItem:_scrollView.documentView
//                                                                         attribute:NSLayoutAttributeHeight
//                                                                         relatedBy:NSLayoutRelationEqual
//                                                                            toItem:nil
//                                                                         attribute:NSLayoutAttributeNotAnAttribute
//                                                                        multiplier:1.0
//                                                                          constant:180+341+366];
//    [_scrollView.documentView addConstraint:contentViewHeight];
//    
//    NSLayoutConstraint *documentTop = [NSLayoutConstraint constraintWithItem:_scrollView.documentView
//                                                                 attribute:NSLayoutAttributeTop
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:_scrollView.contentView
//                                                                 attribute:NSLayoutAttributeBottom
//                                                                multiplier:1.0
//                                                                  constant:0];
//    [_scrollView.contentView addConstraint:documentTop];
//
//    NSLayoutConstraint *documentLeft = [NSLayoutConstraint constraintWithItem:_scrollView.documentView
//                                                                  attribute:NSLayoutAttributeLeft
//                                                                  relatedBy:NSLayoutRelationEqual
//                                                                     toItem:_scrollView.contentView
//                                                                  attribute:NSLayoutAttributeLeft
//                                                                 multiplier:1.0
//                                                                   constant:0];
//    [_scrollView.contentView addConstraint:documentLeft];
//    
//    NSLayoutConstraint *documentRight = [NSLayoutConstraint constraintWithItem:_scrollView.documentView
//                                                                   attribute:NSLayoutAttributeRight
//                                                                   relatedBy:NSLayoutRelationEqual
//                                                                      toItem:_scrollView.contentView
//                                                                   attribute:NSLayoutAttributeRight
//                                                                  multiplier:1.0
//                                                                    constant:0];
//    [_scrollView.contentView addConstraint:documentRight];
//    
//    containerView.scrollViewDocumentHeight = contentViewHeight;
    
    [self addConstraintWithView:_scrollView.documentView toView:_scrollView.contentView withAttributes:@[@(NSLayoutAttributeRight)] withConstant:0];
    [self addConstraintWithView:_scrollView.documentView toView:_scrollView.contentView withAttributes:@[@(NSLayoutAttributeLeft)] withConstant:0];
    
    //If there is an issue with the layout this line could be the problem.
    [self addConstraintWithView:_scrollView.documentView toView:_scrollView.contentView withAttributes:@[@(NSLayoutAttributeTop)] withConstant:0];
    
}

- (void)viewDidLayout {
    [super viewDidLayout];
    
    NSLog(@"After Main Cell container view size: %@", NSStringFromSize(((NSViewController*)self.childViewControllers[0]).view.frame.size));
}

- (void)addChildViewControllers:(NSArray*)categoryItems {
    __block id previousView = _scrollView.documentView;
    [categoryItems enumerateObjectsUsingBlock:^(CategoryInformation *categoryItem, NSUInteger idx, BOOL *stop) {
        NSViewController *viewController = [self.storyboard instantiateControllerWithIdentifier:categoryItem.storyboardIdentifier];
        
        [viewController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addChildViewController:viewController];
        [_scrollView.documentView addSubview:viewController.view];
        
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
        
        [self addConstraintWithView:viewController.view
                             toView:previousView
                            forView:_scrollView.documentView
                     withAttributes:@[@(NSLayoutAttributeTop), @(NSLayoutAttributeBottom)]
                       withConstant:0];
        
        previousView = viewController.view;
    }];
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
