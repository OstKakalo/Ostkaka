//
//  UILabel+MLDayAndNight.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/10/10.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "UILabel+MLDayAndNight.h"

@implementation UILabel (MLDayAndNight)
- (void)ml_setLabelDayAndNight {
    [self jxl_setDayMode:^(UIView *view) {
        UILabel *label = (UILabel *)view;
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor blackColor];
    } nightMode:^(UIView *view) {
        UILabel *label = (UILabel *)view;
        label.backgroundColor = ColorWith51Black;
        label.textColor = ColorWith243;
    }];

}
@end
