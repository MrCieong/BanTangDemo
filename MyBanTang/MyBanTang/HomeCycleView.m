//
//  HomeCycleView.m
//  BangTangDemo
//
//  Created by zhangjing on 16/5/11.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "HomeCycleView.h"
#import "YYWebImage.h"
#import "SDCycleScrollView.h"

@interface HomeCycleView () <SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end

@implementation HomeCycleView


#pragma mark - Cycle Life
- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];
  [self addSubview:self.cycleScrollView];
  
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.cycleScrollView.frame = self.bounds;
}


#pragma mark - Getter & Setter
- (void)setBanners:(NSArray *)banners {
  _banners = banners;
  [self setupCycleScrollViewImagesWith:banners];
}

- (void)setupCycleScrollViewImagesWith:(NSArray *)banners {
  NSMutableArray *imageURLStrings = [NSMutableArray new];
  for (BTBanner *banner in banners) {
    [imageURLStrings addObject:banner.photo];
  }
  self.cycleScrollView.imageURLStringsGroup = imageURLStrings;
}


- (SDCycleScrollView *)cycleScrollView {
  if (!_cycleScrollView) {
    _cycleScrollView = [SDCycleScrollView new];
    _cycleScrollView.delegate = self;
    _cycleScrollView.backgroundColor = [UIColor clearColor];
  }
  return _cycleScrollView;
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
  if ([self.delegate respondsToSelector:@selector(didSelectedBanner:)]) {
    BTBanner *banner = self.banners[index];
    [self.delegate didSelectedBanner:banner];
  }
  
}

@end
