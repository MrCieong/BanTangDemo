//
//  BTProductListCell.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/23.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTProductListCell.h"
#import "BTTopic.h"
#import "UIImageView+YYWebImage.h"

const NSString *kBTProductListCellIdentifier = @"BTProductListCell";
@interface BTProductListCell()
@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@end

@implementation BTProductListCell

- (void)setTopic:(BTTopic *)topic {
  _topic = topic;
  [self.topicImageView yy_setImageWithURL:[NSURL URLWithString:topic.pic] placeholder:[UIImage imageNamed:@"default_image"] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation  completion:nil];
  self.topicLabel.text = topic.title;
  [self.likeButton setTitle:[NSString stringWithFormat:@"❤︎ %@", topic.likes] forState:UIControlStateNormal];
}

@end
