//
//  ImagesPickView.m
//  OCTools
//
//  Created by 周 on 2018/11/9.
//  Copyright © 2018年 周. All rights reserved.
//

#import "ImagesPickView.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import <Photos/Photos.h>
#import <TZImagePickerController/UIView+Layout.h>
#import <TZImagePickerController/TZImageManager.h>
@interface ImagesPickView ()<UICollectionViewDelegate,UICollectionViewDataSource,TZImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
/**图片存放父视图*/
@property (nonatomic, strong)UICollectionView *imageCollectionView;
/**最大可选图片数量*/
@property (nonatomic, assign)NSInteger maxImages;
/**每行展示的图片数量*/
@property (nonatomic, assign)NSInteger imagesCountPerRow;
/**已选择的图片*/
@property (nonatomic, strong)NSMutableArray *selectedPhotos;
/**已选择的资源*/
@property (nonatomic, strong)NSMutableArray *selectedAssets;
@end
@implementation ImagesPickView
#pragma makr - 初始化方法
-(instancetype)initWithFrame:(CGRect)frame andMaxImages:(NSInteger)count imagesNumPerRow:(NSInteger)num {
    if ([super initWithFrame:frame]) {
        self.maxImages = count;
        self.imagesCountPerRow = num;
        self.selectedPhotos = [NSMutableArray array];
        self.selectedAssets = [NSMutableArray array];
        [self addSubview:self.imageCollectionView];
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, self.frame.size.width, self.imageCollectionView.frame.size.height);
    }
    return self;
}
#pragma makr - UICollectionViewDelegate UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _selectedPhotos.count + 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    cell.gifLable.hidden = YES;
    if (indexPath.row == self.selectedPhotos.count) {
        //需要展示添加指示图片
        cell.imageView.image = [UIImage imageNamed:@"icon-tj"];
        cell.deleteBtn.hidden = YES;
    }else {
        //普通的图片展示
        cell.imageView.image = _selectedPhotos[indexPath.row];
        cell.asset = self.selectedAssets[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == self.selectedPhotos.count) {
        //点击的是添加cell
        if (self.selectedPhotos.count == self.maxImages) {
            //已经不能再选择图片了
            NSString *title = [NSString stringWithFormat:[NSBundle tz_localizedStringForKey:@"Select a maximum of %zd photos"], self.maxImages];
            [[[TZImagePickerController alloc]init] showAlertWithTitle:title];
            return;
        }else {
            //选择图片
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请选择图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //判断权限
                AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied) {
                    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                    }];
                    [alertC addAction:action1];
                    [alertC addAction:action2];
                    [self.viewController presentViewController:alertC animated:YES completion:nil];
                }else {
                    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
                    picker.delegate = self;
                    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    [self.viewController presentViewController:picker animated:YES completion:nil];
                }
                
                
            }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                TZImagePickerController *picker = [[TZImagePickerController alloc]initWithMaxImagesCount:self.maxImages delegate:self];
                picker.selectedAssets = self.selectedAssets;
                picker.allowTakePicture = NO;
                [self.viewController presentViewController:picker animated:YES completion:nil];
            }];
            UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertC addAction:action1];
            [alertC addAction:action2];
            [alertC addAction:action3];
            [self.viewController presentViewController:alertC animated:YES completion:nil];
        }
    }else {
        //预览图片
        TZImagePickerController *imagePicker = [[TZImagePickerController alloc]initWithSelectedAssets:self.selectedAssets selectedPhotos:self.selectedPhotos index:indexPath.row];
        imagePicker.allowPickingImage = NO;
        [self.viewController presentViewController:imagePicker animated:YES completion:nil];
    }
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerController *,id> *)info {
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [[TZImageManager manager]savePhotoWithImage:image completion:^(PHAsset *asset, NSError *error) {
            [self.selectedAssets addObject:asset];
            [self.selectedPhotos addObject:image];
            [self.imageCollectionView reloadData];
            [self layoutNewFrame];
            if ([self.delegate respondsToSelector:@selector(imagePickerView:didFinishPickPhoto:)]) {
                [self.delegate imagePickerView:self didFinishPickPhoto:self.selectedPhotos];
            }
        }];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    [_imageCollectionView reloadData];
    [self layoutNewFrame];
    if ([self.delegate respondsToSelector:@selector(imagePickerView:didFinishPickPhoto:)]) {
        [self.delegate imagePickerView:self didFinishPickPhoto:self.selectedPhotos];
    }
}
#pragma mark - 删除图片
- (void)deleteAction:(UIButton *)sender {    
    [_selectedAssets removeObjectAtIndex:sender.tag];
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_imageCollectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
        [self.imageCollectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [self.imageCollectionView reloadData];
        [self layoutNewFrame];
    }];
    
    if ([self.delegate respondsToSelector:@selector(imagePickerView:didFinishPickPhoto:)]) {
        [self.delegate imagePickerView:self didFinishPickPhoto:self.selectedPhotos];
    }
}
#pragma makr - 懒加载
- (UICollectionView *)imageCollectionView {
    if (!_imageCollectionView) {
        //图片的宽度 图片直接的间隔是5
        CGFloat imgItemWidth = (self.frame.size.width - (self.imagesCountPerRow + 1) * 5) / self.imagesCountPerRow;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(imgItemWidth, imgItemWidth);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        
        _imageCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, imgItemWidth + 10) collectionViewLayout:layout];
        _imageCollectionView.backgroundColor = [UIColor whiteColor];
        _imageCollectionView.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
        _imageCollectionView.delegate = self;
        _imageCollectionView.dataSource = self;
        _imageCollectionView.scrollEnabled = NO;
        [_imageCollectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    }
    return _imageCollectionView;
}
#pragma mark - 重新设置视图尺寸
- (void)layoutNewFrame{
    NSInteger lineCount = ceil(self.selectedPhotos.count / self.imagesCountPerRow) + 1;
    CGFloat imgItemWidth = (self.frame.size.width - (self.imagesCountPerRow + 1) * 5) / self.imagesCountPerRow;
    self.imageCollectionView.frame = CGRectMake(0, 0, self.frame.size.width, lineCount *(10 + imgItemWidth));
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.imageCollectionView.frame.size.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
//cell的实现
@implementation TZTestCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
        self.clipsToBounds = YES;
        
        _videoImageView = [[UIImageView alloc] init];
        _videoImageView.image = [UIImage imageNamedFromMyBundle:@"MMVideoPreviewPlay"];
        _videoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _videoImageView.hidden = YES;
        [self addSubview:_videoImageView];
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"photo_delete"] forState:UIControlStateNormal];
        _deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -10);
        _deleteBtn.alpha = 0.6;
        [self addSubview:_deleteBtn];
        
        _gifLable = [[UILabel alloc] init];
        _gifLable.text = @"GIF";
        _gifLable.textColor = [UIColor whiteColor];
        _gifLable.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        _gifLable.textAlignment = NSTextAlignmentCenter;
        _gifLable.font = [UIFont systemFontOfSize:10];
        [self addSubview:_gifLable];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    _gifLable.frame = CGRectMake(self.tz_width - 25, self.tz_height - 14, 25, 14);
    _deleteBtn.frame = CGRectMake(self.tz_width - 36, 0, 36, 36);
    CGFloat width = self.tz_width / 3.0;
    _videoImageView.frame = CGRectMake(width, width, width, width);
}

