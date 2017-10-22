//
//  NodeDetailHeaderTableViewCell.h
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/21.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NodeModel;

@protocol NodeDetailHeaderTableViewCellDelegate <NSObject>

- (void)taskBtnClick:(UIButton *)sender;

@end

@interface NodeDetailHeaderTableViewCell : UITableViewCell

@property(nonatomic, strong) NodeModel *model;
@property(nonatomic, assign) id<NodeDetailHeaderTableViewCellDelegate>delegate;

@end
