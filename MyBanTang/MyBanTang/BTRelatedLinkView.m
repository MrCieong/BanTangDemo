//
//  BTRelatedLinkView.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/25.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTRelatedLinkView.h"
#import "UIView+frameAdjust.h"
#import "Constant.h"
#import "UIImageView+YYWebImage.h"
#import "BTProduct.h"

@interface BTRelatedLinkView ()
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *fromWebsitIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *fromWebsitLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation BTRelatedLinkView

+ (instancetype)instanceView{
  return [[NSBundle mainBundle] loadNibNamed:@"BTRelatedLinkView" owner:nil options:nil].firstObject;
}


#pragma mark - Setter
- (void)setProduct:(BTProduct *)product {
  _product = product;
  
//  [self.productImageView yy_setImageWithURL:[NSURL URLWithString:product.pic] placeholder:[UIImage imageNamed:@"default_icon_placehodler"]];
  self.productTitleLabel.text = product.title;
  self.priceLabel.text = product.price;
  if ([product.url containsString:@"taobao"]) {
    self.fromWebsitLabel.text = @"淘宝";
    self.fromWebsitIconImageView.image = [UIImage imageNamed:@"community_taobao"];
  } else if ([product.url containsString:@"jd"]) {
    self.fromWebsitLabel.text = @"京东";
    self.fromWebsitIconImageView.image = [UIImage imageNamed:@"community_jingdong"];
  } else if ([product.url containsString:@"tmall"]) {
    self.fromWebsitLabel.text = @"天猫";
    self.fromWebsitIconImageView.image = [UIImage imageNamed:@"community_tianmao"];
  }
  
}

@end
