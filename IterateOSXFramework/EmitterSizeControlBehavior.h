//
//  EmitterSizeControlBehavior.h
//  IterateOSX
//
//  Created by James Wilson on 9/23/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "EmitterControlBehavior.h"
@class EmitterFloatControlBehavior;

@interface EmitterSizeControlBehavior : EmitterControlBehavior

@property (nonatomic, weak) IBOutlet EmitterFloatControlBehavior *widthControl;
@property (nonatomic, weak) IBOutlet EmitterFloatControlBehavior *heightControl;

@end
