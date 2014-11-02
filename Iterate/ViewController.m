//
//  ViewController.m
//  Iterate
//
//  Created by James Wilson on 10/11/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _RightMenuWidthConstraint.constant = 0;
    
    UIScreenEdgePanGestureRecognizer *rightEdgeGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(changeRightSizeMenuSize:)];
    rightEdgeGestureRecognizer.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:rightEdgeGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) changeRightSizeMenuSize:(UIScreenEdgePanGestureRecognizer*)gestureRecognizer {
    //gestureRecognizer.
    
    if (_RightMenuWidthConstraint.constant < 250) {
        NSLog(@"%@", NSStringFromCGPoint([gestureRecognizer translationInView:self.view]));
        _RightMenuWidthConstraint.constant = fabsf([gestureRecognizer translationInView:self.view].x);
        
    } 
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"InsertViewControllerSegue"]) {
        //InsertViewController
    }
}

- (void)distributeLayers:(NSMutableArray *)layers fromViewController:(id)viewController {
    
}

@end
