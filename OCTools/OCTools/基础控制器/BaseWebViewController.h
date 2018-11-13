//
//  BaseWebViewController.h
//  OCTools
//
//  Created by 周 on 2018/11/12.
//  Copyright © 2018年 周. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface BaseWebViewController : BaseViewController
@property (nonatomic, strong)NSString *url;
@property (nonatomic, strong)WKWebView *webView;
@end

NS_ASSUME_NONNULL_END
