//
//  BPPlayAudioMgr.m
//  BaseProject_OC
//
//  Created by Aka on 2018/11/19.
//  Copyright © 2018 Aka. All rights reserved.
//

#import "BPPlayAudioMgr.h"
#import <AVFoundation/AVFoundation.h>

@interface BPPlayAudioMgr ()<AVAudioPlayerDelegate>

@property (nonatomic, strong) AVPlayerItem *curItem;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation BPPlayAudioMgr

+ (instancetype)shared {
    static id singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

- (BOOL)configureAudioCategoryForPlayer {
    NSError *error = nil;
    if (@available(iOS 10.0, *)) {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback mode:AVAudioSessionModeDefault options:AVAudioSessionCategoryOptionMixWithOthers error:&error];
    } else {
        // Fallback on earlier versions
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:&error];
    }
    [[AVAudioSession sharedInstance] setActive:YES error:&error];
    if (error) {
        return NO;
    }
    return YES;
}

- (BOOL)playWtihUrl:(NSURL *)pathUrl {
    
    if (![self configureAudioCategoryForPlayer]) {
        NSLog(@"category configure no");
        return NO;
    }
    if (_audioPlayer) {
        [_audioPlayer stop];
        _audioPlayer = nil;
    }
    NSError *playerError = nil;
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:pathUrl error:&playerError];
    if (playerError) {
        return NO;
    }
    _audioPlayer.delegate = self;
    
    if (![_audioPlayer prepareToPlay]) {
        NSLog(@"no prepare to play now");
        return NO;
    }
    if (![_audioPlayer play]) {
        return NO;
    }
    return YES;
}

#pragma mark -- play delegate

/* audioPlayerDidFinishPlaying:successfully: is called when a sound has finished playing. This method is NOT called if the player is stopped due to an interruption. */
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"lt- flag :%d",flag);
}

/* if an error occurs while decoding it will be reported to the delegate. */
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error {
    NSLog(@"lt- decode error :%@",error);
}

@end
