//
//  ViewController.h
//  IterateOSX
//
//  Created by James Wilson on 9/6/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LayerContentViewControllerProtocol.h"

@interface ContentViewController : NSViewController <LayerContentViewControllerProtocol>

@property (weak) IBOutlet NSScrollView *scrollView;
@property (strong, nonatomic) NSArray *layers;
@property (strong) id activeLayer;
@property (strong) id selectedItem;
@property (copy) NSString *keyPathForSelectedItem;
//@property (strong) NSColor *canvasBackgroundColor;


@end

