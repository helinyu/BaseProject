//
//  BPRecordAudioMgr.m
//  BaseProject_OC
//
//  Created by Aka on 2018/11/19.
//  Copyright © 2018 Aka. All rights reserved.
//

#import "BPRecordAudioMgr.h"
#import <AVFoundation/AVFoundation.h>

@interface BPRecordAudioMgr ()<AVAudioRecorderDelegate>

@property (nonatomic, assign) BOOL hasSettingSuccess;

@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, strong) NSDictionary *recorderSettings;
@property (nonatomic, copy) NSString *audioDefaultPath;
@property (nonatomic, strong) NSURL *curPathUrl;

@property (nonatomic, strong) NSMutableDictionary *mCacheUrls;

@end

static NSString *const kAudioCacheName = @"record_audio";

@implementation BPRecordAudioMgr

+ (instancetype)shared {
    static id singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        _audioDefaultPath =[documentDir stringByAppendingPathComponent:kAudioCacheName];
        
        NSError *error = nil;
        if (![[NSFileManager defaultManager] createDirectoryAtPath:_audioDefaultPath withIntermediateDirectories:YES attributes:nil error:&error] ) {
            [[NSFileManager defaultManager] createDirectoryAtPath:_audioDefaultPath withIntermediateDirectories:YES attributes:nil error:&error];
            if (error) {
                NSLog(@"lt- 创建这个文件夹失败");
            }
        }
        
        _mCacheUrls = @{}.mutableCopy;
    }
    return self;
}

- (BOOL)startRecordAudio {
    if (![self configureAudioRecordCategory]) {
        return NO;
    }
  
    NSURL *pathUrl = [self configureDefaultPath];
    if (pathUrl.absoluteString.length <=0) {
        return NO;
    }
    
    _audioRecorder = [self configureAudioRecorderWithPathUrl:pathUrl];
    if (!_audioRecorder) {
        return NO;
    }
    
    BOOL prepareFlag = [_audioRecorder prepareToRecord];
    if (!prepareFlag) {
        return NO;
    }
    
    BOOL recordFlag = [_audioRecorder record];
    return recordFlag;
}

- (void)pauseRecordAudio {
    [_audioRecorder pause];
}

- (void)stopRecordAudio {
    [_audioRecorder stop];
    !_stopBlock? :_stopBlock(_curPathUrl);
}

- (AVAudioRecorder *)configureAudioRecorderWithPathUrl:(NSURL *)pathUrl {
    NSError *error = nil;
    NSDictionary *settings = @{AVSampleRateKey:@(8000),
                               AVFormatIDKey:@(kAudioFormatLinearPCM),
                               AVLinearPCMBitDepthKey:@(16),
                               AVNumberOfChannelsKey:@(1),
                               };
    _audioRecorder = [[AVAudioRecorder alloc] initWithURL:pathUrl settings:settings error:&error];
    _audioRecorder.delegate = self;
    if (error) {
        return nil;
    }
    return _audioRecorder;
}

- (NSURL *)configureDefaultPath {
    NSDate *date = [NSDate new];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";;
    NSString *string = [dateFormatter stringFromDate:date];
    NSString *name = [NSString stringWithFormat:@"im_audio_%@",string];
    NSString *path = [_audioDefaultPath stringByAppendingPathComponent:name];
    NSString *wavFilePath = [path stringByAppendingPathExtension:@"wav"];
    NSURL *wavUrl = [[NSURL alloc] initFileURLWithPath:wavFilePath];
    [_mCacheUrls setObject:wavFilePath forKey:string];
    _curPathUrl = wavUrl;
    return wavUrl;
}

- (BOOL)configureAudioRecordCategory {
    if (_hasSettingSuccess) {
        return YES;
    }
    NSError *error = nil;
    if (@available(iOS 10.0, *)) {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord mode:AVAudioSessionModeDefault options:AVAudioSessionCategoryOptionMixWithOthers error:&error];
    } else {
        // Fallback on earlier versions
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionMixWithOthers error:&error];
    }
    [[AVAudioSession sharedInstance] setActive:YES error:&error];
    if (!error) {
        _hasSettingSuccess = YES;
        return YES;
    }
    
    _hasSettingSuccess = NO;
    return NO;
}

#pragma mark -- delegate

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    NSLog(@"it- audioRecorderDidFinishRecording");
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError * __nullable)error {
    NSLog(@"it- audioRecorderEncodeErrorDidOccur");
}


@end
