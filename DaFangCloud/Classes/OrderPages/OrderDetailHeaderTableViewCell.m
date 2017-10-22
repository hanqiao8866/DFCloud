//
//  OrderDetailHeaderTableViewCell.m
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/19.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import "OrderDetailHeaderTableViewCell.h"
#import "OrderModel.h"

@implementation OrderDetailHeaderTableViewCell {
    UILabel *_numberLabel; // 订单号
    UILabel *_dateLabel; // 日期
    UILabel *_priceLabel; // 价格
    UILabel *_statusLabel; // 状态
    UILabel *_clientNameLabel; // 客户名称
    
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
    
    _numberLabel = [UILabel new];
    [bgView addSubview:_numberLabel];
    _numberLabel.textColor = [UIColor colorWithHexString:@"#485465"];
    _numberLabel.font = [UIFont systemFontOfSize:16];

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
    _statusLabel.textColor = [UIColor colorWithHexString:@"#0069BC"];
    _statusLabel.font = [UIFont systemFontOfSize:14.0f];
    
    _priceLabel = [UILabel new];
    [bgView addSubview:_priceLabel];
    _priceLabel.textColor = [UIColor colorWithHexString:@"#EE5C4E"];
    _priceLabel.font = [UIFont systemFontOfSize:16.0f];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    
    CGFloat margin = 10;
    UIView *contentView = self.contentView;
    
    bgView.sd_layout.leftSpaceToView(contentView, 10).topSpaceToView(contentView, 5).rightSpaceToView(contentView, 10).heightIs(110);
    _dateLabel.sd_layout.topSpaceToView(bgView, margin).rightSpaceToView(bgView, margin).widthIs(100).heightIs(30);
    _numberLabel.sd_layout.leftSpaceToView(bgView, margin).topSpaceToView(bgView, margin).rightSpaceToView(_dateLabel, margin).heightIs(30);
    _priceLabel.sd_layout.rightSpaceToView(bgView, margin).topSpaceToView(_dateLabel, 15).widthIs(100).heightIs(30);

    _clientNameLabel.sd_layout.leftSpaceToView(bgView, margin).topSpaceToView(_numberLabel, 20).widthIs(100).heightIs(30);
    _statusLabel.sd_layout.leftSpaceToView(_clientNameLabel, 0).topSpaceToView(_numberLabel, 20).rightSpaceToView(_priceLabel, margin).heightIs(30);
    
    [self setupAutoHeightWithBottomView:bgView bottomMargin:5];
    
}

- (void)setModel:(OrderModel *)model {
    _model = model;
    _numberLabel.text = model.orderNumber;
    _dateLabel.text = model.orderDate;
    _clientNameLabel.text = model.orderClient;
    _statusLabel.text = model.orderStatus;
    _priceLabel.text = model.orderPrice;
}

@end
