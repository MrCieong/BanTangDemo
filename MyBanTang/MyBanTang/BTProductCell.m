//
//  BTProductCell.m
//  BanTangDemo
//
//  Created by zhangjing on 16/5/17.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTProductCell.h"
#import "BTProduct.h"
#import "Constant.h"
#import "BTHelper.h"
#import "UIView+frameAdjust.h"
#import "UIImageView+YYWebImage.h"
#import "BTLikesUserListView.h"

#define kPadding 12.0
#define kPicWidth (kScreen_Width - 2 * kPadding)

static const NSString *kBTImageBaseURL = @"http://bt.img.17gwx.com/";

static const CGFloat kSmallPadding = 8.0;
static const CGFloat kDivideLineHeight = 0.5;
static const CGFloat kBuyButtonHeight = 37.0;
static const CGFloat kBuyButtonWidth = 100.0;
static const CGFloat kSepeatorHeight = 12.0;
static const CGFloat kParagraphLineSpace = 6.0;
static const CGFloat kRankImageViewHeight = 23.0;
static const CGFloat kRankImageViewWidth = 15.0;

@interface BTProductCell ()

@property (nonatomic, strong) UIImageView *rankImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) UIImageView *imageView3;
@property (nonatomic, strong) UIImageView *imageView4;

@property (nonatomic, strong, readwrite) NSArray *imageViews;
@property (nonatomic, strong, readwrite) NSArray *realImageViews;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UIView *fristDivideLine;
@property (nonatomic, strong) UIView *secondDivideLine;

@property (nonatomic, strong) BTLikesUserListView *userListView;
//@property (nonatomic, strong) UILabel *likesLabel;
//@property (nonatomic, strong) UIButton *arrowButton;


@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UIButton *likesButton;
@property (nonatomic, strong) UIButton *buyButton;
@property (nonatomic, strong) UIView *sepeatorView;
@end

@implementation BTProductCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self setupView];
  }
  return self;
}

