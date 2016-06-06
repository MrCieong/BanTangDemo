//
//  BTNewInfoViewController.m
//  BanTangDemo
//
//  Created by zhangjing on 16/5/17.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTNewInfoViewController.h"
#import "Constant.h"
#import "NewInfoHeaderView.h"
#import "BTNewInfo+Request.h"
#import "BTLoadingView.h"
#import "BTProduct.h"
#import "BTProductCell.h"
#import "UINavigationBar+Awesome.h"
#import "UIView+frameAdjust.h"
#import "BTWebViewController.h"
#import "UIImage+RenderedImage.h"
#import "BTProductDetailViewController.h"


static const CGFloat kTopImageViewHeight = 200.0;
@interface BTNewInfoViewController () <UITableViewDataSource, UITableViewDelegate, BTProductCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NewInfoHeaderView *headerView;
@property (nonatomic, strong) BTLoadingView *loadingView;
@property (nonatomic, strong) BTNewInfo *topicNewInfo;
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) NSArray *products;
@property (nonatomic, assign) CGFloat navigationBarAlpha;


@end
@implementation BTNewInfoViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupView];
  [self loadData];
}

- (void)setupView {
  self.automaticallyAdjustsScrollViewInsets = NO;
  self.view.backgroundColor = [UIColor whiteColor];
  [self setupNavigationItem];
  [self.view addSubview:self.tableView];
  [self.view addSubview:self.topImageView];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
}

- (void)setupNavigationItem {
  
  UILabel *titleLabel = [UILabel new];
  titleLabel.text = @"购物清单";
  [titleLabel sizeToFit];
  self.navigationItem.titleView = titleLabel;
  self.navigationBarAlpha = 0.0;
}

- (void)loadData {
  self.loadingView = [BTLoadingView loadingViewToView:self.view];
  [BTNewInfo fetchNewInfoWithID:self.topicID success:^(BTNewInfo *newIfo) {
    [self.loadingView removeFromSuperview];
    self.topicNewInfo = newIfo;
  } failure:^(NSError *error) {
    
  } ];
}

#pragma mark - UITableViewDataSource UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  BTProduct *product = [self productAtIndexPath:indexPath];
  
  return [BTProductCell getCellHeightWithProduct:product];
}

- (BTProduct *)productAtIndexPath:(NSIndexPath *)indexPath {
  return self.products[indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  BTProductCell *cell = (BTProductCell *)[tableView dequeueReusableCellWithIdentifier:@"BTProductCell" forIndexPath:indexPath];
  if (!cell) {
    cell = [[BTProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BTProductCell"];
    
  }
  cell.delegate = self;
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  cell.product = [self productAtIndexPath:indexPath];
  cell.indexPath = indexPath;
  return cell;
}



#pragma mark - Getter
- (UITableView *)tableView {
  if (!_tableView) {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kScreen_Height, kScreen_Width, kScreen_Height)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.contentInset = UIEdgeInsetsMake(kTopImageViewHeight, 0, 0, 0);
    _tableView.backgroundColor = [UIColor clearColor];
   
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[BTProductCell class] forCellReuseIdentifier:@"BTProductCell"];
  }
  return _tableView;
}

- (NewInfoHeaderView *)headerView {
  if (!_headerView) {
    _headerView = [NewInfoHeaderView new];
  }
  return _headerView;
}

- (void)setTopicNewInfo:(BTNewInfo *)topicNewInfo {
  _topicNewInfo = topicNewInfo;
  
  self.headerView.myNewInfo = topicNewInfo;
  self.tableView.tableHeaderView = self.headerView;
  self.products = _topicNewInfo.product;
  [self.tableView reloadData];
  
  [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    self.tableView.y = 0;
  } completion:nil];
}

- (UIImageView *)topImageView {
  if (!_topImageView) {
    _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kTopImageViewHeight)];
    _topImageView.image = self.topicImage;
    _topImageView.clipsToBounds = YES;
    _topImageView.layer.zPosition = -1;
  }
  return _topImageView;
}

- (void)setNavigationBarAlpha:(CGFloat)navigationBarAlpha {
  _navigationBarAlpha = navigationBarAlpha;
  ((UILabel *)self.navigationItem.titleView).textColor = [[UIColor grayColor] colorWithAlphaComponent:_navigationBarAlpha];
  self.navigationController.navigationBar.shadowImage = [UIImage imageWithRenderColor:[[UIColor lightGrayColor] colorWithAlphaComponent:_navigationBarAlpha] renderSize:CGSizeMake(10, 0.5)];
  [self.navigationController.navigationBar lt_setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:_navigationBarAlpha]];
  
}

static const CGFloat kThresholdOffsetY = 100;

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

  CGFloat offsetY = scrollView.contentOffset.y + kTopImageViewHeight;
  if (offsetY <= 0) {
    CGFloat scale = (kTopImageViewHeight - offsetY) / kTopImageViewHeight;
    self.topImageView.frame = CGRectMake(kScreen_Width * (1 - scale) / 2.0, 0, kScreen_Width * scale, kTopImageViewHeight * scale);
    
  } else {
    if (offsetY <= kTopImageViewHeight) {
      self.topImageView.y = -offsetY;
    }
    
    if (offsetY > kThresholdOffsetY) {
      self.navigationBarAlpha = MAX(0, MIN(1, (offsetY - kThresholdOffsetY ) / 64));;
    } else {
      self.navigationBarAlpha = 0.0;
    }
    
  }
}

#pragma mark - BTProductCellDelegate
- (void)didSelectedBuyButtonWithCellIndexPath:(NSIndexPath *)indexPath {
  BTProduct *product = [self productAtIndexPath:indexPath];
  BTWebViewController *webViewController = [BTWebViewController new];
  webViewController.urlString = product.url;
  webViewController.title = @"宝贝详情";
  [self presentViewController:[[UINavigationController alloc] initWithRootViewController:webViewController] animated:YES completion:nil];
}

- (void)tappedImageViewWithCellIndexPath:(NSIndexPath *)indexPath imageIndex:(int)index images:(NSArray *)images {
  BTProduct *product = [self productAtIndexPath:indexPath];
  BTProductDetailViewController *detailVC = [BTProductDetailViewController new];
  detailVC.product = product;
  detailVC.imageIndex = index;
  detailVC.images = images;
  [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didSelectedLikeButtonWithCellIndexPath:(NSIndexPath *)indexPath {
  UIViewController *vc = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"BTLoginViewController"];
  [self presentViewController:vc animated:YES completion:nil];
}

- (void)didSelectedCommendButtonWithCellIndexPath:(NSIndexPath *)indexPath {
  UIViewController *vc = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"BTLoginViewController"];
  [self presentViewController:vc animated:YES completion:nil];
}

@end
