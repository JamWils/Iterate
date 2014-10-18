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

//LayerTransformViewController

+ (NSArray*)arrayForLayer {
    NSArray *categoryItems = @[
                               [[CategoryInformation alloc] initWithStoryboardIdentifier:@"LayerTransformViewController" height:448]
                               ];
    
    return categoryItems;
}

+ (NSArray*)arrayForEmitterLayer {
    NSArray *categoryItems = @[
                               [[CategoryInformation alloc] initWithStoryboardIdentifier:@"EmitterLayerMainViewController" height:452],
                               [[CategoryInformation alloc] initWithStoryboardIdentifier:@"EmitterLayerMultiplierViewController" height:448]
                               ];
    
    return categoryItems;
}

+ (NSArray*)arrayForEmitterCells {
    NSArray *categoryItems = @[
                               [[CategoryInformation alloc] initWithStoryboardIdentifier:@"EmitterCellMainViewController" height:152],
                               [[CategoryInformation alloc] initWithStoryboardIdentifier:@"EmitterCellColorViewController" height:356],
                               [[CategoryInformation alloc] initWithStoryboardIdentifier:@"EmitterCellVisualViewController" height:331],
                               [[CategoryInformation alloc] initWithStoryboardIdentifier:@"EmitterCellMotionViewController" height:329],
                               [[CategoryInformation alloc] initWithStoryboardIdentifier:@"EmitterCellTemporalViewController" height:500]
                               ];
    
    return categoryItems;
}

@end
