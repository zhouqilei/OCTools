//
//  CalendarViewController.m
//  OCTools
//
//  Created by 周 on 2018/11/15.
//  Copyright © 2018年 周. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionV;
/**当前正在显示的日期*/
@property (nonatomic, strong)Calendar *currentCalendar;
/**存放日期对象的数组*/
@property (nonatomic, strong)NSMutableArray *data;
/**当前年月*/
@property (nonatomic, strong)UILabel *dateL;
@end

@implementation CalendarViewController
- (UILabel *)dateL {
    if (!_dateL) {
        _dateL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 40)];
        _dateL.textAlignment = NSTextAlignmentCenter;
        _dateL.textColor = [UIColor blackColor];
    }
    return _dateL;
}
- (UICollectionView *)collectionV {
    if (!_collectionV) {
        CalendarCollectionViewFlowLayout *layout = [[CalendarCollectionViewFlowLayout alloc]init];
        //每行排列7天
        CGFloat itemWidth = UI_SCREEN_WIDTH  / 7;
        layout.itemSize = CGSizeMake(itemWidth, itemWidth);
        
        layout.headerReferenceSize = CGSizeMake(40, UI_SCREEN_WIDTH);
        
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        
        _collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 80, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar - HOME_INDICATOR_HEIGHT - 80) collectionViewLayout:layout];
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        _collectionV.backgroundColor = [UIColor whiteColor];
        _collectionV.pagingEnabled = YES;
        _collectionV.showsHorizontalScrollIndicator = NO;
        //注册cell
        [_collectionV registerClass:[CalendarViewCell class] forCellWithReuseIdentifier:@"cell"];
      
        
    }
    return _collectionV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置当前的日期为系统时间
    self.currentCalendar = [[Calendar alloc]initWithDate:[NSDate date]];
    Calendar *prev = [[Calendar alloc]initWithDate:[self getPreMonthFirstDayFromDate:self.currentCalendar.date]];
    Calendar *next = [[Calendar alloc]initWithDate:[self getNextMonthFristDayDateFromDate:self.currentCalendar.date]];
    self.data = [NSMutableArray arrayWithObjects:prev,self.currentCalendar,next, nil];
    //添加星期条
    UIView *weekView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 40)];
    weekView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:weekView];
    //添加日期条
    UIView *dateView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, UI_SCREEN_WIDTH, 40)];
    dateView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dateView];
    [dateView addSubview:self.dateL];
    self.dateL.text = [NSString stringWithFormat:@"%ld年%ld月",(long)self.currentCalendar.year,(long)self.currentCalendar.month];
    
    NSArray *weeks = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    CGFloat weekWidth = UI_SCREEN_WIDTH / 7;
    for (int i = 0; i < 7; i++) {
        UILabel *weekL = [[UILabel alloc]initWithFrame:CGRectMake(i * weekWidth, 0, weekWidth, 40)];
        weekL.textColor = [UIColor blackColor];
        weekL.text = weeks[i];
        weekL.textAlignment = NSTextAlignmentCenter;
        [weekView addSubview:weekL];
    }
    [self.view addSubview:self.collectionV];
   //滚动到中间
    
    [self.collectionV setContentOffset:CGPointMake(UI_SCREEN_WIDTH, 0) animated:YES];

}
#pragma mark - 日历计算方法
/**获取当前date下的月份天数*/
- (NSInteger)getMonthDaysFromDate:(NSDate *)date {
    NSCalendar *cal = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSRange range = [cal rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}
/**获取指定date后一个月的1号date*/
- (NSDate *)getNextMonthFristDayDateFromDate:(NSDate *)date{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *cos = [cal components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    cos.day = 1;
    cos.month ++;
    if (cos.month > 12) {
        cos.month = 1;
        cos.year ++;
    }
    return [cal dateFromComponents:cos];
}
/**获取指定date前一个月1号date*/
- (NSDate *)getPreMonthFirstDayFromDate:(NSDate *)date {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *cos = [cal components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    cos.day = 1;
    cos.month--;
    if (cos.month < 1) {
        cos.month = 12;
        cos.year --;
    }
    return [cal dateFromComponents:cos];
}

#pragma mark - UIScrollview
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //当前展示的页码
    NSInteger currentPage = scrollView.contentOffset.x / UI_SCREEN_WIDTH;
    if (currentPage == 1) {
        self.dateL.text = [NSString stringWithFormat:@"%ld年%ld月",(long)self.currentCalendar.year,(long)self.currentCalendar.month];
        return;
    }else{
        //位于第一个日历或第三个日历
        if (currentPage == 0) {
            self.currentCalendar = self.data[0];
            [self.data removeObjectAtIndex:2];
            Calendar *calendar = [[Calendar alloc]initWithDate:[self getPreMonthFirstDayFromDate:self.currentCalendar.date]];
            [self.data insertObject:calendar atIndex:0];
            [self.collectionV reloadData];
            [self.collectionV setContentOffset:CGPointMake(UI_SCREEN_WIDTH, 0) animated:NO];
             self.dateL.text = [NSString stringWithFormat:@"%ld年%ld月",(long)self.currentCalendar.year,(long)self.currentCalendar.month];
        }else {
            self.currentCalendar = self.data[2];
            [self.data removeObjectAtIndex:1];
            Calendar *calendar = [[Calendar alloc]initWithDate:[self getNextMonthFristDayDateFromDate:self.currentCalendar.date]];
            [self.data insertObject:calendar atIndex:2];
            [self.collectionV reloadData];
            [self.collectionV setContentOffset:CGPointMake(UI_SCREEN_WIDTH, 0) animated:NO];
             self.dateL.text = [NSString stringWithFormat:@"%ld年%ld月",(long)self.currentCalendar.year,(long)self.currentCalendar.month];
        }
    }
}

#pragma mark - UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.data.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //cell的数量是 当前日期的月的总天数 + 当前日期1号是星期几
    Calendar *cal = self.data[section];
    return cal.days + cal.firstDayWeek;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Calendar *cal = self.data[indexPath.section];
    CalendarViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row >= cal.firstDayWeek) {
        cell.dayL.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1 - cal.firstDayWeek];
    }else {
        cell.dayL.text = @"";
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Calendar *cal = self.data[indexPath.section];
    if (indexPath.row < cal.firstDayWeek) {
        //点击了空白
        return;
    }
    NSInteger day = indexPath.row + 1 - cal.firstDayWeek;
    NSInteger year = cal.year;
    NSInteger month = cal.month;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSLog(@"%@",indexPath);
    NSLog(@"%ld,%ld,%ld,%@",year,month,day,[dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld",year,month,day]]);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
//日历头部实现
@implementation CalendarHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.textL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 40)];
        self.textL.textColor = [UIColor blackColor];
        self.textL.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.textL];
    }
    return self;
}

