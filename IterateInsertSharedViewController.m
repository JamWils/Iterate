//
//  IterateInsertSharedViewController.m
//  IterateOSX
//
//  Created by James Wilson on 10/31/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "IterateInsertSharedViewController.h"

#if TARGET_OS_IPHONE

@import UIKit;

#elif TARGET_OS_MAC

@import Cocoa;

#endif


@implementation IterateInsertSharedViewController

- (instancetype)init
{
    return nil;
}

- (instancetype)initWithCoordinator:(id<MainCoordinatorProtocol>)coordinator layers:(NSMutableArray*)layers selectedItem:(id)selectedItem canvasBounds:(CGRect)canvasBounds {
    self = [super init];
    if (self) {
        _layers = layers;
        _parentWindow = coordinator;
        _selectedItem = selectedItem;
        _canvasBounds = canvasBounds;
    }
    
    return self;
}

- (void)addLayer:(id)sender {
    CGPoint layerPoint = CGPointMake(CGRectGetMidX(_canvasBounds) - 150, CGRectGetMidY(_canvasBounds) - 150);
    CALayer *layer = [[CALayer alloc] init];
    layer.frame = CGRectMake(layerPoint.x, layerPoint.y, 300, 300);
    
    CGFloat components[] = {0.5, 0.5, 0.5, 1.0};
    CGColorRef color = CGColorCreate(CGColorSpaceCreateDeviceRGB(), components);
    layer.backgroundColor = color;
    CGColorRelease(color);
    
    [self addLayer:layer withName:@"layer"];
}

- (void)addTransformLayer:(id)sender {
    CATransformLayer *layer = [[CATransformLayer alloc] init];
    [self addLayer:layer withName:@"transformLayer"];
}

- (void)addEmitterLayer:(id)sender {
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.emitterPosition = CGPointMake(CGRectGetMidX(_canvasBounds), CGRectGetMidY(_canvasBounds));
    emitter.emitterSize = CGSizeMake(30, 30);
    emitter.emitterShape = kCAEmitterLayerPoint;
    emitter.renderMode = kCAEmitterLayerAdditive;
    [self addCellToItem:emitter];
    
    [self addLayer:emitter withName:@"emitterLayer"];
}

- (void)addEmitterCell:(id)sender {
    [self addCellToItem:_selectedItem];
    
    [_parentWindow distributeLayers:self.layers fromViewController:self];
}

- (void)addCellToItem:(id)item {
    if ([item respondsToSelector:@selector(emitterCells)]) {
        __block NSMutableArray *emitterCells = [[NSMutableArray alloc] init];
        NSArray *oldCells = [item valueForKey:@"emitterCells"];
        [oldCells enumerateObjectsUsingBlock:^(CAEmitterCell *cell, NSUInteger idx, BOOL *stop) {
            [emitterCells addObject:cell];
        }];
        
        CAEmitterCell *cell = [[CAEmitterCell alloc] init];
        cell.birthRate = 5;
        cell.lifetime = 1;
        cell.lifetimeRange = 1;
        cell.velocity = 0;
        cell.contents = (id)[self CGImageNamed:@"Cell"];
        cell.name = [self nameItem:emitterCells withDefaultName:@"emitterCell"];
        [emitterCells addObject:cell];
        
        [item setValue:emitterCells forKey:@"emitterCells"];
    }
}

- (NSString*)nameItem:(NSArray*)currentItems withDefaultName:(NSString*)defaultName{
    __block NSString *newName = defaultName;
    __block int appendIndex = 1;
    [currentItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([obj respondsToSelector:@selector(name)]) {
            
        }
        
        NSString *objectsName = [obj valueForKey:@"name"];
        if ([objectsName isEqualToString:newName]) {
            appendIndex++;
            newName = [NSString stringWithFormat:@"%@%i", defaultName, appendIndex];
        }
        
    }];
    
    return newName;
}

- (void)addLayer:(CALayer*)layer withName:(NSString*)name {
    if ([_selectedItem isKindOfClass:[CALayer class]]) {
        [layer setName:[self nameItem:[_selectedItem sublayers] withDefaultName:name]];
        [_selectedItem addSublayer:layer];
    } else {
        [layer setName:[self nameItem:_layers withDefaultName:name] ];
        [_layers addObject:layer];
    }
    
    [_parentWindow distributeLayers:self.layers fromViewController:self];
}

-(CGImageRef)CGImageNamed:(NSString*)name {
#if TARGET_OS_IPHONE
    UIImage *testImage = [UIImage imageNamed:name];
    return testImage.CGImage;
    
#elif TARGET_OS_MAC
    
    NSImage *testImage = [NSImage imageNamed:name];
    
    CGImageSourceRef source;
    source = CGImageSourceCreateWithData((CFDataRef)[testImage TIFFRepresentation], NULL);
    CGImageRef maskRef =  CGImageSourceCreateImageAtIndex(source, 0, NULL);
    return maskRef;
    
#endif
    
    
}


@end