- (void)setupView {
  
  _rankImageView = [UIImageView new];
  
  _titleLabel = [[UILabel alloc] init];
  _titleLabel.font = [UIFont systemFontOfSize:17];
  _titleLabel.textColor = kUIColorFromRGB(0xFF666666);
  
  _descLabel = [[UILabel alloc] init];
  _descLabel.font = [UIFont systemFontOfSize:14];
  _descLabel.numberOfLines = 0;
  _descLabel.textColor = kUIColorFromRGB(0xFF727272);
  
  _imageView1 = [UIImageView new];
  _imageView1.contentMode = UIViewContentModeScaleAspectFill;
  _imageView1.userInteractionEnabled = YES;
  _imageView1.tag = 1;
  [_imageView1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)]];
  
  _imageView2 = [UIImageView new];
  _imageView2.contentMode = UIViewContentModeScaleAspectFill;
  _imageView2.userInteractionEnabled = YES;
  _imageView2.tag = 2;
  [_imageView2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)]];
  
  _imageView3 = [UIImageView new];
  _imageView3.contentMode = UIViewContentModeScaleAspectFill;
  _imageView3.userInteractionEnabled = YES;
  _imageView3.tag = 3;
  [_imageView3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)]];
  
  _imageView4 = [UIImageView new];
  _imageView4.contentMode = UIViewContentModeScaleAspectFill;
  _imageView4.userInteractionEnabled = YES;
  _imageView4.tag = 4;
  [_imageView4 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)]];
  

  
  _priceLabel = [UILabel new];
  _priceLabel.font = [UIFont systemFontOfSize:14];
  _priceLabel.textColor = BTGobalRedColor;
  
  _fristDivideLine = [UIView new];
  _fristDivideLine.backgroundColor = kUIColorFromRGB(0xFFEEEEEE);
  
  _secondDivideLine = [UIView new];
  _secondDivideLine.backgroundColor = kUIColorFromRGB(0xFFEEEEEE);
  
  
  _commentButton = [UIButton new];
  [_commentButton setTitleColor:kUIColorFromRGB(0xFF727272) forState:UIControlStateNormal];
  [_commentButton setImage:[UIImage imageNamed:@"product_not_commenticon"] forState:UIControlStateNormal];
  [self.commentButton setTitle:@" 评论" forState:UIControlStateNormal];
  
  _likesButton = [UIButton new];
  [_likesButton setTitleColor:kUIColorFromRGB(0xFF727272) forState:UIControlStateNormal];
  
  
  _buyButton = [UIButton new];
  [_buyButton setImage:[UIImage imageNamed:@"tools_taobao"] forState:UIControlStateNormal];
  [_buyButton setImage:[UIImage imageNamed:@"tools_taobao_pressed"] forState:UIControlStateSelected];
  
  _sepeatorView = [UIView new];
  _sepeatorView.backgroundColor = kUIColorFromRGB(0xf8f9fa);

}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  _rankImageView.x = kPadding;
  _rankImageView.y = kPadding;
  _rankImageView.width = kRankImageViewWidth;
  _rankImageView.height = kRankImageViewHeight;
  
  _titleLabel.x = _rankImageView.right + kSmallPadding;
  _titleLabel.y = kPadding;
  [self.titleLabel sizeToFit];
  
  _descLabel.x = kPadding;
  _descLabel.y = _titleLabel.tail + kPadding;
  _descLabel.width = self.width - 2 *kPadding;
  [self.descLabel sizeToFit];
  
  UIImageView *lastImageView = nil;
  for (int i = 0; i < self.product.pic.count; i++) {
    if (i >= self.imageViews.count) {
      return;
    }
    
    UIImageView *imageView = (UIImageView *)self.imageViews[i];
    imageView.x = kPadding;
    imageView.width = kPicWidth;
    imageView.height = kPicWidth;
    imageView.y = lastImageView == nil ? _descLabel.tail + kPadding : lastImageView.tail + kPadding;
    lastImageView = imageView;
  }
  
  _priceLabel.y = lastImageView.tail + kPadding;
  [_priceLabel sizeToFit];
  _priceLabel.x = self.width - kPadding - _priceLabel.width;
  
  _fristDivideLine.y = _priceLabel.tail + kPadding;
  _fristDivideLine.x = 0;
  _fristDivideLine.width = kScreen_Width;
  _fristDivideLine.height = kDivideLineHeight;
  
  _userListView.x = 0;
  _userListView.y = _fristDivideLine.tail;
  [_userListView sizeToFit];
  
  _secondDivideLine.y = _userListView.tail;
  _secondDivideLine.x = 0;
  _secondDivideLine.width = kScreen_Width;
  _secondDivideLine.height = kDivideLineHeight;
  
  _buyButton.y = _secondDivideLine.tail + kSmallPadding;
  _buyButton.width = kBuyButtonWidth;
  _buyButton.height = kBuyButtonHeight;
  _buyButton.x = kScreen_Width - kBuyButtonWidth - kPadding;
  [_buyButton addTarget:self action:@selector(didClickedBuyButton) forControlEvents:UIControlEventTouchUpInside];
  
  CGFloat buyButtonCenterY = _buyButton.tail - kBuyButtonHeight / 2.0;
  
  _commentButton.x = kPadding * 2;
  [_commentButton sizeToFit];
  _commentButton.y = _secondDivideLine.tail + kSmallPadding;
  CGPoint commentButtonCenter = _commentButton.center;
  commentButtonCenter.y = buyButtonCenterY;
  _commentButton.center = commentButtonCenter;
  
  [_likesButton sizeToFit];
  _likesButton.x = (kScreen_Width - _likesButton.width) / 2.0;
  CGPoint likesButtonCenter = _likesButton.center;
  likesButtonCenter.y = buyButtonCenterY;
  _likesButton.center = likesButtonCenter;
  
  _sepeatorView.x = 0;
  _sepeatorView.y = _buyButton.tail + kSmallPadding;
  _sepeatorView.width = kScreen_Width;
  _sepeatorView.height = kSepeatorHeight;
  
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];
  
  [self.contentView addSubview:self.rankImageView];
  [self.contentView addSubview:self.titleLabel];
  [self.contentView addSubview:self.descLabel];
  [self.contentView addSubview:self.imageView1];
  [self.contentView addSubview:self.imageView2];
  [self.contentView addSubview:self.imageView3];
  [self.contentView addSubview:self.imageView4];
  [self.contentView addSubview:self.priceLabel];
  
  [self.contentView addSubview:self.fristDivideLine];
  [self.contentView addSubview:self.secondDivideLine];
  
  [self.contentView addSubview:self.commentButton];
  [self.contentView addSubview:self.likesButton];
  [self.contentView addSubview:self.buyButton];
  
  [self.contentView addSubview:self.sepeatorView];
}

