//
//  TagsView.m
//  OCTools
//
//  Created by 周 on 2018/11/26.
//  Copyright © 2018年 周. All rights reserved.
//

#import "TagsView.h"
#define Normal_Text_Color [UIColor blackColor]//标签正常下文字颜色
#define Selected_Text_Color [UIColor whiteColor]//标签被选中文字
#define Normal_Background_Color [UIColor whiteColor]//标签未点击背景颜色
#define Selected_Background_Color [UIColor redColor]//标签点击背景颜色
#define Title_Font [UIFont systemFontOfSize:15]//标签的字体大小
#define Btn_Height 40.f//标签按钮的高度
#define KBtn_Space_H 10.f //按钮左右间距
#define KBtn_Space_V 10.f //按钮上下间距

@interface TagsView()
/**标签数组*/
@property (nonatomic, strong)NSArray *tags;
/**已经选中的标签*/
@property (nonatomic, strong)NSMutableArray *selectedTags;
@end
@implementation TagsView
- (instancetype)initWithFrame:(CGRect)frame tagsArray:(NSArray *)tags {
    if ([super initWithFrame:frame]) {
        _tags = tags;
        [self setupView];
        
    }
    return self;
}
- (NSMutableArray *)selectedTags {
    if (!_selectedTags) {
        _selectedTags = [NSMutableArray array];
    }
    return _selectedTags;
}
- (void)setupView {
    //布局过程中当前按钮最大X
    CGFloat lastMaxX = KBtn_Space_H;
    //布局过程中当前按钮最大Y
    CGFloat lastMaxY = KBtn_Space_V;
    for (int i = 0; i < self.tags.count; i++) {
        TagBtn *btn = [TagBtn tagBtnWithTagTitle:self.tags[i]];
        btn.tag = i;
        [btn addTarget:self action:@selector(clickTag:) forControlEvents:UIControlEventTouchUpInside];
        if (btn.width + lastMaxX + KBtn_Space_H > self.frame.size.width) {
            //如果这个按钮的宽度过大，两种情况一种是这一行只有这一个按钮，它就是太长 ，另一种是还有别的按钮，要换行
            if (lastMaxX == KBtn_Space_H) {
                //第一种情况 独占一行
                btn.frame = CGRectMake(lastMaxX, lastMaxY, self.frame.size.width - 2 * KBtn_Space_H, Btn_Height);
                //最大高度改变
                lastMaxY = lastMaxY + Btn_Height + KBtn_Space_V;
            }else {
                //需要换行
                lastMaxY = lastMaxY + Btn_Height + KBtn_Space_V;
                lastMaxX = KBtn_Space_H;
                btn.frame = CGRectMake(lastMaxX, lastMaxY, btn.width + lastMaxX + KBtn_Space_H > self.width ? self.width - 2 * KBtn_Space_H : btn.width, Btn_Height);
                lastMaxX = btn.maxX + KBtn_Space_H;
            }
        }else {
            //可以放得下，不需要换行
            btn.frame = CGRectMake(lastMaxX, lastMaxY, btn.width, Btn_Height);
            lastMaxX = lastMaxX + btn.width + KBtn_Space_H;
        }
        [self addSubview:btn];
    }
    //设置view的高度
    self.frame = CGRectMake(self.x, self.y, self.width, lastMaxY + Btn_Height + KBtn_Space_V);
    
}
- (void)clickTag:(UIButton *)sender {
    
    if (self.canMultipleSelection) {
        //多选
         sender.selected = sender.selected == NO ? YES : NO;
        if (sender.selected) {
            [self.selectedTags addObject:sender.titleLabel.text];
        }else {
            [self.selectedTags removeObject:sender.titleLabel.text];
        }
    }else {
        //单选
        [self.selectedTags removeAllObjects];
        for (TagBtn *btn in self.subviews) {
            btn.selected = NO;
        }
        sender.selected = YES;
        [self.selectedTags addObject:sender.titleLabel.text];
    }
    if ([self.delegate respondsToSelector:@selector(tagsView:didSelectedTags:)]) {
        [self.delegate tagsView:self didSelectedTags:self.selectedTags];
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

@implementation TagBtn
+ (TagBtn*)tagBtnWithTagTitle:(NSString *)title{
    TagBtn *btn = [super buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = Title_Font;
    btn.backgroundColor = Normal_Background_Color;
    [btn setTitleColor:Normal_Text_Color forState:UIControlStateNormal];
    [btn setTitleColor:Selected_Text_Color forState:UIControlStateSelected];
    btn.layer.cornerRadius = 20;
    btn.layer.masksToBounds = YES;
    CGSize size = [btn.titleLabel sizeThatFits:CGSizeMake(50, Btn_Height)];
    btn.frame = CGRectMake(0, 0, size.width + 10, Btn_Height);
    //监听属性变化
    [btn addObserver:btn forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:nil];
    return btn;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self && [keyPath isEqualToString:@"selected"]) {
        if (self.selected) {
            self.backgroundColor = Selected_Background_Color;
        }else {
            self.backgroundColor = Normal_Background_Color;
        }
    }
}
@end
