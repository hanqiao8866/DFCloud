//
//  OrderDetailTextTableViewCell.m
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/19.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import "OrderDetailTextTableViewCell.h"
#import "OrderModel.h"

@implementation OrderDetailTextTableViewCell {
    UILabel *_contentLabel; // 订单内容
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _contentLabel = [UILabel new];
    [self.contentView addSubview:_contentLabel];
    _contentLabel.textColor = [UIColor colorWithHexString:@"#586A7B"];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.numberOfLines = 0;
    
    _contentLabel.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 10).rightSpaceToView(self.contentView, 20).autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView:_contentLabel bottomMargin:10];
}

- (void)setModel:(OrderModel *)model {
    _model = model;
    _contentLabel.text = model.orderContent;
}

@end
