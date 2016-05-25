//
//  BTProductListTableViewController.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/23.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTProductListTableViewController.h"
#import "BTProductListCell.h"
#import "BTTopic+Request.h"
#import "BTLoadingView.h"
#import "BTNewInfoViewController.h"

@interface BTProductListTableViewController ()

@property (nonatomic, strong) NSArray *topics;
@property (nonatomic, strong) BTLoadingView *loadingView;

@end

@implementation BTProductListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  [self.tableView registerNib:[UINib nibWithNibName:@"BTProductListCell" bundle:nil] forCellReuseIdentifier:kBTProductListCellIdentifier];
  self.tableView.rowHeight = 264;
  self.navigationController.navigationBar.alpha = 1.0;
  
  _loadingView = [BTLoadingView loadingViewToView:self.view];
  [BTTopic fetchTopicsDataWithIDs:self.topicIDs success:^(NSArray *models) {
    [self.loadingView removeFromSuperview];
    self.topics = models;
    [self.tableView reloadData];
  } failure:^(NSError *error) {
    [self.loadingView removeFromSuperview];
  }];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.topics.count;
}


- (BTTopic *)topicAtIndexPath:(NSIndexPath *)indexPath {
  return self.topics[indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BTProductListCell *cell = [tableView dequeueReusableCellWithIdentifier:kBTProductListCellIdentifier forIndexPath:indexPath];
    
  BTTopic *topic = [self topicAtIndexPath:indexPath];
  cell.topic = topic;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  BTTopic *topic = [self topicAtIndexPath:indexPath];
  BTProductListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  
  BTNewInfoViewController *newInfoVC = [[BTNewInfoViewController alloc] init];
  newInfoVC.topicID = topic.ID;
  newInfoVC.topicImage = cell.topicImageView.image;
  newInfoVC.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:newInfoVC animated:YES];
  
  
}

@end
