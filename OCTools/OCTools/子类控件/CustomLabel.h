//
//  CustomLabel.h
//  OCTools
//
//  Created by 周 on 2018/11/14.
//  Copyright © 2018年 周. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomLabel : UILabel
/**字体与控件边距的间隙*/
@property (nonatomic, assign)UIEdgeInsets textInsets;
/**快速实例化*/
- (instancetype)initWithFrame:(CGRect)frame text:(nullable NSString *)text textColor:(nullable UIColor *)textColor font:(nullable UIFont *)font;
@end

NS_ASSUME_NONNULL_END
