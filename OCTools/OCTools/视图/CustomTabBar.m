//
//  CustomTabBar.m
//  OCTools
//
//  Created by 周 on 2018/10/30.
//  Copyright © 2018年 周. All rights reserved.
//

#import "CustomTabBar.h"
@interface CustomTabBar ()
@property (nonatomic, strong)UIButton *roundButton;
@end
@implementation CustomTabBar
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.roundButton.backgroundColor = [UIColor redColor];
        self.roundButton.layer.cornerRadius = 30;
        [self.roundButton addTarget:self action:@selector(roundButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.roundButton];
    };
    return self;
}
- (UIButton *)roundButton{
    if (!_roundButton) {
        _roundButton = [[UIButton alloc]init];
    }
    return _roundButton;
}
//点击了圆形按钮
- (void)roundButtonClicked {
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat centerx = self.bounds.size.width * 0.5;
    CGFloat centery = self.bounds.size.height * 0.5;
    //根据情况设置中间按钮相对于tabBar的位置
    self.roundButton.frame = CGRectMake(centerx - 30, centery - 55, 60, 60);
    
    Class class = NSClassFromString(@"UITabBarButton");
    int index = 0;
    //获取每个UITabBarButton 的宽度
    int tabWidth = self.bounds.size.width / 3;
    for (UIView *view in self.subviews) {
        //找到UITabBarButton类型子控件
        if ([view isKindOfClass:class]) {
            CGRect rect = view.frame;
            rect.origin.x = index * tabWidth;
            rect.size.width = tabWidth;
            view.frame = rect;
            index++;
            //留出位置放置中间凸出按钮
            if (index == 1) {
                index++;
            }
        }
    }
}

//响应触摸事件，如果触摸位置位于圆形按钮控件上，则由圆形按钮处理触摸消息
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    //判断tabbar是否隐藏
    if (self.hidden == NO) {
        if ([self touchPointInsideCircle:self.roundButton.center radius:30 targetPoint:point]) {
            //如果位于圆形按钮上，则由圆形按钮处理触摸消息
            return self.roundButton;
        }
        else{
            //否则系统默认处理
            return [super hitTest:point withEvent:event];
        }
    }
    return [super hitTest:point withEvent:event];
}

- (BOOL)touchPointInsideCircle:(CGPoint)center radius:(CGFloat)radius targetPoint:(CGPoint)point
{
    CGFloat dist = sqrtf((point.x - center.x) * (point.x - center.x) +
                         (point.y - center.y) * (point.y - center.y));
    return (dist <= radius);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
