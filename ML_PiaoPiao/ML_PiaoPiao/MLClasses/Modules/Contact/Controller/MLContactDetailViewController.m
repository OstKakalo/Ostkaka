//
//  MLContactDetailViewController.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/25.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLContactDetailViewController.h"
#import "MLDetailChatViewController.h"
#import "MLTabBarViewController.h"
@interface MLContactDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *username;

@end

@implementation MLContactDetailViewController

+ (instancetype)ml_contactDetailVC {

    return MYSTORYBOARD;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    [self ml_createButton];
    
    _username.text = self.buddy.username;
}





#pragma mark - 私有方法
- (void)ml_createButton {
    CGFloat viewW = self.view.bounds.size.width;
  
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewW, 200)];
    self.tableView.tableFooterView = footView;
    
    UIButton *sendMsgButton = [[UIButton alloc] init];
    [sendMsgButton addTarget:self action:@selector(ml_sendMsg) forControlEvents:UIControlEventTouchUpInside];
    sendMsgButton.backgroundColor = [UIColor greenColor];
    [sendMsgButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendMsgButton setTitle:@"发消息" forState:UIControlStateNormal];
    sendMsgButton.frame = CGRectMake(30, 0, viewW - 60, 50);
    sendMsgButton.layer.cornerRadius = 10;
    [self.view addSubview:sendMsgButton];
    [footView addSubview:sendMsgButton];

}

- (void)ml_sendMsg {
    
    [self.navigationController popViewControllerAnimated:NO];
    
    
    MLTabBarViewController *tabBarVC = [[MLTabBarViewController alloc] init];
    tabBarVC = (MLTabBarViewController *)[[UIApplication sharedApplication].keyWindow rootViewController];
    tabBarVC.selectedViewController = tabBarVC.viewControllers[0];
    MLDetailChatViewController *detailChatVC = [[MLDetailChatViewController alloc] init];
    detailChatVC.buddy = self.buddy;
    [(UINavigationController *)tabBarVC.viewControllers[0] pushViewController:detailChatVC animated:YES];
    
    
    


}


@end
