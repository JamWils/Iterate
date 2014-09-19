//
//  CategoryControlBehavior.m
//  IterateOSX
//
//  Created by James Wilson on 9/18/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "CategoryControlBehavior.h"

@interface CategoryControlBehavior ()

@property (weak) IBOutlet NSLayoutConstraint *emitterCellPropertyControlHeight;


@end

@implementation CategoryControlBehavior

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (IBAction)toggleHiddenClicked:(NSButton*)sender {
    
    if ([sender.title isEqualToString:@"Hide"]) {
        sender.title = @"Show";
        _emitterCellPropertyControlHeight.animator.constant = 0;
    } else {
        sender.title = @"Hide";
        _emitterCellPropertyControlHeight.animator.constant = 56;
    }
    
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {        
        [self.window layoutIfNeeded];
    } completionHandler:^{
        
    }];
}

@end
