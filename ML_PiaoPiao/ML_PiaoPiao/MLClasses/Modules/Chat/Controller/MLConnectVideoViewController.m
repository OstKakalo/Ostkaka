//
//  MLConnectVideoViewController.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/10/12.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLConnectVideoViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface MLConnectVideoViewController ()
<EMCallManagerDelegate,
AVCaptureVideoDataOutputSampleBufferDelegate

>
{
    UInt8 *_imageDataBuffer;
}
/** 当前的绘画 */
@property (nonatomic, strong) AVCaptureSession *session;

@property (nonatomic,assign)int time;

/** 时间标签 */
@property (nonatomic, weak) UILabel *callTimeLbl;

/** timer */
@property (nonatomic, weak) NSTimer *timer;

/** 按钮等控件 */
@property (nonatomic, weak) UIView *content;

/** GLView20 */
@property (nonatomic, weak) OpenGLView20 *openGLView20;

@property (nonatomic, strong) UIButton *rejectButton;

@property (nonatomic, strong) UILabel *rejectLabel;

@property (nonatomic, strong) UIButton *agreeButton;

@property (nonatomic, strong) UILabel *agreeLabel;

@property (nonatomic, strong) UILabel *askLabel;

@property (nonatomic, strong) UILabel *username;


@property (nonatomic, strong) UIView *smallView;

@end

@implementation MLConnectVideoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.time = 0;
    
    // 初始化子控件
    [self setup];
    
    
    self.username.text = self.callSession.sessionChatter;
    
    
    if (self.callSession.type == eCallSessionTypeVideo) {
        //初始化摄像头
        [self _initCamera];
        // 开始会话
        [self.session startRunning];
        // 将按钮等控件移到屏幕的最前方
        [self.view bringSubviewToFront:self.content];
        [self.view bringSubviewToFront:self.smallView];
        // 视频时对方图像显示的区域
        self.callSession.displayView = self.openGLView20;
    }
    
}

- (void)_initCamera
{
    // 大窗口
    OpenGLView20 *openGLView = [[OpenGLView20 alloc]init];
    openGLView.backgroundColor = [UIColor clearColor];
    openGLView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //    AVCaptureSessionPreset352x288
    //    AVCaptureSessionPreset640x480
    openGLView.sessionPreset = AVCaptureSessionPresetiFrame960x540;
    [self.view addSubview:openGLView];
    
    self.openGLView20 = openGLView;
    
    
    
    // 创建会话层
    self.session = [[AVCaptureSession alloc]init];
    [self.session setSessionPreset:openGLView.sessionPreset];
    
    // 输入
    AVCaptureDevice *device;
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *temp in devices) {
        if (temp.position == AVCaptureDevicePositionFront) {
            device = temp;
            break;
        }
    }
    NSError *error = nil;
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    [self.session beginConfiguration];
    if (!error) {
        [self.session addInput:deviceInput];
    }
    
    // 输出
    AVCaptureVideoDataOutput *outPut = [[AVCaptureVideoDataOutput alloc]init];
    outPut = [[AVCaptureVideoDataOutput alloc] init];
    outPut.videoSettings = openGLView.outputSettings;
    outPut.minFrameDuration = CMTimeMake(1, 15);
    outPut.alwaysDiscardsLateVideoFrames = YES;
    dispatch_queue_t outQueue = dispatch_queue_create("com.gh.cecall", NULL);
    [outPut setSampleBufferDelegate:self queue:outQueue];
    [self.session addOutput:outPut];
    [self.session commitConfiguration];
    
    
    
    // 小窗口
    UIView *smallView = [[UIView alloc]init];
    smallView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 90, 10, 80, 120);
    smallView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:smallView];
    self.smallView = smallView;
    
    
    // 小窗口显示层
    AVCaptureVideoPreviewLayer *smallViewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
    smallViewLayer.frame = CGRectMake(0, 0, 80, 120);
    smallViewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [smallView.layer addSublayer:smallViewLayer];
    
    
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
      fromConnection:(AVCaptureConnection *)connection
{
    if (self.callSession.status != eCallSessionStatusAccepted) {
        return;
    }
    // 捕捉数据输出，根据自己需求可随意更改
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    if(CVPixelBufferLockBaseAddress(imageBuffer, 0) == kCVReturnSuccess)
    {
        UInt8 *bufferPtr = (UInt8 *)CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0);
        UInt8 *bufferPtr1 = (UInt8 *)CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 1);
        
        size_t width = CVPixelBufferGetWidth(imageBuffer);
        size_t height = CVPixelBufferGetHeight(imageBuffer);
        size_t bytesrow0 = CVPixelBufferGetBytesPerRowOfPlane(imageBuffer, 0);
        size_t bytesrow1  = CVPixelBufferGetBytesPerRowOfPlane(imageBuffer, 1);
        
        if (_imageDataBuffer == nil) {
            _imageDataBuffer = (UInt8 *)malloc(width * height * 3 / 2);
        }
        UInt8 *pY = bufferPtr;
        UInt8 *pUV = bufferPtr1;
        UInt8 *pU = _imageDataBuffer + width * height;
        UInt8 *pV = pU + width * height / 4;
        for(int i =0; i < height; i++)
        {
            memcpy(_imageDataBuffer + i * width, pY + i * bytesrow0, width);
        }
        
        for(int j = 0; j < height / 2; j++)
        {
            for(int i = 0; i < width / 2; i++)
            {
                *(pU++) = pUV[i<<1];
                *(pV++) = pUV[(i<<1) + 1];
            }
            pUV += bytesrow1;
        }
        
        YUV420spRotate90(bufferPtr, _imageDataBuffer, width, height);
        [[EaseMob sharedInstance].callManager processPreviewData:(char *)bufferPtr width:width height:height];
        
        /*We unlock the buffer*/
        CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
    }
}


