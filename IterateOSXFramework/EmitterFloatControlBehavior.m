//
//  EmitterControlBehavior.m
//  IterateOSX
//
//  Created by James Wilson on 9/16/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "EmitterFloatControlBehavior.h"
//#import "ViewController.h"
//@import AppKit;

@interface EmitterFloatControlBehavior ()



@end

@implementation EmitterFloatControlBehavior

- (void)awakeFromNib {
    [super awakeFromNib];
    _label.stringValue = super.name;
    
    _slider.continuous = YES;
    _slider.floatValue = _defaultValue;
    _slider.minValue = _minValue;
    _slider.maxValue = _maxValue;
    
    _textField.floatValue = _defaultValue;
    if ([_textField.formatter isKindOfClass:[NSNumberFormatter class]]) {
        NSNumberFormatter *formatter = (NSNumberFormatter*)_textField.formatter;
        formatter.minimum = [NSNumber numberWithFloat:_minValue];
        formatter.maximum = [NSNumber numberWithFloat:_maxValue];
    }
    
    _stepper.floatValue = _defaultValue;
    _stepper.minValue = _minValue;
    _stepper.maxValue = _maxValue;
    
    
    
    [self updateInternalValues:_defaultValue];
}

- (IBAction)sliderValueChanged:(NSSlider*)sender {
    [self updateInternalValues:sender.floatValue];
}

- (IBAction)stepperValueChanged:(NSStepper *)sender {
    [self updateInternalValues:sender.floatValue];
}

- (IBAction)textFieldValueChanged:(NSTextField*)sender {
    [self updateInternalValues:sender.floatValue];
}

- (void)updateInternalValues:(float)value {
    _stepper.floatValue = value;
    _textField.floatValue = value;
    _slider.floatValue = value;
    
    [self updateValues:[NSNumber numberWithFloat:value]];
}

@end
