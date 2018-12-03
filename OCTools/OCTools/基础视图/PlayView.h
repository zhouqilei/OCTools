//
//  PlayView.h
//  OCTools
//
//  Created by 周 on 2018/11/29.
//  Copyright © 2018年 周. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayView : UIView
/**同步屏幕刷新计时器*/
@property (nonatomic, strong)CADisplayLink *link;
/**播放器*/
@property (nonatomic, strong)AVPlayer *player;
/**播放的URL*/
- (void)playWith:(NSURL *)url;
@end

NS_ASSUME_NONNULL_END
