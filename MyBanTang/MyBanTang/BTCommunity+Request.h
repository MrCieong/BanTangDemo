//
//  BTCommunity+Request.h
//  MyBanTang
//
//  Created by zhangjing on 16/5/19.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTCommunity.h"

@interface BTCommunity (Request)
+ (void)fetchCommunityDataWithSuccess:(void (^) (BTCommunity *))success failure:(void (^) (NSError *))failure;
@end
