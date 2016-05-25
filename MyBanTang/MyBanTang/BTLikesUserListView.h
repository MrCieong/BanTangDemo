//
//  BTLikesUserListView.h
//  MyBanTang
//
//  Created by zhangjing on 16/5/18.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTLikesUserListView : UIView

- (instancetype)initWithFrame:(CGRect)frame likesList:(NSArray *)likesList likesString:(NSString *)likesString;

+ (CGFloat)likesUserListViewHeight;
@end
