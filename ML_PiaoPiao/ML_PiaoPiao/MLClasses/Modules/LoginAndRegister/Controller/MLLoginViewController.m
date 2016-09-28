//
//  MLLoginViewController.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/23.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLLoginViewController.h"
#import "MLTabBarViewController.h"

@interface MLLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *lusername;

@property (weak, nonatomic) IBOutlet UITextField *lpassword;

@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;



@end

@implementation MLLoginViewController


- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@", self);
}






- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 监控键盘
    [self ml_keyBoardMove];
}



- (IBAction)ml_login:(id)sender {
    [self.view endEditing:YES];
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:self.lusername.text password:self.lpassword.text completion:^(NSDictionary *loginInfo, EMError *error) {
        
        if (!error && loginInfo) {
            NSLog(@"登录成功");
            // 设置自动登录
            [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
            
            // 跳转页面
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            MLTabBarViewController *tabBarController = [[MLTabBarViewController alloc]init];
            window.rootViewController = tabBarController;
            
        } else{
        
            NSLog(@"%@", error);
        }
    } onQueue:nil];
}



#pragma mark - 点击任意
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    self.logo.alpha = 0;
    self.titleLabel.alpha = 0;
    
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
            self.logo.alpha = 0;
            self.titleLabel.alpha = 0;
        }];
        
        
    }];
}

@end
