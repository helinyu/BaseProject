//
//  BPRecordAudioMgr.h
//  BaseProject_OC
//
//  Created by Aka on 2018/11/19.
//  Copyright © 2018 Aka. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPRecordAudioMgr : NSObject

+ (instancetype)shared;

- (BOOL)startRecordAudio;
- (void)pauseRecordAudio;
- (void)stopRecordAudio;

typedef void(^FinishBlock)(NSURL *pathUrl);
@property (nonatomic, copy) FinishBlock stopBlock;

@end

NS_ASSUME_NONNULL_END
