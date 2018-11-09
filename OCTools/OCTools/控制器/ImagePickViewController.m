//
//  ImagePickViewController.m
//  OCTools
//
//  Created by 周 on 2018/11/9.
//  Copyright © 2018年 周. All rights reserved.
//

#import "ImagePickViewController.h"
#import "ImagesPickView.h"
@interface ImagePickViewController ()<ImagePickerViewDelegate>

@end

@implementation ImagePickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ImagesPickView *imageP = [[ImagesPickView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 200) andMaxImages:9 imagesNumPerRow:3];
    imageP.delegate = self;
    [self.view addSubview:imageP];
}
#pragma mark -ImagePickerViewDelegate
- (void)imagePickerView:(UIView *)view didFinishPickPhoto:(NSArray<UIImage *> *)photos {
    NSLog(@"%@",photos);
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
