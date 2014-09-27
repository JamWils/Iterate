//
//  EmitterControlBehaviorTests.m
//  IterateOSX
//
//  Created by James Wilson on 9/27/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import QuartzCore;
@import IterateOSXFramework;

#import "EmitterControlBehavior.h"

@interface EmitterControlBehaviorTests : XCTestCase

@property (strong, nonatomic) EmitterControlBehavior *emitterControl;

@property (strong) NSNotificationCenter *notificationCenter;
@property (strong) id observerMock;

@end

@implementation EmitterControlBehaviorTests

- (void)setUp {
    [super setUp];
    _emitterControl = [[EmitterControlBehavior alloc] init];
    
    self.notificationCenter = [[NSNotificationCenter alloc] init];
    self.observerMock = [OCMockObject observerMock];
}

- (void)tearDown {
    _emitterControl = nil;
    
    [super tearDown];
}

- (void)testEmitterControlBehaviorAddsObserverForCellEmitterNotificationWhenIsCellProperty {
    id mockEmitterControl = [OCMockObject partialMockForObject:_emitterControl];
    
    _emitterControl.isCellProperty = YES;
    [_emitterControl awakeFromNib];
    
    [[mockEmitterControl expect] updateEmitterCellControls:[OCMArg any]];
    
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    NSDictionary *userInfo = @ { @"emitterCell" : cell };
    [[NSNotificationCenter defaultCenter] postNotificationName:kDidChangeSelectedEmitterCellNotification object:[OCMArg any] userInfo:userInfo];
    XCTAssertNoThrow([mockEmitterControl verify], @"Emitter Control should respond to Selected Emitter Cell Notifications when Cell Property is YES");
}

- (void)testEmitterControlBehaviorDoesNotAddObserverForCellEmitterNotification {
    id mockEmitterControl = [OCMockObject mockForClass:[EmitterControlBehavior class]];
    
    [[[mockEmitterControl stub] andReturn:@(NO)] isCellProperty];
    [[mockEmitterControl expect] awakeFromNib];
    [mockEmitterControl awakeFromNib];
    
    [[mockEmitterControl expect] updateEmitterCellControls:[OCMArg any]];
    [[NSNotificationCenter defaultCenter] postNotificationName:kDidChangeSelectedEmitterCellNotification object:[OCMArg any] userInfo:nil];
    XCTAssertThrows([mockEmitterControl verify], @"Emitter Control should not add  Selected Emitter Cell Notifications when Cell Property is NO");
}



@end
