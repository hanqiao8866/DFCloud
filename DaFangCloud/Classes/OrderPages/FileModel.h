//
//  FileModel.h
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/21.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileModel : NSObject

@property (nonatomic, assign) NSString *fileid;
@property (nonatomic, copy) NSString *fileName; // 文件名称
@property (nonatomic, copy) NSString *filePath; // 文件路径

@end
