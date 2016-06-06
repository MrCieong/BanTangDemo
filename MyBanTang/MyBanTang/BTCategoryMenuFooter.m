//
//  BTCategoryCollectionFooter.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/20.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTCategoryMenuFooter.h"
#import "UIView+frameAdjust.h"
#import "Constant.h"
#import "UIButton+YYWebImage.h"
#import "BTCategory.h"

static const CGFloat kPadding = 12;
static const CGFloat kItemButtonHeight = 90;
static const int kMaxHeightCount = 6;

@interface BTCategoryMenuFooter () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation BTCategoryMenuFooter

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self commonSetup];
  }
  return self;
}

- (void)commonSetup {
  [self addSubview:self.scrollView];
  [self addSubview:self.pageControl];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.scrollView.frame = self.bounds;
  self.pageControl.width = 100;
  self.pageControl.height = 10;
  self.pageControl.center = CGPointMake(self.width / 2.0, self.height - 12);

}


+ (CGFloat)categoryFooterHeightByCategorysCount:(int)count {
  
  int minCount = MIN(kMaxHeightCount, count);
  
  CGFloat height = (minCount == 0 ? 0 : kPadding) + ceilf(minCount / 2.0) * (kItemButtonHeight + kPadding );
  return height;
}

#pragma mark - Getter & Setter
- (UIScrollView *)scrollView {
  if (!_scrollView) {
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
//    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
  }
  return _scrollView;
}

- (UIPageControl *)pageControl {
  if (!_pageControl) {
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.currentPageIndicatorTintColor = BTGobalRedColor;
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
  }
  return _pageControl;
}

- (void)setCategorys:(NSArray *)categorys {
  _categorys = categorys;
  CGFloat pageCount = ceilf(self.categorys.count / (CGFloat)kMaxHeightCount);
  CGFloat contentSizeWidth = pageCount * self.width;
  self.scrollView.contentSize = CGSizeMake(contentSizeWidth, self.height);
  
  self.pageControl.numberOfPages = pageCount;
  self.pageControl.currentPage = 0;
  [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
    [view removeFromSuperview];
  }];
  
  CGFloat kBtnWidth = (self.width - 3 * kPadding ) / 2.0;
  int row = 0;
  int column = 0;
  int page = 0;
  for (int i = 0; i < categorys.count; i++) {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake( page * self.width + (column * (kBtnWidth + kPadding) +kPadding) , (row * (kItemButtonHeight + kPadding)), kBtnWidth, kItemButtonHeight)];
    column++;
    if (column == 2) {
      row++;
      column = 0;
    }
    if (row == 3) {
      page++;
      row = 0;
    }
    BTCategory *category = categorys[i];
    btn.layer.cornerRadius = 3.0;
    btn.clipsToBounds = YES;
    btn.tag = i;
    [btn addTarget:self action:@selector(tapMenuButton:) forControlEvents:UIControlEventTouchUpInside];
    [btn yy_setImageWithURL:[NSURL URLWithString:category.pic] forState:UIControlStateNormal options:YYWebImageOptionSetImageWithFadeAnimation];
    
    [self.scrollView addSubview:btn];
  }
}

#pragma mark Action 
- (void)tapMenuButton:(UIButton *)button {
  if ([self.delegate respondsToSelector:@selector(didSelectMenuButtonWithCategate:)]) {
    [self.delegate didSelectMenuButtonWithCategate:self.categorys[button.tag]];
  }
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  self.pageControl.currentPage = scrollView.contentOffset.x / scrollView.width;
}

@end
