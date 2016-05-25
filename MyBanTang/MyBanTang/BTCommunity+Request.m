//
//  BTCommunity+Request.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/19.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTCommunity+Request.h"
#import "AFNetWorking.h"
#import "MJExtension.h"
#import "BTRequestParameter.h"

static NSString *kCommunityDataPath = @"http://open3.bantangapp.com/community/post/index?";
@implementation BTCommunity (Request)
+ (void)fetchCommunityDataWithSuccess:(void (^)(BTCommunity *))success failure:(void (^)(NSError *))failure {
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  [manager GET:kCommunityDataPath parameters:[BTRequestParameter commonParameters] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable data) {
    BTCommunity *model = [BTCommunity mj_objectWithKeyValues:data[@"data"]];
    success(model);
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    failure(error);
  }];
}



@end
