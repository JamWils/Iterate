//
//  IterateWindowClassTests.m
//  IterateOSX
//
//  Created by James Wilson on 10/1/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "IterateWindowController.h"
#import "IterateCanvasViewControllerOSX.h"
#import "ActiveNavigationBarViewController.h"
#import "LayerOutlineViewController.h"
#import "IterateMacDocument.h"
#import "IterateInsertViewControllerOSX.h"

@interface IterateWindowControllerTests : XCTestCase

@property (strong) IterateWindowController *windowController;
@property (strong) id mockContentViewController;
@property (strong) id mockOutlineViewController;
@property (strong) id mockCanvasColorWell;
@property (strong) id mockDocument;

@end

@implementation IterateWindowControllerTests

- (void)setUp {
    [super setUp];
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    _windowController = [storyboard instantiateControllerWithIdentifier:@"IterateWindowController"];
    [_windowController window];
}

- (void)tearDown {
    _mockDocument = nil;
    _mockCanvasColorWell = nil;
    _mockContentViewController = nil;
    _windowController = nil;
    [super tearDown];
}

- (void)testWindowControllerIsNotNil {
    XCTAssertNotNil(_windowController, @"Window controller should not be nil.");
}

- (void)testCanvasColorWellIsNotNil {
    XCTAssertNotNil(_windowController.canvasColorWell, @"NSColorWell should not be nil.");
}

- (void)testCanvasControllerIsNotNil {
    XCTAssertNotNil(_windowController.canvasViewController, @"Canvas view controller should not be nil.");
    XCTAssertTrue([_windowController.canvasViewController isKindOfClass:[IterateCanvasViewControllerOSX class]], @"The canvas view controller should be of class type Content View Controller");
}

- (void)testActiveMenuBarControllerIsNotNil {
    XCTAssertNotNil(_windowController.activeMenuBarController, @"Active Menu Bar Controller property should not be nil");
    XCTAssertTrue([_windowController.activeMenuBarController isKindOfClass:[ActiveNavigationBarViewController class]], @"The active meny bar controller property is of class type Active Navigation Bar View Controller");
}

- (void)testOutlineViewControllerIsNotNil {
    XCTAssertNotNil(_windowController.outlineViewController, @"Outline View Controller property is not nil");
    XCTAssertTrue([_windowController.outlineViewController isKindOfClass:[LayerOutlineViewController class]], @"The outline view controller property is kind of class Layer Outline View Controller.");
}

#pragma mark SelectedItem Property Unit Tests

#pragma mark ColorWell Unit Tests

- (void)testCanvasBackgroundColorIsSetToWhiteWhenUpdateCanvasColorSenderIsNil {
    [[_mockContentViewController expect] setCanvasBackgroundColor:[NSColor blackColor]];
    
    [_windowController updateCanvasColor:nil];
    [_mockContentViewController verify];
}

- (void)testCanvasBackgroundColorIsSetToRedWhenUpdateCanvasColorSenderIsAnNSColorWell {
    id mockColorWell = [OCMockObject mockForClass:[NSColorWell class]];
    [[[mockColorWell stub] andReturn:[NSColor redColor]] color];
    
    [[_mockContentViewController expect] setCanvasBackgroundColor:[NSColor redColor]];
    [_windowController updateCanvasColor:mockColorWell];
    [_mockContentViewController verify];
    
    mockColorWell = nil;
}

- (void)testColorWellIsUpdatedWhenUpdateCanvasColorSenderIsNil {
    [[_mockContentViewController stub] setCanvasBackgroundColor:[NSColor blackColor]];
    
    [_windowController updateCanvasColor:nil];
    
    XCTAssertEqualObjects([NSColor blackColor], _windowController.canvasColorWell.color);
}

#pragma mark Distribute Layers Unit Tests

- (void)testDistributeLayersCallsSetLayersOnContentViewController {
    _mockContentViewController = [OCMockObject mockForClass:[IterateCanvasViewControllerOSX class]];
    _windowController.canvasViewController = _mockContentViewController;

    NSMutableArray *layers = [self layersForTesting];
    
    [[_mockContentViewController expect] setLayers:layers];
    [_windowController distributeLayers:layers fromViewController:nil];
    
    [_mockContentViewController verify];
}

