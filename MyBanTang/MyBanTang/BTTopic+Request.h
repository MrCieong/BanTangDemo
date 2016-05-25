//
//  BTTopic+Request.h
//  MyBanTang
//
//  Created by zhangjing on 16/5/20.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTTopic.h"

extern const int kBTTopicPageSize;
@interface BTTopic (Request)

+ (void)fetchTopicsDataWithPage:(int)page success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure;
+ (void)fetchTopicDataWithID:(NSInteger)ID success:(void (^)(BTTopic *))success failure:(void (^)(NSError *))failure;
+ (void)fetchTopicsDataWithIDs:(NSString *)IDs success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure;
@end
