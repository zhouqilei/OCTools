//
//  StarRateView.m
//  OCTools
//
//  Created by 周 on 2018/11/5.
//  Copyright © 2018年 周. All rights reserved.
//

#import "StarRateView.h"
@interface StarRateView ()
@property (nonatomic, assign)NSInteger numberOfStars;
@property (nonatomic, strong)UIView *foregroundStarView;
@property (nonatomic, strong)UIView *backgroundStarView;
@end
@implementation StarRateView
- (instancetype)initWithFrame:(CGRect)frame AndStarCount:(NSInteger)starCount {
    if (self = [super initWithFrame:frame]) {
        self.numberOfStars = starCount;
        self.currentRate = 0;
        self.userInteractionEnabled = YES;
        [self setUpStarView];
    }
    return self;
}
#pragma mark - 设置界面
- (void)setUpStarView {
    self.foregroundStarView = [self createStarViewWithImage:SELECTED_STAR_IMAGE];
    
    self.backgroundStarView = [self createStarViewWithImage:STAR_IMAGE];
    
    self.foregroundStarView.frame = CGRectMake(0, 0, self.currentRate * (self.bounds.size.width / self.numberOfStars), self.bounds.size.height);
    
    [self addSubview:self.backgroundStarView];
    
    [self addSubview:self.foregroundStarView];
    
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRateView:)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
    
}
#pragma mark 创建星星视图
- (UIView *)createStarViewWithImage:(NSString *)imageName{
    UIView *view = [[UIView alloc]initWithFrame:self.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    
    for (int i = 0; i < self.numberOfStars; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * self.bounds.size.width / self.numberOfStars, 0, self.bounds.size.width / self.numberOfStars, self.bounds.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
}
#pragma mark - 点击了星星
-(void)tapRateView:(UITapGestureRecognizer *)tap {
    CGPoint tapPoint = [tap locationInView:self];
    
    CGFloat offsset = tapPoint.x;
    
    CGFloat rate = offsset / (self.bounds.size.width / self.numberOfStars);
    
    switch (self.rateStyle) {
        case WholeStar:
        {
            self.currentRate = ceilf(rate);
        }
            break;
        case IncompleteStar:
        {
            self.currentRate = rate;
        }
        default:
            break;
    }
}
#pragma mark -点击星星后重绘界面
- (void)layoutSubviews {
    [super layoutSubviews];
    [UIView animateWithDuration:0.2 animations:^{
        self.foregroundStarView.frame = CGRectMake(0, 0, self.currentRate * (self.bounds.size.width / self.numberOfStars), self.bounds.size.height);
    }];
}
#pragma mark -设置当前评分
- (void)setCurrentRate:(CGFloat)currentRate {
    if (_currentRate == currentRate) {
        return;
    }
    if (currentRate > self.numberOfStars) {
        NSLog(@"评分不能超过星星数量")
    }
    if (currentRate < 0) {
        NSLog(@"评分不能为负数");
    }
    if (self.rateStyle == WholeStar) {
        currentRate = ceilf(currentRate);
    }
    _currentRate = currentRate;
    [self setNeedsLayout];
    if ([self.delegate respondsToSelector:@selector(starRateView:didFinishRate:)]) {
        [self.delegate starRateView:self didFinishRate:self.currentRate];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
