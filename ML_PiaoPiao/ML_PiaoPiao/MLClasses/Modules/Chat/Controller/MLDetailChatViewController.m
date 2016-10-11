//
//  MLDetailChatViewController.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/26.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLDetailChatViewController.h"
#import "MLInputView.h"
#import "MLConversation.h"
#import "MLConversationFrame.h"
#import "MLConversationTableViewCell.h"
#import "MLMoreView.h"
#import <MWPhotoBrowser.h>
#import "MLSpeakView.h"
#import "EMCDDeviceManager.h"
#import "MLConnectViewController.h"
static NSString *const ID = @"mlconversation";

@interface MLDetailChatViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate,
EMChatManagerDelegate,
MLInputViewDelegate,
MLMoreViewDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
IEMChatProgressDelegate,
MLConversationTableViewCellDelegate,
MWPhotoBrowserDelegate,
MLSpeakViewDelegate,
EMCallManagerDelegate

>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MLInputView *inputView;

@property (nonatomic, strong) NSMutableArray *messagesArray;

@property (nonatomic, strong) MLMoreView *moreView;

@property (nonatomic, assign) CGFloat keyHeight;

@property (nonatomic, strong) UIView *modelView;

@property (nonatomic, strong) NSMutableArray *contentThumbnailImageArray;

@property (nonatomic, strong) NSMutableArray *contentImageArray;

@property (nonatomic, strong) MLSpeakView *speakView;

@property (nonatomic, strong) UIImageView *backImage;
@end

@implementation MLDetailChatViewController







- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    
    // 添加子控件
    [self.view addSubview:self.modelView];
    [self.modelView addSubview:self.backImage];
    [self.modelView addSubview:self.tableView];
    [self.modelView addSubview:self.inputView];
    [self.view addSubview:self.moreView];
    [self.moreView addSubview:self.speakView];
    
    [self.view bringSubviewToFront:self.modelView];
    [self.view bringSubviewToFront:_inputView];
    
    
    self.title = self.userName;
    
    // 刷新
    [self ml_reload];
    
    
    // 注册
    [self.tableView registerClass:[MLConversationTableViewCell class] forCellReuseIdentifier:ID];
    
    // 监控键盘
    [self ml_keyBoardMove];
    
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    [[EaseMob sharedInstance].callManager addDelegate:self delegateQueue:nil];
    
    
    
    [[[EaseMob sharedInstance].chatManager conversationForChatter:self.userName conversationType:eConversationTypeChat] markAllMessagesAsRead:YES];
    
    
    
    
    
}
- (void)viewDidAppear:(BOOL)animated {
    [self ml_scrollToBottom];

}


#pragma mark - 结束编辑状态

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    [self.view endEditing:YES];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.modelView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64);
    }];
    
    
    
}



#pragma mark - 操控tabBar消失出现
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
}


#pragma mark - 懒加载

- (UIView *)modelView {

    if (!_modelView) {
        _modelView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
        _modelView.backgroundColor = ColorWith243;
        
    }
    return _modelView;


}

- (NSMutableArray *)messagesArray {
    
    if (!_messagesArray) {
        _messagesArray = [NSMutableArray array];
        
    }
    return _messagesArray;
}
- (UIView *)inputView {
    if (!_inputView) {
        _inputView = [MLInputView ml_inputView];
        _inputView.frame = CGRectMake(0, self.view.bounds.size.height - 50 - 64, self.view.bounds.size.width, 50 );
        _inputView.textField.delegate = self;
        _inputView.delegate = self;
        [_inputView ml_setbackViewDayAndNight];
        
    }
    return _inputView;
    
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 50 - 64);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
    }
    return _tableView;
    
}

- (MLMoreView *)moreView {
    
    if (!_moreView) {
        _moreView = [[MLMoreView alloc] init];
        _moreView.frame = CGRectMake(0, self.view.frame.size.height -  _keyHeight, self.view.bounds.size.width, _keyHeight);
        _moreView.backgroundColor = [UIColor whiteColor];
        _moreView.delegate = self;
        [_moreView ml_setFrontViewDayAndNight];
        
    }
    return _moreView;

}

- (NSMutableArray *)contentThumbnailImageArray {
    if (!_contentThumbnailImageArray) {
        _contentThumbnailImageArray = [NSMutableArray array];
        
    }
    return _contentThumbnailImageArray;

}

