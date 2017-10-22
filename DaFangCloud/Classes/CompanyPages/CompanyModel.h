//
//  CompanyModel.h
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/18.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompanyModel : NSObject

@property (nonatomic, assign) NSString *sid;
@property (nonatomic, copy) NSString *title; // 企业名称
@property (nonatomic, copy) NSString *content; // 企业介绍
@property (nonatomic, copy) NSString *type; // 企业类型
@property (nonatomic, copy) NSString *imagePath; // 企业头像地址
@property (nonatomic, copy) NSString *time; // 加入时间
@property (nonatomic, copy) NSString *level; // 企业等级

@property (nonatomic, copy) NSString *column1; // 企业列表用-企业头像地址

@property (nonatomic, copy) NSString *liuyannum; // 留言数
@property (nonatomic, copy) NSString *collsnum; // 关注数
@property (nonatomic, copy) NSString *viewnum; // 浏览数
@property (nonatomic, copy) NSString *latitude; // 纬度
@property (nonatomic, copy) NSString *longtitude; // 经度
@property (nonatomic, copy) NSString *status; // 状态
@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *address;


@end
