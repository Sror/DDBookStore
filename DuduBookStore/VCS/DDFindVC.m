//
//  DDFindVC.m
//  DuduBookStore
//
//  Created by Bird on 14-8-11.
//  Copyright (c) 2014年 Iceland. All rights reserved.
//

#import "DDFindVC.h"
#import "CWImageScrollView.h"

@interface DDFindVC ()<CWImageScrollViewDelegate>
@property (strong, nonatomic) CWImageScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@end

@implementation DDFindVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.titleName = @"发现";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollview setContentSize:CGSizeMake(320, 520)];
    self.imageScrollView = [[CWImageScrollView alloc] initWithFrame:CGRectMake(10, 110, 297, 95)];
    self.imageScrollView.delegate = self;
    self.imageScrollView.isAutoScroll = YES;
    [self.scrollview addSubview:_imageScrollView];
    [self.imageScrollView reloadData];
    [self addRightNavToShelter];
}


- (NSInteger)numberOfImageScrollView:(CWImageScrollView *)imaScro
{
    return 3;
}

- (UIImageView *)imageScrollView:(CWImageScrollView *)imaScro imageViewForPageAtIndex:(int)index
{
    UIImageView *ima = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"findtest%d.png",index+1]]];
    ima.frame = CGRectMake(0, 0, 297, 95);
    return ima;
}
@end
