//
//  AppDelegate.m
//  DuduBookStore
//
//  Created by Iceland on 14-8-4.
//  Copyright (c) 2014年 Iceland. All rights reserved.
//

#import "AppDelegate.h"
#import "FBNavigationController.h"
#import "DDBookshelfVC.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor lightGrayColor];
    
    //设置状态栏为白色字体
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.window makeKeyAndVisible];
    
    self.window = PP_AUTORELEASE([[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]);
    DDBookshelfVC *main = [[DDBookshelfVC alloc] initWithNibName:@"DDBookshelfVC" bundle:nil];
    FBNavigationController *nav = [[FBNavigationController alloc] initWithRootViewController:main];
    _revealSideViewController = [[PPRevealSideViewController alloc] initWithRootViewController:nav];
    _revealSideViewController.panInteractionsWhenClosed = PPRevealSideInteractionContentView;
    _revealSideViewController.panInteractionsWhenOpened = PPRevealSideInteractionContentView;
    _revealSideViewController.delegate = self;
//    _revealSideViewController.popFromPanGesture = YES;

    [self.window setRootViewController:_revealSideViewController];
    PP_RELEASE(main);
    PP_RELEASE(nav);
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    if (PPSystemVersionGreaterOrEqualThan(7.0)) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [[UINavigationBar appearance] setBarTintColor:[FBUtils colorWithHexString:@"34B085"]];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    }
    
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
