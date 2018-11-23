//
//  WuLiuViewController.h
//  OCTools
//
//  Created by 周 on 2018/11/23.
//  Copyright © 2018年 周. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
/**物流信息类*/
typedef NS_ENUM(NSUInteger, WuLiuPosition){
    /**最上面的物流信息*/
    WuLiuPositionTop,
    /**中间的物流信息*/
    WuLiuPositionMid,
    /**最下面的物流信息*/
    WuLiuPositionBottom
};
@interface WuLiuInfo : NSObject
- (instancetype)initWithMessage:(NSString *)message time:(NSString *)time position:(WuLiuPosition)position;
@property (nonatomic, strong)NSString *message;
@property (nonatomic, strong)NSString *time;
@property (nonatomic, assign)WuLiuPosition position;
/**获取物流信息的高度*/
- (CGFloat)getCellMessageHeightWithMessageWidth:(CGFloat)width MessageFont:(UIFont *)font;
/**获取物流时间戳的高度*/
- (CGFloat)getCellTimeHeightWithWidth:(CGFloat)width TimeFont:(UIFont *)font;
@end
/**物流cell*/
@interface WuLiuCell : UITableViewCell
@property (nonatomic, strong) WuLiuInfo *wuliu;
@property (nonatomic, strong) UILabel *messageL;
@property (nonatomic, strong) UILabel *timeL;
/**点*/
@property (nonatomic, strong) UIView *point;
/**线*/
@property (nonatomic, strong) UIView *line;
@end
/**物流控制器*/
@interface WuLiuViewController : BaseViewController

@end

NS_ASSUME_NONNULL_END
