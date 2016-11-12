//
//  MLServerViewController.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/10/20.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLServerViewController.h"

@interface MLServerViewController ()

@property (weak, nonatomic) IBOutlet UITextView *myTextView;

@end

@implementation MLServerViewController


- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.myTextView.contentOffset = CGPointMake(0, 0);
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
