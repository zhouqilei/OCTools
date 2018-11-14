//
//  CustomTextView.h
//  OCTools
//
//  Created by 周 on 2018/11/14.
//  Copyright © 2018年 周. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTextView : UITextView

/**占位字符*/
@property (nonatomic, strong)NSString *placeholder;
/**占位符颜色*/
@property (nonatomic, strong)UIColor *placeholderTextColor;
/**快速初始化*/
- (instancetype)initWithFrame:(CGRect)frame text:(nullable NSString *)text textColor:(nullable UIColor *)textColor font:(nullable UIFont *)font placeholder:(nullable NSString *)placeholder;
@end

NS_ASSUME_NONNULL_END
