//
//  MLAddFriendView.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/24.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLAddFriendView.h"



@interface MLAddFriendView ()
@property (weak, nonatomic) IBOutlet UITextField *username;

@property (weak, nonatomic) IBOutlet UITextField *message;

@end

@implementation MLAddFriendView


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        
        self = MYXIB;
  
    }
    return self;
}


#pragma mark - 私有方法

- (IBAction)ml_add:(id)sender {
    EMError *error = nil;
    BOOL isSuccess = [[EaseMob sharedInstance].chatManager addBuddy:self.username.text message:self.message.text error:&error];
    if (isSuccess && !error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请求发送成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        
        [[self ml_viewController] presentViewController:alert animated:YES completion:nil];
        
    }
}

// 为了避免循环引用 找到自身controller
- (UIViewController *)ml_viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


@end
