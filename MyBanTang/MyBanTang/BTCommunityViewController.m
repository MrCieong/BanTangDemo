//
//  BTCommunityViewController.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/19.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTCommunityViewController.h"
#import "BTCommunity+Request.h"
#import "BTCategory.h"
#import "BTLoadingView.h"
#import "Constant.h"
#import "UIView+frameAdjust.h"
#import "BTHotRecommendCell.h"
#import "BTCommunityPostInfo+Request.h"
#import "BTFooterLoadingView.h"
#import "BTHotRecommendHeader.h"
#import "BTHotRecommendFooter.h"
#import "UIScrollView+PullToRefreshCoreText.h"
#import "BTCategoryMenuFooter.h"
#import "BTCategoryCell.h"
#import "BTHotRecommendHeader.h"
#import "BTCommunityInfoCollectionViewController.h"
#import "BTHotRecommendTableViewController.h"


static NSString *kHotRecommendCollectionViewCell = @"HotRecommendCollectionViewCell";
static NSString *kBTHotRecommendFooterIdentifier = @"BTHotRecommendFooterIdentifier";
static NSString *kBTHotRecommendHeaderIdentifier = @"BTHotRecommendHeaderIdentifier";
static NSString *kBTCategoryMenuFooterIdentifier = @"BTCategoryMenuFooterIdentifier";
static NSString *kBTCategoryCellIdentifier = @"BTCategoryCellIdentifier";

@interface BTCommunityViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, BTCategoryMenuFooterDelegate>

@property (nonatomic, strong) BTLoadingView *loadingView;
@property (nonatomic, strong) BTHotRecommendFooter *footerLoadingView;

@property (nonatomic, strong) UICollectionViewFlowLayout *hotRecommendLayout;
@property (nonatomic, strong) UICollectionView *hotRecommendCollectionView;
@property (nonatomic, strong) NSArray *categroys;
@property (nonatomic, strong) NSArray *hotRecommends;
@property (nonatomic, strong) BTCategoryMenuFooter *categoryCollectionFooter;


@end

@implementation BTCommunityViewController {
  int _page;
  BOOL _loadFinished;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupView];
  
  [self loadData];
}

- (void)setupView {
  [self.view addSubview:self.hotRecommendCollectionView];
  self.hotRecommendCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
  NSLayoutConstraint *leadingConstraint = [self.hotRecommendCollectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor];
  NSLayoutConstraint *trailingConstraint = [self.hotRecommendCollectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor];
  NSLayoutConstraint *topConstraint = [self.hotRecommendCollectionView.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor];
  NSLayoutConstraint *bottomConstraint = [self.hotRecommendCollectionView.bottomAnchor constraintEqualToAnchor:self.bottomLayoutGuide.topAnchor];
  
  [NSLayoutConstraint activateConstraints:@[leadingConstraint, trailingConstraint, topConstraint, bottomConstraint]];
  
  
}

