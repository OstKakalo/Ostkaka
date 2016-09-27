//
//  MLRegisterViewController.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/23.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLRegisterViewController.h"

@interface MLRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *username;

@property (weak, nonatomic) IBOutlet UITextField *password;


@end

@implementation MLRegisterViewController



- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - 点击事件
- (IBAction)ml_register:(id)sender {
    [self.view endEditing:YES];
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:self.username.text password:self.password.text withCompletion:^(NSString *username, NSString *password, EMError *error) {
        if (!error) {
            NSLog(@"注册成功");
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            NSLog(@"%@",error);
        }
    } onQueue:nil];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // 监控键盘
    [self ml_keyBoardMove];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];

}
#pragma mark - 私有方法

- (void)ml_keyBoardMove {
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillChangeFrameNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//        NSLog(@"%@", note);
        /*
         NSConcreteNotification 0x608000251850 {name = UIKeyboardWillChangeFrameNotification; userInfo = {
         UIKeyboardAnimationCurveUserInfoKey = 7;
         UIKeyboardAnimationDurationUserInfoKey = "0.25";
         UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {414, 271}}";
         UIKeyboardCenterBeginUserInfoKey = "NSPoint: {207, 871.5}";
         UIKeyboardCenterEndUserInfoKey = "NSPoint: {207, 600.5}";
         UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 736}, {414, 271}}";
         UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 465}, {414, 271}}";
         UIKeyboardIsLocalUserInfoKey = 1;
         }}
         */
        CGFloat endY = [[note.userInfo valueForKey:@"UIKeyboardFrameEndUserInfoKey" ] CGRectValue].origin.y;
        CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        CGFloat viewY = endY - SCREEN_HEIGHT;
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0, viewY, SCREEN_WIDTH, SCREEN_HEIGHT);
            
        }];
        
        
    }];
}


@end
