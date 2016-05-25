//
//  BTHotRecommend.h
//  MyBanTang
//
//  Created by zhangjing on 16/5/19.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BTUser;
@interface BTCommunityPostInfo : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *authorId;
@property (nonatomic, copy) NSString *relationId;
@property (nonatomic, copy) NSString *shareUrl;
@property (nonatomic, copy) NSString *isRecommend;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *publishTime;
@property (nonatomic, copy) NSString *datetime;
@property (nonatomic, copy) NSString *datestr;
@property (nonatomic, copy) NSString *miniPicUrl;
@property (nonatomic, copy) NSString *middlePicUrl;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) BTUser *author;
@property (nonatomic, strong) NSArray *pics;
@property (nonatomic, strong) NSDictionary *dynamic;
@property (nonatomic, strong) NSArray *product;
@property (nonatomic, strong) NSArray *comments;

@property (nonatomic, assign) CGFloat height;

@end
