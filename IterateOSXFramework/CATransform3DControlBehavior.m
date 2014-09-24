//
//  CATransform3DControlBehavior.m
//  IterateOSX
//
//  Created by James Wilson on 9/23/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "CATransform3DControlBehavior.h"
#import "EmitterFloatControlBehavior.h"

@implementation CATransform3DControlBehavior

-(IBAction)xSliderUpdated:(NSSlider*)sender {
    [self updateXValues:[sender floatValue]];
}

-(IBAction)ySliderUpdated:(NSSlider*)sender {
    [self updateYValues:[sender floatValue]];
}

-(IBAction)zSliderUpdated:(NSSlider*)sender {
    [self updateZValues:[sender floatValue]];
}

-(IBAction)xTextFieldUpdated:(NSTextField*)sender {
    [self updateXValues:[sender floatValue]];
}

-(IBAction)yTextFieldUpdated:(NSTextField*)sender {
    [self updateYValues:[sender floatValue]];
}

-(IBAction)zTextFieldUpdated:(NSTextField*)sender {
    [self updateZValues:[sender floatValue]];
}

-(IBAction)xStepperUpdated:(NSStepper*)sender {
    [self updateXValues:[sender floatValue]];
}

-(IBAction)yStepperUpdated:(NSStepper*)sender {
    [self updateYValues:[sender floatValue]];
}

-(IBAction)zStepperUpdated:(NSStepper*)sender {
    [self updateZValues:[sender floatValue]];
}

- (void)updateXValues:(float)value {
    _xDeltaControl.stepper.floatValue = value;
    _xDeltaControl.slider.floatValue = value;
    _xDeltaControl.textField.floatValue = value;
}

- (void)updateYValues:(float)value {
    _yDeltaControl.stepper.floatValue = value;
    _yDeltaControl.slider.floatValue = value;
    _yDeltaControl.textField.floatValue = value;
}

- (void)updateZValues:(float)value {
    _yDeltaControl.stepper.floatValue = value;
    _yDeltaControl.slider.floatValue = value;
    _yDeltaControl.textField.floatValue = value;
}

- (IBAction)rotateLayer:(id)sender {
    
}

- (IBAction)translateLayer:(id)sender {
    
}

- (IBAction)scaleLayer:(id)sender {
    
}

@end
