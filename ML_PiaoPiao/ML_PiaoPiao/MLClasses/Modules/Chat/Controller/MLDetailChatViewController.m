//
//  MLDetailChatViewController.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/26.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLDetailChatViewController.h"
#import "MLInputView.h"
#import "MLConversation.h"
#import "MLConversationFrame.h"
#import "MLConversationTableViewCell.h"

static NSString *const ID = @"mlconversation";

@interface MLDetailChatViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate
>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MLInputView *inputView;

@property (nonatomic, strong) NSMutableArray *messagesArray;
@end

@implementation MLDetailChatViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 添加子控件
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.inputView];
    
    self.title = self.buddy.username;
    
    // 刷新
    [self ml_reload];
    // 监控键盘
    [self ml_keyBoardMove];
    
    // 注册
    [self.tableView registerClass:[MLConversationTableViewCell class] forCellReuseIdentifier:ID];
    
    
    
    
    
}
- (void)viewDidAppear:(BOOL)animated {
    [self ml_scrollToBottom];

}


#pragma mark - 结束编辑状态

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];

}


#pragma mark - 操控tabBar消失出现
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
}


#pragma mark - 懒加载


- (NSMutableArray *)messagesArray {
    
    if (!_messagesArray) {
        _messagesArray = [NSMutableArray array];
        
    }
    return _messagesArray;
}
- (UIView *)inputView {
    if (!_inputView) {
        _inputView = [MLInputView ml_inputView];
        _inputView.frame = CGRectMake(0, self.view.bounds.size.height - 50 , self.view.bounds.size.width, 50);
        _inputView.textField.delegate = self;
        
    }
    return _inputView;
    
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 50);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = ColorWith243;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
    }
    return _tableView;
    
}

#pragma mark - textField代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    
    
    EMChatText *textChat = [[EMChatText alloc] initWithText:textField.text];
    
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithChatObject:textChat];
    
    EMMessage *message = [[EMMessage alloc] initWithReceiver:self.buddy.username bodies:@[body]];
   
    
    
    [[EaseMob sharedInstance].chatManager asyncSendMessage:message progress:nil prepare:^(EMMessage *message, EMError *error) {
        //
    } onQueue:nil completion:^(EMMessage *message, EMError *error) {
        //
        if (!error) {
            
            textField.text = nil;
            [textField resignFirstResponder];
            [self ml_reload];
        }
    } onQueue:nil];


    return YES;
}



#pragma mark - tableView代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [self.messagesArray[indexPath.row] cellH];


}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messagesArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MLConversationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    [cell setConversationFrame:_messagesArray[indexPath.row]];
    
    return cell;
}

#pragma mark - 私有方法

- (void)ml_keyBoardMove {
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillChangeFrameNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"note %@, note %@",note , [note class]);
        /*
         {name = UIKeyboardWillChangeFrameNotification; userInfo = {
         UIKeyboardAnimationCurveUserInfoKey = 7;
         UIKeyboardAnimationDurationUserInfoKey = "0.25";
         UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {414, 271}}";
         UIKeyboardCenterBeginUserInfoKey = "NSPoint: {207, 871.5}";
         UIKeyboardCenterEndUserInfoKey = "NSPoint: {207, 600.5}";
         UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 736}, {414, 271}}";
         UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 465}, {414, 271}}";
         UIKeyboardIsLocalUserInfoKey = 1;
         }}

         */
        CGFloat endY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
        CGFloat itemY = endY - self.view.bounds.size.height ;
        CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0, itemY, self.view.bounds.size.width, self.view.bounds.size.height);
        
        }];
        
        
        
        
        
        
    }];
}

- (void)ml_reload {
    
    [self.messagesArray removeAllObjects];
    
     EMConversation *conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:self.buddy.username conversationType:eConversationTypeChat];
    
    NSArray *messages = [conversation loadAllMessages];
    
    for (EMMessage *message in messages) {
        MLConversation *conversation = [[MLConversation alloc] init];
        conversation.message = message;
        MLConversationFrame *conversationFrame = [[MLConversationFrame alloc] init];
        conversationFrame.conversation = conversation;
        [self.messagesArray addObject:conversationFrame];
    }
    
    [_tableView reloadData];
    
    
    // 滑动到最底端
    [self ml_scrollToBottom];

}


- (void)ml_scrollToBottom {
    if (!self.messagesArray.count) {
        
        return ;
    }
    
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_messagesArray.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];


}
@end
