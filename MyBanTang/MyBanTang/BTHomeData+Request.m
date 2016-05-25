//
//  BTHomeData+Request.m
//  BangTangDemo
//
//  Created by zhangjing on 16/5/12.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTHomeData+Request.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "BTRequestParameter.h"

static NSString *kHomeDataPath = @"http://open3.bantangapp.com/recommend/index?";
@implementation BTHomeData (Request)

+ (void)fetchHomeDataWithSuccess:(void (^) (BTHomeData *))success failure:(void (^) (NSError *))failure {
  [self fetchHomeDataWithPage:0 success:success failure:failure];
}

+ (void)fetchHomeDataWithPage:(NSInteger) page success:(void (^) (BTHomeData *))success failure:(void (^) (NSError *))failure {
  NSMutableDictionary *parameters =[BTRequestParameter commonParameters].mutableCopy;
  parameters[@"page"] = @(page);
  parameters[@"pagesize"] = @(20);
  
  
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  [manager GET:kHomeDataPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable data) {
    
    BTHomeData *homeData = [BTHomeData mj_objectWithKeyValues:data[@"data"]];
    success(homeData);
    
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    failure(error);
  }];
  
}

@end
