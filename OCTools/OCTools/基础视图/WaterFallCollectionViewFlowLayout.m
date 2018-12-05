//
//  WaterFallCollectionViewFlowLayout.m
//  OCTools
//
//  Created by 周 on 2018/12/5.
//  Copyright © 2018年 周. All rights reserved.
//

#import "WaterFallCollectionViewFlowLayout.h"
//默认列数
#define KColumnNumber 2
//默认列间距
#define KColumnDis 10.0
//默认行间距
#define KRowDis 10.0
//默认边缘距离
#define KEdgeInsets UIEdgeInsetsMake(0,0,0,0)
@interface WaterFallCollectionViewFlowLayout ()
//布局属性数组
@property (nonatomic, strong) NSMutableArray *attributeArray;
//高度数组
@property (nonatomic, strong) NSMutableArray *heightArray;
@end

@implementation WaterFallCollectionViewFlowLayout
- (NSMutableArray *)attributeArray {
    if (!_attributeArray) {
        _attributeArray = [NSMutableArray array];
    }
    return _attributeArray;
}

- (NSMutableArray *)heightArray {
    if (!_heightArray) {
        _heightArray = [NSMutableArray array];
    }
    return _heightArray;
}
//准备布局
- (void)prepareLayout {
    [super prepareLayout];
    if (!self.columnDis) {
        self.columnDis = KColumnDis;
    }
    if (!self.rowDis) {
        self.rowDis = KRowDis;
    }
    if (!self.columnNumber) {
        self.columnNumber = KColumnNumber;
    }
    if (!self.edgeInsets.top && !self.edgeInsets.left && !self.edgeInsets.bottom && !self.edgeInsets.right) {
        self.edgeInsets = KEdgeInsets;
    }
    
    //1.清除、布局数组数据
    //2.获取每个cell的布局属性
    
    //清除数据cell的布局属性
    if (self.attributeArray.count != 0) {
        [self.attributeArray removeAllObjects];
    }
    //清除高度
    if (self.heightArray.count != 0) {
        [self.heightArray removeAllObjects];
    }
    //添加高度
    for (int i = 0; i < self.columnNumber; i++) {
        [self.heightArray addObject:@(self.edgeInsets.top)];
    }
    //获取每个cell的布局属性
    //1.获取collectionView 拥有的区间
//    NSInteger sectionNumber = self.collectionView.numberOfSections;
    for (int j = 0; j < [self.collectionView numberOfItemsInSection:0]; j++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:0];
        //获取item属性
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attributeArray addObject:attributes];
    }
}
//返回对应的布局
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    //获取对应的item的attributes
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    /**计算item宽度*/
    //总宽度
    CGFloat width = self.collectionView.frame.size.width;
    //每个cell的width
    CGFloat itemW = (width - self.edgeInsets.left - self.edgeInsets.right - ((self.columnNumber - 1)*self.columnDis)) / self.columnNumber;
    //高度由代理返回
    CGFloat itemH = [self.datasource WaterFallLayout:self itemWidth:itemW indexPath:indexPath];
    
    //当前为第几列（从0算起）
    NSInteger currentColumn = indexPath.row % self.columnNumber;
    //itemX
    CGFloat itemX = self.edgeInsets.left + currentColumn *(self.columnDis + itemW);
    //itemY
    CGFloat itemY = [self.heightArray[currentColumn] floatValue];
    //改变数组记录的高度
    [self.heightArray removeObjectAtIndex:currentColumn];
    
    CGFloat currentH = itemY + itemH + self.rowDis;
    [self.heightArray insertObject:@(currentH) atIndex:currentColumn];
    attributes.frame = CGRectMake(itemX, itemY, itemW, itemH);
    return attributes;
}
//返回item的attributes数组
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributeArray;
}
//返回视图内容高度
- (CGSize)collectionViewContentSize {
    //找到最大高度
    CGFloat maxH = 0;
    for (int i = 0; i < self.columnNumber; i++) {
        CGFloat currentH = [self.heightArray[i] floatValue];
        if (maxH < currentH) {
            maxH = currentH;
        }
    }
     return CGSizeMake(0, maxH + self.edgeInsets.bottom);
}
@end