// 对摄像头采集YUV420sp数据
void YUV420spRotate90(UInt8 *  dst, UInt8* src, size_t srcWidth, size_t srcHeight)
{
    size_t wh = srcWidth * srcHeight;
    size_t uvHeight = srcHeight >> 1;//uvHeight = height / 2
    size_t uvWidth = srcWidth>>1;
    size_t uvwh = wh>>2;
    //旋转Y
    int k = 0;
    for(int i = 0; i < srcWidth; i++) {
        int nPos = wh-srcWidth;
        for(int j = 0; j < srcHeight; j++) {
            dst[k] = src[nPos + i];
            k++;
            nPos -= srcWidth;
        }
    }
    for(int i = 0; i < uvWidth; i++) {
        int nPos = wh+uvwh-uvWidth;
        for(int j = 0; j < uvHeight; j++) {
            dst[k] = src[nPos + i];
            dst[k+uvwh] = src[nPos + i+uvwh];
            k++;
            nPos -= uvWidth;
        }
    }
}

- (void)setup
{
    // 1. 背景图片
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    imgView.image = [UIImage imageNamed:@"callBack"];
    [self.view addSubview:imgView];
    
    // contentView
    UIView *contentView = [[UIView alloc]init];
    contentView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:contentView];
    self.content = contentView;
    
    // 2. 时间标签
    UILabel *timeLbl = [[UILabel alloc]init];
    [contentView addSubview:timeLbl];
    [timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(@200);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
        
    }];
    timeLbl.textAlignment = NSTextAlignmentCenter;
    timeLbl.backgroundColor = [UIColor clearColor];
    timeLbl.textColor = [UIColor whiteColor];
    timeLbl.text = @"0:0:00";
    self.callTimeLbl = timeLbl;
    
    self.username = [[UILabel alloc] init];
    [contentView addSubview:_username];
    _username.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 250) / 2, 100, 250, 50);
    _username.textAlignment = NSTextAlignmentCenter;
    _username.font = [UIFont systemFontOfSize:30];
    _username.textColor = [UIColor whiteColor];
    
    
    self.askLabel = [[UILabel alloc] init];
    [contentView addSubview:_askLabel];
    _askLabel.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 200) / 2, 160, 200, 30);
    _askLabel.textAlignment = NSTextAlignmentCenter;
    _askLabel.backgroundColor = [UIColor clearColor];
    _askLabel.textColor = [UIColor whiteColor];
    _askLabel.text = @"视频通话请求...";
    
    // 同意按钮
    UIButton *acceptBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [contentView addSubview:acceptBtn];
    [acceptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(80);
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
        make.height.equalTo(@50);
        make.width.equalTo(@50);
    }];
    [acceptBtn setImage:[UIImage imageNamed:@"rejectPhone.png"] forState:UIControlStateNormal];
    [acceptBtn addTarget:self action:@selector(agreeAction) forControlEvents:UIControlEventTouchUpInside];
    self.agreeButton = acceptBtn;
    
    
    UILabel *acceptLabel = [[UILabel alloc] init];
    [contentView addSubview:acceptLabel];
    acceptLabel.frame = CGRectMake(80,  [UIScreen mainScreen].bounds.size.height - 30, 50, 30);
    acceptLabel.textAlignment = NSTextAlignmentCenter;
    acceptLabel.text = @"接受";
    acceptLabel.textColor = [UIColor whiteColor];
    acceptLabel.font = [UIFont systemFontOfSize:12.f];
    self.agreeLabel = acceptLabel;
    
    // 4. 拒绝按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [contentView addSubview:cancelBtn];
    cancelBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 130, [UIScreen mainScreen].bounds.size.height - 80, 50, 50);
    [cancelBtn setImage:[UIImage imageNamed:@"acceptPhone.png"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(regectAction) forControlEvents:UIControlEventTouchUpInside];
    self.rejectButton = cancelBtn;
    
    
    UILabel *rejectLabel = [[UILabel alloc] init];
    [contentView addSubview:rejectLabel];
    rejectLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 130,  [UIScreen mainScreen].bounds.size.height - 30, 50, 30);
    rejectLabel.textAlignment = NSTextAlignmentCenter;
    rejectLabel.text = @"挂断";
    rejectLabel.textColor = [UIColor whiteColor];
    rejectLabel.font = [UIFont systemFontOfSize:12.f];
    self.rejectLabel = rejectLabel;
    
    

    // 添加代理
    [[EaseMob sharedInstance].callManager addDelegate:self delegateQueue:nil];
}

