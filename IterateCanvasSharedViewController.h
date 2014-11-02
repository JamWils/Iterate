//
//  IterateCanvasSharedViewController.h
//  IterateOSX
//
//  Created by James Wilson on 11/1/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IterateCanvasSharedViewController : NSObject

@property (strong, nonatomic) NSArray *layers;
@property (strong) id activeLayer;
@property (strong) id selectedItem;
@property (copy) NSString *keyPathForSelectedItem;

@end
