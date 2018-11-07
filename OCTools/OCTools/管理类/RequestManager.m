//
//  RequestManager.m
//  OCTools
//
//  Created by 周 on 2018/11/7.
//  Copyright © 2018年 周. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager
+ (instancetype)shareManager {
    static RequestManager *rm = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rm = [[RequestManager alloc]init];
    });
    return rm;
}
#pragma mark - 设置请求的配置
- (void)setRequestWithManager:(AFHTTPSessionManager *)manager {
    //30s超时
    manager.requestSerializer.timeoutInterval = 30;
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", nil];
    //设置请求头
    [manager.requestSerializer setValue:@"utf-8" forHTTPHeaderField:@"Content-Type"];
}
#pragma mark - get请求
- (void)getRequest:(NSString *)url parameters:(id)parameters success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [self setRequestWithManager:manager];
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}
#pragma mark - post请求
- (void)postRequest:(NSString *)url parameters:(id)parameters success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [self setRequestWithManager:manager];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}
#pragma mark - 图片上传
- (void)uploadImages:(NSString *)url images:(NSArray *)images parameters:(id)parameters progress:(void (^)(NSProgress * _Nonnull))progress success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [self setRequestWithManager:manager];
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (UIImage *image in images) {
            //压缩图片
            NSData *data = UIImageJPEGRepresentation(image, 0.4);
            //多张图片是需要在name中加“[]”，单张上传时不用
            [formData appendPartWithFileData:data name:@"file[]" fileName:[NSString stringWithFormat:@"%@.jpg",[NSDate date]] mimeType:@"image/jpeg"];
            
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}
@end
