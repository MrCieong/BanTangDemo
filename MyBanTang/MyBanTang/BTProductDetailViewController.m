//
//  BTProductDetailViewController.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/25.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTProductDetailViewController.h"
#import "BTProduct.h"
#import "Constant.h"
#import "UIView+frameAdjust.h"
#import "UIImageView+YYWebImage.h"
#import "BTProductDetailTableView.h"

@interface BTProductDetailViewController () <UITableViewDataSource, UIScrollViewDelegate, UITableViewDelegate>

@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UIScrollView *topScrollView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tableHeaderView;


@end

@implementation BTProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  [self setupView];
  
}

- (void)setupView {
  self.view.backgroundColor = [UIColor whiteColor];
  self.automaticallyAdjustsScrollViewInsets = NO;
  [self.view addSubview:self.topScrollView];
  [self.view addSubview:self.tableView];
  [self.view addSubview:self.contentScrollView];
  
  self.contentScrollView.userInteractionEnabled = NO;
  [self.topScrollView addGestureRecognizer:self.contentScrollView.panGestureRecognizer];
  [self.tableView addGestureRecognizer:self.contentScrollView.panGestureRecognizer];
  [self updateView];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}




- (void)updateView {
  
  for (int i = 0; i < _images.count; i++) {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake( i * kScreen_Width, 0, kScreen_Width, kScreen_Width)];
    imageView.image = _images[i];
    [self.topScrollView addSubview:imageView];
  }
  self.topScrollView.contentSize = CGSizeMake(_images.count * kScreen_Width, kScreen_Width);
  self.topScrollView.contentOffset = CGPointMake(_imageIndex * kScreen_Width, 0);
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
  return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (indexPath.row == 19) {
    cell.contentView.backgroundColor = [UIColor blueColor];
  }
  
  self.contentScrollView.contentSize = CGSizeMake(kScreen_Width, self.topScrollView.height + self.tableView.contentSize.height);
}

#pragma mark - Setter & Getter
- (UIScrollView *)contentScrollView {
  if (!_contentScrollView) {
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    _contentScrollView.delegate = self;
  }
  return _contentScrollView;
}

- (UIScrollView *)topScrollView {
  if (!_topScrollView) {
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width)];
    _topScrollView.showsHorizontalScrollIndicator = NO;
    _topScrollView.showsVerticalScrollIndicator = NO;
    _topScrollView.layer.zPosition = -1;
    _topScrollView.pagingEnabled = YES;
  }
  return _topScrollView;
}

-(UITableView *)tableView {
  if (!_tableView) {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topScrollView.tail, kScreen_Width, kScreen_Height)];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = [UIView new];
  }
  return _tableView;
}

- (UIView *)tableHeaderView {
  if (!_tableHeaderView) {
    
  }
  return _tableHeaderView;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//  self.tableView.contentOffset = CGPointMake(0, self.contentScrollView.contentOffset.y) ;
  CGFloat offsetY =  self.contentScrollView.contentOffset.y;
  NSLog(@"offsetY: %f", offsetY);
  if (offsetY <= kScreen_Width) {
    self.tableView.y = kScreen_Width - offsetY;
  }
  
}

@end
