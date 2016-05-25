//
//  BTProductCell.h
//  BanTangDemo
//
//  Created by zhangjing on 16/5/17.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BTProductCellDelegate <NSObject>

- (void)didSelectedBuyButtonWithCellIndexPath:(NSIndexPath *)indexPath;
- (void)tappedImageViewWithCellIndexPath:(NSIndexPath *)indexPath imageIndex:(int)index images:(NSArray *)imageView;

@end

@class BTProduct;
@interface BTProductCell : UITableViewCell

@property (nonatomic, strong, readonly) NSArray *imageViews;
@property (nonatomic, strong) BTProduct *product;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id<BTProductCellDelegate> delegate;

+ (CGFloat)getCellHeightWithProduct:(BTProduct *)product;

+ (CGFloat)heightWithProduct:(BTProduct *)product;
@end
