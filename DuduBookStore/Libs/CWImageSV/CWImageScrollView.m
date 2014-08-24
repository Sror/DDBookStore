//
//  CWImageScrollView.m
//  TestImageViewFS
//
//  Created by ouran on 13-7-8.
//  Copyright (c) 2013年 ouran. All rights reserved.
//

#import "CWImageScrollView.h"

@implementation CWImageScrollView
@synthesize imageArray = _imageArray;
@synthesize scrollView = _scrollView;
@synthesize pageCtrl = _pageCtrl;
@synthesize currentPage = _currentPage;
@synthesize totalPages = _totalPages;
@synthesize hasTransformed = _hasTransformed;
@synthesize isAutoScroll = _isAutoScroll;
@synthesize timer = _timer;
@synthesize delegate = _delegate;;

@synthesize preImageView = _preImageView;
@synthesize curImageView = _curImageView;
@synthesize nextImageView = _nextImageView;
@synthesize singleTap = _singleTap;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _imageArray = [[NSMutableArray alloc] initWithObjects:nil];
        _delegate = nil;
        self.autoresizesSubviews = YES;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        //不显示滚动条
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(frame.size.width*3, frame.size.height);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        [self addSubview:_scrollView];
        [self.scrollView setContentOffset:CGPointMake(frame.size.width, 0)];
        
        
        _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self.scrollView addGestureRecognizer:_singleTap];
        
        _pageCtrl = [[UIPageControl alloc] init];
        self.pageCtrl.userInteractionEnabled = NO;
        self.pageCtrl.currentPage = 0;
        [self addSubview:_pageCtrl];
        
        self.currentPage = 0;
        [self updateDots];
    }
    return self;
}

-(void)updateDots
{
    for (int i = 0; i < [self.pageCtrl.subviews count]; i++)
    {
        NSLog(@"%D%@",i,[[self.pageCtrl.subviews objectAtIndex:i] class]);

        if (IOS7_OR_LATER)
        {
            UIView *dot = [self.pageCtrl.subviews objectAtIndex:i];
            if (i == self.currentPage)
                dot.backgroundColor = [UIColor whiteColor];
            else
                dot.backgroundColor = [UIColor lightGrayColor];
        }
        else
        {
            if ([[self.pageCtrl.subviews objectAtIndex:i] isKindOfClass:[UIImageView class]])
            {
                UIImageView *dot = (UIImageView *)[self.pageCtrl.subviews objectAtIndex:i];
                if (i == self.currentPage)
                    dot.image = [UIImage imageNamed:@"findDotSel.png"];
                else
                    dot.image = [UIImage imageNamed:@"findDotNull.png"];
            }
        }
    }
}

- (void)dealloc
{
    if (self.isAutoScroll)
    {
        [self stopAutoScrollTimer];
    }
    [_timer release];
    [_imageArray release];
    [_scrollView release];
    [_pageCtrl release];
    
    [_preImageView release];
    [_curImageView release];
    [_nextImageView release];
    [_singleTap release];
    [super dealloc];
}

- (void)setCurrentPage:(int)page
{
    _currentPage = page;
    self.pageCtrl.currentPage = page;
    [self updateDots];
}

- (void)reloadData
{
    if ([_delegate respondsToSelector:@selector(numberOfImageScrollView:)])
    {
        self.totalPages = [_delegate numberOfImageScrollView: self];
        self.pageCtrl.numberOfPages = self.totalPages;
        self.pageCtrl.frame = CGRectMake(self.frame.size.width-15*self.totalPages, self.frame.size.height-20, 20, 20);
    }
    if ([_delegate respondsToSelector:@selector(imageScrollView:imageViewForPageAtIndex:)])
    {
        for (int i=0; i<self.totalPages; i++)
        {
            UIImageView *imageView = [_delegate imageScrollView:self imageViewForPageAtIndex:i];
            imageView.autoresizesSubviews = NO;
            [self.imageArray addObject:imageView];
        }
        [self loadData];
    }
}

- (void)setDelegate:(id)dele
{
    _delegate = dele;
    [self reloadData];
}
#pragma mark -
#pragma mark - cycLogic
- (void)loadData
{
    int pre = self.totalPages-1;
    int last = 1;
    self.preImageView = [self.imageArray objectAtIndex:pre];
    self.preImageView.tag = 1;
    self.preImageView.frame = CGRectMake(0, 0, self.frame.size.width,self.frame.size.height);
   
    self.curImageView = [self.imageArray objectAtIndex:self.currentPage];
    self.curImageView.tag = 2;
    self.curImageView.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width,self.frame.size.height);

    self.nextImageView = [self.imageArray objectAtIndex:last];
    self.nextImageView.tag = 3;
    self.nextImageView.frame = CGRectMake(self.frame.size.width*2, 0, self.frame.size.width,self.frame.size.height);
    
    [self.scrollView addSubview:_preImageView];
    [self.scrollView addSubview:_curImageView];
    [self.scrollView addSubview:_nextImageView];
}

