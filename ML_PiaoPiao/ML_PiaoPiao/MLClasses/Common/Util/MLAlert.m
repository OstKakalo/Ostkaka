//
//  MLAlert.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/10/10.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLAlert.h"

@implementation MLAlert

+ (UIAlertController *)ml_alertControllerWithDefailDevelop {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"瓢瓢开发人员紧张,暂未开放功能，请期待后续开发。" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"点个赞" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"我很期待" style:UIAlertActionStyleDefault handler:nil]];
    return alert;
}

@end
