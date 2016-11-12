//
//  MLInputView.h
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/26.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MLInputView;

@protocol MLInputViewDelegate <NSObject>

@optional


- (void)ml_inputView:(MLInputView *)inputView inputButtonStyle:(NSInteger)buttonStyle sender:(id)sender;

@end



@interface MLInputView : UIView

+ (instancetype)ml_inputView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic, weak) id<MLInputViewDelegate> delegate;
@end
