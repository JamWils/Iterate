//
//  IterateOutlineViewController.m
//  IterateOSX
//
//  Created by James Wilson on 11/10/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "IterateOutlineViewController.h"
#import "OutlineTableViewCell.h"
@import IterateiOSFramework;

@interface IterateOutlineViewController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *outlineTableView;
@property (strong, nonatomic) ArrayTableViewDataSourceManager *dataSourceManager;

@property (strong, nonatomic) OutlineDataManager *outlineDataManager;
@property (strong, nonatomic) OutlineDelegateManager *outlineDelegateManager;

@end

@implementation IterateOutlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _outlineDelegateManager = [[OutlineDelegateManager alloc] initWithParentObjectBlock:nil];
    _dataSourceManager = [[ArrayTableViewDataSourceManager alloc] initWithItems:_layers
                                                                 cellIdentifier:@"Cell"
                                                                  tableViewMode: UITableViewModeNormal
                                                             configureCellBlock:^(OutlineTableViewCell* cell, id item) {
                                                                 cell.layerNameLabel.text = [item name];
                                                                 cell.layerImageView.image = [UIImage imageNamed:[_outlineDelegateManager imageNameForItem:item]];
                                                                 cell.indentationWidth = 40.0;
                                                                 //        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
                                                                 //        cell.leftIndentationWidthConstraint.constant = 100;
                                                             }];
    
    _outlineTableView.dataSource = _dataSourceManager;
    _outlineTableView.delegate = self;
    _outlineTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_outlineTableView setSeparatorInset:UIEdgeInsetsZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

//- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
//    //OutlineTableViewCell *cell = (OutlineTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
//    
//
//    return indexPath.row;
//}

- (void)setLayers:(NSMutableArray *)layers {
    _layers = layers;
    [_dataSourceManager setValue:_layers forKey:@"items"];
    [_outlineTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
