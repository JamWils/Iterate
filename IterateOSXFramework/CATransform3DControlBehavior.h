//
//  CATransform3DControlBehavior.h
//  IterateOSX
//
//  Created by James Wilson on 9/23/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "EmitterConstantControlBehavior.h"
@class EmitterFloatControlBehavior;

@interface CATransform3DControlBehavior : EmitterConstantControlBehavior

@property (weak) IBOutlet EmitterFloatControlBehavior *mainTranslationControl;
@property (weak) IBOutlet EmitterFloatControlBehavior *xDeltaControl;
@property (weak) IBOutlet EmitterFloatControlBehavior *yDeltaControl;
@property (weak) IBOutlet EmitterFloatControlBehavior *zDeltaControl;

@end
