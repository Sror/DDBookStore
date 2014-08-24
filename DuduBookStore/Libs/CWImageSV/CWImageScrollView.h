//
//  CWImageScrollView.h
//  TestImageViewFS
//
//  Created by ouran on 13-7-8.
//  Copyright (c) 2013年 ouran. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CWImageScrollView : UIView <UIScrollViewDelegate>
{
    int currentPage;
    int totalPages;
    BOOL isAutoScroll;
    BOOL hasTransformed;
    id delegate;
    
    UIScrollView *scrollView;
    UIPageControl *pageCtrl;
    NSMutableArray *imageArray;
}
- (void)setIsAutoScroll:(BOOL)isAuto;
- (void)reloadData;
@property (nonatomic,assign)int currentPage;
@property (nonatomic,assign)int totalPages;
@property (nonatomic,assign)BOOL isAutoScroll;
@property (nonatomic,assign)BOOL hasTransformed;
@property (nonatomic,assign)id delegate;

@property (nonatomic,retain)UIScrollView *scrollView;
@property (nonatomic,retain)UIPageControl *pageCtrl;
@property (nonatomic,retain)NSMutableArray *imageArray;
@property (nonatomic,retain)NSTimer *timer;
@property (nonatomic,retain)UIImageView *preImageView;
@property (nonatomic,retain)UIImageView *curImageView;
@property (nonatomic,retain)UIImageView *nextImageView;

@property (nonatomic,retain)UITapGestureRecognizer *singleTap;
@end


@protocol CWImageScrollViewDelegate <NSObject>

@required
- (NSInteger)numberOfImageScrollView:(CWImageScrollView *)imaScro;
- (UIImageView *)imageScrollView:(CWImageScrollView *)imaScro imageViewForPageAtIndex:(int)index;

@optional
- (void) didTabScrollView:(CWImageScrollView *)scr AtIndex:(int) index;
@end