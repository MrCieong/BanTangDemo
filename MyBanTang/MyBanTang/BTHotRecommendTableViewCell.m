//
//  BTHotRecommendTableViewCell.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/23.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTHotRecommendTableViewCell.h"
#import "Constant.h"
#import "UIView+frameAdjust.h"
#import "BTHelper.h"
#import "BTCommunityPostInfo.h"
#import "UIImageView+YYWebImage.h"
#import "BTUser.h"
#import <XHTagView/XHTagView.h>
#import "MJExtension.h"
#import "BTRelatedLinkView.h"

static const CGFloat kAvatarViewHeight = 50.0;
static const CGFloat kTagsViewHeight = 20;

//static const CGFloat kRelatedLinkHeight = 65;
static const CGFloat kCommentButtonHeight = 25;
static const CGFloat kLikesButtonHeight = 15;

static const CGFloat kSmallPadding = 8;
static const CGFloat kPadding = 12;
static const CGFloat kLineSpaceing = 8;
static const CGFloat kUserIconHeight = 34;
static const CGFloat kSeparatorViewHeight = 8;

@interface BTHotRecommendTableViewCell () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *userImageView;
@property (nonatomic, strong) UILabel *nikeNameLabel;
@property (nonatomic, strong) UILabel *createTimeLabel;

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *imagesScrollView;

@property (nonatomic, strong) UIButton *commentsButton;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UIButton *shareButton;

@property (nonatomic, strong) UIImageView *fristDivideImageView;

@property (nonatomic, strong) UIView *tagsView;
@property (nonatomic, strong) UIImageView *tagsImageView;
@property (nonatomic, strong) UILabel *tagsLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIView *relatedLinkView;

@property (nonatomic, strong) UIButton *likesButton;
@property (nonatomic, strong) UILabel *commentsLabel;
@property (nonatomic, strong) UIImageView *secondDivideImageView;
@property (nonatomic, strong) UIImageView *yourImgIconImageView;
@property (nonatomic, strong) UIButton *commentButton;

@property (nonatomic, strong) UIView *separatorView;

@end

@implementation BTHotRecommendTableViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      [self commonSetup];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self commonSetup];
  }
  
  return self;
}

