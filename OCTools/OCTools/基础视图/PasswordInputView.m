//
//  PasswordInputView.m
//  OCTools
//
//  Created by 周 on 2018/12/5.
//  Copyright © 2018年 周. All rights reserved.
//

#import "PasswordInputView.h"
/**设置视图的高度*/
#define K_Content_Height (UI_SCREEN_HEIGHT / 3 * 2)
@interface PasswordInputView ()
@property (nonatomic, strong)InputView *inputV;
@property (nonatomic, strong)UIWindow *window;
@end

@implementation PasswordInputView
- (instancetype)init {
    if ([super init]) {
        [self setUpView];
    }
    return self;
}
#pragma mark - 设置界面
- (void)setUpView{
    self.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HOME_INDICATOR_HEIGHT);
    self.backgroundColor =  RGBA(0, 0, 0, 0.4);
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    [self addSubview:self.contentView];
    
    [self.contentView addSubview:self.inputV];
}
#pragma makr - 懒加载内容视图
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT - HOME_INDICATOR_HEIGHT, UI_SCREEN_WIDTH, self.contentHeight)];
        _contentView.backgroundColor = [UIColor whiteColor];
        
    }
    return _contentView;
}
- (InputView *)inputV {
    if (!_inputV) {
        _inputV = [[InputView alloc]initWithFrame:CGRectMake(10, 40, self.width - 20, 40)];
        __weak PasswordInputView *view  = self;
        _inputV.inputComplete = ^(NSString * _Nonnull password) {
            if ([view.delegate respondsToSelector:@selector(didFinishInput:)]) {
                [view.delegate didFinishInput:password];
            }
        };
    }
    return _inputV;
}
#pragma mark - 弹出视图
- (void)show {
    
    if (!self.contentHeight) {
        self.contentHeight = K_Content_Height;
    }
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.windowLevel = UIWindowLevelNormal + 1;
    [_window addSubview:self];
    [_window makeKeyAndVisible];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.inputV becomeFirstResponder];
        [self.contentView setFrame:CGRectMake(0, UI_SCREEN_HEIGHT - HOME_INDICATOR_HEIGHT - self.contentHeight, UI_SCREEN_WIDTH, self.contentHeight)];
    }];
}
- (void)tapAction:(UITapGestureRecognizer *)tap {
    if (CGRectContainsPoint(self.contentView.frame, [tap locationInView:self])) {
        
    }else {
        [self dismiss];
    }
}
#pragma mark - 隐藏视图
- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        [self.inputV resignFirstResponder];
        [self.contentView setFrame:CGRectMake(0, UI_SCREEN_HEIGHT - HOME_INDICATOR_HEIGHT, UI_SCREEN_WIDTH, self.contentHeight)];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.window resignKeyWindow];
    }];
}

@end

@interface InputView ()
/**保存密码的字符串*/
@property (nonatomic ,strong)NSMutableString *textStroe;
/**存放密码黑点的数组*/
@property (nonatomic, strong)NSMutableArray *dotArray;

@end

@implementation InputView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.textStroe = [NSMutableString string];
        self.dotArray = [NSMutableArray array];
        
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 1;
        //绘制 竖线
        CGFloat itemW = self.width / 6;
        for (int i = 1; i < 6; i++) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(itemW * i, 0, 1, self.height)];
            line.backgroundColor = [UIColor grayColor];
            [self addSubview:line];
        }
        //绘制黑色的点 设置大小为20 20
        for (int i = 0; i < 6; i++) {
            UIView *dotV = [[UIView alloc]initWithFrame:CGRectMake((itemW - 20) / 2 + i * itemW, (self.height - 20) / 2, 20, 20)];
            dotV.backgroundColor = [UIColor blackColor];
            dotV.layer.cornerRadius = 10;
            dotV.hidden = YES;
            [self addSubview:dotV];
            [self.dotArray addObject:dotV];
        }
    }
    return self;
}
#pragma UIKeyInput UITextInputTraits
/**键盘输入*/
- (void)insertText:(NSString *)text {
    //超出了密码的个数
    if (self.textStroe.length > 5) {
        return;
    }else {
        [self.textStroe appendString:text];
        //填充
        UIView *dotV = self.dotArray[self.textStroe.length - 1];
        dotV.hidden = NO;
        if (self.textStroe.length == 6) {
            //密码已经输入完毕
            self.inputComplete(self.textStroe);
            
        }
    }
}
- (BOOL)hasText {
    return self.textStroe.length > 0;
}
/**键盘删除*/
- (void)deleteBackward {
    if (self.textStroe.length == 0) {
        return;
    }else {
        //隐藏黑点
        UIView *dotV = self.dotArray[self.textStroe.length - 1];
        dotV.hidden = YES;
        //删除
        [self.textStroe deleteCharactersInRange:NSMakeRange(self.textStroe.length - 1, 1)];
    }
}
- (BOOL)canBecomeFirstResponder {
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (![self isFirstResponder]) {
        [self becomeFirstResponder];
    }
}
/**键盘类型*/
- (UIKeyboardType)keyboardType {
    return UIKeyboardTypeNumberPad;
}
/**绘制*/
- (void)drawRect:(CGRect)rect {
    
}

@end
