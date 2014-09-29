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

- (IBAction)xValueUpdated:(id)sender {
    float floatValue = [self getFloatFromObject:sender];
    
    _xControl.stepper.floatValue = floatValue;
    _xControl.slider.floatValue = floatValue;
    _xControl.textField.floatValue = floatValue;
    
    CGPoint point = CGPointMake(floatValue, _yControl.stepper.floatValue);
    [self updateValues:[NSValue valueWithPoint:point]];
}

- (IBAction)yValueUpdated:(id)sender {
    float floatValue = [self getFloatFromObject:sender];
    
    _yControl.stepper.floatValue = floatValue;
    _yControl.slider.floatValue = floatValue;
    _yControl.textField.floatValue = floatValue;
    

    CGPoint point = CGPointMake(_xControl.stepper.floatValue, floatValue);
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

- (float)getFloatFromObject:(id)sender {
    float value = 0.0;
    
    if ([sender isKindOfClass:[NSControl class]]) {
        NSControl *control = (NSControl*)sender;
        value = [control floatValue];
    }
    
    return value;
}

@end
