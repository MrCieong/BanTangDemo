//
//  BTTopicsCell.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/20.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTTopicsCell.h"
#import "BTTopic.h"
#import "BTUser.h"
#import "UIImageView+YYWebImage.h"

@interface BTTopicsCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pic1ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *pic2ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *pic3ImageView;
@property (weak, nonatomic) IBOutlet UIButton *viewsButton;
@property (weak, nonatomic) IBOutlet UIButton *commentsButton;

@end

@implementation BTTopicsCell



- (void)prepareForReuse {
  [super prepareForReuse];
  self.pic1ImageView.image = nil;
  self.pic2ImageView.image = nil;
  self.pic3ImageView.image = nil;
}

- (void)setTopic:(BTTopic *)topic {
  _topic = topic;
  self.titleLabel.text = topic.title;
  [self.userImageView  yy_setImageWithURL:[NSURL URLWithString:topic.user.avatar] options:YYWebImageOptionSetImageWithFadeAnimation];
  self.nickNameLabel.text = topic.user.nickname;
  self.timeLabel.text = [NSString stringWithFormat:@"|  %@", topic.orderTimeStr];
  [self.viewsButton setTitle:topic.views forState:UIControlStateNormal];
  [self.viewsButton setImage:[UIImage imageNamed:@"home_article_views"] forState:UIControlStateNormal];
  
  [self.commentsButton setTitle:topic.comments forState:UIControlStateNormal];
  [self.commentsButton setImage:[UIImage imageNamed:@"home_article_comments"] forState:UIControlStateNormal];
  
  NSDictionary *url1Dict = topic.pics[0];
  NSString *url1String = url1Dict[@"url"];
  
  NSDictionary *url2Dict = topic.pics[1];
  NSString *url2String = url2Dict[@"url"];
  
  NSDictionary *url3Dict = topic.pics[1];
  NSString *url3String = url3Dict[@"url"];
  
  [self.pic1ImageView  yy_setImageWithURL:[NSURL URLWithString:url1String] options:YYWebImageOptionSetImageWithFadeAnimation];
  [self.pic2ImageView  yy_setImageWithURL:[NSURL URLWithString:url2String] options:YYWebImageOptionSetImageWithFadeAnimation];
  [self.pic3ImageView  yy_setImageWithURL:[NSURL URLWithString:url3String] options:YYWebImageOptionSetImageWithFadeAnimation];
  
}
@end
