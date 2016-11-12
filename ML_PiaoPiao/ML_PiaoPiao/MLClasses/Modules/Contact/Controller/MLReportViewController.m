//
//  MLReportViewController.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/10/20.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLReportViewController.h"

@interface MLReportViewController ()

@end

@implementation MLReportViewController


- (IBAction)commitAction:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提交成功,我们会尽快处理" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
