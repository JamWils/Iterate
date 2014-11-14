//
//  OutlineTableViewCell.h
//  IterateOSX
//
//  Created by James Wilson on 11/11/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OutlineTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *layerImageView;
@property (weak, nonatomic) IBOutlet UILabel *layerNameLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftIndentationWidthConstraint;

@end
