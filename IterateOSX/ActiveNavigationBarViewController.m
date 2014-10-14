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

@interface ActiveNavigationBarViewController ()

@property (strong, nonatomic) NSArray *buttons;

@end

@implementation ActiveNavigationBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _buttons = @[_layerMenuButton, _emitterLayerMenuButton, _emitterCellMenuButton];
}

- (IBAction)layerButtonSelected:(NSButton *)sender {
}

- (IBAction)emitterLayerButtonSelected:(NSButton *)sender {
//    sender.enabled = NO;
    NSArray *categoryItems = [CategoryInformation arrayForEmitterLayer];
    
    ActivePropertiesViewController *viewController = [self.parentViewController childViewControllers][1];
    [viewController addChildViewControllers:categoryItems];
}

- (IBAction)EmitterCellButtonSelected:(NSButton *)sender {
//    sender.enabled = NO;
    NSArray *categoryItems = [CategoryInformation arrayForEmitterCells];
    
    ActivePropertiesViewController *viewController = [self.parentViewController childViewControllers][1];
    [viewController addChildViewControllers:categoryItems];
}
@end