- (void)commonSetup {
  _userImageView = [UIImageView new];
  _userImageView.layer.cornerRadius = kUserIconHeight / 2.0;
  _userImageView.clipsToBounds = YES;
  
  
  _nikeNameLabel = [UILabel new];
  _nikeNameLabel.font = [UIFont systemFontOfSize:15];
  
  _createTimeLabel = [UILabel new];
  _createTimeLabel.font = [UIFont systemFontOfSize:14];
  _createTimeLabel.textColor = [UIColor lightGrayColor];
  
  
  _imagesScrollView = [[UIScrollView alloc] init];
  _imagesScrollView.showsHorizontalScrollIndicator = NO;
  _imagesScrollView.showsVerticalScrollIndicator = NO;
  _imagesScrollView.pagingEnabled = YES;
  _imagesScrollView.delegate = self;
  
  _pageControl = [[UIPageControl alloc] init];
  _pageControl.hidden = YES;
  
  _commentsButton = [UIButton new];
  [_commentsButton setImage:[UIImage imageNamed:@"btn_group_comment"] forState:UIControlStateNormal];
  [_commentButton addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
  
  _likeButton = [UIButton new];
  [_likeButton setImage:[UIImage imageNamed:@"btn_group_like"] forState:UIControlStateNormal];
  [_likeButton addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
  [_likeButton setImage:[UIImage imageNamed:@"btn_group_like_selected"] forState:UIControlStateSelected];
  
  _shareButton = [UIButton new];
  [_shareButton addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
  [_shareButton setImage:[UIImage imageNamed:@"btn_group_share"] forState:UIControlStateNormal];
  
  _fristDivideImageView = [UIImageView new];
  _fristDivideImageView.image = [UIImage imageNamed:@"line_product_detail"];
  
  _tagsView = [UIView new];
  _tagsView.clipsToBounds = YES;
  _tagsImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"community_tag"]];
  _tagsLabel = [UILabel new];
  _tagsLabel.textColor = BTGobalRedColor;
  _tagsLabel.font = [UIFont systemFontOfSize:12];
  [_tagsView addSubview:_tagsImageView];
  [_tagsView addSubview:_tagsLabel];
  
  
  _contentLabel = [UILabel new];
  _contentLabel.font = [BTHotRecommendTableViewCell contentFont];
  _contentLabel.textColor = BTGobalTextContentColor;
  _contentLabel.numberOfLines = 0;
  
  _relatedLinkView = [UIView new];
  _relatedLinkView.hidden = YES;
  
  _likesButton = [UIButton new];
  [_likesButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
  _likesButton.titleLabel.font = [BTHotRecommendTableViewCell contentFont];
  
  
  _commentsLabel = [UILabel new];
  _commentsLabel.font = [BTHotRecommendTableViewCell contentFont];
  _commentsLabel.textColor = [UIColor grayColor];
  _commentsLabel.text = @"评论";
  
  _secondDivideImageView = [UIImageView new];
  _secondDivideImageView.image = [UIImage imageNamed:@"line_product_detail"];
  
  _yourImgIconImageView = [UIImageView new];
  _yourImgIconImageView.layer.cornerRadius = kUserIconHeight / 2.0;
  
  _commentButton = [UIButton new];
  UIImage *commentinputBG = [UIImage imageNamed:@"community_commnetinput_bg"];
  CGFloat w = commentinputBG.size.width / 2;
  CGFloat h = commentinputBG.size.height /2;
  [_commentButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
  [_commentButton setBackgroundImage:[commentinputBG resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)] forState:UIControlStateNormal];
  _commentButton.titleLabel.font = [UIFont systemFontOfSize:15];
  [_commentButton addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
  [_commentButton setTitle:@"我来说两句" forState:UIControlStateNormal];
  
  _separatorView = [UIView new];
  _separatorView.backgroundColor = BTGobalTableViewBGColor;
  
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];
  
  [self.contentView addSubview:self.userImageView];
  [self.contentView addSubview:self.nikeNameLabel];
  [self.contentView addSubview:self.createTimeLabel];
  
  
  [self.contentView addSubview:self.imagesScrollView];
  [self.contentView addSubview:self.pageControl];
  [self.contentView addSubview:self.commentsButton];
  [self.contentView addSubview:self.likeButton];
  [self.contentView addSubview:self.shareButton];
  [self.contentView addSubview:self.fristDivideImageView];
  [self.contentView addSubview:self.tagsView];
  [self.contentView addSubview:self.contentLabel];
  [self.contentView addSubview:self.relatedLinkView];
  [self.contentView addSubview:self.likesButton];
  [self.contentView addSubview:self.commentsLabel];
  [self.contentView addSubview:self.secondDivideImageView];
  [self.contentView addSubview:self.yourImgIconImageView];
  [self.contentView addSubview:self.commentButton];
  [self.contentView addSubview:self.separatorView];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.userImageView.frame = CGRectMake(kSmallPadding, kSmallPadding, kUserIconHeight, kUserIconHeight);
  [self.nikeNameLabel sizeToFit];
  self.nikeNameLabel.center = self.userImageView.center;
  self.nikeNameLabel.x = self.userImageView.right + kSmallPadding;
  
  [self.createTimeLabel sizeToFit];
  self.createTimeLabel.center = self.userImageView.center;
  self.createTimeLabel.x = kScreen_Width - self.createTimeLabel.width - kSmallPadding;
  
  self.imagesScrollView.frame = CGRectMake(0, kAvatarViewHeight, kScreen_Width, kScreen_Width);
  
  self.pageControl.width = 100;
  self.pageControl.height = 10;
  self.pageControl.center = self.imagesScrollView.center;
  self.pageControl.y = self.imagesScrollView.tail - 20;
  
  
  
  self.commentsButton.frame = CGRectMake(kPadding, self.imagesScrollView.tail + kPadding, kCommentButtonHeight, kCommentButtonHeight);
  
  self.likeButton.frame = CGRectMake(self.commentsButton.right + kPadding, self.commentsButton.y, kCommentButtonHeight, kCommentButtonHeight);
  
  self.shareButton.frame = CGRectMake(self.likeButton.right +kPadding, self.commentsButton.y, kCommentButtonHeight, kCommentButtonHeight);

  self.fristDivideImageView.frame = CGRectMake(kSmallPadding, self.commentsButton.tail + kPadding - 1, kScreen_Width - 2 * kSmallPadding, 1);
  
  CGFloat tagsViewHeight = self.postInfo.tags.count > 0 ? kSmallPadding + kTagsViewHeight : 0;
  self.tagsView.frame = CGRectMake(0, self.fristDivideImageView.tail, kScreen_Width, tagsViewHeight);
  _tagsImageView.x = kSmallPadding;
  _tagsImageView.y = kSmallPadding;
  [_tagsImageView sizeToFit];
  
  _tagsLabel.x = _tagsImageView.right +kSmallPadding;
  _tagsLabel.y = kSmallPadding;
  [_tagsLabel sizeToFit];
  
  
  CGPoint tagsImageViewCenter = _tagsImageView.center;
  tagsImageViewCenter.y = _tagsLabel.center.y;
  _tagsImageView.center = tagsImageViewCenter;
  
  
  self.contentLabel.frame = CGRectMake(kSmallPadding, self.tagsView.tail +kSmallPadding, kScreen_Width - 2 * kSmallPadding, kCommentButtonHeight);
  [self.contentLabel sizeToFit];

  CGFloat relatedLinkHeight = 0;
  self.relatedLinkView.frame = CGRectMake(kSmallPadding, self.contentLabel.tail, kScreen_Width, relatedLinkHeight);
  
  [self.likesButton sizeToFit];
  self.likesButton.height = kLikesButtonHeight;
  self.likesButton.x = kSmallPadding;
  self.likesButton.y = self.relatedLinkView.tail + kSmallPadding;

  [self.commentsLabel sizeToFit];
  self.commentsLabel.x = kSmallPadding;
  self.commentsLabel.y = self.likesButton.tail + kSmallPadding;

  self.secondDivideImageView.frame = CGRectMake(kSmallPadding, self.commentsLabel.tail + kSmallPadding - 1, kScreen_Width - 2 * kSmallPadding, 1);

  self.yourImgIconImageView.frame = CGRectMake(kSmallPadding, self.secondDivideImageView.tail + kSmallPadding, kUserIconHeight, kUserIconHeight);
  self.commentButton.width = kScreen_Width - self.yourImgIconImageView.right - 2 * kSmallPadding ;
  self.commentButton.height = kUserIconHeight;
  self.commentButton.center = self.yourImgIconImageView.center;
  self.commentButton.x = self.yourImgIconImageView.right + kSmallPadding;
  
  self.separatorView.frame = CGRectMake(0, self.yourImgIconImageView.tail + kSmallPadding, kScreen_Width, kSeparatorViewHeight);
  
}

- (void)prepareForReuse {
  
  self.pageControl.currentPage = 0;
  self.pageControl.hidden = YES;
  self.relatedLinkView.hidden = YES;
  self.imagesScrollView.contentSize = CGSizeMake(0, 0);
  [self.imagesScrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
    [view removeFromSuperview];
  }];
  _tagsLabel.text = @"";
}

#pragma mark - Setter & Getter
- (void)setPostInfo:(BTCommunityPostInfo *)postInfo {
  _postInfo = postInfo;
  [self.userImageView yy_setImageWithURL:[NSURL URLWithString:postInfo.author.avatar] placeholder:[UIImage imageNamed:@"default_icon_placehodler"]];
  
  self.nikeNameLabel.text = postInfo.author.nickname;
  self.createTimeLabel.text = postInfo.datestr;
  
  NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
  style.lineSpacing = kLineSpaceing;
  self.contentLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:postInfo.content attributes:@{NSParagraphStyleAttributeName : style}];
  
  [self.likesButton setTitle:[NSString stringWithFormat:@" %@人喜欢", postInfo.dynamic[@"likes"]] forState:UIControlStateNormal];
  [self.likesButton setImage:[UIImage imageNamed:@"community_like"] forState:UIControlStateNormal];
  self.yourImgIconImageView.image = [UIImage imageNamed:@"default_icon_placehodler"];
  
  for (int i = 0; i < self.postInfo.pics.count; i++) {
    NSDictionary *dict = self.postInfo.pics[i];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kScreen_Width, 0, kScreen_Width, kScreen_Width)];
    [imageView yy_setImageWithURL:[NSURL URLWithString:dict[@"url"]] options:YYWebImageOptionSetImageWithFadeAnimation];
    NSString *tagsString = dict[@"tags"];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:[tagsString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    for (NSDictionary *tagDict in array) {
      NSString *x = tagDict[@"x"];
      NSString *y = tagDict[@"y"];
      NSString *text1 = tagDict[@"text1"];
      NSString *text2 = tagDict[@"text2"];
      NSString *text3 = tagDict[@"text3"];
      
      NSMutableArray *texts = [NSMutableArray new];
      if (text1) [texts addObject:text1];
      if (text2) [texts addObject:text2];
      if (text3) [texts addObject:text3];
      
      XHTagView *tagView = [[XHTagView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width)];
      [imageView addSubview:tagView];
      tagView.branchTexts = texts;
      [tagView showInPoint:CGPointMake([x floatValue] * kScreen_Width, [y floatValue]* kScreen_Width)];
      
      [tagView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedTagView:)]];
      
    }
    
    [self.imagesScrollView addSubview:imageView];
  }
  
  NSMutableString *tagsString = [NSMutableString new];
  for (NSDictionary *tag in postInfo.tags) {
   
    if (tag[@"name"]) {
      [tagsString appendFormat:@"%@  ", tag[@"name"]];
    }
  }
  
  if (tagsString.length > 0) {
    _tagsLabel.text = tagsString;
  }
  
