//
//  CustomAnnotationView.h
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/21.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface CustomAnnotationView : MAAnnotationView

@property (nonatomic, strong) UIImage *portrait;

@property (nonatomic, strong) UIView *calloutView;

@end
