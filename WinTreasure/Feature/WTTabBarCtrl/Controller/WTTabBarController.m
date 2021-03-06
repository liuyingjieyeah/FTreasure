//
//  WTTabBarController.m
//  WinTreasure
//
//  Created by Apple on 16/5/31.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "WTTabBarController.h"
#import "WinTreasureViewController.h"
#import "LatestPubViewController.h"
#import "DiscoveryViewController.h"
#import "ShoppingListViewController.h"
#import "MeViewController.h"
#import "LoginViewController.h"

@interface WTTabBarController () <UITabBarControllerDelegate>

@property (nonatomic, strong) NSMutableArray *controllerArray;

@end

@implementation WTTabBarController

#pragma mark - lazy load
- (NSMutableArray *)controllerArray {
    if (!_controllerArray) {
        _controllerArray = [NSMutableArray array];
    }
    return _controllerArray;
}

#pragma mark - view cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    WinTreasureViewController *winTreasureVC = [[WinTreasureViewController alloc]init];
    winTreasureVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"夺宝" image:[UIImage imageNamed:@"tabbar_firstItem_25x25_"] selectedImage:[[UIImage imageNamed:@"tabbar_firstItem_selected_25x25_"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    BaseNavigationController *winTreasureNav = [[BaseNavigationController alloc]initWithRootViewController:winTreasureVC];
    
    LatestPubViewController *latestPubVC = [[LatestPubViewController alloc]init];
    latestPubVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"最新揭晓" image:[UIImage imageNamed:@"tabbar_secondItem_25x25_"] selectedImage:[[UIImage imageNamed:@"tabbar_secondItem_selected_25x25_"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    BaseNavigationController *latestPubNav = [[BaseNavigationController alloc]initWithRootViewController:latestPubVC];
    
    DiscoveryViewController *discoveryVC = [[DiscoveryViewController alloc]init];
    discoveryVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"发现" image:[UIImage imageNamed:@"tabbar_discovery_25x25_"] selectedImage:[[UIImage imageNamed:@"tabbar_discovery_selected_25x25_"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    BaseNavigationController *discoveryNav = [[BaseNavigationController alloc]initWithRootViewController:discoveryVC];
    
    ShoppingListViewController *shoppingVC = [[ShoppingListViewController alloc]
                                              init];
    shoppingVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"清单" image:[UIImage imageNamed:@"tabbar_forthItem_25x25_"] selectedImage:[[UIImage imageNamed:@"tabbar_forthItem_selected_25x25_"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    BaseNavigationController *shoppingNav = [[BaseNavigationController alloc]initWithRootViewController:shoppingVC];
    
    MeViewController *meVC = [[MeViewController alloc]init];
    meVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我" image:[UIImage imageNamed:@"tabbar_fifthItem_25x25_"] selectedImage:[[UIImage imageNamed:@"tabbar_fifthItem_selected_25x25_"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    BaseNavigationController *meNav = [[BaseNavigationController alloc]initWithRootViewController:meVC];
    
    self.viewControllers = @[winTreasureNav,latestPubNav,discoveryNav,shoppingNav,meNav];
    
}

- (BaseNavigationController *)subControllerFor:(nullable Class)aClass {
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:[[aClass alloc]init]];
    return nav;
}


@end
