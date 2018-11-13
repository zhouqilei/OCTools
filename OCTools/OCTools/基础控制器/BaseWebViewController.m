//
//  BaseWebViewController.m
//  OCTools
//
//  Created by 周 on 2018/11/12.
//  Copyright © 2018年 周. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@property (nonatomic, strong)CALayer *progresslayer;
@end

@implementation BaseWebViewController
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //配置WKWebViewConfiguration
    WKWebViewConfiguration *conf = [[WKWebViewConfiguration alloc]init];
    conf.preferences = [[WKPreferences alloc]init];
    conf.preferences.minimumFontSize = 10;
    conf.preferences.javaScriptEnabled = YES;
    conf.userContentController = [[WKUserContentController alloc]init];
    conf.processPool = [[WKProcessPool alloc]init];
    
    //初始化
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar - HOME_INDICATOR_HEIGHT) configuration:conf];
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self.view addSubview:self.webView];
    
    self.progresslayer = [[CALayer alloc]init];
    self.progresslayer.frame = CGRectMake(0, 0, 20, 2);
    self.progresslayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.progresslayer];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    //添加js注入，js调用原生
    //[conf.userContentController addScriptMessageHandler:self name:@"jsFunction"];
    //后台js调用
    //window.webkit.messageHandlers.jsFunction.postMessage({body: 'key=value'});
    
}
#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    //接收后台传递数据
    /*
    if ([message.name isEqualToString:@"jsFunction"]) {
        NSLog(@"%@",message.body);
    }
     */
}
#pragma makr - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    //加载成功
    //原生调用js
    /*
    NSString *js = [NSString stringWithFormat:@"sendKey('%@')",@"key"];
    [self.webView evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
    }];
     */
}
#pragma mark -监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progresslayer.opacity = 1;
        float newValue = [[change objectForKey:@"new"] floatValue];
        self.progresslayer.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH * newValue, 2);
        if (newValue == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.frame = CGRectMake(0, 0, 0, 2);
            });
        }
    }
    if ([keyPath isEqualToString:@"title"]) {
        self.title = [change objectForKey:@"new"];
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
