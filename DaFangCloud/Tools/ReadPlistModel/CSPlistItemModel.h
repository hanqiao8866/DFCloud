//
//  CSPlistItemModel.h
//  CSReadPlistDemo
//
//  Created by Shaochong Du on 16/5/12.
//  Copyright © 2016年 Shaochong Du. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSPlistItemModel : NSObject

@property (nonatomic, assign) BOOL isUsed;  //  当前item是否在用
@property (nonatomic, copy) NSString *itemId;    //  id
@property (nonatomic, copy) NSString *itemTitle;    //  标题
@property (nonatomic, copy) NSString *itemIcon;    //  图标名称
@property (nonatomic, assign) BOOL isRequired;  //  是否必须字段

@end
