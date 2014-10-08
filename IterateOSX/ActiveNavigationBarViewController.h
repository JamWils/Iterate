//
//  ActiveNavigationBarViewController.h
//  IterateOSX
//
//  Created by James Wilson on 10/8/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ActiveNavigationBarViewController : NSViewController
@property (weak) IBOutlet NSButton *layerMenuButton;
@property (weak) IBOutlet NSButton *emitterLayerMenuButton;
@property (weak) IBOutlet NSButton *emitterCellMenuButton;

- (IBAction)layerButtonSelected:(NSButton *)sender;

- (IBAction)emitterLayerButtonSelected:(NSButton *)sender;

- (IBAction)EmitterCellButtonSelected:(NSButton *)sender;

@end
