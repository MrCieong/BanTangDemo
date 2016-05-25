//
//  LoadingView.m
//  BangTangDemo
//
//  Created by zhangjing on 16/5/12.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTLoadingView.h"

@interface BTLoadingView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation BTLoadingView

+ (instancetype)loadingViewToView:(UIView *)toView {
  id loadingView = [[self alloc] initWithFrame:CGRectMake(0, 0, 52.5, 9)];
  ((UIView *)loadingView).center = toView.center;
  [toView addSubview:loadingView];
  return loadingView;
}


- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];
  [self addSubview:self.imageView];
}

- (UIImageView *)imageView {
  if (!_imageView) {
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _imageView.image = [UIImage animatedImageNamed:@"loading" duration:1];
  }
  return _imageView;
}


@end
