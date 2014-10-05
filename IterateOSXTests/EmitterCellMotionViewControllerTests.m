//
//  EmitterCellMotionViewControllerTests.m
//  IterateOSX
//
//  Created by James Wilson on 9/30/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

@import IterateOSXFramework;

@interface EmitterCellMotionViewControllerTests : XCTestCase

@property (strong, nonatomic) NSViewController *viewController;
@property (strong, nonatomic) NSStoryboard *storyboard;

@end

@implementation EmitterCellMotionViewControllerTests

- (void)setUp {
    [super setUp];
    _storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    _viewController = [_storyboard instantiateControllerWithIdentifier:@"EmitterCellMotionViewController"];
    [_viewController view];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//- (void)testExample {
//    id behavior = [self controlWithPropertyName:@"spin"];
//    XCTAssertNotNil(behavior, @"Spin behavior should not be nil");
//}

- (EmitterControlBehavior*)controlWithPropertyName:(NSString*)propertyName {
    __block EmitterControlBehavior *returnBehavior;
    
    [[_viewController.view subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[EmitterControlBehavior class]]) {
            EmitterControlBehavior *controlBehavior = (EmitterControlBehavior*)obj;
            if ([controlBehavior.emitterProperty isEqualToString:propertyName]) {
                returnBehavior = controlBehavior;
            }
        }
    }];
    
    return returnBehavior;
}

@end
