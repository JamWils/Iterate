//
//  LayerContentViewControllerProtocol.h
//  IterateOSX
//
//  Created by James Wilson on 10/1/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LayerContentViewControllerProtocol <NSObject>

- (void) updateEmitterCellProperty:(NSString*)propertyName withValue:(id)value isCellValue:(BOOL)isCellValue;

@end
