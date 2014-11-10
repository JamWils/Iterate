//
//  IterateDocumentTests.m
//  IterateOSX
//
//  Created by James Wilson on 11/4/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "IterateDocument.h"

@import IterateiOSFramework;

#define kUnitTestFileName   @"IterateTestDocument.iterate"

@interface IterateDocumentTests : XCTestCase

@property (nonatomic, strong) IterateDocument *document;

@end

@implementation IterateDocumentTests {
    NSFileManager* _fileManager;
    NSString* _unitTestFilePath;
    NSURL* _unitTestFileUrl;
}

- (void)setUp {
    [super setUp];
    
    NSArray *dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirs objectAtIndex:0];
    
    _unitTestFilePath = [docsDir stringByAppendingPathComponent:kUnitTestFileName];
    _unitTestFileUrl = [NSURL fileURLWithPath:_unitTestFilePath];
    
    _fileManager = [NSFileManager defaultManager];
    [_fileManager removeItemAtURL:_unitTestFileUrl error:NULL];
    
    _document = [[IterateDocument alloc] initWithFileURL:_unitTestFileUrl];
}

- (void)tearDown {
    _document = nil;
    _fileManager = nil;
    _unitTestFileUrl = nil;
    _unitTestFilePath = nil;
    [super tearDown];
}

- (void)testDocumentIsNotNil {
    
    XCTAssertNotNil(_document);
}

- (void)testDocumentConformsToIterateDocumentProtocol {
    
    XCTAssert([_document conformsToProtocol:(@protocol(IterateDocumentProtocol))], @"The document should conform to iterate document protocol");
}

- (void)testLayerIsNotNilWhenIterateDocumentIsInitialized {
    XCTAssertNotNil(_document.layers, @"The layers should not be nil");
}

//- (void)testSavingCreatesFile {
//    __block BOOL blockSuccess = NO;
//    
//    [_document saveToURL:_unitTestFileUrl forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
//         blockSuccess = success;
//     }];
//    
//    XCTAssertTrue(blockSuccess);
//    XCTAssertTrue([_fileManager fileExistsAtPath:_unitTestFilePath]);
//}

@end
