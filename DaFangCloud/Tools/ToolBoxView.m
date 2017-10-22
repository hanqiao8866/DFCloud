//
//  ToolBoxView.m
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/21.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import "ToolBoxView.h"
#import <objc/runtime.h>

static char overviewKey;

@implementation ToolBoxView

+ (UIView *)creatViewWithBackgroundColor:(UIColor *)bgColor toView:(UIView *)parentView {
    UIView *view = [UIView new];
    view.backgroundColor = bgColor;
    [parentView addSubview:view];
    return view;
}

+ (UIView *)creatViewWithBackgroundColor:(UIColor *)bgColor andFrame:(CGRect)frame toView:(UIView *)parentView {
    UIView *view = [ToolBoxView creatViewWithBackgroundColor:bgColor toView:parentView];
    view.frame = frame;
    return view;
}

+ (UILabel *)creatLabelWithTextColor:(UIColor *)textColor andTextFont:(UIFont *)font toView:(UIView *)parentView{
    UILabel *label = [UILabel new];
    label.textColor = textColor;
    label.font = font;
    [parentView addSubview:label];
    return label;
}

+ (UILabel *)creatLabelWithTextColor:(UIColor *)textColor andTextFont:(UIFont *)font andLineSpaceValue:(CGFloat)spaceValue andText:(NSString *)text toView:(UIView *)parentView {
    UILabel *label = [UILabel new];
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = spaceValue; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.0f};
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:text attributes:dic];
    label.attributedText = attributeStr;
    label.textColor = textColor;
    [parentView addSubview:label];
    return label;
}

#define UILABEL_LINE_SPACE 6
//给UILabel设置行间距和字间距
- (void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    
}

//计算UILabel的高度(带有行间距的情况)
- (CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, MainScreenHight) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

+ (UILabel *)creatLabelWithFrame:(CGRect)frame andTextColor:(UIColor *)textColor andTextFont:(UIFont *)font toView:(UIView *)parentView {
    UILabel *label = [UILabel new];
    label.frame = frame;
    label.textColor = textColor;
    label.font = font;
    [parentView addSubview:label];
    return label;
}

+ (UIImageView *)creatImageViewWithImageName:(NSString *)imageName toView:(UIView *)parentView {
    UIImageView *imageView = [UIImageView new];
    imageView.image = ImageNamed(imageName);
    [parentView addSubview:imageView];
    return imageView;
}

+ (UIImageView *)creatImageViewWithFrame:(CGRect)frame andImageName:(NSString *)imageName toView:(UIView *)parentView {
    UIImageView *imageView = [ToolBoxView creatImageViewWithImageName:imageName toView:parentView];
    imageView.frame = frame;
    return imageView;
}

+ (UIButton *)creatButtonWithTitleColor:(UIColor *)titleColor andBackgroundColor:(UIColor *)bgColor andTitle:(NSString *)title toView:(UIView *)parentView {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.backgroundColor = bgColor;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [parentView addSubview:btn];
    return btn;
}

+ (UIButton *)creatButtonWithTitleColor:(UIColor *)titleColor andBackgroundColor:(UIColor *)bgColor andTitle:(NSString *)title toView:(UIView *)parentView withHandleBlock:(ActionBlock)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundColor:bgColor];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    objc_setAssociatedObject(self, &overviewKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [btn addTarget:self action:@selector(callActionBlock:) forControlEvents:UIControlEventTouchUpInside];
    [parentView addSubview:btn];
    return btn;
}

+ (UIButton *)creatButtonWithFrame:(CGRect)frame andTitleColor:(UIColor *)titleColor andBackgroundColor:(UIColor *)bgColor andTitleFont:(UIFont *)font andTitle:(NSString *)title toView:(UIView *)parentView {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundColor:bgColor];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [parentView addSubview:btn];
    return btn;
    
}

- (void)callActionBlock:(UIButton *)sender {
    ActionBlock block = (ActionBlock)objc_getAssociatedObject(self, &overviewKey);
    if (block) {
        block();
    }
}

+ (UITextField *)creatTextFieldWithBorderStyle:(UITextBorderStyle)borderStyle andFont:(UIFont *)font andClearButtonMode:(UITextFieldViewMode)clearnButtonMode andReturnKeyType:(UIReturnKeyType)returnKeyType andPlaceholder:(NSString *)placeholder toView:(UIView *)parentView {
    UITextField *tf = [[UITextField alloc] init];
    tf.borderStyle = borderStyle;
    tf.placeholder = placeholder;
    tf.font = font;
    tf.clearButtonMode = clearnButtonMode;
    tf.returnKeyType = returnKeyType;
    [parentView addSubview:tf];
    return tf;
}

+ (UITextField *)creatTextFieldWithFrame:(CGRect)frame andBorderStyle:(UITextBorderStyle)borderStyle andFont:(UIFont *)font andClearButtonMode:(UITextFieldViewMode)clearnButtonMode andReturnKeyType:(UIReturnKeyType)returnKeyType andPlaceholder:(NSString *)placeholder toView:(UIView *)parentView {
    UITextField *tf = [[UITextField alloc] initWithFrame:frame];
    tf.borderStyle = borderStyle;
    tf.placeholder = placeholder;
    tf.font = font;
    tf.clearButtonMode = clearnButtonMode;
    tf.returnKeyType = returnKeyType;
    [parentView addSubview:tf];
    return tf;
}


@end
