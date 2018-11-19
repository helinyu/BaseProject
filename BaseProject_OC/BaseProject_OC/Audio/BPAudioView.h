//
//  BPAudioView.h
//  BaseProject_OC
//
//  Created by Aka on 2018/11/19.
//  Copyright © 2018 Aka. All rights reserved.
//

#import "BPBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPAudioView : BPBaseView

@property (nonatomic, strong, readonly) UITableView *tableView;

typedef void(^RecordingBlock)(BOOL isRecording);
@property (nonatomic, copy) RecordingBlock actionBlock;

@end

NS_ASSUME_NONNULL_END
