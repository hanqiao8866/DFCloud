//
//  DXUtils.h
//  DXDesign
//
//  Created by Caxa on 15/8/19.
//  Copyright (c) 2015年 mlf. All rights reserved.
//
// 工具类
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSInteger, DXAvatarType)
{
    DXAvatarTypeDefault = 0,    //  用户头像
    DXAvatarTypeUserBg    //  用户背景图
};

//  当前设备类型
typedef NS_ENUM(NSInteger, DeviceType)
{
    DeviceType4S = 0,    //  4/4s设备
    DeviceType5S    //  5/5s设置
};

@interface GeneralUtils : NSObject

//  是否支持拍照
+ (BOOL)currentServiceSupportCamera;

//  是否允许访问摄像头
+ (BOOL)currentServiceAccessCamera;

/**
 *  根据页面尺寸获取 等比大小尺寸
 *
 *  @param originalSize 原始尺寸
 *  @param type         设计图的设备类型
 *
 *  @return 等比后尺寸
 */
+ (CGSize)getGeometricSize:(CGSize)originalSize type:(DeviceType)type;

/**
 *  根据页面尺寸获取 等比大小尺寸
 *
 *  @param originalSize 原始尺寸
 *
 *  @return 等比后尺寸
 */
+ (CGSize)getGeometricSize:(CGSize)originalSize;
/**
 *  根据页面尺寸获取 等比大小宽度
 *
 *  @param originalWith 原始宽度
 *  @param type         设计图的设备类型
 *
 *  @return 等比后宽度
 */
+ (CGFloat)getGeometricWith:(CGFloat)originalWith type:(DeviceType)type;

/**
 *  根据页面尺寸获取 等比大小高度
 *
 *  @param originalWith 原始高度
 *  @param type         设计图的设备类型
 *
 *  @return 等比后高度
 */
+ (CGFloat)getGeometricHeight:(CGFloat)originalHeight type:(DeviceType)type;



/**
 *  通过字符串获取时间格式字符串
 *
 *  @param dateStr 如：2018081515精确到小时
 *
 *  @return 2015-08-19 18:00:00
 */
+ (NSString *)getDateStr:(NSString *)dateStr;

/**
 *  转换服务器时间格式
 *
 *  @param dateStr "2016-04-17T00:00:00"
 *
 *  @return "2016-04-17 00:00"
 */
+ (NSString *)convertServerDateString:(NSString *)dateStr;

/**
 *  去掉首尾和换行空格得到字符串
 *
 *  @param content 当前文本内容
 *
 *  @return 去掉首尾和换行得到的字符串
 */
+ (NSString *)getContentStr:(NSString *)content;

/**
 *  获取非空字符串
 *
 *  @param content 字符串
 *
 *  @return 非空字符串
 */
+ (NSString *)getNotNilStr:(NSString *)content;

/**
 *  获取非空数字字符串
 *
 *  @param text 文本
 *  @param  placeHolder 替换文本
 *  @return 数字字符
 */
+ (NSString *)getNotNilNum:(NSString *)text placeHolder:(NSString *)placeHolder;

/**
 *  将数字转换为>0的字符串
 *
 *  @param number 数字
 *
 *  @return 非空字符串
 */
+ (NSString *)getNotZeroNumber:(NSInteger)number;

/**
 *  检查文本是否空
 *
 *  @param contentStr 文本内容
 *
 *  @return 空 YES 非空 NO
 */
+ (BOOL)isContentLengthZero:(NSString *)contentStr;

/**
 *  获取配置文件中 字段是否必填
 *
 *  @param isRequre   是否必填
 *  @param placeHoder 占位符
 *
 *  @return 占位文本
 */
+ (NSString *)getPlaceTitleIsRequired:(BOOL)isRequired placeHolder:(NSString *)placeHoder;

/**
 *  设置加载图片的方法 设置默认图片
 *
 *  @param _imgV 加载图片的imageVIew
 *  @param coverImageUrlStr 加载图片的url
 *  @param defaultImageStr 默认图片或图片名称
 */
+(void)setImageView:(UIImageView *)imageView ImageUrlStr:(NSString *)coverImageUrlStr imageDefaultImageStr:(id)defaultImageStr;

/**
 *  设置加载图片的方法 设置默认图片 图片下载完成后进行裁剪并保存本地
 *
 *  @param _imgV 加载图片的imageVIew
 *  @param coverImageUrlStr 加载图片的url
 *  @param placeHoder 默认图片或图片名称
 */
//+ (void)setCropImageView:(UIImageView *)imageView ImageUrlStr:(NSString *)coverImageUrlStr placeHoder:(id)placeHoder;

/**
 *  设置加载图片的方法
 *
 *  @param _imgV 加载图片的imageVIew
 *  @param coverImageUrlStr 加载图片的url
 */
+(void)setImageView:(UIImageView *)imageView ImageUrlStr:(NSString *)coverImageUrlStr;


/**
 *  设置加载用户默认头像的方法
 *
 *  @param _imgV 加载图片的imageVIew
 *  @param coverImageUrlStr 加载图片的url
 */

+(void)setUserPhotoImageView:(UIImageView *)imageView ImageUrlStr:(NSString *)coverImageUrlStr;

/**
 *  设置自己的头像或背景图
 *
 *  @param avatarImgView   承载视图
 *  @param serverImgSuffix 图片后缀
 */
+ (void)setUserAvatarOrBgWithImgView:(UIImageView *)avatarImgView serverImgSuffix:(NSString *)serverImgSuffix avatarType:(DXAvatarType)avatarType;



@end
