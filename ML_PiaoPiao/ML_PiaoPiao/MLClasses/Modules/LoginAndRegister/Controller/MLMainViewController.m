//
//  MLMainViewController.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/23.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//


#import "MLMainViewController.h"
#import "MLLoginViewController.h"
#import "MLRegisterViewController.h"


@interface MLMainViewController ()

@end

@implementation MLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    
#pragma mark - 注册按钮
    UIButton *regisButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:regisButton];
    [regisButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-30);
        make.left.equalTo(self.view).offset(30);
        make.width.equalTo(@100);
        make.height.equalTo(@45);
    }];
    [regisButton setTitle:@"注册" forState:UIControlStateNormal];
    regisButton.backgroundColor = [UIColor greenColor];
    regisButton.layer.cornerRadius = 10.0;
    [regisButton addTarget:self action:@selector(ml_registerAction:) forControlEvents:UIControlEventTouchUpInside];
    
#pragma mark - 登录按钮
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-30);
        make.right.equalTo(self.view).offset(-30);
        make.width.equalTo(@100);
        make.height.equalTo(@45);
    }];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    loginButton.backgroundColor = [UIColor whiteColor];
    loginButton.layer.cornerRadius = 10.0;
    [loginButton addTarget:self action:@selector(ml_loginButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
}




#pragma mark - 私有方法
- (void)ml_registerAction:(UIButton *)button {
    MLRegisterViewController *registerVC = [[MLRegisterViewController alloc] init];
    [self presentViewController:registerVC animated:YES completion:nil];
    
}
 
- (void)ml_loginButton:(UIButton *)button {
    MLLoginViewController *loginVC = [[MLLoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
}

@end
