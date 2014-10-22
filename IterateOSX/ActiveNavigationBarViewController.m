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

@import IterateOSXFramework;

int const DEFAULT_CONSTRAINT_WIDTH = 40;

@import QuartzCore;

@interface ActiveNavigationBarViewController ()

@property (strong, nonatomic) NSArray *buttons;

@end

@implementation ActiveNavigationBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    _buttons = @[_layerMenuButton, _emitterLayerMenuButton, _emitterCellMenuButton];
    [self updateMenuWithSelectedItem:nil];
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
    
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setValue:[self.view.window.windowController parentObject] forKey:@"layer"];
    [[NSNotificationCenter defaultCenter] postNotificationName:kDidChangeSelectedLayerNotification object:self userInfo:userInfo];
}

- (IBAction)EmitterCellButtonSelected:(NSButton *)sender {
    [self toggleButtonsOff:sender];
    NSArray *categoryItems = [CategoryInformation arrayForEmitterCells];
    
    ActivePropertiesViewController *viewController = [self.parentViewController childViewControllers][1];
    [viewController addChildViewControllers:categoryItems];
    
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setValue:[self.view.window.windowController selectedItem] forKey:@"emitterCell"];
    [[NSNotificationCenter defaultCenter] postNotificationName:kDidChangeSelectedEmitterCellNotification object:self userInfo:userInfo];
}

- (void)updateMenuWithSelectedItem:(id)sender {
    NSLayoutConstraint *layerButtonConstraint = [_layerMenuButton.constraints firstObject];
    NSLayoutConstraint *emitterLayerButtonConstraint = [_emitterLayerMenuButton.constraints firstObject];
    NSLayoutConstraint *emitterCellButtonConstraint = [_emitterCellMenuButton.constraints firstObject];
    
    if ([sender isMemberOfClass:[CALayer class]]) {
        layerButtonConstraint.animator.constant = DEFAULT_CONSTRAINT_WIDTH;
        emitterLayerButtonConstraint.animator.constant = 0;
        emitterCellButtonConstraint.animator.constant = 0;
        
        _layerMenuButton.state = NSOnState;
        [self layerButtonSelected:_layerMenuButton];
        
    } else if ([sender isMemberOfClass:[CAEmitterLayer class]]) {
        layerButtonConstraint.animator.constant = DEFAULT_CONSTRAINT_WIDTH;
        emitterLayerButtonConstraint.animator.constant = DEFAULT_CONSTRAINT_WIDTH;
        emitterCellButtonConstraint.animator.constant = 0;
        
        _emitterLayerMenuButton.state = NSOnState;
        [self emitterLayerButtonSelected:_emitterLayerMenuButton];
        
    } else if ([sender isKindOfClass:[CAEmitterCell class]]) {
        layerButtonConstraint.animator.constant = DEFAULT_CONSTRAINT_WIDTH;
        emitterLayerButtonConstraint.animator.constant = DEFAULT_CONSTRAINT_WIDTH;
        emitterCellButtonConstraint.animator.constant = DEFAULT_CONSTRAINT_WIDTH;
        
        _emitterCellMenuButton.state = NSOnState;
        [self EmitterCellButtonSelected:_emitterCellMenuButton];
    } else {
        layerButtonConstraint.constant = 0;
        emitterLayerButtonConstraint.constant = 0;
        emitterCellButtonConstraint.constant = 0;
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
