//
//  BTHelper.h
//  BanTangDemo
//
//  Created by zhangjing on 16/5/17.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BTHelper : NSObject

+ (CGFloat)getTextHeightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width;
+ (CGFloat)getTextHeightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width lineSpace:(CGFloat)lineSpacing;

@end
