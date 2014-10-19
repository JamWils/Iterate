//
//  ActiveNavigationBarViewController.m
//  IterateOSX
//
//  Created by James Wilson on 10/8/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "ActiveNavigationBarViewController.h"
#import "CategoryInformation.h"
#import "ActivePropertiesViewController.h"
#import "IterateWindowController.h"

@import QuartzCore;

@interface ActiveNavigationBarViewController ()

@property (strong, nonatomic) NSArray *buttons;

@end

@implementation ActiveNavigationBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    _buttons = @[_layerMenuButton, _emitterLayerMenuButton, _emitterCellMenuButton];
}

- (IBAction)layerButtonSelected:(NSButton *)sender {
    [self toggleButtonsOff:sender];
    NSArray *categoryItems = [CategoryInformation arrayForLayer];
    
    ActivePropertiesViewController *viewController = [self.parentViewController childViewControllers][1];
    [viewController addChildViewControllers:categoryItems];
}

- (IBAction)emitterLayerButtonSelected:(NSButton *)sender {
    [self toggleButtonsOff:sender];
    NSArray *categoryItems = [CategoryInformation arrayForEmitterLayer];
    
    ActivePropertiesViewController *viewController = [self.parentViewController childViewControllers][1];
    [viewController addChildViewControllers:categoryItems];
}

- (IBAction)EmitterCellButtonSelected:(NSButton *)sender {
    [self toggleButtonsOff:sender];
    NSArray *categoryItems = [CategoryInformation arrayForEmitterCells];
    
    ActivePropertiesViewController *viewController = [self.parentViewController childViewControllers][1];
    [viewController addChildViewControllers:categoryItems];
}

- (void)updateMenuWithSelectedItem:(id)sender {
    NSLayoutConstraint *layerButtonConstraint = [_layerMenuButton.constraints firstObject];
    NSLayoutConstraint *emitterLayerButtonConstraint = [_emitterLayerMenuButton.constraints firstObject];
    NSLayoutConstraint *emitterCellButtonConstraint = [_emitterCellMenuButton.constraints firstObject];
    
    if ([sender isMemberOfClass:[CALayer class]]) {
        layerButtonConstraint.animator.constant = 40;
        emitterLayerButtonConstraint.animator.constant = 0;
        emitterCellButtonConstraint.animator.constant = 0;
        
    } else if ([sender isMemberOfClass:[CAEmitterLayer class]]) {
        layerButtonConstraint.animator.constant = 40;
        emitterLayerButtonConstraint.animator.constant = 40;
        emitterCellButtonConstraint.animator.constant = 0;
        
    } else if ([sender isKindOfClass:[CAEmitterCell class]]) {
        layerButtonConstraint.animator.constant = 40;
        emitterLayerButtonConstraint.animator.constant = 40;
        emitterCellButtonConstraint.animator.constant = 40;
    }
}

- (void)toggleButtonsOff:(NSButton*)skipButton {
    NSArray *buttons = @[_layerMenuButton, _emitterLayerMenuButton, _emitterCellMenuButton];
    
    [buttons enumerateObjectsUsingBlock:^(NSButton *button, NSUInteger idx, BOOL *stop) {
        if (button != skipButton && button.state == NSOnState) {
            button.state = NSOffState;
        }
    }];
}
@end
