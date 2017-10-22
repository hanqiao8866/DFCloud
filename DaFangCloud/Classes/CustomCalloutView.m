//
//  CustomCalloutView.m
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/21.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import "CustomCalloutView.h"
#import <QuartzCore/QuartzCore.h>
#import "CompanyModel.h"

#define kArrorHeight        10

@implementation CustomCalloutView {
    UIImageView *_logoImageView;
    UILabel *_nameLabel;
    UIImageView *_flagImageView;
    UILabel *_tagLabel1;
    UILabel *_tagLabel2;
    UILabel *_addressLabel;
    UILabel *_distanceLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    
    _logoImageView = [ToolBoxView creatImageViewWithImageName:@"caxa_logo.jpg" toView:self];
    _nameLabel = [ToolBoxView creatLabelWithTextColor:[UIColor colorWithHexString:@"#485465"] andTextFont:[UIFont systemFontOfSize:16.0] toView:self];
    _nameLabel.numberOfLines = 0;
    _flagImageView = [ToolBoxView creatImageViewWithImageName:@"star_icon" toView:self];
    _tagLabel1 = [ToolBoxView creatLabelWithTextColor:MainAppColor andTextFont:[UIFont systemFontOfSize:15.0] toView:self];
    _tagLabel1.layer.borderWidth = 1.0f;
    _tagLabel1.layer.borderColor = MainAppColor.CGColor;
    _tagLabel1.layer.cornerRadius = 15;
    _tagLabel1.textAlignment = NSTextAlignmentCenter;
    _tagLabel2 = [ToolBoxView creatLabelWithTextColor:MainAppColor andTextFont:[UIFont systemFontOfSize:15.0] toView:self];
    _tagLabel2.layer.borderWidth = 1.0f;
    _tagLabel2.layer.borderColor = MainAppColor.CGColor;
    _tagLabel2.layer.cornerRadius = 15;
    _tagLabel2.textAlignment = NSTextAlignmentCenter;
    UIImageView *addressIcon = [ToolBoxView creatImageViewWithImageName:@"address_icon" toView:self];
    _addressLabel = [ToolBoxView creatLabelWithTextColor:[UIColor colorWithHexString:@"#485465"] andTextFont:[UIFont systemFontOfSize:13] toView:self];
    _distanceLabel = [ToolBoxView creatLabelWithTextColor:[UIColor whiteColor] andTextFont:[UIFont systemFontOfSize:14] toView:self];
    _distanceLabel.backgroundColor = [UIColor colorWithHexString:@"#CBD2DC"];
    _distanceLabel.textAlignment = NSTextAlignmentCenter;
    _distanceLabel.layer.cornerRadius = 4.0f;
    _distanceLabel.layer.masksToBounds = YES;
    
    _logoImageView.sd_layout.leftSpaceToView(self, 20).topSpaceToView(self, 20).widthIs(80).heightIs(80);
    _flagImageView.sd_layout.topSpaceToView(self, 0).rightSpaceToView(self, 30).widthIs(46).heightIs(58);
    _nameLabel.sd_layout.leftSpaceToView(_logoImageView, 10).topSpaceToView(self, 20).rightSpaceToView(_flagImageView, 10).autoHeightRatio(0);
    _tagLabel1.sd_layout.leftSpaceToView(_logoImageView, 10).topSpaceToView(_nameLabel, 20).widthIs(60).heightIs(30);
    _tagLabel2.sd_layout.leftSpaceToView(_tagLabel1, 10).topSpaceToView(_nameLabel, 20).widthIs(100).heightIs(30);
    
    addressIcon.sd_layout.leftSpaceToView(self, 20).topSpaceToView(_logoImageView, 20).widthIs(16).heightIs(20);
    _distanceLabel.sd_layout.rightSpaceToView(self, 20).centerYEqualToView(addressIcon).widthIs(60).heightIs(30);
    _addressLabel.sd_layout.centerYEqualToView(addressIcon).leftSpaceToView(addressIcon, 10).rightSpaceToView(_distanceLabel, 10).heightIs(20);
    
    UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [detailBtn addTarget:self action:@selector(detailBtnClick) forControlEvents:UIControlEventTouchUpInside];
    detailBtn.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    _nameLabel.text = @"北京数码大方科技有限公司";
    _tagLabel1.text = @"机械";
    _tagLabel2.text = @"软件服务";
    _addressLabel.text = @"北京市海淀区丰秀中路3号院9号楼";
    _distanceLabel.text = @"1.2KM";
    
    
}

- (void)setModel:(CompanyModel *)model {
    _model = model;
}

- (void)detailBtnClick {
    
}

#pragma mark - draw rect

- (void)drawRect:(CGRect)rect {
    [self drawInContext:UIGraphicsGetCurrentContext()];
    self.layer.shadowColor = [[UIColor colorWithRed:92/255.0f green:96/255.0f blue:150/255.0f alpha:0.16] CGColor];
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}

- (void)drawInContext:(CGContextRef)context {
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    [self getDrawPath:context];
    CGContextFillPath(context);
}

- (void)getDrawPath:(CGContextRef)context {
    CGRect rrect = self.bounds;
    CGFloat radius = 6.0;
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}

@end
