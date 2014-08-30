//
//  DDBookBarVC.m
//  DuduBookStore
//
//  Created by Bird on 14-8-11.
//  Copyright (c) 2014年 Iceland. All rights reserved.
//

#import "DDBookBarVC.h"
#import "DDMyVC.h"
#import "CWImageScrollView.h"

@interface DDBookBarVC ()<CWImageScrollViewDelegate>
@property (strong, nonatomic) CWImageScrollView *imageScrollView;

@end

@implementation DDBookBarVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.titleName = @"嘟嘟书吧";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.title = @"书吧";

    self.imageScrollView = [[CWImageScrollView alloc] initWithFrame:CGRectMake(7, 7, 306, 152)];
    self.imageScrollView.delegate = self;
    self.imageScrollView.isAutoScroll = YES;
    [self.view addSubview:_imageScrollView];
    [self.imageScrollView reloadData];
    [self addRightNavToShelter];
    
    
    UIImage *btnImage = [UIImage imageNamed:@"bar_navLeft.png"];
    UIImage *btnImageH = [UIImage imageNamed:@"bar_navLeft.png"];
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame = CGRectMake(0.0f, 0.0f, btnImage.size.width+10, btnImage.size.height);
    leftbtn.backgroundColor = [UIColor clearColor];
    [leftbtn setImage:btnImage forState:UIControlStateNormal];
    [leftbtn setImage:btnImageH forState:UIControlStateHighlighted];
    [leftbtn addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem = PP_AUTORELEASE(leftItem);
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(preloadLeft) object:nil];
    [self performSelector:@selector(preloadLeft) withObject:nil afterDelay:0.3];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfImageScrollView:(CWImageScrollView *)imaScro
{
    return 3;
}

- (UIImageView *)imageScrollView:(CWImageScrollView *)imaScro imageViewForPageAtIndex:(int)index
{
    UIImageView *ima = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"bar_ima%d.png",index+1]]];
    ima.frame = CGRectMake(0, 0, 297, 95);
    return ima;
}

- (void)preloadLeft
{
    DDMyVC *vc = [[DDMyVC alloc] initWithNibName:@"DDMyVC" bundle:Nil];
    FBNavigationController *nav = [[FBNavigationController alloc] initWithRootViewController:vc];
    [self.revealSideViewController preloadViewController:nav
                                                 forSide:PPRevealSideDirectionLeft
                                              withOffset:0];
    PP_RELEASE(nav);
}

# pragma mark -
# pragma mark - Action
- (void)showLeft
{
    DDMyVC *vc = [[DDMyVC alloc] initWithNibName:@"DDMyVC" bundle:Nil];
    FBNavigationController *nav = [[FBNavigationController alloc] initWithRootViewController:vc];
    [self.revealSideViewController pushViewController:nav onDirection:PPRevealSideDirectionLeft withOffset:0 animated:NO];
    PP_RELEASE(nav);
}
@end
