//
//  MLServerListViewController.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/11/12.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLServerListViewController.h"

@interface MLServerListViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation MLServerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillLayoutSubviews {

    [super viewWillLayoutSubviews];
    self.textView.contentOffset = CGPointMake(0, - 100);
    self.textView.editable = NO;
    
}

@end
