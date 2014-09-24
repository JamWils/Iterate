//
//  EmitterControlBehavior.h
//  IterateOSX
//
//  Created by James Wilson on 9/16/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "EmitterControlBehavior.h"
//@class EmitterControlBehavior;

IB_DESIGNABLE
@interface EmitterFloatControlBehavior : EmitterControlBehavior

@property (nonatomic, weak) IBOutlet NSTextField *label;
@property (nonatomic, weak) IBOutlet NSSlider *slider;
@property (nonatomic, weak) IBOutlet NSTextField *textField;
@property (nonatomic, weak) IBOutlet NSStepper *stepper;

@property (nonatomic) IBInspectable float defaultValue;
@property (nonatomic) IBInspectable float minValue;
@property (nonatomic) IBInspectable float maxValue;
@property (nonatomic) IBInspectable float increment;

@end
