//
//  AuthorizationManager.h
//  OCTools
//
//  Created by 周 on 2018/11/9.
//  Copyright © 2018年 周. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger,AuthorizationStatus){
    /**不确定*/
    AuthorizationStatusNotDetermined,//不确定，此时系统尚未向用户申请权限
    /**用户禁止该权限*/
    AuthorizationStatusDenied,
    /**用户已经授权*/
    AuthorizationStatusAuthorized
};
@interface AuthorizationManager : NSObject
+(instancetype)manager;
/**是否有相机权限*/
- (AuthorizationStatus)canUseCamera;
/**请求相机权限 仅用于被用户拒绝权限后的再次申请*/
- (void)requestAuthorizationForCamera;
/**是否有相册权限*/
- (AuthorizationStatus)canUsePhotoLibrary;
/**请求相册权限 仅用于被用户拒绝权限后的再次申请*/
- (void)requestAuthorizationForPhotoLibrary;
/**是否有麦克风权限*/
- (AuthorizationStatus)canUseMicrophone;
/**请求麦克风权限 仅用于被用户拒绝权限后的再次申请*/
- (void)requestAuthorizationForMicrophone;
/**是否有定位权限 仅用于被用户拒绝权限后的再次申请*/
- (AuthorizationStatus)canUseLocation;
/**请求定位权限*/
- (void)requestAuthorizationForLocation;

@end

NS_ASSUME_NONNULL_END
