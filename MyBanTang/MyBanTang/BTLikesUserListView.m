//
//  BTLikesUserListView.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/18.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTLikesUserListView.h"
#import "UIView+frameAdjust.h"
#import "UIButton+YYWebImage.h"
#import "Constant.h"
#import "BTHelper.h"

static NSString *kImageBaseURL = @"http://7te7t9.com2.z0.glb.qiniucdn.com/";
static const CGFloat kButtonWidth = 27;
static const CGFloat kButtonHeight = 27;
static const CGFloat kPadding = 12.0;
static const CGFloat kSmallPadding = 8.0;
static const CGFloat kArrowButtonWidth = 18;
static const CGFloat kArrowButtonHeight = 27;

@interface BTLikesUserListView ()

@property (nonatomic, strong) NSArray *likesList;
@property (nonatomic, copy) NSString *likes;

@property (nonatomic, strong) UILabel *likesLabel;
@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, strong) UIButton *arrowButton;

@end
@implementation BTLikesUserListView

- (instancetype)initWithFrame:(CGRect)frame likesList:(NSArray *)likesList likesString:(NSString *)likesString {
  self = [super initWithFrame:frame];
  if (self) {
    _likesList = likesList;
    _likes = likesString;
    [self commonSetup];
  }
  return self;
}

- (void)commonSetup {
  
  _likesLabel = [UILabel new];
  _likesLabel.textColor = [UIColor lightGrayColor];
  _likesLabel.font = [UIFont systemFontOfSize:10];
  _likesLabel.text = [NSString stringWithFormat:@"%@人喜欢", _likes];
  [self addSubview:_likesLabel];
  
  _arrowButton = [UIButton new];
  [_arrowButton setImage:[UIImage imageNamed:@"subject_arrow_right"] forState:UIControlStateNormal];
  [self addSubview:_arrowButton];
  
  NSMutableArray *buttons = [NSMutableArray new];
  int maxCount = MIN(_likesList.count, floor((kScreen_Width - 3 * kPadding - kArrowButtonWidth) / (kButtonWidth + kSmallPadding)));
  for (int i = 0; i < maxCount; i++ ) {
    NSDictionary *likesDict = _likesList[i];
    NSString *imagePath = likesDict[@"a"];
    NSString *uID = likesDict[@"u"];
    UIButton *btn = [UIButton new];
    btn.tag = uID.integerValue;
    [btn yy_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kImageBaseURL, imagePath]] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"default_icon_placehodler"]];
    [buttons addObject:btn];
    btn.layer.cornerRadius = kButtonHeight / 2.0;
    btn.clipsToBounds = YES;
    [self addSubview:btn];
  }
  _buttons = buttons;
  
}

- (void)layoutSubviews {
  [super layoutSubviews];
  _likesLabel.x = kPadding;
  _likesLabel.y = kSmallPadding;
  [_likesLabel sizeToFit];
  
  UIButton *lastBtn = nil;
  for (UIButton *btn in _buttons) {
    
    btn.x = lastBtn == nil ? kPadding : lastBtn.right + kSmallPadding;
    btn.y = _likesLabel.tail + kSmallPadding;
    btn.width = kButtonWidth;
    btn.height = kButtonHeight;
    
    lastBtn = btn;
  }
  
  _arrowButton.x = self.width - kPadding - kArrowButtonWidth;
  _arrowButton.y = _likesLabel.tail + kSmallPadding;
  _arrowButton.width = kArrowButtonWidth;
  _arrowButton.height = kArrowButtonHeight;
  
}

+ (CGFloat)likesUserListViewHeight {
  return kSmallPadding + [self likesLabeHeight] + kSmallPadding + kArrowButtonHeight + kSmallPadding;
}

+ (CGFloat)likesLabeHeight {
  return [BTHelper getTextHeightWithText:@"aaaaa" font:[UIFont systemFontOfSize:10] width:MAXFLOAT];
}

@end
