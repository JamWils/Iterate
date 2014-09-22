//
//  EmitterPropertyView.m
//  IterateOSX
//
//  Created by James Wilson on 9/21/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "EmitterPropertyView.h"

@implementation EmitterPropertyView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)setViewBackgroundColor:(NSColor *)viewBackgroundColor {
    self.layer.backgroundColor = viewBackgroundColor.CGColor;
}

@end
