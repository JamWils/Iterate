//
//  EmitterConstantControlBehaviorTests.m
//  IterateOSX
//
//  Created by James Wilson on 9/29/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
@import QuartzCore;

#import "EmitterConstantControlBehavior.h"

@interface EmitterConstantControlBehaviorTests : XCTestCase

@property (strong) EmitterConstantControlBehavior *emitterBehavior;
@property (strong) CAEmitterLayer *emitterLayer;
@property (strong) id popUpButton;
@property (strong) id label;
@property (strong) NSArray *menuItems;

@end

@implementation EmitterConstantControlBehaviorTests

- (void)setUp {
    [super setUp];
    _emitterBehavior = [[EmitterConstantControlBehavior alloc] init];
    _popUpButton = [OCMockObject mockForClass:[NSPopUpButton class]];
    _label = [OCMockObject mockForClass:[NSTextField class]];
    
    [_emitterBehavior setValue:_popUpButton forKey:@"popUpButton"];
    [_emitterBehavior setValue:_label forKey:@"label"];
//    _emitterLayer. = kCAEmitterBe
    NSMenuItem *menuItemOne = [[NSMenuItem alloc] initWithTitle:@"Cuboid" action:nil keyEquivalent:@""];
    NSMenuItem *menuItemTwo = [[NSMenuItem alloc] initWithTitle:@"Oldest First" action:nil keyEquivalent:@""];
    _menuItems = @[menuItemOne, menuItemTwo];
    
    _emitterLayer = [[CAEmitterLayer alloc] init];
}

- (void)tearDown {
    _emitterLayer = nil;
    _popUpButton = nil;
    _emitterBehavior = nil;
    [super tearDown];
}

- (void)testPopUpButtonIsNotNil {
    XCTAssertNotNil(_emitterBehavior.popUpButton, @"Pop up button should not be nil.");
}

- (void)testLabelIsNotNil {
    XCTAssertNotNil(_emitterBehavior.label, @"Label should not be nil.");
}

- (void)testSelectedTitleIsFormattedAsCamelCase {
    [[[_popUpButton stub] andReturn:@"My Test"] titleOfSelectedItem];
    
    id partialEmitterBehavior = [OCMockObject partialMockForObject:_emitterBehavior];
    [[partialEmitterBehavior expect] updateValues:[OCMArg checkWithBlock:^BOOL(NSString *result) {
        XCTAssertTrue([result isEqualToString:@"myTest"], @"The result from My Test in update values should be myTest");
        return YES;
    }]];
    
    [_emitterBehavior updateSelected:_popUpButton];
    [partialEmitterBehavior verify];
    partialEmitterBehavior = nil;
}

- (void)testSelectedTitleWithNoSpacesIsAllLowercase {
    [[[_popUpButton stub] andReturn:@"TEsT"] titleOfSelectedItem];
    
    id partialEmitterBehavior = [OCMockObject partialMockForObject:_emitterBehavior];
    [[partialEmitterBehavior expect] updateValues:[OCMArg checkWithBlock:^BOOL(NSString *result) {
        XCTAssertTrue([result isEqualToString:@"test"], @"The result from TEsT in update values should be test");
        return YES;
    }]];
    
    [_emitterBehavior updateSelected:_popUpButton];
    [partialEmitterBehavior verify];
    partialEmitterBehavior = nil;
}

//- (void)testUpdateControlsUpdatesSelectedTitleForPopUpButton {
//    [[[_popUpButton stub] andReturn:_menuItems] itemArray];
//    [[_popUpButton expect] selectItem:[OCMArg any]];
//    
//    [_emitterBehavior updateControls:[OCMArg any]];
//    
//    [_popUpButton verify];
//}

- (void)testUpdateControlSelectsFirstMenuItem {
    _emitterBehavior.emitterProperty = @"renderMode";
    _emitterLayer.renderMode = kCAEmitterLayerCuboid;
    
    [[[_popUpButton stub] andReturn:_menuItems] itemArray];
    [[_popUpButton expect] selectItem:[OCMArg checkWithBlock:^BOOL(id obj) {
        XCTAssertEqualObjects(obj, _menuItems[0], @"The selected item equals the first menu item in the array");
        return YES;
    }]];
    
    [_emitterBehavior updateControls:_emitterLayer];
    
    [_popUpButton verify];
}

- (void)testUpdateControlSelectsSecondMenuItem {
    _emitterBehavior.emitterProperty = @"renderMode";
    _emitterLayer.renderMode = kCAEmitterLayerOldestFirst;
    
    [[[_popUpButton stub] andReturn:_menuItems] itemArray];
    [[_popUpButton expect] selectItem:[OCMArg checkWithBlock:^BOOL(id obj) {
        XCTAssertEqualObjects(obj, _menuItems[1], @"The selected item equals the first menu item in the array");
        return YES;
    }]];
    
    [_emitterBehavior updateControls:_emitterLayer];
    
    [_popUpButton verify];
}

@end
