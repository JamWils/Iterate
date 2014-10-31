//
//  Document.m
//  IterateOSX
//
//  Created by James Wilson on 9/23/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "IterateMacDocument.h"
#import <QuartzCore/QuartzCore.h>
#import "ContentViewController.h"
#import "LayerOutlineViewController.h"
#import "IterateWindowController.h"

@interface IterateMacDocument () <NSWindowDelegate>

@end

@implementation IterateMacDocument

@synthesize layers = _layers;

- (instancetype)init {
    self = [super init];
    if (self) {
        _layers = [[NSMutableArray alloc] init];
        _canvasBackgroundColor = [NSColor whiteColor];
    }
    return self;
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController {
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
    
    NSLog(@"%@", aController.contentViewController);
}

+ (BOOL)autosavesInPlace {
    return YES;
}

- (void)makeWindowControllers {
    // Override to return the Storyboard file name of the document.
    IterateWindowController *windowController = (IterateWindowController*)[[NSStoryboard storyboardWithName:@"Main" bundle:nil] instantiateControllerWithIdentifier:@"IterateWindowController"];
    [self addWindowController:windowController];
    
    
    NSSplitViewController *splitViewController = (NSSplitViewController*)windowController.window.contentViewController;
    //Send layer array to outline view
    NSSplitViewController *leftSplitViewController = (NSSplitViewController*)splitViewController.childViewControllers[0];
    LayerOutlineViewController *outlineViewController = leftSplitViewController.childViewControllers[0];
    outlineViewController.layers = self.layers;
    
    //Send layer array to content view
    
    ContentViewController *viewController = (ContentViewController*)splitViewController.childViewControllers[1];
    windowController.canvasViewController = viewController;
    [windowController updateCanvasColor:nil];
    viewController.layers = self.layers;
//    viewController.canvasBackgroundColor = _canvasBackgroundColor;
    
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    if (outError) {
        *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
    }
    
    return [NSKeyedArchiver archivedDataWithRootObject:_layers];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    if (outError) {
        *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
    }
    _layers = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return YES;
}


-(CGImageRef)CGImageNamed:(NSString*)name {
    NSImage *testImage = [NSImage imageNamed:@"Moon"];
    
    CGImageSourceRef source;
    
    source = CGImageSourceCreateWithData((CFDataRef)[testImage TIFFRepresentation], NULL);
    CGImageRef maskRef =  CGImageSourceCreateImageAtIndex(source, 0, NULL);
    return maskRef;
}

- (void)setLayers:(NSMutableArray *)layers {
    _layers = layers;
    
    NSWindowController *windowController = (NSWindowController*)self.windowControllers[0];
    NSSplitViewController *splitViewController = (NSSplitViewController*)windowController.window.contentViewController;
    //Send layer array to outline view
    NSSplitViewController *leftSplitViewController = (NSSplitViewController*)splitViewController.childViewControllers[0];
    LayerOutlineViewController *outlineViewController = leftSplitViewController.childViewControllers[0];
    outlineViewController.layers = self.layers;
    
    ContentViewController *viewController = (ContentViewController*)splitViewController.childViewControllers[1];
    viewController.layers = self.layers;
}

- (NSMutableArray *)layers {
    return _layers;
}



@end
