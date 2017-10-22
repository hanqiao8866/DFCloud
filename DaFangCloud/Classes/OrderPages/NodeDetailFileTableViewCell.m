//
//  NodeDetailFileTableViewCell.m
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/21.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import "NodeDetailFileTableViewCell.h"
#import "ResultModel.h"

@implementation NodeDetailFileTableViewCell{
    UIImageView *_fileImageView;
    UILabel *_fileNameLabel;
    UILabel *_fileSizeLabel;
    UIImageView *_downImageView;
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
    _fileImageView = [ToolBoxView creatImageViewWithImageName:@"" toView:self.contentView];
    _fileNameLabel = [ToolBoxView creatLabelWithTextColor:[UIColor colorWithHexString:@"#3C3B3F"] andTextFont:[UIFont systemFontOfSize:16.0f] toView:self.contentView];
    _dateLabel = [ToolBoxView creatLabelWithTextColor:[UIColor colorWithHexString:@"#999999"] andTextFont:[UIFont systemFontOfSize:14.0f] toView:self.contentView];
    _downImageView = [ToolBoxView creatImageViewWithImageName:@"downloaded" toView:self.contentView];
    _fileSizeLabel = [ToolBoxView creatLabelWithTextColor:[UIColor colorWithHexString:@"#999999"] andTextFont:[UIFont systemFontOfSize:14.0f] toView:self.contentView];
    _fileSizeLabel.textAlignment = NSTextAlignmentRight;
    
    CGFloat margin = 10;
    UIView *contentView = self.contentView;
    _fileImageView.sd_layout.leftSpaceToView(contentView, margin).topSpaceToView(contentView, margin).heightIs(50).widthIs(50);
    _downImageView.sd_layout.rightSpaceToView(contentView, margin).topSpaceToView(contentView, margin).heightIs(20).widthIs(20);
    _fileNameLabel.sd_layout.leftSpaceToView(_fileImageView, margin).topSpaceToView(contentView, margin).rightSpaceToView(_downImageView, margin).heightIs(20);
    _fileSizeLabel.sd_layout.rightSpaceToView(contentView, margin).topSpaceToView(_fileNameLabel, margin).widthIs(100).heightIs(20);
    _dateLabel.sd_layout.leftSpaceToView(_fileImageView, margin).topSpaceToView(_fileNameLabel, margin).rightSpaceToView(_fileSizeLabel, margin).heightIs(20);
    
    [self setupAutoHeightWithBottomViewsArray:@[_fileImageView,_dateLabel] bottomMargin:margin];
    
}

- (void)setModel:(ResultModel *)model {
    _model = model;
    _fileImageView.image = ImageNamed(@"pdf");
    _fileNameLabel.text = model.fileName;
    _fileSizeLabel.text = model.fileSize;
    _dateLabel.text = model.date;
    
}

@end
