//
//  BTNewInfo.h
//  BanTangDemo
//
//  Created by zhangjing on 16/5/14.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface BTNewInfo : NSObject
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger category;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic,assign) BOOL islike;
@property (nonatomic, copy) NSString *likes;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *productPicHost;
@property (nonatomic, copy) NSString *userAvatrHost;
@property (nonatomic, copy) NSString *shareUrl;
@property (nonatomic, copy) NSString *sharePic;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, strong) NSDictionary *activity;
@property (nonatomic, strong) NSArray *product;

@end
