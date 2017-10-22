//
//  OrderDetailTraceTableViewCell.h
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/19.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NodeModel;

@interface OrderDetailTraceTableViewCell : UITableViewCell

@property(nonatomic, strong) NodeModel *model;
@property (nonatomic, strong) UIImageView *bigImageView;
@property (nonatomic, strong) UIView *vLine1;
@property (nonatomic, strong) UIView *vLine2;

@end
