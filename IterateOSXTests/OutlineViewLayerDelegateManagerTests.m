//
//  OutlineViewLayerDelegateManagerTests.m
//  IterateOSX
//
//  Created by James Wilson on 9/26/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
@import QuartzCore;
@import IterateOSXFramework;

#import "OutlineViewEmitterTestCase.h"
#import "OutlineViewLayerDelegateManager.h"
#import "OutlineViewDataSourceManager.h"

@interface OutlineViewLayerDelegateManagerTests : OutlineViewEmitterTestCase

@property (strong) id mockOutlineView;
@property (strong) OutlineViewLayerDelegateManager *delegate;
@property (strong) OutlineViewDataSourceManager *dataSource;

@property (strong) NSNotificationCenter *notificationCenter;
@property (strong) NSString *selectedViewNotification;
@property (strong) id observerMock;

@end

@implementation OutlineViewLayerDelegateManagerTests

- (void)setUp {
    [super setUp];
    _delegate = [[OutlineViewLayerDelegateManager alloc] initWithParentObjectBlock:nil];
    
    _dataSource = [[OutlineViewDataSourceManager alloc] initWithLayers:self.layers];
    _mockOutlineView = [OCMockObject partialMockForObject:[[NSOutlineView alloc] init]];
    
    [[[_mockOutlineView stub] andReturn:_dataSource] dataSource];
    [[[_mockOutlineView stub] andReturn:_delegate] delegate];
    
    self.notificationCenter = [[NSNotificationCenter alloc] init];
    self.selectedViewNotification = @"DidChangeSelectedLayerNotification";
    self.observerMock = [OCMockObject observerMock];
    
}

- (void)tearDown {
    _observerMock = nil;
    _selectedViewNotification = nil;
    _observerMock = nil;
    
    _mockOutlineView = nil;
    _dataSource = nil;
    _delegate = nil;
    [super tearDown];
}

- (void)testDelegateIsNilWhenInitIsCalled {
    OutlineViewLayerDelegateManager *delegateManager = [[OutlineViewLayerDelegateManager alloc] init];
    XCTAssertNil(delegateManager, @"Delegate manager should be nil when init is called");
}

- (void)testDelegateIsNotNilWhenInitWithParentObjectBlockIsCalled {
    // This is an example of a functional test case.
    XCTAssertNotNil(_delegate, @"Delegate should not be nil with standard init");
}


- (void)testOutlineViewSelectionDidChangeDoesNotThrowErrorWhenSelectedItemIsNil {
    _delegate.activeLayer = [[CALayer alloc] init];;
    _delegate.selectedItem = nil;
    
    XCTAssertNoThrow([_delegate outlineViewSelectionDidChange:nil], @"An unexpected exception was thrown");
}

- (void)testOutlineViewSelectionDidChangeDoesNotThrowErrorWhenActiveLayerIsNil {
    _delegate.activeLayer = nil;
    _delegate.selectedItem = [[CALayer alloc] init];
    
    XCTAssertNoThrow([_delegate outlineViewSelectionDidChange:nil], @"An unexpected exception was thrown");
}

- (void)testDidChangeSelectedLayerNotificationIsCalledWhenOutlineViewSelectionDidChangeIsCalled {
    _delegate.activeLayer = [[CALayer alloc] init];
    _delegate.selectedItem = [[CAEmitterCell alloc] init];
    [[NSNotificationCenter defaultCenter] addMockObserver:self.observerMock name:self.selectedViewNotification object:nil];
    [[self.observerMock expect] notificationWithName:self.selectedViewNotification object:[OCMArg any] userInfo:[OCMArg any]];
    
    [_delegate outlineViewSelectionDidChange:nil];
    
    XCTAssertNoThrow([self.observerMock verify], @"An unexpected exception was thrown");
    [[NSNotificationCenter defaultCenter] removeObserver:_observerMock];
}

- (void)testDidChangeSelectedEmitterCellNotificationIsCalledWhenOutlineViewSelectionDidChangeIsCalled {
    _delegate.activeLayer = [[CALayer alloc] init];
    _delegate.selectedItem = [[CAEmitterCell alloc] init];
    [[NSNotificationCenter defaultCenter] addMockObserver:self.observerMock name:kDidChangeSelectedEmitterCellNotification object:nil];
    [[self.observerMock expect] notificationWithName:kDidChangeSelectedEmitterCellNotification object:[OCMArg any] userInfo:[OCMArg any]];
    
    [_delegate outlineViewSelectionDidChange:nil];
    
    XCTAssertNoThrow([self.observerMock verify], @"An unexpected exception was thrown");
    [[NSNotificationCenter defaultCenter] removeObserver:_observerMock];
}


