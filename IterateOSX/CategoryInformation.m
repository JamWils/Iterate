//
//  CategoryInformation.m
//  IterateOSX
//
//  Created by James Wilson on 10/6/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "CategoryInformation.h"

@implementation CategoryInformation

- (instancetype)init
{
    return nil;
}

- (instancetype)initWithStoryboardIdentifier:(NSString*)storyboardIdentifier height:(float)height
{
    self = [super init];
    if (self) {
        _storyboardIdentifier = storyboardIdentifier;
        _height = height;
    }
    return self;
}

+ (NSArray*)arrayForEmitterCells {
    NSArray *categoryItems = @[
                               [[CategoryInformation alloc] initWithStoryboardIdentifier:@"EmitterCellMainViewController" height:175],
                               [[CategoryInformation alloc] initWithStoryboardIdentifier:@"EmitterCellColorViewController" height:366],
                               [[CategoryInformation alloc] initWithStoryboardIdentifier:@"EmitterCellVisualViewController" height:340],
                               [[CategoryInformation alloc] initWithStoryboardIdentifier:@"EmitterCellMotionViewController" height:341],
                               [[CategoryInformation alloc] initWithStoryboardIdentifier:@"EmitterCellTemporalViewController" height:510]
                               ];
    
    return categoryItems;
}

@end
