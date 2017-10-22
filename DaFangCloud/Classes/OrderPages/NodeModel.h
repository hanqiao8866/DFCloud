//
//  NodeModel.h
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/19.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NodeModel : NSObject

@property (nonatomic, assign) NSString *nodeid;
@property (nonatomic, copy) NSString *nodeName; // 节点名称
@property (nonatomic, copy) NSString *nodeContent; // 节点内容
@property (nonatomic, copy) NSString *nodeDate; // 节点时间
@property (nonatomic, copy) NSString *nodePerson; // 节点负责人
@property (nonatomic, copy) NSString *nodeStatus; // 节点状态

@end
