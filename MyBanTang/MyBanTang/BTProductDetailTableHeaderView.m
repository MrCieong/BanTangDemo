//
//  BTProductDetailTableHeaderView.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/25.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTProductDetailTableHeaderView.h"
#import "UIView+frameAdjust.h"
#import "Constant.h"

static const CGFloat kContentTextFontSize = 14;
//static const CGFloat kPadding = 12;

@interface BTProductDetailTableHeaderView ()
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *preiceLabel;
@property (nonatomic, strong) UIImageView *divideImageView;
@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation BTProductDetailTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      [self commonSetup];
    }
    return self;
}

- (void)commonSetup {
  _pageControl = [UIPageControl new];
  
  _titleLabel = [UILabel new];
  _titleLabel.textColor = BTGobalTextTitleColor;
  
  _preiceLabel = [UILabel new];
  _titleLabel.textColor = BTGobalRedColor;
  _divideImageView = [UIImageView new];
  _contentLabel = [UILabel new];
  _contentLabel.textColor = BTGobalTextContentColor;
  _contentLabel.font = [UIFont systemFontOfSize:kContentTextFontSize];
  _contentLabel.numberOfLines = 0;
  
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];
  [self addSubview:_pageControl];
  [self addSubview:_titleLabel];
  [self addSubview:_preiceLabel];
  [self addSubview:_divideImageView];
  [self addSubview:_contentLabel];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
}

@end
