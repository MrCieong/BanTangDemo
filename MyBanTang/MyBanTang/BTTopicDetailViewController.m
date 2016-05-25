//
//  BTTopicDetailViewController.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/22.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTTopicDetailViewController.h"
#import "BTTopic+Request.h"
#import "BTLoadingView.h"
#import "Constant.h"
#import "UIView+frameAdjust.h"

@interface BTTopicDetailViewController () <UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) BTTopic *topic;
@property (nonatomic, strong) BTLoadingView *loadingView;

@end

@implementation BTTopicDetailViewController
#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
  [self setupView];
  [self loadData];
}

- (void)loadData {
  self.loadingView = [BTLoadingView loadingViewToView:self.view];
  [BTTopic fetchTopicDataWithID:self.topicID success:^(BTTopic *topic) {
    self.topic = topic;
  } failure:^(NSError *error) {
    [self.loadingView removeFromSuperview];
  }];
}


- (void)setupView {
  self.view.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:self.tableView];
  [self setupConstraints];
  
}

- (void)setupConstraints {
  
  self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
  
  NSLayoutConstraint *tableViewLeadingConstraint = [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor];
  NSLayoutConstraint *tableViewTrailingConstraint = [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor];
  NSLayoutConstraint *tableViewTopConstraint =[self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor];
  NSLayoutConstraint *tableViewBottomConstraint = [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
  [NSLayoutConstraint activateConstraints:@[tableViewLeadingConstraint, tableViewTrailingConstraint, tableViewTopConstraint, tableViewBottomConstraint]];
  
  
}

#pragma mark - TableView data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return section == 0 ? 1 : 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentsCell" forIndexPath:indexPath];
  return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return self.webView.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  return self.webView;
}


#pragma mark - UIWebView delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
  self.webView.height = webView.scrollView.contentSize.height;
  [self.tableView reloadData];
  [self.loadingView removeFromSuperview];
}

#pragma mark - Getter & Setter
- (UITableView *)tableView {
  if (!_tableView) {
    _tableView = [[UITableView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CommentsCell"];
  }
  return _tableView;
}

- (void)setTopic:(BTTopic *)topic {
  _topic = topic;
  [self.webView loadHTMLString:topic.articleContent baseURL:nil];
}

- (UIWebView *)webView {
  if (!_webView) {
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, self.view.height)];
    _webView.delegate = self;
  }
  return _webView;
}

@end
