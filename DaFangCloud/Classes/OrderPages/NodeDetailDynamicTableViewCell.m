//
//  NodeDetailDynamicTableViewCell.m
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/21.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import "NodeDetailDynamicTableViewCell.h"
#import "CommentModel.h"

@implementation NodeDetailDynamicTableViewCell{
    UIImageView *_headIamgeView;
    UILabel *_titleLabel;
    UILabel *_contentLabel;
    UILabel *_dateLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _headIamgeView = [ToolBoxView creatImageViewWithImageName:@"user_header" toView:self.contentView];
    _titleLabel = [ToolBoxView creatLabelWithTextColor:[UIColor colorWithHexString:@"#666666"] andTextFont:[UIFont systemFontOfSize:15.0f] toView:self.contentView];
    _dateLabel = [ToolBoxView creatLabelWithTextColor:[UIColor colorWithHexString:@"#999999"] andTextFont:[UIFont systemFontOfSize:14.0f] toView:self.contentView];
    _dateLabel.textAlignment = NSTextAlignmentRight;
    _contentLabel = [ToolBoxView creatLabelWithTextColor:[UIColor colorWithHexString:@"#999999"] andTextFont:[UIFont systemFontOfSize:14.0f] toView:self.contentView];
    
    CGFloat margin = 10;
    UIView *contentView = self.contentView;
    
    _headIamgeView.sd_layout.leftSpaceToView(contentView, margin).topSpaceToView(contentView, margin).heightIs(40).widthIs(40);
    _dateLabel.sd_layout.rightSpaceToView(contentView, margin).topSpaceToView(contentView, margin).widthIs(130).heightIs(20);
    _titleLabel.sd_layout.leftSpaceToView(_headIamgeView, margin).topSpaceToView(contentView, margin).rightSpaceToView(_dateLabel, margin).heightIs(20);
    _contentLabel.sd_layout.leftSpaceToView(_headIamgeView, margin).topSpaceToView(_titleLabel, margin).rightSpaceToView(contentView, margin).heightIs(20);
    
    [self setupAutoHeightWithBottomViewsArray:@[_contentLabel,_headIamgeView] bottomMargin:margin];
    
}

- (void)setModel:(CommentModel *)model {
    _model = model;
    _headIamgeView.image = ImageNamed(@"user_header");
    _titleLabel.text = model.title;
    _contentLabel.text = model.content;
    _dateLabel.text = model.date;
}

@end
