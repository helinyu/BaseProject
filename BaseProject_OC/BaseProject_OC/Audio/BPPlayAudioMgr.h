//
//  BPPlayAudioMgr.h
//  BaseProject_OC
//
//  Created by Aka on 2018/11/19.
//  Copyright © 2018 Aka. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPPlayAudioMgr : NSObject

+ (instancetype)shared;

- (BOOL)playWtihUrl:(NSURL *)pathUrl;

@end

NS_ASSUME_NONNULL_END
