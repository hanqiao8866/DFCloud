//
//  MainViewController.m
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/12.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import "MainViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <UShareUI/UShareUI.h>

#import "LeftInfoViewController.h"
#import "CompanyTableViewCell.h"
#import "CompanyModel.h"
#import "OrderMainViewController.h"
#import "CustomAnnotationView.h"

#import "SearchViewController.h" // 搜索

#import "UserInfoViewController.h" // 用户信息
#import "MyAttentionViewController.h" // 我的关注
#import "BrowserHistoryViewController.h"  // 浏览记录
#import "MyCompanyViewController.h" // 我的企业
#import "SuppliersViewController.h" // 供应商
#import "MyMessageViewController.h" // 我的消息
#import "MyCerticatifyViewController.h" // 我的认证
#import "SettingViewController.h" // 设置

#import "CompanyDetailViewController.h" // 企业详情

@interface MainViewController ()<MAMapViewDelegate, UMSocialShareMenuViewDelegate, UITableViewDelegate, UITableViewDataSource> {
    MAMapView *_mapView;
}

@property(nonatomic, strong) LeftInfoViewController *leftVC;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSourceArray; // 列表假数据
@property (nonatomic, strong)NSMutableArray *testSourceArray; // 地图上假数据 和上边列表假数据是同一个数据源，为了演示区分开来，真实数据由接口提供

@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"首页"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"首页"];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 添加标注数据对象
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *titleView = [UIView new];
    titleView.frame = CGRectMake(0, 0, 80, 44);
    UIImageView *location_icon = [ToolBoxView creatImageViewWithImageName:@"location_icon" toView:titleView];
    UILabel *titleLabel = [ToolBoxView creatLabelWithTextColor:[UIColor whiteColor] andTextFont:[UIFont fontWithName:@"Helvetica Neue" size:20.0f] toView:titleView];
    titleLabel.text = @"北京";
    location_icon.frame = CGRectMake(5, 11, 18, 22);
    titleLabel.frame = CGRectMake(28, 0, 52, 44);
    
    self.navigationItem.titleView = titleView;
    
    [self configureLeftBarButtonWithImageName:@"menu" action:^{
        DLog(@"左边按钮点击");
        [self configureLeftView];
    }];
    
   
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithImage:ImageNamed(@"company_btn_icon") style:UIBarButtonItemStylePlain target:self action:@selector(companyBtnClick)];
    UIBarButtonItem *rightButtonItem2 = [[UIBarButtonItem alloc] initWithImage:ImageNamed(@"order_btn_icon") style:UIBarButtonItemStylePlain target:self action:@selector(orderBtnClick)];
    self.navigationItem.rightBarButtonItems = @[rightButtonItem, rightButtonItem2];
    
    /// 地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    /// 初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    DLog(@"%f", self.view.bounds.size.height);
    _mapView.delegate = self;
    /// 把地图添加至view
    [self.view addSubview:_mapView];
    /// 显示地图定位蓝点
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    [self setMapDataAndView];
    
}

// 设置搜索部分
- (void)setSearchUI {
    UIView *searchBgView = [ToolBoxView creatViewWithBackgroundColor:[UIColor whiteColor] toView:self.view];
    searchBgView.layer.shadowColor = [UIColor colorWithHexString:@"#E8EEFF"].CGColor;//shadowColor阴影颜色
    searchBgView.layer.shadowOffset = CGSizeMake(5,10);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    searchBgView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    searchBgView.layer.shadowRadius = 6;//阴影半径，默认3
    searchBgView.layer.cornerRadius = 6.0;
    UIImageView *searchIcon = [ToolBoxView creatImageViewWithImageName:@"search_icon" toView:searchBgView];
    UILabel *placeLabel = [ToolBoxView creatLabelWithTextColor:[UIColor colorWithHexString:@"#BFC9CC"] andTextFont:[UIFont systemFontOfSize:14] toView:searchBgView];
    placeLabel.text = @"请输入企业名称";
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn addTarget:self action:@selector(searchBarCancel) forControlEvents:UIControlEventTouchUpInside];
    [searchBgView addSubview:searchBtn];
    searchBgView.sd_layout.leftSpaceToView(self.view, 0).topSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).heightIs(50);
    searchIcon.sd_layout.leftSpaceToView(searchBgView, 20).topSpaceToView(searchBgView, 15).heightIs(20).widthIs(20);
    placeLabel.sd_layout.leftSpaceToView(searchIcon, 10).topSpaceToView(searchBgView, 0).heightIs(50).widthIs(150);
    searchBtn.sd_layout.leftSpaceToView(searchBgView, 0).topSpaceToView(searchBgView, 0).rightSpaceToView(searchBgView, 0).heightIs(50);
    
}

