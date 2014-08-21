//
//  FBViewController.m
//  DuduBookStore
//
//  Created by Iceland on 14-8-5.
//  Copyright (c) 2014年 Iceland. All rights reserved.
//

#import "FBViewController.h"
@interface FBViewController ()

@end

@implementation FBViewController

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
    
    UILabel *t = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    t.font = [UIFont systemFontOfSize:18];
    t.textColor = [UIColor whiteColor];
    t.backgroundColor = [UIColor clearColor];
    t.textAlignment = NSTextAlignmentCenter;
    t.text = _titleName;
    self.title = _titleName;
    
    /*iOS7 navTitle默认是黑色，此代码把它改为白色，
     iOS6 不能这么设置，设置的话，应用内跳转AppStore的时候容易崩溃
     */
    if (IOS7_OR_LATER) {
        [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:19], NSFontAttributeName,nil]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

//自定义导航栏左边的按钮
- (UIBarButtonItem *)createNavLeftBtnItemNormal:(NSString *)imgStr highlight:(NSString *)highStr
{
    return [self createNavBtnItem:nil normal:imgStr highlight:highStr selector:nil];
}

//自定义导航栏右边的按钮
- (UIBarButtonItem *)createNavRightBtnItem:(UIViewController *)target normal:(NSString *)imgStr highlight:(NSString *)highStr
{
    return [self createNavBtnItem:target normal:imgStr highlight:highStr selector:@selector(rightNavigationBarItemClicked)];
}

- (UIBarButtonItem *)createNavBtnItem:(UIViewController *)target normal:(NSString *)imgStr highlight:(NSString *)highStr selector:(SEL)selector
{
    UIImage *btnImage = [UIImage imageNamed:imgStr];
    UIImage *btnImageH = [UIImage imageNamed:highStr];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0.0f, 0.0f, btnImage.size.width+10, btnImage.size.height);
    btn.backgroundColor = [UIColor clearColor];
    [btn setImage:btnImage forState:UIControlStateNormal];
    [btn setImage:btnImageH forState:UIControlStateHighlighted];
    if (!FBIsEmpty(target))
    {
        [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

- (void)rightNavigationBarItemClicked
{
    //子类重写
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
