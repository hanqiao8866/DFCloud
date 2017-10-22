//
//  SubmitTableViewCell.h
//  DeYangCloud
//
//  Created by 谢涛 on 16/9/2.
//  Copyright © 2016年 X.T. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SubmitTableViewCellDelegate <NSObject>

- (void)submitBtnClick:(UIButton *)btn;

@end

@interface SubmitTableViewCell : UITableViewCell

@property (nonatomic, assign) id<SubmitTableViewCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

- (IBAction)submitBtnAction:(UIButton *)sender;

@end
