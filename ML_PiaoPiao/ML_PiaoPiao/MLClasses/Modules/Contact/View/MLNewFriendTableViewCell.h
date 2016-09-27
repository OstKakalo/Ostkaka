//
//  MLNewFriendTableViewCell.h
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/24.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MLRequestInfo;

@interface MLNewFriendTableViewCell : UITableViewCell

+(instancetype) ml_newFriendWithTableView:(UITableView *)tableView ;

@property (nonatomic, strong) MLRequestInfo *requestInfo;

@end
