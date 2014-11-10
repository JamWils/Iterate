//
//  FloatControlBehavior.m
//  IterateOSX
//
//  Created by James Wilson on 11/4/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "FloatControlBehavior.h"

@implementation FloatControlBehavior

/*- (void)awakeFromNib {
    [super awakeFromNib];
    
    _label.stringValue = super.name;
    
    _slider.continuous = YES;
    _slider.floatValue = _defaultValue;
    _slider.minValue = _minValue;
    _slider.maxValue = _maxValue;
    
    _textField.floatValue = _defaultValue;
    _textField.backgroundColor = [NSColor clearColor];
    if ([_textField.formatter isKindOfClass:[NSNumberFormatter class]]) {
        NSNumberFormatter *formatter = (NSNumberFormatter*)_textField.formatter;
        formatter.minimum = [NSNumber numberWithFloat:_minValue];
        formatter.maximum = [NSNumber numberWithFloat:_maxValue];
    }
    
    _stepper.floatValue = _defaultValue;
    _stepper.minValue = _minValue;
    _stepper.maxValue = _maxValue;
    
    _stepper.increment = _increment == 0 ? 1.0 : _increment;
    
    //    [self updateInternalValues:_defaultValue];
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

- (IBAction)enabledToggled:(NSButton *)sender {
    if ([_checkBox state] == NSOnState) {
        _textField.enabled = true;
        _stepper.enabled = true;
        _slider.enabled = true;
    } else {
        _textField.enabled = false;
        _stepper.enabled = false;
        _slider.enabled = false;
    }
}

- (void)updateControls:(id)aObject {
    id item = [aObject valueForKey:self.emitterProperty];
    if ([item respondsToSelector:@selector(floatValue)]) {
        _textField.floatValue = [item floatValue];
        _slider.floatValue = [item floatValue];
        _stepper.floatValue = [item floatValue];
    }
    
}*/

@end
