//
//  BTMineViewController.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/26.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTMineViewController.h"

@interface BTMineViewController ()

@end

@implementation BTMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  UIViewController *vc = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"BTLoginViewController"];
  [self presentViewController:vc animated:YES completion:^{
    self.tabBarController.selectedIndex = 1;
  }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
