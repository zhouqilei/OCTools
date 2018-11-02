//
//  AddressPickView.m
//  OCTools
//
//  Created by 周 on 2018/11/2.
//  Copyright © 2018年 周. All rights reserved.
//

#import "AddressPickView.h"
@interface AddressPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong)NSArray *provinces;//所有的省份数组
@property (nonatomic, strong)NSString *selectedProvince;//当前选中的省份
@property (nonatomic, strong)NSString *selectedCity;//当前选中的城市
@property (nonatomic, strong)NSString *selectedArea;//当前选中的地区
@end
@implementation AddressPickView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init {
    if ([super init]) {
        self.dataSource = [self getDataSourceFromJson];
        self.provinces = [self getProvincesFromDataSource];
        self.selectedProvince = @"北京市";
        self.selectedCity = @"北京";
        self.selectedArea = @"东城区";
    }
    return self;
}
- (void)setContentView {
    
    //创建按钮
    [self.contentView addSubview:self.sureBtn];
    [self.contentView addSubview:self.cancelBtn];
    //创建选择视图
    [self.contentView addSubview:self.pickerView];
}
#pragma mark - 选择视图
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, UI_SCREEN_WIDTH, self.contentHeight - 40)];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
    }
    return _pickerView;
}
#pragma mark - UIPickerViewDelegate UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinces.count;
    }else if (component == 1){
        return [self getCitysFromProvince:self.selectedProvince].count;
    }else if (component == 2){
        return [self getAreasFromProvince:self.selectedProvince AndCity:self.selectedCity].count;
    }
    return 0;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinces[row];
    }else if (component == 1){
        return [[self getCitysFromProvince:self.selectedProvince] objectAtIndex:row];
    }else if (component == 2){
        return [[self getAreasFromProvince:self.selectedProvince AndCity:self.selectedCity]objectAtIndex:row];
    }
    return @"";
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.selectedProvince = [self.provinces objectAtIndex:row];
        self.selectedCity = [self getCitysFromProvince:self.selectedProvince].firstObject;
        self.selectedArea = [self getAreasFromProvince:self.selectedProvince AndCity:self.selectedCity].firstObject;
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
    }else if (component == 1){
        self.selectedCity = [[self getCitysFromProvince:self.selectedProvince] objectAtIndex:row];
        self.selectedArea = [self getAreasFromProvince:self.selectedProvince AndCity:self.selectedCity].firstObject;
        [pickerView reloadComponent:2];
    }else if (component == 2){
        self.selectedArea = [[self getAreasFromProvince:self.selectedProvince AndCity:self.selectedCity] objectAtIndex:row];
    }
    
}
#pragma mark - 从地址文件中读取所有的数据
- (NSArray *)getDataSourceFromJson{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"address" ofType:@"json"];
    NSData *data = [[NSData alloc]initWithContentsOfFile:path];
    
    NSArray *dataSource = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return dataSource;
}
#pragma mark - 从数据源中读取所有的省名数组
- (NSArray *)getProvincesFromDataSource {
    NSMutableArray *provinces = [NSMutableArray array];
    for (NSDictionary *dic in self.dataSource) {
        NSString *province = dic.allKeys.firstObject;
        [provinces addObject:province];
    }
    return provinces;
}
#pragma mark - 根据省获取所有的市数组
- (NSArray *)getCitysFromProvince:(NSString *)province {
    NSMutableArray *citys = [NSMutableArray array];
    NSInteger index = [self.provinces indexOfObject:province];
    NSDictionary *dic = self.dataSource[index];
    NSArray *cityDataSource = dic[province];
    for (NSDictionary *dic in cityDataSource) {
        NSString *city = dic.allKeys.firstObject;
        [citys addObject:city];
    }
    return citys;
}
#pragma mark - 根据市获取所有的区数组
- (NSArray *)getAreasFromProvince:(NSString*)province AndCity:(NSString *)city {
    NSInteger provinceIndex = [self.provinces indexOfObject:province];
    NSDictionary *provinceDic = self.dataSource[provinceIndex];
    NSArray *cityDataSource = provinceDic[province];
    NSArray *citys = [self getCitysFromProvince:province];
    NSInteger cityIndex = [citys indexOfObject:city];
    NSLog(@"%@",cityDataSource);
    
    NSDictionary *cityDic = cityDataSource[cityIndex];
    NSArray *areas = cityDic[city];
    return areas;
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
    if ([self.delegate respondsToSelector:@selector(didClickSureWithProvince:City:Area:)]) {
        [self.delegate didClickSureWithProvince:self.selectedProvince City:self.selectedCity Area:self.selectedArea];
    }
    [self dismiss];
}
#pragma mark -重写弹出
- (void)show {
    if (!self.contentHeight) {
        self.contentHeight = 210.f;
    }
    [self setContentView];
    [[self lastWidow] addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        [self.contentView setFrame:CGRectMake(0, UI_SCREEN_HEIGHT - HOME_INDICATOR_HEIGHT - self.contentHeight, UI_SCREEN_WIDTH, self.contentHeight)];
    }completion:^(BOOL finished) {
       
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
@end
