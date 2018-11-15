//
//  BPWebView.h
//  BaseProject_OC
//
//  Created by Aka on 2018/11/15.
//  Copyright © 2018 Aka. All rights reserved.
//

#import "BPBaseView.h"
@class WKWebView;

NS_ASSUME_NONNULL_BEGIN

@interface BPWebView : BPBaseView

@property (nonatomic, strong) WKWebView *webView; // readonly 不可以kvo

@property (nonatomic, strong, readonly) UIProgressView *progressView;

@end

NS_ASSUME_NONNULL_END
