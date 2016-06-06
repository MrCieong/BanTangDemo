//
//  BTCommunityInfoCollectionViewController.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/20.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTCommunityInfoCollectionViewController.h"
#import "BTCommunityPostInfo+Request.h"
#import "BTLoadingView.h"
#import "BTCommunityPostInfoCell.h"
#import "Constant.h"
#import "BTHotRecommendTableViewController.h"

@interface BTCommunityInfoCollectionViewController () <UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) BTLoadingView *loadingView;
@property (nonatomic, strong) NSArray *communityPostInfoList;

@end

@implementation BTCommunityInfoCollectionViewController {
  int _page;
  BOOL _loadFinished;
}

static NSString * const kBTCommuntiyPostInfoCellIdentifier = @"BTCommuntiyPostInfoCell";

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"单品列表";
  [self setupView];
  [self loadDataFromStart:YES];
}

- (void)setupView {
  
  self.collectionView.backgroundColor = kUIColorFromRGB(0xf8f9fa);
  UICollectionViewFlowLayout *layout =(UICollectionViewFlowLayout *)self.collectionViewLayout;
  layout.itemSize = CGSizeMake((kScreen_Width - 3 * 12) / 2, 260);
  layout.sectionInset = UIEdgeInsetsMake(12, 12, 12, 12);
  
  [self.collectionView registerNib:[UINib nibWithNibName:@"BTCommunityPostInfoCell" bundle:nil] forCellWithReuseIdentifier:kBTCommuntiyPostInfoCellIdentifier];
}

- (void)loadDataFromStart:(BOOL) isStart {
  self.loadingView = [BTLoadingView loadingViewToView:self.view];
  if (isStart) {
    _page = 0;
  }
  
  [BTCommunityPostInfo fetchCommunityPostInfoListByCategoryID:self.categoryID page:_page success:^(NSArray *models) {
    
    if (isStart) {
      self.communityPostInfoList = models;
    } else {
      NSMutableArray *tmp = self.communityPostInfoList.mutableCopy;
      [tmp addObjectsFromArray:models];
      self.communityPostInfoList = tmp;
    }
    
    _loadFinished = models.count < kBTCommunityPostInfoPageSize;
    
    [self.collectionView reloadData];
    
    [self hideLoadingView];
  } failure:^(NSError *error) {
    [self hideLoadingView];
  }];
}

- (void)hideLoadingView {
  [self.loadingView removeFromSuperview];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.communityPostInfoList.count;
}

- (BTCommunityPostInfo *)communityPostInfoAtIndexPath:(NSIndexPath *)indexPath {
  return self.communityPostInfoList[indexPath.item];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  BTCommunityPostInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBTCommuntiyPostInfoCellIdentifier forIndexPath:indexPath];
  
  // Configure the cell
  cell.postInfo = [self communityPostInfoAtIndexPath:indexPath];
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
  if (_loadFinished == NO && indexPath.item == self.communityPostInfoList.count - 1) {
    _page++;
    [self loadDataFromStart:NO];
  }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [collectionView deselectItemAtIndexPath:indexPath animated:YES];
  
  BTHotRecommendTableViewController *vc = [BTHotRecommendTableViewController new];
  vc.postInfoArray = @[[self communityPostInfoAtIndexPath:indexPath]];
  vc.title = @"好物详情";
  [self.navigationController pushViewController:vc animated:YES];
  
}

#pragma mark <UICollectionViewDelegateFlowLayout>
//- (CGSize)coll



@end
