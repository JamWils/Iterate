//
//  EmitterPointControlBehavior.h
//  IterateOSX
//
//  Created by James Wilson on 9/22/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "EmitterControlBehavior.h"
@class EmitterFloatControlBehavior;

@interface EmitterPointControlBehavior : EmitterControlBehavior

@property (nonatomic, weak) IBOutlet EmitterFloatControlBehavior *xControl;
@property (nonatomic, weak) IBOutlet EmitterFloatControlBehavior *yControl;

@end
