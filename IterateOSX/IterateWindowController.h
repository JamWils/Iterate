//
//  IterateWindowController.h
//  IterateOSX
//
//  Created by James Wilson on 9/30/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MainCoordinatorProtocol.h"
@class IterateCanvasViewControllerOSX;
@class LayerOutlineViewController;
@class ActiveNavigationBarViewController;

@interface IterateWindowController : NSWindowController <MainCoordinatorProtocol>

@property (strong) id selectedItem;
@property (strong) id parentObject;
@property (copy) NSString *keyPathForSelectedItem;

@property (assign) IterateCanvasViewControllerOSX *canvasViewController;
@property (assign) LayerOutlineViewController *outlineViewController;
@property (assign) ActiveNavigationBarViewController *activeMenuBarController;

@property (weak) IBOutlet NSColorWell *canvasColorWell;

- (IBAction)updateCanvasColor:(id)sender;

//- (void)distributeLayers:(NSMutableArray*)layers fromViewController:(NSViewController*)viewController;
@end
