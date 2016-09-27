//
//  MLConversationFrame.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/26.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLConversationFrame.h"
#import "MLConversation.h"

@interface MLConversationFrame ()


// timeLab
@property(nonatomic, assign) CGRect timeFrame;
// 头像
@property(nonatomic, assign) CGRect iconFrame;
// 内容
@property(nonatomic, assign) CGRect contentFrame;
// cell高度
@property(nonatomic, assign) CGFloat cellH;


@end

@implementation MLConversationFrame

- (void)setConversation:(MLConversation *)conversation {
    _conversation = conversation;
    
    
    
    CGFloat screenW = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat margin = 10;
    CGFloat timeX;
    CGFloat timeY = 0;
    CGFloat timeW;
    CGFloat timeH;
    CGFloat MaxTimeH = 20;
    
    CGSize timeStrSize = [conversation.timeStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, MaxTimeH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kTimeFont} context:nil].size;
    
    timeH = timeStrSize.height;
    timeW = timeStrSize.width + 5;
    timeX = (screenW - timeW) * 0.5;
    self.timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    
    
    CGFloat iconX;
    CGFloat iconY = _timeFrame.size.height + margin;
    CGFloat iconW = 44;
    CGFloat iconH = 44;
    
    
    CGFloat contentX;
    CGFloat contentY = iconY;
    CGFloat contentW;
    CGFloat contentH;
    CGFloat MaxContentW = screenW - 2 * (margin + iconW + margin);
    CGSize contentSize = [conversation.contentText boundingRectWithSize:CGSizeMake(MaxContentW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kContentTextFont} context:nil].size;
    
    contentW = contentSize.width + kContentEdgeLeft + kContentEdgeRight;
    contentH = contentSize.height + kContentEdgeTop + kContentEdgeBottom;
    
    
    if (conversation.isMe) {
        iconX = screenW - margin - iconW;
        contentX = iconX - margin - contentW;
    } else {
        iconX = margin;
        contentX = margin + iconW + margin;
    
    }
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    self.contentFrame = CGRectMake(contentX, contentY, contentW, contentH);
    
    
    self.cellH = timeH + margin + contentH + margin;
    

}

@end
