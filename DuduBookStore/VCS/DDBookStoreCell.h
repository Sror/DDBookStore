//
//  DDBookStoreCell.h
//  DuduBookStore
//
//  Created by Iceland on 14-8-5.
//  Copyright (c) 2014年 Iceland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDBook.h"

@interface DDBookStoreCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UIButton *flagBtn;

@property (assign, nonatomic) BOOL isShort;

@end
