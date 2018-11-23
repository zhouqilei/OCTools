//
//  SuspensionView.m
//  OCTools
//
//  Created by 周 on 2018/11/23.
//  Copyright © 2018年 周. All rights reserved.
//

#import "SuspensionView.h"

@implementation SuspensionView
- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.frame = CGRectMake(UI_SCREEN_WIDTH - 80, UI_SCREEN_HEIGHT - HOME_INDICATOR_HEIGHT - HeightForNagivationBarAndStatusBar - 90, 60, 60);
        self.alpha = 0.7;
        self.layer.cornerRadius = self.frame.size.width / 2;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        
        
        self.suspensionBtn = [[UIButton alloc]init];
        self.suspensionBtn.alpha = 0.7;
        self.suspensionBtn.frame = self.bounds;
        self.suspensionBtn.layer.cornerRadius = self.frame.size.width / 2;
        [self addSubview:self.suspensionBtn];
        
    }
    return self;
}
- (void)show {
    self.hidden = NO;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
- (void)hide {
    self.hidden = YES;
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
