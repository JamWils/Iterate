//
//  EmitterColorControlBehavior.m
//  IterateOSX
//
//  Created by James Wilson on 9/21/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "EmitterColorControlBehavior.h"
#import <QuartzCore/QuartzCore.h>
#import "AlphaColorWell.h"

@implementation EmitterColorControlBehavior

- (IBAction)colorSelected:(NSColorWell *)sender {
    [self updateValues:(id)[sender color].CGColor];
}

- (void)updateControls:(NSNotification*)notification {
//    id item = [notification.userInfo[@"Layer"] valueForKey:self.emitterProperty];
//    
//    if (item) {
//        _colorWell.color = [NSColor colorWithCGColor:(__bridge CGColorRef)(item)];
//    }
}

@end
