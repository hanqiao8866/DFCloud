//
//  DXLaunchActivityTableViewCell.m
//  DXDesign
//
//  Created by Caxa on 15/7/31.
//  Copyright (c) 2015年 mlf. All rights reserved.
//


#import "DXLaunchActivityTableViewCell.h"

@implementation DXLaunchActivityTableViewCell
{
    CAShapeLayer *lineLayer;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.rightViewType = DXRightViewTypeNone;
    
    // Initialization code
    self.activityTextField.textColor = [UIColor colorWithHexString:@"#333333"];
    self.activityTextField.font = Font_Size_System(30);
    
    UIColor *placeHolderColor = [UIColor colorWithHexString:@"#999999"];
    [self.activityTextField setValue:placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.activityTextField setValue:Font_Size_System(30) forKeyPath:@"_placeholderLabel.font"];
    
    self.activityTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.activityTextField.delegate = self;
    self.activityTextField.adjustsFontSizeToFitWidth = YES;
    self.activityTextField.returnKeyType = UIReturnKeyDone;
    
    self.leftLabel.textColor = [UIColor colorWithHexString:@"#666666"];

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
//    CGFloat titleWith = [self.leftLabel.text boundingRectWithSize:CGSizeMake(200, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.leftLabel.font} context:nil].size.width;
//    self.leftLabel.frame = CGRectMake(5, 0, titleWith, self.contentView.height);
//    self.leftLabel.backgroundColor = [UIColor randomColor];
//    self.activityTextField.frame = CGRectMake(titleWith, 0, _bgView.width - titleWith - 10, self.contentView.height);
//    self.activityTextField.backgroundColor = [UIColor randomColor];
    
    if (nil == lineLayer) {
        UIBezierPath * linePath1 = [UIBezierPath bezierPath];
        // start at top left corner
        [linePath1 moveToPoint:CGPointMake(0,self.contentView.height)];
        [linePath1 addLineToPoint:CGPointMake(self.contentView.width, self.contentView.height)];
        
        lineLayer = [CAShapeLayer layer];
        lineLayer.lineWidth = 1.0;
        lineLayer.strokeColor = [UIColor colorWithHexString:@"#eeeeee"].CGColor;
        //虚线边框
        if (self.isDashPattern) {
            lineLayer.lineDashPattern = @[@3, @8];
        }
        
        lineLayer.fillColor = nil;
        lineLayer.path = linePath1.CGPath;
        
        [self.bgView.layer addSublayer:lineLayer];
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//  设置右侧指示图样式
-(void)setRightViewType:(DXRightViewType)rightViewType
{
    //最右侧加图片
    UIButton *arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    arrowBtn.userInteractionEnabled = NO;
    arrowBtn.frame = CGRectMake(0, 0, 30, 20);
    arrowBtn.right = self.activityTextField.right - 10;
//    arrowBtn.backgroundColor = [UIColor randomColor];
    if (rightViewType == DXRightViewTypeArrow) {
        [arrowBtn setImage:[UIImage imageNamed:@"siteDownArrow"] forState:UIControlStateNormal];
        self.activityTextField.rightViewMode = UITextFieldViewModeAlways;
    }else if (rightViewType == DXRightViewTypeRightArrow) {
        
    }
    
    self.activityTextField.rightView = arrowBtn;
}

- (void)setMovingView:(UITableView *)movingView
{
    _movingView = movingView;
    self.activityTextField.kbMoving.kbMovingView = movingView;
}

#pragma mark - UITextField delegate
//  禁止用户随意输入 开始结束时间
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]){
        [textField resignFirstResponder];
        return NO;
    }
    if ([self.moduleTitle isEqualToString:@"资源类型"] ) {
        //  活动性质 开始时间 结束时间禁止用户输入
        return NO;
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.launchDelegate respondsToSelector:@selector(textFieldBeginEdit:)]) {
        [self.launchDelegate textFieldBeginEdit:self];
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.launchDelegate respondsToSelector:@selector(textFieldEndEdit:)]) {
        [self.launchDelegate textFieldEndEdit:self];
    }
}

@end
