//
//  BPWebViewController.m
//  BaseProject_OC
//
//  Created by Aka on 2018/11/15.
//  Copyright © 2018 Aka. All rights reserved.
//

#import "BPWebViewController.h"
#import "BPWebView.h"
#import <WebKit/WebKit.h>
#import <WebViewJavascriptBridge/WKWebViewJavascriptBridge.h>
#import "dsbridge.h"

static NSString *const kEstimatedProgress = @"estimatedProgress";

@interface BPWebViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong) BPWebView *view;

@property (nonatomic, strong) WKWebViewJavascriptBridge *bridge;
@property (nonatomic, strong) 

@end

@implementation BPWebViewController

DP_DYNAMIC_VC_VIEW([BPWebView class]);

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.view.webView];
    [self.bridge registerHandler:@"onScanS3Click:" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC Echo called with: %@", data);
        responseCallback(data);
    }];
    
    if (_url) {
        _urlString = _url.absoluteString;
    }
    
    [self.view.webView addObserver:self forKeyPath:kEstimatedProgress options:NSKeyValueObservingOptionNew context:nil];
    self.view.webView.UIDelegate = self;
    self.view.webView.navigationDelegate = self;
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_urlString]];
    [self.view.webView loadRequest:urlRequest];
    
    UIBarButtonItem *rightBI = [[UIBarButtonItem alloc] initWithTitle:@"交互" style:UIBarButtonItemStylePlain target:self action:@selector(onTestAction)];
    self.navigationItem.rightBarButtonItem = rightBI;
}

- (void)onTestAction{
    [self.bridge callHandler:@"deliverCharacteristic" data:nil responseCallback:^(id responseData) {
        NSLog(@"ObjC received response: %@", responseData);
    }];
}

#pragma mark - WKNavigationDelegate method
// 如果不添加这个，那么wkwebview跳转不了AppStore
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if ([webView.URL.absoluteString hasPrefix:@"https://itunes.apple.com"]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"lt- progress :%@",change);
    if (object == self.view.webView && [keyPath isEqualToString:kEstimatedProgress]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        self.view.progressView.alpha = 1.0f;
        [self.view.progressView setProgress:newprogress animated:YES];
        if (newprogress >= 1.0f) {
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.view.progressView.alpha = 0.0f;
                             }
                             completion:^(BOOL finished) {
                                 [self.view.progressView setProgress:0 animated:NO];
                             }];
        }
    }
}

- (void)dealloc {
    [self.view.webView removeObserver:self forKeyPath:kEstimatedProgress];
}

@end
