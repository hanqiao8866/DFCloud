//
//  ToolBoxView.h
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/21.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ActionBlock)();

@interface ToolBoxView : NSObject

// UIView
+ (UIView *)creatViewWithBackgroundColor:(UIColor *)bgColor toView:(UIView *)parentView;
+ (UIView *)creatViewWithBackgroundColor:(UIColor *)bgColor andFrame:(CGRect)frame toView:(UIView *)parentView;

// UILabel
+ (UILabel *)creatLabelWithTextColor:(UIColor *)textColor andTextFont:(UIFont *)font toView:(UIView *)parentView;
+ (UILabel *)creatLabelWithFrame:(CGRect)frame andTextColor:(UIColor *)textColor andTextFont:(UIFont *)font toView:(UIView *)parentView;
+ (UILabel *)creatLabelWithTextColor:(UIColor *)textColor andTextFont:(UIFont *)font andLineSpaceValue:(CGFloat)spaceValue andText:(NSString *)text toView:(UIView *)parentView;

// UIImageView
+ (UIImageView *)creatImageViewWithImageName:(NSString *)imageName toView:(UIView *)parentView;
+ (UIImageView *)creatImageViewWithFrame:(CGRect)frame andImageName:(NSString *)imageName toView:(UIView *)parentView;

// UIButton
+ (UIButton *)creatButtonWithTitleColor:(UIColor *)titleColor andBackgroundColor:(UIColor *)bgColor andTitle:(NSString *)title toView:(UIView *)parentView;
+ (UIButton *)creatButtonWithTitleColor:(UIColor *)titleColor andBackgroundColor:(UIColor *)bgColor andTitle:(NSString *)title toView:(UIView *)parentView withHandleBlock:(ActionBlock)action;
+ (UIButton *)creatButtonWithFrame:(CGRect)frame andTitleColor:(UIColor *)titleColor andBackgroundColor:(UIColor *)bgColor andTitleFont:(UIFont *)font andTitle:(NSString *)title toView:(UIView *)parentView;

// UITextField
+ (UITextField *)creatTextFieldWithBorderStyle:(UITextBorderStyle)borderStyle andFont:(UIFont *)font andClearButtonMode:(UITextFieldViewMode)clearnButtonMode andReturnKeyType:(UIReturnKeyType)returnKeyType andPlaceholder:(NSString *)placeholder toView:(UIView *)parentView;
+ (UITextField *)creatTextFieldWithFrame:(CGRect)frame andBorderStyle:(UITextBorderStyle)borderStyle andFont:(UIFont *)font andClearButtonMode:(UITextFieldViewMode)clearnButtonMode andReturnKeyType:(UIReturnKeyType)returnKeyType andPlaceholder:(NSString *)placeholder toView:(UIView *)parentView;

@end
