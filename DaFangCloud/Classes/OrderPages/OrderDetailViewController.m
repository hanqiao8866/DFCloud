//
//  OrderDetailViewController.m
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/19.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailHeaderTableViewCell.h" // 详情头部cell
#import "OrderDetailTraceTableViewCell.h" // 订单跟踪cell
#import "OrderDetailTextTableViewCell.h" // 订单内容cell
#import "OrderDetailDescriptionTableViewCell.h" // 节点描述cell
#import "OrderDetailFileTableViewCell.h" // 附件cell
#import "NodeModel.h" // 节点模型
#import "OrderModel.h" // 订单模型
#import "FileModel.h" // 文件模型
#import "NodeDetailViewController.h" // 节点详情
#import "NodeAddViewController.h" // 添加节点

@interface OrderDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (nonatomic, strong) NSMutableArray *nodeArray; // 节点数据源
@property (nonatomic, strong) OrderModel *orderModel;
@property (nonatomic, strong) NSMutableArray *fileArray; // 附件数据源


@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configureNavgationItemTitle:@"订单详情"];
    WEAKSELF
    [self configureBackButtonWithAction:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    if (self.nodeArray == nil) {
        self.nodeArray = [NSMutableArray array];
    }
    
    if (self.fileArray == nil) {
        self.fileArray = [NSMutableArray array];
    }
    
    [self.listTableView registerClass:[OrderDetailHeaderTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderDetailHeaderTableViewCell class])];
    [self.listTableView registerClass:[OrderDetailTraceTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderDetailTraceTableViewCell class])];
    [self.listTableView registerClass:[OrderDetailTextTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderDetailTextTableViewCell class])];
    [self.listTableView registerClass:[OrderDetailDescriptionTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderDetailDescriptionTableViewCell class])];
    [self.listTableView registerClass:[OrderDetailFileTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderDetailFileTableViewCell class])];
    
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.listTableView.backgroundColor = ColorWithRGB(246, 246, 246);
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self loadPageData];
    
    self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadPageData];
    }];
}

- (void)loadPageData {
    if (self.orderModel == nil) {
        self.orderModel = [[OrderModel alloc] init];
        self.orderModel.orderName = @"恒有源地能云采购订单";
        self.orderModel.orderNumber = @"TY793832893809283";
        self.orderModel.orderDate = @"2017/10/17";
        self.orderModel.orderPrice = @"￥16,432";
        self.orderModel.orderProgress = @"30%";
        self.orderModel.orderStatus = @"生产中"; // 订单状态
        self.orderModel.orderClient = @"北京数码好利";
        self.orderModel.orderContent = @"今天洽谈项目合作，意向达成并提交了合作意向定金，企业采购部门向供应商发出的定货凭据（包含成品、原材料、燃料、零部件、办公用品、服务等全部采购过程）。订单类型由于订单类型可以指定处理规则和订单分。"; // 订单内容
        self.orderModel.orderDescription = @"10月底必须完成"; // 订单描述
    }
    
    for (int i = 0; i < 6; i++) {
        NodeModel *model = [[NodeModel alloc] init];
        model.nodeName = [NSString stringWithFormat:@"节点%d", i+1];
        model.nodeContent = @"今天洽谈项目合作，意向达成并提交了合作意向定金，企业采购部门向供应商发出的定货凭据（包含成品、原材料、燃料、零部件、办公用品、服务等全部采购过程）。";
        model.nodeDate = @"2017/10/17";
        [self.nodeArray addObject:model];
    }
    
    for (int i = 0; i < 3; i++) {
        FileModel *model = [[FileModel alloc] init];
        model.fileName = @"合同附件.PDF";
        [self.fileArray addObject:model];
    }
    
    [self.listTableView.mj_header endRefreshing];
    [self.listTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger number;
    if (section == 0) {
        number = 1;
    } else if (section == 1) {
        number = self.nodeArray.count;
    } else if (section == 2 || section == 3) {
        number = 1;
    } else {
        number = self.fileArray.count;
    }
    return number;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height;
    if (indexPath.section == 0) {
        height = [self.listTableView cellHeightForIndexPath:indexPath model:self.orderModel keyPath:@"model" cellClass:[OrderDetailHeaderTableViewCell class] contentViewWidth:MainScreenWidth];
    } else if (indexPath.section == 1) {
//        NodeModel *model = self.nodeArray[indexPath.row];
//        height = [self.listTableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[OrderDetailTraceTableViewCell class] contentViewWidth:MainScreenWidth];
        height = 120;
    } else if (indexPath.section == 2) {
        height = [self.listTableView cellHeightForIndexPath:indexPath model:self.orderModel keyPath:@"model" cellClass:[OrderDetailTextTableViewCell class] contentViewWidth:MainScreenWidth];
    } else if(indexPath.section == 3) {
        height = [self.listTableView cellHeightForIndexPath:indexPath model:self.orderModel keyPath:@"model" cellClass:[OrderDetailDescriptionTableViewCell class] contentViewWidth:MainScreenWidth];
    } else {
        FileModel *model = self.fileArray[indexPath.row];
        height = [self.listTableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[OrderDetailFileTableViewCell class] contentViewWidth:MainScreenWidth];
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return [[UIView alloc] init];
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 40)];
    view.backgroundColor = ColorWithRGB(246, 246, 246);
    UILabel *label = [ToolBoxView creatLabelWithFrame:CGRectMake(20, 0, MainScreenWidth-40, 40) andTextColor:[UIColor colorWithHexString:@"#485465"] andTextFont:[UIFont systemFontOfSize:15] toView:view];
    if (section == 1) {
        label.text = @"订单跟踪";
    } else if (section == 2) {
        label.text = @"订单内容";
    } else if (section == 3) {
        label.text = @"节点描述";
    } else if (section == 4) {
        label.text = @"附件";
    }
    
    return view;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        OrderDetailHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailHeaderTableViewCell class])];
        cell.model = self.orderModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        return cell;
        
    } else if (indexPath.section == 1) {
        NodeModel *model = self.nodeArray[indexPath.row];
        OrderDetailTraceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailTraceTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        if (indexPath.row == 0) {
            cell.bigImageView.hidden = NO;
            cell.vLine1.hidden = YES;
        }
        [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        return cell;
    } else if (indexPath.section == 2) {
        OrderDetailTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailTextTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.orderModel;
        [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        return cell;
    } else if (indexPath.section == 3) {
        OrderDetailDescriptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailDescriptionTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.orderModel;
        [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        return cell;
    } else {
        FileModel *model = self.fileArray[indexPath.row];
        OrderDetailFileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailFileTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        return cell;
    }
    return [[UITableViewCell alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        NodeModel *model = self.nodeArray[indexPath.row];
        NodeDetailViewController *nodeDetailVC = [[NodeDetailViewController alloc] init];
        [self pushNewViewController:nodeDetailVC];
    }
}

- (IBAction)addNodeClick:(UIButton *)sender {
    NodeAddViewController *nodeAddVC = [[NodeAddViewController alloc] init];
    [self pushNewViewController:nodeAddVC];
}





@end
