//
//  IterateInsertViewController.h
//  IterateOSX
//
//  Created by James Wilson on 9/29/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface IterateInsertViewController : NSViewController

@property (strong) id document;
@property (strong) id selectedItem;
@property (strong) NSMutableArray *layers;

@property (weak) IBOutlet NSButton *addLayerButton;
@property (weak) IBOutlet NSButton *addTransformLayerButton;
@property (weak) IBOutlet NSButton *addEmitterLayerButton;
@property (weak) IBOutlet NSButton *addEmitterCellButton;

@property CGRect canvasBounds;

- (IBAction)addEmitterLayer:(id)sender;
- (IBAction)addEmitterCell:(id)sender;
- (IBAction)addLayer:(id)sender;
- (IBAction)addTransformLayer:(id)sender;



@end
