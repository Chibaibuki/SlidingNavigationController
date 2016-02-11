//
//  AppDelegate.m
//  SlidingNavigationController
//
//  Created by 高向孚 on 16/2/7.
//  Copyright © 2016年 ByStudio. All rights reserved.
//

#import "AppDelegate.h"
#import "SlidingNavigationViewController.h"
#import "ContentPageViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    NSArray * labelArray = [[NSArray alloc]initWithObjects:@"周报",@"月报",@"季报",nil];
    ContentPageViewController * contentVC1 = [[ContentPageViewController alloc]init];
    [contentVC1 setTitle:@"vc1"];
    ContentPageViewController * contentVC2 = [[ContentPageViewController alloc]init];
    [contentVC2 setTitle:@"vc2"];
    ContentPageViewController * contentVC3 = [[ContentPageViewController alloc]init];
    [contentVC3 setTitle:@"vc3"];
    
    NSArray * viewControllerArray = [[NSArray alloc]initWithObjects:contentVC1,contentVC2,contentVC3, nil];
    SlidingNavigationViewController * avc = [SlidingNavigationViewController initWithLabelArray:labelArray ViewControllerArray:viewControllerArray];
    
    [avc setGapWidth:10];
    [self.window setRootViewController:avc];
    
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
