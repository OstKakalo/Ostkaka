//
//  MLConversationFrame.h
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/26.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#define  kTimeFont [UIFont systemFontOfSize:13.0]
#define  kContentTextFont [UIFont systemFontOfSize:15.0]
#define  kContentEdgeTop 15
#define  kContentEdgeLeft 20
#define  kContentEdgeBottom 15
#define  kContentEdgeRight 20

@class MLConversation;

@interface MLConversationFrame : NSObject

@property(nonatomic, strong) MLConversation *conversation;

// timeLab
@property(nonatomic, assign, readonly) CGRect timeFrame;
// 头像
@property(nonatomic, assign, readonly) CGRect iconFrame;
// 内容
@property(nonatomic, assign, readonly) CGRect contentFrame;
// cell高度
@property(nonatomic, assign, readonly) CGFloat cellH;



@end
