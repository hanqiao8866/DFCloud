//
//  LeftInfoViewController.m
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/17.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import "LeftInfoViewController.h"

@interface LeftInfoViewController ()

@end

@implementation LeftInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)itemBtnClick:(UIButton *)sender {
    if (sender.tag == 0) {
        self.block(@"头像");
    } else if (sender.tag == 10) {
        self.block(@"我的关注");
    } else if (sender.tag == 20) {
        self.block(@"浏览记录");
    } else if (sender.tag == 30) {
        self.block(@"我的企业");
    } else if (sender.tag == 40) {
        self.block(@"我的订单");
    } else if (sender.tag == 50) {
        self.block(@"供应商");
    } else if (sender.tag == 60) {
        self.block(@"我的消息");
    } else if (sender.tag == 70) {
        self.block(@"我的认证");
    } else if (sender.tag == 80) {
        self.block(@"设置");
    } else if (sender.tag == 90) {
        self.block(@"注销");
    }
}



- (IBAction)tapGesture:(UITapGestureRecognizer *)sender {
    [self dismiss];
}

- (IBAction)swipeGesture:(UISwipeGestureRecognizer *)sender {
    [self dismiss];
}


- (void)dismiss {
    if (self.block) {
        self.block(@"0");
    }
}



@end
