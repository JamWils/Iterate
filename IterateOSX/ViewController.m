//
//  ViewController.m
//  IterateOSX
//
//  Created by James Wilson on 9/6/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@interface ViewController () <NSUserActivityDelegate, NSStreamDelegate>

@property (strong, nonatomic) NSInputStream *inputStream;
@property (strong, nonatomic) NSOutputStream *outputStream;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSUserActivity *activity = [[NSUserActivity alloc] initWithActivityType:@"com.noesisingenuity.emitter.liveEditing"];
    self.userActivity = activity;
    
    self.userActivity.delegate = self;
    self.userActivity.title = @"Live Editing";
    self.userActivity.supportsContinuationStreams = YES;
    [self.userActivity becomeCurrent];
    self.userActivity.needsSave = YES;
    
    NSView *view = self.view;
    CALayer *viewLayer = [CALayer layer];
    [viewLayer setBackgroundColor:CGColorCreateGenericRGB(0.0, 0.0, 0.0, 0.4)]; //RGB plus Alpha Channel
    [view setWantsLayer:YES]; // view's backing store is using a Core Animation Layer
    [view setLayer:viewLayer];
    
    [self initializeOutputStream];
    //When your info is stale:

    
}

- (void) viewWillAppear {
    [super viewWillAppear];
    
    
//    int multiplier = 1;
    
    
    
//    CAEmitterLayer *emitter = [CAEmitterLayer layer];
//    //    emitter.emitterPosition = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
//    emitter.emitterPosition = CGPointMake(500, 300);
//    emitter.emitterMode = kCAEmitterLayerOutline;
//    emitter.emitterShape = kCAEmitterLayerCuboid;
//    emitter.renderMode = kCAEmitterLayerAdditive;
//    emitter.emitterSize = CGSizeMake(30 * multiplier, 0);
//    emitter.name = @"moonLayer";
//    _moon = emitter;
    
//    [self.view.layer addSublayer:_moon];
    
    //Create the emitter cell
//    CAEmitterCell* particle = [CAEmitterCell emitterCell];
//    particle.emissionLongitude = M_PI;
//    particle.birthRate = 20;
//    particle.lifetime = multiplier;
//    particle.lifetimeRange = multiplier * 0.35;
//    particle.velocity = 0;
//    particle.velocityRange = 130;
//    particle.emissionRange = 1.1;
//    particle.scaleSpeed = 0.3;
//    CGColorRef color = CGColorCreateGenericRGB(0.3, 0.4, 0.9, 0.10);
//    particle.color = color;
//    CGColorRelease(color);
//    particle.contents = (id) [self CGImageNamed:@"Moon"];
//    emitter.emitterCells = @[particle];
//    particle.name = @"moonParticle";
}

- (void)viewDidAppear {
    [super viewDidAppear];
    NSUserActivity *activity = [[NSUserActivity alloc] initWithActivityType:@"com.noesisingenuity.emitter.liveEditing"];
    self.userActivity = activity;
    
    self.userActivity.delegate = self;
    self.userActivity.title = @"Live Editing";
    self.userActivity.supportsContinuationStreams = YES;
    [self.userActivity becomeCurrent];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
                                    
    // Update the view, if already loaded.
                                
}

- (void) initializeOutputStream {
//    self.outputStream = output;
//    self.outputStream.delegate = self;
//    [self.outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//    
//    [self.outputStream open];
    _outputStream = [[NSOutputStream alloc] initToMemory];
    
//    inputStream.delegate = self;
    _outputStream.delegate = self;
    
//    self.inputStream = inputStream;
//    outputStream = outpuself.tStream;
    
//    [inputStream open];
    [_outputStream open];
}

-(CGImageRef)CGImageNamed:(NSString*)name {
    NSImage *testImage = [NSImage imageNamed:@"Moon"];

    CGImageSourceRef source;
    
    source = CGImageSourceCreateWithData((CFDataRef)[testImage TIFFRepresentation], NULL);
    CGImageRef maskRef =  CGImageSourceCreateImageAtIndex(source, 0, NULL);
    return maskRef;
}

- (void)updateUserActivityState:(NSUserActivity *)userActivity {
    [super updateUserActivityState:userActivity];
//    [userActivity addUserInfoEntriesFromDictionary:@{
//                                                     @"imageName" : @"Moon",
//                                                     @"velocity" : [_moon valueForKeyPath:@"emitterCells.moonParticle.velocity"],
//                                                     @"birthRate" : [_moon valueForKeyPath:@"emitterCells.moonParticle.birthRate"]
//                                                     }];
}

- (void)userActivity:(NSUserActivity *)userActivity didReceiveInputStream:(NSInputStream *)inputStream outputStream:(NSOutputStream *)outputStream {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userActivity.userInfo];
    [outputStream write:data.bytes maxLength:data.length];
}

- (void)restoreUserActivityState:(NSUserActivity *)userActivity {
        NSLog(@"%s", __PRETTY_FUNCTION__);
    [super restoreUserActivityState:userActivity];
}

- (void)userActivityWillSave:(NSUserActivity *)userActivity {
        NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void) updateEmitterCellProperty:(NSString*)propertyName withValue:(id)value {
    for (CALayer *layer in [self.view.layer sublayers]) {
        if ([layer.name isEqualToString:@"moonLayer"]) {
            CAEmitterLayer *emitterLayer = (CAEmitterLayer*)layer;
            [emitterLayer setValue:value forKeyPath:propertyName];
        }
    }
    self.userActivity.needsSave = YES;
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode {
    switch (eventCode) {
        case NSStreamEventOpenCompleted: {
        } break;
        case NSStreamEventHasBytesAvailable: {
        } break;
        case NSStreamEventHasSpaceAvailable: {

        } break;
        case NSStreamEventErrorOccurred: {
        } break;
        case NSStreamEventEndEncountered: {
        } break;
        default: {
        } break;
    }

}

- (void)setLayers:(NSArray *)layers {
    //Send a notification that layers were loaded
    _layers = layers;
    
    for (CALayer *layer in _layers) {
        [self.view.layer addSublayer:layer];
    }
    [self.view setNeedsDisplay:YES];
}

@end
