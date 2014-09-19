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
    
    _stepper.floatValue = _defaultValue;
    _stepper.minValue = _minValue;
    _stepper.maxValue = _maxValue;
    
    _textFieldNumberFormatter.minimum = [NSNumber numberWithFloat:_minValue];
    _textFieldNumberFormatter.maximum = [NSNumber numberWithFloat:_maxValue];
    
    [self updateValues:_defaultValue];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (IBAction)sliderValueChanged:(id)sender {
    [self updateValues:_slider.floatValue];
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
        if ([viewController.parentViewController isKindOfClass:[NSSplitViewController class]]) {
            NSSplitViewController *splitViewController = (NSSplitViewController*)viewController.parentViewController;
            NSViewController *detailViewController = (NSViewController*)splitViewController.childViewControllers[1];
            
            if ([detailViewController respondsToSelector:@selector(updateEmitterCellProperty:withValue:)]) {
                [detailViewController performSelector:@selector(updateEmitterCellProperty:withValue:) withObject:_emitterCellProperty withObject:[NSNumber numberWithFloat:value]];
            }
            
        }
    }
}

@end
