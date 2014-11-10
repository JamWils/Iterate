//
//  IterateInsertViewController.h
//  IterateOSX
//
//  Created by James Wilson on 11/1/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IterateInsertViewControllerProtocol.h"

@interface IterateInsertViewController : UIViewController <IterateInsertViewControllerProtocol>

@property (weak) IBOutlet UIButton *addLayerButton;
@property (weak) IBOutlet UIButton *addTransformLayerButton;
@property (weak) IBOutlet UIButton *addEmitterLayerButton;
@property (weak) IBOutlet UIButton *addEmitterCellButton;

@end
