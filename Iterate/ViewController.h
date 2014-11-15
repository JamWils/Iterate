//
//  ViewController.h
//  Iterate
//
//  Created by James Wilson on 10/11/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainCoordinatorProtocol.h"
@class IterateCanvasViewController;
@class IterateOutlineViewController;

@interface ViewController : UIViewController <MainCoordinatorProtocol>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *RightMenuWidthConstraint;

@property (strong, nonatomic) IterateCanvasViewController *canvasViewController;
@property (strong, nonatomic) IterateOutlineViewController *outlineViewController;
@property (strong, nonatomic) id document;

@end

