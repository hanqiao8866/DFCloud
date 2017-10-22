//
//  CompanyDetailViewController.m
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/17.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import "CompanyDetailViewController.h"

@interface CompanyDetailViewController ()

@end

@implementation CompanyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureNavgationItemTitle:@"企业详情"];
    WEAKSELF
    [self configureBackButtonWithAction:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];

}




@end
