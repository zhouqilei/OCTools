//
//  NSString+Extension.h
//  OCTools
//
//  Created by 周 on 2018/11/12.
//  Copyright © 2018年 周. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)
/**根据固定的高度和字体大小获取字符串宽度*/
- (CGFloat)getWidthWithHeight:(CGFloat)height font:(UIFont *)font;
/**根据固定的宽度和字体大小获取字符串高度*/
- (CGFloat)getHeightWithWidth:(CGFloat)width font:(UIFont *)font;
/**获取字符串md5*/
+(NSString *)getMd5WithString:(NSString *)str;
/**判断字符串是否可用 不为空 不为null*/
- (BOOL)isValid;
/**h5字符串中获取img标签*/
+ (NSArray *)getImagesFromHtml:(NSString *)html;
/**判断是否是电话号码*/
- (BOOL)isPhoneNumber;
/**判断是否是手机号码*/
- (BOOL)isMobileNumber;
/**获取字符串中的所有电话号码*/
- (NSArray *)getPhoneNumbers;
/**获取字符串中的所有手机号码*/
- (NSArray *)getMobileNumbers;
/**身份证是否合法*/
- (BOOL)isValidID;
/**车牌号是否合法*/
- (BOOL)isValidCarID;
/**银行卡号是否合法*/
- (BOOL)isValidBankID;
/**邮箱是否合法*/
- (BOOL)isValidEmail;
@end

NS_ASSUME_NONNULL_END
