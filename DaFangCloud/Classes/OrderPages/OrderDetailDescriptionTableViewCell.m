//
//  OrderDetailDescriptionTableViewCell.m
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/21.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import "OrderDetailDescriptionTableViewCell.h"
#import "OrderModel.h"

@implementation OrderDetailDescriptionTableViewCell {
    UILabel *_descriptionLabel; // 订单内容
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _descriptionLabel = [UILabel new];
    [self.contentView addSubview:_descriptionLabel];
    _descriptionLabel.textColor = [UIColor colorWithHexString:@"#586A7B"];
    _descriptionLabel.font = [UIFont systemFontOfSize:14];
    _descriptionLabel.numberOfLines = 0;
    
    _descriptionLabel.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 10).rightSpaceToView(self.contentView, 20).autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView:_descriptionLabel bottomMargin:10];
}

- (void)setModel:(OrderModel *)model {
    _model = model;
    _descriptionLabel.text = model.orderDescription;
}


@end
