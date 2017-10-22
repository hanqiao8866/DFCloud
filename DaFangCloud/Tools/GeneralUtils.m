//
//  DXUtils.m
//  DXDesign
//
//  Created by Caxa on 15/8/19.
//  Copyright (c) 2015年 mlf. All rights reserved.
//

#import "GeneralUtils.h"
//#import "MD5Encryption.h"

@implementation GeneralUtils

#pragma mark - tool method
//  是否支持拍照
+ (BOOL)currentServiceSupportCamera
{
    if([[[UIDevice currentDevice] systemVersion]floatValue ] >= 7.0)
    {
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            return NO;
        }else{
            return YES;
        }
    }
    return YES;
}

//  是否允许访问摄像头
+ (BOOL)currentServiceAccessCamera
{
    //判断iOS7的宏，没有就自己写个，下边的方法是iOS7新加的，7以下调用会报错
    if([[[UIDevice currentDevice] systemVersion]floatValue ] >= 7.0)
    {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusDenied){
            return NO;
        }else if(authStatus == AVAuthorizationStatusNotDetermined){
            return YES;
        }
    }
    return YES;
}

//  获取当前设备竖屏时的size大小
+ (CGSize)getVerticalScreenSize
{
    CGSize currentDeviceSize = [UIScreen mainScreen].bounds.size;
    UIInterfaceOrientation orientation =[UIApplication sharedApplication].statusBarOrientation;
    CGFloat verticalScreenWith = currentDeviceSize.width;
    CGFloat verticalScreenHeight = currentDeviceSize.height;
    if (orientation == UIDeviceOrientationLandscapeRight || orientation == UIDeviceOrientationLandscapeLeft) {
        verticalScreenWith = currentDeviceSize.height;
        verticalScreenHeight = currentDeviceSize.width;
    }
    return CGSizeMake(verticalScreenWith, verticalScreenHeight);
}

+ (CGSize)getGeometricSize:(CGSize)originalSize type:(DeviceType)type
{
    CGFloat width = [self getGeometricWith:originalSize.width type:type];
    CGFloat height = [self getGeometricHeight:originalSize.height type:type];
    if (originalSize.width == originalSize.height) {
        if (width > height) {
            height = width;
        }
        
        if (width < height) {
            width = height;
        }
    }
    NSLog(@"tip:当前控件的大小->%.2f %.2f",width,height);
    return CGSizeMake(width, height);
}

+ (CGSize)getGeometricSize:(CGSize)originalSize
{
    CGSize currentScreenSize = [self getVerticalScreenSize];
    CGSize newSize = CGSizeMake(originalSize.width/320.0*currentScreenSize.width, originalSize.height/480.0*currentScreenSize.height);
    NSLog(@"tip:当前控件的大小->%@",NSStringFromCGSize(newSize));
    return newSize;
}

+ (CGFloat)getGeometricWith:(CGFloat)originalWith type:(DeviceType)type
{
    CGSize currentDeviceSize = [self getVerticalScreenSize];
    //  最宽不超过plus
    if (currentDeviceSize.width > 414) {
//        return originalWith;
        return (originalWith/320.0*414);
    }
    if (type == DeviceType4S || type == DeviceType5S) {
        return (originalWith/320.0*currentDeviceSize.width);
    }
    
    return originalWith;
}

+ (CGFloat)getGeometricHeight:(CGFloat)originalHeight type:(DeviceType)type
{
    CGSize currentDeviceSize = [self getVerticalScreenSize];
    
    //  最高不超过plus
    if (currentDeviceSize.height > 736) {
//        return originalHeight;
        return (originalHeight/568.0*736);
    }
    if (type == DeviceType4S) {
        return (originalHeight/480.0*currentDeviceSize.height);
    }else if (type == DeviceType5S){
        return (originalHeight/568.0*currentDeviceSize.height);
    }
    return originalHeight;
}

