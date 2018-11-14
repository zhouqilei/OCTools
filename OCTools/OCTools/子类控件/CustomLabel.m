//
//  CustomLabel.m
//  OCTools
//
//  Created by 周 on 2018/11/14.
//  Copyright © 2018年 周. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel
- (instancetype)init {
    if ([super init]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

#pragma mark - 快速实例化
-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font{
    if ([super initWithFrame:frame]) {
        if (text) {
            self.text = text;
        }
        if (textColor) {
            self.textColor = textColor;
        }
        if (font) {
            self.font = font;
        }
    }
    return self;
}
- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