- (void)testDistributeLayersCallsSetLayersOnOutlineViewController {
    _mockOutlineViewController = [OCMockObject mockForClass:[LayerOutlineViewController class]];
    _windowController.outlineViewController = _mockOutlineViewController;
    
    NSMutableArray *layers = [self layersForTesting];
    
    [[_mockOutlineViewController expect] setLayers:layers];
    [_windowController distributeLayers:layers fromViewController:nil];
    
    [_mockOutlineViewController verify];
}

- (void)testDistributeLayersCallsSetLayersOnDocument {
    _mockDocument = [OCMockObject niceMockForClass:[IterateMacDocument class]];
    _windowController.document = _mockDocument;
    
    NSMutableArray *layers = [self layersForTesting];
    
    [[_mockDocument expect] setLayers:layers];
    [_windowController distributeLayers:layers fromViewController:nil];
    
    [_mockDocument verify];
}

- (void)testDistributeLayersDoesNotCallSetLayersOnNSDocument {
    _mockDocument = [OCMockObject niceMockForClass:[NSDocument class]];
    _windowController.document = _mockDocument;

    NSMutableArray *layers = [self layersForTesting];
    
    [_windowController distributeLayers:layers fromViewController:nil];
}

- (void)testDismissViewControllerIsCalled {
    id partialMockWindow = [OCMockObject partialMockForObject:_windowController];
    NSViewController *viewController = [[NSViewController alloc] init];
    
    [[partialMockWindow expect] dismissController:[OCMArg checkWithBlock:^BOOL(id obj) {
        return obj == viewController;
    }]];
    
    [_windowController distributeLayers:nil fromViewController:viewController];
    [partialMockWindow verify];
}

#pragma mark Prepare for Segue Unit Tests

- (void)testPropertiesForInsertViewControllerAreSet {
    IterateInsertViewControllerOSX *insertViewController = [[IterateInsertViewControllerOSX alloc] init];
    
    //The canvas bounds that will be passed in
    _windowController.canvasViewController.view.frame = CGRectMake(0, 0, 500, 500);
    
    //The layers that will be passed in
    NSMutableArray *layers = [self layersForTesting];
    _windowController.selectedItem = layers[1];
    _mockDocument = [OCMockObject niceMockForClass:[IterateMacDocument class]];
    [[[_mockDocument stub] andReturn:layers] layers];
    _windowController.document = _mockDocument;
    
    NSStoryboardSegue *storyboardSegue = [[NSStoryboardSegue alloc] initWithIdentifier:@"InsertViewControllerSegue" source:_windowController destination:insertViewController];
    [_windowController prepareForSegue:storyboardSegue sender:nil];
    
    XCTAssertEqualObjects(insertViewController.sharedViewController.layers, layers, @"The layers should be passed to insert view controller during prepare for segue");
    
    BOOL canvasBoundsResult = CGRectEqualToRect(insertViewController.sharedViewController.canvasBounds, _windowController.canvasViewController.view.bounds);
    XCTAssertTrue(canvasBoundsResult, @"The canvas bounds should equal the canvas view controller's bounds");
    XCTAssertEqualObjects(insertViewController.sharedViewController.selectedItem, layers[1], @"The selected item should be passed to insert view controller during prepare for segue");
    XCTAssertEqual(insertViewController.sharedViewController.parentWindow, _windowController, @"The parent window should equal to the window controller");
    
}

- (void)testThatLayersPropertyIsNotSetOnInsertViewControllerFromDocumentWithIncorrectSegueName {
    IterateInsertViewControllerOSX *insertViewController = [[IterateInsertViewControllerOSX alloc] init];
    NSMutableArray *layers = [self layersForTesting];
    
    _mockDocument = [OCMockObject niceMockForClass:[IterateMacDocument class]];
    [[[_mockDocument stub] andReturn:layers] layers];
    _windowController.document = _mockDocument;
    
    NSStoryboardSegue *storyboardSegue = [[NSStoryboardSegue alloc] initWithIdentifier:@"WrongSegue" source:_windowController destination:insertViewController];
    [_windowController prepareForSegue:storyboardSegue sender:nil];
    
    XCTAssertNil(insertViewController.sharedViewController.layers, @"The layers should not be passed to insert view controller during prepare for segue");
}

