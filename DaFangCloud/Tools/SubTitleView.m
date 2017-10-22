//
//  SubTitleView.m
//  HengYouYuanProject
//
//  Created by 谢涛 on 2017/7/19.
//  Copyright © 2017年 X.T. All rights reserved.
//

#import "SubTitleView.h"

#define kTitleNormalColor [UIColor darkGrayColor]
#define kTitleSelectedColor [UIColor colorWithHexString:@"#EE5C4E"]

@interface SubTitleView()

@property (nonatomic, strong) UIView *sliderView;
@property (nonatomic, strong) NSMutableArray *subTitleButtonArray;
@property (nonatomic, strong) UIButton *currentSelectedButton;

@end

@implementation SubTitleView

- (NSMutableArray *)subTitleButtonArray {
    if (!_subTitleButtonArray) {
        _subTitleButtonArray = [NSMutableArray array];
    }
    return _subTitleButtonArray;
}

- (UIView *)sliderView {
    if (!_sliderView) {
        _sliderView = [[UIView alloc] init];
        _sliderView.backgroundColor = kTitleSelectedColor;
    }
    return _sliderView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
        [self addSubview:self.sliderView];
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)updateConstraints {
    [super updateConstraints];
}

- (void)setTitleArray:(NSMutableArray<NSString *> *)titleArray {
    _titleArray = titleArray;
    CGFloat width = MainScreenWidth / _titleArray.count;
    for (NSInteger index = 0; index < _titleArray.count; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:_titleArray[index] forState:UIControlStateNormal];
        [button setTitleColor:kTitleNormalColor forState:UIControlStateNormal];
        [button setTitleColor:kTitleSelectedColor forState:UIControlStateSelected];
        button.frame = CGRectMake(width*index, 0, width, 45);
        button.titleLabel.font = [UIFont systemFontOfSize:AdaptiveConverter(14)];
        [button addTarget:self action:@selector(subTitleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.subTitleButtonArray addObject:button];
        [self addSubview:button];
    }

    [self selectedAtButton:self.subTitleButtonArray[0] isFirstStart:YES];
}

- (void)subTitleButtonClicked:(UIButton *)button {
    if (button == self.currentSelectedButton) {
        return ;
    }

    if ([self.delegate respondsToSelector:@selector(subTitleViewDidSelected:atIndex:title:)]) {
        [self.delegate subTitleViewDidSelected:self atIndex:[self.subTitleButtonArray indexOfObject:button] title:button.titleLabel.text];
    }
    [self selectedAtButton:button isFirstStart:NO];
}

- (void)selectedAtButton:(UIButton *)button isFirstStart:(BOOL)first {
    button.selected = YES;
    self.currentSelectedButton = button;


    if (!first) {
        [UIView animateWithDuration:0.25 animations:^{
            self.sliderView.sd_layout
            .centerXEqualToView(button);
            [self.sliderView updateLayout];
        }];
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            self.sliderView.sd_layout
            .widthIs(60)
            .heightIs(2)
            .bottomSpaceToView(self,1)
            .centerXEqualToView(button);
            [self.sliderView updateLayout];
        }];
    }

    [self unselectedAllButtonExcept:button];
}

- (void)unselectedAllButtonExcept:(UIButton *)button {
    for (UIButton *subButton in self.subTitleButtonArray) {
        subButton.selected = (button==subButton);
    }
}

- (void)translateShowAtIndex:(NSInteger)index {
    if (index < 0 || index >= self.subTitleButtonArray.count) {
        return ;
    }

    [self selectedAtButton:self.subTitleButtonArray[index] isFirstStart:NO];
}




@end
