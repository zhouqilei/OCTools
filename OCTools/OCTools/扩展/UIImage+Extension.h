//
//  UIImage+Extension.h
//  OCTools
//
//  Created by 周 on 2018/10/31.
//  Copyright © 2018年 周. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)
/**根据颜色和尺寸生成图片*/
+(UIImage *)imageWithColor:(UIColor *)color rect:(CGRect)rect;
/**根据尺寸拉伸图片*/
+(UIImage *)originImage:(UIImage *)image scaleToSize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
