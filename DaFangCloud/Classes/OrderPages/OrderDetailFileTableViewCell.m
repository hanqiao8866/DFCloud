//
//  OrderDetailFileTableViewCell.m
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/19.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import "OrderDetailFileTableViewCell.h"
#import "FileModel.h"

@implementation OrderDetailFileTableViewCell {
    UILabel *_fileNameLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _fileNameLabel = [UILabel new];
    [self.contentView addSubview:_fileNameLabel];
    _fileNameLabel.textColor = [UIColor colorWithHexString:@"#0069BC"];
    _fileNameLabel.font = [UIFont systemFontOfSize:15];
    
    _fileNameLabel.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 20).rightSpaceToView(self.contentView, 20).heightIs(30);
    
    [self setupAutoHeightWithBottomView:_fileNameLabel bottomMargin:10];
}

- (void)setModel:(FileModel *)model {
    _model = model;
    _fileNameLabel.text = model.fileName;
}


@end
