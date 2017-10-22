//
//  NodeDetailHeaderTableViewCell.m
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/21.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import "NodeDetailHeaderTableViewCell.h"
#import "NodeModel.h"

@implementation NodeDetailHeaderTableViewCell {
    UILabel *_nodeNameLabel; // 节点名称
    UILabel *_dateLabel; // 日期
    UILabel *_clientNameLabel; // 客户名称
    UILabel *_statusLabel; // 状态
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    self.contentView.backgroundColor = ColorWithRGB(246, 246, 246);
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    bgView.layer.shadowColor = [UIColor colorWithHexString:@"#E8EEFF"].CGColor;//shadowColor阴影颜色
    bgView.layer.shadowOffset = CGSizeMake(5,10);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    bgView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    bgView.layer.shadowRadius = 6;//阴影半径，默认3
    bgView.layer.cornerRadius = 6.0;
    
    _nodeNameLabel = [UILabel new];
    [bgView addSubview:_nodeNameLabel];
    _nodeNameLabel.textColor = [UIColor colorWithHexString:@"#485465"];
    _nodeNameLabel.font = [UIFont systemFontOfSize:16];
    
    _dateLabel = [UILabel new];
    [bgView addSubview:_dateLabel];
    _dateLabel.textColor = [UIColor colorWithHexString:@"#AEB7C3"];
    _dateLabel.font = [UIFont systemFontOfSize:13];
    _dateLabel.textAlignment = NSTextAlignmentRight;
    
    _clientNameLabel = [UILabel new];
    [bgView addSubview:_clientNameLabel];
    _clientNameLabel.textColor = [UIColor colorWithHexString:@"#626972"];
    _clientNameLabel.font = [UIFont systemFontOfSize:14];
    
    _statusLabel = [UILabel new];
    [bgView addSubview:_statusLabel];
    _statusLabel.textColor = [UIColor colorWithHexString:@"#16BC00"];
    _statusLabel.font = [UIFont systemFontOfSize:14.0f];
    
    UIButton *btn = [ToolBoxView creatButtonWithTitleColor:[UIColor whiteColor] andBackgroundColor:MainAppColor andTitle:@"完成任务" toView:self.contentView];
    [btn setImage:ImageNamed(@"") forState:UIControlStateNormal];
    btn.layer.cornerRadius = 4.0f;
    btn.layer.masksToBounds = YES;
    [self.contentView addSubview:btn];
    [btn addTarget:self action:@selector(doTaskBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    btn.layer.shadowColor = [UIColor colorWithHexString:@"#AABCFE"].CGColor;//shadowColor阴影颜色
    btn.layer.shadowOffset = CGSizeMake(5,10);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    btn.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    btn.layer.shadowRadius = 6;//阴影半径，默认3
    btn.layer.cornerRadius = 6.0;
    
    CGFloat margin = 10;
    UIView *contentView = self.contentView;
    
    bgView.sd_layout.leftSpaceToView(contentView, 10).topSpaceToView(contentView, 5).rightSpaceToView(contentView, 10).heightIs(110);
    _dateLabel.sd_layout.topSpaceToView(bgView, margin).rightSpaceToView(bgView, margin).widthIs(100).heightIs(30);
    _nodeNameLabel.sd_layout.leftSpaceToView(bgView, margin).topSpaceToView(bgView, margin).rightSpaceToView(_dateLabel, margin).heightIs(30);
    
    _clientNameLabel.sd_layout.leftSpaceToView(bgView, margin).topSpaceToView(_nodeNameLabel, 20).widthIs(100).heightIs(30);
    _statusLabel.sd_layout.leftSpaceToView(_clientNameLabel, 0).topSpaceToView(_nodeNameLabel, 20).rightSpaceToView(bgView, margin).heightIs(30);
    
    btn.sd_layout.leftSpaceToView(contentView, 10).topSpaceToView(bgView, 10).rightSpaceToView(contentView, 10).heightIs(50);
    
    [self setupAutoHeightWithBottomView:btn bottomMargin:5];
    
}

- (void)setModel:(NodeModel *)model {
    _model = model;
    _nodeNameLabel.text = model.nodeName;
    _dateLabel.text = model.nodeDate;
    _clientNameLabel.text = model.nodePerson;
    _statusLabel.text = model.nodeStatus;
}

- (void)doTaskBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(taskBtnClick:)]) {
        [self.delegate taskBtnClick:sender];
    }
}



@end
