//
//  GuidePageViewController.m
//  OCTools
//
//  Created by 周 on 2018/11/16.
//  Copyright © 2018年 周. All rights reserved.
//

#import "GuidePageViewController.h"

@interface GuidePageViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIPageControl *pageControl;
@end

@implementation GuidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}
//设置视图
- (void)setupView {
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    //设置图片
    CGFloat imgW = scrollView.frame.size.width;
    CGFloat imgH = scrollView.frame.size.height;
    for (int i = 0; i < self.imageArrary.count; i++) {
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.image = [UIImage imageNamed:self.imageArrary[i]];
        imageV.frame = CGRectMake(i * imgW, 0, imgW, imgH);
        [scrollView addSubview:imageV];
        //最后一张图片添加按钮
        if (i == self.imageArrary.count - 1) {
            [self addStartButtonInImageView:imageV];
        }
    }
    scrollView.contentSize = CGSizeMake(self.imageArrary.count * imgW, imgH);
    scrollView.pagingEnabled = YES;
    
    //设置点
    self.pageControl = [[UIPageControl alloc]init];
    self.pageControl.frame = CGRectMake(0, self.view.frame.size.height - HOME_INDICATOR_HEIGHT - 20, self.view.frame.size.width, 20);
    self.pageControl.numberOfPages = self.imageArrary.count;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [self.view addSubview:self.pageControl];
}
//设置图片数组
- (void)setImageArrary:(NSArray *)imageArrary {
    _imageArrary = imageArrary;
    [self setupView];
}
//添加开始按钮
- (void)addStartButtonInImageView:(UIImageView *)imageView {
    imageView.userInteractionEnabled = YES;
    UIButton *startButton = [[UIButton alloc]init];
    [startButton setTitle:@"开始体验" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CGFloat startButtonY = self.view.bounds.size.height - HOME_INDICATOR_HEIGHT - 20 - 50;
    CGFloat startButtonW = 145;
    CGFloat startButtonH = 50;
    CGFloat startButtonX = (self.view.bounds.size.width - startButtonW)/2;
    startButton.frame = CGRectMake(startButtonX, startButtonY, startButtonW, startButtonH);
    startButton.layer.cornerRadius = 3;
    startButton.backgroundColor = [UIColor redColor];
    [startButton addTarget:self action:@selector(loadViewController) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    //设置页码
    self.pageControl.currentPage = page;
}
//点击了开始体验
- (void)loadViewController {
    self.didClickStartBtnBlock();
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
