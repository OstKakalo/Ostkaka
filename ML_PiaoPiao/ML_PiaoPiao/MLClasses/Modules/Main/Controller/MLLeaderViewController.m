//
//  MLLeaderViewController.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/10/11.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLLeaderViewController.h"
#import "MLMainViewController.h"
@interface MLLeaderViewController ()

<
UIScrollViewDelegate
>
{
    // 创建页码控制器
    UIPageControl *pageController;
    // 判断是否是第一次进入应用
    BOOL flag;
    
    
    
}

@end

@implementation MLLeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    for (int i = 0; i <= 6; i++) {
        NSString *imageName = [NSString stringWithFormat:@"leader%d.jpg", i];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * i, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        if (6 == i) {
            imageView.userInteractionEnabled = YES;
            
            // 创建button
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            [button setTitle:@"点击进入" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            button.layer.borderWidth = 2;
            button.layer.cornerRadius = 5;
            button.clipsToBounds = YES;
            
            button.layer.borderColor = [UIColor grayColor].CGColor;
            [button addTarget:self  action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(imageView.mas_centerX);
                make.bottom.equalTo(imageView).offset(-100);
                make.height.equalTo(@60);
                make.width.equalTo(@200);
                
            }];
            
        }
        imageView.image = image;
        [myScrollView addSubview:imageView];
    }
    myScrollView.bounces = NO;
    myScrollView.pagingEnabled = YES;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 7, 0);
    myScrollView.delegate = self;
    [self.view addSubview:myScrollView];
    
    
    pageController = [[UIPageControl alloc] init];
    pageController.numberOfPages = 7;
    pageController.pageIndicatorTintColor = [UIColor grayColor];
    pageController.currentPageIndicatorTintColor = [UIColor blackColor];
    [self.view addSubview:pageController];
    [pageController mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-10);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@90);
        make.height.equalTo(@150);
    }];
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageController.currentPage = (NSInteger)(scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width);
    
}
- (void)buttonAction:(UIButton *)button {
    flag = YES;
    NSUserDefaults * userDef = [NSUserDefaults standardUserDefaults];
    [userDef setBool:flag forKey:@"notFirst"];
    [userDef synchronize];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    window.rootViewController = [[MLMainViewController alloc]init];
    
    
}




@end
