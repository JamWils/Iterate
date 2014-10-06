//
//  IteratePropertiesActiveViewController.m
//  IterateOSX
//
//  Created by James Wilson on 10/5/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "IteratePropertiesActiveViewController.h"
#import "ContainerLayoutView.h"

@interface IteratePropertiesActiveViewController ()

@property (strong) NSViewController *mainCellViewController;

@end

@implementation IteratePropertiesActiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    if ([_scrollView.documentView respondsToSelector:@selector(translatesAutoresizingMaskIntoConstraints)]) {
        [_scrollView.documentView setValue:@(NO) forKey:@"translatesAutoresizingMaskIntoConstraints"];
    }
    
    
    
    NSViewController *emitterCellMainViewController = [self.storyboard instantiateControllerWithIdentifier:@"EmitterCellMainViewController"];
    [self addChildViewController:emitterCellMainViewController];
    emitterCellMainViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView.documentView addSubview:emitterCellMainViewController.view];
    
    ContainerLayoutView *containerView = (ContainerLayoutView*)emitterCellMainViewController.view;
    
    NSLog(@"Main Cell container view size: %@", NSStringFromSize(emitterCellMainViewController.view.frame.size));
    
    NSViewController *emitterCellColorViewController = [self.storyboard instantiateControllerWithIdentifier:@"EmitterCellColorViewController"];
    [self addChildViewController:emitterCellColorViewController];
    emitterCellColorViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView.documentView addSubview:emitterCellColorViewController.view];
    
    NSViewController *emitterCellMotionViewController = [self.storyboard instantiateControllerWithIdentifier:@"EmitterCellMotionViewController"];
    [self addChildViewController:emitterCellMotionViewController];
    emitterCellMotionViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView.documentView addSubview:emitterCellMotionViewController.view];
    
    NSLayoutConstraint *mainHeight = [NSLayoutConstraint constraintWithItem:emitterCellMainViewController.view
                                                               attribute:NSLayoutAttributeHeight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                              multiplier:1.0
                                                                constant:180];
    [emitterCellMainViewController.view addConstraint:mainHeight];
    
    if ([containerView respondsToSelector:@selector(setContainerHeight:)]) {
        containerView.containerHeight = mainHeight;
    }
    
    containerView.testProperty = @"Test";
    containerView.testConstraint = mainHeight;
    
    
    NSLayoutConstraint *mainTop = [NSLayoutConstraint constraintWithItem:emitterCellMainViewController.view
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:_scrollView.documentView
                                                               attribute:NSLayoutAttributeTop
                                                              multiplier:1.0
                                                                constant:0];
    [_scrollView.documentView addConstraint:mainTop];
    
    NSLayoutConstraint *mainLeft = [NSLayoutConstraint constraintWithItem:emitterCellMainViewController.view
                                                               attribute:NSLayoutAttributeLeft
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:_scrollView.documentView
                                                               attribute:NSLayoutAttributeLeft
                                                              multiplier:1.0
                                                                constant:0];
    [_scrollView.documentView addConstraint:mainLeft];
    
    NSLayoutConstraint *mainRight = [NSLayoutConstraint constraintWithItem:emitterCellMainViewController.view
                                                                attribute:NSLayoutAttributeRight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_scrollView.documentView
                                                                attribute:NSLayoutAttributeRight
                                                               multiplier:1.0
                                                                 constant:0];
    [_scrollView.documentView addConstraint:mainRight];
    
    NSLayoutConstraint *colorHeight = [NSLayoutConstraint constraintWithItem:emitterCellColorViewController.view
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1.0
                                                                   constant:366];
    [emitterCellColorViewController.view addConstraint:colorHeight];
    
    NSLayoutConstraint *colorTop = [NSLayoutConstraint constraintWithItem:emitterCellColorViewController.view
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:emitterCellMainViewController.view
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1.0
                                                                 constant:0];
    [_scrollView.documentView addConstraint:colorTop];
    
    NSLayoutConstraint *colorLeft = [NSLayoutConstraint constraintWithItem:emitterCellColorViewController.view
                                                                attribute:NSLayoutAttributeLeft
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_scrollView.documentView
                                                                attribute:NSLayoutAttributeLeft
                                                               multiplier:1.0
                                                                 constant:0];
    [_scrollView.documentView addConstraint:colorLeft];
    
    NSLayoutConstraint *colorRight = [NSLayoutConstraint constraintWithItem:emitterCellColorViewController.view
                                                                 attribute:NSLayoutAttributeRight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:_scrollView.documentView
                                                                 attribute:NSLayoutAttributeRight
                                                                multiplier:1.0
                                                                  constant:0];
    [_scrollView.documentView addConstraint:colorRight];
    
    NSLayoutConstraint *motionHeight = [NSLayoutConstraint constraintWithItem:emitterCellMotionViewController.view
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1.0
                                                                    constant:341];
    [emitterCellMotionViewController.view addConstraint:motionHeight];
    
    NSLayoutConstraint *motionTop = [NSLayoutConstraint constraintWithItem:emitterCellMotionViewController.view
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:emitterCellColorViewController.view
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1.0
                                                                 constant:0];
    [_scrollView.documentView addConstraint:motionTop];
    
    NSLayoutConstraint *motionLeft = [NSLayoutConstraint constraintWithItem:emitterCellMotionViewController.view
                                                                 attribute:NSLayoutAttributeLeft
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:_scrollView.documentView
                                                                 attribute:NSLayoutAttributeLeft
                                                                multiplier:1.0
                                                                  constant:0];
    [_scrollView.documentView addConstraint:motionLeft];
    
    NSLayoutConstraint *motionRight = [NSLayoutConstraint constraintWithItem:emitterCellMotionViewController.view
                                                                  attribute:NSLayoutAttributeRight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:_scrollView.documentView
                                                                  attribute:NSLayoutAttributeRight
                                                                 multiplier:1.0
                                                                   constant:0];
    [_scrollView.documentView addConstraint:motionRight];
    
    NSLayoutConstraint *contentViewHeight = [NSLayoutConstraint constraintWithItem:_scrollView.documentView
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1.0
                                                                          constant:180+341+366];
    [_scrollView.documentView addConstraint:contentViewHeight];
    
    NSLayoutConstraint *documentTop = [NSLayoutConstraint constraintWithItem:_scrollView.documentView
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:_scrollView.contentView
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:0];
    [_scrollView.contentView addConstraint:documentTop];
    
    NSLayoutConstraint *documentLeft = [NSLayoutConstraint constraintWithItem:_scrollView.documentView
                                                                  attribute:NSLayoutAttributeLeft
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:_scrollView.contentView
                                                                  attribute:NSLayoutAttributeLeft
                                                                 multiplier:1.0
                                                                   constant:0];
    [_scrollView.contentView addConstraint:documentLeft];
    
    NSLayoutConstraint *documentRight = [NSLayoutConstraint constraintWithItem:_scrollView.documentView
                                                                   attribute:NSLayoutAttributeRight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:_scrollView.contentView
                                                                   attribute:NSLayoutAttributeRight
                                                                  multiplier:1.0
                                                                    constant:0];
    [_scrollView.contentView addConstraint:documentRight];
    
//    containerView.scrollViewDocumentHeight = contentViewHeight;
    
}

- (void)viewDidLayout {
    [super viewDidLayout];
    
    NSLog(@"After Main Cell container view size: %@", NSStringFromSize(((NSViewController*)self.childViewControllers[0]).view.frame.size));
}

@end
