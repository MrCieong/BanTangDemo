//
//  BTTopic.m
//  BangTangDemo
//
//  Created by zhangjing on 16/5/12.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTTopic.h"
#import "MJExtension.h"

@implementation BTTopic

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
  
  if ([propertyName isEqualToString:@"ID"]) {
    propertyName = @"id";
  }
  // nickName -> nick_name
  return [propertyName mj_underlineFromCamel];
}

@end
