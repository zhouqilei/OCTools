//
//  StepProgressView.h
//  OCTools
//
//  Created by 周 on 2018/11/22.
//  Copyright © 2018年 周. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StepProgressView : UIView
/**
 @parama targetNum 节点个数
 */
- (instancetype)initWithFrame:(CGRect)frame targetNum:(NSUInteger)targetNum;

/**
 @parama progress 当前处于第几个节点
 */
- (void)setProgress:(NSUInteger)progress;
@end

NS_ASSUME_NONNULL_END