//  if (postInfo.product.count > 0) {
//    self.relatedLinkView.hidden = NO;
//    self.relatedLinkView.product = postInfo.product.lastObject;
//  }
  
  
  if (self.postInfo.pics.count > 1) {
    self.pageControl.hidden = NO;
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = self.postInfo.pics.count;
  }
  
  self.imagesScrollView.contentSize = CGSizeMake(self.postInfo.pics.count * kScreen_Width, kScreen_Width);
  
}


#pragma mark - Calculate Height
+ (CGFloat)cellHeightWithPostInfo:(BTCommunityPostInfo *)postInfo {
  if (postInfo.height > 100) {
    return postInfo.height;
  } else {
    CGFloat kImageViewHeight = kScreen_Width + 50;
    CGFloat kContentViewHeight = [BTHelper getTextHeightWithText:postInfo.content font:[self contentFont] width:kScreen_Width - 2 * kSmallPadding lineSpace:kLineSpaceing];
    CGFloat kCommentsLabelHeight = [BTHelper getTextHeightWithText:@"评论" font:[BTHotRecommendTableViewCell contentFont] width:kScreen_Width - 2 *kSmallPadding];
    
    CGFloat tagsViewHeight = postInfo.tags.count > 0 ? kSmallPadding + kTagsViewHeight : 0;
    CGFloat relatedLinkHeight =  0;
    
    CGFloat height = kAvatarViewHeight + kImageViewHeight + tagsViewHeight + kSmallPadding + kContentViewHeight + kSmallPadding + relatedLinkHeight + kLikesButtonHeight + kSmallPadding + kCommentsLabelHeight + kSmallPadding - 1 + kSmallPadding + kUserIconHeight + kSmallPadding + kSeparatorViewHeight;
    postInfo.height = height;
    return height;
  }
  
 
}

+ (CGFloat)avatarHeight {
  return 50;
}

+ (UIFont *)contentFont {
  return [UIFont systemFontOfSize:15];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  self.pageControl.currentPage = (kScreen_Width / 2 + scrollView.contentOffset.x ) / kScreen_Width;
}


#pragma mark - Action
- (void)tappedTagView:(UITapGestureRecognizer *)gesture {
  if ([gesture.view isKindOfClass:[XHTagView class]]) {
    XHTagView *tagView = (XHTagView *)gesture.view;
    if ([tagView showing]) {
      [tagView dismiss];
    } else {
      [UIView animateWithDuration:0.3 animations:^{
        tagView.alpha = 1;
      }];
    }
  }
}

- (void)tapAction {
  if ([self.delegate respondsToSelector:@selector(tapAction)]) {
    [self.delegate tapAction];
  }
}

@end