- (void)prepareForReuse {
  [super prepareForReuse];
  self.imageView1.image = nil;
  self.imageView2.image = nil;
  self.imageView3.image = nil;
  self.imageView4.image = nil;
  self.rankImageView.image = nil;
  [self.userListView removeFromSuperview];
}

#pragma mark - Setter
- (void)setProduct:(BTProduct *)product {
  _product = product;
  self.titleLabel.text = product.title;
  
  NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
  style.lineSpacing = kParagraphLineSpace;
  self.descLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:product.desc attributes:@{NSParagraphStyleAttributeName : style}];
  self.priceLabel.text = [NSString stringWithFormat:@"参考价：￥%@", product.price];
  
  self.userListView = [[BTLikesUserListView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, [BTLikesUserListView likesUserListViewHeight]) likesList:product.likes_list likesString:product.likes];
  [self addSubview:self.userListView];
  
  [self.likesButton setTitle:[NSString stringWithFormat:@"❤︎ %@", product.likes] forState:UIControlStateNormal];
  if (product.comments.length > 0 && ![product.comments isEqualToString:@"0"]) {
    [self.commentButton setTitle:[NSString stringWithFormat:@" %@", product.comments] forState:UIControlStateNormal];
  }
  
  unsigned long imagesCount = MIN(product.pic.count, self.imageViews.count);
  NSMutableArray *tmpArray = [NSMutableArray new];
  for (int i = 0; i < imagesCount; i++) {
    
    NSString *imagePathString = product.pic[i][@"p"];
    NSString *imageURLString = [NSString stringWithFormat:@"%@%@", kBTImageBaseURL, imagePathString];
    
    UIImageView *imageView = (UIImageView *)self.imageViews[i];

    [imageView yy_setImageWithURL:[NSURL URLWithString:imageURLString] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    [tmpArray addObject:imageView];
  }
  self.realImageViews = tmpArray;
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
  _indexPath = indexPath;
  self.rankImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"good%d", (int)indexPath.row + 1]];
}

- (NSArray *)imageViews {
  return @[_imageView1, _imageView2, _imageView3, _imageView4];
}

#pragma mark - Action

- (void)didClickedBuyButton {
  if ([self.delegate respondsToSelector:@selector(didSelectedBuyButtonWithCellIndexPath:)]) {
    [self.delegate didSelectedBuyButtonWithCellIndexPath:self.indexPath];
  }
}

- (void)tapImageView:(UITapGestureRecognizer *)gesture {
  int index = (int)gesture.view.tag - 1;
  if ([self.delegate respondsToSelector:@selector(tappedImageViewWithCellIndexPath:imageIndex:images:)]) {
    
    NSMutableArray *images = [NSMutableArray new];
    for (UIImageView *imageView in self.realImageViews) {
      [images addObject:imageView.image];
    }
    
    [self.delegate tappedImageViewWithCellIndexPath:self.indexPath imageIndex:index images:images];
  }
}

#pragma mark - calculate height

+ (CGFloat)getCellHeightWithProduct:(BTProduct *)product {
  if (product.height < 10) {
    return [self heightWithProduct:product];
  } else {
    return product.height;
  }
  
}

+ (CGFloat)heightWithProduct:(BTProduct *)product {
  CGFloat titleHeight = [BTHelper getTextHeightWithText:product.title font:[UIFont systemFontOfSize:17] width:kScreen_Width - 2 * kPadding];
  CGFloat descHeight = [BTHelper getTextHeightWithText:product.desc font:[UIFont systemFontOfSize:14] width:kScreen_Width - 2 * kPadding lineSpace:kParagraphLineSpace];
  
  CGFloat priceHeight =  [BTHelper getTextHeightWithText:product.price font:[UIFont systemFontOfSize:14] width:kScreen_Width - 2 * kPadding];
  CGFloat picsHeight = [self heightWithPics:product.pic];
  
  CGFloat height = kPadding + titleHeight + kPadding + descHeight + kPadding + picsHeight + kPadding + priceHeight + kPadding + kDivideLineHeight + [BTLikesUserListView likesUserListViewHeight] + kDivideLineHeight + kSmallPadding + kBuyButtonHeight + kSmallPadding +kSepeatorHeight;
  product.height = height;
  return height;
  
}

+ (CGFloat)heightWithPics:(NSArray *)pics {
  return pics.count * kPicWidth + (pics.count - 1) * kPadding;
}


@end
