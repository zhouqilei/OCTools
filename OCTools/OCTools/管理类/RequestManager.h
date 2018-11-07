//
//  RequestManager.h
//  OCTools
//
//  Created by 周 on 2018/11/7.
//  Copyright © 2018年 周. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RequestManager : NSObject
+ (instancetype)shareManager;
/**get请求*/
- (void)getRequest:(NSString *)url
        parameters:(id)parameters
           success:(void(^)(id responseObject))success
           failure:(void(^)(NSError *error))failure;
/**post请求*/
- (void)postRequest:(NSString *)url
         parameters:(id)parameters
            success:(void(^)(id responseObject))success
            failure:(void(^)(NSError *error))failure;
/**图片上传*/
- (void)uploadImages:(NSString *)url
              images:(NSArray *)images
          parameters:(id)parameters
            progress:(void(^)(NSProgress *progress))progress
             success:(void(^)(id responseObject))success
             failure:(void(^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
