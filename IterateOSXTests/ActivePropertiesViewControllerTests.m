//
//  ActivePropertiesViewControllerTests.m
//  IterateOSX
//
//  Created by James Wilson on 10/6/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "ActivePropertiesViewController.h"
#import "CategoryInformation.h"
#import "ContainerLayoutView.h"

@interface ActivePropertiesViewControllerTests : XCTestCase

@property (strong) NSStoryboard *mainStoryboard;
@property (strong) ActivePropertiesViewController *viewController;
@property (strong) NSArray *categoryItems;

@end

@implementation ActivePropertiesViewControllerTests

- (void)setUp {
    [super setUp];
    _mainStoryboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    _viewController = (ActivePropertiesViewController*)[_mainStoryboard instantiateControllerWithIdentifier:@"ActivePropertiesViewController"];\
    [_viewController view];
    
    _categoryItems = @[
        [[CategoryInformation alloc] initWithStoryboardIdentifier:@"EmitterCellMainViewController" height:180],
        [[CategoryInformation alloc] initWithStoryboardIdentifier:@"EmitterCellColorViewController" height:200],
        [[CategoryInformation alloc] initWithStoryboardIdentifier:@"EmitterCellMotionViewController" height:300]
    ];
    
}

- (void)tearDown {
    _categoryItems = nil;
    _viewController = nil;
    _mainStoryboard = nil;
    [super tearDown];
}

- (void)testActivePropertiesViewControllerIsNotNil {
    XCTAssertNotNil(_viewController, @"Active Properties View Controller is not nil.");
}

- (void)testScrollViewOutletIsNotNil {
    XCTAssertNotNil(_viewController.scrollView, @"The scroll view is not connected properly in Interface Builder.");
}

- (void)testScrollViewTranslatesAutoresizingMaskIntoConstraintsIsFalse {
    XCTAssertFalse(_viewController.scrollView.translatesAutoresizingMaskIntoConstraints, @"This should be set to false.");
}

- (void)testScrollViewDocumentViewTranslatesAutoresizingMaskIntoConstraintsIsFalse {
    XCTAssertFalse([_viewController.scrollView.documentView translatesAutoresizingMaskIntoConstraints], @"This should be set to false.");
}

- (void)testTestViewControllersDoNotReturnNil {
    XCTAssertNotNil([_mainStoryboard instantiateControllerWithIdentifier:[_categoryItems[0] storyboardIdentifier]], @"This should not return nil.");
    XCTAssertNotNil([_mainStoryboard instantiateControllerWithIdentifier:[_categoryItems[1] storyboardIdentifier]], @"This should not return nil.");
    XCTAssertNotNil([_mainStoryboard instantiateControllerWithIdentifier:[_categoryItems[2] storyboardIdentifier]], @"This should not return nil.");
}

- (void)testChildViewControllersEqualsCategoryInformationCountWhenAddChildViewControllersIsCalled{
    [_viewController addChildViewControllers:_categoryItems];
    
    XCTAssertTrue(_viewController.childViewControllers.count == _categoryItems.count, @"There should be the same number of view controllers as there are category items");
}

- (void)testDocumentViewCountContainsChildViewControllersViewsAfterAddChildViewControllerIsCalled {
    [_viewController addChildViewControllers:_categoryItems];
    
    XCTAssertTrue([_viewController.scrollView.documentView subviews].count == _categoryItems.count, @"The counts should be equal after removing existing subviews.");
}

- (void)testEachChildViewContainersViewTranslatesAutoresizingIsFalse {
    __block NSUInteger translatestAutoresizingCount = 0;
    [_viewController addChildViewControllers:_categoryItems];
    
    NSArray *viewControllers = _viewController.childViewControllers;
    [viewControllers enumerateObjectsUsingBlock:^(NSViewController *childViewController, NSUInteger idx, BOOL *stop) {
        if (!childViewController.view.translatesAutoresizingMaskIntoConstraints) {
            translatestAutoresizingCount++;
        }
    }];
    
    XCTAssertTrue(_viewController.childViewControllers.count == translatestAutoresizingCount, @"The translates auto resizing count %lu should equal to the view controller child view controller count %lu.", translatestAutoresizingCount, _viewController.childViewControllers.count);
}

- (void)testEachChildViewContainersViewHasAHeightConstraint {
    __block NSUInteger heightConstraintCount = 0;
    [_viewController addChildViewControllers:_categoryItems];
    
    NSArray *viewControllers = _viewController.childViewControllers;
    [viewControllers enumerateObjectsUsingBlock:^(NSViewController *childViewController, NSUInteger idx, BOOL *stop) {
        [childViewController.view.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
            NSLayoutAttribute attribute = [constraint firstAttribute];
            if (attribute == NSLayoutAttributeHeight) {
                heightConstraintCount++;
            }
        }];
    }];
    
    XCTAssertTrue(_viewController.childViewControllers.count == heightConstraintCount, @"The height constraint count %lu should equal the view controller child view controller count %lu.", heightConstraintCount, _viewController.childViewControllers.count);
}

