//
//  MLFriendsTableViewCell.h
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/24.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLFriendsTableViewCell : UITableViewCell

@property (nonatomic, strong) EMBuddy *buddy;

+(instancetype)ml_friendsTableViewCellWithTableView:(UITableView *)tableView;

@end
