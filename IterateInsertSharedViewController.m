//
//  IterateInsertSharedViewController.m
//  IterateOSX
//
//  Created by James Wilson on 10/31/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "IterateInsertSharedViewController.h"

@implementation IterateInsertSharedViewController

- (IBAction)addLayer:(id)sender {
    CGPoint layerPoint = CGPointMake(CGRectGetMidX(_canvasBounds) - 150, CGRectGetMidY(_canvasBounds) - 150);
    CALayer *layer = [[CALayer alloc] init];
    layer.frame = CGRectMake(layerPoint.x, layerPoint.y, 300, 300);
    
    CGFloat components[] = {0.5, 0.5, 0.5, 1.0};
    CGColorRef color = CGColorCreate(CGColorSpaceCreateDeviceRGB(), components);
    layer.backgroundColor = color;
    CGColorRelease(color);
    
    /*if ([_document isKindOfClass:[IterateMacDocument class]]) {
        IterateMacDocument *iterateDocument = (IterateMacDocument*)_document;
        NSMutableArray *layers = [iterateDocument mutableArrayValueForKey:@"layers"];
        id objectToCheck = _selectedItem == nil ? layers : [_selectedItem sublayers];
        layer.name = [self nameItem:objectToCheck withDefaultName:@"layer"];
        
        
        if ([_selectedItem isKindOfClass:[CALayer class]]) {
            //            NSMutableArray *sublayers = [_selectedItem mutableArrayValueForKey:@"sublayers"];
            //            [sublayers index:layer];
            [_selectedItem addSublayer:layer];
        } else {
            [layers addObject:layer];
        }
    }*/
    
}

- (IBAction)addTransformLayer:(id)sender {
    CATransformLayer *transformLayer = [[CATransformLayer alloc] init];
    
    /*if ([_document isKindOfClass:[IterateMacDocument class]]) {
        IterateMacDocument *iterateDocument = (IterateMacDocument*)_document;
        NSMutableArray *layers = [iterateDocument mutableArrayValueForKey:@"layers"];
        transformLayer.name = [self nameItem:layers withDefaultName:@"transformLayer"];
        //[layers addObject:transformLayer];
        
        if ([_selectedItem isKindOfClass:[CALayer class]]) {
            [_selectedItem addSublayer:transformLayer];
        } else {
            [layers addObject:transformLayer];
        }
    }*/
}

- (void)addEmitterLayer:(id)sender {
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.emitterPosition = CGPointMake(CGRectGetMidX(_canvasBounds), CGRectGetMidY(_canvasBounds));
    emitter.emitterSize = CGSizeMake(30, 30);
    emitter.emitterShape = kCAEmitterLayerPoint;
    emitter.renderMode = kCAEmitterLayerAdditive;
    [self addCellToItem:emitter];
    
    emitter.name = [self nameItem:_layers withDefaultName:@"emitterLayer"];
    [_layers addObject:emitter];
    [_parentWindow distributeLayers:self.layers fromViewController:self];
    
    /*if ([_parentWindow isKindOfClass:[IterateWindowController class]]) {
        emitter.name = [self nameItem:_layers withDefaultName:@"emitterLayer"];
        [_layers addObject:emitter];
        
        [_parentWindow distributeLayers:self.layers fromViewController:self];
    }*/
}

- (IBAction)addEmitterCell:(id)sender {
    [self addCellToItem:_selectedItem];
    
    [_parentWindow distributeLayers:self.layers fromViewController:self];
    /*if ([_parentWindow isKindOfClass:[IterateWindowController class]]) {
        [_parentWindow distributeLayers:self.layers fromViewController:self];
    }*/
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
        //cell.contents = (id)[self CGImageNamed:@"Cell"];
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

/*-(CGImageRef)CGImageNamed:(NSString*)name {
    NSImage *testImage = [NSImage imageNamed:name];
    
    CGImageSourceRef source;
    source = CGImageSourceCreateWithData((CFDataRef)[testImage TIFFRepresentation], NULL);
    CGImageRef maskRef =  CGImageSourceCreateImageAtIndex(source, 0, NULL);
    return maskRef;
}*/


@end
