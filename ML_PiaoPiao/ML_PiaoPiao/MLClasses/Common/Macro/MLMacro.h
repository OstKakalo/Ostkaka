//
//  MLMacro.h
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/23.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#ifndef MLMacro_h
#define MLMacro_h


#define ColorWith243 [UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:243 / 255.0 alpha:1]
#define SCREEN_RECT         [UIScreen mainScreen].bounds
#define SCREEN_SIZE         [UIScreen mainScreen].bounds.size
#define SCREEN_WIDTH        SCREEN_SIZE.width
#define SCREEN_HEIGHT       SCREEN_SIZE.height

#define MYSTORYBOARD [[UIStoryboard storyboardWithName:NSStringFromClass(self) bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass(self)]

#define MYXIB [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject

#endif /* MLMacro_h */
