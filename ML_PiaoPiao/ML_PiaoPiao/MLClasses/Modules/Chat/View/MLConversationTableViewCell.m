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
#import <UIButton+WebCache.h>
@interface MLConversationTableViewCell ()

@property (nonatomic, strong) UILabel *timeLabel;
//@property (nonatomic, strong) MLLongPressButton *contentButton;
@property (nonatomic, strong) MLLongPressButton *iconButton;



@end

@implementation MLConversationTableViewCell

- (void)setConversationFrame:(MLConversationFrame *)conversationFrame {

    _conversationFrame = conversationFrame;
    
    
    MLConversation *conversation = conversationFrame.conversation;
    _timeLabel.text = conversation.timeStr;
    [_iconButton setImage:[UIImage imageNamed:conversation.userIcon] forState:UIControlStateNormal];

    /*
     eMessageBodyType_Text = 1,
     eMessageBodyType_Image,
     eMessageBodyType_Video,
     eMessageBodyType_Location,
     eMessageBodyType_Voice,
     eMessageBodyType_File,
     */
    switch (conversation.messageBodyType) {
        case eMessageBodyType_Text:
        {
            
            // 解决图文重用问题，如果是文字，将button图片置空
            _contentButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [_contentButton setImage:nil forState:UIControlStateNormal];
            
            [_contentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            _contentButton.titleLabel.font = [UIFont systemFontOfSize: 15.f];
            [_contentButton setTitle:conversation.contentText forState:UIControlStateNormal];
            _contentButton.backgroundColor = conversation.contentBackGroundColor;
            _contentButton.titleEdgeInsets = UIEdgeInsetsZero;
            
        }
            break;
            
        case eMessageBodyType_Image:
        {
            

            _contentButton.imageEdgeInsets = UIEdgeInsetsZero;;
            if (conversation.contentThumbnailImage) {
                [_contentButton setImage:conversation.contentThumbnailImage forState:UIControlStateNormal];
            } else {
            
                [_contentButton sd_setImageWithURL:conversation.contentThumbnailImageURL forState:UIControlStateNormal];
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
            
        case eMessageBodyType_Voice:
        {
            // 解决图文重用问题，如果是文字，将button图片置空
            

            
            
            if (conversation.isMe) {
                [_contentButton setImage:[UIImage imageNamed:@"me3"] forState:UIControlStateNormal];
                _contentButton.imageEdgeInsets = UIEdgeInsetsMake( 11, conversationFrame.contentFrame.size.width - 22 - 6, 11, 6);
                _contentButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                _contentButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
            } else {
                [_contentButton setImage:[UIImage imageNamed:@"he3"] forState:UIControlStateNormal];
                _contentButton.imageEdgeInsets = UIEdgeInsetsMake( 11, 6, 11, conversationFrame.contentFrame.size.width - 22 - 6);
                _contentButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                _contentButton.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
            
            }
            _contentButton.imageView.animationImages = conversation.imageArray;
            _contentButton.imageView.animationDuration = 1.f;
            _contentButton.imageView.animationRepeatCount = 0;
            
            
            
            
            
            [_contentButton setTitle:[NSString stringWithFormat:@"%ld''",(long)conversation.voiceDuration] forState:UIControlStateNormal];
            [_contentButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            _contentButton.titleLabel.font = [UIFont systemFontOfSize: 10.f];
            _contentButton.backgroundColor = conversation.contentBackGroundColor;
    
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
        _contentButton.titleLabel.numberOfLines = 0;
        _contentButton.layer.cornerRadius = 10.0;
        
        [self.contentView addSubview:_contentButton];
        [_contentButton addTarget:self action:@selector(ml_contentButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        
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


#pragma mark - button点击事件
- (void)ml_contentButtonClick {
    if ([self.delegate respondsToSelector:@selector(ml_conversationTableViewCell:)]) {
        [self.delegate ml_conversationTableViewCell:self];
    }


}

@end
