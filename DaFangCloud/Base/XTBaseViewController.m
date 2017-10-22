//
//  XTBaseViewController.m
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/17.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import "XTBaseViewController.h"
#import "AppDelegate.h"

@interface XTBaseViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, copy) XTBarButtonItemActionBlock barbuttonItemAction;
@property (nonatomic, copy) XTRightBarButtonActionBlock rightBarButtonAction;
@property (nonatomic, copy) XTLeftBarButtonActionBlock leftBarButtonAction;

@end

@implementation XTBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.parameterDic = [NSMutableDictionary dictionary];
        self.currentPageIndex = 1;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass(self.class)];
    
    //ios7.0适配
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0) {
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    
    [self layoutNavigation];
    [self loadTheInterfaceData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass(self.class)];
    
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    [self.view endEditing:YES];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (self.navigationController.viewControllers.count == 1) {
        //关闭主界面的右滑返回
        return NO;
    } else {
        return YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
    self.view.backgroundColor = ColorWithRGB(240, 240, 240);
}

// push到一个新的页面
- (void)pushNewViewController:(UIViewController *)newViewController
{
    [self.navigationController pushViewController:newViewController animated:YES];
}

// push到一个新页面 是否隐藏系统tabbar
- (void)pushNewViewController:(UIViewController *)newViewController hiddenTabBar:(BOOL)isHidden
{
    newViewController.hidesBottomBarWhenPushed = isHidden;
    [self.navigationController pushViewController:newViewController animated:YES];
}

- (void)configureBackButtonWithAction:(XTBarButtonItemActionBlock)action {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0 , 0, 24, 20);
    [backBtn addTarget:self action:@selector(clickedBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:ImageNamed(@"back_arrow") forState:UIControlStateNormal];
    UIBarButtonItem *navBackBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = navBackBtn;
    self.barbuttonItemAction = action;
}

// 设置带图片的左侧导航按钮并且回调方法
- (void)configureLeftBarButtonWithImageName:(NSString *)imageName action:(XTLeftBarButtonActionBlock)action
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 20, 20);
    [leftBtn addTarget:self action:@selector(clickedLeftBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    leftBtn.adjustsImageWhenHighlighted = NO;
    UIBarButtonItem *navRightBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem =navRightBtn;
    
    self.leftBarButtonAction = action;
    
}

- (void)clickedBarButtonItemAction {
    if (self.barbuttonItemAction) {
        self.barbuttonItemAction();
    }
}

- (void)clickedLeftBarButtonItemAction {
    if (self.leftBarButtonAction) {
        self.leftBarButtonAction();
    }
}

// 设置导航栏上的文字
- (void)configureNavgationItemTitle:(NSString *)navigationTitle {
    [self configureNavgationItemTitleWithColor:[UIColor whiteColor] andTitle:navigationTitle];
}

- (void)configureNavgationItemTitleWithColor:(UIColor *)navColor andTitle:(NSString *)navTitle {
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:navColor, NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica Neue" size:20.0f], NSFontAttributeName,nil]];
    self.navigationItem.title = navTitle;
}

/**
 添加界面控件
 */
- (void)addSubviews { }

/**
 布局导航栏内容
 */
- (void)layoutNavigation { }

/**
 获取界面数据
 */
- (void)loadTheInterfaceData { }

@end
