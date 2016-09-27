//
//  MLChatViewController.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/24.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLChatViewController.h"

@interface MLChatViewController ()
<
EMChatManagerDelegate
>
@end

@implementation MLChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消息";
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
}


#pragma mark - 监听网络状态以及掉线重连效果

- (void)didConnectionStateChanged:(EMConnectionState)connectionState {

    switch (connectionState) {
        case eEMConnectionConnected:
            self.title = @"消息";
            break;
        case eEMConnectionDisconnected:
            self.title = @"消息(未连接)";
            break;
            
        default:
            break;
    }
}
- (void)willAutoReconnect {
    self.title = @"连接中...";

}

- (void)didAutoReconnectFinishedWithError:(NSError *)error {
    if (!error) {
        self.title = @"消息";
    } else {
        self.title = @"消息(未连接)";
    }

}

@end
