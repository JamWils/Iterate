//
//  HeaderView.m
//  IterateOSX
//
//  Created by James Wilson on 10/21/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView ()

@property (strong, nonatomic) NSTrackingArea *trackingArea;
@property (weak) IBOutlet NSButton *hideButton;

@end

@implementation HeaderView

- (void)awakeFromNib {
    _hideButton.animator.alphaValue = 0.0;
}

- (void)updateTrackingAreas
{
    [self removeTrackingArea:self.trackingArea];
    self.trackingArea = [[NSTrackingArea alloc] initWithRect:CGRectZero
                                                     options:NSTrackingMouseEnteredAndExited|NSTrackingInVisibleRect|NSTrackingActiveInActiveApp
                                                       owner:self
                                                    userInfo:nil];
    [self addTrackingArea:self.trackingArea];
}

- (void) mouseEntered:(NSEvent*)theEvent {
    _hideButton.animator.alphaValue = 1.0;
}

- (void) mouseExited:(NSEvent*)theEvent {
    _hideButton.animator.alphaValue = 0.0;
}

@end