- (void)searchBarCancel {
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self pushNewViewController:searchVC];
}

- (void)setMapDataAndView {
    // 假数据
    
    self.testSourceArray = [NSMutableArray array];
    
    CompanyModel *comModel = [[CompanyModel alloc] init];
    comModel.sid = @"1";
    comModel.title = @"小林工坊";
    comModel.imagePath = @"http://deyang.gongyeyun.com/CloudFile//ShopFile//logo//1386142881917////120131241046844209.jpg";
    comModel.longtitude = @"116.403905830196";
    comModel.latitude = @"39.9151754663074";
    comModel.address = @"北京市东城区天安门";
    [self.testSourceArray addObject:comModel];
    
    comModel = [[CompanyModel alloc] init];
    comModel.sid = @"1";
    comModel.title = @"数码大方科技股份有限公司";
    comModel.imagePath = @"http://deyang.gongyeyun.com/CloudFile//Resouce//2014//1-16////gongfang5.gif";
    comModel.longtitude = @"116.239677801022";
    comModel.latitude = @"40.0331620450779";
    comModel.address = @"北京市海淀区北京数码大方科技股份有限公司";
    [self.testSourceArray addObject:comModel];
    
    comModel = [[CompanyModel alloc] init];
    comModel.sid = @"1";
    comModel.title = @"精益初创企业";
    comModel.imagePath = @"http://deyang.gongyeyun.com/CloudFile//2016//3//4//14//2016030414483848381_2016030402483887CJEFS1R0.jpg";
    comModel.longtitude = @"116.41486751816";
    comModel.latitude = @"40.049592987313";
    comModel.address = @"清河";
    [self.testSourceArray addObject:comModel];
    
    comModel = [[CompanyModel alloc] init];
    comModel.sid = @"1";
    comModel.title = @"葡萄紫了工作室";
    comModel.imagePath = @"http://deyang.gongyeyun.com/CloudFile//2016//6//6//14//2016060614331733171_2016060602331783CK2VCLJ4.jpg";
    comModel.longtitude = @"116.243928163179";
    comModel.latitude = @"40.0799137858244";
    comModel.address = @"丰秀中路";
    [self.testSourceArray addObject:comModel];
    
    comModel = [[CompanyModel alloc] init];
    comModel.sid = @"1";
    comModel.title = @"大方设计";
    comModel.imagePath = @"http://deyang.gongyeyun.com/CloudFile//2016//9//5//12//2016090512452445241_2016090512452410GH9B1VEF.jpg";
    comModel.longtitude = @"116.242585352747";
    comModel.latitude = @"40.0806051271764";
    comModel.address = @"丰秀中路3号院9号楼";
    [self.testSourceArray addObject:comModel];
    
    comModel = [[CompanyModel alloc] init];
    comModel.sid = @"1";
    comModel.title = @"依依设计工作室";
    comModel.imagePath = @"http://deyang.gongyeyun.com/CloudFile//2016//2//17//15//2016021715364036401_2016021703364087OKSEDJEV.jpg";
    comModel.longtitude = @"116.24710246404";
    comModel.latitude = @"40.081112875182";
    comModel.address = @"丰秀中路1";
    [self.testSourceArray addObject:comModel];
    
    [self addPointAnnotation];
    
    [self setSearchUI];
    
    // 添加最下边的提示框
    UIView *tipView = [ToolBoxView creatViewWithBackgroundColor:[[UIColor colorWithHexString:@"#0069BC"] colorWithAlphaComponent:0.9] toView:self.view];
    tipView.frame = CGRectMake(0, MainScreenHight-64-80, MainScreenWidth, 80);
    UILabel *tipLabel = [ToolBoxView creatLabelWithTextColor:[UIColor whiteColor] andTextFont:[UIFont systemFontOfSize:16.0] andLineSpaceValue:6 andText:@"大方工业云在该地区已有12435家企业，32个行业，3345笔订单在进行" toView:tipView];
    tipLabel.numberOfLines = 0;
    tipLabel.frame = CGRectMake(15, 15, MainScreenWidth-30, 50);
    
    
    // 设置企业列表数据
    [self setListDataAndData];
}

