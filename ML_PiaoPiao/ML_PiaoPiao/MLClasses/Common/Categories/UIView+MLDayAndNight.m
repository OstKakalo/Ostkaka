//
//  UIView+MLDayAndNight.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/10/10.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "UIView+MLDayAndNight.h"

@implementation UIView (MLDayAndNight)

- (void)ml_setbackViewDayAndNight {
    [self jxl_setDayMode:^(UIView *view) {
        view.backgroundColor = ColorWith243;
    } nightMode:^(UIView *view) {
        view.backgroundColor = ColorWithBackGround;
    }];

}

- (void)ml_setFrontViewDayAndNight {
    [self jxl_setDayMode:^(UIView *view) {
        view.backgroundColor = [UIColor whiteColor];
    } nightMode:^(UIView *view) {
        view.backgroundColor = ColorWith51Black;
    }];

}

@end