- (void)testActiveLayerIsNotNilWhenEmitterCellsParentIsAnEmitterCell {
    _delegate.activeLayer = nil;
    
    id cell = [[[[self.layers[0] valueForKey:@"sublayers"] objectAtIndex:0] valueForKey:@"emitterCells"] objectAtIndex:1];
    id layer = [[self.layers[0] valueForKey:@"sublayers"] objectAtIndex:0];
    [[[_mockOutlineView expect] andReturn:[[CAEmitterCell alloc] init]] parentForItem:cell];
    [[[_mockOutlineView expect] andReturn:[[CAEmitterLayer alloc] init]] parentForItem:[OCMArg any]];
    XCTAssertTrue([cell isKindOfClass:[CAEmitterCell class]]);
    
    [_delegate outlineView:_mockOutlineView shouldSelectItem:cell];
    [_mockOutlineView verify];
    XCTAssertNotNil(_delegate.activeLayer);
    XCTAssertTrue([_delegate.activeLayer isKindOfClass:[CAEmitterLayer class]], @"The active layer should be an emitter layer");
}

- (void)testKeyPathForEmitterCellWithinEmitterCell {
    __block NSString *returnedKeyPathForSelectedItem = @"";
    _delegate = [[OutlineViewLayerDelegateManager alloc] initWithParentObjectBlock:^(id parentObject, id selectedItem, NSString *keyPathForSelectedItem) {
        returnedKeyPathForSelectedItem = keyPathForSelectedItem;
    }];
    
    CAEmitterCell *theSelectedCell = [[CAEmitterCell alloc] init];
    theSelectedCell.name = @"selectedCell";
    
    CAEmitterCell *theParentCell = [[CAEmitterCell alloc] init];
    theParentCell.name = @"parentCell";
    
    NSString *expectKeyPath = [NSString stringWithFormat:@"emitterCells.parentCell.emitterCells.selectedCell."];
    
    _delegate.activeLayer = nil;
    
//    [[[_mockOutlineView expect] andReturn:theSelectedCell] parentForItem:[OCMArg any]];
    [[[_mockOutlineView expect] andReturn:theParentCell] parentForItem:[OCMArg any]];
    [[[_mockOutlineView expect] andReturn:[[CAEmitterLayer alloc] init]] parentForItem:[OCMArg any]];
    
    [_delegate outlineView:_mockOutlineView shouldSelectItem:theSelectedCell];
    [_delegate outlineViewSelectionDidChange:nil];
    [_mockOutlineView verify];

    XCTAssertTrue([returnedKeyPathForSelectedItem isEqualToString:expectKeyPath], @"The active layer should be an emitter layer");
}

- (void)testActiveLayerIsNotNilWhenEmitterCellsParentIsAnEmitterLayer {
    _delegate.activeLayer = nil;
    
    id cell = [[[[self.layers[0] valueForKey:@"sublayers"] objectAtIndex:0] valueForKey:@"emitterCells"] objectAtIndex:1];
    id returnedLayer = [[CAEmitterLayer alloc] init];
    
    [[[_mockOutlineView stub] andReturn:returnedLayer] parentForItem:cell];
    XCTAssertTrue([cell isKindOfClass:[CAEmitterCell class]]);
    
    [_delegate outlineView:_mockOutlineView shouldSelectItem:cell];
    [_mockOutlineView verify];
    XCTAssertNotNil(_delegate.activeLayer);
    XCTAssertEqualObjects(_delegate.activeLayer, returnedLayer, @"The layer returned from parentForItem should be equal to active layer.");
}

- (void)testUserInfoContainsEmitterCellAndLayerKeyWhenSelectedCellNotificationIsFired {
    _delegate.activeLayer = [[CALayer alloc] init];
    _delegate.selectedItem = [[CAEmitterCell alloc] init];
    [[NSNotificationCenter defaultCenter] addMockObserver:self.observerMock name:kDidChangeSelectedEmitterCellNotification object:nil];
    [[self.observerMock expect] notificationWithName:kDidChangeSelectedEmitterCellNotification object:[OCMArg any] userInfo:[OCMArg checkWithBlock:^BOOL(NSDictionary *userInfo) {
        
        id emitterCell = [userInfo objectForKey:@"emitterCell"];
        XCTAssertNotNil(emitterCell, @"User info should contain a key for emitter cell");
        XCTAssertEqualObjects(emitterCell, _delegate.selectedItem, @"Emitter Cell from user info should equal selected item");
        
        id layer = [userInfo objectForKey:@"layer"];
        XCTAssertNotNil(layer, @"User info should contain a key for layer");
        XCTAssertEqualObjects(layer, _delegate.activeLayer, @"Layer property should equal active layer");
        
        return YES;
    }]];
    
    [_delegate outlineViewSelectionDidChange:nil];
    
    XCTAssertNoThrow([self.observerMock verify], @"An unexpected exception was thrown");
    [[NSNotificationCenter defaultCenter] removeObserver:_observerMock];
}

