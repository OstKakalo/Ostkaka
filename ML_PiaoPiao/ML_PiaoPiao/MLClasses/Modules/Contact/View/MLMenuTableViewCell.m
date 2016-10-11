//
//  MLMenuTableViewCell.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/24.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLMenuTableViewCell.h"
#import "MLNewFriendViewController.h"
#import "MLPlayViewController.h"

@interface MLMenuTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *friendLabel;
@property (weak, nonatomic) IBOutlet UILabel *playLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsLabel;

@end

@implementation MLMenuTableViewCell

- (void)awakeFromNib {

    [super awakeFromNib];
    
    [self.friendLabel ml_setLabelDayAndNight];
    [self.newsLabel ml_setLabelDayAndNight];
    [self.playLabel ml_setLabelDayAndNight];
}

- (IBAction)friendButton:(id)sender {
    
    MLNewFriendViewController *newFriend = [[MLNewFriendViewController alloc] init];
    [[self viewController].navigationController pushViewController:newFriend animated:YES];
    
    
}

- (IBAction)playButton:(id)sender {
    MLPlayViewController *playVC = [[MLPlayViewController alloc] init];
    [[self viewController].navigationController pushViewController:playVC animated:YES];
    
}


- (IBAction)newsButton:(id)sender {
    
    
}


+(instancetype)ml_menuTableViewCellWithTableView:(UITableView *)tableView {
 
    static NSString *MenuID = nil;
    if (!MenuID) {
        MenuID = @"MenuID";
    }
  
    id cell = [tableView dequeueReusableCellWithIdentifier:MenuID];
    if (!cell) {
        cell = MYXIB;
    }
    return cell;

}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


@end
