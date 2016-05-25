//
//  BTProductDetailViewController.h
//  MyBanTang
//
//  Created by zhangjing on 16/5/25.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BTProduct;

@interface BTProductDetailViewController : UIViewController

@property (nonatomic, strong) BTProduct *product;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) int imageIndex;

@end
