//
//  IterateColorSystemConversions.m
//  IterateOSX
//
//  Created by James Wilson on 10/1/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "IterateColorSystemConversions.h"

@implementation NSColor (ColorSystemConversions)

+(CGColorRef) IterateCIColorToCGColor: (CIColor *) ciColor {
    CGColorSpaceRef colorSpace = [ciColor colorSpace];
    const CGFloat *components = [ciColor components];
    CGColorRef cgColor = CGColorCreate (colorSpace, components);
//    CGColorSpaceRelease(colorSpace);
    return (__bridge CGColorRef)(CFBridgingRelease(cgColor));
}

+(CGColorRef) IterateNSColorToCGColor: (NSColor *) nsColor {
    CIColor *ciColor = [[CIColor alloc] initWithColor: nsColor];
    CGColorRef cgColor = [NSColor IterateCIColorToCGColor: ciColor];
//    [ciColor release];
    return cgColor;
}

+(NSColor *) IterateCGColorToNSColor: (CGColorRef) cgColor {
    return [NSColor colorWithCIColor: [CIColor colorWithCGColor: cgColor]];
}
@end
