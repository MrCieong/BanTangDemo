//
//  UILabel+Extension.m
//  BanTang
//
//  Created by Ryan on 15/12/4.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

- (CGFloat)paragraphLabelHeightWithText:(NSString *)text
                               maxWidth:(CGFloat)maxWidth
                            lineSpacing:(CGFloat)lineSpacing
{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    [style setLineSpacing:lineSpacing];
    
    NSInteger leng = maxWidth;
    
    if (attStr.length < maxWidth)  leng = attStr.length;

    [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, leng)];
    
    self.attributedText = attStr;
    
    CGSize labelSize = [self sizeThatFits:CGSizeMake(maxWidth, MAXFLOAT)];
    
    return labelSize.height;
}

@end
