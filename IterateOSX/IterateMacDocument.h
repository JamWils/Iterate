//
//  Document.h
//  IterateOSX
//
//  Created by James Wilson on 9/23/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@import IterateOSXFramework;

@interface IterateMacDocument : NSDocument <IterateDocumentProtocol>


@property (copy) NSColor *canvasBackgroundColor;

@end
