//
//  LayerOutlineViewControllerTests.m
//  IterateOSX
//
//  Created by James Wilson on 9/26/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

#import "LayerOutlineViewController.h"

@interface LayerOutlineViewControllerTests : XCTestCase

@property (strong, nonatomic) LayerOutlineViewController *viewController;
@property (strong, nonatomic) NSStoryboard *storyboard;
@property (strong, nonatomic) NSString *selectedRowKey;
@property (strong, nonatomic) NSOutlineView *partialMockOutlineView;

@end

@implementation LayerOutlineViewControllerTests

- (void)setUp {
    [super setUp];
    _storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    _viewController = [_storyboard instantiateControllerWithIdentifier:@"LayerOutlineViewController"];
    _selectedRowKey = @"selectedOutlineViewRow";
    [_viewController view];
}

- (void)tearDown {
    _selectedRowKey = nil;
    _viewController = nil;
    _storyboard = nil;
    [super tearDown];
}

- (void)testViewControllerIsNotNil {
    XCTAssertNotNil(_viewController, @"View Controller should not be nil");
}

- (void)testLayerOutlineViewIsNotNil {
    XCTAssertNotNil(_viewController.layerOutlineView, @"Layer Outline View should not be nil");
}

- (void)testSelectedRowKeyIsSetToZeroInViewDidLoad {
    NSUInteger restorationValue = 0;
    NSUInteger initialValue = 5;
    [[NSUserDefaults standardUserDefaults] setObject:@(initialValue) forKey:_selectedRowKey];
    
    [_viewController viewDidLoad];
    
    int result = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedOutlineViewRow"] intValue];
    XCTAssertEqual(restorationValue, result, @"The uesr default value should equal zero when ViewDidLoad is called.");
}

- (void)testSelectedRowKeyIsNilWhenLayerCountIsZero {
    NSUInteger initialValue = 5;
    _viewController.layers = [[NSMutableArray alloc] init];
    [[NSUserDefaults standardUserDefaults] setObject:@(initialValue) forKey:_selectedRowKey];
    
    [_viewController viewDidLoad];
    id result = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedOutlineViewRow"];
    XCTAssertNil(result, @"Result should be nil when Layers count is zero.");
}

- (void)testViewWillAppearDoesNotThrowErrorWhenSelectedRowKeyIsNull {
    _viewController.layers = [[NSMutableArray alloc] init];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:_selectedRowKey];
    
    [_viewController viewWillAppear];
}



- (void)testViewWillAppearSetsTheOutlineViewsRowToTheUserDefaultsValue {
//    NSUInteger initialValue = 5;
//    _viewController.layers = [[NSMutableArray alloc] init];
//    [[NSUserDefaults standardUserDefaults] setObject:@(initialValue) forKey:@"selectedOutlineViewRow"];
//    
//    [_viewController viewDidLoad];
//    id result = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedOutlineViewRow"];
//    XCTAssertNil(result, @"Result should be nil when Layers count is zero.");
}

@end
