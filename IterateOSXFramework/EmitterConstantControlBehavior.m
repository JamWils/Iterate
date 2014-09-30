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
    NSString *newValue = [self stringConstantFromStringTitle:[sender titleOfSelectedItem]];
    [self updateValues:newValue];
    
    if ([[[sender titleOfSelectedItem] lowercaseString] isEqualToString:kCAFilterTrilinear]) {
        [_categoryBehavior changeConstraint:_specialViewHeight toConstant:56.0];
    } else {
        [_categoryBehavior changeConstraint:_specialViewHeight toConstant:0.0];
    }
}

- (void)updateControls:(id)aObject {
    for (NSMenuItem *menuItem in _popUpButton.itemArray) {
        if ([[self stringConstantFromStringTitle:menuItem.title] isEqualToString:[aObject valueForKey:self.emitterProperty]]) {
            [_popUpButton selectItem:menuItem];
            break;
        }
    }
    
}

- (NSString*)stringConstantFromStringTitle:(NSString*)title {
    NSString *constant;
    
    NSUInteger stringLength = [title length];
    title = [title stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (stringLength == [title length]) {
        constant = [title lowercaseString];
    } else {
        constant = [title stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[title substringToIndex:1] lowercaseString]];
    }
    
    return constant;
}


@end
