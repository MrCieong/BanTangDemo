//
//  BTNewInfo+Request.m
//  BanTangDemo
//
//  Created by zhangjing on 16/5/14.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTNewInfo+Request.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "BTRequestParameter.h"
static NSString *kNewInfoPath = @"http://open3.bantangapp.com/topic/newInfo?";
@implementation BTNewInfo (Request)

+ (void)fetchNewInfoWithID:(NSInteger)ID success:(void (^) (BTNewInfo *))success failure:(void (^) (NSError *))failure {
  NSMutableDictionary *parameters = [BTRequestParameter commonParameters].mutableCopy;
  parameters[@"id"] = @(ID);
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  [manager GET:kNewInfoPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    BTNewInfo *newInfo = [BTNewInfo mj_objectWithKeyValues:responseObject[@"data"]];
    success(newInfo);
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    failure(error);
  }];
}

@end
