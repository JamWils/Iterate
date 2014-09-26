//
//  IterateEmitterCell.h
//  IterateOSX
//
//  Created by James Wilson on 9/25/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAEmitterCell (Layer)

- (CALayer*)iterateLayerForCell:(NSArray*)layers;

@end