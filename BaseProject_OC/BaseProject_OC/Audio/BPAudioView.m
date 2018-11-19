//
//  BPAudioView.m
//  BaseProject_OC
//
//  Created by Aka on 2018/11/19.
//  Copyright © 2018 Aka. All rights reserved.
//

#import "BPAudioView.h"
#import <Masonry/Masonry.h>

@interface BPAudioView ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *recorderBtn;
@property (nonatomic, assign) BOOL isRecording;

@end

static CGFloat kBtnH = 40.f;

@implementation BPAudioView

- (void)baseInit {
    [super baseInit];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(DLTopLayoutH);
        make.bottom.equalTo(self).offset(-(DLBottomFix +kBtnH));
    }];
    _tableView.backgroundColor = [UIColor cyanColor];
    
    _recorderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_recorderBtn];
    [_recorderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-DLBottomFix);
        make.height.mas_equalTo(kBtnH);
    }];
    [_recorderBtn setTitle:@"长按录制" forState:UIControlStateNormal];
    [_recorderBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_recorderBtn setTitle:@"录制中..." forState:UIControlStateHighlighted];
    [_recorderBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    
    [_recorderBtn addTarget:self action:@selector(onRecordAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onRecordAction:(UIButton *)sender {
    NSLog(@"sender.allControlEvents %lu",(unsigned long)sender.allControlEvents);
    _isRecording = !_isRecording;
    if (_isRecording) {
        [_recorderBtn setTitle:@"录制中..." forState:UIControlStateNormal];
        [_recorderBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_recorderBtn setTitle:@"停止录制" forState:UIControlStateHighlighted];
        [_recorderBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        !_actionBlock? :_actionBlock(_isRecording);
    }
    else {
        [_recorderBtn setTitle:@"录制中..." forState:UIControlStateHighlighted];
        [_recorderBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [_recorderBtn setTitle:@"长按录制" forState:UIControlStateNormal];
        [_recorderBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        !_actionBlock? :_actionBlock(_isRecording);
    }
}


@end
