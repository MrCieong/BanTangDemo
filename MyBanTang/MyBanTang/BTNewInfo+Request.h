//
//  BTNewInfo+Request.h
//  BanTangDemo
//
//  Created by zhangjing on 16/5/14.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTNewInfo.h"

@interface BTNewInfo (Request)

+ (void)fetchNewInfoWithID:(NSInteger)ID success:(void (^) (BTNewInfo *))success failure:(void (^) (NSError *))failure;

@end
