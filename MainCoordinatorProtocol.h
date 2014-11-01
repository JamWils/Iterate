//
//  MainCoordinatorProtocol.h
//  IterateOSX
//
//  Created by James Wilson on 10/31/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MainCoordinatorProtocol <NSObject>

- (void)distributeLayers:(NSMutableArray*)layers fromViewController:(id)viewController;

@end
