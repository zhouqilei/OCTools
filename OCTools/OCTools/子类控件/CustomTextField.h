//
//  CustomTextField.h
//  OCTools
//
//  Created by 周 on 2018/11/14.
//  Copyright © 2018年 周. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTextField : UITextField
/**文字起始位置*/
@property (nonatomic, assign)CGPoint startPoint;
/**快速实例化*/
- (instancetype)initWithFrame:(CGRect)frame text:(nullable NSString *)text textColor:(nullable UIColor *)textColor font:(nullable UIFont *)font placeholder:(nullable NSString *)placeholder;
@end

NS_ASSUME_NONNULL_END
