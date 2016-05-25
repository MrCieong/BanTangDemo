//
//  HomeTableViewController.m
//  BangTangDemo
//
//  Created by zhangjing on 16/5/7.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "HomeTableViewController.h"
#import "HomeTopicCell.h"
#import "UINavigationBar+Awesome.h"
#import "Constant.h"
#import "UIScrollView+PullToRefreshCoreText.h"
#import "BTHomeData+Request.h"
#import "BTTopic.h"
#import "HomeCycleView.h"
#import "BTLoadingView.h"
#import "BTFooterLoadingView.h"
#import "BTNewInfoViewController.h"
#import "UIImage+RenderedImage.h"
#import "UIView+frameAdjust.h"
#import "ZJScrollTitleView.h"
#import "BTProductListTableViewController.h"

static const CGFloat kTitlesViewHeight = 40.0;

@interface HomeTableViewController () <UITableViewDelegate, HomeCycleViewDelegate>

@property (weak, nonatomic) IBOutlet HomeCycleView *homeCycleView;
@property (nonatomic, strong) BTHomeData *homeData;
@property (nonatomic, strong) NSArray *topics;
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) BTLoadingView *loadingView;
@property (nonatomic, strong) BTFooterLoadingView *footerLoadingView;
@property (nonatomic, assign) BOOL finishedLoadedData;
@property (nonatomic, assign) CGFloat navigationBarAlpha;
@property (nonatomic, strong) ZJScrollTitleView *titlesView;


@end

@implementation HomeTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupView];
  [self loadingDataFromStart:YES];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self setupNavigationBarAlpha];
}

- (void)loadingDataFromStart:(BOOL)isStart {
  self.page = isStart ? 0 : self.page;
  [BTHomeData fetchHomeDataWithPage:self.page success:^(BTHomeData *homeData) {
    [self endLoading];
    
    self.homeData = homeData;
    if (isStart) {
      self.topics = homeData.topic;
      self.homeCycleView.banners = homeData.banner;
    } else {
      NSMutableArray *array = [NSMutableArray arrayWithArray:self.topics];
      [array addObjectsFromArray:homeData.topic];
      self.topics = array;
    }
    
    self.finishedLoadedData = homeData.topic.count < 20;
    
    [self.tableView reloadData];
    
  } failure:^(NSError *error) {
    [self endLoading];
  }];
}

- (void)endLoading {
  [self.footerLoadingView stopLoading];
  [self.loadingView removeFromSuperview];
  [self.tableView finishLoading];
}


- (void)setupView {
  [self setupNavigationItem];
//  self.view addsu
  self.titlesView.titles = @[@"最新", @"一周最热", @"买买买", @"读书", @"设计", @"文艺", @"礼物", @"指南", @"爱美", @"吃货" , @"格调" , @"厨房" , @"上班族" , @"学生党" , @"聚会" ];
  self.navigationBarAlpha = 0.0;
  self.loadingView = [BTLoadingView loadingViewToView:self.view];
  self.homeCycleView.delegate = self;
  
  [self setupTableView];
}

- (void)setupTableView {
  self.tableView.tableFooterView = self.footerLoadingView;
  self.tableView.rowHeight = 264.0;
  
  __weak typeof(self) weakSelf = self;
  [self.tableView addPullToRefreshWithPullText:@"C'est La Vie"
                                 pullTextColor:kUIColorFromRGB(0xcb6e76)
                                  pullTextFont:DefaultTextFont
                                refreshingText:@"La Vie est belle"
                           refreshingTextColor:kUIColorFromRGB(0xcb6e76)
                            refreshingTextFont:DefaultTextFont action:^{
                              [weakSelf loadingDataFromStart:YES];
                            }];
}


- (void)setupNavigationItem {
  
  UIButton *leftItemButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 33, 33)];
  [leftItemButton setImage:[UIImage imageNamed:@"home_search_icon"] forState:UIControlStateNormal];
  self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:leftItemButton];
  
  UIButton *rightItemButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 33, 33)];
  [rightItemButton setImage:[UIImage imageNamed:@"home_sign_icon"] forState:UIControlStateNormal];
  self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:rightItemButton];

  UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 150, 33)];
  searchBar.placeholder = @"搜索值得买的好物";
  UITextField *txfSearchField = [searchBar valueForKey:@"_searchField"];
  txfSearchField.backgroundColor = kUIColorFromRGB(0xf8f9fa);
  searchBar.barTintColor = [UIColor whiteColor];
  
  self.navigationItem.titleView = searchBar;
  self.navigationItem.titleView.alpha = 0;
}

