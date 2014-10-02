//
//  IterateInsertViewController.m
//  IterateOSX
//
//  Created by James Wilson on 9/29/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "IterateInsertViewController.h"
#import "IterateDocument.h"
@import QuartzCore;

@interface IterateInsertViewController ()

@end

@implementation IterateInsertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (IBAction)addCellClicked:(NSButton *)sender {
    id document = [[NSDocumentController sharedDocumentController] currentDocument];
    
    if ([document isKindOfClass:[IterateDocument class]]) {
        IterateDocument *layerDocument = (IterateDocument*)document;
        int multiplier = 1;
        CALayer *viewLayer = [CALayer layer];
        [viewLayer setBackgroundColor:CGColorCreateGenericRGB(0.0, 0.0, 0.0, 0.4)]; //RGB plus Alpha Channel
        
        CAEmitterLayer *emitter = [CAEmitterLayer layer];
        //    emitter.emitterPosition = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
        emitter.emitterPosition = CGPointMake(500, 300);
        emitter.emitterMode = kCAEmitterLayerOutline;
        emitter.emitterShape = kCAEmitterLayerCuboid;
        emitter.zPosition = 140.0f;
        emitter.emitterDepth = 20.0f;
        emitter.renderMode = kCAEmitterLayerAdditive;
        emitter.emitterSize = CGSizeMake(30 * multiplier, 0);
        emitter.name = @"moonLayer2";
        
        //Create the emitter cell
        CAEmitterCell* particle = [CAEmitterCell emitterCell];
        particle.emissionLongitude = M_PI;
        particle.birthRate = 20;
        particle.lifetime = multiplier;
        particle.lifetimeRange = multiplier * 0.35;
        particle.velocity = 0;
        particle.velocityRange = 130;
        particle.emissionRange = 1.1;
        particle.scaleSpeed = 0.3;
        CGColorRef color = CGColorCreateGenericRGB(0.3, 0.4, 0.9, 0.10);
        particle.color = color;
        CGColorRelease(color);
        particle.contents = (id) [self CGImageNamed:@"Moon"];
        emitter.emitterCells = @[particle];
        particle.name = @"moonParticle2";
        
        NSMutableArray *viewLayers = [layerDocument mutableArrayValueForKey:@"layers"];
        [viewLayers addObject:emitter];
    }
}

-(CGImageRef)CGImageNamed:(NSString*)name {
    NSImage *testImage = [NSImage imageNamed:@"Moon"];
    
    CGImageSourceRef source;
    
    source = CGImageSourceCreateWithData((CFDataRef)[testImage TIFFRepresentation], NULL);
    CGImageRef maskRef =  CGImageSourceCreateImageAtIndex(source, 0, NULL);
    return maskRef;
}

@end
