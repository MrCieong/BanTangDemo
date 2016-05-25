//
//  BTHotRecommendCell.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/19.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTHotRecommendCell.h"
#import "UIImageView+YYWebImage.h"
#import "UIView+frameAdjust.h"

@interface BTHotRecommendCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation BTHotRecommendCell
- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
     _imageView = [UIImageView new];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  _imageView.x = 0;
  _imageView.y = 0;
  _imageView.width = self.width;
  _imageView.height = self.height;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];
 
  [self.contentView addSubview:_imageView];
}


- (void)setImageURLString:(NSString *)imageURLString {
  _imageURLString = imageURLString;
  
  [_imageView yy_setImageWithURL:[NSURL URLWithString:imageURLString] options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation];
  
}
@end
