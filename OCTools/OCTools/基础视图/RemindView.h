//
//  RemindView.h
//  OCTools
//
//  Created by 周 on 2018/11/6.
//  Copyright © 2018年 周. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, MessageType){
    MessageTypeSuccess,//成功
    MessageTypeError,//错误
    MessageTypeWarning//警告
};
@interface RemindView : UIView
+ (RemindView *)shareRemindView;
- (void)setMessageType:(MessageType )messageType andMessage:(NSString *)message;
- (void)show;
@end

NS_ASSUME_NONNULL_END