#pragma mark - Action
- (void)searchAction {
  
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.topics.count;
}


- (BTTopic *)topicAtIndexPath:(NSIndexPath *)indexPath {
  return self.topics[indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  HomeTopicCell *cell = (HomeTopicCell *)[tableView dequeueReusableCellWithIdentifier:kHomeTopicCellIdentifier forIndexPath:indexPath];
  BTTopic *topic = [self topicAtIndexPath:indexPath];
  cell.topic = topic;
  return cell;
}

#pragma mark - Table View Delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  return self.titlesView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  BTTopic *topic = [self topicAtIndexPath:indexPath];
  HomeTopicCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  
  BTNewInfoViewController *newInfoVC = [[BTNewInfoViewController alloc] init];
  newInfoVC.topicID = topic.ID;
  newInfoVC.topicImage = cell.topicImageView.image;
  newInfoVC.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:newInfoVC animated:YES];
  
  
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == self.topics.count - 1 && self.finishedLoadedData == NO) {
    self.page++;
    [self.footerLoadingView startLoading];
    [self loadingDataFromStart:NO];
  }
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  CGFloat offsetY = scrollView.contentOffset.y;
  if (offsetY > 50) {
    self.navigationBarAlpha = MIN(1, 1 - ((50 + 64 - offsetY) / 64));
  } else {
    self.navigationBarAlpha = 0;
  }
}

#pragma mark - SDCycleScrollViewDelegate
- (void)didSelectedBanner:(BTBanner *)banner {
  if ([banner.type isEqualToString:@"topic_list"]) {
    BTProductListTableViewController *vc = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"BTProductListTableViewController"];
    vc.topicIDs = banner.extend;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
  }
  
}

#pragma mark - Getter & Setter
- (BTFooterLoadingView *)footerLoadingView {
  if (!_footerLoadingView) {
    _footerLoadingView = [[BTFooterLoadingView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44)];
  }
  return _footerLoadingView;
}

- (void)setNavigationBarAlpha:(CGFloat)navigationBarAlpha {
  if (_navigationBarAlpha != navigationBarAlpha) {
    _navigationBarAlpha = navigationBarAlpha;
    
    [self setupNavigationBarAlpha];
  }
  
  
}

- (void)setupNavigationBarAlpha {
  
  self.navigationController.navigationBar.shadowImage = [UIImage imageWithRenderColor:[[UIColor lightGrayColor] colorWithAlphaComponent:self.navigationBarAlpha] renderSize:CGSizeMake(10, 0.5)];
  [self.navigationController.navigationBar lt_setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:self.navigationBarAlpha]];
  self.navigationItem.leftBarButtonItem.customView.alpha = (1 - self.navigationBarAlpha);
  self.navigationItem.rightBarButtonItem.customView.alpha = (1 - self.navigationBarAlpha);
  if (self.navigationBarAlpha == 1 && self.navigationItem.titleView.alpha == 0) {
    [self.navigationItem.titleView.layer removeAllAnimations];
    self.navigationItem.titleView.alpha = 1;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.fromValue = @(-kScreen_Width / 2.0);
    animation.toValue = @(kScreen_Width / 2.0);
    animation.duration = 0.2;
    [self.navigationItem.titleView.layer addAnimation:animation forKey:nil];
    
  } else if (self.navigationBarAlpha < 1 && self.navigationItem.titleView.alpha == 1) {
    [self.navigationItem.titleView.layer removeAllAnimations];
    self.navigationItem.titleView.alpha = 0;
  }
  
}

- (ZJScrollTitleView *)titlesView {
  if (!_titlesView) {
    _titlesView = [[ZJScrollTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kTitlesViewHeight)];
  }
  return _titlesView;
}

@end
