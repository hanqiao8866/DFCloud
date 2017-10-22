//
//  CKNetRequest.h
//  CAXA-KanTu
//
//  Created by ylei on 16/9/27.
//  Copyright © 2016年 Lei Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface CKNetRequest : NSObject

/**
 [AFNetWorking] operationManager对象
 */
@property (nonatomic, strong) AFHTTPSessionManager *operationManager;

/**
 当前的请求operation队列
 */
@property (nonatomic, strong) NSOperationQueue *operationQueue;

/**
 创建CKNetRequest的对象方法

 @return CKNetRequest对象
 */
+ (instancetype)request;

/**
 GET请求

 @param URLString  请求的url
 @param parameters GET请求参数
 @param success    请求成功调用的Block
 @param failure    请求失败调用的Block
 */
- (void)GET:(NSString *)URLString
 parameters:(NSDictionary *)parameters
    success:(void (^)(NSURLSessionDataTask *task, NSString *responseString))success
    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 GET请求
 
 @param URLString  请求的url
 @param parameters GET请求参数
 @param progressBlock  文件下载进度回调
 @param success    请求成功调用的Block
 @param failure    请求失败调用的Block
 */
- (void)GET:(NSString *)URLString
 parameters:(NSDictionary *)parameters
   progress:(void (^)(NSProgress * progress))progressBlock
    success:(void (^)(NSURLSessionDataTask *task, NSString *responseString))success
    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


/**
 POST请求

 @param URLString  请求的url
 @param parameters POST请求体参数
 @param success    请求成功调用的Block
 @param failure    请求失败调用的Block
 */
- (void)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameters
     success:(void (^)(NSURLSessionDataTask *task, NSString *responseString))success
     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;



- (void)                POST:(NSString *)URLString
                  parameters:(NSDictionary *)parameters
   constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                    progress:(void (^)(NSProgress * progress))progressBlock
                     success:(void (^)(NSURLSessionDataTask *task, NSString *responseString))success
                     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 取消当前请求队列的所有请求
 */
- (void)cancelAllOperations;

- (void)Download:(NSString *)URLString
        savePath:(NSString *)aSavePath
        progress:(void (^)(NSProgress * progress))progressBlock
         success:(void (^)(NSURLSessionDataTask *task, NSString *responseString))success
         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


@end
