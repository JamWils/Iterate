//
//  IterateWindowController.h
//  IterateOSX
//
//  Created by James Wilson on 9/30/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LayerContentViewControllerProtocol.h"
@class LayerOutlineViewController;

@interface IterateWindowController : NSWindowController

@property (strong) id selectedItem;
@property (strong) id parentObject;

@property (assign) id<LayerContentViewControllerProtocol> contentViewControllerProtocol;
@property (assign) LayerOutlineViewController *outlineViewController;

@property (weak) IBOutlet NSColorWell *canvasColorWell;


- (IBAction)updateCanvasColor:(id)sender;

@end
