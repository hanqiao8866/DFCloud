//
//  MyCreatOrderViewController.m
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/18.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import "MyCreatOrderViewController.h"
#import "OrderModel.h"
#import "OrderTableViewCell.h"
#import "OrderDetailViewController.h"

@interface MyCreatOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (nonatomic, strong)NSMutableArray *dataSourceArray;


@end

@implementation MyCreatOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureNavgationItemTitle:@"我的订单"];
    WEAKSELF
    [self configureBackButtonWithAction:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    if (self.dataSourceArray == nil) {
        self.dataSourceArray = [NSMutableArray array];
    }
    
    [self.listTableView registerClass:[OrderTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderTableViewCell class])];
    
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.listTableView.backgroundColor = ColorWithRGB(246, 246, 246);
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self loadPageData];
    
    self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadPageData];
    }];
    
}

- (void)loadPageData {
    for (int i = 0; i < 20; i++) {
        OrderModel *model = [[OrderModel alloc] init];
        model.orderName = @"恒有源地能云采购订单";
        model.orderNumber = @"TY793832893809283";
        model.orderDate = @"2017/10/17";
        model.orderPrice = @"￥16,432";
        model.orderProgress = @"30%";
        [self.dataSourceArray addObject:model];
    }
    NSLog(@"%ld",self.dataSourceArray.count);
    [self.listTableView.mj_header endRefreshing];
    [self.listTableView reloadData];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderModel *model = self.dataSourceArray[indexPath.row];
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderTableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    return cell;
}

/** 计算行高 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderModel *model = self.dataSourceArray[indexPath.row];
    return [self.listTableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[OrderTableViewCell class] contentViewWidth:MainScreenWidth];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OrderDetailViewController *detailVC = [[OrderDetailViewController alloc] init];
    [self pushNewViewController:detailVC];
}





@end
