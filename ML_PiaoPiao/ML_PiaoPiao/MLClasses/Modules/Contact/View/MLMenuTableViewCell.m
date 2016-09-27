//
//  MLMenuTableViewCell.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/24.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLMenuTableViewCell.h"
#import "MLNewFriendViewController.h"


@interface MLMenuTableViewCell ()

@end

@implementation MLMenuTableViewCell

- (IBAction)friendButton:(id)sender {
    
    MLNewFriendViewController *newFriend = [[MLNewFriendViewController alloc] init];
    [[self viewController].navigationController pushViewController:newFriend animated:YES];
    
    
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
