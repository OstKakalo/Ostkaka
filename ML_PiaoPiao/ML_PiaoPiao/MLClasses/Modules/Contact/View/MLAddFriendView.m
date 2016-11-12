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

@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (weak, nonatomic) IBOutlet UIView *smallView;

@end

@implementation MLAddFriendView


- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    [self.smallView ml_setFrontViewDayAndNight];
    [self ml_setbackViewDayAndNight];
    [self.message jxl_setDayMode:^(UIView *view) {
        view.backgroundColor = [UIColor whiteColor];
        ((UITextField *)view).textColor = ColorWith51Black;
    } nightMode:^(UIView *view) {
        view.backgroundColor = ColorWith51Black;
        ((UITextField *)view).textColor = ColorWith243;
        [((UITextField *)view) setValue:[UIColor colorWithRed:200 / 255.f green:200 / 255.f blue:200 / 255.f alpha:1] forKeyPath:@"placeholderLabel.textColor"];
    }];
    
    [self.username jxl_setDayMode:^(UIView *view) {
        view.backgroundColor = [UIColor whiteColor];
        ((UITextField *)view).textColor = ColorWith51Black;
    } nightMode:^(UIView *view) {
        view.backgroundColor = ColorWith51Black;
        ((UITextField *)view).textColor = ColorWith243;
        [((UITextField *)view) setValue:[UIColor colorWithRed:200 / 255.f green:200 / 255.f blue:200 / 255.f alpha:1] forKeyPath:@"placeholderLabel.textColor"];
    }];
    
    [self.addButton jxl_setDayMode:^(UIView *view) {
        view.backgroundColor = [UIColor whiteColor];
        [((UIButton *)view) setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
    } nightMode:^(UIView *view) {
        view.backgroundColor = ColorWith51Black;
        [((UIButton *)view) setTitleColor:ColorWith243 forState:UIControlStateNormal ];
    }];
    
    
}


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
