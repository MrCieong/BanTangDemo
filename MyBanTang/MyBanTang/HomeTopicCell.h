//
//  HomeTopicCell.h
//  BangTangDemo
//
//  Created by zhangjing on 16/5/7.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTTopic.h"
extern NSString *kHomeTopicCellIdentifier;
@interface HomeTopicCell : UITableViewCell

@property (nonatomic, strong) BTTopic *topic;
@property (weak, nonatomic) IBOutlet UIImageView *topicImageView;
@end
