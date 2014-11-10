//
//  IterateDocument.h
//  IterateOSX
//
//  Created by James Wilson on 11/4/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IterateDocumentProtocol.h"
@class IterateDocument;


@protocol IteratetDocumentDelegate <NSObject>
- (void)iterateDocumentDidChangeContents:(IterateDocument *)document;
@end

@interface IterateDocument : UIDocument <IterateDocumentProtocol>

@end