- (void)testUserInfoContainsWhenSelectedViewNotificationIsFired {
    _delegate.activeLayer = [[CALayer alloc] init];
    _delegate.selectedItem = [[CALayer alloc] init];
    [[NSNotificationCenter defaultCenter] addMockObserver:self.observerMock name:self.selectedViewNotification object:nil];
    [[self.observerMock expect] notificationWithName:self.selectedViewNotification object:[OCMArg any] userInfo:[OCMArg checkWithBlock:^BOOL(NSDictionary *userInfo) {
        
        id emitterCell = [userInfo objectForKey:@"emitterCell"];
        XCTAssertNil(emitterCell, @"User info should contain a key for emitter cell");
        
        id layer = [userInfo objectForKey:@"layer"];
        XCTAssertNotNil(layer, @"Layer should not be nil in user info");
        XCTAssertEqualObjects(layer, _delegate.activeLayer, @"The user info layer should equal the delegates active layer property");
        return YES;
    }]];
    
    [_delegate outlineViewSelectionDidChange:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:_observerMock];
}

- (void)testCellSelectedNotificationIsNotPostedWhenSelectedItemIsNotAnEmitterCell {
    _delegate.activeLayer = [[CALayer alloc] init];
    _delegate.selectedItem = [[CALayer alloc] init];
    [[NSNotificationCenter defaultCenter] addMockObserver:self.observerMock name:kDidChangeSelectedEmitterCellNotification object:nil];
    [[self.observerMock expect] notificationWithName:kDidChangeSelectedEmitterCellNotification object:[OCMArg any] userInfo:[OCMArg any]];
    
    [_delegate outlineViewSelectionDidChange:nil];
    
    XCTAssertThrows([self.observerMock verify], @"An unexpected exception was thrown");
    [[NSNotificationCenter defaultCenter] removeObserver:_observerMock];
}

- (void)testParentLayerIsSentIntoBlock {
    __block CALayer *configuredLayer = nil;
    __block NSString *configuredSelectedItem = nil;
    
    CALayer *layer = [[CALayer alloc] init];
    
    _delegate = [[OutlineViewLayerDelegateManager alloc] initWithParentObjectBlock:^(id parentObject, id selectedItem, NSString *keyPathForSelectedItem) {
        configuredLayer = parentObject;
        configuredSelectedItem = selectedItem;
        keyPathForSelectedItem = @"";
    }];
    _delegate.selectedItem = @"";
    _delegate.activeLayer = layer;
    
    
    [_delegate outlineViewSelectionDidChange:nil];
    
    XCTAssertEqual(layer, configuredLayer, @"The parent object should be equal to the active layer");
    XCTAssertEqualObjects(@"", configuredSelectedItem, @"The selected item should be equal to a blank string");
}

- (void)testParentBlockCanBeNil {
    _delegate = [[OutlineViewLayerDelegateManager alloc] initWithParentObjectBlock:nil];
    
    _delegate.activeLayer = [[CALayer alloc] init];
    _delegate.selectedItem = [[CALayer alloc] init];
    [[NSNotificationCenter defaultCenter] addMockObserver:self.observerMock name:kDidChangeSelectedEmitterCellNotification object:nil];
    [[self.observerMock expect] notificationWithName:kDidChangeSelectedEmitterCellNotification object:[OCMArg any] userInfo:[OCMArg any]];
    
    [_delegate outlineViewSelectionDidChange:nil];
    
    XCTAssertThrows([self.observerMock verify], @"An unexpected exception was thrown");
    [[NSNotificationCenter defaultCenter] removeObserver:_observerMock];
}

- (void)testActiveLayerIsNotNilWhenSelectedItemIsEmitterCellWithParentAsEmitterCell {
    
}

- (void)testKeyPathForSelectedItemMatchesLayers {
    CALayer *layer = [[CALayer alloc] init];
    
    NSString *expectedKeyPath = @"layer.sublayers.";
}



//- (void)testParentLayerIsSentIntoBlockWhenSelectedItemIsNil {
//    __block CALayer *configuredLayer = nil;
//    CALayer *layer = [[CALayer alloc] init];
//    
//    _delegate = [[OutlineViewLayerDelegateManager alloc] initWithParentObjectBlock:^(id parentObject) {
//        configuredLayer = parentObject;
//    }];
//    _delegate.selectedItem = nil;
//    _delegate.activeLayer = layer;
//    
//    [_delegate outlineViewSelectionDidChange:nil];
//    
//    XCTAssertEqual(layer, configuredLayer, @"The parent object should be equal to the active layer");
//}

//- (void)testActiveLayerIsEqualToEmitterLayerWhenEmitterCellsParentIsAnEmitterLayer {
//    _delegate.activeLayer = nil;
//    
//    id cell = [[[[self.layers[0] valueForKey:@"sublayers"] objectAtIndex:0] valueForKey:@"emitterCells"] objectAtIndex:1];
//    XCTAssertTrue([cell isKindOfClass:[CAEmitterCell class]]);
//    
//    [_delegate outlineView:_mockOutlineView shouldSelectItem:cell];
//    XCTAssertNil(_delegate.activeLayer);
//}

@end
