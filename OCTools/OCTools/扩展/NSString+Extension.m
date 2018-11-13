//
//  NSString+Extension.m
//  OCTools
//
//  Created by 周 on 2018/11/12.
//  Copyright © 2018年 周. All rights reserved.
//

#import "NSString+Extension.h"
#import "CommonCrypto/CommonDigest.h"
@implementation NSString (Extension)
- (CGFloat)getWidthWithHeight:(CGFloat)height font:(UIFont *)font {
    CGRect rect = [self getRectWithSize:CGSizeMake(MAXFLOAT, height) font:font];
    return ceilf(rect.size.width);
}
- (CGFloat)getHeightWithWidth:(CGFloat)width font:(UIFont *)font{
    CGRect rect = [self getRectWithSize:CGSizeMake(width, MAXFLOAT) font:font];
    return ceilf(rect.size.height);
}
- (CGRect)getRectWithSize:(CGSize)size font:(UIFont *)font
{
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect;
}
+ (NSString *)getMd5WithString:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}
- (BOOL)isValid {
    if (self != nil && ![self isKindOfClass:[NSNull class]]) {
        return ([[self stringByTrimmingCharactersInSet:
                  [NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""] || self == nil || [self isEqualToString:@"(null)"] || [self isEqualToString:@"<null>"]) ? NO :YES;
    }
    return NO;
}
+ (NSArray *)getImagesFromHtml:(NSString *)html {
    NSMutableArray *resultArray = [NSMutableArray array];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<(img|IMG)(.*?)(/>|></img>|>)" options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
    NSArray *result = [regex matchesInString:html options:NSMatchingReportCompletion range:NSMakeRange(0, html.length)];
    
    for (NSTextCheckingResult *item in result) {
        NSString *imgHtml = [html substringWithRange:[item rangeAtIndex:0]];
        
        NSArray *tmpArray = nil;
        if ([imgHtml rangeOfString:@"src=\""].location != NSNotFound) {
            tmpArray = [imgHtml componentsSeparatedByString:@"src=\""];
        } else if ([imgHtml rangeOfString:@"src="].location != NSNotFound) {
            tmpArray = [imgHtml componentsSeparatedByString:@"src="];
        }
        if (tmpArray.count >= 2) {
            NSString *src = tmpArray[1];
            NSUInteger loc = [src rangeOfString:@"\""].location;
            if (loc != NSNotFound) {
                src = [src substringToIndex:loc];
                [resultArray addObject:src];
            }
        }
    }
    return resultArray;
}
@end
