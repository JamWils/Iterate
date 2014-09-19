//
//  EmitterControlBehavior.h
//  IterateOSX
//
//  Created by James Wilson on 9/16/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "CustomBehaviors.h"

IB_DESIGNABLE
@interface EmitterControlBehavior : CustomBehaviors

@property (nonatomic, weak) IBOutlet NSTextField *label;
@property (nonatomic, weak) IBOutlet NSSlider *slider;
@property (nonatomic, weak) IBOutlet NSTextField *textField;
@property (nonatomic, weak) IBOutlet NSStepper *stepper;
@property (weak) IBOutlet NSNumberFormatter *textFieldNumberFormatter;

@property (nonatomic) IBInspectable NSString *name;
@property (nonatomic) IBInspectable NSString *emitterCellProperty;
@property (nonatomic) IBInspectable float defaultValue;
@property (nonatomic) IBInspectable float minValue;
@property (nonatomic) IBInspectable float maxValue;

@end
