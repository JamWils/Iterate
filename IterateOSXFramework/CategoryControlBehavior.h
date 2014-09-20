//
//  CategoryControlBehavior.h
//  IterateOSX
//
//  Created by James Wilson on 9/18/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "CustomBehaviors.h"

IB_DESIGNABLE
@interface CategoryControlBehavior : CustomBehaviors

@property (nonatomic, weak) IBOutlet NSTextField *categoryLabel;

@property (nonatomic) IBInspectable NSString *categoryName;
@property (nonatomic) IBInspectable int defaultHeight;

@end
