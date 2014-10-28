//
//  IterateWindowController.m
//  IterateOSX
//
//  Created by James Wilson on 9/30/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "IterateWindowController.h"
#import "ContentViewController.h"
#import "LayerOutlineViewController.h"
#import "IterateInsertViewController.h"
#import "ActiveNavigationBarViewController.h"


@interface IterateWindowController ()

@end

@implementation IterateWindowController

@synthesize parentObject = _parentObject;
@synthesize selectedItem = _selectedItem;
@synthesize keyPathForSelectedItem = _keyPathForSelectedItem;

- (void)windowDidLoad {
    [super windowDidLoad];
    
    NSSplitViewController *coreSplitViewController = (NSSplitViewController*)self.window.contentViewController;
    _canvasViewController = coreSplitViewController.childViewControllers[1];
    
    NSSplitViewController *leftSideSplitViewController = coreSplitViewController.childViewControllers[0];
    _outlineViewController = leftSideSplitViewController.childViewControllers[0];
    
    NSSplitViewController *rightSideSplitViewController = coreSplitViewController.childViewControllers[2];
    _activeMenuBarController = rightSideSplitViewController.childViewControllers[0];
}

- (void)setParentObject:(id)parentObject {
    _parentObject = parentObject;
    
    NSSplitViewController *splitViewController = (NSSplitViewController*)self.window.contentViewController;
    ContentViewController *viewController = (ContentViewController*)splitViewController.childViewControllers[1];
    
    viewController.activeLayer = parentObject;

}

- (id)parentObject {
    return _parentObject;
}

- (void)setSelectedItem:(id)selectedItem {
    _selectedItem = selectedItem;
    
//    NSSplitViewController *splitViewController = (NSSplitViewController*)self.window.contentViewController;
//    ContentViewController *viewController = (ContentViewController*)splitViewController.childViewControllers[1];
    self.canvasViewController.selectedItem = selectedItem;
//    self.canvasViewController.keyPathForSelectedItem = _keyPathForSelectedItem;
    
    [_activeMenuBarController updateMenuWithSelectedItem:selectedItem];
}

- (id)selectedItem {
    return _selectedItem;
}

- (void)setKeyPathForSelectedItem:(NSString *)keyPathForSelectedItem {
    _keyPathForSelectedItem = keyPathForSelectedItem;
    self.canvasViewController.keyPathForSelectedItem = _keyPathForSelectedItem;
}

- (NSString *)keyPathForSelectedItem {
    return _keyPathForSelectedItem;
}

- (IBAction)updateCanvasColor:(id)sender {
    if (sender) {
        _canvasViewController.canvasBackgroundColor = ((NSColorWell*)sender).color;
        
    } else {
        _canvasViewController.canvasBackgroundColor = [NSColor blackColor];
        _canvasColorWell.color = [NSColor blackColor];
    }
}

- (NSViewController*)retrieveContentViewControllerAtIndex:(NSUInteger)index {
    NSViewController *viewController = nil;
    NSSplitViewController *mainSplitViewController = (NSSplitViewController*)self.window.contentViewController;
    viewController = (NSViewController*)mainSplitViewController.childViewControllers[index];
    
    return viewController;
}

- (void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"InsertViewControllerSegue"]) {
        IterateInsertViewController *viewController = (IterateInsertViewController*)segue.destinationController;
        viewController.selectedItem = _selectedItem;
        viewController.canvasBounds = _canvasViewController.view.bounds;
        viewController.document = self.document;
    }
}

@end
