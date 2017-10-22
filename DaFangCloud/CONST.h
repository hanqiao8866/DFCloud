//
//  CONST.h
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/12.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#ifndef CONST_h
#define CONST_h

#define YouMengKey @"59df27f7310c934ff400000c"
#define YouMengPushSecret @"gmntbryiskmfolpippoegaqbpx4zi23y"
#define GaoDeMapKey @"f7902b07cf64a0d22aa96b7582b88bcb"

// device verson float value
#define CURRENT_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
// 版本更新

#define CURRENTAPPVERSION @"V1.0.0"

// iPad
#define IsPad [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad
#define IsPhone [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone

// image STRETCH
#define XT_STRETCH_IMAGE(image, edgeInsets) (CURRENT_SYS_VERSION < 6.0 ? [image stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top] : [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch])

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

//  __OPTIMIZE__ 是release 默认会加的宏
#ifdef __OPTIMIZE__
#define NSLog(...){}
#else
#define NSLog(...) NSLog(__VA_ARGS__)
#endif

// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

#define EMPTY_STRING        @""

#define STR(key)            NSLocalizedString(key, nil)

#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]


#pragma mark -
#pragma mark 系统常用路径
#pragma mark -
#define Path_Documents [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

#define DeYangCloudDBPath [Path_Documents stringByAppendingPathComponent:@"DeYangCloud.sqlite"]


#define MainScreenHight [UIScreen mainScreen].bounds.size.height
#define MainScreenWidth [UIScreen mainScreen].bounds.size.width
#define NavBarAndStatusBarHeight 64
#define TabBarHeight 49
#define MainUseableViewHeight (MainScreenHight-NavBarAndStatusBarHeight-TabBarHeight) // 可用视图高度

#define ImageNamed(a) [UIImage imageNamed:a]


#define ScreenBounds   [[UIScreen mainScreen] bounds]

#define ScreenSize     ScreenBounds.size

#define ScreenHeight   ScreenSize.height

#define ScreenWidth    ScreenSize.width

#define Is_IPhone5 (ScreenHeight == 568 ? true : false)

#define Is_IPhone4 (ScreenHeight == 480 ? true : false)


#define RECT(x,y,w,h) CGRectMake(x,y,w,h)

#define AdaptiveConverter(a) (((CGRectGetWidth([UIScreen mainScreen].bounds) > 375)?(414/375.0f):(CGRectGetWidth([UIScreen mainScreen].bounds)/375.0f))*a)


#define kCYDefaultQtyCount 1

#define RIGHT(v)  (v.frame.origin.x + v.frame.size.width)
#define BOTTOM(v) (v.frame.origin.y + v.frame.size.height)
#define WIDTH(v)   v.frame.size.width
#define HEIGHT(v)  v.frame.size.height


#define CYFontSize(v) v.pointSize
#define kCYDefaultFontName @"ArialMT"
#define kCYDefaultBoldFontName @"Arial-BoldMT"

#define Font_Size_System(_f) [UIFont systemFontOfSize:(roundf(_f/2.0)+1)]
//  <iOS 8 横屏后状态栏高度为屏幕高度；>iOS 8 横屏后状态栏高度为0
#define ScreenStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define StatusBarHeight (ScreenStatusBarHeight > 20.0 ? 20.0 : ScreenStatusBarHeight)
#define NavigationBarHeight self.navigationController.navigationBar.height
#define StatusNavBarHeight (StatusBarHeight + NavigationBarHeight)
#define ContentViewHeight (self.Rect_Used.size.height - StatusBarHeight - NavigationBarHeight)  //  内容视图高度

//  图片collecitonview布局
#define kCollectionViewLRSpace 10.0   //  左右边距
#define kItemLRSpace 5.0    // collectionview的item 左右间距
#define kItemUDSpace 5.0    // collectionview的item 上下间距
#define kItemWidth 70.0     //  宽
#define kItemHeight 70.0    //  高

#define COMMENTVIEW_HEIGHT 50

//  设置颜色
#define ColorWithRGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define ColorWithRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

//  颜色设置
#define MainAppColor [UIColor colorWithHexString:@"#0069BC"]    //  主色
#define SecondAppColor [UIColor colorWithHexString:@"#EE5C4E"]   //  辅助颜色

// Add By YangLei
#define DefaultViewBgColor [UIColor colorWithRed:(239.0)/255.0f green:(239.0)/255.0f blue:(244.0)/255.0f alpha:1.0]

#define SINGLE_LINE_HEIGHT (1/[UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET ((1/[UIScreen mainScreen].scale)/ 2)


#endif /* CONST_h */