- (void)loadData {
  self.loadingView = [BTLoadingView loadingViewToView:self.view];
  [BTCommunity fetchCommunityDataWithSuccess:^(BTCommunity * communityData) {
    
    self.categroys = communityData.category_list;
    [self.hotRecommendCollectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
  } failure:^(NSError * error) {
  }];
  
  [self loadHotRecommendFromStart:YES];
  
}

- (void)loadHotRecommendFromStart:(BOOL) isStart {
  if (isStart) {
    _page = 0;
  }
  
  [BTCommunityPostInfo fetchHotRecommendDataWithPage:_page success:^(NSArray * models) {
     [self hideLoading];
    if (isStart) {
      self.hotRecommends = models;
    } else {
      NSMutableArray *tempArray = self.hotRecommends.mutableCopy;
      [tempArray addObjectsFromArray:models];
      self.hotRecommends = tempArray;
    }
    _loadFinished = models.count < kBTCommunityPostInfoPageSize;
    
    [self.hotRecommendCollectionView  reloadData];
   
  } failure:^(NSError *error) {
    [self hideLoading];
  }];
}

- (void)hideLoading {
  [self.loadingView removeFromSuperview];
  [self.footerLoadingView stopLoading];
  [self.hotRecommendCollectionView finishLoading];
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  if (section == 0) {
    return 0;
  } else {
    return self.hotRecommends.count;
  }
  
}

- (BTCategory *)categoryAtIndexPath:(NSIndexPath *)indexPath {
  return self.categroys[indexPath.item];
}

- (BTCommunityPostInfo *)hotRecommendAtIndexPath:(NSIndexPath *)indexPath {
  return self.hotRecommends[indexPath.item];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    BTCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBTCategoryCellIdentifier forIndexPath:indexPath];
    cell.category = [self categoryAtIndexPath:indexPath];
    return cell;
  } else {
    BTHotRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHotRecommendCollectionViewCell forIndexPath:indexPath];
    if (!cell) {
      cell = [[BTHotRecommendCell alloc] init];
    }
    BTCommunityPostInfo *hotRecommend = [self hotRecommendAtIndexPath:indexPath];
    cell.imageURLString = hotRecommend.miniPicUrl;
    return cell;
  }
  
  
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
  if (_loadFinished == NO && indexPath.item == (self.hotRecommends.count - 1)) {
    _page++;
    [self loadHotRecommendFromStart:NO];
    [self.footerLoadingView startLoading];
  }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
  NSString *identifier = kBTHotRecommendHeaderIdentifier;
  if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
    if (indexPath.section == 0) {
      
      identifier = kBTCategoryMenuFooterIdentifier;
    } else {
      identifier = kBTHotRecommendFooterIdentifier;
    }
    
  }
  UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
  if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
    if (indexPath.section == 0) {
     BTCategoryMenuFooter *menuFooter = (BTCategoryMenuFooter *)reusableView;
      menuFooter.categorys = self.categroys;
      menuFooter.delegate = self;
    } else {
      self.footerLoadingView = (BTHotRecommendFooter *)reusableView;
    }
    
  } else if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
    BTHotRecommendHeader *header = (BTHotRecommendHeader *)reusableView;
    if (indexPath.section == 0) {
      header.iconImageView.image = [UIImage imageNamed:@"category_icon"];
      header.nameLabel.text = @"分类";
      
    } else {
      header.iconImageView.image = [UIImage imageNamed:@"hot_icon"];
      header.nameLabel.text = @"热门推荐";
    }
  }
  
  return reusableView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 1) {
    BTHotRecommendTableViewController *hotRecommendVC = [BTHotRecommendTableViewController new];
    hotRecommendVC.title = @"热门推荐";
    hotRecommendVC.postInfoArray = self.hotRecommends;
    hotRecommendVC.hidesBottomBarWhenPushed = YES;
    hotRecommendVC.selectedIndex = (int)indexPath.item;
    [self.navigationController pushViewController:hotRecommendVC animated:YES];
  }
    
  
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    return CGSizeMake((kScreen_Width - 3 * 12) / 2, 90);
  } else {
    return CGSizeMake((kScreen_Width - 8)/ 3 , (kScreen_Width - 8) / 3 );
  }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
  if (section == 0) {
    
    return CGSizeMake(kScreen_Width, [BTCategoryMenuFooter categoryFooterHeightByCategorysCount:(int)self.categroys.count]);
  }
  return CGSizeMake(300, 50);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
  return section == 0 ? 12 : 4;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
  return section == 0 ? 12 : 4;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
  if (section == 0) {
    return UIEdgeInsetsMake(0, 12, 12, 12);
  } else {
    return ((UICollectionViewFlowLayout *)collectionViewLayout).sectionInset;
  }
}

#pragma mark - BTCategoryMenuFooterDelegate
- (void)didSelectMenuButtonWithCategate:(BTCategory *)category {
  BTCommunityInfoCollectionViewController *vc = [[BTCommunityInfoCollectionViewController alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
  vc.categoryID = category.ID;
  vc.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Getter & Setter

- (UICollectionView *)hotRecommendCollectionView {
  if (!_hotRecommendCollectionView) {
    _hotRecommendCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.hotRecommendLayout];
    
    _hotRecommendCollectionView.dataSource = self;
    _hotRecommendCollectionView.delegate = self;
    _hotRecommendCollectionView.backgroundColor = [UIColor whiteColor];
  
    [_hotRecommendCollectionView registerClass:[BTHotRecommendCell class] forCellWithReuseIdentifier:kHotRecommendCollectionViewCell];
    
    [_hotRecommendCollectionView registerNib:[UINib nibWithNibName:@"BTCategoryCell" bundle:nil] forCellWithReuseIdentifier:kBTCategoryCellIdentifier];
    
    [_hotRecommendCollectionView registerNib:[UINib nibWithNibName:@"BTHotRecommendHeader" bundle:nil]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kBTHotRecommendHeaderIdentifier];
    
    [_hotRecommendCollectionView registerNib:[UINib nibWithNibName:@"BTHotRecommendFooter" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kBTHotRecommendFooterIdentifier];
    
    [_hotRecommendCollectionView registerClass:[BTCategoryMenuFooter class]forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kBTCategoryMenuFooterIdentifier];
    
  }
  return _hotRecommendCollectionView;
}

- (UICollectionViewFlowLayout *)hotRecommendLayout {
  if (!_hotRecommendLayout) {
    _hotRecommendLayout = [[UICollectionViewFlowLayout alloc] init];
    _hotRecommendLayout.itemSize = CGSizeMake((kScreen_Width - 8)/ 3 , (kScreen_Width - 8) / 3 );
    _hotRecommendLayout.minimumLineSpacing = 4;
    _hotRecommendLayout.minimumInteritemSpacing = 4;
    
    _hotRecommendLayout.headerReferenceSize = CGSizeMake(300, 50);
    _hotRecommendLayout.footerReferenceSize = CGSizeMake(300, 50);
  }
  return _hotRecommendLayout;
}


@end
