//
//  WaterFallCollectionViewFlowLayout.h
//  OCTools
//
//  Created by 周 on 2018/12/5.
//  Copyright © 2018年 周. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class WaterFallCollectionViewFlowLayout;
@protocol WaterFallCollectionViewDataSource <NSObject>
@required
//cell的高度
- (CGFloat)WaterFallLayout:(WaterFallCollectionViewFlowLayout *)layout itemWidth:(CGFloat)itemWidth indexPath:(NSIndexPath *)indexPath;
@end
@interface WaterFallCollectionViewFlowLayout : UICollectionViewFlowLayout
/**列数 默认两列*/
@property (nonatomic,assign)NSInteger columnNumber;
/**列间距 默认10*/
@property (nonatomic, assign)CGFloat columnDis;
/**行间距 默认10*/
@property (nonatomic, assign)CGFloat rowDis;
/**默认边缘距离 默认都是0*/
@property (nonatomic, assign)UIEdgeInsets edgeInsets;
/**代理*/
@property (nonatomic, weak)id<WaterFallCollectionViewDataSource>datasource;
@end

NS_ASSUME_NONNULL_END
