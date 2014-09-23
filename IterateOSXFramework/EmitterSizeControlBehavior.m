//
//  EmitterSizeControlBehavior.m
//  IterateOSX
//
//  Created by James Wilson on 9/23/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "EmitterSizeControlBehavior.h"
#import "EmitterFloatControlBehavior.h"

@implementation EmitterSizeControlBehavior

-(IBAction)widthSliderUpdated:(NSSlider*)sender {
    [self updateWidthValues:[sender floatValue]];
}

-(IBAction)heightSliderUpdated:(NSSlider*)sender {
    [self updateHeightValues:[sender floatValue]];
}

-(IBAction)widthTextFieldUpdated:(NSTextField*)sender {
    [self updateWidthValues:[sender floatValue]];
}

-(IBAction)heightTextFieldUpdated:(NSTextField*)sender {
    [self updateHeightValues:[sender floatValue]];
}

-(IBAction)widthStepperUpdated:(NSStepper*)sender {
    [self updateWidthValues:[sender floatValue]];
}

-(IBAction)heightStepperUpdated:(NSStepper*)sender {
    [self updateHeightValues:[sender floatValue]];
}

- (void)updateWidthValues:(float)value {
    _widthControl.stepper.floatValue = value;
    _widthControl.slider.floatValue = value;
    _widthControl.textField.floatValue = value;
    
    CGSize size = CGSizeMake(value, _heightControl.stepper.floatValue);
    [self updateValues:[NSValue valueWithSize:size]];
}

- (void)updateHeightValues:(float)value {
    _heightControl.stepper.floatValue = value;
    _heightControl.slider.floatValue = value;
    _heightControl.textField.floatValue = value;
    
    CGSize size = CGSizeMake(_widthControl.stepper.floatValue, value);
    [self updateValues:[NSValue valueWithSize:size]];
}

@end
