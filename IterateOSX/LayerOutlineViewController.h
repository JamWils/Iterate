//
//  LayerOutlineViewController.h
//  IterateOSX
//
//  Created by James Wilson on 9/24/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

@import Cocoa;
@import AppKit;

@interface LayerOutlineViewController : NSViewController

@property (weak) IBOutlet NSOutlineView *layerOutlineView;
@property (strong, nonatomic) NSMutableArray *layers;

@end