//  获取时间格式字符串
+ (NSString *)getDateStr:(NSString *)dateStr
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyyMMddHH"];
    NSDate* inputDate = [inputFormatter dateFromString:dateStr];
    NSLog(@"date = %@", inputDate);
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [outputFormatter stringFromDate:inputDate];
}

+ (NSString *)convertServerDateString:(NSString *)dateStr
{
    if (dateStr == nil || dateStr.length == 0) {
        return @" ";
    }
    
    NSMutableString *waitDeal = [NSMutableString stringWithString:dateStr];
    if (waitDeal.length > 12) {
        
        waitDeal = [NSMutableString stringWithString:[[waitDeal componentsSeparatedByString:@"T"] componentsJoinedByString:@" "]];
        
        return [waitDeal substringToIndex:16];
    }
    
    return waitDeal;
}

//  获取文本信息
+ (NSString *)getContentStr:(NSString *)content
{
    return [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//  获取非空字符串
+ (NSString *)getNotNilStr:(NSString *)content
{
    if (content == nil) {
        return @"";
    }
    return content;
}

/**
 *  获取非空数字字符串
 *
 *  @param text 文本
 *
 *  @return 数字字符
 */
+ (NSString *)getNotNilNum:(NSString *)text placeHolder:(NSString *)placeHolder
{
    if (text == nil || text.length == 0) {
        if (placeHolder.length > 0) {
            return placeHolder;
        }
        return @"0";
    }
    return text;
}

+ (NSString *)getNotZeroNumber:(NSInteger)number
{
    NSInteger notZeroNum = number;
    if (number < 0) {
        notZeroNum = 0;
    }
    
    return [NSString stringWithFormat:@"%ld",notZeroNum];
}

//  检查文本是否填写
+ (BOOL)isContentLengthZero:(NSString *)contentStr
{
    return [self getContentStr:contentStr].length == 0;
}

/**
 *  获取配置文件中 字段是否必填
 *
 *  @param isRequre   是否必填
 *  @param placeHoder 占位符
 *
 *  @return 占位文本
 */
+ (NSString *)getPlaceTitleIsRequired:(BOOL)isRequired placeHolder:(NSString *)placeHoder
{
    if (isRequired) {
        return [NSString stringWithFormat:@"*%@",placeHoder];
    }
    return placeHoder;
}


+(void)setImageView:(UIImageView *)imageView ImageUrlStr:(NSString *)coverImageUrlStr imageDefaultImageStr:(id)defaultImageStr
{
    UIImage *placeholderImage = [self getPlaceHoderImage:defaultImageStr];
    //  防止nil 和 url中文转码
    NSString *notNilStr = [self getNotNilStr:coverImageUrlStr];
    NSString *imgStr = [notNilStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //  防止cell复用时 图片动画显示问题
    UIImage *localImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imgStr];
    if (localImage) {
        imageView.image = localImage;
    } else {
        [imageView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!error) {
                [UIView transitionWithView:imageView duration:1.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
                    imageView.image = image;
                }];
            }else{
                imageView.image = placeholderImage;
            }
        }];
    }
}

//+ (void)setCropImageView:(UIImageView *)imageView ImageUrlStr:(NSString *)coverImageUrlStr placeHoder:(id)placeHoder
//{
//    UIImage *placeholderImage = [self getPlaceHoderImage:placeHoder];
//    
//    //  防止nil 和 url中文转码
//    NSString *notNilStr = [self getNotNilStr:coverImageUrlStr];
//    NSString *imgStr = [notNilStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    
//    NSString *localFilePath = [[FileDirectoryManager getCropImageFilePath] stringByAppendingPathComponent:[MD5Encryption md5by32:imgStr]];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    if ([fileManager fileExistsAtPath:localFilePath]) {
//        imageView.image = [UIImage imageWithContentsOfFile:localFilePath];
//    } else {
//        [imageView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            if (!error) {
//                UIImage *cropImage = [image imageByScalingAndCroppingForSize:CGSizeMake(imageView.size.width * 2, imageView.size.height * 2)];
//                imageView.image = cropImage;
//                
//                NSData *data = UIImageJPEGRepresentation(cropImage, 0.8);
//                BOOL flag = [data writeToFile:localFilePath atomically:YES];
//                NSLog(@"tip:裁剪图片写入本地结果：%d",flag);
//            }else{
//                imageView.image = placeholderImage;
//            }
//        }];
//    }
//}

