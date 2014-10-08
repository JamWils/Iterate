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

@end

@implementation ActiveNavigationBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (IBAction)layerButtonSelected:(NSButton *)sender {
}

- (IBAction)emitterLayerButtonSelected:(NSButton *)sender {
}

- (IBAction)EmitterCellButtonSelected:(NSButton *)sender {
//    sender.enabled = NO;
    NSArray *categoryItems = @[
            [[CategoryInformation alloc] initWithStoryboardIdentifier:@"EmitterCellMainViewController" height:190],
            [[CategoryInformation alloc] initWithStoryboardIdentifier:@"EmitterCellColorViewController" height:366],
            [[CategoryInformation alloc] initWithStoryboardIdentifier:@"EmitterCellVisualViewController" height:340],
            [[CategoryInformation alloc] initWithStoryboardIdentifier:@"EmitterCellMotionViewController" height:341],
            [[CategoryInformation alloc] initWithStoryboardIdentifier:@"EmitterCellTemporalViewController" height:510]
                       ];
    
    ActivePropertiesViewController *viewController = [self.parentViewController childViewControllers][1];
    [viewController addChildViewControllers:categoryItems];
}
@end
