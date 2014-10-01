//
//  IterateColorSystemConversions.h
//  IterateOSX
//
//  Created by James Wilson on 10/1/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

@import AppKit;
@import QuartzCore;
@import Foundation;

@interface NSColor (IterateColorSystemConversions)

+(CGColorRef) IterateCIColorToCGColor: (CIColor *) ciColor;
+(CGColorRef) IterateNSColorToCGColor: (NSColor *) nsColor;
+(NSColor *) IterateCGColorToNSColor: (CGColorRef) cgColor;

@end
