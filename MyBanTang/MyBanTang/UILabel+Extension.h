//
//  UILabel+Extension.h
//  BanTang
//
//  Created by Ryan on 15/12/4.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)
/**
 *  设置段落标签,返回高度
 *
 *  @param text        文字
 *  @param maxWidth    文字最大的宽度
 *  @param lineSpacing 行间距
 *  @param label       标签
 *
 *  @return 段落标签高度
 */
- (CGFloat)paragraphLabelHeightWithText:(NSString *)text
                               maxWidth:(CGFloat)maxWidth
                            lineSpacing:(CGFloat)lineSpacing;
@end
