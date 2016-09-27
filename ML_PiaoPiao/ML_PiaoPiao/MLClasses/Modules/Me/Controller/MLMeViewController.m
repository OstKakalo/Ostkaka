//
//  MLMeViewController.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/23.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLMeViewController.h"
#import "MLSetTableViewController.h"

@interface MLMeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *username;

@end

@implementation MLMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.title = @"我";
    self.username.text = [[EaseMob sharedInstance].chatManager loginInfo][@"username"];
    
    
}

+ (instancetype)ml_meViewController {
    return MYSTORYBOARD;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 3) {
        MLSetTableViewController *setTableVC = [MLSetTableViewController ml_setTableViewController];
        
        [self.navigationController pushViewController:setTableVC animated:YES];
        
        
    }
    

}
@end
