//
//  NewInfoHeaderView.m
//  BanTangDemo
//
//  Created by zhangjing on 16/5/16.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "NewInfoHeaderView.h"
#import "Constant.h"
#import "BTNewInfo.h"
#import "BTHelper.h"
#import "UIView+frameAdjust.h"
@interface NewInfoHeaderView ()


@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descrptionLabel;
@property (nonatomic, strong) UIView *sepeatorView;

@end

static const CGFloat kPadding = 12;
static const CGFloat kLineSpacing = 6.0;
static const CGFloat kSepeatorHeight = 12.0;
@implementation NewInfoHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self setupSubView];
  }
  return self;
}

- (void)setupSubView {
  self.backgroundColor = [UIColor whiteColor];
  _titleLabel = [UILabel new];
  _titleLabel.textColor = kUIColorFromRGB(0xFF666666);
  
  _descrptionLabel = [UILabel new];
  _descrptionLabel.numberOfLines = 0;
  _descrptionLabel.textColor = kUIColorFromRGB(0xFF727272);
  _descrptionLabel.font = [UIFont systemFontOfSize:14];
  
  _sepeatorView = [UIView new];
  _sepeatorView.backgroundColor = kUIColorFromRGB(0xf8f9fa);

}

- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];
  
  [self addSubview:_titleLabel];
  [self addSubview:_descrptionLabel];
  [self addSubview:_sepeatorView];
}

- (void)layoutSubviews {
  [super layoutSubviews];
 
  
  
  _titleLabel.x = kPadding;
  _titleLabel.y = kPadding;
  [_titleLabel sizeToFit];
  
  _descrptionLabel.x = kPadding;
  _descrptionLabel.y = _titleLabel.tail + kPadding;
  _descrptionLabel.width = kScreen_Width - 2 * kPadding;
  [_descrptionLabel sizeToFit];
  
  _sepeatorView.x = 0;
  _sepeatorView.y = _descrptionLabel.tail + kPadding;
  _sepeatorView.width = kScreen_Width;
  _sepeatorView.height = kSepeatorHeight;

}


#pragma mark - Override Method
- (CGSize)sizeThatFits:(CGSize)size {
  return CGSizeMake(size.width, [self headerTotalHeight]);
}

- (CGFloat)headerTotalHeight {
  
  return 3 * kPadding + [self titleHeight] + [self descrptionLabelHeight] + kSepeatorHeight;
}

- (CGFloat)titleHeight {
  return [BTHelper getTextHeightWithText:self.titleLabel.text font:self.titleLabel.font width:kScreen_Width - kPadding * 2];
}

- (CGFloat)descrptionLabelHeight {
  return [BTHelper getTextHeightWithText:self.descrptionLabel.text font:self.descrptionLabel.font width:kScreen_Width - kPadding * 2 lineSpace:kLineSpacing];
}

#pragma mark - Setter
- (void)setMyNewInfo:(BTNewInfo *)myNewInfo {
  self.titleLabel.text = myNewInfo.title;

  NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
  style.lineSpacing = kLineSpacing;
  self.descrptionLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:myNewInfo.desc attributes:@{NSParagraphStyleAttributeName : style}];
  [self sizeToFit];
}

@end
