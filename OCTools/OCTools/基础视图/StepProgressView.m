//
//  StepProgressView.m
//  OCTools
//
//  Created by 周 on 2018/11/22.
//  Copyright © 2018年 周. All rights reserved.
//

#import "StepProgressView.h"
//完成的颜色
#define CompletedColor [UIColor blueColor].CGColor
//未完成的颜色
#define UnCompletedColor [UIColor grayColor].CGColor
@interface StepProgressView ()
@property (nonatomic, strong)CAShapeLayer *layer1;
@property (nonatomic, strong)CAShapeLayer *layer2;
@property (nonatomic, assign)NSUInteger targetNum;
@property (nonatomic, assign)NSUInteger progress;
@end
@implementation StepProgressView
- (instancetype)initWithFrame:(CGRect)frame targetNum:(NSUInteger)targetNum {
    if ([super initWithFrame:frame]) {
        _targetNum = targetNum;
        self.backgroundColor = [UIColor clearColor];
        [self setProgress:0];
    }
    return self;
}
- (void)setProgress:(NSUInteger)progress {
    _progress = progress;
    [self drawUnCompletedProgress];
    [self drawCompletedProgress];
}
/**绘制已经完成的进度*/
- (void)drawCompletedProgress {
    NSUInteger targetNum = self.targetNum;
    NSUInteger progressNum = self.progress;
    //绘制线的宽度
    CGFloat lineWidth = 4.0f;
    //圆的半径
    CGFloat circleRadius = (self.bounds.size.height - lineWidth * 2) / 2;
    //节点间距
    CGFloat distanceBetweenTwoPoint = (self.bounds.size.width - circleRadius * 2 * targetNum) / (targetNum - 1);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (NSUInteger i = 0; i < progressNum; i++) {
        //画圈
        [path addArcWithCenter:CGPointMake(circleRadius + (distanceBetweenTwoPoint + circleRadius *2) * i, circleRadius) radius:circleRadius startAngle:M_PI endAngle:4 * M_PI clockwise:YES];
        //画直线
        [path addLineToPoint:CGPointMake(circleRadius *2 + (distanceBetweenTwoPoint + circleRadius *2) * i, circleRadius)];
        
        self.layer1 = [CAShapeLayer layer];
        self.layer1.path = path.CGPath;
        self.layer1.lineWidth = lineWidth;
        self.layer1.frame = self.bounds;
        self.layer1.fillColor = [UIColor clearColor].CGColor;
        self.layer1.strokeColor = CompletedColor;
        [self.layer addSublayer:self.layer1];
        [self drawWithLayer1:self.layer1];
    }
}
/**绘制底部进度*/
- (void)drawUnCompletedProgress {
    NSUInteger targetNum = self.targetNum;
    //绘制线的宽度
    CGFloat lineWidth = 4.0f;
    //圆的半径
    CGFloat circleRadius = (self.bounds.size.height - lineWidth * 2) / 2;
    //节点间距
    CGFloat distanceBetweenTwoPoint = (self.bounds.size.width - circleRadius * 2 * targetNum) / (targetNum - 1);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (NSUInteger i = 0; i < targetNum; i++) {
        //画圈
        [path addArcWithCenter:CGPointMake(circleRadius + (distanceBetweenTwoPoint + circleRadius *2) * i, circleRadius) radius:circleRadius startAngle:M_PI endAngle:4 * M_PI clockwise:YES];
        //画直线
        [path addLineToPoint:CGPointMake(circleRadius *2 + (distanceBetweenTwoPoint + circleRadius *2) * i, circleRadius)];
        
        self.layer2 = [CAShapeLayer layer];
        self.layer2.path = path.CGPath;
        self.layer2.lineWidth = lineWidth;
        self.layer2.frame = self.bounds;
        self.layer2.fillColor = [UIColor clearColor].CGColor;
        self.layer2.strokeColor = UnCompletedColor;
        [self.layer addSublayer:self.layer2];
        [self drawWithLayer2:self.layer2];
    }
}
//绘制已完成
- (void)drawWithLayer1:(CAShapeLayer *)layer1 {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    ani.duration = self.progress;
    ani.fromValue = @0;
    ani.toValue = @1;
    [layer1 addAnimation:ani forKey:@""];
}
//绘制未完成
- (void)drawWithLayer2:(CAShapeLayer *)layer2 {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    ani.duration = 0;
    [layer2 addAnimation:ani forKey:@""];
}

@end
