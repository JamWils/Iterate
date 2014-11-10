//
//  IterateInsertViewController.m
//  IterateOSX
//
//  Created by James Wilson on 11/1/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "IterateInsertViewController.h"

@interface IterateInsertViewController ()

@end

@implementation IterateInsertViewController

@synthesize sharedViewController = _sharedViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self connectTargetActionsToButtons];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) connectTargetActionsToButtons {
    [_addLayerButton addTarget:self.sharedViewController action:@selector(addLayer:) forControlEvents:UIControlEventTouchUpInside];
    [_addTransformLayerButton addTarget:self.sharedViewController action:@selector(addTransformLayer:) forControlEvents:UIControlEventTouchUpInside];
    [_addEmitterLayerButton addTarget:self.sharedViewController action:@selector(addEmitterLayer:) forControlEvents:UIControlEventTouchUpInside];
    [_addEmitterCellButton addTarget:self.sharedViewController action:@selector(addEmitterCell:) forControlEvents:UIControlEventTouchUpInside];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
