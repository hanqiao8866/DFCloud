//
//  SubmitTableViewCell.m
//  DeYangCloud
//
//  Created by 谢涛 on 16/9/2.
//  Copyright © 2016年 X.T. All rights reserved.
//

#import "SubmitTableViewCell.h"

@implementation SubmitTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    self.submitBtn.layer.cornerRadius = 5.0f;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)submitBtnAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(submitBtnClick:)]) {
        [self.delegate submitBtnClick:sender];
    }
}
@end
