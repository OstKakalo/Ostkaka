//
//  MLSpeakView.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/30.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLSpeakView.h"



@interface MLSpeakView ()

@property (weak, nonatomic) IBOutlet UILabel *labelStatus;

@end

@implementation MLSpeakView


- (void)awakeFromNib {
    [super awakeFromNib];
    [self.labelStatus ml_setLabelDayAndNight];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = MYXIB;
    }
    return self;
}

- (IBAction)touchDown:(UIButton *)sender {
    self.labelStatus.text = @"松手发送";
    if ([self.delegate respondsToSelector:@selector(ml_speakView:voiceStatus:)]) {
        [self.delegate ml_speakView:self voiceStatus:MLVoiceStatusSpeaking];
    }
    
    
}
- (IBAction)touchUpInside {
    self.labelStatus.text = @"按住说话";
    if ([self.delegate respondsToSelector:@selector(ml_speakView:voiceStatus:)]) {
        [self.delegate ml_speakView:self voiceStatus:MLVoiceStatusSend];
    }
    
}
- (IBAction)touchDragOutside {
    self.labelStatus.text = @"松手取消发送";
    if ([self.delegate respondsToSelector:@selector(ml_speakView:voiceStatus:)]) {
        [self.delegate ml_speakView:self voiceStatus:MLVoiceStatusWillCancle];
    }
    
}
- (IBAction)touchUpOutside {
    self.labelStatus.text = @"按住说话";
    if ([self.delegate respondsToSelector:@selector(ml_speakView:voiceStatus:)]) {
        [self.delegate ml_speakView:self voiceStatus:MLVoiceStatusCancle];
    }
    
}


@end
