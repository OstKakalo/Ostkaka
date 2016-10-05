//
//  MLTabBarViewController.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/23.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLTabBarViewController.h"
#import "MLChatViewController.h"
#import "MLContactViewController.h"

#import "MLMeViewController.h"
#import "MLNavigationController.h"

#import "MLNewFriendViewController.h"
#import "MLRequestInfo.h"
@interface MLTabBarViewController ()
<
EMChatManagerDelegate
>

@property (nonatomic, strong) NSMutableArray *requestInfoArray;
@end

@implementation MLTabBarViewController

- (NSMutableArray *)requestInfoArray {

    if (!_requestInfoArray) {
        _requestInfoArray = [NSMutableArray array];
        
    }
    return _requestInfoArray;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        MLChatViewController *chatVC = [[MLChatViewController alloc] init];
        MLNavigationController *chatNav = [[MLNavigationController alloc] initWithRootViewController:chatVC];
        MLContactViewController *contactVC = [[MLContactViewController alloc] init];
        MLNavigationController *contactNav = [[MLNavigationController alloc] initWithRootViewController:contactVC];
        MLMeViewController *meVC = [MLMeViewController ml_meViewController];
        MLNavigationController *meNav = [[MLNavigationController alloc] initWithRootViewController: meVC];
        
        
        
        
        self.viewControllers = @[chatNav,contactNav,meNav];
        
        chatNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"消息" image:[UIImage imageNamed:@"chat"] selectedImage:[UIImage imageNamed:@"chat-s"]];
        contactNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"联系人" image:[UIImage imageNamed:@"contect"] selectedImage:[UIImage imageNamed:@"contect-s"]];

        meNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"me"] selectedImage:[UIImage imageNamed:@"me-s"]];
        
        self.tabBar.barTintColor = [UIColor blackColor];
        self.tabBar.tintColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
    
    
}



#pragma mark - 监控好友请求
// 监控好友请求
- (void)didReceiveBuddyRequest:(NSString *)username
                       message:(NSString *)message {
    
    
    
    
    
    
    MLRequestInfo *requestInfo = [[MLRequestInfo alloc] init];
    requestInfo.username = username;
    requestInfo.message = message;
    [self.requestInfoArray addObject:requestInfo];
    
    
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@想要添加您为好友",username] message:[NSString stringWithFormat:@"%@",message] preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道啦" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //
        MLNewFriendViewController *newFriendVC = [[MLNewFriendViewController alloc] init];
        newFriendVC.requestArray = _requestInfoArray;
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"去看看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //
        MLNewFriendViewController *newFriendVC = [[MLNewFriendViewController alloc] init];
        newFriendVC.requestArray = _requestInfoArray;
        self.selectedViewController = self.viewControllers[1];
        [(UINavigationController *)self.viewControllers[1] pushViewController:newFriendVC animated:YES];
        
        
        
        
        
        
    }];
    [alert addAction:action1];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
    
}



@end
