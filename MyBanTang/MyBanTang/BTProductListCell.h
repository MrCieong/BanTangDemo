//
//  BTProductListCell.h
//  MyBanTang
//
//  Created by zhangjing on 16/5/23.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BTTopic;
extern NSString *kBTProductListCellIdentifier;
@interface BTProductListCell : UITableViewCell

@property (nonatomic, strong) BTTopic *topic;
@property (weak, nonatomic) IBOutlet UIImageView *topicImageView;
@end
