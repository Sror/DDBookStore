//
//  FBViewController.h
//  DuduBookStore
//
//  Created by Iceland on 14-8-5.
//  Copyright (c) 2014年 Iceland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UITabBarController+HideTabBar.h"
@interface FBViewController : UIViewController


@property (nonatomic,copy)NSString *titleName;
#pragma mark - 导航栏
- (UIBarButtonItem *)createNavLeftBtnItemNormal:(NSString *)imgStr highlight:(NSString *)highStr;
- (UIBarButtonItem *)createNavRightBtnItem:(UIViewController *)target normal:(NSString *)imgStr highlight:(NSString *)highStr;
- (void)addRightNavToShelter;

@end
