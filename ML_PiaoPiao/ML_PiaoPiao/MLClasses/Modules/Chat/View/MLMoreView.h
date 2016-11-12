//
//  MLMoreView.h
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/28.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MLMoreView;

@protocol MLMoreViewDelegate <NSObject>

@optional

- (void)ml_moreView:(MLMoreView *)moreView moreButtonStyle:(NSInteger)buttonStyle;
    




@end


@interface MLMoreView : UIView


@property (nonatomic, weak) id<MLMoreViewDelegate> delegate;

@end
