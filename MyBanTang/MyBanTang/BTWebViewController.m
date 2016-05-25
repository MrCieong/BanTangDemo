//
//  BTWebViewController.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/19.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTWebViewController.h"
#import "Constant.h"

@interface BTWebViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation BTWebViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.view addSubview:self.webView];
  
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"calendar_close_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(closeAction)];
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
      [self.webView loadRequest:request];
    
  });
  
}


- (UIWebView *)webView {
  if (!_webView) {
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
  }
  return _webView;
}

- (void)closeAction {
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
