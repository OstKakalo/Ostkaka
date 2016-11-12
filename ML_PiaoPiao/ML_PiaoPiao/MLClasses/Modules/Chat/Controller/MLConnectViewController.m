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


@property (nonatomic, strong) UIButton *rejectButton;
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;

@property (weak, nonatomic) IBOutlet UILabel *agreeLabel;
@property (nonatomic, strong) UILabel *rejectLabel;
@property (weak, nonatomic) IBOutlet UILabel *askLabel;
@property (weak, nonatomic) IBOutlet UILabel *callTimeLbl;

@property (nonatomic,assign)int time;
/** timer */
@property (nonatomic, weak) NSTimer *timer;


@end

@implementation MLConnectViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[EaseMob sharedInstance].callManager addDelegate:self delegateQueue:nil];
    
    self.username.text = self.callSession.sessionChatter;
    
    
    
    self.rejectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_rejectButton];
    _rejectButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 130, [UIScreen mainScreen].bounds.size.height - 80, 50, 50);
    [_rejectButton setImage:[UIImage imageNamed:@"acceptPhone.png"] forState:UIControlStateNormal];
    [_rejectButton addTarget:self action:@selector(reject:) forControlEvents:UIControlEventTouchUpInside];
    
    

    
    self.rejectLabel = [[UILabel alloc] init];
    [self.view addSubview:_rejectLabel];
    _rejectLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 130,  [UIScreen mainScreen].bounds.size.height - 30, 50, 30);
    _rejectLabel.textAlignment = NSTextAlignmentCenter;
    _rejectLabel.text = @"挂断";
    _rejectLabel.textColor = [UIColor whiteColor];
    _rejectLabel.font = [UIFont systemFontOfSize:12.f];
    
    
    
}

#pragma mark - 点击事件
- (IBAction)agree:(id)sender {
    
    EMError *error = [[EaseMob sharedInstance].callManager asyncAnswerCall:self.callSession.sessionId];
    
    // NSLog(@"%@", error);

    
}
- (IBAction)reject:(id)sender {
    
    [self.timer invalidate];
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
        } completion:^(BOOL finished) {
            self.askLabel.text = @"通话中...";
        }];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(callTime) userInfo:nil repeats:YES];
     
    }

}


- (void)callTime
{
    // NSLog(@"====%d",self.time);
    self.time ++;
    
    //    0:0:01
    int hour = self.time/3600;//获取小时
    int min = (self.time - hour*3600)/60;//分钟
    int sec = self.time - hour*3600 - min * 60;//秒
    
    // NSLog(@"%d %d %d",hour,min,sec);
    NSString *timeLblStr = nil;
    if (hour > 0) {
        timeLblStr = [NSString stringWithFormat:@"%d:%d:%d",hour,min,sec];
    }else if(min > 0){
        timeLblStr = [NSString stringWithFormat:@"0:%d:%02d",min,sec];
    }else{
        // 保证数字是两位  如果不满足两位 那么用0来填补
        timeLblStr = [NSString stringWithFormat:@"0:0:%02d",sec];
        
    }
    self.callTimeLbl.text = timeLblStr;
}

- (void)dealloc
{
    [[EaseMob sharedInstance].callManager removeDelegate:self];
}

@end
