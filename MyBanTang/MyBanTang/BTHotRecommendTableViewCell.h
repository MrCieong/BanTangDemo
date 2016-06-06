//
//  BTHotRecommendTableViewCell.h
//  MyBanTang
//
//  Created by zhangjing on 16/5/23.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BTCommunityPostInfo;

@protocol BTHotRecommendTableViewCellDelegate <NSObject>

- (void)tapAction;

@end

@interface BTHotRecommendTableViewCell : UITableViewCell

@property (nonatomic, strong) BTCommunityPostInfo *postInfo;

@property (nonatomic, weak) id<BTHotRecommendTableViewCellDelegate> delegate;

+ (CGFloat)cellHeightWithPostInfo:(BTCommunityPostInfo *)postInfo;

@end
