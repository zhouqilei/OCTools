//
//  UIView+Extension.m
//  OCTools
//
//  Created by 周 on 2018/11/12.
//  Copyright © 2018年 周. All rights reserved.
//

#import "UIView+Extension.h"
@implementation UIView (Extension)
@dynamic viewController;
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    self.userInteractionEnabled = YES;
    UIControl *touchControl = [[UIControl alloc] initWithFrame:self.bounds];
    touchControl.backgroundColor = [UIColor clearColor];
    touchControl.tag=self.tag;
    [self addSubview:touchControl];
    
    [touchControl addTarget:target action:action forControlEvents:controlEvents];
}
@end
