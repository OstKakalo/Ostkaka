//
//  UIView+MLFindSuperViewController.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/10/10.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "UIView+MLFindSuperViewController.h"

@implementation UIView (MLFindSuperViewController)
- (UIViewController *)ml_viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end
