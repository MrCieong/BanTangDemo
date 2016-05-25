//
//  BTHomeData+Request.h
//  BangTangDemo
//
//  Created by zhangjing on 16/5/12.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTHomeData.h"

@interface BTHomeData (Request)
+ (void)fetchHomeDataWithSuccess:(void (^) (BTHomeData *))success failure:(void (^) (NSError *))failure;
+ (void)fetchHomeDataWithPage:(NSInteger) page success:(void (^) (BTHomeData *))success failure:(void (^) (NSError *))failure;
@end
