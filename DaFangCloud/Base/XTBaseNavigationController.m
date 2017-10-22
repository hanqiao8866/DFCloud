//
//  XTBaseNavigationController.m
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/17.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import "XTBaseNavigationController.h"

@interface XTBaseNavigationController ()

@end

@implementation XTBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINavigationBar *bar = [UINavigationBar appearance];
    [[UINavigationBar appearance] setBarTintColor:MainAppColor];
    [bar setTintColor:[UIColor whiteColor]];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : MainAppColor}];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
