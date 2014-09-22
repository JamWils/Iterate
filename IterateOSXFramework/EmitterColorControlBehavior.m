//
//  EmitterColorControlBehavior.m
//  IterateOSX
//
//  Created by James Wilson on 9/21/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "EmitterColorControlBehavior.h"

@implementation EmitterColorControlBehavior

- (IBAction)colorSelected:(NSColorWell *)sender {
    [self updateValues:(id)[sender color].CGColor];
}


@end
