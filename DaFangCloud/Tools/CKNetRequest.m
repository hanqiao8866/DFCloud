//
//  CKNetRequest.m
//  CAXA-KanTu
//
//  Created by ylei on 16/9/27.
//  Copyright © 2016年 Lei Yang. All rights reserved.
//

#import "CKNetRequest.h"

@implementation CKNetRequest
+ (instancetype)request {
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        self.operationManager = [AFHTTPSessionManager manager];
    }
    return self;
}

- (void)GET:(NSString *)URLString
 parameters:(NSDictionary *)parameters
    success:(void (^)(NSURLSessionDataTask *task, NSString *responseString))success
    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    self.operationQueue = self.operationManager.operationQueue;
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/plain",@"application/octet-stream",nil];
    self.operationManager.requestSerializer.timeoutInterval = 12;
    [self.operationManager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseJson = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

        // MARK: 添加接口地址打印 2017-07-21 by:XT
        NSString *paraStr;
        for (NSString *key in parameters.allKeys) {
            if (paraStr == nil) {
                paraStr = [NSString stringWithFormat:@"%@=%@",key, parameters[key]];
            } else {
                paraStr = [NSString stringWithFormat:@"%@&%@=%@",paraStr,key, parameters[key]];
            }
        }
        NSString *fullUrl = [NSString stringWithFormat:@"%@?%@",URLString,paraStr];

        LLog(@"[URL]: %@\n[TotalURL]: %@\n[Parameters]: %@\n[CKNetRequest]: Success\n%@",URLString,fullUrl,parameters,responseJson);
        success(task,responseJson);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LLog(@"[URL]: %@\n[Parameters]: %@\n[CKNetRequest]: Failure\n%@",URLString,parameters,error.localizedDescription);
        failure(task,error);
    }];
}

- (void)GET:(NSString *)URLString
 parameters:(NSDictionary *)parameters
   progress:(void (^)(NSProgress * progress))progressBlock
    success:(void (^)(NSURLSessionDataTask *task, NSString *responseString))success
    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    self.operationQueue = self.operationManager.operationQueue;
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/plain",@"application/octet-stream",nil];
    self.operationManager.requestSerializer.timeoutInterval = 12;
    [self.operationManager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        progressBlock(downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseJson = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        LLog(@"[URL]: %@\n[Parameters]: %@\n[CKNetRequest]: Success\n%@",URLString,parameters,responseJson);
        success(task,responseJson);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LLog(@"[URL]: %@\n[Parameters]: %@\n[CKNetRequest]: Failure\n%@",URLString,parameters,error.localizedDescription);
        failure(task,error);
    }];
}

- (void)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameters
     success:(void (^)(NSURLSessionDataTask *task, NSString *responseString))success
     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    self.operationQueue = self.operationManager.operationQueue;
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/plain",@"application/octet-stream",@"application/json",@"image/jpeg",@"image/png",@"text/json",@"multipart/form-data",nil];
    self.operationManager.requestSerializer.timeoutInterval = 12;

    NSString *paraStr;
    for (NSString *key in parameters.allKeys) {
        if (paraStr == nil) {
            paraStr = [NSString stringWithFormat:@"%@=%@",key, parameters[key]];
        } else {
            paraStr = [NSString stringWithFormat:@"%@&%@=%@",paraStr,key, parameters[key]];
        }
    }
    NSString *fullUrl = [NSString stringWithFormat:@"%@?%@",URLString,paraStr];
    fullUrl = [fullUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.operationManager POST:fullUrl parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        LLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString* responseJson = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        LLog(@"[CKNetRequest]: %@",responseJson);
        success(task,responseJson);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LLog(@"[CKNetRequest]: %@",error.localizedDescription);
        failure(task,error);
    }];
}

- (void)                POST:(NSString *)URLString
                  parameters:(NSDictionary *)parameters
   constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                    progress:(void (^)(NSProgress * progress))progressBlock
                     success:(void (^)(NSURLSessionDataTask *task, NSString *responseString))success
                     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    self.operationQueue = self.operationManager.operationQueue;
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/plain",@"application/octet-stream",@"application/json",@"image/jpeg",@"image/png",@"text/json",@"multipart/form-data",nil];
    self.operationManager.requestSerializer.timeoutInterval = 600;
    [self.operationManager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        block(formData);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progressBlock(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString* responseJson = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        LLog(@"[CKNetRequest]: %@",responseJson);
        success(task,responseJson);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LLog(@"[CKNetRequest]: %@",error.localizedDescription);
        failure(task,error);
    }];
}

- (void)cancelAllOperations{
    [self.operationQueue cancelAllOperations];
}

- (void)Download:(NSString *)URLString
        savePath:(NSString *)aSavePath
        progress:(void (^)(NSProgress * progress))progressBlock
         success:(void (^)(NSURLSessionDataTask *task, NSString *responseString))success
         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    //下载附件
    self.operationQueue = self.operationManager.operationQueue;
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    self.operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/plain",@"application/octet-stream",nil];
    self.operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/plain",@"application/octet-stream",@"application/json",@"image/jpeg",@"image/png",@"text/json",@"multipart/form-data",nil];

    NSString *fileDownloadSourceURLString = URLString;
    fileDownloadSourceURLString = [fileDownloadSourceURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSURL *url = [[NSURL alloc] initWithString:fileDownloadSourceURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *downloadTask = [self.operationManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            progressBlock(downloadProgress);
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //这里要返回一个NSURL，其实就是文件的位置路径
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSString *fileNetNameString = response.suggestedFilename;
        NSMutableString *fileLocalNameString = [NSMutableString stringWithString:response.suggestedFilename];
        
        //检查本地文件是否已存在
        NSString *fileLocalDownloadPathString = [NSString stringWithFormat:@"%@%@", aSavePath, fileLocalNameString];
        
        NSInteger index = 1;
        
        do {
            if ([fileManager fileExistsAtPath:fileLocalDownloadPathString]) {
                NSString *filePathEx = [fileNetNameString pathExtension];
                fileLocalNameString = [NSMutableString stringWithString:fileNetNameString];
                [fileLocalNameString insertString:[NSString stringWithFormat:@"(%ld)",(long)index] atIndex:fileLocalNameString.length-filePathEx.length-1];
                fileLocalDownloadPathString = [NSString stringWithFormat:@"%@%@", aSavePath, fileLocalNameString];
                index++;
            }
            else {
                break ;
            }
        } while (1);
        
        //创建附件存储目录
        if (![fileManager fileExistsAtPath:aSavePath]) {
            [fileManager createDirectoryAtPath:aSavePath withIntermediateDirectories:YES attributes:nil error:nil];
        }

        return [NSURL fileURLWithPath:fileLocalDownloadPathString];//转化为文件路径
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath,
                          NSError * _Nullable error) {
        //如果下载的是压缩包的话，可以在这里进行解压
        NSLog(@"----%@---%ld---%@",error.domain,error.code,error);
        //下载成功
        if (error == nil) {
            success(nil,[filePath path]);
        } else { //下载失败的时候，只列举判断了两种错误状态码
            failure(nil,error);
        }
    }];
    
    [downloadTask resume];
    
}


@end
