//
//  CYLTabBarControllerConfig.m
//  CYLTabBarController
//
//  Created by 微博@iOS程序犭袁 ( http://weibo.com/luohanchenyilong/ ) on 10/20/15.
//  Copyright © 2015 https://github.com/ChenYilong . All rights reserved.
//
#import "CYLTabBarControllerConfig.h"

@import Foundation;
@import UIKit;
@interface CYLBaseNavigationController : UINavigationController
@end
@implementation CYLBaseNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end


@interface CYLTabBarControllerConfig ()

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@end

@implementation CYLTabBarControllerConfig

/**
 *  lazy load tabBarController
 *
 *  @return CYLTabBarController
 */
- (CYLTabBarController *)tabBarController {
    if (_tabBarController == nil) {
      UIViewController *homeVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeTableViewController"];
        UIViewController *firstNavigationController = [[CYLBaseNavigationController alloc]
                                                       initWithRootViewController:homeVC];
        
      
        UIViewController *communityVC = [[UIStoryboard storyboardWithName:@"Community" bundle:nil] instantiateViewControllerWithIdentifier:@"BTTopicsListViewController"];
        UIViewController *secondNavigationController = [[CYLBaseNavigationController alloc]
                                                        initWithRootViewController:communityVC];
        
        UIViewController *vc3 = [[UIViewController alloc] init];
        UIViewController *thirdNavigationController = [[CYLBaseNavigationController alloc]
                                                       initWithRootViewController:vc3];
        
        UIViewController *vc4 = [[UIViewController alloc] init];
        UIViewController *fourthNavigationController = [[CYLBaseNavigationController alloc]
                                                        initWithRootViewController:vc4];
        CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
      for (UITabBarItem *item in tabBarController.tabBar.items) {
        item.imageInsets = UIEdgeInsetsMake(4.5, 0, -4.5, 0);
      }
        // 在`-setViewControllers:`之前设置TabBar的属性，设置TabBarItem的属性，包括 title、Image、selectedImage。
        [self setUpTabBarItemsAttributesForController:tabBarController];
      
    
        [tabBarController setViewControllers:@[
                                               firstNavigationController,
                                               secondNavigationController,
                                               thirdNavigationController,
                                               fourthNavigationController
                                               ]];
        // 更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性
//        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

/**
 *  在`-setViewControllers:`之前设置TabBar的属性，设置TabBarItem的属性，包括 title、Image、selectedImage。
 */
- (void)setUpTabBarItemsAttributesForController:(CYLTabBarController *)tabBarController {
    
  NSDictionary *dict1 = @{
//                          CYLTabBarItemTitle : @"",
                          CYLTabBarItemImage : @"tab_首页",
                          CYLTabBarItemSelectedImage : @"tab_首页_pressed",
                          };
  NSDictionary *dict2 = @{
//                          CYLTabBarItemTitle : @"",
                          CYLTabBarItemImage : @"tab_社区",
                          CYLTabBarItemSelectedImage : @"tab_社区_pressed",
                          };
  NSDictionary *dict3 = @{
//                          CYLTabBarItemTitle : @"",
                          CYLTabBarItemImage : @"tab_分类",
                          CYLTabBarItemSelectedImage : @"tab_分类_pressed",
                          };
  NSDictionary *dict4 = @{
//                          CYLTabBarItemTitle : @"",
                          CYLTabBarItemImage : @"tab_我的",
                          CYLTabBarItemSelectedImage : @"tab_我的_pressed"
                          };
  NSArray *tabBarItemsAttributes = @[ dict1, dict2, dict3, dict4 ];
  tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}

///**
// *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性
// */
//- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
//#warning CUSTOMIZE YOUR TABBAR APPEARANCE
//    // set the text color for unselected state
//    // 普通状态下的文字属性
//    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
//    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    
//    // set the text color for selected state
//    // 选中状态下的文字属性
//    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
//    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
//    
//    // set the text Attributes
//    // 设置文字属性
//    UITabBarItem *tabBar = [UITabBarItem appearance];
//    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
//    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
//    
//    // Set the dark color to selected tab (the dimmed background)
//    // TabBarItem选中后的背景颜色
//    //    [self customizeTabBarSelectionIndicatorImage];
//    
//    // update TabBar when TabBarItem width did update
//    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight， remove the comment '//'
//    //如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
//    //    [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
//    
//    // set the bar shadow image
//    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
//    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
//    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
//    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
//    
//    // set the bar background image
//    // 设置背景图片
//    //     UITabBar *tabBarAppearance = [UITabBar appearance];
//    //     [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_background"]];
//    
//    //remove the bar system shadow image
//    //去除 TabBar 自带的顶部阴影
//    //    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
//}
//
//- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
//    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
//        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
//        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
//            NSLog(@"Landscape Left or Right !");
//        } else if (orientation == UIDeviceOrientationPortrait){
//            NSLog(@"Landscape portrait!");
//        }
//        [self customizeTabBarSelectionIndicatorImage];
//    };
//    [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification
//                                                      object:nil
//                                                       queue:[NSOperationQueue mainQueue]
//                                                  usingBlock:deviceOrientationDidChangeBlock];
//}
//
//- (void)customizeTabBarSelectionIndicatorImage {
//    ///Get initialized TabBar Height if exists, otherwise get Default TabBar Height.
//    UITabBarController *tabBarController = [self cyl_tabBarController] ?: [[UITabBarController alloc] init];
//    CGFloat tabBarHeight = tabBarController.tabBar.frame.size.height;
//    CGSize selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, tabBarHeight);
//    //Get initialized TabBar if exists.
//    UITabBar *tabBar = [self cyl_tabBarController].tabBar ?: [UITabBar appearance];
//    [tabBar setSelectionIndicatorImage:
//     [[self class] imageWithColor:[UIColor redColor]
//                             size:selectionIndicatorImageSize]];
//}
//
//+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
//    if (!color || size.width <= 0 || size.height <= 0) return nil;
//    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
//    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, color.CGColor);
//    CGContextFillRect(context, rect);
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
//}
//
//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

@end
