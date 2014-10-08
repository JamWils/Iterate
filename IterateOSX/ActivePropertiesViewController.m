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
//    if ([containerView respondsToSelector:@selector(setContainerHeight:)]) {
//        containerView.containerHeight = mainHeight;
//    }
//
//    NSArray *categoryItems = @[
//                               [[CategoryInformation alloc] initWithStoryboardIdentifier:@"EmitterCellMainViewController" height:190],
//                               [[CategoryInformation alloc] initWithStoryboardIdentifier:@"EmitterCellColorViewController" height:366],
//                               [[CategoryInformation alloc] initWithStoryboardIdentifier:@"EmitterCellVisualViewController" height:340],
//                               [[CategoryInformation alloc] initWithStoryboardIdentifier:@"EmitterCellMotionViewController" height:341],
//                               [[CategoryInformation alloc] initWithStoryboardIdentifier:@"EmitterCellTemporalViewController" height:510]
//                               ];
//    [self addChildViewControllers:categoryItems];
    
    NSLayoutConstraint *contentViewHeight = [NSLayoutConstraint constraintWithItem:_scrollView.documentView
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1.0
                                                                          constant:3000];
    [_scrollView.documentView addConstraint:contentViewHeight];
    
//    containerView.scrollViewDocumentHeight = contentViewHeight;
    
    [self addConstraintWithView:_scrollView.documentView toView:_scrollView.contentView withAttributes:@[@(NSLayoutAttributeRight)] withConstant:0];
    [self addConstraintWithView:_scrollView.documentView toView:_scrollView.contentView withAttributes:@[@(NSLayoutAttributeLeft)] withConstant:0];
    
    //If there is an issue with the layout this line could be the problem.
    [self addConstraintWithView:_scrollView.documentView toView:_scrollView.contentView withAttributes:@[@(NSLayoutAttributeTop), @(NSLayoutAttributeBottom)] withConstant:0];
    
    
    
}

- (void)viewDidLayout {
    [super viewDidLayout];
    
    NSLog(@"After Main Cell container view size: %@", NSStringFromSize(self.scrollView.contentView.frame.size));
}

- (void)addChildViewControllers:(NSArray*)categoryItems {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    __block id previousView = _scrollView.documentView;
    
    for (CategoryInformation *categoryItem in categoryItems) {
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
    }
//    [categoryItems enumerateObjectsUsingBlock:^(CategoryInformation *categoryItem, NSUInteger idx, BOOL *stop) {
//       
//    }];
    
//    [self.view updateLayer];
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
