//
//  IterateCanvasSharedViewController.m
//  IterateOSX
//
//  Created by James Wilson on 11/1/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "IterateCanvasSharedViewController.h"
@import QuartzCore;

@implementation IterateCanvasSharedViewController

- (void) updateEmitterCellProperty:(NSString*)propertyName withValue:(id)value isCellValue:(BOOL)isCellValue {
    if (_activeLayer) {
        if ([_selectedItem isKindOfClass:[CAEmitterCell class]]  && isCellValue) {
            NSString *keyPath = [NSString stringWithFormat:@"%@%@", _keyPathForSelectedItem, propertyName];
            [_activeLayer setValue:value forKeyPath:keyPath];
        } else {
            [_activeLayer setValue:value forKeyPath:propertyName];
        }
        
//        self.userActivity.needsSave = YES;
    }
    
}

@end
