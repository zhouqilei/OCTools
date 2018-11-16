//
//  AdViewController.h
//  OCTools
//
//  Created by 周 on 2018/11/16.
//  Copyright © 2018年 周. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImageDownloader.h>
#import <UIImage+GIF.h>
#import <UIImageView+WebCache.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^skipDidClick)(void);
typedef void(^adDidClick)(void);
@interface AdViewController : UIViewController
@property (nonatomic, strong)NSString *url;

/**跳过按钮回调*/
@property (nonatomic, copy)skipDidClick skipDidClickBlock;
/**点击页面回调*/
@property (nonatomic, copy)adDidClick adDidClickBlock;
@end

NS_ASSUME_NONNULL_END
