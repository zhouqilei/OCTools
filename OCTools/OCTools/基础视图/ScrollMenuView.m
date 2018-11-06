//
//  ScrollMenuView.m
//  OCTools
//
//  Created by 周 on 2018/11/5.
//  Copyright © 2018年 周. All rights reserved.
//

#import "ScrollMenuView.h"
@interface ScrollMenuView ()
@property (nonatomic, strong)UIScrollView *contentScrollView;
/**被选中时底部线*/
@property (nonatomic, strong)UIView *bottomSelectedLineView;
/**按钮数组*/
@property (nonatomic, strong)NSMutableArray *itemButtons;
/**样式*/
@property (nonatomic, assign)ScrollMenuViewStyle style;
@end
@implementation ScrollMenuView

- (instancetype)initWithFrame:(CGRect)frame andStyle:(ScrollMenuViewStyle)style {
    if ([super initWithFrame:frame]) {
        self.style = style;
        self.itemButtons = [NSMutableArray array];
        [self setupView];
    }
    return self;
}
#pragma mark - 如果按钮太少，重新设置按钮位置
- (void)setNewLayout {
    
    CGFloat btnWidth = self.frame.size.width / self.items.count;
    CGFloat lastButtonMaxX = 0;
    for (NSInteger i = 0; i < self.items.count; i++) {
        ScrollMenuButton *btn = self.itemButtons[i];
        btn.frame = CGRectMake(lastButtonMaxX, 0, btnWidth, btn.frame.size.height);
        lastButtonMaxX += btn.frame.size.width;
        if (i == 0) {
            [self initBottomLineViewWithButton:btn];
        }
    }
}
#pragma mark - 设置菜单内容
- (void)setItems:(NSArray *)items {
    _items = items;
    [self setupView];
}
#pragma mark - 懒加载底部线
- (UIView *)bottomSelectedLineView {
    if (!_bottomSelectedLineView) {
        _bottomSelectedLineView = [[UIView alloc]init];
        _bottomSelectedLineView.backgroundColor = [UIColor redColor];
    }
    return _bottomSelectedLineView;
}
#pragma makr - 底部线
- (void)initBottomLineViewWithButton:(ScrollMenuButton *)btn {
    CGFloat lineViewWidth = self.style == ScrollMenuViewStyleValue1 ? btn.frame.size.width : 20;
    CGFloat lineViewOrignalX = self.style == ScrollMenuViewStyleValue1 ? 0 : (btn.frame.size.width - lineViewWidth) / 2.0;
    self.bottomSelectedLineView.frame = CGRectMake(lineViewOrignalX, self.frame.size.height - 1, lineViewWidth, 1);
}
- (void)moveBottomLineWithButton:(ScrollMenuButton *)btn
{
    CGFloat lineViewWidth = self.style == ScrollMenuViewStyleValue1 ? btn.frame.size.width : 20;
    CGFloat lineViewOrignalX = self.style == ScrollMenuViewStyleValue1 ? btn.frame.origin.x : btn.frame.origin.x + (btn.frame.size.width - lineViewWidth) / 2.0;
    self.bottomSelectedLineView.frame = CGRectMake(lineViewOrignalX, self.height - 1, lineViewWidth, 1);
}
#pragma mark - 菜单被点击
- (void)clickItemButton:(ScrollMenuButton *)btn {
    self.currentIndex = btn.tag;
    if ([self.delegate respondsToSelector:@selector(scrollMenuView:didClickItemAtIndex:)]) {
        [self.delegate scrollMenuView:self didClickItemAtIndex:btn.tag];
    }
}
#pragma mark - 视图设置
- (void)setupView{
    self.contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    //不显示滚动条
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.contentScrollView];
    
    //上一个按钮的最右X
    CGFloat lastButtonMaxX = 0;
    for (NSInteger i = 0; i < self.items.count; i++) {
        ScrollMenuButton *btn = [ScrollMenuButton defaultStyleButtonWithTitle:self.items[i]];
        btn.tag = i;
        [btn addTarget:self action:@selector(clickItemButton:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(lastButtonMaxX, 0, btn.frame.size.width + 30, self.height);
        btn.selected = i == 0;
        lastButtonMaxX += (btn.frame.size.width + 30);
        [self.contentScrollView addSubview:btn];
        [self.itemButtons addObject: btn];
        //设置底部线
        if (i == 0) {
            self.bottomSelectedLineView.hidden = self.style == ScrollMenuViewStyleDefault;
            [self initBottomLineViewWithButton:btn];
            [self.contentScrollView addSubview:self.bottomSelectedLineView];
        }
    }
    self.contentScrollView.contentSize = CGSizeMake(lastButtonMaxX, 0);
    if (lastButtonMaxX < self.frame.size.width) {
        //由于按钮太少，从新设置视图
        [self setNewLayout];
    }
}
#pragma mark - 设置当前菜单下标
- (void)setCurrentIndex:(NSInteger)currentIndex {
    if (currentIndex >= self.items.count) {
        NSLog(@"下标溢出");
        return;
    }
    _currentIndex = currentIndex;
    for (ScrollMenuButton *btn in self.itemButtons) {
        btn.selected = currentIndex == btn.tag;
        if (btn.isSelected == YES) {
            [UIView animateWithDuration:0.1 animations:^{
                [self moveBottomLineWithButton:btn];
            }];
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
#pragma mark 菜单按钮
@implementation ScrollMenuButton
+ (instancetype)defaultStyleButtonWithTitle:(NSString *)title {
    ScrollMenuButton *btn = [ScrollMenuButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    CGSize size = [btn.titleLabel sizeThatFits:CGSizeMake(50, 50)];
    btn.frame = CGRectMake(0, 0, size.width, size.height);
    return btn;
}
@end
