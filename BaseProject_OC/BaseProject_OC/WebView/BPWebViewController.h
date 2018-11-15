//
//  BPWebViewController.h
//  BaseProject_OC
//
//  Created by Aka on 2018/11/15.
//  Copyright © 2018 Aka. All rights reserved.
//

#import "BPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPWebViewController : BPBaseViewController

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, assign) BOOL isOnBrowser; // 展示在浏览器上

@end

NS_ASSUME_NONNULL_END
