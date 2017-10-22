//
//  XTToolKit.m
//  HengYouYuanProject
//
//  Created by 谢涛 on 2017/7/21.
//  Copyright © 2017年 X.T. All rights reserved.
//

#import "XTToolKit.h"

@implementation XTToolKit

+ (NSString *)getYearMonthDayWithStr:(NSString *)dateStr {
    //  2015-08-06T16:35:34.237  ->  2015-08-06
    return [dateStr substringToIndex:10];
}

+ (NSString *)getFormatYearMonthDayWithStr:(NSString *)dateStr {
    //  2017/4/25 0:00:00
    NSString *str = @"";
    if (dateStr) {
        NSArray *strArray = [dateStr componentsSeparatedByString:@" "];
        if (strArray.count != 0) {
            str = strArray[0];
        }
    }
    return str;
}

+ (NSString *)getYearMonthDayTimeWithStr:(NSString *)dateStr {
    // 2017-05-10T13:56:37.707
    if (dateStr.length > 19) {
        NSString *str = [dateStr substringToIndex:19];
        str = [str stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        return str;
    }
    return dateStr;
}

+ (UIImage *)getFileIconByFileType:(NSString *)fileType {
    NSString *imageName = @"qita";
    if ([fileType isEqualToString:@"ai"]) {
        imageName = @"ai";
    } else if ([fileType isEqualToString:@"avi"]) {
        imageName = @"avi";
    } else if ([fileType isEqualToString:@"css"]) {
        imageName = @"css";
    } else if ([fileType isEqualToString:@"doc"]) {
        imageName = @"doc";
    } else if ([fileType isEqualToString:@"ds"]) {
        imageName = @"ds";
    } else if ([fileType isEqualToString:@"dwg"]) {
        imageName = @"dwg";
    } else if ([fileType isEqualToString:@"eps"]) {
        imageName = @"eps";
    } else if ([fileType isEqualToString:@"exb"]) {
        imageName = @"exb";
    } else if ([fileType isEqualToString:@"gif"]) {
        imageName = @"gif";
    } else if ([fileType isEqualToString:@"hsf"]) {
        imageName = @"hsf";
    } else if ([fileType isEqualToString:@"htf"]) {
        imageName = @"htf";
    } else if ([fileType isEqualToString:@"html"]) {
        imageName = @"html";
    } else if ([fileType isEqualToString:@"ics"]) {
        imageName = @"ics";
    } else if ([fileType isEqualToString:@"icsw"]) {
        imageName = @"icsw";
    } else if ([fileType isEqualToString:@"icw"]) {
        imageName = @"icw";
    } else if ([fileType isEqualToString:@"jpeg"]) {
        imageName = @"jpeg";
    } else if ([fileType isEqualToString:@"jpg"]) {
        imageName = @"jpg";
    } else if ([fileType isEqualToString:@"mov"]) {
        imageName = @"mov";
    } else if ([fileType isEqualToString:@"mp3"]) {
        imageName = @"mp3";
    } else if ([fileType isEqualToString:@"mp4"]) {
        imageName = @"mp4";
    } else if ([fileType isEqualToString:@"mpeg"]) {
        imageName = @"mpeg";
    } else if ([fileType isEqualToString:@"pdf"]) {
        imageName = @"pdf";
    } else if ([fileType isEqualToString:@"php"]) {
        imageName = @"php";
    } else if ([fileType isEqualToString:@"png"]) {
        imageName = @"png";
    } else if ([fileType isEqualToString:@"ppt"]) {
        imageName = @"ppt";
    } else if ([fileType isEqualToString:@"psd"]) {
        imageName = @"psd";
    } else if ([fileType isEqualToString:@"rar"]) {
        imageName = @"rar";
    } else if ([fileType isEqualToString:@"swf"]) {
        imageName = @"swf";
    } else if ([fileType isEqualToString:@"txt"]) {
        imageName = @"txt";
    } else if ([fileType isEqualToString:@"xls"]) {
        imageName = @"xls";
    } else if ([fileType isEqualToString:@"zip"]) {
        imageName = @"zip";
    } else {
        imageName = @"qita";
    }
    return ImageNamed(imageName);
}

//+ (BOOL)hasPermissionInIDArray:(NSArray *)idArray {
//
//}

@end
