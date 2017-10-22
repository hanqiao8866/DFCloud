//
//  XTBaseViewController.h
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/17.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^XTBarButtonItemActionBlock) (void);
typedef void (^XTRightBarButtonActionBlock) (void);
typedef void (^XTLeftBarButtonActionBlock) (void);
// 通用
typedef void(^GeneralBlock)(id object);

@interface XTBaseViewController : UIViewController

@property (nonatomic, strong)NSMutableDictionary *parameterDic; //  数据请求参数信息
@property (nonatomic, assign)NSInteger currentPageIndex; //  当前加载页码
@property (nonatomic, copy) GeneralBlock block;

/**
 *  push新的控制器到导航控制器
 *
 *  @param newViewController 目标新的视图控制器
 */
- (void)pushNewViewController:(UIViewController *)newViewController;


/**
 *  push新的控制器到导航控制器
 *
 *  @param newViewController 目标新的视图控制器
 *  @param isHidden 是否隐藏tabbar
 */
- (void)pushNewViewController:(UIViewController *)newViewController hiddenTabBar:(BOOL)isHidden;

/**
 *  设置barButtonItem以及回调方法
 *
 *  @param action 设置动作
 */
- (void)configureBackButtonWithAction:(XTBarButtonItemActionBlock)action;

- (void)configureLeftBarButtonWithImageName:(NSString *)imageName action:(XTLeftBarButtonActionBlock)action;

/**
 *  设置导航条文字
 *
 *  @param navigationTitle 设置导航条上的文字内容
 */
- (void)configureNavgationItemTitle:(NSString *)navigationTitle;

@end
