//
//  ResultModel.h
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/21.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultModel : NSObject

@property (nonatomic, copy) NSString *fileId;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *fileSize;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *fileUrl;
@property (nonatomic, copy) NSString *fileType;

@end
