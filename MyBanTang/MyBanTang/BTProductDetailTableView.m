//
//  BTProductDetailTableView.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/25.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTProductDetailTableView.h"

@implementation BTProductDetailTableView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  UIView *hitView =  [super hitTest:point withEvent:event];
  
  for (UIView *view in hitView.subviews) {
    if ([view isEqual:self]) {
      return nil;
    }
  }
  
  return hitView;
}

@end
