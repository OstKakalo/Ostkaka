//
//  MLInputView.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/26.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLInputView.h"

@interface MLInputView ()

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *speechButton;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UIButton *faceButton;

@end

@implementation MLInputView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.inputTextField jxl_setDayMode:^(UIView *view) {
        ((UITextField *)view).textColor = [UIColor blackColor];
        view.backgroundColor = [UIColor whiteColor];
    } nightMode:^(UIView *view) {
        ((UITextField *)view).textColor = ColorWith243;
        view.backgroundColor = ColorWith51Black;
    }];
    
    [self.speechButton jxl_setDayMode:^(UIView *view) {
        [((UIButton *)view) setImage:[UIImage imageNamed:@"speech"] forState:UIControlStateNormal];
    } nightMode:^(UIView *view) {
        [((UIButton *)view) setImage:[UIImage imageNamed:@"speek-night"] forState:UIControlStateNormal];
    }];
    [self.faceButton jxl_setDayMode:^(UIView *view) {
        [((UIButton *)view) setImage:[UIImage imageNamed:@"face"] forState:UIControlStateNormal];
    } nightMode:^(UIView *view) {
        [((UIButton *)view) setImage:[UIImage imageNamed:@"face-night"] forState:UIControlStateNormal];
    }];
    [self.moreButton jxl_setDayMode:^(UIView *view) {
        [((UIButton *)view) setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    } nightMode:^(UIView *view) {
        [((UIButton *)view) setImage:[UIImage imageNamed:@"add-night"] forState:UIControlStateNormal];
    }];

}

- (IBAction)more:(id)sender {
  
    if ([self.delegate respondsToSelector:@selector(ml_inputView:inputButtonStyle:sender:)]) {
        [self.delegate ml_inputView:self inputButtonStyle:2 sender:sender];
    }

    NSLog(@"more");
}

- (IBAction)face:(id)sender {
    NSLog(@"face");
    if ([self.delegate respondsToSelector:@selector(ml_inputView:inputButtonStyle:sender:)]) {
        [self.delegate ml_inputView:self inputButtonStyle:1 sender:sender];
    }
}

- (IBAction)speech:(id)sender {
    NSLog(@"speech");
    if ([self.delegate respondsToSelector:@selector(ml_inputView:inputButtonStyle:sender:)]) {
        [self.delegate ml_inputView:self inputButtonStyle:0 sender:sender];
    }
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
