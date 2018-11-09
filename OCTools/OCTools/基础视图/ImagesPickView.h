//
//  ImagesPickView.h
//  OCTools
//
//  Created by 周 on 2018/11/9.
//  Copyright © 2018年 周. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ImagePickerViewDelegate <NSObject>
@optional
- (void)imagePickerView:(UIView *)view didFinishPickPhoto:(NSArray<UIImage *> *)photos;

@end
@interface ImagesPickView : UIView
@property (nonatomic, weak)id<ImagePickerViewDelegate>delegate;
- (instancetype)initWithFrame:(CGRect)frame andMaxImages:(NSInteger )count imagesNumPerRow:(NSInteger )num;

@end

//图片选择时cell的展示
@interface TZTestCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *videoImageView;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UILabel *gifLable;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong) id asset;

- (UIView *)snapshotView;

@end
//获取视图所在控制器的扩展
@interface UIView (Extend)
- (UIViewController *)viewController;
@end
NS_ASSUME_NONNULL_END
