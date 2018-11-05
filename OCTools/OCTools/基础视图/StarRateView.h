//
//  StarRateView.h
//  OCTools
//
//  Created by 周 on 2018/11/5.
//  Copyright © 2018年 周. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define STAR_IMAGE @"icon_wjx2"//暗色星星图片
#define SELECTED_STAR_IMAGE @"icon_wjx1"//亮色星星图片
typedef NS_ENUM(NSInteger,RateStyle){
    WholeStar,//整星
    IncompleteStar//不整星
};
@class StarRateView;
@protocol StarRateViewDelegate <NSObject>
@optional
- (void)starRateView:(StarRateView *)view didFinishRate:(CGFloat )rate;
@end
@interface StarRateView : UIView
@property (nonatomic, weak)id<StarRateViewDelegate>delegate;
/**选择评分的模式*/
@property (nonatomic, assign)RateStyle rateStyle;
/**当前选中的评分*/
@property (nonatomic, assign)CGFloat currentRate;
/**初始化方法*/
- (instancetype)initWithFrame:(CGRect)frame AndStarCount:(NSInteger )starCount;

@end

NS_ASSUME_NONNULL_END
