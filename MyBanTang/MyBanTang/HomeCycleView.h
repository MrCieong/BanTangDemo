//
//  HomeCycleView.h
//  BangTangDemo
//
//  Created by zhangjing on 16/5/11.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTBanner.h"

@protocol HomeCycleViewDelegate <NSObject>

- (void)didSelectedBanner:(BTBanner *)banner;

@end

@interface HomeCycleView : UIView

@property (nonatomic, strong) NSArray *banners;
@property (nonatomic, weak) id<HomeCycleViewDelegate> delegate;

@end
