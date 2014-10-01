//
//  IterateWindowController.m
//  IterateOSX
//
//  Created by James Wilson on 9/30/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "IterateWindowController.h"
#import "ContentViewController.h"

@interface IterateWindowController ()

@end

@implementation IterateWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (void)setParentObject:(id)parentObject {
    _parentObject = parentObject;
    
    NSSplitViewController *splitViewController = (NSSplitViewController*)self.window.contentViewController;

//    NSSplitViewController *leftSplitViewController = (NSSplitViewController*)splitViewController.childViewControllers[0];
//    LayerOutlineViewController *outlineViewController = leftSplitViewController.childViewControllers[0];
//    outlineViewController.layers = self.layers;
    
    ContentViewController *viewController = (ContentViewController*)splitViewController.childViewControllers[1];
    viewController.activeLayer = parentObject;

}

- (void)setSelectedItem:(id)selectedItem {
    _selectedItem = selectedItem;
    
    NSSplitViewController *splitViewController = (NSSplitViewController*)self.window.contentViewController;
    
    //    NSSplitViewController *leftSplitViewController = (NSSplitViewController*)splitViewController.childViewControllers[0];
    //    LayerOutlineViewController *outlineViewController = leftSplitViewController.childViewControllers[0];
    //    outlineViewController.layers = self.layers;
    
    ContentViewController *viewController = (ContentViewController*)splitViewController.childViewControllers[1];
    viewController.selectedItem = selectedItem;
}

- (IBAction)updateCanvasColor:(id)sender {
    NSViewController *viewController = [self retrieveContentViewControllerAtIndex:1];
    if ([viewController isKindOfClass:[ContentViewController class]]) {
        ContentViewController *contentViewController = (ContentViewController*)viewController;
        contentViewController.canvasBackgroundColor = ((NSColorWell*)sender).color;
    }
}

- (NSViewController*)retrieveContentViewControllerAtIndex:(NSUInteger)index {
    NSViewController *viewController = nil;
    NSSplitViewController *mainSplitViewController = (NSSplitViewController*)self.window.contentViewController;
    viewController = (NSViewController*)mainSplitViewController.childViewControllers[index];
//    if (mainSplitViewController.childViewControllers.count < index) {
//        
//    }
    
    return viewController;
}

//- (void)setSelectedItem:(id)selectedItem {
//    
//}

@end
