//
//  EmitterPointControlBehavior.m
//  IterateOSX
//
//  Created by James Wilson on 9/22/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "EmitterPointControlBehavior.h"
#import "EmitterFloatControlBehavior.h"
@import QuartzCore;

@implementation EmitterPointControlBehavior

-(IBAction)xSliderUpdated:(NSSlider*)sender {
    [self updateWidthValues:[sender floatValue]];
}

-(IBAction)ySliderUpdated:(NSSlider*)sender {
    [self updateHeightValues:[sender floatValue]];
}

-(IBAction)xTextFieldUpdated:(NSTextField*)sender {
    [self updateWidthValues:[sender floatValue]];
}

-(IBAction)yTextFieldUpdated:(NSTextField*)sender {
    [self updateHeightValues:[sender floatValue]];
}

-(IBAction)xStepperUpdated:(NSStepper*)sender {
    [self updateWidthValues:[sender floatValue]];
}

-(IBAction)yStepperUpdated:(NSStepper*)sender {
    [self updateHeightValues:[sender floatValue]];
}

- (IBAction)xValueUpdated:(id)sender {
    
}

- (IBAction)yValueUpdated:(id)sender {
    
}


- (void)updateWidthValues:(float)value {
    _xControl.stepper.floatValue = value;
    _xControl.slider.floatValue = value;
    _xControl.textField.floatValue = value;
    
    CGPoint point = CGPointMake(value, _yControl.stepper.floatValue);
    [self updateValues:[NSValue valueWithPoint:point]];
}

- (void)updateHeightValues:(float)value {
    _yControl.stepper.floatValue = value;
    _yControl.slider.floatValue = value;
    _yControl.textField.floatValue = value;
    
    CGPoint point = CGPointMake(_xControl.stepper.floatValue, value);
    [self updateValues:[NSValue valueWithPoint:point]];
}

- (void)updateControls:(id)aObject {
    id item = [aObject valueForKey:self.emitterProperty];
    
    if (item) {
        if (strcmp([item objCType], @encode(CGPoint)) == 0) {
            NSValue *value = (NSValue*)item;
            CGPoint point = [value  pointValue];
            _xControl.textField.floatValue = point.x;
            _xControl.slider.floatValue = point.x;
            _xControl.stepper.floatValue = point.x;
            
            _yControl.textField.floatValue = point.y;
            _yControl.slider.floatValue = point.y;
            _yControl.stepper.floatValue = point.y;
        }
        
    }
}

@end
