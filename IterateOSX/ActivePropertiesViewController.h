//
//  IteratePropertiesActiveViewController.h
//  IterateOSX
//
//  Created by James Wilson on 10/5/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ActivePropertiesViewController : NSViewController

@property (weak) IBOutlet NSScrollView *scrollView;

- (void)addChildViewControllers:(NSArray*)categoryItems;

@end
