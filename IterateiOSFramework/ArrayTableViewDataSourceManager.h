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

@interface ArrayTableViewDataSourceManager : NSObject <UITableViewDataSource>

- (instancetype)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
