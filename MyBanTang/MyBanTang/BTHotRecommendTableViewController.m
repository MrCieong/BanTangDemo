//
//  BTHotRecommendTableViewController.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/23.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTHotRecommendTableViewController.h"
#import "BTCommunityPostInfo.h"
#import "BTHotRecommendTableViewCell.h"
#import "Constant.h"

static NSString *kBTHotRecommendTableViewCellIdentifier = @"BTHotRecommendTableViewCell.h";

@interface BTHotRecommendTableViewController () <BTHotRecommendTableViewCellDelegate>

@end

@implementation BTHotRecommendTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  [self.tableView registerClass:[BTHotRecommendTableViewCell class] forCellReuseIdentifier:kBTHotRecommendTableViewCellIdentifier];
  self.tableView.backgroundColor = BTGobalTableViewBGColor;
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];

}


- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
 
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postInfoArray.count;
}

- (BTCommunityPostInfo *)postInfoAtIndexPath:(NSIndexPath *)indexPath {
  return self.postInfoArray[indexPath.row];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BTHotRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kBTHotRecommendTableViewCellIdentifier forIndexPath:indexPath];
    
  cell.postInfo = [self postInfoAtIndexPath:indexPath];
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return [BTHotRecommendTableViewCell cellHeightWithPostInfo:[self postInfoAtIndexPath:indexPath]];
}

#pragma mark - BTHotRecommendTableViewCellDelegate
- (void)tapAction {
  UIViewController *vc = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"BTLoginViewController"];
  [self presentViewController:vc animated:YES completion:nil];
}

@end
