//
//  InterfaceAPI.h
//  HengYouYuanProject
//
//  Created by 谢涛 on 2017/7/21.
//  Copyright © 2017年 X.T. All rights reserved.
//

#ifndef InterfaceAPI_h
#define InterfaceAPI_h

//#define HostUrl @"http://192.168.3.18:9961/API/" // 测试库
#define HostUrl @"http://hyy-lib2.gongyeyun.com/API/" // 正式库

// 获取账号数据
#define CurrentAccountInfo [NSString stringWithFormat:@"%@Account/CurrentAccountInfo",HostUrl]

// 根据账号ID获取权限
#define GetModListByCId [NSString stringWithFormat:@"%@Account/GetModListByCId",HostUrl]

// 当前登录人项目列表
#define ProjectList [NSString stringWithFormat:@"%@Project/ProjectList",HostUrl]

// 项目详情及跟踪
#define ProjectDetails [NSString stringWithFormat:@"%@Project/ProjectDetails",HostUrl]

// 工作台
#define ProjectDesk [NSString stringWithFormat:@"%@Project/ProjectDesk",HostUrl] 

// 工作台详情
#define ProjectTemplateDetails [NSString stringWithFormat:@"%@Project/ProjectTemplateDetails",HostUrl]

// App添加评论
#define AddCommentApp [NSString stringWithFormat:@"%@Project/AddCommentApp",HostUrl]

// 项目总评论
#define ProjectComment [NSString stringWithFormat:@"%@Project/ProjectComment",HostUrl]

// 项目跟踪操作
#define ActionProjectTemplate [NSString stringWithFormat:@"%@Project/ActionProjectTemplate",HostUrl]

// 获取文件
#define GetAttachmentApp [NSString stringWithFormat:@"%@Project/GetAttachmentApp",HostUrl]

// 获取子项目
#define GetProjectItemById [NSString stringWithFormat:@"%@Project/GetProjectItemById",HostUrl]

// 获取消息列表
#define GetMessageInfoListByUserId [NSString stringWithFormat:@"%@Project/GetMessageInfoListByUserId",HostUrl]

// 获取当前消息
#define GetMessageInfoById [NSString stringWithFormat:@"%@Project/GetMessageInfoById",HostUrl]

// 删除当前消息
#define DelMessageInfoById [NSString stringWithFormat:@"%@Project/DelMessageInfoById",HostUrl]

// 验证版本号
#define ValidateVersion [NSString stringWithFormat:@"%@Project/ValidateVersion",HostUrl]

// 子项目进度列表
#define GetProjectItemProgress [NSString stringWithFormat:@"%@Project/GetProjectItemProgress",HostUrl]

// 更新某一子项目的进度
#define UpdateProjectItemProgress [NSString stringWithFormat:@"%@Project/UpdateProjectItemProgress",HostUrl]



#endif /* InterfaceAPI_h */