- (void)setAsset:(PHAsset *)asset {
    _asset = asset;
    _videoImageView.hidden = asset.mediaType != PHAssetMediaTypeVideo;
    _gifLable.hidden = ![[asset valueForKey:@"filename"] containsString:@"GIF"];
}

- (void)setRow:(NSInteger)row {
    _row = row;
    _deleteBtn.tag = row;
}

- (UIView *)snapshotView {
    UIView *snapshotView = [[UIView alloc]init];
    
    UIView *cellSnapshotView = nil;
    
    if ([self respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)]) {
        cellSnapshotView = [self snapshotViewAfterScreenUpdates:NO];
    } else {
        CGSize size = CGSizeMake(self.bounds.size.width + 20, self.bounds.size.height + 20);
        UIGraphicsBeginImageContextWithOptions(size, self.opaque, 0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage * cellSnapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        cellSnapshotView = [[UIImageView alloc]initWithImage:cellSnapshotImage];
    }
    
    snapshotView.frame = CGRectMake(0, 0, cellSnapshotView.frame.size.width, cellSnapshotView.frame.size.height);
    cellSnapshotView.frame = CGRectMake(0, 0, cellSnapshotView.frame.size.width, cellSnapshotView.frame.size.height);
    
    [snapshotView addSubview:cellSnapshotView];
    return snapshotView;
}

@end
//实现获取视图所在控制器的扩展
@implementation UIView (Extend)
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
