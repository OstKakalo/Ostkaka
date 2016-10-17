//
//  AppDelegate.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/23.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "AppDelegate.h"
#import "MLMainViewController.h"
#import "MLTabBarViewController.h"
#import "MLLoginViewController.h"
#import "MLMainViewController.h"
#import "MLLeaderViewController.h"
@interface AppDelegate ()
<
EMChatManagerDelegate
>
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
#pragma mark 注册AppKey
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"ostkaka#piaopiao" apnsCertName:nil];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    // 添加代理
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
    
    
    
    // 引导页
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    // 判断是否第一次进入应用
    if (![userDef boolForKey:@"notFirst"]) {
        // 如果第一次，进入引导页
        _window.rootViewController = [[MLLeaderViewController alloc] init];

    }
    else {
        
        
        
        
        // 判断是否自动登录
        BOOL isAutoLogin = [[EaseMob sharedInstance].chatManager isAutoLoginEnabled];
        if (!isAutoLogin) {
            // 不是自动登录状态
            MLMainViewController *mainVC = [[MLMainViewController alloc] init];
            self.window.rootViewController = mainVC;
        } else {
            // 自动登录状态
            [SVProgressHUD showWithStatus:@"自动登录中..."];
            
        }

        
       
        
    }
    
    
    
    

    
    
    


    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
 
    [[EaseMob sharedInstance] applicationWillTerminate:application];
    // 移除代理
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}
# pragma mark - EaseMob代理方法

// 自动登录后
- (void)didAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error{

    [SVProgressHUD dismiss];
    if (error) {
        NSLog(@"%@", error);
    } else {
        MLTabBarViewController *tabBarVC = [[MLTabBarViewController alloc] init];
        self.window.rootViewController = tabBarVC;
    }

}

// 监控另外设备登录被迫下线
- (void)didLoginFromOtherDevice {

    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:NO completion:^(NSDictionary *info, EMError *error) {
        if (!error) {
            
            self.window.rootViewController = [[MLMainViewController alloc] init];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"其他设备登录" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"重新登录" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [alert addAction:action1];
            [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
        }
    } onQueue:nil];

}

// 监控被服务器删除
- (void)didRemovedFromServer {
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:NO completion:^(NSDictionary *info, EMError *error) {
        if (!error) {
            
            self.window.rootViewController = [[MLMainViewController alloc] init];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"违背条约，账号被注销" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
        }
    } onQueue:nil];
}



@end
