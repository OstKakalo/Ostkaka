//
//  MLPlayViewController.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/10/8.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLPlayViewController.h"
#import "MLInfo.h"
#import "MLData.h"
#import "MLList.h"
#import "MLPlayHeaderView.h"
#import "MLPlayTableViewCell.h"
#import "MLPlayTableViewCellSecond.h"
@interface MLPlayViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *cellArray;

@property (nonatomic, strong) MLPlayHeaderView *playHeaderView;

@property (nonatomic, assign) int page;
@end

@implementation MLPlayViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
    
}


    

    



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"瓢瓢娱乐";
    
    
    [self.view addSubview:self.tableView];
    
 
    
    UINib *nib = [UINib nibWithNibName:@"MLPlayTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"playTableViewCell"];
    UINib *nibSecond = [UINib nibWithNibName:@"MLPlayTableViewCellSecond" bundle:nil];
    [self.tableView registerNib:nibSecond forCellReuseIdentifier:@"playTableViewCellSecond"];
    

    
    self.page = 1;
    
    [self ml_getDataWith:_page];
    

    [self.view ml_setbackViewDayAndNight];
    
    
    
    
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = ColorWith243;
        _tableView.tableHeaderView = self.playHeaderView;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(ml_topRefrash)];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(ml_bottomRefrash)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;

}

- (MLPlayHeaderView *)playHeaderView {
    if (!_playHeaderView) {
        _playHeaderView = [[MLPlayHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 2)];
        
    }
    return _playHeaderView;

}
- (NSMutableArray *)cellArray {
    if (!_cellArray) {
        _cellArray = [NSMutableArray array];
    }
    return _cellArray;
}










#pragma mark - tableView协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.cellArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MLList *list = self.cellArray[indexPath.row];
    if ([list.display isEqualToString:@"0"]) {
        MLPlayTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"playTableViewCell"];
        cell.title.text = list.title;
        [cell.bigImage sd_setImageWithURL:[MLSeparateImageURL ml_URLWithFailueString:list.pic]];
        [cell.icon sd_setImageWithURL:[MLSeparateImageURL ml_URLWithFailueString:list.icon]];
        cell.smallName.text = list.name;
        cell.readNum.text = list.readnum;
        tableView.rowHeight = 150;
        [cell ml_setbackViewDayAndNight];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if([list.display isEqualToString:@"1"]) {
    
        tableView.rowHeight = 300;
        MLPlayTableViewCellSecond *cell = [tableView dequeueReusableCellWithIdentifier:@"playTableViewCellSecond"];
        cell.title.text = list.title;
        [cell.bigImage sd_setImageWithURL:[MLSeparateImageURL ml_URLWithFailueString:list.pic]];
        [cell.icon sd_setImageWithURL:[MLSeparateImageURL ml_URLWithFailueString:list.icon]];
        cell.name.text = list.name;
        cell.readNum.text = list.readnum;
        [cell ml_setbackViewDayAndNight];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    return nil;
    
    
}


#pragma mark - 私有方法
- (void)ml_getDataWith:(int)page {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"http://api.app.happyjuzi.com/article/list/home?accesstoken=b5f2249b18162156766e6770f6707ad3&net=wifi&page=%d&pf=ios&res=320x568&size=20&uid=4028401393042916&ver=3.4", page] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        MLData *data = [MLData mj_objectWithKeyValues:responseObject[@"data"]];
        ;
        self.playHeaderView.infos = data.info;
        
        
        
        for (MLList *list in data.list) {
            if ([list.type isEqualToString:@"0"]) {
                if ([list.display isEqualToString:@"0"] || [list.display isEqualToString:@"1"]) {
                    [self.cellArray addObject:list];
                }
            }
        }
        [self.tableView reloadData];
        

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    

}

- (void)ml_topRefrash {
    

        self.page = 1;
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:[NSString stringWithFormat:@"http://api.app.happyjuzi.com/article/list/home?accesstoken=b5f2249b18162156766e6770f6707ad3&net=wifi&page=%d&pf=ios&res=320x568&size=20&uid=4028401393042916&ver=3.4", _page] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            MLData *data = [MLData mj_objectWithKeyValues:responseObject[@"data"]];
            ;
            self.playHeaderView.infos = data.info;
            [self.cellArray removeAllObjects];
            for (MLList *list in data.list) {
                if ([list.type isEqualToString:@"0"]) {
                    if ([list.display isEqualToString:@"0"] || [list.display isEqualToString:@"1"]) {
                        [self.cellArray addObject:list];
                    }
                }
            }
            [self.tableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
        
        [self.tableView.mj_header endRefreshing];
   


}

- (void)ml_bottomRefrash {
    

    _page+=1;
    [self ml_getDataWith:_page];

    [self.tableView.mj_footer endRefreshing];


}

@end
