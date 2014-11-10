//
//  IterateMetadata.h
//  IterateOSX
//
//  Created by James Wilson on 11/7/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface IterateMetadata : NSObject

@property (strong) NSURL * fileURL;
@property (strong) IterateMetadata * metadata;
@property (assign) UIDocumentState state;
@property (strong) NSFileVersion * version;

- (id)initWithFileURL:(NSURL *)fileURL metadata:(IterateMetadata *)metadata state:(UIDocumentState)state version:(NSFileVersion *)version;
- (NSString *) description;

@end
