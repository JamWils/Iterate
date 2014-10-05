//
//  ViewController.m
//  IterateOSX
//
//  Created by James Wilson on 9/6/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "ContentViewController.h"
#import "IterateColorSystemConversions.h"
@import QuartzCore;
@import CoreGraphics;
@import AppKit;

@interface ContentViewController () <NSUserActivityDelegate, NSStreamDelegate>

@property (strong, nonatomic) NSInputStream *inputStream;
@property (strong, nonatomic) NSOutputStream *outputStream;

@end

@implementation ContentViewController

@synthesize canvasBackgroundColor = _canvasBackgroundColor;
            
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
    [viewLayer setBackgroundColor:CGColorCreateGenericRGB(0.0, 0.0, 0.0, 0.4)];
    [view setWantsLayer:YES];
    [view setLayer:viewLayer];
    
    [self initializeOutputStream];
    
    NSPanGestureRecognizer *gestureRecognizer = [[NSPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveView:)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
}

- (void) viewWillAppear {
    [super viewWillAppear];
    NSLog(@"%@", self.view.window.windowController);
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

- (void) updateEmitterCellProperty:(NSString*)propertyName withValue:(id)value isCellValue:(BOOL)isCellValue {
    if (_activeLayer) {
        for (CALayer *layer in [self.view.layer sublayers]) {
            if ([layer.name isEqualToString:[_activeLayer valueForKey:@"name"]]) {
                CAEmitterLayer *emitterLayer = (CAEmitterLayer*)layer;
                
                if ([_selectedItem isKindOfClass:[CAEmitterCell class]]  && isCellValue) {
                    NSString *keyPath = [NSString stringWithFormat:@"%@.%@.%@", @"emitterCells", [_selectedItem valueForKey:@"name"], propertyName];
                    [emitterLayer setValue:value forKeyPath:keyPath];
                } else {
                    [emitterLayer setValue:value forKeyPath:propertyName];
                }
                
            }
        }
        self.userActivity.needsSave = YES;
    }
    
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
//
- (void)setLayers:(NSArray *)layers {
    //Send a notification that layers were loaded
    _layers = layers;
    
    [self.view setSubviews:[NSArray array]];
    for (CALayer *layer in _layers) {
        [self.view.layer addSublayer:layer];
    }
    [self.view setNeedsDisplay:YES];
}

- (void)setCanvasBackgroundColor:(NSColor *)canvasBackgroundColor {
    _canvasBackgroundColor = canvasBackgroundColor;
    [self.view.layer setBackgroundColor:canvasBackgroundColor.CGColor];
}

- (NSColor *)canvasBackgroundColor {
    return _canvasBackgroundColor;
}

- (void)moveView:(NSPanGestureRecognizer*)recognizer {
    
}

@end