- (NSMutableArray *)contentImageArray {
    if (!_contentImageArray) {
        _contentImageArray = [NSMutableArray array];
    }
    return _contentImageArray;

}

- (MLSpeakView *)speakView {
    if (!_speakView) {
        _speakView = [[MLSpeakView alloc] init];
        _speakView.frame = CGRectMake(0, 0, self.view.frame.size.width, _keyHeight);
        _speakView.backgroundColor = [UIColor whiteColor];
        _speakView.delegate = self;
        [_speakView ml_setFrontViewDayAndNight];
        
    }
    return _speakView;
}
- (UIImageView *)backImage {
    if (!_backImage) {
        _backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64 - 50)];
        [_backImage jxl_setDayMode:^(UIView *view) {
            ((UIImageView *)view).image = [UIImage imageNamed:@"dayBack"];
        } nightMode:^(UIView *view) {
            ((UIImageView *)view).image = [UIImage imageNamed:@"nightBack.jpg"];
        }];
    }
    return _backImage;
}
#pragma mark - setter方法

- (void)setKeyHeight:(CGFloat)keyHeight {

    _keyHeight = keyHeight;
    self.moreView.frame = CGRectMake(0,self.view.bounds.size.height - _keyHeight , self.view.bounds.size.width, _keyHeight);

}


#pragma mark - textField协议方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    
    
    EMChatText *textChat = [[EMChatText alloc] initWithText:textField.text];
    
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithChatObject:textChat];
    
    EMMessage *message = [[EMMessage alloc] initWithReceiver:self.userName bodies:@[body]];
   
    
    
    [[EaseMob sharedInstance].chatManager asyncSendMessage:message progress:nil prepare:^(EMMessage *message, EMError *error) {
        //
    } onQueue:nil completion:^(EMMessage *message, EMError *error) {
        //
        if (!error) {
            
            textField.text = nil;
            [textField resignFirstResponder];
            [self ml_reload];
        }
    } onQueue:nil];


    return YES;
}



#pragma mark - tableView协议方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [self.messagesArray[indexPath.row] cellH];


}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messagesArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MLConversationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.delegate = self;
    cell.backgroundColor = [UIColor clearColor];
    [cell setConversationFrame:_messagesArray[indexPath.row]];
    
   
    return cell;
}
#pragma mark - EaseMode协议方法
- (void)didReceiveMessage:(EMMessage *)message {
    
    [self ml_reload];
    
}

- (void)didReceiveOfflineMessages:(NSArray *)offlineMessages {
    
    [self ml_reload];
}


#pragma mark - InputView协议方法
- (void)ml_inputView:(MLInputView *)inputView inputButtonStyle:(NSInteger)buttonStyle sender:(id)sender {
    
    UIButton *senderButton = sender;
    senderButton.selected = YES;
    
    
    
    if (buttonStyle == 2) {
        // 更多按钮
        if ([_inputView.textField isFirstResponder]) {
            
            self.speakView.hidden = YES;
            
            [self.view endEditing:YES];
            
            self.modelView.frame = CGRectMake(0, - self.keyHeight + 64, self.view.bounds.size.width, self.view.bounds.size.height - 64);
            
            
        } else {
            
            [_inputView.textField becomeFirstResponder];
            
        }
    } else if (buttonStyle == 0) {
        // 语音按钮
        if ([_inputView.textField isFirstResponder]) {
            
            self.speakView.hidden = NO;
            
            [self.view endEditing:YES];
            
            self.modelView.frame = CGRectMake(0, - self.keyHeight + 64, self.view.bounds.size.width, self.view.bounds.size.height - 64);
            
        } else {
            
            [_inputView.textField becomeFirstResponder];
        
        }
    
    
    
    }
    
    
    

}

