//
//  ContainerLayoutView.h
//  IterateOSX
//
//  Created by James Wilson on 9/20/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ContainerLayoutView : NSView

@property (assign) NSLayoutConstraint *containerHeight;
@property (assign) NSLayoutConstraint *scrollViewDocumentHeight;

@property (assign) NSString *testProperty;
@property (assign) NSLayoutConstraint *testConstraint;

@end
