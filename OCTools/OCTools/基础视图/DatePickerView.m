//
//  DatePickerView.m
//  OCTools
//
//  Created by 周 on 2018/11/1.
//  Copyright © 2018年 周. All rights reserved.
//

#import "DatePickerView.h"
@interface DatePickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
@end
@implementation DatePickerView
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init {
    self = [super init];
    return self;
}
#pragma mark - 创建内容视图
- (void)setContentView {
    //创建按钮
    [self.contentView addSubview:self.sureBtn];
    [self.contentView addSubview:self.cancelBtn];
    //创建选择器
    if (self.dateStyle == DateStyleDate) {
        [self.contentView addSubview:self.datePicker];
    }else if (self.dateStyle == DateStyleYearAndMonth){
        [self.contentView addSubview:self.pickerView];
    }
}

#pragma mark - 自定义选择视图
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, UI_SCREEN_WIDTH, self.contentHeight - 40)];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        [_pickerView selectRow:100 inComponent:0 animated:YES];
        [_pickerView selectRow:[self getYearAndMonthAndDayFrom:[NSDate date]].month - 1 inComponent:1 animated:YES];
    }
    return _pickerView;
}
#pragma mark - 系统时间视图
- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        //系统时间选择
        _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 40, UI_SCREEN_WIDTH, self.contentHeight - 40)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        _datePicker.date = [NSDate date];
        [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}
#pragma mark - 系统时间选择器变化
- (void)dateChanged:(UIDatePicker *)datePicker{
    self.year = [self getYearAndMonthAndDayFrom:self.datePicker.date].year;
    self.month = [self getYearAndMonthAndDayFrom:self.datePicker.date].month;
    self.day = [self getYearAndMonthAndDayFrom:self.datePicker.date].day;
}
#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        //年分取当前年份上下100年
        return 201;
    }else {
        //月份为12个月
        return 12;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        NSInteger currentYear = [self getYearAndMonthAndDayFrom:[NSDate date]].year;
        return [NSString stringWithFormat:@"%d年",currentYear - (100 - row)];
    }else {
        return [NSString stringWithFormat:@"%d月",row + 1];
    }
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.day = 0;
    if (component == 0) {
        NSInteger currentYear = [self getYearAndMonthAndDayFrom:[NSDate date]].year;
        self.year = currentYear - (100-row);
    }else {
        self.month = row + 1;
    }
    
}
#pragma mark - 确定按钮
- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 60, 0, 60, 40)];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}
#pragma mark - 取消按钮
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
#pragma mark -确定选择
- (void)sureAction {
    if ([self.delegate respondsToSelector:@selector(didClickSureWithYear:AndMonth:AndDay:)]) {
        [self.delegate didClickSureWithYear:self.year AndMonth:self.month AndDay:self.day];
        [self dismiss];
    }
}
#pragma mark -重写视图出现的方法
- (void)show {
    if (!self.contentHeight) {
        self.contentHeight = 210.f;
    }
    [self setContentView];
    [[self lastWidow] addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        [self.contentView setFrame:CGRectMake(0, UI_SCREEN_HEIGHT - HOME_INDICATOR_HEIGHT - self.contentHeight, UI_SCREEN_WIDTH, self.contentHeight)];
    }completion:^(BOOL finished) {
        if (self.dateStyle == DateStyleDate) {
            self.year = [self getYearAndMonthAndDayFrom:self.datePicker.date].year;
            self.month = [self getYearAndMonthAndDayFrom:self.datePicker.date].month;
            self.day = [self getYearAndMonthAndDayFrom:self.datePicker.date].day;
        }else if (self.dateStyle == DateStyleYearAndMonth){
            self.year = [self getYearAndMonthAndDayFrom:[NSDate date]].year;
            self.month = [self getYearAndMonthAndDayFrom:[NSDate date]].month;
            self.day = 0;
        }
    }];
}
#pragma mark - 获取最上层window
- (UIWindow *)lastWidow{
    NSArray *windows = [UIApplication sharedApplication].windows;
    for (UIWindow *window in [windows reverseObjectEnumerator]) {
        if ([window isKindOfClass:[UIWindow class]] && CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds)) {
            return window;
        }
    }
    return [UIApplication sharedApplication].keyWindow;
}
#pragma mark - 根据date获取年月日
- (NSDateComponents *)getYearAndMonthAndDayFrom:(NSDate *)date {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *d = [cal components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self.datePicker.date];
    return d;
}
@end