- (void)testEachChildViewContainersHeightConstraintConstantEqualsCategoryItemHeight {
    __block NSMutableArray *heightArray = [[NSMutableArray alloc] init];
    [_viewController addChildViewControllers:_categoryItems];
    
    NSArray *viewControllers = _viewController.childViewControllers;
    [viewControllers enumerateObjectsUsingBlock:^(NSViewController *childViewController, NSUInteger idx, BOOL *stop) {
        [childViewController.view.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
            NSLayoutAttribute attribute = [constraint firstAttribute];
            if (attribute == NSLayoutAttributeHeight) {
                [heightArray addObject:@(constraint.constant)];
            }
            
        }];
    }];
    
    [heightArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat height = [obj floatValue];
        CategoryInformation *categoryInfo = _categoryItems[idx];
        XCTAssertTrue(height == categoryInfo.height, @"The heights do not match");
    }];
    XCTAssertTrue(heightArray.count > 0, @"The height array needs to be greater than zero for a proper test.");
}

- (void)testEachChildViewContainersViewHasARightAttributeConstraint {
    __block NSUInteger rightConstraintCount = 0;
    [_viewController addChildViewControllers:_categoryItems];
    
    [self enumerateConstraints:[_viewController.scrollView.documentView constraints]
                  forAttribute:NSLayoutAttributeRight
               validationBlock:^(NSLayoutConstraint *constraint) {
                   rightConstraintCount++;
                   XCTAssertTrue([constraint.firstItem isKindOfClass:[NSView class]], @"The first item should be a view class.");
                   XCTAssertEqual(_viewController.scrollView.documentView, constraint.secondItem, @"The second item should be the scroll view's document view.");
               }];
    
    XCTAssertTrue(_viewController.childViewControllers.count == rightConstraintCount, @"The right constraint count %lu should equal the view controller child view controller count %lu.", rightConstraintCount, _viewController.childViewControllers.count);
}

- (void)testChildViewContainersTopAttributeConnectToEachOther {
    __block NSUInteger topConstraintCount = 0;
    [_viewController addChildViewControllers:_categoryItems];
    
    [[_viewController.scrollView.documentView constraints] enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        NSLayoutAttribute attribute = [constraint firstAttribute];
        if (attribute == NSLayoutAttributeTop) {
            
            switch (topConstraintCount) {
                case 0:
                    XCTAssertTrue(constraint.firstItem == [_viewController.childViewControllers[0] view]);
                    XCTAssertTrue(constraint.firstAttribute == NSLayoutAttributeTop);
                    XCTAssertTrue(constraint.secondItem == _viewController.scrollView.documentView);
                    XCTAssertTrue(constraint.secondAttribute == NSLayoutAttributeTop);
                    break;
                case 1:
                    XCTAssertTrue(constraint.firstItem == [_viewController.childViewControllers[1] view]);
                    XCTAssertTrue(constraint.firstAttribute == NSLayoutAttributeTop);
                    XCTAssertTrue(constraint.secondItem == [_viewController.childViewControllers[0] view]);
                    XCTAssertTrue(constraint.secondAttribute == NSLayoutAttributeBottom);
                    break;
                case 2:
                    XCTAssertTrue(constraint.firstItem == [_viewController.childViewControllers[2] view]);
                    XCTAssertTrue(constraint.firstAttribute == NSLayoutAttributeTop);
                    XCTAssertTrue(constraint.secondItem == [_viewController.childViewControllers[1] view]);
                    XCTAssertTrue(constraint.secondAttribute == NSLayoutAttributeBottom);
                    break;
                default:
                    break;
            }
            
            topConstraintCount++;
        }
    }];
    
    XCTAssertTrue(_viewController.childViewControllers.count == topConstraintCount, @"The top constraint count %lu should equal the view controller child view controller count %lu.", topConstraintCount, _viewController.childViewControllers.count);
}

- (void)testScrollViewDocumentHasALeftAttributeConstraintToContentView {
    __block NSUInteger leftConstraintCount = 0;
//    [_viewController addChildViewControllers:_categoryItems];
    
    [self enumerateConstraints:[_viewController.scrollView.contentView constraints]
                  forAttribute:NSLayoutAttributeLeft
               validationBlock:^(NSLayoutConstraint *constraint) {
                   leftConstraintCount++;
               }];
    
    XCTAssertTrue(1 == leftConstraintCount, @"The left constraint count %lu should be 1", leftConstraintCount);
}

