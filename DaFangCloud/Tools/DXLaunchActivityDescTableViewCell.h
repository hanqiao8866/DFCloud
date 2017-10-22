//
//  DXLaunchActivityDescTableViewCell.h
//  DXDesign
//
//  Created by Caxa on 15/8/3.
//  Copyright (c) 2015年 mlf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXCustomerTextView.h"

@protocol descTextViewDelegate <NSObject>

//  开始编辑
- (void)textViewBeginEdit:(DXCustomerTextView *)textView;
//  文本超出范围
- (void)textLengthBeyound:(NSInteger)maxLength;
//  编辑结束
- (void)textViewEndEdit:(DXCustomerTextView *)textView;

@end

@interface DXLaunchActivityDescTableViewCell : UITableViewCell<UITextViewDelegate>

@property (nonatomic, strong)UITableView *movingView;

@property (nonatomic, strong)DXCustomerTextView *descTextView;
@property (nonatomic, assign)id<descTextViewDelegate> delegate;
@property (nonatomic, assign) NSInteger contentMaxLength;   //  文本长度

@end
