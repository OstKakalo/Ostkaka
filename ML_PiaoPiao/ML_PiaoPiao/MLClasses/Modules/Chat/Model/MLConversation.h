//
//  MLConversation.h
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/26.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLConversation : NSObject

@property (nonatomic, strong) EMMessage *message;


/************** 文字消息 *******************/
// 文字聊天内容
@property (nonatomic, copy, readonly) NSString *contentText;

// 文字聊天的背景图
@property (nonatomic, strong, readonly) UIColor *contentBackGroundColor;


/************** 图片消息 *******************/
// 详情大图
@property (nonatomic, strong, readonly) UIImage *contentImage;

// 预览图
@property (nonatomic, strong, readonly) UIImage *contentThumbnailImage;

// 详情大图url
@property (nonatomic, strong, readonly) NSURL *contentImageURL;

// 预览图url
@property (nonatomic, strong, readonly) NSURL *contentThumbnailImageURL;


// 预览图尺寸
@property (nonatomic, assign, readonly) CGSize contentThumbnailImageSize;

// 是否横预览
@property (nonatomic, assign, getter=isVertical ,readonly) BOOL vertical;



/************** 语音消息 *******************/

// 持续时间
@property (nonatomic, assign, readonly) NSInteger voiceDuration;

// 本地路径
@property (nonatomic, copy, readonly) NSString *voicePath;


// 音频图片动态图数组
@property (nonatomic, strong, readonly) NSMutableArray *imageArray;
/************** 其他 *******************/

// 头像url
@property (nonatomic, copy, readonly) NSString *userIcon;

// timeStr
@property (nonatomic, copy, readonly) NSString *timeStr;

// 是我还是他
@property (nonatomic, assign, getter=isMe, readonly) BOOL me;

// 消息类型
@property (nonatomic, readonly) MessageBodyType messageBodyType;
@end
