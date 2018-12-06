//
//  WaterFallViewController.m
//  OCTools
//
//  Created by 周 on 2018/12/5.
//  Copyright © 2018年 周. All rights reserved.
//

#import "WaterFallViewController.h"
#import "WaterFallCollectionViewFlowLayout.h"
@interface WaterFallViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,WaterFallCollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionV;
@end

@implementation WaterFallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.collectionV];
}
- (UICollectionView *)collectionV {
    if (!_collectionV) {
        WaterFallCollectionViewFlowLayout *layout = [[WaterFallCollectionViewFlowLayout alloc]init];
        layout.columnNumber = 3;
        layout.datasource = self;
        layout.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        _collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, HeightForNagivationBarAndStatusBar, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HOME_INDICATOR_HEIGHT - HeightForNagivationBarAndStatusBar) collectionViewLayout:layout];
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        _collectionV.backgroundColor = [UIColor whiteColor];
        
        [_collectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionV;
}

#pragma mark - UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor greenColor];
    }else if (indexPath.row % 3 ==0){
        cell.backgroundColor = [UIColor blueColor];
    }else {
        cell.backgroundColor = [UIColor redColor];
    }
    return cell;
}
#pragma mark - layout
- (CGFloat)WaterFallLayout:(WaterFallCollectionViewFlowLayout *)layout itemWidth:(CGFloat)itemWidth indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        return 100;
    }else if (indexPath.row %3 == 0){
        return 110;
    }else {
        return 90;
    }
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
