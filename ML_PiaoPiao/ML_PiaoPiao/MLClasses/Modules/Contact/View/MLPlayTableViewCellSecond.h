//
//  MLPlayTableViewCellSecond.h
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/10/9.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLPlayTableViewCellSecond : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *cellBackView;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *readNum;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *bigImage;

@end
