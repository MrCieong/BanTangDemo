//
//  ZJScrollTitleView.m
//  ScrollTitleView
//
//  Created by zhangjing on 16/5/23.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "ZJScrollTitleView.h"
#import "UIView+frameAdjust.h"
#import "Constant.h"


@interface ZJScrollTitleView ()


@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *labels;
@property (nonatomic, strong) UIView *underBarView;
@property (nonatomic, strong) UIColor *normalStateColor;

@end

static const CGFloat kPadding = 20;
static const CGFloat kSmallPadding = 10;
static const int kBaseTag = 523;
static const CGFloat kUnderBarWidth = 30;
static const CGFloat kUnderBarHeight = 3;
@implementation ZJScrollTitleView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonSetup];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonSetup];
  }
  return self;
}

- (void)commonSetup {
  self.scrollView = [UIScrollView new];
  [self addSubview:self.scrollView];
  self.scrollView.showsHorizontalScrollIndicator = NO;
  self.scrollView.showsVerticalScrollIndicator = NO;
  self.tintColor = BTGobalRedColor;
  self.normalStateColor = [UIColor lightGrayColor];
  self.underBarView = [UIView new];
  
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.scrollView.frame = self.bounds;
  
  
  UILabel *lastLabel;
  for (UILabel *label in self.labels) {
    label.x = lastLabel ? lastLabel.right + kPadding : kSmallPadding;
    label.y = kSmallPadding;
    [label sizeToFit];
    lastLabel = label;
  }
  
  self.scrollView.contentSize = CGSizeMake(lastLabel.right + kPadding, self.height);
  
  if (self.labels.count > 0) {
    UILabel *firstLabe = self.labels.firstObject;
    self.underBarView.frame = CGRectMake(0, self.scrollView.tail - kUnderBarHeight, kUnderBarWidth, kUnderBarHeight);
    CGPoint tmpCenter = self.underBarView.center;
    tmpCenter.x = firstLabe.center.x;
    self.underBarView.center = tmpCenter;
    self.underBarView.backgroundColor = self.tintColor;
  }

}

- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];
}

- (void)setTitles:(NSArray *)titles {
  _titles = titles;
  
  NSMutableArray *tmpLabels = [NSMutableArray new];
  
  [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    [obj removeFromSuperview];
  }];
  [self.scrollView addSubview:self.underBarView];
  for (int i = 0; i < self.titles.count; i++) {
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = self.normalStateColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.titles[i];
    label.tag = kBaseTag + i;
    label.userInteractionEnabled = YES;
    
    [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    [self.scrollView addSubview:label];
    [tmpLabels addObject:label];
  }
  self.labels = tmpLabels;
}

- (void)tapAction:(UIGestureRecognizer *)gestureRecognizer {
  UILabel *label = (UILabel *)gestureRecognizer.view;
  
  [self switchToLabel:label];
  
  if ([self.delegate respondsToSelector:@selector(didSelectedTitleLabelIndex:)]) {
    [self.delegate didSelectedTitleLabelIndex:(int)label.tag - kBaseTag];
  }
}

- (void)switchToLabel:(UILabel *)label {
  
  CGFloat offsetX = label.center.x - self.scrollView.center.x;
  CGFloat maxOffsetX = self.scrollView.contentSize.width - self.scrollView.width;
  if (offsetX < 0) {
    offsetX = 0;
  } else if (offsetX > maxOffsetX) {
    offsetX = maxOffsetX;
  }
  [UIView animateWithDuration:0.2 animations:^{
    self.scrollView.contentOffset = CGPointMake(offsetX, 0);
  }];
  
  
  
  [self.labels enumerateObjectsUsingBlock:^(UILabel *lab, NSUInteger idx, BOOL * _Nonnull stop) {
    lab.transform = CGAffineTransformIdentity;
    lab.textColor =  self.normalStateColor;
  }];
  
  
  CGPoint tmpCenter = self.underBarView.center;
  tmpCenter.x = label.center.x;
  [UIView animateWithDuration:0.3 animations:^{
    self.underBarView.center = tmpCenter;
    label.transform = CGAffineTransformMakeScale(1.1, 1.1);
    label.textColor = self.tintColor;
  }];
}

@end
