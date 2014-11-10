//
//  IterateCanvasViewController.m
//  IterateOSX
//
//  Created by James Wilson on 11/2/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "IterateCanvasViewController.h"

@interface IterateCanvasViewController ()

@end

@implementation IterateCanvasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLayers:(NSArray *)layers {
    _layers = layers;
    
    //[self.view subviews:[NSArray array]];
    NSArray *viewsToRemove = [self.view subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    
    for (CALayer *layer in _layers) {
        [self.view.layer addSublayer:layer];
    }
    [self.view setNeedsDisplay];
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
