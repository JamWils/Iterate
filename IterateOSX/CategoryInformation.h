//
//  CategoryInformation.h
//  IterateOSX
//
//  Created by James Wilson on 10/6/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryInformation : NSObject

- (instancetype)initWithStoryboardIdentifier:(NSString*)storyboardIdentifier height:(float)height;

@property (readonly, copy) NSString *storyboardIdentifier;
@property (readonly) float height;

+ (NSArray*)arrayForTransformLayer;
+ (NSArray*)arrayForLayer;
+ (NSArray*)arrayForEmitterLayer;
+ (NSArray*)arrayForEmitterCells;

@end
