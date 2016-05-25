//
//  BTCategoryCell.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/20.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTCategoryCell.h"
#import "UIImageView+YYWebImage.h"
#import "BTCategory.h"


@interface BTCategoryCell ()
@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView;

@end

@implementation BTCategoryCell

#pragma mark - Setter & Getter
- (void)setCategory:(BTCategory *)category {
  _category = category;
//  self.categoryImageView.clipsToBounds
  [self.categoryImageView yy_setImageWithURL:[NSURL URLWithString:category.pic] options:YYWebImageOptionSetImageWithFadeAnimation];
}

@end
