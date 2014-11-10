//
//  IterateMetadata.m
//  IterateOSX
//
//  Created by James Wilson on 11/7/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "IterateMetadata.h"

@implementation IterateMetadata

- (id)initWithFileURL:(NSURL *)fileURL metadata:(IterateMetadata *)metadata state:(UIDocumentState)state version:(NSFileVersion *)version {
    
    if ((self = [super init])) {
        self.fileURL = fileURL;
        self.metadata = metadata;
        self.state = state;
        self.version = version;
    }
    return self;
    
}

- (NSString *) description {
    return [[self.fileURL lastPathComponent] stringByDeletingPathExtension];
}

@end
