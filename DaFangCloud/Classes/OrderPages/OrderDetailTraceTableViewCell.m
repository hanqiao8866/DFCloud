//
//  OrderDetailTraceTableViewCell.m
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/19.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import "OrderDetailTraceTableViewCell.h"
#import "NodeModel.h"

@implementation OrderDetailTraceTableViewCell {
    UIImageView *_smallImageView;
    UILabel *_titleLabel;
    UILabel *_dateLabel;
    UILabel *_contentLabel;
    UIView *_line;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    _vLine1 = [UIView new];
    [self.contentView addSubview:_vLine1];
    _vLine1.backgroundColor = [UIColor colorWithHexString:@"CCD9E9"];
    
    _vLine2 = [UIView new];
    [self.contentView addSubview:_vLine2];
    _vLine2.backgroundColor = [UIColor colorWithHexString:@"CCD9E9"];
    
    _smallImageView = [UIImageView new];
    [self.contentView addSubview:_smallImageView];
    _smallImageView.image = ImageNamed(@"step_dot_unselect");
    
    _bigImageView = [UIImageView new];
    [self.contentView addSubview:_bigImageView];
    _bigImageView.image = ImageNamed(@"step_dot_select");
    _bigImageView.hidden = YES;
    
    _line = [UIView new];
    [self.contentView addSubview:_line];
    _line.backgroundColor = ColorWithRGB(244, 244, 244);
    
    _dateLabel = [UILabel new];
    [self.contentView addSubview:_dateLabel];
    _dateLabel.textColor = [UIColor colorWithHexString:@"#AAB6C5"];
    _dateLabel.font = [UIFont systemFontOfSize:12.0f];
    
    _titleLabel = [UILabel new];
    [self.contentView addSubview:_titleLabel];
    _titleLabel.textColor = [UIColor colorWithHexString:@"#0069BC"];
    _titleLabel.font = [UIFont systemFontOfSize:15.0f];
    
    _contentLabel = [UILabel new];
    [self.contentView addSubview:_contentLabel];
    _contentLabel.textColor = [UIColor colorWithHexString:@"#586A7B"];
    _contentLabel.font = [UIFont systemFontOfSize:13.0f];
    _contentLabel.numberOfLines = 0;
    
    
    UIView *contentView = self.contentView;
    
    _vLine1.sd_layout.leftSpaceToView(self.contentView,35).topSpaceToView(self.contentView,0).widthIs(3).heightIs(25);
    _bigImageView.sd_layout.centerXEqualToView(_vLine1).topSpaceToView(contentView,20).widthIs(25).heightIs(25);
    _smallImageView.sd_layout.centerXEqualToView(_vLine1).centerYEqualToView(_bigImageView).widthIs(15).heightIs(15);
    _vLine2.sd_layout.leftSpaceToView(self.contentView,35).topSpaceToView(_smallImageView,-15).widthIs(3).bottomSpaceToView(self.contentView, 0);
    _dateLabel.sd_layout.leftSpaceToView(_vLine1, 30).topSpaceToView(contentView,10).rightSpaceToView(contentView,10).heightIs(20);
    _titleLabel.sd_layout.leftSpaceToView(_vLine1,30).topSpaceToView(_dateLabel,5).rightSpaceToView(contentView,10).heightIs(20);
    _contentLabel.sd_layout.leftSpaceToView(_vLine1, 30).topSpaceToView(_titleLabel, 5).rightSpaceToView(contentView, 10).autoHeightRatio(0);
    
    _line.sd_layout.leftEqualToView(_dateLabel).topSpaceToView(_contentLabel,10).rightSpaceToView(contentView,0).heightIs(1);
    
    [self setupAutoHeightWithBottomView:_line bottomMargin:0];
  
}

- (void)setModel:(NodeModel *)model {
    _model = model;
    _dateLabel.text = model.nodeDate;
    _titleLabel.text = model.nodeName;
    _contentLabel.text = model.nodeContent;
}


@end