#pragma mark - speakView协议方法
- (void)ml_speakView:(MLSpeakView *)speakView voiceStatus:(MLVoiceStatus)voiceStatus {
    
    switch (voiceStatus) {
        case MLVoiceStatusSpeaking:
        {
            NSInteger now= (NSInteger)[[NSDate date] timeIntervalSince1970];
            NSInteger randowNum = arc4random() % 100000;
            NSString *fileName = [NSString stringWithFormat:@"%@%zd%zd", self.userName, now, randowNum];
            [[EMCDDeviceManager sharedInstance] asyncStartRecordingWithFileName:fileName completion:^(NSError *error) {
                if (!error) {
                    NSLog(@"正在录制");
                }
            }];
            
            
        }
            break;
            
        case MLVoiceStatusSend:
        {
            [[EMCDDeviceManager sharedInstance] asyncStopRecordingWithCompletion:^(NSString *recordPath, NSInteger aDuration, NSError *error) {
                if (!error) {
                    
                    
                    EMChatVoice *voice = [[EMChatVoice alloc] initWithFile:recordPath displayName:@"audio"];
                    voice.duration = aDuration;
                    EMVoiceMessageBody *body = [[EMVoiceMessageBody alloc] initWithChatObject:voice];
                    
                    // 生成message
                    EMMessage *message = [[EMMessage alloc] initWithReceiver:self.userName bodies:@[body]];
                    
                    [[EaseMob sharedInstance].chatManager asyncSendMessage:message progress:nil prepare:^(EMMessage *message, EMError *error) {
                        //
                    } onQueue:nil completion:^(EMMessage *message, EMError *error) {
                        if (!error) {
                            [self ml_reload];
                        }
                    } onQueue:nil];
                    
                    
                    
                    
                }
            }];
        }
            break;
            
        case MLVoiceStatusWillCancle:
        {
            // 如果有时间可以加HUD
        }
            break;
            
        case MLVoiceStatusCancle:
        {
            // 当前取消录音
            [[EMCDDeviceManager sharedInstance] cancelCurrentRecording];
        }
            break;
            
        default:
            break;
    }

}

#pragma mark - moreView协议方法
- (void)ml_moreView:(MLMoreView *)moreView moreButtonStyle:(NSInteger)buttonStyle {
    
    
    switch (buttonStyle) {
        // 相册
        case 0:
        {
        
            UIImagePickerController *iPC = [[UIImagePickerController alloc] init];
            iPC.delegate = self;
            [self presentViewController:iPC animated:YES completion:nil];
            
        }
            break;
        // 电话
        case 1:
        {
            EMError *error = nil;
            [[EaseMob sharedInstance].callManager asyncMakeVoiceCall:self.userName timeout:0 error:&error];
            if (error) {
                NSLog(@"%@",error);
            }
        }
            break;
        // 视频
        case 2:
        {
            EMError *error = nil;
            [[EaseMob sharedInstance].callManager asyncMakeVideoCall:self.userName timeout:0 error:&error];
            if (error) {
                NSLog(@"%@",error);
            }
        
        }
            break;
            
        default:
            break;
    }
    
    

    
    

}
#pragma mark - UIImagePickerControllerDelegate协议方法

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    
    EMChatImage *emImage = [[EMChatImage alloc] initWithUIImage:image displayName:@"展示的图片名"];
    
    EMImageMessageBody *body = [[EMImageMessageBody alloc] initWithChatObject:emImage];
    
    EMMessage *emsg = [[EMMessage alloc] initWithReceiver:self.userName bodies:@[body]];
    
    
    
    
    [[EaseMob sharedInstance].chatManager asyncSendMessage:emsg progress:self prepare:^(EMMessage *message, EMError *error) {
        //
    } onQueue:nil completion:^(EMMessage *message, EMError *error) {
        // 发送成功
        if (!error) {
            [self ml_reload];
        }
        
    } onQueue:nil];
    
    


}

#pragma mark - IEMChatProgressDelegate协议方法

- (void)setProgress:(float)progress {

}
- (void)setProgress:(float)progress
         forMessage:(EMMessage *)message
     forMessageBody:(id<IEMMessageBody>)messageBody {

}



#pragma mark - MLConversationTableViewCellDelegate协议方法

