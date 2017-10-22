//
//  UIColor+ColorUtils.h
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/17.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorUtils)

//  转换16进制颜色值 以“#”开头 如#696969
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

@end
