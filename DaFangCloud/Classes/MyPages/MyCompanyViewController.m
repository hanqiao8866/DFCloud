//
//  MyCompanyViewController.m
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/22.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import "MyCompanyViewController.h"

@interface MyCompanyViewController ()

@end

@implementation MyCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self configureNavgationItemTitle:@"我的企业"];
    WEAKSELF
    [self configureBackButtonWithAction:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end