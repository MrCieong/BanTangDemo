//
//  BTTopicsListViewController.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/21.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTTopicsListViewController.h"
#import "BTTopic+Request.h"
#import "BTTopicsCell.h"
#import "BTFooterLoadingView.h"
#import "BTSwitchTitleView.h"
#import "BTLoadingView.h"
#import "BTTopicDetailViewController.h"

@interface BTTopicsListViewController () <UITableViewDelegate>
@property (strong, nonatomic) IBOutlet BTSwitchTitleView *switchTitleView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) BTLoadingView *loadingView;
@property (strong, nonatomic) IBOutlet UIView *topSectionView;

@property (nonatomic, strong) NSArray *topics;
@property (nonatomic, strong) NSArray *hotTopics;

@property (weak, nonatomic) IBOutlet UIButton *latestButton;
@property (weak, nonatomic) IBOutlet UIButton *hotButton;

@end

@implementation BTTopicsListViewController {
  int _page;
  BOOL _loadFinished;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupView];
  self.loadingView = [BTLoadingView loadingViewToView:self.view];
  [self loadDataFromStart:YES];
  
}


- (void)setupView {
  self.tableView.tableFooterView = [UIView new];
  self.tableView.rowHeight = 230;
  self.navigationItem.titleView = self.switchTitleView;
  
  __weak typeof(self) weakSelf = self;
  
  self.switchTitleView.switchedBlock = ^(NSUInteger index) {
    if (index == 1) {
      if (self.childViewControllers.count == 0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"BTCommunityViewController"];
        
        [weakSelf addChildViewController:vc];
        vc.view.frame = weakSelf.view.frame;
        vc.view.alpha = 0;
        [weakSelf.view addSubview:vc.view];
        [vc didMoveToParentViewController:weakSelf];
      }
      
      [UIView animateWithDuration:0.3 animations:^{
        [weakSelf childViewControllers].firstObject.view.alpha = 1;
      }];
      
    } else {
      [UIView animateWithDuration:0.3 animations:^{
        [weakSelf childViewControllers].firstObject.view.alpha = 0;
      }];
    }
  };
}


- (void)loadDataFromStart:(BOOL) isStart {
  if (isStart) {
    _page = 0;
    _loadFinished = NO;
  }
  
  [BTTopic fetchTopicsDataWithPage:_page success:^(NSArray *models) {
    [self hideLoadingView];
    if (isStart) {
      self.topics = models;
    } else {
  
        NSMutableArray *tmp = self.topics.mutableCopy;
        [tmp addObjectsFromArray:models];
        self.topics = tmp;
        [self.tableView reloadData];
    }
    
    _loadFinished = models.count < kBTTopicPageSize;
    [self.tableView reloadData];
    
  } failure:^(NSError *error) {
    [self hideLoadingView];
  }];
  
}

- (void)hideLoadingView {
  [self.loadingView removeFromSuperview];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.topics.count;
}

- (BTTopic *)topicAtIndexPath:(NSIndexPath *)indexPath {
  return self.topics[indexPath.row];
}

static NSString *kBTTopicsCell = @"BTTopicsCell";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  BTTopicsCell *cell = [tableView dequeueReusableCellWithIdentifier:kBTTopicsCell forIndexPath:indexPath];
  
  cell.topic = [self topicAtIndexPath:indexPath];
  return cell;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  if ((_loadFinished == NO) && (indexPath.row == self.topics.count - 1)) {
    _page++;
    [self loadDataFromStart:NO];
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  BTTopic *topic = [self topicAtIndexPath:indexPath];
  BTTopicDetailViewController *detailVC = [BTTopicDetailViewController new];
  detailVC.topicID = topic.ID;
  detailVC.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:detailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return  44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  return self.topSectionView;
}

- (IBAction)tapSectionButton:(UIButton *)button {
  
  button.selected = YES;
  if ([button isEqual:self.hotButton]) {
    self.latestButton.selected = NO;
  } else {
     self.hotButton.selected = NO;
    
  }
  
}
@end
