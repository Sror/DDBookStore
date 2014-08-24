//
//  DDClassifyCell.h
//  DuduBookStore
//
//  Created by Iceland on 14-8-20.
//  Copyright (c) 2014年 Iceland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDClassifyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *classView;
@property (weak, nonatomic) IBOutlet UIButton *tagBtn;

@property (strong, nonatomic) NSMutableArray *array;


@property (weak, nonatomic) IBOutlet UIImageView *iv;

@end
