//
//  MLSpeakView.h
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/30.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MLSpeakView;

typedef enum : NSUInteger {
    MLVoiceStatusSpeaking = 0,
    MLVoiceStatusSend,
    MLVoiceStatusWillCancle,
    MLVoiceStatusCancle,
} MLVoiceStatus;

@protocol MLSpeakViewDelegate <NSObject>

@optional

- (void)ml_speakView:(MLSpeakView *)speakView voiceStatus:(MLVoiceStatus)voiceStatus;


@end


@interface MLSpeakView : UIView

@property (nonatomic, weak) id<MLSpeakViewDelegate> delegate;

@end
