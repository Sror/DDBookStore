//
//  AppDelegate.h
//  DuduBookStore
//
//  Created by Iceland on 14-8-4.
//  Copyright (c) 2014年 Iceland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,PPRevealSideViewControllerDelegate>

@property (strong, nonatomic) PPRevealSideViewController *revealSideViewController;
@property (strong, nonatomic) UIWindow *window;

@end
