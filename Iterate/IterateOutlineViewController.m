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

@end

@implementation IterateOutlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSArray *testArray = @[@"Test 1", @"Test 2", @"Test 3"];
    _dataSourceManager = [[ArrayTableViewDataSourceManager alloc] initWithItems:testArray cellIdentifier:@"Cell" configureCellBlock:^(OutlineTableViewCell* cell, NSString* item) {
        cell.layerNameLabel.text = item;
        cell.layerImageView.image = [UIImage imageNamed:@"CAEmitterLayerActive Icon"];
        cell.indentationWidth = 40.0;
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
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

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
//    OutlineTableViewCell *cell = (OutlineTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    

    return indexPath.row;
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
