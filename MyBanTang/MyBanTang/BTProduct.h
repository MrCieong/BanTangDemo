//
//  BTProduct.h
//  BanTangDemo
//
//  Created by zhangjing on 16/5/17.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//"id": "11373",
//"topic_id": "793",
//"category": 11,
//"title": "韩国可瑞安 芝士夹心薄脆饼",
//"desc": "醇香的芝士，香香脆脆的饼干，一口咬下，饼干的香酥，奶酪的冰爽细腻，还有淡淡的芝士香萦绕齿间，完全不会腻味！",
//"price": "5.2",
//"url": "ADwwNxnargSLkWZAiUwLoYpHb4uFWhxW44Axg9%2BwLxNAlp4GqJn5AyUbPoV&unid=bantangapp",
//"iscomments": false,
//"comments": "3",
//"islike": false,
//"likes": "2897",
//"item_id": "520833683346",
//"platform": "1",
//"pic":
//"likes_list"
@interface BTProduct : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger topicId;
@property (nonatomic, assign) NSInteger category;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *likes;
@property (nonatomic, copy) NSString *comments;
@property (nonatomic, copy) NSString *item_id;
@property (nonatomic, copy) NSArray *pic;
@property (nonatomic, copy) NSArray *likesList;
@property (nonatomic, copy) NSArray *likes_list;

@property (nonatomic, assign) CGFloat titleHeight;
@property (nonatomic, assign) CGFloat descHeight;
@property (nonatomic, assign) CGFloat picsHeight;
@property (nonatomic, assign) CGFloat priceHeight;

@property (nonatomic, assign) CGFloat height;

@end
