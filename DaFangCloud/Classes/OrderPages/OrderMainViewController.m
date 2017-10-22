//
//  OrderMainViewController.m
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/18.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import "OrderMainViewController.h"
#import "MyCreatOrderViewController.h"
#import "MyReceiveOrderViewController.h"

@interface OrderMainViewController ()

@end

@implementation OrderMainViewController

#define ITEMNUMBER 2

- (instancetype)init {
    if (self = [super init]) {
        NSArray *classes = [NSArray arrayWithObjects:[MyCreatOrderViewController class], [MyReceiveOrderViewController class],nil];
        
        NSArray *titles = [NSArray arrayWithObjects:@"我创建的",@"我接收的", nil];
        
        return [self initWithViewControllerClasses:classes andTheirTitles:titles];
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self configureNavgationItemTitle:@"我的订单"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WEAKSELF
    [self configureBackButtonWithAction:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    
    [self setSelfProperty];
    
}

/**
 *  设置自身属性
 */
- (void)setSelfProperty {
    self.menuBGColor = [UIColor whiteColor];
    self.pageAnimatable = NO;
    self.postNotification = YES;
    self.bounces = NO;
    self.menuViewStyle = WMMenuViewStyleLine;
    self.titleSizeSelected = 16.0f;
    self.titleSizeNormal = 16.0f;
    self.menuItemWidth = MainScreenWidth/3.0;
    self.menuHeight = 50.0;
    self.titleColorNormal = [UIColor darkGrayColor];
    self.titleColorSelected = SecondAppColor;
}

@end
