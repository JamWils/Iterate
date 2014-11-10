//
//  IterateData.m
//  IterateOSX
//
//  Created by James Wilson on 11/8/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "IterateData.h"
#import "IterateDocument.h"

@implementation IterateData

static IterateDocument *iterateDocument;

+(IterateDocument*)getIterateDocument {
    IterateDocument *document = [[IterateDocument alloc] initWithFileURL:[self localDocumentsDirectoryURL]];
    [document openWithCompletionHandler:^(BOOL success) {
        if (!success) {
            [document saveToURL:[self iterateURL] forSaveOperation:UIDocumentSaveForCreating completionHandler:nil];
        }
    }];
    
    return document;
}

+(void)didReceiveCloudData:(NSDictionary*)dictionary {
    
}

+ (NSURL *)iterateURL {
    NSURL *url = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:@"com.noesisingenuity.iterateDoc"];
    return [url URLByAppendingPathComponent:@"Iterate"];
}

+(NSURL*)localDocumentsDirectoryURL {
    static NSURL *localDocumentsDirectoryURL = nil;
    if (localDocumentsDirectoryURL == nil) {
        NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory,
                                                                                NSUserDomainMask, YES ) objectAtIndex:0];
        localDocumentsDirectoryURL = [NSURL fileURLWithPath:documentsDirectoryPath];
    }
    return localDocumentsDirectoryURL;
}

@end
