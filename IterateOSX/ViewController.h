//
//  ViewController.h
//  IterateOSX
//
//  Created by James Wilson on 9/6/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property (weak) IBOutlet NSScrollView *scrollView;
@property (strong, nonatomic) NSArray *layers;

- (void) updateEmitterCellProperty:(NSString*)propertyName withValue:(id)value;

@end

