//
//  UIView+Extension.m
//  OCTools
//
//  Created by 周 on 2018/11/12.
//  Copyright © 2018年 周. All rights reserved.
//

#import "UIView+Extension.h"
@interface UIView ()<CAAnimationDelegate>
@property (nonatomic, copy)void(^animStop)(void);
@end

@implementation UIView (Extension)
@dynamic viewController;
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    self.userInteractionEnabled = YES;
    UIControl *touchControl = [[UIControl alloc] initWithFrame:self.bounds];
    touchControl.backgroundColor = [UIColor clearColor];
    touchControl.tag=self.tag;
    [self addSubview:touchControl];
    
    [touchControl addTarget:target action:action forControlEvents:controlEvents];
}
- (void)animationStartPoint:(CGPoint)start endPoint:(CGPoint)end didStopAnimation:(void (^)(void))event{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:start];
    //设置控制点
    CGPoint point1 = CGPointZero;
    CGPoint point2 = CGPointZero;
    if (start.x > end.x) {
        point1 = CGPointMake((start.x - end.x) / 4 * 3 + end.x, start.y - 40);
        point2 = CGPointMake((start.x - end.x) / 4 + end.x, (end.y - start.y) / 2 + start.y);
    }else {
        point1 = CGPointMake((end.x - start.x) / 4 + start.x , start.y - 40);
        point2 = CGPointMake((end.x - start.x) / 4 * 3 + start.x, (end.y - start.y) / 2 + start.y);
    }
    [path addCurveToPoint:end controlPoint1:point1 controlPoint2:point2];
    //路径
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    //缩放
    CABasicAnimation *baAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //控制缩放的倍数，根据项目自定
    baAnimation.fromValue = @1;
    baAnimation.toValue = @1;
    baAnimation.autoreverses = YES;
    //动画组合
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,baAnimation];
    groups.duration = 0.5;
    groups.removedOnCompletion = NO;
    groups.fillMode = kCAFillModeForwards;
    groups.delegate = self;
    [groups setValue:@"groupsAnimation" forKey:@"animationName"];
    [self.layer addAnimation:groups forKey:nil];
    self.animStop = event;
}
#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.animStop();
}
- (void)setAnimStop:(void (^)(void))animStop {
    objc_setAssociatedObject(self, @"animStop", animStop, OBJC_ASSOCIATION_COPY);
}
- (void (^)(void))animStop {
    return objc_getAssociatedObject(self, @"animStop");
}
@end
