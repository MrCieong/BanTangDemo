//
//  BTHotRecommend.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/19.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTCommunityPostInfo.h"
#import "MJExtension.h"

@implementation BTCommunityPostInfo

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
  
  if ([propertyName isEqualToString:@"ID"]) {
    propertyName = @"id";
  }
  // nickName -> nick_name
  return [propertyName mj_underlineFromCamel];
}

@end
