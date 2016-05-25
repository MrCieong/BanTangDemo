//
//  BTHotRecommend+Request.h
//  MyBanTang
//
//  Created by zhangjing on 16/5/19.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTCommunityPostInfo.h"

extern const int kBTCommunityPostInfoPageSize;

@interface BTCommunityPostInfo (Request)

+ (void)fetchHotRecommendDataWithPage:(int)page success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure;
/**
 *  根据CategoryID获取对应的社区帖子信息列表
 */
+ (void)fetchCommunityPostInfoListByCategoryID:(NSString *)ID page:(int)page success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure;
@end
