//
//  PasswordInputView.h
//  OCTools
//
//  Created by 周 on 2018/12/5.
//  Copyright © 2018年 周. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PasswordInputViewDelegate <NSObject>

- (void)didFinishInput:(NSString*)password;

@end
@interface PasswordInputView : UIView
@property (nonatomic, strong)UIView *contentView;
@property (nonatomic, assign)CGFloat contentHeight;
@property (nonatomic, weak)id<PasswordInputViewDelegate>delegate;
//弹出
- (void)show;
//隐藏
- (void)dismiss;
//设置视图
- (void)setUpView;
@end


//输入视图
@interface InputView : UIView<UIKeyInput,UITextInputTraits>
/**输入完毕*/
@property (nonatomic, copy) void(^inputComplete)(NSString *password);
@end
NS_ASSUME_NONNULL_END
