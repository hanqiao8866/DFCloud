//
//  NodeDetailViewController.m
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/21.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import "NodeDetailViewController.h"
#import "SubTitleView.h"
#import "NodeDetailHeaderTableViewCell.h"
#import "NodeDetailDynamicTableViewCell.h"
#import "NodeDetailFileTableViewCell.h"
#import "NodeModel.h"
#import "CommentModel.h"
#import "ResultModel.h"


@interface NodeDetailViewController ()<UITableViewDelegate, UITableViewDataSource, SubTitleViewDelegate, NodeDetailHeaderTableViewCellDelegate> {
    int scrollFlag; // 0表示加载动态 1表示加载文件
}

@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (nonatomic, retain) SubTitleView *subTitleView;
@property (nonatomic, strong) NSMutableArray *dynamicDataArray; // 动态数据源
@property (nonatomic, strong) NSMutableArray *fileDataArray; // 文件数据源
@property (nonatomic, strong) NodeModel *nodeModel;

@end

@implementation NodeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureNavgationItemTitle:@"节点详情"];
    WEAKSELF
    [self configureBackButtonWithAction:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.listTableView registerClass:[NodeDetailHeaderTableViewCell class] forCellReuseIdentifier:NSStringFromClass([NodeDetailHeaderTableViewCell class])];
    [self.listTableView registerClass:[NodeDetailDynamicTableViewCell class] forCellReuseIdentifier:NSStringFromClass([NodeDetailDynamicTableViewCell class])];
    [self.listTableView registerClass:[NodeDetailFileTableViewCell class] forCellReuseIdentifier:NSStringFromClass([NodeDetailFileTableViewCell class])];
    
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.listTableView.backgroundColor = ColorWithRGB(244, 244, 244);
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    // 初始化
    scrollFlag = 0;
    
    
    self.fileDataArray = [[NSMutableArray alloc] init];
    self.dynamicDataArray = [[NSMutableArray alloc] init];
    
    self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadPageData];
    }];
    
    [self loadPageData];

}

- (void)loadPageData {
    if (self.nodeModel == nil) {
        self.nodeModel = [[NodeModel alloc] init];
        self.nodeModel.nodeName = @"阀门采购订单装配任务";
        self.nodeModel.nodeDate = @"2017/12/12";
        self.nodeModel.nodePerson = @"李晓琳";
        self.nodeModel.nodeStatus = @"已开始";
    }
    
    for (int i = 0; i < 5; i++) {
        CommentModel *model = [[CommentModel alloc] init];
        model.title = @"设计";
        model.content = @"设计图已经完成，请施工方面查看一下";
        model.date = @"2017-10-20";
        [self.dynamicDataArray addObject:model];
    }
    
    for (int i = 0; i < 8; i++) {
        ResultModel *model = [[ResultModel alloc] init];
        model.fileName = @"采购合同.pdf";
        model.fileSize = @"1.3M";
        model.date = @"2017-10-20";
        [self.fileDataArray addObject:model];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger number;
    if (section == 0) {
        number = 1;
    } else {
        if (scrollFlag == 0) {
            number = self.dynamicDataArray.count;
        } else {
            number = self.fileDataArray.count;
        }
    }
    return number;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 46;
    }
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 46.0f)];
        view.backgroundColor = [UIColor colorWithHexString:@"#F4F7F8"];
        
        self.subTitleView = [[SubTitleView alloc] init];
        self.subTitleView.delegate = self;
        self.subTitleView.titleArray = [@[@"动态",@"文件"] mutableCopy];
        [view addSubview:self.subTitleView];
        if (scrollFlag == 0) {
            [self.subTitleView translateShowAtIndex:0];
        } else if (scrollFlag == 1) {
            [self.subTitleView translateShowAtIndex:1];
        }
        self.subTitleView.sd_layout
        .leftSpaceToView(view, 0)
        .topSpaceToView(view, 0)
        .rightSpaceToView(view, 0)
        .bottomSpaceToView(view, 0);
        return view;
    }
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height;
    if (indexPath.section == 0) {
        height = [self.listTableView cellHeightForIndexPath:indexPath model:self.nodeModel keyPath:@"model" cellClass:[NodeDetailHeaderTableViewCell class] contentViewWidth:MainScreenWidth];
    } else{
        if (scrollFlag == 0) {
            CommentModel *model = self.dynamicDataArray[indexPath.row];
            height = [self.listTableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[NodeDetailDynamicTableViewCell class] contentViewWidth:MainScreenWidth];
        } else {
            ResultModel *model = self.fileDataArray[indexPath.row];
            height = [self.listTableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[NodeDetailFileTableViewCell class] contentViewWidth:MainScreenWidth];
        }
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NodeDetailHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NodeDetailHeaderTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.nodeModel;
        cell.delegate = self;
        [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        return cell;
    } else  {
        if (scrollFlag == 0) {
            CommentModel *model = self.dynamicDataArray[indexPath.row];
            NodeDetailDynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NodeDetailDynamicTableViewCell class])];
            cell.model = model;
            [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        } else {
            ResultModel *nodemodel = self.fileDataArray[indexPath.row];
            NodeDetailFileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NodeDetailFileTableViewCell class])];
            cell.model = nodemodel;
            [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    return [[UITableViewCell alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)subTitleViewDidSelected:(SubTitleView *)titleView atIndex:(NSInteger)index title:(NSString *)title {
    DLog(@"findSubTitle AtIndex: %ld titleString:%@",(long)index,title);
    if (index == 0) {
        scrollFlag = 0;
    } else if (index == 1) {
        scrollFlag = 1;
    }
    [self.listTableView reloadData];
}

#pragma mark --NodeDetailHeaderTableViewCellDelegate
- (void)taskBtnClick:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"操作完成" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}





@end