- (void)testScrollViewDocumentHasARightAttributeConstraintToContentView {
    __block NSUInteger rightConstraintCount = 0;
//    [_viewController addChildViewControllers:_categoryItems];
    
    [self enumerateConstraints:[_viewController.scrollView.contentView constraints]
                  forAttribute:NSLayoutAttributeRight
               validationBlock:^(NSLayoutConstraint *constraint) {
                   if (_viewController.scrollView.documentView == constraint.firstItem && _viewController.scrollView.contentView == constraint.secondItem) {
                       rightConstraintCount++;
                   }
               }];
    
    XCTAssertTrue(1 == rightConstraintCount, @"The right constraint count %lu should be 1", rightConstraintCount);
}

- (void)testScrollViewDocumentHasATopAttributeConstraintToContentView {
    __block NSUInteger topConstraintCount = 0;
    //    [_viewController addChildViewControllers:_categoryItems];
    
    [self enumerateConstraints:[_viewController.scrollView.contentView constraints]
                  forAttribute:NSLayoutAttributeTop
               validationBlock:^(NSLayoutConstraint *constraint) {
                   if (_viewController.scrollView.documentView == constraint.firstItem && _viewController.scrollView.contentView == constraint.secondItem) {
                       topConstraintCount++;
                   }
               }];
    
    XCTAssertTrue(1 == topConstraintCount, @"The top constraint count %lu should be 1", topConstraintCount);
}

- (void)testChildViewControllersViewsContainerHeightConstraintIsNotNil {
    [_viewController addChildViewControllers:_categoryItems];
    
    [_viewController.childViewControllers enumerateObjectsUsingBlock:^(NSViewController *viewController, NSUInteger idx, BOOL *stop) {
        ContainerLayoutView *containerView = (ContainerLayoutView*)viewController.view;
        XCTAssertNotNil(containerView.containerHeightConstraint, @"The container height constraint should not be nil");
        XCTAssertTrue(containerView.containerHeightConstraint.firstAttribute == NSLayoutAttributeHeight, @"This should be a height attribute.");
        XCTAssertTrue([_categoryItems[idx] height] == containerView.containerHeightConstraint.constant, @"The category height and constraint height should match.");
    }];
    
    XCTAssertTrue(_viewController.childViewControllers.count > 0, @"Child View Controller count should be greater than zero.");
}

- (void)testScrollViewDocumentHasHeightAttributeConstraintToSelf {
    __block NSUInteger heightConstraintCount = 0;
    
    [self enumerateConstraints:[_viewController.scrollView.documentView constraints]
                  forAttribute:NSLayoutAttributeHeight
               validationBlock:^(NSLayoutConstraint *constraint) {
                   if (_viewController.scrollView.documentView == constraint.firstItem && constraint.firstAttribute == NSLayoutAttributeHeight) {
                       heightConstraintCount++;
                       XCTAssertTrue(constraint.constant == 0, @"The default height for this constraint should be zero.");
                   }
               }];
    
    XCTAssertTrue(1 == heightConstraintCount, @"The height constraint count %lu should be 1", heightConstraintCount);
}

- (void)testChildViewControllersViewsScrollViewDocumentHeightConstraintIsNotNil {
    [_viewController addChildViewControllers:_categoryItems];
    
    [_viewController.childViewControllers enumerateObjectsUsingBlock:^(NSViewController *viewController, NSUInteger idx, BOOL *stop) {
        ContainerLayoutView *containerView = (ContainerLayoutView*)viewController.view;
        XCTAssertNotNil(containerView.scrollViewDocumentHeightConstraint, @"The scroll view document height constraint should not be nil");
        XCTAssertTrue(containerView.containerHeightConstraint.firstAttribute == NSLayoutAttributeHeight, @"This should be a height attribute.");
    }];
    
    XCTAssertTrue(_viewController.childViewControllers.count > 0, @"Child View Controller count should be greater than zero.");
}

- (void)testScrollViewDocumentHeightConstraintIsTheSumOfAllHeightsInCategoryItemArray {
    [_viewController addChildViewControllers:_categoryItems];
    
    __block float heights = 0;
    [_categoryItems enumerateObjectsUsingBlock:^(CategoryInformation *info, NSUInteger idx, BOOL *stop) {
        heights += info.height;
    }];
    
    [_viewController.childViewControllers enumerateObjectsUsingBlock:^(NSViewController *viewController, NSUInteger idx, BOOL *stop) {
        ContainerLayoutView *containerView = (ContainerLayoutView*)viewController.view;
        XCTAssertTrue(containerView.scrollViewDocumentHeightConstraint.constant == heights, @"The scroll view document height constraint constant should equal the sum of all heights (%f) in the category information array.", heights);
    }];
    
    XCTAssertTrue(_viewController.childViewControllers.count > 0, @"Child View Controller count should be greater than zero.");
}

#pragma mark Helper Methods

- (void)enumerateConstraints:(NSArray*)constraints forAttribute:(NSLayoutAttribute)attribute validationBlock:(void (^) (NSLayoutConstraint *constraint))validationBlock {
    [constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        NSLayoutAttribute attributeConstraint = [constraint firstAttribute];
        if (attribute == attributeConstraint) {
            validationBlock(constraint);
        }
    }];
}

@end
