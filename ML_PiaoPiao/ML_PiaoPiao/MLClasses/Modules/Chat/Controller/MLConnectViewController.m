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
EMCallManagerDelegate,
AVCaptureMetadataOutputObjectsDelegate
>

@property (weak, nonatomic) IBOutlet UILabel *username;

@property (weak, nonatomic) IBOutlet UIButton *rejectButton;

@property (weak, nonatomic) IBOutlet UIButton *agreeButton;

@property (weak, nonatomic) IBOutlet UILabel *agreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rejectLabel;




//@property (nonatomic, strong)AVCaptureDevice *device;
//
//@property (nonatomic, strong)AVCaptureDeviceInput *input;
//
//@property (nonatomic, strong)AVCaptureMetadataOutput *output;
//// 输入输出中间的桥梁
//@property (nonatomic, strong)AVCaptureSession *session;
//
//@property (nonatomic, assign) BOOL hasCameraRight;
//
//@property (nonatomic, strong)AVCaptureVideoPreviewLayer *preview;
@end

@implementation MLConnectViewController

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    if (_hasCameraRight) {
//        if (_session && ![_session isRunning]) {
//            [_session startRunning];
//        }
//        
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[EaseMob sharedInstance].callManager addDelegate:self delegateQueue:nil];
    
    self.username.text = self.callSession.sessionChatter;
    
    
    
    
    
//    // 获取相机授权状态
//    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//    
//    // 对相机授权状态判断
//    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
//        
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"没有相机权限" message:@"请去设置-隐私-相机中对爱儿邦授权" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self.navigationController popViewControllerAnimated:YES];
//        }];
//        [alertController addAction:okAction];
//        
//        _hasCameraRight = NO;
//        return;
//    }
//    _hasCameraRight = YES;
//    

    
//    [self setupCamera];
}







#pragma mark - 点击事件
- (IBAction)agree:(id)sender {
    
    EMError *error = [[EaseMob sharedInstance].callManager asyncAnswerCall:self.callSession.sessionId];
    
    NSLog(@"%@", error);

    
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
// 设置相机
//- (void)setupCamera
//{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        // 耗时的操作
//        // 获取摄像设备
//        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//        
//        // 创建输入流
//        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
//        
//        // 创建输出流
//        _output = [[AVCaptureMetadataOutput alloc]init];
//        
//        // 设置代理，在主线程里刷新
//        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
//        
//        // 初始化链接对象
//        _session = [[AVCaptureSession alloc]init];
//        
//        // 高质量采集率
//        [_session setSessionPreset:AVCaptureSessionPresetHigh];
//        
//        if ([_session canAddInput:self.input])
//        {
//            [_session addInput:self.input];
//        }
//        
//        if ([_session canAddOutput:self.output])
//        {
//            [_session addOutput:self.output];
//        }
//        // 条码类型 AVMetadataObjectTypeQRCode
//        _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // 更新界面
//            // Preview
//            _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
//            _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
//            _preview.frame =CGRectMake(48,110,280,280);
//            //            _preview.frame = self.view.bounds;
//            [self.view.layer insertSublayer:self.preview atIndex:0];
//            // Start
//            [_session startRunning];
//        });
//    });
//}
@end
