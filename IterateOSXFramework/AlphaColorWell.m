//
//  AlphaColorWell.m
//  IterateOSX
//
//  Created by James Wilson on 9/22/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "AlphaColorWell.h"

@implementation AlphaColorWell

- (void)activate:(BOOL)exclusive
{
    [[NSColorPanel sharedColorPanel] setShowsAlpha:YES];
    [super activate:exclusive];
}

- (void)deactivate
{
    [super deactivate];
    [[NSColorPanel sharedColorPanel] setShowsAlpha:NO];
}

@end
