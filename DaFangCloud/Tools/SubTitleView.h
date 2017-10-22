//
//  SubTitleView.h
//  HengYouYuanProject
//
//  Created by 谢涛 on 2017/7/19.
//  Copyright © 2017年 X.T. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SubTitleView;

@protocol SubTitleViewDelegate <NSObject>

- (void)subTitleViewDidSelected:(SubTitleView *)titleView atIndex:(NSInteger)index title:(NSString *)title;

@end

@interface SubTitleView : UIView

@property (nonatomic, strong) NSMutableArray<NSString *> *titleArray;
@property (nonatomic, weak)  id<SubTitleViewDelegate> delegate;

- (void)translateShowAtIndex:(NSInteger)index;

@end
