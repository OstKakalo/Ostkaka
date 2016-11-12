//
//  MLBlackNameViewController.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/11/12.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLBlackNameViewController.h"


static NSString *const cellIdentifier = @"blackCell";

@interface MLBlackNameViewController ()
<
UITableViewDelegate,
UITableViewDataSource

>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *blackBuddyArray;

@end

@implementation MLBlackNameViewController

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 100;
        [_tableView ml_setbackViewDayAndNight];
    }
    return _tableView;


}

- (NSArray *)blackBuddyArray {
    EMError *error = nil;
    NSArray *blockedList = [[EaseMob sharedInstance].chatManager fetchBlockedList:&error];
    if (!error) {
        NSLog(@"获取成功 -- %@",blockedList);
        _blackBuddyArray = blockedList;
    }
    
    return _blackBuddyArray;


}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view ml_setbackViewDayAndNight];
    [self createFootView];
    
    
    
    [self refrash];
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.blackBuddyArray.count;
    

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        [cell ml_setFrontViewDayAndNight];
        
        cell.textLabel.text = self.blackBuddyArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.textLabel ml_setLabelDayAndNight];
    }
    return cell;

}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        EMError *error = [[EaseMob sharedInstance].chatManager unblockBuddy:self.blackBuddyArray[indexPath.row]];
        if (!error) {
            
            NSLog(@"发送成功");
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        
        }

    }
 
    [self refrash];

}

- (void)createFootView {
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 200) / 2, 0, 200, 50)];
    label.text = @"左滑可以移除黑名单哦";
    [label jxl_setDayMode:^(UIView *view) {
        UILabel *label = (UILabel *)view;
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor blackColor];
    } nightMode:^(UIView *view) {
        UILabel *label = (UILabel *)view;
        label.backgroundColor = ColorWithBackGround;
        label.textColor = ColorWith243;
    }];
    [footView addSubview:label];
    self.tableView.tableFooterView = footView;
    
    
    


}

- (void)refrash {
    if (!self.blackBuddyArray.count) {
        [self.tableView removeFromSuperview];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 100, SCREEN_HEIGHT / 2 - 50, 200, 50)];
        label.text = @"黑名单为空";
        [label jxl_setDayMode:^(UIView *view) {
            UILabel *label = (UILabel *)view;
            label.backgroundColor = [UIColor whiteColor];
            label.textColor = [UIColor blackColor];
        } nightMode:^(UIView *view) {
            UILabel *label = (UILabel *)view;
            label.backgroundColor = ColorWithBackGround;
            label.textColor = ColorWith243;
        }];
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
    }
    [self.tableView reloadData];


}

@end
