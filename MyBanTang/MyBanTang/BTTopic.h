//
//  BTTopic.h
//  BangTangDemo
//
//  Created by zhangjing on 16/5/12.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BTUser;
@interface BTTopic : NSObject
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic,assign) BOOL isShowLike;
@property (nonatomic,assign) BOOL islike;
@property (nonatomic,assign) BOOL isComments;
@property (nonatomic, copy) NSString *likes;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *views;
@property (nonatomic, copy) NSString *comments;
@property (nonatomic, copy) NSString *createTimeStr;
@property (nonatomic, copy) NSString *orderTimeStr;
@property (nonatomic, strong) BTUser *user;
@property (nonatomic, strong) NSArray *pics;
@property (nonatomic, copy) NSString *articleContent;

@end
