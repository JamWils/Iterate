//
//  EmitterConstantControlBehavior.m
//  IterateOSX
//
//  Created by James Wilson on 9/21/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "EmitterConstantControlBehavior.h"

@implementation EmitterConstantControlBehavior

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _label.stringValue = super.name;
    [self updateSelected:_popUpButton];

}

- (IBAction)updateSelected:(NSPopUpButton *)sender {
    [self updateValues:[[sender titleOfSelectedItem] lowercaseString]];
}


@end
