//
//  BTUser.h
//  MyBanTang
//
//  Created by zhangjing on 16/5/20.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTUser : NSObject
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, assign) NSInteger isOfficial;

@end
