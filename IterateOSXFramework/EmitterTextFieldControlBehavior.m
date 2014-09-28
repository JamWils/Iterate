//
//  EmitterTextFieldControlBehavior.m
//  IterateOSX
//
//  Created by James Wilson on 9/28/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "EmitterTextFieldControlBehavior.h"

@implementation EmitterTextFieldControlBehavior

- (IBAction)textFieldEdited:(NSTextField *)sender {
    [self updateValues:[sender stringValue]];
}

- (void)updateControls:(id)aObject {
    if ([aObject valueForKey:self.emitterProperty]) {
        _textField.stringValue = [aObject valueForKey:self.emitterProperty];
    }
}

@end
