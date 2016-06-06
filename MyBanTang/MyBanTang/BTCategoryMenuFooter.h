//
//  BTCategoryCollectionFooter.h
//  MyBanTang
//
//  Created by zhangjing on 16/5/20.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BTCategory;
@protocol BTCategoryMenuFooterDelegate <NSObject>

- (void)didSelectMenuButtonWithCategate:(BTCategory *)category;

@end

@interface BTCategoryMenuFooter : UICollectionReusableView

@property (nonatomic, strong) NSArray *categorys;
@property (nonatomic, weak) id<BTCategoryMenuFooterDelegate> delegate;
+ (CGFloat)categoryFooterHeightByCategorysCount:(int)count;
@end
