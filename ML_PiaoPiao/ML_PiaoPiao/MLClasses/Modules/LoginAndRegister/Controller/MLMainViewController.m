//
//  MLMainViewController.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/23.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//


#import "MLMainViewController.h"
#import "MLLoginViewController.h"
#import "MLRegisterViewController.h"
#import "MLMainCollectionViewCell.h"

@interface MLMainViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UIScrollViewDelegate
>

@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) UIImageView *imageView3;
@property (nonatomic, strong) UIImageView *imageView4;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self ml_createImageView];
    
    
    
    
    
    
    
    
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = self.view.bounds.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collectionView.pagingEnabled = YES;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:collectionView]; 
    
    UINib *nib = [UINib nibWithNibName:@"MLMainCollectionViewCell" bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:@"mainCollectionViewCell"];
    self.collectionView = collectionView;
    
    
    
#pragma mark - 注册按钮
    UIButton *regisButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:regisButton];
    [regisButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-30);
        make.left.equalTo(self.view).offset(30);
        make.width.equalTo(@120);
        make.height.equalTo(@45);
    }];
    [regisButton setTitle:@"注册" forState:UIControlStateNormal];
    regisButton.backgroundColor = [UIColor greenColor];
    regisButton.layer.cornerRadius = 10.0;
    [regisButton addTarget:self action:@selector(ml_registerAction:) forControlEvents:UIControlEventTouchUpInside];
    
#pragma mark - 登录按钮
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-30);
        make.right.equalTo(self.view).offset(-30);
        make.width.equalTo(@120);
        make.height.equalTo(@45);
    }];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    loginButton.backgroundColor = [UIColor whiteColor];
    loginButton.layer.cornerRadius = 10.0;
    [loginButton addTarget:self action:@selector(ml_loginButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *iconLabel = [[UILabel alloc] init];
    [self.view addSubview:iconLabel];
    [iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).offset(80);
        make.width.equalTo(@200);
        make.height.equalTo(@100);
        
    }];
    iconLabel.textAlignment = NSTextAlignmentCenter;
    iconLabel.textColor = [UIColor whiteColor];
    iconLabel.text = @"Gourd";
    iconLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:45];
    
    
    
    self.pageControl = [[UIPageControl alloc]init];
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.view addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view).offset(-75);
        make.height.equalTo(@55);
        make.width.equalTo(@100);
        
    }];
    _pageControl.numberOfPages = 4;
    _pageControl.currentPage = 0;
    
}




#pragma mark - 私有方法
- (void)ml_registerAction:(UIButton *)button {
    MLRegisterViewController *registerVC = [[MLRegisterViewController alloc] init];
    [self presentViewController:registerVC animated:YES completion:nil];
    
}
 
- (void)ml_loginButton:(UIButton *)button {
    MLLoginViewController *loginVC = [[MLLoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MLMainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mainCollectionViewCell" forIndexPath:indexPath];
    switch (indexPath.item) {
        case 0:
            cell.bigLabel.text = @"瓢瓢简聊";
            cell.mallLabel.text = @"用最平凡的文字说出最动人的语言";
            break;
            
        case 1:
            cell.bigLabel.text = @"苟且";
            cell.mallLabel.text = @"生活不止眼前的苟且，还有读不懂的诗和到不了的远方";
            break;
            
        case 2:
            cell.bigLabel.text = @"坚持";
            cell.mallLabel.text = @"世上无难事，只要肯放弃";
            break;
            
        case 3:
            cell.bigLabel.text = @"努力";
            cell.mallLabel.text = @"有时候你不努力一下，你都不知道什么叫绝望";
            break;
            
        default:
            break;
    }

    return cell;
    

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    
    CGFloat width = self.view.bounds.size.width;
    if (scrollView.contentOffset.x < width) {
        self.imageView4.alpha = 1 - scrollView.contentOffset.x / width;
    } else if (scrollView.contentOffset.x < 2 * width) {
        self.imageView3.alpha = 1 - (scrollView.contentOffset.x - width) / width;
    } else if (scrollView.contentOffset.x < 3 * width) {
        self.imageView2.alpha = 1 - (scrollView.contentOffset.x - 2 * width) / width;
    } else {
        self.imageView1.alpha = 1 - (scrollView.contentOffset.x - 3 * width) / width;
    }
    
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.currentPage = self.collectionView.contentOffset.x / self.view.bounds.size.width;
    

}

- (void)ml_createImageView {
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:imageView1];
    imageView1.image = [UIImage imageNamed:@"backImage4.jpg"];
    self.imageView1 = imageView1;
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:imageView2];
    imageView2.image = [UIImage imageNamed:@"backImage3.jpg"];
    self.imageView2 = imageView2;
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:imageView3];
    imageView3.image = [UIImage imageNamed:@"backImage2.jpg"];
    self.imageView3 = imageView3;
    
    UIImageView *imageView4 = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:imageView4];
    imageView4.image = [UIImage imageNamed:@"backImage1.jpg"];
    self.imageView4 = imageView4;
}

@end