@end
//日历cell的实现
@implementation CalendarViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.dayL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH/7, UI_SCREEN_WIDTH/7)];
        self.dayL.textAlignment = NSTextAlignmentCenter;
        self.dayL.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.dayL];
    }
    return self;
}

@end
//日期布局实现
@implementation CalendarCollectionViewFlowLayout
- (instancetype)init{
    if ([super init]) {
        self.headerReferenceSize = CGSizeMake(UI_SCREEN_WIDTH, 40);
    }
    return self;
}
- (void)prepareLayout {
    [super prepareLayout];
    self.sectionDic = [NSMutableDictionary dictionary];
    self.allAttributes = [NSMutableArray array];
    //获取section的数量
    NSUInteger section = [self.collectionView numberOfSections];
    for (int sec = 0; sec < section; sec++) {
        //获取每个section的cell个数
        NSUInteger count = [self.collectionView numberOfItemsInSection:sec];
        for (NSInteger item = 0; item < count; item ++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:sec];
            //重写排列
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.allAttributes addObject:attributes];
            
        }
    }
}
- (CGSize)collectionViewContentSize {
    NSInteger actualLo = 0;
    for (NSString *key in self.sectionDic.allKeys) {
        actualLo += [self.sectionDic[key] integerValue];
    }
    return CGSizeMake(actualLo*self.collectionView.frame.size.width, self.collectionView.contentSize.height);
}
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)attributes {
    if (attributes.representedElementKind != nil) {
        return;
    }
    //attributes 的宽度
    CGFloat itemW = attributes.frame.size.width;
    //attributes 的高度
    CGFloat itemH = attributes.frame.size.height;
    
    //collectionView的宽度
    CGFloat width = self.collectionView.frame.size.width;
    //collectionView的高度
    CGFloat height = self.collectionView.frame.size.height;
    //每个attributes的下标值 从0开始
    NSInteger itemIndex = attributes.indexPath.item;
    
    CGFloat stride = (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) ? width : height;
    //获取现在的attribute是第几组
    NSInteger section = attributes.indexPath.section;
    //获取现在section的item的个数
    NSInteger itemCount =[self.collectionView numberOfItemsInSection:section];
    
    CGFloat offset = section * stride;
    //计算x方向item个数
    NSInteger xCount = (width / itemW);
    //计算y方向item个数
    NSInteger yCount = (height / itemH);
    //计算一页总个数
    NSInteger allCount = xCount * yCount;
    //获取每个section的页数 从0开始
    NSInteger page = itemIndex / allCount;
    // 余数，用来计算item的x的偏移量
    NSInteger remain = itemIndex % xCount;
    //取商 用来计算item的Y的偏移量
    NSInteger merchant = (itemIndex-page*allCount)/xCount;
    //x方向每个item的偏移量
    CGFloat xCellOffset = remain * itemW;
    //y方向每个item的偏移量
    CGFloat yCellOffset = merchant * itemH;
    //获取每个section中item占了几页
    NSInteger pageRe = (itemCount % allCount == 0)?(itemCount / allCount) : (itemCount / allCount) + 1;
    //将每一个section与pageRe对应，计算位置
    [self.sectionDic setValue:@(pageRe) forKey:[NSString stringWithFormat:@"%ld",(long)section]];
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        NSInteger actualLo = 0;
        //将每个section中的页数相加
        for (NSString *key in [self.sectionDic allKeys]) {
            actualLo += [self.sectionDic[key] integerValue];
        }
        //获取到的最后的数减去最后一组的页码数
        actualLo -= [self.sectionDic[[NSString stringWithFormat:@"%ld", [_sectionDic allKeys].count-1]] integerValue];
        xCellOffset += page*width + actualLo*width;
    }else {
        yCellOffset += offset;
    }
    attributes.frame = CGRectMake(xCellOffset, yCellOffset, itemW, itemH);
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attr = [super layoutAttributesForItemAtIndexPath:indexPath].copy;
    [self applyLayoutAttributes:attr];
    return attr;
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.allAttributes;
}
@end
//日期对象实现
@implementation Calendar

- (instancetype)initWithDate:(NSDate *)date {
    if ([super init]) {
        _date = date;
        _year = [self getYearMonthDayWeekdayFromDate:date].year;
        _month = [self getYearMonthDayWeekdayFromDate:date].month;
        _days = [self getMonthDaysFromDate:date];
        _firstDayWeek = [self getFirstDayWeekday];
    }
    return self;
}
/**获取当前日期月的第一天的星期*/
- (NSInteger)getFirstDayWeekday {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *cos = [cal components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self.date];
    cos.day = 1;
    NSDate *firstDayDate = [cal dateFromComponents:cos];
    NSLog(@"%@",firstDayDate);
    NSLog(@"%ld",(long)[self getYearMonthDayWeekdayFromDate:firstDayDate].weekday);
    return [self getYearMonthDayWeekdayFromDate:firstDayDate].weekday - 1;
}
/**根据date获取年月日星期*/
- (NSDateComponents *)getYearMonthDayWeekdayFromDate:(NSDate *)date {
    NSCalendar *cal = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *com = [cal components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:date];
    return com;
}
/**获取当前date下的月份天数*/
- (NSInteger)getMonthDaysFromDate:(NSDate *)date {
    NSCalendar *cal = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSRange range = [cal rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}
@end
