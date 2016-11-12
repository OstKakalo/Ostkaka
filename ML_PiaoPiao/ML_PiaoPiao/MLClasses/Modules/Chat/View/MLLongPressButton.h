//
//  MLLongPressButton.h
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/26.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MLLongPressButton;

typedef void(^MLLongPressBlock)(MLLongPressButton *button);

@interface MLLongPressButton : UIButton


@property (nonatomic, copy) MLLongPressBlock longPressBlock;

@end
