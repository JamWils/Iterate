//
//  ArrayTableViewDataSourceManager.m
//  IterateOSX
//
//  Created by James Wilson on 11/10/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "ArrayTableViewDataSourceManager.h"

@interface ArrayTableViewDataSourceManager ()

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;
@property (nonatomic, assign) UITableViewMode tableViewMode;

@end

@implementation ArrayTableViewDataSourceManager

- (instancetype)init
{
    return nil;
}

- (instancetype)initWithItems:(NSArray *)anItems
               cellIdentifier:(NSString *)aCellIdentifier
                tableViewMode:(UITableViewMode)mode
           configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock

{
    self = [super init];
    if (self) {
        self.items = anItems;
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = [aConfigureCellBlock copy];
        self.tableViewMode = mode;
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[(NSUInteger) indexPath.row];
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    
    switch (self.tableViewMode) {
        case UITableViewModeNormal:
            rows = self.items.count;
            break;
        case UITableViewModeOutline:
            break;
        default:
            break;
    }
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                            forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    return cell;
}


@end
