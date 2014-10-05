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
#import "ContentViewController.h"


@interface IterateWindowControllerTests : XCTestCase

@property (strong) IterateWindowController *windowController;
@property (strong) id mockContentViewController;
@property (strong) id mockCanvasColorWell;

@end

@implementation IterateWindowControllerTests

- (void)setUp {
    [super setUp];
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    _windowController = [storyboard instantiateControllerWithIdentifier:@"IterateWindowController"];
    [_windowController window];
    
    _mockContentViewController = [OCMockObject mockForClass:[ContentViewController class]];
    _windowController.canvasViewController = _mockContentViewController;
    
    
}

- (void)tearDown {
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

- (void)testUpdateCanvasColorIsConnected {
    
}

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

@end
