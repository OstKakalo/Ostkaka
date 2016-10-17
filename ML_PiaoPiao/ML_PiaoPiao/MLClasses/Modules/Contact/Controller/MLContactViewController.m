//
//  MLContactViewController.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/24.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLContactViewController.h"
#import "MLAddFrendViewController.h"
#import "MLMenuTableViewCell.h"
#import "MLFriendsTableViewCell.h"
#import "MLContactDetailViewController.h"

@interface MLContactViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
EMChatManagerDelegate
>




@end




@implementation MLContactViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加好友
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(ml_addFrend)];
    
    // 标题
    self.title = @"联系人";
    
    // tableView
    [self ml_createTableView];
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
    [self.view ml_setbackViewDayAndNight];
  
}


#pragma mark -懒加载
- (NSMutableArray *)friendsArray {
    if (!_friendsArray) {
        _friendsArray = [NSMutableArray array];
        
        
        [[EaseMob sharedInstance].chatManager asyncFetchBuddyListWithCompletion:^(NSArray *buddyList, EMError *error) {
            if (!error) {
                NSLog(@"获取成功 -- %@",buddyList);
                if (buddyList.count) {
                    [_friendsArray addObjectsFromArray:buddyList];
                }
            }
        } onQueue:nil];
        
        
    }
    
    return _friendsArray;
    
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (0 == section) {
        return 1;
    } else {
        
        return self.friendsArray.count;
    
    }

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (0 == indexPath.section) {

        MLMenuTableViewCell *cell = [MLMenuTableViewCell ml_menuTableViewCellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell ml_setFrontViewDayAndNight];
        return cell;

    } else {
        MLFriendsTableViewCell *cell = [MLFriendsTableViewCell ml_friendsTableViewCellWithTableView:tableView];
        cell.buddy = self.friendsArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell ml_setFrontViewDayAndNight];
        return cell;

    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    } else {
        return 50;
    
    }
    


}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        MLContactDetailViewController *detailVC = [MLContactDetailViewController ml_contactDetailVC];
        detailVC.buddy = _friendsArray[indexPath.row];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            EMBuddy *buddy = _friendsArray[indexPath.row];
            EMError *error = nil;
            // 删除好友
            BOOL isSuccess = [[EaseMob sharedInstance].chatManager removeBuddy:buddy.username removeFromRemote:YES error:&error];
            if (isSuccess && !error) {
                NSLog(@"删除成功");
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
    }
    


}

#pragma mark - 私有方法
- (void)ml_addFrend {
    MLAddFrendViewController *addFriendVC = [[MLAddFrendViewController alloc] init];
    [self.navigationController pushViewController:addFriendVC animated:YES];
    
    
    

}
- (void)ml_createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = ColorWith243;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView ml_setbackViewDayAndNight];

}



#pragma mark - 监听好友列表
- (void)didUpdateBuddyList:(NSArray *)buddyList
              changedBuddies:(NSArray *)changedBuddies
                     isAdd:(BOOL)isAdd {

    [self.friendsArray removeAllObjects];
    [_friendsArray addObjectsFromArray:buddyList];
    [_tableView reloadData];

}



@end
