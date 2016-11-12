//
//  MLMeViewController.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/23.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLMeViewController.h"
#import "MLSetTableViewController.h"
#import "TouchIDManager.h"
#import "MLServerListViewController.h"
#import "MLBlackNameViewController.h"
@interface MLMeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *username;

@property (weak, nonatomic) IBOutlet UILabel *vipLabel;

//@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *photoLabel;

@property (weak, nonatomic) IBOutlet UILabel *setLabel;

@property (weak, nonatomic) IBOutlet UITableViewCell *firstCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *secondCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *thridCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *fourthCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *fifthCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *sixthCell;

@end

@implementation MLMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.title = @"我";
    self.username.text = [[EaseMob sharedInstance].chatManager loginInfo][@"username"];
    [self.view ml_setbackViewDayAndNight];
    [self.username ml_setLabelDayAndNight];
    [self.setLabel ml_setLabelDayAndNight];
    [self.vipLabel ml_setLabelDayAndNight];
//    [self.moneyLabel ml_setLabelDayAndNight];
    [self.photoLabel ml_setLabelDayAndNight];
    [self.sixthCell.textLabel ml_setLabelDayAndNight];
    
    [self.firstCell ml_setFrontViewDayAndNight];
    [self.secondCell ml_setFrontViewDayAndNight];
//    [self.thridCell ml_setFrontViewDayAndNight];
    [self.fourthCell ml_setFrontViewDayAndNight];
    [self.fifthCell ml_setFrontViewDayAndNight];
    [self.sixthCell ml_setFrontViewDayAndNight];
    self.firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.secondCell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.thridCell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.fourthCell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.fifthCell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.sixthCell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
}

+ (instancetype)ml_meViewController {
    return MYSTORYBOARD;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {

            MLBlackNameViewController *blackVC = [[MLBlackNameViewController alloc] init];
            [self.navigationController pushViewController:blackVC animated:YES];
            
            
            
        } else if(indexPath.row == 1){
            
//            BOOL b =  [TouchIDManager sharedManager].canUseTouchId;
//            
//            if (b) {
//                
//                [[TouchIDManager sharedManager] touchIDWithlocalizedFallbackTitle:nil localizedReason:@"钱包" success:^(BOOL success, NSError *error) {
//                    
//                    [self presentViewController:[MLAlert ml_alertControllerWithDefailDevelop] animated:YES completion:nil];
//                }];
//                
//            } else {
//                
//                
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"不支持指纹识别，要输入密码，请期待后续开发" message:nil preferredStyle:UIAlertControllerStyleAlert];
//                [alert addAction:[UIAlertAction actionWithTitle:@"很期待!!" style:UIAlertActionStyleDefault handler:nil]];
//                [self presentViewController:alert animated:YES completion:nil];
//            
//            }
            
            
            
        
        }
    }
    
    if (indexPath.section == 2) {
//        [self presentViewController:[MLAlert ml_alertControllerWithDefailDevelop] animated:YES completion:nil];
        
        
        
    }
    
    if(indexPath.section == 3) {
        MLSetTableViewController *setTableVC = [MLSetTableViewController ml_setTableViewController];
        
        [self.navigationController pushViewController:setTableVC animated:YES];
        
        
    }
    
    if (indexPath.section == 4) {
        // 服务条款
        MLServerListViewController *serverList = [[MLServerListViewController alloc] init];
        serverList.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:serverList animated:YES];
        
    }
    

}
@end
