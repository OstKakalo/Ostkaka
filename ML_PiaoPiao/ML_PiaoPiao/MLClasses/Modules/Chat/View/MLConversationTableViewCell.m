//
//  MLConversationTableViewCell.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/26.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLConversationTableViewCell.h"
#import "MLLongPressButton.h"
#import "MLConversation.h"
#import "MLConversationFrame.h"
#import "MLLongPressButton.h"
@interface MLConversationTableViewCell ()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) MLLongPressButton *contentButton;
@property (nonatomic, strong) MLLongPressButton *iconButton;

@end

@implementation MLConversationTableViewCell

- (void)setConversationFrame:(MLConversationFrame *)conversationFrame {

    _conversationFrame = conversationFrame;
    
    MLConversation *conversation = conversationFrame.conversation;
    _timeLabel.text = conversation.timeStr;
    [_contentButton setTitle:conversation.contentText forState:UIControlStateNormal];
    [_contentButton setBackgroundImage:conversation.contentBackGroundImage forState:UIControlStateNormal];
    [_iconButton setImage:[UIImage imageNamed:conversation.userIcon] forState:UIControlStateNormal];
    
    
}





- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {


    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = ColorWith243;
        
        
        self.timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = kTimeFont;
        
        [self.contentView addSubview:_timeLabel];
        
        
        self.contentButton = [[MLLongPressButton alloc] init];
//        _contentButton.contentEdgeInsets = UIEdgeInsetsMake(kContentEdgeTop, kContentEdgeLeft, kContentEdgeBottom, kContentEdgeRight);
        _contentButton.titleLabel.numberOfLines = 0;
        _contentButton.layer.cornerRadius = 5.0;
        [_contentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _contentButton.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:_contentButton];
        
        
        self.iconButton = [[MLLongPressButton alloc] init];
        _iconButton.layer.cornerRadius = 22.0;
        _iconButton.clipsToBounds = YES;
        [self.contentView addSubview:_iconButton];
        
        
        
        
        
        
    }
    
    
    
    return self;

}


- (void)layoutSubviews {
    [super layoutSubviews];
    _timeLabel.frame = _conversationFrame.timeFrame;
    _contentButton.frame = _conversationFrame.contentFrame;
    _iconButton.frame = _conversationFrame.iconFrame;
    

    

}

@end
