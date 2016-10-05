//
//  MLChatViewController.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/24.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLChatViewController.h"
#import "MLDetailChatViewController.h"
#import "MLTotalConversationTableViewCell.h"

@interface MLChatViewController ()
<
EMChatManagerDelegate,
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) NSMutableArray *conversationsArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MLChatViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self ml_reload];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消息";
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
    
    [self.view addSubview:self.tableView];
    
    
    
    UINib *nib = [UINib nibWithNibName:@"MLTotalConversationTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"TotalConversation"];
    
    

    
    NSUInteger unReadMessage = [[EaseMob sharedInstance].chatManager loadTotalUnreadMessagesCountFromDatabase];
    if (unReadMessage) {
        
        self.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd", unReadMessage];
    } else {
    
        self.navigationController.tabBarItem.badgeValue = nil;
    }
    
    
    
}

#pragma mark - 懒加载
- (NSMutableArray *)conversationsArray {
    if (!_conversationsArray) {

        _conversationsArray = [NSMutableArray array];

    }
    return _conversationsArray;

}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.frame = self.view.bounds;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 60;
        _tableView.backgroundColor = ColorWith243;
    }
    return _tableView;
}

#pragma mark - tableView协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.conversationsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MLTotalConversationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TotalConversation"];
    

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.conversation = _conversationsArray[indexPath.row];
    return cell;

}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MLDetailChatViewController *detailVC = [[MLDetailChatViewController alloc] init];
    
    EMConversation *conversation = _conversationsArray[indexPath.row];
    detailVC.userName = [conversation chatter];
    [self.navigationController pushViewController:detailVC animated:YES];

    
}


#pragma mark - 监听网络状态以及掉线重连效果

- (void)didConnectionStateChanged:(EMConnectionState)connectionState {

    switch (connectionState) {
        case eEMConnectionConnected:
            self.title = @"消息";
            break;
        case eEMConnectionDisconnected:
            self.title = @"消息(未连接)";
            break;
            
        default:
            break;
    }
}
- (void)willAutoReconnect {
    self.title = @"连接中...";

}

- (void)didAutoReconnectFinishedWithError:(NSError *)error {
    if (!error) {
        self.title = @"消息";
    } else {
        self.title = @"消息(未连接)";
    }

}


#pragma mark - 监控回话列表改变
//- (void)didUpdateConversationList:(NSArray *)conversationList {
//
//    NSLog(@"11");
//    [self ml_reload];
//
//}

#pragma mark - 监控未读消息数改变
- (void)didUnreadMessagesCountChanged {
    
    [self ml_reload];
    NSUInteger unReadMessage = [[EaseMob sharedInstance].chatManager loadTotalUnreadMessagesCountFromDatabase];
    if (unReadMessage) {
        
        self.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd", unReadMessage];
    } else {
        self.navigationController.tabBarItem.badgeValue = nil;
    
    }

}
#pragma mark - 私有方法
- (void)ml_reload {

    [self.conversationsArray removeAllObjects];
    
    NSArray *array = [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:YES];
    [self.conversationsArray addObjectsFromArray:array];
    
    [self.tableView reloadData];
}

@end