- (void)toPreView
{
    self.preImageView = (UIImageView *)[self.scrollView viewWithTag:1];
    self.curImageView = (UIImageView *)[self.scrollView viewWithTag:2];
    self.nextImageView = (UIImageView *)[self.scrollView viewWithTag:3];
    
    self.preImageView.frame = CGRectMake(self.frame.size.width, 0, self.curImageView.frame.size.width, self.frame.size.height);
    self.curImageView.frame = CGRectMake(2 * self.frame.size.width,0,self.curImageView.frame.size.width, self.frame.size.height);
    [self.nextImageView removeFromSuperview];
    self.nextImageView = [self.imageArray objectAtIndex:(self.currentPage + self.totalPages-2)%self.totalPages];
    self.nextImageView.frame = CGRectMake(0, 0, self.curImageView.frame.size.width, self.frame.size.height);
    [self.scrollView addSubview:_nextImageView];
       
    UIImageView *tempIV = [self.imageArray objectAtIndex:self.currentPage];
    self.preImageView.tag = 2;
    self.nextImageView.tag = 1;
    tempIV.tag = 3;
    
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)animated:NO];
    self.currentPage = (self.currentPage + self.totalPages-1)%self.totalPages;
}

- (void)toNextView
{
    self.preImageView = (UIImageView *)[self.scrollView viewWithTag:1];
    self.curImageView = (UIImageView *)[self.scrollView viewWithTag:2];
    self.nextImageView = (UIImageView *)[self.scrollView viewWithTag:3];
    
    [self.preImageView removeFromSuperview];
    self.curImageView.frame=CGRectMake(0,0,self.curImageView.frame.size.width, self.frame.size.height);
    self.nextImageView.frame = CGRectMake(self.frame.size.width, 0, self.curImageView.frame.size.width, self.frame.size.height);
    
    self.preImageView = [self.imageArray objectAtIndex:(self.currentPage + 2)%self.totalPages];
    self.preImageView.frame = CGRectMake(2*self.frame.size.width, 0, self.curImageView.frame.size.width, self.frame.size.height);
    [self.scrollView addSubview:_preImageView];
    
    UIImageView *tempIV = [self.imageArray objectAtIndex:(self.currentPage+1)%self.totalPages];
    self.preImageView.tag = 3;
    self.curImageView.tag= 1;
    tempIV.tag = 2;
    
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)animated:NO];
    self.currentPage = (self.currentPage+1)%self.totalPages;
}
#pragma mark -
#pragma mark - Function
- (void)setIsAutoScroll:(BOOL)isAuto
{
    _isAutoScroll = isAuto;
    if (_isAutoScroll) {
        //开启定时器
        [self startAutoScrollTimer];
    } else {
        [self stopAutoScrollTimer];
    }
}

//计算图片需要放大/缩小的倍数。
- (float)getScale:(UIImageView *)imageView
{
    int screenW = [UIScreen mainScreen].applicationFrame.size.width;
    int screenH = [UIScreen mainScreen].applicationFrame.size.height;
    
    float a = screenH/imageView.frame.size.width;
    float b = screenW/imageView.frame.size.height;
    
    NSLog(@"a==%f,b==%f",a,b);
    
    float c = imageView.frame.size.height/imageView.frame.size.width;
    float d = screenH/screenW;
    if (c>= d)
    {
        return b;
    }
    else
    {
        return a;
    }
}

#pragma mark -
#pragma mark - UIViewAnimationDelegate
- (void)begin
{
    [self.scrollView removeGestureRecognizer:self.singleTap];
    if (!self.hasTransformed)
    {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height);
        self.scrollView.frame = self.bounds;
    }
}

-(void)stop
{
    [self.scrollView addGestureRecognizer:self.singleTap];
    if (self.hasTransformed)
    {
        self.frame = CGRectMake(0, 0, 320, 180);
        self.scrollView.frame = self.bounds;
    }
    // 设置状态
    self.hasTransformed = !self.hasTransformed;
}

#pragma mark -
#pragma mark - handleTap
-(void)handleTap:(UITapGestureRecognizer *)tap
{
    if ([_delegate respondsToSelector:@selector(didTabScrollView: AtIndex:)])
    {
        [_delegate didTabScrollView:self AtIndex:self.currentPage];
    }
}

#pragma mark -
#pragma mark - NSTimer
- (void)stopAutoScrollTimer
{
    if (nil != self.timer && [self.timer isValid])
    {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)startAutoScrollTimer
{
    [self stopAutoScrollTimer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.f
                                                      target:self
                                                    selector:@selector(autoToNextPage)
                                                    userInfo:nil
                                                     repeats:YES];
    
}

- (void)autoToNextPage
{
    [self.scrollView setContentOffset:CGPointMake(640, 0) animated:YES];
}

#pragma mark -
#pragma mark - scrollView Delegate && page
//计算当前是第几页
- (void)scrollViewDidScroll:(UIScrollView *)ascrollView
{
    //self.currentPage = (ascrollView.contentOffset.x+self.frame.size.width/2)/self.frame.size.width;
    
    int x = ascrollView.contentOffset.x;
    //往下翻一张
    if(x >= (2*self.frame.size.width)) {
//        _curPage = [self validPageValue:_curPage+1];
        [self toNextView];
    }
    
    //往上翻
    if(x <= 0) {
//        _curPage = [self validPageValue:_curPage-1];
        [self toPreView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.isAutoScroll)
    {
        [self stopAutoScrollTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.isAutoScroll)
    {
        [self startAutoScrollTimer];
    }
    NSLog(@"currentPage==%d 1x == %f;2x == %f;3x == %f",self.currentPage,self.preImageView.frame.origin.x,self.curImageView.frame.origin.x,self.nextImageView.frame.origin.x);
}
@end
