//
//  BTHelper.m
//  BanTangDemo
//
//  Created by zhangjing on 16/5/17.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTHelper.h"

@implementation BTHelper
+ (CGFloat)getTextHeightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width {
  NSDictionary *attributes = @{NSFontAttributeName : font};
  
  CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
  return CGRectGetHeight(rect);
  
}

+ (CGFloat)getTextHeightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width lineSpace:(CGFloat)lineSpacing {
  NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
  style.lineSpacing = lineSpacing;
  NSDictionary *attributes = @{NSFontAttributeName : font, NSParagraphStyleAttributeName : style};
  
  CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
  return CGRectGetHeight(rect);
  
}
@end
