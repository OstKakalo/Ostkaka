//
//  MLAddFrendViewController.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/24.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLAddFrendViewController.h"
#import "MLAddFriendView.h"
@interface MLAddFrendViewController ()




@end

@implementation MLAddFrendViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        MLAddFriendView *addFriendView = [[MLAddFriendView alloc] init];
        self.view = addFriendView;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
}


#pragma mark - 私有方法
//- (void)ml_createThings {
//
//    self.username = [[UITextField alloc] init];
//    [self.view addSubview:_username];
//    [_username mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(50);
//        make.right.equalTo(self).offset(-50);
//        make.
//    }];
//
//}
@end
