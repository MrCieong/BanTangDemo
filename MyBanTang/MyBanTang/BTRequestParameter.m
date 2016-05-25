//
//  BTRequestParameter.m
//  BanTangDemo
//
//  Created by zhangjing on 16/5/14.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTRequestParameter.h"
const NSString *kBaseURL = @"http://open3.bantangapp.com/";
@implementation BTRequestParameter
+ (NSDictionary *)commonParameters {
  NSMutableDictionary *dict = [NSMutableDictionary new];
  dict[@"app_id"] = @"com.jzyd.BanTang";
  dict[@"app_installtime"] = @(1462985294);
  dict[@"app_versions"] = @(5.7);
  dict[@"channel_name"] = @"appStore";
  dict[@"client_id"] = @"bt_app_ios";
  dict[@"client_secret"] = @"9c1e6634ce1c5098e056628cd66a17a5";
  dict[@"last_get_time"] = @(1463238932);
  dict[@"os_versions"] = @"9.3.1";
  dict[@"screensize"] = @(750);
  dict[@"track_device_info"] = @"iPhone8";
  dict[@"track_deviceid"] = @"476C2ABB-9058-4621-930B-158CBB91354B";
  dict[@"v"] = @(12);
  
  return dict.copy;
}

@end
