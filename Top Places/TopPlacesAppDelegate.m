//
//  TopPlacesAppDelegate.m
//  Top Places
//
//  Created by Maynard Tong on 6/11/13.
//  Copyright (c) 2013 Maynard Tong. All rights reserved.
//

#import "TopPlacesAppDelegate.h"
#import "TopPlacesFlickrTableViewController.h"
#import "FlickrFetcher.h"
#import "RecentListTableViewController.h"

@implementation TopPlacesAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.tabBarController = [[UITabBarController alloc] init];    // Override point for customization after application launch.
    UINavigationController *navConMain;
    UINavigationController *navConRecent;

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        TopPlacesFlickrTableViewController *tpfTableViewController = [[TopPlacesFlickrTableViewController alloc]initWithNibName:@"TopPlacesFlickerPhotoTableViewController" bundle:nil];
        RecentListTableViewController *recentListTableViewController = [[RecentListTableViewController alloc]initWithNibName:@"TopPlacesFlickerPhotoTableViewController" bundle:nil];;

      
        navConRecent = [[UINavigationController alloc] initWithRootViewController:recentListTableViewController];
        navConMain = [[UINavigationController alloc] initWithRootViewController:tpfTableViewController];
    } 
    self.tabBarController.viewControllers = @[navConMain,navConRecent];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
