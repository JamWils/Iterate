//
//  IterateInsertViewController.m
//  IterateOSX
//
//  Created by James Wilson on 9/29/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "IterateInsertViewController.h"
#import "IterateWindowController.h"
#import "IterateDocument.h"
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
    _addLayerButton.enabled = ![_selectedItem isKindOfClass:[CAEmitterCell class]];
}

- (IBAction)addCellClicked:(NSButton *)sender {
//    id document = [[NSDocumentController sharedDocumentController] currentDocument];
//    
//    if ([document isKindOfClass:[IterateDocument class]]) {
//        IterateDocument *layerDocument = (IterateDocument*)document;
        
        
//        NSMutableArray *viewLayers = [layerDocument mutableArrayValueForKey:@"layers"];
//        [viewLayers addObject:emitter];
//    }
}

- (void)addEmitterLayer:(id)sender {
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.emitterPosition = CGPointMake(CGRectGetMidX(_canvasBounds), CGRectGetMidY(_canvasBounds));
    emitter.emitterSize = CGSizeMake(30, 30);
    emitter.emitterShape = kCAEmitterLayerPoint;
    emitter.renderMode = kCAEmitterLayerAdditive;
    [self addCellToItem:emitter];
    
    if ([_document isKindOfClass:[IterateDocument class]]) {
        IterateDocument *iterateDocument = (IterateDocument*)_document;
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
