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

- (IBAction)widthValueUpdated:(id)sender {
    float floatValue = [self getFloatFromObject:sender];
    
    _widthControl.stepper.floatValue = floatValue;
    _widthControl.slider.floatValue = floatValue;
    _widthControl.textField.floatValue = floatValue;
    
    CGSize size = CGSizeMake(floatValue, _heightControl.stepper.floatValue);
    [self updateValues:[NSValue valueWithSize:size]];
}

- (IBAction)heightValueUpdated:(id)sender {
    float floatValue = [self getFloatFromObject:sender];
    
    _heightControl.stepper.floatValue = floatValue;
    _heightControl.slider.floatValue = floatValue;
    _heightControl.textField.floatValue = floatValue;
    
    CGSize size = CGSizeMake(_widthControl.stepper.floatValue, floatValue);
    [self updateValues:[NSValue valueWithSize:size]];
}

- (void)updateControls:(id)aObject {
    id item = [aObject valueForKey:self.emitterProperty];
    
    if (item) {
        if (strcmp([item objCType], @encode(CGSize)) == 0) {
            NSValue *value = (NSValue*)item;
            CGSize size = [value  sizeValue];
            _widthControl.textField.floatValue = size.width;
            _widthControl.slider.floatValue = size.width;
            _widthControl.stepper.floatValue = size.width;
            
            _heightControl.textField.floatValue = size.height;
            _heightControl.slider.floatValue = size.height;
            _heightControl.stepper.floatValue = size.height;
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
