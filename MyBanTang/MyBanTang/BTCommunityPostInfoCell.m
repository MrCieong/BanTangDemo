//
//  BTCommuntiyPostInfoCell.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/20.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTCommunityPostInfoCell.h"
#import "BTCommunityPostInfo.h"
#import "UIImageView+YYWebImage.h"

@interface BTCommunityPostInfoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;

@property (weak, nonatomic) IBOutlet UIImageView *userIconImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *likesButton;

@end

@implementation BTCommunityPostInfoCell

- (void)prepareForReuse {
  [super prepareForReuse];
  self.userIconImageView.image = nil;
  self.picImageView.image = nil;
}

- (void)setPostInfo:(BTCommunityPostInfo *)postInfo {
  _postInfo = postInfo;
  self.userNameLabel.text = postInfo.authorId;
  self.contentLabel.text = postInfo.content;
  self.userIconImageView.image = [UIImage imageNamed:@"default_icon_placehodler"];
  
  [self.picImageView yy_setImageWithURL:[NSURL URLWithString:postInfo.miniPicUrl] options:YYWebImageOptionSetImageWithFadeAnimation];
  
}

@end
