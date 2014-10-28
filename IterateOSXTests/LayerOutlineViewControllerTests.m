//
//  LayerOutlineViewControllerTests.m
//  IterateOSX
//
//  Created by James Wilson on 9/26/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "LayerOutlineViewController.h"
#import "OutlineViewDataSourceManager.h"
#import "IterateWindowController.h"


@interface LayerOutlineViewControllerTests : XCTestCase

@property (strong, nonatomic) LayerOutlineViewController *viewController;
@property (strong, nonatomic) NSStoryboard *storyboard;
@property (strong, nonatomic) NSString *selectedRowKey;
@property (strong, nonatomic) id partialMockOutlineView;
@property (strong, nonatomic) id mockWindowController;
//@property (strong, nonatomic) id mockDataSource;

@end

@implementation LayerOutlineViewControllerTests

- (void)setUp {
    [super setUp];
    _storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    _viewController = [_storyboard instantiateControllerWithIdentifier:@"LayerOutlineViewController"];
    _selectedRowKey = @"selectedOutlineViewRow";
    [_viewController view];
    
    _mockWindowController = [OCMockObject mockForClass:[IterateWindowController class]];
}

- (void)tearDown {
    _mockWindowController = nil;
    _partialMockOutlineView = nil;
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
    
    int result = [[[NSUserDefaults standardUserDefaults] objectForKey:_selectedRowKey] intValue];
    XCTAssertEqual(restorationValue, result, @"The user default value should equal zero when ViewDidLoad is called.");
}

- (void)testSelectedRowKeyIsNilWhenLayerCountIsZero {
    NSUInteger initialValue = 5;
    _viewController.layers = [[NSMutableArray alloc] init];
    [[NSUserDefaults standardUserDefaults] setObject:@(initialValue) forKey:_selectedRowKey];
    
    [_viewController viewDidLoad];
    id result = [[NSUserDefaults standardUserDefaults] objectForKey:_selectedRowKey];
    XCTAssertNil(result, @"Result should be nil when Layers count is zero.");
}

- (void)testViewWillAppearDoesNotThrowErrorWhenSelectedRowKeyIsNull {
    _viewController.layers = [[NSMutableArray alloc] init];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:_selectedRowKey];
    
    [_viewController viewWillAppear];
}

- (void)testViewWillAppearSetsTheOutlineViewsRowToTheUserDefaultsValue {
    NSUInteger initialValue = 5;
    _viewController.layers = [[NSMutableArray alloc] init];
    [_viewController viewDidLoad];
    [[NSUserDefaults standardUserDefaults] setObject:@(initialValue) forKey:@"selectedOutlineViewRow"];
    
    _partialMockOutlineView = [OCMockObject partialMockForObject:_viewController.layerOutlineView];
    _viewController.layerOutlineView = _partialMockOutlineView;
    [[_partialMockOutlineView expect] selectRowIndexes:[NSIndexSet indexSetWithIndex:initialValue] byExtendingSelection:YES];
    
    [_viewController viewWillAppear];
    [_partialMockOutlineView verify];
}

- (void)testSelectedRowKeyIsSetToOutlineViewsSelectedRowInViewWillDisappear {
    NSUInteger initialValue = 0;
    NSUInteger setValue = 5;
    [[NSUserDefaults standardUserDefaults] setObject:@(initialValue) forKey:@"selectedOutlineViewRow"];
    
    _partialMockOutlineView = [OCMockObject partialMockForObject:_viewController.layerOutlineView];
    _viewController.layerOutlineView = _partialMockOutlineView;
    [[[_partialMockOutlineView stub] andReturnValue:OCMOCK_VALUE(setValue)] selectedRow];
    
    [_viewController viewWillDisappear];
    int result = [[[NSUserDefaults standardUserDefaults] objectForKey:_selectedRowKey] intValue];
    XCTAssertEqual(setValue, result, @"The uesr default value should equal the outlines view selected row when view will disappear is called.");
}

- (void)testOutlineViewsReloadDataIsCalledDuringSetLayers {
    _partialMockOutlineView = [OCMockObject partialMockForObject:_viewController.layerOutlineView];
    _viewController.layerOutlineView = _partialMockOutlineView;
    [[_partialMockOutlineView expect] reloadData];
    
    _viewController.layers = [[NSMutableArray alloc] init];
    
    [_partialMockOutlineView verify];
}

- (void)testWindowControllersPropertiesAreSetWhenDelegateSelectedRowIsUpdated {
    
}


//- (void)testOutlineViewsDataSourceLayersAreSetWhenViewControllersLayerIsSet {
//    NSMutableArray *layers = [[NSMutableArray alloc] init];
//    id mockDataSource = [OCMockObject partialMockForObject:[[OutlineViewDataSourceManager alloc] initWithLayers:[[NSMutableArray alloc] init]]];
//    _viewController.layerOutlineView.dataSource = mockDataSource;
//    [[mockDataSource expect] setValue:[OCMArg any] forKey:[OCMArg checkWithBlock:^BOOL(id obj) {
//        return YES;
//    }]];
//    
//    _viewController.layers = layers;
//    
////    XCTAssertEqual(layers, [mockDataSource valueForKey:@"layers"], @"Array objects should be equal after setting layers on view controller.");
//    [mockDataSource verify];
//    
//}

@end
