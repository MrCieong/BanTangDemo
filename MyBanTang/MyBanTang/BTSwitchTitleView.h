//
//  BTSwitchTitleView.h
//  MyBanTang
//
//  Created by zhangjing on 16/5/21.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BTSwitchedBlock) (NSUInteger);

@interface BTSwitchTitleView : UIView

@property (nonatomic, copy) BTSwitchedBlock switchedBlock;

@end
