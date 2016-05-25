//
//  BTSwitchTitleView.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/21.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTSwitchTitleView.h"
#import "Constant.h"
#import "UIView+frameAdjust.h"

@interface BTSwitchTitleView ()
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (strong, nonatomic) UIButton *tmpButton;
@property (weak, nonatomic) IBOutlet UIView *underBarView;

@end

@implementation BTSwitchTitleView

- (void)awakeFromNib {
  [super awakeFromNib];
  
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];
  if (self.tmpButton == nil) {
    self.tmpButton = self.button1;
    self.tmpButton.selected = YES;
    
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  CGPoint tmp = self.underBarView.center;
  tmp.x = self.tmpButton.center.x;
  self.underBarView.center = tmp;
  
}

- (IBAction)didSelected:(UIButton *)sender {
  self.tmpButton.selected = NO;
  sender.selected = YES;
  self.tmpButton = sender;
  [UIView animateWithDuration:0.3 animations:^{
    CGPoint tmp = self.underBarView.center;
    tmp.x = sender.center.x;
    self.underBarView.center = tmp;
  }];
  
  if (self.switchedBlock) {
    self.switchedBlock(sender.tag - 520);
  }
  
}

@end
