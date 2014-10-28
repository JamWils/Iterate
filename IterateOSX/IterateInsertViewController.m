//
//  IterateInsertViewController.m
//  IterateOSX
//
//  Created by James Wilson on 9/29/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "IterateInsertViewController.h"
#import "IterateWindowController.h"
#import "IterateMacDocument.h"
@import QuartzCore;

@interface IterateInsertViewController ()

@end

@implementation IterateInsertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (void)viewWillAppear {
    [super viewWillAppear];
    
    _addEmitterCellButton.enabled = _selectedItem != nil;
    
    if ([_selectedItem isKindOfClass:[CAEmitterCell class]]) {
        _addLayerButton.enabled = NO;
        _addTransformLayerButton.enabled = NO;
        _addEmitterLayerButton.enabled = NO;
    }
    
    
}

- (IBAction)addLayer:(id)sender {
    CGPoint layerPoint = CGPointMake(CGRectGetMidX(_canvasBounds) - 150, CGRectGetMidY(_canvasBounds) - 150);
    CALayer *layer = [[CALayer alloc] init];
    layer.frame = CGRectMake(layerPoint.x, layerPoint.y, 300, 300);
    layer.backgroundColor = [NSColor grayColor].CGColor;
    
    //TODO: Add Unit Tests
    //Check naming conventions
    //Add layers to window instead of document
    //Have window refresh its views when changes are made to the layers property
    //Generate a key path when an item is selected in the outline view
    //Allow user to click anywhere in outline view to deselect all items
    //Fix naming conventions for all layers
    //Create NSView cell for outline view - this will have the icons that you see on the right side menu
    // -- it will also have a hidden/show (eye) icon so the user can toggle the layers in and out of view
    
    
    if ([_document isKindOfClass:[IterateMacDocument class]]) {
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
    }

}

- (IBAction)addTransformLayer:(id)sender {
    CATransformLayer *transformLayer = [[CATransformLayer alloc] init];
    
    if ([_document isKindOfClass:[IterateMacDocument class]]) {
        IterateMacDocument *iterateDocument = (IterateMacDocument*)_document;
        NSMutableArray *layers = [iterateDocument mutableArrayValueForKey:@"layers"];
        transformLayer.name = [self nameItem:layers withDefaultName:@"transformLayer"];
        //[layers addObject:transformLayer];
        
        if ([_selectedItem isKindOfClass:[CALayer class]]) {
            [_selectedItem addSublayer:transformLayer];
         } else {
             [layers addObject:transformLayer];
         }
    }
}

- (void)addEmitterLayer:(id)sender {
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.emitterPosition = CGPointMake(CGRectGetMidX(_canvasBounds), CGRectGetMidY(_canvasBounds));
    emitter.emitterSize = CGSizeMake(30, 30);
    emitter.emitterShape = kCAEmitterLayerPoint;
    emitter.renderMode = kCAEmitterLayerAdditive;
    [self addCellToItem:emitter];
    
    if ([_document isKindOfClass:[IterateMacDocument class]]) {
        IterateMacDocument *iterateDocument = (IterateMacDocument*)_document;
        NSMutableArray *layers = [iterateDocument mutableArrayValueForKey:@"layers"];
        emitter.name = [self nameItem:layers withDefaultName:@"emitterLayer"];
        [layers addObject:emitter];
    }
    
}

- (IBAction)addEmitterCell:(id)sender {
    [self addCellToItem:_selectedItem];
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

-(CGImageRef)CGImageNamed:(NSString*)name {
    NSImage *testImage = [NSImage imageNamed:name];
    
    CGImageSourceRef source;
    source = CGImageSourceCreateWithData((CFDataRef)[testImage TIFFRepresentation], NULL);
    CGImageRef maskRef =  CGImageSourceCreateImageAtIndex(source, 0, NULL);
    return maskRef;
}

@end
