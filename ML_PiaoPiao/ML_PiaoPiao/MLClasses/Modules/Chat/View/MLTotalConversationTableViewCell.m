//
//  MLTotalConversationTableViewCell.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/10/3.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLTotalConversationTableViewCell.h"
#import "NSDate+Categories.h"

@interface MLTotalConversationTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *username;

@property (weak, nonatomic) IBOutlet UILabel *lastMessage;

@property (weak, nonatomic) IBOutlet UILabel *lastMessageTime;

@property (weak, nonatomic) IBOutlet UIButton *unReadMessage;


@end

@implementation MLTotalConversationTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    [self.username ml_setLabelDayAndNight];
}


- (void)setConversation:(EMConversation *)conversation {
    _conversation = conversation;
    // 用户名
    self.username.text = [conversation chatter];
    // 最后一条消息
    
    id<IEMMessageBody> messageBody = conversation.latestMessage.messageBodies.firstObject;
    if (conversation.latestMessage) {
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Text:
            {
                self.lastMessage.text = ((EMTextMessageBody *)messageBody).text;
            }
                break;
                
            case eMessageBodyType_Image:
            {
                self.lastMessage.text = @"[图片]";
            }
                break;
                
            case eMessageBodyType_Voice:
            {
                self.lastMessage.text = @"[语音]";
            }
                break;
                
            default:
                break;
        }
    } else {
    
        self.lastMessage.text = @"";
    }
    
    
    
    
    // 时间
    self.lastMessageTime.text = [NSDate intervalSinceNow:messageBody.message.timestamp];
    
    // 未读消息数
    if (conversation.unreadMessagesCount) {
        self.unReadMessage.hidden = NO;
        NSString *unReadMessage = [NSString stringWithFormat:@"%lu", (unsigned long)conversation.unreadMessagesCount];
        [self.unReadMessage setTitle:unReadMessage forState:UIControlStateNormal];
        self.unReadMessage.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    } else {
    
        self.unReadMessage.hidden = YES;
    }
    
    
    


}

@end
