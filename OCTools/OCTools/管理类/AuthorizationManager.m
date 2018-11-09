//
//  AuthorizationManager.m
//  OCTools
//
//  Created by 周 on 2018/11/9.
//  Copyright © 2018年 周. All rights reserved.
//

#import "AuthorizationManager.h"

@implementation AuthorizationManager
+ (instancetype)manager {
    static AuthorizationManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AuthorizationManager alloc]init];
    });
    return manager;
}
- (AuthorizationStatus)canUseCamera {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied) {
        return AuthorizationStatusDenied;
    }
    if (status == AVAuthorizationStatusAuthorized) {
        return AuthorizationStatusAuthorized;
    }
    return AuthorizationStatusNotDetermined;
}
- (void)requestAuthorizationForCamera{
    if ([[AuthorizationManager manager] canUseCamera] == AuthorizationStatusDenied) {
       [[AuthorizationManager manager]alertWithTitle:@"无法使用相机" Message:@"请在设置中允许使用相机"];
    }
    
}

- (AuthorizationStatus)canUsePhotoLibrary {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted ) {
        return AuthorizationStatusDenied;
    }
    if (status == PHAuthorizationStatusAuthorized) {
        return AuthorizationStatusAuthorized;
    }
    return AuthorizationStatusNotDetermined;
}
- (void)requestAuthorizationForPhotoLibrary {
    if ([[AuthorizationManager manager] canUsePhotoLibrary] == AuthorizationStatusDenied) {
        [[AuthorizationManager manager]alertWithTitle:@"无法使用相册" Message:@"请在设置中允许使用相册"];
    }
}

- (AuthorizationStatus)canUseMicrophone {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied) {
        return AuthorizationStatusDenied;
    }
    if (status == AVAuthorizationStatusAuthorized) {
        return AuthorizationStatusAuthorized;
    }
    return AuthorizationStatusNotDetermined;
}
- (void)requestAuthorizationForMicrophone {
    if ([[AuthorizationManager manager] canUseMicrophone] == AuthorizationStatusDenied) {
        [[AuthorizationManager manager]alertWithTitle:@"无法使用麦克风" Message:@"请在设置中允许使用麦克风"];
    }
}

-(AuthorizationStatus)canUseLocation {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted) {
        return AuthorizationStatusDenied;
    }
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        return AuthorizationStatusAuthorized;
    }
    return AuthorizationStatusNotDetermined;
}
- (void)requestAuthorizationForLocation {
    if ([[AuthorizationManager manager] canUseLocation] == AuthorizationStatusDenied) {
        [[AuthorizationManager manager]alertWithTitle:@"无法使用定位" Message:@"请在设置中允许使用定位"];
    }
}

- (UIViewController *)viewController {
    UIViewController *vc = [[UIApplication sharedApplication].keyWindow rootViewController];
    return vc;
}
- (void)alertWithTitle:(NSString *)title Message:(NSString *)message {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    [alertC addAction:action1];
    [alertC addAction:action2];
    [[[AuthorizationManager manager] viewController] presentViewController:alertC animated:YES completion:nil];
}
@end
