//
//  CompanyTableViewCell.m
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/18.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import "CompanyTableViewCell.h"
#import "CompanyModel.h"

@implementation CompanyTableViewCell {
    UILabel *_titleLabel; // 企业名称
    UILabel *_contentLabel; // 公司介绍
    UIImageView *_headerImageView; // 企业头像
    UIImageView *_collImageView; // 关注图标
    UILabel *_collLabel; // 关注数
    UIImageView *_viewImageView; // 浏览数图标
    UILabel *_viewLabel; // 浏览数
    UILabel *_tagLabel1;
    UILabel *_tagLabel2;
    UILabel *_tagLabel3;
    UILabel *_tagLabel4;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _headerImageView = [UIImageView new];
    _headerImageView.layer.borderColor = [[UIColor colorWithHexString:@"#cfcfcf"] CGColor];
    _headerImageView.layer.borderWidth = 1.0f;
    _headerImageView.layer.cornerRadius = 2.0f;
    _headerImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_headerImageView];
    
    _titleLabel = [UILabel new];
    [self.contentView addSubview:_titleLabel];
    _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.numberOfLines = 0;
    
    _contentLabel = [UILabel new];
    [self.contentView addSubview:_contentLabel];
    _contentLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.numberOfLines = 0;
    
    _collImageView = [UIImageView new];
    [self.contentView addSubview:_collImageView];
    _collImageView.image = ImageNamed(@"collect_icon");
    
    _collLabel = [UILabel new];
    [self.contentView addSubview:_collLabel];
    _collLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    _collLabel.font = [UIFont systemFontOfSize:12.0f];
    
    _viewImageView = [UIImageView new];
    [self.contentView addSubview:_viewImageView];
    _viewImageView.image = ImageNamed(@"view_icon");
    
    _viewLabel = [UILabel new];
    [self.contentView addSubview:_viewLabel];
    _viewLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    _viewLabel.font = [UIFont systemFontOfSize:12.0f];
    
    _tagLabel1 = [self creatTagLabelWithBgColor:ColorWithRGB(255, 169, 46) andText:@"机械"];
    _tagLabel2 = [self creatTagLabelWithBgColor:ColorWithRGB(0, 131, 250) andText:@"软件"];
    _tagLabel3 = [self creatTagLabelWithBgColor:ColorWithRGB(127, 128, 130) andText:@"CAD"];
    _tagLabel4 = [self creatTagLabelWithBgColor:ColorWithRGB(0, 154, 40) andText:@"PLM"];
    
    
    CGFloat margin = 10;
    UIView *contentView = self.contentView;
    
    _headerImageView.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin)
    .widthIs(70)
    .heightIs(70);
    
    _titleLabel.sd_layout
    .leftSpaceToView(_headerImageView, margin)
    .topSpaceToView(contentView, margin)
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0);
    
    _viewImageView.sd_layout.leftSpaceToView(_headerImageView, margin).topSpaceToView(_titleLabel, margin).heightIs(15).widthIs(24);
    _viewLabel.sd_layout.leftSpaceToView(_viewImageView, margin).centerYEqualToView(_viewImageView).widthIs(60).heightIs(20);
    _collImageView.sd_layout.leftSpaceToView(_viewLabel, margin).topSpaceToView(_titleLabel, margin).heightIs(16).widthIs(16);
    _collLabel.sd_layout.leftSpaceToView(_collImageView, margin).centerYEqualToView(_viewImageView).widthIs(60).heightIs(20);
    
    _contentLabel.sd_layout
    .leftSpaceToView(_headerImageView, margin)
    .topSpaceToView(_viewImageView, margin)
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0);
    
    _tagLabel1.sd_layout.leftSpaceToView(contentView, margin).topSpaceToView(_contentLabel, margin).widthIs(60).heightIs(20);
    _tagLabel2.sd_layout.leftSpaceToView(_tagLabel1, margin).topSpaceToView(_contentLabel, margin).widthIs(60).heightIs(20);
    _tagLabel3.sd_layout.leftSpaceToView(_tagLabel2, margin).topSpaceToView(_contentLabel, margin).widthIs(60).heightIs(20);
    _tagLabel4.sd_layout.leftSpaceToView(_tagLabel3, margin).topSpaceToView(_contentLabel, margin).widthIs(60).heightIs(20);
    
    
    [self setupAutoHeightWithBottomViewsArray:@[_tagLabel1, _tagLabel2, _tagLabel3, _tagLabel4] bottomMargin:margin];
    
}

- (UILabel *)creatTagLabelWithBgColor:(UIColor *)bgColor andText:(NSString *)text {
    UILabel *label = [UILabel new];
    label.backgroundColor = bgColor;
    label.text = text;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 10;
    label.layer.masksToBounds = YES;
    [self.contentView addSubview:label];
    return label;
}

- (void)setModel:(CompanyModel *)model {
    
    _model = model;
    _titleLabel.text = model.title;
    _contentLabel.text = model.content;
//    NSString *imageUrl = [model.column1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:ImageNamed(@"placeholder100_100")];
    _headerImageView.image = ImageNamed(@"caxa_logo.jpg");
    _collLabel.text = model.collsnum;
    _viewLabel.text = model.viewnum;
}

@end
