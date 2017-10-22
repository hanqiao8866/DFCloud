//
//  BaseTableFooterView.m
//  TXiOSClient
//
//  Created by dsc on 15/5/7.
//  Copyright (c) 2015年 liguohui. All rights reserved.
//

#import "BaseTableFooterView.h"


@implementation BaseTableFooterView
{
    UILabel *_titleLabel;   //  标题
    UIImageView *_bgImageView;  //  背景图片
    UIView *_sectionTitleView;  //  承载标题的view
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _sectionTitleView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_sectionTitleView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize sectionSize = [_titleLabel.text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(self.contentView.width - 10 *2, 200) lineBreakMode:NSLineBreakByWordWrapping];
    _sectionTitleView.width = self.contentView.width;
    _sectionTitleView.height = sectionSize.height + 9 + 21;
    
    _titleLabel.left = 10;
    _titleLabel.width = self.contentView.width - 10*2;
    _titleLabel.height = sectionSize.height;
    _titleLabel.centerY = self.contentView.centerY;
}

- (void)setSectionTitle:(NSString *)sectionTitle
{
    _titleLabel.text = sectionTitle;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
