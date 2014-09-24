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

- (IBAction)updateXValues:(id)sender {
    float value = [self getFloatFromObject:sender];
    
    _xDeltaControl.stepper.floatValue = value;
    _xDeltaControl.slider.floatValue = value;
    _xDeltaControl.textField.floatValue = value;
    
    [self rotateLayer:nil];
}

- (IBAction)updateYValues:(id)sender {
    float value = [self getFloatFromObject:sender];
    
    _yDeltaControl.stepper.floatValue = value;
    _yDeltaControl.slider.floatValue = value;
    _yDeltaControl.textField.floatValue = value;
    
    [self rotateLayer:nil];
}

- (IBAction)updateZValues:(id)sender {
    float value = [self getFloatFromObject:sender];
    
    _zDeltaControl.stepper.floatValue = value;
    _zDeltaControl.slider.floatValue = value;
    _zDeltaControl.textField.floatValue = value;
    
    [self rotateLayer:nil];
}

- (IBAction)rotateLayer:(id)sender {
    
    if (sender != nil) {
        float value = [self getFloatFromObject:sender];
        
        _mainTranslationControl.slider.floatValue = value;
        _mainTranslationControl.stepper.floatValue = value;
        _mainTranslationControl.textField.floatValue = value;
    }
    
    
    CATransform3D transform = CATransform3DMakeRotation(_mainTranslationControl.slider.floatValue, _xDeltaControl.slider.floatValue, _yDeltaControl.slider.floatValue, _zDeltaControl.slider.floatValue);
    
    [self updateValues:[NSValue valueWithCATransform3D:transform]];
    
}

- (IBAction)translateLayer:(id)sender {
    
}

- (IBAction)scaleLayer:(id)sender {
    
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
