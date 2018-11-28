//
//  ProAttrSelectView.h
//  OCTools
//
//  Created by 周 on 2018/11/27.
//  Copyright © 2018年 周. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ProAttrSelectView;
@protocol ProAttrSelectViewDelegate <NSObject>
@optional
- (void)proAttrSelectView:(ProAttrSelectView *)view didClickSureWithAttrs:(NSMutableArray *)attrs count:(NSInteger)count;
@end
@interface ProAttrSelectView : UIView
- (instancetype)initWithData:(NSArray *)data;
/**当前选择的属性集合*/
@property (nonatomic, strong)NSMutableArray *selectedAttrs;
/**当前选择的商品数量*/
@property (nonatomic, assign)NSInteger *selectedCount;
@property (nonatomic, weak)id<ProAttrSelectViewDelegate>delegate;
- (void)show;
- (void)dismiss;
@end
//属性单元视图
@class AttrSectionView;
@protocol AttrSectionViewDelegate <NSObject>
@optional
- (void)attrSectionView:(AttrSectionView *)view didSelectedAttr:(NSString *)attr atSection:(NSInteger )section;
@end
@interface AttrSectionView : UIView
/**初始化 传入当前属性数据以及分区的号*/
- (instancetype)initWithFrame:(CGRect)frame andData:(NSDictionary *)data andSection:(NSInteger )section;
/**设置属性中的某一个属性按钮是否可用*/
- (void)setAttrEnable:(BOOL)enable withTitle:(NSString *)title;
@property (nonatomic, weak)id<AttrSectionViewDelegate>delegate;
@end
//属性按钮
@interface AttrBtn : UIButton
+ (AttrBtn *)attrBtnWithTitle:(NSString *)title;
@end
//计数视图
@interface CountView : UIView
/**当前的数量 默认为1*/
@property (nonatomic, assign)NSUInteger count;
@end
NS_ASSUME_NONNULL_END
