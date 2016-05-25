//
//  BTBanner.h
//  BangTangDemo
//
//  Created by zhangjing on 16/5/12.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTBanner : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *sub_title;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *topic_type;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *extend;
@property (nonatomic, assign) NSInteger index;

@end
