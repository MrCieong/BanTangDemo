//
//  BTHotRecommendFooter.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/19.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTHotRecommendFooter.h"

@interface BTHotRecommendFooter ()
@property (weak, nonatomic) IBOutlet UIImageView *loadingImageView;

@end

@implementation BTHotRecommendFooter

- (void)awakeFromNib {
  [super awakeFromNib];
  self.loadingImageView.hidden = YES;
}

- (void)startLoading {
  self.loadingImageView.hidden = NO;
  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
  animation.fromValue = 0;
  animation.toValue = @(2.0 * M_PI);
  animation.duration = 1.;
  animation.repeatCount = MAXFLOAT;
  
  [self.loadingImageView.layer addAnimation:animation forKey:nil];
}

- (void)stopLoading {
  self.loadingImageView.hidden = YES;
  [self.loadingImageView.layer removeAllAnimations];
}

@end
