//
//  BPIMAudioTCell.m
//  BaseProject_OC
//
//  Created by Aka on 2018/11/19.
//  Copyright © 2018 Aka. All rights reserved.
//

#import "BPIMAudioTCell.h"
#import <Masonry/Masonry.h>

@interface BPIMAudioTCell ()

@property (nonatomic, strong) UIImageView  *iconImgView;
@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, strong) UILabel *textTextL;

@end

@implementation BPIMAudioTCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (void)baseInit {
    
    _iconImgView = [UIImageView new];
    _progressView = [UIView new];
    [self.contentView addSubview:_iconImgView];
    [self.contentView addSubview:_progressView];
    
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20.f);
        make.left.equalTo(self.contentView).offset(10.f);
        make.centerY.equalTo(self.contentView);
    }];
    _iconImgView.backgroundColor = [UIColor redColor];
    _iconImgView.image = [UIImage imageNamed:@"icon_im_audio"];
    
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_iconImgView.mas_right).offset(10.f);
        make.centerY.equalTo(self.contentView);
    }];
    _progressView.backgroundColor = [UIColor orangeColor];
    
    _textTextL = [UILabel new];
    [self addSubview:_textTextL];
    [_textTextL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

@end
