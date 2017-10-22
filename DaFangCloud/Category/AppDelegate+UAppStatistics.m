//
//  AppDelegate+UAppStatistics.m
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/13.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import "AppDelegate+UAppStatistics.h"
#import <UMMobClick/MobClick.h>

@implementation AppDelegate (UAppStatistics)

- (void)loadTheUStatisticsEnvironmentFromApplication:(UIApplication *)application options:(NSDictionary *)launchOptions {
    UMConfigInstance.appKey = YouMengKey;
    UMConfigInstance.channelId = @"App Store";
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick startWithConfigure:UMConfigInstance];
}

@end
