//
//  EmitterControlBehavior.m
//  IterateOSX
//
//  Created by James Wilson on 9/16/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "EmitterControlBehavior.h"
#import "ViewController.h"
//@import AppKit;

@interface EmitterControlBehavior ()



@end

@implementation EmitterControlBehavior

- (void)awakeFromNib {
    _label.stringValue = _name;
    
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
    
    
    
    [self updateValues:_defaultValue];
}

- (IBAction)sliderValueChanged:(NSSlider*)sender {
    [self updateValues:sender.floatValue];
}

- (IBAction)stepperValueChanged:(NSStepper *)sender {
    [self updateValues:sender.floatValue];
}

- (IBAction)textFieldValueChanged:(NSTextField*)sender {
    [self updateValues:sender.floatValue];
}

- (void)updateValues:(float)value {
    _stepper.floatValue = value;
    _textField.floatValue = value;
    _slider.floatValue = value;
    
    if ([self.owner isKindOfClass:[NSViewController class]]) {
        NSViewController *viewController = (NSViewController*)self.owner;
        if ([viewController.parentViewController isKindOfClass:[NSViewController class]]) {
            NSViewController *containerViewController = (NSViewController*)viewController.parentViewController;
            
            if ([containerViewController.parentViewController isKindOfClass:[NSSplitViewController class]]) {
                NSSplitViewController *splitViewController = (NSSplitViewController*)containerViewController.parentViewController;
                NSViewController *detailViewController = (NSViewController*)splitViewController.childViewControllers[1];
                
                if ([detailViewController respondsToSelector:@selector(updateEmitterCellProperty:withValue:)]) {
                    [detailViewController performSelector:@selector(updateEmitterCellProperty:withValue:) withObject:_emitterCellProperty withObject:[NSNumber numberWithFloat:value]];
                }
                
            }
        }
        
    }
}

@end