#pragma mark - 按钮点击事件
- (void)agreeAction {
    
    [[EaseMob sharedInstance].callManager asyncAnswerCall:self.callSession.sessionId];

}
- (void)regectAction {
    // 停止timer
    [self.timer invalidate];
    [[EaseMob sharedInstance].callManager asyncEndCall:self.callSession.sessionId reason:eCallReasonHangup];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 实时通话的代理
- (void)callSessionStatusChanged:(EMCallSession *)callSession changeReason:(EMCallStatusChangedReason)reason error:(EMError *)error
{
    
    if (callSession.status == eCallSessionStatusAccepted) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(callTime) userInfo:nil repeats:YES];
        [UIView animateWithDuration:0.5 animations:^{
            self.agreeButton.alpha = 0;
            self.agreeLabel.alpha = 0;
            self.rejectButton.frame = CGRectMake((self.view.bounds.size.width - 50) / 2 , self.view.bounds.size.height - 80, 50, 50);
            self.rejectLabel.frame = CGRectMake((self.view.bounds.size.width - self.rejectLabel.bounds.size.width) / 2, self.view.bounds.size.height - 30, self.rejectLabel.bounds.size.width, self.rejectLabel.bounds.size.height);
        } completion:^(BOOL finished) {
            self.askLabel.text = @"通话中...";
        }];
        
        
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
