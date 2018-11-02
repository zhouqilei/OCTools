//
//  AddressPickView.h
//  OCTools
//
//  Created by 周 on 2018/11/2.
//  Copyright © 2018年 周. All rights reserved.
//

#import "UpView.h"

NS_ASSUME_NONNULL_BEGIN
@protocol AddressPickViewDelegate <NSObject>

-(void)didClickSureWithProvince:(NSString *)province City:(NSString *)city Area:(NSString *)area;

@end
@interface AddressPickView : UpView
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, weak)id<AddressPickViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
