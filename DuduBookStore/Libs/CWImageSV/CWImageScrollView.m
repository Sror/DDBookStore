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
        
        _pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(frame.size.width - 150, frame.size.height - 30, 30, 30)];
        self.pageCtrl.userInteractionEnabled = NO;
        [self addSubview:_pageCtrl];
        
        self.currentPage = 0;
    }
    return self;
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

- (void)reloadData
{
    if ([_delegate respondsToSelector:@selector(numberOfImageScrollView:)])
    {
        self.totalPages = [_delegate numberOfImageScrollView: self];
    }
    if ([_delegate respondsToSelector:@selector(imageScrollView:imageViewForPageAtIndex:)])
    {
        for (int i=0; i<self.totalPages; i++)
        {
            UIImageView *imageView = [_delegate imageScrollView:self imageViewForPageAtIndex:i];
            imageView.autoresizesSubviews = YES;
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
    self.curImageView.frame = CGRectMake(320, 0, self.frame.size.width,self.frame.size.height);

    self.nextImageView = [self.imageArray objectAtIndex:last];
    self.nextImageView.tag = 3;
    self.nextImageView.frame = CGRectMake(640, 0, self.frame.size.width,self.frame.size.height);
    
    [self.scrollView addSubview:_preImageView];
    [self.scrollView addSubview:_curImageView];
    [self.scrollView addSubview:_nextImageView];
}

- (void)toPreView
{
    float temp = ([UIScreen mainScreen].applicationFrame.size.width - self.curImageView.frame.size.width)/2;
    self.preImageView = (UIImageView *)[self.scrollView viewWithTag:1];
    self.curImageView = (UIImageView *)[self.scrollView viewWithTag:2];
    self.nextImageView = (UIImageView *)[self.scrollView viewWithTag:3];
    
    self.preImageView.frame = CGRectMake(self.frame.size.width+temp, 0, self.curImageView.frame.size.width, self.frame.size.height);
    self.curImageView.frame = CGRectMake(2 * self.frame.size.width+temp,0,self.curImageView.frame.size.width, self.frame.size.height);
    [self.nextImageView removeFromSuperview];
    self.nextImageView = [self.imageArray objectAtIndex:(self.currentPage + self.totalPages-2)%self.totalPages];
    self.nextImageView.frame = CGRectMake(temp, 0, self.curImageView.frame.size.width, self.frame.size.height);
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
    float temp = ([UIScreen mainScreen].applicationFrame.size.width - self.curImageView.frame.size.width)/2;
    
    self.preImageView = (UIImageView *)[self.scrollView viewWithTag:1];
    self.curImageView = (UIImageView *)[self.scrollView viewWithTag:2];
    self.nextImageView = (UIImageView *)[self.scrollView viewWithTag:3];
    
    [self.preImageView removeFromSuperview];
    self.curImageView.frame=CGRectMake(0+temp,0,self.curImageView.frame.size.width, self.frame.size.height);
    self.nextImageView.frame = CGRectMake(self.frame.size.width+temp, 0, self.curImageView.frame.size.width, self.frame.size.height);
    
    self.preImageView = [self.imageArray objectAtIndex:(self.currentPage + 2)%self.totalPages];
    self.preImageView.frame = CGRectMake(2*self.frame.size.width+temp, 0, self.curImageView.frame.size.width, self.frame.size.height);
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

//旋转+放大/缩小的动画。
- (void)transformImageView:(UIImageView *)ima  animation:(BOOL)anima
{    
    float scale = [self getScale:ima];
    int angle = -90;
    float position = [UIScreen mainScreen].applicationFrame.size.height/2;
    NSLog(@"scale == %f",scale);

    //如果当前状态为已经变形过，则调整两个参数实现恢复原状态的动画
    if (self.hasTransformed)
    {
        scale = 1;
        angle = 0;
        position = 90;
    }
    if (anima)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationWillStartSelector:@selector(begin)];
        [UIView setAnimationDidStopSelector:@selector(stop)];
        [UIView setAnimationDuration:0.3];
        [self transfomImageView:ima ToScale:scale ToAngle:angle ToYPosition:position];
        [UIView commitAnimations];
    }
    else
    {
        [self transfomImageView:ima ToScale:scale ToAngle:angle ToYPosition:position];
    }
}

//旋转的算法
- (void)transfomImageView:(UIImageView *)ima ToScale:(float)scale ToAngle:(int)angle ToYPosition:(float)yPosition
{
    //ima.frame = CGRectMake(0, 0, 320, 480);
    int theTheta=angle;//正数为顺时针旋转 负数为逆时针
    CGFloat radian=theTheta *(M_PI/180.0f);
    CGAffineTransform transform = CGAffineTransformMakeRotation(radian);
    CGAffineTransform scaled = CGAffineTransformScale(transform, scale, scale);
    [ima setTransform:scaled];
    ima.center=CGPointMake(ima.center.x, yPosition);
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
    for (int i=0; i<self.totalPages; i++)
    {
        if (i == self.currentPage)
        {
            [self transformImageView:[self.imageArray objectAtIndex:i] animation:YES];
        }
        else
        {
            [self transformImageView:[self.imageArray objectAtIndex:i] animation:NO];
        }
    }
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
