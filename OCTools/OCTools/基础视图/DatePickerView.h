//
//  DatePickerView.h
//  OCTools
//
//  Created by 周 on 2018/11/1.
//  Copyright © 2018年 周. All rights reserved.
//

#import "UpView.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, DateStyle){
    DateStyleDate,
    DateStyleYearAndMonth
};
@protocol DatePickerViewDelegate <NSObject>
-(void)didClickSureWithYear:(NSInteger )year AndMonth:(NSInteger )month AndDay:(NSInteger)day;

@end
@interface DatePickerView : UpView
//确定按钮
@property (nonatomic, strong)UIButton *sureBtn;
//取消按钮
@property (nonatomic, strong)UIButton *cancelBtn;
//自定义选择视图
@property (nonatomic, strong)UIPickerView *pickerView;
//系统选择视图
@property (nonatomic, strong)UIDatePicker *datePicker;
//选择的时间模式
@property (nonatomic, assign)DateStyle dateStyle;

//年，月，日
@property (nonatomic, assign)NSInteger year;
@property (nonatomic, assign)NSInteger month;
@property (nonatomic, assign)NSInteger day;

@property(nonatomic, weak)id<DatePickerViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
