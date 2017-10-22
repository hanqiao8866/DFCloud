//
//  XTToolKit.h
//  HengYouYuanProject
//
//  Created by 谢涛 on 2017/7/21.
//  Copyright © 2017年 X.T. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XTToolKit : NSObject

+ (NSString *)getYearMonthDayWithStr:(NSString *)dateStr;
+ (NSString *)getFormatYearMonthDayWithStr:(NSString *)dateStr;
+ (NSString *)getYearMonthDayTimeWithStr:(NSString *)dateStr;
+ (UIImage *)getFileIconByFileType:(NSString *)fileType;
//+ (BOOL)hasString:(NSString *)string nIDArray:(NSArray *)idArray;

@end
