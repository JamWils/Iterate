//
//  EmitterControlBehavior.h
//  IterateOSX
//
//  Created by James Wilson on 9/21/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "CustomBehaviors.h"
@class CAEmitterCell;

IB_DESIGNABLE
@interface EmitterControlBehavior : CustomBehaviors

@property IBInspectable BOOL isCellProperty;
@property (nonatomic) IBInspectable NSString *emitterProperty;
@property (nonatomic) IBInspectable NSString *name;

- (void)updateValues:(id)value NS_REQUIRES_SUPER;

- (void)updateControls:(id)aObject;

- (void)updateEmitterCellControls:(CAEmitterCell*)emitterCell;


@end
