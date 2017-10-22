//
//  MyPointAnnnotation.h
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/22.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CompanyModel.h"

@interface MyPointAnnnotation : MAPointAnnotation

@property (nonatomic, strong) CompanyModel *companyModel;

@end
