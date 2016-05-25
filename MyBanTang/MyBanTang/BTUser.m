//
//  BTUser.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/20.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTUser.h"
#import "MJExtension.h"

@implementation BTUser

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
  
  if ([propertyName isEqualToString:@"userID"]) {
    propertyName = @"user_id";
  }
  // nickName -> nick_name
  return [propertyName mj_underlineFromCamel];
}


@end
