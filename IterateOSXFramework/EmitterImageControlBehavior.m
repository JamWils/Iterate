//
//  EmitterImageControlBehavior.m
//  IterateOSX
//
//  Created by James Wilson on 9/22/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "EmitterImageControlBehavior.h"

@implementation EmitterImageControlBehavior

- (IBAction)updateImage:(NSImageView*)sender {
    CGImageRef image = [self CGImageFromNSImage:sender.image];
    [self updateValues:(__bridge id)image];
}

- (void)updateControls:(id)aObject {
    id item = [aObject valueForKey:self.emitterProperty];
    
    if (item) {
        _imageView.image = [[NSImage alloc] initWithCGImage:(__bridge CGImageRef)item size:NSSizeFromCGSize(CGSizeMake(100.0, 100.0))];
    }
}



-(CGImageRef)CGImageFromNSImage:(NSImage*)image {
    
    CGImageSourceRef source;
    
    source = CGImageSourceCreateWithData((CFDataRef)[image TIFFRepresentation], NULL);
    CGImageRef maskRef =  CGImageSourceCreateImageAtIndex(source, 0, NULL);
    return maskRef;
}
@end
