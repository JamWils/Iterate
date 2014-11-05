//
//  IterateInsertSharedViewController.h
//  IterateOSX
//
//  Created by James Wilson on 10/31/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainCoordinatorProtocol.h"
@import QuartzCore;

@interface IterateInsertSharedViewController : NSObject

- (instancetype)initWithCoordinator:(id<MainCoordinatorProtocol>)coordinator layers:(NSMutableArray*)layers selectedItem:(id)selectedItem canvasBounds:(CGRect)canvasBounds;

@property (strong) id document;
@property (strong) id selectedItem;
@property (strong) id<MainCoordinatorProtocol> parentWindow;
@property (strong) NSMutableArray *layers;

@property CGRect canvasBounds;

- (void)addEmitterLayer:(id)sender;
- (void)addEmitterCell:(id)sender;
- (void)addLayer:(id)sender;
- (void)addTransformLayer:(id)sender;



@end
