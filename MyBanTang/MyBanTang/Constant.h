//
//  Constant.h
//  BangTangDemo
//
//  Created by zhangjing on 16/5/7.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//


#ifndef Constant_h
#define Constant_h
#define BTGobalRedColor kUIColorFromRGB(0xec5252)
#define BTGobalTableViewBGColor kUIColorFromRGB(0xf1f1f1)
#define BTGobalTextTitleColor kUIColorFromRGB(0xFF666666)
#define BTGobalTextContentColor kUIColorFromRGB(0xFF727272)
#define kBaseURL @"http://open3.bantangapp.com/"

#define BTColor(r,g,b) [UIColor  colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define kUIColorFromRGB(rgbValue) [UIColor                \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0           \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kScreen_Height   ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Width    ([UIScreen mainScreen].bounds.size.width)

// iOS8的字体
#define BTFont(_size_) [UIFont fontWithName:@"FZLanTingHei-L-GBK" size:_size_]

#define kUserInfoPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) \
lastObject] stringByAppendingPathComponent:@"userInfo.plist"]

#define kAppInfoPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) \
lastObject] stringByAppendingPathComponent:@"appInfo.plist"]


#endif /* Constant_h */
