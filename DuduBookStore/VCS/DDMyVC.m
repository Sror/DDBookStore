//
//  DDMyVC.m
//  DuduBookStore
//
//  Created by Bird on 14-8-11.
//  Copyright (c) 2014年 Iceland. All rights reserved.
//

#import "DDMyVC.h"
#import "DDBookshelfVC.h"
@interface DDMyVC ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;



@end

@implementation DDMyVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.titleName = @"我";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0.0f, 0.0f,60, 30);
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:@"书架" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(leftNavAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = PP_AUTORELEASE(item);

    
    UIImage *btnImage = [UIImage imageNamed:@"settNav.png"];
    UIImage *btnImageH = [UIImage imageNamed:@"settNav.png"];
    UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame = CGRectMake(0.0f, 0.0f, btnImage.size.width+10, btnImage.size.height);
    rightbtn.backgroundColor = [UIColor clearColor];
    [rightbtn setImage:btnImage forState:UIControlStateNormal];
    [rightbtn setImage:btnImageH forState:UIControlStateHighlighted];
    [rightbtn addTarget:self action:@selector(rightNavAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    
    
    [self.scrollview setContentSize:CGSizeMake(320, 434)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark -
# pragma mark - Action
- (IBAction)leftNavAction:(UIButton *)btn
{
    [self.revealSideViewController popViewControllerAnimated:YES];
}

- (IBAction)rightNavAction:(UIButton *)btn
{
    //设置

    
}


@end
