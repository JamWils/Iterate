//
//  IterateCanvasViewController.h
//  IterateOSX
//
//  Created by James Wilson on 11/2/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IterateCanvasViewController : UIViewController

@property (strong, nonatomic) NSArray *layers;
@property (strong) id activeLayer;
@property (strong) id selectedItem;
@property (copy) NSString *keyPathForSelectedItem;

@end
