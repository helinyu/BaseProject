//
//  BPWebView.m
//  BaseProject_OC
//
//  Created by Aka on 2018/11/15.
//  Copyright © 2018 Aka. All rights reserved.
//

#import "BPWebView.h"
#import <WebKit/WebKit.h>

@interface BPWebView ()

//@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation BPWebView

- (void)baseInit {
    [super baseInit];
        
    _webView = [[WKWebView alloc] initWithFrame:self.bounds];
    [self addSubview:_webView];
    
    _progressView = [UIProgressView new];
    [self addSubview:_progressView];
    _progressView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 1.f);
    _progressView.tintColor = [UIColor blueColor];
    _progressView.trackTintColor = [UIColor whiteColor];
}

@end
