//
//  EmitterControlBehavior.h
//  IterateOSX
//
//  Created by James Wilson on 9/21/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "CustomBehaviors.h"

IB_DESIGNABLE
@interface EmitterControlBehavior : CustomBehaviors

@property (nonatomic) IBInspectable NSString *emitterCellProperty;
@property (nonatomic) IBInspectable NSString *name;

- (void)updateValues:(id)value NS_REQUIRES_SUPER;


@end