- (void)ml_conversationTableViewCell:(MLConversationTableViewCell *)conversationTableViewCell {
    
    
    
    switch (conversationTableViewCell.conversationFrame.conversation.messageBodyType) {
        case eMessageBodyType_Text:
        {
        
        }
            break;
            
        case eMessageBodyType_Image:
        {
            MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
            NSUInteger index = 0;
            if (conversationTableViewCell.conversationFrame.conversation.contentThumbnailImage) {
                index = [self.contentThumbnailImageArray indexOfObject:conversationTableViewCell.conversationFrame.conversation.contentThumbnailImage];
            } else {
                index = [self.contentThumbnailImageArray indexOfObject:conversationTableViewCell.conversationFrame.conversation.contentThumbnailImageURL];
            }
            
            [browser setCurrentPhotoIndex:index];
            
            
            [self.navigationController pushViewController:browser animated:YES];
            
        }
            break;
            
        case eMessageBodyType_Voice:
        {
            
            UIButton *contentButton = (UIButton *)conversationTableViewCell.contentButton;
            
            if ([[EMCDDeviceManager sharedInstance] isPlaying]) {
                [[EMCDDeviceManager sharedInstance] stopPlaying];
                [contentButton.imageView stopAnimating];
            } else {
                [contentButton.imageView startAnimating];
                [[EMCDDeviceManager sharedInstance] asyncPlayingWithPath:conversationTableViewCell.conversationFrame.conversation.voicePath completion:^(NSError *error) {
                    //
                    if (!error) {
                        //
                        
                        [contentButton.imageView stopAnimating];
                        
                    }
                }];
            
            }
            
            
            
            
        }
            break;
            
        case eMessageBodyType_Video:
        {
            
        }
            break;
            
        case eMessageBodyType_Location:
        {
            
        }
            break;
            
        case eMessageBodyType_File:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    
    
}
#pragma mark - MWPhotoBrowserDelegate协议方法

// 数量
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {

    return self.contentThumbnailImageArray.count;
    
}
// 大图
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    id image = self.contentImageArray[index];
    MWPhoto *photo;
    if ([self.contentImageArray[index] isKindOfClass:[UIImage class]]) {
        photo = [MWPhoto photoWithImage:image];
    } else {
        photo = [MWPhoto photoWithURL:image];
    }
    return photo;
}
// 缩略图
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    id image = self.contentThumbnailImageArray[index];
    MWPhoto *photo;
    if ([self.contentThumbnailImageArray[index] isKindOfClass:[UIImage class]]) {
        photo = [MWPhoto photoWithImage:image];
    } else {
        photo = [MWPhoto photoWithURL:image];
    }
    return photo;
}

#pragma mark - 私有方法

- (void)ml_keyBoardMove {
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillChangeFrameNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"note %@, note %@",note , [note class]);
        /*
         {name = UIKeyboardWillChangeFrameNotification; userInfo = {
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
        CGFloat endY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
        CGFloat itemY = endY - self.view.bounds.size.height ;
        CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        
        self.keyHeight = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
        
        [UIView animateWithDuration:duration animations:^{
            self.modelView.frame = CGRectMake(0, itemY + 64, self.view.bounds.size.width, self.view.bounds.size.height - 64);
        
        }];
        
        
        
        
        
        
    }];
}

- (void)ml_reload {
    
    [self.messagesArray removeAllObjects];
    [self.contentImageArray removeAllObjects];
    [self.contentThumbnailImageArray removeAllObjects];
    
     EMConversation *conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:self.userName conversationType:eConversationTypeChat];
    
    NSArray *messages = [conversation loadAllMessages];
    
    for (EMMessage *message in messages) {
        MLConversation *conversation = [[MLConversation alloc] init];
        conversation.message = message;
        MLConversationFrame *conversationFrame = [[MLConversationFrame alloc] init];
        conversationFrame.conversation = conversation;
        [self.messagesArray addObject:conversationFrame];
        // 判断信息类型是否是图片
        if (conversation.messageBodyType == eMessageBodyType_Image) {
            
            // 为数组中存大图片
            if (conversation.contentImage) {
                [self.contentImageArray addObject:conversation.contentImage];
            } else {
                
                [self.contentImageArray addObject:conversation.contentImageURL];
            }
            // 为数组中存缩略图
            if (conversation.contentThumbnailImage) {
                [self.contentThumbnailImageArray addObject:conversation.contentThumbnailImage];
            } else {
                
                [self.contentThumbnailImageArray addObject:conversation.contentThumbnailImageURL];
            }
        }
        
    }
    
    [_tableView reloadData];
    
    
    // 滑动到最底端
    [self ml_scrollToBottom];

}


- (void)ml_scrollToBottom {
    if (!self.messagesArray.count) {
        
        return ;
    }
    
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_messagesArray.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];


}



@end
