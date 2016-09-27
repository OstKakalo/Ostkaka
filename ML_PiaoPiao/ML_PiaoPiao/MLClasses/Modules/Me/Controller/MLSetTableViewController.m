//
//  MLSetTableViewController.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/24.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLSetTableViewController.h"
#import "MLMainViewController.h"
@interface MLSetTableViewController ()

@end

@implementation MLSetTableViewController

+ (instancetype)ml_setTableViewController {
    return MYSTORYBOARD;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    // 记录用户名
    [[NSUserDefaults standardUserDefaults] setObject:[[EaseMob sharedInstance].chatManager loginInfo][@"username"] forKey:@"username"];
    
    if (indexPath.section == 2) {
        [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
            if (!error) {
                NSLog(@"退出成功");
                

                
                // 切换根视图控制器
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                window.rootViewController = [[MLMainViewController alloc] init];
                
            }
        } onQueue:nil];

    }

}

@end