/*- (void)testThatCanvasBoundsPropertyIsSetOnInsertViewControllerFromCanvasViewController {
    IterateInsertViewControllerOSX *insertViewController = [[IterateInsertViewControllerOSX alloc] init];
    _windowController.canvasViewController.view.frame = CGRectMake(0, 0, 500, 500);
    
    NSStoryboardSegue *storyboardSegue = [[NSStoryboardSegue alloc] initWithIdentifier:@"InsertViewControllerSegue" source:_windowController destination:insertViewController];
    [_windowController prepareForSegue:storyboardSegue sender:nil];
    
    BOOL result = CGRectEqualToRect(insertViewController.sharedViewController.canvasBounds, _windowController.canvasViewController.view.bounds);
    XCTAssertTrue(result, @"The canvas bounds should equal the canvas view controller's bounds");
}*/

- (void)testThatCanvasPropertyIsNotSetOnInsertViewControllerFromCanvasWithIncorrectSegueName {
    IterateInsertViewControllerOSX *insertViewController = [[IterateInsertViewControllerOSX alloc] init];
    _windowController.canvasViewController.view.frame = CGRectMake(0, 0, 500, 500);
    
    NSStoryboardSegue *storyboardSegue = [[NSStoryboardSegue alloc] initWithIdentifier:@"WrongSegue" source:_windowController destination:insertViewController];
    [_windowController prepareForSegue:storyboardSegue sender:nil];
    
    BOOL result = CGRectEqualToRect(insertViewController.sharedViewController.canvasBounds, _windowController.canvasViewController.view.bounds);
    XCTAssertFalse(result, @"The canvas bounds should not equal the canvas view controller's bounds");
}

/*- (void)testThatSelectedItemPropertyIsSetOnInsertViewControllerFromDocument {
    IterateInsertViewControllerOSX *insertViewController = [[IterateInsertViewControllerOSX alloc] init];
    NSMutableArray *layers = [self layersForTesting];
    _windowController.selectedItem = layers[1];
    
    NSStoryboardSegue *storyboardSegue = [[NSStoryboardSegue alloc] initWithIdentifier:@"InsertViewControllerSegue" source:_windowController destination:insertViewController];
    [_windowController prepareForSegue:storyboardSegue sender:nil];
    
    XCTAssertEqualObjects(insertViewController.sharedViewController.selectedItem, layers[1], @"The selected item should be passed to insert view controller during prepare for segue");
}*/

- (void)testThatSelectedItemPropertyIsNotSetOnInsertViewControllerFromDocument {
    IterateInsertViewControllerOSX *insertViewController = [[IterateInsertViewControllerOSX alloc] init];
    NSMutableArray *layers = [self layersForTesting];
    _windowController.selectedItem = layers[1];
    
    NSStoryboardSegue *storyboardSegue = [[NSStoryboardSegue alloc] initWithIdentifier:@"TestSegue" source:_windowController destination:insertViewController];
    [_windowController prepareForSegue:storyboardSegue sender:nil];
    
    XCTAssertNil(insertViewController.sharedViewController.selectedItem, @"The selected item should not be passed to insert view controller during prepare for segue");
}

/*- (void)testThatParentWindowPropertyIsSetOnInsertViewController {
    IterateInsertViewControllerOSX *insertViewController = [[IterateInsertViewControllerOSX alloc] init];
    
    NSStoryboardSegue *storyboardSegue = [[NSStoryboardSegue alloc] initWithIdentifier:@"InsertViewControllerSegue" source:_windowController destination:insertViewController];
    [_windowController prepareForSegue:storyboardSegue sender:nil];
    
    XCTAssertEqual(insertViewController.sharedViewController.parentWindow, _windowController, @"The parent window should equal to the window controller");
}*/

- (void)testThatParentWindowPropertyIsNotSetOnInsertViewController {
    IterateInsertViewControllerOSX *insertViewController = [[IterateInsertViewControllerOSX alloc] init];
    
    NSStoryboardSegue *storyboardSegue = [[NSStoryboardSegue alloc] initWithIdentifier:@"TestSegue" source:_windowController destination:insertViewController];
    [_windowController prepareForSegue:storyboardSegue sender:nil];
    
    XCTAssertNil(insertViewController.sharedViewController.parentWindow, @"The parent window should not equal to the window controller");
}

#pragma mark -
#pragma mark Helper Methods
- (NSMutableArray*)layersForTesting {
    CALayer *layerA = [[CALayer alloc] init];
    CALayer *layerB = [[CALayer alloc] init];
    return [@[layerA, layerB] mutableCopy];
}

@end
