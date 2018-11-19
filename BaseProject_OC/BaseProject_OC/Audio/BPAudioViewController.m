//
//  BPAudioViewController.m
//  BaseProject_OC
//
//  Created by Aka on 2018/11/19.
//  Copyright © 2018 Aka. All rights reserved.
//

#import "BPAudioViewController.h"
#import "BPAudioView.h"
#import "BPIMAudioTCell.h"

#import "BPRecordAudioMgr.h"
#import "BPPlayAudioMgr.h"

@interface BPAudioViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) BPAudioView *view;

@property (nonatomic, strong) NSMutableArray<NSURL *> *mDatasources;


@end

@implementation BPAudioViewController

DP_DYNAMIC_VC_VIEW([BPAudioView class]);

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"语音录制";
    
    [self.view.tableView registerClass:[BPIMAudioTCell class] forCellReuseIdentifier:NSStringFromClass([BPIMAudioTCell class])];
    self.view.tableView.dataSource = self;
    self.view.tableView.delegate = self;
    
    _mDatasources = @[].mutableCopy;
    self.view.backgroundColor = [UIColor grayColor];
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    NSLog(@"height ;%f",height);
    self.view.actionBlock = ^(BOOL isRecording) {
        if (isRecording) {
           BOOL startFlag = [[BPRecordAudioMgr shared] startRecordAudio];
            if (!startFlag) {
                NSLog(@"lt- 启动录音失败");
                return ;
            }
            NSLog(@"lt- 开始录音");
        }
        else {
            [[BPRecordAudioMgr shared] stopRecordAudio];
        }
    };
    
    [BPRecordAudioMgr shared].stopBlock = ^(NSURL * _Nonnull pathUrl) {
        [self->_mDatasources addObject:pathUrl];
        [self.view.tableView reloadData];
    };
    
}

#pragma mark -- tableview datasource & delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _mDatasources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPIMAudioTCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BPIMAudioTCell class]) forIndexPath:indexPath];
    NSString *curRowString = _mDatasources[indexPath.row].absoluteString;
    if (curRowString.length <=20) {
        curRowString = [curRowString substringFromIndex:(curRowString.length-20)];
    }
    cell.textTextL.text = curRowString;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSURL *curPathURL = _mDatasources[indexPath.row];
    [[BPPlayAudioMgr shared] playWtihUrl:curPathURL];
}

@end
