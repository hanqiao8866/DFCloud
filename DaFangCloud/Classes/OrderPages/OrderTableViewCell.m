//
//  OrderTableViewCell.m
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/19.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "OrderModel.h"

@implementation OrderTableViewCell {
    UILabel *_titleLabel; // 订单名称
    UILabel *_numberLabel; // 订单号
    UIImageView *_orderProgressImageView; // 订单进度
    UILabel *_dateLabel; // 日期
    UILabel *_priceLabel; // 价格
    UILabel *_progressLabel; // 进度
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

    
    _orderProgressImageView = [UIImageView new];
    _orderProgressImageView.image = ImageNamed(@"order_progress");
    [bgView addSubview:_orderProgressImageView];
    
    _titleLabel = [UILabel new];
    [bgView addSubview:_titleLabel];
    _titleLabel.textColor = [UIColor colorWithHexString:@"#485465"];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    
    _numberLabel = [UILabel new];
    [bgView addSubview:_numberLabel];
    _numberLabel.textColor = [UIColor colorWithHexString:@"#AAB6C5"];
    _numberLabel.font = [UIFont systemFontOfSize:13];
    

    _dateLabel = [UILabel new];
    [bgView addSubview:_dateLabel];
    _dateLabel.textColor = [UIColor colorWithHexString:@"#AAB6C5"];
    _dateLabel.font = [UIFont systemFontOfSize:14];
    _dateLabel.textAlignment = NSTextAlignmentRight;
    
    _priceLabel = [UILabel new];
    [bgView addSubview:_priceLabel];
    _priceLabel.textColor = [UIColor colorWithHexString:@"#EE5C4E"];
    _priceLabel.font = [UIFont systemFontOfSize:16.0f];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    
    _progressLabel = [UILabel new];
    [bgView addSubview:_progressLabel];
    _progressLabel.textColor = [UIColor colorWithHexString:@"#5153EF"];
    _progressLabel.font = [UIFont systemFontOfSize:16.0f];
    _progressLabel.textAlignment = NSTextAlignmentCenter;
    
    
    CGFloat margin = 10;
    UIView *contentView = self.contentView;
    
    bgView.sd_layout.leftSpaceToView(contentView, 10).topSpaceToView(contentView, 5).rightSpaceToView(contentView, 10).heightIs(116);
    _orderProgressImageView.sd_layout.leftSpaceToView(bgView, margin).centerYEqualToView(bgView).widthIs(66).heightIs(66);
    _progressLabel.sd_layout.centerYEqualToView(_orderProgressImageView).centerXEqualToView(_orderProgressImageView).widthIs(60).heightIs(30);
    _dateLabel.sd_layout.rightSpaceToView(bgView, margin).topSpaceToView(bgView, 20).widthIs(100).heightIs(30);
    _titleLabel.sd_layout.leftSpaceToView(_orderProgressImageView, margin).topSpaceToView(bgView, 20).rightSpaceToView(_dateLabel, margin).heightIs(30);
    _priceLabel.sd_layout.rightSpaceToView(bgView, margin).topSpaceToView(_dateLabel, 15).widthIs(100).heightIs(30);
    _numberLabel.sd_layout.leftSpaceToView(_orderProgressImageView, margin).topSpaceToView(_titleLabel, 15).rightSpaceToView(_priceLabel, margin).heightIs(30);
    
    [self setupAutoHeightWithBottomView:bgView bottomMargin:5];
    
}

- (void)setModel:(OrderModel *)model {
    _model = model;
    _titleLabel.text = model.orderName;
    _dateLabel.text = model.orderDate;
    _numberLabel.text = model.orderNumber;
    _priceLabel.text = model.orderPrice;
    _progressLabel.text = model.orderProgress;
}

@end
