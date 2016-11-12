//
//  MLLongPressButton.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/26.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLLongPressButton.h"

@implementation MLLongPressButton


- (instancetype)init
{
    self = [super init];
    if (self) {
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(ml_longPress)];
        longPressGesture.minimumPressDuration = 1.f;
        [self addGestureRecognizer:longPressGesture];
    }
    return self;
}


- (void)ml_longPress {
    if (self.longPressBlock) {
        self.longPressBlock(self);
    }

}

@end
