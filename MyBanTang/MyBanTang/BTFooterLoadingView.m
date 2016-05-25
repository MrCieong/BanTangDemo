//
//  FooterLoadingView.m
//  BangTangDemo
//
//  Created by zhangjing on 16/5/12.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTFooterLoadingView.h"


static const float kAnimationImageViewWidth = 20.0;
@interface BTFooterLoadingView ()

@property (nonatomic, strong) UIImageView *animationImageView;

@end

@implementation BTFooterLoadingView

- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];
  [self addSubview:self.animationImageView];
}

- (UIImageView *)animationImageView {
  if (!_animationImageView) {
    _animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kAnimationImageViewWidth, kAnimationImageViewWidth)];
    _animationImageView.center = self.center;
    _animationImageView.image = [UIImage imageNamed:@"loading_small"];
    _animationImageView.hidden = YES;
  }
  return _animationImageView;
}

- (void)startLoading {
  self.animationImageView.hidden = NO;
  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
  animation.fromValue = 0;
  animation.toValue = @(M_PI * 2);
  animation.duration = 0.5;
  animation.repeatCount = HUGE;
  [self.animationImageView.layer addAnimation:animation forKey:@"rotationAnimation"];
}

- (void)stopLoading {
  self.animationImageView.hidden = YES;
  [self.animationImageView.layer removeAllAnimations];
}

@end
