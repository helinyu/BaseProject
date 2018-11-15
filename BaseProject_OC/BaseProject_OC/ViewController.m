//
//  ViewController.m
//  BaseProject_OC
//
//  Created by Aka on 2018/11/15.
//  Copyright © 2018 Aka. All rights reserved.
//

#import "ViewController.h"
#import "BPWebViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  ;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"asdf" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(0.f, 100.f, 100.f, 100.f);
    [btn  addTarget:self action:@selector(onloca) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onloca {
    BPWebViewController *vc = [BPWebViewController new];
    vc.urlString = @"http://www.baidu.com";
    [self.navigationController pushViewController:vc animated:YES];
}


@end
