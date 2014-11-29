//
//  ArrayTableViewDataSourceManager.h
//  IterateOSX
//
//  Created by James Wilson on 11/10/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

@import UIKit;
@import Foundation;

typedef void (^TableViewCellConfigureBlock)(id cell, id item);

typedef NS_ENUM(NSUInteger, UITableViewMode) {
    UITableViewModeNormal = 0,
    UITableViewModeOutline = 1
};

@interface ArrayTableViewDataSourceManager : NSObject <UITableViewDataSource>

- (instancetype)initWithItems:(NSArray *)anItems
               cellIdentifier:(NSString *)aCellIdentifier
                tableViewMode:(UITableViewMode)mode
           configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
