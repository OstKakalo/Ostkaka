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

// 文字聊天内容
@property (nonatomic, copy, readonly) NSString *contentText;

// 文字聊天的背景图
@property (nonatomic, strong, readonly) UIImage *contentBackGroundImage;

// 头像url
@property (nonatomic, copy, readonly) NSString *userIcon;

// timeStr
@property (nonatomic, copy, readonly) NSString *timeStr;

// 是我还是他
@property (nonatomic, assign, getter=isMe, readonly) BOOL me;
@end
