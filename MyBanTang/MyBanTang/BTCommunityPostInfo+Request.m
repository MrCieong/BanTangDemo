//
//  BTHotRecommend+Request.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/19.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTCommunityPostInfo+Request.h"
#import "AFNetworking.h"
#import "BTRequestParameter.h"
#import "MJExtension.h"

//#define COMMUNITY_POST_BASE_URL  @"http://open3.bantangapp.com/community/post/"

static NSString *kCommunityDataPath = @"http://open3.bantangapp.com/community/post/hotRecommend?";
static NSString *kCommunityPostListByCategoryPath = @"http://open3.bantangapp.com/community/post/listByCategory?";
const int kBTCommunityPostInfoPageSize = 12;
@implementation BTCommunityPostInfo (Request)

/**
 *  获取热门推荐
 */
+ (void)fetchHotRecommendDataWithPage:(int)page success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  NSMutableDictionary *para = [BTRequestParameter commonParameters].mutableCopy;
  para[@"page"] = @(page);
  para[@"pagesize"] = @(kBTCommunityPostInfoPageSize);
  
  [manager GET:kCommunityDataPath parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable data) {
    
    NSArray *models = [BTCommunityPostInfo mj_objectArrayWithKeyValuesArray:data[@"data"]];
    success(models);
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    failure(error);
  }];
}

/**
 *  根据CategoryID获取对应的社区帖子信息列表
 */
+ (void)fetchCommunityPostInfoListByCategoryID:(NSString *)ID page:(int)page success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  NSMutableDictionary *para = [BTRequestParameter commonParameters].mutableCopy;
  
  para[@"id"] = ID;
  para[@"page"] = @(page);
  para[@"pagesize"] = @(kBTCommunityPostInfoPageSize);
  
  [manager GET:kCommunityPostListByCategoryPath parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable data) {
    
    NSArray *models = [BTCommunityPostInfo mj_objectArrayWithKeyValuesArray:data[@"data"]];
    success(models);
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    failure(error);
  }];
}

@end
