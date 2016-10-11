//
//  MLSetTableViewController.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/24.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLSetTableViewController.h"
#import "MLMainViewController.h"
#import "NSObject+MLClear.h"
@interface MLSetTableViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *daySwitch;
@property (weak, nonatomic) IBOutlet UIImageView *dayImage;

@property (weak, nonatomic) IBOutlet UILabel *sizeOfCaches;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *clearLabel;
@property (weak, nonatomic) IBOutlet UILabel *backLabel;
@property (weak, nonatomic) IBOutlet UITableViewCell *firstCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *secondCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *ThirdCell;


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
    
    self.title = @"设置";
    
    if ([[JXLDayAndNightManager shareManager] contentMode] == JXLDayAndNightModeDay) {
        self.daySwitch.on = NO;
        self.dayImage.image = [UIImage imageNamed:@"night.png"];
    } else {
        self.daySwitch.on = YES;
        self.dayImage.image = [UIImage imageNamed:@"day.png"];
    }
    
    

    [self.view ml_setbackViewDayAndNight];
    [self.firstCell ml_setFrontViewDayAndNight];
    self.firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.secondCell ml_setFrontViewDayAndNight];
    [self.ThirdCell ml_setFrontViewDayAndNight];
    [self.dayLabel ml_setLabelDayAndNight];
    [self.clearLabel ml_setLabelDayAndNight];
    [self.backLabel ml_setLabelDayAndNight];
    [self.sizeOfCaches ml_setLabelDayAndNight];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    [NSObject getFileCacheSizeWithPath:[NSObject cachePath] completion:^(NSInteger total) {
        self.sizeOfCaches.text = [NSString stringWithFormat:@"%.2fM",total / 1024.0 / 1024.0];
    }];
    
}






- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {


    if (indexPath.section == 1) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"确定要删除%@M缓存么", self.sizeOfCaches.text] message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [NSObject removeCacheWithCompletion:^{
                self.sizeOfCaches.text = @"0.00M";
            }];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
    
    
    
    
    
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


- (IBAction)dayAndNightSwitch:(UISwitch *)sender {
    if (sender.on) {
        self.dayImage.image = [UIImage imageNamed:@"day.png"];
        [[JXLDayAndNightManager shareManager] nightMode];
    } else {
        self.dayImage.image = [UIImage imageNamed:@"night.png"];
        [[JXLDayAndNightManager shareManager] dayMode];
    }
}



@end
