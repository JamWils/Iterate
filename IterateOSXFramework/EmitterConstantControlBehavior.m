//
//  EmitterConstantControlBehavior.m
//  IterateOSX
//
//  Created by James Wilson on 9/21/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "EmitterConstantControlBehavior.h"
#import "CategoryControlBehavior.h"

@implementation EmitterConstantControlBehavior

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _label.stringValue = super.name;
    [self updateSelected:_popUpButton];

}

- (IBAction)updateSelected:(NSPopUpButton *)sender {
    [self updateValues:[[sender titleOfSelectedItem] lowercaseString]];
    
    if ([[[sender titleOfSelectedItem] lowercaseString] isEqualToString:kCAFilterTrilinear]) {
        [_categoryBehavior changeConstraint:_specialViewHeight toConstant:56.0];
    } else {
        [_categoryBehavior changeConstraint:_specialViewHeight toConstant:0.0];
    }
}


@end