- (void)addPointAnnotation {
    CompanyModel *model = self.testSourceArray[1];
    CLLocationCoordinate2D centerCoor;
    centerCoor.latitude = [model.latitude floatValue];
    centerCoor.longitude = [model.longtitude floatValue];
    _mapView.centerCoordinate = centerCoor;
    
    for (int i = 0; i < self.testSourceArray.count; i++) {
        CompanyModel *model = self.testSourceArray[i];
        if (model.latitude.length != 0 && model.longtitude.length != 0) {
            MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
            CLLocationCoordinate2D coor;
            coor.latitude = [model.latitude floatValue];
            coor.longitude = [model.longtitude floatValue];
            pointAnnotation.coordinate = coor;
            [_mapView addAnnotation:pointAnnotation];
        }
        
    }
}

- (void)setListDataAndData {
    if (self.dataSourceArray == nil) {
        self.dataSourceArray = [NSMutableArray array];
    }
    
    [self.tableView registerClass:[CompanyTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CompanyTableViewCell class])];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = ColorWithRGB(246, 246, 246);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self loadPageData];
    
    WEAKSELF
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadPageData];
    }];
    
    [self.view bringSubviewToFront:self.tableView];
}

- (void)loadPageData {
    for (int i = 0; i < 20; i++) {
        CompanyModel *model = [[CompanyModel alloc] init];
        model.title = @"北京数码大方科技股份有限公司";
        model.content = @"数码大方是中国领先的工业软件和工业云服务公司，主要面向装备、汽车、电子电器...";
        model.collsnum = @"123";
        model.viewnum = @"567";
        [self.dataSourceArray addObject:model];
    }
    NSLog(@"%ld",self.dataSourceArray.count);
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CompanyModel *model = self.dataSourceArray[indexPath.section];
    CompanyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CompanyTableViewCell class])];
    cell.model = model;
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    return cell;
}

