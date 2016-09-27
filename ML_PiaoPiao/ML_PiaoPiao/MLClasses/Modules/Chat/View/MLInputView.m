//
//  MLInputView.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/26.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLInputView.h"

@implementation MLInputView
- (IBAction)more:(id)sender {
    NSLog(@"more");
}

- (IBAction)face:(id)sender {
    NSLog(@"face");
}

- (IBAction)speech:(id)sender {
    NSLog(@"speech");
}

+ (instancetype)ml_inputView {

    return MYXIB;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