+ (UIImage *)getPlaceHoderImage:(id)placeHoder
{
    if ([placeHoder isKindOfClass:[NSString class]]) {
        return ImageNamed(placeHoder);
    }
    return placeHoder;
}

+(void)setImageView:(UIImageView *)imageView ImageUrlStr:(NSString *)coverImageUrlStr
{
    [[self class] setImageView:imageView ImageUrlStr:coverImageUrlStr imageDefaultImageStr:@"placeholder.png"];
}

+(void)setUserPhotoImageView:(UIImageView *)imageView ImageUrlStr:(NSString *)coverImageUrlStr
{
    [[self class] setImageView:imageView ImageUrlStr:coverImageUrlStr imageDefaultImageStr:@"defaultAvatar-45.png"];
}

+ (void)setUserAvatarOrBgWithImgView:(UIImageView *)avatarImgView serverImgSuffix:(NSString *)serverImgSuffix avatarType:(DXAvatarType)avatarType
{
//    NSUserDefaults *userInfo=[NSUserDefaults standardUserDefaults];
//    NSDictionary *userInfoDic = [userInfo objectForKey:KUserLoginDic];
//    NSString *urlStr = userInfoDic[USERINFOAVATAR];
//    NSString *placeHolderImgName = @"defaultAvatar-45.png";
//    NSString *avatarPath = [DXFileDirectoryManager getUserAvatarPathByFileName:@""];
//    NSString *imgName = LOCALSMALLAVATAR;
//    if (avatarType == DXAvatarTypeUserBg) {
//        urlStr = userInfoDic[USERINFOBGIMAGE];
//        placeHolderImgName = @"defaultBgImage.png";
//        avatarPath = [DXFileDirectoryManager getUserBgPathByFileName:@""];
//        imgName = LOCALSMALLUSERBG;
//    }
//    DLog(@"tip:设置头像:%@",urlStr);
//    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    activityView.frame = CGRectMake(0, 0, 30, 30);
//    activityView.center = CGPointMake(avatarImgView.width/2.0, avatarImgView.height/2.0);
//    [activityView startAnimating];
//    [avatarImgView addSubview:activityView];
    
    
//    NSString *localAvatarPath = [NSString stringWithFormat:@"%@/%@",avatarPath,imgName];
//    if ([FileManager isFileExists:localAvatarPath]) {
////        [activityView stopAnimating];
//        avatarImgView.image = [UIImage imageWithContentsOfFile:localAvatarPath];
//    }else{
//        NSString *rightAvatarUrlStr = [[urlStr stringByAppendingString:serverImgSuffix] stringByAppendingString:[NSString stringWithFormat:@"?random=%d",arc4random()%10000]];
//        
//        NSLog(@"tip:头像地址------>%@",rightAvatarUrlStr);
//        if (urlStr.length > 0) {
//            [avatarImgView sd_setImageWithURL:[NSURL URLWithString:rightAvatarUrlStr] placeholderImage:ImageNamed(placeHolderImgName) options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
////                [activityView stopAnimating];
//                if (!error) {
//                    NSLog(@"tip:设置头像成功----->%@",imageURL);
//                    avatarImgView.image = image;
//                    //  下载成功后 写入本地路径
//                    NSData *data = UIImagePNGRepresentation(image);
//                    BOOL flag = [data writeToFile:localAvatarPath atomically:YES];
//                    NSLog(@"tip:下载头像写入本地是否成功:%d",flag);
//                }else{
//                    NSLog(@"tip:头像下载失败");
//                }
//            }];
//        }else{
//            avatarImgView.image = ImageNamed(placeHolderImgName);
//        }
//    }
}



@end
