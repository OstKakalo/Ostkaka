//
//  MLFriendsTableViewCell.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/24.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLFriendsTableViewCell.h"

@interface MLFriendsTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *username;

@end

@implementation MLFriendsTableViewCell



+(instancetype)ml_friendsTableViewCellWithTableView:(UITableView *)tableView {
    static NSString *FriendsID = nil;
    if (!FriendsID) {
        FriendsID = @"FriendsID";
    }
    
    
    id cell = [tableView dequeueReusableCellWithIdentifier:FriendsID];
    if (!cell) {
        cell = MYXIB;
    }
    
    
    return cell;
    
}
- (void)setBuddy:(EMBuddy *)buddy {
    _buddy = buddy;
    _username.text = _buddy.username;

}

@end
