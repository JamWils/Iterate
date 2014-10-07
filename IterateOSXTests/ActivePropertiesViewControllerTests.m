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
    
    [[_viewController.scrollView.documentView constraints] enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
            NSLayoutAttribute attribute = [constraint firstAttribute];
            if (attribute == NSLayoutAttributeRight) {
                rightConstraintCount++;
            }
    }];
    
    XCTAssertTrue(_viewController.childViewControllers.count == rightConstraintCount, @"The right constraint count %lu should equal the view controller child view controller count %lu.", rightConstraintCount, _viewController.childViewControllers.count);
}

- (void)testEachChildViewContainersViewHasALeftAttributeConstraint {
    __block NSUInteger leftConstraintCount = 0;
    [_viewController addChildViewControllers:_categoryItems];
    
    [[_viewController.scrollView.documentView constraints] enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        NSLayoutAttribute attribute = [constraint firstAttribute];
        if (attribute == NSLayoutAttributeLeft) {
            leftConstraintCount++;
        }
    }];
    
    XCTAssertTrue(_viewController.childViewControllers.count == leftConstraintCount, @"The left constraint count %lu should equal the view controller child view controller count %lu.", leftConstraintCount, _viewController.childViewControllers.count);
}

@end
