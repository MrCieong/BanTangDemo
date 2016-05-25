//
//  ZJScrollTitleView.h
//  ScrollTitleView
//
//  Created by zhangjing on 16/5/23.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZJScrollTitleViewDelegate <NSObject>

- (void)didSelectedTitleLabelIndex:(int)index;

@end

@interface ZJScrollTitleView : UIView
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, weak) id<ZJScrollTitleViewDelegate> delegate;
@end
