//
//  CalendarViewController.h
//  OCTools
//
//  Created by 周 on 2018/11/15.
//  Copyright © 2018年 周. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CalendarViewController : BaseViewController

@end
//日历头部
@interface CalendarHeaderView : UICollectionReusableView
@property (nonatomic, strong)UILabel *textL;
@end
//日历itemCell
@interface CalendarViewCell : UICollectionViewCell

/**存放day的label*/
@property (nonatomic,strong)UILabel *dayL;
@end
//日期布局
@interface CalendarCollectionViewFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, strong)NSMutableDictionary *sectionDic;
@property (nonatomic, strong)NSMutableArray *allAttributes;
@end

//日期对象
@interface Calendar : NSObject
/**date*/
@property (nonatomic, strong)NSDate *date;
/**月份*/
@property (nonatomic, assign)NSInteger month;
/**年份*/
@property (nonatomic, assign)NSInteger year;
/**这个月几天*/
@property (nonatomic, assign)NSInteger days;
/**这个月第一天周几*/
@property (nonatomic, assign)NSInteger firstDayWeek;
- (instancetype)initWithDate:(NSDate *)date;
@end
NS_ASSUME_NONNULL_END
