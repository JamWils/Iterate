//
//  EmitterCheckBoxControlBehavior.m
//  IterateOSX
//
//  Created by James Wilson on 9/29/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "EmitterCheckBoxControlBehavior.h"

@implementation EmitterCheckBoxControlBehavior

- (IBAction)checkBoxToggled:(NSButton *)sender {
    BOOL isChecked = sender.state == NSOnState ? YES : NO;
    [self updateValues:[NSNumber numberWithBool:isChecked]];
}

- (void)updateControls:(id)aObject {
    id item = [aObject valueForKey:self.emitterProperty];
    if ([item respondsToSelector:@selector(boolValue)]) {
        _checkBox.state = [item boolValue] ? NSOnState : NSOffState;
    }
}

@end
