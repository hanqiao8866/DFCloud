//
//  TXCustomerTextView.h
//  CustomerTextView
//
//  Created by dsc on 15/4/24.
//  Copyright (c) 2015年 XingFuTongIOSClient. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 * @brief 继承于UITextView，添加了placeholder支持，就像UITextField一样的拥有placeholder功能
 * @author 
 */
@interface DXCustomerTextView : UITextView


/*!
 * @brief 占位符文本,与UITextField的placeholder功能一致
 */
@property (nonatomic, strong) NSString *placeholder;

@property (nonatomic, strong) UIFont *placeHolderFont;  //  占位符font

/*!
 * @brief 占位符文本颜色
 */
@property (nonatomic, strong) UIColor *placeholderTextColor;

@end
