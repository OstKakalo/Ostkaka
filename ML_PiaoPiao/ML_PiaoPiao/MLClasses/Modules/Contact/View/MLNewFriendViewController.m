//
//  MLNewFriendViewController.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/24.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLNewFriendViewController.h"
#import "MLNewFriendTableViewCell.h"
#import "MLTabBarViewController.h"

static NSString *const NewFriendID = @"NewFriend";
@interface MLNewFriendViewController ()
<
UITableViewDelegate,
UITableViewDataSource

>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *newsFriendArray;
@end

@implementation MLNewFriendViewController




- (NSMutableArray *)newsFriendArray {
    if (!_newsFriendArray) {
        _newsFriendArray = [NSMutableArray array];
        
    }
    return _newsFriendArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"新朋友";
    
    [self.newsFriendArray removeAllObjects];
    [self.newsFriendArray addObjectsFromArray:_requestArray];
    
    [self ml_createTableView];
    
    
    
}



#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsFriendArray.count;
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MLNewFriendTableViewCell *cell = [MLNewFriendTableViewCell ml_newFriendWithTableView:tableView];
    cell.requestInfo = self.requestArray[indexPath.row];
    return cell;
    
}

#pragma mark - 私有方法
- (void)ml_createTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.rowHeight = 100;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

@end
