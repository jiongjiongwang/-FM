//
//  AppDelegate.m
//  豆瓣FM
//
//  Created by 王炯 on 16/7/14.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "AppDelegate.h"
#import "JASidePanelController.h"
#import "HomeController.h"
#import "LeftController.h"


@interface AppDelegate ()

//使用第三方框架类实例化可以侧滑的控制
@property (nonatomic,strong) JASidePanelController *viewController;



@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //(1)实例化window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //(2)实例化主viewController
    self.viewController = [[JASidePanelController alloc]init];
    
    //向左滑时的界面
    LeftController *leftVC = [[LeftController alloc] init];
    
    self.viewController.leftPanel = leftVC;
    
    
    //向右滑时的主界面
    HomeController *homeVC = [[HomeController alloc] init];
    
    self.viewController.centerPanel = [[UINavigationController alloc]initWithRootViewController:homeVC];
    
    
    //(3)设置主viewController
    self.window.rootViewController = self.viewController;
    
    
    //(4)window显示
    [self.window makeKeyAndVisible];
    
    
    return YES;
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
