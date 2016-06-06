//
//  BTLoginViewController.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/26.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTLoginViewController.h"

@interface BTLoginViewController ()

@end

@implementation BTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapClossButton:(id)sender {
  [self dismissViewControllerAnimated:YES completion:^{
    
  }];
}

- (IBAction)tapWexinLogin:(id)sender {
}

- (IBAction)tapWeiboLogin:(id)sender {
}
- (IBAction)tapQQLogin:(id)sender {
}

@end
