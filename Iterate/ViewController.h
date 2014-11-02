//
//  ViewController.h
//  Iterate
//
//  Created by James Wilson on 10/11/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainCoordinatorProtocol.h"

@interface ViewController : UIViewController <MainCoordinatorProtocol>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *RightMenuWidthConstraint;

@end

