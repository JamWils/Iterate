//
//  EmitterConstantControlBehavior.h
//  IterateOSX
//
//  Created by James Wilson on 9/21/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "EmitterControlBehavior.h"
@class CategoryControlBehavior;

IB_DESIGNABLE
@interface EmitterConstantControlBehavior : EmitterControlBehavior

@property (weak) IBOutlet NSTextField *label;
@property (weak) IBOutlet NSPopUpButton *popUpButton;
@property (weak) IBOutlet NSLayoutConstraint *specialViewHeight;
@property (weak) IBOutlet CategoryControlBehavior *categoryBehavior;

- (IBAction)updateSelected:(NSPopUpButton *)sender;

@end
