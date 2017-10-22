//
//  DXLaunchActivityTableViewCell.h
//  DXDesign
//
//  Created by Caxa on 15/7/31.
//  Copyright (c) 2015年 mlf. All rights reserved.
//
/// 发布活动 通用cell
#import <UIKit/UIKit.h>
//  textfield右侧图标
typedef NS_ENUM(NSInteger, DXRightViewType)
{
    DXRightViewTypeNone = 0,    //  右侧无图片
    DXRightViewTypeArrow,    //  箭头
    DXRightViewTypeRightArrow  //  右侧箭头
    
};
@class DXLaunchActivityTableViewCell;

@protocol DXLaunchActivityTableViewCellDelegate <NSObject>

- (void)textFieldBeginEdit:(DXLaunchActivityTableViewCell *)cell;
- (void)textFieldEndEdit:(DXLaunchActivityTableViewCell *)cell;

@end

@interface DXLaunchActivityTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UITextField *activityTextField;

@property (nonatomic, copy) NSString *moduleTitle;
@property (nonatomic, assign) DXRightViewType rightViewType; //  右侧图标类型
@property (nonatomic, strong) UITableView *movingView;
@property (nonatomic, assign) id<DXLaunchActivityTableViewCellDelegate> launchDelegate;

@property (nonatomic, assign) BOOL isDashPattern;   //  是否虚线分割 默认实线

@end
