//
//  FBNavigationController.m
//  DuduBookStore
//
//  Created by Iceland on 14-8-5.
//  Copyright (c) 2014年 Iceland. All rights reserved.
//

#import "FBNavigationController.h"
#import "AppDelegate.h"
#import "UITabBarController+HideTabBar.h"
@interface FBNavigationController ()

@end

@implementation FBNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (IOS7_OR_LATER)
    {
        [self setNavigationBarBackgroundImage:[UIImage imageNamed:@"nav64red.png"]];
    }
    else
    {
        [self setNavigationBarBackgroundImage:[UIImage imageNamed:@"nav44red.png"]];
    }
    [self.revealSideViewController setDirectionsToShowBounce:PPRevealSideDirectionLeft | PPRevealSideDirectionRight];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * @brief   设置navigation bar 的背景
 */
- (void)setNavigationBarBackgroundImage:(UIImage *)backgroundImage
{
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [self.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        self.navigationBar.layer.contents = (id)backgroundImage.CGImage;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
//    if ( [self.viewControllers count] > 1)
//    {
//        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        [delegate.tabBarController  setTabBarHidden:YES animated:YES];
//    }
}

//- (UIViewController *)popViewControllerAnimated:(BOOL)animated
//{
//    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [delegate.tabBarController  setTabBarHidden:NO animated:YES];
//    
//    return [self popViewControllerAnimated:animated];
//}
//
//- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [delegate.tabBarController  setTabBarHidden:NO animated:YES];
//    return [self popToRootViewControllerAnimated:animated];
//}


/**
 * @brief   添加返回按钮
 */
- (UIBarButtonItem *)addBackItemWithTarget:(id)target selector:(SEL)selector
{
    UIImage *backImage = [UIImage imageNamed:@"weekArrowLeft.png"];
    UIImage *backImageH = [UIImage imageNamed:@"weekArrowLeft.png"];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0.0f, 0.0f, backImage.size.width+10, backImage.size.height);
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:backImage forState:UIControlStateNormal];
    [backBtn setImage:backImageH forState:UIControlStateHighlighted];
    [backBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    return backItem;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
