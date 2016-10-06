//
//  MLConnectViewController.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/10/6.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLConnectViewController.h"

@interface MLConnectViewController ()
<
EMCallManagerDelegate
>

@property (weak, nonatomic) IBOutlet UILabel *username;

@property (weak, nonatomic) IBOutlet UIButton *rejectButton;

@property (weak, nonatomic) IBOutlet UIButton *agreeButton;

@property (weak, nonatomic) IBOutlet UILabel *agreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rejectLabel;


@end

@implementation MLConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[EaseMob sharedInstance].callManager addDelegate:self delegateQueue:nil];
    
    self.username.text = self.callSession.sessionChatter;
    
    
}

#pragma mark - 点击事件
- (IBAction)agree:(id)sender {
    EMError *error = [[EaseMob sharedInstance].callManager asyncAnswerCall:self.callSession.sessionId];
    NSLog(@"%@", error);
//    [[EaseMob sharedInstance].callManager markCallSession:self.callSession.sessionId asSilence:NO];
    
}
- (IBAction)reject:(id)sender {
    [[EaseMob sharedInstance].callManager asyncEndCall:self.callSession.sessionId reason:eCallReasonReject];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - 监控状态

- (void)callSessionStatusChanged:(EMCallSession *)callSession
                    changeReason:(EMCallStatusChangedReason)reason
                           error:(EMError *)error {

    
    if (callSession.status == eCallSessionStatusAccepted) {
        
        
        [UIView animateWithDuration:0.5 animations:^{
            self.agreeButton.alpha = 0;
            self.agreeLabel.alpha = 0;
            self.rejectButton.frame = CGRectMake((self.view.bounds.size.width - 50) / 2 , self.view.bounds.size.height - 80, 50, 50);
            self.rejectLabel.frame = CGRectMake((self.view.bounds.size.width - self.rejectLabel.bounds.size.width) / 2, self.view.bounds.size.height - 30, self.rejectLabel.bounds.size.width, self.rejectLabel.bounds.size.height);
        }];
    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
