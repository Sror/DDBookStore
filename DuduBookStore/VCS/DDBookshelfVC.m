//
//  DDBookshelfVC.m
//  DuduBookStore
//
//  Created by Bird on 14-8-11.
//  Copyright (c) 2014年 Iceland. All rights reserved.
//

#import "DDBookshelfVC.h"
#import "DDMyVC.h"

#import "DDBookStoreVC.h"
#import "DDClassifyVC.h"
#import "DDFindVC.h"
#import "DDSearchVC.h"
#import "DDBookBarVC.h"

@interface DDBookshelfVC ()<UITabBarControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *switchView;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;




@end

@implementation DDBookshelfVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarController = [[UITabBarController alloc] init];
        self.titleName = @"书架";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollview setContentSize:CGSizeMake(320, 568)];
    self.switchView.layer.cornerRadius = 3;
    self.switchView.layer.borderWidth = 1;
    self.switchView.clipsToBounds = YES;
    self.switchView.layer.borderColor = [UIColor redColor].CGColor;

    [self setPPSlide];
    [self loadTabBarVCS];
    
    

    self.imageView.image = [UIImage imageNamed:@"1.png"];
    
    NSArray *array = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"shujia_voice.png"],[UIImage imageNamed:@"shujia_voiceon.png"], nil];
    self.imageView.animationImages = array;
    self.imageView.animationDuration = 2;
    self.imageView.animationRepeatCount = 0;
    [self.imageView startAnimating];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(preloadLeft) object:nil];
    [self performSelector:@selector(preloadLeft) withObject:nil afterDelay:0.3];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(preloadRight) object:nil];
    [self performSelector:@selector(preloadRight) withObject:nil afterDelay:0.1];
}


- (void)preloadLeft
{
    DDMyVC *vc = [[DDMyVC alloc] initWithNibName:@"DDMyVC" bundle:Nil];
    FBNavigationController *nav = [[FBNavigationController alloc] initWithRootViewController:vc];
    [self.revealSideViewController preloadViewController:nav
                                                 forSide:PPRevealSideDirectionLeft
                                              withOffset:_offset];
    PP_RELEASE(nav);
}

- (void)preloadRight
{
    [self.revealSideViewController preloadViewController:_tabBarController
                                                 forSide:PPRevealSideDirectionRight
                                              withOffset:_offset];
}

- (void)setPPSlide
{
    UIImage *btnImage = [UIImage imageNamed:@"pub_list.png"];
    UIImage *btnImageH = [UIImage imageNamed:@"pub_list.png"];
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame = CGRectMake(0.0f, 0.0f, btnImage.size.width+10, btnImage.size.height);
    leftbtn.backgroundColor = [UIColor clearColor];
    [leftbtn setImage:btnImage forState:UIControlStateNormal];
    [leftbtn setImage:btnImageH forState:UIControlStateHighlighted];
    [leftbtn addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem = PP_AUTORELEASE(leftItem);
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0.0f, 0.0f,60, 30);
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn setTitle:@"书馆" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(showRight)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = PP_AUTORELEASE(rightItem);

    [self changeOffset];
    [self.revealSideViewController setDirectionsToShowBounce:PPRevealSideDirectionLeft | PPRevealSideDirectionRight];
    
    _animated = YES;
}

- (void)changeOffset
{
    _offset = 0;
    [self.revealSideViewController changeOffset:_offset
                                   forDirection:PPRevealSideDirectionLeft];
    [self.revealSideViewController changeOffset:_offset
                                   forDirection:PPRevealSideDirectionBottom];
}

- (void)loadTabBarVCS
{
    DDBookStoreVC *bookVC = [[DDBookStoreVC alloc] initWithNibName:@"DDBookStoreVC" bundle:nil];
    FBNavigationController *homeNav = [[FBNavigationController alloc] initWithRootViewController:bookVC];
    
    DDClassifyVC *VC2 = [[DDClassifyVC alloc] init];
    FBNavigationController *homeNav2 = [[FBNavigationController alloc] initWithRootViewController:VC2];
    
    DDSearchVC *VC3 = [[DDSearchVC alloc] init];
    FBNavigationController *homeNav3 = [[FBNavigationController alloc] initWithRootViewController:VC3];
    
    DDFindVC *VC4 = [[DDFindVC alloc] init];
    FBNavigationController *homeNav4 = [[FBNavigationController alloc] initWithRootViewController:VC4];
    
    DDBookBarVC *VC5 = [[DDBookBarVC alloc] init];
    FBNavigationController *homeNav5 = [[FBNavigationController alloc] initWithRootViewController:VC5];
    
    self.tabBarController.delegate = self;
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:homeNav, homeNav2, homeNav3,homeNav4,homeNav5, nil];
    
    UITabBar *tabBar = self.tabBarController.tabBar;
    UITabBarItem *aTabBarItem = [tabBar.items objectAtIndex:0];
    UITabBarItem *bTabBarItem = [tabBar.items objectAtIndex:1];
    UITabBarItem *cTabBarItem = [tabBar.items objectAtIndex:2];
    UITabBarItem *dTabBarItem = [tabBar.items objectAtIndex:3];
    UITabBarItem *eTabBarItem = [tabBar.items objectAtIndex:4];
    
    aTabBarItem.title = @"书馆";
    bTabBarItem.title = @"分类";
    cTabBarItem.title = @"搜索";
    dTabBarItem.title = @"发现";
    eTabBarItem.title = @"书吧";
    
    
    [aTabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab1h.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab1.png"]];
    [bTabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab2h.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab2.png"]];
    [cTabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab3h.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab3.png"]];
    [dTabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab4h.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab4.png"]];
    [eTabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab5h.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab5.png"]];
    
    
    UIColor *titleColor = [FBUtils colorWithHexString:@"666666"];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleColor, UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = [FBUtils colorWithHexString:@"d41e36"];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, UITextAttributeTextColor,
                                                       nil] forState:UIControlStateSelected];
    
    if (!IOS7_OR_LATER)
    {
        UIImage *tabBarBackground = [UIImage imageNamed:@"foot.png"];
        [[UITabBar appearance] setBackgroundImage:[tabBarBackground resizableImageWithCapInsets:UIEdgeInsetsZero]];
        [[UITabBar appearance] setSelectionIndicatorImage:nil];
    }
}

# pragma mark -
# pragma mark - Action
- (void)showLeft
{
    DDMyVC *vc = [[DDMyVC alloc] initWithNibName:@"DDMyVC" bundle:Nil];
    FBNavigationController *nav = [[FBNavigationController alloc] initWithRootViewController:vc];
    [self.revealSideViewController pushViewController:nav onDirection:PPRevealSideDirectionLeft withOffset:_offset animated:_animated];
    PP_RELEASE(nav);
}

- (void)showRight
{
    [self.revealSideViewController pushViewController:_tabBarController onDirection:PPRevealSideDirectionRight withOffset:_offset animated:_animated];
}

@end
