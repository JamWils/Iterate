//
//  IterateDocument.m
//  IterateOSX
//
//  Created by James Wilson on 11/4/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "IterateDocument.h"
#import "IterateData.h"

@implementation IterateDocument

@synthesize layers = _layers;

- (instancetype)initWithFileURL:(NSURL *)url {
    self = [super initWithFileURL:url];
    if (self) {
        _layers = [[NSMutableArray alloc] init];
    }
    
    return self;
}

#pragma mark - Serialization / Deserialization

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    if (![contents isKindOfClass:[NSFileWrapper class]]) {
        _layers = [NSKeyedUnarchiver unarchiveObjectWithData:contents];
        
        if (_layers) {
            NSDictionary *dictionary = @{@"layers" : _layers};
            [IterateData didReceiveCloudData:dictionary];
            return YES;
        }
        
        if (outError) {
            *outError = [NSError errorWithDomain:NSCocoaErrorDomain code:NSFileReadCorruptFileError userInfo:@{
                                                                                                               NSLocalizedDescriptionKey: NSLocalizedString(@"Could not read file", @"Read error description"),
                                                                                                               NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"File was in an invalid format", @"Read failure reason")
                                                                                                               }];
        }
    }
    
    
    return NO;
}

- (id)contentsForType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    return [NSKeyedArchiver archivedDataWithRootObject:_layers];
}

#pragma mark - Deletion

//- (void)accommodatePresentedItemDeletionWithCompletionHandler:(void (^)(NSError *errorOrNil))completionHandler {
//    [super accommodatePresentedItemDeletionWithCompletionHandler:completionHandler];
//    
//    [self.delegate listDocumentWasDeleted:self];
//}

#pragma mark - Handoff

//- (void)updateUserActivityState:(NSUserActivity *)userActivity {
//    [super updateUserActivityState:userActivity];
//    [userActivity addUserInfoEntriesFromDictionary:@{ AAPLAppConfigurationUserActivityListColorUserInfoKey: @(self.list.color) }];
//}


@end
