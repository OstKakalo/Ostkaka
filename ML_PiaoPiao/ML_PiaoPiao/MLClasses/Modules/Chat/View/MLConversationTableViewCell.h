//
//  MLConversationTableViewCell.h
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/26.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MLConversationFrame, MLConversationTableViewCell, MLLongPressButton;

@protocol MLConversationTableViewCellDelegate <NSObject>

@optional

- (void)ml_conversationTableViewCell:(MLConversationTableViewCell *)conversationTableViewCell;

@end


@interface MLConversationTableViewCell : UITableViewCell


@property (nonatomic, strong) MLLongPressButton *contentButton;
@property (nonatomic, strong) MLConversationFrame *conversationFrame;
@property (nonatomic, weak) id<MLConversationTableViewCellDelegate> delegate;

@end