/** 计算行高 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CompanyModel *model = self.dataSourceArray[indexPath.section];
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[CompanyTableViewCell class] contentViewWidth:MainScreenWidth];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01f;
    }
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CompanyModel *model = self.dataSourceArray[indexPath.section];
    CompanyDetailViewController *detailVC = [[CompanyDetailViewController alloc] init];
    [self pushNewViewController:detailVC];
}

- (void)configureLeftView {
    self.leftVC = [[LeftInfoViewController alloc] init];
    WEAKSELF
    self.leftVC.block = ^(id object) {
        if ([object isKindOfClass:[NSString class]]) {
            if ([object isEqualToString:@"头像"] ) {
                DLog(@"跳转至个人信息页面")
                UserInfoViewController *infoVC = [[UserInfoViewController alloc] init];
                [weakSelf pushNewViewController:infoVC];
            } else if ([object isEqualToString:@"我的关注"]) {
                DLog(@"跳转至我的关注页面")
                MyAttentionViewController *myAttentionVC = [[MyAttentionViewController alloc] init];
                [weakSelf pushNewViewController:myAttentionVC];
            } else if ([object isEqualToString:@"我的企业"]) {
                DLog(@"跳转至我的企业页面")
                MyCompanyViewController *myCompanyVC = [[MyCompanyViewController alloc] init];
                [weakSelf pushNewViewController:myCompanyVC];
            } else if ([object isEqualToString:@"我的订单"]) {
                OrderMainViewController *orderVC = [[OrderMainViewController alloc] init];
                [weakSelf pushNewViewController:orderVC];
            } else if ([object isEqualToString:@"供应商"]) {
                SuppliersViewController *suppliersVC = [[SuppliersViewController alloc] init];
                [weakSelf pushNewViewController:suppliersVC];
            } else if ([object isEqualToString:@"我的消息"]) {
                MyMessageViewController *messageVC = [[MyMessageViewController alloc] init];
                [weakSelf pushNewViewController:messageVC];
            } else if ([object isEqualToString:@"我的认证"]) {
                MyCerticatifyViewController *centifyVC = [[MyCerticatifyViewController alloc] init];
                [weakSelf pushNewViewController:centifyVC];
            } else if ([object isEqualToString:@"设置"]) {
                SettingViewController *settingVC = [[SettingViewController alloc] init];
                [weakSelf pushNewViewController:settingVC];
            } else if ([object isEqualToString:@"注销"]) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出吗?" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alertController addAction:sureAction];
                [alertController addAction:cancelAction];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            }
            [weakSelf removeVC];
        }
    };
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.leftVC.view];;
    [self addChildViewController:self.leftVC];
    self.leftVC.view.backgroundColor = [UIColor clearColor];
    self.leftVC.view.frame = CGRectMake(-MainScreenWidth, 20, MainScreenWidth, MainScreenHight-20);
    self.leftVC.shadeView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    
    [UIView animateWithDuration:.25 animations:^{
        weakSelf.leftVC.view.frame = CGRectMake(0, 20, MainScreenWidth, MainScreenHight-20);
        self.leftVC.shadeView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }];
}

- (void)removeVC {
    WEAKSELF
    [UIView animateWithDuration:.25 animations:^{
        self.leftVC.view.frame = CGRectMake(-MainScreenWidth, 20, MainScreenWidth, MainScreenHight-20);
        self.leftVC.shadeView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    } completion:^(BOOL finished) {
        [weakSelf.leftVC.view removeFromSuperview];
        [weakSelf.leftVC removeFromParentViewController];
    }];
}

// 企业列表
- (void)companyBtnClick {
    if (self.tableView.hidden) {
        self.tableView.hidden = NO;
    } else {
        self.tableView.hidden = YES;
    }
}

// 订单列表
- (void)orderBtnClick {
    OrderMainViewController *orderVC = [[OrderMainViewController alloc] init];
    [self pushNewViewController:orderVC];
}

#pragma mark - MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    // 如果是定位的标注则返回
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        return nil;
    }
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        CustomAnnotationView *annotationView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
            // 必须设置为NO, 这样才可以显示自定义视图.
            annotationView.canShowCallout = NO;
            annotationView.draggable = YES;
            annotationView.calloutOffset = CGPointMake(0, -5);
        }
        annotationView.portrait = ImageNamed(@"custom_point");
        
        return annotationView;
    }
    return nil;
}

#define kCalloutViewMargin -8
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    /* Adjust the map center in order to show the callout view completely. */
    if ([view isKindOfClass:[CustomAnnotationView class]]) {
        CustomAnnotationView *cusView = (CustomAnnotationView *)view;
        CGRect frame = [cusView convertRect:cusView.calloutView.frame toView:_mapView];
        frame = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(kCalloutViewMargin, kCalloutViewMargin, kCalloutViewMargin, kCalloutViewMargin));
        if (!CGRectContainsRect(_mapView.frame, frame)) {
            /* Calculate the offset to make the callout view show up. */
            CGSize offset = [self offsetToContainRect:frame inRect:_mapView.frame];
            CGPoint theCenter = _mapView.center;
            theCenter = CGPointMake(theCenter.x - offset.width, theCenter.y - offset.height);
            CLLocationCoordinate2D coordinate = [_mapView convertPoint:theCenter toCoordinateFromView:_mapView];
            [_mapView setCenterCoordinate:coordinate animated:YES];
        }
        DLog(@"点击后显示");
    }
}

- (CGSize)offsetToContainRect:(CGRect)innerRect inRect:(CGRect)outerRect {
    CGFloat nudgeRight = fmaxf(0, CGRectGetMinX(outerRect) - (CGRectGetMinX(innerRect)));
    CGFloat nudgeLeft = fminf(0, CGRectGetMaxX(outerRect) - (CGRectGetMaxX(innerRect)));
    CGFloat nudgeTop = fmaxf(0, CGRectGetMinY(outerRect) - (CGRectGetMinY(innerRect)));
    CGFloat nudgeBottom = fminf(0, CGRectGetMaxY(outerRect) - (CGRectGetMaxY(innerRect)));
    return CGSizeMake(nudgeLeft ?: nudgeRight, nudgeTop ?: nudgeBottom);
}

// 分享功能集成 暂时不用
#pragma mark -- 分享按钮点击
- (void)shareBtnClick {
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建网页内容对象
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"post_icon_01"]];
        //设置网页地址
        shareObject.webpageUrl =@"http://mobile.umeng.com/social";
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id result, NSError *error) {
            if (error) {
                NSLog(@"************Share fail with error %@*********",error);
            }else{
                NSLog(@"response data is %@",result);
            }
        }];
    }];
}







@end
