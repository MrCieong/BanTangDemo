//
//  AppDelegate.m
//  BanTangDemo
//
//  Created by zhangjing on 16/5/16.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "AppDelegate.h"
#import "Constant.h"
#import "UIImage+RenderedImage.h"
#import "CYLTabBarControllerConfig.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  
  [self setupStyle];
  return YES;
}

- (void)setupWindow {
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  self.window.backgroundColor = [UIColor whiteColor];
  self.window.rootViewController = [CYLTabBarControllerConfig new].tabBarController;
  [self.window makeKeyAndVisible];

}

- (void)setupStyle {
  [UITabBar appearance].tintColor = BTGobalRedColor;
  [UITabBar appearance].translucent = NO;
  //  [UINavigationBar appearance].translucent = NO;
  [UINavigationBar appearance].barTintColor = [UIColor whiteColor];
  
  //设置导航栏返回字体颜色
  [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor clearColor]} forState:UIControlStateNormal];
  //设置导航栏返回按钮颜色
  [UINavigationBar appearance].tintColor = BTGobalRedColor;
  
  
  [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : BTGobalTextTitleColor}];
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
