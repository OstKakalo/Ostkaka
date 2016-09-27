//
//  MLInputView.h
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/26.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLInputView : UIView

+ (instancetype)ml_inputView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end
