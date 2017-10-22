//
//  OrderModel.h
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/19.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property (nonatomic, assign) NSString *orderid;
@property (nonatomic, copy) NSString *orderName; // 订单名称
@property (nonatomic, copy) NSString *orderNumber; // 订单号
@property (nonatomic, copy) NSString *orderDate; // 订单时间
@property (nonatomic, copy) NSString *orderClient; // 订单客户名称
@property (nonatomic, copy) NSString *orderPrice; // 订单价格
@property (nonatomic, copy) NSString *orderProgress; // 订单进度
@property (nonatomic, copy) NSString *orderStatus; // 订单状态
@property (nonatomic, copy) NSString *orderContent; // 订单内容
@property (nonatomic, copy) NSString *orderDescription; // 订单描述


@end
