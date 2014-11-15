//
//  ViewController.m
//  Iterate
//
//  Created by James Wilson on 10/11/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "ViewController.h"
#import "IterateInsertViewController.h"
#import "IterateCanvasViewController.h"
#import "IterateOutlineViewController.h"

@import IterateiOSFramework;

NSString *const kContentCanvasViewControllerSegue = @"ContentCanvasViewControllerSegue";
NSString *const kContentOutlineViewControllerSegue = @"ContentOutlineViewControllerSegue";

@interface ViewController ()

@end

@implementation ViewController

@synthesize selectedItem = _selectedItem;
@synthesize keyPathForSelectedItem = _keyPathForSelectedItem;
@synthesize parentObject = _parentObject;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _RightMenuWidthConstraint.constant = 0;
    IterateDocument *document = [IterateData getIterateDocument];
    self.document = document;
    /*UIScreenEdgePanGestureRecognizer *rightEdgeGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(changeRightSizeMenuSize:)];
    rightEdgeGestureRecognizer.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:rightEdgeGestureRecognizer];*/
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
        IterateInsertViewController *viewController = (IterateInsertViewController*)segue.destinationViewController;
        viewController.sharedViewController = [[IterateInsertSharedViewController alloc] initWithCoordinator:self layers:[[self.document layers] mutableCopy] selectedItem:_selectedItem canvasBounds:_canvasViewController.view.bounds];
    } else if ([segue.identifier isEqualToString:kContentCanvasViewControllerSegue]) {
        _canvasViewController = segue.destinationViewController;
    } else if ([segue.identifier isEqualToString:kContentOutlineViewControllerSegue]) {
        _outlineViewController = segue.destinationViewController;
    }
}

- (void)distributeLayers:(NSMutableArray *)layers fromViewController:(id)viewController {
    _canvasViewController.layers = layers;
    _outlineViewController.layers = layers;
    
    if ([self.document isKindOfClass:[IterateDocument class]]) {
        [self.document setLayers:layers];
    }
}

@end
