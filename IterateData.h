//
//  IterateData.h
//  IterateOSX
//
//  Created by James Wilson on 11/8/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IterateDocumentProtocol.h"
@class IterateDocument;

@interface IterateData : NSObject

+(IterateDocument*)getIterateDocument;

+(void)didReceiveCloudData:(NSDictionary*)dictionary;

+(NSURL*)localDocumentsDirectoryURL;

@end
