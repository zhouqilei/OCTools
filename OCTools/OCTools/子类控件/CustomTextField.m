//
//  CustomTextField.m
//  OCTools
//
//  Created by 周 on 2018/11/14.
//  Copyright © 2018年 周. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField
- (instancetype)init {
    if ([super init]) {
        _startPoint = CGPointMake(0, 0);
    }
    return self;
}

#pragma mark - 快速实例化
- (instancetype)initWithFrame:(CGRect)frame text:(nullable NSString *)text textColor:(nullable UIColor *)textColor font:(nullable UIFont *)font placeholder:(nullable NSString *)placeholder{
    if ([super initWithFrame:frame]) {
        if (text) {
            self.text =text;
        }
        if (textColor) {
            self.textColor = textColor;
        }
        if (font) {
            self.font = font;
        }
        if (placeholder) {
            self.placeholder = placeholder;
        }
    }
    return self;
}
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, _startPoint.x, _startPoint.y);
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, _startPoint.x, _startPoint.y);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
