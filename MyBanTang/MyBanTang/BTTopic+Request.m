//
//  BTTopic+Request.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/20.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTTopic+Request.h"
#import "AFNetworking.h"
#import "BTRequestParameter.h"
#import "MJExtension.h"

static NSString *kTopicsListByUsersPath = @"http://open3.bantangapp.com/topics/topic/listByUsers?";
static NSString *kTopicNewInfoPath = @"http://open3.bantangapp.com/topic/newInfo?";
static NSString *kTopicesListByIdsPath = @"http://open3.bantangapp.com/topics/topic/listByIds?";
const int kBTTopicPageSize = 20;
@implementation BTTopic (Request)



/**
 *  获取热门推荐
 */
+ (void)fetchTopicsDataWithPage:(int)page success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  NSMutableDictionary *para = [BTRequestParameter commonParameters].mutableCopy;
  para[@"page"] = @(page);
  para[@"pagesize"] = @(kBTTopicPageSize);
  
  [manager GET:kTopicsListByUsersPath parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable data) {
    
    NSArray *models = [BTTopic mj_objectArrayWithKeyValuesArray:data[@"data"][@"topic"]];
    success(models);
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    failure(error);
  }];
}

+ (void)fetchTopicDataWithID:(NSInteger)ID success:(void (^)(BTTopic *))success failure:(void (^)(NSError *))failure {
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  NSMutableDictionary *para = [BTRequestParameter commonParameters].mutableCopy;
  para[@"id"] = @(ID);
  
  [manager GET:kTopicNewInfoPath parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable data) {
    
    BTTopic *model = [BTTopic mj_objectWithKeyValues:data[@"data"]];
    success(model);
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    failure(error);
  }];
}

+ (void)fetchTopicsDataWithIDs:(NSString *)IDs success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  NSMutableDictionary *para = [BTRequestParameter commonParameters].mutableCopy;
  para[@"ids"] = IDs;
  
  [manager GET:kTopicesListByIdsPath parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable data) {
    
    NSArray *models = [BTTopic mj_objectArrayWithKeyValuesArray:data[@"data"][@"topic"]];
    success(models);
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    failure(error);
  }];
}


@end
